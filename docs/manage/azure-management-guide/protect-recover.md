---
title: Protect and recover in Azure
titleSuffix: Microsoft Cloud Adoption Framework for Azure
description: Ensure business stability by decreasing recovery time
author: BrianBlanchard
ms.author: brblanch
ms.date: 10/17/2019
ms.topic: article
ms.service: cloud-adoption-framework
ms.subservice: operate
ms.custom: fasttrack-edit, AQC
ms.localizationpriority: high
---

# Protect and recover in Azure

Protect and recovery is the third and final discipline in any cloud management baseline.

![Cloud Management Baseline](../../_images/manage/management-baseline.png)

In the last article "Operational compliance", the objective is to reduce the likelihood of a business interruption. This article "Protect and recover" aims to reduce the duration and impact of outages that can't be prevented.

For any enterprise-grade environment, the following table outlines the suggested minimum for any management baseline.

|Process  |Tool  |Purpose  |
|---------|---------|---------|
|Protect data|Azure Backup|Back up data and VMs in the cloud|
|Protect the environment|Azure Security Center|

::: zone target="docs"

## Azure Backup

::: zone-end
::: zone target="chromeless"

## [Azure Backup](#tab/UpdbackupateManagement)

::: zone-end

Azure Backup is the Azure-based service you can use to back up (or protect) and recover your data in the Microsoft cloud. Azure Backup replaces your existing on-premises or offsite backup solution with a cloud-based solution that is reliable, secure, and cost-competitive. It can also be used to protect and recover on-premises assets through one consistent solution.

### Enable backup for an Azure VM

1. In the Azure portal, select **Virtual machines**, and select the VM you want to replicate.
1. In **Operations**, select **Backup**.
1. Create or select an existing Recovery Services vault.
1. Select **Create (or edit) a new policy**.
1. Configure the schedule and retention period.
1. Select **OK**.
1. Select **Enable Backup**.

::: zone target="chromeless"

::: form action="OpenBlade[#blade/HubsExtension/Resources/resourceType/Microsoft.Compute%2FVirtualMachines]" submitText="Go to Virtual Machines" :::

::: zone-end

::: zone target="docs"

[Overview](https://docs.microsoft.com/azure/backup/backup-introduction-to-azure-backup)

## Azure Site Recovery

::: zone-end
::: zone target="chromeless"

## [Azure Site Recovery](#tab/siterecovery)

::: zone-end

Azure Site Recovery is a critical component in your disaster recovery strategy.

The Azure Site Recovery service allows you to replicate virtual machines and workloads hosted in a primary Azure region to a copy hosted in a secondary region. When an outage occurs in your primary region, you can fail over to the copy running in the secondary region and continue to access your applications and services from there. This proactive approach to recovery can significantly reduce recovery times. When the recovery environment is no longer necessary, production traffic can fall back over to the original environment.

### Replicate an Azure VM to another region with Site Recovery service

The following steps outline the process to use Site Recovery service to replicate an Azure VM to another region (Azure-to-Azure):

>
> [!TIP]
> Depending on your scenario, the exact steps may differ slightly.
>

### Enable replication for the Azure VM

1. In the Azure portal, select **Virtual machines**, and select the VM you want to replicate.
1. In **Operations**, select **Disaster recovery**.
1. In **Configure disaster recovery** > **Target region**, select the target region to which you'll replicate.
1. For this Quickstart, accept the other default settings.
1. Select **Enable replication**, which starts a job to enable replication for the VM.

::: zone target="chromeless"

::: form action="OpenBlade[#blade/HubsExtension/Resources/resourceType/Microsoft.Compute%2FVirtualMachines]" submitText="Go to Virtual Machines" :::

::: zone-end

### Verify settings

After the replication job has finished, you can check the replication status, verify replication health, and test the deployment.

1. In the VM menu, select **Disaster recovery**.
2. Verify replication health, the recovery points that have been created, and source and target regions on the map.

::: zone target="chromeless"

::: form action="OpenBlade[#blade/HubsExtension/Resources/resourceType/Microsoft.Compute%2FVirtualMachines]" submitText="Go to Virtual Machines" :::

::: zone-end

### Learn more

- [Azure Site Recovery overview](https://docs.microsoft.com/azure/site-recovery/site-recovery-overview)
- [Replicate an Azure VM to another region](https://docs.microsoft.com/azure/site-recovery/azure-to-azure-quickstart)
