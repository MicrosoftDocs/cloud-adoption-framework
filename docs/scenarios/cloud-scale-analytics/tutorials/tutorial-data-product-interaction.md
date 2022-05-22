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

    :::image type="content" source="../images/cloud-shell.png" alt-text="Azure CLoud Shell":::

1. Select **bash** in the Cloud Shell environment and run the script below.

    - The script will find the _`[DLZprefix]`_`-dev-dp001` resource group and the Azure SQL Server _`[DPprefix]`_`-dev-sqlserver001` in it, then it will create the two Azure SQL Databases on this server.

    - Make sure to replace the \<subscription ID\> parameters with your own subscription ID.

>[!NOTE]
The databases will be pre-populated with AdventureWorks sample data, containing the required tables you will use on this tutorial.

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

When the scripts finish running, you will have on the Azure SQL Server _`[DPprefix]`_`-dev-sqlserver001` two new Azure SQL Databases: **AdatumCRM** and **AdatumERP**, both on the Basic compute tier. They are located in the same resource group _`[DLZprefix]`_`-dev-dp001` where you deployed the data product.

## Set up Purview to catalog the Data Product Batch

>[!NOTE]
>Through the rest of the document, _`DLZprefix`_ refers to the prefix provided for the Data Landing Zone deployment. _`DMLZprefix`_ refers to the prefix used for the Data Management Landing Zone deployment. _`DPprefix`_ refers to the prefix used for the Data Product deployment.

### Create Service Principal

1. Open the Azure Portal. On the top right, click on the highlighted icon below to open the cloud shell.
  :::image type="content" source="../images/cloud-shell.png" alt-text="Azure CLoud Shell":::
  
1. Update the command below to replace the **subscription ID** with your own subscriptionID and the **service principal name** created in the step earlier. After updating the values run in the cloud shell **bash**. The service principal name should be unique within the subscription.

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

    :::image type="content" source="../images/storage-account-sp-members-1.png" alt-text="Storage Account SP Members":::

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

1. Click on **Set Admin** and search for your own account. Click on the desired account returned by the search to select the account.

    :::image type="content" source="../images/set-sql-server-admin.png" alt-text="Search for Account":::

1. On the account is selected, click on **Select** to persist the setting.

     :::image type="content" source="../images/sqldb-selected-account.png" alt-text="Selected Account":::

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

    :::image type="content" source="../images/purview-key-vault-perm.png" alt-text="Purview Add Role Assignment":::

1. On the next screen, search for `Key Vault Administrator`, select the role `Key Vault Administrator` and click on **Next**.
  
    :::image type="content" source="../images/purview-key-vault-administrator.png" alt-text="Search Key Vault Administrator":::

1. Click on **+ Select Members** and add the account currently logged.

    :::image type="content" source="../images/keyvault-administrator-select-member.png" alt-text="Purview Select Member":::
    :::image type="content" source="../images/keyvault-administrator-your-account.png" alt-text="Purview Select your account":::

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

    :::image type="content" source="../images/key-vault-secret-user-role.png" alt-text="Search Key Vault Secret User":::

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

    :::image type="content" source="../images/key-vault-purview-connection.png" alt-text="New Manage Key Vault Connections":::

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

    :::image type="content" source="../images/purview-credential-values.png" alt-text="Credentials Values":::

## Registering Data Sources

At this point, Purview has visibility of the service principal. We can now proceed with registering and setting up the data sources.

### Register ADLS

 Gen 2 Storage Accounts

The following steps outline the process to register an ADLS Gen 2 Storage account.

1. In the Purview interface, click on the **Data Map** option and then **Register**
  
    :::image type="content" source="../images/data-map-register.png" alt-text="Register Data":::

1. Select **ADLS Gen 2** and click on **Continue**

    :::image type="content" source="../images/register-adls.png" alt-text="Register ADLS Gen2":::

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
  
 :::image type="content" source="../images/purview-sql-server-name.png" alt-text="SQL DB Registration Values":::

## Setting up Scans

### Scan the ADLS Gen 2 Data Source

1. Navigate to the Purview data map and select **New Scan** on the data source
  
    :::image type="content" source="../images/scan-data-lake-1.png" alt-text="Scan ADLS":::

