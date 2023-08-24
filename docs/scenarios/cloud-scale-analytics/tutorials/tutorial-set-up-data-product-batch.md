---
title: Tutorial - Set up a data product batch
description: Learn how to set up a data product batch for data integration, data orchestration, and data governance.
author: abdale
ms.author: hamoodaleem
ms.date: 07/18/2022
ms.topic: tutorial
ms.custom: e2e-data-management, think-tank, devx-track-azurecli
---

# Tutorial: Set up a data product batch

In this tutorial, learn how to set up data product services that are already deployed. Use Azure Data Factory to integrate and orchestrate your data, and use Microsoft Purview to discover, manage, and govern data assets.

Learn how to:

> [!div class="checklist"]
>
> - Create and deploy required resources
> - Assign roles and access permissions
> - Connect resources for data integration

This tutorial helps you become familiar with the services that are deployed in the `<DMLZ-prefix>-dev-dp001` sample data product resource group. Experience how the Azure services interface with each other and what security measures are in place.

As you deploy the new components, you'll have a chance to investigate how Purview connects service governance to create a holistic, up-to-date map of your data landscape. The result is automated data discovery, sensitive data classification, and end-to-end data lineage.

## Prerequisites

Before you begin setting up your data product batch, make sure you meet these prerequisites:

- **Azure subscription.** If you don't have an Azure subscription, [create your Azure free account today](https://azure.microsoft.com/free/).

