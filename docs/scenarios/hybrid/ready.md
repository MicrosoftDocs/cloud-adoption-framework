---
title: Ready methodology for a hybrid and multicloud scenario
description: Learn how to prepare your environment for a hybrid and multicloud scenario with Azure landing zones.
author: mpvenables
ms.author: brblanch
ms.date: 01/12/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-hybrid, think-tank
---

<!-- docutune:casing "Harry's Harvesters" "Angie's Applications" "Mary's Markets" -->

# Prepare your environment for a hybrid and multicloud scenario

The [Ready methodology](../../ready/index.md) of the Cloud Adoption Framework for Azure guides customers through environment readiness for cloud adoption. The readiness section includes technical accelerators like Azure landing zones, which are the basic building blocks in any cloud adoption environment. Review your choice of what landing zone to deploy. If you need help with choosing the right one to deploy, this guide can help you get started. If you're considering what landing zone would best fit your organization's operating model, see [Choose the landing zone for your organization](../../ready/landing-zone/choose-landing-zone-option.md) to help you get started.

## Hybrid and multicloud landing zones

Landing zones automate the configuration of your Azure environment, and align with best practices guidance in the Cloud Adoption Framework. When you prepare for a hybrid and multicloud deployment, environment configurations might be different.

These key changes are necessary to prepare a consistent environment for any hybrid and multicloud deployment:

- Hybrid and multicloud network connectivity
- Common identity management
- Integrated management and security
- Unified operational process controls for operations, governance, and compliance
- Unified and consistent development and DevOps across heterogeneous environments

This article guides you through the considerations required for these configurations.

## Configure your initial Azure environment

For each cloud mix above, you'll need an Azure environment to support, govern, and manage your cloud resources. The Ready methodology of the Cloud Adoption Framework helps prepare your environment by using a few steps:

- Consider each of the [Azure landing zone design areas](../../ready/landing-zone/design-areas.md) to evaluate your technical requirements.
- Compare your requirements to the [Azure landing zone implementation options](../../ready/landing-zone/implementation-options.md) to find and implement the best template to start your configuration.
- Do you have an [existing Azure environment to transition into enterprise-scale](../../ready/enterprise-scale/transition.md)?

## Evaluate your cloud mix

Choosing a hybrid and multicloud environment isn't a binary decision. It's closer to a range of decisions, as seen in the following chart. Confirm what Azure landing zone option you have chosen.

It's important to identify how your cloud environment will support your specific mix of cloud-hosting decisions. Do this identification *before* you configure your Azure environment, or any other cloud environment. Here are some examples of common cloud mixes.

![Three illustrations that show how different customers distribute workloads across cloud providers.](../../_images/hybrid/cloud-mix.png)

Each dark blue dot is a workload, and each light blue circle is a business process, supported by a distinct environment. Each cloud mix requires a different Azure environment configuration, as seen with our three reference customers:

- **Hybrid-first customer:** Most workloads stay on-premises, often in a mixture of traditional, hybrid, and portable asset-hosting models. A few specific workloads are deployed to the edge, Azure, or to other cloud providers.

  **Harry's Harvesters** is a *hybrid-first* customer, with a heavy investment in aging datacenters. Cost and governance are its highest priorities. Legacy IT priorities and aging technology infrastructure hindered innovation, which drove some early cloud adoption.

- **Azure-first customer:** Most workloads have been moved to Azure. A few workloads stay on-premises. Strategic decisions have led to a few workloads living on the edge or in multicloud environments.

  **Angie's Applications** is an *Azure-first* customer. Like Harry's Harvesters, it completed its first wave of digital transformation, acquired a few companies, and added customers in regulated industries. Innovation is still its priority. But with its multicloud environment, it's focused on operations management, and efficient, scalable operations required to continue its acquisition strategy.

- **Multicloud-first customer:** Most workloads are currently hosted on a different public cloud, like GCP or AWS. Strategic decisions have led to a few workloads living in Azure or on the edge. Each month, we see customers move from a hybrid-first mix to an Azure-first mix as their cloud strategy matures. But, we also support customers who decide to make hybrid or multicloud mixes their priority. Azure plays a role in each mix.

  **Mary's Markets** is a *multicloud-first* customer. Like Angie's Applications, it moved to the cloud, but didn't choose Azure. It also has some local datacenter assets and edge devices. Mary's Markets is an early adopter of other clouds in an early startup phase, and growth is its significant priority. Driving growth in hybrid and multicloud are the retail requirements of its customers, and the need to improve operations to scale efficiently.

The following considerations are most important when preparing any of your cloud environments for hybrid and multicloud. Your hybrid and multicloud strategy for applications and data will drive the answers to the following questions. Clearly identify what intended cloud mix is required, then consider the best configuration for your environments:

- What mixture of hybrid, edge, and multicloud environments do you support today?
- What mixture best aligns with your strategy for the future?
- Do you want to operate each platform independently or through a unified operations approach?

## Modify your environment to reflect your cloud mix

All three customers have to deliver on slightly different *strategic* requirements to succeed in their digital transformation.