1. Specify the following values in the resulting screen

    | Field| Suggested Value(s)  |
    |:-------|:--------------------|
    | Scan Name |`Scan_`_`[DLZprefix]`_`devraw`|
    | Connect via Integration Runtime| Select the Self Hosted Integration run time deployed as part of the Data Landing Zone.|
    | Credential|Select the Service Principal set up for Purview.|

    :::image type="content" source="../images/Scan-DataLake-add-scan-credential.png" alt-text="Scan ADLS credential":::

1. Click on **Test Connection** to verify the connectivity and permissions are in place, and click on **Continue**.

1. In the Scope your Scan screen, select the entire storage account as the scope for the scan. Click **Continue**.

    :::image type="content" source="../images/scan-data-lake-file-system.png" alt-text="Select Storage File System":::

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

## Copy SQL DB data to ADLS using Azure Data Factory

On the following steps you will use the Copy Data tool from Azure Data Factory (ADF) to create a pipeline to copy the tables from the Azure SQL Databases AdatumCRM and AdatumERP into .csv files in the _`[DLZprefix]`_`devraw` Azure Data Lake storage (ADLS).

### Setup Private Endpoints

As the environment is locked to public access, you need to first log into the Azure Portal on your local browser and connect to the bastion host virtual machine to be able to access the required Azure services using private endpoints:

1. On the resource group _`[DMLZprefix]`_`-dev-bastion` click on _`[DMLZprefix]`_`-dev-vm001`.

    :::image type="content" source="../images/bastion-vm.png" alt-text="Bastion VM":::

1. Select Connect -> Bastion

    :::image type="content" source="../images/bastion-vm-connect.png" alt-text="Bastion VM Connect":::

1. Enter the VM's Username and Password and click **Connect**.

    :::image type="content" source="../images/bastion-vm-connect-password.png" alt-text="Connect Using Bastion":::

1. On the VM's web browser, open the Azure portal and navigate to the resource group _`[DLZprefix]`_`-dev-shared-integration`, open Azure Data Factory _`[DLZprefix]`_`-dev-integration-datafactory001`

    :::image type="content" source="../images/adf-shared-integration.png" alt-text="ADF Shared Integration":::

1. Under the "Getting started" section click on "Open Azure Data Factory Studio" as shown on the image below:

    :::image type="content" source="../images/getting-started-adf-studio.png" alt-text="Data Factory Studio":::

1. On the ADF Studio interface click on the "Manage" icon on the left hand side menu (the fourth icon from the top - the one that looks like a square toolbox with a wrench stamped on it), then click on the "Managed private endpoints" option to create/approve the private endpoints necessary to connect Azure Data Factory to other secured Azure services.

    Note that when you approve the requests (more on that later) they will show as "Approved" as on the example you see on the image below for the storage account _`[DLZprefix]`_`devencur`.

    :::image type="content" source="../images/managed-private-endpoints.png" alt-text="Manage Private Endpoints":::

1. Before approving the private endpoint connections listed above, **click on "+ New" and type "azure sql" to filter the Azure SQL Database connector** you will use to create a new managed private endpoint for SQL Server: _`[DPprefix]`_`-dev-sqlserver001`. This is the server which contains Azure SQL Databases AdatumCRM and AdatumERP that we created on earlier steps.

    :::image type="content" source="../images/managed-private-endpoints.png" alt-text="Private Endpoint Add SQL Connection":::

1. **Name the Private Endpoint:** "dataproduct-dev-sqlserver001" as depicted on the image below. **Confirm** that you selected the SQL Server: _`[DPprefix]`_`-dev-sqlserver001`, otherwise you will not be able to connect to it from this Data Factory on upcoming steps.

    :::image type="content" source="../images/managed-private-endpoints-sql-server.png" alt-text="Create Private Endpoint to Azure SQL Server":::

>[!NOTE]
>To approve ADF to to access the private endpoints of these services, here are a couple of options:

**Option 1**: On each of the services that you request access to, you need to go to the "networking" or to "private endpoint connections" option of that service on the Azure portal to to approve these private endpoint access requests.

**Option 2**: Run the scripts below using the Azure Cloud Shell in Bash mode and approve all the required private endpoints at once.

