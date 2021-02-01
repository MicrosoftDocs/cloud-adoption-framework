---
title: "Ready methodology for hybrid and multicloud strategy"
description: Prepare your environment for hybrid and multicloud with Azure Landing Zones
author: mpvenables
ms.author: brblanch
ms.date: 02/01/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Ready: prepare your environment for hybrid and multicloud

The [Ready methodology](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/) of the Microsoft Azure Cloud Adoption Framework guides customers through environment readiness to prepare for cloud adoption. The readiness section includes technical accelerators (Azure Landing Zones), which are the basic building block in any cloud adoption environment. Landing zones automate the configuration of your Azure environment, aligning with best practices guidance in the Cloud Adoption Framework. When preparing for a hybrid and multicloud deployment, there are a number of environment configurations that may be slightly different. 

This article outlines key considerations and changes that are necessary to prepare your environments for the following:

- Expand connectivity boundaries to connect across hybrid and multicloud platforms
- Improve support for cloud native services like containers, Kubernetes, and hyper-converged infrastructure solutions to reduce hybrid and multicloud adoption friction
- Establish proper cloud native tools to support the use of Azure as **one** of your cloud platforms
- Implement unified operations tooling across all cloud environments to allow for unified operations

This article will guide you through the considerations required to achieve each of those environmental goals.

## Evaluate your cloud mix

Choosing hybrid and multicloud environment is not a binary decision, but closer to a range of decisions (as seen in the chart below). Before configuring your Azure environment (or any other cloud environment), it is important to identify how your cloud environment will support your specific mix of cloud hosting decisions. Below are a few examples of common cloud mixes:

![3 illustrations showing how different customers distribute workloads across cloud providers.](../../_images/unified-operations/cloud-mix.png)

The image above illustrates three of the most common cloud mixes we are seeing with customers. Each blue dot represents a workload. Each orange circle represents a business process, supported by a distinct environment. Each of these cloud mixes requires a very different Azure environment configuration.

- **Hybrid first:** Most workloads stay on-premises, often in a mixture of traditional, hybrid, and portable asset-hosting models. A small number of specific workloads are deployed to the edge, Azure, or to other cloud providers.
- **Azure first:** Most workloads have been moved to Azure. A small number of workloads stay on-premises. Strategic decisions have led to a small number of workloads living on the edge, or in multicloud environments.
- **Multicloud first:** Most workloads are currently hosted on a different public cloud, like GCP or AWS. Strategic decisions have led to a small number of workloads living in Azure or on the edge.
Each month, we see a steady flow of customers moving from a _hybrid first_ mix to an _Azure first_ mix as their cloud strategy matures. But, we also support a number of customers who have made strategic decisions to prioritize hybrid or multicloud mixes. Azure plays a role in each mix.

The most important things to consider when preparing any of your cloud environments for hybrid and multicloud, are the following:

- What mixture of hybrid, edge, and multicloud do you support today?
- What mixture best aligns with your strategy going forward?
- Do you want to operate each platform independently, or through a unified operations approach?

The answers to these questions will depend on your hybrid and multicloud strategy for your apps and data. With a clear understanding of your intended cloud mix, you can begin to consider the best configuration for your environments.

## Analyze your cloud mix

If you're unsure about your current cloud mix, the tools in Azure's control plane can help. Azure Arc, a built-in benefit of Azure Resource Manager, provides visibility into your cloud mix. This toolset is often the first step towards taking control of your cloud mix. You can use Azure Arc (as a complimentary tool) for discovery across all your cloud platforms.

To start evaluating your cloud mix across multiple cloud providers, complete a simple inventory and tagging exercise, in a few simple steps:

- **Add a tag for "hosting platform"** to all hybrid, multicloud, and edge assets.
- **Onboard and tag resources** from AWS, GCP, or other cloud providers.
- **Query your resources** to see where they are all hosted.

