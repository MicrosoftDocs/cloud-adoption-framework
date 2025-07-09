---
title: Capacity Planning for Oracle Database@Azure Using Exadata Database Service
description: Learn how capacity planning can help you select the appropriate infrastructure for Oracle workloads on Oracle Database@Azure.
author: gkayali
ms.author: guherk
ms.date: 01/27/2025
ms.topic: conceptual
ms.custom: e2e-oracle
---

# Capacity planning for Oracle Database@Azure

Oracle Database@Azure is an Oracle database service that runs on Oracle Cloud Infrastructure (OCI) and is colocated in Azure datacenters at Microsoft. This joint offering from Microsoft and Oracle requires you to plan and manage resources across both cloud platforms.

This article provides guidance on capacity planning for Oracle Database@Azure by using Oracle Exadata Database Service. It includes considerations and recommendations to help you plan this process.

> [!NOTE]
> For Oracle Database@Azure sizing, [reach out to your local Oracle sales team](https://www.oracle.com/cloud/azure/oracle-database-at-azure/).

## Capacity considerations for virtual networks and subnets

- Oracle Database@Azure requires a delegated subnet and must be delegated to `Oracle.Database/networkAttachments` before​ cluster deployment.

- You can create a maximum of one Oracle Database@Azure delegated subnet for each virtual network.

- You can assign multiple Exadata virtual machine (VM) clusters to the same delegated subnet. Plan for sufficient IP address ranges to accommodate the required number of VM clusters. For example, if you expect to deploy two VM clusters in the same subnet, ensure that your subnet has enough IP addresses to support both clusters. For more information, see [Plan IP address space for Oracle Database@Azure](/azure/oracle/oracle-db/oracle-database-plan-ip).

- You can assign Exadata VM clusters to different virtual networks in the same subscription or in different subscriptions. For example, a VM cluster is assigned to a development subscription while Oracle Exadata Infrastructure and another Exadata VM Cluster resource are from production subscriptions. This approach minimizes the need to establish separate infrastructure resources just for the development subscription. To assign an Exadata VM cluster to a virtual network from a separate Azure subscription, ensure that both subscriptions are under the same billing account. For more information, see [Link Oracle Database@Azure to multiple Azure subscriptions](/azure/oracle/oracle-db/link-oracle-database-multiple-subscription).

    > [!NOTE]
    > By default, the Oracle Database@Azure service can use up to five delegated subnets. If extra subnet capacity is required, you can request a service limit increase. For more information, see [Delegated subnet limits](/azure/oracle/oracle-db/oracle-database-delegated-subnet-limits).

- If you plan to increase the number of VM clusters, ensure that the Classless Inter-Domain Routing (CIDR) of the client subnet is properly allocated to prevent IP address conflicts and maintain network segmentation. For more information, see [Plan IP address space for Oracle Database@Azure](/azure/oracle/oracle-db/oracle-database-plan-ip).

- Oracle Exadata Database@Azure backup subnets can be optionally provided during VM cluster creation. Backup subnets are created in OCI and don't need to be present in an Azure virtual network. Preassign backup subnet CIDRs to avoid IP address conflicts. This approach helps ensure smooth network operations and prevents potential connectivity problems.

## Capacity considerations for Exadata Infrastructure

- Use Oracle Exadata Database@Azure to provision an infrastructure that uses two databases and three storage servers. This setup is called a *quarter rack*. Before provisioning, ensure that all necessary prerequisites are met, such as network configurations and resource allocations. For more information, see [Provisioning Exadata Infrastructure](https://docs.oracle.com/iaas/Content/database-at-azure-exadata/odexa-provisioning-exadata-infrastructure.html).

- You can add extra database and storage servers independently. You can add up to a maximum of 32 database servers and 64 storage servers. For more information, see [Oracle Database@Azure Service scaling options](https://docs.oracle.com/iaas/exadatacloud/doc/exa-service-desc.html#ECSCM-GUID-EC1A62C6-DDA1-4F39-B28C-E5091A205DD3).

- You can scale up or scale down Exadata Infrastructure based on the workload requirements.

  - Scale Exadata Infrastructure via the OCI console, API, SDK, or Terraform. The scaling process is done online without any downtime and might take up to a few hours to complete. Monitor the process from the **Work Requests** section in the OCI console to confirm that scaling is successful.
  
  - After you add more database or storage servers to your Oracle Exadata Database@Azure infrastructure, add the newly provisioned capacity to the VM clusters.

> [!NOTE]
> Scaling operations for Oracle Exadata Database@Azure are currently managed within OCI at the infrastructure level and the VM cluster level.

## Capacity considerations for Exadata VM Cluster

Consider the following capacity limitations for Exadata VM Cluster.

- A maximum number of eight VM clusters can be created in the same Exadata Infrastructure.

- Each VM in the Exadata VM Cluster has a minimum of two Oracle CPUs (OCPUs) and 30 GB of memory allocation. You can adjust both OCPUs independently during or after the initial VM cluster setup, based on the requirements of the workload.

- When you provision a VM Cluster, you can choose to start with a single-node cluster or a multiple-node VM cluster. By default, a multiple-node VM cluster is selected during the creation process.

- A single-node cluster can't be used for high availability (HA) configurations. To provide HA, we recommend a minimum of two VMs for each Exadata VM cluster.

- The VM cluster can be scaled up or scaled down based on the workload requirements.

  - You can adjust the number of OCPUs and the memory allocation for an Exadata VM Cluster instance symmetrically across all nodes up to the infrastructure limits by using the OCI console, API, SDK, or Terraform.
  
  - After you provision an Exadata VM Cluster instance, it's possible to scale down the processing power to zero. This action effectively shuts down the VM cluster. During this period, only the infrastructure costs are incurred until the system is scaled up again. This feature helps you save costs on test and development systems when they aren't in use.

## Capacity considerations for storage

The storage space inside the Oracle Exadata Database@Azure storage servers is configured for use by Oracle Automatic Storage Management (ASM) when you provision the Exadata VM cluster. By default, the following ASM disk groups are created:

- DATA disk group
  
- RECO disk group
  
- Sparse disk group, which is optional

For more information about the storage configuration, see [Exadata Cloud Infrastructure - Storage configuration](https://docs.oracle.com/iaas/exadatacloud/doc/ecs-storage-config.html).

> [!NOTE]
> After the Exadata VM cluster is created, the disk group layout can't be changed.

Consider the following storage configuration settings:

- Choosing between database backups or sparse disk groups during VM cluster creation significantly affects the allocation of storage space to ASM disk groups in the Oracle Exadata Database@Azure storage servers. For more information, see [Impact of configuration settings on storage](https://docs.oracle.com/iaas/exadatacloud/doc/ecs-storage-config.html#ECSCM-GUID-925DAEBF-4693-4AC6-80E1-15D7121F80A9).
  
- Storing database backups locally on the Oracle Exadata Database@Azure storage server doesn't protect against data loss caused by hardware failures and outages in availability zones or regions. To help ensure a resilient architecture for unplanned outages, see the architecture options in [Business continuity and disaster recovery considerations for Oracle Database@Azure](./bcdr-odaa.md).

## Next step

> [!div class="nextstepaction"]
> [Migrate Oracle workloads to Azure](./oracle-migration-planning.md)
