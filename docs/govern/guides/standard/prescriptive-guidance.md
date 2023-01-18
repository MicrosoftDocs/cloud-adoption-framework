---
title: 'Standard enterprise governance: Best practices explained'
description: Use the Cloud Adoption Framework for Azure to establish a minimum viable product (MVP) for governance that reflects best practices for a standard enterprise.
author: martinekuan
ms.author: martinek
ms.date: 01/17/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
ms.custom: internal
---

# Standard enterprise governance: Best practices explained

The governance guide starts with a set of initial [corporate policies](./initial-corporate-policy.md). These policies establish a governance MVP that reflects [best practices](./index.md).

This article describes the high-level strategies that are required to create a governance MVP. The core of the governance MVP is the [Deployment Acceleration discipline](../../deployment-acceleration/index.md). The tools and patterns applied at this stage enable the incremental improvements needed to expand governance in the future.

## Governance MVP (initial governance foundation)

You can achieve rapid adoption of governance and corporate policy thanks to a few principles and cloud-based governance tooling. The following disciplines are the first three to use in any governance process. Each discipline is then explored further in this article.

To establish the starting point, you'll learn about the high-level strategies behind the Security Baseline, Identity Baseline, and Deployment Acceleration disciplines that are required to create a governance MVP. These disciplines serve as the foundation for all adoption.

![Diagram showing an example of an incremental governance MVP.](../../../_images/govern/governance-mvp.png)

## Implementation process

Implementing the governance MVP has dependencies on identity, security, and networking. After you resolve the dependencies, the cloud governance team decides on several aspects of the governance. The decisions from the cloud governance team and other supporting teams result in a single package of enforcement assets.

![Diagram showing the implementation process of a governance MVP.](../../../_images/govern/governance-mvp-implementation-flow.png)

The following checklist describes the implementation process:

1. Solicit decisions regarding core dependencies: identity, networking, monitoring, and encryption.
2. Determine the pattern to use during corporate policy enforcement.
3. Determine the appropriate governance patterns for the resource consistency, resource tagging, and logging and reporting disciplines.
4. Implement the governance tools aligned to the chosen policy enforcement pattern to apply the dependent decisions and governance decisions.

[!INCLUDE [implementation-process](../../../../includes/implementation-process.md)]

## Application of governance-defined patterns

The cloud governance team is responsible for the following decisions and implementations. Many decisions require input from other teams, but the cloud governance team likely owns both the decisions and implementation. The following sections outline the decisions to make for this use case and details of each decision.

### Subscription design

The decision on what subscription design to use determines how Azure subscriptions are structured and how to use Azure management groups to efficiently manage the access, policies, and compliance for the subscriptions. In this narrative, the governance team has established subscriptions for production and nonproduction workloads. For more information, see the [production and nonproduction](../../../ready/azure-best-practices/initial-subscriptions.md) subscription design pattern.

- Departments aren't likely required, given the current focus. You typically constrain your deployments within a single billing unit. At this stage of adoption, there might not even be an Enterprise Agreement to centralize billing. It's likely that this level of adoption is being managed by a single pay-as-you-go Azure subscription.
- Whether you use the EA portal or have an Enterprise Agreement in place, define and agree on a subscription model to minimize administrative overheard beyond just billing.
- A common naming convention should be agreed on as part of the subscription design, based on the previous two points.

### Resource consistency

Your resource consistency decisions determine the tools, processes, and efforts required to configure, deploy and manage Azure resources consistently within a subscription. In this narrative, [deployment consistency](../../../decision-guides/resource-consistency/index.md#deployment-consistency) is the primary resource consistency pattern.

- Create resource groups for applications using the lifecycle approach. Everything you create, maintain, and retire together should reside in a single resource group. For more information, see the [resource consistency decision guide](../../../decision-guides/resource-consistency/index.md#basic-grouping).
- Apply Azure Policy to all subscriptions from the associated management group.
- As part of the deployment process, store the Azure resource consistency templates for the resource group in source control.
- Associate each resource group with a specific workload or application based on the lifecycle approach described previously.
- Azure management groups enable you to update governance designs as your corporate policy matures.
- Extensive implementation of Azure Policy could exceed the team's time commitments and might not provide a great deal of value at this time. Create a default policy and apply to each management group to enforce the small number of current cloud governance policy statements. This policy defines the implementation of specific governance requirements. You can apply those implementations across all deployed assets.

> [!IMPORTANT]
> Any time a resource in a resource group no longer shares the same lifecycle, move it to another resource group. Examples include common databases and networking components. While they might serve the application being developed, they might also serve other purposes and should therefore exist in other resource groups.

### Resource tagging

Resource tagging decisions determine how metadata applies to Azure resources within a subscription to support operations, management, and accounting purposes. In this narrative, the [classification](../../../decision-guides/resource-tagging/index.md#resource-tagging-patterns) pattern is chosen as the default model for resource tagging.

- Tag deployed assets with:
  - Data classification
  - Criticality
  - SLA
  - Environment
- These four values drive governance, operations, and security decisions.
- If you're implementing this governance guide for a business unit or team within a larger corporation, your tagging should also include metadata for the billing unit.

### Logging and reporting

Logging and reporting decisions determine how you store log data. They also determine how the monitoring and reporting tools that keep IT staff informed on operational health are structured. In this narrative, it's recommended you use a [cloud-native pattern](../../../decision-guides/logging-and-reporting/index.md#cloud-native) for logging and reporting.

## Incremental improvement of governance processes

As governance changes, some policy statements can't or shouldn't be controlled by automated tooling. Other policies result in effort by the IT security team and the on-premises identity management team over time. To help manage new risks as they arise, the cloud governance team oversees the following processes.

**Adoption acceleration:** The cloud governance team reviews deployment scripts across multiple teams. They maintain a set of scripts that serve as deployment templates. The cloud adoption and DevOps teams use the templates to define deployments more quickly. Those scripts contain the necessary requirements to enforce a set of governance policies with no extra effort from cloud adoption engineers. As the curators of these scripts, the cloud governance team can more quickly implement policy changes. As a result of script curation, the cloud governance team is the source of adoption acceleration, which creates consistency among deployments, without strictly forcing adherence.

**Engineer training:** The cloud governance team offers bimonthly training sessions and has created two videos for engineers. These materials help engineers quickly learn the governance culture and how things are done during deployments. The team is adding training assets that show the difference between production and nonproduction deployments, which help engineers understand how the new policies affect adoption. The training ensures consistent deployments without strictly enforcing adherence.

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
- [Resource naming and tagging patterns](../../../decision-guides/resource-tagging/index.md)
- [Software Defined Networking patterns](../../../decision-guides/software-defined-network/index.md)
- [Subscription design patterns](../../../ready/landing-zone/design-area/resource-org-subscriptions.md)

## Next steps

After your cloud adoption team implements this guide, they can proceed with a solid governance foundation. At the same time, the cloud governance team works to continuously update the corporate policies and governance disciplines.

Both teams use the tolerance indicators to identify the next set of improvements required to continue supporting cloud adoption. For the fictional company in this guide, the next step is to improve the security baseline to support moving protected data to the cloud.

> [!div class="nextstepaction"]
> [Improve the Security Baseline discipline](./security-baseline-improvement.md)
