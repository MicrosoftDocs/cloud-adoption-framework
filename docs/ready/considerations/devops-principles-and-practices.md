---
title: DevOps considerations
description: Design area guidance for DevOps considerations in Azure Landing Zones.
author: alguadam
ms.author: alguadam
ms.date: 06/24/2022
ms.topic: conceptual
ms.custom: internal
---

# DevOps considerations

This article provides considerations and recommendations for DevOps in Azure Landing Zones.

## What is DevOps

DevOps is the union of people, processes, and technology that provides continuous value to development (dev) and operations (ops). The DevOps approach encourages team collaboration that creates repeatable processes to help organizations operate efficiently and at scale.

In the context of Azure Landing Zones, DevOps becomes the framework that guides your team (or teams) responsible for your entire Azure Landing Zones lifecycle management in areas such as:

- How to self-organize and define boundaries with other teams to achieve the appropriate balance between autonomy and governance
- How to continuously evolve Azure Landing Zone architecture design [(Conway's Law)](devops-teams-topologies.md)
- How to plan, prioritize and iterate the implementation of the designed Architecture
- How to implement version control, continuous integration and continuous deployment for Azure Landing Zone code
- How to operate and respond to incidents for systems and platforms you own
- The level of automation you apply to Azure Landing Zone provisioning and self-healing
- How to collaborate with other teams in your organization in an agile, outcome-oriented way
- How to create a generative culture of security, quality, user-centricity and continuous learning

The decisions you make when reviewing cloud operating models can influence how you use your DevOps framework.

## DevOps design considerations

- Define your [DevOps framework](#define-your-devops-framework), or align it with your organizational's DevOps and cloud adoption strategy. Include the definition of DevOps and the principles and practices your team must follow. Make sure you connect your DevOps strategy to your business strategy.

- Establish [metrics](#implement-desired-devops-metrics) that allow your team to improve their DevOps performance. High-performance teams use a hypothesis to test their ideas, measure it to see how the hypothesis works, then make changes as needed. DevOps' final intent is to improve aspects like deployment frequency, mean time to apply a change, or time to restore a degraded service. You must design all these metrics to eventually affect overall business performance.

- Determine the [DevOps practices](#define-devops-practices-for-your-azure-landing-zones-management) your team should implement first based on their current skilling, and design a roadmap to incrementally apply new practices that help your team improve their DevOps metrics. Investing in engineering capabilities and resources is critical.

- Determine the [DevOps toolchain](#define-your-devops-technology-ecosystem) your team should use to implement the DevOps practices. Make sure that the tools are consistent with your overall DevOps strategy to avoid scenarios of heterogenous DevOps ecosystems increasing the complexity of Azure Landing Zone or workload deployments.

- Evaluate the effect that your implemented DevOps practices and DevOps tools have on the design of your Azure Landing Zones.

- Create a readiness plan to continuously grow your team's skills. Blanket application of a DevOps model doesn't instantly establish capable DevOps teams.

- [Determine the team topology](./devops-teams-topologies.md) that best aligns with your organization's DevOps strategy and cloud operating model, and establish clear boundaries, responsibilities and dependencies between the teams.

- Determine how the team responsible for Azure Landing Zones should collaborate with other teams in your organization to capture new Azure Landing Zone requirements to update design and implementation, resolve incidents, minimize dependencies, and align with business priorities.

## DevOps recommendations

The following sections contain recommendations to help you implement the DevOps framework within your organization.

### Define your DevOps framework

To establish your DevOps framework, consider using the frameworks that are already available to start with a set of predefined proven practices:

- [Microsoft DevOps Resource Center](/devops/what-is-devops) provides a rich set of definitions, practices, and capabilities that you can adapt to Azure Landing Zone lifecycle management, including:
  - [Planning](/devops/plan/planning-efficient-workloads-with-devops)
  - [Development and Continuous Integration](/devops/develop/developing-modern-software-with-devops)
  - [Continuous Delivery](/devops/deliver/delivering-quality-services-with-devops)
  - [Operations and Reliability](/devops/operate/operating-reliable-systems-with-devops)
  - [DevSecOps](/devops/operate/security-in-devops)

- [Microsoft DevOps Dojo](https://devblogs.microsoft.com/devops/intro-of-devops-dojo/) establishes a DevOps taxonomy built on four foundational pillars and eight capabilities:
  - Pillars:
    - [Culture](/training/modules/introduce-foundation-pillars-devops/3-explore-first-foundation?ns-enrollment-type=learningpath&ns-enrollment-id=learn.wwl.devops-dojo-white-belt-foundation)
    - [Lean Product](/training/modules/introduce-foundation-pillars-devops/4-explore-second-foundation?ns-enrollment-type=learningpath&ns-enrollment-id=learn.wwl.devops-dojo-white-belt-foundation)
    - [Architecture](/training/modules/define-foundation-pillars/2-explore-third-foundation-pillar?ns-enrollment-type=learningpath&ns-enrollment-id=learn.wwl.devops-dojo-white-belt-foundation)
    - [Technology](/training/modules/define-foundation-pillars/3-explore-last-foundation?ns-enrollment-type=learningpath&ns-enrollment-id=learn.wwl.devops-dojo-white-belt-foundation)
  - Capabilities:
    - [Continuous Planning](/training/modules/analyze-devops-continuous-planning-intergration/2-explore-continuous-planning?ns-enrollment-type=learningpath&ns-enrollment-id=learn.wwl.devops-dojo-white-belt-foundation)
    - [Continuous Integration](/training/modules/analyze-devops-continuous-planning-intergration/3-analyze-continuous-integration?ns-enrollment-type=learningpath&ns-enrollment-id=learn.wwl.devops-dojo-white-belt-foundation)
    - [Continuous Delivery](/training/modules/explain-devops-continous-delivery-quality/2-use-continuous-delivery-release-faster?ns-enrollment-type=learningpath&ns-enrollment-id=learn.wwl.devops-dojo-white-belt-foundation)
    - [Continuous Operations](/training/modules/explore-devops-continuous-security-operations/3-explore-continuous-operations?ns-enrollment-type=learningpath&ns-enrollment-id=learn.wwl.devops-dojo-white-belt-foundation)
    - [Continuous Security](/training/modules/explore-devops-continuous-security-operations/2-explore-continuous-security?ns-enrollment-type=learningpath&ns-enrollment-id=learn.wwl.devops-dojo-white-belt-foundation)
    - [Continuous Quality](/training/modules/explain-devops-continous-delivery-quality/3-explore-continuous-quality?ns-enrollment-type=learningpath&ns-enrollment-id=learn.wwl.devops-dojo-white-belt-foundation)
    - [Continuous Improvement](/training/modules/characterize-devops-continous-collaboration-improvement/3-explore-continuous-improvement?ns-enrollment-type=learningpath&ns-enrollment-id=learn.wwl.devops-dojo-white-belt-foundation)
    - [Continuous Collaboration](/training/modules/characterize-devops-continous-collaboration-improvement/2-explore-continuous-collaboration?ns-enrollment-type=learningpath&ns-enrollment-id=learn.wwl.devops-dojo-white-belt-foundation)

### Define DevOps practices for your Azure Landing Zones management

Consider the following DevOps practices for your Azure Landing Zones:

- Review how to [manage the development lifecycle of Azure Landing Zones as code](./development-strategy-development-lifecycle.md).
- Review [security considerations](./security-considerations-overview.md) for Azure Landing Zones in the DevOps space.

### Plan your DevOps implementation journey

Define and align your DevOps implementation journey with your organization's [cloud adoption plan](../../plan/plan-intro.md).

- Determine where your team is today in the following areas:
  - DevOps practices your team has adopted for Azure Landing Zones management.
    - Use tools like [DevOps Self-assessment](https://devopsassessment.net/) to assess the current state of your team's DevOps status.
  - Current team [structure](../../organize/index.md#structure-type), including [roles and responsibilities](../../organize/raci-alignment.md) and owned [cloud functions](../../organize/index.md#understand-required-cloud-functions).
  - What [technical skills](../suggested-skills.md) your team has.
  - Which [cloud operations model](../../operating-model/define.md) your team currently follows.
- Use your organization's cloud adoption plan to define a desired model for your team.
- Establish an iterative roadmap for implementing the desired model in an iterative and incremental mode that aligns with your organization's [transformation timeline](../../strategy/digital-transformation-timeline.md).

### Implement desired DevOps metrics

Identify which metrics you'll use to measure your team's DevOps performance. Use metrics to drive desired habits in your team that connect with [business outcomes](../../strategy/learning-metrics.md). Establish metrics to let your team measure impact over activities. Make key metrics visible to all, since transparency promotes trust and drives alignment with organizational objectives.

Examples of metrics that measure DevOps performance to improve business impact include:

- Business Outcomes:
  - Use [Objectives and Key Results](../../strategy/business-outcomes/okr.md) as a tool to move your teams away from an "output" mindset and toward an "outcome" mindset. For example, you might use the number of workloads that improved their compliance rating over the number of policies deployed to Azure.
  - Customer or end user satisfaction. Examples include Net Promoter Score (NPS), surveys, interviews.
  - Business growth. Examples include increased profitability, increased revenue, and new revenue source acquirements.
  - People metrics. Examples include the Employee Net Promoter Score (eNPS), utilization, retention, and satisfaction.
  - Costs. For example, you might use reduction in costs.

- Software delivery performance:
  - Lead Time for Change, the time it takes for a bug fix, new feature or any other change to go from idea to deployment to production.
  - Deployment Frequency, the deployments per day of code changes to production.
  - Mean Time to Restore, the time it takes to restore service in production after an incident occurs.
  - Change Fail Percentage, the percentage of changes to production (such as configuration changes) that lead to a failure.

- Quality:
  - Defect escape rate, the number of defects identified by your end users.
  - Unplanned work or rework, the percentage of time spent doing unplanned work or rework.
  - Active bugs, the number of bugs that aren't yet fixed.
  - Code Health, the percentage of code that hasn't been unit tested.

### Define your DevOps technology ecosystem

The DevOps toolchain you choose to manage the lifecycle of your Azure Landing Zones affects:

- Your strategies for implementing DevOps principles and practices
- Security considerations for your DevOps lifecycle
- The overall architecture design of your Azure Landing Zones lifecycle management

Use the [DevOps framework](#define-your-devops-framework) that you previously defined to identify which tools to use for each of your DevOps processes. Choose the DevOps technologies that are most suitable for your teams' needs, but find a balance that lets you achieve standardization across your organization but avoid too much complexity or heterogeneity in your DevOps ecosystems.

Examples of DevOps technologies across different DevOps stages include:

- **Planning:** Azure Boards, GitHub, Atlassian Jira, Trello
- **Continuous Integration:** Azure Repos, GitHub Repos, Atlassian Bitbucket, SonarQube, Selenium, Cucumber, OWASP ZA, NuGet, npm
- **Continuous Delivery:** Azure Pipelines, GitHub Actions, Bicep, Terraform, Jenkins, Atlassian Bamboo, RedHat Ansible, Chef, Puppet
- **Operations:** Azure Monitor, Azure Automation, Microsoft Power BI, Grafana, Splunk
- **Collaboration and feedback:** Azure DevOps Wikis, GitHub Wikis, GitHub Discussions, Microsoft Teams, Slack, Confluence, Stack Overflow

The following diagram shows an example DevOps framework with Azure DevOps toolchain selection:

![Diagram of DevOps framework with Azure DevOps toolchain selection.](./media/devops-toolchain-azure-devops.png)

The following diagram shows an example DevOps framework with Azure DevOps and GitHub toolchain selection:

![Diagram of DevOps framework with Azure DevOps and GitHub toolchain selection.](./media/devops-toolchain-github.png)
