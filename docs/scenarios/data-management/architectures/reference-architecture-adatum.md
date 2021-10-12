---
title: Adatum Corporation scenario for data management and analytics in Azure
description: Learn about the Adatum Corporation scenario for data management and analytics in Azure.
author: AnalyticJeremy
ms.author: jepeach
ms.date: 09/21/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.custom: think-tank, e2e-data
---

# Adatum Corporation scenario for data management and analytics in Azure

The Cloud Adoption Framework for data management and analytics is modular by design and allows organizations to start with foundational landing zones that support their data and analytics workloads, regardless of whether the projects are being migrated or are newly developed and deployed to Azure. The architecture enables organizations to start as small as needed and scale alongside their business requirements regardless of scale point.

## Customer profile

This reference architecture is ideal for customers that have identified a unit of their business that's ready to deploy analytics workloads to Azure. This architecture deploys a single landing zone that can be used by the business unit to manage their data estate. It provides the flexibility to add more landing zones for other business units when they're ready to move to Azure.

Adatum Corporation (Adatum) is a large, international enterprise. In addition to the centralized business units at their headquarters, they also have subsidiaries around the globe that have their own business units, including accounting, marketing, sales, support, and operations.

All of these disparate groups are producing their own data. Many of the business units have embedded analytics teams. The central IT organization has provided most of the data platform that's in use, but a few business units have gone rogue and implemented their own solutions. The data platform is comprised of various cloud services and on-premises solutions.

The company's vision is to have a centralized analytics platform, a single source of truth for all data. However, it has become challenging for many different stakeholders to buy into one single technology. Given the rate at which new data is being created and new options become available, even early drafts of plans for centralization quickly become outdated. Meanwhile, the corporate sales team has outgrown their current solution, and the company urgently needs to use new analytics to pursue a new market segment.

Adatum has decided to implement the Cloud Adoption Framework for data management and analytics pattern in Azure to solve this problem. The enterprise is confident that the enterprise-scale analytics pattern will allow the corporate sales team to migrate their data platform today but still provide enough flexibility to accommodate other business units when they are ready to join.

### Current situation

The Adatum corporate sales group uses traditional ERP and CRM systems to process its sales transactions. Data from these systems needs to be exported to a separate analytics platform so that stakeholders across the organization can access the data and enrich it for their various projects.

## Architectural solution

In this reference architecture, we will deploy a data management zone, which is needed for all ESA implementations, and a single data landing zone, which can be used by the corporate sales department.

### Data management zone

A critical concept for every enterprise-scale for analytics and AI implementation is having one data management zone. This subscription contains resources that will be shared across all of the landing zones. This includes shared networking components like a firewall and private DNS zones. It also includes resources for data and cloud governance, such as Azure Policy and Azure Purview.

### Data integrations

The landing zone will have two data integrations. The first integration will ingest data related to customers. This includes the customer records and their related records (like addresses, contacts, territory assignments, and contact history). This data will be imported from the Adatum CRM system.

The second data integration will ingest sales transactions. This includes transaction headers, line item details, shipping records, and payments. All of these records will be ingested from the Adatum ERP system.

These integrations won't transform or enrich the data. They only copy the data from the source systems and land it in the analytics platform. This allows many data products to consume the data in a scalable manner without putting another burden on the source system.

### Data products

In this example, Adatum has one data product. This product combines raw data from the two data integrations and transforms them into a new dataset. From there, it can be picked up by business users for extra analysis and reporting with tools like Microsoft Power BI.

:::image type="content" source="../images/adatum.png" alt-text="Diagram of architecture." lightbox="../images/adatum.png":::

*Figure 1: Diagram of architecture. Not all Azure services are represented in the diagram above. It has been simplified to highlight the core concepts of how resources are organized within the architecture.*

## Rationale

### Why not put sales transactions and customers in their own data landing zones?

One of the first decisions enterprises must make about their enterprise-scale for analytics and AI implementation is how to divide the entire data estate into landing zones. Data solutions that will frequently communicate with one another are strong candidates for inclusion in the same landing zone. This allows enterprises to reduce the costs associated with moving data across peered VNets. In this example, sales transaction data will frequently be linked to customer data. Therefore, it makes sense to store these related data integrations in the same data landing zone.

An extra consideration for landing zones is how the teams responsible for the data are aligned within the organization. In this case, the two data integrations are owned by different teams, but those teams are both part of the sales and marketing division at Adatum.

### Why not let sales transactions and customers share one data integration?

By separating the customer data and the sales transaction data in their own data integrations, we allow the subject matter experts for those domains to make the best decisions for their particular datasets. They can choose the access patterns, ingestion engines, and storage options that best meet their needs without conflicting with one another.

For example, the team that has expertise with the CRM system will be responsible for the customer data integration. Based on the team's skill set and the technologies used by the CRM system, they'll decide which tools best suit their needs. They won't have to worry if these decisions will also work for the sales transactions team. That team will be using their own toolset and won't have to compromise to meet the requirements of the customers team.

### Why move the sales team to the new data platform?

In this example, the corporate sales team is the first to move to the new enterprise-scale for analytics and AI platform. The solution is designed to be scalable above all else. As other business units are ready to migrate, more landing zones can be added to accommodate their workloads.

## How to evolve in the future

Scaling is accomplished by adding more landing zones to the architecture. These landing zones will use VNet peering to connect to the data management zone and all of the other landing zones. This mesh pattern allows datasets and resources to be shared across zones. By splitting into different zones, the workloads are spread across Azure subscriptions and resources. This allows enterprises to avoid reaching the limits of the Azure services and continue to grow their data estates.

## Deployment guidelines

The customer scenario outlined above can be deployed by referencing the following architectures the Adatum data management landing zone and data landing zone:

### Data management landing zone deployment

:::image type="content" source="../images/adatum-data-management-landing-zone.png" alt-text="Adatum data management landing zone." lightbox="../images/adatum-data-management-landing-zone.png":::

### Sales data landing zone deployment

:::image type="content" source="../images/adatum-sales-data-landing-zone.png" alt-text="Adatum sales data landing zone." lightbox="../images/adatum-sales-data-landing-zone.png":::

### Deployment templates deployment

To deploy the architecture baselines above, use the data management landing zone and the data landing zone reference implementation templates in the following GitHub repositories:

- [Data management landing zone template](https://github.com/Azure/data-management-zone)
- [Data landing zone template](https://github.com/Azure/data-landing-zone)

Use the following template to deploy sales transactions, customer data integrations, and **Summary** data products in the Adatum sales data landing zones:

- [Data product batch template](https://github.com/Azure/data-product-batch)

> [!IMPORTANT]
> Not every template listed above will need to be deployed to meet the needs of Adatum. Some customization will be required for the templates. Services that aren't needed should be removed from the templates prior to deployment.

## Next steps

Continue to the [Relecloud scenario for data management and analytics in Azure](./reference-architecture-relecloud.md).

Learn more in:

- [Overview of the enterprise-scale for analytics and AI architecture data landing zone in Azure](./data-landing-zone.md)
- [Enterprise-scale for analytics and AI data integrations in Azure](./data-landing-zone-data-integration.md)
- [Overview of the enterprise-scale for analytics and AI data management landing zone in Azure](./data-management-landing-zone.md)
- [Enterprise-scale for analytics and AI data products in Azure](./data-landing-zone-data-products.md)
