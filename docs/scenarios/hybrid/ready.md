---
title: Ready methodology for hybrid and multicloud strategy
description: Prepare your environment for a hybrid and multicloud scenario with Azure landing zones.
author: mpvenables
ms.author: brblanch
ms.date: 04/13/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: e2e-hybrid
---

# Ready: Prepare your environment for a hybrid and multicloud scenario

The [Ready methodology](../../ready/index.md) of the Cloud Adoption Framework for Azure guides customers through environment readiness to prepare for cloud adoption. The readiness section includes technical accelerators (Azure landing zones), which are the basic building block in any cloud adoption environment. Review your choice of what landing zone to deploy. If you need help choosing the right one to deploy, this guide can help you get started. If you are considering what landing zone would best fit your organization's operating model, [this article](../../ready/landing-zone/choose-landing-zone-option.md) can help you get started with this alignment.

## Hybrid and multicloud landing zones

Landing zones automate the configuration of your Azure environment, and align with best practices guidance in the Cloud Adoption Framework. When you prepare for a hybrid and multicloud deployment, environment configurations might be slightly different.

These are the key changes necessary to prepare a consistent environment for any hybrid and multicloud deployment
(hybrid and multicloud landing zone):

- Hybrid and multicloud network connectivity
- Common ID management
- Integrated management and security
- Unified operational process controls for operations, governance, and compliance
- Unified and consistent development and DevOps across heterogeneous environments

This article guides you through the considerations required for these environment configurations.

## Evaluate your cloud mix

Choosing a hybrid and multicloud environment isn't a binary decision. It's closer to a range of decisions, as seen in the chart below. Confirm what Azure landing zone option you have chosen.

Before you configure your Azure environment or any other cloud environment, it's important to identify how your cloud environment will support your specific mix of cloud hosting decisions. Here are some examples of common cloud mixes.

![Three illustrations showing how different customers distribute workloads across cloud providers.](../../_images/hybrid/cloud-mix.png)

Each dark blue dot represents a workload—and each light blue circle a business process, supported by a distinct environment. Each cloud mix requires a different Azure environment configuration, as seen with our three reference customers:

- **Hybrid-first** customer: Most workloads stay on-premises, often in a mixture of traditional, hybrid, and portable asset-hosting models. A few specific workloads are deployed to the edge, Azure, or to other cloud providers.  

**Harry’s Harvesters** is a _Hybrid first_ customer, with a heavy investment in aging datacenters. Cost and governance are his high priorities. Legacy IT priorities and aging technology infrastructure hindered innovation, which drove some early cloud adoption.

- **Azure-first** customer: Most workloads have been moved to Azure. A few workloads stay on-premises. Strategic decisions have led to a few workloads living on the edge or in multicloud environments.

**Angie’s Applications** is "Azure first". Like Harry's, Angie’s Apps completed their first wave of digital transformation, acquired a few companies, and added customers in regulated industries. Innovation is still their priority. But with their multicloud environment, they're focused on operations management, and efficient, scalable operations required to continue their acquisition strategy.

- **Multicloud-first** customer: Most workloads are currently hosted on a different public cloud, like GCP or AWS. Strategic decisions have led to a few workloads living in Azure or on the edge. Each month, we see a steady flow of customers moving from a _hybrid first_ mix to an _Azure first_ mix as their cloud strategy matures. But, we also support customers who have made strategic decisions to prioritize hybrid or multicloud mixes. Azure plays a role in each mix.

**Mary’s Markets** is a "Multicloud first" customer. Like Angie’s Apps, they moved to the cloud, but didn’t choose Azure. They also have some local datacenter assets and edge devices. Mary's is an early adopter of other clouds in early startup phase, and growth is her big priority. Driving her growth in hybrid and multicloud are the retail requirements of her customers, and the need to improve operations in order to scale efficiently.

Here are the most important items to consider when you prepare any of your cloud environments for hybrid and multicloud. Your hybrid and multicloud strategy for applications and data will drive the answers to the questions below. Clearly identify what intended cloud mix is required, then consider the best configuration for your environment(s):

- Do you have an [existing Azure environment to transition into enterprise-scale](../../ready/enterprise-scale/transition.md)?
- What mixture of hybrid, edge, and multicloud environments do you support today?
- What mixture best aligns with your strategy for the future?
- Do you want to operate each platform independently or through a unified operations approach?

## Evaluate your cloud mix

If you're unsure about your current cloud mix, the tools in Azure's control plane can help. Azure Arc, a built-in benefit of Azure Resource Manager, provides visibility into your cloud mix. Azure Arc extends across environments, and increases the discoverability of your assets, and, with greater visibility across your resources, is the first step towards taking control of your cloud mix. You can use Azure Arc (as a complimentary tool) for discovery across all your cloud platforms.

![Illustration showing an overview of the visibility created across processes and controls of unified operations.](../../_images/hybrid/unified-operations-processes-controls.png)

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

## Modify your environment to reflect your cloud mix

All three customers will have to deliver on slightly different _strategic_ requirements to succeed in their digital transformation.

- **Harry’s Harvesters** will need to focus on a **migration and governance** strategy to achieve cost controls, while ensure continued compliance.
- **Angie’s applications** will continue to invest in **innovation** but also needs to focus on a strategy to **optimize operations**, as they innovate.
- **Mary’s Markets** will need to focus on **migration** and **scaling operations** to continue to grow their market share.

