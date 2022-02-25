---
title: Approaches
description: TODO
author: nickwalkmsft
ms.author: nickwalk
ms.date: 2/25/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: adopt
---

# Cloud migration and modernization approaches

Customers are confused about whether they should migrate or modernize

"Depending on your overall strategy and needs, you may migrate first and modernize later, or vice versa, but it's important to keep those horizons separated". (at least separating out clusters of workloads - if you have one team working on migrating some workflows and another team working on modernizing others, keep them separate. The "clusters of workloads" concept is presented in envision-cloud-modernization)

Deciding which to do first comes down to *what benefits you're after*. There are distinct motivations/reasons and outcomes. Migrate first -> IaaS; modernize first -> containers/PaaS.

This graphic sums up the decision making based on the benefits:

:::image type="content" source="../_images/adopt/migration-modernization-approaches.png" alt-text="img":::

<br><br><br>

Also want to illustrate how it's not "all or nothing". The image below presents an example of how a customer broke down their portfolio into migrate and modernize approaches. In the image, the percentages are not the focus (they're a hand-wavy "average" of customers), and the callouts to sequencing ("First to move", "next to move") aren't intended to represent a prescribed sequence of operations, they're just to indicate the **relative size of work**: everything under "first to move" is the simplest", and so on. Customers more focused on control will lift-and-shift and migrate. More interest in productivity -> modernization: SaaS/PaaS/serverless. For most customers it's a mix.

:::image type="content" source="../_images/adopt/portfolio-migration-modernization-approach.png" alt-text="img":::

In regards to the last bullet on the right: if there is "deep architectural change" involved, that is *not* modernization, it is *rearchitecture*, and the customer should be referencing WAF. Additionally, the top row of bullets (shifting pieces of LoB apps to PowerApps, etc.) is also not part of modernization, it's *innovation*, and that guidance should live there.