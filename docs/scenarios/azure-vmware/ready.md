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

The [Ready methodology](../../ready/index.md) of the Microsoft Azure Cloud Adoption Framework guides customers through environment readiness to prepare for cloud adoption. The readiness section includes technical accelerators (Azure landing zones), which are the basic building block in any cloud adoption environment. Landing zones automate the configuration of your Azure environment, aligning with best practices guidance in the Cloud Adoption Framework. When preparing for a Azure VMware Solution, there are a number of environment configurations that might be slightly different.

This article outlines key considerations and changes that are necessary to prepare your environments for the following:

## Azure VMware Solution evaluation

<What should the customer be looking for when evaluating an Azure Landing Zone for compatibility?

**Resource organization plan:** The landing zone should include references to the subscription or subscriptions to be used, guidance on resource group usage, and the tagging and naming standards to be used when the team deploys resources.

**Azure AD and Active Directory:** As part of the Identity and Access Management Enterprise Scale Landing Zone (ESLZ), an Active Directory Domain Services Domain Controller is deployed in the Identity Subscription. Active Directory Sites and Services should be updated to direct Azure and AVS AD DS traffic to the appropriate Domain Controllers.

**Network:** Any required network configuration should be established in the landing zone prior to migration. For critical AVS platforms, use the guidance in the enterprise-scale design areas as the design foundations, including hybrid integration, performance reliability at scale, and zero-trust based network security. There are some key considerations that affect your AVS deployment, including traffic inspection requirements, internet egress and ingress requirements, the use of NVAs, connectivity to standard Hub vNet or Azure Virtual WAN Hub, and private connectivity.

**Governance and compliance:**

**Security:**

## Azure VMware Solution Azure Landing Zone acceleration

Reference any articles, reference architectures, or best practices that would accelerate deployment of an Azure Landing Zone that passed the evaluation criteria.

## Next steps: Assess for Azure VMware Solution

The following list of articles will take you to guidance found at specific points throughout the cloud adoption journey to help you be successful in the cloud adoption scenario.

- [Plan for Azure VMware Solution](./plan.md)
- [Review your environment or Azure Landing Zone(s)](./ready.md)
- [Migrate Azure VMware Solution](./migrate.md)
- [Innovate with Azure VMware Solution](./innovate.md)
- [Govern Azure VMware Solution](./govern.md)
- [Manage Azure VMware Solution](./manage.md)