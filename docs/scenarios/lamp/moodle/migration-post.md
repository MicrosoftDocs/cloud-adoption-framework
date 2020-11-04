---
title: How to follow up after a Moodle migration
description: Learn how to follow up after Moodle migration.
author: TBD
ms.author: TBD
ms.date: 11/06/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenarios
---

# How to follow up after a Moodle migration

## Post-migration tasks

Post migration tasks are around final application configuration that includes setting up logging destinations, SSL certificates and scheduled tasks / cron jobs.

- Post migration tasks that include application configuration.
- Update log paths in virtual machine scale set instance(s).
- Restart servers in virtual machine scale set instance(s).
- Update Certificates.
- Update certificate location.
- Update HTML Local Copy.
- Restartt PHP and nginx servers.
- Map the DNS name to the Azure Load Balancer IP.

## Controller virtual machine scale set
    
### Log paths
        
- On-premises might be having different log path location and those paths need to be updated with Azure log paths.
    - Ex: /var/log/syslogs/moodle/access.log
    - Ex: /var/log/syslogs/moodle/error.log 
- Update log files location. This command will open the configuration file:
      ```bash
      nano /etc/nginx/nginx.conf
      ```
- Change the log path location.
- Find access_log and error_log and update the log path.
- After the changes, and save the file. 
- Press CTRL+o to save and CTRL+x to exit.
            
### Restart servers
        
Restart the nginx and php-fpm servers:
       ```bash
       sudo systemctl restart nginx
       sudo systemctl restart php<phpVersion>-fpm
       ```

## Controller virtual machine

### Certificates

        -   Log in to the Controller Virtual Machine and follow the below steps.
        -   The certificates for your moodle application reside in /moodle/certs.
        -   Copy over the .crt and .key files over to /moodle/certs/. The file names should be changed to nginx.crt and nginx.key in order to be recognized by the configured nginx servers. Depending on your local environment, you may choose to use the utility SCP or a tool like WinSCP to copy these files over to the controller virtual machine.
            -   Command to change the certs name.
                ```bash
                cd /path/to/certs/location
                mv /path/to/certs/location/*.key /moodle/certs/nginx.key
                mv /path/to/certs/location/*.crt /moodle/certs/nginx.crt
                ```
        -   You can also generate a self-signed certificate, useful for testing only.
            
            ```bash
            openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
            -keyout /moodle/certs/nginx.key \
            -out /moodle/certs/nginx.crt \
            -subj "/C=US/ST=WA/L=Redmond/O=IT/CN=mydomain.com"
            ```
        -   It is recommended that the certificate files be read-only to owner and that these files are owned by www-data:www-data.
            ```bash
            chown www-data:www-data /moodle/certs/nginx.*
            chmod 400 /moodle/certs/nginx.*
            ```
        -   Update Certs location.
            ```bash
            nano /etc/nginx/sites-enabled/*.conf
            # Above command will open the configuration file.
            # 
            # Change the certs path location.
            # Find ssl_certificate and update the certs path as below
            # /moodle/certs//moodle/certs/nginx.crt;
            # /moodle/certs/nginx.key;
            #
            # After the changes, save the file. 
            # Press CTRL+o to save and CTRL+x to exit. 
            ```

### Update the local HTML copy
        
        - Moodle html site (/moodle/html/moodle) content's local copy is created in the virtual machine scale set at /var/www/html/moodle.
        - Local copy is updated only when there is an update in timestamp.
        -   Execute the below command from Controller Virtual Machine to update the timestamp. 
            ```bash
            sudo -s
            /usr/local/bin/update_last_modified_time.moodle_on_azure.sh
            ```
        -  By executing the script last modified timestamp file (/moodle/html/moodle/last_modified_time.moodle_on_azure)  every time the /moodle/html/moodle directory content is updated in local copy (/var/www/html).
        
### Restart servers
        
        -   Restart the nginx and php-fpm servers.
            ```bash
            sudo systemctl restart nginx
            sudo systemctl restart php<phpVersion>-fpm
            ```

### Map DNS name with the Azure Load Balancer IP

        -   DNS name mapping with the Azure Load Balancer IP must be done at the hosting provider level.
        -   Disable Moodle website from Maintenance mode.
            - Run the below command in Controller Virtual Machine.
                ```bash
                sudo /usr/bin/php admin/cli/maintenance.php --disable
                ```
            - To check the status of the moodle site run the below command.
                ```bash
                sudo /usr/bin/php admin/cli/maintenance.php
                ```
        -   Hit the DNS name to get the migrated Moodle web page.

## Frequently asked questions and troubleshooting

<details> 
<summary>(For Similar questions click on expand!)</summary>

