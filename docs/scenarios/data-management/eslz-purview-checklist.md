---
title: Enterprise Scale Analytics and AI Azure Purview Readiness Checklist 
description: Enterprise Scale Analytics and AI Azure Purview Readiness Checklist 
author: zeinam
ms.author: zeinam # Microsoft employees only
ms.date: 05/21/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Azure Purview Readiness Checklist

As you start your journey on managing and governing data in the cloud or in hybrid at scale, you realize that there are multiple stages in the adoption lifecycle. A well-planned deployment of a data governance platform such as **Azure Purview** can provide the following benefits:

- Unified data discovery across the entire organization  
- Improved analytic collaboration
- Maximized return on investment
- Reduced deployment in time and effort

The **Azure Purview Readiness Checklist** below is high level guidance that can help you through the process of planning and deploying Azure Purview, and guide you through the entire process from organizational readiness to full deployment and operation:

| <span title="Icon">&nbsp;</span> | <span title="Description">&nbsp;</span> |
|--|--|
| <br> ![Phase 1](./images/icons/1.png) | <br>**Planning and Organizational Readiness**: Plan for unified data governance, learn the pre-requisite tools and approaches important to create a data management environment, and [develop a plan for data management and analytics](./plan.md) |
| <br> ![Phase 2](./images/icons/2.png) | **Build your Data Governance and Management Foundation**: Deploy your Enterprise Scale Analytics [Data Management Landing Zone](eslz-data-management-landing-zone.md), including Azure Purview Account as a unified enterprise Data Management and Data Governance solution. |
| <br>![Phase 3](./images/icons/3.png) | **Onboard first Data Landing Zone**: Start with your first [Data Landing Zone](./eslz-data-landing-zone.md) by starting small then expanding to quickly enable low-risk adoption and build toward security, governance, and compliance over time. |
| <br> ![Phase 4](./images/icons/4.png)| **Onboard additional Data Landing Zones**: Once the baseline architecture is fully deployed and evaluated, and your operating model is aligned with cloud-native operations, move forward by enabling additional Data Landing Zones.

## Phase 1: Planning and Organizational Readiness

1. Identify and document sources of data across your organization to create a digital estate of your data. Consider finding answers for the following questions as you begin:
    - Who are the data owners?
    - Who has write access to the data?
    - Where is the data? Is it in the Cloud? Is it on-premises?
    - What types of data sources do you have in the organization? (e.g., Azure SQL DB, Amazon S3, on-premises SQL Servers, etc.)
  
2. Define roles and responsibilities to build and manage a unified data governance solution. Consider the following sample roles:
    - Data Curators: Manage Classifications and Glossary Terms.
    - Data Readers: Require read-only access to Search and Insights Reports.
    - Data Source Administrators + Curators: Register and Scan Data Sources, Manage Catalog.
    - Data Source Administrators + Readers: Register and Scan Data Sources.
    - Supporting Roles for building an end-to-end data governance solution using Azure Purview:
       - Azure Subscription Administrators to manage Azure resources, Policies, RBAC, Resource Providers.
       - Azure AD Administrators to manage identity and application registration.
       - NetOps to prepare the network to support Azure Purview connectivity requirements.
       - SecOps to manage Azure Key Vaults and secrets.
       - M365 Administrators (Microsoft M365 Information Protection if M365 Sensitivity Labels will be used)
       - Data Source Owners to map them for roles in Azure Purview.

3. Define whether there is an existing [Enterprise Scale Analytics and AI Data Management Landing Zone] in the environment or you need to deploy a new Data Management Landing Zone. The Data Management Landing Zone is a centralized subscription to deploy services such as Azure Purview.

