---
title: Deploy a migration landing zone in Azure
description: Learn how to deploy a migration landing zone in Azure. Use this landing zone to move an on-premises environment into Azure.
author: martinekuan
ms.author: martinek
ms.date: 12/10/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Deploy a migration landing zone in Azure

A migration landing zone is an environment that's been provisioned and prepared to host certain workloads. These workloads are being migrated from an on-premises environment into Azure.

## Deploy the blueprint

Before you use the Cloud Adoption Framework Migration landing zone blueprint, review the following design principles, assumptions, decisions, and implementation guidance. Make sure that this guidance aligns with the cloud adoption plan you want. If so, you can deploy the [Cloud Adoption Framework Migration landing zone blueprint](/azure/governance/blueprints/samples/caf-migrate-landing-zone/) using the deployment steps.

> [!div class="nextstepaction"]
> [Deploy the blueprint sample](/azure/governance/blueprints/samples/caf-migrate-landing-zone/deploy)

### Deployment options

This implementation option deploys a minimum viable product (MVP) to start a migration. As the migration progresses, follow a modular refactoring-based approach to mature the operating model in parallel guidance. Use the [Govern methodology](../../govern/index.md) and the [Manage methodology](../../manage/index.md) to address those complex topics in parallel with the initial migration effort.

The specific resources deployed by this MVP approach are outlined in the [decisions](#decisions) section below.

## Design areas

This implementation option is an opinionated approach to the common design areas shared by all Azure landing zones. For technical details, see the [assumptions](#assumptions) and [decisions](#decisions).

### Azure billing and Active Directory tenant

This implementation option doesn't take an inherent position on enterprise enrollment. This approach is designed to be applicable no matter what contractual agreements you have with Microsoft or Microsoft partners. Before you deploy this implementation option, it's assumed that you've created a target subscription.

### Identity and access management

This implementation option assumes that the target subscription is already associated with an Azure Active Directory (Azure AD) instance. Using this association follows the [identity management best practices](/azure/security/fundamentals/identity-management-best-practices?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json).

### Network topology and connectivity

This implementation option creates a virtual network with subnets for a gateway, firewall, jump box, and landing zone. As a next step iteration, the team would follow the [networking decisions guide](../considerations/networking-options.md) to implement the appropriate form of connectivity between the gateway subnet and other networks. This implementation is in alignment with [network security best practices](/azure/security/fundamentals/network-best-practices?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json).

### Resource organization

This implementation option creates a single landing zone, in which resources are organized into workloads defined by specific resource groups. Choosing this minimalist approach to resource organization defers the technical decision of resource organization. You can defer this decision until your team clearly defines the cloud operating model.

This approach is based on an assumption that the cloud adoption effort won't exceed [subscription limits](/azure/azure-resource-manager/management/azure-subscription-service-limits). This option also assumes limited architectural complexity and security requirements within this landing zone.

If this complexity changes through the course of the cloud adoption plan, you might need to refactor your resource organization using the guidance in the [Govern methodology](../../govern/index.md).

### Security

This implementation option doesn't implement controls for the primary purpose of security. In the absence of defined security controls, you shouldn't use this landing zone for mission critical workloads or sensitive data. It's assumed you're using this landing zone for limited production deployment. This deployment starts your learning, iteration, and development of the operating model in parallel with these early migration efforts.

To accelerate parallel development of security disciplines, review the [Secure methodology](../../secure/index.md). Consider deploying the [Cloud Adoption Framework Foundation blueprint](./foundation-blueprint.md) along with the Cloud Adoption Framework Migration landing zone blueprint.


### Management

This implementation option doesn't implement management operations that can be used in production. In the absence of a defined operations baseline, you shouldn't use this landing zone for mission critical workloads or sensitive data. It's assumed your using this landing zone for limited production deployment. This deployment starts the learning, iteration, and development of the operating model in parallel with these early migration efforts.

To accelerate parallel development of an operations baseline, review the [Manage methodology](../../manage/index.md) and consider deploying the [Azure server management guide](../../manage/azure-server-management/index.md).

> [!WARNING]
> As you develop the operations baseline, you might need to refactor. You might need to move resources [to a new subscription or resource group](/azure/azure-resource-manager/management/move-resource-group-and-subscription?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json).

This implementation option doesn't have affordances for business continuity and disaster recovery (BCDR). It's assumed that the solution for protection and recovery will be addressed by the development of the operations baseline.

### Governance

This implementation option doesn't implement governance tooling that can be used in production. In the absence of defined policy automation, you shouldn't use this landing zone for mission critical workloads or sensitive data. It's assumed you're using this landing zone for limited production deployment. This deployment starts your learning, iteration, and development of the operating model in parallel with these early migration efforts.

To accelerate parallel development of governance disciplines, review the [Govern methodology](../../govern/index.md). Consider deploying the [Cloud Adoption Framework Foundation blueprint](./foundation-blueprint.md) along with the Cloud Adoption Framework Migration landing zone blueprint.

> [!WARNING]
> As the governance disciplines mature, refactoring might be required. You might need to move resources [to a new subscription or resource group](/azure/azure-resource-manager/management/move-resource-group-and-subscription?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json).

### Platform automation and DevOps

This implementation option doesn't implement automated Azure pipelines in DevOps. In the absence of defined automation, you shouldn't use this landing zone for mission critical workloads or sensitive data. It's assumed you're using this landing zone for limited production deployment. This deployment starts your learning, iteration, and development of the operating model in parallel with these early migration efforts.

To accelerate parallel development, review the [Ready methodology](../../ready/index.md). Consider deploying the [Cloud Adoption Framework Foundation blueprint](./foundation-blueprint.md) along with the Cloud Adoption Framework Migration landing zone blueprint.

## Assumptions

This initial landing zone includes the following assumptions and constraints. If these assumptions align with your constraints, you can use the blueprint to create your first landing zone. You can also extend the blueprint to create a landing zone blueprint that meets your unique constraints.

- **Subscription limits:** This adoption effort isn't expected to exceed [subscription limits](/azure/azure-resource-manager/management/azure-subscription-service-limits).
- **Compliance:** No third-party compliance requirements are needed in this landing zone.
- **Architectural complexity:** Architectural complexity doesn't require more production subscriptions.
- **Shared services:** No existing shared services in Azure require this subscription to be treated like a spoke in a hub and spoke architecture.
- **Limited production scope:** This landing zone could potentially host production workloads. It's not a suitable environment for sensitive data or mission-critical workloads.

If these assumptions align with your current adoption needs, then this blueprint might be a starting point to build your landing zone.

## Decisions

The following decisions are represented in the landing zone blueprint.

| Component                    | Decisions                                                                                         | Alternative approaches                                                                                                                                                                                                                                                                |
|------------------------------|---------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Migration tools              | Azure Site Recovery will be deployed and an Azure Migrate project will be created.                | [Migration tools decision guide](../../decision-guides/migrate-decision-guide/index.md)                                                                                                                                                                                               |
| Logging and monitoring       | Operational insights workspace and diagnostic storage account will be provisioned.                |                                                                                                                                                                                                                                                                                       |
| Network                      | A virtual network will be created with subnets for a gateway, firewall, jump box, and landing zone. | [Networking decisions](../considerations/networking-options.md)                                                                                                                                                                                                                       |
| Identity                     | It's assumed that the subscription is already associated with an Azure AD instance. | [Identity management best practices](/azure/security/fundamentals/identity-management-best-practices?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json) |
| Policy                       | This blueprint currently assumes that no Azure policies are to be applied.                        |                                                                                                                                                                                                                                                                                       |
| Subscription design          | N/A - designed for a single production subscription.                                              | [Create initial subscriptions](../azure-best-practices/initial-subscriptions.md)                                                                                                                                                                                                      |
| Resource groups              | N/A - designed for a single production subscription.                                              | [Scale subscriptions](../azure-best-practices/scale-subscriptions.md)                                                                                                                                                                                                                 |
| Management groups            | N/A - designed for a single production subscription.                                              | [Organize and manage subscriptions](../azure-best-practices/organize-subscriptions.md)                                                                                                                                                                                                |
| Data                         | N/A                                                                                               | [Choose the correct SQL Server option in Azure](/azure/azure-sql/azure-sql-iaas-vs-paas-what-is-overview) and [Azure data store guidance](/azure/architecture/guide/technology-choices/data-store-overview)                       |
| Storage                      | N/A                                                                                               | [Azure Storage guidance](../considerations/storage-options.md)                                                                                                                                                                                                                        |
| Naming and tagging standards | N/A                                                                                               | [Naming and tagging best practices](../azure-best-practices/naming-and-tagging.md)                                                                                                                                                                                                    |
| Cost management              | N/A                                                                                               | [Tracking costs](../azure-best-practices/track-costs.md)                                                                                                                                                                                                                              |
| Compute                      | N/A                                                                                               | [Compute options](/azure/architecture/guide/technology-choices/compute-decision-tree)                                                                                                                                                                                                                               |

## Customize or deploy a landing zone

Learn more and download a reference sample of the Cloud Adoption Framework Migration landing zone blueprint. Use this blueprint for deployment or customization from the Azure blueprint samples.

> [!div class="nextstepaction"]
> [Deploy the blueprint sample](/azure/governance/blueprints/samples/caf-migrate-landing-zone/deploy)

For guidance on customizations that should be made to this blueprint or the resulting landing zone, see the [landing zone considerations](../considerations/index.md).

## Next steps

After deploying your first landing zone, you're ready to expand your landing zone.

> [!div class="nextstepaction"]
> [Expand your landing zone](../considerations/index.md)
