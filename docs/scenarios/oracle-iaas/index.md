---
title: Introduction to the Oracle on Azure adoption scenario
description: Learn how to set up and manage Oracle workloads within your Azure landing zone. 
author: jfaurskov
ms.author: janfaurs
ms.date: 04/26/2024
ms.topic: conceptual
ms.custom:
  - think-tank
  - e2e-oracle
  - engagement-fy24
---
# Introduction: Migrate Oracle workloads to Azure

This article describes how to set up and manage Oracle workloads within your Azure landing zone. It also describes specific architectural strategies and provides reference implementations for Oracle database systems on Azure. The guidance assumes that you have an Azure landing zone. For more information, see [What is an Azure landing zone?](/azure/cloud-adoption-framework/ready/landing-zone/implementation-options) and [Landing zone implementation options](/azure/cloud-adoption-framework/ready/landing-zone/implementation-options).

## Define Oracle on Azure

You can lift and shift your Oracle workloads to Azure virtual machines or use Oracle Database@Azure. Oracle Database@Azure provides two principal options for migrating Oracle workloads to Azure:

- **Oracle on Azure Virtual Machines**: Run Oracle databases and enterprise applications, such as Siebel, PeopleSoft, JD Edwards, E-Business Suite, or customized WebLogic Server applications on Azure infrastructure. You can use an Oracle Linux image, Red Hat Enterprise Linux (RHEL), or another endorsed operating system. There are multiple VMs and storage options available.

- **Oracle Database@Azure**: You can use Oracle Database@Azure to run Oracle Exadata infrastructure in Azure. Oracle Exadata is a high-performance database platform. Oracle Database@Azure supports tools, such as Oracle Real Application Clusters (RAC) and Oracle Data Guard. Oracle enterprise applications such as Siebel, PeopleSoft, JD Edwards, E-Business Suite, or customized WebLogic Server applications run on Azure VMs and can connect to Oracle Database@Azure.

For more information, see [Oracle on Azure overview](/azure/oracle/oracle-azure-overview).

## Oracle on Azure architectures

You can use Oracle on Azure to integrate database services for Oracle with Azure cloud capabilities. Apply data analytics and generative AI to your Oracle data. Monitor your apps and Oracle database service with a single view in Azure.

The following diagrams provide a conceptual reference architecture for Oracle on Azure Virtual Machines and Oracle Database@Azure that you can use to accelerate cloud adoption. The diagrams show critical design areas for Azure landing zones. They also present a network layout that demonstrates architectural principles, but they don't detail an entire enterprise network.

Use the reference architectures as a starting point. Modify the reference architectures to fit your specific business and technical requirements when you plan to implement your landing zone.

### Landing zone architecture for Oracle on Azure Virtual Machines

The following diagram shows Oracle on Azure Virtual Machines deployed to an application landing zone. It also shows the critical design areas that support this deployment. The Oracle databases run on VMs. You can change the number and size of VMs to accommodate your needs.

:::image type="content" source="./media/index/reference-architecture-oracle-iaas-landing-zone.png" alt-text="Diagram that shows a reference architecture of Oracle on Azure Virtual Machines.":::

### Landing zone architecture for Oracle Database@Azure

The following diagram shows Oracle Database@Azure deployed to an application landing zone. It also shows the critical design areas that support this deployment. The Oracle databases run on Oracle Exadata VM clusters in Azure. You can change the number and size of VM clusters to accommodate your needs.

:::image type="content" source="./media/index/reference-architecture-oracle-odaa-landing-zone.png" alt-text="Diagram that shows a reference architecture of Oracle Database@Azure.":::

## Next step

> [!div class="nextstepaction"]
> [Strategic impact of Oracle on Azure](oracle-landing-zone-strategy.md)