1.   Error: database connection failed: If you get errors like "database connection failed" or "could not connect to the database you specified", here are some possible reasons and some possible solutions.
	
		- 	Your database server is not installed or running. To check this for MySQL try typing the following command line
			```
			$telnet database_host_name 3306
			```
		- You should get a cryptic response which includes the version number of the MySQL server.
		- If you are attempting to run two instances of Moodle on different ports, use the ip address of the host (not localhost) in the $CFG->dbhost setting, e.g. $CFG->dbhost = 127.0.0.1:3308.
		- You have not created a Moodle database and assigned a user with the correct privileges to access it.
        - The Moodle database settings are incorrect. The database name, database user or database user password in your Moodle configuration file config.php are incorrect. 
		- Check that there are no apostrophes or non-alphabetic letters in your MySQL username or password.
2.  Error: "500:Internal Server Error": There are several possible causes for this error. It is a good idea to start by checking your web server error log which should have a more comprehensive explanation. However, here are some known possibilities....
			
	- There is a syntax error in your .htaccess or httpd.conf files. The way in which directives are written differs depending on which file you are using. You can test for configuration errors in your nginx files using the command:
		```
		nginx -t
		```
    - you may also see a 403: Forbidden error.
	-  the web server executes under your own username and all files have a maximum permissions level of 755. Check that this is set for your Moodle directory in your control panel or (if you have access to the shell) use this command:
		```
		chmod -R 755 moodle
		```
3. Error "403: Forbidden".

	- This error means that the php memory_limit value is not enough for the php script. The memory_limit value is the "allowed memory size" - 64M in the example above (67108864 bytes / 1024 = 65536 KB. 65536 KB / 1024 = 64 MB). You will need to increase the php memory_limit value until this message is not shown anymore. There are two methods of doing this.
	- On a hosted installation you should ask your host's support how to do this. However, many allow .htaccess files. If yours does, add the following line to your .htaccess file (or create one in the moodle directory if it does not already exist):
		```
		php_value memory_limit <value>M
		Example: php_value memory_limit 40M
		```
	- If you have your own server with shell access, edit your php.ini file (make sure it is the correct one by checking in your phpinfo output) as follows:
		```
		memory_limit <value>M
		Example: memory_limit 40M
		```
	- Remember that you need to restart your web server to make changes to php.ini effective. An alternative is to disable the memory_limit by using the command memory_limit 0.

4. I can't log in - I just stay stuck on the login screen
	
	- This may also apply if you are seeing “Your session has timed out. Please login again” or "A server error that affects your login session was detected. Please login again or restart your browser" and can't log in.
	- The following are possible causes and actions you can take.
	- Check first that your main admin account (which will be a manual account) is also a problem. If your users are using an external authentication method (e.g. LDAP) that could be the problem. Isolate the fault and make sure it really is Moodle before going any further.
	- Check that your hard disk is not full or if your server is on shared hosting check that you have not reached your disk space quota. This will prevent new sessions being created and nobody will be able to log in.
	- Carefully check the permissions in your 'moodledata' area. The web server needs to be able to write to the 'sessions' subdirectory. 
5. Fatal error: $CFG->dataroot is not writable, admin has to fix directory permissions! Exiting.

	- Check the moodle and moodledata permissions and make sure they are www-data:www-data only. If not change the group and ownership permissions.
	- Command to update the permissions

		```
		sudo chown -R /moodle/moodledata
		```

6. Could not find a top level course

	- If this appears immediately after you have attempted to install Moodle it almost certainly means that the installation did not complete. A complete installation will ask you for the administrator profile and to name the site just before it completes. Check your logs for errors. Then drop the database and start again. If you used the web-based installer try the command line one.

7. I log in but the login link does not change. I am logged in and can navigate freely.

	- Make sure the URL in your $CFG->wwwroot setting is exactly the same as the one you are actually using to access the site.

8. Error when uploading a file

 	- If you obtain a 'File not found' error when uploading a file, it indicates that slash arguments are not enabled on your web server. Please try enabling it.
	- If your web server does not support slash arguments, its use in Moodle can be disabled by un-ticking the checkbox 'Use slash arguments' in Administration > Site administration > Server > HTTP.
	- Warning: Disabling the use of slash arguments will result in SCORM packages not working and slash arguments warnings being displayed!

9. Site is stuck in maintenance mode

	- Sometimes Moodle gets stuck in maintenance mode and you will see the message "This site is undergoing maintenance and is currently unavailable" despite your attempts to turn-off maintenance mode.
	- When you put Moodle into maintenance mode it creates a file called maintenance.html in moodledata/maintenance.html (the site files directory). To fix this try the following:
	- Check that the web server user has write permissions to the moodledata directory.
	- Manually delete the maintenance.html file.
10. Where to find the logs

	- Syslog
        - While accessing a page either error or access log are generated.
        - They are captured at /var/log/nginx/ location.
	- Cron Log
        - Cron job will be running and it will update the local copy in instance.
        -  The path is  /var/log/sitelogs/moodle/cron.log.
</details> 

## Next steps