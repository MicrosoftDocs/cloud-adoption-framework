---
title: Understand teams and functions for the data management and analytics scenario in Azure
description: Learn about teams and functions for the data management and analytics scenario in Azure.
author: mboswell
ms.author: mboswell
ms.date: 08/06/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank, e2e-data
---

# Understand teams and functions for the data management and analytics scenario in Azure

For the data management and analytics scenario, we recommend by moving teams like ingest, processing, analysis, consumption, and visualization from working in horizontally siloed teams to agile vertical cross domain teams in each tier. Platform teams like data platform operations and platform operations are grouped together in a common platform group.

![Diagram of the data management and analytics scenario teams.](./images/enterprise-scale-analytics-ai-teams.png)

## Platform group

The platform group consists of two teams:

- **Platform ops:** Platform ops is part of the platform group. It operates and owns the cloud platform. This team is responsible for instantiating the data management landing zone and data landing zone scaffolding like networking, peering, core service, and monitoring within the data management and analytics scenario.

They usually help data platform ops to develop IT service management interfaces for personas in the data landing zone at the start of rolling out the data management and analytics scenario. These interfaces tend to be REST API calls to a service to onboard datasets, set security, and add services to data landing zones.

- **Data platform ops:** The data platform ops group is housed within the platform group. Data platform ops provides services such as central monitoring, cataloging, and reusable policies for data landing zones and products. Data platform ops owns the data management landing zone, and the team's other responsibilities are:

### Develop infrastructure

- Develop infrastructure-as-code templates for data landing zone personas; the templates must be updated and maintained over time, and they can cover multiple scenarios.
- Prioritize templates and add new functionalities based on a feedback cycle from other teams.
- Work in an agile framework with the common goal to produce standard infrastructure templates.

### Respond to new data landing zone requests

The data platform ops team must provide the tools and services to support the templates that they've created. IT service management tools like ServiceNow can handle ticket requests approved by the data platform ops team for creating new data landing zones. Once approved, a new landing zone would fork from the base template to create a new DevOps project, and pipelines would deploy templates to a new environment.

### The data platform ops feedback and enhancement loop

Two options are available to enhance the templates:

- Teams in charge of infrastructure template instances would enhance their DevOps templates and deployments. If teams discover issues in the templates, data platform ops can support the teams and merge changes back from their fork into the template.

- Other data landing zone teams should be able to create improvement and backlog tickets that would enhance templates based on how the tickets are prioritized.

### Azure policies for the enterprise-scale for analytics and AI

The enterprise-scale for analytics and AI principles emphasize self-service agility and guardrails to protect data, costs, and patterns. Data platform ops works with platform ops to define quality, and these teams collaborate to implement specific data policies. Data platform ops should follow a review process to update and maintain new features that are added to products.

### Deploy and operate data management landing zones

Data platform ops and platform ops work together to deploy and operate data management landing zones. A data management landing zone provides shared services to data landing zones, making it a central piece of enterprise-scale for analytics and AI.

## Data landing zone ops

Data landing zone ops operates and maintains their data landing zone instance while responding to new data integration and product service requests. They provide many of the same services as data platform ops but are limited to their data landing zone.

They work out of the forked repo that's created when a data landing zone is created. To request policy changes, they have to raise tickets to data platform ops to allow these exceptions.

### Support the data product team to customize products

The data landing zone ops team supports the data product team by using pull requests to submit new product templates to their respective data product repositories.

As the owner of the landing zone, Azure DevOps would route the approval for changes to data landing zone ops:

- If approved, the template changes would be moved to the main branch and deployed to production via continuous integration/continuous development, causing the data product platform/infrastructure to be updated.

- If denied, data landing zone ops would work with the data product team to fix the changes.

### Respond to new data integration and data product requests

Data landing zone ops supports integration ops and data product teams to create new data integration and data products. When integration ops or a data product teams request assistance, an IT service management solution, for example, an automation logic app, orchestrates the approval or deployment of a new data integration or data products repository. Data landing zone ops would be notified of new requests and approve or decline deployments. Once approved, a new DevOps project is created, the main template and artifacts are forked, and a new data integration or data product is deployed.

### Adhere to the Azure Well-Architected Framework

