---
title: Understand best practices for data science projects with enterprise-scale for analytics and AI in Azure
description: Learn about best practices for data science projects with enterprise-scale for analytics and AI in Azure.
author: abdale
ms.author: hamoodaleem
ms.date: 08/06/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank, e2e-data
---

# Understand best practices for data science projects with enterprise-scale for analytics and AI in Azure

We recommend these best practices for how to use enterprise-scale for analytics and AI in Azure to operationalize data science projects.

## Develop a blueprint

It's essential to develop a blueprint that bundles a set of services for your data science projects is essential for consistency across different data science teams' use cases. We recommend developing a consistent blueprint in the form of a template repository that can be used for various data science projects within your enterprise. It will help shorten deployment times.

### Guidelines for data science templates

Following are guidelines on developing a data science template for your organization:

- Develop a set of infrastructure as code templates to deploy an Azure Machine Learning workspace. Include resources like a key vault, storage account, Azure Application Insights, and container registry.

- Include the setup of data stores and compute targets in these templates like compute instances, compute clusters, and Azure Databricks.

- Include an Azure Data Factory or Azure Synapse deployment in templates and Cognitive Services.

- The templates should provide all necessary tools to execute the data science exploration phase and the initial operationalization of the model.

### Considerations for an initial setup

In some cases, data scientists in your organization might require an environment for quick ad hoc analysis. It's common when a data science project isn't formally set up. For example, a project manager, cost code, or cost center, that might be required for cross-charging within Azure, might be missing because it needs approval. Users in your organization or team might need to access a data science environment to understand the data and possibly evaluate a project's feasibility. Also, some projects might not require a full data science environment because of the small number of datasets.

In other cases, a full data science project might be required, complete with a dedicated environment, project management, cost code, and cost center. Projects that are set up like this are typically required when multiple team members want to collaborate, share results, and need to operationalize models after the exploration phase succeeds.

### The setup process

Templates should be deployed on a per-project basis after they've been set up. Each project should receive at least two instances for development and production environments to be separated. In the production environment, no individual person should have access, and everything should be deployed through continuous integration/continuous development pipelines and a service principal. It's important because Azure Machine Learning doesn't provide a granular role-based access control model within a workspace. User access can't be limited to a specific set of experiments, endpoints, or pipelines.

The same access rights typically apply to different types of artifacts. So, it's important to separate development from production to prevent production pipelines or endpoints from being deleted within a workspace. Along with the template, a process needs to be built to give data product teams the option to request new environments.

We recommend setting up different AI services like Azure Cognitive Services on a per-project basis. The result is deployments occur for each data product resource group. It creates a clear separation from a data access standpoint and mitigates the risk of unauthorized data access by the wrong teams.

## Deployment best practices

### Real-time streaming scenario

For streaming and real-time use cases, deployments should be tested on a downsized [Azure Kubernetes Service (AKS)](/azure/aks/). The testing can be in the development environment to save on costs before you deploy to the production AKS or Azure App Service for containers. Simple input and output tests should be performed to make sure that the services respond as expected.

Next, you can deploy models to the service you want. This deployment compute target is the only one that's generally available and recommended for production workloads in an AKS cluster. This step is more necessary if graphics processing unit (GPU) or field-programmable gate array support is required. Other native deployment options that support these hardware requirements aren't currently available in Azure Machine Learning.

Azure Machine Learning requires one-to-one mapping to AKS clusters. Every new connection to an Azure Machine Learning workspace breaks the previous connection between AKS and Azure Machine Learning. Once that limitation is mitigated, we recommended deploying central AKS clusters as shared resources and attach them to their respective workspaces.

Another central test AKS instance should be hosted if stress tests should be done before you move a model to the production AKS. The test environment should provide the same compute resource as the production environment to ensure that the results are as similar as possible to the production environment.

### Batch scenario

Not all use cases require AKS cluster deployments, especially if large data amounts only need to be scored regularly or be based on an event like data being dropped in a specific storage account. Azure Machine Learning pipelines and Azure Machine Learning compute clusters should be used for deployment during these types of scenarios. These pipelines should be orchestrated and executed in Data Factory.

### Identify the right compute resources

