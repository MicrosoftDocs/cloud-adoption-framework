---
title: DevOps security considerations overview
description: See a summary of security considerations including access, agents, workstations, and scanning, for DevOps platforms like Azure DevOps and GitHub.
author: steved0x
ms.author: sdanie
ms.date: 06/23/2022
ms.topic: concept-article
ms.custom: internal
---

# Security considerations for DevOps platforms

Security should always be a priority in cloud-based development platforms such as [Azure DevOps](/azure/devops/user-guide/what-is-azure-devops) and [GitHub](https://github.com/). Microsoft updates and maintains the security of the underlying cloud infrastructure, but it's up to you to review and configure security best practices for your own Azure DevOps organizations and GitHub instances.

Consider the following critical security areas whether you deploy environments through infrastructure as code in continuous integration and continuous deployment (CI/CD) pipelines, or deploy code to your applications hosted in Azure.

## Restrict access to DevOps tooling

Follow the principle of least privilege by using role-based access control (RBAC) through [Microsoft Entra ID](/entra/fundamentals/whatis). Give users and services the minimum amount of access to your DevOps platforms that they need to do their business functions. For more information, see the following articles:

- [Connect your organization to Microsoft Entra ID](/azure/devops/organizations/accounts/connect-organization-to-azure-ad)
- [Microsoft Entra single sign-on (SSO) integration with GitHub Enterprise Cloud](/entra/identity/saas-apps/github-enterprise-cloud-enterprise-account-tutorial)
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

With Microsoft-hosted agents, you don't need to worry about upgrades or maintenance. With self-hosted agents, you have greater flexibility to implement security guardrails. You control the agent hardware, operating system, and installed tools. Self-hosted agents can also provide private networking access to resources behind firewalls or virtual networks.

See [Azure Pipelines agents](/azure/devops/pipelines/agents/agents) to review the differences between the types of agents and identify potential security considerations.

## Use secure and scoped service identities

For GitHub, Azure DevOps, or third party CI/CD platforms, use secure and scoped identities to deploy code and infrastructure to Azure environments.

- User Assigned Managed Identities or Application Registrations (Service Principals) in Entra ID can be used. Never use a User Account.
- Implement [OpenId Connect (Workload Identity Federation)](/azure/active-directory/develop/workload-identity-federation) authentication with Federated Credentials for the identity. Never use client secrets or certificates.
- Create a separate identity for each application and environment you deploy to, ensuring granular permissions can be applied.
- Create a separate identity per application and environment for read-only operations, such as Terraform plan or Bicep what-if.
- Scope the identity permissions to only the Azure subscription or resource groups required for deployment. Use the principle of least privilege to assign only the necessary roles to the identity.
- Deploy your identities and Federated Credentials through infrastructure as code (IaC) in a secure subscription vending process. For more information, see [Automate subscription deployment and configuration](/azure/cloud-adoption-framework/ready/landing-zone/design-area/subscription-vending).

User Assigned Managed Identities are managed by Azure Resource Manager. Application Registrations (Service Principals) are managed by Entra ID. User Assigned Managed Identities more easily integrate with your subscription vending process, ensuring they're decommissioned along with your other resources when no longer needed.

With self-hosted agents utilizing Azure compute it's possible to use System or User Assigned Managed Identities directly on the agent. Although this approach can be secure, it's recommended to use OpenId Connect (Workload Identity Federation) with either User Assigned Managed Identities or Application Registrations (Service Principals) for greater flexibility and control. When you use a compute attached managed identity, if you attach multiple User Assigned Managed Identities to the agent, anything running on the agent has access to all of them. It's usually cost prohibitive to have separate agents per application and environment to ensure least privilege access.

### Azure DevOps

Always use a [service connection](/azure/devops/pipelines/library/service-endpoints) to deploy infrastructure or application code in an Azure environment. A service connection is a wrapper for the identity in Azure.

- Create a separate service connection and identity for each application and environment you deploy to, ensuring granular permissions can be applied.
- Create [approvals](/azure/devops/pipelines/process/approvals#approvals) on the service connection. Don't create them on Environments, as that can be bypassed in code.
- Create [required templates](/azure/devops/pipelines/process/approvals#required-template) (also known as governed pipelines) on the service connection to ensure that malicious code can't be injected without approval.
- Ensure your identity Federated Credentials are scoped to the service connection only.
- Deploy your service connections through infrastructure as code (IaC) in a secure subscription vending process. For more information, see [Automate subscription deployment and configuration](/azure/cloud-adoption-framework/ready/landing-zone/design-area/subscription-vending).

### GitHub Actions

Always use the built-in Actions or environment variables to specify the identity.

- Create approvals on a GitHub Actions Environment.
- Update your [subject claims](https://docs.github.com/actions/reference/security/oidc#customizing-the-token-claims) to include the `environment` claim to ensure your identity can only be used in the scope of the specified environment. Add this claim to your identity Federated Credential.
- Update you [subject claims](https://docs.github.com/actions/reference/security/oidc#customizing-the-token-claims) to include the `job_workflow_ref` (also known as governed pipelines) claim to ensure your identity can only be used in the scope of the specified workflow. Add this claim to your identity Federated Credential.
- Update your [subject claims](https://docs.github.com/actions/reference/security/oidc#customizing-the-token-claims) to remove `repository` and use `repository_owner_id` and `repository_id` instead to ensure your identity can only be used in the scope of the specified repository even if it's renamed. Add this claim to your identity Federated Credential.
- Update your subjects claims through infrastructure as code (IaC) in a secure subscription vending process. For more information, see [Automate subscription deployment and configuration](/azure/cloud-adoption-framework/ready/landing-zone/design-area/subscription-vending).

## Use a secret store

Always avoid using secrets, prefer OpenId Connect (Workload Identity Federation) or Managed Identities wherever possible.

In the case that you can't avoid using a secret, never hard-code them in code or auxiliary documentation in your repositories. Adversaries scan repositories, searching for exposed confidential data to exploit. Set up a secret store such as [Azure Key Vault](/azure/key-vault/general/basic-concepts), and reference the store in Azure Pipelines to securely retrieve keys, secrets, or certificates. For more information, see [Secure the pipeline and CI/CD workflow](/security/zero-trust/develop/secure-devops-environments-zero-trust). You can also [use Key Vault secrets in GitHub Actions workflows](/azure/developer/github/github-key-vault).

## Use hardened DevOps workstations to build and deploy code

Platform and development teams often have elevated privileges on the Azure platform, or on other services such as Azure DevOps and GitHub. This access greatly increases the potential attack surface. Implement guardrails to secure any endpoints and workstations you use to develop and deploy code.

Use hardened [secure admin workstations (SAWs)](https://techcommunity.microsoft.com/blog/coreinfrastructureandsecurityblog/secure-administrative-workstations/258424) to deploy any changes to high-risk and production environments. For more information, see [Secure endpoints with Zero Trust](/security/zero-trust/deploy/endpoints).

## Do security scanning and testing

Whether you deploy application code or infrastructure as code, implement [DevSecOps best practices and controls](/security/zero-trust/develop/secure-devops-environments-zero-trust) in your pipelines. Integrate security early in your CI/CD journey to prevent costly security breaches later on. Create a strategy to implement static code analysis, unit testing, secret scanning, and package/dependency scanning in your pipelines.

Enterprise security tools such as [Microsoft Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction) can integrate with DevOps tools. For example, Defender for Cloud can [identify vulnerable container images in your CI/CD workflows](/azure/defender-for-cloud/defender-for-container-registries-cicd). For GitHub Actions and repositories, use [GitHub Advanced Security](https://docs.github.com/get-started/learning-about-github/about-github-advanced-security) for code and secret scanning and dependency review.

Periodically review audit events to monitor and react to unexpected usage patterns by administrators and other users. You can [access, filter, and export audit logs](/azure/devops/organizations/audit/azure-devops-auditing) for your Azure DevOps organization. For long-term storage and detailed log querying, [create an audit stream](/azure/devops/organizations/audit/auditing-streaming) to an [Azure Monitor Log Analytics](/azure/azure-monitor/logs/log-analytics-overview) workspace, or to a security information and event management (SIEM) system like [Microsoft Sentinel](/azure/sentinel/overview).
