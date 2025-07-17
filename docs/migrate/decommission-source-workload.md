---
title: Decommission source workloads after migration
description: Learn how to properly decommission source workloads after Azure migration. Get step-by-step guidance on stakeholder sign-off, license optimization, data archival, and documentation updates to reduce costs and ensure compliance.
author: stephen-sumner
ms.author: pnp
ms.date: 08/01/2025
ms.topic: conceptual
---

# Decommission source workloads after migration

A decommissioned workload is one that is no longer needed in its original environment. This step is essential to reduce operational overhead, reclaim resources, and ensure compliance. You should follow a structured process to formally retire the source workload once the Azure-hosted version is stable and fully adopted.

## Obtain stakeholder sign-off

1. **Request formal approval from the business owner.** A formal sign-off confirms that the workload is no longer needed in its original environment. This step ensures alignment between IT and business stakeholders. Business owners must confirm that the Azure-hosted workload meets all functional and performance expectations. This confirmation prevents premature decommissioning of systems still in use.

2. **Document the sign-off.** Store the approval in a centralized system such as a project management tool or SharePoint. This documentation provides traceability and audit readiness.

## Reclaim licenses used by the source environment

License optimization reduces costs and ensures compliance with licensing terms.

1. **Identify licenses eligible for reuse.** Determine whether any on-premises licenses are eligible for [Azure Hybrid Benefit][Azure Hybrid Benefit](/azure/virtual-machines/windows/hybrid-use-benefit-licensing) (AHB). AHB allows you to use existing Windows Server or SQL Server licenses with [Software Assurance](https://www.microsoft.com/licensing/licensing-programs/software-assurance-default) to reduce Azure VM costs.

2. **Deallocate unused licenses.** For licenses that are no longer needed, update your license inventory and return or reassign them as appropriate.

## Archive data for compliance and recovery

1. **Determine retention requirements.** Consult legal and compliance teams to identify how long data must be retained. Requirements vary by industry and region.

2. **Migrate data to Azure Storage cold or archive tiers.** Use [Azure Blob Storage tiers](/azure/storage/blobs/access-tiers-overview) to store archived data cost-effectively. Use the cold tier for short-term retention (90 days) and the archive tier for long-term retention (180 days or more).

3. **Test data restoration procedures.** Validate that archived data can be restored within acceptable timeframes. Document the process and store it with your disaster recovery runbooks.

4. **Update retention policies.** Ensure that your data governance policies reflect the new storage locations and retention durations.

## Keep documentation accurate and up to date

1. **Update architecture diagrams and runbooks.** Reflect the new Azure-based architecture in all technical documentation. Include updated IP addresses, DNS names, and service dependencies.

2. **Revise monitoring dashboards and alerting rules.** Ensure that monitoring tools reflect the current state of the environment. Remove references to decommissioned systems.

3. **Deprecate legacy documentation.** Clearly mark outdated documents as deprecated or archive them with a date. This prevents confusion during incident response or troubleshooting.

4. **Allocate time and budget for documentation updates.** Include documentation tasks in your migration project plan to avoid last-minute gaps.

## Next steps

- [Modernize](/azure/cloud-adoption-framework/modernize/) workload or [Build cloud native](/azure/cloud-adoption-framework/innovate/) features

- [Govern](/azure/cloud-adoption-framework/govern/), [Secure](/azure/cloud-adoption-framework/secure/overview), [Manage](/azure/cloud-adoption-framework/manage/) your Azure environment.
