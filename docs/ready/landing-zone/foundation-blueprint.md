---
title: Deploy a CAF foundation blueprint in Azure
description: Learn how to deploy a CAF foundation blueprint in Azure.
author: BrianBlanchard
ms.author: brblanch
ms.date: 09/27/2019
ms.topic: guide
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Deploy a CAF foundation blueprint

TODO: Intro... This is not a landing zone but adds governance tooling to the landing zone

## Deploy the blueprint

TODO: Deployment steps

## Assumptions

TODO: Key assumptions before choosing this with your first landing zone

## Decisions

TODO: Update the table below to outline the inherent decisions made by the blueprint

| Component | Decisions | Alternative approaches |
|---------|---------|---------|
|Migration tools|Azure Site Recovery will be deployed and an Azure Migrate project will be created.|[Migration tools decision guide](../../decision-guides/migrate-decision-guide/index.md)|
|Logging and monitoring|Operational Insights workspace and diagnostic storage account will be provisioned.|         |
|Network|A virtual network will be created with subnets for gateway, firewall, jumpbox, and landing zone.|[Networking decisions](../considerations/networking-options.md)|
|Identity|It's assumed that the subscription is already associated with an Azure Active Directory instance.|[Identity management best practices](https://docs.microsoft.com/azure/security/azure-security-identity-management-best-practices?toc=https://docs.microsoft.com/azure/cloud-adoption-framework/toc.json&bc=https://docs.microsoft.com/azure/cloud-adoption-framework/bread/toc.json)         |
|Policy|This blueprint currently assumes that no Azure policies are to be applied.|         |
|Subscription design|N/A - Designed for a single production subscription.|[Scaling subscriptions](../azure-best-practices/scaling-subscriptions.md)|
|Management groups|N/A - Designed for a single production subscription.|[Scaling subscriptions](../azure-best-practices/scaling-subscriptions.md)         |
|Resource groups|N/A - Designed for a single production subscription.|[Scaling subscriptions](../azure-best-practices/scaling-subscriptions.md)         |
|Data|N/A|[Choose the correct SQL Server option in Azure](https://docs.microsoft.com/azure/sql-database/sql-database-paas-vs-sql-server-iaas) and [Azure Data Store guidance](https://docs.microsoft.com/azure/architecture/guide/technology-choices/data-store-overview) |
|Storage|N/A|[Azure Storage guidance](../considerations/storage-options.md)         |
|Naming and tagging standards|N/A|[Naming and tagging best practices](../azure-best-practices/naming-and-tagging.md)         |
|Cost management|N/A|[Tracking costs](../azure-best-practices/track-costs.md)|
|Compute|N/A|[Compute options](../considerations/compute-options.md)|

## Customize or deploy

TODO: Deployment steps

## Next steps

After deploying your first landing zone, you are ready to [Expand your landing zone](../considerations/index.md)

> [!div class="nextstepaction"]
> [Expand your landing zone](../considerations/index.md)
