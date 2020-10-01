## **Pre-Migration:**
- Data Export from on-premises to Azure involves the following tasks.
    -   Install Azure CLI.
    -   Create Subscription.
    -   Create Resource Group.
    -   Create Storage Account.
    -   Backup of on-premises data.
    -   Download and install AzCopy.
    -   Copy Archive file to Blob storage.

-   **Data Export from on-premises to Azure Cloud:**
    -   **Install Azure CLI**
        -   Install Azure CLI on a host inside the on-premises infrastructure for all Azure related tasks.
            ```bash
            curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
            ```
        -   Now login into your Azure account.
            ```bash
            az login
            ```
         - az login: Azure CLI will quite likely launch an instance or a tab inside your default web-browser and prompt you to login to Azure using your Microsoft Account.
          - If the above browser launch does not happen, open a browser page at  [https://aka.ms/devicelogin](https://aka.ms/devicelogin) and enter the authorization code displayed in your terminal.
        -  To use command line use below command.
            ```bash
            az login -u <username> -p <password>
            ```
    
    -   **Create Subscription:**
        - If you have a subscription handy, set the subscription and skip this step.
           
        - And if you do not have a subscription, you can choose to [create one within the Azure Portal](https://ms.portal.azure.com/#blade/Microsoft_Azure_Billing/SubscriptionsBlade) or opt for a [Pay-As-You-Go](https://azure.microsoft.com/en-us/offers/ms-azr-0003p/)
        - To create the subscription using azure portal, navigate to Subscription from Home section.
        ![image](/images/subscription1.png)

        - Command to set the subscription.
            ```bash
            az account set --subscription "Subscription Name"

            # Example: az account set --subscription "ComputePM LibrarySub"
            ```

        
    -   **Create Resource Group:**
        - Once you have a subscription handy, you will need to create a Resource Group.
        - One option is to create resource group using Azure portal.
        - Navigate to home section and search for resource group, after clicking on add fill the mandatory fields and click on create.

       	 ![image](/images/rg1.png)
        - Alternatively, you can use the Azure CLI command to create a resource group.
        - Provide the same default Location provided in previous steps.
        - More details on [Location in Azure](https://azure.microsoft.com/en-in/global-infrastructure/data-residency/).
            ```bash
            az group create -l location -n name -s Subscription_NAME_OR_ID
            # Update the screenshot and subscription name with sample test account

            # example: az group create -l eastus -n manual_migration -s ComputePM LibrarySub
            ```
         - In above step resource group is created as "manual_migration". Use the same resource group in further steps.
    -   **Create Storage Account:**
        -  The next step would be to [create a Storage Account](https://ms.portal.azure.com/#create/Microsoft.StorageAccount) in the Resource Group you've just created.
        - Storage account can also be created using Azure portal or Azure CLI command.
        - To create using portal, navigate to portal and search for storage account and click on Add button.
        - After filling the mandatory details, click on create.
        ![image](/images/storageaccountcreating.png)
        - Alternatively, you can use Azure CLI command.
            ```bash
            az storage account create -n storageAccountName -g resourceGroupName --sku Standard_LRS --kind BlobStorage -l location

            # Example: az storage account create -n onpremisesstorage -g manual_migration --sku Standard_LRS --kind BlobStorage -l eastus
            
            # In the above command --kind Indicates the type of storage account.
            ```

        - Once the storage account "onpremisesstorage" is created, this is used as the destination to take the on-premises backup.
    
    -   **Backup of on-premises data:**
        - Before taking backup of on-premises data, enable maintenance mode for moodle site.
            - Run the below command in on-premises virtual machine.
                ```bash
                sudo /usr/bin/php admin/cli/maintenance.php --enable
                ```
            - To check the status of the moodle site run the below command.
                ```bash
                sudo /usr/bin/php admin/cli/maintenance.php
                ```
        - Take backup of on-premises data such as moodle, moodledata, configurations and database backup file to a single directory. The following illustration should give you a good idea.

	    	![image](/images/directorystructure.png)

        - First create an empty storage directory in any desired location to copy all the data.

            ```bash
            sudo -s
            # For example, the location is /home/azureadmin.
            cd /home/azureadmin
            mkdir storage
            ```

    - **Backup of moodle and moodledata**
        - The moodle directory consists of site HTML content and moodledata contains moodle site data.

        ```bash
        # Commands to copy moodle and moodledata 
        cp -R /var/www/html/moodle /home/azureadmin/storage/
        cp -R /var/moodledata /home/azureadmin/storage/
        ```
	- **Backup of PHP and webserver configuration**
		- Copy the PHP configuration files such as php-fpm.conf, php.ini, pool.d and conf.d directory to phpconfig directory under the configuration directory.
		- Copy the ngnix configuration such as nginx.conf, sites-enabled/dns.conf to the nginxconfig directory under the configuration directory.
            ```bash
            cd /home/azureadmin/storage
            mkdir configuration
            # command to copy nginx and php configuration.
            cp -R /etc/nginx /home/azureadmin/storage/configuration/nginx
            cp -R /etc/php /home/azureadmin/storage/configuration/php
            ```

	- **Create a backup of database**
		- If you already have mysql-client installed, skip the step to install mysql-client.
		- If you do not have mysql-client, now would be a good time to do that.
			```bash
			sudo -s
			# command to check mysql-client is installed or not.
			mysql -V
			
            # if the mysql-client is not installed, install the same by following command.
			sudo apt-get install mysql-client
			
            #following command will allow to you to take the backup of database.
			mysqldump -h dbServerName -u dbUserId -pdbPassword dbName > /home/azureadmin/storage/database.sql
			# Replace dbServerName, dbUserId, dbPassword and dbName with on-premises database details.
			```

	- Create an archive storage.tar.gz file of backup directory.
        ```bash
        cd  /home/azureadmin/
        tar -zcvf storage.tar.gz storage
    	```

    -   **Download and install AzCopy**
        - Execute the below commands to install AzCopy.
        ```bash
        sudo -s
        wget https://aka.ms/downloadazcopy-v10-linux
        tar -xvf downloadazcopy-v10-linux
        sudo rm /usr/bin/azcopy
        sudo cp ./azcopy_linux_amd64_*/azcopy /usr/bin/
        ```

    -   **Copy Archive file to Blob storage**
        - Copy the on-premises archive file to blob storage using AzCopy.
        - To use AzCopy, user should generate SAS Token first.
        - Go to the created Storage Account Resource and navigate to Shared access signature in the left panel.

			![image](/images/storageaccountcreated.PNG)
        - Select the Container, object checkboxes and set the start, expiry date of the SAS token. Click on "Generate SAS and Connection String".

            ![image](images/SAStokengeneration.PNG)
        
        - Copy and save the SAS token for further use.

        
        - Command to create a container in the storage account.
            ```bash
            az storage container create --account-name <storageAccontName> --name <containerName> --auth-mode login

            # Example: az storage container create --account-name onpremisesstorage --name migration --auth-mode login

            # --auth-mode login means authentication mode as login, after login the container will be created.
            ```
        - Container can be created using Azure Portal, navigate to the same storage account created and click on container and click on Add button.
            
        - After giving the mandatory container name, click on create button.
    
    ![image](images/cc.png)
    
    -   Command to copy archive file to blob storage.
        ```bash
        sudo azcopy copy '/home/azureadmin/storage.tar.gz' 'https://<storageAccountName>.blob.core.windows.net/<containerName>/<SAStoken>'

        # Example: azcopy copy '/home/azureadmin/storage.tar.gz' 'https://onpremisesstorage.blob.core.windows.net/migration/?sv=2019-12-12&ss='
        ```
        ![image](images/ArchivefileinBlobstorage.PNG)
    -  Now, you should have a copy of your archive inside the Azure blob storage account.

