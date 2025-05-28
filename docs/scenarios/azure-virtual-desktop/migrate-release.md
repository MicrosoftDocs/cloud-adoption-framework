---
title: Azure Virtual Desktop post-deployment and release tasks
description: Use the Cloud Adoption Framework best practices to learn about the release process for the migration or deployment of Azure Virtual Desktop instances.
author: Zimmergren
ms.author: pnp
ms.date: 05/18/2021
ms.topic: conceptual
ms.custom: think-tank, e2e-avd
---

# Azure Virtual Desktop post-deployment

The release process for the migration or deployment of Azure Virtual Desktop instances is straightforward. This process mirrors the one used during the [Azure Virtual Desktop proof of concept](./proof-of-concept.md):

- Test the performance and latency of application groups and deployed desktops for a sampling of users.
- Onboard end users to teach them how to connect via:
  - [Windows desktop client](/azure/virtual-desktop/user-documentation/connect-windows-7-10)
  - [Web client](/azure/virtual-desktop/user-documentation/connect-web)
  - [Android client](/azure/virtual-desktop/user-documentation/connect-android)
  - [macOS client](/azure/virtual-desktop/user-documentation/connect-macos)
  - [iOS client](/azure/virtual-desktop/user-documentation/connect-ios)

## Post-deployment

After the release has been completed, it's common to add [logging and diagnostics to better operate Azure Virtual Desktop](/azure/virtual-desktop/azure-monitor).

Although the release process is out of scope for this migration scenario, the process might expose the need to migrate additional workloads to Azure during subsequent iterations of migration. If you haven't configured Microsoft 365 or Microsoft Entra ID, your cloud adoption team might choose to onboard into those services upon the release of the desktop scenarios. For a hybrid operating model, operations teams might also choose to integrate Intune, System Center, or other configuration management tools to improve operations, compliance, and security.

## Next steps

After the Azure Virtual Desktop migration is complete, your cloud adoption team can begin the next scenario-specific migration. Alternately, if there are additional desktops to be migrated, you can reuse this article series to guide your next Azure Virtual Desktop migration or deployment.

- [Plan for Azure Virtual Desktop migration or deployment](./plan.md)
- [Review your environment or Azure landing zones](./ready.md)
- [Complete an Azure Virtual Desktop proof of concept](./proof-of-concept.md)
- [Assess for Azure Virtual Desktop migration or deployment](./migrate-assess.md)
- [Deploy or migrate Azure Virtual Desktop instances](./migrate-deploy.md)
- [Release your Azure Virtual Desktop deployment to production](./migrate-release.md)
