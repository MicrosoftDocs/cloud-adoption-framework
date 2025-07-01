---
title: What is an Azure landing zone?
description: Learn how a landing zone provides the basic building block of any cloud adoption environment.
author: jtracey93
ms.author: jatracey
ms.date: 07/01/2025
ms.topic: conceptual
ms.custom: internal
---

# What is an Azure landing zone?

An Azure landing zone is an environment that follows key design principles across eight design areas. These design principles accommodate all application portfolios and enable application migration, modernization, and innovation at scale. An Azure landing zone uses subscriptions to isolate and scale application resources and platform resources. Subscriptions for application resources are called application landing zones, and subscriptions for platform resources are called platform landing zones.

## Azure landing zone architecture

An Azure landing zone architecture is scalable and modular to meet various deployment needs. The repeatable infrastructure allows you to apply configurations and controls to every subscription consistently. Modules make it easy to deploy and modify specific Azure landing zone architecture components as your requirements evolve.

The Azure landing zone conceptual architecture (*see figure 1*) represents an opinionated target architecture for your Azure landing zone. You should use this conceptual architecture as a starting point and [tailor the architecture to meet your needs](./tailoring-alz.md).

:::image type="content" source="../enterprise-scale/media/azure-landing-zone-architecture-diagram-hub-spoke.svg" alt-text="A conceptual architecture diagram of an Azure landing zone." lightbox="../enterprise-scale/media/azure-landing-zone-architecture-diagram-hub-spoke.svg":::
*Figure 1: Azure landing zone conceptual architecture. Download a [Visio file](https://github.com/microsoft/CloudAdoptionFramework/raw/main/ready/enterprise-scale-architecture.vsdx) of this architecture.*

**Design areas:** The conceptual architecture illustrates the relationships between its eight design areas. These design areas are Azure billing and Microsoft Entra tenant, identity and access management, management group and subscription organization, network topology and connectivity, security, management, governance, and platform automation and DevOps. For more information on the design areas, see [the Azure Landing Zone environment design areas](./design-areas.md#environment-design-areas).

**Resource organization:** The conceptual architecture shows a sample management group hierarchy. It organizes subscriptions (yellow boxes) by management group. The subscriptions under the "Platform" management group represent the platform landing zones. The subscriptions under the "Landing zone" management group represent the application landing zones. The conceptual architecture shows five subscriptions in detail. You can see the resources in each subscription and the policies applied.

## Platform landing zones vs. application landing zones

An Azure landing zone consists of platform landing zones and application landing zones. It's worth explaining the function of both in more detail.

**Platform landing zone:** A platform landing zone is a subscription that provides shared services (identity, connectivity, management) to applications in application landing zones. Consolidating these shared services often improves operational efficiency. One or more central teams manage the platform landing zones. In the conceptual architecture (*see figure 1*), the "Identity subscription," "Management subscription," and "Connectivity subscription" represent three different platform landing zones. The conceptual architecture shows these three platform landing zones in detail. It depicts representative resources and policies applied to each platform landing zone.

**Application landing zone:** An application landing zone is a subscription for hosting an application. You pre-provision application landing zones through code and use management groups to assign policy controls to them. In the conceptual architecture (*see figure 1*), the "Landing zone A1 subscription" and "Landing zone A2 subscription" represent two different application landing zones. The conceptual architecture shows only the "Landing zone A2 subscription" in detail. It depicts representative resources and policies applied to the application landing zone.

:::image type="content" source="./media/alz-application-platform.svg" alt-text="A conceptual architecture diagram of an Azure landing zone with Application & Platform Landing Zones overlaid." lightbox="./media/alz-application-platform.svg":::
*Figure 2: Azure landing zone conceptual architecture with Application & Platform Landing Zones overlaid. Download a [Visio file](https://github.com/microsoft/CloudAdoptionFramework/raw/main/ready/enterprise-scale-architecture.vsdx) of this architecture.*

There are three main approaches to managing application landing zones. You should use one of the following management approaches depending on your needs:

- Central team approach
- Application team approach
- Shared team approach

| Application landing zone management approach | Description |
| --- | --- |
| Central team management | A central IT team fully operates the landing zone. The team applies controls and platform tools to the platform and application landing zones.
| Application team management | A platform administration team delegates the entire application landing zone to an application team. The application team manages and supports the environment. The management group policies ensure that the platform team still governs the application landing zone. You can add other policies at the subscription scope and use alternative tooling for deploying, securing, or monitoring application landing zones.|
| Shared management | With technology platforms such as AKS or AVS, a central IT team manages the underlying service. The application teams are responsible for the applications running on top of the technology platforms. You need to use different controls or access permissions for this model. These controls and permissions differ from the ones you use to manage application landing zones centrally.

## Application landing zone accelerators

Application landing zone accelerators help you deploy common workloads in your application landing zone subscriptions. Use the list of available application landing zone accelerators in the [Azure Architecture Center](/azure/architecture/landing-zones/landing-zone-deploy#application) and deploy the accelerator that matches your scenario. Make sure you have reviewed and completed the [prerequisites](https://github.com/Azure/Enterprise-Scale/wiki/Deploying-ALZ-Pre-requisites) before deploying Azure Landing Zones.

### AI in Azure landing zones

A common questions is whether you need a dedicated AI landing zone alongside your Azure landing zone. The answer is that you don't need a separate AI landing zone. Instead, you can use the existing Azure landing zone architecture to deploy AI workloads into. The Azure landing zone design areas and principles are sufficient to support AI workloads, as they provide the necessary foundation for governance, security, and management for applications and workloads that both include AI and non-AI components and services. 

You can integrate AI services into your application landing zones without needing a separate AI landing zone. The Azure landing zone architecture, design principles, and design areas, such as identity and access management, network topology and connectivity, security, and governance, are already designed to accommodate all workloads, including those that involve AI.

From the perspective of Azure landing zones, AI is just another workload or service that can be deployed, governed, and secured within one or more application landing zone subscriptions, just like any other application, workload, or service, by the platform team by utilizing the existing Azure landing zone architecture, principles, and design areas.

For more information on AI adoption in Azure, see the [AI adoption scenario](/azure/cloud-adoption-framework/scenarios/ai/). For specific focus on AI workloads and landing zones, see [Establish an AI foundation](/azure/cloud-adoption-framework/scenarios/ai/ready#establish-an-ai-foundation).

## Azure Verified Modules for Platform Landing Zones

For infrastructure as code (IaC) deployments, you can use Azure Verified Modules for Platform Landing Zones. Available for both Bicep and Terraform, these modules provide a set of reusable, customizable, and extensible modules that help you deploy a platform landing zone. The modules are designed to help you accelerate the delivery of the recommended resource hierarchy and governance model. You can integrate shared services, network connectivity, and application workloads into your deployment or manage them independently.

If you want to use Bicep or Terraform, see [Bicep and Terraform deployment options](/azure/architecture/landing-zones/landing-zone-deploy#platform).

## Azure Platform Landing Zones Portal Accelerator

This accelerator is a ready-made deployment experience. The Azure landing zone portal accelerator deploys the conceptual architecture (*see figure 1*) and applies predetermined configurations to key components such as management groups and policies. It suits organizations whose conceptual architecture aligns with the planned operating model and resource structure.

If you plan to manage your environment with the Azure portal, use the Azure Platform Landing Zones Portal Accelerator. Deploying the Azure Landing Zone Portal Accelerator requires permissions to create resources at the tenant (`/`) scope. To grant these permissions, follow the guidance in [Tenant deployments with ARM templates: Required access](/azure/azure-resource-manager/templates/deploy-to-tenant?tabs=azure-powershell#required-access).

<!-- markdownlint-disable MD034 -->

<br/>

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=14a106f2-3835-44b1-8452-3849bea9fea7]

<!-- markdownlint-enable MD034 -->
*Video explaining Azure landing zones and their implementation principles*

## Next steps

An Azure landing zone is an environment that adheres to crucial design principles across eight design areas. You should familiarize yourself with these design principles to tailor them to your needs.

> [!div class="nextstepaction"]
> [Design principles](./design-principles.md)

You can also review the [Frequently Asked Questions (FAQ)](/azure/cloud-adoption-framework/ready/enterprise-scale/faq) to learn more about Azure landing zones and answer common questions such as, *"Do I need an AI landing zone?"* or *"What is the difference between an Azure landing zone and an enterprise-scale landing zone?"*.