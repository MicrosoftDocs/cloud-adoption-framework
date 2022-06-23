---
title: Improve landing zone governance
description: Improve landing zone governance.
author: asudbring
ms.author: allensu
ms.date: 06/22/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Improve landing zone governance

Landing zone governance is the smallest unit of overall governance. Establishing a sound governance foundation within your first few landing zones will reduce the amount of refactoring required later in the adoption lifecycle. Improving landing zone governance will integrate cost controls, establish basic tooling to allow for scale, and will make it easier for the cloud governance team to deliver on the five Disciplines of Cloud Governance.

## Landing zone governance best practices

The following list of guides and best practices provide examples of ways to improve landing zone governance:

- [Governance](../../govern/index.md) : The methodology for the cloud adoption framework provides overall guidance for creating governance policies, processes, and disciplines. Steps to improve the overall governance of landing zones include:
    - [Methodology](../../govern/methodology.md): Understand the pieces of the methodology and how they fit into the design. Evaluate corporate policies and processes and how they will align with the over all governance strategy.
    - [Benchmark](../../govern/benchmark.md): Use the governance benchmark tool to discover gaps in your organization. Assess the current and future state to establish a plan and take action.
    - [Initial foundation](../../govern/initial-foundation.md): Establish an initial cloud governance foundation. Establish an initial foundation for all landing zones.
    - [Improve foundation](../../govern/foundation-improvements.md): Iteratively add governance controls to strengthen all landing zone governance.  
- [Governance guide for complex enterprises](../../govern/guides/complex/index.md): Establishing an initial governance foundation can assist with adding initial governance tooling to the first few landing zones. These practices will aid in scaling adoption and governance, along with implementing sound cost management. This approach starts with: resource organization, policy definitions, Azure roles, and blueprint definitions.
- [Naming and tagging standards](../azure-best-practices/naming-and-tagging.md): Ensure consistency in naming and tagging, which is the foundational data for establishing sound governance practices.
- [Track costs across workloads](../azure-best-practices/track-costs.md): Begin tracking costs in your first landing zone. Evaluate how you will apply consistency across multiple workloads and roles.
- [Scale with multiple subscriptions](../azure-best-practices/scale-subscriptions.md): Evaluate how this landing zone and other landing zones will scale, as multiple subscriptions become a requirement.
- [Organize subscriptions](../landing-zone/design-area/resource-org.md): Understand how to organize and manage multiple subscriptions.

## Test-driven development cycle

Before beginning any security improvements, it's important to understand the "definition of done" and all "acceptance criteria". For more information, see the articles on [test-driven development of landing zones](./test-driven-development.md) and [test-driven development in Azure](./azure-test-driven-development.md).

![Test-driven development process for cloud landing zones](../../_images/ready/test-driven-development-process.png)

## Next steps

Cloud adoption will continue to expand with each wave or release of new workloads. To stay ahead of these requirements, cloud platform teams should periodically review the landing zone design areas.

> [!div class="nextstepaction"]
> [Review landing zone design areas](../landing-zone/design-areas.md)
