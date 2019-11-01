---
title: "Accelerate migration with VMware hosts"
titleSuffix: Microsoft Cloud Adoption Framework for Azure
description: Accelerate migration with VMware hosts
author: BrianBlanchard
ms.author: brblanch
ms.date: 10/10/2019
ms.topic: guide
ms.service: cloud-adoption-framework
ms.subservice: migrate
---

# Accelerate migration with VMware hosts

Migrating entire VMware hosts can move multiple workloads and several assets in a single migration effort. The following guidance expands the scope of the [Azure migration guide](../azure-migration-guide/index.md) through a VMware host migration. Most of the effort required in this scope expansion occurs during the prerequisites and migration processes of a migration effort.

## Suggested prerequisites

When migrating your first VMware host to Azure, you must meet a number of prerequisites to prepare identity, network, and management requirements. After these prerequisites are met, each additional host should require significantly less effort to migrate. The following sections provide more detail about the prerequisites.

### Secure your Azure environment

Implement the appropriate cloud solution for role-based access control and network connectivity in your Azure environment. The [secure your environment guide](https://docs.microsoft.com/azure/vmware-cloudsimple/private-cloud-secure?toc=https://docs.microsoft.com/azure/cloud-adoption-framework/toc.json&bc=https://docs.microsoft.com/azure/cloud-adoption-framework/_bread/toc.json) can help with this implementation.

### Private cloud management

There are two required tasks and one optional task to establish the private cloud management. [Escalate private cloud privileges](https://docs.microsoft.com/azure/vmware-cloudsimple/escalate-privileges?toc=https://docs.microsoft.com/azure/cloud-adoption-framework/toc.json&bc=https://docs.microsoft.com/azure/cloud-adoption-framework/_bread/toc.json) and [workload DNS and DHCP setup](https://docs.microsoft.com/azure/vmware-cloudsimple/dns-dhcp-setup?toc=https://docs.microsoft.com/azure/cloud-adoption-framework/toc.json&bc=https://docs.microsoft.com/azure/cloud-adoption-framework/_bread/toc.json) are each required best practices.

If the objective is to [migrate workloads by using Layer 2 stretched networks](https://docs.microsoft.com/azure/vmware-cloudsimple/migration-layer-2-vpn?toc=https://docs.microsoft.com/azure/cloud-adoption-framework/toc.json&bc=https://docs.microsoft.com/azure/cloud-adoption-framework/_bread/toc.json), this third best practice is also required.

### Private cloud networking

After the management requirements are established, you can establish private cloud networking by using the following best practices:

- [VPN connection to Private Cloud](https://docs.microsoft.com/azure/vmware-cloudsimple/set-up-vpn?toc=https://docs.microsoft.com/azure/cloud-adoption-framework/toc.json&bc=https://docs.microsoft.com/azure/cloud-adoption-framework/_bread/toc.json)
- [On-premises network connection with ExpressRoute](https://docs.microsoft.com/azure/vmware-cloudsimple/on-premises-connection?toc=https://docs.microsoft.com/azure/cloud-adoption-framework/toc.json&bc=https://docs.microsoft.com/azure/cloud-adoption-framework/_bread/toc.json)
- [Azure virtual network connection with ExpressRoute](https://docs.microsoft.com/azure/vmware-cloudsimple/azure-expressroute-connection?toc=https://docs.microsoft.com/azure/cloud-adoption-framework/toc.json&bc=https://docs.microsoft.com/azure/cloud-adoption-framework/_bread/toc.json)
- [Configure DNS name resolution](https://docs.microsoft.com/azure/vmware-cloudsimple/on-premises-dns-setup?toc=https://docs.microsoft.com/azure/cloud-adoption-framework/toc.json&bc=https://docs.microsoft.com/azure/cloud-adoption-framework/_bread/toc.json)

### Integration with the cloud adoption plan

After you've met the other prerequisites, you should include each VMware host in the [cloud adoption plan](../../plan/template.md). Within the cloud adoption plan, add each host to be migrated, as a [distinct workload](../../plan/workloads.md). Within each workload, add the VMs to be migrated as [assets](../../plan/workloads.md). To add workloads and assets to the adoption plan in bulk, see [adding/editing work items with Excel](https://docs.microsoft.com/azure/devops/boards/backlogs/office/bulk-add-modify-work-items-excel?view=azure-devops).

## Migrate process changes

During each iteration, the adoption team works through the backlog to migrate the highest priority workloads. The process doesn't really change for VMware hosts. When the next workload on the backlog is a VMware host, the only change will be the tool used.

You can use the following tools in the migration effort:

- [Native VMware tools](https://docs.microsoft.com/azure/vmware-cloudsimple/migrate-workloads?toc=https://docs.microsoft.com/azure/cloud-adoption-framework/toc.json&bc=https://docs.microsoft.com/azure/cloud-adoption-framework/_bread/toc.json)
- [Azure Data Box](https://docs.microsoft.com/azure/vmware-cloudsimple/migration-using-azure-data-box?toc=https://docs.microsoft.com/azure/cloud-adoption-framework/toc.json&bc=https://docs.microsoft.com/azure/cloud-adoption-framework/_bread/toc.json)

Alternatively, you can migrate workloads through a disaster recovery failover by using the following tools:

- [Back up workload virtual machines](https://docs.microsoft.com/azure/vmware-cloudsimple/backup-workloads-veeam?toc=https://docs.microsoft.com/azure/cloud-adoption-framework/toc.json&bc=https://docs.microsoft.com/azure/cloud-adoption-framework/_bread/toc.json)
- [Configure Private Cloud as disaster recovery site using Zerto](https://docs.microsoft.com/azure/vmware-cloudsimple/disaster-recovery-zerto?toc=https://docs.microsoft.com/azure/cloud-adoption-framework/toc.json&bc=https://docs.microsoft.com/azure/cloud-adoption-framework/_bread/toc.json)
- [Configure Private Cloud as disaster recovery site using VMware SRM](https://docs.microsoft.com/azure/vmware-cloudsimple/disaster-recovery-site-recovery-manager?toc=https://docs.microsoft.com/azure/cloud-adoption-framework/toc.json&bc=https://docs.microsoft.com/azure/cloud-adoption-framework/_bread/toc.json)

## Next steps

Return to the expanded scope checklist to ensure your migration method is fully aligned.

> [!div class="nextstepaction"]
> [Expanded scope checklist](./index.md)