```bash

# Storage Managed Private EndPoint approval 

# devencur
resourceGroupName=$(az group list -o tsv  --query "[?contains(@.name, '-dev-storage')==\`true\`].name")
storageAcctName=$(az storage account list -g $resourceGroupName -o tsv  --query "[?contains(@.name, 'devencur')==\`true\`].name")
endPointConnectionName=$(az network private-endpoint-connection list -g $resourceGroupName -n $storageAcctName --type Microsoft.Storage/storageAccounts -o tsv --query "[?contains(@.properties.privateLinkServiceConnectionState.status, 'Pending')==\`true\`].name")

az network private-endpoint-connection approve -g $resourceGroupName -n $endPointConnectionName --resource-name $storageAcctName --type Microsoft.Storage/storageAccounts --description "Approved"

# devraw
resourceGroupName=$(az group list -o tsv  --query "[?contains(@.name, '-dev-storage')==\`true\`].name")
storageAcctName=$(az storage account list -g $resourceGroupName -o tsv  --query "[?contains(@.name, 'devraw')==\`true\`].name")
endPointConnectionName=$(az network private-endpoint-connection list -g $resourceGroupName -n $storageAcctName --type Microsoft.Storage/storageAccounts -o tsv --query "[?contains(@.properties.privateLinkServiceConnectionState.status, 'Pending')==\`true\`].name")
az network private-endpoint-connection approve -g $resourceGroupName -n $endPointConnectionName --resource-name $storageAcctName --type Microsoft.Storage/storageAccounts --description "Approved"

# SQL Database Managed Private Endpoint Approval 
resourceGroupName=$(az group list -o tsv  --query "[?contains(@.name, '-dev-dp001')==\`true\`].name")
sqlServerName=$(az sql server list -g $resourceGroupName -o tsv  --query "[?contains(@.name, 'sqlserver001')==\`true\`].name")
endPointConnectionName=$(az network private-endpoint-connection list -g $resourceGroupName -n $sqlServerName --type Microsoft.Sql/servers -o tsv --query "[?contains(@.properties.privateLinkServiceConnectionState.status, 'Pending')==\`true\`].name")
az network private-endpoint-connection approve -g $resourceGroupName -n $endPointConnectionName --resource-name $sqlServerName --type Microsoft.Storage/storageAccounts --description "Approved"

# KeyVault Private Endpoint Approval 
resourceGroupName=$(az group list -o tsv  --query "[?contains(@.name, '-dev-metadata')==\`true\`].name")
keyVaultName=$(az keyvault list -g $resourceGroupName -o tsv  --query "[?contains(@.name, 'dev-vault001')==\`true\`].name")
endPointConnectionID=$(az network private-endpoint-connection list -g $resourceGroupName -n $keyVaultName --type Microsoft.Keyvault/vaults -o tsv --query "[?contains(@.properties.privateLinkServiceConnectionState.status, 'Pending')==\`true\`].id")
az network private-endpoint-connection approve -g $resourceGroupName --id $endPointConnectionID --resource-name $keyVaultName --type Microsoft.Keyvault/vaults --description "Approved"

# Purview Private Endpoint Approval 
resourceGroupName=$(az group list -o tsv  --query "[?contains(@.name, 'dev-governance')==\`true\`].name")
purviewAcctName=$(az purview account list -g $resourceGroupName -o tsv  --query "[?contains(@.name, '-dev-purview001')==\`true\`].name")
for epn in $(az network private-endpoint-connection list -g $resourceGroupName -n $purviewAcctName --type Microsoft.Purview/accounts -o tsv --query "[?contains(@.properties.privateLinkServiceConnectionState.status, 'Pending')==\`true\`].name")
do
    az network private-endpoint-connection approve -g $resourceGroupName -n $epn --resource-name $purviewAcctName --type Microsoft.Purview/accounts --description "Approved"
done

```

Here is an example of how this storage account _`[DLZprefix]`_`devraw` manages private endpoint access requests. Click on "Networking", and then on the "Private endpoint connections" tab as highlighted in red on the image below:

:::image type="content" source="../images/private-endpoint-connections.png" alt-text="Private Endpoint Connections":::

And here is an example of how to approve a private endpoint access request by clicking in "Private endpoint connections". The interface is slightly different, but you also have the option to first select the request in "Pending" state and click on "Approve" as depicted on the image below for the Azure SQL Server _`[DLZprefix]`_`-dev-sqlserver001`:

:::image type="content" source="../images/private-endpoint-connections-sql.png" alt-text="Private Endpoint SQL Connections":::

>[!NOTE]
>After you approve the request at each of the services, it might take a few minutes for the request to show as "Approved" on the "Managed private endpoints" pane back in Data Factory Studio. (even if you press "Refresh", the approval state might be stale for some time).

