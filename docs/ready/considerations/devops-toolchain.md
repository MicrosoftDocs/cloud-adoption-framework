---
title: DevOps Toolchain
description: Guidance on decisions to consider when choosing a DevOps tooling stack
author: ElisaAnzelmo, ElenaBataneroGarcia
ms.author: elanzel, elbatane
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
      it provides a complete solution that may not integrate with other third-party tools. This can be useful for companies beginning their DevOps journey. E.g. Full stack Azure DevOps toolchain.
    - customized:
      This allows teams to bring and mix the existing tools they know and they have already in use into the wider DevOps toolchain. Integration is essential for these types of toolchains avoiding team members spending unnecessary time switching between screens, logging in to multiple places, and having the challenge to share information between tools. E.g. Azure DevOps and GitHub toolchain.

- Consider toolchains that are regurarly updated and for which you can get assistance when you need it by email or online, this is a requirement for any product or service that is on the critical path to market.     
### Planning
- Consider adopting a tool that supports Continuous Planning practices as described in [Continuous Planning practices in White Belt](https://devopsdojodocs.azurewebsites.net/white-belt/capabilities/continuous-planning/index.html#continuous-planning-practices-in-white-belt):
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
    - Version Control System: everything in your project must be checked in to a single version control repository such as Git. Refer to [What is Continuous Integration article](https://devopsdojodocs.azurewebsites.net/white-belt/capabilities/continuous-integration/what-is-continuous-integration.html) for more details
    - [Branching strategy](../considerations/development-strategy-development-lifecycle.md#branch-strategy)
    - [Automated Build](../considerations/development-strategy-development-lifecycle.md#automated-builds)

- Note that the choose of the repository is also influenced by data sovereignty/residency requirements. If you need your data to be hosted locally, in contries other than US, you'll need Azire DevOps, for example and you cannot adopt GitHub Repos.

- To minimize the amount of manual configuration needed to provision resources consider adopting [Infrastructure as Code](/azure/architecture/checklist/dev-ops#management). Infrastructure as Code helps also to document configuration. Keep scripts and and templates in source control, like any other code you maintain.

- Adopt [code scanning tools](/devops/devsecops/enable-devsecops-azure-github#secure-your-code-with-github) that help you detect code defects as soon as possible and include pre-deployment checks to validate and confirm changes before a deployment (E.g. ["what-if" function](../considerations/development-strategy-development-lifecycle.md#deployment-strategy)).

- CI/CD tools should speed up the time to market for your product. Tools that allow you to parallelize tasks and take advantage of elastic scalability on cloud-hosted infrastructure will enhance the performance of your CI/CD process. 

- Consider using CI/CD tools features that support the measure of DevOps performance. Dashboards and reporting can track aspects of your development process like lead time, cycle time, velocity of work, etc.

### Continuous Operations
- The goals of [Continuous Operations](https://devopsdojodocs.azurewebsites.net/white-belt/capabilities/continuous-operations/what-is-continuous-operations.html) are
- to reduce or eliminate the need for planned downtimes or interruptions such as scheduled maintenance, capacity optimization and deployment.
- to increase overall the reliability and resiliency of the systems in three aspects with people, process and tools.

- Use cloud-native tools to:
  - [Monitor key metrics](../considerations/devops-principles-and-practices.md#implement-your-desired-devops-metrics) for service performance and availability.
  - Gain digital experience and customer insights.
  - Generate intelligence-driven responses for incidents, system recovery, or scaling. [Azure Diagnostics](/azure/monitoring-and-diagnostics/azure-diagnostics) and [Application Insights](/azure/application-insights) are the standard method of tracking the health and status of Azure resources. [Azure Monitor](/azure/monitoring-and-diagnostics/monitoring-overview) also provides centralized monitoring and management for cloud or hybrid solutions.
  - Automate proactive maintenance and tasks such as deployment or systems updates. [Azure Automation](/azure/automation/overview) is a cloud-native tool that can be used to create event-based automation to diagnose and resolve issues.

### Collaboration & feedback
- Rapid feedback loops are at the heart of the CI/CD process. A CI/CD tool uses that feedback to resolve conditions in the CI/CD workflow logic and displays the information back to users, usually on a dashboard. 
Support for email notifications and integrations with IDEs or communication platforms ensure you stay informed of what’s happening without having to check the dashboard. Ensure you have the flexibility to configure the alerts you receive, as getting too many alerts would transform them in background noise.

- The tool choosen for the collaboration should support the following [collaboration practices](https://devopsdojodocs.azurewebsites.net/white-belt/capabilities/continuous-collaboration/index.html#continuous-collaboration-in-white-belt):
  - Kanban collaboration
  - Wiki content collaboration
  - ChatOps collaboration
  - Team room

## DevOps toolchain recommendation for Azure Landing Zones
- A DevOps toolchain for [Landing Zone implementation](/azure/cloud-adoption-framework/ready/landing-zone/implementation-options) should consider all the DevOps phases discussed above: planning, CI/CD, operations, collaborations and feedbacks.

- There are a few common topologies that enterprises tend to follow when designing their DevOps 
workflows and toolchains:
    - Full stack Azure DevOps toolchain:  For enterprises who are already heavily invested in the Microsoft ecosystem, this topology allows them take full advantage of the native integrations between Microsoft 
products and possibly streamline key processes.
    - Azure DevOps and GitHub toolchain: This topology enables you to use the strengths of both as part 
of a well-integrated solution.

### Full stack Azure DevOps toolchain
| DevOps stage | tools |
| - | - |
| Planning | - Azure Boards provides powerful and flexible planning capabilities to developers and other personas, 
including hierarchical backlogs, customizable Kanban boards, rich process customization, team 
dashboards, and custom reporting.|
| CI/ CD| |
| Operations | |
| Collaborations and Feedbacks| |
### Azure DevOps and GitHub toolchain
| DevOps stage | tools |
| - | - |
| Planning | |
| CI/ CD|GitHub Enterprise Server for Repos, GitHub Advanced Security (GHAS) |
| Operations | |
| Collaborations and Feedbacks| |









--------------------------------------------
>>> wich kind of code?
>>> selfhosted agents? increment nr of licences to have parallel job





