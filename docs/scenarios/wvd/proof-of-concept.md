---
title: "Windows Virtual Desktop proof of concept"
description: Use the Cloud Adoption Framework for Azure to learn Virtual desktop migration best practices to reduce complexity and standardize the migration process.
author: BrianBlanchard
ms.author: brblanch
ms.date: 07/01/2010
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
---

# Windows Virtual Desktop proof of concept

To validate configuration of the Azure landing zone and end-user network capacity, complete and test a proof of concept prior to end-user desktop deployment. The following approach to the migration process is simplified to outline a proof-of-concept implementation.

1. **Assess:** Host pools should be deployed using the default VM sizes. Assessment data will help identify the expected number of concurrent user sessions and the number of virtual machines required to support those concurrent sessions.
2. **Deploy:** [Create a host pool](https://docs.microsoft.com/azure/virtual-desktop/create-host-pools-azure-marketplace) for pooled desktops using a Windows 10 gallery image from the Azure Marketplace and the sizing from step 1.
3. **Deploy:** [Create RemoteApp application groups](https://docs.microsoft.com/azure/virtual-desktop/manage-app-groups#create-a-remoteapp-group) for workloads that have already been migrated.
4. **Deploy:** [Create an FSLogix profile container](https://docs.microsoft.com/azure/virtual-desktop/create-host-pools-user-profile) to store user profiles.
5. **Release:** Test performance and latency of application groups and deployed desktops for a sampling of users.
6. **Release:** Onboard end users to teach them how to connect through [Windows desktop client](https://docs.microsoft.com/azure/virtual-desktop/connect-windows-7-and-10), [web client](https://docs.microsoft.com/azure/virtual-desktop/connect-web), [Android client](https://docs.microsoft.com/azure/virtual-desktop/connect-android), [macOS client](https://docs.microsoft.com/azure/virtual-desktop/connect-macos), or [iOS client](https://docs.microsoft.com/azure/virtual-desktop/connect-ios)

## Assumptions

The proof of concept approach could meet some production needs. But, this approach is built on a number of assumptions.

It is unlikely that the following assumption will all prove to be true for any enterprise migration of WVD. The adoption team should assume that the production deployment will require a separate deployment that more closely aligns to the production requirements identified during the Windows Virtual Desktop assessment.

1. End users have a low latency connection to the assigned landing zone in Azure.
2. All users can work from a shared pool of desktops.
3. All users can use the Windows 10 Enterprise multi-session image from the Azure Marketplace.
4. All user profiles will be migrated to either Azure Files, Azure NetApp Files, or a VM-based storage service for the FSLogix profile containers.
5. All users can be described by a common persona with a density of six users per 1 vCPU and 4 GB of RAM, [as per the VM sizing recommendations](https://docs.microsoft.com/windows-server/remote/remote-desktop-services/virtual-machine-recs#multi-session-recommendations)
6. All workloads are compatible with Windows 10 multi-session.
7. Latency between the virtual desktops and application groups is acceptable for production usage.

To calculate the cost of the WVD scenario based on the proof-of-concept configuration reference, the pricing calculator for [East US](https://azure.com/e/448606254c9a44f88798892bb8e0ef3c), [West Europe](https://azure.com/e/61a376d5f5a641e8ac31d1884ade9e55), or [Southeast Asia](https://azure.com/e/7cf555068922461587d0aa99a476f926). Note - these examples all use Azure Files are the storage service for user profile storage.

## Next step: Assess for Windows Virtual Desktop

The following list of articles will take you to guidance found at specific points throughout the cloud adoption journey.

- [Assess for Windows Virtual Desktop migration or deployment](./migrate-assess.md)
- [Deploy or migrate Windows Virtual Desktop instances](./migrate-deploy.md)
- [Release your Windows Virtual Desktop deployment to production](./migrate-release.md)
