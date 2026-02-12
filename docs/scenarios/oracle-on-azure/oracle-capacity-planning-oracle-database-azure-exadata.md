---
title: Capacity Planning for Oracle Database@Azure by Using Exadata Database Service
description: Plan and configure the appropriate infrastructure capacity for Oracle workloads on Oracle Exadata Database@Azure to ensure optimal performance and cost efficiency.
author: gkayali
ms.author: guherk
ms.date: 08/13/2025
ms.topic: concept-article
ms.custom: e2e-oracle
---

# Capacity planning for Oracle Database@Azure by using Exadata Database service

Effective capacity planning determines the right infrastructure configuration for Oracle workloads on Oracle Exadata Database@Azure. Proper capacity planning prevents performance bottlenecks, reduces costs, and ensures scalability as your Oracle workloads grow.

## Plan virtual network and subnet capacity

Network configuration forms the foundation of your Oracle Database@Azure deployment. Proper subnet planning ensures adequate IP address allocation and supports future growth without network conflicts.

1. **Delegate a subnet specifically for Oracle Database@Azure before cluster deployment.** Oracle Database@Azure requires a subnet delegated to `Oracle.Database/networkAttachments` to establish the required network permissions. Create this delegation in the Azure portal or through infrastructure as code (IaC) templates to ensure consistent configuration across environments.

1. **Limit each virtual network to one Oracle Database@Azure delegated subnet.** You can create a maximum of one Oracle Database@Azure delegated subnet for each virtual network. Plan your virtual network architecture to accommodate this limitation by using multiple virtual networks if you need separate network segments.

1. **Calculate IP address requirements for multiple virtual machine clusters in the same subnet.** You can assign multiple Exadata virtual machine (VM) clusters to the same delegated subnet. Allocate sufficient address space to support your planned number of clusters, including future expansion. For example, if you plan to deploy two VM clusters in the same subnet, ensure that your subnet classless inter-domain routing (CIDR) provides adequate IP addresses for both clusters plus growth capacity. For more information, see [Plan IP address space for Oracle Database@Azure](/azure/oracle/oracle-db/oracle-database-plan-ip).

1. **Use cross-subscription VM cluster assignments to optimize resource allocation.** You can assign Exadata VM clusters to different virtual networks in the same subscription or in different subscriptions. For example, you can assign a VM cluster to a development subscription when Oracle Exadata Infrastructure and another Exadata VM Cluster resource are in production subscriptions. This approach reduces the need to establish separate infrastructure resources only for the development subscription. To assign an Exadata VM cluster to a virtual network from a separate Azure subscription, ensure that both subscriptions belong to the same billing account. For more information, see [Link Oracle Database@Azure to multiple Azure subscriptions](/azure/oracle/oracle-db/link-oracle-database-multiple-subscription).

1. **Request extra delegated subnet capacity when you exceed the default limit of five subnets.** By default, the Oracle Database@Azure service can use up to five delegated subnets. If you need extra subnet capacity, submit a service limit increase request through Azure support. Plan this request early in your deployment timeline to avoid delays. For more information, see [Delegated subnet limits](/azure/oracle/oracle-db/oracle-database-delegated-subnet-limits).

1. **Allocate client subnet CIDR properly to prevent IP address conflicts.** If you plan to increase the number of VM clusters, ensure that the CIDR of the client subnet is properly allocated to prevent IP address conflicts and maintain network segmentation. For more information, see [Plan IP address space for Oracle Database@Azure](/azure/oracle/oracle-db/oracle-database-plan-ip).

1. **Pre-allocate backup subnet CIDRs to prevent IP address conflicts.** Oracle Exadata Database@Azure backup subnets can be optionally provided during VM cluster creation. Backup subnets are created in Oracle Cloud Infrastructure and don't need to be present in an Azure virtual network. Assign backup subnet CIDRs during planning to ensure network segmentation and prevent connectivity problems.

## Configure Exadata Infrastructure capacity

Infrastructure sizing determines the performance and scalability of your Oracle Database@Azure deployment. Proper infrastructure configuration ensures adequate compute and storage resources while providing flexibility for future growth.

