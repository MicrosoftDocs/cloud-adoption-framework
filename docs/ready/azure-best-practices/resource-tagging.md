---
title: Tag your Azure resources
description: Review recommendations for tagging your Azure resources and assets.
author: BrianBlanchard
ms.author: brblanch
ms.date: 11/20/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: readiness, fasttrack-edit, internal
---

# Tag your Azure resources

When you apply metadata tags to your cloud resources, you can include information about those assets that couldn't be included in the resource name. You can use that information to perform more sophisticated filtering and reporting on resources. You want these tags to include context about the resource's associated workload or application, operational requirements, and ownership information. This information can be used by IT or business teams to find resources or generate reports about resource usage and billing.

What tags you apply to resources and what tags are required or optional differs among organizations. The following list provides examples of common tags that capture important context and information about a resource. Use this list as a starting point to establish your own tagging conventions.

## Tagging examples

| Tag Name | Description | Key | Example value |
|--|--|--|--|
| **Application name** | Name of the application, service, or workload the resource is associated with. | _ApplicationName_ | _{application name}_ |
| **Approver name** | Person responsible for approving costs related to this resource. | _Approver_ | _{email}_ |
| **Budget required/approved** | Money allocated for this application, service, or workload. | _BudgetAmount_ | _{\$}_ |
| **Business unit** | Top-level division of your company that owns the subscription or workload the resource belongs to. In smaller organizations, this tag might represent a single corporate or shared top-level organizational element. | _BusinessUnit_ | _FINANCE_, _MARKETING_, _{Product Name}_, _CORP_, _SHARED_ |
| **Cost center** | Accounting cost center associated with this resource. | _CostCenter_ | _{number}_ |
| **Disaster recovery** | Business criticality of the application, workload, or service. | _DR_ | _Mission-critical_, _Critical_, _Essential_ |
| **End date of the project** | Date when the application, workload, or service is scheduled for retirement. | _EndDate_ | _{date}_ |
| **Environment** | Deployment environment of the application, workload, or service. | _Env_ | _Prod_, _Dev_, _QA_, _Stage_, _Test_ |
| **Owner name** | Owner of the application, workload, or service. | _Owner_ | _{email}_ |
| **Requester name** | User who requested the creation of this application. | _Requester_ | _{email}_ |
| **Service class** | Service level agreement level of the application, workload, or service. | _ServiceClass_ | _Dev_, _Bronze_, _Silver_, _Gold_ |
| **Start date of the project** | Date when the application, workload, or service was first deployed. | _StartDate_ | _{date}_ |
