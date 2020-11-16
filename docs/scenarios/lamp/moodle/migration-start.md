---
title: How to start a manual Moodle migration
description: Learn how to start a manual Moodle migration.
author: BrianBlanchard
ms.author: brblanch
ms.date: 11/06/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: plan
---

# How to start a manual Moodle migration

To start a Moodle migration, log into [Azure](https://portal.azure.com/) after completing deployment. Go to the created resource group, and find all the created resources. The following image demonstrates how resources will be created:

[Resources overview](./images/resource-creation-overview.png)

## Controller virtual machine

- Use a free open-source terminal emulator or serial console tool to log in to a controller machine.
- Copy the public IP of the controller virtual machine to use as the host name.
- Expand **SSH** in the navigation panel, select **Auth**, and find the SSH key file from deploying the Azure infrastructure with an Azure Resource Manager Template.
- Select **Open**. You will be prompted for the user name. Enter **azureadmin**, as it's hard-coded in the template.

[The PuTTY login page.](./images/putty-login.png)

[PuTTY key criteria.](./images/putty-key-criteria.png)

- Browse and select the SSH key and click on Open button.

Browse [PuTTY general FAQ/troubleshooting questions](https://documentation.help/PuTTY/faq.html) to learn more about PuTTY.

After logging in, run the next set of commands to migrate.

## Download and install AzCopy

Run: the following commands to install AzCopy:

  ```bash
  sudo -s
  wget https://aka.ms/downloadazcopy-v10-linux
  tar -xvf downloadazcopy-v10-linux
  sudo rm /usr/bin/azcopy
  sudo cp ./azcopy_linux_amd64_*/azcopy /usr/bin/
  ```

## Copy the backup

To copy the backup archive to the controller virtual machine instance from an Azure Resource Manager deployment:

- Download the compressed backup file(storage.tar.gz) from blob storage to Controller virtual Machine at /home/azureadmin/ location.

  ```bash
  sudo -s
  cd /home/azureadmin/
  azcopy copy `https://storageaccount.blob.core.windows.net/container/BlobDirectoryName<SASToken>` `/home/azureadmin/`
  ```

  For example: `azcopy copy 'https://onpremisesstorage.blob.core.windows.net/migration/storage.tar.gz?sv=2019-12-12&ss=' /home/azureadmin/storage.tar.gz`

- Extract the compressed content to a directory.

  ```bash
  d /home/azureadmin
  ar -zxvf storage.tar.gz
  ```

## How to migrate and configure a Moodle application

Before migrating, back up the current configuration. A backup directory is extracted as `storage/at/home/azureadmin`. This storage directory contains Moodle, moodledata, and configuration directories and a database backup file. These will be copied to desired locations.

- Create a backup directory.

  ```bash
  cd /home/azureadmin/
  mkdir -p backup
  mkdir -p backup/moodle
  mkdir -p backup/moodle/html
  ```

- Create backup of Moodle and moodledata directories.

  ```bash
  mv /moodle/html/moodle /home/azureadmin/backup/moodle/html/moodle
  mv /moodle/moodledata /home/azureadmin/backup/moodle/moodledata
  ```

- Copy on-premises Moodle and moodledata directories to a shared location (`/moodle`).

  ```bash
  cp -rf /home/azureadmin/storage/moodle /moodle/html/
  cp -rf /home/azureadmin/storage/moodledata /moodle/moodledata
  ```

- Import the Moodle database to Azure. Azure Database for MySQL instances are protected by a firewall. By default, all connections to the server and the databases inside the server are rejected. Before connecting to Azure Database for MySQL for the first time, configure the firewall to add the client machine's public network IP address or IP address range.

  ```bash
  az mysql server firewall-rule create --resource-group myresourcegroup --server mydemoserver --name AllowMyIP --start-ip-address 192.168.0.1 --end-ip-address 192.168.0.1
  ```

- Select the new MySQL server and then **Connection security**.

![Select **Connection security**.](./images/database-connection-security.png)

- You can add an IP or configure firewall rules here. Select **Save** after you've created the rules.

You can now connect to the server using the mysql command-line tool or the MySQL Workbench tool. To obtain connection information, copy the **Server name** and **Server admin login name** from the **MySQL server resource** page. You can select the copy button next to each field to do this.

![Setting up a new connection.](images/database-connection.png)

For example, if the server name is `mydemoserver.mysql.database.azure.com`, and the server admin login name is `myadmin@mydemoserver`:

- Before importing a database, make sure that Azure Database details for MySQL server details are ready.
- Navigate to Azure portal, and go to the created resource group.
- Select the Azure Database for MySQL server resource.
- In the overview panel find Azure Database for MySQL server details such as Server name, Server admin login name.
- Reset the password by clicking the Reset Password button at top let of the page.

Use these database server details for the following commands:

- Import the on-premises database to Azure Database for MySQL.

- Create a database to import on-premises database.

  ```bash
  mysql -h $server_name -u $server_admin_login_name -p$admin_password -e "CREATE DATABASE $moodledbname CHARACTER SET utf8;"
  ```

- Assign right permissions to database.

  ```bash
  mysql -h $server_name -u $server_admin_login_name -p$admin_password -e "GRANT ALL ON $moodledbname.* TO `$server_admin_login_name` IDENTIFIED BY `$admin_password`;"
  ```

- Import the database.

  ```bash
  mysql -h $server_name -u $server_admin_login_name -p$admin_password $moodledbname < /home/azureadmin/storage/database.sql
  ```

- Update the database details in the Moodle configuration file (/moodle/config.php).

Update parameters in config.php. Make sure to store the DNS name for this task:

- Navigate to the Azure portal, and find your resource group.

- Locate the **Load Balancer public IP**, and get the DNS name from the **Overview** panel:

  dbhost, dbname, dbuser, dbpass, dataroot, and wwwroot

  ```bash
  cd /moodle/html/moodle/
  nano config.php

- Update the database details, and save the file.

  For example:

  - $CFG->dbhost    = `localhost`;                - Change `localhost` to the server name.
  - $CFG->dbname    = `moodle`;                   - Change `moodle` to the newly created database name.
  - $CFG->dbuser    = `root`;                     - Change `root` to the server admin login name.
  - $CFG->dbpass    = `password`;                 - Change `password` to the server admin login password.
  - $CFG->wwwroot   = `https://on-premises.com`;  - Change `on-premises` to the DNS name.
  - $CFG->dataroot  = `/var/moodledata`;          - Change the path to `/moodle/moodledata`.

The on-premises `dataroot` directory can be stored at any location. After making the changes, save the file. Press `CTRL+O` to save and `CTRL+X` to exit.

Configure directory permissions.

- Set 755 and www-data owner:group permissions to the Moodle directory.

  ```bash
  sudo chmod 755 /moodle/html/moodle sudo chown -R www-data:www-data /moodle/html/moodle
   ```

- Set 770 and www-data owner:group permissions to the moodledata directory.

  ```bash
  sudo chmod 770 /moodle/moodledata sudo chown -R www-data:www-data /moodle/moodledata
  ```

- Update the nginx conf file.

  ```bash
  sudo mv /etc/nginx/sites-enabled/*.conf /home/azureadmin/backup/
  cd /home/azureadmin/storage/configuration/
  sudo cp -rf nginx/sites-enabled/*.conf /etc/nginx/sites-enabled/
  ```

- Update the PHP config file.

  ```bash
  _PHPVER=`/usr/bin/php -r "echo PHP_VERSION;" | /usr/bin/cut -c 1,2,3`
  echo $_PHPVER
  sudo mv /etc/php/$_PHPVER/fpm/pool.d/www.conf /home/azureadmin/backup/www.conf
  sudo cp -rf /home/azureadmin/storage/configuration/php/$_PHPVER/fpm/pool.d/www.conf /etc/php/$_PHPVER/fpm/pool.d/
  ```

- Install missing PHP extensions. Azure Resource Manager templates install the following PHP extensions: fpm, cli, curl, zip, pear, mbstring, dev, mcrypt, soap, json, redis, bcmath, gd, mysql, xmlrpc, intl, xml, and bz2. To obtain the list of PHP extensions that are installed on on-premises, run the following command:

  ```bash
  php -m
  ```

- If on-premises has any additional PHP extensions that aren't present in the controller virtual machine, they can be installed manually.

  ```bash
  sudo apt-get install -y php-<extensionName>
  ```

- Update the DNS name and root directory location. Update the Azure cloud DNS name with the on-premises DNS name. This command will open the configuration file:

  ```bash
  nano /etc/nginx/sites-enabled/*.conf
  ```

- Azure Resource Manager template deployment will set the nginx server on port 81. Update the server port to 81 if it's not 81.

- Update the server name. For example, if the server_name on-premises.com, update the on-premises.com with the DNS name. In most of the cases, DNS may remain same in the migration.

- Update the HTML root directory location. For example, if `root /var/www/html/moodle;`, update it to be `root /moodle/html/moodle;`.

- The on-premises root directory can be at any location.

- After the changes, press `CTRL+O` to save the file and `CTRL+X` to exit.

- Restart the web servers.

  ```bash
  sudo systemctl restart nginx
  sudo systemctl restart php$_PHPVER-fpm  
  ```

- Stop the web servers. When a request reaches Azure Load Balancer, it will be redirected to virtual machine scale set instances but not to the controller virtual machine.

  ```bash
  sudo systemctl stop nginx
  sudo systemctl stop php$_PHPVER-fpm  
  ```

## How to copy configuration files

Copy PHP and web server configuration files to a shared location. Configuration files can be copied to virtual machine scale set instances from the shared location.

To create a directory for configuration in a shared location:

```bash
mkdir -p /moodle/config
mkdir -p /moodle/config/php
mkdir -p /moodle/config/nginx
```

To copy the PHP and web server configuration files to a configuration directory:

```bash
cp /etc/nginx/sites-enabled/* /moodle/config/nginx
cp /etc/php/$_PHPVER/fpm/pool.d/www.conf /moodle/config/php
```

## Next steps

Continue to [how to up Moodle controller instance and worker nodes (Azure infrastructure configuration)](./azure-infra-config.md) for information about the next steps in the Moodle migration process.
