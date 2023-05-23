---
title: What is an Azure landing zone?
description: Learn how a landing zone provides the basic building block of any cloud adoption environment.
author: martinekuan
ms.author: martinek
ms.date: 05/26/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# What is an Azure landing zone?

An Azure landing zone is an Azure environment that enables application migration, modernization, and innovation at scale. An Azure landing zone follows essential design principles across eight design areas. It's a deployment framework that accommodates simple to complex application portfolios. An Azure landing zone uses multiple subscriptions to provide a secure and scalable home for your applications ("application landing zones") and platform resources ("platform landing zones").

## Azure landing zone architecture

Azure landing zone architecture is scalable and modular to meet a range of deployment needs. It uses repeatable infrastructure to apply configuration and controls to each subscription. It's also modular to easily scale specific elements of the environment as your requirements evolve.

The Azure landing zone conceptual architecture (*see figure 1*) represents an opinionated, target architecture. It consists of platform landing zones for central, shared resources and application landing zones to host your applications. Use the conceptual architecture as a starting point and and then [tailor the architecture to meet your needs](./tailoring-alz.md).

:::image type="content" source="../enterprise-scale/media/ns-arch-cust-expanded.svg" alt-text="A conceptual architecture diagram of an Azure landing zone." lightbox="../enterprise-scale/media/ns-arch-cust-expanded.svg":::
*Figure 1: Azure landing zone conceptual architecture. Download a [Visio file](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/ready/enterprise-scale-architecture.vsdx) of this architecture.*

*Resource organization:* The conceptual architecture shows a sample management group hierarchy. Subscriptions (yellow boxes) fall under the appropriate management group. The subscriptions for platform landing zones are under the 'Platform' management group. The subscriptions for application landing zones are under the 'Landing zone' management group. The conceptual architecture also shows a zoomed in view of five subscriptions.You can see the resources and policies applied to these subscriptions.

*Design areas:* The conceptual architecture illustrates the implementation of key design principles across eight design areas: Azure billing and Active Directory tenant (A), identity and access management (B), resource organization (C), network topology and connectivity (E), security (F), management (D, G, H), governance (C, D), and Platform automation and DevOps (I). For more information, see [the Azure Landing Zone environment design areas](./design-areas.md#environment-design-areas).

### Platform landing zones vs. application landing zones

An Azure landing zone consists of two types of landings zones: platform landing zones and application landing zones.

**Platform landing zone** is a subscription that provides a centralized service (identity, connectivity, management) to applications in application landing zones. One or more central teams manage platform landing zones. Platform landing zones provide key services to workloads and applications. Consolidating these key services often improves operational efficiency. In the conceptual architecture, the "Identity subscription", "Management subscription", and "Connectivity subscription" are each a platform landing zone. The architecture shows representative resources and policies for each platform landing zone.

**Application landing zone** is an environment for hosting application pre-provisioned through code. You use management groups to assign policy controls to application landing zones. The conceptual architecture shows representative resources and policies for these application landing zones. In the conceptual architecture, the "Landing zone A1" and "Landing zone A2" are each an application landing zone.

There are three main approaches to managing application landing zones: central team management, application team management, or shared management (*see table*).

| Application landing zone management approach | Description |
| --- | --- |
| Central team management | A central IT team fully operates the landing zone. The team applies controls and platform tools to both the platform and application landing zones.
| Application team management | A platform administration team delegates the entire landing zone to a workload team. The workload team manages and supports the environment. The management group policies control that the platform team controls still controls the workload. You can include adding other policies at the subscription scope and using alternative tooling for deploying, securing, or monitoring workloads.|
| Shared management | With technology platforms such as AKS or AVS, a central IT team manages the underlying service. The application teams are responsible for the applications running on top of the technology platforms. You need to use different controls or access permissions for this model. These controls and permissions are different from the ones you use to centrally manage application landing zones.  

## Azure landing zone accelerators

Accelerators are infrastructure-as-code implementations that help you rapidly deploy an Azure landing zone. There's a platform landing zone accelerator and several application landing zone accelerators.

### Platform landing zone accelerator

**Azure landing zone portal accelerator:** There's a ready-made deployment experience called the Azure landing zone portal accelerator. The Azure landing zone portal accelerator deploys a full implementation of the conceptual architecture. It also applies opinionated configurations for key components such as management groups and policies. The portal accelerator is for organizations where the conceptual architecture fits the operating model and resource structure you plan to use.

You should use the Azure landing zone portal accelerator if you plan to manage your environment with the Azure portal. If you want to use Bicep or Terraform, see the [Bicep and Terraform deployment options](/azure/architecture/landing-zones/landing-zone-deploy#platform).

Deploying the Azure landing zone portal accelerator requires permissions to create resources at the tenant (`/`) scope. Follow the guidance in [Tenant deployments with ARM templates: Required access](/azure/azure-resource-manager/templates/deploy-to-tenant?tabs=azure-powershell#required-access) to grant these permissions.

[![`DTA-Button-ALZ`](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.svg?sanitize=true)](https://aka.ms/caf/ready/accelerator)

### Application landing zone accelerators

Application landing zone accelerators help you deploy application landing zones. Use the list of available application landing zone accelerators in the [Azure Architecture Center](/azure/architecture/landing-zones/landing-zone-deploy). There are [infrastructure as code implementations or accelerators](/azure/architecture/landing-zones/landing-zone-deploy#application) for each of these scenarios.

<!-- markdownlint-disable MD034 -->

<br/>

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE4xdvm]

<!-- markdownlint-enable MD034 -->
*Video that describes application landing zones*

## Next steps

The foundation of the architecture is a set of core design principles that serve as a compass for subsequent design decisions across critical technical domains. Familiarize yourself with these principles to better understand their benefits and the tradeoffs associated with deviation.

> [!div class="nextstepaction"]
> [Design principles](./design-principles.md)
