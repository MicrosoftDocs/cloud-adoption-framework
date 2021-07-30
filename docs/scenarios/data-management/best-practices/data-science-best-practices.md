---
title: Understand best practices for data science projects with enterprise-scale for analytics and AI in Azure
description: Learn about best practices for data science projects with enterprise-scale for analytics and AI in Azure
author:  abdale
ms.author: hamoodaleem 
ms.date: 08/06/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank, e2e-data
---

# Understand best practices for data science projects with enterprise-scale for analytics and AI in Azure

The following best practices are recommended for how to use enterprise scale analytics and AI in Azure to operationalize data science projects.

## Develop a blueprint

Developing a blueprint that bundles a set of services for your data science projects is essential for consistency across different data science teams' use cases. To shorten deployment times, it's recommended to develop a consistent blueprint in the form of a template repository that can be used for various data science projects within your enterprise.

### Guidelines for data science templates

Following are guidelines on developing a data science template for your organization:

1. Develop a set of infrastructure-as-code templates to deploy an Azure Machine Learning workspace with resources like a key vault, storage account, Azure Application Insights, and Container Registry.

1. Include the setup of data stores and compute targets in these templates like compute instances, compute clusters, and Azure Databricks.

1. Include an Azure Data Factory or Synapse deployment in templates and Cognitive Services.

1. The templates should provide all necessary tools to execute the data science exploration phase as well as the initial operationalization of the model.

### Considerations for an initial setup

In some cases, data scientists in your organization might require an environment for a quick ad-hoc analysis. This is often the case when a data science project isn't formally set up; for example, a project manager, cost code, or cost center (that could be required for cross-charging within Azure) might be missing because it has yet to be approved. Users in your organization or team might need to access a data science environment to understand the data and possibly evaluate a project's feasibility. Also, some projects might not require a full data science environment because of the small number of datasets.

In other cases, a full data science project might be required, complete with a dedicated environment, project management, cost code, and cost center. These types of project setups are typically required when multiple team members want to collaborate, share results, and need to operationalize models after the exploration phase succeeds.

### The setup process

Templates should be deployed on a per-project basis after they've been set up. Each project should receive at least two instances for development and production environments to be separated. In the production environment, no individual person should have access, and everything should be deployed through continuous integration/continuous development pipelines and a service principal. This is important because Azure Machine Learning doesn't currently provide a granular role-based access control model within a workspace, which means that user access can't be limited to a specific set of experiments, endpoints, or pipelines. The same access rights typically apply to different types of artifacts. Therefore, it's important to separate development from production to prevent production pipelines or endpoints from being deleted within a workspace. In addition to the template, a process needs to be built to give Data Product teams the option to request new environments.

It's recommended to set up different AI services like Azure Cognitive Services on a per-project basis, which means that deployments occur for each data product resource group. This creates a clear separation from a data access standpoint and mitigates the risk of unauthorized data access by the wrong teams.

## Deployment best practices

### Real-time streaming scenario

For streaming and real-time use cases, deployments should be tested on a downsized [Azure Kubernetes Service (AKS)](/azure/aks/) in the development environment to save costs before deploying them to the production AKS or Azure App Service for containers. Simple input and output tests should be performed to make sure that the services respond as expected.

Next, models can be deployed to a desired service. The only deployment compute target today that is GA and is recommended for production workloads in an AKS cluster. This is more necessary if graphics processing unit (GPU) or field-programmable gate array support is required. Other native deployment options that supports these hardware requirements aren't currently available in Azure Machine Learning. Today, Azure Machine Learning requires one-to-one mapping to AKS clusters. Every new connection to an Azure Machine Learning workspace breaks the previous connection between AKS and Azure Machine Learning. Once that limitation is mitigated, it's recommended to deploy central AKS clusters as shared resources and attach them to their respective workspaces. An additional central test AKS instance should then also be hosted if stress tests need to be performed before moving a model to the production AKS. The test environment should provide the same compute resource as the production environment to ensure that the results are as similar as possible to the production environment.

### Batch scenario

Not all use cases require AKS cluster deployments, especially if large data amounts only need to be scored on a regular basis or be based on an event like data being dropped in a specific storage account. Azure Machine Learning pipelines and Azure Machine Learning compute clusters should be used for deployment during these types of scenarios. These pipelines should be orchestrated and executed in Data Factory.

### Identify the right compute resources

