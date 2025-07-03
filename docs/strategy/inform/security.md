---
title: Security Considerations for Your Cloud Strategy
description: Learn how to design your cloud infrastructure with security in mind to protect your data and applications from unauthorized access and data breaches.
ms.author: pnp
author: Zimmergren
ms.topic: conceptual
ms.date: 02/03/2025
---

# Security considerations for your cloud strategy

You need a well-designed security strategy for a successful cloud adoption. If your organization uses traditional on-premises environments, you should evaluate your cloud expertise and specifically focus on cloud security. To manage security in the cloud, you might need to make significant changes to the structure of your security team and your overall security approach.

Potential changes to your organization might introduce stress and conflict. For a successful cloud adoption, ensure that your management teams provide support and clearly present changes to other teams.

## Address common challenges

**Evolve your mindset.** On-premises security is typically a narrowly focused practice that a small team of engineers and operations administrators might handle. Cloud security requires participation from across the organization, and the scope of security teams expands significantly. An on-premises environment's attack surface is primarily at the perimeter. In a cloud environment, every resource is a potential attack vector, so security teams need to adapt their approach accordingly.

**Adjust teams and roles.** Cloud security, especially for large organizations, involves specialized roles. To ensure that you don't have gaps in your security management, you might need to add new teams or reorganize existing teams.

**Recommendations:**

- _Introduce security conversations early._ Start security conversations with the right stakeholders early in your cloud adoption process. This approach helps ensure that you can prepare for organizational alignment early on.

- _Understand modern security teams, roles, and functions._ Review the Cloud Adoption Framework guidance about [security teams, roles, and functions](../../secure/teams-roles.md). This guidance describes how to implement end-to-end security.
- _Embrace the Cloud Adoption Framework Secure methodology._ Use the [Cloud Adoption Framework Secure methodology](../../secure/overview.md) to apply Microsoft security best practices at each stage of your cloud adoption journey. The guidance for each phase includes several security approaches, including security posture modernization, incident preparation and response, security sustainment, and the Confidentiality, Integrity, and Availability (CIA) Triad.

## Understand the Microsoft Secure Future Initiative

As a worldwide cloud provider, Microsoft prioritizes security above all other concerns and recognizes the critical need to prevent security breaches. The [Microsoft Secure Future Initiative](https://www.microsoft.com/trust-center/security/secure-future-initiative) addresses these concerns and provides an overall approach to build and maintain Microsoft products.

The extent to which you prioritize security over other concerns, like reliability, performance, and costs, depends on many factors. You define these factors when you create your overall adoption strategy. Regardless of your priorities, you should understand the pillars of the Microsoft Secure Future Initiative to help focus on key areas of your cloud estate's security that you want to strengthen.

## Adopt a Zero Trust strategy

The Zero Trust principles create the foundation of the Microsoft security strategy. Zero Trust is a cloud-ready security strategy that consists of three main principles:

- **Verify explicitly:** Always authenticate and authorize based on all available data points.

- **Use least privilege:** Limit user access with just-in-time and just-enough access, risk-based adaptive policies, and data protection.
- **Assume breach:** Minimize the blast radius and segment access. Verify end-to-end encryption, and use analytics to get visibility, drive threat detection, and improve defenses.

The Zero Trust principles guide your decisions when you design, implement, and operate a cloud estate. They provide a clear reference point to check against, which helps ensure that your choices don't compromise security.

Use the Microsoft [Zero Trust guidance](/security/zero-trust/zero-trust-overview) to streamline the integration of a Zero Trust approach into your security strategy. The Zero Trust guidance:

- Provides a tightly focused and structured [adoption framework](/security/zero-trust/adopt/zero-trust-adoption-overview) that aligns with the adoption journey phases of the Cloud Adoption Framework for Azure. Use this guidance to align your overall cloud adoption with the Zero Trust approach.

- Explains how [Azure](/security/zero-trust/azure-infrastructure-overview), [Microsoft 365](/microsoft-365/security/microsoft-365-zero-trust), and [AI services](/security/zero-trust/copilots/apply-zero-trust-copilots-overview) can help you align your cloud estate to the Zero Trust principles.
- Provides guidance about aligning your [development practices](/security/zero-trust/develop/overview) to the Zero Trust principles.

**Recommendations:**

- _Adopt Zero Trust._ Use the Microsoft [Zero Trust guidance](/security/zero-trust/zero-trust-overview) to implement Zero Trust principles, which help drive a security-first mindset.

## Use the CISO and MCRA workshops

Microsoft offers workshops to help decision makers and architects apply best practices to their cloud adoption. The Chief Information Security Officer (CISO) workshop focuses on a thorough approach to modernize cybersecurity practices from the perspective of the CISO and other senior leadership roles.

The Microsoft Cybersecurity Reference Architecture (MCRA) workshop focuses on how to apply architectural best practices to your cloud environment designs. The Zero Trust principles create the foundation for the guidance in the CISO and MCRA workshops. The workshops also align to Microsoft best practices across the Cloud Adoption Framework, Azure Well-Architected Framework, and Zero Trust security recommendations.

**Recommendations:**

- _Consult with team leaders about the CISO and MCRA workshops._ Consider investing in one or more [Microsoft-led workshops](/security/adoption/adoption#microsoft-led-workshops). Take advantage of the CISO and MCRA workshops in particular. For Microsoft-led workshop material, see [Security adoption resources](/security/adoption/adoption).

## Next step

> [!div class="nextstepaction"]
> [Sustainability considerations](sustainability.md)
