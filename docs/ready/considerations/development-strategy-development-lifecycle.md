---
title: Development lifecycle
description: Design area guidance for DevOps principles and practices in Azure Landing Zones
author: emguzman13
ms.author: emguzman
ms.date: 06/18/2022
ms.topic: conceptual
ms.subservice: ready
ms.custom: internal
---

# Development lifecycle

Development lifecycle strategy provides key design considerations and recommendations for repository, branch, automated builds, deployment, and rollback strategy during automatic landing zone creation.

## Repository strategy

### Design considerations

- Consider adopting a version control system like Git to provide your team with flexibility in code sharing and management.
  - [Git](/azure/devops/repos/git) is the industry-standard version control system. It's a distributed version control system, where your local copy of the code is a complete version of the repository.

- Understand mono-repo versus multirepo [Repository structure](/training/modules/structure-your-git-repo/).
  - In mono-repo structures, all source code lives in a single repository.
  - In multirepo structures, all projects are organized into separate repositories.

- Choose a visibility setting that suits the content of your repository.
  - Public repositories can be accessed anonymously.
  - Private repositories require users be granted access to the repo and signed in to access services.
  - You can set public and private visibility for [Azure DevOps Projects](/azure/devops/organizations/public/make-project-public) and [GitHub repos](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/managing-repository-settings/setting-repository-visibility).

