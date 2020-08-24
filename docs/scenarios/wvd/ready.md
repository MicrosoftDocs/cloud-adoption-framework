---
title: "Azure landing zones for Windows Virtual Desktop instances"
description: Use the Cloud Adoption Framework for Azure to learn virtual desktop migration best practices to reduce complexity and standardize the migration process.
author: BrianBlanchard
ms.author: brblanch
ms.date: 07/01/2010
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
---

# Windows Virtual Desktop Azure landing zone review

Before the Contoso cloud adoption team migrates to Windows Virtual Desktop, it will need an Azure landing zone that's capable of hosting desktops and any supporting workloads. The following checklist can help the team evaluate the landing zone for compatibility. Guidance in the [Ready methodology](../../ready/index.md) of this framework can help the team build a compatible Azure landing zone, if one has not been provided.

## Evaluate compatibility

- **Resource organization plan**: The landing zone should include references to the subscription or subscriptions to be used, guidance on resource group usage, and the tagging and naming standards to be used when the team deploys resources.
- **Azure AD**: An Azure Active Directory (Azure AD) instance or an Azure AD tenant should be provided for end-user authentication.
- **Network**: Any required network configuration should be established in the landing zone prior to migration.
- **VPN or ExpressRoute**: Additionally, any landing zone that supports virtual desktops will need a network connection so that end users can connect to the landing zone and hosted assets. If an existing set of endpoints is configured for virtual desktops, end users can still be routed through those on-premises devices via a VPN or Azure ExpressRoute connection. If a connection doesn't already exist, you might want to review the guidance on configuring network connectivity options in the [Ready methodology](../../ready/index.md).
- **Governance, users, and identity**: For consistent enforcement, any requirements to govern access from virtual desktops and to govern users and their identities should be configured as Azure policies and applied to the landing zone.
- **Security**: The security team has reviewed the landing zone configurations and approved each landing zone for its intended use, including landing zones for the external connection and landing zones for any mission-critical applications or sensitive data.
- **Windows Virtual Desktop**: Windows Virtual Desktop platform as a service has been enabled. <!-- TODO: Add link to enable the service. -->

Any landing zone that the team develops by using the best practices in the [Ready methodology](../../ready/index.md) and that can meet the previously mentioned specialized requirements would qualify as a landing zone for this migration.

To understand how to architect Windows Virtual Desktop, review the [Windows Virtual Desktop requirements](/azure/virtual-desktop/overview#requirements).

## Next steps

For guidance on specific elements of the cloud adoption journey, see:

- [Complete a Windows Virtual Desktop proof of concept](./proof-of-concept.md)
- [Assess for Windows Virtual Desktop migration or deployment](./migrate-assess.md)
- [Deploy or migrate Windows Virtual Desktop instances](./migrate-deploy.md)
- [Release your Windows Virtual Desktop deployment to production](./migrate-release.md)