1. **Start with a quarter rack configuration that includes two database servers and three storage servers.** Use Oracle Exadata Database@Azure to provision an infrastructure that uses at least two database servers and three storage servers. This setup is known as a *quarter rack configuration* and provides the minimum configuration for Oracle Exadata Database@Azure deployment. Before you provision the infrastructure, ensure that all necessary prerequisites are met, such as network configurations and resource allocations. For more information, see [Provisioning Exadata Infrastructure](https://docs.oracle.com/iaas/Content/database-at-azure-exadata/odexa-provisioning-exadata-infrastructure.html).

1. **Add database and storage servers independently based on workload requirements.** You can add extra database and storage servers independently. Scale your infrastructure by adding up to 32 database servers and 64 storage servers. This independent scaling approach allows you to optimize resources for compute-intensive or storage-intensive workloads without over-provisioning unused capacity. For more information, see [Oracle Database@Azure Service scaling options](https://docs.oracle.com/iaas/exadatacloud/doc/exa-service-desc.html#ECSCM-GUID-EC1A62C6-DDA1-4F39-B28C-E5091A205DD3).

1. **Use online scaling to adjust infrastructure capacity without downtime.** You can scale up or scale down Exadata Infrastructure based on the workload requirements. Scale Exadata Infrastructure via the Oracle Cloud Infrastructure console, API, SDK, or Terraform. The scaling process is done online without any downtime and takes up to a few hours to complete. Monitor the process from the **Work Requests** section in the Oracle Cloud Infrastructure console to confirm that scaling is successful.

1. **Add newly provisioned capacity to VM clusters after infrastructure scaling.** After you add more database or storage servers to your Oracle Exadata Database@Azure infrastructure, add the newly provisioned capacity to the VM clusters. Infrastructure scaling increases available resources, but you must explicitly add this capacity to your VM clusters to use the extra resources. Scaling operations for Oracle Exadata Database@Azure are managed within Oracle Cloud Infrastructure at the infrastructure level and the VM cluster level.

## Size Exadata VM clusters appropriately

VM cluster configuration directly affects database performance and high availability. Proper VM cluster sizing ensures adequate compute resources while providing the flexibility to scale based on workload demands.

- **Deploy a maximum of eight VM clusters within a single Exadata Infrastructure.** You can create a maximum of eight VM clusters in the same Exadata Infrastructure. This limit ensures optimal resource distribution and management across your infrastructure. Plan your database consolidation strategy to work within this constraint while maintaining performance isolation between workloads.

- **Allocate a minimum of two Oracle CPUs (OCPUs) and 30 gigabytes (GB) of memory for each VM.** Each VM in the Exadata VM Cluster has a minimum of two OCPUs and 30 GB of memory allocation. You can adjust both OCPUs independently during or after initial VM cluster setup, based on workload requirements. Adjust OCPU and memory allocation based on actual workload requirements and performance monitoring data.

- **Choose between single-node and multiple-node VM cluster configurations based on availability requirements.** When you provision a VM cluster, you can choose to start with a single-node cluster or a multiple-node VM cluster. By default, a multiple-node VM cluster is selected during the creation process. A single-node cluster can't be used for high availability (HA) configurations. To provide HA, use a minimum of two VMs for each Exadata VM cluster.

- **Scale VM cluster resources symmetrically across all nodes by using Oracle Cloud Infrastructure management tools.** You can scale the VM cluster up or down based on the workload requirements. Adjust OCPUs and memory allocation symmetrically across all nodes up to infrastructure limits using Oracle Cloud Infrastructure console, API, SDK, or Terraform. This symmetrical scaling approach ensures balanced performance and prevents resource bottlenecks.

- **Scale VM clusters down to zero OCPUs to minimize costs during non-use periods.** After you provision an Exadata VM Cluster instance, it's possible to scale down the processing power to zero. This action effectively shuts down the VM cluster. During this period, only the infrastructure costs are incurred until the system is scaled up again. This feature helps you save costs on test and development systems when they aren't in use.

- **Configure local file system sizes carefully during initial deployment.** The VM cluster's local file systems can be customized through configuration. After the local file system size is increased, it can't be reduced. Plan file system allocation conservatively to avoid storage waste while ensuring adequate space for application data and logs. For more information, see [Provisioning an Exadata VM cluster for Azure](https://docs.oracle.com/iaas/Content/database-at-azure-exadata/odexa-provisioning-exadata-vm-cluster-azure.html).

## Optimize storage configuration

Storage configuration determines data protection, performance, and backup strategies for your Oracle databases. Oracle Automatic Storage Management provides the foundation for storage allocation and must be configured correctly during initial deployment.

The storage space inside the Oracle Exadata Database@Azure storage servers is configured for use by Oracle Automatic Storage Management when you provision the Exadata VM cluster. By default, the following Oracle Automatic Storage Management disk groups are created:

- **DATA disk group:** Stores database files and user data
- **RECO disk group:** Stores recovery files and archived logs
- **Sparse disk group:** Provides extra storage capacity (optional)

For more information, see [Storage configuration](https://docs.oracle.com/iaas/exadatacloud/doc/ecs-storage-config.html).

- **Choose between database backups and sparse disk groups during VM cluster creation.** Choosing between database backups or sparse disk groups during VM cluster creation significantly affects the allocation of storage space to Oracle Automatic Storage Management disk groups in the Oracle Exadata Database@Azure storage servers. Evaluate your backup strategy and storage requirements before you make this choice because the disk group layout can't be changed after VM cluster creation. For more information, see [Impact of configuration settings on storage](https://docs.oracle.com/iaas/exadatacloud/doc/ecs-storage-config.html#ECSCM-GUID-925DAEBF-4693-4AC6-80E1-15D7121F80A9).

- **Implement external backup strategies to protect against hardware failures and outages.** Storing database backups locally on the Oracle Exadata Database@Azure storage server doesn't protect against data loss that hardware failures and outages in availability zones or regions cause. Configure cross-region backup solutions and disaster recovery architectures to ensure data resilience and business continuity. To help ensure a resilient architecture for unplanned outages, see the architecture options in [Business continuity and disaster recovery (BCDR) considerations for Oracle Database@Azure](./oracle-disaster-recovery-oracle-database-azure.md). After the Exadata VM cluster is created, the disk group layout can't be changed. Plan your storage configuration carefully during initial deployment.

## Azure tools and resources

| Category | Tool | Description |
|----------|------|-------------|
| Planning | [Plan IP address space for Oracle Database@Azure](/azure/oracle/oracle-db/oracle-database-plan-ip) | Guide subnet CIDR allocation and IP address planning |
| Multiple-subscription | [Link Oracle Database@Azure to multiple Azure subscriptions](/azure/oracle/oracle-db/link-oracle-database-multiple-subscription) | Deploy VM clusters across different Azure subscriptions |
| Service limits | [Delegated subnet limits](/azure/oracle/oracle-db/oracle-database-delegated-subnet-limits) | Define default limits and request increases for delegated subnets |
| Infrastructure | [Provisioning Exadata Infrastructure](https://docs.oracle.com/iaas/Content/database-at-azure-exadata/odexa-provisioning-exadata-infrastructure.html) | Deploy Exadata Infrastructure by using Oracle documentation |
| Scaling | [Oracle Database@Azure Service scaling options](https://docs.oracle.com/iaas/exadatacloud/doc/exa-service-desc.html#ECSCM-GUID-EC1A62C6-DDA1-4F39-B28C-E5091A205DD3) | Explore maximum scaling limits and capabilities |
| VM cluster | [Provisioning an Exadata VM cluster for Azure](https://docs.oracle.com/iaas/Content/database-at-azure-exadata/odexa-provisioning-exadata-vm-cluster-azure.html) | Provision VM clusters step-by-step |
| Storage configuration | [Exadata Cloud Infrastructure - Storage configuration](https://docs.oracle.com/iaas/exadatacloud/doc/ecs-storage-config.html) | Configure storage for Exadata Cloud Infrastructure |
| Storage impact | [Impact of configuration settings on storage](https://docs.oracle.com/iaas/exadatacloud/doc/ecs-storage-config.html#ECSCM-GUID-925DAEBF-4693-4AC6-80E1-15D7121F80A9) | Understand how configuration choices affect storage allocation |
| Disaster recovery | [BCDR for Oracle Database@Azure](./oracle-disaster-recovery-oracle-database-azure.md) | Design resilient Oracle deployments by using BCDR architecture options |

## Next step

> [!div class="nextstepaction"]
> [Migrate Oracle workloads to Azure](./oracle-migration-planning.md)