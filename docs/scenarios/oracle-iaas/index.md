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

Refer to the guidance in this article for setting up and managing Oracle workloads within your Azure landing zone. This article outlines specific architectural strategies and provides reference implementations for Oracle database systems on Azure. The guidance assumes you have an Azure landing zone. For more information, see [What is an Azure landing zone](/azure/cloud-adoption-framework/ready/landing-zone/implementation-options) and [Landing zone implementation options](/azure/cloud-adoption-framework/ready/landing-zone/implementation-options).

## Defining Oracle on Azure

Oracle on Azure provides two principal options for migrating Oracle workloads to Azure. You can lift and shift your Oracle workloads to Azure virtual machines or use the Oracle Database@Azure:

- Oracle on Azure Virtual Machines: Run Oracle databases and enterprise applications, such as Siebel, PeopleSoft, JD Edwards, E-Business Suite, or customized WebLogic server applications on Azure infrastructure. You can use Oracle Linux images, RHEL, or other endorsed OS. There are multiple virtual machines and storage options available.

- Oracle Database@Azure: Oracle Database@Azure allows you to run Oracle Exadata infrastructure in Azure. Oracle Exadata is a high-performance database platform. Oracle Database@Azure supports other critical features, such as Oracle Real Application Cluster (RAC) and Oracle Data Guard. Oracle enterprise applications such as Siebel, PeopleSoft, JD Edwards, E-Business Suite, or customized WebLogic server applications runs on Azure virtual machines and can connect to Oracle Database@Azure.

For more information, see [Oracle on Azure overview](/azure/oracle/oracle-azure-overview).

## Oracle on Azure narrative

Oracle on Azure allows you to integrate Oracle's database services with Azure's cloud capabilities. Apply data analytics and generative AI to your Oracle data. Monitor your apps and Oracle database service with a single view in Azure. Accelerate cloud adoption using the Azure Landing Zone Accelerators for Oracle on Azure virtual machines and Oracle Database@Azure.
The following diagrams provide a conceptual reference architecture for Oracle on Azure virtual machines and Oracle Database@Azure. The diagrams show critical design areas for Azure landing zones. They present a network layout that demonstrates architectural principles and don't detail an entire enterprise network.

Use the reference architectures as a starting point. Modify them to fit your specific business and technical requirements when you plan your landing zone implementation.

### Landing zone architecture for Oracle on Azure Virtual Machines

The following diagram shows Oracle on Azure Virtual Machines deployed to an application landing zone and the critical design areas that support it. The Oracle databases run on virtual machines. You can change the size and number of virtual machines to accommodate your needs.

:::image type="content" source="./media/reference-architecture-oracle-iaas-landing-zone.png" alt-text="Diagram showing a reference architecture of Oracle on Azure Virtual Machines.":::

Download a [Visio file](https://github.com/MicrosoftDocs/cloud-adoption-framework/tree/main/docs/scenarios/oracle-iaas/media/Azure-Landing-Zone-Architecture-Oracle.vsdx) of this architecture.

### Landing zone architecture for Oracle Database@Azure

The following diagram shows Oracle Database@Azure deployed to an application landing zone and the critical design areas that support it. The Oracle databases run on Oracle Exadata virtual machine clusters in Azure. You can change the size and number of VM clusters to accommodate your needs.

:::image type="content" source="./media/reference-architecture-oracle-odaa-landing-zone.png" alt-text="Diagram showing a reference architecture of Oracle Database@Azure.":::
*Download a [Visio file](https://github.com/MicrosoftDocs/cloud-adoption-framework/tree/main/docs/scenarios/oracle-iaas/media/Azure-Landing-Zone-Architecture-Oracle.vsdx) of this architecture.*

## Next step

> [!div class="nextstepaction"]
> [Strategy for Oracle on Azure](oracle-landing-zone-strategy.md)
