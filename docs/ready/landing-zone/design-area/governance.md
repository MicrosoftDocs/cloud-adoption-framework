---
title: Azure governance design area guidance
description: Design area guidance for governing your Azure environment
author: DominicAllen
ms.author: doalle
ms.date: 12/3/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Design area: Azure governance

Azure governance establishes the tooling needed to support cloud governance, compliance auditing, and automated guardrails.

## Design area review

**Involved roles or functions:** Azure governance is led by [cloud governance](../../../organize/cloud-governance.md). The [cloud platform](../../../organize/cloud-platform.md) and [cloud center of excellence](../../../organize/cloud-center-of-excellence.md) might be required to define and implement some technical requirements. Governance focuses on the enforcement of operations and security requirements, which might require [cloud security](../../../organize/cloud-security.md), [central IT](../../../organize/cloud-security.md) or [cloud operations](../../../organize/cloud-operations.md).

**Scope:** Review decisions made during reviews of [identity](./identity-access.md), [network](./network-topology-and-connectivity.md), [security](./security.md), and [management](./management.md) design areas. The team might compare review decisions from automated governance, which is part of the Azure landing zone accelerator. Review decisions might help determine what can be audited or enforced. Review decisions might evaluate what policies can be automatically deployed.

**Out of scope:** Azure governance establishes the foundation for networking. However, it doesn't address compliance-related articles such as advanced network security or automated guardrails to enforce networking decisions. These networking decisions might be addressed when reviewing compliance design areas related to [security](./security.md) and [governance](./governance.md). Delaying the discussions might allow the cloud platform team to address initial networking requirements before addressing more complex articles.

## Design area overview

An organizations cloud adoption journey starts with strong controls to government environments.

Governance provides mechanisms and processes for maintaining control over platforms, applications, and resources in Azure.

![Landing zone image](../../enterprise-scale/media/lz-design.png)

The design area review explores the considerations and recommendations that help you make informed decisions as you plan your landing zone.

The governance design area focuses on the design decisions in the landing zone. Also, the [Govern methodology](/azure/cloud-adoption-framework/govern/index) in the Cloud Adoption Framework gives guidance for governance processes and tools.

The Govern methodology consists of five disciplines:

|Discipline|Context|
|-|-|
| Cost management| Explore guidance to cost reporting control techniques|
| Security baseline| Explore further in the [security design area](./security.md)|
| Resource consistency| Explore guidance for naming and tagging resources in the environment governance |
| Identity baseline| Covered in depth in the [identity and access management](./identity-access.md) design area|
| Deployment acceleration| Explore further in the [platform automation and DevOps](./platform-automation-devops.md) design area|

## Azure governance considerations

Azure policy ensures security and compliance for enterprise technical estates. Azure policy might enforce vital management and security conventions across Azure platform services. Azure policy supplements Azure role-based access control, which controls authorized users actions. Also, Azure Cost Management + Billing might help support your ongoing governance cost and spending in Azure, or other multicloud environments.

### Deployment acceleration considerations

Change advisory review boards might hinder an organizations innovation and business agility. Azure Policy increases workload efficiency by replacing such reviews with automated guardrails and adherence audits.

- Determine what Azure policies are needed based on your business controls or compliance regulations. Use the policies included in the Azure landing zone accelerator as a stating point.
- Use the [standards-based blueprint samples](/azure/governance/blueprints/samples) to consider other policies that might align to your business requirements.
- Enforce networking, identity, management, and security conventions are often automated.
- Manage and create policy assignments by using policy definitions, which might be reused at multiple inherited assignment scopes. You can have centralized baseline policy assignments at management, subscription, and resource group scopes.
- Ensure continuous compliance with compliance reporting and auditing.
- Understand that Azure Policy has limits, such as the restriction of definitions at any particular scope: [policy limits](/azure/azure-resource-manager/management/azure-subscription-service-limits).
- Understand regulatory compliance policies. The policies might include HIPAA, PCI-DSS, or SOC 2 Trust Services Criteria.

### Cost management considerations

