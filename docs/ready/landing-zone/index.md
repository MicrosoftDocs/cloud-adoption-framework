---
title: What is an Azure landing zone?
description: Learn how a landing zone provides the basic building block of any cloud adoption environment.
author: stephen-sumner
ms.author: ssumner
ms.date: 05/31/2023
ms.topic: conceptual
ms.custom: internal
---

# What is an Azure landing zone?

An Azure landing zone is an environment that follows key design principles across eight design areas. These design principles accommodate all application portfolios and enable application migration, modernization, and innovation at scale. An Azure landing zone uses subscriptions to isolate and scale application resources and platform resources. Subscriptions for application resources are called application landing zones, and subscriptions for platform resources are called platform landing zones.

## Azure landing zone architecture

An Azure landing zone architecture is scalable and modular to meet various deployment needs. A repeatable infrastructure allows you to apply configurations and controls to every subscription consistently. Modules make it easy to deploy and modify specific Azure landing zone architecture components as your requirements evolve.

The Azure landing zone conceptual architecture (*see figure 1*) represents an opinionated target architecture for your Azure landing zone. You should use this conceptual architecture as a starting point and [tailor the architecture to meet your needs](./tailoring-alz.md).

:::image type="content" source="../enterprise-scale/media/ns-arch-cust-expanded.svg" alt-text="A conceptual architecture diagram of an Azure landing zone." lightbox="../enterprise-scale/media/ns-arch-cust-expanded.svg":::
*Figure 1: Azure landing zone conceptual architecture. Download a [Visio file](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/ready/enterprise-scale-architecture.vsdx) of this architecture.*

**Design areas:** The conceptual architecture illustrates the relationships between its eight design areas. These design areas are Azure billing and Microsoft Entra tenant (A), identity and access management (B), resource organization (C), network topology and connectivity (E), security (F), management (D, G, H), governance (C, D), and platform automation and DevOps (I). For more information on the design areas, see [the Azure Landing Zone environment design areas](./design-areas.md#environment-design-areas).

**Resource organization:** The conceptual architecture shows a sample management group hierarchy. It organizes subscriptions (yellow boxes) by management group. The subscriptions under the "Platform" management group represent the platform landing zones. The subscriptions under the "Landing zone" management group represent the application landing zones. The conceptual architecture shows five subscriptions in detail. You can see the resources in each subscription and the policies applied.

### Components of an Azure Landing Zone

An Azure landing zone consists of platform landing zones, application landing zones and global gouvernance and management resources. It's worth explaining their function in more detail.

**Platform landing zone:** A platform landing zone acts as a specialized subscription dedicated to providing centralized or shared services, such as identity, connectivity, and management, that underpin the applications housed within the application landing zones. By centralizing these shared services, operational efficiency is significantly enhanced. Typically, these zones are overseen by one or more centralized teams. In the referenced conceptual architecture (figure 1), the platform landing zones are exemplified by the "Identity subscription", "Management subscription", and "Connectivity subscription," each showcasing a distinct aspect of the platform's fundamental services. The detailed architecture illustrates the specific resources and policies that are implemented across each of the platform landing zones, providing a clear view of the infrastructure's design and organization.

**Application landing zone:** An application landing zone is a tailored Azure subscription created for hosting applications or workloads. It includes all the necessary elements such as virtual networks, storage solutions, and computing resources configured to support specific application needs. These zones are pre-provisioned through infrastructure-as-code, establishing a repeatable and consistent deployment process. Management groups are utilized to assign governance policies, ensuring compliance and security. As illustrated in the conceptual architecture (figure 1), "Landing zone A1 subscription" and "Landing zone A2 subscription" are examples of application landing zones, with "Landing zone A2 subscription" highlighted to detail its architecture and policy framework.

There are three main approaches to managing application landing zones. You should use a (1) central team, (2) application team, or (3) shared team management approach, depending on your needs (*see table*).

| Application landing zone management approach | Description |
| --- | --- |
| Central team management | A central IT team fully operates the landing zone. The team applies controls and platform tools to the platform and application landing zones.
| Application team management | A platform administration team delegates the entire application landing zone to an application team. The application team manages and supports the environment. The management group policies ensure that the platform team still governs the application landing zone. You can add other policies at the subscription scope and use alternative tooling for deploying, securing, or monitoring application landing zones.|
| Shared management | With technology platforms such as AKS or AVS, a central IT team manages the underlying service. The application teams are responsible for the applications running on top of the technology platforms. You need to use different controls or access permissions for this model. These controls and permissions differ from the ones you use to manage application landing zones centrally.  


**Global Governance and Management Resources:**

These global resources are not specific to any Platform or Application Landing Zone but instead provide overarching management and governance across the entire Azure environment. Examples of these global resources include:

-   **Azure Policy**: Implements and enforces rules that all landing zones must comply with for consistency and compliance.
-   **Azure Management Groups**: Organizes and groups subscriptions for better hierarchy and policy distribution.-   
-   **Microsoft Entra**: Manages identities and access controls ensuring only authorized users and services interact with your Azure resources.

Through these global resources, Azure enforces governance and monitors compliance, thus ensuring a well-managed and secure cloud environment regardless of the landing zone structure.


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

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE4xdvm]

<!-- markdownlint-enable MD034 -->
*Video explaining application landing zones and their implementation principles*

## Next steps

An Azure landing zone is an environment that adheres to crucial design principles across eight design areas. You should familiarize yourself with these design principles to tailor them to your needs.

> [!div class="nextstepaction"]
> [Design principles](./design-principles.md)
