---
title: Azure landing zone review for Microsoft Azure VMware Solution
description: Learn about how Microsoft Azure VMware Solution affects your Azure landing zone design.
author: Zimmergren
ms.author: pnp
ms.date: 05/07/2024
ms.topic: conceptual
ms.custom: e2e-azure-vmware, think-tank
---

# Azure landing zone review for Microsoft Azure VMware Solution

The [Ready methodology](../../ready/index.md) of the Cloud Adoption Framework guides customers through environment readiness to prepare for cloud adoption. This readiness section includes technical accelerators (Azure landing zones), which are the basic building block in any cloud adoption environment. Azure landing zones automate the configuration of your Azure environment and align it with best practices guidance in the Cloud Adoption Framework guides. As you prepare for an Azure VMware Solution, consider that your environment configurations might need to be slightly different.

This article outlines key considerations and changes that are necessary to prepare your environments.

## Azure VMware Solution evaluation

As you evaluate an Azure VMware Solution, consider these best practices:

**Resource organization plan:** For the landing zone, include references to the subscriptions to use, guidance on resource group usage, and the tagging and naming standards to use when the team deploys resources.

**Microsoft Entra ID and Active Directory:** Use the Active Directory Sites and Services tool to direct Azure and Azure VMware Solution Active Directory Domain Services traffic to the appropriate domain controllers.

As part of the identity and access management enterprise-scale landing zone, an Active Directory Domain Services domain controller is deployed in the identity subscription.

**Network topology and connectivity:** Establish any required network configuration in the landing zone before migration. Consider requirements that might affect your Azure VMware Solution deployment such as:

- Traffic inspection
- Network traffic flows
- Internet egress and ingress
- Use of NVAs
- Connectivity to standard hub virtual network or an Azure Virtual WAN hub
- Private connectivity

**Management and monitoring​:** Create alerts and dashboards on metrics that are most important to your operations teams.

License VMware ecosystem solutions like vRealize Operations, vRealize Log Insight and vRealize Network Insight. These solutions provide a detailed understanding of the Azure VMware Solution platform.

Configure guest monitoring for virtual machines that run in Azure VMware Solution by following the hybrid documentation available for Windows and Linux.

**Business continuity and disaster recovery:** Select a validated backup solution for the VMware virtual machines, such as Microsoft Azure Backup Server (MABS), or from our backup partners.

When working with Azure VMware Solution in both primary (protected) and secondary (recovery) sites, use VMware Site Recovery Manager.

**Governance and compliance:** Use specific design elements for:

- Environment governance
- Guest application and VM governance
- Environment and guest compliance

**Security:** As you decide who can do specific functions within Azure VMware Solution, review and plan for the main areas of:

- Identity security
- Environment and network security
- Guest application and VM security

**Platform automation and DevOps​:** Use guidance for automation and DevOps to assist with the deployment of an Azure VMware Solution private cloud, such as:

- Deployment options for Azure VMware Solution, including manual and automated
- Automated scale considerations and implementation details
- Considerations for VMware-level automation within a private cloud
- Recommendations on automation approaches extended from an enterprise landing zone
- Considerations on automation technologies to use for deployment and management, like Azure CLI, Azure Resource Manager template, Bicep, and PowerShell

## Azure VMware Solution Azure landing zone acceleration

Azure VMware Solution requires an understanding of Azure landing zones and makes use of infrastructure-as-code to deploy end-to-end solution templates. These solution templates are customizable and are a starter for most Azure VMware Solution scenarios. For more information, see:

- [What is an Azure landing zone?](../../ready/landing-zone/index.md)
- [Deploy Azure landing zones](/azure/architecture/landing-zones/landing-zone-deploy)

## Next step

Examine design considerations and recommendations related to identity and access management that are specific to the deployment of Azure VMware Solution.

> [!div class="nextstepaction"]
> [Identity and access management](./eslz-identity-and-access-management.md)
