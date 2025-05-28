---
title: Innovate methodology and maturity modeling
description: Learn about Azure tools that use the Innovate methodology to remove friction and empower adoption incrementally as hypotheses mature through the maturity model.
author: Zimmergren
ms.author: pnp
ms.date: 05/07/2024
ms.topic: conceptual
ms.custom: internal
keywords: toolchain, maturity model, continuous integration, innovate methodology
---

# Tools to empower adoption in Azure

As described in [Empower adoption](../considerations/ci-cd.md), building true innovation at scale requires an investment in removing friction that could slow adoption. In the early stages of testing a hypothesis, a solution is small. The investment in removing friction is likely small as well. As hypotheses prove true, the solution and the investment in empowering adoption grows. This article provides key continuous integration links to help you get started with each stage of the maturity model.

:::image type="content" source="../../_images/innovate/empower-adoption-maturity.png" alt-text="Diagram that shows the Cloud Adoption Framework approach to empower adoption." lightbox="../../_images/innovate/empower-adoption-maturity.png":::

## Alignment with the Innovate methodology

You can accelerate this type of digital invention through the following maturity levels. Technical guidance to accelerate digital invention is listed in the table of contents on the left side of this page. Those articles are grouped by maturity model level.

- **Shared solution**: Establish a centralized repository for all aspects of the solution.
- **Feedback loops**: Ensure feedback loops can be managed consistently throughout iterations.
- **Continuous integration**: Regularly build and consolidate a continuous integration and continuous delivery (CI/CD) solution.
- **Reliable testing**: Validate solution quality and expected changes to drive ensuring measurements.
- **Solution deployment**: Deploy a solution to allow a team to share changes with customers quickly.
- **Integrated measurement**: Add learning metrics to the feedback loop for clear analysis by the entire team.

## Toolchain

For adoption teams that are mature professional development teams with many contributors, the Azure toolchain starts with GitHub and Azure DevOps.

You can expand this foundation to use other tool features as your need grows. The expanded foundation might involve tools like:

- Azure Policy
- Infrastructure as code (IaC) templates, such as Azure Resource Manager templates (ARM templates), Terraform templates, and Bicep templates
- Azure Monitor

The table of contents on the left side of this page lists guidance for each tool and aligns with the previously described maturity model.

## Get started

Below you'll find articles to help you get started with each of the tools in this toolchain.

> [!NOTE]
> The following links will leave the Cloud Adoption Framework, as they reference supporting content that's beyond the scope of CAF.

### Shared solution

- [Get started with a shared repository via GitHub](https://guides.github.com/introduction/git-handbook/)
- [Get started with a shared backlog](/azure/devops/boards/backlogs/backlogs-boards-plans)
- [Synchronize Power Apps with Azure DevOps](/power-platform/alm/devops-build-tools)

### Feedback loops

- [Manage feedback with Azure DevOps](/azure/devops/project/feedback)

### Continuous integration

- [Continuous integration with Azure Pipelines and GitHub](https://www.azuredevopslabs.com/labs/azuredevops/continuousintegration/)

### Reliable testing

- [Manage and track test plans](/azure/devops/test/track-test-status)

### Solution deployment

- [Continuous deployment with Azure Pipelines and GitHub](https://www.azuredevopslabs.com/labs/azuredevops/continuousdeployment/)

### Integrated metrics

- [Monitor ASP.NET applications](/azure/azure-monitor/azure-monitor-app-hub)
- [Monitor ASP.NET Core web applications](/azure/azure-monitor/azure-monitor-app-hub)
- [Monitor Node.js applications](/azure/azure-monitor/app/nodejs-quick-start)
- [Monitor mobile applications](/azure/azure-monitor/app/mobile-center-quickstart)
- [Monitor web applications](/azure/azure-monitor/app/website-monitoring)
- [Monitor VMs hosting traditional applications](/azure/azure-monitor/vm/monitor-virtual-machine)

## Next steps

Learn about tools to accelerate customer adoption through digital support for your build-measure-learn cycles.

> [!div class="nextstepaction"]
> [Interact with devices](./devices.md)
