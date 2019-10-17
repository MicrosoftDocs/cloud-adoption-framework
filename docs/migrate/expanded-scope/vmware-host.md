---
title: "Accelerate migration with VMWare hosts"
titleSuffix: Microsoft Cloud Adoption Framework for Azure
description: Accelerate migration with VMWare hosts
author: BrianBlanchard
ms.author: brblanch
ms.date: 10/10/2019
ms.topic: guide
ms.service: cloud-adoption-framework
ms.subservice: migrate
---

# Accelerate migration with VMWare hosts

Migrating entire VMWare hosts can move multiple workloads and several assets in a single migration effort. The following guidance will expand the scope of the [Azure migration guide](../azure-migration-guide/index.md) through a VMWare host migration.

## General scope expansion

Most of this effort required in this scope expansion will occur during the prerequisites and migration processes of a migration effort.

## Suggested prerequisites

When migrating your first VMWare host to Azure, there are a number of prerequisites that must be met to prepare identity, network, and management requirements. Once these prerequisites are met, each additional host should require significantly less effort to migrate. These prerequisites align to a few key efforts: secure your Azure environment, private cloud management, and private cloud networking.

### Secure your Azure environment

Implement the appropriate cloud solution for RBAC and Network connectivity in your Azure environment. The [secure your environment guide](https://docs.microsoft.com/azure/vmware-cloudsimple/private-cloud-secure.md?toc=https://docs.microsoft.com/azure/cloud-adoption-framework/toc.json&bc=https://docs.microsoft.com/azure/cloud-adoption-framework/_bread/toc.json) can help with this implementation.

### Private cloud management

There are two required tasks and one optional task to establish the private cloud management. [Escalate private cloud privileges](https://docs.microsoft.com/azure/vmware-cloudsimple/escalate-privileges.md?toc=https://docs.microsoft.com/azure/cloud-adoption-framework/toc.json&bc=https://docs.microsoft.com/azure/cloud-adoption-framework/_bread/toc.json) and [workload DNS and DHCP setup](https://docs.microsoft.com/azure/vmware-cloudsimple/dns-dhcp-setup.md?toc=https://docs.microsoft.com/azure/cloud-adoption-framework/toc.json&bc=https://docs.microsoft.com/azure/cloud-adoption-framework/_bread/toc.json) are each required best practices.

If the objective is to [migrate workloads using Layer 2 stretched networks](https://docs.microsoft.com/azure/vmware-cloudsimple/migration-layer-2-vpn.md?toc=https://docs.microsoft.com/azure/cloud-adoption-framework/toc.json&bc=https://docs.microsoft.com/azure/cloud-adoption-framework/_bread/toc.json), this third best practice will be required.

### Private cloud Networking

Once the management requirements are established, the private cloud networking can be established using the following best practices:

- [VPN connection to Private Cloud](https://docs.microsoft.com/azure/vmware-cloudsimple/set-up-vpn.md?toc=https://docs.microsoft.com/azure/cloud-adoption-framework/toc.json&bc=https://docs.microsoft.com/azure/cloud-adoption-framework/_bread/toc.json)
- [On-premises network connection with ExpressRoute](https://docs.microsoft.com/azure/vmware-cloudsimple/on-premises-connection.md?toc=https://docs.microsoft.com/azure/cloud-adoption-framework/toc.json&bc=https://docs.microsoft.com/azure/cloud-adoption-framework/_bread/toc.json)
- [Azure virtual network connection with ExpressRoute](https://docs.microsoft.com/azure/vmware-cloudsimple/azure-expressroute-connection.md?toc=https://docs.microsoft.com/azure/cloud-adoption-framework/toc.json&bc=https://docs.microsoft.com/azure/cloud-adoption-framework/_bread/toc.json)
- [Configure DNS name resolution](https://docs.microsoft.com/azure/vmware-cloudsimple/on-premises-dns-setup.md?toc=https://docs.microsoft.com/azure/cloud-adoption-framework/toc.json&bc=https://docs.microsoft.com/azure/cloud-adoption-framework/_bread/toc.json)

### Integration with the cloud adoption plan

Once the prerequisites have been met, each VMWare host be included in the [cloud adoption plan](../../plan/template.md). Within the cloud adoption plan, add each host to be migrated, as a [distinct workload](../../plan/workloads.md). Within each workload, the VMs to be migrated can each be added as [assets](../../plan/workloads.md). To bulk add workloads and assets to the adoption plan, see [adding/editing work items with Excel](https://docs.microsoft.com/azure/devops/boards/backlogs/office/bulk-add-modify-work-items-excel?view=azure-devops).

## Migrate process changes

During each iteration, the adoption team works through the backlog to migrate the highest priority workloads. The process doesn't really change for VMWare hosts. When the next workload on the backlog is a VMWare host, the only change will be the tool used.

### Suggested action during the migrate process

The following are a few examples of the tools that can be used in the migration effort:

- [Native VMWare tools](https://docs.microsoft.com/azure/vmware-cloudsimple/migrate-workloads.md?toc=https://docs.microsoft.com/azure/cloud-adoption-framework/toc.json&bc=https://docs.microsoft.com/azure/cloud-adoption-framework/_bread/toc.json)
- [Azure Data Box](https://docs.microsoft.com/azure/vmware-cloudsimple/migration-using-azure-data-box.md?toc=https://docs.microsoft.com/azure/cloud-adoption-framework/toc.json&bc=https://docs.microsoft.com/azure/cloud-adoption-framework/_bread/toc.json)

Alternatively, workloads can be migrated through a disaster recovery failover using the following tools:

- [Back up workload virtual machines](https://docs.microsoft.com/azure/vmware-cloudsimple/backup-workloads-veeam.md?toc=https://docs.microsoft.com/azure/cloud-adoption-framework/toc.json&bc=https://docs.microsoft.com/azure/cloud-adoption-framework/_bread/toc.json)
- [Configure Private Cloud as disaster recovery site using Zerto](https://docs.microsoft.com/azure/vmware-cloudsimple/disaster-recovery-zerto.md?toc=https://docs.microsoft.com/azure/cloud-adoption-framework/toc.json&bc=https://docs.microsoft.com/azure/cloud-adoption-framework/_bread/toc.json)
- [Configure Private Cloud as disaster recovery site using VMware SRM](https://docs.microsoft.com/azure/vmware-cloudsimple/disaster-recovery-site-recovery-manager.md?toc=https://docs.microsoft.com/azure/cloud-adoption-framework/toc.json&bc=https://docs.microsoft.com/azure/cloud-adoption-framework/_bread/toc.json)

## Next steps

Return to the [Expanded Scope Checklist](./index.md) to ensure your migration method is fully aligned.

> [!div class="nextstepaction"]
> [Expanded scope checklist](./index.md)
