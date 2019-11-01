---
title: "Enable server management services on a single VM for evaluation"
titleSuffix: Microsoft Cloud Adoption Framework for Azure
description: Enable server management services on a single VM for evaluation
author: BrianBlanchard
ms.author: brblanch
ms.date: 05/10/2019
ms.topic: article
ms.service: cloud-adoption-framework
ms.subservice: operate
---

# Enable server management services on a single VM for evaluation

Learn how to enable server management services on a single VM for evaluation.

> [!NOTE]
> Create the required [Log Analytics workspace and Azure Automation account](./prerequisites.md#create-a-workspace-and-automation-account) before you implement Azure management services on a VM.

It's simple to add Azure server management services to individual virtual machines in the Azure portal. You can familiarize yourself with these services before you add them. When you select a VM instance, all the solutions on the list of [management tools and services](./tools-services.md) appear on the **Operations** or **Monitoring** menu. You select a solution and follow the wizard to add it.

![Screenshot of virtual machine settings in the Azure portal](./media/onboarding-single-vm.png)

## Related resources

For more information about adding these solutions to individual VMs, see:

- [Onboard Update Management, Change Tracking, and Inventory solutions from Azure virtual machine](https://docs.microsoft.com/azure/automation/automation-onboard-solutions-from-vm)
- [Onboard Azure Monitoring for VMs](https://docs.microsoft.com/azure/azure-monitor/insights/vminsights-enable-single-vm)

## Next steps

Learn how to use Azure policy to bring on Azure VMs at scale.

> [!div class="nextstepaction"]
> [Configure Azure management services for a subscription](./onboard-at-scale.md)
