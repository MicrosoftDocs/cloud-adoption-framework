---
title: Replication options
description: Replicate on-premises assets to the cloud.
author: martinekuan
ms.author: martinek
ms.reviewer: ssumner
ms.date: 09/19/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
ms.custom: internal
---

# Replication options

In most cases, we recommend Azure Migrate for replicating on-premises assets to the cloud. However, there are certain scenarios where Azure Site Recovery and Azure Database Migration Service are preferable. This article helps you understand these two alternate services.

## Azure Site Recovery

[Azure Site Recovery](/azure/site-recovery/site-recovery-overview) orchestrates and manages disaster recovery for Azure VMs, on-premises VMs, and physical servers. You can also use Site Recovery to manage migration of machines on-premises and other cloud providers to Azure. Replicate on-premises machines to Azure or Azure VMs to a secondary region. Then, you fail the VM from the primary site to the secondary and complete the migration process. With Azure Site Recovery, you can achieve various migration scenarios:

- **Migrate from on-premises to Azure.** Migrate on-premises VMware VMs, Hyper-V VMs, and physical servers to Azure. Complete the same steps as you would for full disaster recovery. Simply don't fail machines back from Azure to the on-premises site.
- **Migrate between Azure regions.** Migrate Azure VMs from one Azure region to another. After the migration is complete, configure disaster recovery for the Azure VMs now in the secondary region to which you migrated.
- **Migrate from other cloud to Azure.** You can migrate your compute instances provisioned on other cloud providers to Azure VMs. Site Recovery treats those instances as physical servers for migration purposes.

![Azure Site Recovery](../../../_images/migrate/asr-replication-image.png)
*Figure 1: Azure Site Recovery moving assets to Azure or other clouds.*

You want to assess your on-premises and cloud infrastructure for migration before using Azure Site Recovery. After the assessment, you can use Azure Site Recovery to replicate your on-premises machines to the cloud.

See the following steps to set up migration for on-premises VMs, physical servers, and cloud VM instances to Azure:

- Verify prerequisites
- Prepare Azure resources
- Prepare on-premises VM or cloud instances for migration
- Deploy a configuration server
- Enable replication for VMs
- Test failover to make sure everything's working
- Run a one-time failover to Azure

## Azure Database Migration Service

[Azure Database Migration Service](/azure/dms/dms-overview) helps reduce the complexity of your cloud migration. It uses a single comprehensive service instead of multiple tools. It's a fully managed service designed to enable seamless migrations from multiple database sources to Azure data platforms with little downtime. The service integrates functionality from existing tools and services for a more comprehensive database solution.

The data migration assistant generates assessment reports that guide you through the changes required before performing a migration. It's up to you to do any required remediation. When you're ready to begin the migration process, Azure Database Migration Service does all of the associated steps. You can fire and forget your migration projects with peace of mind, knowing that the process takes advantage of Microsoft best practices.

## Next steps

After replication is complete, you can begin [staging activities](./stage.md).

> [!div class="nextstepaction"]
> [Staging activities during a migration](./stage.md)
