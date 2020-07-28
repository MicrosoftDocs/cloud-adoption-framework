---
title: "Windows Virtual Desktop proof of concept"
description: Use the Cloud Adoption Framework for Azure to learn Windows Virtual Desktop migration best practices to reduce complexity and standardize the migration process.
author: BrianBlanchard
ms.author: brblanch
ms.date: 07/01/2010
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
---

# Windows Virtual Desktop proof of concept

To validate the configuration of the Azure landing zone and end-user network capacity, before they deploy the end-user desktop, the Contoso cloud adoption team completes and tests a proof of concept. 

The following approach to the migration process is simplified to outline a proof-of-concept implementation.

1. **Assess**: They deploy host pools by using the default VM sizes. Assessment data help them identify the expected number of concurrent user sessions and the number of virtual machines required to support those concurrent sessions.
2. **Deploy**: They [create a host pool](https://docs.microsoft.com/azure/virtual-desktop/create-host-pools-azure-marketplace) for pooled desktops by using a Windows 10 gallery image from Azure Marketplace and the sizing from assessment step 1.
3. **Deploy**: They [create RemoteApp application groups](https://docs.microsoft.com/azure/virtual-desktop/manage-app-groups#create-a-remoteapp-group) for workloads that they've already migrated.
4. **Deploy**: They [create an FSLogix profile container](https://docs.microsoft.com/azure/virtual-desktop/create-host-pools-user-profile) to store user profiles.
5. **Release**: They test the performance and latency of application groups and deployed desktops for a sampling of users.
6. **Release**: They onboard their end users to teach them how to connect through [Windows desktop client](https://docs.microsoft.com/azure/virtual-desktop/connect-windows-7-and-10), [web client](https://docs.microsoft.com/azure/virtual-desktop/connect-web), [Android client](https://docs.microsoft.com/azure/virtual-desktop/connect-android), [macOS client](https://docs.microsoft.com/azure/virtual-desktop/connect-macos), or [iOS client](https://docs.microsoft.com/azure/virtual-desktop/connect-ios).

## Assumptions

The proof of concept approach could meet some production needs, but it's built on a number of assumptions.

It's unlikely that all the following assumptions will prove to be true for any enterprise migration of Windows Virtual Desktop (WVD). The adoption team should assume that the production deployment will require a separate deployment that more closely aligns to the production requirements that they identify during the Windows Virtual Desktop assessment. The assumptions are:

* End users have a low-latency connection to the assigned landing zone in Azure.
* All users can work from a shared pool of desktops.
* All users can use the Windows&nbsp;10 Enterprise multi-session image from Azure Marketplace.
* All user profiles will be migrated to either Azure Files, Azure NetApp Files, or a virtual machine (VM)-based storage service for the FSLogix profile containers.
* All users can be described by a common persona with a density of six users per virtual central processing unit (vCPU) and 4&nbsp;gigabytes (GB) of RAM, [as per the VM sizing recommendations](https://docs.microsoft.com/windows-server/remote/remote-desktop-services/virtual-machine-recs#multi-session-recommendations).
* All workloads are compatible with Windows&nbsp;10 multi-session.
* Latency between the virtual desktops and application groups is acceptable for production usage.

To calculate the cost of the WVD scenario based on the proof-of-concept configuration reference, the pricing calculator for [East US](https://azure.com/e/448606254c9a44f88798892bb8e0ef3c), [West Europe](https://azure.com/e/61a376d5f5a641e8ac31d1884ade9e55), or [Southeast Asia](https://azure.com/e/7cf555068922461587d0aa99a476f926). 
> [!NOTE]
> These examples all use Azure Files as the storage service for user profile storage.

## Next steps

For guidance on specific elements of the cloud adoption journey, see:

- [Assess for Windows Virtual Desktop migration or deployment](./migrate-assess.md)
- [Deploy or migrate Windows Virtual Desktop instances](./migrate-deploy.md)
- [Release your Windows Virtual Desktop deployment to production](./migrate-release.md)
