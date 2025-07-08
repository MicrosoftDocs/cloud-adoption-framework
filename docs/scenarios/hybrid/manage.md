---
title: Manage your portfolio across hybrid and multicloud operations
description: Implement effective controls to provide operations management across hybrid and multicloud deployments by using Azure's enterprise control plane.
author: Zimmergren
ms.author: pnp
ms.date: 02/01/2020
ms.topic: conceptual
ms.custom: e2e-hybrid, think-tank
---

# Manage your portfolio across hybrid and multicloud operations

Using a hybrid and multicloud environment leads to natural shifts in how you operate in the cloud. The [Manage methodology](../../manage/index.md) of the Cloud Adoption Framework outlines a path for implementing an operations baseline and developing that baseline throughout your cloud adoption lifecycle. Expanding your strategy to include hybrid, multicloud, and edge deployments requires a shift in how you implement proper operations management. [Unified operations](./unified-operations.md) is the best concept to address those shifting requirements.

The following section outlines how you can apply the concept of unified operations and implement best practices to ensure effective hybrid, multicloud, and edge operations.

## Extend your operations baseline

[Azure Arc](/azure/azure-arc/overview) reduces the complexity and cost of extending your operations baseline. Deploying Azure Arc across your datacenter, hybrid cloud, and multicloud environments extends the native features of Azure that are included in Azure Resource Manager.

To get started with an operations baseline that spans on-premises and multiple cloud providers, complete an inventory and tagging exercise. This exercise will begin to extend your operations baselines in a few steps:

- Add a tag for `hosting platform` to all hybrid, multicloud, and edge assets.
- Tag resources from AWS, GCP, and so on.
- Query your resources to discover where they're hosted.

<!-- docutune:casing "update management guide" -->

After you finish the exercise, you can begin to operate your hybrid and multicloud environment. Typically, the first step you take when you extend operations across clouds is to *establish a consistent plan for patch and update management*. For more information, see [Azure Update Manager overview](/azure/update-manager/overview).

## Operations management disciplines

Along with tagging and bringing on assets, you can also deliver many operations management disciplines by using hybrid and multicloud tools. Azure Arc resource bridge deployed on VMware vSphere and System Center managed private cloud environments simplifies hybrid workload management with Azure as the single control plane across your Azure and on-premises environments. You can manage the lifecycle and powercycle of your workloads wherever they are running using Azure Portal and set up automation using Azure APIs, SDKs, and Infrastructure as Code (IaC) templates. These articles provide more information:
- [Perform VM operations on VMware VMs through Azure](/azure/azure-arc/vmware-vsphere/perform-vm-ops-through-azure)
- [Perform VM operations on SCVMM VMs through Azure](/azure/azure-arc/system-center-virtual-machine-manager/perform-vm-ops-on-scvmm-through-azure)
 
Virtual machine (VM) extensions are small applications that provide post-deployment configuration and automation tasks on Azure VMs. For example, if a VM requires software installation or antivirus protection, or if you need to run a script on a VM, you can use a VM extension. These articles provide more information:

- [Virtual machine extension management with Azure Arc-enabled servers](/azure/azure-arc/servers/manage-vm-extensions)
- [Enable Azure VM extensions by using ARM templates](/azure/azure-arc/servers/manage-vm-extensions-template)

## Next steps

After the unified operations migration is finished, the cloud adoption team can begin your next scenario-specific migration. If there are more platforms to be migrated, use the following articles to help guide your next unified operations migration or deployment:

- [Strategy for unified operations](./strategy.md)
- [Plan for unified operations](./plan.md)
- [Review your environment or Azure landing zones](./ready.md)
- [Hybrid and multicloud migration](./migrate.md)
- [Govern hybrid and multicloud environments](./govern.md)
