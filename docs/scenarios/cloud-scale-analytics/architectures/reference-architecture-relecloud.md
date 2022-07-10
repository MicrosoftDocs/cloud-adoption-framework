---
title: Relecloud scenario for cloud-scale analytics in Azure
description: Learn about the Relecloud scenario for cloud-scale analytics in Azure.
author: AnalyticJeremy
ms.author: jepeach
ms.date: 02/28/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-data-management
---

# Relecloud scenario for cloud-scale analytics in Azure

This reference architecture can help customers who have already implemented a basic version of cloud-scale analytics and are now ready to host a new business unit that modernizes its analytics operations. It demonstrates a more complex scenario with multiple landing zones, data applications, and data products.

## Customer profile

Relecloud is a private cloud provider offering shared computing and storage resources to companies around the globe. Data analysts in the operations group use telemetry data from cloud services to understand how their customers are using the platform. A separate team of analysts in the billing group studies invoicing data to gain insights about which services generate the most revenue.

## Current situation

Although Relecloud provides compute resources of their own, they don't want to constrain their platform with their own internal operations. Therefore, they rely on Microsoft Azure for their internal computing needs. Last quarter, as the operations team was pursuing new analytics projects, the team modernized its analytics platform by migrating it to Azure. They chose to implement cloud-scale analytics to maximize the potential for scaling the platform and adding new workloads from the organization.

Today, the billing group has outgrown its current analytics solution. The volume of invoices they must analyze has become too large for their on-premises server. They've decided to follow the lead of the operations group and modernize their platform in Azure.

However, analysts in the billing group have different skills than the analysts in the operations group. The billing analysts don't want to be constrained to use the same tools chosen by operations. The billing group is also in a different part of the organization, and they want the flexibility to implement the policies and procedures that meet their needs.

## Architectural solution

Relecloud will scale their analytics platform by adding a new landing zone for the billing group. This will provide a virtual workspace for the billing group to implement the analytics solutions that will meet their business needs. By having the landing zone separate from the organization's other resources, the billing group can implement its own access policies and account for the costs of its services.

### Data management landing zone

A key concept for every cloud-scale analytics implementation is having one data management landing zone. This subscription contains resources that will be shared across all landing zones. This includes shared networking components like a firewall or private DNS zones. It also includes resources for data and cloud governance like Azure Policy and Azure Purview.

Relecloud created a data management landing zone when the solution was deployed for the operations group. When the billing group joins the platform, they'll use the same data management landing zone. This will allow them to share common resources with the operations group.

### Operations data landing zone

The operations group has been building solutions in its data landing zone for a few months.

#### Operations data applications

The team has built a [source-aligned data application](../../cloud-scale-analytics/architectures/data-application-source-aligned.md) that uses Apache Spark jobs running in Azure Databricks to ingest service telemetry data and land it in an Azure Data Lake Storage account. This process copies the data as-is from the source system but doesn't transform it. By storing a copy in the analytics platform, analysts can work with the data without overloading the source system. Instead of creating a dedicated deployment for this data application, the operations team used the Databricks workspace in the shared **Ingest & Processing** resource group.

Relecloud customers can create cloud accounts to manage resources and billing in their private clouds. Each customer can have multiple accounts. The analytics team built a data application to bring in the cloud account data. Because the volume and frequency of data is much lower than the telemetry data, they don't need to use Spark jobs to handle this data. Instead, they created pipelines in Azure Data Factory to copy the data.

#### Operations data products

Relecloud analysts obtain value from the data in source-aligned data applications by creating new data applications that are consumer-aligned. One of these consumer-aligned data applications is a **Cloud service recommender** model. Relecloud data scientists used Azure Machine Learning to build a model that looks at the services consumed in a cloud account and suggests related services that could be useful. This model is deployed to an Azure Kubernetes Service (AKS) cluster running in the landing zone and managed by Azure Machine Learning. Applications running outside of cloud-scale analytics can call the AKS endpoint to get recommendations.

After the billing team creates their landing zone, the operations team will be able to create a new data product that the operations management team has requested. They want to know how much revenue is generated by the **Cloud service recommender** data application. The new **Recommender revenue** data product will use Azure Synapse Analytics to combine data from **Cloud service recommender** and **Revenue by service** into a new data product. Business analysts can connect to Azure Synapse with Microsoft Power BI to find and report insights from this new data product.

### Billing data landing zone

The billing group has been using an on-premises system to power its analytics. However, as the volume of data has grown and the business' reliance on their work has increased, their current system hasn't been able to keep pace. The group has decided to modernize their platform by moving to the cloud.

As discussed above, the billing group won't share a landing zone with the operations group. Instead, they'll be given their own landing zone in which they'll have the freedom to build the platform that best suits their needs.

The new landing zone will be connected to the data management landing zone and all other data landing zones with virtual network peering. This will enable data to be shared securely through the Azure internal network.

#### Billing data applications

To land data from existing systems into the analytics platform, the billing group will build two data applications. The first will ingest the customer data. This includes the full list of customers and all related data, including customer addresses, locations, and salesperson assignments. The second application will import the company's invoice history, which includes all billing charges to customers and the related payment data.

Both of these applications will be powered by pipelines in a shared Azure Synapse workspace. Each application will have a dedicated compute pool to facilitate cost accounting and security boundaries. Since the applications can be fully implemented with shared resources, the billing group doesn't have to create a deployment for these data applications.

#### Billing data products

The billing analysts will create a new data product called **Revenue by service** that will analyze how much each cloud service generates for Relecloud. This product will rely on the data in the **Invoices** ingestion. It will also connect across to the operations landing zone and read the service usage data.

Like with data applications, the data product will also rely on a shared Azure Synapse workspace.

:::image type="content" source="../images/relecloud.png" alt-text="Diagram of architecture." lightbox="../images/relecloud.png":::

*Figure 1: Diagram of architecture. Not all Azure services are represented in the diagram. It has been simplified to highlight the core concepts of how resources are organized within the architecture.*

### Deployment templates

To deploy the architectures, use the data management landing zone and the data landing zone reference implementation templates in the following GitHub repositories:

- [Data management landing zone template](https://github.com/Azure/data-management-zone)
- [Data landing zone template](https://github.com/Azure/data-landing-zone)

Use the following templates to deploy other data applications and data products in the Relecloud billing and operations data landing zones:

|Name  |Data landing zone  |Type  |Template  |
|---------|---------|---------|---------|
|Cloud accounts     |Operations         |Data application         |[Data product batch template](https://github.com/Azure/data-product-batch)         |
|Recommender revenue     |Operations         |Data product         |[Data product batch template](https://github.com/Azure/data-product-batch)         |
|Cloud service recommender     |Operations         |Data application         |[Data product analytics template](https://github.com/Azure/data-product-analytics)         |
|Revenue by service     |Billing         |Data product         |[Data product batch template](https://github.com/Azure/data-product-batch)         |

> [!IMPORTANT]
> Not everything in the reference implementation templates above will need to be deployed to meet the needs of Relecloud. Some level of customization will be required for the templates. Services that aren't needed should be removed from the templates prior to deployment.

## Next steps

Continue to the [Lamna Healthcare scenario for cloud-scale analytics in Azure](./reference-architecture-lamna.md).

Learn more in:

- [Azure Machine Learning as a data product for cloud-scale analytics](../best-practices/azure-machine-learning.md)
- [Use Azure Synapse Analytics with cloud-scale analytics](../best-practices/azure-synapse-analytics-implementation.md)
