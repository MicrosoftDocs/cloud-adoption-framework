---
title: Ongoing management and security
description: Use the Cloud Adoption Framework for Azure to learn to focus on the operations and security configurations that will support your ongoing operations.
author: martinekuan
ms.author: martinek
ms.date: 05/10/2019
ms.topic: conceptual
ms.custom: internal
---

# Phase 3: Ongoing management and security

After you've onboarded Azure server management services, you'll need to focus on the operations and security configurations that will support your ongoing operations. We'll start with securing your environment by reviewing Microsoft Defender for Cloud. We'll then configure policies to keep your servers in compliance and automate common tasks. This section covers the following topics:

- [Enable the guest configuration policy](./guest-configuration-policy.md): Use the Azure Policy guest configuration feature to audit the settings in a virtual machine. For example, you can check whether any certificates are about to expire.
- [Track and alert on critical changes](./enable-tracking-alerting.md): When you're troubleshooting, the first question to consider is, "What's changed?" In this article, you'll learn how to track changes and create alerts to proactively monitor critical components.
- [Create update schedules](./update-schedules.md): Schedule the installation of updates to ensure that all your servers have the latest ones.
- [Common Azure Policy examples](./common-policies.md): This article provides examples of common management policies.
- [Protect cloud workloads](/azure/defender-for-cloud/defender-for-cloud-introduction#protect-cloud-workloads): See how Microsoft Defender for Cloud can help you protect your cloud workloads.

## Next steps

Learn how to [enable the Azure Policy guest configuration](./guest-configuration-policy.md) feature.

> [!div class="nextstepaction"]
> [Guest configuration policy](./guest-configuration-policy.md)
