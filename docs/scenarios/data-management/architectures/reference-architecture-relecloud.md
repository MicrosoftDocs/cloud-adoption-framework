---
title: Relecloud scenario for cloud adoption framework for data management and analytics
description: Learn how to implement advanced version of cloud adoption framework for data management and analytics
author: AnalyticJeremy
ms.author: jepeach
ms.date: 09/08/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---


# Relecloud scenario

This reference architecture is relevant to customers that have already implemented a basic version of enterprise-scale for analytics and AI and are now ready to host a new business unit that is modernizing its analytics operations.  It demonstrates a more complex scenario with multiple landing zones, multiple data integrations, and multiple data products.

## Customer profile

**Relecloud** is a private cloud provider offering shared computing and storage resources to companies around the globe.  Data analysts in the operations group use telemetry data from the cloud services to understand how their customers are utilizing the platform.  A separate team of analysts in the billing group studies invoicing data to provide insights on which services generate the most revenue.

## Current situation

Although Relecloud provides compute resources of their own, they do not want to constrain their platform with their own internal operations.  Therefore, they rely on Microsoft Azure for their internal computing needs.  Last quarter, as the operations team was pursuing new analytics projects, the team modernized its analytics platform by migrating it Azure.  They chose to implement enterprise-scale for analytics and AI to maximize the potential for scaling the platform and adding new workloads from across the organization.

Today, the billing group has out grown the capacity of its current analytics solution.  The volume of invoices they must analyze has grown too great for their on-premises server.  They have decided to follow the lead of the operations group and modernize their platform in Azure.

However, analysts in the billing group have a different set of skills than the analysts in the operations group.  The billing analysts do not want to be constrained to use the same tools chosen by their counterparts in operations.  The billing group is also in a different part of the organization, and they want to the flexibility to implement the policies and procedures that meet their needs.

## Architectural solution

Relecloud will scale their analytics platform by adding a new landing zone for the billing group.  This will provide a virtual workspace for the billing group to implement the analytics solutions that will meet their business needs.  By having the landing zone separate from the organization's other resources, the billing group can implement its own access policies and account for the costs of its services.

### Data Management Landing Zone

A critical concept for every enterprise-scale for analytics and AI implementation is having one Data Management Zone. This subscription contains resources that will be shared across all of the landing zones.  This includes shared networking components, like a firewall and private DNS zones.  It also includes resources for data and cloud governance, such as Azure Policies and Azure Purview.

Relecloud created a Data Management Zone when the solution was deployed for the operations group.  When the billing group joins the platform, they will use the same Data Management Zone.  This will allow them to share common resources with the operations group.

### Operations Data Landing Zone

The operations group has been building solutions in its data landing zone for a few months.

#### Operations Data Integrations

The team has built a data integration that uses Apache Spark jobs running in Azure Databricks to ingest service telemetry data and land it in an Azure Data Lake Storage account.  This process copies the data as-is from the source system but and does not transform it.  By storing a copy in the analytics platform, analysts can work with the data without putting extra load on the source system. Instead of creating a dedicated deployment for this data integration, the operations team used the Databricks workspace in the shared "Ingest & Processing" resource group.

Relecloud's customers can create "Cloud Accounts" to manage the resources and billing in their private clouds.  Each customer can have multiple accounts. The analytics team built a data integration to bring in the cloud account data.  Because the volume and frequency of data is much lower than the telemetry data, they did not need to use Spark jobs to handle this data.  Instead, they created pipelines in Azure Data Factory to copy the data.

#### Operations Data Products

Relecloud's analysts obtain value from the data landed in the data integrations by creating data products.  One of these products is a "Cloud Service Recommender" model.  Using Azure Machine Learning, Relecloud's data scientists built a model that looks at the services consumed in a cloud account and suggests related services that may be useful.  This model is deployed to an Azure Kubernetes Service (AKS) cluster running in the landing zone and managed by Azure Machine Learning.  Applications running outside of the enterprise-scale for analytics and AI platform can call the AKS endpoint to get recommendations.

After the billing team creates their landing zone, the operations team will be able to create a new data product that the operations management team has requested.  They want to know how much revenue is generated by the "Cloud Service Recommender" product.  The new "Recommender Revenue" product will use Azure Synapse to combine data from two other data products ("Cloud Service Recommender" and "Revenue by Service") into a new product.  Business analysts can connect to Azure Synapse with Microsoft Power BI to find and report insights from this new data product.

