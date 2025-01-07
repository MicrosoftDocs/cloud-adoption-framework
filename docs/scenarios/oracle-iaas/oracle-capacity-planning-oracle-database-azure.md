---
title: Capacity planning for Oracle Database@Azure-Exadata Database Service
description: Learn how capacity planning can help you select the appropriate infrastructure for Oracle workloads on Azure Oracle Database@Azure.
author: gkayali
ms.author: guherk
ms.date: 04/26/2024
ms.topic: conceptual
ms.custom: UpdateFrequency2, e2e-oracle
---

# Capacity planning for Oracle Database@Azure 
Oracle Database@Azure is a multicloud solution where Oracle Exadata service runs directly within Azure data centers. This offering, jointly provided by Microsoft and Oracle, requires planning and managing resources across both cloud platforms. 

In this article, we cover following areas of capacity considerations while deploying Oracle Database@Azure-Exadata Database Service:  
* Network infrastructure: Oracle Database@Azure virtual network(vnet) & Subnet 
* Oracle Database@Azure Infrastructure  
* Oracle Database@Azure Virtual Machine(VM) Cluster  
* Oracle Database@Azure Storage configuration  

> [!NOTE]
> For Oracle Database@Azure sizing, [reach out to your local Oracle sales team](https://www.oracle.com/cloud/azure/oracle-database-at-azure/) for sizing guidance.


## Capacity consideration for Oracle Database@Azure Virtual Network & Subnet
- Oracle Database@Azure requires a delegated subnet and must be delegated to “Oracle.Database/networkAttachments” before​ cluster deployment. 
- You can create a maximum of one (1) Oracle Database@Azure delegated subnet per virtual network(vNet).   
- You can assign multiple Oracle Database@Azure VMs Clusters to the same delegated subnet. Plan for sufficient IP address ranges accordingly to accommodate the required number of VM clusters. For example, if you expect to deploy two VM clusters in the same subnet, ensure that your subnet has enough IP addresses to support all two clusters. Refer to [Plan IP address space for Oracle Database@Azure](https://learn.microsoft.com/azure/oracle/oracle-db/oracle-database-plan-ip). 
- You can assign Oracle Database@Azure VM clusters to different virtual network in same or different subscription. For example, a VM cluster is assigned to Development subscription while Infrastructure and VM cluster are from Production subscription.  This help reduce the needs to setup a separate Infrastructure just for Development subscription.

    To assign Oracle Database@Azure VM Cluster to a virtual network from a separate Azure subscription, ensure that both subscriptions are under the same billing account. Refer to [Link Oracle Database@Azure to multiple Azure subscriptions](https://learn.microsoft.com/azure/oracle/oracle-db/link-oracle-database-multiple-subscription). 
- If you have plans to increase the number of VM clusters, ensure the CIDRs of the client subnet are properly allocated to prevent IP address conflicts, and maintain network segmentation. Refer to [Plan IP address space for Oracle Database@Azure](https://learn.microsoft.com/azure/oracle/oracle-db/oracle-database-plan-ip) for details on IP CIDRs for each subnet.  
- Oracle Database@Azure backup subnet can be optionally provided during VM cluster creation. Backup subnets are created in the OCI and don't need to be present in Azure virtual network.  
    - Recommendation:  
    Pre-assigning backup subnet CIDRs to avoid any IP address conflicts, ensuring smooth network operations and preventing potential connectivity issues. 


## Capacity consideration for Oracle Database@Azure Infrastructure

- Oracle Database@Azure allows provisioning of an infrastructure to start with two databases and three storage servers known as quarter rack. Before provisioning, ensure that all necessary prerequisites are met, such as network configurations and resource allocations.  
- Additional database and/or storage servers can be added independently. Up to a maximum of 32 database servers and 64 storage servers are allowed to be added. For detail Infrastructure configuration, refer to [Oracle Database@Azure Service Scaling Options](https://docs.oracle.com/en-us/iaas/exadatacloud/doc/exa-service-desc.html#ECSCM-GUID-EC1A62C6-DDA1-4F39-B28C-E5091A205DD3). 
-  Infrastructure Compute/Storage Scaling Option:  
    - You can scale an Oracle Database@Azure Infrastructure in the Azure Console/API/SDK/Terraform. The scaling process is done online without any downtime to the service and might take up to a few hours to complete. Ensure that you monitor the process to confirm successful scaling. 
    - After adding additional database or storage servers to your Oracle Database@Azure infrastructure, add the newly provisioned capacity to the VM clusters.  


## Capacity consideration for Oracle Database@Azure VM Cluster
- A maximum of Eight VM clusters can be created in the same Oracle Database@Azure Infrastructure.    
- Each VM in the VM clusters has a minimum of two OCPU and 30 GB of memory allocation.  Both OCPU and memory allocation can be adjusted independently during initial VM cluster setup or afterward according to the workload requirement. 
- When provisioning a VM Cluster, you can choose to start with either a single-node VM or a multi-node VM cluster. By default, a multi-node VM cluster is selected during the creation process.
- Single node VM cluster can't be used for high-availability (HA) configurations. We recommend a minimum of 2 VMs per VM Cluster to provide high availability. 
- Scaling within an Oracle Database@Azure VM cluster:  
    - You can adjust the number of OCPU and memory for an Oracle Database@Azure VM cluster instance symmetrically across all nodes up to the infrastructure limits using OCI console/API/SDK/Terraform. 
    - Once an Oracle Database@Azure VM cluster instance has been provisioned, it's possible to scale the processing power down to zero, effectively shutting down the VM cluster. During this period, only the infrastructure costs are incurred until the system is scaled up again. This feature is advantageous for cost-saving on test/development systems when they aren't in use. 


## Capacity consideration for Oracle Database@Azure Storage
- The storage space inside the Oracle Database@Azure storage servers is configured for use by Oracle Automatic Storage Management (ASM) when you provision the Oracle Database@Azure VM cluster.   By default, the following ASM disk groups are created:  
    - DATA disk group 
    - RECO disk group
    - Sparse disk group (optional) 

    Detail of the storage configuration can be found from [Storage Configuration](https://docs.oracle.com/en-us/iaas/exadatacloud/doc/ecs-storage-config.html). 

> [!NOTE]
> Once Oracle Database@Azure VM cluster is created, you can no longer allow to change the disk group layout. 

-  Configuration Settings on Storage: 
    - The choices of selecting database backups or sparse disk groups during VM cluster creation profoundly affect how storage space in the Oracle Database@Azure storage servers is allocated to the ASM and sparse disk groups.
    - Choosing to store database backups locally on the Oracle Database@Azure storage won't protect against data loss caused by hardware failures, availability zone(AZ) or regional outage.


## Next steps

- [Migration planning for Oracle on Azure](./oracle-migration-planning.md)
- /azure/virtual-machines/workloads/oracle/oracle-migration-oracle-database-at-azure
 
