---
title: Set up machine learning workspaces
description: Understand the factors that influence how you set up your machine learning workspaces, and determine the best structure and controls for each workspace.
author: BrianBlanchard
ms.author: brblanch
ms.date: 12/07/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: innovate
---

# Set up Azure Machine Learning workspaces

Multiple factors can influence how you set up your machine learning workspaces, and they can help you to determine the best structure and controls for each type:

![A diagram of how to set up Azure Machine Learning workspaces.](media/set-up-workspaces.png)

1. **Public, restricted:**
   - Development, test, and production workspace
   - Custom role: data scientist
   - Git integration for version control and continuos integration/continuous development (CI/CD)
   
1. **Public, not restricted:**
   - Development, test, and production workspace
   - Role: contributor
   - Git Integration for version Control and CI/CD
   
1. **Private, restricted:**
   - Development, test, and production workspace
   - Private link enabled
   - Custom role: data scientist
   - Git integration for version control and CI/CD
   
1. **Private, not restricted:**
   - Development, test, and production workspace
   - Private link enabled
   - Role: contributor
   - Git integration for version control and CI/CD
   
1. **All workspaces:**
   - One Azure Machine Learning Studio workspace per project
   - One compute instance per data scientist
   - One compute cluster per virtual machine size shared with data scientists for development
   - One compute cluster per production pipeline
   - Setting the compute cluster minimum node size to 0 to reduce costs
   - Instructing users to shut down compute instances manually after use
   - A 'workspace admin' custom role with access to create compute instances and clusters
   - A 'data scientist' custom role requiring all infrastructure to be set up by another user before the data scientist can begin work