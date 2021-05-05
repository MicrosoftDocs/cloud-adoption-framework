---
title: Access Control
description: Learn about access control best practices in the Cloud Adoption Framework for Azure.
author: DominicAllen
ms.author: doalle
ms.date: 04/04/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: secure
ms.custom: internal
---

# Access Control

Access control is the part of security that people experience first and most often. People see access control when they log into their computers and their mobile phones, when they share a file or try to access an application, and when they use an ID Card key to access a physical building or room. While it's not everything in security, it's critically important and it requires focusing on getting both user experience and security assurances right.

## From a perimeter tactic to zero trust strategy

The traditional approach of access control for IT has been based on restricting access to a corporate network and then supplementing this with additional controls as appropriate. This model restricts all resources to a corporate owned network connection and has become too inflexible to meet the needs of a dynamic enterprise. 

:::image type="content" source="./media/zero-trust-shift.png" alt-text="Zero Trust Shift" lightbox="./media/zero-trust-shift-popout.png":::

Organizations must embrace a zero trust approach to access control as they embrace remote work as normal and use cloud technology to digitally transform their business model, customer engagement model, employee engagement and empowerment model, and more. 

Zero trust principles help establish and continuously improve security assurances while maintaining flexibility to match pace with this new world. Most zero trust journeys start with access control and focus on identity as a preferred and primary control while continuing to embrace network security technology as a key element. Network technology and the security perimeter tactic are still present in a modern access control model, but they aren't the dominant and preferred approach in a complete access control strategy

## Modern Access Control

Organizations should develop a holistic access control strategy that is comprehensive, consistent, and rigorously applies security principles deeply across the technology stack, but is also flexible to meet the needs of the organization. 

This diagram illustrates all of the different elements that an organization must consider for an access control strategy that spans multiple workloads, multiple clouds, different business sensitivity levels, and both human and computer access. 

:::image type="content" source="./media/access-control.png" alt-text="Access Control Overview" lightbox="./media/access-control-popout.png":::

A good access control strategy goes beyond a single discrete tactic or technology, and should adopt a pragmatic approach that embraces the right technology and tactics for the right scenarios. 

