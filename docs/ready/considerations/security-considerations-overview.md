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

Make security a priority when you use cloud-based development platforms such as [Azure DevOps](/azure/devops/user-guide/what-is-azure-devops) and [GitHub](https://github.com/). Microsoft secures and maintains the underlying cloud infrastructure. You must review and configure security best practices for your Azure DevOps organizations and GitHub instances.

Review the following critical security areas. Apply them when you deploy environments through infrastructure as code (IaC) in continuous integration and continuous deployment (CI/CD) pipelines. Also apply them when you deploy application code to Azure.

## Restrict access to DevOps tooling

Follow the principle of least privilege. Use role-based access control (RBAC) through [Microsoft Entra ID](/entra/fundamentals/whatis), Microsoft’s cloud identity service.  
Give users and services only the access they need to perform their job functions.  
For more information, see the following articles:

- [Connect your organization to Microsoft Entra ID](/azure/devops/organizations/accounts/connect-organization-to-azure-ad)
- [Microsoft Entra single sign-on (SSO) integration with GitHub Enterprise Cloud](/entra/identity/saas-apps/github-enterprise-cloud-enterprise-account-tutorial)
- [Azure DevOps security best practices](/azure/devops/organizations/security/security-best-practices)

After you establish Microsoft Entra ID as your identity management plane, manage Azure DevOps role assignments by using [Microsoft Entra group memberships](../../secure/govern.md). You can [assign Azure DevOps roles to Microsoft Entra groups](../../secure/govern.md). Change or remove access by updating a user’s Microsoft Entra group membership.

- Use Microsoft Entra ID [entitlement management](/entra/id-governance/entitlement-management-overview) to create access packages that allow Microsoft Entra users time-bound access to required resources to complete their tasks.

- You can also use Microsoft Entra [Privileged Identity Management](/entra/id-governance/privileged-identity-management/pim-configure#what-can-i-do-with-it) for just-in-time access to promote individuals to Azure DevOps Administrator roles for a period of time.

Manage Azure DevOps security by using security groups, policies, and settings at the organization, project, or object level. Consider disabling permission inheritance in Azure DevOps if possible.

## Restrict repository and branch access

Restrict repository access, permissions, and branch creation. These controls protect your code and environments from malicious or unwanted changes. [Restrict access to repositories](/azure/devops/repos/git/set-git-repository-permissions?toc=/azure/devops/organizations/security/toc.json&bc=/azure/devops/organizations/security/breadcrumb/toc.json) by using security groups in Azure DevOps. Limit who can read and update code in your branches by setting [branch permissions](/azure/devops/repos/git/branch-permissions?toc=/azure/devops/organizations/security/toc.json&bc=/azure/devops/organizations/security/breadcrumb/toc.json).

## Restrict pipeline access and permissions

Malicious code can steal enterprise data and secrets. It can also corrupt production environments.  
Implement guardrails in your pipelines to prevent malicious deployments. Restrict access to limit lateral movement across projects, pipelines, and repositories if a pipeline is compromised.

Consider following an incremental approach to securing your YAML pipelines. For more information, see [Plan how to secure your YAML pipelines](/azure/devops/pipelines/security/approach).

## Select the DevOps agent based on security needs

You can use Microsoft-hosted agents or self-hosted agents to run Azure DevOps and GitHub pipelines. An agent is the compute that executes pipeline jobs. There are trade-offs for each type of agent.

Microsoft-hosted agents handle upgrades and maintenance for you.  
Self-hosted agents give you more flexibility to implement security guardrails. You control the agent hardware, operating system, and installed tools. Self-hosted agents can also provide private networking access to resources behind firewalls or virtual networks.

See [Azure Pipelines agents](/azure/devops/pipelines/agents/agents) to review the differences between the types of agents and identify potential security considerations.

## Use secure and scoped service identities

Use secure, scoped identities to deploy code and infrastructure to Azure from GitHub, Azure DevOps, or third-party CI/CD platforms.

- User-assigned managed identities or application registrations (service principals) in Entra ID can be used. Never use a user account.
- Implement [OpenID Connect (workload identity federation)](/azure/active-directory/develop/workload-identity-federation) authentication with federated credentials for the identity. Never use client secrets or certificates.
- Create a separate identity for each application and environment you deploy to, ensuring granular permissions can be applied.
- Create a separate identity per application and environment for read-only operations, such as Terraform plan or Bicep what-if.
- Scope the identity permissions to only the Azure subscription or resource groups required for deployment. Use the principle of least privilege to assign only the necessary roles to the identity.
- Deploy your identities and federated credentials through infrastructure as code (IaC) in a secure subscription vending process. For more information, see [Automate subscription deployment and configuration](/azure/cloud-adoption-framework/ready/landing-zone/design-area/subscription-vending).

Azure Resource Manager manages user-assigned managed identities. Application registrations (service principals) are managed by Entra ID. User-assigned managed identities more easily integrate with your subscription vending process, ensuring they're decommissioned along with your other resources when no longer needed.

When you use self-hosted agents on Azure compute, you can use system-assigned or user-assigned managed identities directly on the agent. Although this approach can be secure, it's recommended to use OpenID Connect (workload identity federation) with either user-assigned managed identities or application registrations (service principals) for greater flexibility and control. When you use a compute-attached managed identity, if you attach multiple user-assigned managed identities to the agent, anything running on the agent has access to all of them. It's usually cost prohibitive to have separate agents per application and environment to ensure least privilege access.

### Azure DevOps identities

Always use a [service connection](/azure/devops/pipelines/library/service-endpoints) with OpenID Connect (workload identity federation) to deploy infrastructure or application code in an Azure environment. A service connection is a wrapper for the identity in Azure.

- Create a separate service connection and identity for each application and environment you deploy to, ensuring granular permissions can be applied.
- Create [approvals](/azure/devops/pipelines/process/approvals#approvals) on the service connection. Don't create them on environments, as that can be bypassed in code.
- Create [required templates](/azure/devops/pipelines/process/approvals#required-template) (also known as governed pipelines) on the service connection to ensure that malicious code can't be injected without approval.
- Ensure your identity federated credentials are scoped to the service connection only.
- Deploy your service connections through infrastructure as code (IaC) in a secure subscription vending process. For more information, see [Automate subscription deployment and configuration](/azure/cloud-adoption-framework/ready/landing-zone/design-area/subscription-vending).

Example code and pipelines can be found in the [Azure DevOps Workload Identity Federation](/samples/azure-samples/azure-devops-terraform-oidc-ci-cd/azure-devops-terraform-oidc-ci-cd/) code sample.

### GitHub Actions identities

Always use the built-in Actions or environment variables with OpenID Connect (workload identity federation) to deploy infrastructure or application code in an Azure environment.

- Create an identity for each application and environment you deploy to, ensuring granular permissions can be applied.
- Create approvals on a GitHub Actions environment.
- Update your [subject claims](https://docs.github.com/actions/reference/security/oidc#customizing-the-token-claims) to include the `environment` claim to ensure your identity can only be used in the scope of the specified environment. This ensures your approvals cannot be bypassed. Add this claim to your identity federated credential.
- Update your [subject claims](https://docs.github.com/actions/reference/security/oidc#customizing-the-token-claims) to include the `job_workflow_ref` (also known as governed pipelines) claim to ensure your identity can only be used in the scope of the specified workflow. Add this claim to your identity federated credential.
- Update your [subject claims](https://docs.github.com/actions/reference/security/oidc#customizing-the-token-claims) to remove `repository` and use `repository_owner_id` and `repository_id` instead to ensure your identity can only be used in the scope of the specified repository even if it's renamed. Add this claim to your identity federated credential.
- Update your subject claims through infrastructure as code (IaC) in a secure subscription vending process. For more information, see [Automate subscription deployment and configuration](/azure/cloud-adoption-framework/ready/landing-zone/design-area/subscription-vending).

Example code and workflows can be found in the [GitHub Actions Workload Identity Federation](/samples/azure-samples/github-terraform-oidc-ci-cd/github-terraform-oidc-ci-cd/) code sample.

## Use a secret store

Avoid secrets whenever possible. Prefer OpenID Connect (workload identity federation) or managed identities.

If you must use a secret, never hard-code it in source code or documentation stored in your repositories. Adversaries scan repositories, searching for exposed confidential data to exploit. Set up a secret store such as [Azure Key Vault](/azure/key-vault/general/basic-concepts), and reference the store in Azure Pipelines to securely retrieve keys, secrets, or certificates. For more information, see [Secure the pipeline and CI/CD workflow](/security/zero-trust/develop/secure-devops-environments-zero-trust). You can also [use Key Vault secrets in GitHub Actions workflows](/azure/developer/github/github-key-vault).

## Use hardened DevOps workstations to build and deploy code

Platform and development teams often hold elevated privileges on Azure and services such as Azure DevOps and GitHub. This access greatly increases the potential attack surface. Implement guardrails to secure any endpoints and workstations you use to develop and deploy code.

Use hardened [secure admin workstations (SAWs)](https://techcommunity.microsoft.com/blog/coreinfrastructureandsecurityblog/secure-administrative-workstations/258424) to deploy any changes to high-risk and production environments. For more information, see [Secure endpoints with Zero Trust](/security/zero-trust/deploy/endpoints).

## Do security scanning and testing

Implement [DevSecOps best practices and controls](/security/zero-trust/develop/secure-devops-environments-zero-trust) in your pipelines. Apply them to application code and infrastructure as code. Integrate security early in your CI/CD journey to prevent costly security breaches later on. Create a strategy to implement static code analysis, unit testing, secret scanning, and package or dependency scanning in your pipelines.

Enterprise security tools such as [Microsoft Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction) can integrate with DevOps tools. For example, Defender for Cloud can [identify vulnerable container images in your CI/CD workflows](/azure/defender-for-cloud/defender-for-container-registries-cicd). For GitHub Actions and repositories, use [GitHub Advanced Security](https://docs.github.com/get-started/learning-about-github/about-github-advanced-security) for code and secret scanning and dependency review.

Periodically review audit events to monitor and react to unexpected usage patterns by administrators and other users. You can [access, filter, and export audit logs](/azure/devops/organizations/audit/azure-devops-auditing) for your Azure DevOps organization. For long-term storage and advanced queries, create an audit stream. Send it to an [Azure Monitor Log Analytics](/azure/azure-monitor/logs/log-analytics-overview) workspace or to a security information and event management (SIEM) system, such as [Microsoft Sentinel](/azure/sentinel/overview).