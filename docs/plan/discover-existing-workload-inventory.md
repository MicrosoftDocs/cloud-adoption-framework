---
title: Discover your existing workload inventory
description: Discover how to create a comprehensive workload inventory and prioritize assets for cloud migration. Learn to use Azure Migrate and other tools to assess your infrastructure, applications, and business requirements for successful Azure adoption.
author: stephen-sumner
ms.author: pnp
ms.date: 07/15/2025
ms.topic: concept-article
---

# Discover your existing workload inventory

*This section applies to organizations with existing IT workloads outside Azure (on-premises or other clouds) that need migration to Azure.* A comprehensive workload inventory is the foundation of a solid cloud adoption plan for such organizations. You can’t make decisions about how or whether to migrate a system if you don’t know it exists or understand its characteristics. Your cloud adoption plan must include steps to discover all workloads, gather key data about each, and prioritize them for migration.

[!INCLUDE [discovery and assessment table](./includes/discovery-assessment-table.md)]

## Discover workload inventory

A complete inventory of your technical assets forms the foundation of your cloud adoption plan. Your inventory identifies all systems, applications, and infrastructure components across your environment. You need this inventory to decide which [cloud migration strategy](./select-cloud-migration-strategy.md#select-the-right-migration-strategy) is the best fit.

1. **Define each workload and its boundaries.** A workload is a collection of IT components, such as servers, virtual machines (VMs), cloud services, applications, code, data, or appliances, that support one or more business processes. You need to define each workload to understand its business value and technical footprint. This clarity helps prioritize migration and modernization efforts. Use network traffic monitoring and dependency mapping tools to identify workload boundaries and visualize relationships between components.

2. **Use automated discovery tools.** [Azure Migrate](/azure/migrate/migrate-services-overview) provides free discovery capabilities for on-premises and cloud environments. This tool automatically identifies servers, applications, and their interdependencies. You must use automated discovery to accelerate inventory creation and reduce manual errors. If Azure Migrate doesn't fully support your environment, use tools like [Dr Migrate](https://marketplace.microsoft.com/marketplace/consulting-services/lab3solutions.drmigrate-standard-cons-deployment) or [CloudPilot](https://appsource.microsoft.com/product/web-apps/cloudatlasinc.36d534d9-ab47-4cd8-93d3-2be7df682782) that extend Azure Migrate capabilities.

3. **Include all components across all environments.** Your inventory must capture infrastructure and application components across all platforms. You need to include servers, VMs, applications, databases, communication patterns, integrations, identities, and cloud services from Azure, AWS, Google Cloud, and other providers. This comprehensive view ensures that no critical asset is overlooked during planning or migration.

4. **Use manual discovery when automation isn't possible.** Some environments restrict automated discovery tools due to security policies or technical limitations. Use the [Azure Migrate import template](https://go.microsoft.com/fwlink/?linkid=2109031) to manually document assets in restricted environments. Manual documentation ensures you capture assets that automated tools can't access.

## Prioritize workloads by business value and feasibility

A long inventory list can be overwhelming. The plan should include a method to prioritize which workloads to tackle first in the cloud adoption effort. Not all workloads are equally important or equally suitable for immediate migration, so use a prioritization framework.

1. **Use business criticality.** Rank workloads by how critical they are to business operations, revenue, or customer experience. Often, a few workloads are mission-critical (if they go down, major business losses) while others are less critical. High business value systems might be high priority to ensure they benefit from cloud scalability or resilience, or sometimes lower priority if risk of migrating them is too high.

1. **Estimate cloud readiness.** Make quick, high-level estimates of how ready each workload is for cloud migration, based on what you already know. A detailed technical assessment comes later, but for now, consider factors like technical complexity, legacy components, and known risks. Some workloads might be easy wins, while others might require significant rework. You might prioritize simpler workloads to build momentum, or choose a moderately complex but high-value system to maximize early success.

1. **Note dependencies.** At this stage, assess dependencies at a high level using existing knowledge. A full dependency mapping is done later, but for now, identify workloads that are tightly coupled with others. Systems with many connections might need to be migrated together to avoid disruptions. In some cases, a lower-priority workload might need to move earlier because a higher-priority system depends on it. Use this insight to group related workloads into logical migration waves.

1. **Consider strategic alignment.** If certain workloads are key to strategic initiatives, you might prioritize them to move sooner. On the other hand, workloads slated to be retired or replaced soon should be deprioritized for migration.

1. **Create a prioritized backlog.**  This backlog can be a list or table with categories like "Wave 1: Workloads A, B, C. Wave 2: Workloads D, E." Ensure you validate this order with stakeholders. Business and IT owners should review and agree that the sequence makes sense. You want to get their buy-in and avoid pushback later. For example, if you schedule a department’s critical app last without their input, they might object. Adjust the plan based on feedback to balance technical logic with business needs.

## Gather business details per workload

For each workload identified, the plan should capture key business context and requirements. This information guides migration strategy (next section) and ensures decisions align with business needs. Important details to document

1. **Owners and stakeholders**: Document who owns the workload from a business perspective (for example, VP of Sales for a CRM) and from an IT perspective (application owner, infrastructure owner). List all stakeholders who must be involved in planning its move.

1. **Business function and criticality**: Document what the workload does, and how important it is. Record a short description of its purpose and classify its criticality level (high/medium/low). Criticality often ties to how much downtime can be tolerated.

1. **Data sensitivity and compliance**: Note the classification of data the system handles (public, internal, confidential, highly confidential). Document compliance requirements that apply to this workload. For instance, if data residency is required in a certain region, that influences the cloud architecture for it.

1. **Operational constraints**: Document specific maintenance windows, blackout periods (high-traffic periods), and uptime requirements. Document any such constraints because they affect migration scheduling and target architecture (high-availability needs).

1. **Projected timeline or deadlines**: If there’s a desired timeline for migrating this workload, note that as well. For example, maybe you have contract renewals or data center leases ending. These factors feed into the overall roadmap scheduling.

For an example, see [Migration adoption plan](./migration-adoption-plan.md#workload-business-details-for-migration).

## Azure discovery and assessment tools and resources

| Category | Tool | Description |
|----------|------|-------------|
| Discovery | [Azure Migrate](/azure/migrate/migrate-services-overview) | Discovers servers, applications, and dependencies across your infrastructure |
| Discovery | [Azure Migrate infrastructure](/azure/migrate/migrate-appliance) | Discovers on-premises infrastructure components |
| Discovery | [Azure Migrate application discovery](/azure/migrate/how-to-discover-applications) | Identifies applications running in your environment |
| Discovery | [Dr.Migrate](https://marketplace.microsoft.com/marketplace/consulting-services/lab3solutions.drmigrate-standard-cons-deployment) | Analyzes your existing workloads to identify migration readiness and modernization opportunities. Provides detailed insights into dependencies, configuration, and potential blockers to streamline your migration planning. |
| Discovery | [Azure Migrate import template](https://go.microsoft.com/fwlink/?linkid=2109031) | Enables manual documentation of assets in restricted environments |
| Assessment | [Azure Migrate assessment](/azure/migrate/tutorial-discover-physical) | Evaluates on-premises workloads for Azure migration |
| Assessment | [Azure Migrate assessment for physical servers](/azure/migrate/tutorial-assess-physical) | Assesses physical and virtualized servers for cloud migration |
| Assessment | [Dr Migrate](https://marketplace.microsoft.com/marketplace/consulting-services/lab3solutions.drmigrate-standard-cons-deployment) | Assess infrastructure and code for cloud migration |
| Code discovery assessment | [CAST Highlight](https://appsource.microsoft.com/product/web-apps/cast.cast_highlight?tab=Overview) | Analyzes application code for cloud readiness |
| Assessment | [CloudPilot](https://appsource.microsoft.com/product/web-apps/cloudatlasinc.36d534d9-ab47-4cd8-93d3-2be7df682782) | Analyzes applications for cloud readiness |
| Code assessment | [AppCAT](/azure/migrate/appcat/overview) | Assesses .NET and Java applications for Azure compatibility |
| Assessment | [CloudAtlas](https://appsource.microsoft.com/product/web-apps/unify-cloud-llc.cloudatlas_modernize_and_migrate?tab=Overview) | Provides modernization and migration assessment |
| PaaS assessment | [Cloudockit](https://marketplace.microsoft.com/marketplace/apps/azure-dockit.cloudockit?tab=Overview) | Generates architecture diagrams and documentation for cloud environments |
| AWS to Azure migration | [AWS to Azure guidance](/azure/migration/migrate-from-aws) | Provides guidance for migrating from AWS to Azure |
| Google Cloud to Azure migration | [Google Cloud to Azure guidance](/azure/migration/migrate-from-google-cloud) | Provides guidance for migrating from Google Cloud to Azure |
| AWS to Azure migration | [AWS to Azure service mapping](/azure/architecture/aws-professional/#primary-topics) | Maps AWS services to equivalent Azure services |
| Google Cloud to Azure migration | [Google Cloud to Azure service mapping](/azure/architecture/gcp-professional/services) | Maps Google Cloud services to equivalent Azure services |

## Next steps

> [!div class="nextstepaction"]
> [Pick your migration strategy](./select-cloud-migration-strategy.md)
