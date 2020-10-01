-   **Setup Moodle controller instance and worker nodes**    
-   **Virtual Machine Scale Set**
    -   VMSS instances are assigned with Private IP and can be accessible only with the controller virtual machine which is associated with in the same Virtual Network.
    -   For connecting the VMSS instance with private IP, need to have gateway enabled. 
    -   [Deploy Virtual Network Gateway](/vpngateway.md) to set the gateway access to VMSS instances. 
    -   Before accessing Virtual Machine Scale Set, please make sure that VMSS is password enabled.
    -   *Get Virtual Machine Scale Set Private IP:*
        -   To get the Virtual Machine Scale Set instances private IP follow the below steps.
        -   Login to [Azure](portal.azure.com) and go to the created Resource Group.
        -   Find and navigate to the Virtual Machine Scale Set resource.
        -   In the left panel, select the Instances.
        -   Navigate to the running instance and find the Private IP associated to it in the Overview section.
    
    -   To login into Virtual Machine Scale Set, first login to Controller Virtual Machine and run the set of commands.
        ```bash
        sudo -s
        sudo ssh azureadmin@172.31.X.X 

        # 172.31.X.X is the Virtual Machine Scale Set Instance private IP.
        ```
    -   Login to Scale Set Virtual Machine instance and execute the following sequence of steps.
    
    -   A backup directory is extracted as storage/ at /home/azureadmin.
        -   This storage directory contains moodle, moodledata and configuration directory along with database backup file. These will be copied to desired locations.
        - Create a backup directory.
            ```bash
            cd /home/azureadmin/
            mkdir -p backup
            mkdir -p backup/moodle
            ```
        
    - **Configuring PHP & webserver**
        - Create a backup of php and webserver configuration.
            ```bash
            # Set PHP version to a variable.
            _PHPVER=`/usr/bin/php -r "echo PHP_VERSION;" | /usr/bin/cut -c 1,2,3`
            echo $_PHPVER

            sudo mv /etc/nginx/sites-enabled/*.conf  /home/azureadmin/backup/
            sudo mv /etc/php/$_PHPVER/fpm/pool.d/www.conf /home/azureadmin/backup/www.conf  
            ```
        - Copy the php and webserver configuration files.
            ```bash
            sudo cp /moodle/config/nginx/*.conf  /etc/nginx/sites-enabled/
            sudo  cp /moodle/config/php/www.conf /etc/php/$_PHPVER/fpm/pool.d/ 
            ```
        -   Install Missing PHP extensions.
                - ARM template install the following PHP extensions.
                    - fpm, cli, curl, zip, pear, mbstring, dev, mcrypt, soap, json, redis, bcmath, gd, mysql, xmlrpc, intl, xml and bz2.
            -   To know the PHP extensions which are installed on on-premises run the below command on on-premises virtual machine to get the list.
                ```bash
                php -m
                ```
            - Note: If on-premises has any additional PHP extensions which are not present in Controller Virtual Machine can be installed manually.
                ```bash
                sudo apt-get install -y php-<extensionName>
                ```