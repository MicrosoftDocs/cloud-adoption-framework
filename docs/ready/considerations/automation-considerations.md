---
title: Automation considerations
description: Describes the different considerations and recomentation when automating deployment of Azure Landing Zone and platform services
author: MariusStorhaug
ms.author: MariusStorhaug
ms.date: 04/27/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Automation considerations

Describe why a platform team should consider automating platform deployment/configuration for an evolving platform.
https://www.thinkautomation.com/productivity/ten-benefits-of-automation/
https://www.productivity.com/benefits-of-automation/
https://learn.hashicorp.com/tutorials/terraform/infrastructure-as-code?in=terraform/azure-get-started

https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/deploy-landing-zones-with-terraform
https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/terraform-module
https://www.terraform.io/cloud-docs/guides/recommended-practices/part3.2

Describe how parts of the platform can be automated in different ways. with their opportunities and trade-offs.

Deployment layering?

Single source of truth.

Scheduling, event-driven, state-driven, both, or none?

https://www.luminatech.co.uk/news/7-key-considerations-for-an-effective-it-automation-strategy
https://www.cio.com/article/230399/6-critical-considerations-when-building-business-driven-automation-for-scale.html
https://foundry4.com/automation-strategy-5-considerations-before-getting-started
https://www.ontestautomation.com/five-considerations-before-choosing-an-automated-testing-solution/

## Considerations Platform automation

https://www.hcltech.com/blogs/infrastructure-code-iac-revolution-it-automation
https://www.devtraining.eu/event/online-devops-extreme-automation-2022-05-23-2022-05-25-221/register
https://medium.com/@rodrigo.estrada/iac-extreme-immutability-9a8c2d20001e
https://searchconvergedinfrastructure.techtarget.com/feature/IaC-tools-comparison-shows-benefits-of-automated-deployments
https://blog.cloudticity.com/noops-automation-solving-healthcares-problems
https://superadmins.com/infrastructure-as-code-demystified-iac-benefits-challenges-best-practices/
https://www.aquasec.com/cloud-native-academy/devsecops/infrastructure-as-code-devops/
https://www.aquasec.com/cloud-native-academy/devsecops/infrastructure-as-code-iac/

Extreme automation - Cost/benefit - Return on investment
Discuss different approaches to automation of the platform deployment and configuration (day 2 ops).
Configuration changes on the platform can have huge implications on workloads running on it.
Establishing a **4 eyes principle** could limit errors and mistakes when deploying or reconfiguring the platform.
Different solutions to consider as teams transition from a **ClickOps** approach where changes happen in the portal.
Tools that can push and pull configuration to and from Azure, allowing a dual mode of **ClickOps** and **DevOps**.
Use of CI/CD to enable a **fail fast** approach where validation happens before deployment.
Consider an approach of treating **Everything as Code** including but not limited to:
What is being deployed and configured
Details on how the automation does what it does (i.e. deployment logic as code, yml pipelines vs Release pipelines)
How to handle rollback of changes
- Infrastructure as Code (CI/CD, GitOps, DevOps)
- Azure Policy (Blueprint?)
- Azure Automation
- Azure Functions

## Recommendations for Platform automation

Use **Everything as Code** approach for full transparency and configuration control of the Azure platform.
Packages for deploying, where are the packages coming from (Single/Multi repo, Bicep Reg)?

## Read more

- [Azure/ALZ-Bicep | GitHub Repo](https://github.com/Azure/ALZ-Bicep)
- [Azure/terraform-azurerm-caf-enterprise-scale | GitHub Repo](https://registry.terraform.io/modules/Azure/caf-enterprise-scale/azurerm/latest)
-

- [Adopt policy-driven guardrails - Cloud Adoption Framework | Microsoft Docs](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/enterprise-scale/dine-guidance)
- [Fundamentals of Bicep - Learn | Microsoft Docs](https://docs.microsoft.com/learn/paths/fundamentals-bicep/)
- [Intermediate Bicep - Learn | Microsoft Docs](https://docs.microsoft.com/learn/paths/intermediate-bicep/)
- [Advanced Bicep - Learn | Microsoft Docs](https://docs.microsoft.com/learn/paths/advanced-bicep/)
- [Deploy Azure resources by using Bicep and GitHub Actions - Learn | Microsoft Docs](https://docs.microsoft.com/learn/paths/bicep-github-actions/)
- [Deploy Azure resources by using Bicep and Azure Pipelines - Learn | Microsoft Docs](https://docs.microsoft.com/learn/paths/bicep-azure-pipelines/)
