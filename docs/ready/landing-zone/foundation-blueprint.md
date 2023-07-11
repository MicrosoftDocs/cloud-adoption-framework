---
title: Deploy a CAF Foundation blueprint in Azure
description: Learn how to deploy a CAF Foundation blueprint in Azure.
author: martinekuan
ms.author: martinek
ms.date: 04/21/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom:
  - internal
  - engagement-fy23
---

<!-- docutune:ignore "CAF Foundation blueprint" -->

# Deploy a CAF Foundation blueprint in Azure

The CAF Foundation blueprint does not deploy a landing zone. Instead, it deploys the tools required to establish a governance MVP (minimum viable product) to begin developing your governance disciplines. This blueprint is designed to be additive to an existing landing zone and can be applied to the CAF Migration landing zone blueprint with a single action.

## Deploy the blueprint

Before you use the CAF Foundation blueprint in the Cloud Adoption Framework, review the following design principles, assumptions, decisions, and implementation guidance. If this guidance aligns with the desired cloud adoption plan, the [CAF Foundation blueprint](/azure/governance/blueprints/samples/caf-foundation/) can be deployed using the deployment steps.

> [!div class="nextstepaction"]
> [Deploy the blueprint sample](/azure/governance/blueprints/samples/caf-foundation/deploy)

### Deployment options

This implementation option deploys a minimum viable product (MVP) to serve as the foundation for your governance disciplines. The team will follow a modular refactoring-based approach to mature the governance disciplines using the [Govern methodology](../../govern/index.md).

## Design areas

This implementation option provides an opinionated approach to the common design areas shared by all Azure landing zones. For technical details, see the [Assumptions](#assumptions) section.

### Azure billing and Active Directory tenant

This implementation option does not take an inherent position on enterprise enrollment. This approach is designed to be applicable to customers regardless of contractual agreements with Microsoft or Microsoft partners. Prior to deployment of this implementation option, it's assumed that the customer has already created a target subscription.

### Identity and access management

This implementation option assumes that the target subscription is already associated with an Azure Active Directory instance in accordance with [identity management best practices](/azure/security/fundamentals/identity-management-best-practices?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json).

### Network topology and connectivity

This implementation option assumes the landing zone already has a defined network topology in accordance with [network security best practices](/azure/security/fundamentals/network-best-practices?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json).

### Resource organization

This implementation option demonstrates how Azure Policy can add some elements of resource organization through the application of tags. Specifically, a `CostCenter` tag will be appended to resources using Azure Policy.

The governance team should compare and contrast the elements of resource organization to be addressed by tagging versus those that should be addressed through subscription design. These fundamental decisions will inform resource organization as your cloud adoption plans progress.

To aid in this comparison early in adoption cycles, the following articles should be considered:

- [Initial Azure subscriptions](../azure-best-practices/initial-subscriptions.md): At this stage of adoption scale, does your operating model require two, three, or four subscriptions?
- [Scale subscriptions](../azure-best-practices/scale-subscriptions.md): As adoption scales, what criteria will be used to drive subscription scaling?
- [Organize subscriptions](../azure-best-practices/organize-subscriptions.md): How will you organize subscriptions as you scale?
- [Tagging standards](../azure-best-practices/resource-tagging.md): What other criteria need to be consistently captured in tags to augment your subscription design?

To aid in this comparison when teams are further along with cloud adoption, see the governance patterns section of the [governance guide: prescriptive guidance](../../govern/guides/complex/prescriptive-guidance.md#application-of-governance-defined-patterns) article. This section of the prescriptive guidance demonstrates a set of patterns based on a specific narrative and operating model. That guidance also includes links to other patterns that should be considered.

### Security

This implementation option doesn't implement controls for the primary purpose of security. In the absence of defined security controls, you shouldn't use this landing zone for mission critical workloads or sensitive data. It's assumed you're using this landing zone for limited production deployment. This deployment starts your learning, iteration, and development of the operating model in parallel with these early migration efforts.

To accelerate parallel development of security disciplines, review the [Secure methodology](../../secure/index.md). Consider deploying the [Cloud Adoption Framework Foundation blueprint](./foundation-blueprint.md) along with the Cloud Adoption Framework Migration landing zone blueprint.

### Management

This implementation option does not implement key aspects of the operations baseline. In the absence of a defined operations baseline, this landing zone should not be used for mission critical workloads or sensitive data. It is assumed that this landing zone is being used for limited production deployment to initiate learning, iteration, and development of the overall operating model in parallel to these early stage migration efforts.

To accelerate parallel development of an operations baseline, review the [Manage methodology](../../manage/index.md) and consider deploying the [Azure server management guide](../../manage/azure-server-management/index.md).

> [!WARNING]
> As the operations baseline is developed, refactoring may be required. Specifically, resources may later need to be [moved to a new subscription or resource group](/azure/azure-resource-manager/management/move-resource-group-and-subscription?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json).

This implementation option doesn't have affordances for business continuity and disaster recovery (BCDR). It's assumed that the solution for protection and recovery will be addressed by the development of the operations baseline.

### Governance

This implementation demonstrates one approach to maturity in the Cost Management discipline of the Govern methodology. Specifically, it demonstrates how Azure Policy can be used to create an allow list of specific SKUs. Limiting the types and sizes of resources that can be deployed into a landing zone reduces the risk of overspending.

To accelerate parallel development of the other governance disciplines, review the [Govern methodology](../../govern/index.md). To continue maturing the Cost Management discipline of governance, see the [Cost Management discipline guidance](../../govern/guides/complex/cost-management-improvement.md#incremental-improvement-of-best-practices).

> [!WARNING]
> As the governance disciplines mature, refactoring may be required. Refactoring may be required. Specifically, resources may later need to be [moved to a new subscription or resource group](/azure/azure-resource-manager/management/move-resource-group-and-subscription?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json).

### Platform automation and DevOps

This implementation option doesn't implement automated Azure pipelines in DevOps. In the absence of defined automation, you shouldn't use this landing zone for mission critical workloads or sensitive data. It's assumed you're using this landing zone for limited production deployment. This deployment starts your learning, iteration, and development of the operating model in parallel with these early migration efforts.

To accelerate parallel development, review the [Ready methodology](../../ready/index.md). Consider deploying the [Cloud Adoption Framework Foundation blueprint](./foundation-blueprint.md) along with the Cloud Adoption Framework Migration landing zone blueprint.

## Assumptions

This initial blueprint assumes that the team is committed to maturing governance capabilities in parallel to the initial cloud migration efforts. If these assumptions align with your constraints, you can use the blueprint to begin the process of developing governance maturity.

- **Compliance:** No third-party compliance requirements are needed in this landing zone.
- **Limited production scope:** This landing zone could potentially host production workloads. It is not a suitable environment for sensitive data or mission-critical workloads.

If these assumptions align with your current adoption needs, then this blueprint might be a starting point for building your landing zone.

## Next steps

Learn more and download a reference sample of the CAF Foundation blueprint for deployment or customization from the Azure blueprint samples.

> [!div class="nextstepaction"]
> [Deploy the blueprint sample](/azure/governance/blueprints/samples/caf-foundation/deploy)

When you're ready to exand this foundation into your first landing zone, see [Transition existing Azure environments to the Azure landing zone conceptual architecture](../enterprise-scale/transition.md).
