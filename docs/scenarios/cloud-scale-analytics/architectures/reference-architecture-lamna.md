---
title: Lamna Healthcare scenario for cloud-scale analytics in Azure
description: Learn about the Lamna Healthcare scenario for cloud-scale analytics in Azure.
author: AnalyticJeremy
ms.author: jepeach
ms.date: 09/21/2021
ms.topic: conceptual
ms.custom: think-tank, e2e-data-management
---

# Lamna Healthcare scenario for cloud-scale analytics in Azure

This reference architecture is written for customers that want to use cloud-scale analytics not only for scalability but to secure their data. It demonstrates how access to sensitive data can be controlled and how appropriately desensitized data can be shared with analysts.

## Customer profile

Lamna Healthcare (Lamna) offers patient management services to healthcare providers. They handle highly sensitive patient data throughout the course of their business. Access to the detailed data must be carefully restricted. However, Lamna would also like to safely use some version of this data to inform its business practices. They need a mechanism to share the data with analysts that doesn't violate patient trust or data protection laws.

## Current situation

Today, Lamna stores all of its data on-premises. The patient data is stored in a traditional database system. However, as their business has grown and the volume of data has increased, the company must migrate their patient applications to the cloud. As part of this transition, they would like to copy the data from the application into a cloud-based analytics platform that will allow their analysts to make better use of the data without putting extra load on the application database.

A critical concern for Lamna is the security of the patient data. As a healthcare company, they're subject to several different data protection laws.

## Architectural solution

Lamna will implement cloud-scale analytics as their solution for a cloud-based analytics platform. They'll rely on multiple landing zones both for increased scalability and for clear separation of sensitive data products.

### Data management landing zone

A critical concept for every cloud-scale analytics implementation is having one data management landing zone. This subscription contains resources that will be shared across all of the landing zones. This includes shared networking components, like a firewall and private DNS zones. It also includes resources for data and cloud governance, such as Azure Policy and Azure Purview.

### Patient data landing zone

In Lamna's organizational chart, the patient management group is part of the operations group. However, given the extreme sensitivity of the data they use, they'll have their own data landing zone in cloud-scale analytics architecture.

This landing zone will host a copy of the detailed patient data and health records from the company's patient management application and related data products. These data products will be loaded into the landing zone by Data applications that will regularly ingest the data into the cloud and land it in Azure Data Lake Storage.

### Operations data landing zone

The operations group at Lamna is responsible for the company's core line of business, namely providing consulting services to healthcare providers. In their operations data landing zone, they store data related to these healthcare providers and the services with which they've engaged.

Like all business data, there's an element of sensitivity to these data products, and Lamna of wants to protect its list of clients. However, since this data doesn't include health information about individuals, it's not subject to the most stringent data protection laws.

#### Data applications

The operations landing zone has a [data application](../../cloud-scale-analytics/architectures/data-application-source-aligned.md) that loads the healthcare provider data from Lamna's on-premises operations system. Like all data applications, this lands the data in the cloud as-is and doesn't apply transformations to the data products.

#### Data products

Analysts throughout Lamna need access to data to build reports for the business. However, much of the data is far too sensitive for a broad audience. To safely provide access to the highly sensitive patient data, the operations team created a **Tokenized patients dataset** product in their landing zone. Using Azure Data Factory, they copy patient data from the patients landing zone. However, the team was careful to remove or tokenize any columns containing personal data. This allows analysts to use the data for business purposes without exposing any personal details of the patients.

### Marketing data landing zone

The marketing group is focused on obtaining new clients and managing Lamna's position within the marketplace. Their marketing landing zone is primarily used to store and analyze external data products about the markets they serve and the healthcare industry.

However, to support a new marketing push, the group wants to conduct a study of health outcomes for the patients served by Lamna's clients. They hope to produce a fact-based report supported by strong statistical evidence showing that their approach to healthcare leads to better outcomes.

To support this new effort, researchers in the marketing group will need to access the highly sensitive patient data in a secure and compliant manner while still being able to obtain the information that they need.

To meet this need, the marketing team creates aggregated data products from the tokenized patients dataset created by the operations team. These data products don't contain individual health records. Instead, they group records across different axes. This helps researchers to conduct studies of the population as a whole without risking access to any individual's health information.

:::image type="content" source="../images/lamna.png" alt-text="Diagram of architecture." lightbox="../images/lamna.png":::

*Figure 1: Diagram of architecture. Not all Azure services are represented in the diagram. It has been simplified to highlight the core concepts of how resources are organized within the architecture.*

## Rationale

### Should all sensitive data always be given its own data landing zone?

No. Only the most restricted data requiring specific protections, like just-in-time access or customer-managed keys, requires its own landing zone. For other scenarios, other data protection features in Azure provide a highly secure environment for your data. This includes row-level security, column-level security, and encrypted columns.

### Deployment templates

To deploy the architectures, use the data management landing zone and the data landing zone reference implementation templates in the following GitHub repositories:

- [Data management landing zone template](https://github.com/Azure/data-management-zone)
- [Data landing zone template](https://github.com/Azure/data-landing-zone)

Use the following templates to deploy other Data applications and data products in the Lamna data landing zones:

|Name  |Data landing zone  |Type  |Template  |
|---------|---------|---------|---------|
|Patients     |Patients         |Data application         |[Data product batch template](https://github.com/Azure/data-product-batch)         |
|Health records     |Patients         |Data application         |[Data product batch template](https://github.com/Azure/data-product-batch)         |
|Providers     |Operations         |Data application         |[Data product batch template](https://github.com/Azure/data-product-batch)         |
|Tokenized patients     |Operations         |Data product         |[Data product batch template](https://github.com/Azure/data-product-batch)         |
|Aggregated patient data     |Marketing         |Data product         |[Data product batch template](https://github.com/Azure/data-product-batch)         |

> [!IMPORTANT]
> Not everything in the reference implementation templates above will need to be deployed to meet the needs of Lamna. Some level of customization will be required for the templates. Services that aren't needed should be removed from the templates prior to deployment.

## Next steps

- Continue to [Deployment templates for cloud-scale analytics](../architectures/deployment-templates.md).
- Learn more in [Understand data privacy for cloud-scale analytics in Azure](../secure-data-privacy.md).
