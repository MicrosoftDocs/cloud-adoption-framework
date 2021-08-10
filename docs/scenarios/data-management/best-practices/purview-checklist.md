---
title: Azure Purview readiness checklist for the data management and analytics enterprise-scale scenario
description: Learn about the enterprise-scale for analytics and AI Azure Purview readiness checklist
author: zeinam
ms.author: zeinam
ms.date: 05/21/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Azure Purview readiness checklist for data management and analytics enterprise-scale scenario

During your data governance journey with Azure Purview and enterprise-scale for analytics and AI, you'll find there are multiple stages in the adoption lifecycle. A well-planned deployment of **Azure Purview** in the [data management landing zone](../architectures/data-management-landing-zone.md) can provide the following benefits:

- Unified data discovery across the entire organization  
- Improved analytic collaboration
- Maximized return on investment
- Reduced deployment in time and effort

## Overview

The **Azure Purview readiness checklist** provides high-level guidance that can help your organization plan and deploy Azure Purview. There are four phases that guide you through the process, from organizational readiness to full deployment and operation.

|Phase |Description |
|--|--|
|![Phase 1](../images/icons/1.png) | Plan for unified data governance, learn the pre-requisite tools and approaches needed for creating a data management environment, and [develop a plan for data management and analytics](../plan.md). |
|![Phase 2](../images/icons/2.png) | Build your data governance and management foundation: Deploy your enterprise-scale for analytics [data management landing zone](../architectures/data-management-landing-zone.md) with Azure Purview. This foundation is a unified enterprise data management and data governance solution. |
|![Phase 3](../images/icons/3.png) | Onboard the first data landing zone: Start with your first [data landing zone](../architectures/data-landing-zone.md) and start small. Then expand to quickly enable low-risk adoption and build toward security, governance, and compliance over time. |
|![Phase 4](../images/icons/4.png)| Onboard more data landing zones: Once you deploy and evaluate your baseline architecture and align your operating model with cloud-native operations, you can enable more data landing zones.

## Phase 1: Planning and organizational readiness

- Identify and document sources of data across your organization to create a digital estate of your data. Consider finding answers for the following questions as you begin:
  - Who are the data owners?
  - Who has write access to the data?
  - Where is the data? Is it in the cloud? Is it on-premises?
  - What types of data sources do you have in the organization? For example, Azure SQL Database, Amazon S3, or on-premises SQL servers.
  
- Define roles and responsibilities to build and manage a unified data governance solution. Consider the following roles for your organization:

    |Role  |Description  |
    |---------|---------|
    |Data curators     |Manage classifications and glossary terms         |
    |Data readers     |Requires read-only access for search and insights reports         |
    |Data source administrators and curators     |Register and scan data sources, and manage catalog         |
    |Data source administrators and readers     |Register and scan data sources         |

- Consider the following supporting roles for building an end-to-end data governance solution using Azure Purview:

    |Role  |Description  |
    |---------|---------|
    |Azure subscription administrators     |Manage Azure resources, policies, role-based access control (RBAC), and resource providers         |
    |Azure AD administrators     |Manage identity and application registration.        |
    |NetOps administrators     |Prepare the network to support Azure Purview connectivity requirements        |
    |SecOps administrators     |Manage Azure key vaults and secrets         |
    |Microsoft 365 administrators     |Microsoft Information Protection in Microsoft 365 if Microsoft 365 sensitivity labels will be used         |
    |Data source owners     |Mapped to roles in Azure Purview         |

- Define whether there's an existing enterprise-scale for analytics and AI [data management landing zone](../architectures/data-management-landing-zone.md) in the environment or if there is a need to deploy a *new* data management landing zone. The data management landing zone is a centralized subscription to deploy services such as Azure Purview.

- Manage budgets, costs, and licensing.
  - Understand how the Azure Purview billing model works, and define how to control costs. Microsoft offers Azure Purview in a [pay-as-you-go model](https://aka.ms/purviewpricing).
  - Understand more about potential costs. For example, if you're planning to extend Microsoft 365 sensitivity labels to files and database columns in Azure Purview, you need Microsoft 365 E5 licenses.

- Plan for enterprise-level communication, readiness, and awareness across different teams. These teams are the ones required to curate, use, and manage data across multiple platforms.

- Locate data sources. If they're in Azure, identify which subscriptions are in scope.
  - Identify subscription owners of data landing zones.
  - Define which authentication methods to use to allow Azure Purview to connect to and scan data sources.
  - If data sources are in IaaS or on on-premises VMs, deploy Microsoft Integration Runtime.
  - Define Azure Key Vault requirements to store required keys and secrets for data governance purposes.

- Prepare network and connectivity using [Azure Private Endpoint](/azure/private-link/private-endpoint-overview).

## Phase 2: Build your data governance and management foundation

- Prepare your Azure subscription to deploy the data management landing zone with Azure Purview.
  - Define which subscription will be used.
  - Register required Azure resource providers.
  - Review and update the Azure Policy assigned to allow deployment of Azure Storage, Azure Event Hubs namespace, and Azure Purview accounts.
  - Validate if the Azure Purview account has access to a data source subscription to register and scan data sources.
  - If needed, assign required access to Key Vault secrets to Azure Purview account's managed identity.
  - For on-premises and infrastructure as a service (IaaS) data sources, create credentials and map to Key Vault's secrets in Azure Purview.
  - Generate and register integration runtime for data sources inside IaaS or on-premises VMs.
  - If there's multiple environments, such as production and nonproduction, prepare to deploy the respective data management landing zones with Azure Purview accounts.

- Import your glossary terms to Azure Purview and define the formatting. Use an Azure Purview default template or create new term templates in Azure Purview.

- Build your custom classifications and classification rules.

- Consent to extend sensitivity labels to Azure Purview.

- Validate and update Microsoft 365 sensitivity labels in the Microsoft Security and Compliance dashboard.

- Create autolabeling rules in Microsoft 365.

- Grant *Data Reader* or *Data Curator* access in Azure Purview to data governance and security teams in the organization.

- Do an initial security review.

- Build and communicate a detailed plan of tasks, roles, and responsibilities to operate Azure Purview.

## Phase 3: Onboard your first data landing zone

- Make sure deployment of the data management landing zone is completed.

- Deploy your first [data landing zone](../architectures/data-landing-zone.md).

- Adjust Azure Purview automatic scan rules.

- Migrate data sources to the new data landing zone.

- Validate and update your Azure Purview [collections architecture](/azure/purview/manage-data-sources#manage-collections).

- Validate and update the collection hierarchy inside the Azure Purview account.

- Validate data sources in collections by testing connectivity and doing initial scans.

- Verify classifications in assets and adjust custom classification rules.

- Verify assets with assigned labels.

- Assign *Data Experts* and *Data Owners* to assets in Azure Purview.

- Assign glossary terms to data assets.

- Review and update automatic scan rules.

- Analyze current costs related to data management by defining costs and budget model.

- Review security, business, and operational requirements. Identify gaps and adjust the configuration accordingly.

- Create and share a roles and responsibilities plan.

## Phase 4: Onboard more data landing zones

- Deploy more data landing zones as needed.

- Adjust Azure Purview automatic scan rules.

- Onboard more data sources into data landing zones.

- Optimize glossary terms.

- Optimize classifications rules.

- Use Azure RBAC model to manage access to metadata and optimize the Azure Purview access model.
