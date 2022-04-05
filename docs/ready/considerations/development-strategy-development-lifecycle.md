---
title: Development lifecycle
description: Design area guidance for DevOps principles and practices in Azure Landing Zones
author: emguzman13
ms.author: emguzman
ms.date: 03/22/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Development lifecycle

Development lifecycle strategy explores key design considerations and recommendations surrounding the repository, branch, automated builds, deployment, and rollback strategy during the creation of the landing zone via automation. 

## Repository strategy 

**Design considerations**

- Adopting a version control system such as Git provides flexibility in how your team shares and manages code. 

- [Repository structure](/learn/modules/structure-your-git-repo/) mono-repo vs multi-repo.
  - With mono-repo all source code is kept in a single repository. 
  - multi-repo is organizing your projects each into their separate repository.  

- Choose a visibility setting that suits the content of your repository.
  - Private repositories require users to be granted access to the repo and signed in to access the services. 
  - Public repositories can be accessed anonymously.
  - Public and private visibility can be set for [Azure DevOps projects](/azure/devops/organizations/public/make-project-public?view=azure-devops) and [GitHub repos](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/managing-repository-settings/setting-repository-visibility). 

- Consider setting repository permissions to lock down who can contribute to your source code and manage other features. 
  - Repository permissions can be set for [Azure Devops](/azure/devops/repos/git/set-git-repository-permissions?view=azure-devops) and [GitHub](https://docs.github.com/organizations/managing-access-to-your-organizations-repositories/repository-roles-for-an-organization)  

- Consider using [Infrastructure as Code](/azure/architecture/framework/devops/automation-infrastructure) for deploying resources to Azure. Infrastructure as Code is the management of infrastructure in a declarative model and it is useful to reduce configuration effort, ensure consistency between deployments and avoid manual configuration of environments.

- Azure provides support for Infrastructure as Code for Landing Zone via: 
  - [Bicep](https://github.com/Azure/ALZ-Bicep) 
  - [Terraform](https://github.com/azure/caf-terraform-landingzones)

**Design recommendations**

- Use Git as a version control system. 
  [Git](/azure/devops/repos/git/?view=azure-devops) is the industry-standard version control system. It is a distributed version control system, where your local copy of the code is a complete version of the repository.

- Use private repositories when building Azure Landing Zone, as users require to be granted access to the repo, control over who can see and managed Azure Landing Zone´s code is configured.  

- Use public repositories when sharing non-confidential information such as automation examples, public documentation, open-source collaboration repositories. 

- Adopt an Infrastructure as Code approach to deploy, manage, govern and support resources in the clouds.

## Branch strategy

**Design considerations**

- Consider a [branch strategy](https://docs.microsoft.com/azure/devops/repos/git/git-branching-guidance?view=azure-devops) that allows teams to collaborate better and avoids spending time managing version control. 

- A [naming convention](https://docs.microsoft.com/azure/devops/repos/git/git-branching-guidance?view=azure-devops#name-your-feature-branches-by-convention) should be considered. 
  
- Consider [branch permissions](https://docs.microsoft.com/azure/devops/repos/git/branch-permissions?view=azure-devops) to control user´s capabilities.

- Consider branch policies to help teams protect their important branches of development. Policies enforce your team´s code quality and change management standards: 
  - Use pull requests to merge changes into important branches. 
  - [Require a minimum number of reviewers](https://docs.microsoft.com/azure/devops/repos/git/branch-policies?view=azure-devops&tabs=browser#require-a-minimum-number-of-reviewers) for pull request.
  - [Automatically include code reviewers](https://docs.microsoft.com/azure/devops/repos/git/branch-policies?view=azure-devops&tabs=browser#automatically-include-code-reviewers)
  - [Check for linked work items](https://docs.microsoft.com/azure/devops/repos/git/branch-policies?view=azure-devops&tabs=browser#check-for-linked-work-items) allows you to keep traceability. 
  - [Check for comment resolution](https://docs.microsoft.com/azure/devops/repos/git/branch-policies?view=azure-devops&tabs=browser#check-for-comment-resolution) validates whether all PR comments are resolved. 
  - [Limit merge types](https://docs.microsoft.com/azure/devops/repos/git/branch-policies?view=azure-devops&tabs=browser#limit-merge-types). 

- Adopting a pull request strategy helps to keep control of the code changes merged into branches. 
  - Define a [merge strategy](https://docs.microsoft.com/azure/devops/repos/git/merging-with-squash?view=azure-devops).
  - Pull request should be simple, meaning that the number of files should be minimum. This will help the reviewer to validate commits and changes.
  - Pull request must have good title and description to help reviewers know what to except when reviewing code.
  - Consider using [pull request templates](https://docs.microsoft.com/azure/devops/repos/git/pull-request-templates?view=azure-devops).
  - Consider deleting origin branch after pull request is complete. This will help to keep control and have better management of the branches.   

**Design recommendations**

- Adopt a [trunk-based development model](https://trunkbaseddevelopment.com/). In this model, developers commit to a single branch. This model facilitates continuous integration, because all feature work is done in the trunk, and any merge conflicts are resolved when the commit happens. 

- Each team should define and use a consistent naming convention for the branches to identify the work done. 

- Set permissions to control who can read and update the code in a branch on your Git repository. Permissions can be set for individual users and groups.

- Set branch policies:
  - Merge branches into the main branch must be done using pull request. 
  - Require a minimum number of reviewers for pull request. 
  - Reset all approval votes to remove all approval votes, but keep votes to reject or wait, whenever the source branch changes. 
  - Automatically include code reviewers. 
  - Check for comment resolution. 

- Set squach as merge strategy, as allows you to condense the Git history of topic branches when you compleate a pull request. Instead of each commit on the topic branch being added to the history of the default branch, a squach merge adds all the files changes to a single new commit on the default branch. 

## Automated builds

**Design considerations**

- Consider implementing [Continuous Integration (CI)](https://docs.microsoft.com/devops/develop/what-is-continuous-integration#:~:text=Continuous%20Integration%20(CI)%20is%20the,after%20every%20small%20task%20completion). CI is the practice of merging all developer code into a central codebase on a regular schedule, and then automatically perform standard builds and test processes. 

- Consider using of CI triggers:  
  - [Azure Repos Git.](https://docs.microsoft.com/azure/devops/pipelines/repos/azure-repos-git?view=azure-devops#ci-triggers) Triggers such as branches, path and tags can be configured as triggers to run a CI build.
  - [GitHub.]( https://docs.microsoft.com/azure/devops/pipelines/repos/github?view=azure-devops#ci-triggers) Triggers such as branches, path and tags can be configured as triggers to run a CI build.

- Consider including Infrastructure as Code unit test in the build process to validate syntax. 
  - [ARM Templates test toolkit](https://docs.microsoft.com/azure/azure-resource-manager/templates/test-toolkit) checks whether the template uses recommended practices. 
  - [Bicep linter](https://docs.microsoft.com/azure/azure-resource-manager/bicep/linter) checks Bicep files for syntax errors and best practice violations.  

- Consider including unit test in the application build process. Review the tasks available for [Azure DevOps Pipeline](https://docs.microsoft.com/azure/devops/pipelines/tasks/?view=azure-devops#test) for testing purposes. 

- Manage connection to Azure by using Azure DevOps service connections or GitHub secrets. Connections should have the right privilige access to azure resources.

- Consider using [Azure Key Vault secrets](https://docs.microsoft.com/azure/devops/pipelines/release/key-vault-in-own-project?view=azure-devops&tabs=portal) to store and manage sensitive information such as passwords, API keys, cretificates, etc.

- [Azure DevOps agents](https://docs.microsoft.com/azure/devops/pipelines/agents/agents?view=azure-devops&tabs=browser ) self-hosted vs Microsoft-hosted 
  - With Microsoft-hosted agents, maintenance and upgrades are taken care of for you. Every time a build job is run a fresh virtual machine is created.
  - Self-hosted agents are set up and managed on your own to run build jobs. 

**Design recommendations**

- Use CI to automate builds and testing of code every time a team member commits changes to version control.   

- Include unit tests for Infrastructure as Code and application code as part of the build process. 

- Microsoft-hosted pools offer isolation and a clean VM for each run of a pipeline. If possible, use Microsoft-hosted pool rather than self-hosted pools. 

- When connecting Azure DevOps or GitHub to Azure via service connections or GitHub secrets make sure to define the scope, so it can access only the resources that they require. 

- Use Key Vault secrets to avoid hard-coding sensitive information such as credentials (virtual machine´s user passwords), certificates or keys. Then use secrets as variables in build and release jobs. 


## Deployment strategy

**Design considerations**

- Consider using [Continuous Delivery (CD)](https://docs.microsoft.com/devops/deliver/what-is-continuous-delivery). CD is the process to build, test, configure, and deploy from a build to an environment. 

- Consider using [environments](../considerations/environments.md). Environments allows you to target a collection of resources from a delivery job. Typical examples of environment names are Dev, Test, QA, Staging and Production. 

- Consider including Infrastructure as Code pre-deployment as part of the strategy to validate and confirm changes before a deployment. 
  - [ARM Templates what-if](https://docs.microsoft.com/azure/azure-resource-manager/templates/deploy-what-if?tabs=azure-powershell ) 
  - [Bicep what-if](https://docs.microsoft.com/azure/azure-resource-manager/bicep/deploy-what-if?tabs=azure-powershell%2cCLI)
  - [Terraform plan](https://www.terraform.io/cli/commands/plan)

**Design recommendations**

- Use CD to ensure that code is always ready to deploy, by automatically building, testing, and deploying code to production-like environments. Adding continuous delivery to create a full CI/CD integration will help you detect code defects as soon as possible. It also ensures that properly tested updates can be released in a short time. 

- Use environments as part of the deployment strategy. Environments allows you to have benefits such as: deployment history, traceability of commits and work items, diagnostic resource health, security. 

- Include Infrastructure as Code pre-deployment checks, so you can preview the changes that will happen. The pre-deployment checks will provide details whether a resource has been created, modified, or deleted. 

## Rollback strategy

**Design considerations**

- Consider creating a rollback plan. Rollback a deployment involves reverting the deployment to a known good state, the ability to recover from a failed deployment is crucial. 

- Consider the use of [Undo changes](https://docs.microsoft.com/azure/devops/repos/git/undo?view=azure-devops&tabs=visual-studio) in Git when you need to revert changes in a commit, discart changes or reset a branch to a previous state. 

- Consider using rollback a failed deployment by redeploying an earlier deployment when using [ARM Templates](https://docs.microsoft.com/azure/azure-resource-manager/templates/rollback-on-error). 

**Design recommendations**

- Adopt the use of undo changes in Git when looking to revert changes to committed files, discart uncommitted changes or reset a brach to a previous state. 