- How is the organizations cost and recharging model structured? What are the key data points required to accurately see cloud services spend?
- Finding the structure of tags that fits your cost and recharging model might help track your cloud spend.
- Azure pricing calculator can be used to estimate the expected monthly costs for using any combination of Azure products.
- Azure Hybrid Benefit might help reduce the costs of running your workloads in the cloud. You can use your on-premises Software Assurance-enabled Windows Server and SQL Server licenses on Azure. It also applies to Red Hat and SUSE Linux subscriptions.
- Azure Reservations helps you save money by committing to one-year or three-year plans for multiple products. Committing let's you get resource discounts, which might significantly reduce your resource costs by up to 72% from pay-as-you-go prices.
- Azure policies can be used to allow specific regions, resource types, and resource SKUs.
- Azure Storage lifecycle management offers a rule-based policy. The policy might be used to move blob data to the appropriate access tiers, or to expire data at the end of the data lifecycle.
- Azure dev/test subscriptions give you access to select Azure services for nonproduction workloads at discounted pricing.
- Use autoscaling to save costs by dynamically allocating and de-allocating resources to match your performance needs.
- Using Azure spot virtual machines allows you to take advantage of our unused capacity at a significant cost savings. Azure spot virtual machines are great for workloads that can handle interruptions. For example, batch processing jobs, dev/test environments, large compute workloads, and more.
- Some Azure services are free for 12 months while some other services are always free. Selecting the right Azure services helps you reduce costs.
- Selecting the right compute service for your application can help with cost efficiency. Azure offers many ways to host your code.

### Resource consistency considerations

- What are the groups of resources in your environment? These groups can share configuration characteristics that might be required to help stay consistent.
- Is the application or workload subscription design the most appropriate for your operation needs?
- Are there groups of resources that should share a common lifecycle?
- Are there groups of resources that should share common access constraints (such as Role-based access control)?
- Are there standard resource configurations within your organization that might be used to ensure a consistent baseline configuration?
- Explore how [tools in Azure can support resource consistency](/azure/cloud-adoption-framework/govern/resource-consistency/toolchain) in your landing zone.

### Security baseline considerations

- What tools and guardrails need to be enforced across the environment as part of a security baseline?
- Who might be notified when deviations are found?
- Consider using Azure Policy to enforce tools (such as Microsoft Defender for Cloud, Microsoft Defender for Cloud).
- Consider using Azure Policy to enforce guardrails (such as the Azure Security Benchmark).

### Identity management considerations

- Who might have access to audit logs for identity and access management?
- Who might be notified when suspicious sign-in events occur?
- Consider using [Azure Active Directory reports](/azure/active-directory/reports-monitoring/overview-reports#:~:text=%20There%20are%20two%20types%20of%20activity%20reports,tasks%20reported%20by%20the%20audit%20logs...%20More%20) to govern activity.
- Consider the logs from Azure AD, which might be sent to the central Log Analytics workspace for the platform.
- Explore the capabilities of [Azure AD access reviews](/azure/active-directory/governance/access-reviews-overview) in your landing zone governance approach.
- Explore the capabilities of [Azure AD entitlement management](/azure/active-directory/governance/entitlement-management-overview) in your landing zone governance approach.

## Azure governance recommendations

### Deployment acceleration recommendations

- Identify required Azure tags and use the append policy mode to enforce usage. Use the [tagging strategy](../../azure-best-practices/resource-tagging.md) article as a starting point
- Map regulatory and compliance requirements to Azure Policy definitions and Azure role assignments.
- Establish Azure Policy definitions at the top-level root management group as they might be assigned at inherited scopes.
- Manage policy assignments at the highest appropriate level with exclusions at bottom levels, if necessary.
- Use Azure Policy to control resource provider registrations at the subscription or management group levels.
- Use built-in policies to minimize operational overhead.
- Assign the built-in Resource Policy Contributor role at a particular scope to enable application-level governance.
- Limit the number of Azure Policy assignments made at the root management group scope to avoid managing through exclusions at inherited scopes.

### Cost management recommendations

- Use Azure Cost Management + Billing to implement financial oversight on resources in your environment.
- Use tags in Azure to append metadata to resources, which might enable granular analysis of spend (such as cost center or project name).

## Azure governance in the Azure landing zone accelerator

The Azure landing zone accelerator implementation includes capabilities to help organizations efficiently get mature governance controls.

For example:

- A management group hierarchy that groups resources by function or workload type might encourage best practices for resource consistency.
- A rich set of Azure policies might enable governance controls at management group level to ensure all resources are in scope.
