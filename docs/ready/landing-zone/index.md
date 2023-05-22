---
title: What is an Azure landing zone?
description: Learn how a landing zone provides the basic building block of any cloud adoption environment.
author: martinekuan
ms.author: martinek
ms.date: 09/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# What is an Azure landing zone?

An Azure landing zone is a multi-subscription Azure environment that enables application migration, modernization, and innovation at scale. An Azure landing zone adheres to essential design principles across eight design areas.

Azure landing zones are scalable and modular to fit all deployment needs. They use repeatable infrastructure to apply configuration and controls to each application landing zone as. They also use a modular or extensible to easily scale specific elements of the environment as requirements evolve.

## Azure landing zone conceptual architecture

The Azure landing zone conceptual architecture is a target architecture. It sets a direction for the overall approach your organization should take when designing and implementing an Azure landing zone. Use this architecture as a starting point and modify it to fit your specific business and technical requirements.

:::image type="content" source="../enterprise-scale/media/ns-arch-cust-expanded.svg" alt-text="A conceptual architecture diagram of an Azure landing zone." lightbox="../enterprise-scale/media/ns-arch-cust-expanded.svg":::
*Figure 1: Azure landing zone conceptual architecture. Download a [Visio file](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/ready/enterprise-scale-architecture.vsdx) of this architecture.*

Whether you're starting on your first production application on Azure or operating a complex portfolio of tech platforms and workloads, you can [tailor the Azure landing zone architecture to meet requirements](./tailoring-alz.md).

**Subscriptions:** The conceptual architecture shows the placement of the subscriptions (yellow boxes) in the management group hierarchy. It also shows a zoomed in view of five subscriptions with Azure resources and policies applied.

**Design areas:** The conceptual architecture illustrates implementation recommendations across eight design areas: (1) Azure billing and Active Directory tenant, (2) identity and access management, (3) resource organization, (4) network topology and connectivity, (5) security, (6) management, (7) governance, (8) platform automation and DevOps (A-I). Of these eight design areas, there are environment design areas and compliance design areas.

*Environment design areas:* Azure billing and Azure Active Directory tenant (A), identity and access management (B), management groups and subscriptions (C), and network topology connectivity (E) are the environment design areas.

*Compliance design areas:* Security (F), management (D, G, H), governance (C, D), and Platform automation and DevOps (I) are the compliance design areas.

For more information, see [the Azure Landing Zone environment design areas](./design-areas.md#environment-design-areas).

### Platform landing zone vs. application landing zones

An Azure landing zone has two types of landings zones: platform landing zones and application landing zones. Platform landing zones are for the platform resources your applications need. Application landing zones are environments for your applications.

In the conceptual architecture, platform landing zones are the subscriptions under the 'Platform' management group. The application landing zones are the subscriptions under the "Landing zone" management group.

**Platform landing zone:** A platform landing zones are subscriptions that provide centralized services to workloads and applications. A central team or several central teams aligned to function (networking, identity) manage these subscriptions. Platform landing zones provide key services to workloads and applications. Consolidating these key services often improves operational efficiency.

In the conceptual architecture, the "Identity subscription", "Management subscription", and "Connectivity subscription" are platform landing zones.

**Application landing zone:**  An application landing zone is an environment for an application or workload. You use management groups to assign policy controls to application landing zones.

In the conceptual architecture, the "Application landing zone 1 subscription" and "Application landing zone 2 subscription" are application landing zones.

Depending on the deployment, a central IT team, application team, or shared management (*see table*).

| Application landing zone management approach | Description |
| --- | --- |
| Central IT team management | A central IT team fully operates the landing zone. The team applies controls and platform tools to both the platform and application landing zones.
| Application team management | A platform administration team delegates the entire landing zone to a workload team. The workload team manages and supports the environment. The management group policies control that the platform team controls still controls the workload. This might include adding additional policies at the subscription scope and using alternative tooling for deploying, securing, or monitoring workloads.|
| Shared management | With technology platforms such as AKS or AVS, a central IT teams manages the underlying service. The application teams are responsible for the applications running on top of the technology platforms. You need to use different controls or access permissions for this model. These controls and permissions are different from the ones you use to centrally manage application landing zones.  

## Azure landing accelerators

Accelerators are infrastructure-as-code implementations that deploy both platform and application landing zones.

<!-- markdownlint-disable MD034 -->

<br/>

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE4xdvm]

<!-- markdownlint-enable MD034 -->

### Portal accelerator

There's a ready-made deployment experience called the **Azure landing zone portal accelerator**. The portal accelerator is for organizations where the conceptual architecture fits the operating model and resource structure you plan to use.

You should use if you plan to manage your environment with the Azure portal. The Azure landing zone portal accelerator deploys a full implementation of the conceptual architecture, along with opinionated configurations for key components such as management groups and policies.

Deploying the Azure landing zone portal accelerator requires permissions to create resources at the tenant (`/`) scope. These permissions can be granted by following the guidance in [Tenant deployments with ARM templates: Required access](/azure/azure-resource-manager/templates/deploy-to-tenant?tabs=azure-powershell#required-access).

[![`DTA-Button-ALZ`](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.svg?sanitize=true)](https://aka.ms/caf/ready/accelerator)

### Platform landing zone accelerators

There are Azure landing zone accelerators available for platform landing zones. Some accelerators deliver the full architecture using third-party deployment technologies. Other accelerators start from a smaller footprint. For more information, see [Implementation options](./implementation-options.md).

### Application landing zone accelerators

Application landing zone accelerators are listed in the [Azure Architecture Center](/azure/architecture/landing-zones/landing-zone-deploy)

### Scenario-based accelerators

The Microsoft Cloud Adoption Framework outlines [cloud adoption scenarios](../../scenarios/overview.md) to help you further refine and accelerate your cloud adoption journey, for application and workload deployment. There are [Infrastructure as Code implementations or accelerators](/azure/architecture/landing-zones/landing-zone-deploy#application) for each of these scenarios.

## Next steps

At the foundation of the architecture is a set of core design principles that serve as a compass for subsequent design decisions across critical technical domains. Familiarize yourself with these principles to better understand their impact and the trade-offs associated with deviation.

> [!div class="nextstepaction"]
> [Design principles](./design-principles.md)