Data landing zone ops is responsible for the data landing zone, and it's recommended for the team to be proficient in the [Azure Well-Architected Framework](/azure/architecture/framework/), which provides guidance on cost optimization, reliability, and security.

### Business as usual

Data landing zone ops is responsible for business tasks that include gathering feedback and enhancement requests. These requests are prioritized and shared with data platform ops on a regular basis. The team monitors the data landing zone for incidents and health events. They will engage other ops teams during severe incidents to mitigate, restore backups, failover, and scale services.

## Integration ops

Integration ops' main task is to ingest data from the source and provide a read data store version in the data landing zone. The only change that they make to the structure is to add conformed data types.

[Data integration and data product deployment process](./eslz-provision-platform.md#data-integration-and-data-product-deployment-process) describes onboarding integration. Jordan is a data manager within integration ops. This team provides access to reusable data assets and must carefully assess access controls, reviews data attributes (compliance), and supports the wider community.

### Triage new dataset requests

IT service management solutions field dataset onboarding requests from the business to integration ops. The team reviews the data catalog for existing assets and source systems and collects metadata such as schema, location, privacy requirements, and ingest patterns to be associated with the source. They use their forked repo to develop ingestion pipelines and deploy to their data integration resource groups. The final part of the business' dataset onboarding process is to register the dataset by:

- Registering it in the data catalog.
- Creating Azure Data Lake folders for the dataset.
- Notifying integration ops and data product teams of the new dataset.

### Update existing datasets

IT service management solutions field dataset update requests from the business to integration ops. The team uses their forked repo to develop ingestion pipelines and deploy to their data integration resource groups. Upon deployment, they update the dataset in the data catalog and notify everyone in integration ops and the data product team of the new data asset.

### Manage access requests to datasets

As previously described in [Understand security provisioning for the data management and analytics scenario in Azure](./security-provisioning.md#grant-access), integration operations is responsible for approving access to datasets.

### Review dataset telemetry

Integration ops can use a data access heatmap to identify traffic and hotspots that can help to identify popular assets. Heatmaps can also help to prioritize support investments and manage storage costs while highlighting data assets wit low traction. Low traction dataset would lead integration ops to contact the owners to evaluate archiving options.

> [!NOTE]
> Some data catalog solutions feature heatmaps as part of their integrated solution. However, it's also possible to do this with other reporting tools like Microsoft Power BI.

### The integration operations feedback and enhancement loop

Feedback portals and other channels (DL, open office hours, and others) provide feedback to integration ops. They work with the business the team to identify major blockers for data options and collaborate with data landing zone ops on process-related issues and data asset owners on data quality issues. This information is entered into the integration ops backlog to enhance pipelines.

## The data product team

The data product team delivers new data products to the business. They source from data integrations' read data stores and transform them into business solutions. Anything that transforms data for use is classified as a **data product**. This team is often a mix of technical specialists and subject matter experts who can help the business to achieve value quickly. Data products can range from simple reports and new data assets to custom setups with data-driven Kubernetes web apps.

### New data products

Product owners and business representatives create requests for new data product when they're needed. The data office assesses the requirements and assembles a new data product team with a range of expertise. The team identifies the data assets required for the data product and requests permission to the data asset. If a new data asset is needed, integration ops receives a ticket to ingest it. The team identifies the services required for the new data product and requests a new data product via the [data integration and data product deployment process](./eslz-provision-platform.md#data-integration-and-data-product-deployment-process). The data product team receives a forked repo from the master data products template to deploy the data product.

### Certify data products

In a self-service platform, anyone can create reports, curate datasets in an Azure Data Lake workspace account, and release data products for the business to use. Data product review requests occur when:

- Business sponsors log tickets to certify data products.
- Data platform ops nominates data products based on popularity.

A data product team can drive a certification process, to be defined data platform ops and digital security, which might include:

- Tests devised to validate data transformations and business logic
- Assessments for: security, compliance, or performance impact

Upon certification, artifacts are collated and uploaded to a data product repository, documentation is published, and the data product team is notified.

### Product support

Users can submit feedback with an IT service management solution or directly within the product as a ticket is routed to the data product owner. This individual triages the request and determines whether to escalate it to the data product team to fix or enter feedback into a product backlog and review during product planning cycles.

## The data science products team

While the data science products team creates data products, it's distinct because their functions lead to data integrations, assets, or products. This results in published models becoming data products for others to use, and the pattern follows a Machine Learning ops model that's associated with the data landing zone.

The data science products team starts by searching and finding relevant datasets for their use case. Data governance solutions can reveal more details like data quality, lineage, or a similar dataset or profile. They research if a sample dataset is available and if the data is relevant to the project. Once data access is granted via a data catalog or an Azure AD access package, the team uses the services in the data landing zone to explore and analyze the data.

Before processing all data, the team uses local or remote compute to process and analyze sample datasets. They can optimize remote compute targets with larger datasets to train and develop machine learning models with runs, outputs, and models that are tracked inside Azure Machine Learning.

When the team has developed machine learning models, they start operationalizing them. For this, they expand the team to include DataOps and machine learning engineers who can assist with moving the models into a new data product, as outlined in a data product team role.

The data science team will continue to work with the associated data product owners to capture feedback, support, and resolved and update models in production using a [machine learning ops methodology](/azure/machine-learning/concept-model-management-and-deployment).

## Analyst

Analysts represent a large group that includes business analysts, power users, and generally anyone in the organization with an interest in optimizing data to create new business insights. Self-service enablement is a key principle that supports analysts to access analytics and data without having to secure formal IT budget and resources.

> [!TIP]
> Enterprises should view insights created by analysts as the next set of potential data products to be certified for others to use within the business.

### Find and request data

Analysts consult data marketplaces/catalogs to discover relevant datasets.

- If the data asset can't be found or doesn't exist, then analysts open a support ticket with integration ops. Integration ops assist with finding the dataset or add the request to their backlog to assess it in another development cycle.

- If the dataset exists, analytics can identify Azure AD group membership for assets listed in catalog and use the Azure access package portal to request access to the Azure AD group.

### Build new reports

Analysts can use tools like Microsoft Power BI to integrate datasets into reports. These reports can be for their individual use or publishing a certified data product. Before publishing the report across the organization, it would need to be certified with a data product certification process for security, compliance, and performance.

### Run as-needed queries

Enterprise-scale for analytics and AI has shared workspaces where analysts can query data, subject to permissions. It's common for data products to provide dedicated compute to run queries as they're needed. In both cases, analyst can run queries against data assets in the data landing zones. It's also subject to permissions. The results from the queries can be stored in Azure Data Lake workspaces to be used again.

### User feedback

Since analysts can serve as an untapped source information and improvements, enterprises are highly encouraged to create user feedback groups for each data landing zone.

In addition to participating in these user groups, analysts should submit data asset feedback to integration ops and data catalog issues within the data catalog or the IT service management solution. They can submit data process issues to the data product team or within an IT service management solution.

> [!NOTE]
> An IT service management should serve as a central location for submitting feedback and escalating issues. Submitting direct feedback to individual teams might seem to be a faster solution, but this approach doesn't give the business visibility into the challenges in the platform. An IT service management solution with correct routing to integration ops and, the data product teams can give the business one view across the enterprise.

## Responsibility assignment matrix

- Responsible: who is completing the task?
- Accountable: who is making decisions and taking actions on the tasks(s)?
- Consulted: who will receive communication about decisions and tasks?
- Informed: who will be updated about the decisions and actions during the project?

|Role |Cloud environment|Data management landing zone|Data landing zone|Data integration|Data products|
|-|-|-|-|-|-|
|Service owner|Informed|Accountable|Consulted informed|Consulted informed|Consulted informed|
|Data landing zone service owner|Informed|Consulted informed|Accountable|Accountable|Accountable|
|Cloud platform ops|Responsible|Consulted|Consulted|Consulted|Consulted|
|Data platform ops|Consulted|Responsible|Responsible|Consulted|Consulted|
|Data landing zone ops|Informed|Responsible|Responsible|Responsible|Responsible|
|Integration ops||Informed|Informed|Responsible|Consulted|
|Data product team||Informed|Informed|Informed|Responsible|

## Next steps

[Azure Well-Architected Framework for data workloads](./well-architected-framework.md)
