---
title: Secure DevOps
description: Learn how to secure DevOps, the pipeline, and CI/CD workflow.
author: julie-ng
ms.author: julng
ms.date: 04/21/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: secure
ms.custom: internal
---

# Secure the pipeline and CI/CD workflow

Automation and the agile methodology enables teams to deliver faster, but also adds complexity to security because the workflow extends to the developer teams themselves.

The following diagram illustrates a baseline CI/CD workflow. The red configuration icon :::image type="icon" source="../media/devsecops-iconmonstr-gear-10.svg"::: indicates security permissions which must be configured by the customer. This follows the [shared responsibility model](/azure/security/fundamentals/shared-responsibility), where Azure and other vendors provide permissions, which must be configured by the customer according to their governance model and business requirements.

![A typical CI/CD workflow that illustrates how code changes in a Git repository will affect your cloud resources](../media/devsecops-workflow.svg)

Let's examine each stage of this typical workflow to help you understand how the configurations often depend on one another. Your workflow might have more stages. The following concepts will help you understand CI/CD and help you design your workflow for security.

## Stage 1: Git workflow

Code changes, not just to software, but also to *pipeline as code* and [infrastructure as code](/devops/deliver/what-is-infrastructure-as-code), are saved and managed in Git. Git is a distributed source code management software. When code is pushed from local computers to the centralized Git server, business rules can be applied before it's accepted.

### Pull requests and collaboration

The industry standard workflow, regardless of your software configuration management (SCM) software as a service (SaaS) vendor, is to use [pull requests](/azure/devops/repos/git/pull-requests), which can act both as an automated quality gatekeeper and a manual approval step before source code is accepted.

The pull request workflow is designed to introduce healthy friction, which is why it should only be applied to secure **specific Git branches**. Especially the branches that will trigger automated workflows that can deploy, configure, or in any other way affect your cloud resources. These branches are called protected branches and typically follow naming conventions such as `production` or `releases/*`.

It's common for pull requests to require:

- Peer reviews
- Passing continuous integration (CI) builds
- Manual approval

If the requirements are met, the code changes are accepted and can be merged.

### Restrict access to protected branches

The pull request workflow is used together with restricted access controls. The pull request workflow can't be enforced however, unless the server is configured to reject direct changes to protected branches.

A developer can't push directly to the `production` branch, but instead must create a pull request that targets the protected branch. Each SCM vendor has a different flavor for achieving restricted access to protected branches. For example, with GitHub this feature is only [available](https://docs.github.com/en/github/administering-a-repository/defining-the-mergeability-of-pull-requests/about-protected-branches#restrict-who-can-push-to-matching-branches) for organizations using GitHub team or GitHub Enterprise cloud.

### Document your Git access model

Because the collaboration model is complex and has many moving parts, it's helpful to create a table that documents all possible ways code changes can trigger deployments for example:

| Branch name | Requires PR? | Deploys? | Developer access | Admin access |
|:--|:--|:--|--:|--:|
| `feat/*` | No | No | Read/write | Read/write |
| `main` | Yes | Staging | Read | Read/write |
| `production` | Yes, from `main` only | Production | Read | Read/write |

This Git access table example is oversimplified to illustrate its purpose. In practice, there are often more actors, more deployment targets, and multiple pipelines that run for different use cases. Your table structure might be different depending on the requirements of your organization and your workloads.

The table should help you answer questions such as:

- If a developer pushes code changes to branch X, will it deploy? If so, to which environment?
- At what point in the application code lifecycle is a vulnerability scan done?
- If a security vulnerability is found, how many code pushes and approvals are required before it lands in production?

Not only is this table useful for debugging and static documentation, but also for team collaboration. It's transparent to developers where healthy friction has been introduced into the workflow to prioritize code quality and security. More importantly, it shows the developer the expected path for code changes to reach production.

Because DevOps is a journey, your Git access model isn't static. It will change and evolve as the teams find their own rhythms and mature. That's why it's important to store this documentation as close as possible to the code, for example, in the Git repositories.

To learn more about pull requests and protected branches, see:

