---
title: DevOps considerations
description: Design area guidance for DevOps considerations in Azure Landing Zones
author: alguadam
ms.author: alguadam
ms.date: 01/04/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# DevOps considerations for Azure Landing Zones

## What is DevOps

DevOps is the union of people, processes, and technology that continues to provide value to development (dev) and operations (ops).
This approach encourages team collaboration that creates repeatable processes to help organizations operate efficiently, and at scale.

In the context of Azure Landing Zones, DevOps will become the framework to guide the team or teams responsible for the entire Azure Landing Zones lifecycle management in areas such as:

- How to self-organize and define boundaries with other teams to achieve the appropriate balance between autonomy and governance
- How to continuously evolve Azure Landing Zone architecture design [(Conway's Law)](devops-teams-topologies.md#team-topologies)
- How to plan, prioritize and iterate the implementation of the designed Architecture
- How to implement version control, continuous integration and continuous deployment of Azure Landing Zone code
- How to operate and respond to incidents for the systems and platforms they own
- The level of automation that will be applied to Azure Landing Zone provisioning and self-healing
- How to collaborate with other teams in the organization in an agile, outcome-oriented way
- How to create a generative culture of security, quality, user-centricity and continuous learning

The decisions you make when reviewing cloud operating models might influence how you use your DevOps framework.

## DevOps design considerations

- Define your [DevOps framework](#define-your-devops-framework), or align it with your organizational's DevOps and cloud adoption strategy. Include the definition of DevOps, the principles and the practices that your team will follow. Also connect your DevOps strategy to your business strategy.

- Establish the [metrics](#implement-your-desired-devops-metrics) that will allow your team to improve their DevOps performance. High-performance teams use a hypothesis to test their ideas, then they measure it to see how the hypothesis works, and finally, they make changes. DevOps' final intent is to improve aspects like mean time that takes the team to apply a change, deployment frequency, or time to restore a degraded service. All the metrics must be designed to eventually impact the overall business performance.

- Determine the [DevOps practices](#define-the-devops-practices-to-adopt-for-your-azure-landing-zones-management) that your team will implement first based on their current skilling, and design a roadmap to incrementally apply new practices that help your team improve the DevOps metrics. Investing in engineering capabilities and resources is critical.

- Determine the [DevOps toolchain](#define-your-devops-technology-ecosystem) that your team will use to implement the DevOps practices. Make sure that the tools are consistent with the overall DevOps strategy to avoid scenarios of heterogenous DevOps ecosystems that increase the complexity level of Azure Landing Zone and/or workload deployments.

- Evaluate the impact that the implemented DevOps practices and the DevOps tools will have on the design of your Azure Landing Zones.

- Design a readiness plan to continuously grow your team's skills. The blanket application of a DevOps model won't instantly establish capable DevOps teams.

- [Determine the team topology](./devops-teams-topologies.md) that best aligns with your organization's DevOps strategy and cloud operating model, and establish clear boundaries, responsibilities and dependencies between the teams.

- Determine how your team responsible for Azure Landing Zones will collaborate with other teams in the organization to capture new Azure Landing Zone requirements to update the design and implementation, resolve incidents, minimize dependencies and align on business priorities.

## Recommendations for DevOps in the context of Azure Landing Zones

### Define your DevOps framework

To establish your DevOps framework, consider any of the frameworks that are already available to start with a set of pre-defined proven practices:

- [Microsoft DevOps Resource Center](/devops/what-is-devops) provides a rich set of definitions, practices and capabilities that can be adapted to Azure Landing Zone lifecycle management, including:
  - [Planning](/devops/plan/planning-efficient-workloads-with-devops)
  - [Development and Continuous Integration](/devops/develop/developing-modern-software-with-devops)
  - [Continuous Delivery](/devops/deliver/delivering-quality-services-with-devops)
  - [Operations and Reliability](/devops/operate/operating-reliable-systems-with-devops)
  - [DevSecOps](/devops/operate/security-in-devops)

- [Microsoft DevOps Dojo](https://devblogs.microsoft.com/devops/intro-of-devops-dojo/) establishes a DevOps taxonomy built on four foundation pillars and eight different capabilities:
  - Pillars:
    - [Culture](/learn/modules/introduce-foundation-pillars-devops/3-explore-first-foundation?ns-enrollment-type=learningpath&ns-enrollment-id=learn.wwl.devops-dojo-white-belt-foundation)
    - [Lean Product](/learn/modules/introduce-foundation-pillars-devops/4-explore-second-foundation?ns-enrollment-type=learningpath&ns-enrollment-id=learn.wwl.devops-dojo-white-belt-foundation)
    - [Architecture](/learn/modules/define-foundation-pillars/2-explore-third-foundation-pillar?ns-enrollment-type=learningpath&ns-enrollment-id=learn.wwl.devops-dojo-white-belt-foundation)
    - [Technology](/learn/modules/define-foundation-pillars/3-explore-last-foundation?ns-enrollment-type=learningpath&ns-enrollment-id=learn.wwl.devops-dojo-white-belt-foundation)
  - Capabilities:
    - [Continuous Planning](/learn/modules/analyze-devops-continuous-planning-intergration/2-explore-continuous-planning?ns-enrollment-type=learningpath&ns-enrollment-id=learn.wwl.devops-dojo-white-belt-foundation)
    - [Continuous Integration](/learn/modules/analyze-devops-continuous-planning-intergration/3-analyze-continuous-integration?ns-enrollment-type=learningpath&ns-enrollment-id=learn.wwl.devops-dojo-white-belt-foundation)
    - [Continuous Delivery](/learn/modules/explain-devops-continous-delivery-quality/2-use-continuous-delivery-release-faster?ns-enrollment-type=learningpath&ns-enrollment-id=learn.wwl.devops-dojo-white-belt-foundation)
    - [Continuous Operations](/learn/modules/explore-devops-continuous-security-operations/3-explore-continuous-operations?ns-enrollment-type=learningpath&ns-enrollment-id=learn.wwl.devops-dojo-white-belt-foundation)
    - [Continuous Security](/learn/modules/explore-devops-continuous-security-operations/2-explore-continuous-security?ns-enrollment-type=learningpath&ns-enrollment-id=learn.wwl.devops-dojo-white-belt-foundation)
    - [Continuous Quality](/learn/modules/explain-devops-continous-delivery-quality/3-explore-continuous-quality?ns-enrollment-type=learningpath&ns-enrollment-id=learn.wwl.devops-dojo-white-belt-foundation)
    - [Continuous Improvement](/learn/modules/characterize-devops-continous-collaboration-improvement/3-explore-continuous-improvement?ns-enrollment-type=learningpath&ns-enrollment-id=learn.wwl.devops-dojo-white-belt-foundation)
    - [Continuous Collaboration](/learn/modules/characterize-devops-continous-collaboration-improvement/2-explore-continuous-collaboration?ns-enrollment-type=learningpath&ns-enrollment-id=learn.wwl.devops-dojo-white-belt-foundation)

### Define the DevOps practices to adopt for your Azure Landing Zones management

Consider using the following DevOps practices for your Azure Landing Zones:

- See recommended practices to [manage the development lifecycle of Azure Landing Zones as code](./development-strategy-development-lifecycle.md).
- See [security considerations](./security-considerations-overview.md) for Azure Landing Zones in the DevOps space.

### Plan your DevOps implementation journey

Define and align your DevOps implementation journey with your organization's [cloud adoption plan](../../plan/plan-intro.md):

- Determine where your team is today in the following aspects:
  - The DevOps practices adopted for Azure Landing Zones management. Use tools like [DevOps Self-assessment](https://devopsassessment.net/) to assess the current state of your team's DevOps status.
  - How your [team is currently structured](../../organize/index.md#structure-type), including [roles and responsibilities](../../organize/raci-alignment.md) and owned [cloud functions](../../organize/index.md#understand-required-cloud-functions).
  - The [technical skills](../suggested-skills.md) in your team.
  - The current [cloud operations model](../../operating-model/define.md) adopted by your team.
- Define the desired model for your team according to your organization's cloud adoption plan.
- Establish an iterative roadmap to implement the desired model in an iterative and incremental mode in alignment with your organization's [transformation timeline](/azure/cloud-adoption-framework/strategy/digital-transformation-timeline).

### Implement your desired DevOps metrics

Identify what metrics will be used to measure your team's DevOps performance. Use metrics as a way to drive the desired habits in your team that is connected with [business outcomes](/azure/cloud-adoption-framework/strategy/learning-metrics). Establish metrics to let your team measure impact over activities. Make the key metrics visible to all, as transparency promotes trust and drives alignment to organizational objectives.

Following some examples of metrics that measure DevOps performance to improve business impact:

- Business Outcomes:
  - Use [Objectives and Key Results](/azure/cloud-adoption-framework/strategy/business-outcomes/okr) as a tool to move your teams away from an “output” mindset to an “outcome” mindset. E.g., Number of workloads that improved their compliance rating over the number of policies deployed to Azure.
  - Customer or end user satisfaction. E.g., Net Promoter Score (NPS), surveys, interviews.
  - Business growth. E.g., Increased profitability, increased revenue, acquiring new revenue sources
  - People metrics. E.g., Employee Net Promoter Score (eNPS), utilization, retention, satisfaction.
  - Costs. E.g., Reduction in costs.

- Software delivery performance:
  - Lead Time for Change. E.g., Time it takes for a bug fix, new feature or any other change to go from idea to deployment to production.
  - Deployment Frequency. E.g., Deploys per day of a code change to production.
  - Mean Time to Restore. E.g., Time it takes to restore service in production when an incident occurs.
  - Change Fail Percentage. E.g., Percentage of changes to production (such as configuration changes) that leads to a failure.

- Quality:
  - Defect escape rate. E.g., Number of defects identified by the end users.
  - Unplanned work or rework. E.g., Percentage of time doing unplanned work or rework.
  - Active bugs. E.g., Number of bugs that aren't fixed.
  - Code Health. E.g., Percentage of code that hasn't been unit tested.

### Define your DevOps technology ecosystem

The DevOps toolchain that you choose to manage the lifecycle of your Azure Landing Zones will impact:

- The strategies to implement DevOps principles and practices
- The security to consider in the DevOps lifecycle
- The overall Architecture design of your Azure Landing Zones lifecycle management

Use the [DevOps framework](#define-your-devops-framework) that you defined to identify what tools will be used for each of your DevOps processes. Choose the DevOps technologies that are most suitable for your teams' needs, but find the balance to achieve enough standardization across your organization and avoid too complex or heterogeneous DevOps ecosystems.

Some examples of DevOps technologies across different DevOps stages are:

- Planning: Azure Boards, GitHub, Atlassian Jira, Trello
- Continuous Integration: Azure Repos, GitHub Repos, Atlassian Bitbucket, SonarQube, Selenium, Cucumber, OWASP ZA, NuGet, npm
- Continuous Delivery: Azure Pipelines, GitHub Actions, Bicep, Terraform, Jenkins, Atlassian Bamboo, RedHat Ansible, Chef, Puppet
- Operations: Azure Monitor, Azure Automation, Microsoft Power BI, Graphana, Splunk
- Collaboration & feedback: Azure DevOps Wikis, GitHub Wikis, GitHub Discussions, Microsoft Teams, Slack, Confluence, Stack Overflow

E.g., of DevOps framework with Azure DevOps toolchain selection:

![Diagram of DevOps framework with Azure DevOps toolchain selection.](./media/devops-toolchain-azure-devops.png)

E.g., of DevOps framework with Azure DevOps and GitHub toolchain selection:

![Diagram of DevOps framework with Azure DevOps and GitHub toolchain selection.](./media/devops-toolchain-github.png)