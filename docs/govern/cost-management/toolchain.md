---
title: Cost Management tools in Azure
description: See how Azure native tools can help mature policies and processes that support the Cost Management discipline.
author: BrianBlanchard
ms.author: brblanch
ms.date: 09/17/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
ms.custom: internal
---

# Cost Management tools in Azure

The [Cost Management discipline](./index.md) is one of the [Five Disciplines of Cloud Governance](../governance-disciplines.md). This discipline focuses on ways of establishing cloud spending plans, allocating cloud budgets, monitoring and enforcing cloud budgets, detecting costly anomalies, and adjusting the cloud governance plan when actual spending is misaligned.

The following is a list of Azure native tools that can help mature the policies and processes that support this discipline.

| Tool | [Azure portal](https://azure.microsoft.com/features/azure-portal/) | [Azure Cost Management + Billing](/azure/cost-management-billing/cost-management-billing-overview) | [Power BI Desktop connector](/power-bi/connect-data/desktop-connect-azure-cost-management) | [Azure Policy](/azure/governance/policy/overview) |
|---------|---------|---------|---------|---------|
| Budget control     | No         | Yes         | No         | Yes         |
| Monitor spending on single resource    | Yes         | Yes         | Yes         | No         |
| Monitor spending across multiple resources    | No         | Yes        | Yes         | No         |
| Control spending on single resource     | Yes, manual sizing         | Yes         | No         | Yes         |
| Enforce spending across multiple resources    | No         | Yes         | No         | Yes         |
| Enforce accounting metadata on resources    | No         | No         | No         | Yes         |
| Monitor and detect trends     | Yes          | Yes        | Yes         | No         |
| Detect spending anomalies     | No         | Yes        | Yes         | No        |
| Socialize deviations     | No        | Yes        | Yes        | No        |
