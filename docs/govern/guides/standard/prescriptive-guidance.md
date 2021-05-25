---
title: "Standard enterprise governance: Best practices explained"
description: Use the Cloud Adoption Framework for Azure to establish a minimum viable product (MVP) for governance that reflects best practices for a standard enterprise.
author: BrianBlanchard
ms.author: brblanch
ms.date: 09/05/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
ms.custom: internal
---

# Standard enterprise governance guide: Best practices explained

The governance guide starts with a set of initial [corporate policies](./initial-corporate-policy.md). These policies are used to establish a governance MVP that reflects [best practices](./index.md).

In this article, we discuss the high-level strategies that are required to create a governance MVP. The core of the governance MVP is the [Deployment Acceleration discipline](../../deployment-acceleration/index.md). The tools and patterns applied at this stage will enable the incremental improvements needed to expand governance in the future.

## Governance MVP (initial governance foundation)

Rapid adoption of governance and corporate policy is achievable, thanks to a few simple principles and cloud-based governance tooling. These are the first three disciplines to approach in any governance process. Each discipline will be further described in this article.

To establish the starting point, this article discusses the high-level strategies behind the Security Baseline, Identity Baseline, and Deployment Acceleration disciplines that are required to create a governance MVP, which will serve as the foundation for all adoption.

![Diagram showing an example of an incremental governance MVP.](../../../_images/govern/governance-mvp.png)

## Implementation process

The implementation of the governance MVP has dependencies on identity, security, and networking. Once the dependencies are resolved, the cloud governance team will decide a few aspects of governance. The decisions from the cloud governance team and from supporting teams will be implemented through a single package of enforcement assets.

![Diagram showing the implementation process of a governance MVP.](../../../_images/govern/governance-mvp-implementation-flow.png)

This implementation can also be described using a simple checklist:

1. Solicit decisions regarding core dependencies: identity, networking, monitoring, and encryption.
2. Determine the pattern to be used during corporate policy enforcement.
3. Determine the appropriate governance patterns for the resource consistency, resource tagging, and logging and reporting disciplines.
4. Implement the governance tools aligned to the chosen policy enforcement pattern to apply the dependent decisions and governance decisions.

[!INCLUDE [implementation-process](../../../../includes/implementation-process.md)]

## Application of governance-defined patterns

The cloud governance team is responsible for the following decisions and implementations. Many require inputs from other teams, but the cloud governance team is likely to own both the decision and the implementation. The following sections outline the decisions made for this use case and details of each decision.

### Subscription design

The decision on what subscription design to use determines how Azure subscriptions get structured and how Azure management groups will be used to efficiently manage access, policies, and compliance of these subscription. In this narrative, the governance team has established subscriptions for production and nonproduction workloads [production-and-nonproduction](../../../ready/azure-best-practices/initial-subscriptions.md) subscription design pattern.

- Departments are not likely to be required given the current focus. Deployments are expected to be constrained within a single billing unit. At the stage of adoption, there may not even be an Enterprise Agreement to centralize billing. It's likely that this level of adoption is being managed by a single pay-as-you-go Azure subscription.
- Regardless of the use of the EA portal or the existence of an Enterprise Agreement, a subscription model should still be defined and agreed on to minimize administrative overheard beyond just billing.
- A common naming convention should be agreed on as part of the subscription design, based on the previous two points.

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

Resource tagging decisions determine how metadata is applied to Azure resources within a subscription to support operations, management, and accounting purposes. In this narrative, the [classification](../../../decision-guides/resource-tagging/index.md#resource-tagging-patterns) pattern has been chosen as the default model for resource tagging.

- Deployed assets should be tagged with:
  - Data classification
  - Criticality
  - SLA
  - Environment
- These four values will drive governance, operations, and security decisions.
- If this governance guide is being implemented for a business unit or team within a larger corporation, tagging should also include metadata for the billing unit.

### Logging and reporting

Logging and reporting decisions determine how your store log data and how the monitoring and reporting tools that keep IT staff informed on operational health are structured. In this narrative, a [cloud-native pattern](../../../decision-guides/logging-and-reporting/index.md#cloud-native)** for logging and reporting is suggested.

## Incremental improvement of governance processes

As governance changes, some policy statements can't or shouldn't be controlled by automated tooling. Other policies will result in effort by the IT security team and the on-premises identity management team over time. To help manage new risks as they arise, the cloud governance team will oversee the following processes.

**Adoption acceleration:** The cloud governance team has been reviewing deployment scripts across multiple teams. They maintain a set of scripts that serve as deployment templates. Those templates are used by the cloud adoption and DevOps teams to define deployments more quickly. Each of those scripts contains the necessary requirements to enforce a set of governance policies with no additional effort from cloud adoption engineers. As the curators of these scripts, the cloud governance team can more quickly implement policy changes. As a result of script curation, the cloud governance team is seen as a source of adoption acceleration. This creates consistency among deployments, without strictly forcing adherence.

**Engineer training:** The cloud governance team offers bimonthly training sessions and has created two videos for engineers. These materials help engineers quickly learn the governance culture and how things are done during deployments. The team is adding training assets that show the difference between production and nonproduction deployments, so that engineers will understand how the new policies will affect adoption. This creates consistency among deployments, without strictly forcing adherence.

**Deployment planning:** Before deploying any asset containing protected data, the cloud governance team will review deployment scripts to validate governance alignment. Existing teams with previously approved deployments will be audited using programmatic tooling.

**Monthly audit and reporting:** Each month, the cloud governance team runs an audit of all cloud deployments to validate continued alignment to policy. When deviations are discovered, they're documented and shared with the cloud adoption teams. When enforcement doesn't risk a business interruption or data leak, the policies are automatically enforced. At the end of the audit, the cloud governance team compiles a report for the cloud strategy team and each cloud adoption team to communicate overall adherence to policy. The report is also stored for auditing and legal purposes.

**Quarterly policy review:** Each quarter, the cloud governance team and the cloud strategy team will review audit results and suggest changes to corporate policy. Many of those suggestions are the result of continuous improvements and the observation of usage patterns. Approved policy changes are integrated into governance tooling during subsequent audit cycles.

## Alternative patterns

If any of the patterns selected in this governance guide don't align with the reader's requirements, alternatives to each pattern are available:

- [Encryption patterns](../../../decision-guides/encryption/index.md)
- [Identity patterns](../../../decision-guides/identity/index.md)
- [Logging and reporting patterns](../../../decision-guides/logging-and-reporting/index.md)
- [Policy enforcement patterns](../../../decision-guides/policy-enforcement/index.md)
- [Resource consistency patterns](../../../decision-guides/resource-consistency/index.md)
- [Resource tagging patterns](../../../decision-guides/resource-tagging/index.md)
- [Software Defined Networking patterns](../../../decision-guides/software-defined-network/index.md)
- [Subscription design patterns](../../../decision-guides/subscriptions/index.md)

## Next steps

Once this guide is implemented, each cloud adoption team can go forth with a sound governance foundation. At the same time, the cloud governance team will work to continuously update the corporate policies and governance disciplines.

The two teams will use the tolerance indicators to identify the next set of improvements needed to continue supporting cloud adoption. For the fictional company in this guide, the next step is improving the security baseline to support moving protected data to the cloud.

> [!div class="nextstepaction"]
> [Improve the Security Baseline discipline](./security-baseline-improvement.md)