When you are done with all approvals, the "Managed private endpoints" pane should look similar to this, with all the approval state fields marked as "Approved":

:::image type="content" source="../images/managed-private-endpoints-complete.png" alt-text="Private Endpoint SQL Connections Approved":::

### Role Assignments

- After completing the Endpoint approvals, it is now necessary to add the appropriate role permissions (credentials) for Data Factory to access:
  - Azure SQL Databases AdatumCRM and AdatumERP in Azure SQL Server _`[DPprefix]`_`-dev-sqlserver001`,
  - Storage Accounts _`[DLZprefix]`_`devraw`, _`[DLZprefix]`_`devencur`and _`[DLZprefix]`_`devwork`.
  - Purview account _`[DMLZprefix]`_`-dev-purview001`

#### Azure SQL Server

1. Lets start with Azure SQL Server. **Navigate** to _`[DPprefix]`_`-dev-sqlserver001` in the resource group  _`[DMLZprefix]`_`-dev-dp001`.  

1. Click **"Access Control (IAM)"**, then Click on the **"+ Add" button** circled in red as depicted on the image below, and then select **"Add role assignment"** from the dropdown menu.

    :::image type="content" source="../images/add-role-to-sql-server.png" alt-text="Azure SQL Server Add Roles":::

1. Select **"Contributor"** and click **Next**.

    :::image type="content" source="../images/add-role-to-contributor.png" alt-text="Azure SQL Server Contributor Role":::

1. On the "Members" tab, Select **"Managed Identity"** and then click on **+ Select Members"** to open the "select managed identities" pane on the right hand side of the screen, as depicted on the image below:

    :::image type="content" source="../images/add-role-to-managed-identities.png" alt-text="Azure SQL Server Managed Identity Members":::

1. Also depicted on the image above you will see that you need to select the **subscription** and the **"Data Factory (V2)"** to be able to list the available Data Factories. On the options that will be listed by name, select **Azure Data Factory _`[DLZprefix]`_`-dev-integration-datafactory001`**

1. After you click **Select** the screen will look similar to the one below, where you will just need to click **twice** on **"Review and Assign"** to complete this process:

    :::image type="content" source="../images/add-role-to-sql-server-review-assign.png" alt-text="Azure SQL Server Managed Review and Assign":::

#### Storage Accounts

1. Now lets assign the appropriate roles to the storage accounts _`[DLZprefix]`_`devraw`, _`[DLZprefix]`_`devencur`and _`[DLZprefix]`_`devwork`.

1. Follow the same steps as you just did for the Azure SQL Server role assignment. This time, select **"Storage Blob Data Contributor"** instead of selecting the  **"Contributor"** role.

1. After assigning the permissions to all three storage accounts, Data Factory will be able to connect and access these storage accounts to complete upcoming lab steps.

#### Purview

The last step on adding role assignments is to add the **"Purview Data Curator"** role in Purview to the managed identity account of the Azure Data Factory _`[DLZprefix]`_`-dev-integration-datafactory001`. These steps will allow Data Factory to send data catalog assets information from multiple data sources to the Purview account.

1. Go to the Purview account _`[DMLZprefix]`_`-dev-purview001` in the resource group _`[DMLZprefix]`_`-dev-governance`, click on **Open Purview Studio**.

1. In Purview Studio, select **Data Map**, then **Collections**.

1. On the right pane click on **Role assignments** and find **Data curators**.

1. Add the managed identity for _`[DLZprefix]`_`-dev-integration-datafactory001` as you see on the image below:

:::image type="content" source="../images/purview-role-assignment.png" alt-text="Purview Role Assignment":::

### Connect Data Factory to Purview

The permissions are set, Purview can now see the Data Factory, and the next step now is to have _`[DMLZprefix]`_`-dev-purview001` connecting to _`[DLZprefix]`_`-dev-integration-datafactory001`.

1. Open **Purview Studio**, click on **Management**, select **Data Factory**, and create a Data Factory connection by clicking on **+ New**. Select Data Factory _`[DLZprefix`_`-dev-integration-datafactory001` and click ok.

1. Here is how the setting should look like while selecting the new connection:
  
    :::image type="content" source="../images/connect-purview-to-data-factory.png" alt-text="Purview Role Assignment final":::