These customer all have different strategic, operational, governance, and environmental requirements. There is no one-size-fits-all solution to prepare them for their unique journeys to hybrid and multicloud. But they do all have one common need before they make impactful decisions—visibility.

Starting on different paths, these customers' first step in their cloud journey is the same—to onboard hybrid and multicloud assets into Azure Arc at no costs—and **gain visibility across workloads and cloud providers**. While their strategic focus will differ, _the starting point remains the Cloud Adoption Framework_, accomplishing their strategic objective by following guidance in different methodologies.

![Illustration showing three customer stories and their intended cloud mix during their hybrid and multicloud journey.](../../_images/hybrid/customer-stories-hybrid-multicloud.png)

- **Harry's Harvesters** will require visibility into inventory and costs. Following guidance in the Strategy and Govern methodologies, he'll focus on governance and cloud migration, to reduce cost and shift to OpEx cost models.
- **Angie's Applications** will need connectivity between clouds and new operational innovations. She'll follow guidance in the Innovate and Manage methodologies, with a focus on cloud-native innovation and Azure landing zones for cross-cloud connectivity.
- **Mary's Markets** will need to scale workloads, and support demands form retail customers. She'll follow guidance in the Migrate and Manage methodologies, focusing first on the operations baseline to prepare for scale, then a limited migration to Azure.

![Illustration showing three customer stories and their intended cloud mix during their hybrid and multicloud journey.](../../_images/hybrid/customer-stories-hybrid-multicloud_2.png)

Each customer now needs to address network, identity, governance, and operations management to ensure proper environmental configuration. With their slightly different requirements for operations and environmental configuration, they'll use different implementation options with Azure Landing Zones:

- **Harry's Harvesters**' operational requirement is to modernize existing operations into new environments, and quickly build a compliant environment for his full datacenter in Azure. His ambitious plan is to migrate out of his organization's local datacenters, requiring compliance from day 1. The fastest path to his objectives is Enterprise-scale landing zones.
- **Angie's Applications**' operational requirement is to ensure consistent environmental configuration and control, adding hybrid and multicloud configuration to existing environments. She started with a smaller landing zone footprint and grew over time—and are at the _Expand_ phase of the _Start Small and Expand_ approach to Azure Landing Zones. She'll use the Operations Baseline in the Manage methodology, and the decisions trees in the Ready methodology to move forward.
- **Mary's Markets**' operational goal is to configure Azure and a hybrid environment to work with existing cloud configurations, using third-party options to extend her multicloud expertise to Azure and a hybrid environment configuration. Her organization has invested heavily in Terraform to build their multicloud environments. She'll start with the Cloud Adoption Framework Terraform modules to Start Small & Expand into the hybrid environment to integrate with their existing cloud solutions.

## Modify your environment to reflect your cloud mix

After establishing your Azure environment, consider these modifications to support the most appropriate cloud mix:

- **Identity**: Which cloud will host your primary identity provider? If that provider is outside of Azure, you might need to integrate your identity provider with Azure Active Directory. For more information on identity providers, see [this article](/azure/active-directory/external-identities/identity-providers).
- **Public network connectivity**: Best practices suggest that all ingress and egress traffic should route through one cloud platform when possible. But your requirements or cloud mix might require more of a peer model. This arrangement is especially common if your cloud mix is used to satisfy redundancy and reliability requirements. How will you configure connectivity between each cloud platform and the public internet?
- **Backup and recovery**: It's common for customers to centralize their backup and recovery strategy around the most reliable provider in their cloud mix. Often the result is that one of the cloud providers serves as a shared recovery center. Azure Backup and Azure Site Recovery can help in each case.
- **Cloud platform connectivity**: If your cloud platforms will share common recovery, operations, or governance resources, you might require connectivity between each cloud platform. How will you configure connectivity between each cloud platform?

## Configure your initial Azure environment

For each of the preceding cloud mixes, you'll need an Azure environment to support, govern, and manage your cloud resources. The Ready methodology of the Cloud Adoption Framework helps prepare your environment by using a few steps:

- Consider each of the [Azure landing zone design areas](../../ready/landing-zone/design-areas.md) to properly evaluate your technical requirements.
- Compare your requirements to the [Azure landing zone implementation options](../../ready/landing-zone/implementation-options.md) to find and implement the most suitable template to start your configuration.

### The most important consideration

**Will you operate each cloud independently or through a unified central operations approach?**

Independent operations can double or triple your total cost of ownership (TCO). For some customers, TCO cost increases can be multiplied by over 10 times. To minimize costs and demands on your staff, a unified operations approach is best for all cloud mixes for your hybrid and multicloud strategy.

To learn more about unification of your cloud operations, see the articles on [unified operations](./unified-operations.md), [governance](./govern.md), and [operations management](./manage.md) for hybrid and multicloud solutions.

## Next steps

For more guidance for your cloud adoption journey, see the following articles:

- [Hybrid and multicloud migration](./migrate.md)
- [Govern hybrid and multicloud environments](./govern.md)
- [Manage hybrid and multicloud environments](./manage.md)
- 
