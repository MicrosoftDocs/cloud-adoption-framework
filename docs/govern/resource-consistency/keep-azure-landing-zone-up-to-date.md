---
title: Keep your Azure landing zone up to date
description: Learn best practices for keeping your Azure landing zones up to date.
author: Jfaurskov
ms.author: Janfaurs
ms.date: 01/10/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
ms.custom: internal
---

# Keep your Azure landing zone up to date

An Azure landing zone is a set of pre-defined Azure resources and configurations that provide a foundation for a cloud-based application or workload. It's important to ensure that your deployed landing zone environment is up to date so that you can maintain improved security, avoid platform configuration drift, and stay optimized for new feature releases.

## Why update your Azure landing zones?

Here are a few reasons to keep your landing zone up to date:

- **Maintain improved security.** Cybersecurity threats are constantly evolving. It's important to ensure that your landing zone reflects the latest best practices for protecting your data and systems. Keeping your landing zone up to date helps you mitigate the risk of a security breach and helps you keep your data properly secured.
- **Avoid platform configuration drift.** As landing zones continue to evolve, drift relative to your deployed environment is introduced. Examples of drift include:
    - Replacement of landing zone policies by built-in Azure policies or by newer versions of landing zone policies.
    - Improvements to network features.
    - New features.
    
    The longer drift is left unattended, the more technical debt it incurs. This debt requires remediation. So that you can avoid spending increased time on remediation activities, we encourage you to regularly review the latest [changes to landing zones](https://github.com/Azure/Enterprise-Scale/wiki/Whats-new).
- **Optimize for Azure improvements.** As new Azure features and services are released, landing zones might be modified to include them. Likewise, as older Azure features are deprecated, changes might also be made to landing zones.
- **Get support.** A landing zone, as a deployable reference and implementation, is an open-source project, so support is limited to community engagement. Keeping your landing zone aligned to the current implementation makes community support more likely.

Neglecting to keep your landing zones up to date could affect your security posture and the benefits that you get from the landing zones. To protect your investment in Azure, regularly review and update your landing zones as needed. See the **Next steps** section for guidance on how to do that.

## Keep policies and policy initatives up to date

Over time, Azure landing zone custom policies and policy initiatives might be updated to newer versions or even superseded by new Azure built-in policies. If so, they should be included in your platform landing zone update cycle.

- [Migrate landing zone custom policies to Azure built-in policies](./migrate-azure-landing-zone-policies.md)
- [Update Azure landing zone custom policies](../guides/standard/update-custom-policies.md)

## Using Infrastructure-as-Code (IaC) to keep ALZ updated

To help more easily remain up to date with ALZ in a consistent way, use IaC to maintain your ALZ environment. See the following link for more details on the benefits [Why use Infrastructure as Code to update your ALZ?](../../manage/iac-updates.md)

## Next steps

- [Latest updates to landing zones](https://github.com/Azure/Enterprise-Scale/wiki/Whats-new)
