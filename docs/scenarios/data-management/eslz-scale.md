---

title: "Scale 'data management and analytics' in Azure"
description: Scale 'data management and analytics' in Azure
author: esbran
ms.author: espen
ms.date: 06/21/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
---

# Scaling the 'data management and analytics'

A scalable data platform is critical to accommodate the rapid growth of data- traffic, volume and processing capacity. Vast amounts of data are generated every second. With data size expected to grow exponentially over the next years. Not only volume, but the speed at which new data is generated and the speed at which data moves around. In addition to growing data, end users have the expectation that they’ll need to be able to get back query results faster, near real-time. End users are expecting to wait minutes rather than hours for their results. Cloud computing offers hyper scaling. An enterprise application needs to be able to scale.

As an enterprise company you want to enable separate business units the ability to  more self serviced and not rely entirely on a central team to provision the environment, databases and tools you need to build and enable your data workload.  
In order to extend your analytics platform to include other Azure services on demand, the prescribed approach is to provision the platform with only the services you require, with appropriate sizing, and extend it further as new use cases are on-boarded. This approach also allows enterprises to regulate the platform cost effectively.

Design considerations:
When designing your analytics environment consider regional dependencies, are there specific data residency requirements that needs to be taken into account. Are there any local laws or regulations enforcing data to reside in a specific location.

- If your environment is at a starting point, consider [starting with a single Data Landing Zone](#starting-with-a-single-data-landing-zone).

- If your environment is more advanced requiring the ability to scale out using consistent patterns, consider [starting with multiple Data Landing Zones](#starting-with-multiple-data-landing-zones).

## Starting with a single Data Landing Zone

![Enterprise Scale Data Management and Single Data Landing Zone](images/high-level-design-single-data-landing-zone.png)

*Figure 1: Enterprise Scale Data Management with a single Data Landing Zone*

Figure 1 gives an overview of an Enterprise Scale Analytics and AI platform with a central Data Management Landing Zone and a **single** spoke (i.e., the Data Landing Zone). For many environments this approach of deploying a central data management landing zone with a single data landing zone spoke will be the starting point for many. An advantage of starting with this approach is that it allows you to conform to the principles of Enterprise Scale Analytics and AI whilst giving you the option to add additional Data Landing Zones at a later stage as needed. This pattern builds out common core services with flexibility to bolt on specific customizations. If you start with a single Data Landing Zone it is important to plan for expanding into multiple Landing Zones to avoid having to migrate data at a later stage. Once you start importing a data ensure it lands in the correct Data Landing Zone.

## Starting with multiple Data Landing Zones

![Enterprise Scale Data Management and Multiple Data Landing Zones](images/high-level-design-multiple-landing-zones.png)
*Figure 2: Enterprise Scale Data Management with multiple Data Landing Zones*

Figure 2 gives an overview of an Enterprise Scale Analytics and AI platform with a central Data Management Landing Zone and **multiple** spokes (i.e., the [Data Landing Zones](architectures/data-landing-zone.md)).

Enterprise Scale Analytics advocates consistent governance using a common architecture that defines baseline capabilities and policies. Thus, all Data Landing Zones adhere to the same controls and auditing. Teams operating within the Data Landing Zone have the freedom to create data pipelines, ingest sources, create data products (such as reports and dashboards), and perform *ad hoc* Spark/SQL analysis. Furthermore, Data Landing Zone capabilities can be augmented by adding services on top of the baseline capability set out in the policy. For instance, a team could add a third-party graph engine to address some niche business requirement.

If you have multiple Data Landing Zones, these can connect to data lakes hosted in other zones, allowing groups to collaborate across the enterprise (subject to SSO access controls).When designing for an environment consisting of multiple Data Landing Zones ensure a direct line of communication between workloads with large amounts of traffic. When having workloads across multiple subscriptions that requires a high throughput or low latency we recommend to peer the vnets for the relevant workloads.  

The construction set places a strong emphasis on central cataloging and classification to protect data and allow various groups to discover datasets.