Before you deploy a model in Azure Machine Learning to an AKS, the user needs to specify the resources like CPU, RAM, and GPU that should be allocated for the respective model. Defining these parameters can be a complex and tedious process. Stress tests with different configurations need to be done to identify a good set of parameters. This process can be simplified with the **Model Profiling** feature in Azure Machine Learning, which is a long-running job that tests different resource allocation combinations and uses an identified latency and RTT to recommend an optimal combination. This information can assist the actual model deployment on AKS.

To safely update models in Azure Machine Learning, teams should use the controlled rollout feature (preview) to minimize downtime and keep the model's REST endpoint consistent.

## Best practices and the workflow for Machine Learning operations

### Include sample code in data science repositories

Data science projects can be simplified and accelerated if certain artifacts and best practices are provided to teams. We recommend creating artifacts that can be used by all data science teams working on Azure with Azure Machine Learning and respective tools that are part of the data product environment. The artifacts should be created and provided by data and machine learning engineers.

These artifacts should include:

- Sample notebooks that show how to:

  - Load, mount, and work with datasets.
  - Log metrics and parameters.
  - Submit training jobs to compute clusters.

- Artifacts required for operationalization:

  - Sample Azure Machine Learning pipelines
  - Sample Azure Pipelines
  - More scripts required to execute pipelines

- Documentation.

### Use well-designed artifacts to operationalize pipelines

Artifacts can speed up data science projects' exploration and operationalization phases. A DevOps forking strategy can help to scale these artifacts across all projects. Since this setup promotes the use of Git, users and the overall automation process can benefit from the artifacts provided.

> [!TIP]
> Azure Machine Learning sample pipelines should built with the Python software developer kit (SDK) or based on the YAML language. The new YAML experience will be more future-proof, as the Azure Machine Learning product team is currently working on a new SDK and command line interface (CLI). They are confident that YAML will serve as the definition language for all artifacts within Azure Machine Learning.

Sample pipelines won't work out of the box for each project, but they can be used as a baseline. You can adjust them for projects. A pipeline should include the most relevant aspects of each project. For example, referencing a compute target, referencing datasets, defining parameters, defining inputs, and defining the execution steps. The same should be done for Azure Pipelines. Azure Pipelines should also use the Azure Machine Learning SDK or CLI.

Pipelines should demonstrate how to:

- Connect to a workspace from within a DevOps pipeline.
- Check whether the required compute is available.
- Submit a job.
- Register and deploy a model.

Artifacts won't suit all projects all the time and may require customization, but having a foundation can speed up a project's operationalization and deployment.

### Structure the Machine Learning operations repository

To avoid situations where users might lose track of where you store artifacts, we recommend requesting more time to communicate and construct a top-level folder structure for the standard repository where all projects should follow.

> [!NOTE]
> The concepts mentioned in this section can be used across on-premises, Amazon Web Services, Palantir, and Azure environments.

The proposed top-level folder structure for a Machine Learning operations repository is illustrated in the following:

![Diagram of the repository structure for Machine Learning operations.](../images/repository-structure.png)

The following purposes apply to each folder in the repository:

|Folder  |Purpose  |
|---------|---------|
|`.cloud`     |Cloud-specific code and artifacts should be stored in this folder. The artifacts include configuration files for the Azure Machine Learning workspace, including compute target definitions, jobs, registered models, and endpoints.         |
|`.ado/.github`     |This folder should be used to store Azure DevOps or GitHub artifacts like YAML pipelines or code owners.         |
|`code`     |This folder should include the actual code that's developed as part of the project. This folder can contain Python packages and some scripts that are used for the respective steps of the machine learning pipeline. We recommend separating individual steps that need to be done in this folder. Common steps are **preprocessing**, **model training**, and **model registration**. Dependencies like Conda dependencies, Docker images, or others should be defined for each folder.         |
|`docs`     |This folder is used for documentation purposes. This folder stores Markdown files and images to describe the project.         |
|`pipelines`     |This stores Azure Machine Learning pipelines definitions in YAML or Python.         |
|`tests`     |The folder is used for writing unit and integration tests that need to be executed to discover bugs and issues early during the project.         |
|`notebooks`     |This folder is used to separate Jupyter notebooks from the actual Python project. Inside the folder, each individual should have a subfolder to check in their notebooks and prevent Git merge conflicts.         |

## Next steps

[Azure Machine Learning as a data product](./azure-machine-learning.md)
