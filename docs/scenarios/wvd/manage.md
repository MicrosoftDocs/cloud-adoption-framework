---
title: Manage an Azure Virtual Desktop environment
description: Explore management best practices for Azure Virtual Desktop
author: DominicAllen
ms.author: doalle
ms.date: 05/18/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-avd
---

# Manage an Azure Virtual Desktop environment

The [Cloud Adoption Framework provides a core methodology to define operation management processes](../../manage/index.md) for the cloud in an agnostic sense. Its guidance helps establish an operations management baseline and other specialized layers of operations. This article outlines what you need to integrate into your existing operations to prepare for virtual desktop management.

## Business alignment for operations management needs

Using virtual desktops simplifies the provisioning and management of desktops for users, leading to improved operations management outcomes. To realize these operational improvements, you might have to revise your desktop management strategy, starting with the business alignment.

To establish proper operations management practices, you must understand how virtual desktops will be used in your cloud adoption plans and what benefits you want to realize from this shift to virtualized desktops.

- Will you manage multiple technology solutions, such as virtual desktops and remote access from physical devices in your cloud platform?
- Will centralized teams support operations and management of the virtual desktop platform? Does this accountability shift to the individual workload teams?
- Will centralized teams support operations and management of the applications running in each virtual desktop configuration? Does this accountability shift to the individual workload teams?
- Are you using virtual desktops for access to mission-critical applications?
- Are you only using virtual desktops for less-critical or utility applications and functions to reduce costs?
- How important is the performance and reliability of your virtual desktop environment?
- Are the applications accessed via your virtual desktop resistant to disconnection? Do you need to persist state to protect and recover the application session on the desktop session?

These basic questions will shape how to best integrate Azure Virtual Desktop into your operations management strategy.

## Operations baseline

Implementing an operations baseline provides centralized access to the tools required to operate and manage all assets in your cloud environment. If you don't have an operations baseline for your assets, you can implement the [operations baseline defined in the Manage methodology](../../manage/azure-server-management/index.md).

Your operations baseline should include tools and configurations to provide visibility, monitoring, operational compliance, optimization, and protection/recovery.

![Operations management baseline](../../_images/manage/management-baseline.png)

## Platform operations

Unless this implementation is your organization's first or only deployment to the cloud, you should have an operations baseline. This section identifies a few tools you might want to include to help manage your virtual desktop environment.

### Inventory and visibility

Monitoring Azure Virtual Desktop uses the tools, dashboards, and alerts in your operations baseline. However, you might need to add extra configuration to integrate data from your virtual desktop into operations monitoring tools like [Azure Monitor for Azure Virtual Desktop](/azure/virtual-desktop/azure-monitor).

Once you've configured Azure Monitor to collect data on your virtual desktop, you can monitor the following areas as part of your centralized management processes:

- Disk performance
- Host performance
- Session performance
- Session diagnostics

These metrics will enable operations teams to monitor and react to performance and user experience issues to ensure a good overall platform experience.

### Operations compliance

Patching and scaling are key elements of the ongoing operational management of an Azure Virtual Desktop environment. The operators may sit in many different teams, depending on your desired operations approach.

To maintain operations compliance, an operator will monitor usage, resize assets to balance performance and cost, and patch the underlying systems to minimize risk and configuration drift.

Central IT organizations tend to deliver these tasks as part of the operations baseline for infrastructure as a service (IaaS).

The following guides provide best practices for implementing management capabilities for Azure Virtual Desktop environments:

- [Use Azure Monitor for Azure Virtual Desktop](/azure/virtual-desktop/azure-monitor)
- [Use Azure Advisor for Azure Virtual Desktop](/azure/virtual-desktop/azure-advisor)
- [Configure automatic updates for Azure Virtual Desktop](/azure/virtual-desktop/configure-automatic-updates)

### Protect and recover

The Azure Virtual Desktop architecture separates the host compute from the user profile and associated data, making it easier to move the host if necessary for performance reasons.

You can manage user profiles in solutions such as [FSLogix profile containers](/azure/virtual-desktop/create-host-pools-user-profile) in order to store the complete user profile in a single container. This configuration enables the profile to roam between virtual desktops.

In addition, using concepts such as [MSIX app attach](/azure/virtual-desktop/app-attach-image-prep) also helps separate the applications from the operating system. It's then easier to provision virtual machines.

### Workload operations

The platform operations section above illustrates a common conversation when managing Azure Virtual Desktop. Will the virtual desktops platform and applications be managed centrally? Or are they a workload tool that should be managed by the teams who own each of the workloads? The answer is different for different organizations. The constant seen across most organizations is that virtual desktops are designed to give the users more flexibility in how they want to work and access applications in a secure way.

Workload operations can build on your existing operations baseline and platform-specific operations. You can also safely operate an Azure Virtual Desktop environment using completely decentralized workload operations.

In either case, when you need to elevate operations to focus on specific outcomes for a specific workload, you can use the [Azure Well-Architected Framework](/azure/architecture/framework/) and [Microsoft Azure Well-Architected Review](/assessments/?id=azure-architecture-review&mode=pre-assessment) to get specific on the types of operational processes and tools to use for your workload.
