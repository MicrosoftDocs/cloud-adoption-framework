---
title: "Operational Compliance - Cloud Management and Operations"
titleSuffix: Microsoft Cloud Adoption Framework for Azure
description: Operational Compliance - Cloud Management and Operations
author: BrianBlanchard
ms.author: brblanch
ms.date: 10/17/2019
ms.topic: article
ms.service: cloud-adoption-framework
ms.subservice: operate
---

# Operational compliance in cloud management

Operational compliance builds on the discipline of [Inventory and visibility](./inventory.md), as the first actionable step of cloud management. This discipline focuses on regular telemetry reviews and remediation efforts (both proactive and reactive remediation). This discipline is the cornerstone for maintaining balance between security, governance, performance, and cost.

## Components of operations compliance

Maintaining compliance to operational commitments requires analysis, automation, and human remediation. Effective operational compliance requires consistency in a few critical processes:

1. Resource consistency
2. Environment consistency
3. Resource configuration consistency
4. Update consistency
5. Remediation automation

### Resource consistency

The most effective step a cloud management team can take toward operational compliance is establishing consistency in resource organization and tagging. When resources are consistently organized and tagged, all other operational tasks become easier. For deeper guidance on resource consistency, see the [Governance phase](../../govern/index.md) of the cloud adoption lifecycle. Specifically, the [initial governance foundation articles](../../govern/initial-foundation.md) demonstrate examples of ways to start developing resource consistency.

### Environment consistency

Consistent environments, or landing zones, is the next most important step toward operational compliance. When landing zones are consistent and enforced through automated tools, it is significantly less complex to diagnose and resolve operational issues. For deeper guidance on environment consistency, see the [Ready phase](../../ready/index.md) of the cloud adoption lifecycle. The exercises in that phase establish a repeatable process for defining and maturing a consistent, code-first approach to the development of cloud-based environments.

### Resource configuration consistency

Building on governance and readiness approaches, cloud management should include processes for the ongoing monitoring and evaluation of adherence to resource consistency requirements. As workloads change or new versions are adopted, it is vital that cloud management processes evaluate any configuration changes, which are not easily regulated through automated means.

When inconsistencies are discovered, some are addressed by consistency in updates and others may be automatically remediated.

### Update consistency

Stability can lead to stable operations. But, some changes are required within cloud management processes. In particular, regular patching and performance changes are essential to reducing interruptions and controlling costs.

One of the many values of a mature cloud management methodology is stabilizing and controlling necessary change.

Any cloud management baseline should include a means of scheduling, controlling, and possibly automating necessary updates. Those updates should include patches at a minimum, but could also include performance, sizing, and other aspects of updating assets.

### Remediation automation

As an enhanced baseline for cloud management, some workloads may benefit from automated remediation. When a workload commonly encounters issues that can't be resolved through code or architectural changes, remediation automation can reduce the burden of cloud management and increase user satisfaction.

Many would argue that any issue, which is common enough to automate, should be resolved through resolution of technical debt. When long-term resolution is prudent, it should be the default option. However, there are a number of business scenarios which make it difficult to justify large investments in resolution of technical debt. When technical debt resolution can't be justified, but remediation is a common and costly burden, automated remediation is the next best solution.

## Next steps

[Protection and recovery](./protect.md) are the next areas to consider in a cloud management baseline.

> [!div class="nextstepaction"]
> [Protect and recover](./protect.md)