- **Permissions to the Azure subscription.** To set up Purview and Azure Synapse Analytics for the deployment, you must have the [User Access Administrator](/azure/role-based-access-control/built-in-roles#user-access-administrator) role or the [Owner](/azure/role-based-access-control/built-in-roles#owner) role in the Azure subscription. You'll set more role assignments for services and service principals in the tutorial.

- **Deployed resources.** To complete the tutorial, these resources must already be deployed in your Azure subscription:

  - *Data management landing zone.* For more information, see the [data management landing zone](https://github.com/Azure/data-management-zone) GitHub repository.
  - *Data landing zone.* For more information, see the [data landing zone](https://github.com/Azure/data-landing-zone) GitHub repository.
  - *Data product batch.* For more information, see the [data product batch](https://github.com/Azure/data-product-batch) GitHub repository.

- **Microsoft Purview account.** The account is created as part of your data management landing zone deployment.

- **Self-hosted integration runtime.** The runtime is created as part of your data landing zone deployment.

> [!NOTE]
> In this tutorial, placeholders refer to prerequisite resources you deploy before you begin the tutorial:
>
> - `<DMLZ-prefix>` refers to the prefix you entered when you created your *data management landing zone* deployment.
> - `<DLZ-prefix>` refers to the prefix you entered when you created your *data landing zone* deployment.
> - `<DP-prefix>` refers to the prefix you entered when you created your *data product batch* deployment.

### Create Azure SQL Database instances

To begin this tutorial, create two sample SQL Database instances. You'll use the databases to simulate CRM and ERP data sources in later sections.

1. In the [Azure portal](https://portal.azure.com/), in the portal global controls, select the **Cloud Shell** icon to open an Azure Cloud Shell terminal. Select **Bash** for the terminal type.

    :::image type="content" source="../images/cloud-shell.png" alt-text="Screenshot that shows the Cloud Shell icon in the Azure portal.":::

1. In Cloud Shell, run the following script. The script finds the `<DLZ-prefix>-dev-dp001` resource group and the `<DP-prefix>-dev-sqlserver001` Azure SQL server that's in the resource group. Then, the script creates the two SQL Database instances on the `<DP-prefix>-dev-sqlserver001` server. The databases are prepopulated with AdventureWorks sample data. The data includes the tables you use in this tutorial.

    Make sure you replace the `subscription` parameter placeholder value with your own Azure subscription ID.

    ```bash
    # Azure SQL Database instances setup
    # Create the AdatumCRM and AdatumERP databases to simulate customer and sales data.

    # Use the ID for the Azure subscription you used to deployed the data product.
    az account set --subscription "<your-subscription-ID>"

    # Get the resource group for the data product.
    resourceGroupName=$(az group list -o tsv  --query "[?contains(@.name, 'dp001')==\`true\`].name")

    # Get the existing Azure SQL Database server name.
    sqlServerName=$(az sql server list -g $resourceGroupName -o tsv  --query "[?contains(@.name, 'sqlserver001')==\`true\`].name")

    # Create the first SQL Database instance, AdatumCRM, to create the customer's data source.
    az sql db create --resource-group $resourceGroupName --server $sqlServerName --name AdatumCRM --service-objective Basic --sample-name AdventureWorksLT

    # Create the second SQL Database instance, AdatumERP, to create the sales data source.
    az sql db create --resource-group $resourceGroupName --server $sqlServerName --name AdatumERP --service-objective Basic --sample-name AdventureWorksLT
    ```

When the script is finished running, on the `<DP-prefix>-dev-sqlserver001` Azure SQL server, you have two new SQL Database instances, `AdatumCRM` and `AdatumERP`. Both databases are on the Basic compute tier. The databases are located in the same `<DLZ-prefix>-dev-dp001` resource group you used to deploy the data product batch.

## Set up Purview to catalog the data product batch

Next, complete the steps to set up Purview to catalog the data product batch. You begin by creating a service principal. Then, you set up required resources and assign roles and access permissions.

### Create a service principal

1. In the [Azure portal](https://portal.azure.com/), in the portal global controls, select the **Cloud Shell** icon to open an Azure Cloud Shell terminal. Select **Bash** for the terminal type.

1. Revise the following script:

   - Replace the `subscriptionId` parameter placeholder value with your own Azure subscription ID.
   - Replace the `spname` parameter placeholder value with the name you want to use for your service principal. The service principal name must be unique in the subscription.

   After you update the parameter values, run the script in Cloud Shell.

    ```bash
    # Replace the parameter values with the name you want to use for your service principal name and your Azure subscription ID.
    spname="<your-service-principal-name>"
    subscriptionId="<your-subscription-id>"

    # Set the scope to the subscription.
    scope="/subscriptions/$subscriptionId"

    # Create the service principal.
    az ad sp create-for-rbac \
      --name $spname \
      --role "Contributor" \
      --scope $scope
    ```

1. Check the JSON output for a result that's similar to the following example. *Note or copy the values in the output to use in later steps*.

    ```json
    {
      "appId": "<your-app-id>",
      "displayName": "<service-principal-display-name>",
      "name": "<your-service-principal-name>",
      "password": "<your-service-principal-password>",
      "tenant": "<your-tenant>"
    }
    ```

### Set up service principal access and permissions

From the JSON output generated in the preceding step, get the following returned values:

- service principal ID (`appId`)
- service principal key (`password`)

The service principal must have the following permissions:

- Storage Blob Data Reader role on the storage accounts.
- Data Reader permissions on the SQL Database instances.

To set up the service principal with the required role and permissions, complete the following steps.

### Azure Storage account permissions

1. In the Azure portal, go to the `<DLZ-prefix>devraw` Azure Storage account. In the resource menu, select **Access Control (IAM)**.

   :::image type="content" source="../images/storage-service-principal-permissions.png" alt-text="Screenshot that shows the storage account service principal permissions pane, with Access Control highlighted.":::

1. Select **Add** > **Add role assignment**.

   :::image type="content" source="../images/storage-service-principal-access-control.png" alt-text="Screenshot that shows the storage account service principal Access Control pane that shows how to add a role assignment.":::

1. In **Add role assignment**, on the **Role** tab, search for and select **Storage Blob Data Reader**. Then, select **Next**.

   :::image type="content" source="../images/storage-service-principal-role-assignment.png" alt-text="Screenshot that shows searching for Storage Blob Data Reader under Add role assignment.":::

1. In **Members**, choose **Select members**.

    :::image type="content" source="../images/storage-service-principal-members.png" alt-text="Screenshot that shows select members pane under add role assignment.":::

1. In **Select members**, search for the name of the service principal you created.

    :::image type="content" source="../images/add-service-principal.png" alt-text="Screenshot that shows how to search for a service principal name.":::

1. In the search results, select the service principal, and then choose **Select**.

    :::image type="content" source="../images/select-service-principal.png" alt-text="Screenshot that shows the results pane after searching for a service principal name.":::

1. To complete the role assignment, select **Review + assign** twice.

Repeat the steps in this section for the remaining storage accounts:

- `<DLZ-prefix>devencur`
- `<DLZ-prefix>devwork`

### SQL Database permissions

To set SQL Database permissions, you connect to the Azure SQL virtual machine by using the query editor. Because all the resources are behind a private endpoint, you must first sign in to the Azure portal by using an Azure Bastion host virtual machine.

In the Azure portal, connect to the virtual machine that's deployed in the `<DMLZ-prefix>-dev-bastion` resource group. If you're not sure how to connect to the virtual machine by using the Bastion host service, see [Connect to a VM](/azure/bastion/tutorial-create-host-portal#connect).

To add the service principal as a user in the database, you might first need to add yourself as the Azure Active Directory admin. In steps 1 and 2, you add yourself as the Azure Active Directory admin. In steps 3 to 5, you give the service principal permissions to a database. When you're signed in to the portal from the Bastion host virtual machine, search for Azure SQL virtual machines in the Azure portal.

1. Go to the `<DP-prefix>-dev-sqlserver001` Azure SQL virtual machine. In the resource menu under **Settings**, select **Azure Active Directory**.

   :::image type="content" source="../images/azure-sql-admin-active-directory.png" alt-text="Screenshot that shows the Azure Active Directory pane in Azure SQL Database Server.":::

1. In the command bar, select **Set admin**. Search for and select your own account. Choose **Select**.

   :::image type="content" source="../images/set-sql-server-admin.png" alt-text="Screenshot that shows how to search for an account to make a user an admin.":::

1. In the resource menu, select **SQL databases**, and then select the `AdatumCRM` database.

   :::image type="content" source="../images/database-query-editor.png" alt-text="Screenshot that shows a search for the correct database, with AdatumCRM highlighted.":::

1. In the **AdatumCRM** resource menu, select **Query editor (preview)**. Under **Active Directory authentication**, select the **Continue as** button to sign in.

   :::image type="content" source="../images/query-editor.png" alt-text="Screenshot that shows how to sign in to the query editor by using Active Directory authentication.":::

1. In the query editor, revise the following statements to replace `<service principal name>` with the name of the service principal you created (for example, `purview-service-principal`). Then, run the statements.

   ```sql

   CREATE USER [<service principal name>] FROM EXTERNAL PROVIDER
   GO

   EXEC sp_addrolemember 'db_datareader', [<service principal name>]
   GO

   ```

   :::image type="content" source="../images/azure-sql-add-service-principal.png" alt-text="Screenshot that shows how to execute statements in the query editor.":::

Repeat steps 3 to 5 for the `AdatumERP` database.

### Set up the key vault

Purview reads the service principal key from an instance of Azure Key Vault. The key vault is created in your data management landing zone deployment. The following steps are required to set up the key vault:

1. Add the service principal key to the key vault as a secret.

1. Give the Purview MSI Secrets Reader permissions in the key vault.

1. Add the key vault to Purview as a key vault connection.

1. Create a credential in Purview that points to the key vault secret.

#### Add permissions to add secret to the key vault

1. In the Azure portal, go to the Azure Key Vault service. Search for the `<DMLZ-prefix>-dev-vault001` key vault.

     :::image type="content" source="../images/key-vault-search.png" alt-text="Screenshot that shows the Access Control Key Vault pane.":::

1. In the resource menu, select **Access control (IAM)**. In the command bar, select **Add**, and then select **Add role assignment**.

    :::image type="content" source="../images/purview-key-vault-role.png" alt-text="Screenshot that shows adding a role assignment in Purview.":::

1. On the **Role** tab, search for and then select **Key Vault Administrator**. Select **Next**.

    :::image type="content" source="../images/purview-key-vault-administrator.png" alt-text="Screenshot that shows how to search for the Key Vault Administrator role.":::

1. In **Members**, choose **Select members** to add the account that's currently signed in.

    :::image type="content" source="../images/key-vault-administrator-select-member.png" alt-text="Screenshot that shows the Select members button highlighted.":::

1. In **Select members**, search for the account that's currently signed in. Select the account, and then choose **Select**.

    :::image type="content" source="../images/key-vault-select-user.png" alt-text="Screenshot that shows the select member search box.":::

1. To complete the role assignment process, select **Review + assign** twice.

#### Add a secret to the key vault

Complete the following steps to sign in to the Azure portal from the Bastion host virtual machine.

1. In the `<DMLZ-prefix>-dev-vault001` key vault resource menu, select **Secrets**. In the command bar, select **Generate/Import** to create a new secret.

    :::image type="content" source="../images/key-vault-add-secret.png" alt-text="Screenshot that shows the key vault Generate/Import button highlighted.":::

1. In **Create a secret**, select or enter the following values:

    | Setting | Action |
    | --- | --- |
    | **Upload options** | Select **Manual**. |
    | **Name** | Enter *service-principal-secret*. |
    | **Value** | Enter the service principal password you created earlier. |

     :::image type="content" source="../images/key-vault-create-secret.png" alt-text="Screenshot that shows the key vault Create a secret pane.":::

      > [!NOTE]
      > This step creates a secret named `service-principal-secret` in the key vault by using the service principal password key. Purview uses the secret to connect to and scan the data sources. If you enter an incorrect password, you won't be able to complete the following sections.

1. Select **Create**.

#### Set up Purview permissions in the key vault

For the Purview instance to read the secrets that are stored in the key vault, you must assign Purview the relevant permissions in the key vault. To set the permissions, you add the Purview Managed Identity to the key vault Secrets Reader role.

1. In the `<DMLZ-prefix>-dev-vault001` key vault resource menu, select **Access control (IAM)**.

1. In the command bar, select **Add**, and then select **Add role assignment**.

    :::image type="content" source="../images/key-vault-add-role-assignment.png" alt-text="Screenshot that shows the Access Control pane, with the add role assignment button highlighted.":::

1. In **Role**, search for and select **Key Vault Secrets User**. Select **Next**.

    :::image type="content" source="../images/key-vault-secret-user-role.png" alt-text="Screenshot that shows the search for Key Vault Secret User pane.":::

1. In **Members**, choose **Select members**.

    :::image type="content" source="../images/key-vault-user-select-member.png" alt-text="Screenshot that shows the add role assignment pane with the select member button highlighted.":::

1. Search for the `<DMLZ-prefix>-dev-purview001` Purview instance. Select the instance to add the relevant account. Then, choose **Select**.

    :::image type="content" source="../images/key-vault-user-purview-managed.png" alt-text="Screenshot that shows the search box for the Purview instance name.":::

1. To complete the role assignment process, select **Review + assign** twice.

    :::image type="content" source="../images/key-vault-user-purview-managed-review-assign.png" alt-text="Screenshot that shows how to complete a role assignment.":::

#### Set up a key vault connection in Purview

To set up a key vault connection to Purview, you must sign in to the Azure portal by using an Azure Bastion host virtual machine.

1. In the Azure portal, go to the `<DMLZ-prefix>-dev-purview001` Purview account. Under **Getting started**, in **Open Microsoft Purview Governance Portal**, select **Open**.

    :::image type="content" source="../images/microsoft-purview-studio.png" alt-text="Screenshot that shows the Microsoft Purview account overview.":::

1. In Purview Studio, select **Management** > **Credentials**. In the **Credentials** command bar, select **Manage Key Vault connections**, and then select **New**.

    :::image type="content" source="../images/purview-key-vault-connections.png" alt-text="Screenshot that shows the Manage Key Vault connections button.":::

1. In **New key vault connection**, select or enter the following information:

    | Setting | Action |
    | --- | --- |
    | **Name** | Enter *\<DMLZ-prefix\>-dev-vault001*. |
    | **Azure Subscription** | Select the subscription that hosts the key vault. |
    | **Key Vault Name** | Select the **\<DMLZ-prefix\>-dev-vault001** key vault. |

    :::image type="content" source="../images/purview-key-vault-add-connection.png" alt-text="Screenshot that shows the new Key Vault connections pane.":::

1. Select **Create**.

1. In **Confirm granting access**, select **Confirm**.

#### Create a credential in Purview

The final step to set up key vault is to create a credential in Purview that points to the secret you created in the key vault for the service principal.

1. In Purview Studio, select **Management** > **Credentials**. In the **Credentials** command bar, select **New**.

    :::image type="content" source="../images/purview-add-credentials.png" alt-text="Screenshot that shows the new Purview Credentials pane.":::

1. In **New credential**, select or enter the following information:

    | Setting | Action |
    | --- | --- |
    | **Name** | Enter *purviewServicePrincipal*. |
    | **Authentication method** | Select **Service principal**. |
    | **Tenant ID** | The value is automatically populated. |
    | **Service principal ID** | Enter the application ID or client ID of the service principal. |
    | **Key Vault connection** | Select the key vault connection you created in the preceding section. |
    | **Secret name** | Enter the name of the secret in the key vault (*service-principal-secret*). |

    :::image type="content" source="../images/purview-credential-values.png" alt-text="Screenshot that shows the new credentials form, with values highlighted.":::

1. Select **Create**.

## Register data sources

At this point, Purview can connect to the service principal. Now you can register and set up the data sources.

### Register Azure Data Lake Storage Gen2 accounts

The following steps outline the process to register an Azure Data Lake Storage Gen2 storage account.

1. In Purview Studio, select the data map icon, select **Sources**, and then select **Register**.

    :::image type="content" source="../images/data-map-register.png" alt-text="Screenshot that shows the data map button highlighted in Purview.":::

1. In **Register sources**, select **Azure Data Lake Storage Gen2**, and then select **Continue**.

    :::image type="content" source="../images/register-data-lake.png" alt-text="Screenshot that shows the Azure Data Lake Storage Gen2 registration source.":::

1. In **Register sources (Azure Data Lake Storage Gen2)**, select or enter the following information:

    | Setting | Action |
    | --- | --- |
    | **Name** | Enter *\<DLZ-prefix\>dldevraw*. |
    | **Azure subscription** | Select the subscription that hosts the storage account. |
    | **Storage account name** | Select the relevant storage account. |
    | **Endpoint** |  The value is automatically populated based on the selected storage account. |
    | **Select a collection** | Select the root collection. |

    :::image type="content" source="../images/purview-register-add-raw.png" alt-text="Screenshot that shows the Register Azure Data Lake Storage Gen2 pane, with values highlighted.":::

1. Select **Register** to create the data source.

Repeat these steps for the following storage accounts:

- `<DMLZ-prefix>devencur`
- `<DMLZ-prefix>devwork`

### Register the SQL Database instance as a data source

1. In Purview Studio, select the **Data map** icon, select **Sources**, and then select **Register**.

    :::image type="content" source="../images/data-map-register.png" alt-text="Screenshot that shows the data map button highlighted in the Purview interface.":::

1. In **Register sources**, select **Azure SQL Database**, and then select **Continue**.

    :::image type="content" source="../images/register-sql-database.png" alt-text="Screenshot that shows the Azure SQL Database registration source.":::

1. In **Register sources (Azure SQL Database)**, select or enter the following information:

    | Setting | Action |
    | --- | --- |
    | **Name** | Enter *SQLDatabase* (the name of the database created in *Create Azure SQL Database instances*). |
    | **Subscription** | Select the subscription that hosts the database. |
    | **Server name** | Enter *\<DP-prefix\>-dev-sqlserver001*. |

     :::image type="content" source="../images/purview-sql-server-name.png" alt-text="Screenshot that shows the Register SQL Database form, with values highlighted.":::

1. Select **Register**.

## Set up scans

Next, set up scans for the data sources.

### Scan the Data Lake Storage Gen2 data source

1. In Purview Studio, go to the data map. On the data source, select the **New scan** icon.

    :::image type="content" source="../images/data-lake-new-scan.png" alt-text="Screenshot that shows how to set up a new Data Lake Storage Gen2 scan.":::

1. In the new scan pane, select or enter the following information:

    | Setting | Action |
    | --- | --- |
    | **Name** | Enter *Scan_\<DLZ-prefix\>devraw*. |
    | **Connect via integration runtime** | Select the self-hosted integration runtime that was deployed with the data landing zone. |
    | **Credential** | Select the service principal you set up for Purview. |

    :::image type="content" source="../images/data-lake-add-scan-credential.png" alt-text="Screenshot that shows the scan Data Lake Storage Gen2 credential form with values entered.":::

1. Select **Test connection** to verify the connectivity and that permissions are in place. Select **Continue**.

1. In **Scope your scan**, select the entire storage account as the scope for the scan, and then select **Continue**.

    :::image type="content" source="../images/scan-data-lake-file-system.png" alt-text="Screenshot that shows the Scope your scan pane with storage accounts selected.":::

1. In **Select a scan rule set**, select **AdlsGen2**, and then select **Continue**.

    :::image type="content" source="../images/scan-data-lake-select-rule-set.png" alt-text="Screenshot that shows the Data Lake Storage Gen2 scan rule set selection.":::

1. In **Set a scan trigger**, select **Once**, and then select **Continue**.

    :::image type="content" source="../images/scan-data-lake-set-trigger.png" alt-text="Screenshot that shows the set a scan Trigger pane, with Once selected.":::

1. In **Review your scan**, review the scan settings. Select **Save and Run** to start the scan.

    :::image type="content" source="../images/scan-data-lake-review-save.png" alt-text="Screenshot that shows reviewing your scan before you save and run it.":::

Repeat these steps for the following storage accounts:

- `<DMLZ-prefix>devencur`
- `<DMLZ-prefix>devwork`

### Scan the SQL Database data source

1. In the Azure SQL Database data source, select **New Scan**.

    :::image type="content" source="../images/scan-database.png" alt-text="Screenshot that shows how to create a new SQL Database scan.":::

1. In the new scan pane, select or enter the following information:

    | Setting | Action |
    | --- | --- |
    | **Name** | Enter *Scan_Database001*. |
    | **Connect via integration runtime** | Select **Purview-SHIR**. |
    | **Database name**| Select the database name. |
    | **Credential** | Select the key vault credential you created in Purview. |
    | **Lineage extraction (preview)** | Select **Off**. |

    :::image type="content" source="../images/scan-database-credentials.png" alt-text="Screenshot that shows the scan credential form, with values entered.":::

1. Select **Test connection** to verify the connectivity and that permissions are in place. Select **Continue**.

1. Select the scope for the scan. To scan the entire database, use the default value.

    :::image type="content" source="../images/scan-database-selections.png" alt-text="Screenshot that shows how to set the scope for the scan to the whole database.":::

1. In **Select a scan rule set**, select **AzureSqlDatabase**, and then select **Continue**.

    :::image type="content" source="../images/scan-database-rule-set.png" alt-text="Screenshot that shows the SQL Database scan rule set selection.":::

1. In **Set a scan trigger**, select **Once**, and then select **Continue**.

    :::image type="content" source="../images/scan-set-trigger.png" alt-text="Screenshot that shows the set a scan to run pane with once selected.":::

1. In **Review your scan**, review the scan settings. Select **Save and Run** to start the scan.

Repeat these steps for the `AdatumERP` database.

Purview is now set up for data governance for the registered data sources.

## Copy SQL Database data to Data Lake Storage Gen2

In the following steps, you use the Copy Data tool in Data Factory to create a pipeline to copy the tables from the SQL Database instances `AdatumCRM` and `AdatumERP` to CSV files in the `<DLZ-prefix>devraw` Data Lake Storage Gen2 account.

The environment is locked to public access, so first you need to set up private endpoints. To use the private endpoints, you'll sign in to the Azure portal in your local browser, and then connect to the Bastion host virtual machine to access the required Azure services.

### Create private endpoints

To set up private endpoints for the required resources:

1. In the `<DMLZ-prefix>-dev-bastion` resource group, select `<DMLZ-prefix>-dev-vm001`.

    :::image type="content" source="../images/bastion-vm.png" alt-text="Screenshot that shows the resource groups for connecting to the bastion host virtual machine." lightbox="../images/bastion-vm.png":::

1. In the command bar, select **Connect** and select **Bastion**.

    :::image type="content" source="../images/bastion-vm-connect.png" alt-text="Screenshot that shows the connect to bastion selection pane.":::

1. Enter the username and password for the virtual machine, and then select **Connect**.

    :::image type="content" source="../images/bastion-vm-connect-password.png" alt-text="Screenshot that shows the username and password entry pane.":::

1. In the virtual machine's web browser, go to the Azure portal. Go to the `<DLZ-prefix>-dev-shared-integration` resource group and open the `<DLZ-prefix>-dev-integration-datafactory001` data factory.

    :::image type="content" source="../images/data-factory-shared-integration.png" alt-text="Screenshot that shows how to go to a different resource group to open Azure Data Factory." lightbox="../images/data-factory-shared-integration.png":::

1. Under **Getting started**, in **Open Azure Data Factory Studio**, select **Open**.

    :::image type="content" source="../images/data-factory-studio-open.png" alt-text="Screenshot that shows how to open Azure Data Factory Studio.":::

1. In the Data Factory Studio menu, select the **Manage** icon (the icon looks like a square toolbox with a wrench stamped on it). In the resource menu, select **Managed private endpoints** to create the private endpoints that are required to connect Data Factory to other secured Azure services.

    Approving access requests for the private endpoints is discussed in a later section. After you approve private endpoint access requests, their approval status is **Approved**, as in the following example of the `<DLZ-prefix>devencur` storage account.

    :::image type="content" source="../images/managed-private-endpoints.png" alt-text="Screenshot that shows how to go to the Manage Private Endpoints pane." lightbox="../images/managed-private-endpoints.png":::

1. Before you approve the private endpoint connections, select **New**. Enter *Azure SQL* to find the Azure SQL Database connector you use to create a new managed private endpoint for the `<DP-prefix>-dev-sqlserver001` Azure SQL virtual machine. The virtual machine contains the `AdatumCRM` and `AdatumERP` databases you created earlier.

1. In **New managed private endpoint (Azure SQL Database)**, for **Name**, enter *data-product-dev-sqlserver001*. Enter the Azure subscription you used to create the resources. For **Server name**, select `<DP-prefix>-dev-sqlserver001` so that you can connect to it from this data factory in the next sections.

    :::image type="content" source="../images/managed-private-endpoints-sql-server.png" alt-text="Screenshot that shows how to name the new private endpoint.":::

### Approve private endpoint access requests

To give Data Factory access to the private endpoints for the required services, you have a couple options:

- **Option 1:** In each service you request access to, in the Azure portal, go to the networking or private endpoint connections option of the service and approve the access requests to the private endpoint.

- **Option 2:** Run the following scripts in Azure Cloud Shell in Bash mode to approve all access requests to the required private endpoints at once.

    ```bash
    
    # Storage managed private endpoint approval
    
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
    
    # SQL Database managed private endpoint approval
    resourceGroupName=$(az group list -o tsv  --query "[?contains(@.name, '-dev-dp001')==\`true\`].name")
    sqlServerName=$(az sql server list -g $resourceGroupName -o tsv  --query "[?contains(@.name, 'sqlserver001')==\`true\`].name")
    endPointConnectionName=$(az network private-endpoint-connection list -g $resourceGroupName -n $sqlServerName --type Microsoft.Sql/servers -o tsv --query "[?contains(@.properties.privateLinkServiceConnectionState.status, 'Pending')==\`true\`].name")
    az network private-endpoint-connection approve -g $resourceGroupName -n $endPointConnectionName --resource-name $sqlServerName --type Microsoft.Sql/servers --description "Approved"
    
    # Key Vault private endpoint approval
    resourceGroupName=$(az group list -o tsv  --query "[?contains(@.name, '-dev-metadata')==\`true\`].name")
    keyVaultName=$(az keyvault list -g $resourceGroupName -o tsv  --query "[?contains(@.name, 'dev-vault001')==\`true\`].name")
    endPointConnectionID=$(az network private-endpoint-connection list -g $resourceGroupName -n $keyVaultName --type Microsoft.Keyvault/vaults -o tsv --query "[?contains(@.properties.privateLinkServiceConnectionState.status, 'Pending')==\`true\`].id")
    az network private-endpoint-connection approve -g $resourceGroupName --id $endPointConnectionID --resource-name $keyVaultName --type Microsoft.Keyvault/vaults --description "Approved"
    
    # Purview private endpoint approval
    resourceGroupName=$(az group list -o tsv  --query "[?contains(@.name, 'dev-governance')==\`true\`].name")
    purviewAcctName=$(az purview account list -g $resourceGroupName -o tsv  --query "[?contains(@.name, '-dev-purview001')==\`true\`].name")
    for epn in $(az network private-endpoint-connection list -g $resourceGroupName -n $purviewAcctName --type Microsoft.Purview/accounts -o tsv --query "[?contains(@.properties.privateLinkServiceConnectionState.status, 'Pending')==\`true\`].name")
    do
        az network private-endpoint-connection approve -g $resourceGroupName -n $epn --resource-name $purviewAcctName --type Microsoft.Purview/accounts --description "Approved"
    done
    
    ```

The following example shows how the `<DLZ-prefix>devraw` storage account manages private endpoint access requests. In the resource menu for the storage account, select **Networking**. In the command bar, select **Private endpoint connections**.

:::image type="content" source="../images/private-endpoint-connections.png" alt-text="Screenshot that shows how to go to the Private endpoint connections pane." lightbox="../images/private-endpoint-connections.png":::

For some Azure resources, you select **Private endpoint connections** in the resource menu. An example for the Azure SQL server is shown in the following screenshot.

To approve a private endpoint access request, in **Private endpoint connections**, select the pending access request, and then select **Approve**:

:::image type="content" source="../images/private-endpoint-connections-sql.png" alt-text="Screenshot that shows to approve a private endpoint access request." lightbox="../images/private-endpoint-connections-sql.png":::

After you approve the access request in each required service, it might take a few minutes for the request to show as **Approved** in **Managed private endpoints** in Data Factory Studio. Even if you select **Refresh** in the command bar, the approval state might be stale for a few minutes.

When you're finished approving all access requests for the required services, in **Managed private endpoints**, the **Approval state** value for all the services is **Approved**:

:::image type="content" source="../images/managed-private-endpoints-complete.png" alt-text="Screenshot that shows the private endpoint SQL connections as Approved.":::

### Role assignments

When you finish approving private endpoint access requests, add the appropriate role permissions for Data Factory to access these resources:

- SQL Database instances `AdatumCRM` and `AdatumERP` in the `<DP-prefix>-dev-sqlserver001` Azure SQL server
- Storage accounts `<DLZ-prefix>devraw`, `<DLZ-prefix>devencur`, and `<DLZ-prefix>devwork`
- Purview account `<DMLZ-prefix>-dev-purview001`

#### Azure SQL virtual machine

1. To add role assignments, begin with the Azure SQL virtual machine. In the `<DMLZ-prefix>-dev-dp001` resource group, go to `<DP-prefix>-dev-sqlserver001`.

1. In the resource menu, select **Access control (IAM)**. In the command bar, select **Add** > **Add role assignment**.

1. On the **Role** tab, select **Contributor**, and then select **Next**.

    :::image type="content" source="../images/add-role-to-contributor.png" alt-text="Screenshot that shows the Contributor role selection pane.":::

1. In **Members**, for **Assign access to**, select **Managed identity**. For **Members**, choose **Select Members**.

    :::image type="content" source="../images/add-role-to-managed-identities.png" alt-text="Screenshot that shows the select Managed Identity Members pane.":::

1. In **Select managed identities**, select your Azure subscription. For **Managed identity**, select **Data Factory (V2)** to see available data factories. In the list of data factories, select **Azure Data Factory \<DLZ-prefix\>-dev-integration-datafactory001**. Choose **Select**.

    :::image type="content" source="../images/add-role-to-sql-server-review-assign.png" alt-text="Screenshot that shows the role assignment completion pane.":::

1. Select **Review + Assign** twice to complete the process.

#### Storage accounts

Next, assign the required roles to the `<DLZ-prefix>devraw`, `<DLZ-prefix>devencur`, and `<DLZ-prefix>devwork` storage accounts.

To assign the roles, complete the same steps that you used to create the Azure SQL server role assignment. But, for the role, select **Storage Blob Data Contributor** instead of **Contributor**.

After you assign roles for all three storage accounts, Data Factory can connect to and access the storage accounts.

#### Microsoft Purview

The final step to add role assignments is to add the Purview Data Curator role in Microsoft Purview to the managed identity account of the `<DLZ-prefix>-dev-integration-datafactory001` data factory. Complete the following steps so that Data Factory can send data catalog asset information from multiple data sources to the Purview account.

1. In the resource group `<DMLZ-prefix>-dev-governance`, go to the `<DMLZ-prefix>-dev-purview001` Purview account.

1. In Purview Studio, select the **Data map** icon, and then select **Collections**.

1. Select the **Role assignments** tab for the collection. Under **Data curators**, add the managed identity for `<DLZ-prefix>-dev-integration-datafactory001`:

    :::image type="content" source="../images/purview-role-assignment.png" alt-text="Screenshot that shows how to add data curators to your Purview role assignment.":::

### Connect Data Factory to Purview

The permissions are set, and Purview can now see the data factory. The next step is to have `<DMLZ-prefix>-dev-purview001` connect to `<DLZ-prefix>-dev-integration-datafactory001`.

1. In Purview Studio, select the **Management** icon, and then select **Data Factory**. Select **New** to create a Data Factory connection.

1. In the **New Data Factory connections** pane, enter your Azure subscription and select the `<DLZ-prefix>-dev-integration-datafactory001` data factory. Select **OK**.

    :::image type="content" source="../images/connect-purview-data-factory.png" alt-text="Screenshot that shows what the Purview Studio pane looks like while selecting a new connection." lightbox="../images/connect-purview-data-factory.png":::

1. In the `<DLZ-prefix>-dev-integration-datafactory001` Data Factory Studio instance, under **Manage** > **Azure Purview**, refresh **Azure Purview account**.

   The `Data Lineage - Pipeline` integration now shows the green **Connected** icon.

    :::image type="content" source="../images/data-factory-purview-connection.png" alt-text="Screenshot that shows the Azure Data Factory Purview account pane with the data lineage pipeline connected.":::

### Create an ETL pipeline

Now that the  `<DLZ-prefix>-dev-integration-datafactory001` has the required access permissions, create a copy activity in Data Factory to move data from SQL Database instances to the `<DLZ-prefix>devraw` raw storage account.

#### Use the Copy Data tool with AdatumCRM

This process extracts customer data from the `AdatumCRM` SQL Database instance and copies it to Data Lake Storage Gen2 storage.

1. In Data Factory Studio, select the **Author** icon, and then select **Factory Resources**. Select the plus sign (+) and select **Copy Data tool**.

   :::image type="content" source="../images/copy-data-tool.png" alt-text="Screenshot that shows the Copy Data tool under factory resources.":::

   Complete each step in the Copy Data tool wizard:

   1. To create a trigger to run the pipeline every 24 hours, select **Schedule**.

      :::image type="content" source="../images/create-pipeline.png" alt-text="Screenshot that shows how to schedule a Trigger to run periodically in CRM." lightbox="../images/create-pipeline.png":::

   1. To create a linked service to connect this data factory to the `AdatumCRM` SQL Database instance on the `<DP-prefix>-dev-sqlserver001` server (source), select **New Connection**.

      :::image type="content" source="../images/adatum-crm-connection.png" alt-text="Screenshot that shows connecting to the AdatumCRM database." lightbox="../images/adatum-crm-connection.png":::

      > [!NOTE]
      > If you experience errors connecting to or accessing the data in the SQL Database instances or the storage accounts, review your permissions in the Azure subscription. Make sure that the data factory has the required credentials and access permissions to any problematic resource.

   1. Select these three tables:

      - `SalesLT.Address`
      - `SalesLT.Customer`
      - `SalesLT.CustomerAddress`

      :::image type="content" source="../images/adatum-crm-tables.png" alt-text="Screenshot that shows the select tables pane with tables highlighted.":::

   1. Create a new linked service to access the `<DLZ-prefix>devraw` Azure Data Lake Storage Gen2 storage (destination).

      :::image type="content" source="../images/raw-storage-connection.png" alt-text="Screenshot that shows the raw storage connection." lightbox="../images/raw-storage-connection.png":::

   1. Browse the folders in the `<DLZ-prefix>devraw` storage and select *Data* as the destination.

      :::image type="content" source="../images/raw-data-folder.png" alt-text="Screenshot that shows the destination as raw data." lightbox="../images/raw-data-folder.png":::

   1. Change the file name suffix to *.csv* and use the other default options.

      :::image type="content" source="../images/destination-data-source.png" alt-text="Screenshot that shows the file name suffix field with CSV entered.":::

   1. Go to the next pane and select **Add header to file**.

      :::image type="content" source="../images/add-header-to-file.png" alt-text="Screenshot that shows how to add a header to a file.":::

   1. When you finish the wizard, the **Deployment complete** pane looks similar to this example:

      :::image type="content" source="../images/copy-data-tool-crm-complete.png" alt-text="Screenshot that shows the Copy Data tool deployment completed.":::

The new pipeline is listed in **Pipelines**.

#### Run the pipeline

This process creates three .csv files in the *Data\CRM* folder, one for each of the selected tables in the `AdatumCRM` database.

1. Rename the pipeline `CopyPipeline_CRM_to_Raw`.

1. Rename the datasets `CRM_Raw_Storage` and `CRM_DB`.

1. In the **Factory Resources** command bar, select **Publish all**.

1. Select the `CopyPipeline_CRM_to_Raw` pipeline, and in the pipeline command bar, select **Trigger** to copy the three tables from SQL Database to Data Lake Storage Gen2.

    :::image type="content" source="../images/trigger-run-crm.png" alt-text="Screenshot that shows how to use the trigger tool to copy data from the SQL Database to Data Lake Storage Gen2.":::

#### Use the Copy Data tool with AdatumERP

Next, extract the data from the `AdatumERP` database. The data represents sales data coming from the ERP system.

1. Still in Data Factory Studio, create a new pipeline by using the Copy Data tool. This time, you're sending the sales data from `AdatumERP` to the `<DLZ-prefix>devraw` storage account data folder, the same way you did with the CRM data. Complete the same steps, but use the `AdatumERP` database as the source.

   1. Create the schedule to trigger every hour.

   1. Create a linked service to the `AdatumERP` SQL Database instance.

       :::image type="content" source="../images/adatum-erp-connection.png" alt-text="Screenshot that shows the Adatum ERP connection pane completed." lightbox="../images/adatum-erp-connection.png":::

   1. Select these seven tables:

      - `SalesLT.Product`
      - `SalesLT.ProductCategory`
      - `SalesLT.ProductDescription`
      - `SalesLT.ProductModel`
      - `SalesLT.ProductModelProductDescription`
      - `SalesLT.SalesOrderDetail`
      - `SalesLT.SalesOrderHeader`

      :::image type="content" source="../images/adatum-erp-tables.png" alt-text="Screenshot that shows Adatum ERP Table options.":::

   1. Use the existing linked service to the `<DLZ-prefix>devraw` storage account and set the file extension to *.csv*.

       :::image type="content" source="../images/destination-data-source.png" alt-text="Screenshot that shows a raw storage account with the file extension set to CSV.":::

   1. Select **Add header to file**.

      :::image type="content" source="../images/add-header-to-file.png" alt-text="Screenshot that shows adding a header to a file under File format settings.":::

   1. Complete the wizard again and rename the pipeline `CopyPipeline_ERP_to_DevRaw`. Then, in the command bar, select **Publish all**. Finally, run the trigger on this newly created pipeline to copy the seven selected tables from SQL Database to Data Lake Storage Gen2.

When you finish these steps, 10 CSV files are in the `<DLZ-prefix>devraw` Data Lake Storage Gen2 storage. In the next section, you curate the files in the `<DLZ-prefix>devencur` Data Lake Storage Gen2 storage.

## Curate data in Data Lake Storage Gen2

When you finish creating the 10 CSV files in the raw `<DLZ-prefix>devraw` Data Lake Storage Gen2 storage, transform these files as needed as you copy them to the curated `<DLZ-prefix>devencur` Data Lake Storage Gen2 storage.

Continue using Azure Data Factory to create these new pipelines to orchestrate data movement.

### Curate CRM to customer data

Create a data flow that gets the CSV files in the *Data\CRM* folder in `<DLZ-prefix>devraw`. Transform the files and copy the transformed files in *.parquet* file format to the *Data\Customer* folder in `<DLZ-prefix>devencur`.

1. In Azure Data Factory, go to the data factory and select **Orchestrate**.

    :::image type="content" source="../images/select-orchestrate.png" alt-text="Screenshot that shows the Orchestrate button in Azure Data Factory.":::

1. In **General**, name the pipeline `Pipeline_transform_CRM`.

1. In the **Activities** pane, expand **Move and Transform**. Drag the data flow activity and drop it in the pipeline canvas.

    :::image type="content" source="../images/activities.png" alt-text="Screenshot that shows the Activities pane and Move and transform highlighted.":::

1. In **Adding Data Flow**, select **Create new data flow** and name the data flow `CRM_to_Customer`. Select **Finish**.

    > [!NOTE]
    > In the command bar of the pipeline canvas, turn on **Data flow debug**. In debug mode, you can interactively test the transformation logic against a live Apache Spark cluster. Data flow clusters take 5 to 7 minutes to warm up. We recommend that you turn on debugging before you begin data flow development.

    :::image type="content" source="../images/data-flow-debug.png" alt-text="Screenshot that shows the Open Data Flow button.":::

   When you're finished selecting the options in the `CRM_to_Customer` data flow, the `Pipeline_transform_CRM` pipeline looks similar to this example:

   :::image type="content" source="../images/pipelines-transform-crm.png" alt-text="Screenshot that shows the pipeline transform CRM.":::

   The data flow looks like this example:

   :::image type="content" source="../images/crm-to-customer.png" alt-text="Screenshot that shows the CRM to Customer data flow.":::

1. Next, modify these settings in the data flow for the `CRMAddress` source:

   1. Create a new dataset from Data Lake Storage Gen2. Use the **DelimitedText** format. Name the dataset `DevRaw_CRM_Address`.

   1. Connect the linked service to `<DLZ-prefix>devraw`.

   1. Select the `Data\CRM\SalesLTAddress.csv` file as the source.

1. Modify these settings in the data flow for the paired `CustAddress` sink:

   1. Create a new dataset named `DevEncur_Cust_Address`.

   1. Select the *Data\Customer* folder in `<DLZ-prefix>devencur` as the sink.

   1. Under **Settings\Output to single file**, convert the file to *Address.parquet*.

For the remainder of the data flow configuration, use the information in the following tables for each component. Note that `CRMAddress` and `CustAddress` are the first two rows. Use them as examples for the other objects.

An item that isn't in either of the following tables is the `RemovePasswords` schema modifier. The preceding screenshot shows that this item goes between `CRMCustomer` and `CustCustomer`. To add this schema modifier, go to **Select settings** and remove **PasswordHash** and **PasswordSalt**.

`CRMCustomer` returns a 15-column schema from the .crv file. `CustCustomer` writes only 13 columns after the schema modifier removes the two password columns.

#### The complete table

| Name | Object type | Dataset name | Data store | Format type | Linked service | File or folder |
| --- | --- | --- | --- | --- | --- | --- |
| `CRMAddress` | source | `DevRaw_CRM_Address` | Azure Data Lake Storage Gen2 | DelimitedText | `devraw` | `Data\CRM\SalesLTAddress.csv` |
| `CustAddress` | sink | `DevEncur_Cust_Address` | Azure Data Lake Storage Gen2 | Parquet | `devencur` | *Data\Customer\Address.parquet* |
| `CRMCustomer` | source | `DevRaw_CRM_Customer` | Azure Data Lake Storage Gen2 | DelimitedText | `devraw` | `Data\CRM\SalesLTCustomer.csv` |
| `CustCustomer` | sink | `DevEncur_Cust_Customer` | Azure Data Lake Storage Gen2 | Parquet | `devencur` | *Data\Customer\Customer.parquet* |
| `CRMCustomerAddress` | source | `DevRaw_CRM_CustomerAddress` | Azure Data Lake Storage Gen2 | DelimitedText | `devraw` | `Data\CRM\SalesLTCustomerAddress.csv` |
| `CustCustomerAddress` | sink | `DevEncur_Cust_CustomerAddress` | Azure Data Lake Storage Gen2 | Parquet | `devencur` | *Data\Customer\CustomerAddress.parquet* |

### The ERP to Sales table

Now, repeat similar steps to create a `Pipeline_transform_ERP` pipeline, create an `ERP_to_Sales` data flow to transform the *.csv* files in the *Data\ERP* folder in `<DLZ-prefix>devraw`, and copy the transformed files to the *Data\Sales* folder in `<DLZ-prefix>devencur`.

In the following table, you'll find the objects to create in the `ERP_to_Sales` data flow and the settings you need to modify for each object. Each *.csv* file is mapped to a *.parquet* sink.

| Name | Object type | Dataset name | Data store | Format type | Linked service | File or folder |
| --- | --- | --- | --- | --- | --- | --- |
| `ERPProduct` | source | `DevRaw_ERP_Product` | Azure Data Lake Storage Gen2 | DelimitedText | `devraw` | `Data\ERP\SalesLTProduct.csv` |
| `SalesProduct` | sink | `DevEncur_Sales_Product` | Azure Data Lake Storage Gen2 | Parquet | `devencur` | *Data\Sales\Product.parquet* |
| `ERPProductCategory` | source | `DevRaw_ERP_ProductCategory` | Azure Data Lake Storage Gen2 | DelimitedText | `devraw` | `Data\ERP\SalesLTProductCategory.csv` |
| `SalesProductCategory` | sink | `DevEncur_Sales_ProductCategory` | Azure Data Lake Storage Gen2 | Parquet | `devencur` | *Data\Sales\ProductCategory.parquet* |
| `ERPProductDescription` | source | `DevRaw_ERP_ProductDescription` | Azure Data Lake Storage Gen2 | DelimitedText | `devraw` | `Data\ERP\SalesLTProductDescription.csv` |
| `SalesProductDescription` | sink | `DevEncur_Sales_ProductDescription` | Azure Data Lake Storage Gen2 | Parquet | `devencur` | *Data\Sales\ProductDescription.parquet* |
| `ERPProductModel` | source | `DevRaw_ERP_ProductModel` | Azure Data Lake Storage Gen2 | DelimitedText | `devraw` | `Data\ERP\SalesLTProductModel.csv` |
| `SalesProductModel` | sink | `DevEncur_Sales_ProductModel` | Azure Data Lake Storage Gen2 | Parquet | `devencur` | *Data\Sales\ProductModel.parquet* |
| `ERPProductModelProductDescription` | source | `DevRaw_ERP_ProductModelProductDescription` | Azure Data Lake Storage Gen2 | DelimitedText | `devraw` | `Data\ERP\SalesLTProductModelProductDescription.csv` |
| `SalesProductModelProductDescription` | sink | `DevEncur_Sales_ProductModelProductDescription` | Azure Data Lake Storage Gen2 | Parquet | `devencur` | *Data\Sales\ProductModelProductDescription.parquet* |
| `ERPProductSalesOrderDetail` | source | `DevRaw_ERP_ProductSalesOrderDetail` | Azure Data Lake Storage Gen2 | DelimitedText | `devraw` | `Data\ERP\SalesLTProductSalesOrderDetail.csv` |
| `SalesProductSalesOrderDetail` | sink | `DevEncur_Sales_ProductSalesOrderDetail` | Azure Data Lake Storage Gen2 | Parquet | `devencur` | *Data\Sales\ProductSalesOrderDetail.parquet* |
| `ERPProductSalesOrderHeader` | source | `DevRaw_ERP_ProductSalesOrderHeader` | Azure Data Lake Storage Gen2 | DelimitedText | `devraw` | `Data\ERP\SalesLTProductSalesOrderHeader.csv` |
| `SalesProductSalesOrderHeader` | sink | `DevEncur_Sales_ProductSalesOrderHeader` | Azure Data Lake Storage Gen2 | Parquet | `devencur` | *Data\Sales\ProductSalesOrderHeader.parquet* |

## Next steps

> [!div class="nextstepaction"]
> [Clean up resources](cleanup-instructions.md)
