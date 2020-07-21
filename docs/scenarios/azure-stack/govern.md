---
title: "Govern Azure running in your datacenter"
description: Learn how to Govern Azure running on Azure Stack Hub in your datacenter.
author: BrianBlanchard
ms.author: brblanch
ms.date: 05/19/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
---

# Govern Azure running in your datacenter

Governing hybrid solutions across public and private cloud platforms adds complexity. Since Azure Stack Hub is your own private instance of Azure running in your datacenter, that complexity is inherently reduced.

The business processes, disciplines, and many of the best practices outlined in the [govern methodology](../../govern/index.md) of the Cloud Adoption Framework can still be applied to hybrid governance with Azure Stack Hub. Many cloud-native tools used in the public cloud version of Azure can also be used in Azure Stack Hub.

## Azure Stack Hub governance considerations

The following series of blogs show how cloud governance concepts can be implemented for Azure Stack Hub:

- [Organizational services](https://azure.microsoft.com/blog/azure-stack-iaas-part-seven/) such as resource groups, role-based access control (RBAC), change auditing, locks, and tags.
- [Security services](https://azure.microsoft.com/blog/azure-stack-iaas-part-four/), including default firewalls, restrictions, VM updates and patch management, and malware status.
- [DevOps options](https://azure.microsoft.com/blog/azure-stack-iaas-part-seven-2/), including infrastructure as code (IaC), a portal with PowerShell and command-line interface (CLI), Azure Application Insights, and integration with Azure DevOps and Jenkins.

## Governance toolchain for Azure Stack Hub

For guidance applying cloud-native governance tools to Azure Stack Hub environments, see the following links:

- [Azure Resource Manager templates and Desired State Configuration](https://docs.microsoft.com/azure-stack/user/azure-stack-arm-templates?view=azs-2002)
- [PowerShell](https://docs.microsoft.com/azure-stack/user/azure-stack-powershell-overview?view=azs-2002)
- [Azure Policy](https://docs.microsoft.com/azure-stack/user/azure-stack-policy-module?view=azs-2002)
- [Role-based access control (RBAC)](https://docs.microsoft.com/azure-stack/user/azure-stack-manage-permissions?view=azs-2002)

## Next step: Integrate this strategy into your cloud adoption journey

The following articles provide guidance found at specific points throughout the cloud adoption journey.

- [Manage Azure Stack Hub](./manage.md)
