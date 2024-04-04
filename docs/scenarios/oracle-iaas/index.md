---
title: Introduction to the Oracle on Azure adoption scenario
description: Oracle on Azure landing zone accelerator.
author: jfaurskov
ms.author: janfaurs
ms.date: 04/03/2024
ms.topic: conceptual
ms.custom: 
  - think-tank
  - e2e-oracle
  - engagement-fy24
---
# Introduction to the Oracle on Azure adoption scenario

Use the guidance in this article to set up and operate Oracle workloads inside your Azure landing zone implementation. The article provides specific architectural approaches and reference implementations for your Oracle database systems on Azure.

The implementation guidance in this article presupposes that you have implemented Azure landing zone in your environment. For more information, see [What is an Azure landing zone](/azure/cloud-adoption-framework/ready/landing-zone/implementation-options) and [Landing zone implementation options.](/azure/cloud-adoption-framework/ready/landing-zone/implementation-options).

## Defining Oracle on Azure

Oracle is widely recognized for its comprehensive suite of software and hardware systems, particularly its database management systems, which are prevalent in on-premises enterprise implementations today. As businesses increasingly seek to modernize their infrastructure and move towards cloud solutions, understanding the integration of Oracle systems with Azure services becomes highly relevant.

Oracle on Azure VMs and Oracle Database@Azure offer robust solutions for running Oracle workloads in the cloud. Oracle on Azure VMs provides a range of virtual machine images pre-configured with Oracle software, allowing for easy deployment and management of Oracle applications. These VMs are optimized for performance and support a variety of Oracle products, including databases and middleware. Oracle Database@Azure, on the other hand, is a fully managed service that delivers high-performance Oracle databases on Azure infrastructure.It enables seamless integration with Azure services, providing a comprehensive cloud environment for mission-critical applications. Both offerings ensure flexibility, scalability, and cost-effectiveness, making them ideal for businesses looking to modernize their Oracle workloads in the cloud. 

The different offerings have different requirements and considerations, and the guidance in the Oracle on Azure landing zone accelerator articles is designed to help you navigate every step of adopting Oracle workloads for Azure.

Oracle on Azure landing zone architectures vary by organization. Technical considerations and design recommendations lead to configurations that are unique to your organization's specific scenario. The recommendations that this article describes should lead to an architecture that puts your organization on a path to sustainable scaling.

## Oracle on Azure narrative

As customers from different industries have specific needs that leverage Oracle investments, there's also the concern of sustainability. Compared to deploying huge on-premises infrastructure, having your Oracle workloads in the cloud helps to use minimal computing resources only as and when is needed with flexible scalability to support sustainability goals.

Oracle on Azure also offers competitive pricing and performance compared to on-premises options, robust global regulatory compliance, and cloud-native management tooling for your enterprise management requirements.

When customers choose the relevant Oracle on Azure solution for their specific computing tasks, there will also need to be considerations for following the [Cloud Adoption Framework](/azure/cloud-adoption-framework/overview) to prepare decision makers and central IT for successful cloud adoption.

### High-level Oracle landing zone architecture for Oracle on Azure Virtual Machines

The following diagram is a conceptual reference architecture that shows the critical design areas in an Oracle on Azure IaaS landing zone implementation.

:::image type="content" source="media/reference-architecture-oracle-iaas-landing-zone.png" alt-text="Diagram showing a reference architecture of Oracle on Azure Virtual Machines.":::

Use the reference architecture as a starting point. You can download the [Visio file](https://github.com/MicrosoftDocs/cloud-adoption-framework/tree/main/docs/scenarios/oracle-iaas/media/Azure-Landing-Zone-Architecture-Oracle.vsdx) and modify it to fit your specific business and technical requirements when you plan your landing zone implementation.

As shown in  the reference architectural diagram, the Oracle databases are deployed on virtual machines. You can change the size and number of virtual machines to accommodate your organization's needs. The network layout in this example is simplified to demonstrate architectural principles and isn't intended to describe an entire enterprise network.

### High-level Oracle landing zone architecture for Oracle Database@Azure

The following diagram is a conceptual reference architecture that shows the critical design areas in an Oracle on Azure landing zone implementation.

:::image type="content" source="media/reference-architecture-oracle-odaa-landing-zone.png" alt-text="Diagram showing a reference architecture of Oracle Database@Azure.":::

Use the reference architecture as a starting point. You can download the [Visio file](https://github.com/MicrosoftDocs/cloud-adoption-framework/tree/main/docs/scenarios/oracle-iaas/media/Azure-Landing-Zone-Architecture-Oracle.vsdx) and modify it to fit your specific business and technical requirements when you plan your landing zone implementation.

As shown in  the reference architectural diagram, the Oracle databases are deployed on Oracle Exadata VM clusters in Azure data centers. You can change the size and number of VM clusters to accommodate your organization's needs. The network layout in this example is simplified to demonstrate architectural principles and isn't intended to describe an entire enterprise network.

## Next step: Integrate Oracle on Azure into your cloud adoption journey

The following list of articles will take you to guidance found at specific points throughout the cloud adoption journey to help you be successful in the cloud adoption scenario.

- [Strategy for Oracle on Azure](oracle-landing-zone-strategy.md)
- [Plan for Oracle on Azure](oracle-landing-zone-plan.md)
- [Migrate to Oracle on Azure](oracle-migration-planning.md)
