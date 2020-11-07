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
        
On-premises might have different log path locations that need to be updated with Azure log paths. For example, /var/log/syslogs/moodle/access.log and /var/log/syslogs/moodle/error.log 
    
- Update the log files location. This command will open the configuration file:

  ```bash
  nano /etc/nginx/nginx.conf
  ```

- Change the log path location.

- Find access_log and error_log, and update the log path.

- Press **CTRL+o** to save and **CTRL+x** to exit.

            
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

- It's recommended for the certificate files to be read-only to the owner and for these files to be owned by owned by www-data:www-data.

  ```bash
  chown www-data:www-data /moodle/certs/nginx.*
   chmod 400 /moodle/certs/nginx.*
  ```

- To update the certificate location and open the configuration file:

  ```bash
  nano /etc/nginx/sites-enabled/*.conf
  ```

 - To change the certificate's path location, find 'ssl_certificate'. Update the certificate's path as below:
   
   /moodle/certs//moodle/certs/nginx.crt;
   /moodle/certs/nginx.key;

- Press **CTRL+o** to save the file and **CTRL+x** to exit.
          

### Update the local HTML copy
        
The Moodle html site (/moodle/html/moodle) content's local copy is created in the virtual machine scale set at /var/www/html/moodle. The local copy is updated only when there is an update in timestamp. Execute the following command from the controller virtual machine to update the timestamp. 

  ```bash
  sudo -s
  /usr/local/bin/update_last_modified_time.moodle_on_azure.sh
  ```

-  Every time that the script in the last modified timestamp file (/moodle/html/moodle/last_modified_time.moodle_on_azure) is executed, the /moodle/html/moodle directory content is updated in the local copy (/var/www/html).
        
### Restart servers
        
- Restart the nginx and php-fpm servers.

  ```bash
  sudo systemctl restart nginx
  sudo systemctl restart php<phpVersion>-fpm
  ```

### Map the DNS name to the Azure Load Balancer IP

- DNS name mapping to the Azure Load Balancer IP must be done at the hosting-provider level.

- Disable the Moodle website from the maintenance mode.

- Run the following command in the controller virtual machine:

  ```bash
  sudo /usr/bin/php admin/cli/maintenance.php --disable
  ```

- To check the status of the moodle site, run the following command:

  ```bash
  sudo /usr/bin/php admin/cli/maintenance.php
  ```

- Hit the DNS name to get the migrated Moodle web page.

## Frequently asked questions and troubleshooting

<details> 
<summary>(Select expand for similar questions!)</summary>

1. Error: The database connection has failed: For errors like _database connection failed_ or _could not connect to the database you specified_, here are some potential reasons and solutions.
	
- Your database server isn't installed or running. To check this for MySQL, try typing the following the following command:

  ```
  $telnet database_host_name 3306
  ```

- You should get a cryptic response which includes the version number of the MySQL server.

- If you're attempting to run two instances of Moodle on different ports, use the IP address of the host (not localhost) in the $CFG->dbhost setting; for example, $CFG->dbhost = 127.0.0.1:3308.

- You haven't created a Moodle database or assigned a user with the correct privileges to access it.

- The Moodle database settings aren't correct. The database name, database user, or database user password in your Moodle configuration file config.php aren't correct. 
        
- Check that there aren't apostrophes or non-alphabetic letters in your MySQL username or password.
		
2. Error: _500:Internal Server Error": There are several possible causes for this error. Start by checking your web server error log, which should have a more comprehensive explanation. Here are some known possibilities:
			
- There's a syntax error in your .htaccess or httpd.conf files. The way in which directives are written differs depending on which file you are using. You can use the following command to test for configuration errors in your nginx files:

  ```
  nginx -t
  ```

- The web server executes under your own user name, and all files have a maximum permissions level of 755. Check that this is set for your Moodle directory in your control panel, or use this command if you have access to the shell:

  ```
  chmod -R 755 moodle
  ```

3. Error: _403: Forbidden_.

This error means that the PHP memory_limit value isn't enough for the PHP script. The memory_limit value is the allowed memory size, which is 64M in the example above (67108864 bytes / 1024 = 65536 KB. 65536 KB / 1024 = 64 MB). You'll need to increase the PHP memory_limit value until this message is gone. There are two methods of doing this:

Method one: On a hosted installation, you should ask your host's support how to do this. Many allow .htaccess files. If yours does, add the following line to your .htaccess file, or create one in the Moodle directory if it doesn't already exist:

```
php_value memory_limit <value>M
Example: php_value memory_limit 40M
```

Method two: If you have your own server with shell access, edit your php.ini file. Make sure that it's the correct one by checking in your phpinfo output:

```
memory_limit <value>M
Example: memory_limit 40M
```

Remember that you need to restart your web server to make changes to php.ini effective. An alternative is to disable the memory_limit by using the command memory_limit 0.

4. Can't log in; stuck on the login screen.

This can also apply if you see _Your session has timed out. Please log in again._ or _A server error that affects your login session was detected. Please login again or restart your browser._ The following are potential causes and actions that you can take to resolve this:

- Check first that your main admin account (which will be a manual account) is also a problem. If your users are using an external authentication method (for example, LDAP), then that could be the problem. Isolate the cause, and verify that it's with Moodle before going any further.

- Check that your hard disk isn't full, that your server is on shared hosting, and that you haven't reached your disk space quota. This will prevent new sessions from being created, and no one will be able to log in.

- Carefully check the permissions in your 'moodledata' area. The web server needs to be able to write to the 'sessions' subdirectory.
 
5. Fatal error: _$CFG->dataroot is not writable. The admin has to fix directory permissions! Exiting._

- Check that Moodle and moodledata permissions are www-data:www-data only. If not, change the group and ownership permissions. The following command updates the permissions:

  ```
  sudo chown -R /moodle/moodledata
  ```

6. Couldn't find a top-level course.

- If this appears immediately after you attempted to install, Moodle it almost certainly means that the installation didn't complete. A complete installation will ask you for the administrator profile and to name the site just before it completes. Check your logs for errors. Then drop the database and start again. If you used the web-based installer, try the command line one.

7. The login link does not change upon logging in. I am logged in and can't navigate freely: Make sure the URL in your $CFG->wwwroot setting is exactly the same as the one you are actually using to access the site.

8. Errors when uploading a file:

- If you obtain a _File not found_ error when uploading a file, it indicates that slash arguments aren't enabled on your web server. Try enabling it.

- If your web server doesn't support slash arguments, its use in Moodle can be disabled by un-ticking the checkbox **Use slash arguments** in Administration > Site administration > Server > HTTP

- ![Warning:] Disabling slash arguments will result in SCORM packages not working and slash arguments warnings being displayed!

9. The site is stuck in maintenance mode. Sometimes Moodle gets stuck in maintenance mode, and the message _This site is undergoing maintenance and is currently unavailable_ appears despite your attempts to turn off maintenance mode. When you put Moodle into maintenance mode, it creates a file called maintenance.html in moodledata/maintenance.html, the site file's directory). To fix this, try the following:

- Check that the web server user has write permissions to the moodledata directory.
- Manually delete the maintenance.html file.
	
10. Where to find the logs:

- Syslog:
  - Either an error or access log is generated while someone accesses a page.
  - They're captured at /var/log/nginx/ location.
        
- Cron log:
  - The cron job will be running, and it will update the local copy in instance.
  -  The path is /var/log/sitelogs/moodle/cron.log.
  
</details> 

## Next steps

TBD