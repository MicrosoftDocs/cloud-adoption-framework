---
title: Security considerations
description: Design area considerations for security in Azure
author: DominicAllen
ms.author: doalle
ms.date: 8/1/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

**Security design considerations:**
An enterprise must have visibility into what's happening within their technical cloud estate. Security monitoring and audit logging of Azure platform services is a key component of a scalable framework.

- Data retention periods for audit data. Azure AD Premium reports have a 30-day retention period.

- Long-term archiving of logs such as Azure activity logs, VM logs, and platform as a service (PaaS) logs.

- Baseline security configuration via Azure in-guest VM policy.

- Emergency patching for critical vulnerabilities.

- Patching for VMs that are offline for extended periods of time.

- Requirements for real-time monitoring and alerting.

- Security information and event management integration with Azure Security Center and Azure Sentinel.

- Vulnerability assessment of VMs.

## Platform security design considerations

- Shared responsibility.

- High availability and disaster recovery.

- Consistent security across Azure services for data management and analytics and control plane operations.

- Multitenancy for key platform components. The multitenancy includes Hyper-V, the HSMs underpinning Key Vault, and database engines.