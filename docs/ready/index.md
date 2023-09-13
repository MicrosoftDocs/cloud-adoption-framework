---
title: Prepare for cloud adoption
description: Learn how to create a landing zone to host the workloads that you plan to build in the cloud or migrate to the cloud.
author: martinekuan
ms.author: martinek
ms.date: 11/12/2021
ms.topic: conceptual
ms.custom: internal
---

# Prepare for cloud adoption

Before adoption can begin, you'll create a landing zone to host the workloads that you plan to build in or migrate to the cloud. This section of the framework guides you through environment preparation and landing zone creation.

## Landing zone concepts

If you understand Azure landing zones, skip ahead to the [Landing zone journey section](#landing-zone-journey). If not, review these landing zone concepts before proceeding:

- Abstractly speaking, a ***landing zone*** helps you plan for and design an Azure deployment, by conceptualizing a designated area for placement and integration of resources. There are [two types of landing zones](/azure/cloud-adoption-framework/ready/landing-zone/#platform-vs-application-landing-zones):
   - ***platform landing zone:*** provides centralized enterprise-scale foundational services for workloads and applications.
   - ***application landing zone:*** provides services specific to an application or workload. 

- Concretely, a landing zone can be viewed through two lenses:
  - **reference architecture**: a specific design that illustrates resource deployment to one or more Azure subscriptions, which meet the requirements of the landing zone. 
  - **reference implementation**: artifacts that deploy Azure resources into the landing zone subscription(s), according to the reference architecture. Many landing zones offer multiple deployment options, but the most common is a ready-made Infrastructure as Code (IaC) template referred to as a ***landing zone accelerator***. Accelerators automate and accelerate the deployment of a reference implementation, using IaC technology such as ARM, Bicep, Terraform, and others. 

- A workload deployed to an application landing zone integrates with and is dependent upon services provided by the platform landing zone. These infrastructure services run workloads such as networking, identity access management, policies, and monitoring. This operational foundation enables migration, modernization, and innovation at enterprise-scale in Azure. 

In summary, [Azure landing zones](/azure/cloud-adoption-framework/ready/landing-zone) provide a destination for cloud workloads, a prescriptive model for managing workload portfolios at scale, and consistency and governance across workload teams. 

## Landing zone journey

As you work your way through the Ready guide, consider your progress as a continuous journey that will prepare you for landing zone creation. The journey consists of 4 major phases:

- Bootstrap your environment
- Deploy Azure landing zone platform components
- Subscription vending process
- Landing zone accelerator deployment

See the graphic below for an illustration of the 4 phases, all of which will be covered in more detail as you progress through the Ready guide.

:::image type="content" source="../landing-zone/media/customer-landing-zone-journey.png" alt-text="Diagram showing organization and naming of Azure resources deployed by the Azure Virtual Desktop landing zone accelerator." border="false" lightbox="../landing-zone/media/customer-landing-zone-journey.png" :::

## Next steps

Continue with cloud adoption and preparing your Azure environment for landing zones, by reviewing the [Azure setup guide](./azure-setup-guide/index.md).



<br><br><br><br><br><br><br><br><br>  

## **`TO BE DELETED - START`**  
The following exercises help guide you through the process of creating a landing zone to support cloud adoption.  

| Step | Description |
|--|--|
| <br> :::image type="icon" source="../_images/icons/1.png"::: | <br> [Cloud operating model](../operating-model/index.md): Explore guidance on how to find the right operating model to support your cloud adoption. |
| <br> :::image type="icon" source="../_images/icons/2.png"::: | <br> [Azure landing zones](./landing-zone/index.md): Learn about the Azure landing zone conceptual architecture and Azure landing zone accelerator. |
| <br> :::image type="icon" source="../_images/icons/3.png"::: | <br> [Journey to the target architecture](./landing-zone/landing-zone-journey.md): Validate your starting point for landing zone implementation against the three core concepts of start, align and enhance. |
| <br> :::image type="icon" source="../_images/icons/4.png"::: | <br> [Azure landing zone design areas](./landing-zone/design-areas.md): Explore the process and guidance for designing your Azure landing zone. |

## **`TO BE DELETED - END`**  

