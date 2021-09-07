---
title: Azure Virtual Desktop proof of concept
description: Use the Cloud Adoption Framework to learn about best practices for completing and testing an Azure Virtual Desktop proof of concept.
author: DominicAllen
ms.author: doalle
ms.date: 05/18/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-avd
---

# Azure Virtual Desktop proof of concept

Before deploying end-user desktops, validate the configuration of the Azure landing zone and end-user network capacity by completing and testing a proof of concept.

The following approach to the migration process is simplified to outline a proof-of-concept implementation.

- **[Step 1: Assess](migrate-assess.md):**

  - The team deploys host pools by using the default virtual machine (VM) sizes. Assessment data helps the team identify the expected number of concurrent user sessions and the number of VMs required to support those concurrent sessions.

- **[Step 2: Migrate](migrate-deploy.md):**

  - The team [creates a host pool](/azure/virtual-desktop/create-host-pools-azure-marketplace) for pooled desktops by using a Windows 10 Enterprise multi-session gallery image from Azure Marketplace and the sizing from assessment step 1.
  - The team [creates either desktop or RemoteApp application groups](/azure/virtual-desktop/manage-app-groups#create-a-remoteapp-group) for workloads that it has already migrated.
  - The team [creates an FSLogix profile container](/azure/virtual-desktop/create-host-pools-user-profile) to store user profiles.

- **[Step 3: Release](migrate-release.md):**

  - The team tests the performance and latency of application groups and deployed desktops for a sampling of users.
  - The team onboards its end users to teach them how to connect through [Windows desktop client](/azure/virtual-desktop/connect-windows-7-10), [web client](/azure/virtual-desktop/connect-web), [Android client](/azure/virtual-desktop/connect-android), [macOS client](/azure/virtual-desktop/connect-macos), or [iOS client](/azure/virtual-desktop/connect-ios).

## Assumptions

The proof-of-concept approach could meet some production needs, but it's built on a number of assumptions.

It's unlikely that all the following assumptions will prove to be true for every enterprise migration of Azure Virtual Desktop, but they serve as a reference point to determine where tailoring may be required.

The adoption team should assume the production deployment will require a separate deployment that more closely aligns to the production requirements that it identifies during the Azure Virtual Desktop assessment. The assumptions are:

- End users have a low-latency connection to the assigned landing zone in Azure.
- All users can work from a shared pool of desktops.
- All users can use the Windows 10 Enterprise multi-session image from Azure Marketplace.
- All user profiles will be migrated to either Azure Files, Azure NetApp Files, or a VM-based storage service for the FSLogix profile containers.
- All users can be described by a common persona with a density of six users per virtual central processing unit (vCPU) and 4&nbsp;gigabytes (GB) of RAM, [as per the VM sizing recommendations](/windows-server/remote/remote-desktop-services/virtual-machine-recs#multi-session-recommendations).
- All workloads are compatible with Windows 10 Enterprise multi-session.
- Latency between the virtual desktops and application groups is acceptable for production usage.

To calculate the cost of the Azure Virtual Desktop scenario based on the proof of concept configuration reference, consider the following examples using the Azure pricing calculator for [East US](https://azure.com/e/448606254c9a44f88798892bb8e0ef3c), [West Europe](https://azure.com/e/61a376d5f5a641e8ac31d1884ade9e55), or [Southeast Asia](https://azure.com/e/7cf555068922461587d0aa99a476f926).
> [!NOTE]
> These examples all use Azure Files as the storage service for user profiles.

## Next steps

For guidance on specific elements of the cloud adoption journey, see:

- [Assess for Azure Virtual Desktop migration or deployment](./migrate-assess.md)
- [Deploy or migrate Azure Virtual Desktop instances](./migrate-deploy.md)
- [Release your Azure Virtual Desktop deployment to production](./migrate-release.md)
