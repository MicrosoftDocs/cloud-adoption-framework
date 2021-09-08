---
title: Lamna Healthcare scenario for cloud adoption framework for data management and analytics
description: Learn how to implement highly sensitive version of cloud adoption framework for data management and analytics
author: AnalyticJeremy
ms.author: jepeach
ms.date: 09/08/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---


# Lamna Healthcare scenario

This reference architecture is written for customers that want to use enterprise-scale for analytics and AI not only for scalability but also for security of their data.  It demonstrates how access to sensitive data can be controlled and how appropriately desensitized data can be shared with analysts.

**Lamna Healthcare** offers patient management services to healthcare providers.  Through the normal course of their business, they handle highly sensitive patient data.  Access to the detailed data must be carefully restricted.  However, Lamna would also like to safely use some version of this data to inform its business practices.  They need a mechanism to share the data with analysts that does not violate the patients' trust or data protection laws.

## Current situation

Today, Lamna Healthcare stores all of its data on-premises.  The patient data is stored in a traditional database system.  However, as their business has grown and the volume of data has increased, the company must migrate their patient applications to the cloud.  As part of this transition, they would like to copy the data from the application into a cloud-based analytics platform that will allow their analysts to make better use of the data without putting extra load on the application database.

A critical concern for Lamna is the security of the patient data.  As a healthcare company, they are subject to several different data protection laws.

## Architectural solution

Lamna will implement enterprise-scale for analytics and AI as their solution for a cloud-based analytics platform.  They will rely on multiple landing zones both for increased scalability and for clear separation of sensitive datasets.

### Data Management Zone

A critical concept for every enterprise-scale for analytics and AI implementation is having one Data Management Zone. This subscription contains resources that will be shared across all of the landing zones.  This includes shared networking components, like a firewall and private DNS zones.  It also includes resources for data and cloud governance, such as Azure Policies and Azure Purview.

### Patients Data Landing Zone

In Lamna's organizational chart, the patient management group is part of the operations group.  However, given the extreme sensitivity of the data they use, they will have their own data landing zone in the enterprise-scale for analytics and AI architecture.

This landing zone will host a copy of the detailed patient data and health records from the company's patient management application and related datasets. These datasets will be loaded into the landing zone by data integrations that will regularly ingest the data into the cloud and land it in Azure Data Lake Storage.

### Operations Data Landing Zone

The operations group at Lamna is responsible for the company's core line of business, namely providing consulting services to healthcare providers.  In their "Operations" data landing zone, they store data related to these healthcare providers and the services they have engaged in.

Like all business data, there is an element of sensitivity to these datasets, and Lamna of wants to protect its list of clients.  However, since this data does not include health information about individuals, it is not subject to the most stringent data protection laws.

#### Data Integrations

The "Operations" landing zone has a data integration that loads the healthcare provider data from Lamna's on-premises operations system.  Like all data integrations, this lands the data in the cloud as-is and does not apply transformations to the datasets.

#### Data Products

Analysts throughout Lamna Healthcare need access to data to build reports for the business.  However, much of the data is far too sensitive for a broad audience.  To safely provide access to the highly sensitive patient data, the operations team created a "Tokenized Patients Dataset" product in their landing zone.  Using Azure Data Factory, they copy patient data from the "Patients" landing zone.  However, the team was careful to remove or tokenize any columns containing personally identifiable information (PII).  This allows analysts to use the data for business purposes without exposing any personal details of the patients.

### Marketing Data Landing Zone

The marketing group is focused on obtaining new clients and managing Lamna's position within the marketplace.  Their "Marketing" landing zone is primarily used to store and analyze external datasets about the markets they serve and the healthcare industry.

However, to support a new marketing push, the group wants to conduct a study of health outcomes for the patients served by Lamna's clients.  They hope to produce a fact-based report supported by strong statistical evidence showing that their approach to healthcare leads to better outcomes.

To support this new effort, researchers in the marketing group will need to access the highly sensitive patient data in a secure and compliant manner while still being to obtain the information they require.

To meet this need, the marketing team creates aggregated datasets from the "Tokenized Patients Dataset" created by the operations team.  These datasets do not contain individual health records.  Instead, they group together records along different axes.  This enables researchers to conduct studies of the population as a whole without risking access to any single individual's health information.

:::image type="content" source="../images/lamna.svg" alt-text="architectural diagram" lightbox="../images/lamna.svg":::

**Figure 1: Architectural Diagram**  Note that not all Azure services are represented in the diagram.  It has been simplified to accentuate the core concepts of how resources are organized within the architecture.

## Rationale

### Should all sensitive data always be given its own data landing zone?

No.  Only the most restricted data, requiring specific protections like just-in-time access or customer-managed keys, requires its own landing zone.  For other scenarios, other data protection features in Azure provide a highly secure environment for your data.  This includes row-level security, column-level security, and encrypted columns.

## Deployment guidelines

The customer scenario outlined above can be deployed by referencing the architectures below for Lamna's data management landing zone and data landing zone.

### Data Management Landing Zone Deployment

:::image type="content" source="../images/lamna-data-management-landing-zone.png" alt-text="Lamna Corporation data management landing zone" lightbox="../images/lamna-data-management-landing-zone.png":::

### Patients Data Landing Zone Deployment

:::image type="content" source="../images/lamna-patients-data-landing-zone.png" alt-text="Lamna Corporation Billing Data Landing Zone" lightbox="../images/lamna-patients-data-landing-zone.png":::

### Operations Data Landing Zone Deployment

:::image type="content" source="../images/lamna-operations-data-landing-zone.png" alt-text="Lamna Corporation Operations Data Landing Zone" lightbox="../images/lamna-operations-data-landing-zone.png":::

### Marketing Data Landing Zone Deployment

:::image type="content" source="../images/lamna-marketing-data-landing-zone.png" alt-text="Lamna Corporation Marketing Data Landing Zone" lightbox="../images/lamna-marketing-data-landing-zone.png":::

### Deployment templates

The **reference implementation** templates for the Data Management Landing Zone and the Data Landing Zone in the following GitHub repositories should be used to deploy the baseline of the above architectures:

- [Data Management Landing Zone template](https://github.com/Azure/data-management-zone)
- [Data Landing Zone template](https://github.com/Azure/data-landing-zone)

Use the following templates to deploy the other data integrations and data products in Lamna's data landing zones:

|Name  |Data Landing Zone  |Type  |Template  |
|---------|---------|---------|---------|
|Patients     |Patients         |Data Integration         |[Data Product Batch template](https://github.com/Azure/data-product-batch)         |
|Health Records     |Patients         |Data Integration         |[Data Product Batch template](https://github.com/Azure/data-product-batch)         |
|Providers     |Operations         |Data Integration         |[Data Product Batch template](https://github.com/Azure/data-product-batch)         |
|Tokenized Patients     |Operations         |Data Product         |[Data Product Batch template](https://github.com/Azure/data-product-batch)         |
|Aggregated Patient Data     |Marketing         |Data Product         |[Data Product Batch template](https://github.com/Azure/data-product-batch)         |

> [!IMPORTANT]
> Please keep in mind that not everything in the above reference implementation templates will need to be deployed to meet the needs of Lamna therefore some level of customization of these templates will be required. Hence, those services which are not required should be removed from the deployment templates prior to deployment.

## Next steps

- [Understand data privacy for the data management and analytics scenario in Azure](/azure/cloud-adoption-framework/scenarios/data-management/secure-data-privacy)
