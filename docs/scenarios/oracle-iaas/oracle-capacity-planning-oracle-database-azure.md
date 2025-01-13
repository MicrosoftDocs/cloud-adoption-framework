---
title: Capacity planning for Oracle Database@Azure using Oracle Exadata Database
description: Learn how capacity planning can help you select the appropriate infrastructure for Oracle workloads on Azure Oracle Database@Azure.
author: gkayali
ms.author: guherk
ms.date: 01/10/2025
ms.topic: conceptual
ms.custom: e2e-oracle
---

# Capacity planning for Oracle Database@Azure

Oracle Database@Azure is an Oracle database service that runs on Oracle Cloud Infrastructure (OCI) and is colocated in Azure datacenters at Microsoft. This offering, jointly provided by Microsoft and Oracle, requires planning and managing resources across both cloud platforms.

This article provides guidance on capacity planning for Oracle Database@Azure using Exadata Database Service. It includes considerations and recommendations to assist you with this planning process.

> [!NOTE]
> For Oracle Database@Azure sizing, [reach out to your local Oracle sales team](https://www.oracle.com/cloud/azure/oracle-database-at-azure/) for sizing guidance.

## Capacity considerations for virtual network and subnet

- Oracle Database@Azure requires a delegated subnet and must be delegated to `Oracle.Database/networkAttachments` before​ cluster deployment.
- You can create a maximum of one (1) Oracle Database@Azure delegated subnet per virtual network.
- You can assign multiple Exadata VM Clusters to the same delegated subnet. Plan for sufficient IP address ranges accordingly to accommodate the required number of VM clusters. For example, if you expect to deploy two VM clusters in the same subnet, ensure that your subnet has enough IP addresses to support all two clusters. See [Plan IP address space for Oracle Database@Azure](/azure/oracle/oracle-db/oracle-database-plan-ip).
- You can assign Exadata VM Clusters to different virtual network in same or different subscriptions. For example, a VM cluster is assigned to a development subscription while Exadata Infrastructure and Exadata VM Cluster resources are from production subscriptions. This helps reduce the need to set up separate infrastructure resources just for the development subscription.
    To assign Exadata VM Cluster to a virtual network from a separate Azure subscription, ensure that both subscriptions are under the same billing account. See [Link Oracle Database@Azure to multiple Azure subscriptions](/azure/oracle/oracle-db/link-oracle-database-multiple-subscription).

    > [!NOTE]
    > By default, Oracle Database@Azure service can use up to five delegated subnets. If additional subnet capacity is required, you can request a service limit increase. See [Delegated subnet limits](/azure/oracle/oracle-db/oracle-database-delegated-subnet-limits)
- If you have plans to increase the number of VM clusters, ensure the CIDRs of the client subnet are properly allocated to prevent IP address conflicts, and maintain network segmentation. See [Plan IP address space for Oracle Database@Azure](/azure/oracle/oracle-db/oracle-database-plan-ip) for details on IP CIDRs for each subnet.
- Oracle Exadata Database@Azure backup subnets can be optionally provided during VM cluster creation. Backup subnets are created in Oracle Cloud Infrastructure (OCI) and don't need to be present in Azure virtual network.
  - Preassign backup subnet CIDRs to avoid any IP address conflicts, ensuring smooth network operations and preventing potential connectivity issues.

## Capacity consideration for Exadata Infrastructure

- Oracle Exadata Database@Azure allows provisioning of an infrastructure to start with two databases and three storage servers known as quarter rack. Before provisioning, ensure that all necessary prerequisites are met, such as network configurations and resource allocations.
- Additional database and storage servers can be added independently. Up to a maximum of 32 database servers and 64 storage servers are allowed to be added. For more information, see [Oracle Database@Azure Service Scaling Options](https://docs.oracle.com/en-us/iaas/exadatacloud/doc/exa-service-desc.html#ECSCM-GUID-EC1A62C6-DDA1-4F39-B28C-E5091A205DD3).
- Exadata Infrastructure can be scaled up or down based on the workload requirements.
  - Scale Exadata Infrastructure via the OCI Console, API, SDK, or Terraform. The scaling process is done online without any downtime to the service and might take up to a few hours to complete. Ensure that you monitor the process to confirm successful scaling.
  - After adding additional database or storage servers to your Oracle Exadata Database@Azure infrastructure, add the newly provisioned capacity to the VM clusters.

 > [!NOTE]
    >Scaling operations for Oracle Exadata Database@Azure, both at the Infrastructure and VM Cluster levels, are currently managed within OCI.
## Capacity consideration for Exadata VM Cluster

- A maximum of eight (8) VM clusters can be created in the same Exadata Infrastructure.
- Each VM in the Exadata VM Cluster has a minimum of two Oracle CPU (OCPU) and 30 GB of memory allocation. Both can be adjusted independently during initial VM cluster setup or afterward according to the workload requirement.
- When provisioning a VM Cluster, you can choose to start with either a single-node or a multi-node VM cluster. By default, a multi-node VM cluster is selected during the creation process.
- Single node cluster can't be used for high-availability (HA) configurations. We recommend a minimum of 2 VMs per Exadata VM Cluster to provide high availability.
- The VM cluster can be scaled up or down based on the workload requirements.
  - You can adjust the number of OCPU and memory for an Exadata VM Cluster instance symmetrically across all nodes up to the infrastructure limits using the OCI console, API, SDK, or Terraform.
  - Once an Exadata VM Cluster instance has been provisioned, it's possible to scale the processing power down to zero, effectively shutting down the VM cluster. During this period, only the infrastructure costs are incurred until the system is scaled up again. This feature is advantageous for cost-saving on test/development systems when they aren't in use.

## Capacity consideration for storage

- The storage space inside the Oracle Exadata Database@Azure storage servers is configured for use by Oracle Automatic Storage Management (ASM) when you provision the Exadata VM Cluster. By default, the following ASM disk groups are created:
  - DATA disk group
  - RECO disk group
  - Sparse disk group (optional)

    For more information on the storage configuration, see [OCI Documentation - Exadata Cloud Infrastructure - Storage configuration](https://docs.oracle.com/en-us/iaas/exadatacloud/doc/ecs-storage-config.html).

> [!NOTE]
> Once Exadata VM Cluster is created, you can't change the disk group layout.

- Consider the storage configuration settings:
  - The choices of selecting database backups or sparse disk groups during VM cluster creation profoundly affect how storage space in the Oracle Exadata Database@Azure storage servers is allocated to the ASM disk groups. See [Impact of Configuration Settings on Storage](https://docs.oracle.com/en-us/iaas/exadatacloud/doc/ecs-storage-config.html#ECSCM-GUID-925DAEBF-4693-4AC6-80E1-15D7121F80A9).
  - Choosing to store database backups locally on the Oracle Exadata Database@Azure storage doesn't protect against data loss caused by hardware failures and outages in availability zone or regions.
  
      - To ensure a resilient architecture for unplanned outages, explore the available architecture options in the  [Business continuity and disaster recovery considerations for Oracle Database@Azure](./oracle-disaster-recovery-oracle-database-azure.md). 

## Next steps

- [Migration planning for Oracle on Azure](./oracle-migration-planning.md)
