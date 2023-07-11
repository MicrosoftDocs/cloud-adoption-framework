---
title: Tutorial - Evaluate an enterprise data scenario
description: Learn how to evaluate the data requirements for an example enterprise scenario. Learn how Azure cloud-scale analytics provides a scalable, repeatable framework that meets an organization's unique needs for building a modern data platform.
author: abdale
ms.author: hamoodaleem
ms.date: 07/18/2022
ms.topic: tutorial
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Tutorial: Evaluate an enterprise data scenario

In this tutorial, look at the data needs and challenges of an example enterprise scenario. Learn how Azure cloud-scale analytics provides a scalable, repeatable framework that meets an organization's unique needs for building a modern data platform.

Discover the key components of evaluating an enterprise data scenario:

> [!div class="checklist"]
>
> - Understand the scenario
> - Know the data needs
> - Define the architectural solution
> - Test the solution rationale
> - Plan for future growth
> - Deploy resources

## Understand the scenario

Adatum Corporation is a large, multinational enterprise. Adatum has centralized business units at its headquarters and subsidiaries around the globe.

Each Adatum subsidiary has its own business units, including accounting, marketing, sales, support, and operations. Each of these disparate groups produces its own data. Many of the Adatum business units have embedded analytics teams.

The Adatum central IT organization initially provided the data platform that Adatum and its subsidiaries use. Over time, some business units have implemented their own solutions to meet business needs. Now, the enterprise data platform is a combination of various cloud services and on-premises solutions.

The company's vision is to have a centralized analytics platform. Adatum wants a single source for all corporate data. But the company hasn't been successful in its attempts to get so many different stakeholders to agree to use one, single technology. Given the rate at which new data is created and new options become available, even early drafts of plans for centralization quickly become outdated. Meanwhile, the corporate sales team has outgrown its current solution, and the company urgently needs new analytics to pursue a new market segment.

Adatum has decided to implement the Azure cloud-scale analytics architecture pattern to solve its data problem. The enterprise is confident that the Azure cloud-scale analytics pattern will support the corporate sales team in migrating its data platform. The pattern also provides enough flexibility to accommodate other business units when they're ready to join the data mesh.

## Know the data needs

The Adatum corporate sales group uses traditional enterprise resource planning (ERP) and customer relationship management (CRM) systems to process its sales transactions. Data from these systems must be exported to a separate analytics platform so that stakeholders throughout the organization can access the data and enrich it for their various projects.

## Define the architectural solution

In this reference architecture, first you deploy a data management landing zone that's required for all Azure cloud-scale analytics implementations. Then, you set up a single data landing zone that's used by the corporate sales department.

### Data management landing zone

A critical aspect of each Azure cloud-scale analytics implementation is the single data management landing zone. A data management landing zone contains resources that are shared across all data landing zones in the Azure subscription. The resources include shared networking components, like a firewall and Azure Private DNS zones. It also includes resources for data and cloud governance through Azure Policy and Microsoft Purview.

### Data integration

The data management landing zone ingests two data sources to integrate data into a single, shared source of data.

The first data source is related to customers. Customer data includes customer order records and related customer records, like addresses, contacts, territory assignments, and contact history. This data is imported from the Adatum CRM system.

The second ingested data source contains sales transactions. This data includes transaction headers, line item details, shipping records, and payments. All these records are ingested from the Adatum ERP system.

> [!NOTE]
> Shared data integration doesn't transform or enrich the data. It only copies the data from the source systems and adds it to the analytics platform. Through this process, many data products can consume the data in a scalable manner without putting additional burden on the source system.

### Data products

In this example, Adatum has one data product. The product combines raw data from the shared data integration and transforms it into a new dataset. From there, business users can pick up the data for more analysis and reporting with tools like Microsoft Power BI.

:::image type="content" source="../images/adatum-revised.png" border="false" alt-text="Diagram that shows the Adatum Corporation data management landing zone.":::

Not all Azure services are represented in the preceding figure. The diagram is simplified to highlight core concepts about how resources are organized in the architecture.

## Test the solution rationale

The following sections describe the rationale for key decisions that enterprises make in planning their Azure cloud-scale analytics implementation.

### Why not put sales transactions and customers in their own data landing zones?

One of the first decisions to make about your Azure cloud-scale analytics implementation is how to divide the entire data estate into landing zones. Data solutions that frequently communicate with one another are strong candidates for inclusion in the same landing zone. Grouping data solutions helps enterprises reduce the costs associated with moving data across peered virtual networks. In this example, sales transaction data is frequently linked to customer data. So, it makes sense to store these related data integrations in the same data landing zone.

Another consideration for landing zones is how the teams responsible for the data are aligned within the organization.

### Why move only the sales team to the new data platform?

In this example, the corporate sales team is the first to move to the new cloud-scale analytics platform. The solution priority is to be scalable. As other business units are ready to migrate, you can add more landing zones to accommodate their workloads.

## Plan for future growth

You can scale by adding more landing zones to the architecture over time. These landing zones use virtual network peering to connect to the data management landing zone and all other landing zones. This mesh pattern supports sharing datasets and resources across zones. When you split datasets into different zones, workloads are spread across Azure subscriptions and resources. Enterprises can then avoid reaching the limits of the Azure services and continue to grow their data estates.

## Deploy resources

You can deploy this customer scenario by referencing the following architectures for the Adatum Corporation data management landing zone and sales data landing zone.

### Deploy the data management landing zone

:::image type="content" source="../images/adatum-data-management-landing-zone.png" border="false" alt-text="Diagram of the Adatum Corporation data management landing zone." lightbox="../images/adatum-data-management-landing-zone.png":::

### Deploy the sales data landing zone

:::image type="content" source="../images/adatum-sales-data-landing-zone.png" border="false" alt-text="Diagram of the Adatum Corporation sales data landing zone." lightbox="../images/adatum-sales-data-landing-zone.png":::

## Next steps

> [!div class="nextstepaction"]
> [Create a data landing zone](tutorial-create-data-landing-zone.md)
