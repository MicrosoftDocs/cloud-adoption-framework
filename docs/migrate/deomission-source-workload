---
title: Decommission source workloads after migration
description: 
author: stephen-sumner
ms.author: pnp
ms.date: 08/01/2025
ms.topic: conceptual
---


# Decommission source workloads after migration

A decommissioned workload is one that is no longer needed in its original environment. This step is essential to reduce operational overhead, reclaim resources, and ensure compliance. You should follow a structured process to formally retire the source workload once the Azure-hosted version is stable and fully adopted.

## Obtain stakeholder sign-off

A formal sign-off confirms that the workload is no longer needed in its original environment. This step ensures alignment between IT and business stakeholders.

1. **Request formal approval from the business owner.** Business owners must confirm that the Azure-hosted workload meets all functional and performance expectations. This confirmation prevents premature decommissioning of systems still in use.

2. **Document the sign-off.** Store the approval in a centralized system such as a project management tool or SharePoint. This documentation provides traceability and audit readiness.

## Reclaim licenses used by the source environment

License optimization reduces costs and ensures compliance with Microsoft licensing terms.

1. **Identify licenses eligible for reuse.** Determine whether any on-premises licenses are eligible for Azure Hybrid Benefit (AHB). AHB allows you to use existing Windows Server or SQL Server licenses with Software Assurance to reduce Azure VM costs. See https://learn.microsoft.com/azure/virtual-machines/windows/hybrid-use-benefit-licensing for eligibility and configuration details.

2. **Apply AHB to eligible Azure resources.** If eligible, configure AHB on the corresponding Azure VMs. This reduces compute costs without requiring new licenses. Be aware that AHB cannot be used simultaneously on-premises and in Azure.

3. **Deallocate unused licenses.** For licenses that are no longer needed, update your license inventory and return or reassign them as appropriate.

## Archive data for compliance and recovery

Archived data ensures regulatory compliance and provides a fallback during the transition period.

1. **Determine retention requirements.** Consult legal and compliance teams to identify how long data must be retained. Requirements vary by industry and region.

2. **Migrate data to Azure Storage cold or archive tiers.** Use https://learn.microsoft.com/azure/storage/blobs/access-tiers-overview to store archived data cost-effectively. Use the cold tier for short-term retention (e.g., 90 days) and the archive tier for long-term retention (7 years or more).

3. **Test data restoration procedures.** Validate that archived data can be restored within acceptable timeframes. Document the process and store it with your disaster recovery runbooks.

4. **Update retention policies.** Ensure that your data governance policies reflect the new storage locations and retention durations.

## Update documentation and operational assets

Accurate documentation ensures operational continuity and reduces support risks.

1. **Update architecture diagrams and runbooks.** Reflect the new Azure-based architecture in all technical documentation. Include updated IP addresses, DNS names, and service dependencies.

2. **Revise monitoring dashboards and alerting rules.** Ensure that monitoring tools reflect the current state of the environment. Remove references to decommissioned systems.

3. **Deprecate legacy documentation.** Clearly mark outdated documents as deprecated or archive them. This prevents confusion during incident response or troubleshooting.

4. **Allocate time and budget for documentation updates.** Include documentation tasks in your migration project plan to avoid last-minute gaps.

## Azure resources and tools

| Category               | Tool                                                                 | Description                                                                 |
|------------------------|----------------------------------------------------------------------|-----------------------------------------------------------------------------|
| Licensing              | https://learn.microsoft.com/azure/virtual-machines/windows/hybrid-use-benefit-licensing | Explains how to apply existing licenses to reduce Azure VM costs.          |
| Data Archival          | https://learn.microsoft.com/azure/storage/blobs/access-tiers-overview | Describes cold and archive tiers for cost-effective long-term storage.     |
| Monitoring             | https://learn.microsoft.com/azure/azure-monitor/overview | Provides observability into Azure workloads and infrastructure.            |
| Documentation Planning | https://learn.microsoft.com/azure/cloud-adoption-framework/manage/ready#document-your-cloud-operations | Guides documentation and operational readiness for Azure environments.     |

## Next step

