---
title: Deploy a migration landing zone in Azure
description: Learn how to deploy a migration landing zone in Azure.
author: BrianBlanchard
ms.author: brblanch
ms.date: 02/25/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Deploy a migration landing zone in Azure

A migration landing zone is an environment that has been provisioned and prepared to host workloads that are being migrated from an on-premises environment into Azure.

## Deploy the blueprint

Before you use the CAF Migration landing zone blueprint in the Cloud Adoption Framework, review the following design principles, assumptions, decisions, and implementation guidance. If this guidance aligns with the desired cloud adoption plan, the [CAF Migration landing zone blueprint](/azure/governance/blueprints/samples/caf-migrate-landing-zone) can be deployed using the deployment steps.

> [!div class="nextstepaction"]
> [Deploy the blueprint sample](/azure/governance/blueprints/samples/caf-migrate-landing-zone/deploy)

## Design principles

This implementation option provides an opinionated approach to the common design areas shared by all Azure landing zones. See the assumptions and decisions below for addition technical detail.

### Deployment options

This implementation option deploys a minimum viable product (MVP) to start a migration. As the migration progresses, the customer will follow a modular refactoring-based approach to mature the operating model in parallel guidance, using the [Govern methodology](../../govern/index.md) and the [Manage methodology](../../manage/index.md) to address those complex topics in parallel to the initial migration effort.

