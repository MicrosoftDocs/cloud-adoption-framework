---
title: Security in the Microsoft Cloud Adoption Framework for Azure
description: Use the Cloud Adoption Framework for Azure to learn how to integrate security throughout your cloud adoption journey.
author: MarkSimos
ms.author: mas
ms.date: 04/04/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: secure
ms.custom: internal
---

# Security in the Microsoft Cloud Adoption Framework for Azure

Just as cloud adoption is a journey, cloud security is also an ongoing journey of incremental progress and maturity, not a static destination.

## Envision a security end state

A journey without a target destination is just wandering. While this approach might eventually lead to enlightenment, business goals and constraints often require focusing on objectives and key results.

The Secure methodology provides a vision of the complete end state to guide the improvement of your security program over time. The following infographic provides a visual mapping of the key ways that security integrates with the larger organization and the disciplines within security.

:::image type="content" source="./media/secure-methodology.png" alt-text="CAF Secure Methodology" lightbox="./media/secure-methodology-popout.png":::

The Cloud Adoption Framework provides security guidance for this security journey by providing clarity for the processes, best practices, models, and experiences. This guidance is based on the lessons learned and real world experiences of real customers, Microsoft's security journey, and work with organizations like NIST, The Open Group, and the [Center for Internet Security (CIS)](https://www.cisecurity.org/).

## Mapping to concepts, frameworks, and standards

Security itself is both a standalone organizational discipline and a quality/attribute that is integrated or overlaid on other disciplines, which make it difficult to precisely define and map in detail. The security industry uses many different frameworks to capture risk, plan controls, and operate. Here is a quick summary of how the disciplines in the CAF Secure methodology relate to other security concepts and guidance:

- **Zero trust:** Microsoft believes all security disciplines should follow the zero-trust principles of *assume breach*, *verify explicitly*, and *use least privilege access*. These principles underpin any sound [security strategy](../strategy/define-security-strategy.md) and also must be balanced with *business enablement* goals. The first and most visible part of zero trust is in access control, so it's highlighted in the description of access control security discipline.

