---
title: Set up Moodle controller instance and worker nodes
description: Learn how to Set up Moodle controller instance and worker nodes.
author: BrianBlanchard
ms.author: Umakanth
ms.date: 11/06/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: plan
---

# Set up Moodle controller instance and worker nodes

## Virtual machine scale set instances

Virtual machine scale set instances are assigned with private IPs that can be accessed only with the controller virtual machine, which is in the same virtual network. Enable the gateway to connect the virtual machine scale set instance to a private IP, and follow [deploy the virtual network gateway](/vpngateway.md) to gain gateway access to virtual machine scale set instance. Before accessing a virtual machine scale set, set it to password-enabled.

To create a virtual machine scale set instance private IP:

- Log in to [Azure](portal.azure.com) and go to the created Resource Group.
- Find and navigate to the virtual machine scale set resource.
- In the left panel, select **Instances**.
- Navigate to the running instance and find the private IP associated to it in the **Overview** section.

To log in into a virtual machine scale set, log into the controller virtual machine and run these commands:

```bash
 sudo -s
 sudo ssh azureadmin@172.31.X.X 
```

172.31.X.X is the virtual machine scale set Instance private IP.

Log in to scale set virtual machine instance. Perform the following steps:

- A backup directory is extracted as storage/ at /home/azureadmin. This storage directory contains Moodle, moodledata, and a configuration directory, plus a database backup file. These will be copied to desired locations.

- Create a backup directory.

  ```bash
  cd /home/azureadmin/
  mkdir -p backup
  mkdir -p backup/moodle
  ```
        
Configure the PHP and web server:

- Create a backup of PHP and web server configurations.

  ```bash

- Set the PHP version to a variable.

  _PHPVER=`/usr/bin/php -r "echo PHP_VERSION;" | /usr/bin/cut -c 1,2,3`
  echo $_PHPVER

  sudo mv /etc/nginx/sites-enabled/*.conf  /home/azureadmin/backup/
  sudo mv /etc/php/$_PHPVER/fpm/pool.d/www.conf /home/azureadmin/backup/www.conf  
  ```

- Copy the PHP and web server configuration files.

  ```bash
  sudo cp /moodle/config/nginx/*.conf  /etc/nginx/sites-enabled/
  sudo  cp /moodle/config/php/www.conf /etc/php/$_PHPVER/fpm/pool.d/
  ```

- Install missing PHP extensions, and use an Azure Resource Manager template to install the following PHP extensions: fpm, cli, curl, zip, pear, mbstring, dev, mcrypt, soap, json, redis, bcmath, gd, mysql, xmlrpc, intl, xml, and bz2.
                    
- To obtain the list of PHP extensions installed on-premises, run the following command on an on-premises virtual machine:

  ```bash
  php -m
  ```

- ![Note] If on-premises has any additional PHP extensions that aren't present in the controller virtual machine, they can be installed manually.

  ```bash
  sudo apt-get install -y php-<extensionName>
  ```