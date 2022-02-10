---
title: Scaling data management and analytics in Azure
description: Learn how to scale data management and analytics in Azure. Decide whether to use a single or multiple data landing zones to design a scalable platform.
author: mboswell
ms.author: mboswell
ms.date: 02/10/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Scaling data management and analytics in Azure

A scalable data platform is critical to accommodate the rapid growth of data. Vast amounts of data are generated every second. The amount of data to deal with is expected to grow exponentially over the next few years. The speed at which new data is generated and the speed at which data moves will increase. Even with more data, users expect that they'll get fast query results. Users expect to wait minutes rather than hours for results.

As a company, you want to enable business units to act on their own. Business units shouldn't rely on a central team to provision the environment, databases, and tools they need.

To extend your analytics platform to include other Azure services on demand, start by provisioning the platform with only the services you require. Extend your platform as you onboard new use cases. This approach allows your company to regulate the platform cost effectively.

When designing your analytics environment, consider regional dependencies and data residency requirements. Are there any local laws or regulations requiring data to stay in a specific location?

A data landing zone is equal to an Azure subscription and allows single or multiple data landing zones deployments. Data landing zones are connected to a data management landing zone for discovery and management of data. A data management landing zone is a single Azure subscription.

Subscriptions are a unit of management, billing, and scale within Azure. Subscriptions play a critical role when you're designing for large-scale Azure adoption.

The majority of deployments will start with a single data landing zone connected to a data management landing zone. The single data landing zone can contain multiple domains and data applications.

There are factors which will drive you towards multiple data landing zones such:

- Multi-region data landing zone deployments
- Requirements for different Azure policies to be applied to a data landing zone
- Subscriptions serve as a scale unit so component workloads can scale within the platform [subscription limits](/azure/azure-resource-manager/management/azure-subscription-service-limits). Make sure you consider subscription resource limits during your workload design sessions.
- Subscriptions provide a management boundary for governance and isolation, which clearly separates concerns.
- Consider that subscription quotas aren't capacity guarantees and are applied on a per-region basis.

Further consideration are documented in the cloud adoption framework guidance for [Subscriptions](../../ready/landing-zone/design-area/resource-org-subscriptions.md).

## Single data landing zone

The following diagram shows an overview of a data management and analytics scenario platform with a data management landing zone and a single data landing zone.

:::image type="content" source="images/high-level-design-single-data-landing-zone.png" alt-text="Diagram of data management landing zone and single data landing zone.":::

> [!NOTE]
> Not all Azure services are represented in the diagram. It has been simplified to highlight the core concepts of how resources are organized within the architecture.

This approach allows you to conform to the principles of data management and analytics scenario. It gives you the option to add data landing zones as needed. This pattern builds out common core services with flexibility to add customizations. If you start with a single data landing zone, plan for expanding into multiple landing zones. Such planning avoids having to migrate data later.

## Multiple data landing zones

This diagram is an overview of a data management and analytics scenario platform with a central data management landing zone and multiple data landing zones:

:::image type="content" source="images/high-level-design-multiple-landing-zones.png" alt-text="Diagram of data management landing zone and multiple data landing zones.":::

> [!NOTE]
> Not all Azure services are represented in the diagram. It has been simplified to highlight the core concepts of how resources are organized within the architecture.

Data management and analytics scenario advocates consistent governance using a common architecture. The architecture defines baseline capabilities and policies. All data landing zones adhere to the same controls and auditing. Teams can create data pipelines, ingest sources, and create data products, such as reports and dashboards. Teams can do Spark/SQL analysis as needed. You can augment data landing zone capabilities by adding services to the capability in the policy. For instance, a team could add a third-party graph engine to address a niche business requirement.

If you have multiple data landing zones, the zones can connect to data lakes hosted in other zones. This approach allows groups to collaborate across the business.

> [!CAUTION]
> We recommend against querying data cross region and instead recommend an approach to make sure that data is close to the compute executing it whilst respecting regional boundaries.

When designing for multiple data landing zones, ensure direct communication between workloads with large amounts of traffic. For large workloads across multiple subscriptions, we recommend peering the virtual networks, see [Network topology and connectivity for data management and analytics landing zones](eslz-network-topology-and-connectivity.md).

Data management and analytics scenario places a strong emphasis on central cataloging and classification to protect data and allow various groups to discover datasets.

## Next steps

[Enterprise enrollment and Azure Active Directory tenants for data management and analytics scenario](./eslz-enterprise-enrollment-and-azure-ad-tenants.md)
