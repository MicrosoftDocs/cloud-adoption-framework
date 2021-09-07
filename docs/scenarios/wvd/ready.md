---
title: Azure landing zones for Azure Virtual Desktop instances
description: Use the Cloud Adoption Framework for Azure to prepare your environment for virtual desktop migration using best practices that reduce complexity and standardize the migration process.
author: DominicAllen
ms.author: doalle
ms.date: 05/18/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-avd
---

# Azure Virtual Desktop Azure landing zone review

Before implementing Azure Virtual Desktop, the environment needs an Azure landing zone capable of hosting desktops and any supporting workloads. The following checklist can help the team evaluate the landing zone for compatibility. Guidance in the [Ready methodology](../../ready/index.md) of this framework can help the team build a compatible Azure landing zone, if one has not been provided.

## Evaluate compatibility

- **Resource organization plan:** The landing zone should include references to the subscription or subscriptions to be used, guidance on resource group usage, and the tagging and naming standards to be used when the team deploys resources.
- **Azure AD:** An Azure Active Directory (Azure AD) instance or an Azure AD tenant should be provided for end-user authentication. In addition, users must be synchronized from Active Directory Domain Services (AD DS) or Azure Active Directory Domain Services (Azure AD DS) to Azure AD.
- **Network:** Any required network configuration should be established in the landing zone prior to migration.
- **VPN or ExpressRoute:** Additionally, any landing zone that supports virtual desktops will need a network connection so that end users can connect to the landing zone and hosted assets. If an existing set of endpoints is configured for virtual desktops, end users can still be routed through those on-premises devices via a VPN or Azure ExpressRoute connection. If a connection doesn't already exist, you might want to review the guidance on configuring network connectivity options in the [Ready methodology](../../ready/index.md).
- **Governance, users, and identity:** For consistent enforcement, any requirements to govern access from virtual desktops and to govern users and their identities should be configured as Azure policies and applied to the landing zone.
- **Security:** The security team has reviewed the landing zone configurations and approved each landing zone for its intended use, including landing zones for the external connection and landing zones for any mission-critical applications or sensitive data.
- **Azure Virtual Desktop:** Azure Virtual Desktop platform as a service has been enabled.

Any landing zone that the team develops by using the best practices in the [Ready methodology](../../ready/index.md) and that can meet the previously mentioned specialized requirements would qualify as a landing zone for this migration.

To understand how to architect Azure Virtual Desktop, review the [Azure Virtual Desktop requirements](/azure/virtual-desktop/overview#requirements).

## Next steps

For guidance on specific elements of the cloud adoption journey, see:

- [Complete an Azure Virtual Desktop proof of concept](./proof-of-concept.md)
- [Assess for Azure Virtual Desktop migration or deployment](./migrate-assess.md)
- [Deploy or migrate Azure Virtual Desktop instances](./migrate-deploy.md)
- [Release your Azure Virtual Desktop deployment to production](./migrate-release.md)
