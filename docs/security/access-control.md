---
title: Access control
description: Learn about access control best practices in the Cloud Adoption Framework for Azure.
author: DominicAllen
ms.author: doalle
ms.date: 04/04/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: secure
ms.custom: internal
---

# Access control

Access control is the part of security that people experience first and most often. They see it when they log in to their computers and mobile phones, when they share a file or try to access an application, and when they use an ID Card key to enter a building or room. While access control is not everything in security, it's critically important, and it requires proper attention so that both the user experience and the security assurances are right.

## From security perimeter to zero trust

The traditional approach to access control establishes a *security perimeter* that restricts access to a corporate network, and supplements the security perimeter with additional controls as appropriate. This approach requires that users access all resources through the corporate network, a requirement that has become too restrictive to meet the needs of a dynamic enterprise.

:::image type="content" source="./media/zero-trust-shift.png" alt-text="Zero Trust Shift" lightbox="./media/zero-trust-shift-popout.png":::

For many organizations, working remotely is normal, and workloads are migrating to the cloud. To maintain access control as circumstances change, organizations should embrace a *zero trust* approach: users and devices aren't trusted by default just because they are on the network. Such an approach can provide the flexibility needed for new business models, and new ways of engaging with employees and customers.

Zero trust principles help establish and continuously improve security assurances, and allow security to keep pace with the organization. Most zero trust journeys start with access control and focus on identity as a preferred and primary control, while continuing to embrace network security technology as a key element. Network technology and the security perimeter are still part of a modern access control model, but they are no longer dominant and preferred.

## Modern access control

Organizations should develop an access control strategy that:

- Is comprehensive and consistent.
- Rigorously applies security principles throughout the technology stack.
- Is flexible enough to meet the needs of the organization.

This diagram illustrates all of the different elements that an organization must consider for an access control strategy for multiple workloads, multiple clouds, various business sensitivity levels, and access by both people and devices.

:::image type="content" source="./media/access-control.png" alt-text="Access Control Overview" lightbox="./media/access-control-popout.png":::

A good access control strategy goes beyond a single tactic or technology. It requires a pragmatic approach that embraces the right technology and tactics for each scenario.

Modern access control must meet the productivity needs of the organization, and also be:

