---
title: Ongoing management and security
description: Use the Cloud Adoption Framework for Azure to learn to focus on the operations and security configurations that will support your ongoing operations.
author: BrianBlanchard
ms.author: brblanch
ms.date: 05/10/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: manage
ms.custom: internal
---

# Phase 3: Ongoing management and security

After you've onboarded Azure server management services, you'll need to focus on the operations and security configurations that will support your ongoing operations. We'll start with securing your environment by reviewing the Azure Security Center. We'll then configure policies to keep your servers in compliance and automate common tasks. This section covers the following topics:

- [Address security recommendations](#address-security-recommendations): Azure Security Center provides suggestions to improve the security of your environment. When you implement these recommendations, you see the impact reflected in a security score.
- [Enable the guest configuration policy](./guest-configuration-policy.md): Use the Azure Policy Guest Configuration feature to audit the settings in a virtual machine. For example, you can check whether any certificates are about to expire.
- [Track and alert on critical changes](./enable-tracking-alerting.md): When you're troubleshooting, the first question to consider is, "What's changed?" In this article, you'll learn how to track changes and create alerts to proactively monitor critical components.
- [Create update schedules](./update-schedules.md): Schedule the installation of updates to ensure that all your servers have the latest ones.
- [Common Azure Policy examples](./common-policies.md): This article provides examples of common management policies.

## Address security recommendations

Azure Security Center is the central place to manage security for your environment. You'll see an overall assessment and targeted recommendations.

We recommend that you review and implement the recommendations provided by this service. For information about additional benefits of Azure Security Center, see [Follow Azure Security Center recommendations](../../migrate/azure-best-practices/migrate-best-practices-security-management.md#best-practice-follow-azure-security-center-recommendations).

## Next steps

Learn how to [enable the Azure Policy Guest Configuration](./guest-configuration-policy.md) feature.

> [!div class="nextstepaction"]
> [Guest configuration policy](./guest-configuration-policy.md)
