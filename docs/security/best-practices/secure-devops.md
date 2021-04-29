---
title: Secure DevOps
description: DESCRIPTION
author: julie-ng
ms.author: julng
ms.date: 04/21/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: secure
ms.custom: internal
---

## Securing the Pipeline and CI/CD Workflow

Automation and the agile methodology enables teams to deliver faster but also adds complexity to security because the workflow is extended to the developer teams themselves.

The following diagram illustrates a baseline CI/CD workflow. The red configuration icon <img src="./../media/devsecops-iconmonstr-gear-10.svg" valign="middle" alt="configuration cog icon"> indicates security permissions which must be configured by the customer. This follows the [Shared Responsibility Model](https://docs.microsoft.com/azure/security/fundamentals/shared-responsibility) where Azure and other vendors provide permissions, which must be configured by the customer according to their governance model and business requirements.

<img src="./../media/devsecops-workflow.svg" alt="A Typical CI/CD Workflow">

_**Figure 1 - a typical CI/CD workflow illustrating how code changes in a git repository will affect your cloud resources**_

Let's examine each stage of this typical workflow to help you understand how the configurations often depend on one another. Your workflow may have more stages. The concepts below will help you understand CI/CD and help you design your workflow for security.

### Stage 1 - Git Workflow

Code changes, not just to software but also to Pipeline as Code and [Infrastructure as Code](https://docs.microsoft.com/azure/devops/learn/what-is-infrastructure-as-code) are saved and managed in git, which is a distributed source code management software. When code is pushed from local computers to the centralized git server, business rules can be applied before it is accepted.

#### Pull Requests and Collaboration

The industry standard workflow, regardless of your SCM Software as a Service (SaaS) vendor is to leverage [Pull Requests](https://docs.microsoft.com/azure/devops/repos/git/pull-requests?view=azure-devops) (1A), which can act both as an automated quality gatekeeper as well as a manual approval step before source code is accepted.

The Pull Request workflow is designed to introduce healthy friction, which is why it should only be applied to secure _specific git branches_ - especially those that will trigger automated workflows that can deploy, configure or in any other way affect your cloud resources. These branches are called Protected Branches (1B) and typically follow naming contents like `production`, `releases/*`, etc.

It is common for Pull Requests to require:

- Peer reviews
- Passing continuous integration (CI) builds
- Manual approval

If the requirements are met, the code changes are accepted and can be merged.

#### Restrict Access to Protected Branches

The Pull Request workflow is used together with restricted access controls. In addition to offering the Pull Request workflow, it cannot be enforced unless the server is configured to reject direct changes to protected branches.

In this way a developer cannot push directly to the `production` branch but instead must create a Pull Request that targets the protected branch. Each SCM vendor will have different flavors for achieving this. Please note that for GitHub this feature is only [available](https://docs.github.com/en/github/administering-a-repository/about-protected-branches#restrict-who-can-push-to-matching-branches) for organization using GitHub Team or GitHub Enterprise Cloud.

#### Document your Git Access Model

Because the collaboration model is so complex and has many moving parts, it is helpful to create a table with an overview of all possible ways code changes can trigger deployments, for example:

| Branch Name | Requires PR? | Deploys? | Developer Access | Admin Access |
|:--|:--|:--|--:|--:|
| `feat/*` | No | No | R/W | R/W |
| `main` | Yes | Staging | R | R/W |
| `production` | Yes, from `main` only | Production | R | R/W |

_**Table 1 - simplified example table documenting git and deployment triggers**_

The table above is grossly oversimplified example to illustrate its purpose. In practice there are often be more actors, more deployment targets, as well as multiple pipelines that run for different use cases. Your table structure will different depending on your organization's and the workload's requirements.

Regardless of the structure, your table should help you answer these types of questions:

- If a developer pushes code changes to branch X, will it deploy? If so, to which environment?
- At what point in the application code lifecycle is vulnerability scanning performed?
- If a security vulnerability is found, how many code pushes and approvals are required before it lands in production?
- and more.

This table is not only useful for debugging or static documentation, but also for team collaboration. It makes transparent to developers where healthy friction has been introduced into the workflow to prioritize code quality and security. More importantly it shows the developer the expected path for code changes to reach production.

As DevOps is a journey this table is not static and will change and evolve as the teams find their own rhythms and mature. Therefore this type of documentation should be stored as close as possible to the code, i.e. in the git repositories themselves.

#### Further Reading

- [Azure Repos - Set branch permissions](https://docs.microsoft.com/azure/devops/repos/git/branch-permissions?view=azure-devops)
- [Azure Repos - Create, view, and manage pull requests](https://docs.microsoft.com/azure/devops/repos/git/pull-requests?view=azure-devops)
- [Azure Repos - Improve code quality with branch policies](https://docs.microsoft.com/azure/devops/repos/git/branch-policies?view=azure-devops)
- [GitHub - About Pull Requests](https://docs.github.com/en/github/collaborating-with-issues-and-pull-requests/about-pull-requests)
- [GitHub - About Protected Branches](https://docs.github.com/en/github/administering-a-repository/about-protected-branches)


### Stage 2 - Pipelines as Code

The Pipeline as Code movement accelerated automation adoption and deployments by moving pipeline definitions and configurations from the CI vendor to the developers, brining the build and deployment logic closer to the corresponding application logic. This greater flexibility here also comes with greater responsibility.

RBAC controls in a UI driven pipeline can prevent individual users from making destructive changes. Pipelines as Code, however often run with privileged identities and will happily destroy your workloads if instructed to do so.

How to avoid this is described in the next stage.

### Stage 3 - Securing Your Deployment Credentials 

Pipelines and code repositories should not include hard-coded credentials and secrets, which instead should be stored elsewhere and leverage CI vendor features for security. Because Pipelines run as headless agents, they should never use an individual's password. Instead pipelines should run using headless security principals, e.g. [Service Principals](https://docs.microsoft.com/azure/active-directory/develop/app-objects-and-service-principals) or [Managed Identities](https://docs.microsoft.com/azure/active-directory/managed-identities-azure-resources/overview). Access to this security principal's credentials as well as database Connection Strings, third-party API keys, etc. should also be securely managed in the CI platform.

_How_ a credential is secured as well as gates and approvals are vendor specific features. When choosing a CI platform, make sure it supports all the features you require.

Azure Pipelines is an enterprise scale CI solution where credentials are stored as [Service Connections](https://docs.microsoft.com/azure/devops/pipelines/library/service-endpoints?view=azure-devops&tabs=yaml), upon which you can [configure approvals and checks](https://docs.microsoft.com/azure/devops/pipelines/process/approvals?view=azure-devops&tabs=check-pass) including manual approval and specific branch or pipeline authorizations. (TODO: link to other Azure Docs? WAF? CAF? for details)

#### Leverage Azure Key Vault 

If your CI platform supports it, consider storing credentials in a dedicated secret store, for example [Azure Key Vault](https://azure.microsoft.com/services/key-vault/). In this way credentials are fetched at runtime by the build agent and your attack surface is reduced.

#### Further Reading

- [Azure Docs - What is Azure role-based access control (Azure RBAC)?](https://docs.microsoft.com/azure/role-based-access-control/overview)
- [Azure DevOps Docs - Service connections](https://docs.microsoft.com/azure/devops/pipelines/library/service-endpoints?view=azure-devops&tabs=yaml)


### Phase 4 - Securing Your Azure Resources

Your Azure Resources should be secured according to Principle of Least Privilege, applied to both permissions and scope. For details, see also [Azure Docs - Best practices for Azure RBAC](https://docs.microsoft.com/azure/role-based-access-control/best-practices).

#### Create Custom Roles for Build Agents

CI/CD Automation applies not just to applications but also to infrastructure. Infrastructure as Code (IaC) templates ensure consistent deployments and help central cloud platform teams scale.

That being said it is important to understand that IaC automation can go wrong. It can also misconfigure and in worst case scenarios permanently delete infrastructure. When planning your cloud journey, identify in advance which operations are business critical and require human intervention. 

Take for example, [cannot-delete management locks](https://docs.microsoft.com/azure/azure-resource-manager/management/lock-resources), which may be applied to business critical resources like a data. To prevent this from happening, we may *remove* `Microsoft.Authorization/*/Delete` permissions from a service principal used in CI automation. In this example and use-case, the service principal would be allowed to *create* the management lock, but not delete it.

For these reasons it is recommended to [create a custom role](https://docs.microsoft.com/azure/role-based-access-control/custom-roles) for your CI agents. Remember, a build agents run headless. And headless agents are well, _brainless_. Choose your permissions carefully.

For further references, see:

- [Azure AD built-in roles](https://docs.microsoft.com/azure/active-directory/roles/permissions-reference)
- [Azure resource provider operations](https://docs.microsoft.com/azure/role-based-access-control/resource-provider-operations)

---

## Further Reading (include or not?)

- [Cloud Adoption Framework - Ready - Platform automation and DevOps](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/enterprise-scale/platform-automation-and-devops)
- [Azure DevOps Docs - Pipelines Security Walkthrough](https://docs.microsoft.com/azure/devops/pipelines/security/overview?view=azure-devops)  
  For more about the features used to secure pipelines, including [security through templates](https://docs.microsoft.com/azure/devops/pipelines/security/templates?view=azure-devops), which is not covered in this document.
- [Azure Architecture Center - DevSecOps in GitHub](https://docs.microsoft.com/en-us/azure/architecture/solution-ideas/articles/devsecops-in-github)


