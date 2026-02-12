---
title: Introduction to Oracle on Azure Adoption Scenarios
description: Learn how to set up and manage Oracle workloads within your Azure landing zone. See reference implementations for Oracle database systems on Azure.
author: jfaurskov
ms.author: janfaurs
ms.date: 11/04/2024
ms.topic: concept-article
ms.custom: e2e-oracle
---
# Introduction to Oracle on Azure adoption scenarios

This article describes how to set up and manage Oracle workloads within your Azure landing zone. The architectures described incorporate a multi-region design. The article also describes specific architectural strategies and provides reference implementations for Oracle database systems that cross multiple regions on Azure. The guidance assumes that you have an Azure landing zone that's configured to support multi-region deployments. For more information, see [What is an Azure landing zone?](/azure/cloud-adoption-framework/ready/landing-zone/implementation-options) and [Landing zone implementation options](/azure/cloud-adoption-framework/ready/landing-zone/implementation-options).

## Define Oracle on Azure

Oracle on Azure adoption scenarios provide two principal technology platform options:

- **Oracle on Azure Virtual Machines**: Run Oracle databases and enterprise applications, such as Siebel, PeopleSoft, JD Edwards, E-Business Suite, or customized WebLogic Server applications on Azure infrastructure. You can use an Oracle Linux image, Red Hat Enterprise Linux (RHEL), or another endorsed operating system. There are multiple VMs and storage options available.

- **Oracle Database@Azure**: You can use Oracle Database@Azure to run Oracle Exadata infrastructure in Azure. Oracle Exadata is a high-performance database platform. Oracle Database@Azure supports tools, such as Oracle Real Application Clusters (RAC) and Oracle Data Guard. Oracle enterprise applications such as Siebel, PeopleSoft, JD Edwards, E-Business Suite, or customized WebLogic Server applications run on Azure VMs and can connect to Oracle Database@Azure.

  Oracle Database@Azure can be integrated with [Azure Arc-enabled servers](/azure/azure-arc/servers/overview) to extend Azure management capabilities to the Oracle infrastructure. This integration enables unified governance, security monitoring through Microsoft Defender for Cloud, and policy compliance while maintaining existing OCI management operations. For more information, see [Azure Arc connectivity design for Oracle Database@Azure](azure-arc-connectivity-design.md) and [Oracle on Azure overview](/azure/oracle/oracle-azure-overview).

## Oracle on Azure architectures

You can use Oracle on Azure to integrate database services for Oracle with Azure cloud capabilities. Apply data analytics and generative AI to your Oracle data. Monitor your apps and Oracle database service with a single view in Azure.

The following diagrams show reference architectures for Oracle on Azure Virtual Machines and Oracle Database@Azure to accelerate cloud adoption. The diagrams show critical design areas for Azure landing zones and incorporate a multi-region design to enhance availability and disaster recovery. They also present a network layout that demonstrates architectural principles across multiple regions, but they don't detail an entire enterprise network.

Use the multi-region reference architectures as a starting point. Modify them to fit your specific business and technical requirements when you implement your landing zone. A multi-region architecture supports business continuity and disaster recovery while improving resiliency by reducing the impact of localized failures. It aligns with best practices for high availability and scalability.

### Landing zone architecture for Oracle on Azure virtual machines

The following diagram shows Oracle on Azure virtual machines deployed to an application landing zone in a multi-region design. The approach shown distributes your Oracle databases across multiple Azure regions to enhance availability, scalability, and disaster recovery capabilities. The diagram also highlights the critical design areas that support this multi-region deployment. The Oracle databases run on VMs in each region. You can change the number and size of VMs to accommodate your needs.

:::image type="content" source="./media/index/reference-architecture-oracle-infrastructure-landing-zone.svg" alt-text="Diagram that shows a reference architecture of Oracle on Azure Virtual Machines." border="false" lightbox="./media/index/reference-architecture-oracle-infrastructure-landing-zone.svg":::

### Landing zone architecture for Oracle Database@Azure

The following diagram shows Oracle Database@Azure deployed to an application landing zone in a multi-region design. It also shows the critical design areas that support this multi-region deployment. The Oracle databases run on Oracle Exadata VM clusters across multiple regions on Azure. You can change the number and size of VM clusters in each region to accommodate your needs.

:::image type="content" source="./media/index/reference-architecture-oracle-odaa-landing-zone.svg" alt-text="Diagram that shows a reference architecture of Oracle Database@Azure." border="false" lightbox="./media/index/reference-architecture-oracle-odaa-landing-zone.svg":::

## Next step

> [!div class="nextstepaction"]
> [Strategic impact of Oracle on Azure](oracle-landing-zone-strategy.md)
