---
title: Operational compliance considerations
description: Learn about design area guidance. This guidance helps establish operational compliance across your Azure platform services.
author: DominicAllen
ms.author: doalle
ms.date: 01/04/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Operational compliance considerations

Throughout your cloud journey, your environments will continue to scale and the number of applications and services grow. It's important to put capabilities in place to monitor for deviations from your expected configurations.

Your tools should include automation where possible. Automation enables them to scale, covering the growing environment footprint and reducing the risk of gaps in observation.

## Monitoring for configuration drift

Monitoring your environments for configuration drift is an important part of ensuring stable and consistent operations.

[Azure Policy](/azure/governance/policy/overview) is valuable within cloud management processes. Azure Policy can audit and remediate Azure resources. It can also audit settings inside a machine. The validation is performed by the guest configuration extension and client. The extension, through the client, validates settings like:

- Operating system configuration.
- Application configuration or presence.
- Environment settings.

Use this technique as part of your organization management approach within a landing zone. It can assist you with ensuring resources stay in line with the expected configuration.

Learn more about the [guest configuration feature of Azure Policy](/azure/governance/policy/concepts/guest-configuration). Consider how it can be a part of your landing zone management toolkit.

## Update management considerations

- Are there existing update management tools used by the organization? Can they be extended to cover the cloud environment or are new tools required?
- Which teams will be responsible for overseeing update management?
- Are there groups of resources that share similar update schedules?
- Are there groups of resources that cannot be updated at the same time for business continuity reasons?

## Operational compliance recommendations

- Use [Update Management in Azure Automation](/azure/automation/update-management/overview) as a long-term patching mechanism for both Windows and Linux VMs. Enforcing Update Management configurations through Azure Policy ensures that all VMs are included in the patch management regimen. It also provides application teams with the ability to manage patch deployment for their VMs. It also provides visibility and enforcement capabilities to the central IT team across all VMs.
- Monitor in-guest virtual machine (VM) configuration drift using Azure Policy. Enabling [guest configuration](/azure/governance/policy/concepts/guest-configuration) audit capabilities through policy helps application team workloads to consume feature capabilities immediately, with little effort.

## Next steps

Learn how workload teams can use a federated model and operationally maintain their workloads.

> [!div class="nextstepaction"]
> [Workloads](management-workloads.md)