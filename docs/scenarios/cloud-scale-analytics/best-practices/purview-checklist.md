---
title: Microsoft Purview readiness checklist for the cloud-scale analytics
description: Learn about cloud-scale analytics Microsoft Purview readiness checklist
author: zeinam
ms.author: zeinam
ms.date: 05/09/2022
ms.topic: conceptual
ms.custom: e2e-data-management, think-tank
---

# Microsoft Purview readiness checklist for cloud-scale analytics

During your data governance journey with Microsoft Purview and cloud-scale analytics, you'll find there are multiple stages in the adoption lifecycle. A well-planned deployment of **Microsoft Purview** in the [data management landing zone](../architectures/data-management-landing-zone.md) can provide the following benefits:

- Unified data discovery across the entire organization
- Improved analytic collaboration
- Maximized return on investment
- Reduced deployment in time and effort

## Overview

The **Microsoft Purview readiness checklist** provides high-level guidance that can help your organization plan and deploy Microsoft Purview. There are four phases that guide you through the process, from organizational readiness to full deployment and operation.

|Phase |Description |
|--|--|
|![Phase 1](../images/icons/1.png) | Plan for unified data governance, learn the prerequisite tools and approaches needed for creating a data management environment, and [develop a plan for cloud-scale analytics](../plan.md). |
|![Phase 2](../images/icons/2.png) | Build your data governance and management foundation: Deploy your analytics landing zone accelerator [data management landing zone](../architectures/data-management-landing-zone.md) with Microsoft Purview. This foundation is a unified enterprise data management and data governance solution. |
|![Phase 3](../images/icons/3.png) | Onboard the first data landing zone: Start with your first [data landing zone](../architectures/data-landing-zone.md) and start small. Then expand to quickly enable low-risk adoption and build toward security, governance, and compliance over time. |
|![Phase 4](../images/icons/4.png)| Onboard more data landing zones: Once you deploy and evaluate your baseline architecture and align your operating model with cloud-native operations, you can enable more data landing zones.

## Phase 1: Planning and organizational readiness

- Identify and document sources of data across your organization to create a digital estate of your data. Consider finding answers for the following questions as you begin:
  - Who are the data owners?
  - Who has write access to the data?
  - Where is the data? Is it in the cloud? Is it on-premises?
  - What types of data sources do you have in the organization? For example, Azure SQL Database, Amazon S3, or on-premises SQL servers.

- Define roles and responsibilities to build and manage a unified data governance solution. Microsoft Purview uses a set of predefined roles to control who can access what within the account. For more information related to Microsoft Purview roles, see [Access control in Microsoft Purview](/azure/purview/catalog-permissions#roles).

- Consider the following supporting roles for building an end-to-end data governance solution using Microsoft Purview:

    |Role  |Description  |
    |---------|---------|
    |Azure subscription administrators     |Manage Azure resources, policies, role-based access control (RBAC), and resource providers         |
    |Azure AD administrators     |Manage identity and application registration.        |
    |NetOps administrators     |Prepare the network to support Microsoft Purview connectivity requirements        |
    |SecOps administrators     |Manage Azure key vaults and secrets         |
    |Microsoft 365 administrators     |Microsoft Purview Information Protection in Microsoft 365 if Microsoft 365 sensitivity labels will be used         |
    |Data source owners     |Mapped to roles in Microsoft Purview         |

- Define whether there's an existing cloud-scale analytics [data management landing zone](../architectures/data-management-landing-zone.md) in the environment or if there is a need to deploy a *new* data management landing zone. The data management landing zone is a centralized subscription to deploy services such as Microsoft Purview.

- Manage budgets, costs, and licensing.
  - Understand how the Microsoft Purview billing model works, and define how to control costs. Microsoft offers Microsoft Purview in a [pay-as-you-go model](https://aka.ms/purviewpricing). Detailed pricing information can also be found in [Microsoft Purview pricing](/azure/purview/concept-guidelines-pricing)
  - Understand more about potential costs. For example, if you're planning to extend Microsoft 365 sensitivity labels to files and database columns in Microsoft Purview, you need Microsoft 365 E5 licenses.

- Plan for enterprise-level communication, readiness, and awareness across different teams. These teams are the ones required to curate, use, and manage data across multiple platforms.

- Locate data sources. If they're in Azure, identify which subscriptions are in scope.
  - Identify subscription owners of data landing zones.
  - Define which authentication methods to use to allow Microsoft Purview to connect to and scan data sources.
  - If data sources are in IaaS or on on-premises VMs, deploy the Microsoft Integration Runtime.
  - Define Azure Key Vault requirements to store required keys and secrets for data governance purposes.

- Prepare network connectivity using an [Azure private endpoint](/azure/private-link/private-endpoint-overview).

## Phase 2: Build your data governance and management foundation

- Prepare your Azure subscription to deploy the data management landing zone with Microsoft Purview.
  - Define which subscription will be used.
  - Register required Azure resource providers.
  - Review and update the Azure Policy assigned to allow deployment of Azure Storage, Azure Event Hubs namespace, and Microsoft Purview accounts.
  - Validate if the Microsoft Purview account has access to a data source subscription to register and scan data sources.
  - If needed, assign required access to Key Vault secrets to Microsoft Purview account's managed identity.
  - For on-premises and infrastructure as a service (IaaS) data sources, create credentials and map to Key Vault's secrets in Microsoft Purview.
  - Generate and register integration runtime for data sources inside IaaS or on-premises VMs.
  - If there's multiple environments, such as production and nonproduction, prepare to deploy the respective data management landing zones with Microsoft Purview accounts.

- Import your glossary terms to Microsoft Purview and define the formatting. Use a Microsoft Purview default template or create new term templates in Microsoft Purview.

- Build your custom classifications and classification rules.

- Consent to extend sensitivity labels to Microsoft Purview.

- Validate and update Microsoft 365 sensitivity labels in the Microsoft security and compliance dashboard.

- Create autolabeling rules in Microsoft 365.

- Grant roles in Microsoft Purview to data governance and security teams in the organization to corresponding collections.

- Do an initial security review.

- Build and communicate a detailed plan of tasks, roles, and responsibilities to operate Microsoft Purview.

## Phase 3: Onboard your first data landing zone

- Make sure deployment of the data management landing zone is completed.

- Deploy your first [data landing zone](../architectures/data-landing-zone.md).

- Adjust Microsoft Purview automatic scan rules.

- Migrate data sources to the new data landing zone.

- Validate and update your Microsoft Purview [collections architecture](/azure/purview/manage-data-sources#manage-collections). Best practice information around Microsoft Purview collections architecture can be found [here](/azure/purview/concept-best-practices-collections).

- Validate and update the collection hierarchy inside the Microsoft Purview account.

- Validate data sources in collections by testing connectivity and doing initial scans.

- Verify classifications in assets and adjust custom classification rules.

- Verify assets with assigned labels.

- Assign *Data Experts* and *Data Owners* to assets in Microsoft Purview.

- Assign glossary terms to data assets.

- Review and update automatic scan rules.

- Analyze current costs related to data management by defining costs and budget model.

- Review security, business, and operational requirements. Identify gaps and adjust the configuration accordingly.

- Create and share a roles and responsibilities plan.

## Phase 4: Onboard more data landing zones

- Deploy more data landing zones as needed.

- Adjust Microsoft Purview automatic scan rules.

- Onboard more data sources into data landing zones.

- Optimize glossary terms.

- Optimize classifications rules.

- Use Microsoft Purview fine-grained roles inside collections.
