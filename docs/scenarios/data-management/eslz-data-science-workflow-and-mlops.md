---
title: Enterprise Scale Analytics and AI Data Science Workflow and MLOps
description: Enterprise Scale Analytics and AI Data Science Workflow and MLOps
author:  abdale
ms.author:  abdale # Microsoft employees only
ms.date: 03/03/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Data Science Workflow and MLOps

## Git

### Including sample code in data science repositories

Data Science projects can be significantly simplified and accelerated, if certain artifacts and best practices are provided to the teams. Therefore, the CAE team suggests creating artifacts, which can be leveraged by all data science teams working on Azure with Azure Machine Learning and the respective tools that are part of the Data Product environment. The artifacts should be created and provided by Data and ML engineers. These artifacts should include:

1. **Sample notebooks** that show how to

    - Load, mount and work with datasets,
    - Log metrics and parameters
    - Submit a training job to compute clusters.

1. **Artifacts** that are required for operationalization, which includes:

    - Sample Azure Machine Learning Pipeline
    - Sample Azure DevOps pipelines
    - Additional scripts required to execute the pipeline

1. **Documentation**

These artifacts will significantly speed up the exploration and operationalization phase for data science projects and can be scaled across all projects. To scale these artifacts across all projects, a DevOps forking strategy could be used.

Such a setup will also promote the use of git because users will benefit from the provided artifacts.

In addition, the automation process will greatly benefit from these artifacts. The Azure Machine Learning sample pipelines should be either build using the Python SDK or should be based on the new yaml language. The new yaml experience will be more future proof as the AML product team is currently working on a new SDK and CLI offering that will place it’s bet on yaml as a definition language for all artifacts within Azure Machine Learning. These sample pipelines will not necessarily work out of the box for each and every project, but can be used as a baseline and finetuned for the respective projects. The pipeline itself should include the most relevant aspects for each project such as referencing a compute target, referencing datasets, defining parameters, defining inputs and defining two execution steps.

The same should be done for the Azure DevOps pipelines. The pipelines should demonstrate how users can connect to a workspace from within a DevOps pipeline, how to check whether the required compute is available, how to submit a job, how to register a model and deploy a model. The DevOps pipelines should also make use of the Azure Machine Learning SDK or CLI.

In summary, these artifacts will not fit all projects 100% and require customization, but even having the first 60 or 80% in place will speed up project operationalization and deployment significantly.

### Standard Repository Folder Structure

In order to avoid situations where users can lose track of where differents artifacts are stored, requiring additional time for communications in order to understand folder's structure, it is recommended putting a standard top-level folder structure in place, which all projects should follow. This can be bundled with the previous recommendation included in the above sections.
The concepts mentioned in this section can be used across all environments: on-premises, AWS, Palantir and Azure.

The proposed top-level folder structure is illustrated in the following image:

![MLOps Repository Structure](./images/repository-structure.png)
*Figure 1. MLOps Repository Structure*

The folders are fulfilling the following purposes:

- **.cloud**
Cloud specific code and artifacts should be stored in this folder. This includes configuration files for the Azure Machine Learning workspace, including the definition of compute targets, jobs, registered models and endpoints.
- **.ado/.github**
This folder should be used to store Azure DevOps or GitHub related artifacts, such as yaml pipelines or definition of codeowners.
- **code**
The code folder should include the actual code that is developed as part of the project. In this folder can be python packages and some scripts that are used for the respective steps of the machine learning pipeline. Inside this folder, we propose a separation by individual steps that need to be performed. Common steps are preprocessing, model training and model registration. For each step, there should be a definition of the dependencies provided (conda dependencies, docker image, etc.).
- **docs**
Docs is used for documentation purposes. This folder houses markdown files and images to describe the project.
- **pipelines**
This folder is used to store the definition of Azure Machine Learning pipelines in yaml or Python language.
- **tests**
The tests folder is used for writing unit and integration tests that need to be executed to discover bugs and issues early on in the project.
- **notebooks**
A notebooks folder is used to separate jupyter notebooks from the actual python project. Inside the folder, each individual should have a subfolder to check in their notebooks and prevent git conflicts. The reason for this is that there are known issues wrt. git and jupyter notebooks.
