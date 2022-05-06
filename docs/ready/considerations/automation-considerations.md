---
title: Automation considerations
description: Describes the different considerations and recomentation when automating deployment of Azure Landing Zone and platform services
author: MariusStorhaug
ms.author: MariusStorhaug
ms.date: 04/27/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Automation considerations

Cloud Infrastructure is software defined, where teams can provision, configure, and manage cloud infrastructure using
different tools and techniques. As teams evolve and grow, they shift from using portals and manual steps,
to using code and automation to provision, configure, and manage the infrastructure and services.

## Platform automation considerations

- To unlock key benefits and start setting a good development culture, teams should start with treating **Everything as Code**,
letting everyone in the team inspect what is being deployed and how. It also enables platform teams to adopt key
development practices that will help them to be more agile and efficient. By keeping code in repositories and using version
control systems, teams can track changes and control what changes they want into production.

- When the team wants to deploy a change to the infrastructure or update a chapter in their documentation, they should consider following
**the 4-eyes principle** where they do _peer-programming_ or _peer-review_, where changes to code is never done alone. This will increase
code quality, let the team share responsibility for code changes and increase the team’s knowledge on what is deployed or agreed on.
In addition, reviewing code is a fantastic way to learn new techniques and ways of coding and automating.

- The practice of peer-review should be enforced by using version control systems, such as Git, together with Git repositories. Git repositories
let's teams define important branches and protect them using branch policies. Depending on the policy, code changes on these branches can only
be merged into the protected branch when certain criteria are met. i.e., number of approvals from team members.

- Teams should connect the practice of keeping 'Everything as Code', the review process together with a continuous integration and deployment (CI/CD)
process. Changes that are made on a custom branch should automatically trigger a CI process, where static code analysis, validation, and test deployments
are executed. This will help developers check their code early (often referred to as **fail fast** or **shift-left testing**) for errors that could potentially cause
issues if deployed to production. Depending on the branching strategy that the team has, a change to an important branch, such as `dev` or `test` should
trigger deployments to different environments. With the final stage running after an approval to change the code in `main`, leading to a change being
deployed to production. This way of treating production code gives the team a **Single source of truth** for what is running in each environment.

- To get to the point where the platform is fully self-healing and provides self-service for workload teams, the platform team needs to seek to **automate everything**
  (often referred to as **Extreme Automation**) from provisioning, configuration, and management of the platform to provisioning of the landing zone
  subscriptions for workload teams. Additional benefits of extreme automation are that the platform team can focus more on providing value, rather than spending time
  deploying, configuring, and managing the platform. It creates a self-enhancing cycle, allowing for more time to build automation.

- As platform teams automate more of the operational activities, reducing human intervention, the teams focus should shift to more important tasks that helps
enable and accelerate workload teams' innovation on Azure. To get to this point, the platform team needs to go through multiple iterations of developing and
building tools, scripts and enhancing capabilities in the platform.

