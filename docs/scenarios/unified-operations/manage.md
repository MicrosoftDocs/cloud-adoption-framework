---
title: "Manage hybrid and multicloud operations"
description: Implement effective controls to provide operations management across hybrid and multicloud deployments, leveraging Azure's enterprise control plane.
author: BrianBlanchard
ms.author: brblanch
ms.date: 01/01/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: operate
---

# Manage hybrid and multicloud operations

Hybrid and multicloud leads to nature shifts in how you operate the cloud. The Manage methodology in the cloud adoption framework outlines a path for implementing an operations baseline and maturing that baseline throughout your cloud adoption lifecycle. Expanding your strategy to include hybrid, multicloud, and edge deployments will require a shift in how your implement proper operations management. [Unified operations](./unified-operations.md) is the best practice concept to address those shifting requirements.

This article outlines you can apply the concept of unified operations and implement best practices to ensure effective hybrid, multicloud, and edge operations.

## Always start with business alignment

Before implementing unified operations solution, its important to understand the scope of your hybrid, multicloud, and edge deployments. It's also important to understand the business impact of the workloads that will be hosted on a secondary cloud platform. This implementation guide will start with suggested steps for extending your operations baseline. That baseline may be sufficient to avoid duplicated or fractured operations.

However, you should evaluate the hybrid and multicloud strategy to determine if any of the following will exist in your future state:

- Do any of the environments have operational requirements beyond that of your operations baseline? If so, you may need to also implement an expanded baseline.
- Are there any shared platforms (like SQL, SAP, WVD, etc...) that will be deployed to a hybrid or multicloud environment? If so, you may need to invest more in platform operations for that technology platform.
- Do any of the workloads in your hybrid and multicloud strategy have higher operational requirements or abnormally high business impacts? If so, you may need to invest in workload operations and a well-architected review.

## Extending your operations baseline

Azure Arc reduces the complexity and cost of extending your operations baseline. Deploying Azure Arc across your data center, hybrid cloud, and multicloud environments will extend the built-in features of Azure that are included in Azure Resource Manager.

This simple deployment automatically provides you with all of the basic cloud control features:
    - Search, Index, Group, and Tag all deployed assets for basic visibility
    - Template, Automate, and Extend tooling for consistent deployment
    - Create Access and Security boundaries to protect deployed assets

**TODO: Add link** Get started today by deploying Azure Arc.

From there you can add additional cloud controls to create an enhanced baseline for all resources in that environment. You could also add further features and automated controls to improve operations of specific workloads or shared technology platforms running in your hybrid and multicloud environments.

## Enhanced baseline

If the hybrid and multicloud environment is governed by higher operations management requirements, then you may need to expand the operations baseline to include a number of common features. The following are a few of the most common features we see added to customers' enhanced baselines:

- Monitoring: Expand monitoring & alerts to include cloud service performance, and/or application performance.
- Inventory & change tracking: Consistently log, diagnose, and remediate issues related to inventory, change tracking, and patch management.

## Best Practices (Blocked - TODO Here)

> [!WARNING]
> TODO: We need to figure out how these integrate into the story. We can't drive traffic away from approved customer facing properties here. These articles are very similar to the Azure Server Management guide in CAF Manage. Should these be converted to MD files in that section?

### Azure Arc enabled Servers - Day-2 Scenarios & Use-Cases

Once you have server resources projected into Azure with Azure Arc, you can start to use native Azure tooling to manage the servers as native Azure resources. The following guides show examples of using Azure management tools such as resource tags, Azure Policy, Log Analytics, and more with Azure Arc enabled servers.

* [Tagging and querying server inventory across multiple clouds using Resource Graph Explorer](https://github.com/microsoft/azure_arc/blob/master/azure_arc_servers_jumpstart/docs/arc_inventory_tagging.md)

* [Deploying Microsoft Monitoring Agent Extension (MMA) to Azure Arc Linux and Windows VMs using Extension Management](https://github.com/microsoft/azure_arc/blob/master/azure_arc_servers_jumpstart/docs/arc_vm_extension_mma_arm.md)

* [Deploying Custom Script Extension to Azure Arc Linux and Windows VMs using Extension Management](https://github.com/microsoft/azure_arc/blob/master/azure_arc_servers_jumpstart/docs/arc_vm_extension_customscript_arm.md)

* [Deploying Microsoft Monitoring Agent Extension (MMA) to Azure Arc Linux and Windows VMs using Azure Policies](https://github.com/microsoft/azure_arc/blob/master/azure_arc_servers_jumpstart/docs/arc_policies_mma.md)
 
* [Integrate Azure Security Center with Azure Arc enabled Servers](https://github.com/microsoft/azure_arc/blob/master/azure_arc_servers_jumpstart/docs/arc_securitycenter.md)

* [Integrate Azure Sentinel with Azure Arc enabled Servers](https://github.com/microsoft/azure_arc/blob/master/azure_arc_servers_jumpstart/docs/arc_azuresentinel.md)

### Azure Arc enabled Servers - Scaled Deployment Scenarios

The following guides are designed to provide scaled onboarding experience to Azure Arc of virtual machines deployed in various platforms and existing environments.

 * [Scaled Onboarding VMware vSphere Windows Server VMs to Azure Arc](https://github.com/microsoft/azure_arc/blob/master/azure_arc_servers_jumpstart/docs/vmware_scaled_powercli_win.md)

 * [Scaled Onboarding VMware vSphere Linux VMs to Azure Arc](https://github.com/microsoft/azure_arc/blob/master/azure_arc_servers_jumpstart/docs/vmware_scaled_powercli_linux.md)

 * [Scaled Onboarding AWS EC2 instances to Azure Arc using Ansible](https://github.com/microsoft/azure_arc/blob/master/azure_arc_servers_jumpstart/docs/aws_scale_ansible.md)

## Next step: Your next migration iteration

Once the unified operations migration is complete, the cloud adoption team can begin your next scenario-specific migration. Alternatively, if there are addition platforms to be migrated, this article series can be used again to guide your next unified operations migration or deployment.

- [Strategy for unified operations](./strategy.md)
- [Plan for unified operations](./plan.md)
- [Review your environment or Azure Landing Zone(s)](./ready.md)
- [Assess for unified operations migration](./migrate-assess.md)
- [Migrate unified operations](./migrate-deploy.md)
- [Release unified operations to production](./migrate-release.md)
- [Innovate with unified operations](./innovate.md)
- [Govern unified operations](./govern.md)
- [Manage unified operations](./manage.md)
