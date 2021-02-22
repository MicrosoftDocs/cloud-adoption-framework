---
title: Security Baseline tools in Azure
description: See how Azure native tools can help mature policies and processes that support the Security Baseline discipline.
author: BrianBlanchard
ms.author: brblanch
ms.date: 09/17/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
ms.custom: internal
---

# Security Baseline tools in Azure

The [Security Baseline discipline](./index.md) is one of the [Five Disciplines of Cloud Governance](../governance-disciplines.md). This discipline focuses on ways of establishing policies that protect the network, assets, and most importantly the data that will reside on a cloud provider's solution. Within the Five Disciplines of Cloud Governance, the Security Baseline discipline involves classification of the digital estate and data. It also involves documentation of risks, business tolerance, and mitigation strategies associated with the security of data, assets, and networks. From a technical perspective, this discipline also includes involvement in decisions regarding [encryption](../../decision-guides/encryption/index.md), [network requirements](../../decision-guides/software-defined-network/index.md), [hybrid identity strategies](../../decision-guides/identity/index.md), and tools to [automate enforcement](../../decision-guides/policy-enforcement/index.md) of security policies across [resource groups](../../decision-guides/resource-consistency/index.md).

The following list of Azure tools can help mature the policies and processes that support this discipline.

| Tool | [Azure portal](https://azure.microsoft.com/features/azure-portal/) and [Azure Resource Manager](/azure/azure-resource-manager/management/overview) | [Azure Key Vault](/azure/key-vault/)  | [Azure AD](/azure/active-directory/fundamentals/active-directory-whatis) | [Azure Policy](/azure/governance/policy/overview) | [Azure Security Center](/azure/security-center/security-center-introduction) | [Azure Monitor](/azure/azure-monitor/overview) |
|------------------------------------------------------------|---------------------------------|-----------------|----------|--------------|-----------------------|---------------|
| Apply access controls to resources and resource creation   | Yes                             | No              | Yes      | No           | No                    | No            |
| Secure virtual networks                                    | Yes                             | No              | No       | Yes          | No                    | No            |
| Encrypt virtual drives                                     | No                              | Yes             | No       | No           | No                    | No            |
| Encrypt PaaS storage and databases                         | No                              | Yes             | No       | No           | No                    | No            |
| Manage hybrid identity services                            | No                              | No              | Yes      | No           | No                    | No            |
| Restrict allowed types of resource                         | No                              | No              | No       | Yes          | No                    | No            |
| Enforce geo-regional restrictions                          | No                              | No              | No       | Yes          | No                    | No            |
| Monitor security health of networks and resources          | No                              | No              | No       | No           | Yes                   | Yes           |
| Detect malicious activity                                  | No                              | No              | No       | No           | Yes                   | Yes           |
| Preemptively detect vulnerabilities                        | No                              | No              | No       | No           | Yes                   | No            |
| Configure backup and disaster recovery                     | Yes                             | No              | No       | No           | No                    | No            |

For a complete list of Azure security tools and services, see [Security services and technologies available on Azure](/azure/security/fundamentals/services-technologies).

Customers commonly use third-party tools to enable Security Baseline discipline activities. For more information, see the article [integrate security solutions in Azure Security Center](/azure/security-center/security-center-partner-integration).

In addition to security tools, [Compliance Management in Microsoft 365](https://www.microsoft.com/microsoft-365/enterprise/compliance-management) provides extensive guidance, reports, and related documentation that can help you perform risk assessments as part of your migration planning process.
