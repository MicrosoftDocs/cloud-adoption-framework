---
title: How to follow up after a Moodle migration
description: Learn how to follow up after Moodle migration.
author: BrianBlanchard
ms.author: brblanch 
ms.date: 11/06/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: plan
---

# How to follow up after a Moodle migration

## Post-migration tasks

Post-migration tasks are final application configurations that include setting up logging destinations, SSL certificates, and scheduled tasks/cron jobs. This range of tasks includes:

- Configuring applications.
- Updating log paths in virtual machine scale set instance(s).
- Restarting servers in virtual machine scale set instance(s).
- Updating certificates.
- Updating certificate locations.
- Updating the HTML local copy.
- Restarting PHP and nginx servers.
- Mapping the DNS name to the Azure Load Balancer IP.

## Controller virtual machine scale set

### Log paths

On-premises might have different log path locations that need to be updated with Azure log paths. For example, /var/log/syslogs/moodle/access.log and /var/log/syslogs/moodle/error.log.

- Update the log file location. This command will open the configuration file:

  ```bash
  nano /etc/nginx/nginx.conf
  ```

- Change the log path location.

- Find `access_log` and `error_log`, and update the log path.

- Press `CTRL+O` to save and `CTRL+X` to exit.

### Restart servers

Restart the nginx and php-fpm servers:

  ```bash
  sudo systemctl restart nginx
  sudo systemctl restart php<phpVersion>-fpm
  ```

## Controller virtual machine

### Certificates

- To access certificates, log in to the controller virtual machine.

- The certificates for your Moodle application reside in /moodle/certs.

- Copy the .crt and .key files to /moodle/certs/. The file names should be changed to nginx.crt and nginx.key in order to be recognized by the configured nginx servers. Depending on your local environment, you may choose to use the utility SCP or a tool like WinSCP to copy these files over to the controller virtual machine.

- The command to change a certificate's name.

  ```bash
  cd /path/to/certs/location
  mv /path/to/certs/location/*.key /moodle/certs/nginx.key
  mv /path/to/certs/location/*.crt /moodle/certs/nginx.crt
  ```

- You can also generate a self-signed certificate, which is only useful for testing.

  ```bash
  openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout /moodle/certs/nginx.key \
   -out /moodle/certs/nginx.crt \
  -subj "/C=US/ST=WA/L=Redmond/O=IT/CN=mydomain.com"
  ```

- It's recommended for the certificate files to be read-only to the owner and for these files to be owned by `www-data:www-data`.

  ```bash
  chown www-data:www-data /moodle/certs/nginx.*
   chmod 400 /moodle/certs/nginx.*
  ```

- To update the certificate location and open the configuration file:

  ```bash
  nano /etc/nginx/sites-enabled/*.conf
  ```

- To change the certificate's path location, find `ssl_certificate`. Update the certificate's path as below:

```bash
   /moodle/certs/moodle/certs/nginx.crt;
   /moodle/certs/nginx.key;
```

- Press `CTRL+O` to save the file and `CTRL+X` to exit.

### Update the local HTML copy

The Moodle html site (`/moodle/html/moodle`) content's local copy is created in the virtual machine scale set at `/var/www/html/moodle`. The local copy is updated only when there is an update in timestamp. Execute the following command from the controller virtual machine to update the timestamp.

  ```bash
  sudo -s
  /usr/local/bin/update_last_modified_time.moodle_on_azure.sh
  ```

- Every time that the script in the last modified timestamp file (`/moodle/html/moodle/last_modified_time.moodle_on_azure`) is executed, the `/moodle/html/moodle` directory content is updated in the local copy (`/var/www/html`).

### Restart servers

- Restart the `nginx` and `php-fpm` servers.

  ```bash
  sudo systemctl restart nginx
  sudo systemctl restart php<phpVersion>-fpm
  ```

### Map the DNS name to the Azure Load Balancer IP

- DNS name mapping to the Azure Load Balancer IP must be done at the hosting-provider level.

- Disable **Maintenance mode** on the Moodle website.

- Run the following command in the controller virtual machine:

  ```bash
  sudo /usr/bin/php admin/cli/maintenance.php --disable
  ```

- To check the status of the Moodle site, run the following command:

  ```bash
  sudo /usr/bin/php admin/cli/maintenance.php
  ```

- Hit the DNS name to get the migrated Moodle web page.

## Frequently asked questions and troubleshooting