To get started, [inventory and tag your hybrid and multicloud resources](../../manage/unified-operations/server/best-practices/arc-inventory-tagging.md)

The following links will help you onboard and tag assets across each of your cloud providers:

- Onboard Azure assets: [Linux VMs](../../manage/unified-operations/server/best-practices/arm-template-linux.md) and [Windows VMs](../../manage/unified-operations/server/best-practices/arm-template-win.md)
- Onboard assets in your local data center: [Linux VMs](../../manage/unified-operations/server/best-practices/onboard-server-linux.md) and [Windows VMs](../../manage/unified-operations/server/best-practices/onboard-server-win.md)
- Onboard VMware assets: [Linux VMs](../../manage/unified-operations/server/best-practices/vmware-scaled-powercli-linux.md) and [Windows VMs](../../manage/unified-operations/server/best-practices/vmware-scaled-powercli-win.md)
- Onboard AWS assets: [Linux VMs with Terraform](../../manage/unified-operations/server/best-practices/aws-terraform-al2.md) and [AWS Ubuntu with Terraform](../../manage/unified-operations/server/best-practices/aws-terraform-ubuntu.md)
- Onboard GCP assets: [Ubuntu VMs](../../manage/unified-operations/server/best-practices/gcp-terraform-ubuntu.md) and [Windows VMs](../../manage/unified-operations/server/best-practices/gcp-terraform-windows.md)

## Configure your initial Azure environment

For each of the cloud mixes above, you will need an Azure environment to support, govern, and manage your cloud resources.
The Cloud Adoption Framework's Ready methodology helps prepare your environment using a few simple steps:

- Consider each of the [Azure landing zone design areas](../../ready/landing-zone/design-areas.md) to properly evaluate your technical requirements.
- Compare your requirements to the [Azure landing zone implementation options](../../ready/landing-zone/implementation-options.md), to find & implement the most suitable template to start your configuration.

## Modify your environment to reflect your cloud mix

Once your Azure environment is established, you can begin to modify your Azure environment to support the most appropriate cloud mix. The following modifications should be considered:

- **Identity:** Which cloud will host your primary identity provider? If that provider is outside of Azure, you may need to integrate your identity provider with Azure Active Directory. See [this article](https://docs.microsoft.com/azure/active-directory/external-identities/identity-providers) for additional guidance on identity providers.
- **Public network connectivity:** Best practice suggests that all ingress and egress traffic should route through one cloud platform when possible. But, your requirements or cloud mix may require more of a peer model. This is especially common if your cloud mix is used to satisfy redundancy and reliability requirements. How will you configure connectivity between each cloud platform and the public internet?
- **Backup and recovery:** It is very common for customers to centralize their backup and recovery strategy around the most reliable provider in their cloud mix. This often results in one of the cloud providers serving as a shared recovery center. Azure Backup and Azure Site Recovery can help in each case.
- **Cloud platform connectivity:** If your cloud platforms will share common recovery, operations, or governance resources, you may require connectivity between each cloud platform. How will you configure connectivity between each cloud platform?

### The most important consideration

**Will you operate each cloud independently, or through a unified central operations approach?**

Independent operations can double or triple your total cost of ownership. For some customers, Total Cost of Ownership (TCO) cost increases can be multiplied by over 10 times. To minimize costs and demands on your staff, best practice points to a unified operations approach for all cloud mixes for your hybrid and multicloud strategy.

To learn more about unification of your cloud operations, see the articles on [Unified Operations](./unified-operations.md), [Governance](./govern.md) and [Operations management](./manage.md) for hybrid and multicloud solutions.

## Next step: Prepare for hybrid and multicloud migration

The following list of articles will take you to guidance found at specific points throughout the cloud adoption journey, aiming to help you become successful in cloud adoption scenarios.

- [Hybrid and multicloud migration](./migrate.md)
- [Govern hybrid and multicloud environments](./govern.md)
- [Manage hybrid and multicloud environments](./manage.md)
