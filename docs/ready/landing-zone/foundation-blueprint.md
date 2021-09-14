---
title: Deploy a CAF Foundation blueprint in Azure
description: Learn how to deploy a CAF Foundation blueprint in Azure.
author: BrianBlanchard
ms.author: brblanch
ms.date: 09/27/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

<!-- docutune:ignore "CAF Foundation blueprint" -->

# Deploy a CAF Foundation blueprint in Azure

The CAF Foundation blueprint does not deploy a landing zone. Instead, it deploys the tools required to establish a governance MVP (minimum viable product) to begin developing your governance disciplines. This blueprint is designed to be additive to an existing landing zone and can be applied to the CAF Migration landing zone blueprint with a single action.

## Deploy the blueprint

Before you use the CAF Foundation blueprint in the Cloud Adoption Framework, review the following design principles, assumptions, decisions, and implementation guidance. If this guidance aligns with the desired cloud adoption plan, the [CAF Foundation blueprint](/azure/governance/blueprints/samples/caf-foundation/) can be deployed using the deployment steps.

> [!div class="nextstepaction"]
> [Deploy the blueprint sample](/azure/governance/blueprints/samples/caf-foundation/deploy)

## Design principles

This implementation option provides an opinionated approach to the common design areas shared by all Azure landing zones. See the assumptions and decisions below for addition technical detail.

### Deployment options

This implementation option deploys an MVP to serve as the foundation for your governance disciplines. The team will follow a modular refactoring-based approach to mature the governance disciplines using the [Govern methodology](../../govern/index.md).

### Enterprise enrollment

This implementation option does not take an inherent position on enterprise enrollment. This approach is designed to be applicable to customers regardless of contractual agreements with Microsoft or Microsoft partners. Prior to deployment of this implementation option, it's assumed that the customer has already created a target subscription.

### Identity

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

### Governance disciplines

This implementation demonstrates one approach to maturity in the Cost Management discipline of the Govern methodology. Specifically, it demonstrates how Azure Policy can be used to create an allow list of specific SKUs. Limiting the types and sizes of resources that can be deployed into a landing zone reduces the risk of overspending.

To accelerate parallel development of the other governance disciplines, review the [Govern methodology](../../govern/index.md). To continue maturing the Cost Management discipline of governance, see the [Cost Management discipline guidance](../../govern/guides/complex/cost-management-improvement.md#incremental-improvement-of-best-practices).

> [!WARNING]
> As the governance disciplines mature, refactoring may be required. Refactoring may be required. Specifically, resources may later need to be [moved to a new subscription or resource group](/azure/azure-resource-manager/management/move-resource-group-and-subscription?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json).

### Operations baseline

This implementation option does not implement any aspects of the operations baseline. In the absence of a defined operations baseline, this landing zone should not be used for any mission critical workloads or sensitive data. It is assumed that this landing zone is being used for limited production deployment to initiate learning, iteration, and development of the overall operating model in parallel to these early stage migration efforts.

To accelerate parallel development of an operations baseline, review the [Manage methodology](../../manage/index.md) and consider deploying the [Azure server management guide](../../manage/azure-server-management/index.md).

> [!WARNING]
> As the operations baseline is developed, refactoring may be required. Specifically, resources may later need to be [moved to a new subscription or resource group](/azure/azure-resource-manager/management/move-resource-group-and-subscription?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json).

### Business continuity and disaster recovery (BCDR)

This implementation option does not implement any BCDR solution. It is assumed that the solution for protection and recover will be addressed by the development of the operations baseline.

## Assumptions

This initial blueprint assumes that the team is committed to maturing governance capabilities in parallel to the initial cloud migration efforts. If these assumptions align with your constraints, you can use the blueprint to begin the process of developing governance maturity.

- **Compliance:** No third-party compliance requirements are needed in this landing zone.
- **Limited production scope:** This landing zone could potentially host production workloads. It is not a suitable environment for sensitive data or mission-critical workloads.

If these assumptions align with your current adoption needs, then this blueprint might be a starting point for building your landing zone.

## Customize or deploy this blueprint

Learn more and download a reference sample of the CAF Foundation blueprint for deployment or customization from the Azure blueprint samples.

> [!div class="nextstepaction"]
> [Deploy the blueprint sample](/azure/governance/blueprints/samples/caf-foundation/deploy)

## Next steps

After deploying your first landing zone, you're ready to expand your landing zone.

> [!div class="nextstepaction"]
> [Expand your landing zone](../considerations/index.md)
