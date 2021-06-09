---
title: "Azure Enterprise Scale Analytics and AI Teams and Functions"
description: Enterprise Scale Analytics and AI Teams and Functions
author: mboswell
ms.author: mboswell
ms.date: 03/05/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Teams and Functions

The Enterprise Scale Analytics and AI moves teams from working horizontally across each tier such as Ingest, Processing, Analysis, Consumption and Visualization to vertical Data Landing Zone Groups coexisting together in an agile team. Platform teams such as Data Platform Ops and Platform Ops are grouped together under a common Platform Group.

![Enterprise Scale Analytics and AI Teams](./images/enterprise-scale-analytics-ai-teams.png)

*Figure 1: Enterprise Scale Analytics and AI Teams*

### Platform Ops

Platform Ops are part of the Platform Group team. They operate and own the cloud platform all up.

Within Enterprise Scale Analytics they are responsible for instantiating Data Management Landing Zone and Data Landing Zone scaffolding such as networking, peering, core service and monitoring.

At the start of rolling out Enterprise Scale Analytics and AI they are likely to have a heavy involvement in working, with the Data Platform Ops, in developing IT Service Management interfaces which personas in Data Landing Zone can use. These interfaces would typically be REST API calls to a service to onboard datasets, set security and add services to Data Landing Zones.

### Data Platform Ops

The Data Platform Ops group which is encompassed within the Platform Group Team.

Data Platform Ops provides a host of services such as central monitoring, cataloguing services, as well as providing reusable policies for Data Landing Zones and Data Products.

Data Platform Ops own the Data Management Landing Zone and have further responsibility which are detailed in the following sections.

#### Develop Infrastructure

The Data Platform Ops team is responsible for developing infrastructure as code templates for use by Data Landing Zone personas. The templates can cover multiple scenarios, which must be kept up to date and enhanced over times.

The team relies on a feedback cycle from other teams to prioritize templates and add new functionality.

The team is working in an agile framework with a common goal of driving standard infrastructure templates.

#### Respond to new Data Landing Zone Requests

The Data Platform Ops team must provide a code free way of consuming the templates that they have created. Using an IT Service Management tooling such as ServiceNow could handle ticket requests which are approved by the Data Platform Ops team for creating new Data Landing Zones.

Upon approved a new DevOps project would be created for that new landing zone forked from the base templates and the pipelines will be executed to deploy the templates to the new environment.

#### Data Platform Ops Feedback and Enhancement Loop

There are two options to incorporate enhancements into the templates:

* Teams in charge of instances of the infrastructure templates would enhance there DevOps templates and deployments. If teams discover issues in the templates, the Data Platform Ops can support the teams and merge changes back from there fork into the template.
* Other teams in the Data Landing Zones should be able to raise tickets for improvements and backlogs created to enhance templates based on prioritization.

#### Azure Policies for Enterprise Scale Analytics and AI

The Enterprise Scale Analytics and AI ethos is based upon self-service agility with guardrails to protect data, costs and patterns.

The Data Platform Ops team are core to working alongside Platform Ops in defining what good looks like. They would work with the Platform Ops team to implement the data specific policies. As features are added to products the Data Platform team should have a review process to keep on top and update as necessary.

#### Deployment and Operation of Data Management Landing Zone

The Data Platform Ops will deploy and operated the Data Management Landing Zone(s) alongside the Platform Ops team. The Data Management Landing Zone is the central piece of Enterprise Scale Analytics and AI which will provide shared services to the Data Landing Zones.

## Data Landing Zone Ops

The Data Landing Zone Ops operate and maintain their Data Landing Zone instance whilst respond to new Domain and Data Product service requests.

They provide many of the same services as Data Platform Ops but are limited to there Data Landing Zone.

They would worked on the forked repo which is created at the point of creating the Data Landing Zone. If they require changes to policies they have to raise ticket to the Data Platform Ops to allow the exceptions.

### Support Data Product Teams to Customize Products

A Data Landing Zone Ops team supports Data Products when they submit a new product template, via a Pull-Request, to there respective Data Products repository.

As owner of the Landing Zone, Azure DevOp would route approval for changes to the Data Landing Zone Ops.

* If approved, the Template changes would be moved to main branch and deployed to production, via CICD, leading to the Data Product platform/infrastructure to be updated.
* If denied, the Data Landing Zone Ops would work with the Data Product Team to fix the changes.

### Respond to New Domain + Product Requests

A Data Landing Zone Ops team supports Domain Ops and Data Products Teams to create new domain instances and data products.

When Domain Ops/Data Product request new instance, IT Service Management solution, it should call an automation app (logic app) which orchestrates approval, deployment, and of either a Domain or Data Products repo creation.

