---
title: Security recommendations
description: Design area recommendations for security in Azure
author: DominicAllen
ms.author: doalle
ms.date: 8/1/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Security monitoring design recommendations

- Use Azure AD reporting capabilities to generate access control audit reports.

- Export Azure activity logs to Azure Monitor Logs for long-term data retention. Export to Azure Storage for long-term storage beyond two years, if necessary.

- Enable Security Center Standard for all subscriptions, and use Azure Policy to ensure compliance.

- Monitor base operating system patching drift via Azure Monitor Logs and Azure Security Center.

- Use Azure policies to automatically deploy software configurations through VM extensions and enforce a compliant baseline VM configuration.

- Monitor VM security configuration drift via Azure Policy.

- Connect default resource configurations to a centralized Azure Monitor Log Analytics workspace.

- Use an Azure Event Grid-based solution for log-oriented, real-time alerting.

**Platform security design recommendations:**

- In the context of your underlying requirements, conduct a joint examination of each required service. If you want to bring your own keys, it might not be supported across all considered services. Implement relevant mitigation so that inconsistencies don't hinder desired outcomes. Choose appropriate region pairs and disaster recovery regions that minimize latency.

- Develop a security allowlist plan to assess services security configuration, monitoring, alerts, and how to integrate them with existing systems.

- Determine the incident response plan for Azure services before allowing it into production.

- Use Azure AD reporting capabilities to generate access control audit reports.

- Align your security requirements with Azure platform roadmaps to stay current with newly released security controls.

- Implement a zero-trust approach for access to the Azure platform, where appropriate.