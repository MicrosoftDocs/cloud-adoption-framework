---
title: Adatum Corporation scenario for cloud-scale analytics in Azure
description: Learn about the Adatum Corporation scenario for cloud-scale analytics in Azure.
author: mboswell
ms.author: mboswell
ms.date: 11/28/2024
ms.topic: conceptual
ms.custom: think-tank, e2e-data-management
---

# Adatum Corporation scenario for cloud-scale analytics in Azure

Cloud-scale analytics is modular by design and allows organizations to start with foundational landing zones that support their data and analytics workloads, regardless of whether the projects are being migrated or are newly developed and deployed to Azure. The architecture enables organizations to start as small as needed and scale alongside their business requirements regardless of scale point.

## Customer profile

This reference architecture is ideal for customers who identified a unit of their business that's ready to deploy analytics workloads to Azure. This architecture deploys a single landing zone that can be used by the business unit to manage their data estate. It provides the flexibility to add more landing zones for other business units when they're ready to move to Azure.

Adatum Corporation is a large, international enterprise. In addition to the centralized business units at their headquarters, they also have subsidiaries around the globe that have their own business units, including accounting, marketing, sales, support, and operations.

All of these disparate groups are producing their own data. Many of the business units have embedded analytics teams. The central IT organization has provided most of the data platform that's in use, but a few business units have gone rogue and implemented their own solutions. The data platform is composed of various cloud services and on-premises solutions.

The company's vision is to have a centralized analytics platform, a single source of truth for all data. However, it has become challenging for many different stakeholders to buy into one single technology. Given the rate at which new data is being created and new options become available even early drafts of plans for centralization quickly become outdated. Meanwhile, the corporate sales team has outgrown their current solution, and the company urgently needs to use new analytics to pursue a new market segment.

Adatum has decided to implement cloud-scale analytics pattern in Azure to solve this problem. The enterprise is confident that cloud-scale analytics allows the corporate sales team to migrate their data platform today but still provide enough flexibility to accommodate other business units when they're ready to join.

### Current situation

The Adatum corporate sales group uses traditional ERP and CRM systems to process its sales transactions. Data from these systems needs to be exported to a separate analytics platform so that stakeholders across the organization can access the data and enrich it for their various projects.

## Architectural solution

In this reference architecture, we deploy a data management landing zone, which is needed for all ESA implementations, and a single data landing zone, which can be used by the corporate sales department.

### Data management landing zone

A critical concept for every cloud-scale analytics is having one data management landing zone. This subscription contains resources shared across all of the landing zones and includes shared networking components like a firewall and private DNS zones. It also includes resources for data and cloud governance. Microsoft Purview and Databricks Unity Catalog are deployed as services at tenant level.

### Data applications

The landing zone has two [data applications](../../cloud-scale-analytics/architectures/data-application-source-aligned.md). The first integration ingests data related to customers. This step includes the customer records and their related records (like addresses, contacts, territory assignments, and contact history). This data is imported from the Adatum CRM system.

The second data application ingests sales transactions. This includes transaction headers, line item details, shipping records, and payments. All of these records are ingested from the Adatum ERP system.

These integrations won't transform or enrich the data. They only copy the data from the source systems and land it in the analytics platform. This allows many data products to consume the data in a scalable manner without putting another burden on the source system.

### Data products

In this example, Adatum has one data product. This product combines raw data from the two Data applications and transforms them into a new dataset. From there, it can be picked up by business users for extra analysis and reporting with tools like Microsoft Power BI.

:::image type="content" source="../images/adatum.png" alt-text="Diagram of Adatum architecture." lightbox="../images/adatum.png":::

*Figure 1: Diagram of architecture. Not all Azure services are represented in the diagram. It's simplified to highlight the core concepts of how resources are organized within the architecture.*

## Rationale

### Why not put sales transactions and customers in their own data landing zones?

One of the first decisions enterprises must make about their cloud-scale analytics is how to divide the entire data estate into landing zones. Data solutions that frequently communicate with one another are strong candidates for inclusion in the same landing zone. This decision allows enterprises to reduce the costs associated with moving data across peered VNets. In this example, sales transaction data will frequently be linked to customer data. Therefore, it makes sense to store these related Data applications in the same data landing zone.

An extra consideration for landing zones is how the teams responsible for the data are aligned within the organization. In this case, the two Data applications are owned by different teams, but those teams are both part of the sales and marketing division at Adatum.

### Why not let sales transactions and customers share one Data application?

By separating the customer data and the sales transaction data in their own Data applications, we allow the subject matter experts for those domains to make the best decisions for their particular data products. They can choose the access patterns, ingestion engines, and storage options that best meet their needs without conflicting with one another.

For example, the team that has expertise with the CRM system will be responsible for the customer Data application. Based on the team's skill set and the technologies used by the CRM system, they decide which tools best suit their needs. They won't have to worry if these decisions will also work for the sales transactions team. That team is using their own toolset and won't have to compromise to meet the requirements of the customers' team.

### Why move the sales team to the new data platform?

In this example, the corporate sales team is the first to move to the new cloud-scale analytics. The solution is designed to be scalable above all else. As other business units are ready to migrate, more landing zones can be added to accommodate their workloads.

## How to evolve in the future?

Scaling is accomplished by adding more landing zones to the architecture. These landing zones use virtual network peering to connect to the data management landing zone and all of the other landing zones. This mesh pattern allows data products and resources to be shared across zones. By splitting into different zones, the workloads are spread across Azure subscriptions and resources. This step allows enterprises to avoid reaching the limits of the Azure services and continue to grow their data estates.

## Next steps

Continue to the [Relecloud scenario for cloud-scale analytics in Azure](./reference-architecture-relecloud.md).

Learn more in:

- [Overview of the data landing zone](./data-landing-zone.md)
- [Overview of the data management landing zone](./data-management-landing-zone.md)
- [Cloud-scale analytics data products in Azure](./data-landing-zone-data-products.md)
