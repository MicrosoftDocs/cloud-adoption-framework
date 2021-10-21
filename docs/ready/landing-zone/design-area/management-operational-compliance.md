---
title: Management - Operational compliance
description: Design area guidance for managing your Azure platform services
author: DominicAllen
ms.author: doalle
ms.date: 8/1/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---


# Operational compliance considerations | Management design area

TODO: What else does ESLZ have to say regarding resource level configuration, configuration drift, reacting to outages or changes to Azure services, cost and sizing optimization?

### Update management considerations

- Are there existing update management tools used by the organization? Can they be extended to cover the cloud environment or are new tools required?
- Which teams will be responsible for overseeing update management?
- Are there groups of resources that share similar update schedules?
- Are there groups of resources that cannot be updated at the same time for business continuity reasons?  
