---
title: How to set up Moodle worker nodes
description: Learn how to configure a virtual machine scale set for Moodle. See how to access the scale set from the controller by using a private IP address.
author: UmakanthOS
ms.author: brblanch
ms.date: 11/30/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: plan
ms.custom: think-tank
---

<!-- cspell:ignore moodledata mbstring mcrypt bcmath -->

# How to set up Moodle worker nodes

Follow these steps to configure a virtual machine scale set, or worker nodes, for Moodle.

## Virtual machine scale set instances

A virtual machine scale set instance is assigned a private IP address. You can only access this IP address with a controller virtual machine that is in the same virtual network as the IP address. This article describes how to set up that IP address and then configure the Azure virtual machine scale set that your Moodle migration creates.

### Access the virtual machine scale set

Follow these steps to access the virtual machine scale set:

1. Determine the private IP address that Azure uses for your virtual machine scale set instance:

   1. Sign in to the [Azure portal](https://ms.portal.azure.com/#home), and locate the resource group that deployment created.

   1. Open the page for the virtual machine scale set resource.

   1. In the left panel, select **Instances**.

   1. Open the running instance. In the **Overview** section, copy the private IP address that is associated with that instance.

1. Enter these commands to sign in to the virtual machine scale set from the controller virtual machine:

   ```bash
   sudo -s
   sudo ssh azureadmin@<private IP address>
   ```

   In the command, `<private IP address>` is the private IP address of the virtual machine scale set. For example, enter:

   ```bash
   sudo -s
   sudo ssh azureadmin@172.31.X.X
   ```

### Create a backup directory

An [earlier step of the migration process extracted backup files](./migration-start.md#back-up-the-current-configuration) to a directory named `storage` in `/home/azureadmin`. This `storage` directory contains the `moodle` and `moodledata` directories, a configuration directory, and a database backup file. After signing in to your scale set virtual machine instance, enter these commands to create a backup directory for these files:

```bash
cd /home/azureadmin/
mkdir -p backup
mkdir -p backup/moodle
```

### Configure the PHP and web server

To configure the PHP and web server, take these steps:

1. Set the PHP version to a variable:

   ```bash
   _PHPVER=`/usr/bin/php -r "echo PHP_VERSION;" | /usr/bin/cut -c 1,2,3`
   echo $_PHPVER
   ```

1. Create a backup of the PHP and web server configurations:

   ```bash
   sudo mv /etc/nginx/sites-enabled/*.conf /home/azureadmin/backup/
   sudo mv /etc/php/$_PHPVER/fpm/pool.d/www.conf /home/azureadmin/backup/www.conf  
   ```

1. Copy the PHP and web server configuration files:

   ```bash
   sudo cp /moodle/config/nginx/*.conf  /etc/nginx/sites-enabled/
   sudo cp /moodle/config/php/www.conf /etc/php/$_PHPVER/fpm/pool.d/
   ```

### Install missing extensions

Take these steps to install missing extensions:

1. To obtain a list of PHP extensions that are installed on-premises, enter the following command on an on-premises virtual machine:

   ```bash
   php -m
   ```

1. Use an Azure Resource Manager template to install the following PHP extensions:

    - `fpm`
    - `cli`
    - `curl`
    - `zip`
    - `pear`
    - `mbstring`
    - `dev`
    - `mcrypt`
    - `soap`
    - `json`
    - `redis`
    - `bcmath`
    - `gd`
    - `mysql`
    - `xmlrpc`
    - `intl`
    - `xml`
    - `bz2`

1. If the on-premises Moodle application has any additional PHP extensions that aren't in the controller virtual machine, install them manually with this command:

   ```bash
   sudo apt-get install -y php-<extension name>
   ```

## Next steps

Continue to [How to follow up after a Moodle migration](./migration-post.md).
