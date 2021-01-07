---
title: "Manage hybrid and multicloud operations"
description: Implement effective controls to provide operations management across hybrid and multicloud deployments, leveraging Azure's enterprise control plane.
author: BrianBlanchard
ms.author: brblanch
ms.date: 02/01/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: operate
---

# Manage hybrid and multicloud operations

Hybrid and multicloud leads to natural shifts in how you operate the cloud. The Manage methodology in the cloud adoption framework outlines a path for implementing an operations baseline and maturing that baseline throughout your cloud adoption lifecycle. Expanding your strategy to include hybrid, multicloud, and edge deployments will require a shift in how your implement proper operations management. [Unified operations](./unified-operations.md) is the best practice concept to address those shifting requirements.

This article outlines how you can apply the concept of unified operations and implement best practices to ensure effective hybrid, multicloud, and edge operations.

## Extending your operations baseline

Azure Arc reduces the complexity and cost of extending your operations baseline. Deploying Azure Arc across your data center, hybrid cloud, and multicloud environments will extend the built-in features of Azure that are included in Azure Resource Manager.

To get started with an operations baseline that spans multiple cloud providers, complete a simple inventory and tagging exercise. This simple exercise will begin to extend your operations baselines in a few simple steps:

- Add a tag for "hosting platform" to all hybrid, multicloud, and edge assets
- Tag resources from AWS, GCP, etc...
- Query your resources to see where they are all hosted.

To get started, [inventory and tag your hybrid and multicloud resources](../../manage/unified-operations/server/best-practices/arc_inventory_tagging.md)
**TODO Point to relative link**

Once you complete the basic exercise your can begin operating your hybrid and multicloud environment. The first step most customers take when extending operations across clouds, is to establish a consistent plan for patch and update management. Follow this guide on [hybrid and multicloud update management](https://review.docs.microsoft.com/azure/cloud-adoption-framework/manage/unified-operations/server/best-practices/arc_updatemanagement?branch=pr-en-us-884) to deploy tools that can control patching across cloud providers.

## Enhanced baseline

Enhance your operations baseline by onboarding a continuously broader range of assets and cloud providers. The follow list provides a few examples of the type of assets you can add to your expanded operations baseline.

- Onboard Azure assets: [linux VMs](https://review.docs.microsoft.com/en-us/azure/cloud-adoption-framework/manage/unified-operations/server/best-practices/azure_arm_template_linux) and [Windows VMs](https://review.docs.microsoft.com/en-us/azure/cloud-adoption-framework/manage/unified-operations/server/best-practices/azure_arm_template_win)
- Onboard assets in your local data center: [linux VMs](https://review.docs.microsoft.com/en-us/azure/cloud-adoption-framework/manage/unified-operations/server/best-practices/onboard_server_linux) and [Windows VMs](https://review.docs.microsoft.com/en-us/azure/cloud-adoption-framework/manage/unified-operations/server/best-practices/onboard_server_win)
- Onboard VMware assets: [linux VMs](https://review.docs.microsoft.com/en-us/azure/cloud-adoption-framework/manage/unified-operations/server/best-practices/vmware_scaled_powercli_linux) and [Windows VMs](https://review.docs.microsoft.com/en-us/azure/cloud-adoption-framework/manage/unified-operations/server/best-practices/vmware_scaled_powercli_win)
- Onboard AWS assets: [linux VMs with Terraform](https://review.docs.microsoft.com/en-us/azure/cloud-adoption-framework/manage/unified-operations/server/best-practices/aws_terraform_al2) and [AWS Ubuntu with Terraform](https://review.docs.microsoft.com/en-us/azure/cloud-adoption-framework/manage/unified-operations/server/best-practices/aws_terraform_ubuntu)
- Onboard GCP assets: [Ubuntu VMs](https://review.docs.microsoft.com/en-us/azure/cloud-adoption-framework/manage/unified-operations/server/best-practices/gcp_terraform_ubuntu) and [Windows VMs](https://review.docs.microsoft.com/en-us/azure/cloud-adoption-framework/manage/unified-operations/server/best-practices/gcp_terraform_windows)

## Operations management disciplines

In addition to tagging and onboarding assets, you can also deliver a number of operations management disciplines using hybrid and multicloud tools.

Once example of a mature operations management discipline, is the use of Microsoft Monitoring Agents to manage software installation, anti-virus protection, or other configuration management functions. The following articles demonstrate configuration of MMA in your hybrid and multicloud environment.

- [Manage VMs with MMA](https://review.docs.microsoft.com/en-us/azure/cloud-adoption-framework/manage/unified-operations/server/best-practices/arc_vm_extension_mma_arm?branch=pr-en-us-884)
- [Scale configuration of MMA](https://review.docs.microsoft.com/en-us/azure/cloud-adoption-framework/manage/unified-operations/server/best-practices/arc_vm_extension_customscript_arm)

As you mature your hybrid and multicloud operations, periodically check the [Unified Operations best practices](https://review.docs.microsoft.com/en-us/azure/cloud-adoption-framework/manage/unified-operations/?branch=pr-en-us-884) for frequent updates and new examples of best practice implementations.

## Next step: Your next migration iteration

Once the unified operations migration is complete, the cloud adoption team can begin your next scenario-specific migration. Alternatively, if there are addition platforms to be migrated, this article series can be used again to guide your next unified operations migration or deployment.

- [Strategy for unified operations](./strategy.md)
- [Plan for unified operations](./plan.md)
- [Review your environment or Azure Landing Zone(s)](./ready.md)
- [Hybrid and multicloud migration](./migrate.md)
- [Govern hybrid and multicloud environments](./govern.md)
- [Manage hybrid and multicloud environments](./manage.md)