The Data Landing Zone Ops would be notified of new requests and approve or decline deployments. Once approved, a new DevOps project created, template and artifact forked, and a new domain or product deployed.

### Azure Well-Architected Framework Adherence

As the responsible team for the Data Landing Zone it is advisable that the team are proficient in the [Azure Well-Architected Framework](/azure/architecture/framework/) which give guidance on Cost Optimization, Reliability, and Security.

### Business as Usual

Data Landing Zone Ops team is responsible for business as usual tasks such as gathering feedback and enhancement requests. These requests are prioritized and shared with the Data Platform Ops via a regular cadence.

The team monitor the Data Landing Zone for incidents and health events. They will engage other Ops teams during severe incidents to mitigate, restore backusp, failover, and scale  services.

## Domain Ops

Domain Ops primary function is to ingest data from source and to provide a read data store version in the Data Landing Zone. The only change to the structure is to add conformed data types.

Onboarding a domain was covered in [Domain & Data Product Deployment Process](deployment-models.md#domain--data-product-deployment-process).

Jordan is a Data Manager within the Domain-Ops team.

This team provide access to reusable data assets and must carefully assess access controls, data attributes (compliance) and support the wider community.

### Triage New Dataset Request

Domain Ops would receive a request to onboard a new dataset via the business raising a ticket in there IT Service Management solution.

Domain Ops reviews data catalog for existing assets and source systems.

Domain Ops collect the metadata to be associated with the source such as schema, location, privacy requirements and ingest pattern.

Using there forked repo they would develop ingestion pipelines and deploy to there domain resource groups.

Finally, as part of the Enterprises dataset onboarding process they would register the dataset which would then drive creation of:

1. Registering the dataset in the data catalog.
2. Creating Azure Data Lake Folders for the dataset.
3. Notify the domain ops and data product teams of the new data asset.

### Updates to Existing Dataset

Domain Ops would receive a request to update a dataset via the business raising a ticket in there IT Service Management solution.

Using there forked repo they would update pipelines and deploy to there domain resource groups. Upon deployment they would update the dataset in the data catalog and notify the domain ops and data product teams of the new data asset.

Finally, as part of the updating the dataset definition they would:

1. Update the the dataset in the data catalog.
2. Notify the domain ops and data product teams of the new data asset.

### Manage Access Requests to Datasets

As previously described in [Granting Access](security-provisioning.md#granting-access) Domain Ops would be responsible for approving access to datasets.

### Dataset Telemetry Review

Domain Ops can use a data access heatmap to identify traffic and hotspots which will allow them to identify popular assets.

The heatmaps help prioritize support investment and manage storage costs whilst highlighting low traction data assets. In the case of low traction dataset, Domain Ops would contact the owners to evaluate archiving options.

>[!NOTE]
>Some Data Catalog solutions provide heatmaps as part of there integrated solution. However, it is possible to use other reporting tools such as PowerBI to.

### Domain Ops Feedback and Enhancement Loop

The Domain ops would analyze feedback provided via a User Voice process such as a feedback portal and other channels (DL, open office hours etc.)

Working with the business the team would identify major blockers for data options and collaborate with:

* Data Landing Zone Ops on process related issues.
* Data Asset Owners on Data Quality related issues.

This would input into the Domain Ops backlog as an enhancement to pipelines.

## Data Product Teams

The Data Product Team and delivers new Data Products to the business. They take sources from Domains Read Data Stores and transform them into business solutions.

Anything which has to transform data for use should be classified as a data product.

The Data Products team is often blended with technical specialists and business Subject Matter Experts to ensure business value is met expediently.

Data Products can range from simple reports, new data assets, to more bespoke setups such as a k8s data driven web app.

### New Data Products

When a new product is required a request is raised by product owners and business representative's to create a new data product.

The Data Office assess the requirements and assembles a new Data Product Team based upon specialties.

The team identifies the data assets required for the data product and raises requests for permission to the data asset. If a new data asset is require Domain Ops would receive a ticket to ingest the new data asset.

THe team identifies the common services which will be required for the new data product and raise a request for a new data product via [Domain & Data Product Deployment Process](deployment-models.md#domain--data-product-deployment-process)

The Data Product team is given a forked repo from the master Data Products template to work with to deploy data product.

### Certify Data Products

In self-service platform anyone can create reports, create curate datasets in the the Data Lake Workspace account and at certain points they may wish to push them back to for the wider business to use. Request to review data products can be raised by:

1. A business sponsor logging a ticket to certify a data product.
2. Data Platform Ops nominates data product based on popularity.

A data product team would drive a certification process (to be defined by Data Platform Ops and Digital Security) which might include:

* Tests devised to validate:
  * Data Transformations
  * Business Logic
* Conduct Assessments:
  * Security Impact
  * Compliance Impact
  * Performance Impact

Upon certification artifacts are collated and uploaded to a Data Product repository, documentation is published and the data product receives certification.

### Product Support

End users raise feedback via IT Service Management Solution or directly within the product and the ticket is routed to the Data Product Owner.

The request is triaged by the product own to determine either:

1. Escalate to Data Product Team if break fix is required and implement fix
1. Place feedback into product backlog and review during product planning cycles.

## Data Science Products Team

Although this team is creating Data Products, it has been called out separately as the functions build on top of either a Domain dataset or a Data Product. However, the end results is the published models become Data Products which others use.

This would follow an ML Ops Model which is associated with the Data Landing Zone.

The Data Science Products Team would start by searching and finding the relevant dataset for there use case. The Data Governance solution should produce additional details such as data quality, lineage, similar dataset and data profile.

For each of the datasets they would see if there is a sample dataset available and if the data is relevant for the project, they ask for access through the data catalog or AD Access Package. Once data access was granted, she can access the data through the services in the Data Landing zone to start explorative data analysis.

The team would use local compute or remote compute to process the data and start analyzing sample datasets, before processing all data. They can leverage remote compute targets, with larger datasets, to train and develop ML models with runs, outputs and models tracked inside Azure Machine Learning.

Once the team has ended up with promising ML models, they can start operationalizing these. For this they will expand the team to include Data Ops and ML Engineers who will assist with moving the models into a new Data Product as outlined in Data Products Teams role.

The Data Science team will continue to work with the associated Data Product Owners to capture feedback, support and resolved/update models in production using a [M/L Ops methodology](/azure/machine-learning/concept-model-management-and-deployment).

### Analyst

Analysts represents a large group including business analysts, power users, and generally anyone in the organization that has an interest in leveraging data to create new business insights.

Self-service enablement is a key principle, in line with this analysts can access analytics and data without having to secure formal IT budget and resources.

>[!TIP]
>Enterprises should view insights created by Analysts as the next set of potential Data Products which could be certified for use by others in the business.

### Find and Request Data

Analyst consults data marketplace/catalog to discover relevant datasets.

* If the data asset can't be found or doesn't exist then they can raise a ticket with Domain Ops to support. The Domain Ops will assist in finding the dataset or add the request to there backlog for assessment in another development cycle.
* If the dataset exists the analytics will be able to identify AAD-group membership for asset listed in catalog and request access to the AAD-group via Access Package portal.

### Build New Reports

Analysts can use the discovered dataset to build reports using tools such as PowerBI. When they are ready to publish they can use the report for there own benefit or chose to publish as a certified data product. Certifying a report would invoke the Data Products certification process for security, compliance and performance before publishing the workbook for discovery across the organization.

### *Ad Hoc* Queries

The Enterprise Scale Analytics and AI solution pattern has a number of shared workspaces where analysts can query data (subject to permissions). It is likely that Data Products would also provide dedicated compute to process *ad hoc* queries.

In both cases Analyst can run queries against data assets across Data Landing Zone(s) subject to their permissions. The results from *ad hoc* queries can be stored in Azure Data Lake workspace for re-use.

### User Feedback

Analyst can be an untapped source of improvements and enterprises are highly encouraged to create user feedback groups for each Data Landing Zone.

Alongside encouraging participation in these user groups, analysts should log feedback for data assets to Domain Ops, Data Catalog issues within the data catalog or within IT Service Management solution. Lastly, Data process issues can be raise with data product teams or the T Service Management solution.

>[!NOTE]
>IT Service Management should be considered as a central location to raise feedback and issues. Whilst directly logging feedback to the individual teams might seem a quicker solution it doesn't give the enterprise a full view of challenges in the platform. \
\
>An IT Service Management with correct routing to the Domain Ops, Data Product Teams will assist with one view across the enterprise.

## RACI Chart

* Responsible - Who is completing the task
* Accountable - Who is making decisions and taking actions on the tasks(s)
* Consulted - Who will be communicated with regarding decisions and tasks
* Informed - Who will be updated on the decision's and actions during the project

|Role |Cloud Environment|Data Management Landing Zone|Data Landing Zone|Domain|Data Products|
|-|-|-|-|-|-|
|ES-AAI Service owner|Informed|Accountable|Consulted Informed|Consulted Informed|Consulted Informed|
|Data Landing Zone Service owner|Informed|Consulted Informed|Accountable|Accountable|Accountable|
|Cloud Platform Ops|Responsible|Consulted|Consulted|Consulted|Consulted|
|Data Platform Ops|Consulted|Responsible|Responsible|Consulted|Consulted|
|Data Landing Zone Ops|Informed|Responsible|Responsible|Responsible|Responsible|
|Domain Ops||Informed|Informed|Responsible|Consulted|
|Data Products Team||Informed|Informed|Informed|Responsible|