1. In the _`[DLZprefix]`_`-dev-integration-datafactory001` Data Factory Studio, refresh the **Azure Purview account** under **Manage>Azure Purview.** and the "Data Lineage - Pipeline" will show the green icon **"Connected"** as depicted on the image below:

    :::image type="content" source="../images/data-factory-purview-connection.png" alt-text="Data Factory Purview":::

### Create ETL Pipeline

Now that the  _`[DLZprefix]`_`-dev-integration-datafactory001` has the required access permissions you will create a copy activity in Azure Data Factory to move data from Azure SQL Databases to the raw Storage Account _`[DLZprefix]`_`devraw`.

#### Copy Data tool - AdatumCRM

This process will extract "Customer" data from the AdatumCRM Azure SQL Database into Azure Data Lake Storage.

1. In Data Factory Studio, on the **Author** section, click on the plus sign (+) under **Factory Resources** and select **Copy Data tool** from the context menu as shown on the picture below.

    :::image type="content" source="../images/copy-data-tool.png" alt-text="Copy Data tool":::

Follow each step on the Copy Data tool wizard:

1. Select **Schedule** to create a trigger to run the pipeline every 24 hours.

    :::image type="content" source="../images/create-pipeline.png" alt-text="Create Trigger":::

1. Click on **+ New Connection** to create a Linked Service to connect this data factory to the Azure SQL Database AdatumCRM on server _`[DPprefix]`_`-dev-sqlserver001` (source)

    :::image type="content" source="../images/adatum-crm-connection.png" alt-text="Connect to AdatumCRM":::

>[!NOTE]
>If you have any errors connecting or accessing the data in the Azure SQL Databases, or the storage accounts, please review permissions and make sure that the Data Factory has the appropriate credentials and access permissions to any problematic resource.

1. Select these 3 tables:

- SalesLT.Address
- SalesLT.Customer
- SalesLT.CustomerAddress

    :::image type="content" source="../images/adatum-crm-tables.png" alt-text="Select Tables":::

1. Create a new Linked Service to access the _`[DLZprefix]`_`devraw` Azure Data Lake Storage Gen2. (destination)

    :::image type="content" source="../images/raw-storage-connection.png" alt-text="Raw Storage Connection":::

1. Browse the folders in the _`[DLZprefix]`_`devraw` storage and select "data" as the destination.

    :::image type="content" source="../images/raw-data-folder.png" alt-text="Raw Storage Destination":::

1. Change the "File name suffix" to .csv and leave the other options as default.

    :::image type="content" source="../images/destination-data-source.png" alt-text="CSV file":::

1. Go to the next screen and select "Add header to file".

    :::image type="content" source="../images/add-header-to-file.png" alt-text="header to file":::

1. Finish the wizard with a screen similar to this one:

    :::image type="content" source="../images/copy-datatool-crm-complete.png" alt-text="Copy Data Tool completed":::

When you are done with the wizard, it will show under Pipelines the new pipeline you just created.

#### Pipeline

- Rename the pipeline and the Datasets to the names you see on the image below, publish all, then run the Trigger to have the 3 tables copied from SQL DB to ADLS.

    :::image type="content" source="../images/trigger-run-crm.png" alt-text="Copy Data Tool SQLDB to ADLS":::

This process you just finished will create 3 .csv files in the "data\CRM" folder, one for each of the selected tables of database AdatumCRM.

#### Copy Data tool - AdatumERP

Now lets extract the data from the AdatumERP Azure SQL Database representing the sales data coming from the ERP system.

1. Still in ADF Studio, create a new pipeline using the Copy Data Tool again, this time to send the sales data from AdatumERP to the `[DLZprefix]devraw` storage account data folder, the same way you did with the CRM data.

- Follow the same steps as in item 5, this time using Azure SQL Database AdatumERP as the source.

- Create the schedule to trigger every hour as well.

- Linked Service to Azure SQL DB name: AdatumERP.

:::image type="content" source="../images/adatum-erp-connection.png" alt-text="AdatumERP Connection":::

1. Select tables: SalesLT.Product, SalesLT.ProductCategory, SalesLT.ProductDescription, SalesLT.ProductModel, SalesLT.ProductModelProductDescription, SalesLT.SalesOrderDetail, SalesLT.SalesOrderHeader.

:::image type="content" source="../images/adatum-erp-tables.png" alt-text="AdatumERP Tables":::

1. Use the already created Linked Service to the `[DLZprefix]devraw` storage account, set the file extension to .csv.

