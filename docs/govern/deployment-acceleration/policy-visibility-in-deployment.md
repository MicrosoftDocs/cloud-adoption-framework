---
title: Policy visibility in the deployment process
description: Governance via policy should be incorporated early in the development process.
author: robbagby
ms.author: robbag
ms.date: 10/20/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
ms.custom: internal, UpdateFrequency2
---

# Policy visibility in the deployment process

Azure Policy is a key tool to ensure solutions adhere to organizational standards and to assess compliance. Policy enforcement and auditing should be automated in the DevOps process to ensure compliance. This governance should be performed as early in the development process as possible to prevent rework or wasted efforts, such as implementing noncompliant resources. Automating policy compliance at the beginning of the development process ensures applications start compliant and remain compliant.

## Guidance and enforcement

You should integrate policy evaluation into every deployment process that creates or manages resources in Azure. These processes include application deployments and infrastructure as code (IaC) pipelines that use tools like ARM templates or Terraform to create infrastructure.

You should implement policy compliance checks in CI/CD pipelines at the beginning of the development process. Configure the pipelines to continue or fail based on the compliance state of resources.

Use the following resources as a guide to implement compliance checks within your deployment pipelines.

- [Implement Azure Policy as Code with GitHub](/azure/governance/policy/tutorials/policy-as-code-github)
- [Implement Azure Policy with Azure DevOps release pipelines](/azure/governance/policy/tutorials/policy-devops-pipelines)
- Use the [`GitHub Action for Azure Policy Compliance Scan`](https://github.com/marketplace/actions/azure-policy-compliance-scan) to continue or fail the workflow based on the compliance state of resources.

## Auditing

Use the following resources as a guide to audit policy compliance and to automate policy compliance reporting.

- [Get compliance data of Azure resources in the portal](/azure/governance/policy/how-to/get-compliance-data#portal)
- [Get compliance data of Azure resources at the command line](/azure/governance/policy/how-to/get-compliance-data#command-line)
- Use the [`GitHub Action for Azure Policy Compliance Scan`](https://github.com/marketplace/actions/azure-policy-compliance-scan) to generate a report on the compliance state of scanned resources.
