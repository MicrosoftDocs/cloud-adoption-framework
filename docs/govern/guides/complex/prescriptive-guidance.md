---
title: "Complex enterprise governance: Best practices explained"
description: Use the Cloud Adoption Framework for Azure to establish a minimum viable product (MVP) for governance that reflects best practices for a complex enterprise.
author: BrianBlanchard
ms.author: brblanch
ms.date: 09/05/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
ms.custom: internal
---

# Governance guide for complex enterprises: Best practices explained

The governance guide begins with a set of initial [corporate policies](./initial-corporate-policy.md). These policies are used to establish a minimum viable product (MVP) for governance that reflects [best practices](./index.md).

In this article, we discuss the high-level strategies that are required to create a governance MVP. The core of the governance MVP is the [Deployment Acceleration discipline](../../deployment-acceleration/index.md). The tools and patterns applied at this stage will enable the incremental improvements needed to expand governance in the future.

## Governance MVP (initial governance foundation)

Rapid adoption of governance and corporate policy is achievable, thanks to a few simple principles and cloud-based governance tooling. These are the first of the three governance disciplines to approach in any governance process. Each discipline will be explained further on in this article.

To establish the starting point, this article discusses the high-level strategies behind the Security Baseline, Identity Baseline, and Deployment Acceleration disciplines that are required to create a governance MVP. The MVP serves as the foundation for all cloud adoption.

![Diagram showing an example of an incremental governance MVP.](../../../_images/govern/governance-mvp.png)

## Implementation process

The implementation of the governance MVP has dependencies on identity, security, and networking. Once the dependencies are resolved, the cloud governance team will decide a few aspects of governance. The decisions from the cloud governance team and from supporting teams will be implemented through a single package of enforcement assets.

![Diagram showing the implementation process of a governance MVP.](../../../_images/govern/governance-mvp-implementation-flow.png)

This implementation can also be described using a simple checklist:

1. Solicit decisions regarding core dependencies: identity, network, and encryption.
1. Determine the pattern to be used during corporate policy enforcement.
1. Determine the appropriate governance patterns for resource consistency, resource tagging, and logging and reporting.
1. Implement the governance tools aligned to the chosen policy enforcement pattern to apply the dependent decisions and governance decisions.

[!INCLUDE [implementation-process](../../../../includes/implementation-process.md)]

## Application of governance-defined patterns

The cloud governance team will be responsible for the following decisions and implementations. Many will require inputs from other teams, but the cloud governance team is likely to own both the decision and implementation. The following sections outline the decisions made for this use case and details of each decision.

### Subscription design