- **Harry's Harvesters** needs to focus on a **migration and governance** strategy to achieve cost controls, while ensuring continued compliance.
- **Angie's Applications** continues to invest in **innovation**, but also needs to focus on a strategy to **optimize operations** as they innovate.
- **Mary's Markets** needs to focus on **migration** and **scaling operations** to continue growing their market share.

These customers all have different strategic, operational, governance, and environmental requirements. There's no one-size-fits-all solution to prepare them for their unique journeys to hybrid and multicloud. But they do all have one common need before they make impactful decisions: visibility.

Starting on different paths, each customer's first step in its cloud journey is the same: onboard hybrid and multicloud assets into Azure Arc at no cost, and **gain visibility across workloads and cloud providers**. While their strategic focus differs, **the starting point remains the Cloud Adoption Framework**. Each customer accomplishes their strategic goal by following guidance in different methodologies.

![Illustration that shows three customer stories and their intended cloud mix during their hybrid and multicloud journey.](../../_images/hybrid/customer-stories-hybrid-multicloud.png)

- **Harry's Harvesters** needs visibility into inventory and costs. Following guidance in the Strategy and Govern methodologies, it focuses on governance and cloud migration to reduce cost and shift to operating expense (OPEX) cost models.
- **Angie's Applications** needs connectivity between clouds and new operational innovations. It follows the guidance in the Innovate and Manage methodologies. With these methodologies, it focuses on cloud-native innovation and Azure landing zones for cross-cloud connectivity.
- **Mary's Markets** needs to scale workloads, and support demand from retail customers. It follows guidance in the Migrate and Manage methodologies, focusing first on the operations baseline to prepare for scale, then a limited migration to Azure.

![Illustration that shows three customer stories and each customer's intended cloud mix during their hybrid and multicloud journey.](../../_images/hybrid/customer-stories-hybrid-multicloud-2.png)

Each customer now needs to address network, identity, governance, and operations management to ensure proper environmental configuration. With their slightly different requirements for operations and environmental configuration, they'll use different implementation options with Azure landing zones:

- **Harry's Harvesters**' operational requirement is to modernize existing operations into new environments. Then it quickly builds a compliant environment for its entire datacenter in Azure. Its ambitious plan is to migrate out of its organization's local datacenters, requiring compliance from day one. The fastest path to its goals is via enterprise-scale landing zones.
- **Angie's Applications**' operational requirement is to ensure consistent environmental configuration and control, adding hybrid and multicloud configuration to existing environments. It started with a smaller landing zone footprint and grew over time. Now, it's in the *expand* phase of the *start small and expand* approach to Azure landing zones. The company uses the operations baseline in the Manage methodology and the decision trees in the Ready methodology to move forward.
- **Mary's Markets** has an operational goal to configure Azure and a hybrid environment to work with existing cloud configurations. It uses third-party options to extend its multicloud expertise to Azure and a hybrid environment configuration. The organization has invested heavily in Terraform to build their multicloud environments. It starts with the Cloud Adoption Framework Terraform modules to start small and expand into the hybrid environment, integrating with their existing cloud solutions.

## Support the most appropriate cloud mix

After establishing your Azure environment, consider modifications to:

- **Identity:** Which cloud will host your primary identity provider? If that provider is outside of Azure, you might need to integrate your identity provider with Azure Active Directory. For more information, see [Identity providers for external identities](/azure/active-directory/external-identities/identity-providers).
- **Public network connectivity:** Best practices suggest that all ingress and egress traffic should route through one cloud platform when possible. But your requirements or cloud mix might require more of a peer model. This arrangement is especially common if your cloud mix is used to satisfy redundancy and reliability requirements. How will you configure connectivity between each cloud platform and the public internet?
- **Backup and recovery:** It's common for customers to centralize their backup and recovery strategy around the most reliable provider in their cloud mix. Often the result is that one of the cloud providers serves as a shared recovery center. Azure Backup and Azure Site Recovery can help in each case.
- **Cloud platform connectivity:** If your cloud platforms will share common recovery, operations, or governance resources, you might require connectivity between each cloud platform. How will you configure that connectivity?

### The most important consideration

**Will you operate each cloud independently or through a unified central operations approach?**

Independent operations can double or triple your total cost of ownership (TCO). For some customers, TCO cost increases can be multiplied by over 10 times. To minimize costs and demands on your staff, a unified operations approach is best for all cloud mixes for your hybrid and multicloud strategy.

![Illustration that shows an overview of the visibility created across processes and controls of unified operations.](../../_images/hybrid/unified-operations-processes-controls.png)

For more information, see [unified operations](./unified-operations.md), [governance](./govern.md), and [operations management](./manage.md) for hybrid and multicloud solutions.

## Next steps

For more information on your cloud adoption journey, see:

- [Hybrid and multicloud migration](./migrate.md)
- [Govern hybrid and multicloud environments](./govern.md)
- [Manage hybrid and multicloud environments](./manage.md)
- [Enterprise-scale support for hybrid and multicloud](../hybrid/enterprise-scale-landing-zone.md)
