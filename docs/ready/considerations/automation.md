---
title: Automation
description: Overview of Azure Landing Zone and platform services automation considerations and recommendations.
author: Zimmergren
ms.author: pnp
ms.date: 01/17/2025
ms.topic: conceptual
ms.custom: internal
---

# Automation

In software defined cloud infrastructure, teams use various tools and techniques to provision, configure, and manage the infrastructure. As your teams evolve and grow, they can transition from using portals and manual efforts to using code and automation to provision, configure, and manage infrastructure and services.

## Platform automation considerations

- Implementing the Everything as Code (EaC) methodology allows your teams to unlock key benefits, create a strong development culture, and enable everyone on each team to inspect how and which resources are deployed. EaC also helps your platform teams adopt key development practices that improve their agility and efficiency. Your teams can track changes and control which ones move to production by housing code in repositories and using version control systems to manage it.
- Teams can follow the **4-eyes principle** and use *peer programming* or *peer review* to ensure code changes are never made alone. Peer programming and peer review improve code quality, let teams share responsibility for changes, and increase team knowledge about what is agreed upon and deployed. Code review is a fantastic way for team members to learn new techniques and methods for coding and automation.
- Teams should use version control systems like Git, together with [Git repositories](../considerations/development-strategy-development-lifecycle.md#repository-strategy), to enforce peer review. Git repositories let your teams define important branches and protect them with [branch policies](../considerations/development-strategy-development-lifecycle.md#branch-strategy). You can use policy to require code changes on these branches to meet certain criteria, like a minimum number of team member approvals, before they can merge into a protected branch.
- Teams should connect the EaC methodology and the change review process together with a [continuous integration and continuous delivery (CI/CD)](../considerations/development-strategy-development-lifecycle.md#automated-builds) process. Every code change should automatically trigger a CI process that executes static code analysis, validation, and test deployments. CI ensures that developers check their code early (often referred to as **fail fast** or **shift-left testing**) for errors that can cause future issues. Depending on which [branching strategy](../considerations/development-strategy-development-lifecycle.md#branch-strategy) your team uses, changes to any important branch should trigger deployment to different [environments](../considerations/environments.md). Once changes are approved and merged into `main`, the CD process deploys those changes to production. This code management system provides your team with a **single source of truth** for what is running in each environment.
- To ensure your platform is fully self-healing and provides self-service for your workload teams, your platform team must work to automate everything (often referred to as **Extreme Automation**) from provisioning, configuration, and platform management to landing zone subscription provisioning for workload teams. Extreme automation allows your platform team to focus on providing value rather than on deploying, configuring, and managing your platform. Extreme automation also creates a self-enhancing cycle that gives your team more time to build more automation.
- As your platform teams automate operational activities and reduce human intervention, they should shift their focus to important tasks that enable and accelerate workload team innovation on Azure. To achieve this, your platform team must iterate through multiple cycles of building and development as they put into place your platform's tools, scripts and capability enhancements.
- Multiple options are available to help your team get started with their Azure Landing Zone deployment. These options depend on your team's current capabilities and can grow as your team evolves. More specifically, for [Platform Deployment](/azure/architecture/landing-zones/landing-zone-deploy#platform), you can choose between Portal, Bicep, or Terraform-based experiences, depending on the infrastructure as code (IaC) proficiency and tooling preference of the respective teams.
  - New and emerging platform teams that are still getting to know [IaC](/azure/architecture/checklist/dev-ops#management) and are familiar with using a portal to deploy and manage resources can use the [Azure landing zone accelerator](../landing-zone/index.md#azure-platform-landing-zones-portal-accelerator). This accelerator supports teams that currently use a **ClickOps** approach. ClickOps is the process of provisioning, configuring, and managing resources by clicking in portals, management consoles, and wizards. This accelerator allows your team to use the portal as an initial deployment tool. As platform engineering maturity grows, your team can gradually incorporate Azure CLI, PowerShell, or IaC.
  - The [AzOps solution](https://github.com/Azure/AzOps) allows teams to evolve their platform automation and management practices from **ClickOps** driven to **DevOps** capable. Your team can transition from using their personal account access to using DevOps principles and practices relying only on CI/CD with AzOps and IaC. AzOps lets your team bring their own architecture, use the architecture deployed by Azure Landing Zone Portal accelerator (after the initial portal-based deployment, as AzOps integration is not part of the ALZ Portal experience), integrate with a brownfield deployment, or use custom templates (Bicep or ARM) to build and operationalize your platform.
  - Platform teams with established skills and capabilities can adopt a codified approach that follows **[DevOps principles and practices](./devops-principles-and-practices.md)**. Your team should base themselves heavily on IaC and modern development practices, transitioning away from using Azure access on their personal accounts and toward running all operations through your CI/CD pipeline. Your team should use IaC-based accelerators, like [ALZ-Bicep](https://github.com/Azure/ALZ-Bicep) or the [Azure landing zones Terraform module](../landing-zone/deploy-landing-zones-with-terraform.md) to accelerate this transition.
- IaC-based accelerators have limited management scope. New versions provide more capabilities and increased resource management ability. If using an accelerator, your team should consider a layered approach that starts with an accelerator, then adds a layer of automation. The automation layer provides capabilities your team needs in order to fully support your workload teams with platform features like domain controller deployment for legacy applications.
- As your platform team transitions to a DevOps approach, they need to establish a process for handling emergency fixes. They can use [Privileged Identity Management (PIM)](/entra/id-governance/privileged-identity-management/pim-configure) eligible permissions to request access to perform fixes and later bring it back to code to limit configuration drift, or they can use code to implement a quick fix. Your team should always register quick fixes in their backlog so they can rework each fix at a later point and limit their technical debt. Too much technical debt leads to future deceleration since some platform code isn't fully reviewed and doesn't meet team coding guidelines and principles.
- You can use [Azure Policies](/azure/governance/policy/overview) to add some automation to your platform. Consider using IaC to deploy and manage Azure Policies, often referred to as Policy-as-Code (PaC). These policies let you automate activities like log collection. Many PaC frameworks also implement an exemption process, so plan for your workload teams to request exemptions from policies.
- Use "Policy-driven-governance" to signal to workload teams when they're attempting to deploy resources that don't meet a security control. Consider deploying policies with the `deny` effect for these situations, which allows your workload teams to also treat Everything as Code and avoid configuration drift where code declares one thing and policy changed a setting at deployment time. Avoid using `modify` effects, such as if a workload team deploys a storage account with `supportOnlyHttpsTraffic = false` defined in their code where a `modify` policy changes that to `true` at deployment time to keep it compliant. This leads the code drift from what is deployed.

## Platform automation design recommendation

- Follow an **Everything as Code** approach for full transparency and configuration control of the Azure platform, documentation, deployment, and testing process.
- Use [version control](/devops/develop/git/what-is-version-control) to manage all your code repositories, including:
  - Infrastructure as Code
  - Policy as Code
  - Configuration as Code
  - Deployment as Code
  - Documentation as Code
- Implement **the 4-eyes principle** and a process for *peer-programming* or *peer-review* to ensure that all code changes are reviewed by your team before being deployed to production.
- Adopt a [branching strategy](/azure/devops/repos/git/git-branching-guidance) for your team and [set branch policies](/azure/devops/repos/git/branch-policies) for branches that you want to protect. With branch policies, teams must use [pull requests](/azure/devops/repos/git/about-pull-requests) to make merge changes.
- Use [continuous integration and continuous delivery (CI/CD)](./devops-principles-and-practices.md#define-your-devops-framework) to automate code testing and deployment to different environments.
- Work to **automate everything**, such as the provisioning, configuration, and management of your platform and the provisioning of landing zone subscriptions for your workload teams.
- Use one of the available accelerators that matches your team's capabilities to get started with deploying Azure Landing Zones.
- Plan to use a layered deployment approach to add capabilities that aren't covered by an accelerator but are needed to fully support your workload teams.
- Establish a process for using code to implement quick fixes. Always register quick fixes in your team's backlog so each fix can be reworked at a later point and you can limit technical debt.
- Use [Infrastructure as Code](./infrastructure-as-code.md) to deploy and manage [Azure Policies](/azure/governance/policy/overview) (often referred to as Policy-as-Code)
- Implement an exemption process for policies. Plan for your workload teams to request exemptions from policies, and be ready to unblock the teams when needed.
- Use "Policy-driven-governance" to block workload teams when they attempt to deploy resources that don't meet a security control. This helps reduce configuration drift, where code declares a different state than what ends up being deployed.

## Read more

- [Adopt policy-driven guardrails](../enterprise-scale/dine-guidance.md)
- [Bicep fundamentals](/training/paths/fundamentals-bicep)
- [Intermediate Bicep](/training/paths/intermediate-bicep)
- [Advanced Bicep](/training/paths/advanced-bicep)
- [Use Bicep and GitHub Actions to deploy Azure resources](/training/paths/bicep-github-actions)
- [Use Bicep and Azure Pipelines to deploy Azure resources](/training/paths/bicep-azure-pipelines)
- [Control and govern your Azure environment by deploying your infrastructure as code](/training/modules/control-govern-azure-environment-deploying-infrastructure-code/)