The decision on what subscription design to use determines how Azure subscriptions get structured and how Azure management groups will be used to efficiently manage access, policies, and compliance of these subscription. In this narrative, the governance team has chosen a [mixed subscription strategy](../../../decision-guides/subscriptions/index.md#mix-subscription-strategies).

- As new requests for Azure resources arise, a *department* should be established for each major business unit in each operating geography. Within each of the departments, *subscriptions* should be created for each application archetype.
- An application archetype is a means of grouping applications with similar needs. Common examples include:
  - Applications with protected data, governed applications (such as HIPAA or FedRAMP).
  - Low-risk applications.
  - Applications with on-premises dependencies.
  - SAP or other mainframe applications in Azure.
  - Applications that extend on-premises SAP or mainframe applications.

  Each organization has unique needs based on data classifications and the types of applications that support the business. Dependency mapping of the digital estate can help define the application archetypes in an organization.
- A common naming convention should be adopted as part of the subscription design, based on the above.

### Resource consistency

Resource consistency decisions determine the tools, processes, and effort required to ensure Azure resources are deployed, configured, and managed consistently within a subscription. In this narrative, [deployment consistency](../../../decision-guides/resource-consistency/index.md#deployment-consistency) has been chosen as the primary resource consistency pattern.

- Resource groups are created for applications using the lifecycle approach. Everything that is created, maintained, and retired together should reside a single resource group. For more information, see the [resource consistency decision guide](../../../decision-guides/resource-consistency/index.md#basic-grouping).
- Azure Policy should be applied to all subscriptions from the associated management group.
- As part of the deployment process, Azure resource consistency templates for the resource group should be stored in source control.
- Each resource group is associated with a specific workload or application based on the lifecycle approach described above.
- Azure management groups enable updating governance designs as corporate policy matures.
- Extensive implementation of Azure Policy could exceed the team's time commitments and may not provide a great deal of value at this time. A simple default policy should be created and applied to each management group to enforce the small number of current cloud governance policy statements. This policy will define the implementation of specific governance requirements. Those implementations can then be applied across all deployed assets.

> [!IMPORTANT]
> Any time a resource in a resource group no longer shares the same lifecycle, it should be moved to another resource group. Examples include common databases and networking components. While they may serve the application being developed, they may also serve other purposes and should therefore exist in other resource groups.

### Resource tagging

Resource tagging decisions determine how metadata is applied to Azure resources within a subscription to support operations, management, and accounting purposes. In this narrative, the [accounting](../../../decision-guides/resource-tagging/index.md#resource-tagging-patterns) pattern has been chosen as the default model for resource tagging.

- Deployed assets should be tagged with values for:
  - Department or billing unit
  - Geography
  - Data classification
  - Criticality
  - SLA
  - Environment
  - Application archetype
  - Application
  - Application owner
- These values, along with the Azure management group and subscription associated with a deployed asset, will drive governance, operations, and security decisions.

### Logging and reporting

Logging and reporting decisions determine how your store log data and how the monitoring and reporting tools that keep IT staff informed on operational health are structured. In this narrative a [hybrid monitoring](../../../decision-guides/logging-and-reporting/index.md) pattern for logging and reporting is suggested, but not required of any development team at this point.

- No governance requirements are currently set regarding the specific data points to be collected for logging or reporting purposes. This is specific to this fictional narrative and should be considered an antipattern. Logging standards should be determined and enforced as soon as possible.
- Additional analysis is required before the release of any protected data or mission-critical workloads.
- Before supporting protected data or mission-critical workloads, the existing on-premises operational monitoring solution must be granted access to the workspace used for logging. Applications are required to meet security and logging requirements associated with the use of that tenant, if the application is to be supported with a defined SLA.

## Incremental of governance processes

Some of the policy statements cannot or should not be controlled by automated tooling. Other policies will require periodic effort from IT security and on-premises identity baseline teams. The cloud governance team will need to oversee the following processes to implement the last eight policy statements:

**Corporate policy changes:** The cloud governance team will make changes to the governance MVP design to adopt the new policies. The value of the governance MVP is that it will allow for the automatic enforcement of the new policies.

**Adoption acceleration:** The cloud governance team has been reviewing deployment scripts across multiple teams. They've maintained a set of scripts that serve as deployment templates. Those templates can be used by the cloud adoption teams and DevOps teams to more quickly define deployments. Each script contains the requirements for enforcing governance policies, and additional effort from cloud adoption engineers is not needed. As the curators of these scripts, they can implement policy changes more quickly. Additionally, they're viewed as accelerators of adoption. This ensures consistent deployments without strictly enforcing adherence.

**Engineer training:** The cloud governance team offers bimonthly training sessions and has created two videos for engineers. Both resources help engineers get up to speed quickly on the governance culture and how deployments are performed. The team is adding training assets to demonstrate the difference between production and nonproduction deployments, which helps engineers understand how the new policies affect adoption. This ensures consistent deployments without strictly enforcing adherence.

**Deployment planning:** Before deploying any asset containing protected data, the cloud governance team will be responsible for reviewing deployment scripts to validate governance alignment. Existing teams with previously approved deployments will be audited using programmatic tooling.

**Monthly audit and reporting:** Each month, the cloud governance team runs an audit of all cloud deployments to validate continued alignment to policy. When deviations are discovered, they're documented and shared with the cloud adoption teams. When enforcement doesn't risk a business interruption or data leak, the policies are automatically enforced. At the end of the audit, the cloud governance team compiles a report for the cloud strategy team and each cloud adoption team to communicate overall adherence to policy. The report is also stored for auditing and legal purposes.

**Quarterly policy review:** Each quarter, the cloud governance team and the cloud strategy team to review audit results and suggest changes to corporate policy. Many of those suggestions are the result of continuous improvements and the observation of usage patterns. Approved policy changes are integrated into governance tooling during subsequent audit cycles.

## Alternative patterns

If any of the patterns chosen in this governance guide don't align with the reader's requirements, alternatives to each pattern are available:

- [Encryption patterns](../../../decision-guides/encryption/index.md)
- [Identity patterns](../../../decision-guides/identity/index.md)
- [Logging and reporting patterns](../../../decision-guides/logging-and-reporting/index.md)
- [Policy enforcement patterns](../../../decision-guides/policy-enforcement/index.md)
- [Resource consistency patterns](../../../decision-guides/resource-consistency/index.md)
- [Resource tagging patterns](../../../decision-guides/resource-tagging/index.md)
- [Software Defined Networking patterns](../../../decision-guides/software-defined-network/index.md)
- [Subscription design patterns](../../../decision-guides/subscriptions/index.md)

## Next steps

Once this guidance is implemented, each cloud adoption team can proceed with a solid governance foundation. At the same time, the cloud governance team will work to continually update the corporate policies and governance disciplines.

Both teams will use the tolerance indicators to identify the next set of improvements needed to continue supporting cloud adoption. The next step for this company is incremental improvement of their governance baseline to support applications with legacy or third-party multi-factor authentication requirements.

> [!div class="nextstepaction"]
> [Improve the Identity Baseline discipline](./identity-baseline-improvement.md)
