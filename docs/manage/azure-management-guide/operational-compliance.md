---
title: Operational compliance in Azure
description: Learn how to ensure business stability through operational compliance by reducing the likelihood of outages or vulnerabilities.
author: martinekuan
ms.author: martinek
ms.date: 01/17/2023
ms.topic: conceptual
ms.custom: internal, fasttrack-edit, AQC
---

# Operational compliance in Azure

*Operational compliance* is the second discipline in any cloud management baseline.

:::image type="content" source="../../_images/manage/management-baseline.png" alt-text="Diagram that shows a cloud management baseline." lightbox="../../_images/manage/management-baseline.png":::

Improving operational compliance reduces the likelihood of an outage related to configuration drift or vulnerabilities related to systems being improperly patched.

For any enterprise-grade environment, this table outlines the suggested minimum for a management baseline.

| Process | Tool | Purpose |
|---|---|---|
| Patch management | Azure Automation Update Management | Management and scheduling of updates |
| Policy enforcement | Azure Policy | Automated policy enforcement to ensure environment and guest compliance |
| Environment configuration | [Infrastructure as code (IaC)](/azure/cloud-adoption-framework/ready/considerations/infrastructure-as-code) | Automated environment creation, configuration, and to avoid configuration drift |
| Resource configuration | Desired State Configuration | Automated configuration on guest OS and some aspects of the environment |

::: zone target="docs"

## Update Management

::: zone-end
::: zone target="chromeless"

## [Update Management](#tab/UpdateManagement)

::: zone-end

Computers that are managed by the Update Management solution for Azure Automation use the following configurations to do assessment and update deployments:

- Log Analytics agent for Windows or Linux.
- PowerShell Desired State Configuration (DSC) for Linux.
- Azure Automation Hybrid Runbook Worker.
- Microsoft Update or Windows Server Update Services (WSUS) for Windows computers.

For more information, see [Update Management solution for Azure Automation](/azure/automation/update-management/overview).

> [!WARNING]
> Before using Update Management, you must onboard virtual machines or an entire subscription into Log Analytics and Azure Automation.
>
> There are two approaches to onboarding:
>
> - [Single VM](../azure-server-management/onboard-single-vm.md)
> - [Entire subscription](../azure-server-management/onboard-at-scale.md)
>
> You should follow one before proceeding with Update Management.

### Manage updates

To apply a policy to a resource group:

1. Go to [Azure Automation](https://portal.azure.com/#blade/HubsExtension/BrowseResource/resourceType/Microsoft.Automation%2FAutomationAccounts).
1. Select **Automation accounts**, and choose one of the listed accounts.
1. Go to **Configuration Management**.
1. Use **Inventory**, **Change Management**, and **State Configuration** to control the state and operational compliance of the managed VMs.

::: zone target="chromeless"

::: zone-end

::: zone target="docs"

## Azure Policy

::: zone-end
::: zone target="chromeless"

## [Azure Policy](#tab/AzurePolicy)

::: zone-end

Azure Policy is used throughout governance processes. It's also highly valuable within cloud management processes. Azure Policy can audit and remediate Azure resources and can also audit settings inside a machine. The validation is performed by the guest configuration extension and client. The extension, through the client, validates settings like:

- Operating system configuration.
- Application configuration or presence.
- Environment settings.

Azure Policy guest configuration currently only audits settings inside the machine. It doesn't apply configurations.

An important part of this process is maintaining and updating Azure Policy assignments as your governance process requires. Using IaC can help you update and maintain your policy infrastructure. To learn more, see [Use IaC to update Azure landing zones](../infrastructure-as-code-updates.md).

::: zone target="chromeless"

### Action

Assign a built-in policy to a management group, subscription, or resource group.

::: zone-end

::: zone target="docs"

### Apply a policy

To apply a policy to a resource group:

1. Go to [Azure Policy](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyMenuBlade/GettingStarted).
1. Select **Assign a policy**.

### Learn more

To learn more, see:

- [Azure Policy](/azure/governance/policy/)
- [Azure Policy guest configuration](/azure/governance/policy/concepts/guest-configuration)
- [Cloud Adoption Framework: Define corporate policy](../../govern/policy-compliance/policy-definition.md)

::: zone-end

