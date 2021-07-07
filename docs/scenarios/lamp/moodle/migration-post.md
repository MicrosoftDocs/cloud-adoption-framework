---
title: How to follow up after a Moodle migration
description: Learn how to follow up after a Moodle migration. See how to update log paths, restart servers, and take other steps that are needed to complete the migration.
author: UmakanthOS
ms.author: brblanch
ms.date: 11/30/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: plan
ms.custom: think-tank
---

<!-- cspell:ignore SCORM newkey keyout mydomain httpd sitelog sitelogs -->
<!--docutune:casing SCP WinSCP SCORM -->

# How to follow up after a Moodle migration

## Post-migration tasks

After migrating Moodle, you need to take care of some post-migration tasks to complete your configuration. These tasks include:

- Updating log paths in virtual machine scale set instances.
- Restarting servers in virtual machine scale set instances.
- Updating certificates.
- Updating certificate locations.
- Updating the HTML local copy.
- Restarting the PHP and NGINX servers.
- Mapping the DNS name to the Azure Load Balancer IP address.

## Controller virtual machine scale set

Take the following steps to finish configuring your virtual machine scale set. You will need to SSH to your virtual machine scale set instance by using the private IP address, as described in [Access the virtual machine scale set](./azure-infra-config.md#access-the-virtual-machine-scale-set).

### Update log paths

Your on-premises environment and Azure might store log files in different locations. For example, you might need to update these log paths:

- `/var/log/syslogs/moodle/access.log`
- `/var/log/syslogs/moodle/error.log`

Follow these steps to update the log file locations:

1. Enter this command to open the configuration file:

   ```bash
   nano /etc/nginx/nginx.conf
   ```

2. Find `access_log` and `error_log`, and update the log paths.

3. Press Ctrl+O to save the changes and Ctrl+X to close the file.

### Restart servers

Enter these commands to restart the `nginx` and `php-fpm` servers:

```bash
sudo systemctl restart nginx
sudo systemctl restart php<php version>-fpm
```

## Controller virtual machine

Take these steps to complete the controller virtual machine configuration.

### Update security certificates

1. Sign in to the controller virtual machine. You can find the certificates for your Moodle application in the `/moodle/certs` folder.

1. Copy the `.crt` and `.key` files to `/moodle/certs/`. Change the file names to `nginx.crt` and `nginx.key`, respectively, so that the configured NGINX servers recognize them. If your local environment supports the SCP utility or a tool like WinSCP, you can use these tools to copy these files to the controller virtual machine. Otherwise, use these commands:

   ```bash
   cd /<path to certs location>
   mv /<path to certs location>/*.key /moodle/certs/nginx.key
   mv /<path to certs location>/*.crt /moodle/certs/nginx.crt
   ```

   As an alternative to copying the files, use these commands to generate a self-signed certificate:

   ```bash
   openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
   -keyout /moodle/certs/nginx.key \
   -out /moodle/certs/nginx.crt \
   -subj "/C=US/ST=WA/L=Redmond/O=IT/CN=mydomain.com"
   ```

   You can only use a self-signed certificate for testing.

1. It's recommended that the certificate files are owned by `www-data:www-data` and are read-only to the owner. Enter these commands to make those changes:

   ```bash
   chown www-data:www-data /moodle/certs/nginx.*
   chmod 400 /moodle/certs/nginx.*
   ```

1. Update the certificate location by taking these steps:

   1. Enter this command to open the configuration file:

      ```bash
      nano /etc/nginx/sites-enabled/*.conf
      ```

   1. Find `ssl_certificate` in the file.

   1. Replace the certificate's paths with these values:

      ```bash
      /moodle/certs/moodle/certs/nginx.crt;
      /moodle/certs/nginx.key;
      ```

   1. Press Ctrl+O to save your changes and Ctrl+X to close the file.

### Update local HTML copy

The local copy of the Moodle HTML site content, `/moodle/html/moodle`, is created in the virtual machine scale set in this folder: `/var/www/html/moodle`. The local copy is updated only when the time stamp changes. Enter this command in the controller virtual machine to update the time stamp:

```bash
sudo -s
/usr/local/bin/update_last_modified_time.moodle_on_azure.sh
```

The last-modified time stamp file, `/moodle/html/moodle/last_modified_time.moodle_on_azure`, contains a script. Every time that the script runs, the `/moodle/html/moodle` directory content is updated in the local copy, `/var/www/html`.

### Restart servers

Enter these commands to restart the `nginx` and `php-fpm` servers:

```bash
sudo systemctl restart nginx
sudo systemctl restart php<php version>-fpm
```

### Map the DNS name to the Azure Load Balancer IP address

Follow these steps at the hosting-provider level to map the DNS name to the Azure Load Balancer IP:

1. Enter the following command in the controller virtual machine to turn off maintenance mode on the Moodle website:

   ```bash
   sudo /usr/bin/php admin/cli/maintenance.php --disable
   ```

1. Enter this command to check the status of the Moodle site:

   ```bash
   sudo /usr/bin/php admin/cli/maintenance.php
   ```

1. Go to the DNS name to see the migrated Moodle web page.

## Frequently asked questions and troubleshooting

Refer to the following information when you have questions about your Moodle migration. These log files can also help you troubleshoot problems:

- Syslog files:

  - Whenever a user goes to your webpage, the system generates either an error log or an access log.
  - You can find them in this folder: `/var/log/nginx/`.

- Cron log file:
  - When a cron job runs, it updates the local copy of the log file.
  - You can find the file in this folder: `/var/log/sitelogs/moodle/cron.log`.

### Database connection failure

For errors like *database connection failed* or *could not connect to the database you specified*, here are some potential reasons and solutions:

- Your database server isn't installed or running. To check for this condition in MySQL, enter the following command:

  ```bash
  $telnet database_host_name 3306
  ```

  If your database is running, you should get a response that includes the version number of the MySQL server.

- The host address is configured incorrectly. If you're running two instances of Moodle on different ports, use the IP address of the host, not `localhost`, in the `$CFG->dbhost` setting. For example, use:

  `$CFG->dbhost = 127.0.0.1:3308`

- You haven't created a Moodle database. Or you haven't assigned adequate permissions for accessing the database. Check the database and the permissions that you granted.

- The Moodle database settings aren't correct. For instance, the database name, username, or password in your Moodle configuration file, `config.php`, isn't correct. Make sure your MySQL username and password don't contain apostrophes or non-alphanumeric characters.

### Internal server error

There are several possible causes for this error: *500: Internal Server Error*. Start by checking your web server error log, which should contain a detailed explanation. Here are some possibilities:

- There's a syntax error in your `.htaccess` or `httpd.conf` file. The correct syntax for directives differs depending on which file you're using. Use the following command to test for configuration errors in your NGINX files:

  ```bash
  `nginx -t`
  ```

- The web server runs under your own user name, and the access permissions are incorrect. In this case, all files need a maximum permission level of 755. Check that this level is set for your Moodle directory in your control panel. Or use this command to set the level if you have access to the shell:

  ```bash
  chmod -R 755 moodle
  ```

### Memory limit error

When a *403: Forbidden* error occurs, the PHP `memory_limit` value isn't large enough for the PHP script. The `memory_limit` value is the allowed memory size. Increase the PHP `memory_limit` value by small amounts until the message disappears. Use one of these methods:

- For a hosted installation, ask your host's support how to increase the value. Many environments use `.htaccess` files. If your installation does, add the following line to your `.htaccess` file:

  ```bash
  php_value memory_limit <value>M
  ```

  For example, to increase the value to 40 megabytes, enter:

  `php_value memory_limit 40M`

  If no `.htaccess` file exists, create one in the Moodle directory with that line.

- If you have your own server with shell access, edit your `php.ini` file. Then restart your web server to apply the changes that you made in `php.ini`. To make sure you've updated the value correctly, enter this command:

  ```bash
  `phpinfo`
  ```

  The output from `phpinfo` should contain a line similar to this one:

  ```bash
  memory_limit <value>M
  ```

  For example, it might contain this line:

  `memory_limit 40M`

  An alternative to increasing the `memory_limit` value is to turn off the memory limit by entering this command:

  ```bash
  memory_limit 0
  ```

### Sign-in errors

Sometimes you can't sign in, or you see one of these messages:

- `Your session has timed out. Please log in again.`

- `A server error that affects your login session was detected. Please log in again or restart your browser.`

There might be a problem with your authentication method, especially if you use an external method like LDAP to authenticate users. Try to sign in to another manual account, such as your main admin account. If you can't sign in, check your authentication. If you can sign in to the other account, here are possible reasons and solutions for the Moodle sign-in problem:

- Your hard disk might be full. In this situation, Moodle can't create new sessions, and users can't sign in. Check that your hard disk isn't full, that your server is on shared hosting, and that you haven't reached your disk space quota.

- The web server can't write to the `sessions` subdirectory. Carefully check the permissions in your `moodledata` area.

### Fatal errors

The Moodle and moodledata permissions might be incorrect if you see this error: `fatal error: $cfg->dataroot is not writable. The admin has to fix directory permissions! Exiting.`

Check that these permissions are `www-data:www-data` only. If the permissions are at a different level, use this command to change the group and ownership permissions:

```bash
sudo chown -R /moodle/moodledata
```

### Top-level course errors

If you can't find a top-level course right after you install Moodle, the installation probably didn't finish. Right before the end of a complete installation, Moodle asks you for the administrator profile and prompts you to name the site. If these steps were missing, check your logs for errors. Then restart the database. If you used the web-based installer, install Moodle again by using the command line.

### Navigation errors

If you can't navigate freely in Moodle after you sign in, your URL configuration might be incorrect. Make sure that the URL in your `$CFG->wwwroot` setting is the same one that you use to access the site.

### File upload errors

If you see a *File not found* error when uploading a file, your web server might not have turned on slash arguments.

- If your web server supports slash arguments, turn them on.

- If your web server doesn't support slash arguments, turn them off in Moodle by clearing the **Use slash arguments** check box in **Administration** > **Site administration** > **Server** > **HTTP**. You may see this message.

  > [!WARNING]
  > Disabling slash arguments will result in SCORM packages not working and slash arguments warnings being displayed!

### Maintenance mode errors

When Moodle is in maintenance mode and you try to leave that mode, sometimes you see this message: *This site is undergoing maintenance and is currently unavailable*. This situation comes up when there's a problem with the `maintenance.html` file that Moodle creates in the `moodledata` folder when it goes into maintenance mode. In this case, take these steps:

- Check that the web server user has write permissions in the `moodledata` directory.
- Manually delete the `maintenance.html` file.

## Next steps

- [Azure Database for MySQL documentation](/azure/mysql/)
- [What are virtual machine scale sets?](/azure/virtual-machine-scale-sets/overview)
- [Storage account overview](/azure/storage/common/storage-account-overview)
