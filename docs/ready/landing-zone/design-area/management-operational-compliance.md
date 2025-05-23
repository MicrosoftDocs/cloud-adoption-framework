---
title: Operational compliance considerations
description: Overview of operational compliance design considerations and recommendations.
author: Zimmergren
ms.author: pnp
ms.date: 02/27/2025
ms.topic: conceptual
ms.custom: internal, UpdateFrequency.5
---

# Operational compliance considerations

Throughout your cloud adoption journey, your environments will continue to scale and your number of applications and services will continue to grow. It's important that you put capabilities in place to monitor for deviations from your expected configurations.

Your tools should include automation wherever possible. Automation enables them to scale, covering your growing environment footprint and reducing the risk of gaps in observation.

## Monitor for configuration drift

Monitoring your environments for configuration drift is an important part of ensuring stable and consistent operations.

[Azure Policy](/azure/governance/policy/overview) is valuable within cloud management processes. Azure Policy can audit and remediate Azure resources, and can also audit settings inside a machine. Validation is performed by the Azure Automanage Machine Configuration extension and client. The extension, through the client, validates settings such as:

- Operating system configuration
- Application configuration or presence
- Environment settings

Use this technique as part of your organization's management approach within landing zones, where can assist help ensure resources stay in line with an expected configuration.

In addition, using Infrastructure as Code can help you monitor for configuration drift, as well as help you keep your landing zone up to date.  To learn more, see [Keep your Azure landing zone up to date](../../../govern/resource-consistency/keep-azure-landing-zone-up-to-date.md) and [Use infrastructure as code to update Azure landing zones](../../../manage/infrastructure-as-code-updates.md).

Learn about [Azure Automanage Machine Configuration](/azure/governance/machine-configuration/overview). Consider how you can use it as part of your landing zone management toolkit.

## Update management considerations

- Does your organization currently use any update management tools? Can these tools be extended to cover your cloud environment, or will you need new tools?
- Which teams should be responsible for overseeing update management?
- Do you have groups of resources that share similar update schedules?
- Do you have groups of resources that can't be updated at the same time for business continuity reasons?

## Operational compliance recommendations

- Use [Azure Update Manager](/azure/update-manager/overview) as a long-term patching mechanism for both Windows and Linux VMs. Enforcing Update Manager configurations by using Azure Policy ensures that all VMs are included in your patch management regimen. It also provides your application teams with the ability to manage patch deployment for their VMs, and provides visibility and enforcement capabilities to your central IT team across all VMs.
- Use Azure Policy to monitor in-machine virtual machine (VM) configuration drift. Enabling [Azure Automanage Machine Configuration](/azure/governance/machine-configuration/overview) audit capabilities through policy helps your application team workloads to consume feature capabilities immediately with little effort.

## Next steps

Learn how your workload teams can use a federated model and operationally maintain their workloads.

> [!div class="nextstepaction"]
> [Workloads](management-workloads.md)
