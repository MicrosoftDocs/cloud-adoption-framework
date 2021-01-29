---
title: "Manage your portfolio across hybrid and multicloud operations"
description: Implement effective controls to provide operations management across hybrid and multicloud deployments, leveraging Azure's enterprise control plane.
author: mpvenables
ms.author: brblanch
ms.date: 02/01/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: operate
---

# Manage your portfolio across hybrid and multicloud operations

Hybrid and multicloud leads to natural shifts in how you operate the cloud. The [Manage](https://docs.microsoft.com/azure/cloud-adoption-framework/manage/) methodology in the Microsoft Cloud Adoption Framework for Azure outlines a path for implementing an operations baseline, and maturing that baseline throughout your cloud adoption lifecycle. Expanding your strategy to include hybrid, multicloud, and edge deployments will require a shift in how you implement proper operations management. [Unified operations](./unified-operations.md) is the best practice concept to address those shifting requirements.

The section below outlines how you can apply the concept of unified operations, and implement best practices to ensure effective hybrid, multicloud, and edge operations.

## Extending your operations baseline

[Azure Arc](https://docs.microsoft.com/azure/azure-arc/overview) reduces the complexity and cost of extending your operations baseline. Deploying Azure Arc across your data center, hybrid cloud, and multicloud environments will extend the native features of Azure that are included in Azure Resource Manager.

To get started with an operations baseline that spans multiple cloud providers, complete a simple inventory and tagging exercise. This simple exercise will begin to extend your operations baselines in a few simple steps:

- **Add a tag for "hosting platform"** to all hybrid, multicloud, and edge assets.
- **Tag resources** from AWS, GCP, etc.
- **Query your resources**, to discover where they are hosted.

To get started, [inventory and tag your hybrid and multicloud resources](../../manage/unified-operations/server/best-practices/arc-inventory-tagging.md)

Once you complete the basic inventory and tagging exercise, you can begin operating your hybrid and multicloud environment. The first step most customers take when extending operations across clouds is **establishing a consistent plan for patch and update management**. Follow the [hybrid and multicloud update management](../../manage/unified-operations/server/best-practices/arc-update-management.md) guide to deploy tools that can control patching across cloud providers.

## Enhanced baseline

Enhance your operations baseline by onboarding a continuously broader range of assets and cloud providers. The follow list provides a few examples of the type of assets you can add to your expanded operations baseline.

- Onboard Azure assets: [Linux VMs](../../manage/unified-operations/server/best-practices/arm-template-linux.md) and [Windows VMs](../../manage/unified-operations/server/best-practices/arm-template-win.md)
- Onboard assets in your local data center: [Linux VMs](../../manage/unified-operations/server/best-practices/onboard-server-linux.md) and [Windows VMs](../../manage/unified-operations/server/best-practices/onboard-server-win.md)
- Onboard VMware assets: [Linux VMs](../../manage/unified-operations/server/best-practices/vmware-scaled-powercli-linux.md) and [Windows VMs](../../manage/unified-operations/server/best-practices/vmware-scaled-powercli-win.md)
- Onboard AWS assets: [Linux VMs with Terraform](../../manage/unified-operations/server/best-practices/aws-terraform-al2.md) and [AWS Ubuntu with Terraform](../../manage/unified-operations/server/best-practices/aws-terraform-ubuntu.md)
- Onboard GCP assets: [Ubuntu VMs](../../manage/unified-operations/server/best-practices/gcp-terraform-ubuntu.md) and [Windows VMs](../../manage/unified-operations/server/best-practices/gcp-terraform-windows.md)

## Operations management disciplines

In addition to tagging and onboarding assets, you can also deliver a number of operations management disciplines using hybrid and multicloud tools.

One example of a mature operations management discipline is to use Microsoft Monitoring Agents (MMA) to manage software installation, anti-virus protection, or other configuration management functions. The following articles demonstrate the configuration of MMAs in your hybrid and multicloud environment.

- [Manage VMs with MMA](../../manage/unified-operations/server/best-practices/arc-vm-extension-mma.md)
- [Scale configuration of MMA](../../manage/unified-operations/server/best-practices/arc-vm-extension-custom-script.md)

## Next step: Your next migration iteration

Once the unified operations migration is complete, the cloud adoption team can begin your next scenario-specific migration. Alternatively, if there are additional platforms to be migrated, the following articles can be used to help guide your next unified operations migration or deployment.

- [Strategy for unified operations](./strategy.md)
- [Plan for unified operations](./plan.md)
- [Review your environment or Azure Landing Zone(s)](./ready.md)
- [Hybrid and multicloud migration](./migrate.md)
- [Govern hybrid and multicloud environments](./govern.md)
- [Manage hybrid and multicloud environments](./manage.md)
