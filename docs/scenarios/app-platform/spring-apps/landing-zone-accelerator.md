---
title: Azure Spring apps landing zone accelerator
description: Learn about the Azure Spring apps landing zone accelerator set, which is an open source collection of Terraform templates.
author: pagewriter-msft
ms.author: prwilk
ms.date: 03/01/2023
ms.topic: conceptual
ms.service: caf
ms.subservice: caf-scenario-spring-apps
---

# Azure Spring apps landing zone accelerator

Azure Spring apps landing zone accelerator is intended for an application team that's building and deploying Spring Boot applications in a typical enterprise landing zone design. As the workload owner, use architectural guidance provided in this accelerator to achieve your target technical state with confidence.  

## What's included in the accelerator

The landing zone accelerator is a set of design considerations and reference architecture that's backed by an implementation.

- **Design areas** cover considerations and recommendations for common technical areas that integrate with the centralized services.

  - [Identity and access management](./identity-and-access-management.md)
  - [Network topology and connectivity](./network-topology-and-connectivity.md)
  - [Security](./security.md)
  - [Monitoring operations](./management.md)

- **Reference architecture** provides design guidance that applies the recommendations to an example Spring app. The practical approach is used as design guidance for greenfield implementation and as an assessment for brownfield customers that already use Spring Boot apps.

    For more information about this architecture, see [Azure Spring apps landing zone accelerator.](https://github.com/Azure/springapps-landing-zone-accelerator#azure-spring-apps-landing-zone-accelerator).

    [![Diagram that shows Azure App Service landing zone accelerator architecture.](./media/spring-apps-reference-architecture-landing-zone.png)](./media/spring-apps-reference-architecture-landing-zone.png#lightbox)

- **Reference implementation** accompanies the architecture and demonstrates the best practices. It provides infrastructure as code (IaC) templates for a sample Spring app.

For more information, see [Azure Spring apps reference implementation](https://github.com/Azure/springapps-landing-zone-accelerator).

## Integration with platform landing zones

The accelerator assumes that the enterprise (platform) landing zones are based on [Azure landing zone](../../../ready/landing-zone/index.md) guidance. The platform landing zones have shared services that centralized teams manage. You can focus your efforts on application development and workload resources.

It's highly recommended that you have a good understanding of the **integration points between the shared resources and workload resources**. If the platform requires changes, work with the centralized team to get the changes implemented with a **shared responsibility mindset**. For example, communicate the expected potential of the workload early so that the central networking team can allocate a virtual network with address space that's large enough to accommodate that growth.

## Next steps

Review the critical design areas to make complete considerations and recommendations for your architecture.

[Identity and access management](./identity-and-access-management.md)


