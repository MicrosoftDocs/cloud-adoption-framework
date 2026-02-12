---
title: Capacity Planning for Oracle Autonomous Database@Azure
description: Learn about capacity planning, resource optimization, and performance tuning for Oracle Autonomous Database@Azure deployments.
author: gkayali
ms.author: guherk
ms.date: 08/13/2025
ms.topic: concept-article
ms.custom: e2e-oracle
---

# Capacity planning for Oracle Autonomous Database@Azure

Effective capacity planning ensures optimal performance, cost efficiency, and scalability for Oracle workloads in Oracle Autonomous Database@Azure. Follow these recommendations to deploy Oracle Autonomous Database@Azure that scales with your business needs.

## Configure compute resources to meet performance goals

Compute resources in Oracle Autonomous Database@Azure are measured in elastic compute processing units (ECPUs), which directly affect database performance and cost. To optimize compute allocation:

1. **Select the appropriate ECPU allocation based on your workload needs.** ECPU allocation determines query performance and scalability. Oracle Autonomous Database@Azure supports configurations from 2 to 512 ECPUs. Choose the appropriate size based on workload intensity and performance targets.

1. **Enable compute autoscaling for workloads that have variable demand.** Autoscaling adjusts compute resources automatically during peak demand. The system scales up to three times the base ECPU count. To request extra ECPUs beyond this limit, see [Request increased ECPU limits](https://docs.oracle.com/iaas/Content/database-at-azure-autonomous/odadb-managing-autonomous-database-resources-azure.html).

   - **Verify autoscaling settings in the Azure and Oracle Cloud Infrastructure portals.** Confirm that autoscaling is enabled and configured correctly. Use the **Resource Allocation** interface under **Settings** in the Autonomous Database Service page in the Azure portal. For more information, see [Use autoscaling](https://docs.oracle.com/en/cloud/paas/autonomous-database/serverless/adbsb/autonomous-auto-scale.html).

   - **Schedule start and stop times for noncritical workloads.** Reduce costs by stopping databases during inactive periods. Configure these schedules as described in [Schedule start and stop times for an autonomous database instance](https://docs.oracle.com/en/cloud/paas/autonomous-database/serverless/adbsb/autonomous-auto-stop-start.html) from the Oracle Cloud Infrastructure console.

## Configure storage to support workload requirements

Storage capacity affects both performance and cost. Plan and manage storage effectively:

1. **Select the appropriate workload types.** Choose the correct workload configuration based on your use case:

   - Data warehouse: 1 terabyte (TB) to 384-TB storage capacity
  
   - Transaction processing, JSON, APEX: 20 gigabytes (GB) to 393,216-GB storage capacity

1. **Enable storage autoscaling to support growth.** Autoscaling expands storage up to three times the reserved capacity. This feature is disabled by default, so enable it proactively to avoid manual intervention during growth.

   - **Request extra storage capacity when needed.** Request extra storage capacity through the [resource management process](https://docs.oracle.com/iaas/Content/database-at-azure-autonomous/odadb-managing-autonomous-database-resources-azure.html#GUID-2C088312-BC30-468E-A15A-00740D2818F5).

## Manage resources independently and efficiently

- **Manage compute and storage independently.** Adjust ECPUs and storage based on workload needs. Use the Azure portal or the Oracle Cloud Infrastructure console to make changes without downtime.

- **Review storage reduction requirements before implementation.** Storage reduction requires specific conditions to be met. Before implementation, review [Shrink storage](https://docs.oracle.com/en/cloud/paas/autonomous-database/serverless/adbsb/autonomous-auto-scale.html#GUID-3EE6FBB5-58D5-477E-8EDE-0BDEAC99FA85).

## Plan disaster recovery to maintain availability

- **Use built-in local disaster recovery across availability zones.** Oracle Autonomous Database@Azure provides automatic backup-based recovery within the same Azure region. This feature doesn't require extra ECPUs or storage.

- **Account for resource consumption when you use Autonomous Data Guard.** Ensure equal resource allocation for production and standby databases. For example, a 12 ECPU production database requires a 12 ECPU standby instance.

## Next step

> [!div class="nextstepaction"]
> [Migrate Oracle workloads to Azure](./oracle-migration-planning.md)
