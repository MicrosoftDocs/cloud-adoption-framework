---
title: "Azure landing zones for Windows Virtual Desktop instances"
description: Use the Cloud Adoption Framework for Azure to learn Virtual desktop migration best practices to reduce complexity and standardize the migration process.
author: BrianBlanchard
ms.author: brblanch
ms.date: 07/01/2010
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
---

# Windows Virtual Desktop Azure landing zone review

Before migrating to WVD, the team will need an Azure landing zone that is capable of hosting desktops and any supporting workloads. The following checklist will help evaluate the landing zone for compatibility. Guidance in the [Ready methodology](../../ready/index.md) of this framework can help build a compatible Azure landing zone, if one has not been provided.

## Evaluate compatibility

- **Resource organization plan:** The landing zone should include references to the subscription or subscriptions to be use, guidance on resource group usage, and the tagging and naming standards to be used when deploying resources.
- **Azure AD:** An Azure Active Directory or Azure AD tenant should be provided for end user authentication.
- **Network:** Any required network configuration should be established in the landing zone prior to migration.
- **VPN or ExpressRoute:** Additionally, any landing zone that supports virtual desktops will need a network connection for end users to connect to the landing zone and hosted assets. If there is an existing set of endpoints configured for virtual desktops, end users can still be routed through those on-premises devices via a VPN or ExpressRoute connection. If one doesn't exist already, you may want to review the guidance on configuring network connectivity options in the [Ready methodology](../../ready/index.md).
- **Governance, users, and identity:** Any requirements to govern access from virtual desktops, along with any requirements to govern users and their identities should be configured as Azure policies and applied to the landing zone for consistent enforcement.
- **Security:** The security team has reviewed the landing zone configurations and approved each landing zone for the intended use, included landing zones for the external connection and landing zones for any mission critical applications or sensitive data.
- **Windows Virtual Desktop (WVD):** The WVD PaaS service has been enabled. <!-- TODO: Add link to enable the service. -->

Any landing zone developed using the best practices in the [Ready methodology](../../ready/index.md) that can meet the specialized requirements listed above would qualify as a candidate landing zone for this migration.

To understand how to architect Windows Virtual Desktop review the [requirements here](https://docs.microsoft.com/azure/virtual-desktop/overview#requirements).

## Next step: Complete a Windows Virtual Desktop proof of concept

- [Complete a Windows Virtual Desktop proof of concept](./proof-of-concept.md)
- [Assess for Windows Virtual Desktop migration or deployment](./migrate-assess.md)
- [Deploy or migrate Windows Virtual Desktop instances](./migrate-deploy.md)
- [Release your Windows Virtual Desktop deployment to production](./migrate-release.md)