The specific resources deployed by this MVP approach are outlined in the [decisions](#decisions) section below.

### Enterprise enrollment

This implementation option doesn't take an inherent position on enterprise enrollment. This approach is designed to be applicable to customers regardless of contractual agreements with Microsoft or Microsoft partners. Prior to deployment of this implementation option, it is assumed that the customer has created a target subscription.

### Identity

This implementation option assumes that the target subscription is already associated with an Azure Active Directory instance in accordance with [identity management best practices](/azure/security/fundamentals/identity-management-best-practices?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json)

### Network topology and connectivity

This implementation option creates a virtual network with subnets for gateway, firewall, jump box, and landing zone. As a next step iteration, the team would follow the [networking decisions guide](../considerations/networking-options.md) to implement the appropriate form of connectivity between the gateway subnet and other networks in alignment with [network security best practices](/azure/security/fundamentals/network-best-practices?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json).

### Resource organization

This implementation option creates a single landing zone, in which resources will be organized into workloads defined by specific resource groups. Choosing this minimalist approach to resource organization defers the technical decision of resource organization until the team's cloud operating model is more clearly defined.

This approach is based on an assumption that the cloud adoption effort will not exceed [subscription limits](/azure/azure-resource-manager/management/azure-subscription-service-limits). This option also assumes limited architectural complexity and security requirements within this landing zone.

If this changes through the course of the cloud adoption plan, the resource organization may need to be refactored using the guidance in the [Govern methodology](../../govern/index.md).

### Governance disciplines

This implementation option doesn't implement any governance tooling. In the absence of defined policy automation, this landing zone should not be used for any mission critical workloads or sensitive data. It is assumed that this landing zone is being used for limited production deployment to initiate learning, iteration, and development of the overall operating model in parallel to these early stage migration efforts.

To accelerate parallel development of governance disciplines, review the [Govern methodology](../../govern/index.md) and consider deploying the [CAF Foundation blueprint](./foundation-blueprint.md) in addition to the CAF Migration landing zone blueprint.

> [!WARNING]
> As the governance disciplines mature, refactoring may be required. Specifically, resources may later need to be [moved to a new subscription or resource group](/azure/azure-resource-manager/management/move-resource-group-and-subscription?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json).

### Operations baseline

This implementation option doesn't implement any operations. In the absence of a defined operations baseline, this landing zone should not be used for any mission critical workloads or sensitive data. It is assumed that this landing zone is being used for limited production deployment to initiate learning, iteration, and development of the overall operating model in parallel to these early stage migration efforts.

To accelerate parallel development of an operations baseline, review the [Manage methodology](../../manage/index.md) and consider deploying the [Azure server management guide](../../manage/azure-server-management/index.md).

> [!WARNING]
> As the operations baseline is developed, refactoring may be required. Specifically, resources may later need to be [moved to a new subscription or resource group](/azure/azure-resource-manager/management/move-resource-group-and-subscription?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json).

### Business continuity and disaster recovery (BCDR)

This implementation option doesn't implement any BCDR solution. It is assumed that the solution for protection and recover will be addressed by the development of the operations baseline.

## Assumptions

This initial landing zone includes the following assumptions or constraints. If these assumptions align with your constraints, you can use the blueprint to create your first landing zone. The blueprint also can be extended to create a landing zone blueprint that meets your unique constraints.

- **Subscription limits:** This adoption effort isn't expected to exceed [subscription limits](/azure/azure-resource-manager/management/azure-subscription-service-limits).
- **Compliance:** No third-party compliance requirements are needed in this landing zone.
- **Architectural complexity:** Architectural complexity doesn't require additional production subscriptions.
- **Shared services:** No existing shared services in Azure require this subscription to be treated like a spoke in a hub and spoke architecture.
- **Limited production scope:** This landing zone could potentially host production workloads. It is not a suitable environment for sensitive data or mission-critical workloads.

If these assumptions align with your current adoption needs, then this blueprint might be a starting point for building your landing zone.

## Decisions

The following decisions are represented in the landing zone blueprint.

| Component                    | Decisions                                                                                         | Alternative approaches                                                                                                                                                                                                                                                                |
|------------------------------|---------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Migration tools              | Azure Site Recovery will be deployed and an Azure Migrate project will be created.                | [Migration tools decision guide](../../decision-guides/migrate-decision-guide/index.md)                                                                                                                                                                                               |
| Logging and monitoring       | Operational insights workspace and diagnostic storage account will be provisioned.                |                                                                                                                                                                                                                                                                                       |
| Network                      | A virtual network will be created with subnets for gateway, firewall, jump box, and landing zone. | [Networking decisions](../considerations/networking-options.md)                                                                                                                                                                                                                       |
| Identity                     | It's assumed that the subscription is already associated with an Azure Active Directory instance. | [Identity management best practices](/azure/security/fundamentals/identity-management-best-practices?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json) |
| Policy                       | This blueprint currently assumes that no Azure policies are to be applied.                        |                                                                                                                                                                                                                                                                                       |
| Subscription design          | N/A - designed for a single production subscription.                                              | [Create initial subscriptions](../azure-best-practices/initial-subscriptions.md)                                                                                                                                                                                                      |
| Resource groups              | N/A - designed for a single production subscription.                                              | [Scale subscriptions](../azure-best-practices/scale-subscriptions.md)                                                                                                                                                                                                                 |
| Management groups            | N/A - designed for a single production subscription.                                              | [Organize and manage subscriptions](../azure-best-practices/organize-subscriptions.md)                                                                                                                                                                                                |
| Data                         | N/A                                                                                               | [Choose the correct SQL Server option in Azure](/azure/sql-database/sql-database-paas-vs-sql-server-iaas) and [Azure data store guidance](/azure/architecture/guide/technology-choices/data-store-overview)                       |
| Storage                      | N/A                                                                                               | [Azure Storage guidance](../considerations/storage-options.md)                                                                                                                                                                                                                        |
| Naming and tagging standards | N/A                                                                                               | [Naming and tagging best practices](../azure-best-practices/naming-and-tagging.md)                                                                                                                                                                                                    |
| Cost management              | N/A                                                                                               | [Tracking costs](../azure-best-practices/track-costs.md)                                                                                                                                                                                                                              |
| Compute                      | N/A                                                                                               | [Compute options](../considerations/compute-options.md)                                                                                                                                                                                                                               |

## Customize or deploy a landing zone

Learn more and download a reference sample of the CAF Migration landing zone blueprint for deployment or customization from the Azure blueprint samples.

> [!div class="nextstepaction"]
> [Deploy the blueprint sample](/azure/governance/blueprints/samples/caf-migrate-landing-zone/deploy)

For guidance on customizations that should be made to this blueprint or the resulting landing zone, see the [landing zone considerations](../considerations/index.md).

## Next steps

After deploying your first landing zone, you're ready to expand your landing zone.

> [!div class="nextstepaction"]
> [Expand your landing zone](../considerations/index.md)