- Consider setting repository permissions that help you control who can contribute to your source code and manage other features.
  - You can set repository permissions for [Azure DevOps](/azure/devops/repos/git/set-git-repository-permissions) and [GitHub](https://docs.github.com/organizations/managing-access-to-your-organizations-repositories/repository-roles-for-an-organization).

- Consider using [Infrastructure as Code (IaC)](/azure/architecture/framework/devops/automation-infrastructure) resource deployment to Azure. IaC allows you to manage infrastructure in a declarative model, helping to reduce configuration effort, ensure consistency between deployments, and avoid manual environment configuration.

- Azure provides support for IaC for Landing Zones through:
  - [Bicep](https://github.com/Azure/ALZ-Bicep)
  - [Terraform](../landing-zone/deploy-landing-zones-with-terraform.md)

### Design recommendations

- Use Git as a version control system.

- Use private repositories when building Azure Landing Zones

- Use public repositories when sharing non-confidential information like automation examples, public documentation, and open-source collaboration material.

- Adopt an IaC approach for deploying, managing, governing and supporting cloud resources.

## Branch strategy

### Design considerations

- Consider using a [branch strategy](/azure/devops/repos/git/git-branching-guidance) that allows teams to collaborate better and efficiently manage version control.

- Consider using specific [naming conventions](/azure/devops/repos/git/git-branching-guidance#name-your-feature-branches-by-convention) for your branches.

- Consider using [branch permissions](/azure/devops/repos/git/branch-permissions) to control user capabilities.

- Consider using branch policies to help your teams protect important branches of development. Policies that can help enforce code quality and change management standards. Examples of branch policies include:
  - Always using pull requests to merge changes into important branches.
  - [Requiring a minimum number of reviewers](/azure/devops/repos/git/branch-policies#require-a-minimum-number-of-reviewers) for pull requests.
  - [Automatically including code reviewers](/azure/devops/repos/git/branch-policies#automatically-include-code-reviewers).
  - [Checking for linked work items](/azure/devops/repos/git/branch-policies#check-for-linked-work-items) allows you to keep traceability.
  - [Checking for comment resolution](/azure/devops/repos/git/branch-policies#check-for-comment-resolution) validates whether all PR comments are resolved.
  - [Limiting merge types](/azure/devops/repos/git/branch-policies#limit-merge-types).

- Adopting a pull request strategy can help you keep control of code changes merged into branches.
  - Define a [merge strategy](/azure/devops/repos/git/merging-with-squash).
  - Pull requests should be simple, with the number of files kept to a minimum to help reviewers validate commits and changes more efficiently.
  - Pull requests should have clear titles and descriptions so reviewers know what to expect when reviewing code.
  - You can use [pull request templates](/azure/devops/repos/git/pull-request-templates).
  - You can delete origin branches after pull requests are complete, which gives you more control and better branch management.

### Design recommendations

- Adopt a [trunk-based development model](https://trunkbaseddevelopment.com/), in which developers commit to a single branch. This model facilitates continuous integration. All feature work is done in the trunk, and any merge conflicts are resolved when the commit happens.

- Have your teams define and use consistent naming conventions for branches to identify the work done.

- Set permissions to control who can read and update code in a branch of your Git repository. You can set permissions for individual users and for groups.

- Set branch policies:
  - Require the use of pull requests for branch merges into the main branch.
  - Require a minimum number of reviewers for pull requests.
  - Reset all approval votes to remove all approval votes, but keep votes to reject or wait whenever a source branch changes.
  - Automatically include code reviewers.
  - Check for comment resolution.

- Set squash as merge strategy, which allows you to condense the Git history of topic branches when you complete pull requests. Instead of adding each commit on a topic branch to the history of the default branch, a squash merge adds all file changes to a single new commit on the default branch.

## Automated builds

### Design considerations

- Consider implementing [Continuous Integration (CI)](/devops/develop/what-is-continuous-integration#:~:text=Continuous%20Integration%20(CI)%20is%20the,after%20every%20small%20task%20completion). CI involves merging all developer code into a central codebase on a regular schedule and automatically executing standard builds and test processes.

- Consider using CI triggers:
  - [Azure Repos Git](/azure/devops/pipelines/repos/azure-repos-git#ci-triggers). You can configure branches, paths, and tags as triggers to run a CI build.
  - [GitHub](/azure/devops/pipelines/repos/github#ci-triggers). You can configure branches, paths, and tags triggers to run a CI build.

- Consider including IaC unit tests in your build process to validate syntax.
  - The [ARM Templates test toolkit](/azure/azure-resource-manager/templates/test-toolkit) checks whether a template follows recommended practices.
  - [Bicep linter](/azure/azure-resource-manager/bicep/linter) checks Bicep files for syntax errors and best practice violations.

- Consider including unit tests in your application build process. Review the tasks available for [Azure DevOps Pipeline](/azure/devops/pipelines/tasks#test).

- Use Azure DevOps service connections or GitHub secrets to manage connections to Azure. Each connection should have the correct privilege access to Azure resources.

- Consider using [Azure Key Vault secrets](/azure/devops/pipelines/release/key-vault-in-own-project) to store and manage sensitive information like passwords, API keys, certificates.

- [Azure DevOps agents](/azure/devops/pipelines/agents/agents) can be self-hosted or Microsoft-hosted.
  - Maintenance and upgrades are taken care of for you when you use Microsoft-hosted agents. Every time a build job is run, a fresh virtual machine is created.
  - You set up and manage self-hosted agents on your own to run build jobs.

### Design recommendations

- Use CI to automate builds and testing of code every time a team member commits changes to version control.

- Include unit tests for IaC and application code as part of your build process.

- If possible, use Microsoft-hosted pool rather than self-hosted pools, as they offer isolation and a clean VM for each pipeline run.

- When you connect Azure DevOps or GitHub to Azure via service connections or GitHub secrets, make sure you always define the scope so they can access only required resources.

- Use Key Vault secrets to avoid hard-coding sensitive information such as credentials (virtual machine´s user passwords), certificates or keys. Then use secrets as variables in your build and release jobs.

## Deployment strategy

### Design considerations

- Consider using [Continuous Delivery (CD)](/devops/deliver/what-is-continuous-delivery). CD involves building, testing, configuring, and deploying from a build to an environment.

- Consider using [environments](../considerations/environments.md). Environments allow you to target a collection of resources from a delivery job. Examples of common environment names include:
  - Dev
  - Test
  - QA
  - Staging
  - Production

- Consider using IaC as part of your strategy to validate and confirm changes pre-deployment.
  - [ARM Templates what-if](/azure/azure-resource-manager/templates/deploy-what-if?tabs=azure-powershell)
  - [Bicep what-if](/azure/azure-resource-manager/bicep/deploy-what-if?tabs=azure-powershell%2cCLI)
  - [Terraform plan](https://www.terraform.io/cli/commands/plan)

### Design recommendations

- Use CD to ensure that code is always ready to deploy by automatically building, testing, and deploying code to production-like environments. Add continuous delivery to create a full CI/CD integration that helps you detect code defects as early as possible and ensures you can quickly release properly tested updates.

- Use environments as part of your deployment strategy. Environments provide benefits like:
  - Deployment history
  - Traceability of commits and work items
  - Diagnostic resource health
  - Security

- Include IaC pre-deployment checks so you can preview changes. and see details on whether a resource has been created, modified, or deleted.

## Rollback strategy

### Design considerations

- Consider creating a rollback plan. Rolling back a deployment involves reverting the deployment to a known good state and provides a crucial ability to recover from a failed deployment.

- Consider using [undo changes](/azure/devops/repos/git/undo) in Git if you need to revert changes in a commit, discard changes or reset a branch to a previous state.

### Design recommendations

- Adopt the use of undo changes in Git when you need to revert changes to committed files, discard uncommitted changes or reset a branch to a previous state.
