---
title: Manage your portfolio across hybrid and multicloud operations
description: Implement effective controls to provide operations management across hybrid and multicloud deployments by using Azure's enterprise control plane.
author: brianblanchard
ms.author: brblanch
ms.date: 02/01/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-hybrid
---

# Manage your portfolio across hybrid and multicloud operations

Using a hybrid and multicloud environment leads to natural shifts in how you operate in the cloud. The [Manage methodology](../../manage/index.md) in the Cloud Adoption Framework for Azure outlines a path for implementing an operations baseline and developing that baseline throughout your cloud adoption lifecycle. Expanding your strategy to include hybrid, multicloud, and edge deployments requires a shift in how you implement proper operations management. [Unified operations](./unified-operations.md) is the best concept to address those shifting requirements.

The following section outlines how you can apply the concept of unified operations and implement best practices to ensure effective hybrid, multicloud, and edge operations.

## Extend your operations baseline

[Azure Arc](/azure/azure-arc/overview) reduces the complexity and cost of extending your operations baseline. Deploying Azure Arc across your datacenter, hybrid cloud, and multicloud environments extends the native features of Azure that are included in Azure Resource Manager.

To get started with an operations baseline that spans on-premises and multiple cloud providers, complete an inventory and tagging exercise. This exercise will begin to extend your operations baselines in a few steps:

- Add a tag for `hosting platform` to all hybrid, multicloud, and edge assets.
- Tag resources from AWS, GCP, and so on.
- Query your resources to discover where they're hosted.

To get started, [inventory and tag your hybrid and multicloud resources](../../manage/hybrid/server/best-practices/arc-inventory-tagging.md).

<!-- docutune:casing "update management guide" -->

After you finish the exercise, you can begin to operate your hybrid and multicloud environment. Typically, the first step you take when you extend operations across clouds is to *establish a consistent plan for patch and update management*. To deploy tools that can control patching across cloud providers, follow the steps in the [Hybrid and multicloud update management guide](../../manage/hybrid/server/best-practices/arc-update-management.md).

## Enhanced baseline

Enhance your operations baseline by bringing on a continuously broader range of assets and cloud providers. The following list provides a few examples of the type of assets you can add to your expanded operations baseline:

- **Azure assets:** [Linux VMs](../../manage/hybrid/server/best-practices/arm-template-linux.md) and [Windows VMs](../../manage/hybrid/server/best-practices/arm-template-windows.md)
- **Assets in your local datacenter:** [Linux VMs](../../manage/hybrid/server/best-practices/onboard-server-linux.md) and [Windows VMs](../../manage/hybrid/server/best-practices/onboard-server-windows.md)
- **VMware assets:** [Linux VMs](../../manage/hybrid/server/best-practices/vmware-scaled-powercli-linux.md) and [Windows VMs](../../manage/hybrid/server/best-practices/vmware-scaled-powercli-windows.md)
- **AWS assets:** [Linux VMs with Terraform](../../manage/hybrid/server/best-practices/aws-terraform-al2.md) and [AWS Ubuntu with Terraform](../../manage/hybrid/server/best-practices/aws-terraform-ubuntu.md)
- **GCP assets:** [Ubuntu VMs](../../manage/hybrid/server/best-practices/gcp-terraform-ubuntu.md) and [Windows VMs](../../manage/hybrid/server/best-practices/gcp-terraform-windows.md)

## Operations management disciplines

Along with tagging and bringing on assets, you can also deliver many operations management disciplines by using hybrid and multicloud tools.

One example of a mature operations management discipline is the use of Microsoft Monitoring Agent to manage software installation, antivirus protection, or other configuration management functions. The following articles demonstrate configuration of Monitoring Agent in your hybrid and multicloud environment:

- [Manage VMs with Monitoring Agent](../../manage/hybrid/server/best-practices/arc-vm-extension-mma.md)
- [Scale configuration of Monitoring Agent](../../manage/hybrid/server/best-practices/arc-vm-extension-custom-script.md)

## Next steps

After the unified operations migration is finished, the cloud adoption team can begin your next scenario-specific migration. If there are more platforms to be migrated, use the following articles to help guide your next unified operations migration or deployment:

- [Strategy for unified operations](./strategy.md)
- [Plan for unified operations](./plan.md)
- [Review your environment or Azure landing zones](./ready.md)
- [Hybrid and multicloud migration](./migrate.md)
- [Govern hybrid and multicloud environments](./govern.md)
