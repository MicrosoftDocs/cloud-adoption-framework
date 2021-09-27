---
title: Governance considerations
description: Design area considerations for governing your Azure environment
author: DominicAllen
ms.author: doalle
ms.date: 8/1/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Azure governance considerations


## Azure Policy - Design considerations

Azure Policy is essential to ensuring security and compliance within enterprise technical estates. It can enforce vital management and security conventions across Azure platform services. It can also supplement Azure role-based access control that controls what actions authorized users can do.

- Determine what Azure policies are needed.

- Enforce management and security conventions, such as the use of private endpoints.

- Manage and create policy assignments by using policy definitions can be reused at multiple inherited assignment scopes. You can have centralized, baseline policy assignments at management group, subscription, and resource group scopes.

- Ensure continuous compliance with compliance reporting and auditing.

- Understand that Azure Policy has limits, such as the restriction of definitions at any particular scope: [policy limits](/azure/azure-resource-manager/management/azure-subscription-service-limits).

- Understand regulatory compliance policies. The policies might include HIPAA, PCI DSS, or SOC 2 Trust Services Criteria.