---
title: Multicloud
description: Learn how to design your cloud infrastructure with multicloud in mind to support different business functions or provide high availability for critical systems.
ms.author: tozimmergren
author: Zimmergren
ms.topic: conceptual
ms.date: 11/21/2024
---

# Multicloud

- What
  - Multicloud is a deliberate strategy of using different public clouds, for example to support different business functions, or to provide high availability for critical systems.
  - Multicloud is not the same as using a variety of SaaS products for different business purposes.
  - Private clouds should also be considered in a multi-cloud strategy.
- Why
  - My question tells me that they don’t want to be tight with a CSP but the real question is How do I ensure I get the best from each CSP and specifically from Microsoft (Stephane)
  - Skills across different cloud providers, and organizational alignment/training (e.g. do you skill the same people in two clouds? Or create separate teams for each cloud?)Understand the cost models. If you have signed up for a MACC, how do you track your spending across clouds to make sure you are maximizing cost efficiency?
- How / Who
  - Don't confuse multicloud with portability. All clouds will have some custom properties or services that mean moving a workload seamlessly from one to another becomes difficult, and developing workloads that are totally vendor-agnostic should not be a goal, as it prevents the use of the unique services that a specific cloud has to offer.
  - Instead, think about where the boundaries should exist between clouds, and where those boundaries are reflected in your organization. For example, if you operate several completely separate business units, then autonomy around cloud selection may be justified. If everything across the company is managed in a single IT function, then multicloud will mean additional skills, governance, and monitoring overhead.

## Next steps

> [!div class="nextstepaction"]
> [Communicate the strategy](../communication.md)