:::image type="content" source="../images/destination-data-source.png" alt-text="Raw storage account":::

1. Select Add header to file.

:::image type="content" source="../images/add-header-to-file.png" alt-text="header to file":::

1. Finish the wizard for the second time, rename the pipeline to CopyPipeline_ERP_to_DevRaw , publish all, then run the trigger on this newly created pipeline, to have the 7 tables you selected copied from SQL DB to ADLS.

After finishing these steps, there will be ten .csv files in Azure Data Lake storage _`[DLZprefix]`_`devraw`. You can now proceed to the next step to start curating the files in the _`[DLZprefix]`_`devencur` Data Lake.

## Curate Data in ADLS

### Curate Data

After finishing the creation of the ten _.csv_ files in the "raw" _`[DLZprefix]`_`devraw` Data Lake storage, in this step you will transform these files as needed as you copy them to the "Curated" _`[DLZprefix]`_`devencur` Data Lake storage.

Continue using Azure Data Factory to create these new pipelines to orchestrate this data movement.

### CRM to Customer

With this Data flow that you are about to create you will get the .csv files in the Data\CRM folder in _`[DLZprefix]`_`devraw` transform them and copy the transformed files to folder "Data\Customer" in _`[DLZprefix]`_`devencur` in .parquet format.

Here are the steps:

1. On the home page of Azure Data Factory, select Orchestrate.

:::image type="content" source="../images/select-orchestrate.png" alt-text="Add header to file":::

1. In the General tab for the pipeline, name it "Pipeline_transform_CRM".

1. In the Activities pane, expand the Move and Transform accordion. Drag and drop the Data Flow activity from the pane to the pipeline canvas.

:::image type="content" source="../images/activities.png" alt-text="Activities":::

1. In the Adding Data Flow pop-up, select Create new Data flow and then name your data flow "CRM_to_Customer". Click Finish when done.

>[!NOTE]
>In the top bar of the pipeline canvas, slide the Data flow debug slider on. Debug mode allows for interactive testing of transformation logic against a live Spark cluster. Data Flow clusters take 5-7 minutes to warm up and users are recommended to turn on debug first if they plan to do Data Flow development.

:::image type="content" source="../images/data-flow-debug.png" alt-text="Open Data Flow":::

1. When you are finished selecting all the options in the Data flow "CRM_to_Customer", the pipeline "Pipeline_transform_CRM" will look like this:

:::image type="content" source="../images/pipelines-transform-crm.png" alt-text="Pipeline_transform_CRM":::

and the Data flow will look like this:

:::image type="content" source="../images/crm-to-customer.png" alt-text="CRM_to_Customer":::

These are the settings you need to modify in the Data Flow when manipulating these files:

For the source "CRMAddress":

- Create a new dataset from "Azure Data Lake Storage Gen2" with format "DelimitedText" and call it "DevRaw_CRM_Address"
- Connect to the linked service to _`[DLZprefix]`_`devraw`
- Select file Data\CRM\SalesLTAddress.csv as the source.

And for it's pair, the sink "CustAddress":

- Create a new dataset called DevEncur_Cust_Address
- Select file Data\Customer\ in _`[DLZprefix]`_`devencur` as the sink.
- Convert the file to "Address.parquet" (under "Settings\Output to single file").

>[!NOTE]
>For the rest of the Data flow configuration, use the information on the table below for each component. Note that CRMAddress and CustAddress are the first two rows. Use them as an example for the other objects.

>[!NOTE]
>There is one item that is not on the table, which is the "RemovePasswords" Select Schema Modifier. As you can see on the picture of the Data flow "CRM_to_Customer" this goes in between "CRMCustomer"
and "CustCustomer". When you add this Select, go to "Select settings" and remove fields "PasswordHash" and "PasswordSalt".

>[!NOTE]
>"CRMCustomer" brings back a schema with 15 columns from the .crv file, and "CustCustomer" will write only 13 columns after the Select Schema Modifier removes the two password columns.

#### Complete Table

