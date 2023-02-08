---
title: 'Complex enterprise governance: Best practices explained'
description: Use the Cloud Adoption Framework for Azure to establish a minimum viable product (MVP) for governance that reflects best practices for a complex enterprise.
author: martinekuan
ms.author: martinek
ms.date: 01/17/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
ms.custom: internal
---

# Complex enterprise governance: Best practices explained

The governance guide begins with a set of initial [corporate policies](./initial-corporate-policy.md). These policies establish a minimum viable product (MVP) for governance that reflects [best practices](./index.md).

This article describes the high-level strategies that are required to create a governance MVP. The core of the governance MVP is the [Deployment Acceleration discipline](../../deployment-acceleration/index.md). At this stage, the tools and patterns that you apply can support incremental improvements to expand governance in the future.

## Governance MVP (initial governance foundation)

You can achieve rapid adoption of governance and corporate policy, thanks to a few principles and cloud-based governance tooling. The following disciplines are the first of the three governance disciplines to use in any governance process. Each discipline is then explored further on in this article.

To establish the starting point, you'll learn about the high-level strategies behind the Security Baseline, Identity Baseline, and Deployment Acceleration disciplines that are required to create a governance MVP. The MVP serves as the foundation for all cloud adoption.

![Diagram showing an example of an incremental governance MVP.](../../../_images/govern/governance-mvp.png)

## Implementation process

Implementing the governance MVP has dependencies on identity, security, and networking. After you resolve the dependencies, the cloud governance team decides on several aspects of the governance. The decisions from the cloud governance team and from other supporting teams result in a single package of enforcement assets.

![Diagram showing the implementation process of a governance MVP.](../../../_images/govern/governance-mvp-implementation-flow.png)

The following checklist describes the implementation process:

1. Solicit decisions regarding core dependencies: identity, network, and encryption.
1. Determine the pattern to use during corporate policy enforcement.
1. Determine the appropriate governance patterns for resource consistency, resource tagging, and logging and reporting.
1. Implement the governance tools aligned to the chosen policy enforcement pattern to apply the dependent decisions and governance decisions.

[!INCLUDE [implementation-process](../../../../includes/implementation-process.md)]

## Application of governance-defined patterns

The cloud governance team is responsible for the following decisions and implementations. Many decisions require input from other teams, but the cloud governance team likely owns both the decisions and implementation. The following sections outline the decisions to make for this use case and details of each decision.

### Subscription design

