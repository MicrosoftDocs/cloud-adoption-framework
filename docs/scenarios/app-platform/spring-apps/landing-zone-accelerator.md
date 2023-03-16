---
title: Azure Spring Apps landing zone accelerator
description: The Azure Spring Apps landing zone accelerator set is an open-source collection of Terraform templates that you can use to automate the deployment of an environment capable of hosting Azure Spring Apps.
author: pagewriter-msft
ms.author: prwilk
ms.date: 03/01/2023
ms.topic: conceptual
ms.service: caf
ms.subservice: caf-scenario-spring-apps
---

# Azure Spring Apps landing zone accelerator

Azure Spring Apps landing zone accelerator is intended for an **application team** that's **building and deploying Spring Boot applications** in a typical enterprise landing zone design. As the workload owner, use **architectural guidance** provided in this accelerator to achieve your target technical state with confidence.  

## What's included in the accelerator

The landing zone accelerator is a set of design considerations, reference architecture, backed by an implementation.

- **Design areas** cover considerations and recommendations for common technical areas that integrate with the centralized services.

    - [Identity and access management](./identity-and-access-management.md)
    - [Network topology and connectivity](./network-topology-and-connectivity.md)
    - [Security](./security.md)
    - [Monitoring operations](./management.md)



- **Reference architecture** provides design guidance that applies the recommendations for an example spring app. The practical approach can be used as design guidance for greenfield implementation and as an assessment for brownfield customers already using Spring Boot apps.

    [![Diagram that shows Azure App Service landing zone accelerator architecture.](./media/spring-apps-reference-architecture-landing-zone.png)](./media/spring-apps-reference-architecture-landing-zone.png#lightbox)


    For information about this architecture, see [Azure Spring Apps Landing Zone Accelerator](https://github.com/Azure/springapps-landing-zone-accelerator#azure-spring-apps-landing-zone-accelerator).

- **Reference implementation** accompanies the architecture and demonstrates the best practices, provides infrastructure-as-code templates a sample spring app.

    > [!IMPORTANT]
    > ![GitHub logo](../../../_images/icons/github.svg) Refer to the [Azure Spring Apps Reference Implementation](https://github.com/Azure/springapps-landing-zone-accelerator).


## Integration with platform landing zones

The accelerator assumes that the enterprise (platform) landing zones are based on [Azure landing zone](../../../ready/landing-zone/index.md) guidance. The platform landing zones have shared services managed by centralized teams, so that you can focus your efforts on application development and workload resources. 

It's highly recommended that you have a good understanding of the **integration points between the shared resources and workload resources**. If there are changes required in the platform, work with the centralized team to get the changes implemented with a **shared responsibility mindset**. For example, communicate the expected potential of the workload early so that the central networking team can allocate a virtual network with address space that's large enough to accommodate that growth.


## Next step

Review the critical design areas to make complete considerations and recommendations for your architecture. 

> [!div class="nextstepaction"] 
> [Identity and access management](./identity-and-access-management.md)


