---
title: How to prepare for a Moodle migration
description: Learn how to prepare for a Moodle migration.
author: BrianBlanchard
ms.author: brblanch
ms.date: 11/06/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: plan
---

# How to prepare for a Moodle migration

Exporting data from an on-premises environment to Azure involves the following tasks:

- Install the Azure command-line interface (Azure CLI).
- Create an Azure subscription.
- Create a resource group in Azure.
- Create a storage account in Azure.
- Back up on-premises Moodle data.
- Download and install AzCopy.
- Copy archived files to Azure Blob.

## Install the Azure CLI

1. Inside your on-premises environment, on a host that you can use for Azure tasks, use this command to install Azure CLI:

   ```bash
   curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
   ```

1. In the Azure CLI, use this command to sign in to your Azure account:

   ```bash
   az login -u <username> -p <password>
   ```

   Azure CLI will likely open a browser window or tab and then prompt you to sign in to Azure with your Microsoft account. If a browser window doesn't open, go to [https://aka.ms/devicelogin](https://aka.ms/devicelogin), and enter the authorization code displayed in your terminal.

## Create a subscription

Skip this step if you already have an Azure subscription.

If you don't have a subscription, you can either set up a [pay-as-you-go subscription](https://azure.microsoft.com/offers/ms-azr-0003p/), or you can create a subscription in Azure.

