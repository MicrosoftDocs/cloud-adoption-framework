---
title: Azure Purview readiness checklist for 'data management and analytics' Enterprise-Scale scenario 
description: Enterprise Scale Analytics and AI Azure Purview Readiness Checklist 
author: zeinam
ms.author: zeinam # Microsoft employees only
ms.date: 05/21/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Azure Purview readiness checklist for 'data management and analytics' Enterprise-Scale scenario

As your organization starts its data governance journey with Azure Purview and Enterprise Scale Analytics and AI, you realize that there are multiple stages in the adoption lifecycle. A well-planned deployment of **Azure Purview** in the [Data Management Landing Zone](eslz-data-management-landing-zone.md) can provide the following benefits:

- Unified data discovery across the entire organization  
- Improved analytic collaboration
- Maximized return on investment
- Reduced deployment in time and effort

## Overview

The **Azure Purview Readiness Checklist** aims to provide high-level guidance that can help your organization through the process of planning and deploying Azure Purview. The phases (1 to 4) outlined below will serve as a guide for you through the entire process ranging from organizational readiness to full deployment and operation.

|Phase |Description |
|--|--|
|![Phase 1](./images/icons/1.png) | [Planning and Organizational Readiness](#phase-1-planning-and-organizational-readiness): Plan for unified data governance, learn the pre-requisite tools and approaches needed for creating a data management environment, and [develop a plan for data management and analytics](./plan.md) |
|![Phase 2](./images/icons/2.png) | [Build your Data Governance and Management Foundation](#phase-2-build-your-data-governance-and-management-foundation): Deploy your Enterprise Scale Analytics [Data Management Landing Zone](eslz-data-management-landing-zone.md) with Azure Purview as a unified enterprise Data Management and Data Governance solution. |
|![Phase 3](./images/icons/3.png) | [Onboard the first Data Landing Zone](#phase-3-onboard-first-data-landing-zone): Start with your first [Data Landing Zone](./eslz-data-landing-zone.md) by starting small then expanding to quickly enable low-risk adoption and build toward security, governance, and compliance over time. |
|![Phase 4](./images/icons/4.png)| [Onboard additional Data Landing Zones](#phase-4-onboard-additional-data-landing-zones): Once the baseline architecture is fully deployed and evaluated, and your operating model is aligned with cloud-native operations, move forward by enabling additional Data Landing Zones.

## Phase 1: Planning and Organizational Readiness

1. Identify and document sources of data across your organization to create a digital estate of your data. Consider finding answers for the following questions as you begin:
    - Who are the data owners?
    - Who has write access to the data?
    - Where is the data? Is it in the Cloud? Is it on-premises?
    - What types of data sources do you have in the organization? (e.g., Azure SQL Database, Amazon S3, On-premises SQL Servers, etc.)
  
2. Define roles and responsibilities to build and manage a unified data governance solution. Consider the following roles for your organization:

    |Role  |Description  |
    |---------|---------|
    |Data Curators     |Manage classifications and glossary terms.         |
    |Data Readers     |Requires read-only access for search and insights reports.         |
    |Data Source Administrators + Curators     |Register and scan data sources, and manage catalog.         |
    |Data Source Administrators + Readers     |Register and scan data sources.         |

    Consider the following supporting roles for building an end-to-end data governance solution using Azure Purview:

    |Role  |Description  |
    |---------|---------|
    |Azure Subscription Administrators     |Manage Azure resources, policies, RBAC, and resource providers.         |
    |Azure AD Administrators     |Manage identity and application registration.         |
    |NetOps Administrators     |Prepare the network to support Azure Purview connectivity requirements.         |
    |SecOps Administrators     |Manage Azure Key Vaults and secrets.         |
    |M365 Administrators     |Microsoft M365 Information Protection if M365 Sensitivity Labels will be used.         |
    |Data Source Owners     |Mapped to roles in Azure Purview         |

3. Define whether there is an existing Enterprise Scale Analytics and AI [Data Management Landing Zone](eslz-data-management-landing-zone.md) in the environment or if there is a need to deploy a *new* Data Management Landing Zone. The Data Management Landing Zone is a centralized subscription to deploy services such as Azure Purview.

4. Manage budget, costs and licensing.
   - Understand how the Azure Purview billing model works, and define how to control costs. Currently, Microsoft offers Azure Purview in a [pay-as-you-go model](https://aka.ms/purviewpricing).
   - Know additional costs. For example, if you are planning to extend Microsoft 365 Sensitivity Labels to files and database columns in Azure Purview, you need M365 E5 licenses.

5. Plan for enterprise level communication, readiness and awareness across different teams who are required to curate, use and manage data across multiple platforms.

6. Locate data sources. If they are in Azure, identify which subscriptions are in scope.
   - Identify subscription owners of Data Landing Zones.
   - Define which authentication methods to use to allow Azure Purview to connect to and scan data sources.
   - If data sources reside in IaaS or on on-premises VMs, deploy Microsoft Integration Runtime.
   - Define Azure Key Vaults requirements to store required keys and secrets for data governance purposes.

7. Prepare network and connectivity using [Azure Private Endpoint](/azure/private-link/private-endpoint-overview).

## Phase 2: Build your Data Governance and Management Foundation

1. Prepare your Azure subscription to deploy the Data Management Landing Zone with Azure Purview.
   - Define which subscription will be used.
   - Register required Azure Resource Providers.
   - Review and update the Azure Policy assigned to allow deployment of Azure Storage, EventHub Namespace and Azure Purview Accounts.
   - Validate if the Azure Purview account is provided access to data source subscription to register and scan data sources.
   - If needed, assign required access to key vault secrets to Azure Purview account's Managed Identity.
   - For on-premises and IaaS data sources, create credentials and map to key vault's secrets in Azure Purview.
   - Generate and register Integration Runtime for data sources inside IaaS or on-premises VMs.
   - In case of multiple environments such as prod and non-prod, prepare to deploy the respective Data Management Landing Zones with Azure Purview accounts.

2. Import your glossary terms to Azure Purview and define the formatting. Use Azure Purview default template or create a new term templates in Azure Purview.

3. Build your custom classifications and classification rules.

4. Consent to extend sensitivity labels to Azure Purview.

5. Validate and update M365 sensitivity labels in the Microsoft Security and Compliance dashboard.

6. Create auto-labeling rules in M365.

7. Grant *Data Reader* or *Data Curator* access in Azure Purview to data governance and security teams in the organization.

8. Perform an initial security review.

9. Build and communicate a detailed plan of tasks, roles and responsibilities to operate Azure Purview.

## Phase 3: Onboard first Data Landing Zone

1. Make sure deployment of the Data Management Landing Zone is completed.

2. Deploy your first [Data Landing Zone](eslz-data-landing-zone.md).

3. Adjust Azure Purview automatic scan rules.

4. Migrate data sources to the new Data Landing Zone.

5. Validate and update your Azure Purview [collections architecture](/azure/purview/manage-data-sources#manage-collections).

6. Validate and update the collection hierarchy inside Azure Purview Account.

7. Validate data sources in collections by testing connectivity and performing initial scans.

8. Verify classifications in assets and adjust custom classification rules.

9. Verify assets with assigned labels.

10. Assign *Data Experts* and *Data Owners* to assets in Azure Purview.

11. Assign glossary terms to data assets.

12. Review and update automatic scan rules.

13. Analyze current costs related to data management by defining costs and budget model.

14. Review security, business and operational requirements. Identify gaps and adjust the configuration accordingly.

15. Create and share a roles and responsibilities plan.

## Phase 4: Onboard additional Data Landing Zones

1. Deploy additional Data Landing Zones as needed.

2. Adjust Azure Purview automatic scan rules.

3. Onboard additional data sources into Data Landing Zones.

4. Optimize glossary terms.

5. Optimize classifications rules.

6. Use Azure RBAC model to manage access to metadata and optimize the Azure Purview access model.
