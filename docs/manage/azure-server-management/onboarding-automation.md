---
title: "Automate onboarding"
description: Use the onboarding sample files to help you consider automating your Azure server management services deployment to improve efficiency.
author: BrianBlanchard
ms.author: brblanch
ms.date: 05/10/2019
ms.topic: article
ms.service: cloud-adoption-framework
ms.subservice: operate
---

# Automate onboarding

To improve the efficiency of deploying Azure server management services, consider automating deployment as discussed in previous sections of this guidance. The script and the example templates provided in the following sections are starting points for developing your own automation of onboarding processes.

This guidance has a supporting GitHub repository of sample code, [CloudAdoptionFramework](https://aka.ms/caf/manage/automation-samples). The repository provides example scripts and Azure Resource Manager templates to help you automate the deployment of Azure server management services.

The sample files illustrate how to use Azure PowerShell cmdlets to automate the following tasks:

- Create a [Log Analytics workspace](https://docs.microsoft.com/azure/azure-monitor/platform/manage-access). (Or, use an existing workspace if it meets the requirements. For details, see [Workspace planning](./prerequisites.md#log-analytics-workspace-and-automation-account-planning).

- Create an Automation account. (Or, use an existing account if it meets the requirements. For details, see [Workspace planning](./prerequisites.md#log-analytics-workspace-and-automation-account-planning)).

- Link the Automation account and the Log Analytics workspace. This step isn't required if you're onboarding by using the Azure portal.

- Enable Update Management, and Change Tracking and Inventory, for the workspace.

- Onboard Azure VMs by using Azure Policy. A policy installs the Log Analytics agent and the Microsoft Dependency Agent on the Azure VMs.

- Onboard on-premises servers by installing the Log Analytics agent on them.

The files described in the following table are used in this sample. You can customize them to support your own deployment scenarios.

| File name | Description |
|-----------|-------------|
| New-AMSDeployment.ps1 | The main, orchestrating script that automates onboarding. It creates resource groups, and location, workspace, and Automation accounts, if they don't exist already. This PowerShell script requires an existing subscription. |
| Workspace-AutomationAccount.json | A Resource Manager template that deploys the workspace and Automation account resources. |
| WorkspaceSolutions.json | A Resource Manager template that enables the solutions you want in the Log Analytics workspace. |
| ScopeConfig.json | A Resource Manager template that uses the opt-in model for on-premises servers with the Change Tracking solution. Using the opt-in model is optional. |
| Enable-VMInsightsPerfCounters.ps1 | A PowerShell script that enables VM Insights for servers and configures performance counters. |
| ChangeTracking-Filelist.json | A Resource Manager template that defines the list of files that will be monitored by Change Tracking. |

Use the following command to run New-AMSDeployment.ps1:

```powershell
.\New-AMSDeployment.ps1 -SubscriptionName '{Subscription Name}' -WorkspaceName '{Workspace Name}' -WorkspaceLocation '{Azure Location}' -AutomationAccountName {Account Name} -AutomationAccountLocation {Account Location}
```

## Next steps

Learn how to set up basic alerts to notify your team of key management events and issues.

> [!div class="nextstepaction"]
> [Set up basic alerts](./setup-alerts.md)
