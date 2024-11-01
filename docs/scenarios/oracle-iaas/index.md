---
title: Introduction to Oracle on Azure adoption scenarios
description: Learn how to set up and manage Oracle workloads within your Azure landing zone. See reference implementations for Oracle database systems on Azure.
author: jfaurskov
ms.author: janfaurs
ms.date: 08/01/2024
ms.topic: conceptual
ms.custom: e2e-oracle
---
# Introduction to Oracle on Azure adoption scenarios

This article describes how to set up and manage Oracle workloads within your Azure landing zone, incorporating a multi-region design. It also describes specific architectural strategies and provides reference implementations for Oracle database systems on Azure across multiple regions. The guidance assumes that you have an Azure landing zone configured to support multi-region deployments. For more information, see [What is an Azure landing zone?](/azure/cloud-adoption-framework/ready/landing-zone/implementation-options) and [Landing zone implementation options](/azure/cloud-adoption-framework/ready/landing-zone/implementation-options).

## Define Oracle on Azure

Oracle on Azure adoption scenarios provide two principal technology platform options:

- **Oracle on Azure Virtual Machines**: Run Oracle databases and enterprise applications, such as Siebel, PeopleSoft, JD Edwards, E-Business Suite, or customized WebLogic Server applications on Azure infrastructure. You can use an Oracle Linux image, Red Hat Enterprise Linux (RHEL), or another endorsed operating system. There are multiple VMs and storage options available.

- **Oracle Database@Azure**: You can use Oracle Database@Azure to run Oracle Exadata infrastructure in Azure. Oracle Exadata is a high-performance database platform. Oracle Database@Azure supports tools, such as Oracle Real Application Clusters (RAC) and Oracle Data Guard. Oracle enterprise applications such as Siebel, PeopleSoft, JD Edwards, E-Business Suite, or customized WebLogic Server applications run on Azure VMs and can connect to Oracle Database@Azure.

For more information, see [Oracle on Azure overview](/azure/oracle/oracle-azure-overview).

## Oracle on Azure architectures

You can use Oracle on Azure to integrate database services for Oracle with Azure cloud capabilities. Apply data analytics and generative AI to your Oracle data. Monitor your apps and Oracle database service with a single view in Azure.

The following diagrams provide a conceptual reference architecture for Oracle on Azure Virtual Machines and Oracle Database@Azure that you can use to accelerate cloud adoption. The diagrams show critical design areas for Azure landing zones and incorporate a multi-region design to enhance availability and disaster recovery. They also present a network layout that demonstrates architectural principles across multiple regions, but they don’t detail an entire enterprise network.

Use the multi-region reference architectures as a starting point. Modify the reference architectures to fit your specific business and technical requirements when you plan to implement your landing zone. Implementing a multi-region architecture ensures business continuity and resilience against regional outages, aligning with best practices for high availability and scalability.

### Landing zone architecture for Oracle on Azure Virtual Machines

The following diagram shows Oracle on Azure Virtual Machines deployed to an application landing zone utilizing a multi-region design. This approach distributes your Oracle databases across multiple Azure regions to enhance availability, scalability, and disaster recovery capabilities. It also highlights the critical design areas that support this multi-region deployment. The Oracle databases run on VMs in each region, and you can change the number and size of VMs to accommodate your needs. 

:::image type="content" source="./media/index/reference-architecture-oracle-infrastructure-landing-zone.svg" alt-text="Diagram that shows a reference architecture of Oracle on Azure Virtual Machines." border="false" lightbox="./media/index/reference-architecture-oracle-infrastructure-landing-zone.svg":::

### Landing zone architecture for Oracle Database@Azure

The following diagram shows Oracle Database@Azure deployed to an application landing zone. It also shows the critical design areas that support this deployment. The Oracle databases run on Oracle Exadata VM clusters in Azure. You can change the number and size of VM clusters to accommodate your needs.

The following diagram shows Oracle Database@Azure deployed to an application landing zone utilizing a multi-region design. It also shows the critical design areas that support this multi-region deployment. The Oracle databases run on Oracle Exadata VM clusters in Azure across multiple regions. You can change the number and size of VM clusters in each region to accommodate your needs.

:::image type="content" source="./media/index/reference-architecture-oracle-odaa-landing-zone.svg" alt-text="Diagram that shows a reference architecture of Oracle Database@Azure." border="false" lightbox="./media/index/reference-architecture-oracle-odaa-landing-zone.svg":::

## Next step

> [!div class="nextstepaction"]
> [Strategic impact of Oracle on Azure](oracle-landing-zone-strategy.md)
