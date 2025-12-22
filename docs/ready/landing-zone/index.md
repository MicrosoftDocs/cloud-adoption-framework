---
title: What is an Azure landing zone?
description: Learn how a landing zone provides the basic building block of any cloud adoption environment.
author: jtracey93
ms.author: jatracey
ms.date: 12/11/2025
ms.topic: concept-article
ms.custom: internal
---

# What is an Azure landing zone?

An Azure landing zone is the standardized and recommended approach for all organizations utilizing Azure. It provides a consistent way to set up and manage your Azure environment at scale. It ensures consistency across your organization by aligning with key requirements for security, compliance, and operational efficiency through [platform and application landing zones](#platform-landing-zone-vs-application-landing-zones). They provide a well-architected foundation aligned with core [design principles](design-principles.md) across eight [design areas](design-areas.md).

## Azure landing zone architecture

An Azure landing zone architecture is scalable and modular to meet various deployment needs. The repeatable infrastructure allows you to apply configurations and controls to every subscription consistently. Modules make it easy to deploy and modify specific Azure landing zone architecture components as your requirements evolve.

The Azure landing zone reference architecture (*see figure 1*) represents an opinionated target architecture for your Azure landing zone. You should use this reference architecture as a starting point and [tailor the architecture to meet your needs](./tailoring-alz.md).

:::image type="content" source="../enterprise-scale/media/azure-landing-zone-architecture-diagram-hub-spoke.svg" alt-text="A reference architecture diagram of an Azure landing zone." lightbox="../enterprise-scale/media/azure-landing-zone-architecture-diagram-hub-spoke.svg":::
*Figure 1: Azure landing zone reference architecture. Download a [Visio file](https://github.com/MicrosoftDocs/cloud-adoption-framework/raw/main/docs/ready/enterprise-scale/media/enterprise-scale-architecture.vsdx) or [PDF file](https://github.com/MicrosoftDocs/cloud-adoption-framework/raw/main/docs/ready/enterprise-scale/media/enterprise-scale-architecture.pdf) of this architecture.*

**Design areas:** The reference architecture illustrates the relationships between its eight design areas. These design areas are Azure billing and Microsoft Entra tenant, identity and access management, management group and subscription organization, network topology and connectivity, security, management, governance, and platform automation and DevOps. For more information on the design areas, see [the Azure Landing Zone environment design areas](./design-areas.md#environment-design-areas).

**Resource organization:** The reference architecture shows a sample management group hierarchy. It organizes subscriptions (yellow boxes) by management group. The subscriptions under the "Platform" management group host shared services that comprise the platform landing zone. The subscriptions under the "Landing zone" management group represent the application landing zones. The reference architecture shows five subscriptions in detail. You can see the resources in each subscription and the policies applied.

<a name='platform-landing-zones-vs-application-landing-zones'></a>

## Platform landing zone vs. application landing zones

An Azure landing zone consists of one platform landing zone and one or more application landing zones. It's worth explaining the function of both in more detail.

**Platform landing zone:** A platform landing zone provides shared services (identity, connectivity, management) to applications in application landing zones. Consolidating these shared services often improves operational efficiency. One or more central teams manage the services in the platform landing zone. In the reference architecture (*see figure 1*), the "Identity subscription," "Management subscription," and "Connectivity subscription" are components of the platform landing zone. The reference architecture depicts representative resources and policies applied to the subscriptions that host the platform landing zone shared services.

**Application landing zone:** An application landing zone contains the resources for hosting a single workload/application. A workload should have an application landing zone for each environment (development, testing, or production). Each application landing zone consists of one or more subscriptions, as needed to accommodate scaling and service limits. You pre-provision application landing zone subscriptions through code, via a [Subscription vending process](/azure/cloud-adoption-framework/ready/landing-zone/design-area/subscription-vending), while a workload team is responsible for deploying workload components into their application landing zone. 

Application landing zones are nested under appropriate management groups, such as `Online` or `Corp`, to inherit Azure Policy definitions from the parent management group(s). This structure ensures that workload subscriptions are deployed in a controlled and consistent manner, while still allowing flexibility for individual workload needs. 

In the Azure landing zone architecture (*see figure 1*), the "Landing zone A2 subscription", for example, is an application landing zone. The architecture depicts representative resources and policies applied to the "Landing zone A2 subscription". The "Landing zone P1 subscription" is used by platform teams to build and deploy services that support multiple application landing zones and teams, such as VM image repositories and container registries. These services are not application-specific, and the subscription remains subject to governance policies applied at the application landing zone level.

:::image type="content" source="./media/alz-application-platform.svg" alt-text="A reference architecture diagram of an Azure landing zone with Application Landing Zones & Platform Landing Zone overlaid." lightbox="./media/alz-application-platform.svg":::
*Figure 2: Azure landing zone reference architecture with Application Landing Zones & Platform Landing Zone overlaid. Download a [Visio file](https://github.com/MicrosoftDocs/cloud-adoption-framework/raw/main/docs/ready/enterprise-scale/media/enterprise-scale-architecture.vsdx) or [PDF file](https://github.com/MicrosoftDocs/cloud-adoption-framework/raw/main/docs/ready/enterprise-scale/media/enterprise-scale-architecture.pdf) of this architecture.*

There are three main approaches to managing application landing zones. You should use one of the following management approaches depending on your needs:

- Central team approach
- Application team approach
- Shared team approach

| Application landing zone management approach | Description |
| --- | --- |
| Central team management | A central IT team fully operates the landing zone. The team applies controls and platform tools to the platform and application landing zones.
| Application team management | A platform administration team delegates the entire application landing zone to an application team. The application team manages and supports the environment. The management group policies ensure that the platform team still governs the application landing zone. You can add other policies at the subscription scope and use alternative tooling for deploying, securing, or monitoring application landing zones.|
| Shared management | With technology platforms such as AKS or AVS, a central IT team manages the underlying service. The application teams are responsible for the applications running on top of the technology platforms. You need to use different controls or access permissions for this model. These controls and permissions differ from the ones you use to manage application landing zones centrally.

> [!TIP]
> You can see more guidance on different types of application landing zones in [Establish common subscription vending product lines](/azure/cloud-adoption-framework/ready/landing-zone/design-area/subscription-vending-product-lines)

## Application landing zone accelerators

Application landing zone accelerators help you deploy common workloads in your application landing zone subscriptions. Use the list of available application landing zone accelerators in the [Azure Architecture Center](/azure/architecture/landing-zones/landing-zone-deploy#application) and deploy the accelerator that matches your scenario.

### AI in Azure landing zones

A common question is whether you need a dedicated AI landing zone alongside your Azure landing zone. The answer is that you don't need a separate AI landing zone. Instead, you use the existing Azure landing zone architecture to deploy AI workloads into application landing zones. The Azure landing zone design areas and principles are sufficient to support AI workloads, as they provide the necessary foundation for governance, security, and management for applications and workloads that both include AI and non-AI components and services.

You can integrate AI services into your application landing zones without needing a separate AI landing zone. The Azure landing zone architecture, design principles, and design areas, such as identity and access management, network topology and connectivity, security, and governance, are already designed to accommodate all workloads, including those that involve AI.

From the perspective of Azure landing zones, AI is just another workload or service that can be deployed, governed, and secured within one or more application landing zone subscriptions, just like any other application, workload, or service, by the platform team by utilizing the existing Azure landing zone architecture, principles, and design areas.

For more information on AI adoption in Azure, see the [AI adoption scenario](/azure/cloud-adoption-framework/scenarios/ai/). For specific focus on AI workloads and landing zones, see [Establish an AI foundation](/azure/cloud-adoption-framework/scenarios/ai/ready#establish-an-ai-foundation).

## Deploying and managing Azure landing zone

There are multiple ways to deploy and manage your Platform landing zone, which is part of the Azure landing zone (see above), as detailed further in [Landing zone implementation options](./implementation-options.md). You can choose the method that best fits your organization's needs and expertise. There are multiple options available:

- [Azure landing zone Infrastructure-as-Code (IaC) Accelerator](https://aka.ms/alz/accelerator) ***(recommended approach)***
  - [Azure Verified Modules (AVM) for Platform landing zone (ALZ) - Terraform](https://aka.ms/alz/acc/tf) *(Can also be used outside of the accelerator, if desired)*
  - [Azure Verified Modules (AVM) for Platform landing zone (ALZ) - Bicep](https://aka.ms/alz/acc/bicep) *(Can also be used outside of the accelerator, if desired)*
- [Azure platform landing zone portal accelerator](https://aka.ms/alz/portal)

We highly recommend using Infrastructure-as-Code (IaC) options, such as Bicep or Terraform, via the Azure landing zone Infrastructure-as-Code (IaC) Accelerator for deploying and managing Azure landing zones. These options provide greater flexibility, repeatability, and scalability compared to the portal accelerator. 

But if your organization does not have the necessary expertise in IaC or prefers a more visual approach, the portal accelerator can be a suitable alternative. See [Use infrastructure as code to update Azure landing zones](/azure/cloud-adoption-framework/ready/considerations/infrastructure-as-code-updates) for more information to help you understand why IaC is the preferred approach.

## Next steps

Review the design principles behind Azure landing zones to understand how they guide a secure and scalable environment. If you're ready to deploy, explore the available implementation options for creating and managing landing zones. For quick answers to common questions, such as whether you need an AI landing zone or how enterprise-scale differs, check out the FAQs.

> [!div class="nextstepaction"]
> [Design principles](./design-principles.md)

> [!div class="nextstepaction"]
> [Implementation options](./implementation-options.md)

> [!div class="nextstepaction"]
> [Frequently Asked Questions (FAQ)](/azure/cloud-adoption-framework/ready/enterprise-scale/faq)