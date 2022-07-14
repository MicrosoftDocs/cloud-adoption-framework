---
title: Interact with data product services
description: Learn how to interact with data product services, including how to perform data orchestration and how to use Microsoft Purview for data governance. 
author: andrehass
ms.author: anhass
ms.date: 07/13/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Interact with data product services

In this tutorial, learn how to interact with data product services that are already deployed. In the tutorial, you use Azure Data Factory for data integration and orchestration, and you use Azure Purview to discover, manage, and govern data assets.

The objective of completing this hands-on experience is for you to become familiar with the services deployed in the sample data product resource group `<DMLZ-prefix>-dev-dp001`. You will experience how these products interface with each other and the security measures in place.

As you deploy the new components, you will have a chance to investigate how Purview glues together service governance to create a holistic, up-to-date map of your data landscape with automated data discovery, sensitive data classification, and end-to-end data lineage.

## Prerequisites

- **Permissions to the Azure subscription**: User Access Administrator or Owner access to the subscription for Purview and Synapse configuration, role assignments for services and service principals.

- **A successfully deployed data management landing zone**: For more information, check the [data management landing zone](https://github.com/Azure/data-management-zone) repo.

- **A successfully deployed data landing zone**: For more information, check the [data landing zone](https://github.com/Azure/data-landing-zone) GitHub repository.

- **A successfully deployed data product**: For more information, check the [data product](https://github.com/Azure/data-product-batch) repo.

- **A Purview account**: This has been already deployed in the data management landing zone deployment steps.

- **Self Hosted Integration Runtime**: This has been already deployed in the data landing zone deployment steps.

### Create Azure SQL Databases

The first step to start this hands-on experience is to create two sample Azure SQL Databases. You will use them to simulate the CRM and ERP data sources for the upcoming steps.

1. Open the Azure portal. On the top right, select the highlighted icon below to open the Cloud Shell.

    :::image type="content" source="../images/cloud-shell.png" alt-text="Screenshot that shows the Cloud Shell icon on the Azure portal.":::

1. Select **bash** in the Cloud Shell environment and run the script below.

    - The script finds the `<DLZ-prefix>-dev-dp001` resource group and the Azure SQL server `<DP-prefix>-dev-sqlserver001` that's in the resource group. Then, the script creates the two Azure SQL databases on the `<DP-prefix>-dev-sqlserver001` server.

    - Make sure you replace the `<subscription ID>` parameters with your own Azure subscription ID.

    > [!NOTE]
    >The databases will be pre-populated with AdventureWorks sample data, containing the required tables you will use on this tutorial.

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

When the scripts finish running, you will have on the Azure SQL Server `<DP-prefix>-dev-sqlserver001` two new Azure SQL Databases: **AdatumCRM** and **AdatumERP**, both on the Basic compute tier. They are located in the same resource group `<DLZ-prefix>-dev-dp001` where you deployed the data product.

## Set up Purview to catalog the data product batch

> [!NOTE]
> In the rest of the article, `<DLZ-prefix>` refers to the prefix you provided when you deployed the *data landing zone*. `<DMLZ-prefix>` refers to the prefix you provided when you deployed the *data management landing zone deployment*. `<DP-prefix>` refers to the prefix you provided when you deployed the data product.

### Create a service principal

1. In the [Azure portal](https://portal.azure.com/), in the portal global controls, select the **Cloud Shell** icon to open an Azure Cloud Shell terminal.

  :::image type="content" source="../images/cloud-shell.png" alt-text="Screenshot that shows the Cloud Shell icon in the Azure portal.":::
  
1. Revise the following command to replace the value for `subscriptionId` with your Azure subscription ID and replace the value for `spname` with the name of the service principal you created earlier. After you update the values, run the command in the Cloud Shell by using **bash**. The service principal name should be unique within the subscription.

    > [!IMPORTANT]
    > Replace the parameters with a service principal name of your choice and your subscription ID.

    ```bash
    # Replace the parameters with a service principal name of your choice and your subscription ID. 
    spname="<service_principal_name>" 
    subscriptionId="<subscription_id>"

    # Set the scope to subscription.
    scope="/subscriptions/$subscriptionId"

    # Create the service principal 
    az ad sp create-for-rbac \
      --name $spname \
      --role "Contributor" \
      --scope $scope

    ```

1. Check the JSON output for a result that's similar to the following example. *Note or copy the values in the output to use in later steps*.

    ```json
    {
      "appId": "example-app-id",
      "displayName": "purview-service-principal",
      "name": "example-service-principal-name",
      "password": "example-service-principal-password",
      "tenant": "example-tenant"
    }
    ```

### Set up service principal access and permissions

From the JSON output generated in the preceding step, get the following values:

- service principal ID (`appId`)
- service principal key (`password`)

The service principal must have the following permissions:

- **Blob data reader** role on the Azure Storage accounts
- **Data Reader** permissions on the Azure SQL database instance

To set up the service principal with the required role and permissions, complete the following steps.

#### Azure Storage account permissions

1. In the Azure portal, go to the `<DLZ-prefix>devraw` Azure Storage account. In the resource menu, select **Access Control (IAM)**.

    :::image type="content" source="../images/storage-account-sp-permissions.png" alt-text="Screenshot of the Storage account service principal permissions pane, with Access Control highlighted.":::

1. Select **Add** > **Add role assignment**.

    :::image type="content" source="../images/storage-account-sp-access-control.png" alt-text="Screenshot of the Storage account service principal Access Control pane that shows how to add a role assignment.":::

1. In **Add role assignment**, search for and select **Storage Blob Data Reader**. Then, select **Next**.

    :::image type="content" source="../images/storage-account-sp-role-assignment.png" alt-text="Screenshot that shows how to search for Storage Blob Data Reader under Add role assignment.":::

1. In **Members**, choose **Select Members** and search for the service principal account you created.

    :::image type="content" source="../images/storage-account-sp-members-1.png" alt-text="Screenshot of select members screen under add role assignment.":::

1. Search for and select the service principal name you created earlier.

    :::image type="content" source="../images/add-service-principal.png" alt-text="Screenshot that shows how to search for the service principal Name created in previous step.":::

1. Choose **Select**.

    :::image type="content" source="../images/select-service-principal.png" alt-text="Screenshot of the results pane after searching for the service principal Name.":::

1. To complete the role assignment, select **Review + assign** twice.

    Repeat the steps in this section for the remaining storage accounts:

    - `<DLZ-prefix>devencur`
    - `<DLZ-prefix>devwork`

### Azure SQL database permissions

To set Azure SQL database permissions, you connect to SQL Server by using the query editor. Because all the resources are behind a private endpoint, you must first sign in to the Azure portal by using an Azure Bastion host virtual machine.

In the Azure portal, connect to the virtual machine that's deployed in the `<DMLZ-prefix>-dev-bastion` resource group. If you're not sure how to connect to the virtual machine by using the Bastion host service, see [Connect to a VM](/azure/bastion/tutorial-create-host-portal#connect).

To add the service principal as a user within the database, you might first need to add yourself as the Azure Active Directory admin. Steps 1 to 3 explain how to do this. The remainder of the steps explain how to give the service principal permissions to the database. When you are signed in to the portal from the Bastion host virtual machine, search for SQL servers in the Azure portal.

1. Go to the `<DP-prefix>-dev-sqlserver001` Azure SQL server and select **Active Directory**.

    :::image type="content" source="../images/azure-sql-admin-1.png" alt-text="Screenshot of the Azure active directory screen under SQl server.":::

1. Select **Set Admin**. Search for and select your own account.

    :::image type="content" source="../images/set-sql-server-admin.png" alt-text="Screenshot that shows how to search for an Account to make admin.":::

1. Choose **Select** to persist the setting.

     :::image type="content" source="../images/sql-database-selected-account.png" alt-text="Screenshot of the correct admin account selected.":::

1. Select **SQL Databases**, and then select the `AdatumCRM` database.

     :::image type="content" source="../images/database-query-editor.png" alt-text="Screenshot of the search to find the correct database with Adatum CRM highlighted.":::

1. In **AdatumCRM**, select **Query editor**. Under **Active Directory authentication**, select the **Continue as** button to sign in.

     :::image type="content" source="../images/query-editor.png" alt-text="Screenshot that shows how to log in to query editor with Active Directory.":::

1. In the query editor, revise the following statements to replace `<service principal name>` with the name of the service principal you created (for example, `purview-service-principal`). Then, run the statements.

    ```sql

    CREATE USER [<service principal name>] FROM EXTERNAL PROVIDER
    GO

    EXEC sp_addrolemember 'db_datareader', [<service principal name>]
    GO

    ```

    :::image type="content" source="../images/azure-sql-add-sp.png" alt-text="Screenshot that shows how to execute statements in the query editor.":::

Repeat steps 4 through 6 for the `AdatumERP` database.

### Set up the key vault

Purview will read the service principal key from a key vault. We will use the Key Vault instance deployed along with the **data management landing zone**. The following steps are required to set up the key vault.

- Add the service principal key to the key vault as a secret.
- Give the Purview MSI Secrets Reader permissions on the key vault
- Add the key vault within Purview as a Key Vault Connection
- Create a Credential within Purview pointing to the key vault secret

### Add permissions to add secret to the key vault

1. In the Azure portal, go to the Azure Key Vault service. Search for the `<DMLZ-prefix>-dev-vault001` key vault.

     :::image type="content" source="../images/key-vault-1.png" alt-text="Screenshot of the Access Control Key Vault screen.":::

1. Select **Access Control (IAM)**, **Add** and then **Add Role Assignment**.

    :::image type="content" source="../images/purview-key-vault-perm.png" alt-text="Screenshot of adding a role assignment in Purview.":::

1. On the next screen, search for `Key Vault Administrator`, select the role `Key Vault Administrator` and select **Next**.
  
    :::image type="content" source="../images/purview-key-vault-administrator.png" alt-text="Screenshot that shows how to search for the Key Vault Administrator role.":::

1. Choose **Select Members** and add the account that's currently signed in.

    :::image type="content" source="../images/key-vault-administrator-select-member.png" alt-text="Screenshot of the Select members button highlighted.":::
    :::image type="content" source="../images/key-vault-administrator-your-account.png" alt-text="Screenshot of the select member search field.":::

1. In **Select Members**, search for the account that's currently signed in. Select the account, and then choose **Select**.

    :::image type="content" source="../images/key-vault-select-user.png" alt-text="Screenshot of the select member set to your relevant account.":::

1. To complete the role assignment process, select **Review + assign** twice.

### Add a secret to the key vault

Complete the following steps to sign in to the Azure portal from the Bastion Host virtual machine.

1. In the `<DMLZ-prefix>-dev-vault001` key vault, select **Secrets** > **Generate/Import** to create a new secret.
  
    :::image type="content" source="../images/key-vault-add-secret.png" alt-text="Screenshot that shows the Key Vault Generate Secret button highlighted.":::

1. Enter or select the following values, and then select **Create**:

    | Field | Suggested value |
    | --- | --- |
    | **Upload options** | **Manual** |
    | **Name** | **service-principal-secret** |
    | **Value** | The service principal password you created in the previous steps `CJsPsAz8-~sf6_Qj_ecXXxxxXxxXXxxXXXxXX`|

     :::image type="content" source="../images/key-vault-create-secret.png" alt-text="Screenshot of the Key Vault Create Secret screen.":::

      > [!NOTE]
      >This step creates a secret named `service-principal-secret` within the key vault with the service principal password key. This will be used by Purview to connect to and scan the data sources. If the incorrect password provided, subsequent steps will not work.

### Set up Purview permissions on the key vault

For the Purview instance to read the secrets stored within the key vault, it has to be given relevant permissions on the key vault. We do this by adding the **Purview Managed Identity** to the `Key Vault Secrets Reader` role.

1. On the same key vault with the name `<DMLZ-prefix>-dev-vault001`, select **Access Control (IAM)** > **Add** > **Add Role Assignment**.
  
    :::image type="content" source="../images/key-vault-add-role-assignment.png" alt-text="Screenshot of the Access Control screen with the add role assignment button highlighted.":::

1. In **Role**, search for and select **Key Vault Secrets User**. Select **Next**.

    :::image type="content" source="../images/key-vault-secret-user-role.png" alt-text="Screenshot of the search for Key Vault Secret User screen.":::

1. Choose **Select Members**.
  
    :::image type="content" source="../images/key-vault-user-select-member.png" alt-text="Screenshot of the add role assignment screen with the select member button highlighted.":::

1. Search for the `<DMLZ-prefix>-dev-purview001` Purview instance. Select it to add the relevant account, and then choose **Select**.
  
    :::image type="content" source="../images/key-vault-user-purview-managed.png" alt-text="Screenshot of the search bar for the Purview instance name.":::

1. To complete the role assignment process, select **Review + assign** twice.
  
    :::image type="content" source="../images/key-vault-user-purview-managed-review-assign.png" alt-text="Screenshot that shows how to complete a role assignment.":::

### Set up key vault Connection in Purview

> [!NOTE]
>For this step, you will need to log into the Azure portal using a bastion host Virtual Machine.

The next step is for us to link Purview with the key vault. To do this, follow the steps below

1. Navigate to the Purview Account in the Azure portal. Access your Purview Account `<DMLZ-prefix>-dev-purview001`. Select the **Open** link within the Open Microsoft Purview Governance Portal.

    :::image type="content" source="../images/microsoft-purview-studio.png" alt-text="Screenshot of the Microsoft Purview account overview.":::
  
1. Within the Purview Studio, select the **Management** hub > **Credentials** > **Manage Key Vault Connections** > **New** in the dialog
  
    :::image type="content" source="../images/purview-key-vault-connection.png" alt-text="Screenshot that shows the new Key Vault Connections form.":::

1. Select **Manage Key Vault Connections** and then **New** in the dialog

    :::image type="content" source="../images/key-vault-purview-connection.png" alt-text="Screenshot of the Manage Key Vault Connections button.":::

1. Create the new connection with the following values and then select **Create**.

    | Field| Suggested Value(s)  |
    |:-------|:--------------------|
    | Name| `<DMLZ-prefix>-dev-vault001` |
    | Azure Subscription | Select the subscription hosting the key vault|
    | Key Vault Name | Select the key vault `<DMLZ-prefix>-dev-vault001`|

1. On Confirming granting access, select **Confirm**.

### Create a Credential in Purview

The final step is to create a credential within Purview pointing to the secret we created earlier in the key vault for the service principal. To do this, follow the steps below:

1. Select **Management** > **Credentials** > **New**

    :::image type="content" source="../images/purview-add-credentials.png" alt-text="Screenshot that shows the new Purview Credentials screen.":::

1. In the dialog, provide the following values and select **Create**

    | Field| Suggested Value(s)  |
    |:-------|:--------------------|
    | Name| `purviewServicePrincipal` |
    | Authentication Method | service principal|
    | Tenant ID | This is automatically populated|
    | service principal ID | This is the Application (Client ID/App ID) of the Service principal|
    | Key Vault Connection| Select the Key Vault Connection created in the previous step|
    | Secret Name | Type in the name of the secret in the Key Vault (`service-principal-secret`)|  

    :::image type="content" source="../images/purview-credential-values.png" alt-text="Screenshot that shows the new credentials form with values highlighted.":::

## Registering Data Sources

At this point, Purview has visibility of the service principal. We can now proceed with registering and setting up the data sources.

### Register ADLS

 Gen 2 Storage Accounts

The following steps outline the process to register an ADLS Gen 2 Storage account.

1. In the Purview interface, select the **Data Map** option, and then select **Register**.
  
    :::image type="content" source="../images/data-map-register.png" alt-text="Screenshot that shows the data map button highlighted in Purview.":::

1. Select **ADLS Gen 2**, and then select **Continue**.

    :::image type="content" source="../images/register-adls.png" alt-text="Screenshot that shows the Azure Data Lake Storage Gen 2 registration source.":::

1. Fill in the values for all the fields

    | Field| Suggested Value(s)  |
    |:-------|:--------------------|
    | Name| `<DLZ-prefix>dldevraw` (or another suitable name)|
    | Azure Subscription | Select the subscription hosting the storage account|
    | Storage account Name| Select the relevant storage account|
    | Endpoint|  This should be automatically populated based on the selected storage account|
    | Select a collection | Select the root collection.|  

    :::image type="content" source="../images/purview-register-add-raw.png" alt-text="Screenshot of the Register ADLS form with values highlighted.":::

1. Click **Register** to create the data source.

Repeat steps 1 through 3 for the remaining storage accounts: 

- `<DMLZ-prefix>devencur`
- `<DMLZ-prefix>devwork`

### Register the Azure SQL database as a data source

1. In the Purview interface, select the **Data Map** option and then **Register**

    :::image type="content" source="../images/data-map-register.png" alt-text="Screenshot that shows the data map button highlighted in the Purview interface.":::

1. Select **SQL Database** and select **Continue**
  
    :::image type="content" source="../images/register-sql-db.png" alt-text="Screenshot that shows the Azure SQL Database registration source.":::

1. On the next screen, provide the following values and select **Register**

    | Field| Suggested Value(s)  |
    |:-------|:--------------------|
    | Name|`SQLDatabase` (the name of the database created in "Create Azure SQL Db's" step)|
    | Subscription| the subscription hosting the database|
    | Server name|the SQL Server name to register -- _`DPprefix`_-dev-sqlserver001|
  
     :::image type="content" source="../images/purview-sql-server-name.png" alt-text="Screenshot of the Register SQL database form with values highlighted.":::

## Set up scans

### Scan the Azure Data Lake Service Gen 2 data source

1. Navigate to the Purview data map and select **New Scan** on the data source
  
    :::image type="content" source="../images/scan-data-lake-1.png" alt-text="Screenshot that shows how to set up a new ADLS scan.":::

1. Specify the following values in the resulting screen

    | Field | Suggested Value(s)  |
    |:-------|:--------------------|
    | Scan Name | `Scan_<DLZ-prefix>devraw` |
    | Connect via Integration Runtime | Select the Self Hosted Integration run time deployed as part of the data landing zone. |
    | Credential | Select the service principal set up for Purview. |

    :::image type="content" source="../images/datalake-add-scan-credential.png" alt-text="Screenshot of the scan ADLS credential form with values entered.":::

1. Select **Test Connection** to verify the connectivity and permissions are in place, and select **Continue**.

1. In the Scope your Scan screen, select the entire storage account as the scope for the scan. Click **Continue**.

    :::image type="content" source="../images/scan-data-lake-file-system.png" alt-text="Screenshot of the scope your scan screen with storage accounts selected.":::

1. In the Select a Scan Rule Set screen, select the **ADLS Gen 2 Scan Rule set**. Click **Continue**.

    :::image type="content" source="../images/scan-data-lake-select-rule-set.png" alt-text="Screenshot that shows the ADLS scan rule set selection.":::

1. In the Set a Scan Trigger screen, select **Once**. Click **Continue**.
  
    :::image type="content" source="../images/scan-data-lake-set-trigger.png" alt-text="Screenshot that shows the set a scan Trigger screen with once selected.":::

1. In the final screen, review the scan settings and select **Save and Run**.

    :::image type="content" source="../images/scan-data-lake-review-save.png" alt-text="Screenshot that shows how to review your scan before saving.":::

Repeat steps 1 through 6 for the remaining storage accounts

- `<DMLZ-prefix>devencur`
- `<DMLZ-prefix>devwork`

### Scan the SQL DB Data Source

1. Select the **New Scan** icon on the Azure SQL DB data source.

    :::image type="content" source="../images/scan-database.png" alt-text="Screenshot that shows how to set up a new SQL database scan.":::

1. Provide the following values and select **Test Connection** to ensure the connectivity and permissions are correct. Select **Continue**

    | Field| Suggested Value(s)  |
    |:-------|:--------------------|
    | Name |`Scan_Database001`|
    | Connect via: |Purview-SHIR|
    | Database name| Select the database name.|
    | Credential|select the key vault credential created in Purview.|
    | Lineage extraction |off|
  
    :::image type="content" source="../images/scan-database-credentials.png" alt-text="Screenshot of the scan credential form with values entered.":::

1. Select the scope for the scan. You can leave this as is to scan the entire database.

    :::image type="content" source="../images/scan-database-selections.png" alt-text="Screenshot that shows how to set the scope for the scan to the whole database.":::

1. Select **AzureSQLDatabase** as the scan rule set.
  
    :::image type="content" source="../images/scan-database-ruleset.png" alt-text="Screenshot that shows the SQL database scan rule set selection.":::

1. Select **Once** for the Scan Trigger and select **Continue**.
  
    :::image type="content" source="../images/scan-set-trigger.png" alt-text="Screenshot that shows the set a scan to run screen with once selected.":::

1. Review the scan parameters and select **Save and run** to start the scan.

Repeat steps 1 through 6 for the **AdatumERP** database

You now have Purview setup completed for data governance of registered data sources. Proceed to the next step.

## Copy SQL DB data to ADLS using Azure Data Factory

On the following steps you will use the Copy Data tool from Azure Data Factory (ADF) to create a pipeline to copy the tables from the Azure SQL Databases AdatumCRM and AdatumERP into .csv files in the `<DLZ-prefix>devraw` Azure Data Lake storage (ADLS).

### Setup Private Endpoints

As the environment is locked to public access, you need to first log into the Azure portal on your local browser and connect to the bastion host virtual machine to be able to access the required Azure services using private endpoints:

1. On the resource group `<DMLZ-prefix>-dev-bastion` select `<DMLZ-prefix>-dev-vm001`.

    :::image type="content" source="../images/bastion-vm.png" alt-text="Screenshot that shows the resource groups for connecting to the bastion host virtual machine.":::

1. Select Connect -> Bastion

    :::image type="content" source="../images/bastion-vm-connect.png" alt-text="Screenshot that shows the connect to bastion selection screen.":::

1. Enter the VM's Username and Password and select **Connect**.

    :::image type="content" source="../images/bastion-vm-connect-password.png" alt-text="Screenshot that shows the username and password entry screen.":::

1. On the VM's web browser, open the Azure portal and go to the resource group `<DLZ-prefix>-dev-shared-integration`, open Azure Data Factory `<DLZ-prefix>-dev-integration-datafactory001`

    :::image type="content" source="../images/adf-shared-integration.png" alt-text="Screenshot that shows how to go to a different resource group to open Azure Data Factory.":::

1. Under the "Getting started" section select "Open Azure Data Factory Studio" as shown on the image below:

    :::image type="content" source="../images/getting-started-adf-studio.png" alt-text="Screenshot that shows how to open Azure Data Factory Studio.":::

1. On the ADF Studio interface select the "Manage" icon on the left hand side menu (the fourth icon from the top - the one that looks like a square toolbox with a wrench stamped on it), then select the "Managed private endpoints" option to create/approve the private endpoints necessary to connect Azure Data Factory to other secured Azure services.

    Note that when you approve the requests (more on that later) they will show as "Approved" as on the example you see on the image below for the storage account `<DLZ-prefix>devencur`.

    :::image type="content" source="../images/managed-private-endpoints.png" alt-text="Screenshot that shows how to go to the Manage Private Endpoints screen.":::

1. Before approving the private endpoint connections listed above, **select "+ New" and type "azure sql" to filter the Azure SQL Database connector** you will use to create a new managed private endpoint for SQL Server: `<DP-prefix>-dev-sqlserver001`. This is the server which contains Azure SQL Databases AdatumCRM and AdatumERP that we created on earlier steps.

1. **Name the Private Endpoint:** "dataproduct-dev-sqlserver001" as depicted on the image below. **Confirm** that you selected the SQL Server: `<DP-prefix>-dev-sqlserver001`, otherwise you will not be able to connect to it from this Data Factory on upcoming steps.

    :::image type="content" source="../images/managed-private-endpoints-sql-server.png" alt-text="Screenshot that shows how to name the new Private Endpoint.":::

> [!NOTE]
>To approve ADF to access the private endpoints of these services, here are a couple of options:
>
>**Option 1**: On each of the services that you request access to, you need to go to the "networking" or to "private endpoint connections" option of that service on the Azure portal to approve these private endpoint access requests.
>
>**Option 2**: Run the scripts below using the Azure Cloud Shell in Bash mode and approve all the required private endpoints at once.

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

Here is an example of how this storage account `<DLZ-prefix>devraw` manages private endpoint access requests. Select "Networking", and then on the "Private endpoint connections" tab as highlighted in red on the image below:

:::image type="content" source="../images/private-endpoint-connections.png" alt-text="Screenshot that shows how to go to the Private Endpoint Connections page.":::

And here is an example of how to approve a private endpoint access request by selecting in "Private endpoint connections". The interface is slightly different, but you also have the option to first select the request in "Pending" state and select "Approve" as depicted on the image below for the Azure SQL Server `<DLZ-prefix>-dev-sqlserver001`:

:::image type="content" source="../images/private-endpoint-connections-sql.png" alt-text="Screenshot that shows to to approve a private Endpoint access request.":::

> [!NOTE]
>After you approve the request at each of the services, it might take a few minutes for the request to show as "Approved" on the "Managed private endpoints" pane back in Data Factory Studio. (even if you press "Refresh", the approval state might be stale for some time).

When you are done with all approvals, the "Managed private endpoints" pane should look similar to this, with all the approval state fields marked as "Approved":

:::image type="content" source="../images/managed-private-endpoints-complete.png" alt-text="Screenshot that shows Private Endpoint SQL Connections as Approved.":::

### Role assignments

- After completing the Endpoint approvals, it is now necessary to add the appropriate role permissions (credentials) for Data Factory to access:
  - Azure SQL Databases AdatumCRM and AdatumERP in Azure SQL Server `<DP-prefix>-dev-sqlserver001`,
  - Storage Accounts `<DLZ-prefix>devraw`, `<DLZ-prefix>devencur`and `<DLZ-prefix>devwork`.
  - Purview account `<DMLZ-prefix>-dev-purview001`

#### Azure SQL Server

1. Lets start with Azure SQL Server. **Navigate** to `<DP-prefix>-dev-sqlserver001` in the resource group  `<DMLZ-prefix>-dev-dp001`.  

1. Click **"Access Control (IAM)"**, then Select the **"+ Add" button** circled in red as depicted on the image below, and then select **"Add role assignment"** from the dropdown menu.

    :::image type="content" source="../images/add-role-to-sql-server.png" alt-text="Screenshot that shows how to get to the add role assignment page in Azure SQL Server.":::

1. Select **"Contributor"** and select **Next**.

    :::image type="content" source="../images/add-role-to-contributor.png" alt-text="Screenshot that shows the Contributor role selection screen.":::

1. On the "Members" tab, Select **"Managed Identity"** and then select **Select Members"** to open the "select managed identities" pane on the right hand side of the screen, as depicted on the image below:

    :::image type="content" source="../images/add-role-to-managed-identities.png" alt-text="Screenshot of the select Managed Identity Members screen.":::

1. Also depicted on the image above you will see that you need to select the **subscription** and the **"Data Factory (V2)"** to be able to list the available Data Factories. On the options that will be listed by name, select **Azure Data Factory `<DLZ-prefix>-dev-integration-datafactory001`**

1. After you select **Select** the screen will look similar to the one below, where you will just need to select **twice** on **"Review and Assign"** to complete this process:

    :::image type="content" source="../images/add-role-to-sql-server-review-assign.png" alt-text="Screenshot that shows the role assignment completion screen.":::

#### Storage Accounts

1. Now lets assign the appropriate roles to the storage accounts `<DLZ-prefix>devraw`, `<DLZ-prefix>devencur`and `<DLZ-prefix>devwork`.

1. Follow the same steps as you just did for the Azure SQL Server role assignment. This time, select **"Storage Blob Data Contributor"** instead of selecting the  **"Contributor"** role.

1. After assigning the permissions to all three storage accounts, Data Factory will be able to connect and access the storage accounts to complete upcoming lab steps.

#### Purview

The last step on adding role assignments is to add the **"Purview Data Curator"** role in Purview to the managed identity account of the Azure Data Factory `<DLZ-prefix>-dev-integration-datafactory001`. These steps will allow Data Factory to send data catalog assets information from multiple data sources to the Purview account.

1. Go to the Purview account `<DMLZ-prefix>-dev-purview001` in the resource group `<DMLZ-prefix>-dev-governance`, select **Open Purview Studio**.

1. In Purview Studio, select **Data Map**, then **Collections**.

1. On the right pane select **Role assignments** and find **Data curators**.

1. Add the managed identity for `<DLZ-prefix>-dev-integration-datafactory001` as you see on the image below:

    :::image type="content" source="../images/purview-role-assignment.png" alt-text="Screenshot of how to add data curators to your Purview role assignment.":::

### Connect Data Factory to Purview

The permissions are set, Purview can now see the Data Factory, and the next step now is to have `<DMLZ-prefix>-dev-purview001` connecting to `<DLZ-prefix>-dev-integration-datafactory001`.

1. Open **Purview Studio**, select **Management**, select **Data Factory**, and create a Data Factory connection by selecting on **New**. Select Data Factory `<DLZ-prefix>-dev-integration-datafactory001` and select ok.

1. Here is how the setting should look like while selecting the new connection:
  
    :::image type="content" source="../images/connect-purview-to-data-factory.png" alt-text="Screenshot of what the Purview studio screen looks like while selecting a new connection.":::

1. In the `<DLZ-prefix>-dev-integration-datafactory001` Data Factory Studio, refresh the **Azure Purview account** under **Manage>Azure Purview.** and the "Data Lineage - Pipeline" will show the green icon **"Connected"** as depicted on the image below:

    :::image type="content" source="../images/data-factory-purview-connection.png" alt-text="Screenshot of the Azure Data Factory Purview account screen with the data lineage pipeline connected.":::

### Create ETL Pipeline

Now that the  `<DLZ-prefix>-dev-integration-datafactory001` has the required access permissions you will create a copy activity in Azure Data Factory to move data from Azure SQL Databases to the raw Storage Account `<DLZ-prefix>devraw`.

#### Copy Data tool - AdatumCRM

This process will extract "Customer" data from the AdatumCRM Azure SQL Database into Azure Data Lake Storage.

1. In Data Factory Studio, on the **Author** section, select the plus sign (+) under **Factory Resources** and select **Copy Data tool** from the context menu as shown on the picture below.

    :::image type="content" source="../images/copy-data-tool.png" alt-text="Screenshot of the Copy Data tool under factory resources.":::

    Follow each step on the Copy Data tool wizard:

1. Select **Schedule** to create a trigger to run the pipeline every 24 hours.

    :::image type="content" source="../images/create-pipeline.png" alt-text="Screenshot that shows how to schedule a Trigger to run periodically in CRM.":::

1. Select **New Connection** to create a Linked Service to connect this data factory to the Azure SQL Database AdatumCRM on server `<DP-prefix>-dev-sqlserver001` (source)

    :::image type="content" source="../images/adatum-crm-connection.png" alt-text="Screenshot that shows how to connect to Adatum CRM.":::

    > [!NOTE]
    >If you have any errors connecting or accessing the data in the Azure SQL Databases, or the storage accounts, please review permissions and make sure that the Data Factory has the appropriate credentials and access permissions to any problematic resource.

1. Select these three tables:

    - SalesLT.Address
    - SalesLT.Customer
    - SalesLT.CustomerAddress

    :::image type="content" source="../images/adatum-crm-tables.png" alt-text="Screenshot of the select tables screen with tables highlighted.":::

1. Create a new Linked Service to access the `<DLZ-prefix>devraw` Azure Data Lake Storage Gen2. (destination)

    :::image type="content" source="../images/raw-storage-connection.png" alt-text="Screenshot that shows the raw storage connection.":::

1. Browse the folders in the `<DLZ-prefix>devraw` storage and select "data" as the destination.

    :::image type="content" source="../images/raw-data-folder.png" alt-text="Screenshot that shows the destination as raw data.":::

1. Change the "File name suffix" to .csv and leave the other options as default.

    :::image type="content" source="../images/destination-data-source.png" alt-text="Screenshot that shows the file name suffix field with CSV entered.":::

1. Go to the next screen and select "Add header to file".

    :::image type="content" source="../images/add-header-to-file.png" alt-text="Screenshot that shows how to add a header to a file.":::

1. Finish the wizard with a screen similar to this one:

    :::image type="content" source="../images/copy-datatool-crm-complete.png" alt-text="Screenshot that shows the copy Data Tool deployment completed.":::

When you are done with the wizard, it will show under Pipelines the new pipeline you just created.

#### Pipeline

- Rename the pipeline and the Datasets to the names you see on the image below, publish all, then run the Trigger to have the three tables copied from SQL DB to ADLS.

    :::image type="content" source="../images/trigger-run-crm.png" alt-text="Screenshot that shows how to use the trigger tool to copy data from the SQL Database to ADLS.":::

This process you just finished will create three .csv files in the "data\CRM" folder, one for each of the selected tables of database AdatumCRM.

#### Copy Data tool - AdatumERP

Now lets extract the data from the AdatumERP Azure SQL Database representing the sales data coming from the ERP system.

1. Still in ADF Studio, create a new pipeline using the Copy Data Tool again, this time to send the sales data from AdatumERP to the `[DLZprefix]devraw` storage account data folder, the same way you did with the CRM data.

    - Follow the same steps as in item 5, this time using Azure SQL Database AdatumERP as the source.

    - Create the schedule to trigger every hour as well.

    - Linked Service to Azure SQL DB name: AdatumERP.

    :::image type="content" source="../images/adatum-erp-connection.png" alt-text="Screenshot of the Adatum ERP Connection form completed.":::

1. Select tables: SalesLT.Product, SalesLT.ProductCategory, SalesLT.ProductDescription, SalesLT.ProductModel, SalesLT.ProductModelProductDescription, SalesLT.SalesOrderDetail, SalesLT.SalesOrderHeader.

    :::image type="content" source="../images/adatum-erp-tables.png" alt-text="Screenshot of Adatum ERP Table options.":::

1. Use the already created Linked Service to the `[DLZprefix]devraw` storage account, set the file extension to .csv.

    :::image type="content" source="../images/destination-data-source.png" alt-text="Screenshot that shows a raw storage account with the file extension set to csv.":::

1. Select Add header to file.

    :::image type="content" source="../images/add-header-to-file.png" alt-text="Screenshot that shows how to add a header to a file under file format settings.":::

1. Finish the wizard for the second time, rename the pipeline to CopyPipeline_ERP_to_DevRaw, publish all, then run the trigger on this newly created pipeline, to have the seven tables you selected copied from SQL DB to ADLS.

After finishing these steps, there will be ten .csv files in Azure Data Lake storage `<DLZ-prefix>devraw`. You can now proceed to the next step to start curating the files in the `<DLZ-prefix>devencur` Data Lake.

## Curate data in ADLS

### Curate data

After finishing the creation of the ten _.csv_ files in the "raw" `<DLZ-prefix>devraw` Data Lake storage, in this step you will transform these files as needed as you copy them to the "Curated" `<DLZ-prefix>devencur` Data Lake storage.

Continue using Azure Data Factory to create these new pipelines to orchestrate this data movement.

### CRM to customer

With this Data flow that you are about to create you will get the .csv files in the Data\CRM folder in `<DLZ-prefix>devraw` transform them and copy the transformed files to folder "Data\Customer" in `<DLZ-prefix>devencur` in .parquet format.

Here are the steps:

1. On the home page of Azure Data Factory, select Orchestrate.

    :::image type="content" source="../images/select-orchestrate.png" alt-text="Screenshot that shows the orchestrate button on the Azure Data Factory home page.":::

1. In the General tab for the pipeline, name it "Pipeline_transform_CRM".

1. In the Activities pane, expand the Move and Transform accordion. Drag and drop the Data Flow activity from the pane to the pipeline canvas.

    :::image type="content" source="../images/activities.png" alt-text="Screenshot that shows the activities pane with move and transform highlighted.":::

1. In the Adding Data Flow pop-up, select Create new Data flow and then name your data flow "CRM_to_Customer". Click Finish when done.

    > [!NOTE]
    >In the top bar of the pipeline canvas, slide the Data flow debug slider on. Debug mode allows for interactive testing of transformation logic against a live Spark cluster. Data Flow clusters take 5-7 minutes to warm up and users are recommended to turn on debug first if they plan to do Data Flow development.

    :::image type="content" source="../images/data-flow-debug.png" alt-text="Screenshot of the Open Data Flow button.":::

1. When you are finished selecting all the options in the Data flow "CRM_to_Customer", the pipeline "Pipeline_transform_CRM" will look like this:

    :::image type="content" source="../images/pipelines-transform-crm.png" alt-text="Screenshot that shows how the Pipeline transform CRM looks.":::

    and the Data flow will look like this:

    :::image type="content" source="../images/crm-to-customer.png" alt-text="Screenshot that shows how the CRM to Customer data flow looks.":::

These are the settings you need to modify in the Data Flow when manipulating these files:

For the source "CRMAddress":

- Create a new dataset from "Azure Data Lake Storage Gen2" with format "DelimitedText" and call it "DevRaw_CRM_Address"
- Connect to the linked service to `<DLZ-prefix>devraw`
- Select file Data\CRM\SalesLTAddress.csv as the source.

And for it's pair, the sink "CustAddress":

- Create a new dataset called DevEncur_Cust_Address
- Select file Data\Customer\ in `<DLZ-prefix>devencur` as the sink.
- Convert the file to "Address.parquet" (under "Settings\Output to single file").

> [!NOTE]
>For the rest of the Data flow configuration, use the information on the table below for each component. Note that CRMAddress and CustAddress are the first two rows. Use them as an example for the other objects.
>
>There is one item that is not on the table, which is the "RemovePasswords" Select Schema Modifier. As you can see on the picture of the Data flow "CRM_to_Customer" this goes in between "CRMCustomer"
and "CustCustomer". When you add this Select, go to "Select settings" and remove fields "PasswordHash" and "PasswordSalt".
>
>"CRMCustomer" brings back a schema with 15 columns from the .crv file, and "CustCustomer" will write only 13 columns after the Select Schema Modifier removes the two password columns.

#### Complete table

| Name | Object Type | Dataset Name | Data Store | Format Type | Linked Service | File or Folder |
|---|---|---|---|---|---|---|
| CRMAddress | source | DevRaw_CRM_Address | Azure Data Lake Storage Gen2 | DelimitedText | devraw | Data\CRM\SalesLTAddress.csv |
| CustAddress | sink | DevEncur_Cust_Address | Azure Data Lake Storage Gen2 | Parquet | devencur | Data\Customer\Address.parquet |
| CRMCustomer | source | DevRaw_CRM_Customer | Azure Data Lake Storage Gen2 | DelimitedText | devraw | Data\CRM\SalesLTCustomer.csv |
| CustCustomer | sink | DevEncur_Cust_Customer | Azure Data Lake Storage Gen2 | Parquet | devencur | Data\Customer\Customer.parquet |
| CRMCustomerAddress | source | DevRaw_CRM_CustomerAddress | Azure Data Lake Storage Gen2 | DelimitedText | devraw | Data\CRM\SalesLTCustomerAddress.csv |
| CustCustomerAddress | sink | DevEncur_Cust_CustomerAddress | Azure Data Lake Storage Gen2 | Parquet | devencur | Data\Customer\CustomerAddress.parquet |

### ERP to Sales

Now repeat similar steps and create pipeline "Pipeline_transform_ERP", create a Data flow "ERP_to_Sales" to transform the .csv files in the Data\ERP folder in `<DLZ-prefix>devraw` and copy the transformed files to folder "Data\Sales" in `<DLZ-prefix>devencur`

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