Before deploying a model in Azure Machine Learning to an AKS, the user needs to specify the resources (CPU, RAM, GPU) that should be allocated for the respective model. Defining these parameters can be a complex and tedious process. Stress tests with different configurations need to be performed to identify a good set of parameters. This process can be simplified with the **Model Profiling** feature in Azure Machine Learning, which is a long-running job that tests different resource allocation combinations and uses an identified latency and RTT to recommend an optimal combination. This information can assist the actual model deployment on AKS.

To safely update models in Azure Machine Learning, teams should use the controlled rollout feature (preview) to minimize the downtime and keep the model REST endpoint consistent.

## Best practices and the workflow for Machine Learning Operations

### Include sample code in data science repositories

Data science projects can be simplified and accelerated if certain artifacts and best practices are provided to teams. Therefore, it's recommended to create artifacts that can be used by all data science teams working on Azure with Azure Machine Learning and respective tools that are part of the data product environment. The artifacts should be created and provided by data and machine learning engineers.

These artifacts should include:

1. **Sample notebooks** that show how to:

    - Load, mount, and work with datasets.
    - Log metrics and parameters.
    - Submit training jobs to compute clusters.

2. **Artifacts** required for operationalization:

    - Sample Azure Machine Learning pipelines
    - Sample Azure DevOps pipelines
    - Additional scripts required to execute pipelines

3. **Documentation**

### Use well-designed artifacts to operationalize pipelines

Artifacts can speed up data science projects' exploration and operationalization phases, and a DevOps forking strategy can help to scale these artifacts across all projects. Since this setup promotes the use of Git, users and the overall automation process can benefit from the artifacts provided.

> [!TIP]
> Azure Machine Learning sample pipelines should built with the Python software developer kit (SDK) or based on the YAML language. The new YAML experience will be more future-proof, as the Azure Machine Learning product team is currently working on a new SDK and command line interface (CLI). They are confident that YAML will serve as the definition language for all artifacts within Azure Machine Learning.

It is understood that any sample pipelines won't work out of the box for each project, but they can be used as a baseline and be adjusted for projects. A pipeline should include the most relevant aspects of each project, like such as referencing a compute target, referencing datasets, defining parameters, defining inputs, and defining the execution steps. The same should be done for Azure DevOps pipelines, and DevOps pipelines should also use the Azure Machine Learning SDK or CLI. 

Pipelines should demonstrate how to:
 
- Connect to a workspace from within a DevOps pipeline.
- Check whether the required compute is available.
- Submit a job.
- Register and deploy a model.

Artifacts won't suit all projects all the time and may require customization, but having a foundation can speed up a project's operationalization and deployment.

### Structure the Machine Learning Operations repository

To avoid situations where users might lose track of where different artifacts are stored, it's recommended to request additional time to communicate and understand folder structure and construct a top-level folder structure for the standard repository where all projects should follow. This can be bundled with the previous recommendations in the sections above.

> [!NOTE]
> The concepts mentioned in this section can be used across on-premises, Amazon Web Services, Palantir, and Azure environments.

The proposed top-level folder structure for Machine Learning Operations repository is illustrated in Figure one:

![The repository structure for Machine Learning Operations.](../images/repository-structure.png)

*Figure 1: The repository structure for Machine Learning Operations.*

The following purposes apply to each folder in the repository:

|Folder  |Purpose  |
|---------|---------|
|`.cloud`     |Cloud-specific code and artifacts should be stored in this folder. This includes configuration files for the Azure Machine Learning workspace, including compute target definitions, jobs, registered models, and endpoints.         |
|`.ado/.github`     |This folder should be used to store Azure DevOps or GitHub artifacts like YAML pipelines or code owners.         |
|`code`     |This folder should include the actual code that's developed as part of the project. This folder can contain Python packages and some scripts that are used for the respective steps of the machine learning pipeline. We recommend separating individual steps that need to be performed in this folder. Common steps are **preprocessing**, **model training**, and **model registration**. Dependencies like Conda dependencies, Docker images, or others should be defined for each folder.         |
|`docs`     |This folder is used for documentation purposes. This folder stores Markdown files and images to describe the project.         |
|`pipelines`     |This stores Azure Machine Learning pipelines definitions in YAML or Python.         |
|`tests`     |The folder is used for writing unit and integration tests that need to be executed to discover bugs and issues early during the project.         |
|`notebooks`     |This folder is used to separate Jupyter notebooks from the actual Python project. Inside the folder, each individual should have a subfolder to check in their notebooks and prevent Git merge conflicts.         |