- **Secure** - Explicitly validate the trust of users and devices during access requests, using all available data and telemetry. This makes it more difficult for attackers to impersonate legitimate users without being detected. Also, the access control strategy should focus on eliminating unauthorized escalation of privilege (e.g. granting a privilege that can be used to get higher privileges). For more information on protecting privileged access, see [Securing privileged access](https://aka.ms/spa).
- **Consistent** - Ensure that security assurances are applied consistently and seamlessly across the environment. Doing so improves the user experience, and removes opportunities for attackers to enter through weaknesses created when access control is too complex or disjointed. You should have a single access control strategy that uses the fewest number of policy engines, to avoid configuration inconsistencies and configuration drift.
- **Comprehensive** - Enforcement of access policy should be done as closely to the resources and access pathways as possible. This improves security coverage, and helps security fit smoothly into scenarios and expectations of users. Take advantage of security controls for data, applications, identity, networks, databases, and more, to drive policy enforcement closer to the business assets of value.
- **Identity centric** – Prioritize the use of  identity and related controls when available. Identity controls provide rich context into access requests, and application context that isn't available from raw network traffic. Networking controls are still important, and sometimes the only available option (such as in operational technology environments), but identity should always be the first choice if available. A failure dialog during application access from the identity layer will be more precise and informative than a network traffic block, making it more likely the user can correct the issue without a costly help desk call.

### Enterprise access model

The enterprise access model is a comprehensive access model based on zero trust. This model addresses all types of access by internal and external users, services, applications, and privileged accounts with administrative access to systems.

:::image type="content" source="./media/privileged-access-over-underlying-planes.png" alt-text="Adding user and application access pathways" lightbox="./media/privileged-access-over-underlying-planes-popout.png":::

This is described in detail in [Enterprise access model](/security/compass/privileged-access-access-model)

## Known, Trusted, Allowed

One helpful perspective on the zero trust transformation of access control is that it shifts from a static two-step process of authentication and authorization, to a dynamic three step process called Known, Trusted, Allowed:

:::image type="content" source="./media/known-trusted-allowed-physical.png" alt-text="Known Trusted Allowed - Physical" lightbox="./media/known-trusted-allowed-physical-popout.png":::

1. **Known** - Authentication that ensures you are who you say you are. This is analogous to the physical process of checking a government-issued photo identification document.
1. **Trusted** - Validation that the user or device is trustworthy enough to access the resource. This is analogous to security at an airport that screens all passengers for security risks before allowing them to enter the airport.
1. **Allowed** - Granting of specific rights and privileges for the application, service, or data. This is analogous to an airline that manages where passengers are going, what cabin they sit in (first class, business class, coach), whether they have to pay for luggage, and so on.

### Key access control technologies

The key technical capabilities that enable modern access control are:

- **Policy engine** - The component where organizations configure the technical security policy to meet the organization's productivity and security objectives.
- **Policy enforcement points** - Points that enforce, across the organization's resources, the central policy decisions by the policy engine. The resources include data, applications, identity, network, and databases.

This diagram depicts how Azure Active Directory provides a policy engine and a policy enforcement point, so that security protocols can implement Known, Trusted, Allowed:

:::image type="content" source="./media/known-trusted-allowed-electronic.png" alt-text="Known Trusted Allowed - Electronic" lightbox="./media/known-trusted-allowed-electronic-popout.png":::

The Azure Active Directory policy engine can be extended to other policy enforcement points, including:

- **Modern applications** - Applications that use modern authentication protocols.
- **Legacy applications** - Via Azure AD Application Proxy.
- **VPN and remote access solutions** - Such as Cisco AnyConnect, Palo Alto Networks, F5, Fortinet, Citrix, Zscaler.
- **Documents, email, and other files** - Via Microsoft Information Protection.
- **SaaS applications** - See [Tutorials for integrating SaaS applications with Azure Active Directory](/azure/active-directory/saas-apps/tutorial-list).

## Data-driven access decisions

To fulfill the zero trust principle of explicit validation, it is critical to make an informed decision. The zero trust policy engine should have access to diverse data on the users and devices in order to make sound security decisions. This diversity helps to identify these aspects with greater confidence:

- Whether the actual user is in control of the account.
- Whether the device has been compromised by an attacker.
- Whether the user has the appropriate roles and permissions.

Microsoft built a threat intelligence system that integrates security context from many and diverse signal sources. See [this summary of Microsoft Threat Intelligence](https://aka.ms/threatintelligence) for more information.

## Segmentation: Separate to protect

Organizations often choose to create boundaries to divide the internal environment into separate segments, as part of their access control approach. This is intended to contain the damage of a successful attack to the attacked segment. Segmentation is traditionally done with firewalls or other network filtering technology, though the concept can also be applied to identity and other technologies.

For information on applying segmentation to Azure environments, see [Azure Components and Reference Model](/security/compass/microsoft-security-compass-introduction#azure-components-and-reference-model-2151)

## Isolation: Avoid firewall and forget

Isolation is an extreme form of segmentation that is sometimes required for protecting critically important assets. Isolation is most often used for assets that are both business-critical, and difficult to bring up to current policy and standards. Classes of assets that may well require isolation include operational technology (OT) systems like:

- SCADA (supervisory control and data acquisition).
- ICS (industrial control system).

:::image type="content" source="./media/firewall-and-forget.png" alt-text="People, Process, Technology for Isolation" lightbox="./media/firewall-and-forget-popout.png":::

Isolation must be designed as a complete people/process/technology system and be integrated with business processes to be successful and sustainable. This approach typically fails over time if it's implemented as a purely technology approach without processes and training to validate and sustain the defenses. It's easy to fall into a 'firewall and forget' trap by defining the problem as static and technical.

In most cases, processes are needed to implement isolation, processes that various teams (security, IT, OT, and sometimes business operations) must follow. Successful isolation usually consists of:

- **Train** - Train all employees, vendors, and stakeholders on isolation strategy and their part in it, including why it's important  and what they must do.
- **Policies, standards, and processes** - Establish clear policies and standards, and document processes for business and technical stakeholders for all scenarios. The scenarios include such things as vendor access, change management, threat response, and exception management. Monitor to ensure that the configuration doesn't drift and that policies, standards, and processes are followed.
- **Technology** - Implement technical controls to block unauthorized communications, to detect anomalies and potential threats, and to harden bridging and transit devices that interact with the isolated environment (for example, operator consoles for OT systems).

For more information, see Network Isolation in [Asset Protection](.\asset-protection.md\#network-isolation).

## Next steps

Whatever your requirements for access control, your strategy should be grounded in the proper fundamentals. The guidance provided in these articles, and in the Cloud Adoption Framework, can help organizations find and implement the right approach.

The next discipline is modernizing [Security Operations](security-operations.md).
