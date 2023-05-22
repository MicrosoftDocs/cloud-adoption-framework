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

An Azure landing zone is a multi-subscription Azure environment that enables application migration, modernization, and innovation at scale. An Azure landing zone adheres to essential design principles across seven design areas. An Azure landing zone has two types of landings zones: platform landing zones and application landing zones. Platform landing zones are for the platform resources your applications need. Application landing zones are environments for your applications.

## Azure landing zone conceptual architecture

The Azure landing zone conceptual architecture is target architecture. It sets a direction for the overall approach your organization should take when designing and implementing an Azure landing zone. Use this architecture as a starting point and modify it to fit your specific business and technical requirements.

:::image type="content" source="../enterprise-scale/media/ns-arch-cust-expanded.svg" alt-text="A conceptual architecture diagram of an Azure landing zone." lightbox="../enterprise-scale/media/ns-arch-cust-expanded.svg":::
*Download a [Visio file](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/ready/enterprise-scale-architecture.vsdx) of this architecture.*

Before deploying Azure resources, you need to set up your enterprise enrollment (A), identity and access management (B), and management groups and subscriptions (C). You should place your subscriptions in the appropriate management groups. The yellow boxes represent different subscriptions. The diagram shows you the Azure resources in five of these subscriptions.

Whether you're starting on your first production application on Azure or operating a complex portfolio of tech platforms and workloads, you can [tailor the Azure landing zone architecture to meet requirements](./tailoring-alz.md).

For more information on the design areas labeled A-I in the visual, see the Azure Landing Zone [environment design areas](./design-areas.md#environment-design-areas).

### Platform landing zone vs. application landing zones

There are two types of landing zones:

- **Platform landing zone:** A platform landing zones are subscriptions that provide centralized services to workloads and applications. A central team or a number of central teams split by function (networking, identity) manage these subscriptions. Platform landing zones provide key services to workloads and applications. Consolidating these key services often improves operational efficiency. In the conceptual architecture, the "Identity subscription", "Management subscription", and "Connectivity subscription" are platform landing zones.
- **Application landing zone:**  An application landing zone is an environment for an application or workload. You use management groups to assign policy controls to application landing zones. In the conceptual architecture, the "Application landing zone subscription A2" receives the policy controls from 'corp' management group. There are three different approaches to managing application landing zones:
  
  - *Central IT team management*: A central IT team fully operates the landing zone. The team applies controls and platform tools to both the platform and application landing zones.
  - *Split management*: With technology platforms such as AKS or AVS, a central IT teams manages the underlying service. The application teams are responsible for the applications running on top of the technology platforms. You need to use different controls or access permissions for this model. These controls and permissions are different from the ones you use to centrally manage application landing zones.  
  - *Application team management*: A platform administration team delegates the entire landing zone to a workload team to fully manage and support the environment; whilst still being controlled by the policies applied from the Management Groups above that the platform team control. This might include adding additional policies at the subscription scope and using alternative tooling for deploying, securing or monitoring workloads that is fully controlled and operated by the workload team.

## Azure landing accelerators

Accelerators are infrastructure-as-code implementations that deploy both platform and application landing zones. Since no single solution fits all technical environments, accelerators are scalable and modular.

- **Scalable:** Accelerators allow you to create repeatable environments with consistent configuration and controls regardless of the workloads or Azure resources deployed to each landing zone instance.
- **Modular:** Accelerators provide a modular or extensible approach to building out your environment based on a common set of design areas. The extensibility of an Azure landing zone enables an organization to easily scale specific elements of the environment as requirements evolve.

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

There are other Azure landing zone accelerators available for platform landing zones. Some accelerators deliver the full architecture using third-party deployment technologies. Other accelerators start from a smaller footprint. For more information, see [Implementation options](./implementation-options.md).

### Application landing zone accelerators

Application landing zone accelerators are listed in the [Azure Architecture Center](/azure/architecture/landing-zones/landing-zone-deploy)

### Scenario-based accelerators

The Microsoft Cloud Adoption Framework outlines [cloud adoption scenarios](../../scenarios/overview.md) to help you further refine and accelerate your cloud adoption journey, for application and workload deployment. There are [Infrastructure as Code implementations or accelerators](/azure/architecture/landing-zones/landing-zone-deploy#application) for each of these scenarios.

## Next steps

At the foundation of the architecture is a set of core design principles that serve as a compass for subsequent design decisions across critical technical domains. Familiarize yourself with these principles to better understand their impact and the trade-offs associated with deviation.

> [!div class="nextstepaction"]
> [Design principles](./design-principles.md)
