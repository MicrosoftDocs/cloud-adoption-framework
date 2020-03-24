---
title: "Cost optimization across an enterprise"
description: Learn the basics of managing costs associated with cloud adoption.
author: JanetCThomas
ms.author: janet
ms.date: 03/05/2020
ms.topic: guide
ms.service: cloud-adoption-framework
ms.subservice: overview
---

# How to optimize cloud costs across an enterprise environment

Cost management is the process of effectively planning and controlling costs associated with cloud adoption. Cost management is generally managed on a day to day basis by the cloud governance team. However, proper cost control across an enterprise is a much broader team effort. For specifics on cost management within a governance function, [jump ahead to the last step below](#core-cost-optimization-process).

## Effective cost Optimization

One of the core disciplines of cloud governance is cost management. That discipline helps establish budgets, monitor for sound cost allocation patterns, and identify opportunities to improve cloud spending behaviors. However, enterprise cost management involves many other roles and functions to minimize cost and balance the demands of scale, performance, security, and reliability. This article maps those various supporting functions into one getting started guide to help create alignment between each of the involved teams.

## Actionable steps checklist

The following steps reduce the amount of materials and the processes required during initial efforts to achieve enterprise cost management.

![Getting Started with enterprise cost management](../_images/getting-started/cost-getting-started-map.png)

*** Cost optimization:** Do you have a central governance team responsible for monitoring costs, budgets, and optimization opportunities across all Azure subscriptions and environments?

1. **Define strategy:** Do all stakeholder understand how their strategic objectives and desired business outcomes map to cost in the cloud? Has a business justification been completed to create an initial cost basis?
2. **Digital estate:** Has the team inventoried existing assets to forecast potential cloud costs?
3. **Adoption plan:** Is there a defined plan for adoption of next 10 workloads?
4. **Ready:** Have best practices for tracking costs across projects been implemented in each landing zone?
5. **Migration:** Have proper costs considerations been included in the overall migration approach?
6. **Manage:** Have business commitments been established to account for the cost of operations management?
7. **Organization:** Does the organization function as a cost-conscious team?

## Implementation details for each actionable steps

Each of these steps pulls from the broader cloud adoption framework, allowing readers to start fast and scale efforts over time.

### Cost optimization discipline of governance

The foundation of 

- [Build a cost-conscious organization](../organize/cost-conscious-organization.md)
- [Develop a cost management discipline](../govern/cost-management/index.md)
- [Track costs across business units, environments or projects](../ready/azure-best-practices/track-costs.md)
- [Manage costs and billing with Azure Cost Management](../ready/azure-setup-guide/manage-costs.md)


### 1. Define strategy

Strategic decisions have direct impact on cost controls, which ripple throughout the adoption life-cycle and beyond into long-term operations.

- Strategy: [Understand motivations](../strategy/motivations.md): Critical business events and some migration motivations tend to be cost sensitive, increasing the importance of cost control for all subsequent efforts. Other forward looking motivations related to innovation or growth through migration may be focused more on top-line revenue. Understanding motivations will help understand how high of a priority cost management should be.
- Strategy: [Business Outcomes](../strategy/business-outcomes/index.md): Some fiscal outcomes tend to be extremely cost sensitive. When the desired outcomes map to fiscal metrics, it can be wise to invest in the cost management discipline of governance very early.
- Strategy: [Business Justification](../strategy/cloud-migration-business-case.md): The business justification serves as a high-level view of the overall financial plan for cloud adoption. This can be a good source for initial budgeting efforts.

- **Accountable team:** [Cloud Strategy Team](../organize/cloud-strategy.md)
- **Supporting teams:** [Cloud Adoption Team](../organize/cloud-adoption.md) and [Cloud center of excellence](../organize/cloud-center-of-excellence.md)/[Central IT](../organize/central-it.md)
- **Deliverables:** Record motivations, outcomes, and business justification in the [Strategy and Planning Template](https://archcenter.blob.core.windows.net/cdn/fusion/readiness/Microsoft-Cloud-Adoption-Framework-Strategy-and-Plan-Template.docx). Create your first budget using Azure Cost Management.

### 2. Digital estate

The digital estate (or analysis of the existing IT portfolio) can aid in validating the business justification and provide a refined view of budgetary expectations.

- Plan: [Align cost models and forecast models](../digital-estate/calculate.md): Once the digital estate has been analyzed, you can use Azure Cost Management to align cost and forecast models.

- **Accountable team:** [Cloud Strategy Team](../organize/cloud-strategy.md)
- **Responsible/Supporting teams:** [Cloud Adoption Team](../organize/cloud-adoption.md) and [Cloud center of excellence](../organize/cloud-center-of-excellence.md)/[Central IT](../organize/central-it.md)
- **Deliverables:** Update the [Strategy and Planning Template](https://archcenter.blob.core.windows.net/cdn/fusion/readiness/Microsoft-Cloud-Adoption-Framework-Strategy-and-Plan-Template.docx) to reflect changes triggered by the digital estate analysis.

### 3. Adoption plan

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

- **Accountable team:** [Cloud Strategy Team](../organize/cloud-strategy.md)
- **Responsible/Supporting teams:** [Cloud Adoption Team](../organize/cloud-adoption.md) and [Cloud center of excellence](../organize/cloud-center-of-excellence.md)/[Central IT](../organize/central-it.md)
- **Deliverables:** Record motivations and outcomes in the [Strategy and Planning Template](https://archcenter.blob.core.windows.net/cdn/fusion/readiness/Microsoft-Cloud-Adoption-Framework-Strategy-and-Plan-Template.docx)

### 4. Landing zone

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

/azure/cost-management-billing/costs/tutorial-acm-create-budgets?toc=https://docs.microsoft.com/azure/cloud-adoption-framework/toc.json&bc=https://docs.microsoft.com/azure/cloud-adoption-framework/_bread/toc.json

- **Accountable team:** [Cloud Strategy Team](../organize/cloud-strategy.md)
- **Responsible/Supporting teams:** [Cloud Adoption Team](../organize/cloud-adoption.md) and [Cloud center of excellence](../organize/cloud-center-of-excellence.md)/[Central IT](../organize/central-it.md)
- **Deliverables:** Record motivations and outcomes in the [Strategy and Planning Template](https://archcenter.blob.core.windows.net/cdn/fusion/readiness/Microsoft-Cloud-Adoption-Framework-Strategy-and-Plan-Template.docx)

### 5. Migration

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

- **Accountable team:** [Cloud Strategy Team](../organize/cloud-strategy.md)
- **Responsible/Supporting teams:** [Cloud Adoption Team](../organize/cloud-adoption.md) and [Cloud center of excellence](../organize/cloud-center-of-excellence.md)/[Central IT](../organize/central-it.md)
- **Deliverables:** Record motivations and outcomes in the [Strategy and Planning Template](https://archcenter.blob.core.windows.net/cdn/fusion/readiness/Microsoft-Cloud-Adoption-Framework-Strategy-and-Plan-Template.docx)

### 6. Manage

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

- **Accountable team:** [Cloud Strategy Team](../organize/cloud-strategy.md)
- **Responsible/Supporting teams:** [Cloud Adoption Team](../organize/cloud-adoption.md) and [Cloud center of excellence](../organize/cloud-center-of-excellence.md)/[Central IT](../organize/central-it.md)
- **Deliverables:** Record motivations and outcomes in the [Strategy and Planning Template](https://archcenter.blob.core.windows.net/cdn/fusion/readiness/Microsoft-Cloud-Adoption-Framework-Strategy-and-Plan-Template.docx)

### 7. Organize

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

- **Accountable team:** [Cloud Strategy Team](../organize/cloud-strategy.md)
- **Responsible/Supporting teams:** [Cloud Adoption Team](../organize/cloud-adoption.md) and [Cloud center of excellence](../organize/cloud-center-of-excellence.md)/[Central IT](../organize/central-it.md)
- **Deliverables:** Record motivations and outcomes in the [Strategy and Planning Template](https://archcenter.blob.core.windows.net/cdn/fusion/readiness/Microsoft-Cloud-Adoption-Framework-Strategy-and-Plan-Template.docx)


## Additional information

- [Download the Cost Management template](../govern/cost-management/template.md)
- [How to optimize your cloud investment with Azure Cost Management](https://docs.microsoft.com/azure/cost-management/cost-mgt-best-practices?toc=https://docs.microsoft.com/azure/cloud-adoption-framework/toc.json&bc=https://docs.microsoft.com/azure/cloud-adoption-framework/_bread/toc.json)