---
title: Resource consistency in the Cloud Adoption Framework for Azure
description: The resource consistency discipline in the Cloud Adoption Framework for Azure provides guidance on establishing policies related to the operational management of an environment, application, or workload.
author: robbagby
ms.author: robbag
ms.date: 10/05/2022
ms.topic: conceptual
ms.subservice: govern
ms.custom: internal, UpdateFrequency2
---

# Resource Consistency discipline

Resource consistency is one of the Five Disciplines of Cloud Governance within the Cloud Adoption Framework governance model. This discipline will provide guidance on how to ensure your resources are configured consistently. This consistency will allow your IT operations to discover your resources, include them in recovery solutions, and onboard them into repeatable operations processes.

## Governed vs. ungoverned resources

[Gartner defines IT Governance](https://www.gartner.com/en/information-technology/glossary/it-governance) "... as the processes that ensure the effective and efficient use of IT in enabling an organization to achieve its goals." A resource can be considered governed if the processes are in place to ensure compliance with business standards. Resources that aren't in compliance are necessarily ungoverned resources, as there are no processes in place to remediate and make them compliant.

Examples of ungoverned resources regarding the resource consistency discipline include:

- Any resource without required tags
- Any resource not following organization's naming standards
- Any resource not properly located in the defined hierarchical structure
- Any resource deployed in an unauthorized region

## Tooling

The following tools are available to govern Azure resources.

- [Azure Policy](/azure/governance/policy/overview) is the primary tool to enforce resource consistency of Azure resources and assess compliance at-scale. Azure Policies can be deployed to either audit or enforce compliance.
- [Azure Resource Graph](/azure/governance/resource-graph/overview) queries can be used for auditing or reporting on resource consistency.
- [Azure Resource Manager template specs](/azure/azure-resource-manager/templates/template-specs) support resource consistency. Administrators can validate the content of the templates to ensure they're following standards.

## Orphaned resources

Orphaned resources are resources that aren't currently in use, such as resources left behind after you decommission a workload. The most common example of orphaning a resource occurs when you delete a Virtual Machine, but leave the NIC and disks. This can be intentional if you want to later rebuild a VM with the same disks.

Orphaned resources should be governed along with active resources. Use Azure Resource Graph queries to identify orphaned resources in your organization and determine if they're governed or not.

The following two Azure Resource Graph query lists disks and network cards not connected to a virtual machine.

```bash
resources
| where type =~ 'Microsoft.Compute/disks'
| where managedBy == "" and diskState != 'ActiveSAS'
or (diskState == 'Unattached' or diskState != 'ActiveSAS')
| project name, resourceGroup, subscriptionId, tenantId, properties.diskState

resources
| where type == "microsoft.network/networkInterfaces"
| extend vm = properties.virtualMachine
| where isnull(vm.id)
| project name, resourceGroup, subscriptionId, tenantId, vm.id
```

## Manage resource consistency

In this discipline, you'll learn which areas are important to govern regarding resource consistency. These areas include Azure management groups, resource naming and tagging, and business constraints such as restricting resource types or sizes. For each area, you'll receive prescriptive guidance on what to govern, and how to enforce and audit compliance with standards.

Consider the resource consistency guidance for the following areas.

- [Management groups](management-group-structure.md)
- [Resource naming](naming.md)
- [Resource tagging](tagging.md)
- [Business constraints](business-constraints.md)
- [Keep landing zones up to date](keep-azure-landing-zone-up-to-date.md)
