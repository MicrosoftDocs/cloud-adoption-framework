---
title: Enterprise Scale Analytics and AI Data Science Blueprint
description: Enterprise Scale Analytics and AI Architecture Data Science Blueprint
author:  abdale
ms.author: hamoodaleem # Microsoft employees only
ms.date: 03/03/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Data Science Blueprint

Commonly, there are two types of scenarios for data science projects:

1. Ad-hoc analysis
There can be data scientists, which require an environment for quick ad-hoc analysis. This can be the case for multiple reasons, but often this is the case because the data science project is not setup yet, which means that for example a project manager is still missing or a cost code/cost center has not been provided yet, which is required for cross-charging within Azure. Still, these users require access to an environment to get an understanding of the data and maybe make a first evaluation regarding the feasibility of the project. Also, there can be projects, where a full data science environment setup is not required, because there are just a few datasets loaded and evaluated.

2. Full Data Science project
In other cases, a full project setup is required, with a dedicated environment, project management, cost code/cost center etc. When multiple team members want to collaborate, share results and need to operationalize models after the exploration phase has been successful, these kind of project setups are required.

## Overview

Having a blueprint developed for Data Science projects, which bundles a set of services is essential in order to have consistency through different use cases between different data science teams. Therefor, To drastically shorten the deployment time, it is recommended developing a consistent blueprint (template repository) that can be used for all Data Science projects. This pattern should consist of a set of ARM templates to deploy an Azure Machine Learning workspace with Key Vault, Storage account, Application Insights and Container Registry. Also included should be the setup of the compute targets, such as Compute Instances, Compute Clusters and Databricks, and the setup of datastores. Lastly, the templates should also include a Data Factory deployment as well as a general Cognitive Services instance. This setup should provide all the necessary tools to execute the data science exploration phase as well as the initial operationalization of the model.

## Setup Process

This setup should be deployed on a project basis. Each project should receive at least two instances in order to have a development and production environment. In the production environment, no individual person should have access, and everything should be deployed through CI/CD pipelines and a service principal. This is very important, because Azure Machine Learning currently does not provide a granular RBAC model within a workspace, which means that users access cannot be limited to a certain set of experiments, endpoints or pipelines. The same access rights generally apply for all artifacts of a certain type. Therefore, it is important to separate development from production to prevent accidental deletion of production pipelines or endpoints within a workspace.

In addition to the template, a process needs to be built in order to give the data product teams the possibility to request new environments.

## Different AI Services

 Regarding different AI services such as Cognitive Services, it is highly recommended deploying these services on a project basis, which means deployment per data product or data domain resource group. This creates a clear separation from a data access standpoint and mitigates the risk of unauthorized data access by wrong teams.
