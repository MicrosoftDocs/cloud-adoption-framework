---
title: DevOps toolchain
description: Guidance to help you choose a DevOps tooling stack.
author: elanzel
ms.author: elanzelm
ms.date: 06/24/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# DevOps toolchain

A DevOps toolchain is a collection of tools that enables DevOps teams to collaborate across the entire product lifecycle and to tackle key DevOps fundamentals.

The tools a DevOps toolchain includes operate as an integrated unit for planning, continuous integration, continuous delivery, operations, collaboration and feedback. You can review some examples of DevOps technologies across different DevOps stages in [Define your DevOps technology ecosystem](../considerations/devops-principles-and-practices.md#define-your-devops-technology-ecosystem).

## DevOps toolchain considerations

- DevOps' processes can already be in use across your organization when you select a toolchain. You should find the right balance between the adoption of technologies suitable for your team's needs and the goal of standardizing and avoiding heterogeneous DevOps ecosystems across your organization.

- You can adopt different kinds of DevOps toolchains:
  - **All-in-one:** Provides a complete solution that might not integrate with other third-party tools. All-in-one toolchains can be useful for organizations beginning their DevOps journey. Example: [Full stack Azure DevOps toolchain].(#full-stack-azure-devops-toolchain).
  - **Customized:** Allows teams to bring and mix existing tools they know and already have in use into the wider DevOps toolchain. Integration is essential for these types of toolchains to avoid spending unnecessary time switching between screens, logging in to multiple places, and having the challenge to share information between tools. Example: [Azure DevOps and GitHub toolchain](#azure-devops-and-github-toolchain).
- Consider using toolchains that are regularly updated and that have assistance available whenever you need it through email or online portal. This is a requirement for any product or service that is on the critical path to market.

### Planning

- Consider adopting a tool that supports [Continuous Planning](/learn/modules/analyze-devops-continuous-planning-intergration/2-explore-continuous-planning) practices:
  - Release planning
  - Epic and feature identification
  - Prioritization
  - Estimation
  - User story definition
  - Backlog refinement
  - Sprint planning
  - Daily scrum
  - Sprint review
  - Retrospective

### Continuous Integration and Continuous Delivery

- When implementing [Continuous Integration (CI)](/devops/develop/what-is-continuous-integration)/[Continuous Delivery (CD)](/devops/deliver/what-is-continuous-delivery), consider adopting a tool that supports:
  - Version Control Systems. Everything in your project must be checked in to a single version control repository like Git: code, tests, database scripts, build and deployment scripts, and anything else needed to create, install, run and test your application.
  - [Branching strategy](../considerations/development-strategy-development-lifecycle.md#branch-strategy).
  - [Automated builds](../considerations/development-strategy-development-lifecycle.md#automated-builds).
- Note that your choice of repository is also influenced by data sovereignty/residency requirements. If you need your data to be hosted locally in countries other than US, you'll need Azure DevOps repositories when GitHub Repos cannot be used.
- To minimize the amount of manual configuration required to provision resources, consider adopting [Infrastructure as Code (IaC)](/azure/architecture/checklist/dev-ops#management). [IaC](/dotnet/architecture/cloud-native/infrastructure-as-code) lets you apply software engineering practices like testing and versioning, which make make infrastructure and deployments automated, consistent, and repeatable. Keep scripts and templates under source control like any other code you maintain.
- Adopt [code scanning tools](/devops/devsecops/enable-devsecops-azure-github#secure-your-code-with-github) to help you detect code defects as soon as possible. Include pre-deployment checks to validate and confirm changes before any deployment (Example: ["what-if"](../considerations/development-strategy-development-lifecycle.md#deployment-strategy)) function.
- CI/CD tools speed up the time to market for your product. Tools that allow you to parallelize tasks and take advantage of elastic scalability on cloud-hosted infrastructure enhance the performance of your CI/CD process.
- Consider using CI/CD tool features that support the measure of DevOps performance. Dashboards and reporting can track aspects of your development process like lead time, cycle time, velocity of work, etc.

### Continuous Operations

Continuous Operations is a focus that helps organizations maintain continuity of output between internal systems and customers through the uninterrupted delivery of critical services or functions. The goals of Continuous Operations are:

- To reduce or eliminate the need for planned downtimes or interruptions such as scheduled maintenance, capacity optimization and deployment.
- To increase overall reliability and resiliency of systems in three aspects, with people, process and tools.

Use cloud-native tools to:

- [Monitor key metrics](../considerations/devops-principles-and-practices.md#implement-your-desired-devops-metrics) for service performance and availability.
- Gain digital experience and customer insights.
- [Generate intelligence-driven responses](/azure/azure-monitor/continuous-monitoring) for incidents, system recovery, or scaling. 
  - [Azure Diagnostics](/azure/monitoring-and-diagnostics/azure-diagnostics) and [Application Insights](/azure/application-insights) are the standard method for tracking the health and status of Azure resources. [Azure Monitor](/azure/monitoring-and-diagnostics/monitoring-overview) also provides centralized monitoring and management for cloud or hybrid solutions.
- Automate proactive maintenance and tasks like deployment or system updates. 
  - [Azure Automation](/azure/automation/overview) is a cloud-native tool you can use to create event-based automation to diagnose and resolve issues.

### Collaboration and feedback

- Rapid feedback loops are at the heart of the CI/CD process. A CI/CD tool uses feedback to resolve conditions in CI/CD workflow logic and displays information back to users, usually through a dashboard.
- Support for email notifications and integration with IDEs or communication platforms ensure you can stay informed about what’s happening without having to check a dashboard. Ensure you have the flexibility to configure which alerts you receive, since getting too many alerts transforms them into background noise.

- Any tool you choose for the collaboration should support the following collaboration practices:
  - Kanban collaboration
  - Wiki content collaboration
  - ChatOps collaboration
  - Team room

## DevOps toolchain recommendations for Azure Landing Zones

DevOps toolchains for Azure Landing Zone implementation should consider all previously discussed DevOps phases: 
- Planning 
- CI/CD (including automation capabilities like Infrastructure as code)
- Operations
- Collaborations and feedback

Review guidance for landing zone deployment and considerations for choosing an implementation option in [Choosing landing zone adoption](/azure/cloud-adoption-framework/ready/landing-zone/choose-landing-zone-option#deployment-considerations).

Regardless of selected methodology (start small and expand or enterprise-scale), there are a few common topologies that enterprises tend to follow as they design their DevOps workflows and toolchains.

- **Full stack Azure DevOps toolchain:** For enterprises that are already heavily invested in the Microsoft ecosystem, this topology allows them to take full advantage of the native integrations between Microsoft products and services and streamline key processes.
- **Azure DevOps and GitHub toolchain:** This topology allows you to use the strengths of both Azure and GitHub as part of a well-integrated solution.

### Full stack Azure DevOps toolchain

![Diagram of a full stack Azure DevOps toolchain.](./media/devops-toolchain-azure-devops.png)

| DevOps stage | tools |
| - | - |
| Planning | [Azure Boards](/azure/devops/boards/get-started/what-is-azure-boards) provides powerful and flexible planning capabilities to developers and other personas, including hierarchical backlogs, customizable Kanban boards, rich process customization, team dashboards, and custom reporting.|
| CI/ CD | [Azure Repos](/azure/devops/repos/get-started/what-is-repos) allows you to create private Git repositories, and it supports different Git clients, branching strategy, and protection. Azure Repos also provides localized data residency in the cloud to enable compliance with European regulations. [Azure Pipelines](/azure/devops/pipelines/get-started/what-is-azure-pipelines) allows customers to set up automated pipelines for CI/CD, including for advanced test reportin, and provides powerful support for multi-stage pipelines. Fine-grain permissions, gates, custom checks, and automated test result reporting in Azure Pipelines help you enforce security, compliance, and safe deployment best practices in your organization and support parallel steps execution and scalability. [Azure Artifacts](/azure/devops/artifacts/start-using-azure-artifacts) provides a feed to store packages and to review and validate each package for security purposes, and also provides granular permission control and auditing. [Azure Test Plans](/azure/devops/test/overview) in Azure DevOps provides a browser-based test management solution for exploratory, manual, and user acceptance testing. Users of Azure Test Plans also typically use Azure Boards for planning and project management. You can link user stories and other requirements to test cases and can  document bugs found through testing. Adopt [Marketplace extensions for DevOps](/azure/devops/marketplace/overview) to improve static code analysis with tools like Credential scanners, Open Source scanners, Bugs and Vulnerabilities scanners, and more. |
| Operations | [Azure Dashboards and reporting](/azure/devops/report/dashboards/overview) provide custom reporting to help you monitor key service performance metrics. [Azure Diagnostics](/azure/monitoring-and-diagnostics/azure-diagnostics) and [Application Insights](/azure/application-insights) are the standard method of tracking the health and status of Azure resources. [Azure Monitor](/azure/monitoring-and-diagnostics/monitoring-overview) provides centralized monitoring and management. [Azure Automation](/azure/automation/overview) can be used to create event-based automation to diagnose and resolve issues.  |
| Collaborations and Feedbacks| [Azure DevOps Wiki](/azure/devops/project/wiki/about-readme-wiki) allows sharing of information with other team's members, it supports collaborative editing of its content and structure. [Azure Boards](/azure/devops/boards/) provide Kanban collaboration and support for comments and discussions in backlog items. Microsoft Teams can be [integrated with Azure DevOps](https://www.azuredevopslabs.com/labs/vstsextend/teams/) to complete the team collaboration experience. |

### Azure DevOps and GitHub toolchain

![Diagram of a Azure DevOps and GitHub toolchain.](./media/devops-toolchain-github.png)

| DevOps stage | tools |
| - | - |
| Planning |  Recommendation is to use [Azure Boards](/azure/devops/boards/get-started/what-is-azure-boards) as a stable and scalable solution for planning, managing different repositories, and offering hierarchical work items or data visualization. [Azure Boards integrates with GitHub](https://github.com/marketplace/azure-boards), allowing you to link work items with commits in GitHub. Azure Boards also allows you to choose your ideal workflow, either starting with a simple, out-of-the-box workflow or using the powerful and flexible customization engine to build a workflow that suits your needs. When it comes time to visualize your data, Azure Boards enables you to easily build custom dashboards, configure their layout, and easily monitor progress throughout the lifecycle of your project. |
| CI/ CD| The recommended version of GitHub is the Enterprise (GHE) including  [GitHub Repo](https://docs.github.com/github/creating-cloning-and-archiving-repositories/about-repositories) for repository and [GitHub Advanced Security (GHAS)](https://github.com/advanced-security) which include [CodeQL](https://codeql.github.com/), [Code Scanning](https://docs.github.com/en/code-security/code-scanning/automatically-scanning-your-code-for-vulnerabilities-and-errors/about-code-scanning), [Secret Scanning](https://docs.github.com/en/code-security/secret-scanning/about-secret-scanning), [Security Overview](https://docs.github.com/en/code-security/secret-scanning/about-secret-scanning) and [Dependency Review](https://docs.github.com/en/code-security/supply-chain-security/understanding-your-software-supply-chain/about-dependency-review). GHE offers also Codespaces, a cloud IDE that can be used to develop code, replacing **Visual Studio Code** usually adopted in the Full-stack Azure DevOps scenario. [GitHub Actions](https://github.com/features/actions) can be used to automate non build workflows if your repositories are in GitHub. If you are in more complex scenarios where you need to access code from outside of GitHub or you need centralized management of workflow templates and build pipelines you should adopt [Azure Pipelines](/azure/devops/pipelines/get-started/what-is-azure-pipelines). As for the Azure Boards, [integration of Azure Pipelines with GitHub](https://github.com/marketplace/azure-pipelines) repositories is available. Detailed information about integration of Azure DevOps and GitHub are available in: [Work with Azure DevOps and GitHub](/azure/developer/github/integrate-azure-devops). [GitHub Packages](https://github.com/features/packages) is the software package service that allows you to host your own packages privately or publicly. GitHub offers container registry support for hosting Docker or OCI images. Access tokens are required to publish, install, or delete packages, keeping the lifecycle management of your packages secure. There is also automation support for packages: you can integrate GitHub Packages with GitHub Actions, GitHub APIs and webhooks to create DevOps workflows including your code, CI, and deployment all in one interface. |
| Operations | [GitHub Insights](https://docs.github.com/en/enterprise-cloud@latest/organizations/collaborating-with-groups-in-organizations/viewing-insights-for-your-organization) provides analytic reports based on data from your GitHub Enterprise Server instance to help you understand and improve your software delivery process. For Landing Zone diagnostics and management the same Azure services recommended in [Full-stack Azure DevOps](#full-stack-azure-devops-toolchain) scenario should be adopted.|
| Collaborations and Feedbacks| [GitHub Discussions](https://docs.github.com/discussions) can be used to share questions, ideas, conversations, requests for comment (RFC), resource planning, and announcements. Use [Azure Boards](/azure/devops/boards/) to easily build custom dashboards, configure their layout, and easily monitor progress throughout the lifecycle of your project. Microsoft Teams can be adopted to complete the team collaboration experience.|
