---
title: DevOps Toolchain
description: Guidance on decisions to consider when choosing a DevOps tooling stack
author: elanzel
ms.author: elanzelm
ms.date: 04/22/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# DevOps toolchain
A DevOps toolchain is a collection of tools that enables DevOps teams to collaborate across the entire product lifecycle and tackles key DevOps fundamentals.
These tools operate as an integrated unit for planning, continuous integration, continuous delivery, operations, collaboration and feedback. Some examples of DevOps techonologies across different DevOps stages are available in [Define your DevOps technology ecosystem](../considerations/devops-principles-and-practices.md#define-your-devops-technology-ecosystem).

## DevOps toolchain considerations
- DevOps' processes can be already in use across the organization when you select the toolchain. You should find the right balance between the adoption of technologies that are suitable for your team's needs and the goal to standardize and avoid heterougeneus DevOps ecosystems across the organization.

- Different kind of DevOps toolchain can be adopted:
    - all-in-one:
      it provides a complete solution that may not integrate with other third-party tools. This can be useful for companies beginning their DevOps journey. E.g. [Full stack Azure DevOps toolchain](#full-stack-azure-devops-toolchain).
    - customized:
      This allows teams to bring and mix the existing tools they know and they have already in use into the wider DevOps toolchain. Integration is essential for these types of toolchains avoiding team members spending unnecessary time switching between screens, logging in to multiple places, and having the challenge to share information between tools. E.g. [Azure DevOps and GitHub toolchain](#azure-devops-and-github-toolchain).
- Consider toolchains that are regurarly updated and for which you can get assistance when you need it by email or online, this is a requirement for any product or service that is on the critical path to market.     
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
- When implementing [Continuous Integration (CI)](/devops/develop/what-is-continuous-integration)/[Continuous Delivery (CD)](/devops/deliver/what-is-continuous-delivery) consider adopting a tool that supports:
    - Version Control System. Everything in your project must be checked in to a single version control repository such as Git: code, tests, database scripts, build and deployment scripts, and anything else needed to create, install, run and test your application. 
    - [Branching strategy](../considerations/development-strategy-development-lifecycle.md#branch-strategy)
    - [Automated Build](../considerations/development-strategy-development-lifecycle.md#automated-builds)
- Note that the choose of the repository is also influenced by data sovereignty/residency requirements. If you need your data to be hosted locally, in countries other than US, you'll need Azure DevOps repositories for example, while GitHub Repos cannot be used.

- To minimize the amount of manual configuration needed to provision resources consider adopting [Infrastructure as Code](/azure/architecture/checklist/dev-ops#management). [Infrastructure as Code](/dotnet/architecture/cloud-native/infrastructure-as-code) allows you to apply software engineering practices such as testing and versioning, this make your infrastructure and deployments automated, consistent, and repeatable. Keep scripts and templates in source control, like any other code you maintain.

- Adopt [code scanning tools](/devops/devsecops/enable-devsecops-azure-github#secure-your-code-with-github) that help you detect code defects as soon as possible and include pre-deployment checks to validate and confirm changes before a deployment (E.g. ["what-if"](../considerations/development-strategy-development-lifecycle.md#deployment-strategy)) function.

- CI/CD tools should speed up the time to market for your product. Tools that allow you to parallelize tasks and take advantage of elastic scalability on cloud-hosted infrastructure will enhance the performance of your CI/CD process. 

- Consider using CI/CD tools features that support the measure of DevOps performance. Dashboards and reporting can track aspects of your development process like lead time, cycle time, velocity of work, etc.

### Continuous Operations
- Continuous Operations is a focus by which an organization maintains continuity of output between internal systems and customers through uninterrupted delivery of critical services or functions. The goals of Continuous Operations are
  - to reduce or eliminate the need for planned downtimes or interruptions such as scheduled maintenance, capacity optimization and deployment.
  - to increase overall the reliability and resiliency of the systems in three aspects with people, process and tools.

- Use cloud-native tools to:
  - [Monitor key metrics](../considerations/devops-principles-and-practices.md#implement-your-desired-devops-metrics) for service performance and availability.
  - Gain digital experience and customer insights.
  - [Generate intelligence-driven responses](azure/azure-monitor/continuous-monitoring) for incidents, system recovery, or scaling. [Azure Diagnostics](/azure/monitoring-and-diagnostics/azure-diagnostics) and [Application Insights](/azure/application-insights) are the standard method of tracking the health and status of Azure resources. [Azure Monitor](/azure/monitoring-and-diagnostics/monitoring-overview) also provides centralized monitoring and management for cloud or hybrid solutions.
  - Automate proactive maintenance and tasks such as deployment or systems updates. [Azure Automation](/azure/automation/overview) is a cloud-native tool that can be used to create event-based automation to diagnose and resolve issues.

### Collaboration & feedback
- Rapid feedback loops are at the heart of the CI/CD process. A CI/CD tool uses that feedback to resolve conditions in the CI/CD workflow logic and displays the information back to users, usually on a dashboard. 
Support for email notifications and integrations with IDEs or communication platforms ensure you stay informed of what’s happening without having to check the dashboard. Ensure you have the flexibility to configure the alerts you receive, as getting too many alerts would transform them in background noise.

- The tool choosen for the collaboration should support the following collaboration practices:
  - Kanban collaboration
  - Wiki content collaboration
  - ChatOps collaboration
  - Team room

## DevOps toolchain recommendation for Azure Landing Zones
- A DevOps toolchain for Azure Landing Zone implementation should consider all the DevOps phases discussed above: planning, CI/CD (including automation capabilities like Infrastructure as code), operations, collaborations and feedbacks. Guidance about the landing zone deployment and considerations for chosing an implementation option are in [Choosing landing zone adoption](/azure/cloud-adoption-framework/ready/landing-zone/choose-landing-zone-option#deployment-considerations) documentation.

- Regardless the selected methodology (Start small and expand or Enterprise-scale), there are a few common topologies that enterprises tend to follow when designing their DevOps workflows and toolchains:
    - Full stack Azure DevOps toolchain:  For enterprises who are already heavily invested in the Microsoft ecosystem, this topology allows them take full advantage of the native integrations between Microsoft 
products and possibly streamline key processes.
    - Azure DevOps and GitHub toolchain: This topology enables you to use the strengths of both as part 
of a well-integrated solution.

### Full stack Azure DevOps toolchain

![Full stack Azure DevOps toolchain](./media/devops-toolchain-azure-devops.png)

| DevOps stage | tools |
| - | - |
| Planning | [Azure Boards](/azure/devops/boards/get-started/what-is-azure-boards) provides powerful and flexible planning capabilities to developers and other personas, including hierarchical backlogs, customizable Kanban boards, rich process customization, team dashboards, and custom reporting.|
| CI/ CD| [Azure Repos](/azure/devops/repos/get-started/what-is-repos) allows to create private Git repositories, supporting different Git clients, branching strategy and protection. With Azure Repos you can benefit of localized data residency in the cloud to enable compliance with European regulations. [Azure Pipelines](/azure/devops/pipelines/get-started/what-is-azure-pipelines) allows customers to set up automated pipelines for CI/CD, including advanced test reporting. Azure Pipelines is currently strong in CD because of its support for multi-stage pipelines. Fine-grain permissions, gates, custom checks, and automated test result reporting in Azure Pipelines help you enforce security, compliance, and safe deployment best practices in your organization. They also support parallel steps execution and scalability. [Azure Artifacts](/azure/devops/artifacts/start-using-azure-artifacts) feed to store packages and to review and validate each package for security purposes. Azure Artifacts provide granular permission control and auditing. [Azure Test Plans](/azure/devops/test/overview) in Azure DevOps provides a browser-based test management solution for exploratory, manual, and user acceptance testing. Users of Azure Test Plans also typically use Azure Boards for planning and project management. You can link user stories and other requirements to test cases, or document bugs found as a result of testing. [Marketplace extensions for DevOps](/azure/devops/marketplace/overview) should be adopted to improve the static code analysis with tools such as Credential scanners, Open Source scanners, Bugs and Vulnerabilities scanners, etc. |
| Operations | [Azure Dashboards and reporting](/azure/devops/report/dashboards/overview) provide custom reporting to monitor key service performance metrics. [Azure Diagnostics](/azure/monitoring-and-diagnostics/azure-diagnostics) and [Application Insights](/azure/application-insights) are the standard method of tracking the health and status of Azure resources. [Azure Monitor](/azure/monitoring-and-diagnostics/monitoring-overview) provides centralized monitoring and management. [Azure Automation](/azure/automation/overview) can be used to create event-based automation to diagnose and resolve issues.  |
| Collaborations and Feedbacks| [Azure DevOps Wiki](/azure/devops/project/wiki/about-readme-wiki) allows sharing of information with other team's members, it supports collaborative editing of its content and structure. [Azure Boards](/azure/devops/boards/) provide Kanban collaboration and support for comments and discussions in backlog items. Microsoft Teams can be [integrated with Azure DevOps](https://www.azuredevopslabs.com/labs/vstsextend/teams/) to complete the team collaboration experience. |
### Azure DevOps and GitHub toolchain

![Azure DevOps and GitHub toolchain](./media/devops-toolchain-github.png)

| DevOps stage | tools |
| - | - |
| Planning |  Recommendation is to use [Azure Boards](/azure/devops/boards/get-started/what-is-azure-boards) as a stable and scalable solution for planning, managing different repositories, and offering hierarchical work items or data visualization. [Azure Boards integrates with GitHub](https://github.com/marketplace/azure-boards), allowing you to link work items with commits in GitHub. Azure Boards also allows you to choose your ideal workflow, either starting with a simple, out-of-the-box workflow or using the powerful and flexible customization engine to build a workflow that suits your needs. When it comes time to visualize your data, Azure Boards enables you to easily build custom dashboards, configure their layout, and easily monitor progress throughout the lifecycle of your project. |
| CI/ CD| The recommended version of GitHub is the Enterprise (GHE) including  [GitHub Repo](https://docs.github.com/github/creating-cloning-and-archiving-repositories/about-repositories) for repository and [GitHub Advanced Security (GHAS)](https://github.com/advanced-security) wich include [CodeQL](https://codeql.github.com/), [Code Scanning](https://docs.github.com/en/code-security/code-scanning/automatically-scanning-your-code-for-vulnerabilities-and-errors/about-code-scanning), [Secret Scanning](https://docs.github.com/en/code-security/secret-scanning/about-secret-scanning), [Security Overview](https://docs.github.com/en/code-security/secret-scanning/about-secret-scanning) and [Dependency Review](https://docs.github.com/en/code-security/supply-chain-security/understanding-your-software-supply-chain/about-dependency-review). GHE offers also Codespaces, a cloud IDE that can be used to develop code, replacing **Visual Studio Code** usually adopted in the Full-stack Azure DevOps scenario. [GitHub Actions](https://github.com/features/actions) can be used to automate non build workflows if your repositories are in GitHub. If you are in more complex scenarios were you need to access code from outside of GitHub or you need centralized management of workflow templates and build pipelines you should adopt [Azure Pipelines](/azure/devops/pipelines/get-started/what-is-azure-pipelines). As for the Azure Boards, [integration of Azure Pipelines with GitHub](https://github.com/marketplace/azure-pipelines) repositories is available. Detaild information about integration of Azure DevOps and GitHub are available in: [Work with Azure DevOps and GitHub](/azure/developer/github/integrate-azure-devops). [GitHub Packages](https://github.com/features/packages) is the software package service that allows you to host your own packages privately or publicly. GitHub offers container registry support for hosting Docker or OCI images. Access tokens are required to publish, install, or delete packages, keeping the lifecycle management of your packages secure. There is also automation support for packages: you can integrate GitHub Packages with GitHub Actions, GitHub APIs and webhooks to create DevOps workflows including your code, CI, and deployment all in one interface. |
| Operations | [Github Insights](https://docs.github.com/en/enterprise-cloud@latest/organizations/collaborating-with-groups-in-organizations/viewing-insights-for-your-organization) provides analytic reports based on data from your GitHub Enterprise Server instance to help you understand and improve your software delivery process. For Landing Zone diagnostics and management the same Azure services recommended in [Full-stack Azure DevOps](#full-stack-azure-devops-toolchain) scenario should be adopted.|
| Collaborations and Feedbacks| [GitHub Discussions](https://docs.github.com/discussions) can be used to share questions, ideas, conversations, requests for comment (RFC), resource planning, and announcements. Use [Azure Boards](/azure/devops/boards/) to easily build custom dashboards, configure their layout, and easily monitor progress throughout the lifecycle of your project. Microsoft Teams can be adopted to complete the team collaboration experience.|








