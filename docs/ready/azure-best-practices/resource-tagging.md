---
title: Define your tagging strategy
description: Learn about recommendations for tagging your Azure resources and assets and how to define your tagging strategy.
author: BrianBlanchard
ms.author: brblanch
ms.date: 12/28/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal, readiness, fasttrack-edit
---

# Define your tagging strategy

When you apply metadata tags to your cloud resources, include information that couldn't be included in the resource name. For example, include information about the asset. You can use that information to run more sophisticated filtering and reporting on resources. You want these tags to include context about the resource's associated workload or application, operational requirements, and ownership information. IT or business teams use this information to find resources or generate reports about resource usage and billing.

What tags you apply to resources and what tags are required or optional differs among organizations. The following list provides examples of common tags that capture important context and information about a resource. Use this list as a starting point to establish your own tagging conventions.

## Minimum suggested tags

The following tags guide implementation and processes in Cloud Adoption Framework methodologies. Many of the best practices in those methodologies demonstrate cloud operations automation and governance based on the following tags.

| Tag Name | Description | Key and example values |
|--|--|--|
| **Workload name** | Name of the workload the resource supports. | *WorkloadName* <br><br> <li> `ControlCharts` |
| **Data classification** | Sensitivity of data hosted by this resource. | *DataClassification* <br><br> <li> `Non-business` <li> `Public` <li> `General` <li> `Confidential` <li> `Highly confidential` |
| **Business criticality** | Business impact of the resource or supported workload. | *Criticality* <br><br> <li> `Low` <li> `Medium` <li> `High` <li> `Business unit-critical` <li> `Mission-critical` |
| **Business unit** | Top-level division of your company that owns the subscription or workload that the resource belongs to. In smaller organizations, this tag might represent a single corporate or shared top-level organizational element. | *BusinessUnit* <br><br> <li> `Finance` <li> `Marketing` <li> `Product XYZ` <li> `Corp` <li> `Shared` |
| **Operations commitment** | Level of operations support provided for this workload or resource. | *OpsCommitment* <br><br> <li> `Baseline only` <li> `Enhanced baseline` <li> `Platform operations` <li> `Workload operations` |
| **Operations team** | Team accountable for day-to-day operations. | *OpsTeam* <br><br> <li> `Central IT` <li> `Cloud operations` <li> `ControlCharts team` <li> `MSP-{Managed Service Provider name}` |

## Other common tagging examples

Use the following tags to increase visibility into the usage of Azure resources.

| Tag Name | Description | Key and example values |
|--|--|--|
| **Application name** | Added granularity, if the workload is subdivided across multiple applications or services. | *ApplicationName* <br><br> <li> `IssueTrackingSystem` |
| **Approver name** | Person responsible for approving costs related to this resource. | *Approver* <br><br> <li> `chris@contoso.com` |
| **Budget required/approved** | Money approved for this application, service, or workload. | *BudgetAmount* <br><br> <li> `$200,000` |
| **Cost center** | Accounting cost center associated with this resource. | *CostCenter* <br><br> <li> `55332` |
| **Disaster recovery** | Business criticality of the application, workload, or service. | *DR* <br><br> <li> `Mission-critical` <li> `Critical` <li> `Essential` |
| **End date of the project** | Date when the application, workload, or service is scheduled for retirement. | *EndDate* <br><br> <li> `2023-10-15` |
| **Environment** | Deployment environment of the application, workload, or service. | *Env* <br><br> <li> `Prod` <li> `Dev` <li> `QA` <li> `Stage` <li> `Test` |
| **Owner name** | Owner of the application, workload, or service. | *Owner* <br><br> <li> `jane@contoso.com` |
| **Requester name** | User who requested the creation of this application. | *Requester* <br><br> <li> `john@contoso.com` |
| **Service class** | Service level agreement level of the application, workload, or service. | *ServiceClass* <br><br> <li> `Dev` <li> `Bronze` <li> `Silver` <li> `Gold` |
| **Start date of the project** | Date when the application, workload, or service was first deployed. | *StartDate* <br><br> <li> `2020-10-15` |

## Take action

Review the [resource naming and tagging decision guide](../../decision-guides/resource-tagging/index.md).

## Next steps

Learn how to move resource groups and assets between subscriptions in Azure.

> [!div class="nextstepaction"]
> [Move resource groups and assets between subscriptions](/azure/azure-resource-manager/management/move-resource-group-and-subscription)
