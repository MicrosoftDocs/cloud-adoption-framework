---
title: How to set up Moodle controller instance and worker nodes
description: Learn how to Set up Moodle controller instance and worker nodes (Azure infrastructure configuration).
author: BrianBlanchard
ms.author: brblanch
ms.date: 11/06/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: plan
---

# How to set up Moodle controller instance and worker nodes

## Virtual machine scale set instances

Virtual machine scale set instances are assigned with private IPs that can be accessed only with the controller virtual machine, which is in the same virtual network. Enable the gateway to connect the virtual machine scale set instance to a private IP, and follow [how to create a virtual network gateWay and connect through a private IP](./vpn-gateway.md) to gain gateway access to the virtual machine scale set instance. Before accessing a virtual machine scale set, set it to password-enabled.

To create a virtual machine scale set instance private IP:

- Log in to the [Azure portal](https://ms.portal.azure.com/#home), and locate the created resource group.
- Find and navigate to the virtual machine scale set resource.
- In the left panel, select **Instances**.
- Navigate to the running instance and find the private IP associated with it in the **Overview** section.

Log in to a virtual machine scale set and the controller virtual machine; run these commands:

```bash
 sudo -s
 sudo ssh azureadmin@172.31.X.X
```

172.31.X.X is the virtual machine scale set Instance private IP.

Log in to a scale set virtual machine instance. Perform the following steps:

- A backup directory is extracted as storage/ at /home/azureadmin. This storage directory contains Moodle, moodledata, and a configuration directory, plus a database backup file. These will be copied to desired locations.

- Create a backup directory.

  ```bash
  cd /home/azureadmin/
  mkdir -p backup
  mkdir -p backup/moodle
  ```

- To configure the PHP and web server, create a backup of PHP and web server configurations, and set the PHP version to a variable.

   ```bash
  _PHPVER=`/usr/bin/php -r "echo PHP_VERSION;" | /usr/bin/cut -c 1,2,3`
  echo $_PHPVER
   ```

  ```bash
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

- If on-premises has any additional PHP extensions that aren't in the controller virtual machine, they can be installed manually.

  ```bash
  sudo apt-get install -y php-<extensionName>
  ```

## Next steps

Continue to [how to follow up after a Moodle migration](./migration-post.md) for information about the next step in the Moodle migration process.
