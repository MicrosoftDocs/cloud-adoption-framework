---
title: Capacity Planning for Oracle Database@Azure Using Autonomous Database Service
description: Learn how capacity planning can help you select the appropriate infrastructure for Oracle workloads on Oracle Autonomous Database@Azure.
author: gkayali
ms.author: guherk
ms.date: 05/30/2025
ms.topic: conceptual
ms.custom: e2e-oracle
---

# Capacity planning for Oracle Autonomous Database@Azure

Oracle Database@Azure is an Oracle database service that runs on Oracle Cloud Infrastructure (OCI) and is colocated in Azure datacenters at Microsoft. This joint offering from Microsoft and Oracle requires you to plan and manage resources across both cloud platforms.

This article covers Storage and Compute capacity considerations and recommendations when deploying Oracle Autonomous Database@Azure.  

> [!NOTE]
> For Oracle Autonomous Database@Azure sizing, [reach out to your local Oracle sales team](https://www.oracle.com/cloud/azure/oracle-database-at-azure/).

## Storage & Compute Considerations

- Each Oracle Autonomous Database@Azure is capable of scaling from two ECPU up to 512 ECPU. It should be noted that one OCPU is approximately equivalent to four ECPU. 
- Enabling Compute Auto Scaling permits the system to expand up to three times the specified ECPU count as demand increases. If workload necessities exceed three times the auto scaling ECPU, request extra ECPU by following the procedure from [Request Increased ECPU Limits](https://docs.oracle.com/en-us/iaas/Content/database-at-azure-autonomous/odadb-managing-autonomous-database-resources-azure.html#GUID-2C088312-BC30-468E-A15A-00740D2818F5). 
- By default, Oracle Autonomous Database has Compute Auto Scaling enabled and Storage Auto Scaling disabled. 
To check in Auto Scaling Manage Resource Allocation from the Azure and OCI portal. For more details on Compute Auto Scaling, see [Use Auto Scaling](https://docs.oracle.com/en/cloud/paas/autonomous-database/serverless/adbsb/autonomous-auto-scale.html#GUID-27FAB1C1-B09F-4A7A-9FB9-5CB8110F7141). 
- Oracle Autonomous Database@Azure supports different workloads such as Data Warehouse, Transaction Processing, JSON, and APEX. 
The Data Warehouse workload can scale storage from one TB to 384 TB, while other workloads can scale storage from 20 GB to 393216 GB. 
Storage Auto Scaling can be enabled for automatic expansion up to three times the reserved storage. For details on Storage Auto Scaling, see [Use Auto Scaling](https://docs.oracle.com/en/cloud/paas/autonomous-database/serverless/adbsb/autonomous-auto-scale.html#GUID-27FAB1C1-B09F-4A7A-9FB9-5CB8110F7141). 
- Extra ECPU or storage can be requested after provisioning Oracle Autonomous Database@Azure. For more details, see [Request Increased Storage or ECPU Limits](https://docs.oracle.com/en-us/iaas/Content/database-at-azure-autonomous/odadb-managing-autonomous-database-resources-azure.html#GUID-2C088312-BC30-468E-A15A-00740D2818F5).
- ECPU and storage can be configured and scale separately from Azure or OCI console and adjusted later as needed. ECPU allocation and storage scaling are seamless.  
- Shrinking the Autonomous Database storage space after provisioned can only be performed from OCI console. Conditions for shrinking the database storage are found under [Shrink Storage](https://docs.oracle.com/en/cloud/paas/autonomous-database/serverless/adbsb/autonomous-auto-scale.html#GUID-3EE6FBB5-58D5-477E-8EDE-0BDEAC99FA85). 
- Schedule start and stop times for noncritical Oracle Autonomous Database@Azure workloads to save on operational costs when not in use. For details, see [Schedule Start and Stop Times for an Autonomous Database Instance](https://docs.oracle.com/en/cloud/paas/autonomous-database/serverless/adbsb/autonomous-auto-stop-start.html).
-  A local backup based disaster recovery is automatically provided in a different availability zone within the same Azure region as the primary Autonomous Database. No additional ECPU and Storage provisioning is required for the local disaster recovery standby database. Details can be found in [Manage Disaster Recovery for Autonomous Database Services](https://docs.oracle.com/en-us/iaas/Content/database-at-azure-autonomous/odadb-managing-autonomous-database-resources-azure.html#GUID-55B688D8-17DE-4CD9-9810-7A480532D6AE). 
- In managing Disaster Recovery for Oracle Autonomous Database@Azure, both the production and secondary Disaster Recovery environments consume an equal amount of ECPU and storage. For example, a 12 ECPU production instance with Autonomous Data Guard configured for Disaster Recovery results in the secondary Disaster Recovery database being provisioned with the same 12 ECPU size. 

## Next step

> [!div class="nextstepaction"]
> [Migrate Oracle workloads to Azure](./oracle-migration-planning.md)
