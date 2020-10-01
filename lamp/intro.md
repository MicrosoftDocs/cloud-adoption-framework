## Moodle Manual Migration
- This document explains how to migrate Moodle application from an on-premises environment to Azure. 
- For each of the steps, you have two approaches provided.
    - One that lets you to use Azure Portal. 
    - Other that lets you accomplish the same tasks on a command line using Azure CLI.
### Migrating Moodle using ARM Template  
- Migration of Moodle with an ARM template creates the infrastructure in Azure.
- Once the infrastructure is created, the Moodle software stack and associated dependencies are migrated.
## Prerequisites
- If the versions of the software stack deployed on-premises are lagging with respect to the versions supported in this guide, the expectation is that the on-premises versions will be updated/patched to the versions listed in this guide.
- Must have access to the on-premises infrastructure to take backup of Moodle deployment and configurations (including DB configurations).
- Azure subscription and Azure Blob storage should be created prior to migration.
- Make sure to have Azure CLI and Az Copy handy.
- Make sure Moodle website should be in maintenance mode.
- This migration guide supports the following software versions:   
     - Ubuntu 18.04 LTS
     - Nginx 1.14
     - MySQL 5.6, 5.7 or 8.0 database server (This guide uses Azure Database for MYSQL)
     - PHP 7.2, 7.3, or 7.4
     - Moodle 3.8 & 3.9
## Migration Approach
-   Migration of Moodle application to Azure is broken down in the following three stages:
    - Pre-migration tasks.
    - Actual migration of the application.
    - Post-migration tasks.
