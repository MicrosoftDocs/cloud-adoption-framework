---
title: Discover your existing inventory
description: Learn how to create a comprehensive inventory of your technical assets to form the foundation of your cloud adoption plan and make informed migration decisions.
author: stephen-sumner
ms.author: pnp
ms.date: 07/15/2025
ms.topic: conceptual
---

# Discover your existing inventory

This article helps you create a comprehensive inventory of your technical assets to form the foundation of your cloud adoption plan. An accurate inventory enables you to make informed decisions about each asset's future in the cloud.

## Create a comprehensive inventory

A complete inventory of your technical assets forms the foundation of your cloud adoption plan. Your inventory identifies all systems, applications, and infrastructure components across your environment. You need this inventory to decide which assets to migrate, modernize, or retire. Follow this guidance:

1. **Use automated discovery tools.** Azure Migrate provides free discovery capabilities for on-premises and cloud environments. The tool automatically discovers servers, applications, and dependencies across your infrastructure. For environments where Azure Migrate doesn't provide complete coverage, consider integrated tools like [Dr Migrate](https://azuremarketplace.microsoft.com/marketplace/consulting-services/lab3solutions.drmigrate-standard-cons-deployment) or [Cloud Pilot](https://appsource.microsoft.com/product/web-apps/cloudatlasinc.36d534d9-ab47-4cd8-93d3-2be7df682782) that extend Azure Migrate capabilities. Select discovery tools based on your asset location (on-premises or other clouds) and asset type (IaaS, PaaS, or code).

2. **Include all asset types.** Your inventory must capture servers, virtual machines, applications, databases, and cloud services across all environments. Include assets from AWS, GCP, and other cloud providers to ensure complete visibility. Document both infrastructure components and the applications that run on them.

3. **Use manual discovery when automation isn't possible.** Some environments restrict automated discovery tools due to security policies or technical limitations. Use the [Azure Migrate import template](https://go.microsoft.com/fwlink/?linkid=2109031) to manually document assets in restricted environments. Manual documentation ensures you capture assets that automated tools cannot access.

## Select discovery tools by environment

Different environments require specific discovery approaches. The type of infrastructure and its location determine which tools provide the most accurate inventory data. You must match your discovery tools to your environment type.

| Environment | Discovery Tool | Assessment Tool | Asset Examples |
|------------|----------------|-----------------|----------------|
| On-premises infrastructure | [Azure Migrate appliance](/azure/migrate/migrate-appliance) for infrastructure and [application discovery](/azure/migrate/how-to-discover-applications) | [Azure Migrate assessment](/azure/migrate/tutorial-discover-physical) | Physical servers, VMware VMs, Hyper-V VMs, SQL databases, web applications |
| AWS infrastructure | [Azure Migrate for physical servers](/azure/migrate/tutorial-discover-physical) | [Azure Migrate assessment](/azure/migrate/tutorial-discover-physical) | EC2 instances, RDS databases, EBS volumes |
| GCP infrastructure | [Azure Migrate for physical servers](/azure/migrate/tutorial-discover-physical) | [Azure Migrate assessment](/azure/migrate/tutorial-discover-physical) | Compute Engine VMs, Cloud SQL, persistent disks |
| AWS platform services | AWS Resource Explorer | Cloudockit, [AWS to Azure service mapping](/azure/architecture/aws-professional/#primary-topics) | Lambda functions, Elastic Beanstalk, DynamoDB |
| GCP platform services | GCP Cloud Asset Inventory | Cloudockit, [GCP to Azure service mapping](/azure/architecture/gcp-professional/services) | BigQuery, App Engine, Cloud Functions |
| Application code | CAST Highlight, CloudAtlas | [AppCAT](/azure/migrate/appcat/overview), Cloud Pilot, CAST Highlight | Source code repositories, custom applications, APIs |

## Azure resources

| Category | Tool | Description |
|----------|------|-------------|
| Discovery | [Azure Migrate](/azure/migrate/migrate-services-overview) | Discovers and assesses on-premises and cloud infrastructure for migration |
| Discovery | [Dr Migrate](https://azuremarketplace.microsoft.com/marketplace/consulting-services/lab3solutions.drmigrate-standard-cons-deployment) | Provides automated discovery and migration planning for complex environments |
| Code analysis | [Cloud Pilot](https://appsource.microsoft.com/product/web-apps/cloudatlasinc.36d534d9-ab47-4cd8-93d3-2be7df682782) | Analyzes applications and provides cloud readiness assessments |
| Code analysis | [AppCAT](/azure/migrate/appcat/overview) | Assesses application code compatibility with Azure services |
| Code analysis | [CAST Highlight](https://azuremarketplace.microsoft.com/marketplace/apps/castsoftware.casthighlight) | Analyzes source code for cloud readiness and modernization opportunities |
| Documentation | [Cloudockit](https://www.cloudockit.com/) | Generates architecture diagrams and documentation for cloud environments |

## Next steps

> [!div class="nextstepaction"]
> [Pick you migration strategy](./plan-migration-strategies.md)