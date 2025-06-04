---
title: DevOps security considerations overview
description: See a summary of security considerations including access, agents, workstations, and scanning, for DevOps platforms like Azure DevOps and GitHub.
author: steved0x
ms.author: sdanie
ms.date: 06/23/2022
ms.topic: conceptual
ms.custom: internal
---

# Security considerations for DevOps platforms

Security should always be a priority in cloud-based development platforms such as [Azure DevOps](/azure/devops/user-guide/what-is-azure-devops) and [GitHub](https://github.com/). Microsoft updates and maintains the security of the underlying cloud infrastructure, but it's up to you to review and configure security best practices for your own Azure DevOps organizations and GitHub instances.

Consider the following critical security areas whether you deploy environments through infrastructure as code in continuous integration and continuous deployment (CI/CD) pipelines, or deploy code to your applications hosted in Azure.

## Restrict access to DevOps tooling

Follow the principle of least privilege by using role-based access control (RBAC) through [Microsoft Entra ID](/entra/fundamentals/whatis). Give users and services the minimum amount of access to your DevOps platforms that they need to do their business functions. For more information, see the following articles:

- [Connect your organization to Microsoft Entra ID](/azure/devops/organizations/accounts/connect-organization-to-azure-ad)
- [Microsoft Entra Single Sign-On (SSO) integration with GitHub Enterprise Cloud](/entra/identity/saas-apps/github-enterprise-cloud-enterprise-account-tutorial)
- [Azure DevOps security best practices](/azure/devops/organizations/security/security-best-practices)

After you establish Microsoft Entra ID as your identity management plane, follow best practices to manage Azure DevOps role assignments with [Microsoft Entra group memberships](../../secure/govern.md). You can [assign Azure DevOps roles to Microsoft Entra groups](../../secure/govern.md), and adjust a user's Microsoft Entra membership to change or remove their Azure DevOps access.

- Use Microsoft Entra ID [entitlement management](/entra/id-governance/entitlement-management-overview) to create access packages that allow Microsoft Entra users time-bound access to required resources to complete their tasks.

- You can also use Microsoft Entra [Privileged Identity Management](/entra/id-governance/privileged-identity-management/pim-configure#what-can-i-do-with-it) for just-in-time access to promote individuals to Azure DevOps Administrator roles for a period of time.

Manage security in Azure DevOps by using security groups, policies, and settings at the Azure DevOps organization, project, or object level. Consider disabling permission inheritance in Azure DevOps if possible.

## Restrict repository and branch access

Restrict repository access, permissions, and branch creation to protect your code and environments from undesired or malicious changes. [Restrict access to repositories](/azure/devops/repos/git/set-git-repository-permissions?toc=/azure/devops/organizations/security/toc.json&bc=/azure/devops/organizations/security/breadcrumb/toc.json) by using security groups in Azure DevOps. Limit who can read and update code in your branches by setting [branch permissions](/azure/devops/repos/git/branch-permissions?toc=/azure/devops/organizations/security/toc.json&bc=/azure/devops/organizations/security/breadcrumb/toc.json).

## Restrict pipeline access and permissions

Malicious code might steal enterprise data and secrets, and corrupt production environments. Implement guardrails to prevent malicious code deployment in the pipeline. By restricting access and implementing guardrails, you can also prevent lateral exposure to other projects, pipelines, and repositories from any compromised pipelines.

Consider following an incremental approach to securing your YAML pipelines. For more information, see [Plan how to secure your YAML pipelines](/azure/devops/pipelines/security/approach).

## Select the DevOps agent based on security needs

You can use Microsoft-hosted or self-hosted agents to power Azure DevOps and GitHub pipelines. There are trade-offs for each type of agent.

With Microsoft-hosted agents, you don't need to worry about upgrades or maintenance. With self-hosted agents, you have greater flexibility to implement security guardrails. You control the agent hardware, operating system, and installed tools.

See [Azure Pipelines agents](/azure/devops/pipelines/agents/agents) to review the differences between the types of agents and identify potential security considerations.

## Use secure and scoped service connections

Whenever possible, use a [service connection](/azure/devops/pipelines/library/service-endpoints) to deploy infrastructure or application code in an Azure environment. The service connection should have limited deployment access to specific Azure resources or resource groups, to reduce any potential attack surfaces. Also, consider creating separate service connections for development, testing, QA, and production environments.

## Use a secret store

Never hard-code secrets in code or auxiliary documentation in your repositories. Adversaries scan repositories, searching for exposed confidential data to exploit. Set up a secret store such as [Azure Key Vault](/azure/key-vault/general/basic-concepts), and reference the store in Azure Pipelines to securely retrieve keys, secrets, or certificates. For more information, see [Secure the pipeline and CI/CD workflow](/security/zero-trust/develop/secure-devops-environments-zero-trust). You can also [use Key Vault secrets in GitHub Actions workflows](/azure/developer/github/github-key-vault).

## Use hardened DevOps workstations to build and deploy code

Platform and development teams often have elevated privileges on the Azure platform, or on other services such as Azure DevOps and GitHub. This access greatly increases the potential attack surface. Implement guardrails to secure any endpoints and workstations you use to develop and deploy code.

Use hardened [secure admin workstations (SAWs)](https://techcommunity.microsoft.com/blog/coreinfrastructureandsecurityblog/secure-administrative-workstations/258424) to deploy any changes to high-risk and production environments. For more information, see [Secure endpoints with Zero Trust](/security/zero-trust/deploy/endpoints).

## Do security scanning and testing

Whether you deploy application code or infrastructure as code, implement [DevSecOps best practices and controls](/security/zero-trust/develop/secure-devops-environments-zero-trust) in your pipelines. Integrate security early in your CI/CD journey to prevent costly security breaches later on. Create a strategy to implement static code analysis, unit testing, secret scanning, and package/dependency scanning in your pipelines.

Enterprise security tools such as [Microsoft Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction) can integrate with DevOps tools. For example, Defender for Cloud can [identify vulnerable container images in your CI/CD workflows](/azure/defender-for-cloud/defender-for-container-registries-cicd). For GitHub Actions and repositories, use [GitHub Advanced Security](https://docs.github.com/get-started/learning-about-github/about-github-advanced-security) for code and secret scanning and dependency review.

Periodically review audit events to monitor and react to unexpected usage patterns by administrators and other users. You can [access, filter, and export audit logs](/azure/devops/organizations/audit/azure-devops-auditing) for your Azure DevOps organization. For long-term storage and detailed log querying, [create an audit stream](/azure/devops/organizations/audit/auditing-streaming) to an [Azure Monitor Log Analytics](/azure/azure-monitor/logs/log-analytics-overview) workspace, or to a security information and event management (SIEM) system like [Microsoft Sentinel](/azure/sentinel/overview).
