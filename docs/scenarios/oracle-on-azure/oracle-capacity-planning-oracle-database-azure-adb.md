---
title: Capacity Planning for Oracle Autonomous Database@Azure
description: Guidance for capacity planning and resource optimization for Oracle Autonomous Database@Azure deployments.
author: gkayali
ms.author: guherk
ms.date: 08/13/2025
ms.topic: conceptual
ms.custom: e2e-oracle
---

# Capacity planning for Oracle Autonomous Database@Azure

Effective capacity planning ensures optimal performance, cost efficiency, and scalability for Oracle workloads in Oracle Autonomous Database@Azure. Follow these recommendations to establish a successful Oracle Autonomous Database@Azure deployment that scales with your business needs.

## Configure compute resources to meet performance goals

Compute resources in Oracle Autonomous Database@Azure are measured in ECPU units, which directly affect database performance and cost. Use these steps to optimize compute allocation:

 1. **Select the appropriate ECPU allocation based on your workload needs.** ECPU allocation determines query performance and scalability. Oracle Autonomous Database@Azure supports configurations from 2 to 512 ECPU. Choose the appropriate size based on workload intensity and performance targets.

2. **Enable Compute Auto Scaling for workloads with variable demand.** Auto Scaling adjusts compute resources automatically during peak demand. The system scales up to three times the base ECPU count. To request additional ECPU beyond this limit, follow the procedure in [Request Increased ECPU Limits](https://docs.oracle.com/en-us/iaas/Content/database-at-azure-autonomous/odadb-managing-autonomous-database-resources-azure.html).

- **Verify Auto Scaling settings in the Azure and OCI portals.** Confirm that Auto Scaling is enabled and configured correctly. Use the Resource Allocation interface under Settings in the Autonomous Database Service page in the Azure portal. For details, see [Use Auto Scaling](https://docs.oracle.com/en/cloud/paas/autonomous-database/serverless/adbsb/autonomous-auto-scale.html).

- **Schedule start and stop times for non-critical workloads**. Reduce costs by stopping databases during inactive periods. Configure these schedules as described in [Schedule Start and Stop Times for an Autonomous Database Instance](https://docs.oracle.com/en/cloud/paas/autonomous-database/serverless/adbsb/autonomous-auto-stop-start.html) from OCI console.

## Configure storage to support workload requirements

Storage capacity affects both performance and cost. Use these steps to plan and manage storage effectively:

1. **Select appropriate workload types**: Choose the correct workload configuration based on your use case:
  - Data Warehouse: 1 TB to 384 TB storage capacity
  - Transaction Processing, JSON, APEX: 20 GB to 393,216 GB storage capacity

2. **Enable Storage Auto Scaling to support growth.** Auto Scaling expands storage up to three times the reserved capacity. This feature is disabled by default, so enable it proactively to avoid manual intervention during growth.

- **Request additional storage capacity when needed**: Request extra storage capacity as needed through the [resource management process](https://docs.oracle.com/en-us/iaas/Content/database-at-azure-autonomous/odadb-managing-autonomous-database-resources-azure.html#GUID-2C088312-BC30-468E-A15A-00740D2818F5).

## Manage resources independently and efficiently

1. **Manage compute and storage independently.** Adjust ECPU and storage based on workload needs. Use the Azure portal or OCI console to make changes without downtime.

2. **Review storage reduction requirements before implementation.** Storage reduction requires specific conditions to be met. Review [storage shrinking requirements](https://docs.oracle.com/en/cloud/paas/autonomous-database/serverless/adbsb/autonomous-auto-scale.html#GUID-3EE6FBB5-58D5-477E-8EDE-0BDEAC99FA85) before implementation.


## Plan disaster recovery to maintain availability

1. **Use built-in local disaster recovery across availability zones.** Oracle Autonomous Database@Azure provides automatic backup-based recovery within the same Azure region. This feature does not require additional ECPU or storage.

2. **Account for resource consumption when using Autonomous Data Guard.** Ensure equal resource allocation for production and standby databases. For example, a 12 ECPU production database requires a 12 ECPU standby instance.

## Next step

> [!div class="nextstepaction"]
> [Migrate Oracle workloads to Azure](./oracle-migration-planning.md)
