---
title: Protect and recover in Azure
description: Learn how to ensure business stability by reducing recovery time and the likelihood of business interruption.
author: BrianBlanchard
ms.author: brblanch
ms.date: 10/17/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: manage
ms.localizationpriority: high
ms.custom: internal, fasttrack-edit, AQC
---

<!-- docutune:ignore "provide advanced threat protection" -->

# Protect and recover in Azure

*Protect and recover* is the third and final discipline in any cloud-management baseline.

![Cloud Management Baseline](../../_images/manage/management-baseline.png)

In [Operational compliance in Azure](./operational-compliance.md) the objective is to reduce the likelihood of a business interruption. The current article aims to reduce the duration and impact of outages that can't be prevented.

For any enterprise-grade environment, this table outlines the suggested minimum for any management baseline:

| Process                 | Tool                  | Purpose                                                                                  |
| ----------------------- | --------------------- | ---------------------------------------------------------------------------------------- |
| Protect data            | Azure Backup          | Back up data and virtual machines in the cloud.                                          |
| Protect the environment | Azure Security Center | Strengthen security and provide advanced threat protection across your hybrid workloads. |

::: zone target="docs"

## Azure Backup

::: zone-end
::: zone target="chromeless"

## [Azure Backup](#tab/AzureBackup)

::: zone-end

With Azure Backup, you can back up, protect, and recover your data in the Microsoft cloud. Azure Backup replaces your existing on-premises or offsite backup solution with a cloud-based solution. This new solution is reliable, secure, and cost competitive. Azure Backup can also help protect and recover on-premises assets through one consistent solution.

For data present in Azure, Azure Backup offer varied levels of protection. For example, when backing up key cloud infrastructure pieces such as Azure Virtual Machines and Azure Files, it offers [Azure Virtual Machines backup](/azure/backup/backup-azure-vms-introduction) and [Azure Files backup](/azure/backup/azure-file-share-backup-overview). For more critical components such as databases running in Azure Virtual Machines, it offers dedicated database backup solutions for [SQL Server](/azure/backup/backup-azure-sql-database) and [SAP HANA](/azure/backup/sap-hana-db-about) with far lower RPO.

Review the following section to see how easily you can enable backup for Azure Virtual Machines.

### Enable backup for an Azure VM

1. In the Azure portal, select **Virtual machines**, then select the VM you want to backup.
1. On the **Operations** pane, select **Backup**.
1. Create or select an existing Azure Recovery Services vault.
1. Select **Create (or edit) a new policy**.
1. Configure the schedule and retention period.
1. Select **OK**.
1. Select **Enable backup**.

::: zone target="chromeless"

::: form action="OpenBlade[#blade/HubsExtension/Resources/resourceType/Microsoft.Compute%2FVirtualMachines]" submitText="Go to Virtual Machines" :::

::: zone-end

::: zone target="docs"

For more details about Azure Backup, see [Overview of Azure Backup](/azure/backup/backup-overview).

## Azure Site Recovery

::: zone-end
::: zone target="chromeless"

## [Azure Site Recovery](#tab/siterecovery)

::: zone-end

Azure Site Recovery is a critical component in your disaster recovery strategy.

Site Recovery replicates VMs and workloads that are hosted in a primary Azure region. It replicates them to a copy that is hosted in a secondary region. When an outage occurs in your primary region, you fail over to the copy running in the secondary region. You then continue to access your applications and services from there. This proactive approach to recovery can significantly reduce recovery times. When the recovery environment is no longer needed, production traffic can fall back to the original environment.

### Replicate an Azure VM to another region with Site Recovery

The following steps outline the process to use Site Recovery for Azure-to-Azure replication, which is replication of an Azure VM to another region.
>
> [!TIP]
> Depending on your scenario, the exact steps might differ slightly.
>

### Enable replication for the Azure VM

1. In the Azure portal, select **Virtual machines**, then select the VM you want to replicate.
1. On the **Operations** pane, select **Disaster recovery**.
1. Select **Configure disaster recovery** > **Target region**, and choose the target region to which you'll replicate.
1. For this quickstart, accept the default values for all other options.
1. Select **Enable replication**, which starts a job to enable replication for the VM.

::: zone target="chromeless"

::: form action="OpenBlade[#blade/HubsExtension/Resources/resourceType/Microsoft.Compute%2FVirtualMachines]" submitText="Go to Virtual Machines" :::

::: zone-end

### Verify settings

After the replication job has finished, you can check the replication status, verify replication health, and test the deployment.

1. In the VM menu, select **Disaster recovery**.
1. Verify replication health, the recovery points that have been created, and source and target regions on the map.

::: zone target="chromeless"

::: form action="OpenBlade[#blade/HubsExtension/Resources/resourceType/Microsoft.Compute%2FVirtualMachines]" submitText="Go to Virtual Machines" :::

::: zone-end

### Learn more

- [Azure Site Recovery overview](/azure/site-recovery/site-recovery-overview)
- [Replicate an Azure VM to another region](/azure/site-recovery/azure-to-azure-quickstart)
