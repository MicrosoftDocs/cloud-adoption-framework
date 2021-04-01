---
title: Security Title
description: Security Description
author: GitHubAlias
ms.author: msftalias
ms.date: 04/04/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: secure
ms.custom: internal
---

# Generic space holder - remember to edit the metadata before publication

## This article should cover all of the items under the "consideration for governance and compliance" question at the CAF level

- TEST
Regulatory and governance requirements of this workload are known and well understood.Regulatory requirements may mandate that operational data, such as application logs and metrics, remain within a certain geo-political region. This has obvious implications for how the application should be operationalized.
- Landing Zone concept is implemented for this workload using Azure Blueprints and/or Azure Policies.Landing Zone refers to components that are already defined and in place before the workloads are getting deployed by the workload owners, e.g. network topology with Hub/Spoke concept. The purpose of the "Landing Zone" is to ensure that when a workload lands on Azure, the required "plumbing" is already in place, providing greater agility and compliance with enterprise security and governance requirements. It is crucial that a Landing Zone will be handed over to the workload owner with the security guardrails deployed.
- Azure Policies are used to enforce and control security and organizational standards.Azure Policy should be used to enforce and report a compliant configuration of Azure services. Azure policies can be use on multiple levels. It is recommended to apply organizational wide security controls on Azure platform level. These policies build the guardrails of a landing zone.
- Root management group is used and any changes that are applied using this group are carefully considered.The root management group ensures consistency across the enterprise by applying policies, permissions, and tags across all subscriptions. This group can affect all resources in Azure and incorrect use can impact the security of all workloads in Azure.
- Compliance for this workload is systematically monitored and maintained. Regular compliance attestations are performed.Knowing whether your cloud resources are in compliance with standards mandated by governments or industry organizations is essential in today's globalized world (e.g. GDPR). Continuous monitoring and assessing workload increases the overall security and compliance of your workload in Azure. For example Azure Security Center provides a regulatory compliance dashboard.
- External or internal audits of this workload are performed periodically.Compliance is important for several reasons. Aside from signifying levels of standards, like ISO 27001 and others, noncompliance with regulatory guidelines may bring sanctions and penalties.
- Security plan for this workload was developed and is maintained.A security plan should be part of the main planning documentation for the cloud. It should include several core elements including organizational functions, security skilling, technical security architecture and capabilities roadmap.
- Best practices and guidelines, based on industry recommendations, are reviewed and applied proactively.Security best practices are ideally applied proactively and completely to all systems as a cloud program is implemented.
- Attacker vs. defender costs are considered when implementing defenses. Easy and cheap attack methods are always prevented.Cybersecurity attacks are planned and conducted by human attackers that must manage their return on investment into attacks (return could include profit or achieving an assigned objective). If basic - cheap - vulnerabilites are covered, the effort - cost - required for the attacker gets higher.
- Attacker access containment is considered when making investments into security solutions.
