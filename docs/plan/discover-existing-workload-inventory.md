---
title: Discover your existing workload inventory
description: Learn how to create a comprehensive inventory of your technical assets to form the foundation of your cloud adoption plan and make informed migration decisions.
author: stephen-sumner
ms.author: pnp
ms.date: 07/15/2025
ms.topic: conceptual
---

# Discover your existing workload inventory

This article helps you create a comprehensive inventory of your technical assets to form the foundation of your cloud adoption plan. An accurate inventory enables you to make informed decisions about each asset's future in the cloud.

## Discover workload inventory

A complete inventory of your technical assets forms the foundation of your cloud adoption plan. Your inventory identifies all systems, applications, and infrastructure components across your environment. You need this inventory to decide which assets to migrate, modernize, or retire. Follow this guidance:

1. **Use automated discovery tools.** [Azure Migrate](/azure/migrate/migrate-services-overview?view=migrate) provides free discovery capabilities for on-premises and cloud environments. The tool automatically discovers servers, applications, and dependencies across your infrastructure. For environments where Azure Migrate doesn't provide complete coverage, consider tools like [Dr Migrate](https://azuremarketplace.microsoft.com/marketplace/consulting-services/lab3solutions.drmigrate-standard-cons-deployment) or [CloudPilot](https://appsource.microsoft.com/product/web-apps/cloudatlasinc.36d534d9-ab47-4cd8-93d3-2be7df682782) that extend Azure Migrate capabilities. Select discovery tools based on your asset location (on-premises or other clouds) and asset type (IaaS, PaaS, or code).

    [!INCLUDE [discovery and assessment table](./includes/discovery-assessment-table.md)]

2. **Include all asset types.** Your inventory must capture servers, virtual machines, applications, databases, and cloud services across all environments. Include assets from AWS, GCP, and other cloud providers to ensure complete visibility. Document both infrastructure components and the applications that run on them.

3. **Use manual discovery when automation isn't possible.** Some environments restrict automated discovery tools due to security policies or technical limitations. Use the [Azure Migrate import template](https://go.microsoft.com/fwlink/?linkid=2109031) to manually document assets in restricted environments. Manual documentation ensures you capture assets that automated tools cannot access.

## Azure discovery and assessment tools and resources

| Category | Tool | Description |
|----------|------|-------------|
| Discovery | [Azure Migrate](/azure/migrate/migrate-services-overview?view=migrate) | Discovers servers, applications, and dependencies across your infrastructure |
| Discovery | [Azure Migrate infrastructure](/azure/migrate/migrate-appliance) | Discovers on-premises infrastructure components |
| Discovery | [Azure Migrate application discovery](/azure/migrate/how-to-discover-applications) | Identifies applications running in your environment |
| Discovery | [Azure Migrate import template](https://go.microsoft.com/fwlink/?linkid=2109031) | Enables manual documentation of assets in restricted environments |
| Assessment | [Azure Migrate assessment](/azure/migrate/tutorial-discover-physical) | Evaluates on-premises workloads for Azure migration |
| Assessment | [Azure Migrate assessment for physical servers](/azure/migrate/tutorial-assess-physical?view=migrate-classic&viewFallbackFrom=migrate) | Assesses physical and virtualized servers for cloud migration |
| Assessment | [Dr Migrate](https://azuremarketplace.microsoft.com/marketplace/consulting-services/lab3solutions.drmigrate-standard-cons-deployment) | Assess infrastructure and code for cloud migration |
| Code discovery assessment | [CAST Highlight](https://appsource.microsoft.com/product/web-apps/cast.cast_highlight?tab=Overview) | Analyzes application code for cloud readiness |
| Assessment | [CloudPilot](https://appsource.microsoft.com/product/web-apps/cloudatlasinc.36d534d9-ab47-4cd8-93d3-2be7df682782) | Analyzes applications for cloud readiness |
| Code assessment | [AppCAT](/azure/migrate/appcat/overview) | Assesses .NET and Java applications for Azure compatibility |
| Assessment | [CloudAtlas](https://appsource.microsoft.com/product/web-apps/unify-cloud-llc.cloudatlas_modernize_and_migrate?tab=Overview) | Provides modernization and migration assessment |
| PaaS assessment | [Cloudockit](https://azuremarketplace.microsoft.com/marketplace/apps/azure-dockit.cloudockit?tab=Overview) | Generates architecture diagrams and documentation for cloud environments |
| AWS to Azure migration | [AWS to Azure guidance](/azure/migration/migrate-from-aws) | Provides guidance for migrating from AWS to Azure |
| GCP to Azure migration | [GCP to Azure guidance](/azure/migration/migrate-from-google-cloud) | Provides guidance for migrating from GCP to Azure |
| AWS to Azure migration | [AWS to Azure service mapping](/azure/architecture/aws-professional/#primary-topics) | Maps AWS services to equivalent Azure services |
| GCP to Azure migration | [GCP to Azure service mapping](/azure/architecture/gcp-professional/services) | Maps GCP services to equivalent Azure services |

## Next steps

> [!div class="nextstepaction"]
> [Pick your migration strategy](./select-cloud-migration-strategy.md)
