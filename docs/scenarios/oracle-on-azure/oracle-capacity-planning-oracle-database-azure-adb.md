---
title: Capacity Planning for Oracle Autonomous Database@Azure
description: Guidance for capacity planning and resource optimization for Oracle Autonomous Database@Azure deployments.
author: gkayali
ms.author: guherk
ms.date: 06/16/2025
ms.topic: conceptual
ms.custom: e2e-oracle
---

# Capacity planning for Oracle Autonomous Database@Azure

Effective capacity planning ensures optimal performance, cost efficiency, and scalability for Oracle workloads in Oracle Database@Azure. Follow these recommendations to establish a successful Oracle Autonomous Database@Azure deployment that scales with your business needs.

## Configure compute resources for optimal performance

Compute resources in Oracle Autonomous Database@Azure are measured in ECPU units that directly impact database performance and capacity. Proper configuration of compute resources ensures your database meets performance requirements while avoiding unnecessary costs. 
Follow these steps:

 **Select the appropriate ECPU allocation based on your workload needs**. The proper ECPU allocation directly impacts query performance for your database workload. Oracle Autonomous Database@Azure scales from 2 ECPU to 512 ECPU.

- **Enable Compute Auto Scaling for workloads with variable demand**. Auto Scaling dynamically adjusts resources to maintain performance during peak usage periods without manual intervention. The system can automatically expands compute resources up to three times the base ECPU count as demand increases, and you can request additional ECPU if needed using the procedure in [Request Increased ECPU Limits](https://docs.oracle.com/en-us/iaas/Content/database-at-azure-autonomous/odadb-managing-autonomous-database-resources-azure.html).

- **Verify Auto Scaling settings in the Azure and OCI portals**. Proper configuration validation ensures your database scales as expected during operation. Oracle Autonomous Database has Compute Auto Scaling enabled by default, but you should confirm this setting matches your requirements through the Resource Allocation interface under Settings from Autonomous Database Service page from Azure portal. For more details, see [Use Auto Scaling](https://docs.oracle.com/en/cloud/paas/autonomous-database/serverless/adbsb/autonomous-auto-scale.html).

- **Schedule start and stop times for non-critical workloads**. Scheduling reduces operating costs by automatically stopping the database during periods of inactivity.  Configure these schedules as decribed in [Schedule Start and Stop Times for an Autonomous Database Instance](https://docs.oracle.com/en/cloud/paas/autonomous-database/serverless/adbsb/autonomous-auto-stop-start.html) from OCI console.

## Configure Storage for optimal performance

Storage capacity in Oracle Autonomous Database@Azure is the amount of data your database can manage and directly impacts database performance. Proper storage planning ensures adequate capacity while controlling expenses. Follow these steps:
 
- **Select appropriate workload types**: Choose the correct workload configuration based on your use case:
  - Data Warehouse: 1 TB to 384 TB storage capacity
  - Transaction Processing, JSON, APEX: 20 GB to 393,216 GB storage capacity
- **Configure Storage Auto Scaling**: Enable automatic storage expansion to allow the system to scale up to three times your reserved capacity, accommodating growth without manual intervention. This feature is disabled by default.
- **Plan for future scaling**: Request additional storage capacity as needed through the [resource management process](https://docs.oracle.com/en-us/iaas/Content/database-at-azure-autonomous/odadb-managing-autonomous-database-resources-azure.html#GUID-2C088312-BC30-468E-A15A-00740D2818F5).

## Resource management best practices

- **Manage compute and storage independently**: Scale ECPU and storage separately based on specific workload requirements. Both resources can be adjusted seamlessly through Azure portal or OCI console.
- **Understand storage reduction limitations**: Storage reduction requires specific conditions to be met. Review [storage shrinking requirements](https://docs.oracle.com/en/cloud/paas/autonomous-database/serverless/adbsb/autonomous-auto-scale.html#GUID-3EE6FBB5-58D5-477E-8EDE-0BDEAC99FA85) before implementation.


## Disaster recovery planning

- **Leverage built-in local disaster recovery**: Utilize the automatic local backup-based disaster recovery across availability zones within your Azure region. This requires no additional ECPU or storage provisioning.
- **Plan for Resource Consumption When Transitioning from Backup-Based DR to Autonomous Data Guard**: Account for equal resource consumption between production and disaster recovery environments. For instance, a 12 ECPU production autonomous database requires the same 12 ECPU allocation for the standby database.

## Next step

> [!div class="nextstepaction"]
> [Migrate Oracle workloads to Azure](./oracle-migration-planning.md)
