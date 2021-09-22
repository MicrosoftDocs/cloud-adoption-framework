---
title: Platform automation and DevOps design area considerations
description: Explore considerations for Platform automation and devops 
author: DominicAllen
ms.author: doalle
ms.date: 8/1/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Platform automation and DevOps considerations

Many traditional IT operating models aren't compatible with the cloud, and organizations must undergo operational and organizational transformation to deliver against enterprise migration targets. You should use a DevOps approach for both application and central teams.

## Design considerations

- Where central teams are concerned, you should use pipelines for continuous integration and continuous deployment. Use the pipelines to manage policy definitions, role definitions, policy assignments, management group hierarchies, and subscriptions. These pipelines help ensure that you can operationally manage multiple subscriptions while still conforming to a desired state.

- The blanket application of a DevOps model won't instantly establish capable DevOps teams.

- Investing in engineering capabilities and resources is critical.

- You can arrange internal and external DevOps roles and functions from a variety of sources that align with your organization's strategy.

- For some legacy applications, the associated application team might not have engineering resources required to align with a DevOps strategy.
 
## Define central and federated responsibilities considerations

The distribution of roles, responsibilities, and trust between central IT teams and applications teams is paramount to the operational transformation your organization must undergo when adopting the cloud at scale.

Central teams strive to maintain full control while application owners seek to maximize agility. The balance between these goals can greatly influence the success of the migration.
