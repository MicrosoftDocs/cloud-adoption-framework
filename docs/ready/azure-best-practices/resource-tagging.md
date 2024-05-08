---
title: Define your tagging strategy
description: Learn about recommendations for tagging your Azure resources and assets and how to define your tagging strategy.
author: martinekuan
ms.author: martinek
ms.date: 12/28/2021
ms.topic: conceptual
ms.custom: internal, readiness, fasttrack-edit
---

# Define your tagging strategy

When you apply metadata tags to your cloud resources, you can include information that the resource name doesn't include, like information about the asset. You can use that information to run sophisticated filtering and reporting on resources. Include context about the resource's associated workload or application, operational requirements, and ownership information. IT or business teams use this information to find resources or generate reports about resource usage and billing.

The required tags and optional tags that you apply to resources differs among organizations. The following list provides examples of common tags that capture important context and information about a resource. Use this list as a starting point to establish your own tagging conventions.

## Minimum suggested tags

Use the following tags to help guide the implementation and processes of Cloud Adoption Framework for Azure methodologies. The methodologies have many best practices that demonstrate cloud operations automation and governance based on the following tags.

| Tag name | Description | Key value and example values |
|--|--|--|
| **Workload name** | Name of the workload that the resource supports. | *WorkloadName* <br><br> <li> `ControlCharts` |
| **Data classification** | Sensitivity of data that the resource hosts. | *DataClassification* <br><br> <li> `Non-business` <li> `Public` <li> `General` <li> `Confidential` <li> `Highly confidential` |
| **Business criticality** | Business impact of the resource or supported workload. | *Criticality* <br><br> <li> `Low` <li> `Medium` <li> `High` <li> `Business unit-critical` <li> `Mission-critical` |
| **Business unit** | Top-level division of your company that owns the subscription or workload that the resource belongs to. In smaller organizations, this tag might represent a single corporate or shared top-level organizational element. | *BusinessUnit* <br><br> <li> `Finance` <li> `Marketing` <li> `Product XYZ` <li> `Corp` <li> `Shared` |
| **Operations commitment** | Level of operations support provided for the workload or resource. | *OpsCommitment* <br><br> <li> `Baseline only` <li> `Enhanced baseline` <li> `Platform operations` <li> `Workload operations` |
| **Operations team** | Team accountable for day-to-day operations. | *OpsTeam* <br><br> <li> `Central IT` <li> `Cloud operations` <li> `ControlCharts team` <li> `MSP-{Managed Service Provider name}` |

## Other common tagging examples

Use the following tags to increase visibility into the usage of Azure resources.

| Tag name | Description | Key and example values |
|--|--|--|
| **Application name** | Added granularity, if the workload is subdivided across multiple applications or services. | *ApplicationName* <br><br> <li> `IssueTrackingSystem` |
| **Approver name** | Person responsible for approving costs related to the resource. | *Approver* <br><br> <li> `chris@contoso.com` |
| **Budget required/approved** | Money approved for the application, service, or workload. | *BudgetAmount* <br><br> <li> `$200,000` |
| **Cost center** | Accounting cost center associated with the resource. | *CostCenter* <br><br> <li> `55332` |
| **Disaster recovery** | Business criticality of the application, workload, or service. | *DR* <br><br> <li> `Mission-critical` <li> `Critical` <li> `Essential` |
| **End date of the project** | Date when the application, workload, or service is scheduled for retirement. | *EndDate* <br><br> <li> `2023-10-15` |
| **Environment** | Deployment environment of the application, workload, or service. | *Env* <br><br> <li> `Prod` <li> `Dev` <li> `QA` <li> `Stage` <li> `Test` |
| **Azure region** | Region where you create the resource. | *AzureRegion* <br><br> <li> `West Europe` <li> `UK South` <li> `East US` <li> `Japan East` <li> `Qatar Central` |
| **Owner name** | Owner of the application, workload, or service. | *Owner* <br><br> <li> `jane@contoso.com` |
| **Requester name** | User who requested the creation of the application. | *Requester* <br><br> <li> `john@contoso.com` |
| **Service class** | Service-level agreement level of the application, workload, or service. | *ServiceClass* <br><br> <li> `Dev` <li> `Bronze` <li> `Silver` <li> `Gold` |
| **Start date of the project** | Date when the application, workload, or service was first deployed. | *StartDate* <br><br> <li> `2020-10-15` |

## Take action

Review the [resource naming and tagging decision guide](./resource-naming-and-tagging-decision-guide.md).

## Next step

Learn how to move resource groups and assets between subscriptions in Azure.

> [!div class="nextstepaction"]
> [Move resource groups and assets between subscriptions](/azure/azure-resource-manager/management/move-resource-group-and-subscription)