- There are multiple options available for teams to get started with their Azure Landing Zone deployment. These options depend on the teams' current capabilities
and can grow as the team evolves:
  - New and emerging platform teams which are getting to know Infrastructure as Code and more familiar with using the portal to deploy and manage resources,
    could start by using the [Azure landing zone accelerator (with AzOps)](\landing-zone\index.md#azure-landing-zone-accelerator). This accelerator
    supports team still using a **ClickOps** approach. **ClickOps** is the process of provisioning, configuring, and managing resources by clicking in portals, management
    consoles, and wizards. The solution allows teams to use the portal, Azure CLI, PowerShell or IaC. Changes done in code is pushed to Azure, while changes done
    in the portal can be pulled back to code.
  - As teams gain confidence, technical skills and grow their capabilities, a more codified approach can be adopted, namely **DevOps**. To support a transition to
    DevOps, the team should base itself heavily on Infrastructure as Code, CI/CD, and modern development practices and transition away from having access to Azure on their
    personal account to basing all operations on the CI/CD and permissions that of a service account. To accelerate the transition, teams should consider using the IaC
    based accelerators, such as [ALZ-Bicep](https://github.com/Azure/ALZ-Bicep) or the [Terraform module for Cloud Adoption Framework enterprise-scale](../enterprise-scale/terraform-module-caf-enterprise-scale.md).

- The accelerator mentioned above are limited in what they manage. As new versions are released, they get more capabilities and resources they manage. Teams that choose
  to use the accelerators should consider a layered approach, where they start with an accelerator and then add a layer of automation which adds capabilities that the team
  needs to fully support their workload teams with platform features, i.e., deploying domain controllers for legacy applications.

- As platform teams transition to a more DevOps approach, and reduce the use of their personal accounts, a process should be established for how to handle emergency fixes.
  For a start, the teams could use Privilege Identity Management (PIM) eligible permissions to request access to perform fixes, and then later bring this back to code to limit configuration drift,
  or by implementing a quick fix using code. Quick fixes should be registered in the team's backlog so the fix can be reworked at a later point, to limit technical dept. Too much technical
  dept will lead the team to decelerate at a later point, as there is code in the platform that is not fully reviewed and does not meet the teams coding guidelines and principles.

- Some automation can be added to the platform using Azure Policies. Consider using Infrastructure as Code to deploy and manage Azure Policies (often referred to as Policy-as-Code)
  to automate some of the activities, such as log collection. Many Policy as Code frameworks also have the added feature of implementing an exemption process. Plan for workload teams to
  request exemptions from policies.

- Use 'Policy-driven-governance' to signal to workload teams when they are attempting to deploy resources which do not meet a security control. For these situations, consider deploying policies
  with the `deny` effect. This will allow workload teams to also treat Everything as Code and avoid teams having configuration drift, where the code declares one thing, and the policy changed a setting
  on deployment time. In other words, avoid using `modify` effects. i.e., a workload team deploying a storage account with `supportOnlyHttpsTraffic = false` defined in their code, where a `modify` policy
  changes that to `false` on deployment time to keep it compliant. This leads the workload teams' code to be drifted from what is actually deployed.

## Platform automation design recommendation

- Follow an **Everything as Code** approach for full transparency and configuration control of the Azure platform, documentation, deployment, and testing process.
- Use version control to manage all the code repositories, including Infrastructure-, Policy-, Configuration-, Deployment- and Documentation-as-Code.
- Implement **the 4-eyes principle** and a process for _peer-programming_ or _peer-review_ to ensure that code changes are reviewed by the team before being
  deployed to production. This will help increase code quality and let the team share responsibility for code changes and increase the team’s knowledge on what is deployed.
- Define important branches and protect them using branch policies.
- Use continuous integration and deployment (CI/CD) to automate testing and deployment of code to different environments.
- Seek to **automate everything** such as provisioning, configuration and management of platform and the provisioning of landing zone subscriptions for workload teams.
  Automating processes will give the team more time to automate other processes and create a self-enhancing cycle.
- Use one of the available accelerators that matches the team's capabilities, to get started with deploying Azure Landing Zones.
- Plan for adding a layered deployment approach to add capabilities that is not covered by an accelerator which is needed to fully support workload teams.
- Establish a process for implementing quick fixes using code. Quick fixes must be registered in the team's backlog so the fix can be reworked at a later point, to limit technical dept.
- Use Infrastructure as Code to deploy and manage Azure Policies (often referred to as Policy-as-Code)
- Implement an exemption process for policies. Plan for workload teams to request exemptions from policies and be ready to unblock the teams when needed.
- Use 'Policy-driven-governance' to block workload teams when they are attempting to deploy resources which do not meet a security control. This help teams reducing configuration
  drift, where the code declares a different state then what is deployed.

## Read more

- [Adopt policy-driven guardrails - Cloud Adoption Framework | Microsoft Docs](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/enterprise-scale/dine-guidance)
- [Fundamentals of Bicep - Learn | Microsoft Docs](https://docs.microsoft.com/learn/paths/fundamentals-bicep/)
- [Intermediate Bicep - Learn | Microsoft Docs](https://docs.microsoft.com/learn/paths/intermediate-bicep/)
- [Advanced Bicep - Learn | Microsoft Docs](https://docs.microsoft.com/learn/paths/advanced-bicep/)
- [Deploy Azure resources by using Bicep and GitHub Actions - Learn | Microsoft Docs](https://docs.microsoft.com/learn/paths/bicep-github-actions/)
- [Deploy Azure resources by using Bicep and Azure Pipelines - Learn | Microsoft Docs](https://docs.microsoft.com/learn/paths/bicep-azure-pipelines/)
- [Control and govern your Azure environment by deploying your infrastructure as code - Learn | Microsoft Docs](https://docs.microsoft.com/learn/modules/control-govern-azure-environment-deploying-infrastructure-code/)
