---
title: Data Product Interaction
description: Interact with Data Product services. Learn how to perform Data orchestration and use Microsoft Purview for Data Governance. 
author: andrehass
ms.author: anhass
ms.date: 02/08/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---



# Interact with a Data Product

In this tutorial, you will interact with the Data Product services that have been deployed in the previous steps. Data Factory for data integration and orchestration and Purview to discover, manage and govern data assets.

The objective of completing this hands-on experience is for you to become familiar with the services deployed in the sample data product resource group `[DMLZprefix]-dev-dp001`. You will experience how these products interface with each other and the security measures in place.

As you deploy the new components, you will have a chance to investigate how Purview glues together service governance to create a holistic, up-to-date map of your data landscape with automated data discovery, sensitive data classification, and end-to-end data lineage.

## Pre-requisites

- **Permissions to the Azure subscription**: User Access Administrator or Owner access to the subscription for Purview and Synapse configuration, role assignments for services and Service Principals.

- **A successfully deployed Data Management Landing Zone**: For more information, check the [Data Management Landing Zone](https://github.com/Azure/data-management-zone) repo.

- **A successfully deployed Data Landing Zone**: For more information, check the [Data Landing Zone](https://github.com/Azure/data-landing-zone) repo.

- **A successfully deployed Data Product**: For more information, check the [Data Product](https://github.com/Azure/data-product-batch) repo.

- **A Purview Account**: This has been already deployed in the Data Management Landing Zone deployment steps.

- **Self Hosted Integration Runtime**: This has been already deployed in the Data Landing Zone deployment steps.

### Create Azure SQL Databases

The first step to start this hands-on experience is to create two sample Azure SQL Databases. You will use them to simulate the CRM and ERP data sources for the upcoming steps.

1. Open the Azure Portal. On the top right, click on the highlighted icon below to open the cloud shell.

    :::image type="content" source="../images/CloudShell.png" alt-text="Azure CLoud Shell":::

1. Select **bash** in the Cloud Shell environment and run the script below. 

    - The script will find the _`[DLZprefix]`_`-dev-dp001` resource group and the Azure SQL Server _`[DPprefix]`_`-dev-sqlserver001` in it, then it will create the two Azure SQL Databases on this server.

    - Make sure to replace the \<subscription ID\> parameters with your own subscription ID. 

>[!NOTE]
The databases will be pre-populated with AdventureWorks sample data, containing the required tables you will use on this lab.

```Bash
# Azure SQL Database Setup
# Create databases AdatumCRM and AdatumERP to simulate Customer's and Sale's data. 

# Use the subscription id where you deployed the data product.
az account set --subscription "<subscription ID>"

# Get the resource group for the data product.
resourceGroupName=$(az group list -o tsv  --query "[?contains(@.name, 'dp001')==\`true\`].name")

# Get the existing Azure SQL DB Server name.
sqlServerName=$(az sql server list -g $resourceGroupName -o tsv  --query "[?contains(@.name, 'sqlserver001')==\`true\`].name")

# Create the first Azure SQL Database, AdatumCRM to create the Customer's data source.
az sql db create --resource-group $resourceGroupName --server $sqlServerName --name AdatumCRM --service-objective Basic --sample-name AdventureWorksLT

# Create the second Azure SQL Database, AdatumERP to create the Sales data source.
az sql db create --resource-group $resourceGroupName --server $sqlServerName --name AdatumERP --service-objective Basic --sample-name AdventureWorksLT
```

### Conclusion

When the scripts finish running, you will have on the Azure SQL Server _`[DPprefix]`_`-dev-sqlserver001` two new Azure SQL Databases: **AdatumCRM** and **AdatumERP**, both on the Basic compute tier. They are located in the same resource group _`[DLZprefix]`_`-dev-dp001` where you deployed the data product.


## Set up Purview to catalog the Data Product Batch

>[!NOTE]
>Through the rest of the document, _`DLZprefix`_ refers to the prefix provided for the Data Landing Zone deployment. _`DMLZprefix`_ refers to the prefix used for the Data Management Landing Zone deployment. _`DPprefix`_ refers to the prefix used for the Data Product deployment.


### Create Service Principal

1. Open the Azure Portal. On the top right, click on the highlighted icon below to open the cloud shell.
  :::image type="content" source="../images/CloudShell.png" alt-text="Azure CLoud Shell":::
  
1. Update the command below to replace the **subscription ID** with our own subscriptionID and the **service principal name** created in the step earlier. After updating the values run in the cloud shell **bash**. The service principal name should be unique within the subscription.

>[!IMPORTANT]
>Replace the parameters with a service principal name of your choice and your subscription ID.

```bash
# Replace the parameters with a service principal name of your choice and your subscription ID. 
spname="<service_principal_name>" 
subscriptionId="<subscription_id>"

# Set the Scope to Subscription
scope="/subscriptions/$subscriptionId"

# Create the Service Principal 
az ad sp create-for-rbac \
  --name $spname \
  --role "Contributor" \
  --scope $scope

```

1. This will generate the following JSON output.

>[!NOTE]
>Make a note of this as this will be needed for the subsequent steps.


```JSON
{
  "appId": "999xxx1x-9x99-9999-0000-61xxx9x99xx9",
  "displayName": "purview-serviceprincipal",
  "name": "999xxx1x-9x99-9999-0000-61xxx9x99xx9",
  "password": "CJsPsAz8-~sf6_Qj_ecXXxxxXxxXXxxXXXxXX",
  "tenant": "999xxx1x-9x99-9999-0000-61xxx9x99xx9"
}
```

### Setting up Service Principal Access and Permissions

 From the JSON output generated in the previous step, grab the following

- Service Principal ID (appId)
- Service Principal Key (password)

The Service Principal needs the following permissions

- **Blob data reader** role on the Azure Storage Accounts
- **Data Reader** permissions on the Azure SQL DB instance

To set this up, please follow the steps below.

#### Azure Storage Account Permissions

1. In the Azure portal, navigate to the Azure Storage Account instance _`[DLZprefix]`_`devraw`. Click on **Access Control (IAM)** on the left.

    :::image type="content" source="../images/storage-account-sp-permissions.png" alt-text="Storage Account SP Permissions":::

1. Click on **Add+** and than **Add Role Assignment**

    :::image type="content" source="../images/storage-account-sp-access-control.png" alt-text="Storage Account SP Access Control":::

1. In Add Role Assignment , search for Storage Blob Data Reader, select the `Storage Blob Data Reader` role and click on **Next**.

    :::image type="content" source="../images/storage-account-sp-role-assignment.png" alt-text="Storage Account SP Role Assignment":::

1. In the next screen click on **+ Select Members** and search for the Service Principal account you just created.

    :::image type="content" source="../images/storage-account-sp-members1.png" alt-text="Storage Account SP Members":::

1. Search for the service principal name created in previous step, select the service principal.

    :::image type="content" source="../images/add-service-principal.png" alt-text="Search Service Principal Name":::

1. Pick the relevant result and click on **Select**.

    :::image type="content" source="../images/select-service-principal.png" alt-text="Select Service Principal Name":::

1. To complete the role assignment process click **Review + assign** twice.

1. Repeat steps 1 through 7 for the remaining storage accounts

- _`[DLZprefix]`_`devencur`
- _`[DLZprefix]`_`devwork`


### Azure SQL Database Permissions

For this step you will need to connect to SQL Server using the Query Editor. Since all the resources are behind a private endpoint, you will need to log into the Azure Portal using a bastion host Virtual Machine. 

Using the Azure Portal, connect to the virtual machine deployed in the _`[DMLZPrefix]`_`-dev-bastion` resource group. 
If you are unsure on how to connect to the virtual machine using bastion host service, please refer to **Connecting to the VM** in [Deploy Bastion Host and Jumpbox](/lab1/6_deploy_bastion_host/).

To add the service principal as a user within the database, you might need to add yourself as the active directory admin first. Steps 1 to 3 below explain how to do this. The remainder of the steps explain how to give the service principal permissions to the database. Once logged into Portal from the bastion Host Virtual Machine, search for SQL Servers in the Azure Portal.

1. Navigate to the SQL Server _`[DPprefix]`_`-dev-sqlserver001` and click on **Active Directory**.

    :::image type="content" source="../images/azure-sql-db-ad-admin1.png" alt-text="SQL Server Admin":::

1. Click on **Set Admin** and search for your own account. Click on **Select** to select the account.

    :::image type="content" source="../images/set-sqlserver-admin.png" alt-text="Search for Account":::

1. Click on **Save** to persist the setting.

1. Now click on **SQL Databases**, choose the database `AdatumCRM`.

     :::image type="content" source="../images/database-query-editor.png" alt-text="Choose Database":::

1. In `AdatumCRM` and click on **Query editor** and than Log with Active Directory Authentication using the button Log in as your user.

     :::image type="content" source="../images/query-editor.png" alt-text="Log with Active Directory":::

1. Once in the query editor, execute the following statements but replacing `<Service Principal>` with the name of the service principal you just created (e.g. purview-sp).

```sql

CREATE USER [<Service Principal Name>] FROM EXTERNAL PROVIDER
GO

EXEC sp_addrolemember 'db_datareader', [<Service Principal Name>]
GO

```

:::image type="content" source="../images/azure-sql-db-add-sp.png" alt-text="Add SQL Database Service Principal":::

Repeat steps 4 through 6 for the `AdatumERP` database.

### Setting up the Key Vault

Purview will read the service principal key from a Key Vault. We will use the Key Vault instance deployed along with the **Data Management Landing Zone**. The following steps are required to set up the Key Vault. 

- Add the Service Principal key to the Key Vault as a secret.
- Give the Purview MSI Secrets Reader permissions on the Key Vault
- Add the Key Vault within Purview as a Key Vault Connection
- Create a Credential within Purview pointing to the Key Vault secret

### Adding Permissions to Add Secret into the Key Vault

1. In the Azure Portal, navigate to the key vault service and search for Key Vault named _`[DMLZprefix]`_`-dev-vault001`.

 :::image type="content" source="../images/key-vault-1.png" alt-text="Access Control Key Vault":::

1. Click on **Access Control (IAM)**, **Add** and than **Add Role Assignment**.

    :::image type="content" source="../images/purview-keyvault-perm.png" alt-text="Purview Add Role Assignment":::

1. On the next screen, search for `Key Vault Administrator`, select the role `Key Vault Administrator` and click on **Next**.
  
    :::image type="content" source="../images/purview-keyvault-administrator.png" alt-text="Purview Add Role Assignment":::

1. Click on **+ Select Members** and add the account currently logged.

    :::image type="content" source="../images/keyvault-administrator-select-member.png" alt-text="Purview Select Member":::
    :::image type="content" source="../images/keyvault-administrator-your-account.png" alt-text="Purview Select Member":::

1. In Select Members, search for the account currently logged, click to add the relevant account, and click on **select**

    :::image type="content" source="../images/key-vault-select-user.png" alt-text="Select Key Vault User":::

1. To complete the role assignment process click **Review + assign** twice.

### Add Secret to the Key Vault

Complete the following steps logging into Azure Portal from the Bastion Host virtual machine.

1. On the he same key vault with the name _`[DMLZprefix]`_`-dev-vault001`. Click on **Secrets** and than **Generate/Import** to create a new secret.
  
    :::image type="content" source="../images/key-vault-add-secret.png" alt-text="Key Vault Generate Secret":::

1. Provide the following values and click on **Create**.

| Field| Suggested Value(s)  |
|:-------|:--------------------|
| Upload options | Manual |
| Name | service-principal-secret |
| Value | Service Principal password you created in the previous steps `CJsPsAz8-~sf6_Qj_ecXXxxxXxxXXxxXXXxXX`|

   :::image type="content" source="../images/key-vault-create-secret.png" alt-text="Key Vault Create Secret":::

>[!NOTE]
>This step creates a secret named `service-principal-secret` within the Key Vault with the Service Principal password key. This will be used by Purview to connect to and scan the data sources. If the incorrect password provided, subsequent steps will not work.

### Set up Purview permissions on the Key Vault

For the Purview instance to read the secrets stored within the Key Vault, it has to be given relevant permissions on the Key Vault. We do this by adding the **Purview Managed Identity** to the `Key Vault Secrets Reader` role.

1. On the he same key vault with the name _`[DMLZprefix]`_`-dev-vault001` Click on **Access Control (IAM)**, **Add** and than **Add Role Assignment**.
  
    :::image type="content" source="../images/keyvault-add-role-assigment.png" alt-text="Key Vault Permissions":::

1. In Role, search for `Key Vault Secret User`,  Select **Key Vault Secrets User** and click **Next**.

    :::image type="content" source="../images/key-vault-secretUser-role.png" alt-text="Search Key Vault Secret User":::

1. Click on **+ Select Members**.
  
    :::image type="content" source="../images/keyvault-user-select-member.png" alt-text="Select Member":::

1. Search for the Purview instance name _`[DMLZprefix]`_`-dev-purview001`, click to add the relevant account and then click on **Select**.
  
    :::image type="content" source="../images/keyvault-user-purview-managed.png" alt-text="Server Purview Name":::

1. To complete the role assignment process click **Review + assign** twice.
  
    :::image type="content" source="../images/keyvault-user-purview-managed-review-assign.png" alt-text="Review and Assign":::

### Set up Key Vault Connection in Purview

>[!NOTE]
For this step, you will need to log into the Azure Portal using a bastion host Virtual Machine.

The next step is for us to link Purview with the Key Vault. To do this, follow the steps below

1. Navigate to the Purview Account in the Azure portal. Access your Purview Account _`[DMLZprefix]`_`-dev-purview001`. Click on the **Open** link within the Open Microsoft Purview Governance Portal.

    :::image type="content" source="../images/microsoft-purview-studio.png" alt-text="Purview Studio":::
  
1. Within the Purview Studio, click on the **Management** hub > **Credentials** > **Manage Key Vault Connections** > **New** in the dialog
  
    :::image type="content" source="../images/purview-key-vault-connections.png" alt-text="Manage Key Vault Connections":::

1. Click on **Manage Key Vault Connections** and then **New** in the dialog

    :::image type="content" source="../images/key-vault-purview-connection3a.png" alt-text="New Manage Key Vault Connections":::

1. Create the new connection with the following values and then click on **Create**.

    | Field| Suggested Value(s)  |
    |:-------|:--------------------|
    | Name| _`[DMLZprefix]`_`-dev-vault001` | 
    | Azure Subscription | Select the subscription hosting the key vault|
    | Key Vault Name | Select the key vault _`[DMLZprefix]`_`-dev-vault001`|

    :::image type="content" source="../images/purview-key-vault-connection.png" alt-text="Purview Connection":::

1. On Confirming granting access, click **Confirm**.

### Create a Credential in Purview

The final step is to create a credential within Purview pointing to the secret we created earlier in the Key Vault for the service principal. To do this, follow the steps below.

1. Click on **Management** > **Credentials** > **New**

    :::image type="content" source="../images/purview-add-credentials.png" alt-text="New Purview Credentials":::

1. In the dialog, provide the following values and click on **Create**

    | Field| Suggested Value(s)  |
    |:-------|:--------------------|
    | Name| `purviewServicePrincipal` | 
    | Authentication Method | Service Principal|
    | Tenant ID | This is automatically populated|
    | Service Principal ID | This is the Application (Client ID/App ID) of the Service principal|
    | Key Vault Connection| Select the Key Vault Connection created in the previous step|
    | Secret Name | Type in the name of the secret in the Key Vault (`service-principal-secret`)|  

    :::image type="content" source="../images/purview-credential-values.png" alt-text="New Purview Credentials":::

## Registering Data Sources

At this point, Purview has visibility of the service principal. We can now proceed with registering and setting up the data sources.

### Register ADLS Gen 2 Storage Accounts

The following steps outline the process to register an ADLS Gen 2 Storage account.

1. In the Purview interface, click on the **Data Map** option and then **Register**
  
    :::image type="content" source="../images/data-map-register.png" alt-text="Register Data":::

1. Select **ADLS Gen 2** and click on **Continue**

    :::image type="content" source="../images/register-adls.png" alt-text="Register Data":::

1. Fill in the values for all the fields

    | Field| Suggested Value(s)  |
    |:-------|:--------------------|
    | Name| _`[DLZprefix]`_`dldevraw` (or another suitable name)| 
    | Azure Subscription | Select the subscription hosting the storage account|
    | Storage account Name| Select the relevant storage account|
    | Endpoint|  This should be automatically populated based on the selected storage account|
    | Select a collection | Select the root collection.|  

  
    :::image type="content" source="../images/purview-register-add-dl-raw.png" alt-text="Register ADLS raw":::

Click **Register** to create the data source.

Repeat steps 1 through 3 for the remaining storage accounts

- _`[DMLZprefix]`_`devencur`
- _`[DMLZprefix]`_`devwork`

### Register Azure SQL DB as a Data Source

1. In the Purview interface, click on the **Data Map** option and then **Register**

    :::image type="content" source="../images/data-map-register.png" alt-text="Register SQL DB":::

1. Select **SQL Database** and click on **Continue**
  
    :::image type="content" source="../images/register-sql-db.png" alt-text="Select SQLDB to Register":::

1. On the next screen, provide the following values and click on **Register**

    | Field| Suggested Value(s)  |
    |:-------|:--------------------|
    | Name|`SQLDatabase` (the name of the database created in "Create Azure SQL Dbs" step)|
    | Subscription| the subscription hosting the database|
    | Server name|the SQL Server name to register -- _`DPprefix`_-dev-sqlserver001|
  
 :::image type="content" source="../images/purview-sqldb-server-name.png" alt-text="SQL DB Registration Values":::

## Setting up Scans

### Scan the ADLS Gen 2 Data Source

1. Navigate to the Purview data map and select **New Scan** on the data source
  
    :::image type="content" source="../images/ScanDataLake1.png" alt-text="Scan ADLS":::

1. Specify the following values in the resulting screen

    | Field| Suggested Value(s)  |
    |:-------|:--------------------|
    | Scan Name |`Scan_`_`[DLZprefix]`_`devraw`|
    | Connect via Integration Runtime| Select the Self Hosted Integration run time deployed as part of the Data Landing Zone.|
    | Credential|Select the Service Principal set up for Purview.|

    :::image type="content" source="../images/Scan-DataLake-add-scan-credential.png" alt-text="Scan ADLS credential":::

1. Click on **Test Connection** to verify the connectivity and permissions are in place, and click on **Continue**.

1. In the Scope your Scan screen, select the entire storage account as the scope for the scan. Click **Continue**.

    :::image type="content" source="../images/Scan-data-lake-file-system.png" alt-text="Select Storage File System":::

1. In the Select a Scan Rule Set screen, select the **ADLS Gen 2 Scan Rule set**. Click **Continue**.

    :::image type="content" source="../images/scan-data-lake-select-rule-set.png" alt-text="Scan Rule Set":::

1. In the Set a Scan Trigger screen, select **Once**. Click **Continue**.
  
    :::image type="content" source="../images/scan-data-lake-set-trigger.png" alt-text="Scan Trigger":::

1. In the final screen, review the scan settings and click on **Save and Run**.

    :::image type="content" source="../images/scan-data-lake-review-save.png" alt-text="Save and Run":::

1. Repeat steps 1 through 6 for the remaining storage accounts

- _`[DMLZprefix]`_`devencur`
- _`[DMLZprefix]`_`devwork`

### Scan the SQL DB Data Source

1. Click on the **New Scan** icon on the Azure SQL DB data source.

 
    :::image type="content" source="../images/scan-database.png" alt-text="New Scan SQL DB":::

1. Provide the following values and click on **Test Connection** to ensure the connectivity and permissions are correct. Click on **Continue**

    | Field| Suggested Value(s)  |
    |:-------|:--------------------|
    | Name |`Scan_Database001`|
    | Connect via: |Purview-SHIR|
    | Database name| Select the database name.|
    | Credential|select the Key Vault credential created in Purview.|
    | Lineage extraction |off|
  
    :::image type="content" source="../images/scan-database-credentials.png" alt-text="SQL DB Values":::

1. Select the scope for the scan. You can leave this as is to scan the entire database.

    :::image type="content" source="../images/scan-database-selections.png" alt-text="SQL DB Scope":::

1. Select **AzureSQLDatabase** as the scan rule set.
  
    :::image type="content" source="../images/scan-database-ruleset.png" alt-text="SQL DB Rule Set":::

1. Select **Once** for the Scan Trigger and click **Continue**.
  
    :::image type="content" source="../images/scan-set-trigger.png" alt-text="SQL DB Scan Trigger":::

1. Review the scan parameters and click on **Save and run** to start the scan.

1. Repeat steps 1 through 6 for the **AdatumERP** database

You now have Purview setup completed for data governance of registered data sources. Proceed to the next step.
