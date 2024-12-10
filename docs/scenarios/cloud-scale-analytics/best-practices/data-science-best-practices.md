---
title: Best practices for data science projects with cloud-scale analytics in Azure
description: Learn about best practices for data science projects with cloud-scale analytics in Azure.
author: abdale
ms.author: hamoodaleem
ms.date: 05/07/2024
ms.topic: conceptual
ms.custom: e2e-data-management, think-tank
---

# Best practices for data science projects with cloud-scale analytics in Azure

We recommend these best practices for using cloud-scale analytics in Microsoft Azure to operationalize data science projects.

## Develop a template

Develop a template that bundles a set of services for your data science projects. Use a template that bundles a set of services to help provide consistency across various data science teams' use cases. We recommend that you develop a consistent blueprint in the form of a template repository. You can use this repository for various data science projects within your enterprise to help shorten deployment times.

### Guidelines for data science templates

Develop a data science template for your organization with the following guidelines:

- Develop a set of infrastructure as code (IaC) templates to deploy an Azure Machine Learning workspace. Include resources like a key vault, a storage account, a container registry, and Application Insights.

- Include the setup of data stores and compute targets in these templates, like compute instances, compute clusters, and Azure Databricks.

## Deployment best practices

### Real-time

- Include an Azure Data Factory or Azure Synapse deployment in templates and Azure Cognitive Services.
- The templates should provide all necessary tools to execute the data science exploration phase and the initial operationalization of the model.

### Considerations for an initial setup

In some cases, data scientists in your organization might require an environment for quick as-needed analysis. This situation is common when a data science project isn't formally set up. For example, a project manager, cost code, or cost center that might be required for cross-charging within Azure might be missing because the missing element needs approval. Users in your organization or team might need to access a data science environment to understand the data and possibly evaluate a project's feasibility. Also, some projects might not require a full data science environment because of the small number of data products.

In other cases, a full data science project might be required, complete with a dedicated environment, project management, cost code, and cost center. Full data science projects are useful for multiple team members who want to collaborate, share results, and need to operationalize models after the exploration phase succeeds.

### The setup process

Templates should be deployed on a per-project basis after they've been set up. Each project should receive at least two instances for development and production environments to be separated. In the production environment, no individual person should have access, and everything should be deployed through continuous integration or continuous development pipelines and a service principal. These production environment principles are important because Azure Machine Learning doesn't provide a granular role-based access control model within a workspace. You can't limit user access to a specific set of experiments, endpoints, or pipelines.

The same access rights typically apply to different types of artifacts. It's important to separate development from production to prevent the deletion of production pipelines or endpoints within a workspace. Along with the template, a process needs to be built to give data product teams the option to request new environments.

We recommend setting up different AI services like Azure Cognitive Services on a per-project basis. By setting up different AI services on a per-project basis, deployments occur for each data product resource group. This policy creates a clear separation from a data access standpoint and mitigates the risk of unauthorized data access by the wrong teams.

### Streaming scenario

For real-time and streaming use cases, deployments should be tested on a downsized [Azure Kubernetes Service (AKS)](/azure/aks/). The testing can be in the development environment to save on costs before you deploy to the production AKS or Azure App Service for containers. You should perform simple input and output tests to make sure that the services respond as expected.

Next, you can deploy models to the service you want. This deployment compute target is the only one that's generally available and recommended for production workloads in an AKS cluster. This step is more necessary if graphics processing unit (GPU) or field-programmable gate array support is required. Other native deployment options that support these hardware requirements aren't currently available in Azure Machine Learning.

Azure Machine Learning requires one-to-one mapping to AKS clusters. Every new connection to an Azure Machine Learning workspace breaks the previous connection between AKS and Azure Machine Learning. After that limitation is mitigated, we recommended deploying central AKS clusters as shared resources and attach them to their respective workspaces.

Another central test AKS instance should be hosted if stress tests should be done before you move a model to the production AKS. The test environment should provide the same compute resource as the production environment to ensure that the results are as similar as possible to the production environment.

### Batch scenario

Not all use cases need AKS cluster deployments. A use case doesn't need an AKS cluster deployment if large data amounts only need scoring regularly or are based on an event. For example, large data amounts can be based on when data drops into a specific storage account. Azure Machine Learning pipelines and Azure Machine Learning compute clusters should be used for deployment during these types of scenarios. These pipelines should be orchestrated and executed in Data Factory.

### Identify the right compute resources

