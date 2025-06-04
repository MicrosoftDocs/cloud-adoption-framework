---
title: Platform automation and DevOps for Azure API Management
description: Learn about design considerations and recommendations for platform automation and DevOps in the Azure API Management landing zone accelerator
author: Zimmergren
ms.author: pnp
ms.date: 04/12/2022
ms.topic: conceptual
ms.custom: internal
---

# Platform automation and DevOps for the API Management landing zone accelerator

This article provides design considerations and recommendations for platform automation and DevOps when using the API Management landing zone accelerator. Platform automation and DevOps provide opportunities to modernize your approach to environmental deployment with infrastructure-as-code options.

Learn more about the [platform automation and DevOps](../../../ready/landing-zone/design-area/platform-automation-devops.md) design area.

## Design considerations

- Each API team can push updates from their own developer repo to their own development API Management instance.
  - What does this mean from a network planning perspective?
  - What about other nonproduction environments (such as QA or staging)?
- Consider how products and other entities should be managed or versioned, especially if multiple teams use the same products.
- Consider the testing strategy for APIs and policies.

## Design recommendations

- A central team (for example, an API Management admin team) manages the production API Management environment.
- API Management configurations are represented as Resource Manager templates or equivalent Bicep or Terraform templates, and an infrastructure-as-code mindset should be embraced.
- The API Management admin team will publish configuration changes to the production API Management environment from a Git repository (publisher repo) owned by the API Management admin team.
- Each individual API team may fork the publisher repo to have their own developer repo to work from.
- Each team can use the API Management [APIOps](https://github.com/azure/apiops) or the [API Management extension](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-apimanagement) for Visual Studio Code to extract the relevant artifacts from their development API Management instance. These artifacts are based on Azure Resource Manager and should be committed to the API team’s Git repo.
    > [!NOTE]
    > Do not use the API Management [Git integration](/azure/api-management/api-management-configuration-repository-git).
- Service templates and shared templates should be in separate repos.
- Changes to artifacts should be done to the extracted artifacts and then committed to Git. These should be deployed to a dev environment.
- To promote to the centralized environments (staging, production, and so on), API teams can submit a pull request (PR) to merge their changes to the publisher repo.
- The API Management admin team validates the PR.
  - Ideally, most of the validations are automated as part of submitting a PR.
- The infrastructure-as-code templates should be in a different repo – and deployed in a deployment pipeline.
  - Separate infrastructure deployment from application deployment. Core infrastructure changes less frequently than applications. Treat each type of deployment as a separate flow and pipeline.
- After changes are approved and merged successfully, the API Management admin team can deploy the changes to the centrally managed environment (staging, production) in coordination with agreed-upon API team schedules.

## Enterprise-scale assumptions

The following are assumptions that went into the development of the API Management landing zone accelerator:

- Using infrastructure-as-code Bicep files to deploy API Management infrastructure and backends.
- Deployment of infrastructure templates using pipelines.

## Next steps

- [Automate API deployments with APIOps](/azure/architecture/example-scenario/devops/automated-api-deployments-apiops)
