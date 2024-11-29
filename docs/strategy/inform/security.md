---
title: Security
description: Learn how to design your cloud infrastructure with security in mind to protect your data and applications from unauthorized access, data breaches, and other security threats.
ms.author: tozimmergren
author: Zimmergren
ms.topic: conceptual
ms.date: 11/21/2024
---

# Security

A well-designed security strategy is critical to successful cloud adoption. Organizations coming from traditional on-premises environments should evaluate their cloud expertise with specific attention to cloud security. Managing security in the cloud may require significant changes to the structure of your security team and your approach to security overall.

Be aware that the potential changes to your organization may be a source of stress and conflict and ensure that your management teams provide support and present the changes as a necessary but positive evolution for the organization.

## Common challenges

- **Mindset evolution**: On-premises security is typically a narrowly focused practice handled by a small team that might consist of engineers and operations admins. Cloud security, on the other hand, requires participation from across the organization and the scope of security teams is expanded significantly. An on-premises environment's attack surface is primarily at the perimeter, whereas in a cloud environment, every resource is a potential attack vector, so security teams need to adapt their approach accordingly.
- **Changes to teams and roles**: Cloud security, especially for larger organizations, involves specialized roles, and you may need to add new teams or reorganize existing teams to ensure that there aren’t any gaps in your security management.

## The Secure Future Initiative (SFI)

Microsoft has recognized that operating as a worldwide cloud provider requires that security is paramount to all other concerns and cannot be compromised. For this reason, Microsoft has developed the [Secure Future Initiative](https://www.microsoft.com/trust-center/security/secure-future-initiative) as the overall approach to building and maintaining its products.

The extent to which you prioritize security over other concerns like reliability, performance, and costs depends on many factors that will be defined as you build out your overall adoption strategy. Regardless of that extent, understanding the pillars of the SFI can help you focus on key areas of your cloud estate’s security that shouldn’t be compromised.

## Adopt Zero Trust

Microsoft's own security strategy is founded on a Zero Trust approach. Zero Trust is a cloud-ready security strategy based on three main principles:

- Verify explicitly: Always authenticate and authorize based on all available data points.
- Use least privilege: Limit user access with Just-In-Time and Just-Enough-Access (JIT/JEA), risk-based adaptive policies, and data protection.
- Assume breach: Minimize blast radius and segment access. Verify end-to-end encryption and use analytics to get visibility, drive threat detection, and improve defenses.

The Zero Trust principles guide every decision for designing, implementing, and operating a cloud estate, giving you a clear reference point to check against, ensuring that security is not compromised by any choice you make.

Microsoft's [Zero Trust guidance](/security/zero-trust/zero-trust-overview) focuses on streamlining the integration of the Zero Trust approach into your security strategy by:

- Providing a tightly focused and structured [adoption framework](/security/zero-trust/adopt/zero-trust-adoption-overview) that aligns with the CAF adoption journey phases, making it easy for decision makers to align their overall cloud adoption with adopting the Zero Trust approach.
- Explaining how [Azure](/security/zero-trust/azure-infrastructure-overview), [Microsoft 365](/microsoft-365/security/microsoft-365-zero-trust?bc=%2fsecurity%2fzero-trust%2fbreadcrumb%2ftoc.json&toc=%2fsecurity%2fzero-trust%2ftoc.json), and [AI services](/security/zero-trust/copilots/apply-zero-trust-copilots-overview) can help you align your cloud estate to Zero Trust principles.
- Providing guidance on aligning your [development practices](/security/zero-trust/develop/overview) to Zero Trust principles.

## Use the Chief Information Security Officer (CISO) and Microsoft Cybersecurity Reference Architecture (MCRA) workshops

Microsoft offers workshops aimed at decision makers and architects to apply best practices to your cloud adoption. The CISO workshop focuses on a thorough approach to modernizing cybersecurity practices from the perspective of the CISO and other senior leadership roles. The MCRA workshop focuses on applying architectural best practices to your cloud environment designs. All guidance found in the CISO and MCRA workshops are built on the Zero Trust principles and align to MIcrosoft’s best practices found across CAF, WAF and Zero Trust security recommendations.

**Recommendations:**

- *Introduce security conversations early*: Consider starting your security conversations with the right stakeholders early in your cloud adoption process to ensure you can prepare for any organizational alignment early on.
- *Understand modern security teams, roles, and functions*: Ensure you review the Cloud Adoption Framework guidance on [Security Teams, Roles, and Functions](../../secure/teams-roles.md) to learn about how you need to think about security end-to-end.
- *Embrace the CAF Secure methodology*: Apply Microsoft's security best practices at each stage of your cloud adoption journey using [CAF Secure](../../secure/overview.md). The guidance in each phase considers several security approaches, including security posture modernization, incident preparation and response, the CIA (confidentiality, integrity, and availability) Triad, and security sustainment.
- *Adopt Zero Trust*: Use Microsoft's [Zero Trust guidance](/security/zero-trust/zero-trust-overview) to understand how your organization can drive a security-first mindset using Zero Trust.
- *Consult with team leaders about the CISO and MCRA workshops*: Consider investing in one or more [Microsoft led workshops](/security/adoption/adoption#microsoft-led-workshops) to take advantage of the learnings available in the CISO and MCRA workshops. All of the material presented in Microsoft led workshops is publicly available [here](/security/adoption/adoption).

## Next steps

> [!div class="nextstepaction"]
> [Sustainability](sustainability.md)
