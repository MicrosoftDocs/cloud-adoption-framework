---
title: Security title
description: Security description
author: JanetCThomas
ms.author: brblanch
ms.date: 04/04/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: secure
ms.custom: internal
---

# Secure Methodology - Building security into your cloud adoption journey

Just as adopting the cloud is a journey, so too is security for the cloud age an ongoing journey and not a static destination.

The Cloud Adoption Framework provides security guidance for this security journey through best practices, models, and experiences of fictional companies. This is based on the experiences of real customers, of Microsoft&#39;s own journey, and, and work with organizations like NIST, The Open Group, and Center for Internet Security (CIS).

## Envision a security end state

A journey without a target destination is just wandering. It&#39;s important to establish a rough vision of the end state before taking the first step. The following infographic provides a frame of reference for the end state and the key components it must include.

![CAF Secure Methodology](../_images/security/secure-methodology.png)

## Security Transformation

As organizations adopt the cloud and security it, they quickly find that static processes cannot keep up with the pace of change in cloud platforms, the threat environment, and the evolution of security technologies. Security must shift to a continuously evolving approach to match pace with this change that will transform organizational culture and daily processes throughout the organization.

### Change Drivers

Security organizations are experiencing two types of major transformations at the same time

- **Uplevel to business risk -** Security has been propelled into the realm of business risk management from a purely technical quality-oriented discipline. This is partly driven by digital transformation and partly by the massive increase in volume and sophistication of attacks that are enabled by the industrialization of the attack economy that makes specialized tools and skills cheap and easy for attackers to leverage.
- **Platform change -** Security is also grappling with a technical platform change to the cloud on the scale of factories shifting from running their own electrical generators to plugging into an electrical grid. While they have the right foundational skills, nearly every process and technology is changing in some way.

## Common friction points

These changes often challenge the foundational assumptions that the security organization was built on, frequently forcing security organizations to focus on addressing poor alignment of

- **Culture** - a culture that doesn&#39;t match their current mission (currently based on static quality assurance with IT/business groups that must shift to a partnership focused on enablement and risk management)
- **Risk ownership -** security is often assigned accountability for risk realization when they should be responsible for expert advice and partnership to business/system owners that are accountable for risk outcomes.
- **Talent focus -** security is often focused on growing through deeply technical talent (which is in short supply in the marketplace) when they should be focused on including diverse skillsets and perspectives to help mitigate risk and solve problems using different frameworks (business, human psychology, economics, etc.). If the only solution one has is the proverbial technical hammer, all problems will look like technical problems.

### Business Alignment

Because of these shifts, your cloud adoption program should focus heavily on business alignment in three categories

- **Risk Insights** - Align and integrate security insights and risk signals/sources to the business initiatives in progress + the existing risk management framework business leaders are already using and familiar with.
- **Security Integration** - Integrate security knowledge, skills, and insights deeper into daily operations of the business and IT environment via a deep partnership at all levels of the organization. Much like airport security must rely on everyone in the airport to look out for suspicious behavior, so too must security become a part of everyone&#39;s thinking and job to keep the organization truly safe. &quot;if you see something, say something&quot;
- **Operational Resiliency** - Focus on ensure the organization is resilient by being able to continue operations during an attack (even if at a degraded state) and that the organization rapidly bounces back to full operations. This requires business organizations, IT operations, and security teams to all work together to plan for these scenarios, prepare the organization for them, and practice to build muscle memory and habits.


### Security Disciplines

This transformation will affect each security discipline differently. While all of these are extremely important and require investment , these are ordered (roughly) by which ones have the most immediate opportunities for quick wins as you adopt the cloud :

- **Access Control -**
- **Security Operations -**
- **Asset Protection -**
- **Security Governance -**
- **Innovation Security** - As organization adopt DevOps models to increase the pace of innovation to keep up with market needs and consumer preferences, security must become an integral part of a DevSecOps process and integrate security expertise and resources directly into this high speed cycle.


### Guiding Principles

All security activities should be aligned to and shaped by a dual focus on

1. **Business Enablement** - Aligning to organization&#39;s business objective and risk framework
2. **Security Assurances** - focused on applying zero trust principles of

  - **Assume Breach** - When designing security for any component or system, reduce risk of attackers expanding access by assuming other resources in the organization are compromised
  - **Explicit Verification** - Explicitly validate trust using all available data points, rather than assuming trust. (e.g. in access control validate the user identity, location, device health, service or workload, data classification, and anomalies rather than simply allowing access from an implicitly trusted internal network)
  - **Least Privileged Access** - Limit the risk of a compromised user or resource by providing just-in-time and just-enough-access (JIT/JEA), risk-based adaptive polices, and data protection to help secure both data and productivity.

**Next Steps**

1. Review the [recommended security strategy](https://aka.ms/securitystrategy)
2. Learn about modernizing the responsibilities for each [role and overall organizational functions](https://aka.ms/securityroles).
3. Get started with the [getting started guide](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/get-started/security) and [Azure Security Top 10 best practices](https://aka.ms/azuresecuritytop10)