The decision on what subscription design to use determines how Azure subscriptions are structured and how to use Azure management groups to efficiently manage the access, policies, and compliance for the subscriptions. Refer to the subscription [organization and governance recommendations](../../../ready/landing-zone/design-area/resource-org-subscriptions.md#organization-and-governance-recommendations) for a thorough review of subscription design recommendations.

- As new requests for Azure resources arise, establish a *department* for each major business unit in each operating geography. Within each of the departments, create *subscriptions* for each application archetype.
- An application archetype is a means of grouping applications with similar needs. Common examples include:
  - Applications with protected data and governed applications (such as HIPAA or FedRAMP)
  - Low-risk applications
  - Applications with on-premises dependencies
  - SAP or other mainframe applications in Azure
  - Applications that extend on-premises SAP or mainframe applications

  Each organization has unique needs based on data classifications and the types of applications that support the business. Dependency mapping on the digital estate helps define your organization's application archetypes.
- Adopt a common naming convention as part of the subscription design, based on the previous information.

### Resource consistency

Your resource consistency decisions determine the tools, processes, and efforts required to ensure you configure, deploy, and manage Azure resources consistently within a subscription. In this narrative, [deployment consistency](../../../decision-guides/resource-consistency/index.md#deployment-consistency) is the primary resource consistency pattern.

- Create resource groups for applications using the lifecycle approach. Everything that's created, maintained, and retired together should reside in a single resource group. For more information, see the [resource consistency decision guide](../../../decision-guides/resource-consistency/index.md#basic-grouping).
- Apply Azure Policy to all subscriptions from the associated management group.
- As part of the deployment process, store Azure resource consistency templates for the resource group in source control.
- Each resource group is associated with a specific workload or application based on the lifecycle approach described previously.
- Azure management groups let you update governance designs as corporate policy matures.
- Extensive implementation of Azure Policy could exceed the team's time commitments and might not provide a great deal of value at this time. Create a default policy and apply it to each management group to enforce the small number of current cloud governance policy statements. This policy defines the implementation of specific governance requirements. You can apply those implementations across all deployed assets.

> [!IMPORTANT]
> Any time a resource in a resource group no longer shares the same lifecycle, move it to another resource group. Examples include common databases and networking components. While they might serve the application being developed, they might also serve other purposes and should therefore exist in other resource groups.

### Resource tagging

Resource tagging decisions determine how metadata applies to Azure resources within a subscription to support operations, management, and accounting purposes. In this narrative, the [accounting](../../../ready/azure-best-practices/resource-naming-and-tagging-decision-guide.md#resource-tagging-patterns) pattern is chosen as the default model for resource tagging.

- Tag deployed assets with values for:
  - Department or billing unit
  - Geography
  - Data classification
  - Criticality
  - SLA
  - Environment
  - Application archetype
  - Application
  - Application owner
- These values, along with the Azure management group and subscription associated with a deployed asset, drive governance, operations, and security decisions.

### Logging and reporting

Logging and reporting decisions determine how you store log data. They also determine how the monitoring and reporting tools that keep IT staff informed on operational health are structured. In this narrative a [hybrid monitoring](../../../decision-guides/logging-and-reporting/index.md) pattern for logging and reporting is suggested, but not required for any development team at this point.

- No governance requirements are currently set regarding the specific data points to be collected for logging or reporting purposes. It's specific to this fictional narrative and should be considered an antipattern. Determine and enforce logging standards as soon as possible.
- More analysis is required before the release of any protected data or mission-critical workloads.
- Before you support protected data or mission-critical workloads, you must grant the existing on-premises operational monitoring solution access to the workspace you use for logging. Applications must meet security and logging requirements associated with the use of that tenant, if the application is to be supported with a defined SLA.

## Incremental governance processes

Some of the policy statements can't or shouldn't be controlled by automated tooling. Other policies require periodic effort from IT security and on-premises identity baseline teams. The cloud governance team needs to oversee the following processes to implement the last eight policy statements:

**Corporate policy changes:** The cloud governance team makes changes to the governance MVP design to adopt the new policies. The value of the governance MVP is that it lets you automatically enforce the new policies.

**Adoption acceleration:** The cloud governance team reviews deployment scripts across multiple teams. They maintain a set of scripts that serve as deployment templates. The cloud adoption and DevOps teams use the templates to more quickly define deployments. Those scripts contain the necessary requirements to enforce a set of governance policies with no extra effort from cloud adoption engineers. As the curators of these scripts, the cloud governance team can more quickly implement policy changes. As a result of script curation, the cloud governance team is the source of adoption acceleration, which creates consistency among deployments, without strictly forcing adherence.

**Engineer training:** The cloud governance team offers bimonthly training sessions and has created two videos for engineers. Both resources help engineers get up to speed quickly on the governance culture and learn how to do the deployments. The team is adding training assets to demonstrate the difference between production and nonproduction deployments, which helps engineers understand how the new policies affect adoption. The training ensures consistent deployments without strictly enforcing adherence.

**Deployment planning:** Before you deploy any asset containing protected data, the cloud governance team reviews deployment scripts to validate governance alignment. Existing teams with previously approved deployments are audited using programmatic tooling.

**Monthly audit and reporting:** Each month, the cloud governance team runs an audit of all cloud deployments to validate continued alignment to policy. When deviations are discovered, they're documented and shared with the cloud adoption teams. When enforcement doesn't risk a business interruption or data leak, the policies are automatically enforced. At the end of the audit, the cloud governance team compiles a report for the cloud strategy team and each cloud adoption team to communicate overall adherence to policy. The report is also stored for auditing and legal purposes.

**Quarterly policy review:** Each quarter, the cloud governance and cloud strategy teams meet to review audit results and suggest changes to corporate policy. Many of those suggestions are the result of continuous improvements and observing usage patterns. The teams integrate approved policy changes into governance tooling during subsequent audit cycles.

## Alternative patterns

If any of the patterns in this governance guide don't align with your requirements, you can explore the alternatives:

- [Encryption patterns](../../../decision-guides/encryption/index.md)
- [Identity patterns](../../../decision-guides/identity/index.md)
- [Logging and reporting patterns](../../../decision-guides/logging-and-reporting/index.md)
- [Policy enforcement patterns](../../policy-compliance/policy-definition.md)
- [Resource consistency patterns](../../../decision-guides/resource-consistency/index.md)
- [Resource tagging patterns](../../../ready/azure-best-practices/resource-naming-and-tagging-decision-guide.md)
- [Software Defined Networking patterns](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/landing-zone/design-area/network-topology-and-connectivity)
- [Subscription design patterns](../../../ready/landing-zone/design-area/resource-org-subscriptions.md)

## Next steps

After your cloud adoption team implements this guidance, they can proceed with a solid governance foundation. At the same time, the cloud governance team works to continually update the corporate policies and governance disciplines.

Both teams use the tolerance indicators to identify the next set of improvements required to continue supporting cloud adoption. The next step for the company is to do incremental improvements of their governance baseline in support of applications with legacy or third-party multifactor authentication requirements.

> [!div class="nextstepaction"]
> [Improve the Identity Baseline discipline](./identity-baseline-improvement.md)
