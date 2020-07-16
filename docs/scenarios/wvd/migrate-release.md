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

The release process for the migration or deployment Windows Virtual Desktop instances is relatively straightforward. This process is mirrors the process used during the [Windows Virtual Desktop proof of concept](./proof-of-concept.md):

- Test performance and latency of application groups and deployed desktops for a sampling of users.
- Onboard end users to teach them how to connect via:
  - [Windows desktop client](https://docs.microsoft.com/azure/virtual-desktop/connect-windows-7-and-10)
  - [Web client](https://docs.microsoft.com/azure/virtual-desktop/connect-web)
  - [Android client](https://docs.microsoft.com/azure/virtual-desktop/connect-android)
  - [macOS client](https://docs.microsoft.com/azure/virtual-desktop/connect-macos)
  - [iOS client](https://docs.microsoft.com/azure/virtual-desktop/connect-ios)

Once the release has been completed, it is common to add [logging and diagnostics to better operate Windows Virtual Desktop](https://docs.microsoft.com/azure/virtual-desktop/diagnostics-log-analytics#push-diagnostics-data-to-your-workspace). It is also common for operations teams to onboard the pooled hosts and desktop VMs into the [Azure server management best practices](../../manage/azure-server-management/index.md) to manage reporting, patching, and BCDR configurations.

While out of scope for this migration scenario, the release process may expose the need to migrate additional workloads to Azure during subsequent iterations of migration. If office365 or Azure AD haven't been configured, the team may choose to onboard into those services upon release of desktop scenarios. For a hybrid operating model, operations teams may also choose to integrate Intune, System Center, or other configuration management tools improve operations, compliance, and security.

## Next step: Your next migration iteration

Once the Windows Virtual Desktop migration is complete, the cloud adoption team can begin your next scenario specific migration. Alternatively, if there are addition desktops to be migrated, this article series can be used again to guide your next Windows Virtual Desktop migration or deployment.

- [Plan for Windows Virtual Desktop migration or deployment](./plan.md)
- [Review your environment or Azure landing zones](./ready.md)
- [Complete a Windows Virtual Desktop proof of concept](./proof-of-concept.md)
- [Assess for Windows Virtual Desktop migration or deployment](./migrate-assess.md)
- [Deploy or migrate Windows Virtual Desktop instances](./migrate-deploy.md)
- [Release your Windows Virtual Desktop deployment to production](./migrate-release.md)
