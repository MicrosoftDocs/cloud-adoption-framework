---
title: Setting up Azure Machine Learning for Enterprise scale
description: When planning an Azure Machine Learning deployment for an enterprise environment, there are common decision points and scenarios that impact how you create the Workspace.
author: denniseik
ms.author: deeikele
ms.date: 22/03/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

This article discusses decision points when creating a Workspace. When planning an Azure Machine Learning deployment for an enterprise environment, there are some common decision points or scenarios that impact how you create the Workspace. These decision points are:

* Team structure, meaning the way your Machine Learning teams are organized and collaborate on projects given use case and data segregation, or cost management requirements.
* Environments used as part of your development and release workflow to segregate development from production.
* Regionality of your data or the audience you need to serve your ML solution to. 

# How does team structure impact Workspace set up?

The Workspace is the top-level resource in Azure Machine Learning, holding Azure Machine Learning artifacts produced when working with Azure ML, as well as managed compute and pointers to attached and associated resources. From a manageability standpoint, the Workspace as an ARM-resource allows for Role Based Access Control, management by Policy, and can be used as a unit for cost reporting.  

Organizations typically choose for one or a combination of the below solution patterns to comply with manageability requirements.

1. A **Workspace per team** is typically chosen when all members of team require the same level of access to data and experimentation assets.   For instance, an organization with three ML-teams might create three workspaces, one for each team. 

  Benefits: As a result, all ML-related artefacts for all projects run by that team are found in a single place. This can boost productivity since it makes exploration of experimentation results from peers on the team accessible and more easily reusable. Organization by team typically means a low Azure resource footprint and allows for cost management per team. Since experimentation assets can grow fast, follow proper naming and tagging conventions to keep artifacts organized.

  To consider: Since granular RBAC and “ACL”'ing of data sources and experimentation assets is limited within a Workspace, each user of the Workspace must have similar data access level permissions and no use case data segregation requirements must exists.

1. A **Workspace per project** is common for teams that require segregation of data and experimentation assets by project or face cost reporting and budgeting requirements on a project-level. For instance, an organization with four ML teams that each runs three projects, might create 12 Workspace instances in total.

Benefits: As a result, cost can be managed on a project-level. Teams typically choose to create a dedicated resource group for Azure ML and associated resources for similar reasons. When working with external contributors, the project-centered Workspace set up also allows for easier collaboration on a project, since external users only need to be granted access to the project resources and not for the team. 

To consider: The isolation of experimentation results and assets might make discovery and reuse more difficult within the organization due to assets being scattered across multiple Workspace instances.

1. A **Single Workspace** for every user is typically chosen for non-team or non-project related work, or when costs cannot be directly associated to a specific unit of billing like is the case with R&D. 

Benefits: As a result, cost of individual non-project related work can be decoupled from project-related cost. When setting up a single workspace for all users to do individual work, this means a significantly lower Azure resource footprint compared to a set up where N workspaces would exist for N users to facilitate individual work. 

To consider: The Workspace might become cluttered quickly when many ML practitioners share the same instance. Users possibly require UI-based filtering of assets to effectively find one's own resources. Consider creating shared ML Workspaces per business division to mitigate scale concerns or to segment budgets.