| Name | Object Type | Dataset Name | Data Store | Format Type | Linked Service | File or Folder |
|---|---|---|---|---|---|---|
| CRMAddress | source | DevRaw_CRM_Address | Azure Data Lake Storage Gen2 | DelimitedText | devraw | Data\CRM\SalesLTAddress.csv |
| CustAddress | sink | DevEncur_Cust_Address | Azure Data Lake Storage Gen2 | Parquet | devencur | Data\Customer\Address.parquet |
| CRMCustomer | source | DevRaw_CRM_Customer | Azure Data Lake Storage Gen2 | DelimitedText | devraw | Data\CRM\SalesLTCustomer.csv |
| CustCustomer | sink | DevEncur_Cust_Customer | Azure Data Lake Storage Gen2 | Parquet | devencur | Data\Customer\Customer.parquet |
| CRMCustomerAddress | source | DevRaw_CRM_CustomerAddress | Azure Data Lake Storage Gen2 | DelimitedText | devraw | Data\CRM\SalesLTCustomerAddress.csv |
| CustCustomerAddress | sink | DevEncur_Cust_CustomerAddress | Azure Data Lake Storage Gen2 | Parquet | devencur | Data\Customer\CustomerAddress.parquet |

### ERP to Sales

Now repeat similar steps and create pipeline "Pipeline_transform_ERP", create a Data flow "ERP_to_Sales" to transform the .csv files in the Data\ERP folder in _`[DLZprefix]`_`devraw` and copy the transformed files to folder "Data\Sales" in _`[DLZprefix]`_`devencur`

On the table below you will find the objects to create in the "ERP_to_Sales" Data Flow and the settings you need to modify for each one of them. Note that each .csv file gets mapped to a .parquet sink.

| Name | Object Type | Dataset Name | Data Store | Format Type | Linked Service | File or Folder |
|---|---|---|---|---|---|---|
| ERPProduct | source | DevRaw_ERP_Product | Azure Data Lake Storage Gen2 | DelimitedText | devraw | Data\ERP\SalesLTProduct.csv |
| SalesProduct | sink | DevEncur_Sales_Product | Azure Data Lake Storage Gen2 | Parquet | devencur | Data\Sales\Product.parquet |
| ERPProductCategory | source | DevRaw_ERP_ProductCategory | Azure Data Lake Storage Gen2 | DelimitedText | devraw | Data\ERP\SalesLTProductCategory.csv |
| SalesProductCategory | sink | DevEncur_Sales_ProductCategory | Azure Data Lake Storage Gen2 | Parquet | devencur | Data\Sales\ProductCategory.parquet |
| ERPProductDescription | source | DevRaw_ERP_ProductDescription | Azure Data Lake Storage Gen2 | DelimitedText | devraw | Data\ERP\SalesLTProductDescription.csv |
| SalesProductDescription | sink | DevEncur_Sales_ProductDescription | Azure Data Lake Storage Gen2 | Parquet | devencur | Data\Sales\ProductDescription.parquet |
| ERPProductModel | source | DevRaw_ERP_ProductModel | Azure Data Lake Storage Gen2 | DelimitedText | devraw | Data\ERP\SalesLTProductModel.csv |
| SalesProductModel | sink | DevEncur_Sales_ProductModel | Azure Data Lake Storage Gen2 | Parquet | devencur | Data\Sales\ProductModel.parquet |
| ERPProductModelProductDescription | source | DevRaw_ERP_ProductModelProductDescription | Azure Data Lake Storage Gen2 | DelimitedText | devraw | Data\ERP\SalesLTProductModelProductDescription.csv |
| SalesProductModelProductDescription | sink | DevEncur_Sales_ProductModelProductDescription | Azure Data Lake Storage Gen2 | Parquet | devencur | Data\Sales\ProductModelProductDescription.parquet |
| ERPProductSalesOrderDetail | source | DevRaw_ERP_ProductSalesOrderDetail | Azure Data Lake Storage Gen2 | DelimitedText | devraw | Data\ERP\SalesLTProductSalesOrderDetail.csv |
| SalesProductSalesOrderDetail | sink | DevEncur_Sales_ProductSalesOrderDetail | Azure Data Lake Storage Gen2 | Parquet | devencur | Data\Sales\ProductSalesOrderDetail.parquet |
| ERPProductSalesOrderHeader | source | DevRaw_ERP_ProductSalesOrderHeader | Azure Data Lake Storage Gen2 | DelimitedText | devraw | Data\ERP\SalesLTProductSalesOrderHeader.csv |
| SalesProductSalesOrderHeader | sink | DevEncur_Sales_ProductSalesOrderHeader | Azure Data Lake Storage Gen2 | Parquet | devencur | Data\Sales\ProductSalesOrderHeader.parquet |

Congratulations You have reached the completion of the tutorial
