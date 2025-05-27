---
title: Multiple data zones for cloud-scale analytics in Azure
description: See how Relecloud, a fictional cloud provider company, implements multiple landing zones for cloud-scale analytics in Azure.
author: mboswell
ms.author: mboswell
ms.date: 11/28/2024
ms.topic: conceptual
ms.custom: think-tank, e2e-data-management
---

# Multiple data zones for cloud-scale analytics in Azure

This reference architecture is for organizations that have implemented a basic version of cloud-scale analytics and are now ready to host new business units to help modernize their analytics operations. This more complex scenario uses multiple landing zones, data applications, and data products.

*Apache Hive and the Hive logo are either registered trademarks or trademarks of the Apache Software Foundation in the United States and/or other countries. No endorsement by The Apache Software Foundation is implied by the use of these marks.*

## Problem statement

Relecloud, the fictional company in this example, is a private cloud provider that offers shared computing and storage resources to global organizations. Although Relecloud provides compute resources, they don't want to constrain their platform with their own internal operations. Therefore, they rely on Microsoft Azure for their internal computing needs.

Data analysts in the operations group use telemetry data from cloud services to understand how their customers use the platform. A separate team of analysts in the billing group studies invoicing data to gain insights about which services generate the most revenue.

Last quarter, the operations team modernized its analytics platform by migrating it to Azure. One goal in implementing cloud-scale analytics was to maximize the potential for scaling the platform and adding new organizational workloads.

Today, the billing group has outgrown its current analytics solution. The volume of invoices to analyze is too large for their on-premises server. The team decides to follow the lead of the operations group and modernize their data analytics platform in Azure.

Analysts in the billing group have different skills than analysts in the operations group. The billing analysts don't want to be constrained to use the same tools as operations. The billing group is in a different part of the organization and wants the flexibility to implement the policies and procedures that meet their needs.

## Architectural solution

Relecloud scales their analytics platform by adding a new landing zone for the billing group. This landing zone provides a virtual workspace for the billing group to implement the analytics solutions that meet their business needs. By having a landing zone separate from the organization's other resources, the billing group can implement their own access policies and account for the costs of their services.

The following diagram doesn't represent all Azure services. The diagram is simplified to highlight the core concepts of organizing resources within the architecture.

:::image type="content" source="../images/multizone.png" alt-text="Diagram of a multiple landing zone architecture for cloud-scale analytics." lightbox="../images/multizone.png":::

### Data management landing zone

A key requirement for a cloud-scale analytics implementation is a data management landing zone. This subscription contains resources that are shared across all landing zones, including shared networking components like a firewall or private DNS zones. It also includes resources for data and cloud governance. Microsoft Purview and Databricks Unity Catalog have been deployed as services at the tenant level.

Relecloud created a data management landing zone when they deployed the data analytics solution for the operations group. When the billing group joins the platform, they use the same data management landing zone to share common resources with the operations group.

### Operations data landing zone

The operations group has the following solutions in its data landing zone.

#### Operations data applications

The team has built a [source-aligned data application](../../cloud-scale-analytics/architectures/data-application-source-aligned.md) that uses Apache Spark jobs in Azure Databricks to ingest service telemetry data and store it in an Azure Data Lake Storage account.

This process copies the data as-is from the source system but doesn't transform it. Analysts can work with the copied data in the analytics platform without overloading the source system. Instead of creating a dedicated deployment for this data application, the operations team uses the Databricks workspace in the shared **Ingest & Processing** resource group.

Relecloud customers can create cloud accounts to manage resources and billing in their private clouds. Each customer can have multiple accounts. The analytics team built a data application to import the cloud account data. Because the volume and frequency of data are much lower than for telemetry data, the team doesn't need to use Spark jobs. Instead, they created Azure Data Factory pipelines to copy the data.

Azure Database for MySQL acts as the Hive metastore, and Azure SQL Database is the Azure Data Factory metastore.

#### Operations data products

Relecloud analysts get value from the data in the source-aligned data applications by creating new, consumer-aligned data applications. One of these consumer-aligned data applications is a **Cloud service recommender** model. Relecloud data scientists used Azure Machine Learning to build a model that looks at the services a cloud account consumes and suggests related services that could be useful. The team deploys this model to an Azure Kubernetes Service (AKS) cluster running in the landing zone and managed by Azure Machine Learning. Applications that run outside of cloud-scale analytics can call the AKS endpoint to get recommendations.

After the billing team creates their landing zone, the operations team creates a new data product that their management team requests. The management team wants to know how much revenue the **Cloud service recommender** data application generates. The new **Recommender revenue** data product uses Azure Synapse Analytics to combine data from **Cloud service recommender** and **Revenue by service** into a new data product. Business analysts can connect to Azure Synapse with Microsoft Power BI to find and report insights from this new data product.

### Billing data landing zone

The billing group was using an on-premises system to power their analytics, but as the data volume grew and the company relied more on their work, the system couldn't keep pace. The group modernizes their platform by moving to the cloud.

The billing group doesn't share a landing zone with the operations group but gets their own landing zone where they have the freedom to build the platform that best suits their needs. The new landing zone is connected to the data management landing zone and all other data landing zones with virtual network peering. This mechanism enables data to be shared securely through the Azure internal network.

#### Billing data applications

To land data from existing systems into the analytics platform, the billing group builds two data applications. The first application ingests the customer data, including the full list of customers and all related data, such as customer addresses, locations, and salesperson assignments. The second application imports the company's invoice history, which includes all billing charges to customers and the related payment data.

Both of these applications are powered by pipelines in the shared Azure Synapse workspace. Each application has a dedicated compute pool to facilitate cost accounting and security boundaries. Since the applications can be fully implemented with shared resources, the billing group doesn't have to create a deployment for these data applications.

#### Billing data product

The billing analysts create a new data product called **Revenue by service** that analyzes how much revenue each cloud service generates for Relecloud. This product relies on the data in the **Invoices** ingestion. The product also connects to the operations landing zone and reads the service usage data. Like the data applications, the data product also relies on the shared Azure Synapse workspace.

## Next steps

Continue to the [Lamna Healthcare scenario for secure cloud-scale analytics in Azure](./reference-architecture-lamna.md).

For more information, see the following articles:

- [Azure Machine Learning as a data product for cloud-scale analytics](../best-practices/azure-machine-learning.md)
- [Use Azure Synapse Analytics with cloud-scale analytics](../best-practices/azure-synapse-analytics-implementation.md)
