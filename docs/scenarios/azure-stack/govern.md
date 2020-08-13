---
title: "Govern an Azure instance in your datacenter"
description: Learn how to govern an Azure instance running on Azure Stack Hub in your datacenter.
author: BrianBlanchard
ms.author: brblanch
ms.date: 05/19/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
---

# Govern an Azure instance in your datacenter

Governing hybrid solutions across public and private cloud platforms adds complexity. Because your Azure Stack hub is your own private instance of Azure running in your datacenter, that complexity is inherently reduced.

The business processes, disciplines, and many of the best practices outlined in the [govern methodology](../../govern/index.md) of the Cloud Adoption Framework can still be applied to hybrid governance with Azure Stack Hub. Many cloud-native tools used in the public cloud version of Azure can also be used in your Azure Stack hub.

## Azure Stack Hub governance considerations

The following series of blogs shows how your organization can implement cloud governance concepts for Azure Stack Hub:

- [Organizational services](https://azure.microsoft.com/blog/azure-stack-iaas-part-seven/) such as resource groups, role-based access control (RBAC), change auditing, locks, and tags.
- [Security services](https://azure.microsoft.com/blog/azure-stack-iaas-part-four/), including default firewalls, restrictions, VM updates and patch management, and malware status.
- [DevOps options](https://azure.microsoft.com/blog/azure-stack-iaas-part-seven-2/), including infrastructure as code, a portal with PowerShell and command-line interface, Azure Application Insights, and integration with Azure DevOps and Jenkins.

## Governance toolchain for Azure Stack Hub

For guidance on applying cloud-native governance tools to Azure Stack Hub environments, see:

- [Azure Resource Manager templates and Desired State Configuration](https://docs.microsoft.com/azure-stack/user/azure-stack-arm-templates?view=azs-2002)
- [PowerShell](https://docs.microsoft.com/azure-stack/user/azure-stack-powershell-overview?view=azs-2002)
- [Azure Policy](https://docs.microsoft.com/azure-stack/user/azure-stack-policy-module?view=azs-2002)
- [Role-based access control](https://docs.microsoft.com/azure-stack/user/azure-stack-manage-permissions?view=azs-2002)

## Next steps

For guidance on specific elements of the cloud adoption journey, see:

- [Manage Azure Stack Hub](./manage.md)
