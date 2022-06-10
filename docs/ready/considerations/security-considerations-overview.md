---
title: Security Considerations Overview
description: briefly covers each security topic for platform devops.
author: SimonaKovatcheva
ms.author: sikovatc
ms.date: 03/29/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Security Considerations for Platform DevOps

Security should always be a priority in cloud-based development platforms such as Azure DevOps (ADO) and GitHub. Microsoft updates and maintains the security of the underlying cloud infrastructure, but it's up to you to review security best practices and configure them in your own ADO projects and organizations and GitHub instances. Whether deploying environments through infrastructure as code in CI/CD pipelines or deploying updated code to your applications hosted in Azure, there are several critical security consideration areas.

## Select the correct DevOps agent based on your security needs

There are two options for the agents and runners that power pipelines in Azure DevOps and GitHub - Microsoft-hosted and self-hosted. There are trade-offs for using each type; with Microsoft-hosted, you do not need to worry about upgrades or maintenance, but with self-hosted, you have greater flexibility to implement security guardrails as you have control over the tools installed, operating system, and hardware of the agent. Review the [differences between the types of agents](/azure/devops/pipelines/agents/agents) to identify potential security considerations when choosing either.

## Leverage RBAC through AAD and restrict access to DevOps tooling

Adhere to the principle of least privilege by giving users and services the minimum amount of access to perform their business functions across your DevOps platforms. Consider [integrating Azure DevOps with your Azure Active Directory (AAD) tenant](/azure/devops/organizations/accounts/connect-organization-to-azure-ad) and refer to  [ADO security best practices](/azure/devops/organizations/security/security-best-practices). You can also [integrate GitHub Enterprise with Azure AD](/azure/active-directory/saas-apps/github-enterprise-cloud-enterprise-account-tutorial) as an identity provider to manage users and access.


 After establishing [AAD as your single identity management plane](/azure/cloud-adoption-framework/secure/best-practices/end-to-end-governance#single-identity-management-plane-with-azure-ad-groups), you can adhere to best practices by managing role assignments in ADO while managing group memberships in AAD. For example, consider [assigning ADO roles to AAD groups](/azure/cloud-adoption-framework/secure/best-practices/end-to-end-governance#mirror-rbac-model-with-role-assignments) and simply adjusting a user's AAD membership to change or remove their ADO access. Leverage [Entitlement Management](/azure/active-directory/governance/entitlement-management-overview) in Azure AD to create access packages that allow AAD users time-bound access to the required Azure and ADO resources to complete their tasks. [Privileged Identity Management in AAD](/azure/active-directory/privileged-identity-management/pim-configure#what-can-i-do-with-it) can also be used to provide just-in-time access to promote individuals to administrator roles in ADO for a period of time to complete any tasks that require those elevated permissions. 

Manage security in ADO by leveraging security groups, policies, and settings at the Azure DevOps organization/collection, project, or object level.
Consider disabling inheritance of permissions in ADO when possible.

Periodically review audit events to monitor and react to unexpected usage patterns by administrators and other users. You can [access, filter, and export audit logs for your Azure DevOps organization](/azure/devops/organizations/audit/azure-devops-auditing); for long-term storage and more detailed loq querying, [create an audit stream](/azure/devops/organizations/audit/auditing-streaming) to an Azure Monitor Log Analytics workspace or to a SIEM such as Microsoft Sentinel.

## Use hardened DevOps workstations to build and deploy code

Platform and development teams will often have elevated privileges on the Azure platform, and depending on additional responsibilities, on other services such as Azure DevOps and GitHub. As a result, the potential attack surface is greatly increased, and guidelines need to be put in place to secure any endpoints and workstations used to develop and deploy code. Implement hardened [secure admin workstations (SAWs)](https://www.microsoft.com/insidetrack/protecting-high-risk-environments-with-secure-admin-workstations) for deploying any changes to high-risk and production environments. Refer to the [Zero Trust Model for securing endpoints](/security/zero-trust/deploy/endpoints) for more information.

## Restrict access and permissions on pipelines

Implement guardrails to prevent malicious code deployment in the pipeline. Malicious code may steal enterprise data, secrets, and corrupt production environments. By restricting access and implementing guardrails, we can also prevent lateral exposure to other projects, pipelines, and repositories from any compromised pipelines. Consider following an [incremental approach to securing your YAML pipelines](/azure/devops/pipelines/security/approach). 

## Use a secret store across your pipelines 

Never leave secrets hard-coded in code or in other auxiliary documentation in your repositories. Adversaries scan repositories searching for exposed confidential data to exploit. Instead, [leverage a secret store such as Azure Key Vault](/azure/cloud-adoption-framework/secure/best-practices/secure-devops) and reference that in your Azure DevOps pipeline so the key, secret, or certificate can be securely retrieved. [Azure Key Vaults can also be integrated with GitHub Actions workflows](/azure/developer/github/github-key-vault) for similar behavior. 


## Implement security scanning and testing across pipelines and repos

Whether deploying application code or Infrastructure as Code, implement [DevSecOps best practices and controls](/azure/cloud-adoption-framework/secure/devsecops-controls#build-and-test) in your pipelines to integrate security earlier in your CI/CD journey and prevent costly security breaches later on. Create a strategy to implement static code analysis, unit testing, secret scanning, package/dependency scanning in your pipelines, where applicable. 
If using GitHub Actions and/or repositories, consider leveraging [GitHub Advanced Security features](https://docs.github.com/get-started/learning-about-github/about-github-advanced-security) for code and secret scanning and dependency review. Enterprise security tools such as Microsoft Defender for Cloud are becoming more integrated with DevOps tools; for example, Defender for Cloud can [scan for vulnerabilities container images in CI/CD workflows](/azure/defender-for-cloud/defender-for-container-registries-cicd).

## Restrict access to repositories and branches 

Restrict access, permissions, and branching on repositories to protect your code and environments from potentially undesired and malicious changes. [Restrict access to repositories](/azure/devops/repos/git/set-git-repository-permissions?toc=%2fazure%2fdevops%2forganizations%2fsecurity%2ftoc.json&bc=%2fazure%2fdevops%2forganizations%2fsecurity%2fbreadcrumb%2ftoc.json) by leveraging security groups in Azure DevOps. Limit who can read and update code in your branches by setting [branch permissions](/azure/devops/repos/git/branch-permissions?toc=%2Fazure%2Fdevops%2Forganizations%2Fsecurity%2Ftoc.json&bc=%2Fazure%2Fdevops%2Forganizations%2Fsecurity%2Fbreadcrumb%2Ftoc.json). 

## Secure and properly scope service connections 

When deploying infrastructure or application code changes in the context of an Azure environment, it is recommended to use a [service connection](/azure/devops/pipelines/library/service-endpoints) whenever possible. It should have limited deployment access to only specific resources or resource groups in Azure in order to reduce any potential attack surfaces. Also, consider creating separate service connections per dev, testing, QA, and production environments.