4. Manage budget, costs and licensing.
   - Understand how Azure Purview billing model works, and define how to control costs. Currently, Microsoft offers Azure Purview in a [pay-as-you-go model](http://aka.ms/purviewpricing).
   - Know additional costs. For example, if you are planning to extend Microsoft 365 Sensitivity Labels to files and database columns in Azure Purview, you need M365 E5 licenses.

5. Plan for enterprise level communication, readiness and awareness across different teams who require to curate, use and manage data across multiple platforms.

6. Locate data sources. If they are in Azure, what subscriptions are in scope. (Design for Data Management Landing Zones)
   - Identify Subscription Owners of Data Landing Zones.
   - Define what authentication methods to use to allow Azure Purview to connect to and scan data sources.
   - If data sources reside in IaaS or on-premises VMs, deploy Microsoft Integration Runtime.
   - Define Azure Key Vaults requirements to keep required keys and secrets for data governance.

7. Prepare Network and connectivity using Private Endpoint.

For further reading, see [Develop a plan for data management and analytics](./plan.md).

## Phase 2: Build your Data Governance and Management Foundation

_By Deploying a Data Management Landing Zone:_

1. Prepare your Azure Subscriptions to deploy Data Management Landing Zone including Azure Purview.
   - Define what Azure Subscriptions will be used to deploy Azure Purview.
   - Register required Azure Resource Providers in Purview subscription.
   - Review and update Azure Policy assigned to Purview subscriptions to allow deployment of Azure Storage, EventHub Namespace and Purview Accounts.
   - Deploy Data Management Landing Zones with Azure Purview Accounts for production and non-production environments.
   - Validate if Azure Purview Account is provided access to data source subscription to register and scan data sources.
   - If needed, assign required access to key vault secrets to Azure Purview Account's MSI.
   - For on-premises and IaaS data service create Credentials and map to Key Vault's secrets in Azure Purview.
   - Generate and Register Integration Runtime for data sources inside IaaS or on-premises VMs.

2. Import your glossary terms to Azure Purview. Define your glossary terms formatting; use Azure Purview default template or create a new term templates in Azure Purview.

3. Build your custom classifications / classification rules.

4. Consent to extend Sensitivity Labels to Azure Purview.

5. Validate / Update M365 Sensitivity Labels in Microsoft Security & Compliance dashboard.

6. Create Auto-labeling Rules in M365.

7. Grant Data Reader or Data Curator access to Azure Purview to data, governance and security teams in the organization.

8. Perform initial Security review.

9. Build and communicate detailed plan of tasks, roles and responsibilities to operate Azure Purview.

## Phase 3: Onboard first Data Landing Zone

1. Make sure deployment of Enterprise Scale Analytics and AI Data Management Landing Zone is completed.

2. Deploy your first [Enterprise Scale Analytics and AI Data Landing Zones](https://review.docs.microsoft.com/en-us/azure/cloud-adoption-framework/scenarios/data-management/eslz-data-landing-zone?branch=pr-en-us-1254).

3. Adjust Azure Purview automatic scan rules.

4. Migrate data sources to new Data Landing Zone.

5. Validate and update your Azure Purview Collection architecture.

6. Validate and update Collection hierarchy inside Azure Purview Account.

7. Validate data sources in collection, test connectivity and perform initial scans.

8. Verify classifications in assets and adjust custom classification rules.

9. Verify Assets with assigned labels.

10. Assign Data Experts and Data Owners to assets in Azure Purview.

11. Assign Glossary Terms to data assets.

12. Review and update automatic scan rules.

13. Analyze current costs related to data management and define costs and budget model.

14. Review security, business and operational requirements, identify gaps and adjust configuration.

15. Adjust and share roles and responsibilities plan.

## Phase 4: Onboard additional Data Landing Zones

1. Deploy additional Enterprise Scale Analytics and AI Data Landing Zones.

2. Adjust Azure Purview automatic scan rules.

3. Onboard additional data sources into Data Landing Zones.

4. Optimize glossary terms.

5. Optimize classifications rules.

6. Use Azure RBAC model to manage access to metadata and optimize Azure Purview access model.
