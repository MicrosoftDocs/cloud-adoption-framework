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

The implementation guidance in this article presupposes that you have implemented Azure landing zone in your environment. For more information, see [What is an Azure landing zone](/azure/cloud-adoption-framework/ready/landing-zone/implementation-options) and [Landing zone implementation options](/azure/cloud-adoption-framework/ready/landing-zone/implementation-options).

## Defining Oracle on Azure

Oracle on Azure provides two principles options for migrating Oracle workloads to Azure. You can lift and shift your Oracle workloads to Azure virtual machines or use the fully-managed Oracle Database@Azure:

- Oracle on Azure Virtual Machines: Run Oracle databases and enterprise applications, such as Siebel, PeopleSoft, JD Edwards, E-Business Suite, or customized WebLogic server applications, to Azure infrastructure. You can use Oracle Linux images, RHEL or other endorsed OS. There are multiple virtual machines and storage options available.

- Oracle Database@Azure: Oracle Database@Azure allows you to run Oracle Exadata infrastructure in Azure. Oracle Exadata is a high-performance database platform. Azure supports critical features, such as Oracle Zero Downtime Migration, Oracle Real Application Clusters, Oracle Data Guard, and Oracle GoldenGate. 

For more information, see [Oracle on Azure overview](/azure/oracle/oracle-azure-overview)

## Oracle on Azure narrative

As customers from different industries have specific needs that leverage Oracle investments, there's also the concern of sustainability. Compared to deploying huge on-premises infrastructure, having your Oracle workloads in the cloud helps to use minimal computing resources only as and when is needed with flexible scalability to support sustainability goals.

Oracle on Azure also offers competitive pricing and performance compared to on-premises options, robust global regulatory compliance, and cloud-native management tooling for your enterprise management requirements.

When customers choose the relevant Oracle on Azure solution for their specific computing tasks, there will also need to be considerations for following the [Cloud Adoption Framework](/azure/cloud-adoption-framework/overview) to prepare decision makers and central IT for successful cloud adoption.

### Landing zone architecture for Oracle on Azure Virtual Machines

The following diagram is a conceptual reference architecture that shows the critical design areas in an Oracle on Azure IaaS landing zone implementation.

:::image type="content" source="media/reference-architecture-oracle-iaas-landing-zone.png" alt-text="Diagram showing a reference architecture of Oracle on Azure Virtual Machines.":::

Use the reference architecture as a starting point. You can download the [Visio file](https://github.com/MicrosoftDocs/cloud-adoption-framework/tree/main/docs/scenarios/oracle-iaas/media/Azure-Landing-Zone-Architecture-Oracle.vsdx) and modify it to fit your specific business and technical requirements when you plan your landing zone implementation.

As shown in  the reference architectural diagram, the Oracle databases are deployed on virtual machines. You can change the size and number of virtual machines to accommodate your organization's needs. The network layout in this example is simplified to demonstrate architectural principles and isn't intended to describe an entire enterprise network.

### Landing zone architecture for Oracle Database@Azure

The following diagram shows Oracle Database@Azure deployed to an application landing zone and the critical design areas that support it. The Oracle databases run on Oracle Exadata virtual machine clusters in Azure. You can change the size and number of VM clusters to accommodate your needs.

:::image type="content" source="./media/reference-architecture-oracle-odaa-landing-zone.png" alt-text="Diagram showing a reference architecture of Oracle Database@Azure.":::
*Download a [Visio file](https://github.com/MicrosoftDocs/cloud-adoption-framework/tree/main/docs/scenarios/oracle-iaas/media/Azure-Landing-Zone-Architecture-Oracle.vsdx) of this architecture.*

## Next step

> [!div class="nextstepaction"]
> [Strategy for Oracle on Azure](oracle-landing-zone-strategy.md)