- To use the Azure portal to create a subscription, open [Subscriptions](https://ms.portal.azure.com/#blade/Microsoft_Azure_Billing/SubscriptionsBlade), select **Add**, and enter the required information.

  :::image type="content" source="./images/azure-subscriptions-page.png" alt-text="Azure subscriptions.":::

- To use the Azure CLI to create a subscription, enter this command:

  ```azurecli
  az account set --subscription '<subscription name>'
  ```

  For example, enter:

  `az account set --subscription 'ComputePM LibrarySub'`

## Create a resource group

Once the subscription is set up, create a resource group in Azure. You can either use the Azure portal or the CLI to create the group.

- To use the Azure portal, open **Resource group**, fill in the mandatory fields, and select **Review + create**.

  :::image type="content" source="./images/resource-group.png" alt-text="Resource groups: Create a resource group.":::

- To use the Azure CLI to create a resource group, use this command:

  ```azurecli
  az group create -l <location> -n <resource group name> -s '<subscription name>'
  ```

  For the default location, use the same value that you used in previous steps. See [Data residency in Azure](https://azure.microsoft.com/global-infrastructure/data-residency/) for a list of available regions. For example, enter:

  `az group create -l eastus -n manual_migration -s 'ComputePM LibrarySub'`

Make a note of the name of the resource group that you created, and use that name in later steps.

## Create a storage account

Next, create a storage account within the resource group that you just created. You'll use this storage account to back up your on-premises Moodle data.

You can either use the Azure portal or the Azure CLI to create the storage account.

- To use the Azure portal, open [Create storage account](https://ms.portal.azure.com/#create/Microsoft.StorageAccount). After filling in the mandatory fields, select **Review + create**.

  :::image type="content" source="./images/create-storage-account.png" alt-text="Creating a storage account.":::

- To use the Azure CLI to create the storage account, use this command:

  ```azurecli
  az storage account create -n <storage account name> -g <resource group name> --sku <storage account SKU> --kind <storage account type> -l <location>
  ```

  For example, enter:

  `az storage account create -n onpremisesstorage -g manual_migration --sku Standard_LRS --kind BlobStorage -l eastus`

  The `--kind` parameter specifies the type of storage account.

## Back up on-premises data

Before backing up your on-premises Moodle data, turn on **Maintenance mode** on your Moodle website by following these steps:

1. On an on-premises virtual machine, run this command:

   ```bash
   sudo /usr/bin/php admin/cli/maintenance.php --enable
   ```

2. Run the following command to check the status of your Moodle website:

   ```bash
   sudo /usr/bin/php admin/cli/maintenance.php
   ```

When backing up on-premises Moodle and moodledata files, configurations, and databases, back up to a single directory. The following diagram summarizes this idea:

:::image type="content" source="./images/directory-structure.png" alt-text="The Moodle backup directory structure.":::

### Create a storage directory

To copy all data, create an empty storage directory in any desired location. For example, if the location is `/home/azureadmin`, use these commands:

  ```bash
  sudo -s
  cd /home/azureadmin
  mkdir storage
  ```

### Back up Moodle and moodledata

The `moodle` directory consists of website HTML content. The `moodledata` directory contains Moodle website data.

Use these commands to copy Moodle and moodledata:

  ```bash
  cp -R /var/www/html/moodle /home/azureadmin/storage/
  cp -R /var/moodledata /home/azureadmin/storage/
  ```

### Backup PHP and web server configurations

To back up configuration files, follow these steps:

1. Use these commands to create new directories under your storage directory:

   ```bash
   cd /home/azureadmin/storage mkdir configuration
   cd /home/azureadmin/storage/configuration mkdir phpconfig
   cd /home/azureadmin/storage/configuration mkdir nginxconfig
   ```

   The `phpconfig` directory stores PHP configuration files, such as `php-fpm.conf`, `php.ini`, `pool.d`, and `conf.d`. The `nginxconfig` directory stores ngnix configurations, such as `nginx.conf` and `sites-enabled/dns.conf`.

2. Use these commands to copy the PHP and nginx configuration files:

   ```bash
   cp -R /etc/nginx /home/azureadmin/storage/configuration/nginxconfig
   cp -R /etc/php /home/azureadmin/storage/configuration/php
   ```

### Back up the database

Follow these steps to back up your database:

1. Use these commands to check whether mysql-client is installed:

   ```bash
   sudo -s
   mysql -V
   ```

2. If mysql-client is installed, skip this step. Otherwise, use this command to install mysql-client:

   ```bash
   sudo apt-get install mysql-client
   ```

3. Use this command to back up the database:

   ```bash
   mysqldump -h <database server name> -u <database user ID> -p<database password> <database name> > /home/azureadmin/storage/database.sql
   ```

   For <database server name>, <database user ID>, <database password>, and <database name>, use the values that your on-premises database uses.

### Create an archive

Use this command to create an archive file, `storage.tar.gz`, of your backup directory:

```bash
cd /home/azureadmin/ tar -zcvf storage.tar.gz storage
```

## Download and install AzCopy

Use the following commands to install AzCopy:

```bash
sudo -s
wget https://aka.ms/downloadazcopy-v10-linux
tar -xvf downloadazcopy-v10-linux
sudo rm /usr/bin/azcopy
sudo cp ./azcopy_linux_amd64_*/azcopy /usr/bin/
```

## Copy archived files to Azure Blob Storage

Follow these steps to use AzCopy to copy archived on-premises files to Azure Blob Storage.

### Generate an SAS token

To generate an SAS token for AzCopy, follow these steps:

1. In the Azure portal, go to the page for the storage account you created earlier.

1. In the left panel, select **Shared access signature**.

1. Select **Container**.

   :::image type="content" source="./images/storage-account-created.png" alt-text="A sample storage account.":::

1. Under **Allowed services**, select **Blob**.

1. Under **Allowed permissions**, select the following check boxes:
   - Read
   - Write
   - Delete
   - List
   - Add
   - Create

1. Under **Blob versioning permissions*, select **Enables deletion of versions**.

1. Under **Start and expiry date/time**, enter a start and end time for the SAS token.

1. Select **Generate SAS and connection string**.

   :::image type="content" source="./images/SAS-token-generation.png" alt-text="Generating an SAS token.":::

1. Copy and save the SAS token for future use.

### Create a container

Create a container in the storage account. You can either use the Azure CLI or the Azure portal for this step.

- To use the Azure CLI, use this command:

  ```bash
  az storage container create --account-name <storage account name> --name <container name> --auth-mode login
  ```

  For example, enter:

  `az storage container create --account-name onpremisesstorage --name migration --auth-mode login`

  When you use the `--auth-mode` parameter with a value of `login`, Azure uses your credentials for authentication and then creates the container.

- To use the Azure portal to create the container, follow these steps:

  1. In the portal, go to the page for the storage account you created earlier.

  1. Select **Container**, and then select **Add**.

  1. Enter a name for the container, and select **Create**.

     :::image type="content" source="./images/new-container.png" alt-text="A new container.":::

### Copy the archive file to Azure Blob Storage

Use this command to copy your archive file to the container that you created in Blob Storage:

```bash
sudo azcopy copy /home/azureadmin/storage.tar.gz 'https://<storage account name>.blob.core.windows.net/<container name>/<SAS token>'
```

For example, enter:

`azcopy copy /home/azureadmin/storage.tar.gz 'https://onpremisesstorage.blob.core.windows.net/migration/?sv=2019-12-12&ss='`

Your Blob Storage account should now contain a copy of your archive.

:::image type="content" source="./images/archive-in-blob.png" alt-text="An archive in Azure Blob.":::

## Next steps

Continue to [Moodle migration tasks, architecture, and template](./migration-arch.md).
