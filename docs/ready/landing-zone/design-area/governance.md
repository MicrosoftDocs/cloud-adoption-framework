---
title: Governance
description: Design area guidance for governing your Azure environment
author: DominicAllen
ms.author: doalle
ms.date: 8/1/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Design area: Azure governance

As organizations begin their cloud adoption journey, starting with strong controls in place to government environments is an important success criteria.

Governance provides mechanisms and processes to maintain control over your applications and resources in Azure.

![Landing Zone image](../../enterprise-scale/media/lz-design.png)

At part of the design area review, explore the considerations and recommendations outlined here in order to make informed decisions as you plan your landing zone. 

The governance design area focusses on the considerations and recommendations for design decisions as part of the landing zone. In addition to this, the [Govern methodology](/govern/index.md) in the Cloud Adoption Framework provides further in-depth guidance for holistic governance processes and tools. 

The govern methodology is formed of five disciplines:

|Discipline|Context|
|-|-|
| Cost Management| Explore guidance to cost reporting control techniques|
| Security baseline| Explore this further as part of the [Security design area](./security.md)|
| Resource consistency| Explore guidance for naming and tagging resources as part of environment governance |
| Identity baseline| Covered in depth as part of the [Identity and Access Management](./identity-access.md) design area|
| Deployment acceleration| Explore this further as part of the [Platform automation and DevOps](./platform-automation-devops.md) design area|


## Azure governance considerations

### Cost management considerations

- How is the organizations cost and recharging model structured? What are the key data points required in order to accurately reflect spend on cloud services?
- Tagging resources can make the process of tracking and allocating cloud spend easier, find the structure of tags that best fits your cost and recharging model.
-	Azure Pricing Calculator can be used to estimate the expected monthly costs for using any combination of Azure products.
-	Azure Hybrid Benefit helps to significantly reduce the costs of running your workloads in the cloud. It works by letting you use your on-premises Software Assurance-enabled Windows Server and SQL Server licenses on Azure. This benefit applies to RedHat and SUSE Linux subscriptions, too.
- Azure Reservations helps you to save money by committing to one-year or three-year plans for multiple products. Committing allows you to get a discount on the resources you use. Reservations can significantly reduce your resource costs by up to 72% from pay-as-you-go prices. 
- Azure Policies can be used to allow specific regions, resource types and resource SKUs.
-	Azure Storage lifecycle management offers a rule-based policy that you can use to transition blob data to the appropriate and cheaper access tiers or to expire data at the end of the data lifecycle.
-	Azure Dev/Test subscriptions gives you access to select Azure services for nonproduction workloads at discounted pricing.
-	Use autoscaling and save costs by dynamically allocating and de-allocating resources to match your performance needs.
-	Using Azure Spot Virtual Machines allows you to take advantage of our unused capacity at a significant cost savings. Azure Spot Virtual Machines are great for workloads that can handle interruptions like batch processing jobs, dev/test environments, large compute workloads, and more.
-	Some Azure services are free for 12 month and other services are always free. Selecting the right Azure services helps you to reduce costs.
- Azure offers many ways to host your code. Operate more cost efficiently by selecting the right compute service for your application.

### Resource consistency considerations

- What are the groups of resources in your environment that share configuration characteristics that you will require to be keep consistent?
- Are there groups of resources that should share a common lifecycle?
- Are there groups of resources that should share common access constraints (e.g. role-based access contorls)
- Are there standard resource configurations within your organization that should be used to ensure a consistent baseline configuration?


### Azure Policy - Design considerations

Azure Policy is essential to ensuring security and compliance within enterprise technical estates. It can enforce vital management and security conventions across Azure platform services. It can also supplement Azure role-based access control that controls what actions authorized users can do.

- Determine what Azure policies are needed.

- Enforce management and security conventions, such as the use of private endpoints.

- Manage and create policy assignments by using policy definitions can be reused at multiple inherited assignment scopes. You can have centralized, baseline policy assignments at management group, subscription, and resource group scopes.

- Ensure continuous compliance with compliance reporting and auditing.

- Understand that Azure Policy has limits, such as the restriction of definitions at any particular scope: [policy limits](/azure/azure-resource-manager/management/azure-subscription-service-limits).

- Understand regulatory compliance policies. The policies might include HIPAA, PCI DSS, or SOC 2 Trust Services Criteria.

## Azure governance recommendations

### Cost management recommendations

- Use tools such as Azure Cost management and billing to implement financial oversight on resources in your environment
- Use tools such as tags in Azure to append metadata to resources to enable granular analysis of spend - for example, cost centre or project name

### Azure Policy - Design recommendations

- Identify required Azure tags and use the append policy mode to enforce usage.

- Map regulatory and compliance requirements to Azure Policy definitions and Azure role assignments.

- Establish Azure Policy definitions at the top-level root management group so that they can be assigned at inherited scopes.

- Manage policy assignments at the highest appropriate level with exclusions at bottom levels, if necessary.

- Use Azure Policy to control resource provider registrations at the subscription or management group levels.

- Use built-in policies where possible to minimize operational overhead.

- Assign the built-in Resource Policy Contributor role at a particular scope to enable application-level governance.

- Limit the number of Azure Policy assignments made at the root management group scope to avoid managing through exclusions at inherited scopes.

## Azure governance in the Azure landing zone accelerator

The Azure landing zone accelerator implementation includes capabilities to help organizations get to mature governance controls, quickly.

For example:

- a management group hierarchy that groups resources by function or workload type to encourage best practices for resource consistency, as described above
- a rich set of Azure policies that enable governance controls at management group level to ensure all resources are in scope
