---

title: Scale data management and analytics in Azure
description: Learn about data management and analytics in Azure. Decide whether to use a single or multiple Data Landing Zones to design a scalable platform.
author: esbran
ms.author: espen
ms.date: 07/16/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
---

# Scaling data management and analytics

A scalable data platform is critical for your enterprise to accommodate the rapid growth of data. Vast amounts of data are generated every second. The amount of data to deal with is expected to grow exponentially over the next few years. The speed at which new data is generated and the speed at which data moves will increase. Even with more data, users expect that they'll get fast query results. Users expect to wait minutes rather than hours for results.

As an enterprise company, you want to enable business units to act on their own. Business units shouldn't rely on a central team to provision the environment, databases, and tools they need. To extend your analytics platform to include other Azure services on demand, start by provisioning the platform with only the services you require. Extend your platform as you onboard new use cases. This approach allows your enterprise to regulate the platform cost effectively.

When designing your analytics environment, consider regional dependencies and take specific data residency requirements into account. Are there any local laws or regulations requiring data to stay in a specific location?

You can start with single or multiple Data Landing Zones:

- If you're just starting with your environment, consider a [single Data Landing Zone](#starting-with-a-single-data-landing-zone).

- For a more advanced environment that requires the ability to scale out using consistent patterns, consider [multiple Data Landing Zones](#starting-with-multiple-data-landing-zones).

For more information, see [Enterprise Scale Analytics and AI Architecture Data Landing Zone](architectures/data-landing-zone.md).

## Single Data Landing Zone

This figure gives an overview of an Enterprise Scale Analytics and AI platform with a Data Management Landing Zone and a single Data Landing Zone.

![Enterprise Scale Data Management and Single Data Landing Zone](images/high-level-design-single-data-landing-zone.png)

This approach allows you to conform to the principles of Enterprise Scale Analytics and AI. It gives you the option to add Data Landing Zones as needed. This pattern builds out common core services with flexibility to add customizations. If you start with a single Data Landing Zone, plan for expanding into multiple Landing Zones. Such planning avoids having to migrate data later. Once you start importing data, be sure that it is in the correct Data Landing Zone.

## Multiple Data Landing Zones

This figure is an overview of an Enterprise Scale Analytics and AI platform with a central Data Management Landing Zone and multiple Data Landing Zones:

![Enterprise Scale Data Management and Multiple Data Landing Zones](images/high-level-design-multiple-landing-zones.png)

Enterprise Scale Analytics advocates consistent governance using a common architecture. The architecture defines baseline capabilities and policies. All Data Landing Zones adhere to the same controls and auditing. Teams can create data pipelines, ingest sources, and create data products, such as reports and dashboards. Teams can do Spark/SQL analysis as needed. You can augment Data Landing Zone capabilities by adding services to the baseline capability set out in the policy. For instance, a team could add a third-party graph engine to address a niche business requirement.

If you have multiple Data Landing Zones, the zones can connect to data lakes hosted in other zones. This approach allows groups to collaborate across the enterprise.

When designing for multiple Data Landing Zones, ensure direct communication between workloads with large amounts of traffic. For large workloads across multiple subscriptions, we recommend peering the virtual networks.

The construction set places a strong emphasis on central cataloging and classification to protect data and allow various groups to discover datasets.

## Next steps

- [Enterprise enrollment and Azure AD tenants for data management and analytics Enterprise-Scale scenario](eslz-enterprise-enrollment-and-azure-ad-tenants.md)
- [Network topology and connectivity for data management and analytics](eslz-network-topology-and-connectivity)
