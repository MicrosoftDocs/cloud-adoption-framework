---
title: Improve landing zone governance
description: Improve landing zone governance
author: BrianBlanchard
ms.author: brblanch
ms.date: 04/04/2020
ms.topic: overview
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Improve landing zone governance

Landing zone governance is the smallest unit of overall governance. Establishing a sound governance foundation within your first few landing zones will reduce the amount of refactoring required later in the adoption lifecycle. Improving landing zone governance will integrate cost controls, establish basic tooling to allow for scale, and will make it easier for the cloud governance team to deliver on the five disciplines of cloud governance.

## Landing zone governance best practices

- **Initial landing governance:** The article on establishing an [Initial governance foundation](../../govern/guides/complex/index.md) will aid in adding initial governance tooling to the first few landing zones. These practices will aid in scaling adoption and governance, along with implementing sound cost management. This approach starts with: Resource organization, Policy definitions, RBAC roles, and Blueprint definitions.
- **[Naming and tagging standards](../azure-best-practices/naming-and-tagging.md):** Ensure consistency in naming and tagging, which is the foundational data for establishing sound governance practices.
- **[Track costs across workloads](../azure-best-practices/track-costs.md):** Begin tracking costs in your first landing zone. Evaluate how you will apply consistency across multiple workloads and roles.
- **[Scale with multiple subscriptions](../azure-best-practices/scale-subscriptions.md):** Evaluate how this landing zone and other landing zones will scale, as multiple subscriptions become a requirement.
- **[Organize subscriptions](../azure-best-practices/organize-subscriptions.md):** Understand how to organize and manage multiple subscriptions.

## Four steps to improve overall governance

The [Govern methodology](../../govern/index.md) provides overall guidance for building out governance policies, processes, and disciplines. We will use the basic structure of that methodology and the following steps from that methodology to improve landing zone governance and governance across all landing zones.

1. [Understand the methodology](../../govern/methodology.md): Understand the basic methodology to guide end-state governance design.
2. [Benchmark](../../govern/benchmark.md): Assess both current and future state to establish a vision and take action.
3. [Initial governance foundation](../../govern/initial-foundation.md): Small, easily implemented set of governance tools to establish an initial foundation for all landing zones.
4. [Improve the governance foundation](../../govern/foundation-improvements.md): Iteratively add governance controls to strengthen all landing zone governance.

## Next steps

Cloud adoption will continue to expand with each wave or release of new workloads. To stay ahead of these requirements, it is suggested that cloud platform teams periodically [review additional landing zone best practices](../azure-best-practices/index.md).

> [!div class="nextstepaction"]
> [Review additional landing zone best practices](../azure-best-practices/index.md)