### Billing Data Landing Zone

For years, the billing group has been using an on-premises system to power its analytics.  However, as the volume of data has grown and the business's reliance on their work has increased, their current system has not been able to keep pace.  The group has decided to modernize their platform by moving to the cloud.

As discussed above, the billing group will not share a landing zone with the operations group.  Instead, they will be given their own landing zone in which they will have the freedom to build the platform that best suits their needs.

The new landing zone will be connected to the Data Management Zone and all other data landing zones with VNet peering.  This will enable data to be shared securely through Azure's internal network.

#### Billing Data Integrations

To land data from existing systems into the analytics platform, the billing group will build two data integrations.  The first will ingest the customer data.  This includes the full list of customers and all of the related data (such as the customer addresses, locations, and salesperson assignments).  The second integration will import Relecloud's invoice history, which includes all of the billing charges to customers and the related payment data.

Both of these integrations will be powered by pipelines in a shared Azure Synapse workspace.  Each integration will have a dedicated compute pool to facilitate cost accounting and security boundaries.  Since the integrations can be fully implemented with shared resources, the billing group does not have to create a deployment for these data integrations.

#### Billing Data Products

The billing analysts will create a new data product called "Revenue by Service" that will analyze how much each cloud service generates for Relecloud.  This product will rely heavily on the data in the "Invoices" ingestion.  It will also connect across to the "Operations" landing zone and read the "Service Usage" data.

Like the data integrations, the data product will also rely on a shared Azure Synapse workspace.

:::image type="content" source="../images/relecloud.png" alt-text="architectural diagram" lightbox="../images/relecloud.png":::

**Figure 1: Architectural Diagram**  Note that not all Azure services are represented in the diagram.  It has been simplified to accentuate the core concepts of how resources are organized within the architecture.</sub>

## Deployment guidelines

The customer scenario outlined above can be deployed by referencing the architectures below for Relecloud's data management landing zone and data landing zone.

### Data Management Landing Zone Deployment

:::image type="content" source="../images/relecloud-data-management-landing-zone.png" alt-text="Relecloud Corporation Data Management Landing Zone" lightbox="../images/relecloud-data-management-landing-zone.png":::

### Billing Data Landing Zone Deployment

:::image type="content" source="../images/relecloud-billing-data-landing-zone.png" alt-text="Relecloud Corporation Billing Data Landing Zone" lightbox="../images/relecloud-billing-data-landing-zone.png":::

### Operations Data Landing Zone Deployment

:::image type="content" source="../images/relecloud-operations-data-landing-zone.png" alt-text="Relecloud Corporation Operations Data Landing Zone" lightbox="../images/relecloud-operations-data-landing-zone.png":::

### Deployment templates

The **reference implementation** templates for the Data Management Landing Zone and the Data Landing Zone in the following GitHub repositories should be used to deploy the baseline of the above architectures:

- [Data Management Landing Zone template](https://github.com/Azure/data-management-zone)
- [Data Landing Zone template](https://github.com/Azure/data-landing-zone)

Use the following templates to deploy the other data integrations and data products in Relecloud's "Billing" and "Operations" data landing zones:

|Name  |Data Landing Zone  |Type  |Template  |
|---------|---------|---------|---------|
|Cloud Accounts     |Operations         |Data Integration         |[Data Product Batch template](https://github.com/Azure/data-product-batch)         |
|Recommender Revenue     |Operations         |Data Product         |[Data Product Batch template](https://github.com/Azure/data-product-batch)         |
|Cloud Service Recommender     |Operations         |Data Product         |[Data Product Analytics template](https://github.com/Azure/data-product-analytics/blob/main/docs/EnterpriseScaleAnalytics-Prerequisites.md)         |
|Revenue by Product     |Billing         |Data Product         |[Data Product Batch template](https://github.com/Azure/data-product-batch)         |

> [!IMPORTANT]
> Please keep in mind that not everything in the above reference implementation templates will need to be deployed to meet the needs of Relecloud therefore some level of customization of these templates will be required. Hence, those services which are not required should be removed from the deployment templates prior to deployment.

## Next steps

- [Learn more about using Azure Machine Learning as a data product](/azure/cloud-adoption-framework/scenarios/data-management/best-practices/azure-machine-learning)
- [Learn how to power your data strategy with Azure Synapse Analytics](/azure/cloud-adoption-framework/scenarios/data-management/best-practices/synapse)
