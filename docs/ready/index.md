---
title: Ready your Azure environment for workloads
description: Understand Azure landing zone and the process to use one. 
author: stephen-sumner
ms.author: pnp
ms.date: 12/11/2025
ms.topic: concept-article
ms.custom: internal
ms.update-cycle: 1095-days
---

# Ready your Azure environment for workloads

Before you can deploy workloads in Azure, prepare the underlying environment that supports them. CAF Ready provides a structured approach that helps you build a scalable, secure, and governed cloud environment from the start. This foundational setup is known as a platform landing zone. An [Azure landing zone](/azure/cloud-adoption-framework/ready/landing-zone/) is the recommended implementation of a platform landing zone.

:::image type="content" source="../_images/ready/azure-landing-zone-conceptual-diagram.png" alt-text="Diagram showing the conceptual components of your cloud environment as it aligns with Azure landing zones." lightbox="../_images/ready/azure-landing-zone-conceptual-diagram.png" border="false":::

## Platform landing zone

The platform landing zone serves as the backbone of your Azure environment. It establishes governance and central services that apply across your organization. Its functionality includes a management group hierarchy with Azure Policy enforcement across subscriptions. There are also dedicated subscriptions for connectivity, identity, management, and security shared services.

Depending on your organization's size and cloud maturity, you might choose to implement all, some, or none of these centralized services. For smaller or cloud-native teams, a lightweight approach might be sufficient.

Part of your platform landing zone should include the capability to receive requests for application landing zones and distribute those requests to workload teams for implementation.

## Application landing zone

An application landing zone is for workload resources. A workload should have an application landing zone for each environment (development, testing, or production). Each application landing zone consists of one or more subscriptions to accommodate scaling and service limits. They are nested under appropriate management groups, such as "Online" or "Corp," to inherit Azure Policy definitions from the parent management group(s). This structure ensures that workloads are deployed in a controlled and consistent manner, while still allowing flexibility for individual workload needs.

## Configurations that apply across all subscriptions

Whether a subscription belongs to the platform or an application landing zone, certain configurations should be enabled universally. These configurations include: Azure Role-Based Access Control (RBAC), Cost Management, Network Watcher, and Microsoft Defender for Cloud. These services help maintain visibility, security, and operational control across your entire Azure environment.

## Azure landing zone implementation

An [Azure landing zone](/azure/cloud-adoption-framework/ready/landing-zone/) is the recommended implementation of a platform landing zone. The implementation unfolds in major phases, each with supporting processes and tools:

:::image type="content" source="./landing-zone/media/customer-landing-zone-journey.png" alt-text="Diagram showing the Azure landing zone customer journey." border="false" lightbox="./landing-zone/media/customer-landing-zone-journey.png" :::

### 1. Bootstrap your environment

Whether you’re starting fresh (Greenfield) or modernizing an existing setup (Brownfield), the first step is to create the subscriptions that will host your resources. Implementing a new Azure landing zone environment based on best practices usually requires multiple subscriptions. You can create these subscriptions manually, programmatically, or by using automated vending modules:

- [Create subscriptions manually](/azure/cost-management-billing/manage/create-subscription#create-a-subscription)
- [Create subscriptions programmatically](/azure/cost-management-billing/manage/programmatically-create-subscription)
- [Subscription vending modules](/azure/cloud-adoption-framework/ready/landing-zone/design-area/subscription-vending)

### 2. Deploy platform landing zone components

Next, accelerate the deployment of your platform resources based on the Azure landing zone reference architecture. These components establish governance and shared services such as management group hierarchy, policy enforcement, connectivity, security, and monitoring. Deployment options include the Azure portal, Bicep, and Terraform:

- [Accelerator portal](/azure/cloud-adoption-framework/ready/landing-zone/implementation-options#azure-landing-zone-accelerator-approach)
- [ALZ IaC Accelerator](https://aka.ms/alz/accelerator)
  - [Bicep modules](https://aka.ms/alz/bicep)
  - [Terraform module](https://aka.ms/alz/tf)

### 3. Subscription vending process (optional)

Once your platform is in place, you’ll need to create individual application landing zones within your Azure tenant. A subscription vending solution is recommended to automate this process. Vending helps deploy subscriptions along with core resources such as networking. Both Bicep and Terraform modules are available:

- [Vending module (Terraform)](https://aka.ms/lz-vending/tf)
- [Vending module (Bicep)](https://aka.ms/lz-vending/bicep)

## Next step

> [!div class="nextstepaction"]
> [What is an Azure landing zone?](./landing-zone/index.md)