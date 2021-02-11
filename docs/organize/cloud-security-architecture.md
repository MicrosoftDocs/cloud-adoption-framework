---
title: Cloud security architecture functions
description: Understand cloud security architecture functions.
author: JanetCThomas
ms.author: janet
ms.date: 05/15/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: organize
ms.custom: internal
---

# Cloud security architecture functions

Security architecture translates the organizations business and assurance goals into documentation and diagrams to guide technical security decisions.

## Modernization

Security architecture is affected by different factors:

- **Continuous engagement model:** Continuous release of software updates and cloud features make fixed engagement models obsolete. Architects should be engaged with all teams working in technical topic areas to guide decision making along those teams' capability lifecycles.
- **Security from the cloud:** Incorporate security capabilities from the cloud to reduce enablement time and ongoing maintenance costs (hardware, software, time, and effort).
- **Security of the cloud:** Ensure coverage of all cloud assets including software as a service (SaaS) applications, infrastructure as a service (IaaS) VMs, and platform as a service (PaaS) applications and services. This should include discovery and security of both sanctioned and unsanctioned services.
- **Identity integration:** Security architects should ensure tight alignment with identity teams to help organizations meet the dual goals of enabling productivity and providing security assurances.
- **Integration of internal context** in security designs to such as context from posture management and incidents investigated by security operations [center] (SOC). This should include elements like relative risk scores of user accounts and devices, sensitivity of data, and key security isolation boundaries to actively defend.

## Team composition and key relationships

Security architecture is ideally provided by a dedicated individual or dedicated team, but resource constraints may require assigning this function to an individual with other responsibilities.

Security architecture should have a broad portfolio of relationships across the security organization, with key stakeholders in other organizations, and with peers in external organizations. Key internal relationships should include:

- IT/enterprise architects
- Security posture management
- Technology directors
- Key business leaders or their representatives
- Industry peers and others in the security community

Security architects should actively influence [security policy and standards](./cloud-security-policy-standards.md).

## Next steps

Review the function of [cloud security compliance management](./cloud-security-compliance-management.md).
