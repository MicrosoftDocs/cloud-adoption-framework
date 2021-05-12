---
title: Ready methodology for hybrid and multicloud strategy
description: Prepare your environment for a hybrid and multicloud scenario with Azure landing zones.
author: brianblanchard
ms.author: brblanch
ms.date: 02/01/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: e2e-hybrid
---

# Ready: Prepare your environment for a hybrid and multicloud scenario

The [Ready methodology](../../ready/index.md) of the Cloud Adoption Framework for Azure guides customers through environment readiness to prepare for cloud adoption. The readiness section includes technical accelerators (Azure landing zones), which are the basic building block in any cloud adoption environment. Landing zones automate the configuration of your Azure environment and align with best practices guidance in the Cloud Adoption Framework. When you prepare for a hybrid and multicloud deployment, environment configurations might be slightly different.

This article outlines key considerations and changes that are necessary to prepare your environments to:

- Expand connectivity boundaries to connect across hybrid and multicloud platforms.
- Improve support for cloud native services like containers, Kubernetes, and hyper-converged infrastructure solutions to reduce hybrid and multicloud adoption friction.
- Establish proper cloud native tools to support the use of Azure as *one* of your cloud platforms.
- Implement unified operations tooling across all cloud environments to allow for unified operations.

This article guides you through the considerations required to achieve each of those environmental goals.

## Evaluate your cloud mix

Choosing a hybrid and multicloud environment isn't a binary decision. It's closer to a range of decisions, as seen in the following chart. Before you configure your Azure environment or any other cloud environment, it's important to identify how your cloud environment will support your specific mix of cloud hosting decisions. A few examples of common cloud mixes are shown here.

![Three illustrations showing how different customers distribute workloads across cloud providers.](../../_images/hybrid/cloud-mix.png)

The preceding image illustrates three of the most common cloud mixes we see with customers. Each blue dot represents a workload. Each orange circle represents a business process, supported by a distinct environment. Each of this cloud mixes requires a different Azure environment configuration.

- **Hybrid first**: Most workloads stay on-premises, often in a mixture of traditional, hybrid, and portable asset-hosting models. A few specific workloads are deployed to the edge, Azure, or to other cloud providers.
- **Azure first**: Most workloads have been moved to Azure. A few workloads stay on-premises. Strategic decisions have led to a few workloads living on the edge or in multicloud environments.
- **Multicloud first**: Most workloads are currently hosted on a different public cloud, like GCP or AWS. Strategic decisions have led to a few workloads living in Azure or on the edge. Each month, we see a steady flow of customers moving from a *hybrid first* mix to an *Azure first* mix as their cloud strategy matures. But, we also support customers who have made strategic decisions to prioritize hybrid or multicloud mixes. Azure plays a role in each mix.

Here are the most important items to consider when you prepare any of your cloud environments for hybrid and multicloud:

- What mixture of hybrid, edge, and multicloud environments do you support today?
- What mixture best aligns with your strategy for the future?
- Do you want to operate each platform independently or through a unified operations approach?

The answers to these questions will depend on your hybrid and multicloud strategy for your applications and data. With a clear understanding of your intended cloud mix, you can begin to consider the best configuration for your environments.

## Analyze your cloud mix

If you're unsure about your current cloud mix, the tools in Azure's control plane can help. Azure Arc, a built-in benefit of Azure Resource Manager, provides visibility into your cloud mix. This toolset is often the first step toward taking control of your cloud mix. You can use Azure Arc (as a complimentary tool) for discovery across all your cloud platforms.

To start evaluating your cloud mix across multiple cloud providers, complete an inventory and tagging exercise in a few steps:

- Add a tag for `hosting platform` to all hybrid, multicloud, and edge assets.
- Bring on and tag resources from AWS, GCP, or other cloud providers.
- Query your resources to see where they're hosted.

To get started, [inventory and tag your hybrid and multicloud resources](../../manage/hybrid/server/best-practices/arc-inventory-tagging.md).

The following links will help you bring on and tag assets across each of your cloud providers:

- **Azure assets**: [Linux VMs](../../manage/hybrid/server/best-practices/arm-template-linux.md) and [Windows VMs](../../manage/hybrid/server/best-practices/arm-template-windows.md)
- **Assets in your local datacenter**: [Linux VMs](../../manage/hybrid/server/best-practices/onboard-server-linux.md) and [Windows VMs](../../manage/hybrid/server/best-practices/onboard-server-windows.md)
- **VMware assets**: [Linux VMs](../../manage/hybrid/server/best-practices/vmware-scaled-powercli-linux.md) and [Windows VMs](../../manage/hybrid/server/best-practices/vmware-scaled-powercli-windows.md)
- **AWS assets**: [Linux VMs with Terraform](../../manage/hybrid/server/best-practices/aws-terraform-al2.md) and [AWS Ubuntu with Terraform](../../manage/hybrid/server/best-practices/aws-terraform-ubuntu.md)
- **GCP assets**: [Ubuntu VMs](../../manage/hybrid/server/best-practices/gcp-terraform-ubuntu.md) and [Windows VMs](../../manage/hybrid/server/best-practices/gcp-terraform-windows.md)

## Configure your initial Azure environment

For each of the preceding cloud mixes, you'll need an Azure environment to support, govern, and manage your cloud resources. The Ready methodology of the Cloud Adoption Framework helps prepare your environment by using a few steps:

- Consider each of the [Azure landing zone design areas](../../ready/landing-zone/design-areas.md) to properly evaluate your technical requirements.
- Compare your requirements to the [Azure landing zone implementation options](../../ready/landing-zone/implementation-options.md) to find and implement the most suitable template to start your configuration.

## Modify your environment to reflect your cloud mix

After your Azure environment is established, you can begin to modify it to support the most appropriate cloud mix. Consider the following modifications:

- **Identity**: Which cloud will host your primary identity provider? If that provider is outside of Azure, you might need to integrate your identity provider with Azure Active Directory. For more information on identity providers, see [this article](/azure/active-directory/external-identities/identity-providers).
- **Public network connectivity**: Best practices suggest that all ingress and egress traffic should route through one cloud platform when possible. But your requirements or cloud mix might require more of a peer model. This arrangement is especially common if your cloud mix is used to satisfy redundancy and reliability requirements. How will you configure connectivity between each cloud platform and the public internet?
- **Backup and recovery**: It's common for customers to centralize their backup and recovery strategy around the most reliable provider in their cloud mix. Often the result is that one of the cloud providers serves as a shared recovery center. Azure Backup and Azure Site Recovery can help in each case.
- **Cloud platform connectivity**: If your cloud platforms will share common recovery, operations, or governance resources, you might require connectivity between each cloud platform. How will you configure connectivity between each cloud platform?

### The most important consideration

**Will you operate each cloud independently or through a unified central operations approach?**

Independent operations can double or triple your total cost of ownership (TCO). For some customers, TCO cost increases can be multiplied by over 10 times. To minimize costs and demands on your staff, a unified operations approach is best for all cloud mixes for your hybrid and multicloud strategy.

To learn more about unification of your cloud operations, see the articles on [unified operations](./unified-operations.md), [governance](./govern.md), and [operations management](./manage.md) for hybrid and multicloud solutions.

## Next steps

For more guidance for your cloud adoption journey, see the following articles:

- [Hybrid and multicloud migration](./migrate.md)
- [Govern hybrid and multicloud environments](./govern.md)
- [Manage hybrid and multicloud environments](./manage.md)
