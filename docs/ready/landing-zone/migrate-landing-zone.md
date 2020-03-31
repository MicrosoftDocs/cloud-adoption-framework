---
title: Deploy a migration landing zone in Azure
titleSuffix: Microsoft Cloud Adoption Framework for Azure
description: Learn how to deploy a migration landing zone in Azure.
author: BrianBlanchard
ms.author: brblanch
ms.date: 02/25/2020
ms.topic: guide
ms.service: cloud-adoption-framework
ms.subservice: ready
---

<!-- cSpell:ignore vCPUs jumpbox -->

# Deploy a migration landing zone

*Migration landing zone* is a term used to describe an environment that has been provisioned and prepared to host workloads being migrated from an on-premises environment into Azure.

## Deploy the first landing zone

Before you use the migration landing zone blueprint in the Cloud Adoption Framework, review the following assumptions, decisions, and implementation guidance. If this guidance aligns with the desired cloud adoption plan, the [Migration landing zone blueprint](https://docs.microsoft.com/azure/governance/blueprints/samples/caf-migrate-landing-zone/index) can be deployed using the [deployment steps][deploy-sample].

> [!div class="nextstepaction"]
> [Deploy the blueprint sample][deploy-sample]

## Assumptions

This initial landing zone includes the following assumptions or constraints. If these assumptions align with your constraints, you can use the blueprint to create your first landing zone. The blueprint also can be extended to create a landing zone blueprint that meets your unique constraints.

- **Subscription limits:** This adoption effort isn't expected to exceed [subscription limits](https://docs.microsoft.com/azure/azure-subscription-service-limits).
- **Compliance:** No third-party compliance requirements are needed in this landing zone.
- **Architectural complexity:** Architectural complexity doesn't require additional production subscriptions.
- **Shared services:** There are no existing shared services in Azure that require this subscription to be treated like a spoke in a hub and spoke architecture.
- **Limited production scope:** This landing zone could potentially host production workloads. However, it is not a suitable environment for sensitive data or mission-critical workloads.

If these assumptions align with your current adoption needs, then this blueprint might be a starting point for building your landing zone.

## Decisions

The following decisions are represented in the landing zone blueprint.

| Component                    | Decisions                                                                                         | Alternative approaches                                                                                                                                                                                                                                                                |
|------------------------------|---------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Migration tools              | Azure Site Recovery will be deployed and an Azure Migrate project will be created.                | [Migration tools decision guide](../../decision-guides/migrate-decision-guide/index.md)                                                                                                                                                                                               |
| Logging and monitoring       | Operational Insights workspace and diagnostic storage account will be provisioned.                |                                                                                                                                                                                                                                                                                       |
| Network                      | A virtual network will be created with subnets for gateway, firewall, jumpbox, and landing zone.  | [Networking decisions](../considerations/networking-options.md)                                                                                                                                                                                                                       |
| Identity                     | It's assumed that the subscription is already associated with an Azure Active Directory instance. | [Identity management best practices](https://docs.microsoft.com/azure/security/azure-security-identity-management-best-practices?toc=https://docs.microsoft.com/azure/cloud-adoption-framework/toc.json&bc=https://docs.microsoft.com/azure/cloud-adoption-framework/_bread/toc.json) |
| Policy                       | This blueprint currently assumes that no Azure policies are to be applied.                        |                                                                                                                                                                                                                                                                                       |
| Subscription design          | N/A - Designed for a single production subscription.                                              | [Create initial subscriptions](../azure-best-practices/initial-subscriptions.md)                                                                                                                                                                                                      |
| Resource groups              | N/A - Designed for a single production subscription.                                              | [Scale subscriptions](../azure-best-practices/scale-subscriptions.md)                                                                                                                                                                                                                 |
| Management groups            | N/A - Designed for a single production subscription.                                              | [Organize and manage subscriptions](../azure-best-practices/organize-subscriptions.md)                                                                                                                                                                                                |
| Data                         | N/A                                                                                               | [Choose the correct SQL Server option in Azure](https://docs.microsoft.com/azure/sql-database/sql-database-paas-vs-sql-server-iaas) and [Azure Data Store guidance](https://docs.microsoft.com/azure/architecture/guide/technology-choices/data-store-overview)                       |
| Storage                      | N/A                                                                                               | [Azure Storage guidance](../considerations/storage-options.md)                                                                                                                                                                                                                        |
| Naming and tagging standards | N/A                                                                                               | [Naming and tagging best practices](../azure-best-practices/naming-and-tagging.md)                                                                                                                                                                                                    |
| Cost management              | N/A                                                                                               | [Tracking costs](../azure-best-practices/track-costs.md)                                                                                                                                                                                                                              |
| Compute                      | N/A                                                                                               | [Compute options](../considerations/compute-options.md)                                                                                                                                                                                                                               |

## Customize or deploy a landing zone

Learn more and download a reference sample of the Migrate landing zone blueprint for deployment or customization from [Azure Blueprint samples][deploy-sample].

> [!div class="nextstepaction"]
> [Deploy the blueprint sample][deploy-sample]

For guidance on customizations that should be made to this blueprint or the resulting landing zone, see the [landing zone considerations](../considerations/index.md).

## Next steps

After deploying your first landing zone, you are ready to [expand your landing zone](../considerations/index.md)

> [!div class="nextstepaction"]
> [Expand your landing zone](../considerations/index.md)

<!-- links -->

[deploy-sample]: https://docs.microsoft.com/azure/governance/blueprints/samples/caf-migrate-landing-zone/deploy
