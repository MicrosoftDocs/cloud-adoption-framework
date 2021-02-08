---
title: "Govern modern container solutions"
description: Extend governance practices to modern containers instances
author: BrianBlanchard
ms.author: brblanch
ms.date: 03/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
---

# Govern modern container solutions

The [cloud adoption framework provides a governance methodology](../../govern/index.md) to systematically and incrementally improve governance of your cloud portfolio. This article demonstrates how you can extend that standard governance approach to govern Kubernetes clusters that are deployed to Azure or other public/private clouds.

## Initial governance foundation

Governance starts with an [initial governance foundation often referred to as a governance MVP](../../govern/initial-foundation.md). That foundation deploys the basic Azure products required to deliver governance across your cloud environment.

The initial governance foundation focuses on the following aspects of governance:

- Basic hybrid network and connectivity
- Azure Role-based access control (RBAC) for identity and access control
- Naming and tagging standard for consistent identification of resources
- Organization of resources using resource groups, subscriptions, and management groups
- Azure Policy and Azure Blueprint to enforce governance policies

Each of these features of the initial governance foundation can be used to govern modern container solutions instances. But first, you will need to add a few key components to that initial foundation to apply [Azure Policy to your containers](https://docs.microsoft.com/azure/governance/policy/concepts/policy-for-kubernetes?bc=%252fazure%252fcloud-adoption-framework%252f_bread%252ftoc.json&toc=%252fazure%252fcloud-adoption-framework%252ftoc.json). Once enabled, you can use Azure Policy & your initial governance foundation to govern the following types of containers:

- [Azure Kubernetes Service (AKS)](https://docs.microsoft.com/azure/aks/intro-kubernetes?bc=%252fazure%252fcloud-adoption-framework%252f_bread%252ftoc.json&toc=%252fazure%252fcloud-adoption-framework%252ftoc.json)
- [Azure Arc enabled Kubernetes](https://docs.microsoft.com/azure/azure-arc/kubernetes/overview?bc=%252fazure%252fcloud-adoption-framework%252f_bread%252ftoc.json&toc=%252fazure%252fcloud-adoption-framework%252ftoc.json)
- [AKS Engine](https://github.com/Azure/aks-engine/blob/master/docs/README.md)

## Expand on governance disciplines

The initial governance foundation can then be used to expand on various disciplines of governance to ensure consistent, stable deployment approaches across all of your Kubernetes instances.

### Security baseline

The following best practices can help add to your initial security baseline, to account for security of your AKS clusters:

- [Secure pods](https://docs.microsoft.com/azure/aks/use-pod-security-on-azure-policy?bc=%252fazure%252fcloud-adoption-framework%252f_bread%252ftoc.json&toc=%252fazure%252fcloud-adoption-framework%252ftoc.json)
- [Secure traffic between pods](https://docs.microsoft.com/azure/aks/use-network-policies?bc=%252fazure%252fcloud-adoption-framework%252f_bread%252ftoc.json&toc=%252fazure%252fcloud-adoption-framework%252ftoc.json)
- [Authorized IP access for AKS API](https://docs.microsoft.com/azure/aks/api-server-authorized-ip-ranges?bc=%252fazure%252fcloud-adoption-framework%252f_bread%252ftoc.json&toc=%252fazure%252fcloud-adoption-framework%252ftoc.json)

### Identity

There are also a number of best practices you can apply to your identity baseline to ensure consistent identity and access management across your kubernetes clusters:

- [Azure AD integration](https://docs.microsoft.com/azure/aks/managed-aad?bc=%252fazure%252fcloud-adoption-framework%252f_bread%252ftoc.json&toc=%252fazure%252fcloud-adoption-framework%252ftoc.json)
- [RBAC and Azure AD integration](https://docs.microsoft.com/azure/aks/azure-ad-rbac?bc=%252fazure%252fcloud-adoption-framework%252f_bread%252ftoc.json&toc=%252fazure%252fcloud-adoption-framework%252ftoc.json)
- [Managed identities in Kubernetes](https://docs.microsoft.com/azure/aks/use-managed-identity?bc=%252fazure%252fcloud-adoption-framework%252f_bread%252ftoc.json&toc=%252fazure%252fcloud-adoption-framework%252ftoc.json)
- [Access other Azure resources with Azure AD pod identity](https://docs.microsoft.com/azure/aks/use-azure-ad-pod-identity?bc=%252fazure%252fcloud-adoption-framework%252f_bread%252ftoc.json&toc=%252fazure%252fcloud-adoption-framework%252ftoc.json)

## Next step: Manage modern container solutions

The following list of articles will take you to guidance found at specific points throughout the cloud adoption journey to help you be successful in the cloud adoption scenario.

- [Manage modern container solutions](./manage.md)