Before you deploy a model in Azure Machine Learning to an AKS, the user needs to specify the resources like CPU, RAM, and GPU that should be allocated for the respective model. Defining these parameters can be a complex and tedious process. You need to do stress tests with different configurations to identify a good set of parameters. You can simplify this process with the **Model Profiling** feature in Azure Machine Learning, which is a long-running job that tests different resource allocation combinations and uses an identified latency and round trip time (RTT) to recommend an optimal combination. This information can assist the actual model deployment on AKS.

To safely update models in Azure Machine Learning, teams should use the controlled rollout feature (preview) to minimize downtime and keep the model's REST endpoint consistent.

## Best practices and the workflow for MLOps

### Include sample code in data science repositories

You can simplify and accelerate data science projects if your teams have certain artifacts and best practices. We recommend creating artifacts that all data science teams can use while working with Azure Machine Learning and the data product environment's respective tools. Data and machine learning engineers should create and provide the artifacts.

These artifacts should include:

- Sample notebooks that show how to:

  - Load, mount, and work with data products.
  - Log metrics and parameters.
  - Submit training jobs to compute clusters.

- Artifacts required for operationalization:

  - Sample Azure Machine Learning pipelines
  - Sample Azure Pipelines
  - More scripts required to execute pipelines

- Documentation

### Use well-designed artifacts to operationalize pipelines

Artifacts can speed up data science projects' exploration and operationalization phases. A DevOps forking strategy can help to scale these artifacts across all projects. Since this setup promotes the use of Git, users and the overall automation process can benefit from the provided artifacts.

> [!TIP]
> Azure Machine Learning sample pipelines should built with the Python software developer kit (SDK) or based on the YAML language. The new YAML experience will be more future-proof, as the Azure Machine Learning product team is currently working on a new SDK and command line interface (CLI). The Azure Machine Learning product team is confident that YAML will serve as the definition language for all artifacts within Azure Machine Learning.

Sample pipelines don't work out of the box for each project, but they can be used as a baseline. You can adjust sample pipelines for projects. A pipeline should include the most relevant aspects of each project. For example, a pipeline can reference a compute target, reference data products, define parameters, define inputs, and define the execution steps. The same process should be done for Azure Pipelines. Azure Pipelines should also use the Azure Machine Learning SDK or CLI.

Pipelines should demonstrate how to:

- Connect to a workspace from within a DevOps pipeline.
- Check whether the required compute is available.
- Submit a job.
- Register and deploy a model.

Artifacts aren't suited for all projects all the time and might require customization, but having a foundation can speed up a project's operationalization and deployment.

### Structure the MLOps repository

You might have situations where users lose track of where they can find and store artifacts. To avoid these situations, you should request more time to communicate and construct a top-level folder structure for the standard repository. All projects should follow the folder structure.

> [!NOTE]
> The concepts mentioned in this section can be used across on-premises, Amazon Web Services, Palantir, and Azure environments.

The proposed top-level folder structure for a MLOps (machine learning operations) repository is illustrated in the following diagram:

![Diagram of the repository structure for MLOps.](../images/repository-structure.png)

The following purposes apply to each folder in the repository:

|Folder | Purpose |
|--|--|
|`.cloud` | Store cloud-specific code and artifacts in this folder. The artifacts include configuration files for the Azure Machine Learning workspace, including compute target definitions, jobs, registered models, and endpoints. |
|`.ado/.github` | Store Azure DevOps or GitHub artifacts like YAML pipelines or code owners in this folder. |
|`code` | Include the actual code that's developed as part of the project in this folder. This folder can contain Python packages and some scripts that are used for the respective steps of the machine learning pipeline. We recommend separating individual steps that need to be done in this folder. Common steps are **preprocessing**, **model training**, and **model registration**. Define dependencies like Conda dependencies, Docker images, or others for each folder. |
|`docs` | Use this folder for documentation purposes. This folder stores Markdown files and images to describe the project. |
|`pipelines` | Store Azure Machine Learning pipelines definitions in YAML or Python in this folder. |
|`tests` | Write unit and integration tests that need to be executed to discover bugs and issues early during the project in this folder. |
|`notebooks` | Separate Jupyter notebooks from the actual Python project with this folder. Inside the folder, each individual should have a subfolder to check in their notebooks and prevent Git merge conflicts. |

## Next step

[Cloud-scale analytics data products in Azure](../architectures/data-landing-zone-data-products.md)