- **The Open Group:** These security disciplines map closely to the zero-trust components in the [core principles white paper](https://publications.opengroup.org/security-library/w210) published by The Open Group, where Microsoft actively participates. The one notable exception is that Microsoft elevated the discipline of innovation security so that DevSecOps is a top-level element because of how new, important, and transformative this discipline is for many organizations.

- **NIST cybersecurity framework:** For organizations that use the [NIST cybersecurity framework](https://www.nist.gov/cyberframework), we have highlighted bold text where the framework most closely maps. Modern access control and DevSecOps map broadly to the full spectrum of the framework, so those items aren't noted individually.

## Mapping to roles and responsibilities

While security is a highly technical discipline, it's first and foremost a human discipline reflective of the long history of human conflict (but updated for computers and the internet). The following diagram summarizes the roles and responsibilities in a security program.

:::image type="content" source="./media/roles-and-responsibilities.png" alt-text="View of the responsibilities/functions of an enterprise security team" lightbox="./media/roles-and-responsibilities-popout.png":::

For more information, see [Cloud security functions](../organize/cloud-security.md).

## Security transformation

As organizations adopt the cloud, they quickly find that static security processes cannot keep up with the pace of change in cloud platforms, the threat environment, and the evolution of security technologies. Security must shift to a continuously evolving approach to match pace with this change that will transform organizational culture and daily processes throughout the organization.

To guide this transformation, this methodology provides guidance on the integration of security with business processes (top row) and security technical disciplines (bottom row). These collectively enable meaningful and sustainable progress on your security journey to reduce organizational risk. Few organizations can master all of these at once, but all organizations should steadily mature each process and discipline.

### Change drivers

Security organizations are experiencing two types of major transformations at the same time

- **Security as business risk:** Security has been propelled into the realm of business risk management from a purely technical quality-oriented discipline. This is driven by dual forces of:
  - **Digital transformation:** Increases in digital footprint are continuously increasing the potential attack surface of the organization
  - **Threat landscape:** Increases in attack volume and sophistication that are fueled by an industrialized attack economy with specialized skills and continual commoditization of attack tools and techniques.
- **Platform change:** Security is also grappling with a technical platform change to the cloud. This shift is on the scale of factories shifting from running their own electrical generators to plugging into an electrical grid. While security teams often have the right foundational skills, they are becoming overwhelmed by the changes to nearly every process and technology they use everyday.
- **Shift in expectations:** In the past decade, digital innovation has redefined entire industries. Business agility, especially agility related to digital transformation, can quickly unseat an organization as a market leader. Likewise, loss of consumer confidence can have a similar impact on the business. While it was once acceptable for security to start with "no" to block a project and protect the organization,  the urgency of embracing digital transformation must change the engagement model to "let's talk about how to stay safe while you do what is needed to stay relevant."

## Guiding lasting transformation

Transforming how the business and tech teams view security requires aligning security closely to the priorities, processes, and risk framework. Key areas that drive success are

- **Culture:** The culture of security must be focused on safely meeting the business mission, not impeding it. At the same time, security must become a normalized part of the culture of the organization as the internet upon which the business operates is open, allow adversaries to attempt attacks at any time. This cultural shift requires improved processes, partnerships, and ongoing leadership support at all levels to communicate the change, model the behavior, and reinforce the shift.
- **Risk ownership:** The accountability for security risk should be assigned to the same roles that own all other risks, freeing security up to be a trusted advisor and subject matter expert rather than a scapegoat. Security should be responsible for sound and balanced advice that is communicated in the language of those leaders, but should not be held accountable for decisions they do not own.
- **Security talent:**  Security talent is in a chronic shortage and organizations should always be planning how to best develop and distribute security knowledge and skills. In addition to growing security teams directly with technical security skillsets, mature security teams are also diversifying their strategy by focusing on
  - **Growing security skillsets and knowledge** within existing teams in IT and the business. This is especially important for DevOps teams with a DevSecOps approach and can take many forms (such as a security help desk, identifying and training champions within the community, or job swapping programs).
  - **Recruiting diverse skillsets** to security teams to bring fresh perspectives and frameworks to problems (like business, human psychology, or economics) and build better relationships within the organization. To a hammer, all problems look like nails.

### Business alignment

Because of these shifts, your cloud adoption program should focus heavily on business alignment in three categories

- **Risk insights:** Align and integrate security insights and risk signals/sources to the business initiatives. Ensure repeatable processes educate all teams on the application of those insights and hold teams accountable for improvements.
- **Security integration:** Integrate security knowledge, skills, and insights deeper into daily operations of the business and IT environment via repeatable processes and deep partnership at all levels of the organization.
- **Operational resiliency:** Focus on ensuring the organization is resilient by being able to continue operations during an attack (even if at a degraded state) and that the organization rapidly bounces back to full operations.

### Security disciplines

This transformation will affect each security discipline differently. While each of these disciples is extremely important and requires investment, these are ordered (roughly) by which ones have the most immediate opportunities for quick wins as you adopt the cloud:

- **Access control:** Application of network and identity create access boundaries and segmentation to reduce the frequency and reach of any security breaches
- **Security operations:** Monitor IT operations to detect, respond, and recover from breach. Use data to continuously reduce risk of breach
- **Asset protection:** Maximize protection of all assets (infrastructure, devices, data, applications, networks, and identities) to minimize risk to the overall environment
- **Security governance:** Delegated decisions accelerate innovation and introduce new risks. Monitor decisions, configurations, and data to govern decisions made across the environment and within all workloads across the portfolio.
- **Innovation security:** As an organization adopts DevOps models to increase the pace of innovation, security must become an integral part of a DevSecOps process and integrate security expertise and resources directly into this high-speed cycle. This involves shifting some decision making from centralized teams to empower workload-focused teams.

### Guiding principles

All security activities should be aligned to and shaped by a dual focus on

- **Business enablement:** Align to organization's business objective and risk framework
- **Security assurances:** Focused on applying zero trust principles of
  - **Assume breach:** When designing security for any component or system, reduce risk of attackers expanding access by assuming other resources in the organization are compromised
  - **Explicit verification:** Explicitly validate trust using all available data points, rather than assuming trust. For example, in access control, validate the user identity, location, device health, service or workload, data classification, and anomalies, rather than simply allowing access from an implicitly trusted internal network.
  - **Least-privileged access:** Limit the risk of a compromised user or resource by providing just-in-time and just-enough-access (JIT/JEA), risk-based adaptive policies, and data protection to help secure both data and productivity.

## Related resources

The Secure methodology is part of a comprehensive set of security guidance that also includes:

- [Azure Well-Architected Framework](/azure/architecture/framework/security/overview): Guidance on securing your workloads on Azure.
- [Azure security benchmarks](/security/benchmark/azure/): Prescriptive best practices and controls for Azure security.
- [Enterprise-scale landing zone](../ready/enterprise-scale/security-governance-and-compliance.md): Azure reference architecture and implementation with integrated security.
- [Top 10 security best practices for Azure](./security-top-10.md): Top Azure security best practices that Microsoft recommends based on lessons learned across customers and our own environments.
