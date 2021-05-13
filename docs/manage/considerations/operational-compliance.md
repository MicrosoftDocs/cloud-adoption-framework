---
title: Operational compliance in cloud management
description: Use the Cloud Adoption Framework for Azure to learn how to maintain compliance with operational commitments.
author: BrianBlanchard
ms.author: brblanch
ms.date: 10/17/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: manage
ms.custom: internal
---

# Operational compliance in cloud management

Operational compliance builds on the discipline of [inventory and visibility](./inventory.md). As the first actionable step of cloud management, this discipline focuses on regular telemetry reviews and remediation efforts (both proactive and reactive remediation). This discipline is the cornerstone for maintaining balance between security, governance, performance, and cost.

## Components of operations compliance

Maintaining compliance with operational commitments requires analysis, automation, and human remediation. Effective operational compliance requires consistency in a few critical processes:

- Resource consistency
- Environment consistency
- Resource configuration consistency
- Update consistency
- Remediation automation

### Resource consistency

The most effective step that a cloud management team can take toward operational compliance is to establish consistency in resource organization and tagging. When resources are consistently organized and tagged, all other operational tasks become easier. For deeper guidance on resource consistency, see the [Govern methodology](../../govern/index.md). Specifically, review the [initial governance foundation articles](../../govern/initial-foundation.md) to learn how to start developing resource consistency.

### Environment consistency

Establishing consistent environments, or landing zones, is the next most important step toward operational compliance. When landing zones are consistent and enforced through automated tools, it's significantly less complex to diagnose and resolve operational issues. For deeper guidance on environment consistency, see the [readiness phase](../../ready/index.md) of the cloud adoption lifecycle. The exercises in this phase help build a repeatable process for defining and maturing a consistent, code-first approach to developing cloud-based environments.

### Resource configuration consistency

As it builds on governance and readiness approaches, cloud management should include processes for the ongoing monitoring and evaluation of its adherence to resource consistency requirements. As workloads change or new versions are adopted, it's vital that cloud management processes evaluate any configuration changes, which are not easily regulated through automation.

When inconsistencies are discovered, some are addressed by consistency in updates and others can be automatically remediated.

### Update consistency

Stability in approach can lead to more stable operations. But some changes are required within cloud management processes. In particular, regular patching and performance changes are essential to reducing interruptions and controlling costs.

One of the many values of a mature cloud management methodology is a focus on stabilizing and controlling necessary change.

Any cloud management baseline should include a means of scheduling, controlling, and possibly automating necessary updates. Those updates should include patches at a minimum, but could also include performance, sizing, and other aspects of updating assets.

### Remediation automation

As an enhanced baseline for cloud management, some workloads may benefit from automated remediation. When a workload commonly encounters issues that can't be resolved through code or architectural changes, automating remediation can help reduce the burden of cloud management and increase user satisfaction.

Many would argue that any issue that's common enough to automate should be resolved through resolution of technical debt. When a long-term resolution is prudent, it should be the default option. However, some business scenarios make it difficult to justify large investments in the resolution of technical debt. When such a resolution can't be justified, but remediation is a common and costly burden, automated remediation is the next best solution.

## Next steps

[Protection and recovery](./protect.md) are the next areas to consider in a cloud management baseline.

> [!div class="nextstepaction"]
> [Protect and recover](./protect.md)
