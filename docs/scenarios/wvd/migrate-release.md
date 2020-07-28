---
title: "Windows Virtual Desktop post-deployment and release tasks"
description: Use the Cloud Adoption Framework for Azure to learn Windows Virtual Desktop migration best practices to reduce complexity and standardize the migration process.
author: BrianBlanchard
ms.author: brblanch
ms.date: 07/01/2010
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
---

# Windows Virtual Desktop post-deployment

The release process for the migration or deployment Windows Virtual Desktop (WVD) instances is relatively straightforward. This process mirrors the one used during the [Windows Virtual Desktop proof of concept](./proof-of-concept.md):

- Test the performance and latency of application groups and deployed desktops for a sampling of users.
- Onboard end-users to teach them how to connect via:
  - [Windows desktop client](https://docs.microsoft.com/azure/virtual-desktop/connect-windows-7-and-10)
  - [Web client](https://docs.microsoft.com/azure/virtual-desktop/connect-web)
  - [Android client](https://docs.microsoft.com/azure/virtual-desktop/connect-android)
  - [macOS client](https://docs.microsoft.com/azure/virtual-desktop/connect-macos)
  - [iOS client](https://docs.microsoft.com/azure/virtual-desktop/connect-ios)

## Post-deployment

After the release has been completed, it's common to add [logging and diagnostics to better operate WVD](https://docs.microsoft.com/azure/virtual-desktop/diagnostics-log-analytics#push-diagnostics-data-to-your-workspace). It's also common for operations teams to onboard the pooled hosts and desktop virtual machines (VMs) into the [Azure server management best practices](../../manage/azure-server-management/index.md) to manage reporting, patching, and business continuity and disaster recovery configurations.

Although the release process is out of scope for this migration scenario, the process might expose the need to migrate additional workloads to Azure during subsequent iterations of migration. If you haven't configured Office 365 or Azure Active Directory (Azure AD), your cloud adoption team might choose to onboard into those services upon release of desktop scenarios. For a hybrid operating model, operations teams might also choose to integrate Intune, System Center, or other configuration management tools to improve operations, compliance, and security.

## Next steps

After the WVD migration is complete, your cloud adoption team can begin the next scenario-specific migration. Alternatively, if there are addition desktops to be migrated, you can reuse this article series to guide your next WVD migration or deployment.

- [Plan for Windows Virtual Desktop migration or deployment](./plan.md)
- [Review your environment or Azure landing zones](./ready.md)
- [Complete a Windows Virtual Desktop proof of concept](./proof-of-concept.md)
- [Assess for Windows Virtual Desktop migration or deployment](./migrate-assess.md)
- [Deploy or migrate Windows Virtual Desktop instances](./migrate-deploy.md)
- [Release your Windows Virtual Desktop deployment to production](./migrate-release.md)
