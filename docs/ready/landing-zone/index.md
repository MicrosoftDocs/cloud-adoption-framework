---
title: What is an Azure landing zone?
description: Learn how a landing zone provides the basic building block of any cloud adoption environment.
author: stephen-sumner
ms.author: ssumner
ms.date: 10/07/2024
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

### Platform landing zones vs. application landing zones

An Azure landing zone consists of platform landing zones and application landing zones. It's worth explaining the function of both in more detail.

**Platform landing zone:** A platform landing zone is a subscription that provides shared services (identity, connectivity, management) to applications in application landing zones. Consolidating these shared services often improves operational efficiency. One or more central teams manage the platform landing zones. In the conceptual architecture (*see figure 1*), the "Identity subscription," "Management subscription," and "Connectivity subscription" represent three different platform landing zones. The conceptual architecture shows these three platform landing zones in detail. It depicts representative resources and policies applied to each platform landing zone.

**Application landing zone:** An application landing zone is a subscription for hosting an application. You pre-provision application landing zones through code and use management groups to assign policy controls to them. In the conceptual architecture (*see figure 1*), the "Landing zone A1 subscription" and "Landing zone A2 subscription" represent two different application landing zones. The conceptual architecture shows only the "Landing zone A2 subscription" in detail. It depicts representative resources and policies applied to the application landing zone.

There are three main approaches to managing application landing zones. You should use one of the following management approaches depending on your needs:

- Central team approach
- Application team approach
- Shared team approach

| Application landing zone management approach | Description |
| --- | --- |
| Central team management | A central IT team fully operates the landing zone. The team applies controls and platform tools to the platform and application landing zones.
| Application team management | A platform administration team delegates the entire application landing zone to an application team. The application team manages and supports the environment. The management group policies ensure that the platform team still governs the application landing zone. You can add other policies at the subscription scope and use alternative tooling for deploying, securing, or monitoring application landing zones.|
| Shared management | With technology platforms such as AKS or AVS, a central IT team manages the underlying service. The application teams are responsible for the applications running on top of the technology platforms. You need to use different controls or access permissions for this model. These controls and permissions differ from the ones you use to manage application landing zones centrally.

## Azure landing zone accelerators

Accelerators are infrastructure-as-code implementations that help you deploy an Azure landing zone correctly. We have a platform landing zone accelerator and several application landing zone accelerators you can deploy.

### Platform landing zone accelerator

There's a ready-made deployment experience called the **Azure landing zone portal accelerator**. The Azure landing zone portal accelerator deploys the conceptual architecture (*see figure 1*) and applies predetermined configurations to key components such as management groups and policies. It suits organizations whose conceptual architecture aligns with the planned operating model and resource structure.

You should use the Azure landing zone portal accelerator if you plan to manage your environment with the Azure portal. If you want to use Bicep or Terraform, see the [Bicep and Terraform deployment options](/azure/architecture/landing-zones/landing-zone-deploy#platform). Deploying the Azure landing zone portal accelerator requires permissions to create resources at the tenant (`/`) scope. Follow the guidance in [Tenant deployments with ARM templates: Required access](/azure/azure-resource-manager/templates/deploy-to-tenant?tabs=azure-powershell#required-access) to grant these permissions.

[![`DTA-Button-ALZ`](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.svg?sanitize=true)](https://aka.ms/caf/ready/accelerator)

### Application landing zone accelerators

Application landing zone accelerators help you deploy application landing zones. Use the list of available application landing zone accelerators in the [Azure Architecture Center](/azure/architecture/landing-zones/landing-zone-deploy#application) and deploy the accelerator that matches your scenario.

<!-- markdownlint-disable MD034 -->

<br/>

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=14a106f2-3835-44b1-8452-3849bea9fea7]

<!-- markdownlint-enable MD034 -->
*Video explaining application landing zones and their implementation principles*

## Next steps

An Azure landing zone is an environment that adheres to crucial design principles across eight design areas. You should familiarize yourself with these design principles to tailor them to your needs.

> [!div class="nextstepaction"]
> [Design principles](./design-principles.md)