Modern access control *must meet the productivity needs of the organization* and also be:
  
 - **Secure** - Explicitly validate the trust of the users and devices during access requests using all available data and telemetry. This makes it more difficult for attackers to impersonate legitimate users without being detected. Additionally, the access control strategy should focus on eliminating unauthorized escalation of privilege (e.g. inadvertently granting a lower privilege user ability to gain higher privileges). For more information on protecting privileged access, see [Securing Privileged Access](https://aka.ms/spa)
 - **Consistent** - Ensure that security assurances are applied consistently and seamlessly across the environment. This improves the user experience and removes opportunities for attackers to sneak in through weaknesses in a disjointed or highly complex access control implementation. You should have a single access control strategy that uses the fewest number of policy engines to avoid configuration inconsistencies and configuration drift. 
 - **Comprehensive** - Enforcement of access policy should be done as close to the resources and access pathways as possible. This improve security coverage for scenarios and helps security fit smoothly into scenarios and expectations of user personas. Take advantage of security controls for data, applications, identity, network, databases, and more to drive policy enforcement closer to the business assets of value.  
 - **Identity Centric** – Prioritize the use of  identity and related controls when available. Identity controls provide rich context into access requests and application context that isn't available from raw network traffic. Networking controls are still important to maintain and are sometimes the only available option (such as in operational technology environments), but identity should always be the first choice if available. An failure dialog during application access from the identity layer will be more precise and informative than a network traffic block, making it more likely the user can correct the issue without a costly helpdesk call. 

### Enterprise Access Model

The enterprise access model is a comprehensive access model based on zero trust. This model addresses all type of access by internal and external users, services, applications, and privileged accounts with administrative access to systems.  

:::image type="content" source="./media/privileged-access-over-underlying-planes.png" alt-text="Adding user and application access pathways" lightbox="./media/privileged-access-over-underlying-planes-popout.png":::

This is described in detail in [Enterprise access model](https://docs.microsoft.com/security/compass/privileged-access-access-model)

## Known, trusted, allowed

One helpful perspective on the zero trust transformation of access control is that it shifts from a static two-step process of authentication and authorization to a dynamic three step process:

:::image type="content" source="./media/known-trusted-allowed-physical.png" alt-text="Known Trusted Allowed - Physical" lightbox="./media/known-trusted-allowed-physical-popout.png":::

1. **Known** - Authentication that ensures you are who you say you are. This is analogous to the physical process of checking a government issued identity card with a photo. 
2. **Trusted** - Validation that your user and device are trustworthy enough to access the resource. This is analogous to security at an airport that screens all passengers for security risks before allowing them to enter the airport. 
3. **Allowed** - Granting the specific rights and privileges for the application, service, or data. This is analogous to an airline that manages where passengers are going, what cabin they sit in (first class, business class, coach), whether they have to pay for luggage, and so on. 

### Key Access Control Technologies

The key technical capabilites that enable modern access control are:

 - **Policy Engine** - is the component where organizations configure the technical security policy to meet the organizations productivity and security objectives.
 - **Policy Enforcement Points** - enforce the central policy decisions by the policy engine across the organization's resources including data, applications, identity, network, databases, and more. 

This diagram depicts how Azure Active Directory provides a policy engine and a policy enforcement point for modern identity protocols to enable known-trusted-allowed: 

:::image type="content" source="./media/known-trusted-allowed-electronic.png" alt-text="Known Trusted Allowed - Electronic" lightbox="./media/known-trusted-allowed-electronic-popout.png":::

Azure Active Directory policy engine can be extended to other policy enforcement points including
 - **Modern applications** - that use modern authentication protocols 
 - **Legacy applications** - via Azure AD App Proxy
 - **VPN and remote access solutions** - such as Cisco AnyConnect, Palo Alto Networks, F5, Fortinet, Citrix, Zscaler, and more
 - **Documents, email, and other files** - via Microsoft Information Protection
 - **And more** - see [Tutorials for integrating SaaS applications with Azure Active Directory](https://docs.microsoft.com/azure/active-directory/saas-apps/tutorial-list)

## Data-driven access decisions

To fulfill the zero trust principle of explicit validation, it is critical to make an informed decision. The zero trust policy engine should have access to diverse data on the users and devices to make sound security decisions. This diversity helps you identify with greater confidence
 - whether the actual user is in control of the account
 - whether the device has been compromised by an attacker
 - whether the user has the appropriate roles and permissions


Microsoft has invested into building a threat intelligence system that integrates security context derived from a high volume of diverse signal sources. See [this summary of Microsoft Threat Intelligence](https://aka.ms/threatintelligence) for more information. 

## Segmentation and Isolation

Organizations often choose to create internal boundaries to divide the internal environment into separate segments as part of their access control approach. This is intended to contain the damage of an attack by limiting attacker access if they get into the environment. Segmentation is traditionally done with firewalls or other network filtering technology, though the concept may be applied to identity and other technologies as well. 

For a reference on how an enterprise segmentation can be applied to Azure environments, see [Azure components and reference model](https://docs.microsoft.com/security/compass/microsoft-security-compass-introduction#azure-components-and-reference-model-2151)

### Isolation: Avoid Firewall and Forget
*Isolation requires people, process, and technology*

An extreme form of segmentation called isolation is sometimes required for protecting critically important assets. Isolation is most often used for assets that are both business critical and difficult or impossible to bring up to current policy and standards. This frequently includes operational technology (OT) systems like Supervisory Control and Data Acquisition (SCADA) and Industrial Control Systems (ICS). 

:::image type="content" source="./media/firewall-and-forget.png" alt-text="People, Process, Technology for Isolation" lightbox="./media/firewall-and-forget-popout.png":::

Isolation must be designed as a complete people/process/technology system and be integrated with business processes to be successful and sustainable. This approach typically fails over time if it's implemented as purely a technology approach without processes and training to validate and sustain the defenses over time. It's easy to fall into a 'firewall and forget' trap by defining the problem as a static and technical. In most cases, processes are needed to sustain the defenses and require security, IT, OT, and sometimes business operations teams to follow them. 

 - **People** - Train all employees, vendors, and stakeholders on isolation strategy and their part in it, including why its important (threats/risks and potential business impact, what they are expected to do, and how to do it. 
 - **Process** - Establish clear policy and standards, document processes for business and technical stakeholders for all scenarios (vendor access, change management process, threat response procedures, etc.) including exception management. Monitor to ensure the configuration doesn't drift and other processes are followed correctly and rigorously. 
 - **Technology** - Implement technical controls to block unauthorized communications, detect anomalies and potential threats, and harden bridging/transit devices that interact with the isolated environment (e.g. operator consoles for OT systems)

See also [Network Isolation](.\asset-protection.md\#network-isolation) in Asset Protection

## Next Steps

While each organization will have unique requirements for access control, your strategy should be grounded in the same fundamentals.
The guidance provided in these articles, and the Cloud Adoption Framework more broadly, can help organizations find the right approach. 

The next discipline is modernizing [Security Operations](./security-operations.md)


