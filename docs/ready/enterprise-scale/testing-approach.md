---
title: Testing approach for Enterprise Scale
description: Testing approach for Enterprise Scale
author: JackTracey
ms.author: jatracey
ms.date: 02/02/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready 
ms.custom: think-tank
---

# Testing approach for Enterprise Scale

We recognise that larger organisations may wish to also test their Enterprise Scale deployments (e.g. Azure Policy definitions and assignments, RBAC custom roles and assignments, etc.) whether this is via automation (ARM Templates, Terraform etc.) or manually via the portal. This article will provide a suggested approach that can be taken to achieve the testing of changes and their impact in Enterprise Scale deployments.

## Diagram 

***THIS DIAGRAM NEEDS UPDATING TO SHOW THE CANARY SIDE OF THE MANAGEMENT GROUP HIERARCHY***

![Diagram that shows management group hierarchy.](./media/sub-org.png)

_Figure 1: Management group hierarchy._

## Summary


### Reasons Why Not To Use Seperate Azure AD Tenants:

- Have to purchase duplicate licenses for Azure AD features (PIM/MFA etc.)
- Users have to have multiple accounts - security risk
  - Protect with AAD P2 features & PIM from single AAD tenant instead to fix this
- Doesn't allow testing of RBAC and Policy changes effectively - due to separate tenant so code will be different
  - Better to use single tenant and split out separate management group structure beneath Tenant - Root Group - e.g "Contoso" = Prod, "Contoso-Canary" = dev/test
- Single tenant and multiple MG structures allow single view for security and compliance
- Single tenant keep things simple and reduces risk of shadow IT for Azure