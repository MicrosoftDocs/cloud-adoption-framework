---
title: Develop your naming and tagging strategy for Azure resources
description: Read an overview of resource naming and tagging strategy for enterprise cloud adoption efforts.
author: BrianBlanchard
ms.author: brblanch
ms.date: 11/20/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: readiness, fasttrack-edit, internal
---

# Develop your naming and tagging strategy for Azure resources

Organize your cloud assets to support operational management and accounting requirements. Well-defined naming and metadata tagging conventions help to quickly locate and manage resources. These conventions also help associate cloud usage costs with business teams via chargeback and showback accounting mechanisms.

When you're ready to define your naming and tagging strategy, use these links to assist you:

- [Name your Azure resources and assets](./resource-naming.md)
- [Recommended abbreviations for Azure resource types](./resource-abbreviations.md)
- [Tag your Azure resources](./resource-tagging.md)
- [Resource naming and tagging decision guide](../../decision-guides/resource-tagging/index.md)

## Purpose of naming and tagging

Accurate representation and naming of resources are critical for security purposes. In the event of a security incident, it's critical to quickly identify affected systems, what functions those systems support, and the potential business impact. Security services such as [Azure Security Center](https://docs.microsoft.com/azure/security-center/security-center-introduction) and [Azure Sentinel](https://docs.microsoft.com/azure/sentinel) reference resources and their associated logging and alert information by resource name.

Azure defines [naming rules and restrictions for Azure resources](/azure/azure-resource-manager/management/resource-name-rules). This guidance provides detailed recommendations to support enterprise cloud adoption efforts.

Changing resource names can be difficult. Establish a comprehensive naming convention before you begin any large cloud deployment.

> [!NOTE]
> Every business has different organizational and management requirements. These recommendations provide a starting point for discussions within your cloud adoption teams.
>
> As these discussions proceed, use the following template to capture the naming and tagging decisions you make when you align these recommendations to your specific business needs.
>
> Download the [naming and tagging conventions tracking template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/ready/naming-and-tagging-conventions-tracking-template.xlsx).

## Naming and tagging strategy

A naming and tagging strategy includes business and operational details as components of resource names and metadata tags:

- The business side of this strategy ensures that resource names and tags include the organizational information needed to identify the teams. Use a resource along with the business owners who are responsible for resource costs.

- The operational side ensures that names and tags include information that IT teams use to identify the workload, application, environment, criticality, and other information useful for managing resources.

## Next steps

Learn about the considerations for naming your Azure resources and assets, and review example names for resources and assets in Azure.

> [!div class="nextstepaction"]
> [Name your Azure resources and assets](./resource-naming.md)
