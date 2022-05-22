---
title: Customer Scenario 
description: Customer scenario
author: andrehass
ms.author: anhass
ms.date: 02/08/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

### Customer Scenario

**Adatum Corporation** is a large, multinational enterprise. In addition to the centralized business units at their headquarters, they also have subsidiaries across the globe, each with its own business units such as accounting, marketing, sales, support, and operations.

All of these disparate groups are producing their own data.  Many of the business units have embedded analytics teams. The central IT organization has provided most of the data platform that is in use, but a few business units have gone rogue and implemented their own solutions.  The data platform is comprised of a variety of cloud services and on-premises solutions.

The company's vision is to have a centralized analytics platform, a single source of truth for all data. However, it has proven impossible to get so many different stakeholders to buy into one single technology. Given the rate at which new data is being created and new options become available, even early drafts of plans for centralization quickly become out-dated. Meanwhile, the corporate sales team has out-grown their current solution, and the company urgently needs new analytics to pursue a new market segment.

Adatum has decided to implement the cloud-scale analytics architecture pattern in Azure to solve this problem.  The enterprise is confident that the cloud-scale analytics pattern will allow the corporate sales team to migrate their data platform today but still provide enough flexibility to accommodate other business units when they are ready to join the data mesh.

### Current situation

Adatum's corporate sales group uses traditional ERP and CRM systems to process its sales transactions.  Data from these systems needs to be exported to a separate analytics platform so that stakeholders across the organization can access the data and enrich it for their various projects.

## Architectural solution

In this reference architecture, we will deploy a Data Management Landing Zone, which is needed for all cloud-scale analytics implementations, and a single Data Landing Zone, which can be used by the corporate sales department.

### Data Management Landing Zone

A critical concept for every cloud-scale analytics implementation is having one Data Management Landing Zone. This subscription contains resources that will be shared across all of the landing zones.  This includes shared networking components, like a firewall and private DNS zones.  It also includes resources for data and cloud governance, such as Azure Policies and Azure Purview.

### Data Integrations

The landing zone will have a single shared data integration for the ingestion of two data sources. The first data will be related to customers, this includes the customer records and their related records (like addresses, contacts, territory assignments, and contact history). This data will be imported from Adatum's CRM system.

The second data ingestion will be for sales transactions. This includes transaction headers, line item details, shipping records, and payments.  All of these records will be ingested from Adatum's ERP system.

Note that this shared integration will not transform or enrich the data.  It will only copy the data from the source systems and land it in the analytics platform.  This allows many data products to consume the data in a scalable manner without putting an additional burden on the source system.

### Data Products

In this example, Adatum has one data product.  This product combines raw data from the shared data integration and transforms them into a new dataset. From there, it can be picked up by business users for additional analysis and reporting with tools like Power BI.

:::image type="content" source="../images/adatum-revised.png" alt-text="Adatum Corporation Data Management Landing Zone":::

<br />
<sub>**Figure 1: Architectural Diagram**  Note that not all Azure services are represented in the diagram.  It has been simplified to accentuate the core concepts of how resources are organized within the architecture.</sub>

## Rationale

### Why not put "Sales Transactions" and "Customers" in their own data landing zones?

One of the first decisions enterprises must make about their cloud-scale analytics implementation is how to divide the entire data estate into landing zones.  Data solutions that will frequently communicate with one another are strong candidates for inclusion in the same landing zone.  This allows enterprises to reduce the costs associated with moving data across peered Vnets.  In this example, sales transaction data will very frequently be linked to customer data.  Therefore, it makes sense to store these related data integrations in the same data landing zone.

An additional consideration for landing zones is how the teams responsible for the data are aligned within the organization.  

### Why move only the sales team to the new data platform?

In this example, the corporate sales team is the first to move to the new cloud-scale analytics platform. The solution is designed to be scalable above all else.  As other business units are ready to migrate, additional landing zones can be added to accommodate their workloads.

## How to evolve later

Scaling is accomplished by adding more landing zones to the architecture.  These landing zones will use VNet peering to connect to the Data Management Landing Zone and all of the other landing zones.  This mesh pattern allows datasets and resources to be shared across zones.  By splitting into different zones, the workloads are spread across Azure subscriptions and resources.  This allows enterprises to avoid reaching the limits of the Azure services and continuing to grow their data estates.

## Deployment guidelines

The customer scenario outlined above can be deployed by referencing the architectures below for Adatum Corporation's Data Management Landing Zone and data landing zone.

### Data Management Landing Zone Diagram

:::image type="content" source="../images/adatum-data-management-landing-zone.png" alt-text="Adatum Corporation Data Management Landing Zone":::

### Sales Data Landing Zone

:::image type="content" source="../images/adatum-sales-data-landing-zone-revised.png" alt-text="Adatum Corporation Sales Data Landing Zone":::
