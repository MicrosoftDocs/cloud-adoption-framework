---
# This basic template provides core metadata fields for Markdown articles on docs.microsoft.com.

# Mandatory fields.
title: Enterprise Scale Analytics and AI Data Products
description: Enterprise Scale Analytics and AI Data Products
author: mboswell
ms.author: mboswell # Microsoft employees only
ms.date: 02/10/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---
# Data Products

![Data Products Resource Group](../images/dataproductsrg.png)

Multiple Resource Groups by Data Domain

Data Products are determined to be compute or polyglot persistence that are required on use case by use case. We therefore expect multiple resource groups by data product.

Examples of Data Products are: -

* Functions
* App Service
* Logic Apps
* Azure Analysis Services
* Cognitive Services
* Azure Machine Learning
* Azure SQL DB
* Azure MySQL
* Azure CosmosDB

Azure Policy would drive the default configuration of these services within a Data Landing Zone.

Therefore, we can consider operational analytics as multiple resource groups which Data Product Scrum Team can request from a standard service catalogue. By using Azure Policy, we can configure the security boundary and required feature set.

They would be considered an incremental deployment to the Data Landing Zone.

Data Products should be automatically registered with the Azure Purview to allow scanning of data.

>[!IMPORTANT]
>To drive consistency we recommend configuring an Azure Policy per Data Domain Product

## Creating a Data Product

Figure 1, illustrates how a Data Product is created. It shows how a Data Landing Zone hosts multiple data Domain's and that a Domain logical boundary is driven by data ownership and knowledge. A Data Product is created by ingesting data from Domains either inside the same Data Landing Zone or from across multiple Data Landing Zones subject to approval of the Domain.

![Creating a Data Product](../images/dataproductcrossdlz.png)

Figure 1: Creating a Data Product

## Azure Machine Learning (Optional)

Azure Machine Learning should be considered a data product and can be used to enable the end-to-end data science development activities. Data Product and Science teams will interact with this workspace to explore and pre-process data, iterate through the machine learning model development cycle and operationalize models.

Azure Machine Learning will be the would cover all aspects of the data science lifecycle from datastore and dataset registration to model deployment. It can be used for any kind of machine learning, from classical ML to deep learning, supervised, and unsupervised learning. Whether you prefer to write Python or R code or zero-code/low-code options such as the designer, you can build, train, and track highly accurate machine learning and deep-learning models in an Azure Machine Learning Workspace.

![Sample Data Science workflow](../images/image25.png)

Figure 2: Sample Data Science workflow

For a production grade deployment, it is advised to use three workspaces (cf. Figure 21), one for development, one for testing and making sure that results are reproducible and one for production. Data Scientists should only have access to the dev and maybe to the test environment. Azure Data Factory can be used in the production environment to orchestrate dataflows and trigger registered machine learning pipelines.

 Deploy three Azure Machine Learning workspaces per project and use Azure Data Factory for orchestrating workflows and triggering registered machine learning pipelines.

>[!IMPORTANT]
>Deploy three Azure Machine Learning workspaces per project and use Azure Data Factory for orchestrating workflows and triggering registered machine learning pipelines.\
\
Azure Machine Learning clusters should be used for production grade model training and Azure Kubernetes Service should be used for production grade deployments.

>[!TIP]
>Azure Machine Learning should be used for data science projects since it covers the end-to-end workflow with various sub-services and features and, in addition, allows to fully automate the process.

## Reporting and Visualization

For every Data Landing Zone an empty Visualization Resource Group would be created. Visualization is considered a **data product** and depending on the complexity can be created via self serve or managed by a data product team.

![Visualization Resource Group](../images/visualizationrg.png)

>[!NOTE]
>Licensing costs might mean that is it more economical to deploy 3rd party products such Spotfire and Tableau into the Data Management Subscription and for the products to reach across into the Data Landing Zone to pull data back.

Whilst an initial Reporting and Visualization Resource Group would be deployed for a new Data Landing Zone, Data Products might require their own Reporting and Visualization Resource Group due to security boundary or a requirement to cross charge the Domain for usage. However, it is important to remember that using Azure Active Directory Passthrough authentication from services such as Power BI and Azure Analysis Services often reduces the need for a separated security boundary.

As it stands, Power BI is the strategic visualization tool in Self Services Analytics and Citizen Data Scientists. Our recommendation is to leverage the current well-established processes for data refresh scheduling, security, compliance, and data confidentiality handling.

Aligned to Microsoft investments and roadmap, we recommend when necessary and if possible to leverage Power BI Premium as primary option for specific cases where refresh frequency, performance, users licensing cannot be met by Power BI Pro. Azure Analysis Services is recommended to be used on an exception basis, there are specific use cases where it might be required such as multi-dimensional models, CI/CD advanced requirements, etc.

Therefore, as part of low-level design, we recommend Enterprises consider an approach/internal process that allows access to a "trial" PBI premium capacity by business users who would like to evaluate if it is a good fit for their use cases.

## Log Feedback to Enterprise Scale Analytics v-team

[Log Feedback for this page](https://github.com/Azure/enterprise-scale-analytics/issues/new?title=&body=%0A%0A%5BEnter%20feedback%20here%5D%0A%0A%0A---%0A%23%23%23%23%20Document%20Details%0A%0A%E2%9A%A0%20*Do%20not%20edit%20this%20section.%20It%20is%20required%20for%20Solution%20Engineering%20%E2%9E%9F%20GitHub%20issue%20linking.*%0A%0A*%20Content%3A%2003-datalandingzones%20%E2%9E%9F%2006-dataproducts.md)

>[Previous](05-domains.md)
>[Next](07-dataquality.md)
