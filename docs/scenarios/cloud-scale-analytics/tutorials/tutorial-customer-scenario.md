---
title: Customer scenario tutorial
description: This customer scenario shows how Azure cloud-scale analytics provides a scalable, repeatable framework that meets an organization's unique needs for building modern data platforms.
author: andrehass
ms.author: anhass
ms.date: 07/14/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Customer scenario

Adatum Corporation is a large, multinational enterprise. In addition to the centralized business units at their headquarters, they also have subsidiaries across the globe. And each subsidiary has its own business units, such as accounting, marketing, sales, support, and operations.

All of these disparate groups produce their own data. Many of the business units have embedded analytics teams. The central IT organization provided most of the data platform that's in use, but a few business units have gone rogue and implemented their own solutions. The data platform is made up of various cloud services and on-premises solutions.

The company's vision is to have a centralized analytics platform, a single source of truth for all data. But it's proven impossible to get so many different stakeholders to buy into one single technology. Given the rate at which new data is being created and new options become available, even early drafts of plans for centralization quickly become out-dated. Meanwhile, the corporate sales team has out-grown their current solution, and the company urgently needs new analytics to pursue a new market segment.

Adatum has decided to implement the Azure cloud-scale analytics architecture pattern to solve this problem. The enterprise is confident that the Azure cloud-scale analytics pattern will support the corporate sales team in migrating their data platform today. And the pattern also provides enough flexibility to accommodate other business units when they're ready to join the data mesh.

## Current situation

Adatum's corporate sales group uses traditional enterprise resource planning (ERP) and customer relationship management (CRM) systems to process its sales transactions. Data from these systems must be exported to a separate analytics platform so that stakeholders across the organization can access the data and enrich it for their various projects.

## Architectural solution

In this reference architecture, you deploy a data management landing zone that's required for all Azure cloud-scale analytics implementations. And you set up a single data landing zone that's used by the corporate sales department.

### Data management landing zone

A critical aspect of every Azure cloud-scale analytics implementation is the single data management landing zone. This subscription contains resources that are shared across all of the landing zones. The resources include shared networking components, like a firewall and private domain name system (DNS) zones. And it also includes resources for data and cloud governance, such as Azure Policies and Microsoft Purview.

### Data integrations

The landing zone has a single shared data integration for the ingestion of two data sources. The first data is related to customers. Customer data includes the customer records and their related records (like addresses, contacts, territory assignments, and contact history). This data is imported from Adatum's CRM system.

The second data ingestion is for sales transactions. This data includes transaction headers, line item details, shipping records, and payments. All of these records are ingested from Adatum's ERP system.

> [!NOTE]
> This shared integration doesn't transform or enrich the data. It only copies the data from the source systems and lands it in the analytics platform. This process lets many data products consume the data in a scalable manner without putting an additional burden on the source system.

### Data products

In this example, Adatum has one data product. This product combines raw data from the shared data integration and transforms it into a new dataset. From there, the data can be picked up by business users for more analysis and reporting with tools like Microsoft Power BI.

:::image type="content" source="../images/adatum-revised.png" alt-text="Diagram showing the Adatum Corporation data management landing zone.":::

*Figure 1: Architectural diagram* Not all Azure services are represented in this diagram. The diagram was simplified to highlight core concepts for how resources are organized within the architecture.

## Rationale

The following section describes the rationale for key decisions that enterprises make in their Azure cloud-scale analytics implementation.

### Why not put sales transactions and customers in their own data landing zones?

One of the first decisions to make about your Azure cloud-scale analytics implementation is how to divide the entire data estate into landing zones. Data solutions that frequently communicate with one another are strong candidates for inclusion in the same landing zone. Grouping data solutions helps enterprises reduce the costs associated with moving data across peered virtual networks. In this example, sales transaction data is frequently linked to customer data. So, it makes sense to store these related data integrations in the same data landing zone.

Another consideration for landing zones is how the teams responsible for the data are aligned within the organization.  

### Why move only the sales team to the new data platform?

In this example, the corporate sales team is the first to move to the new cloud-scale analytics platform. The solution is designed to be scalable above all else. As other business units are ready to migrate, you can add more landing zones to accommodate their workloads.

## How to evolve later

You can scale by adding more landing zones to the architecture over time. These landing zones use virtual network peering to connect to the data management landing zone and all the other landing zones. This mesh pattern supports sharing datasets and resources across zones. When you split datasets into different zones, workloads are spread across Azure subscriptions and resources. Enterprises can then avoid reaching the limits of the Azure services and continue to grow their data estates.

## Deployment guidelines

You can deploy the customer scenario outlined previously by referencing the following architectures for Adatum Corporation's data management landing zone and sales data landing zone.

### Deploy the data management landing zone

:::image type="content" source="../images/adatum-data-management-landing-zone.png" alt-text="Diagram of the Adatum Corporation data management landing zone." lightbox="../images/adatum-data-management-landing-zone.png":::

### Deploy the sales data landing zone

:::image type="content" source="../images/adatum-sales-data-landing-zone.png" alt-text="Diagram of the Adatum Corporation sales data landing zone." lightbox="../images/adatum-sales-data-landing-zone.png":::
