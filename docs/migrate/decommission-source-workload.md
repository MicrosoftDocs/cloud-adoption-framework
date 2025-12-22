---
title: Decommission source workloads after migration to cloud
description: Learn how to properly decommission source workloads after Azure migration. Get step-by-step guidance on stakeholder approval, license optimization, data archival, and documentation updates to reduce costs and ensure compliance.
author: stephen-sumner
ms.author: pnp
ms.date: 01/13/2025
ms.topic: concept-article
---

# Decommission source workloads after migration to cloud

This article provides guidance to safely decommission source workloads after successful migration to Azure. Proper decommissioning reduces operational overhead, reclaims resources, and ensures compliance while preventing premature shutdown of critical systems.

## Obtain stakeholder approval before decommissioning

Business approval confirms that the source workload is ready for decommissioning after successful migration to Azure. Stakeholder alignment prevents premature shutdown of critical systems and ensures business continuity during the transition. You should obtain explicit consent from workload owners before removing any source infrastructure or applications.

1. **Request formal approval from business and technical stakeholders.** Formal approval confirms that the workload no longer provides business value in its source environment. Business owners must verify that the Azure-hosted workload meets all functional and performance expectations. Include IT operations and security teams to validate technical readiness and compliance requirements. This confirmation prevents premature decommissioning of systems with unresolved dependencies.

2. **Document approval with success criteria and timelines.** Store the approval in a centralized system such as Azure DevOps, project management tools, or SharePoint. Include specific success metrics that validate the business outcome, such as "100% functional parity achieved" or "all performance benchmarks met for 30 days." Set clear decommissioning timelines with grace periods for rollback if issues arise. This documentation provides audit trail visibility and regulatory compliance support.

## Reclaim and optimize software licenses

License reclamation reduces operational costs and ensures compliance with licensing agreements after source workload shutdown. Software asset management prevents compliance violations and maximizes the value of existing license investments. You should audit and reallocate licenses to maintain cost efficiency and regulatory adherence.

1. **Identify licenses eligible for Azure Hybrid Benefit.** Review on-premises licenses to determine eligibility for [Azure Hybrid Benefit](/azure/virtual-machines/windows/hybrid-use-benefit-licensing) before decommissioning source systems. Validate that Windows Server and SQL Server licenses have active [Software Assurance](https://www.microsoft.com/licensing/licensing-programs/software-assurance-default) or qualifying subscription coverage. Apply Azure Hybrid Benefit to reduce Azure compute costs while maintaining compliance. This optimization maximizes license value during the transition period.

2. **Update license inventory and compliance tracking.** Maintain accurate records of license allocations in your software asset management system. Remove decommissioned workloads from license tracking databases and update inventory counts to reflect current usage. Use centralized tools such as Microsoft Cost Management or other asset management platforms to monitor ongoing compliance. This tracking prevents license violations and supports audit readiness for regulatory reviews.

3. **Reallocate or return unused licenses.** Reassign freed licenses to other workloads or return them to vendors according to contract terms. For enterprise agreements, coordinate with procurement teams to understand return policies and potential cost recovery options. Update license agreements and vendor contracts to reflect the reduced license requirements. This reallocation ensures optimal license utilization and prevents unnecessary renewal costs.

## Preserve data for compliance and recovery needs

Data preservation maintains regulatory compliance and legal discovery capabilities after source system decommissioning. Organizations must identify, classify, and archive data remaining in source systems that could be subject to regulatory retention requirements or legal hold obligations.

1. **Identify unmigrated data subject to regulatory requirements.** Conduct a data inventory of source systems to identify unmigrated data that might be subject to regulatory retention mandates such as HIPAA, SOX, GDPR, or SEC 17a-4. Work with legal and compliance teams to classify data by regulatory frameworks and document retention periods. Include legacy systems, archived files, and backup repositories that contain regulated data. This assessment prevents compliance violations during source system decommissioning.

2. **Implement compliant storage architecture with Azure Storage.** Use [Azure Blob Storage tiers](/azure/storage/blobs/access-tiers-overview) with appropriate compliance features for archived data. Apply [immutable storage policies](/azure/storage/blobs/immutable-storage-overview) for regulatory compliance, including Write-Once-Read-Many (WORM) capabilities. Configure [legal hold policies](/azure/storage/blobs/immutable-storage-overview#legal-holds) for litigation support. Use cool tier for medium-term retention and archive tier for long-term retention requirements. Enable audit logging and configure [Azure Policy](/azure/governance/policy/overview) compliance controls to enforce data protection standards.

3. **Create data recovery and access procedures.** Document processes for retrieving archived data from Azure Storage when needed for compliance audits or legal discovery. Establish service level agreements for data retrieval times based on storage tiers used. Train compliance and legal teams on Azure-based data access procedures. Test data recovery processes before completing source system decommissioning. This preparation ensures business continuity for compliance and legal requirements.

## Update documentation and procedures

Documentation updates confirm the final environment state after source decommissioning and provide accurate operational guidance for the Azure-based architecture. Current documentation prevents operational risks during incident response and troubleshooting activities.

1. **Update architecture diagrams to reflect new environment.** Replace architecture diagrams with documentation showing the final Azure state. Include network topology with Azure Virtual Networks, subnets, network security groups, IP ranges, DNS configurations, and service endpoints. Remove all references to source environment components and network connections. Document new Azure-based integration points and dependencies. This updated documentation ensures accurate system understanding for operations and troubleshooting.

2. **Revise operational procedures for Azure operations.** Update incident response, disaster recovery, and maintenance workflows for Azure-only operations. Document escalation procedures for Azure support channels and service level agreements. Remove procedures referencing decommissioned systems and update contact lists. Include Azure-specific troubleshooting steps and monitoring approaches. This revision prevents operational confusion and ensures efficient incident response.

3. **Update monitoring and alerting configurations.** Remove monitoring dashboards and alerts for decommissioned systems to prevent false alarms. Update service level objectives and key performance indicators to reflect Azure capabilities. Document monitoring baselines based on post-migration Azure performance data. This cleanup ensures focused monitoring of active Azure resources.

4. **Archive legacy documentation with clear deprecation notices.** Mark source environment documentation as deprecated with timestamps and migration completion dates. Move outdated documentation to archive folders with restricted access controls. Create redirect notices pointing to current Azure documentation for common scenarios. Maintain archived documentation for historical reference and compliance audit requirements. This archival approach preserves institutional knowledge while preventing outdated information use.

## Azure tools and resources

| Category | Tool | Description |
|----------|------|-------------|
| Cost optimization | [Azure Hybrid Benefit](/azure/virtual-machines/windows/hybrid-use-benefit-licensing) | Reduces Azure costs by using existing on-premises Windows Server and SQL Server licenses |
| Cost management | [Microsoft Cost Management](/azure/cost-management-billing/) | Tracks and optimizes Azure spending and license usage |
| Data archival | [Azure Blob Storage tiers](/azure/storage/blobs/access-tiers-overview) | Provides cost-effective storage options for archived data with compliance features |
| Compliance | [Azure Policy](/azure/governance/policy/overview) | Enforces governance and compliance controls across Azure resources |
| Documentation | [Azure DevOps](/azure/devops) | Centralizes project documentation, approvals, and change tracking |

## Next steps

> [!div class="nextstepaction"]
> [Modernize workloads in Azure](/azure/cloud-adoption-framework/modernize/prepare-organization-cloud-modernization)