- [Set branch permissions](/azure/devops/repos/git/branch-permissions)
- [Create, view, and manage pull requests](/azure/devops/repos/git/pull-requests)
- [Improve code quality with branch policies](/azure/devops/repos/git/branch-policies)
- [About pull requests](https://docs.github.com/en/github/collaborating-with-issues-and-pull-requests/proposing-changes-to-your-work-with-pull-requests/about-pull-requests)
- [About protected branches](https://docs.github.com/en/github/administering-a-repository/defining-the-mergeability-of-pull-requests/about-protected-branches)

## Stage 2: Pipelines as code

The pipeline-as-code movement accelerated automation adoption and deployments by moving pipeline definitions and configurations from the CI vendor to the developers, bringing the build and deployment logic closer to the corresponding application logic. The greater flexibility here also comes with greater responsibility.

RBAC controls in a UI-driven pipeline can prevent individual users from making destructive changes. Pipelines as code, however, often run with privileged identities and can destroy your workloads if instructed to do so.

## Stage 3: Secure your deployment credentials

Pipelines and code repositories should not include hard-coded credentials and secrets. Credentials and secrets should be stored elsewhere and use CI vendor features for security. Because pipelines run as headless agents, they should never use an individual's password. Pipelines should run using headless security principals instead, such as [service principals](/azure/active-directory/develop/app-objects-and-service-principals) or [managed identities](/azure/active-directory/managed-identities-azure-resources/overview). Access to this security principal's credentials, database connection strings, and third-party API keys should also be securely managed in the CI platform.

**How** a credential is secured, gates, and approvals are vendor-specific features. When choosing a CI platform, make sure it supports all the features you require.

Azure Pipelines is an enterprise-scale continuous integration solution where credentials are stored as [service connections](/azure/devops/pipelines/library/service-endpoints?tabs=yaml), upon which you can [configure approvals and checks](/azure/devops/pipelines/process/approvals?tabs=check-pass). This configuration includes manual approval and specific branch or pipeline authorizations.

### Azure Key Vault

If your CI platform supports it, consider storing credentials in a dedicated secret store, for example [Azure Key Vault](https://azure.microsoft.com/services/key-vault/). Credentials are fetched at runtime by the build agent and your attack surface is reduced.

## Stage 4: Securing your Azure resources

Your Azure resources should be secured according to the principle of least privilege, applied to both permissions and scope.

For more information, see:

- [Best practices for Azure RBAC](/azure/role-based-access-control/best-practices)

- [What is Azure role-based access control (Azure RBAC)?](/azure/role-based-access-control/overview)

### Create custom roles for build agents

CI/CD automation applies not just to applications, but also to infrastructure. Infrastructure as code (IaC) templates ensure consistent deployments and help centralized cloud platform teams scale.

It's important to understand that IaC automation can go wrong. It can misconfigure, and in worst case scenarios, permanently delete infrastructure. When you plan your cloud journey, identify in advance which operations are business critical and require human intervention.

For example, [cannot-delete management locks](/azure/azure-resource-manager/management/lock-resources), might be applied to business critical resources like a data. To prevent this from happening, you might *remove* `Microsoft.Authorization/*/Delete` permissions from a service principal used in CI automation. In this example and use-case, the service principal can *create* the management lock, but not delete it.

It's recommended to [create a custom role](/azure/role-based-access-control/custom-roles) for your CI agents. Remember, build agents run headless, and headless agents are brainless. Choose your permissions carefully.

To learn more, see:

- [Azure AD built-in roles](/azure/active-directory/roles/permissions-reference)
- [Azure resource provider operations](/azure/role-based-access-control/resource-provider-operations)

## Resources

- [Platform automation and DevOps](../../ready/enterprise-scale/platform-automation-and-devops.md)
- [Pipelines security walkthrough](/azure/devops/pipelines/security/overview)
- [Security via templates](/azure/devops/pipelines/security/templates)
- [DevSecOps in GitHub](/azure/architecture/solution-ideas/articles/devsecops-in-github)

## Next steps

Now that you understand how to secure DevOps, learn more about end-to-end governance from DevOps to Azure.

> [!div class="nextstepaction"]
> [End-to-end governance from DevOps to Azure](./end-to-end-governance.md)
