---
title: Azure Landing Zone review for Azure VMware Solution
description: Learn about how Azure VMware Solution affects your Azure landing zone design.
author: WendyRing    
ms.author: janet    
ms.date: 09/02/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Azure Landing Zone review for Azure VMware Solution

The [Ready methodology](../../ready/index.md) of the Microsoft Azure Cloud Adoption Framework guides customers through environment readiness to prepare for cloud adoption. The readiness section includes technical accelerators (Azure landing zones), which are the basic building block in any cloud adoption environment. Landing zones automate the configuration of your Azure environment, aligning with best practices guidance in the Cloud Adoption Framework. When preparing for an Azure VMware Solution (AVS), there are many environment configurations that might be slightly different.

This article outlines key considerations and changes that are necessary to prepare your environments:

## Azure VMware Solution evaluation

**Resource organization plan:** The landing zone should include references to the subscription or subscriptions to be used, guidance on resource group usage, and the tagging and naming standards to be used when the team deploys resources.

**Azure AD and Active Directory:** As part of the Identity and Access Management Enterprise Scale Landing Zone (ESLZ), an Active Directory Domain Services Domain Controller is deployed in the Identity Subscription. Active Directory Sites and Services should be updated to direct Azure and AVS AD DS traffic to the appropriate Domain Controllers.

**Network topology and connectivity:** Any required network configuration should be established in the landing zone before migration. Consider requirements that affect your AVS deployment such as:

- Traffic inspection
- Internet egress and ingress
- Use of NVAs
- Connectivity to standard Hub vNet or Azure Virtual WAN Hub
- Private connectivity

**Management and monitoring​:** Create alerts and dashboards on metrics that are most important to your operations teams. Consider licensing VMware eco-system solutions like vRealize Operations Manager and vRealize Network Insights. These solutions provide a detailed understanding of the Azure VMware Solution platform. Configure guest monitoring for virtual machines that run in Azure VMware Solution by following the hybrid documentation available for Windows and Linux.

**Business continuity and disaster recovery:** Select a validated backup solution for the VMware Virtual Machines, such as Microsoft Azure Backup Server (MABS) or from our backup partners. When working with Azure VMware Solution in both primary (protected) and secondary (recovery) sites, VMware Site Recovery Manager should be used.

**Governance and compliance:dd** Consider specific design elements for environment governance, guest application and VM governance, and environment and guest compliance when you implement Azure VMware Solution.

**Security:** Review and plan for the main areas of identity security, environment and network security, and guest application and VM security, when you decide who can do specific functions within Azure VMware Solution.

**Platform automation and DevOps​:** Guidance for automation and DevOps can assist with the deployment of an Azure VMware Solution (AVS) Private Cloud such as:

- Deployment options for AVS including manual and automated
- Automated scale considerations and implementation details
- Considerations for VMware-level automation within a private cloud
- Recommendations on automation approaches extended from an enterprise landing zone
- Considerations on automation technologies to use for deployment and management, like Azure CLI, Azure Resource Manager template, Bicep, and PowerShell

## Azure VMware Solution Azure Landing Zone acceleration

Azure VMware Solution requires an understanding of Azure landing zones and makes use of infrastructure-as-code to deploy end to end solution templates. These solution templates are customizable and are a starter for most Azure VMware Solution scenarios. To learn more, see:

- [What is a landing zone?](../../ready/landing-zone/index.md)
- [Choose a landing zone option](../../ready/landing-zone/choose-landing-zone-option.md)
- [Refactoring landing zones](../../ready/landing-zone/refactor.md)

## Next steps

> [!div class="nextstepaction"]
> [Identity and access management](./eslz-identity-and-access-management.md)
