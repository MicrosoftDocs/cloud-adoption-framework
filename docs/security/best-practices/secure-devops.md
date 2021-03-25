---
title: Security Title
description: Security Description
author: GitHubAlias
ms.author: msftalias
ms.date: 04/04/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: secure
ms.custom: internal
---

# Generic space holder - remember to edit the metadata before publication

## This article should cover all of the items under the "secure devops" question at the CAF level

- Formal DevOps approach to building and maintaining software in this workload was adopted.The DevOps approach increases the organization's ability to rapidly address security concerns without waiting for a longer planning and testing cycle of traditional waterfall model. Key attributes are: automation, close integration of infra and dev teams, testability and reliability and repeatability of deployments.
- DevOps security guidance based on industry lessons-learned, and available automation tools (OWASP guidance, Microsoft toolkit for Secure DevOps etc.) is leveraged.Organizations should leverage a control framework such as NIST, CIS or ASB (Azure Security Benchmarks) for securing applications on the cloud rather than starting from zero.
- Gates and approvals are configured in DevOps release process of this workload.Pull Requests and code reviews serve as the first line of approvals during development cycle. Before releasing new code to production (new features, bugfixes etc.), security review and approval should be required.
- Security team is involved in planning, design and the rest of DevOps process of this workload.There should be a process for onboarding service securely to Azure. The onboarding process should include reviewing the configuration options to determine what logging/monitoring needs to be established, how to properly harden a resource before it goes into production. For a list of common criteria for onboarding resoruces, see the Service Enablement Framework
- Deployments are automated and it's possible to deploy N+1 and N-1 version (where N is the current production).N-1 and N+1 refer to roll-back and roll-forward. Automated deployment pipelines should allow for quick roll-forward and roll-back deployments to address critical bugs and code updates outside of the normal deployment lifecycle.
- Code scanning tools are integrated as part of the continuous integration (CI) process for this workload and cover also 3rd party dependencies.Credentials should not be stored in source code or configuration files, because that increases the risk of exposure. Code analyzers (such as Roslyn analyzers for Visual Studio) can prevent from pushing credentials to source code repository and pipeline addons such as CredScan (part of Microsoft Security Code Analysis) help to catch credentials during the build process. Vulnerable dependencies should be flagged and investigated. This can done in combination with other code scanning tasks (e.g. code churn, test results/coverage).
- Credentials, certificates and other secrets are managed in a secure manner inside of CI/CD pipelines.Secrets need to be managed in a secure manner inside of the CI/CD pipeline. The secrets needs to be stored either in a secure store inside the pipeline or externally in Azure Key Vault. When deploying application infrastructure (e.g. with Azure Resource Manager or Terraform), credentials and keys should be generated during the process, stored directly in Key Vault and referenced by deployed resources. Hard-coded credentials should be avoided.
- Branch policies are used in source control management, main branch is protected and code reviews are required.Branch policies provide additional level of control over the code which is committed to the product. It is a common practice to not allow pushing against the main branch and require pull-request (PR) with code review before merging the changes by at least one reviewer, other than the change author. Different branches can have different purposes and access levels, for example: feature branches are created by developers and are open to push, integration branch requires PR and code-review and production branch requires additional approval from a senior developer before merging.
- Security controls are applied to all self-hosted build agents used by this workload (if any).When the organization uses their own build agents it adds management complexity and can become an attack vector. Build machine credentials must be stored securely and file system needs to be cleaned of any temporary build artifacts regularly. Network isolation can be achieved by only allowing outgoing traffic from the build agent, because it's using pull model of communication with Azure DevOps.
- CI/CD roles and permissions are clearly defined for this workload