1. The database connection has failed.

   For errors like *database connection failed* or *could not connect to the database you specified*, here are some potential reasons and solutions:

   - Your database server isn't installed or running. To check for this condition in MySQL, enter the following command:

     ```bash
     $telnet database_host_name 3306
     ```

     If your database is running, you should get a response that includes the version number of the MySQL server.

   - The host address is configured incorrectly. If you're running two instances of Moodle on different ports, use the IP address of the host, not `localhost`, in the `$CFG->dbhost` setting. For example, use:

     `$CFG->dbhost = 127.0.0.1:3308`

   - You haven't created a Moodle database. Or you haven't assigned adequate permissions for accessing the database. Check the database and the permissions that you granted.

   - The Moodle database settings aren't correct. For instance, the database name, username, or password in your Moodle configuration file, `config.php`, aren't correct. Make sure your MySQL username and password don't contain apostrophes or non-alphanumeric characters.

1. Error: *500: Internal Server Error*

   There are several possible causes for this error. Start by checking your web server error log, which should contain a detailed explanation. Here are some possibilities:

   - There's a syntax error in your `.htaccess` or `httpd.conf` files. The correct syntax for directives differs depending on which file you're using. Use the following command to test for configuration errors in your nginx files:

     ```bash
     `nginx -t`
     ```

   - The web server runs under your own user name, and the access permisisons are incorrect. In this case, all files have a maximum permissions level of 755. Check that this level is set for your Moodle directory in your control panel. Or use this command to set the levels if you have access to the shell:

     ```bash
     chmod -R 755 moodle
     ```

1. Error: *403: Forbidden*

   When this error occurs, the PHP `memory_limit` value isn't large enough for the PHP script. The `memory_limit` value is the allowed memory size. Increase the PHP `memory_limit` value by small amounts until the message disappears. Use one of these methods:

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

1. Sign-in errors

   Sometimes you can't sign in, or you see one of these messages:

   - *Your session has timed out. Please log in again.*
   - *A server error that affects your login session was detected. Please log in again or restart your browser.*

   There might be a problem with your authentication method, especially if you use an external method like LDAP to authenticate users. Try to sign in to another manual account, such as your main admin account. If you cannot sign in, check your authentication. If you can sign in to the other account, here are possible reasons and solutions for the Moodle sign-in problem:

   - Your hard disk might be full. In this situation, Moodle can't create new sessions, and users can't sign in. Check that your hard disk isn't full, that your server is on shared hosting, and that you haven't reached your disk space quota.

   - The web server can't write to the `sessions` subdirectory. Carefully check the permissions in your `moodledata` area.

1. Fatal error: *$CFG->dataroot is not writable. The admin has to fix directory permissions! Exiting.*

   The Moodle and moodledata permissions might be incorrect. Check that these permissions are `www-data:www-data` only. If the permissions are at a different level, use this command to change the group and ownership permissions:

   ```bash
   sudo chown -R /moodle/moodledata
   ```

1. You can't find a top-level course.

   If you run into this problem right after you installed Moodle, the installation probably didn't finish. Right before the end of a complete installation, Moodle asks you for the administrator profile and prompts you to name the site. If these steps were missing, check your logs for errors. Then restart the database. If you used the web-based installer, install Moodle again by using the command line.

1. After you sign in, you can't navigate freely in Moodle.

   Your URL configuration might be incorrect. Make sure that the URL in your `$CFG->wwwroot` setting is the same one that you use to access the site.

1. File uploading errors

   If you see a *File not found* error when uploading a file, your web server has not turned on slash arguments.

   - If your web server supports slash arguments, turn them on.

   - If your web server doesn't support slash arguments, turn them off in Moodle by unticking the **Use slash arguments** checkbox in Administration > Site administration > Server > HTTP.

      > [!WARNING]
      > Disabling slash arguments will result in SCORM packages not working and slash arguments warnings being displayed!

1. The site is stuck in **Maintenance mode**. Sometimes Moodle gets stuck in **Maintenance mode**, and the message _This site is undergoing maintenance and is currently unavailable_ appears despite your attempts to turn it off. When you put Moodle into **Maintenance mode**, it creates a `maintenance.html` file in `moodledata/maintenance.html`, the site file's directory. To fix this, try the following:

    - Check that the web server user has write permissions to the moodledata directory.
    - Manually delete the `maintenance.html` file.

1. Where to find the logs:

    - Syslog:
      - Either an error or access log is generated while someone accesses a page.
      - They're captured at this location: `/var/log/nginx/`.

    - Cron log:
      - The cron job will be running, and it will update the local copy in instance.
      - The path is `/var/log/sitelogs/moodle/cron.log`.
