---
title: Discover your existing workload inventory
description: Discover how to create a comprehensive workload inventory and prioritize assets for cloud migration. Learn to use Azure Migrate and other tools to assess your infrastructure, applications, and business requirements for successful Azure adoption.
author: stephen-sumner
ms.author: pnp
ms.date: 07/15/2025
ms.topic: conceptual
---

# Discover your existing workload inventory

This article helps you create a comprehensive inventory of your workloads to form the foundation of your cloud adoption plan. An accurate inventory enables you to make informed decisions about each workload's future in the cloud. Use the following table for discovery and assessment tools for workloads on-premises, in Amazon Web Services (AWS), in Google Cloud Platform (GCP), and application code.

[!INCLUDE [discovery and assessment table](./includes/discovery-assessment-table.md)]

## Discover workload inventory

A complete inventory of your technical assets forms the foundation of your cloud adoption plan. Your inventory identifies all systems, applications, and infrastructure components across your environment. You need this inventory to decide which [cloud migration strategy](./select-cloud-migration-strategy.md#select-the-right-migration-strategy) is the best fit.

1. **Define each workload and its boundaries.** A workload is a collection of IT components, such as servers, virtual machines (VMs), cloud services, applications, code, data, or appliances, that support one or more business processes. You need to define each workload to understand its business value and technical footprint. This clarity helps prioritize migration and modernization efforts. Use network traffic monitoring and dependency mapping tools to identify workload boundaries and visualize relationships between components.

2. **Use automated discovery tools.** [Azure Migrate](/azure/migrate/migrate-services-overview) provides free discovery capabilities for on-premises and cloud environments. This tool automatically identifies servers, applications, and their interdependencies. You must use automated discovery to accelerate inventory creation and reduce manual errors. If Azure Migrate doesn't fully support your environment, use tools like [Dr Migrate](https://azuremarketplace.microsoft.com/marketplace/consulting-services/lab3solutions.drmigrate-standard-cons-deployment) or [CloudPilot](https://appsource.microsoft.com/product/web-apps/cloudatlasinc.36d534d9-ab47-4cd8-93d3-2be7df682782) that extend Azure Migrate capabilities.

3. **Include all components across all environments.** Your inventory must capture infrastructure and application components across all platforms. You need to include servers, VMs, applications, databases, communication patterns, integrations, identities, and cloud services from Azure, AWS, GCP, and other providers. This comprehensive view ensures that no critical asset is overlooked during planning or migration.

4. **Use manual discovery when automation isn't possible.** Some environments restrict automated discovery tools due to security policies or technical limitations. Use the [Azure Migrate import template](https://go.microsoft.com/fwlink/?linkid=2109031) to manually document assets in restricted environments. Manual documentation ensures you capture assets that automated tools can't access.

## Prioritize workloads based on business value

A prioritized workload list is essential to avoid analysis paralysis and ensure early cloud adoption efforts deliver measurable business value. Prioritization helps you focus on the workloads that matter most to your organization and align with your strategic goals. You need to identify and sequence workloads based on business value, cloud motivations, and interdependencies.

1. **Identify the most important workloads based on business value.** A prioritized list of workloads helps you focus on what matters most. This list should reflect the workloads that are most critical to your business operations, customer experience, or revenue generation. Use business metrics such as revenue contribution, customer reach, or operational criticality to rank workloads.

2. **Validate prioritization with stakeholders.** Stakeholder alignment ensures prioritization reflects both technical realities and business priorities. Review the proposed workload order with business owners, application teams, and cloud governance stakeholders. Adjust based on feedback to ensure buy-in and reduce resistance during execution.

## Document workload business details

Business details document the organizational context and criticality of each workload. These details guide your migration decisions and help you prioritize workloads based on business value. You must collect this information for every workload in your inventory. Follow this guidance:

1. **Identify workload owners and stakeholders.** Document the official workload name, description, and individuals accountable for the workload. These individuals must participate in migration planning to ensure technical accuracy and business alignment. Include application owners, data owners, business owners, and infrastructure teams who maintain the workload. Record the business unit responsible for workload costs and the department that oversees operations.

2. **Document workload criticality and data sensitivity.** Classify each workload as mission-critical, medium priority, or low priority based on its business value. Determine data sensitivity levels using categories such as highly confidential, confidential, general, public, or nonbusiness. This classification determines security requirements and migration priority.

3. **Capture business criticality and compliance requirements.** Document how each workload affects business processes, revenue, and operations. Identify which business teams and processes depend on the workload to understand the full effect of potential downtime. Include any regulatory compliance requirements, data residency restrictions, or industry-specific standards that govern the workload. This information shapes your cloud architecture decisions.

4. **Record operational constraints.** Document maintenance windows, business freeze periods, and geographic restrictions for each workload. Include any times when the business can't tolerate changes, such as peak sales periods or financial closing dates. These constraints determine your migration schedule and deployment windows.

| Business detail | Description |
|-----------------|-------------|
| Workload name | Official name used across the organization |
| Workload description | Single sentence describing the workload's purpose |
| Workload owners | Individuals accountable for workload |
| Criticality level | High (mission-critical), medium, or low priority |
| Data sensitivity | Highly confidential, confidential, general, public, nonbusiness |
| Compliance requirements | Regulatory standards or certifications required |
| Business owners | Executive or manager overseeing this workload |
| Business unit | Department responsible for workload costs |
| Business processes affected | Processes that depend on this workload |
| Business teams affected | Teams whose work depends on this workload |
| Business value | Revenue, operations, or customer value if unavailable |
| Maintenance windows | Scheduled times for updates and changes |
| Business freeze periods | Dates when no changes are permitted |
| Timelines | List the target date to complete migration strategy |

## Azure discovery and assessment tools and resources

| Category | Tool | Description |
|----------|------|-------------|
| Discovery | [Azure Migrate](/azure/migrate/migrate-services-overview) | Discovers servers, applications, and dependencies across your infrastructure |
| Discovery | [Azure Migrate infrastructure](/azure/migrate/migrate-appliance) | Discovers on-premises infrastructure components |
| Discovery | [Azure Migrate application discovery](/azure/migrate/how-to-discover-applications) | Identifies applications running in your environment |
| Discovery | [Azure Migrate import template](https://go.microsoft.com/fwlink/?linkid=2109031) | Enables manual documentation of assets in restricted environments |
| Assessment | [Azure Migrate assessment](/azure/migrate/tutorial-discover-physical) | Evaluates on-premises workloads for Azure migration |
| Assessment | [Azure Migrate assessment for physical servers](/azure/migrate/tutorial-assess-physical) | Assesses physical and virtualized servers for cloud migration |
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
