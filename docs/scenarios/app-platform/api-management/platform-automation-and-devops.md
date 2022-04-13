---
title: Platform automation and DevOps for Azurew API Management
description: <<Describe how this landing zone accelerator can improve platform automation and devops of Azure API Management.>>
author: BrianBlanchard
ms.author: brblanch
ms.date: 04/12/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: internal
---

# Platform automation and devops for API Managment landing zone accelerator

[Intro paragraph. Disclose any required dependency on ESLZ design area or other ALZ design areas, with links to those supporting materials.]

## Design considerations

The following is a bulleted list of things you must think about when preparing for **any** deployment of API Management.

- Each API team can push updates from their own developer repo to their own development API Management instance.
    - What does this mean from a network planning perspective?
    - What about other nonproduction environments (QA, Staging etc)
- Consider how products and other entities should be managed/versioned especially if multiple teams use the same products.
- Consider the testing strategy for APIs and policies.

## Design recommendations

The following is a bulleted list of best practices that should be included in any deployment of API Management.

- A central team (e.g. API Management admin team) manages the production API Management environment.
- API Management configurations are represented as Resource Manager templates and an infrastructure-as-code mindset should be embraced.
- The API Management admin team will publish configuration changes to the production API Management environment from a Git repository (publisher repo) owned by the API Management admin team.
- Each individual API team may fork the publisher repo to have their own developer repo to work from.
- Each team can use the API Management [DevOps Resource Kit](https://github.com/Azure/azure-api-management-devops-resource-kit) or the [API Management extension](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-apimanagement) for Visual Studio Code to extract the relevant artifacts from their development API Management instance. These artifacts are based on ARM and should be committed to the API team’s Git repo. 
    - Do not use the API Management [Git integration](/azure/api-management/api-management-configuration-repository-git)
- Service templates and shared templates should be in separate repos
- Use the [“Extract all APIs with separated API folders“ option](https://github.com/Azure/azure-api-management-devops-resource-kit/blob/main/src/README.md#extractor)
- Changes to artifacts should be done to the extracted artifacts and then committed to Git. These should be deployed to a dev environment 
- To promote to the centralized environments (staging, production), API teams can submit a pull request (PR) to merge their changes to the publisher repo. 
- The API Management admin team validates the PR.
    - Ideally most of the validations are automated as part of submitting a PR.
- The IAC templates should be in a different repo – and deployed in a deployment pipeline
    - Separate infrastructure deployment from application deployment. Core infrastructure changes less than applications. Treat each type of deployment as a separate flow and pipeline.
- Once changes are approved and merged successfully, the API Management admin team can deploy the changes to the centrally managed environment (staging, production) in coordination with agreed-upon API team schedules. 

## Enterprise-scale assumptions

The following are assumptions that went into the development of the deployable asset: Enterprise-scale for API Management.

## Additional considerations

Create as many H2 "##" headers as is required to educate the customer on this topic.