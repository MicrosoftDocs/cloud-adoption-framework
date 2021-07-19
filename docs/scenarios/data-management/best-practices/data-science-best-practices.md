---
title: Best practices for Enterprise Scale Analytics and AI Data Science in Azure
description: Enterprise Scale Analytics and AI Architecture Data Science Environment
author:  abdale
ms.author: hamoodaleem # Microsoft employees only
ms.date: 03/03/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Best practices for data science projects in Enterprise Scale Analytics and AI

Following are recommended best practices for operationalizing data science projects in Enterprise Scale Analytics and AI.

## Developing a blueprint

Developing a blueprint for your data science projects which bundles a set of services is essential in order to have consistency through different use cases across data science teams. In order to drastically shorten deployment times, it is recommended to develop a consistent blueprint in the form of a template repository that can be used for various data science projects within your enterprise.

### Data science template guidelines

Following are guidelines on developing a data science template for your organization:

1. Develop a set of Infrastructure as Code (IaC) templates to deploy an Azure Machine Learning workspace with resources such as a key vault, storage account, Application Insights and Container Registry.
2. Include the setup of compute targets in these templates such as Compute Instances, Compute Clusters and Databricks, and the setup of data stores.
3. Include a Data Factory or Synapse deployment in templates as well as Cognitive Services.
4. The templates should provide all the necessary tools to execute the data science exploration phase as well as the initial operationalization of the model.

### Initial setup considerations

In some cases, data scientists in your organization may require an environment for quick **ad-hoc analysis**. This is often the case when a data science project is not formally setup yet, for example a project manager may still be missing or a cost code or cost center (which may be required for cross-charging within Azure) because it has not been approved yet. Regardless, users in your organization or team may require access to a data science environment to get an understanding of the data and maybe make a first evaluation regarding the feasibility of a project. Also, some projects may not require a full data science environment to be setup because of the small number of datasets.

In other cases, a **full data science project** may be required, complete with a dedicated environment, project management, cost code and cost center. When multiple team members want to collaborate, share results and need to operationalize models after the exploration phase has been successful, these kind of project setups are normally required.

### Setup process

Once setup, templates should be deployed on a per project basis. Each project should receive at least two instances in order to have separation between development and production environments. In the production environment, no individual person should have access and everything should be deployed through CI/CD pipelines and a service principal. This is very important because Azure Machine Learning currently does not provide a granular RBAC model within a workspace, which means that users access cannot be limited to only a certain set of experiments, endpoints or pipelines. The same access rights generally apply for all artifacts of a certain type. Therefore, it is important to separate development from production to prevent accidental deletion of production pipelines or endpoints within a workspace.

In addition to the template, a process needs to be built in order to give the data product teams the possibility to request new environments.

With regards to different AI services such as Cognitive Services, it is highly recommended to setup these services also on a per project basis which means deployments occur per data product resource group. This creates a clear separation from a data access standpoint and mitigates the risk of unauthorized data access by wrong teams.

## Deployment best practices

### Real Time Streaming Scenario

For streaming and real-time use cases, deployments should be tested on a downsized [Azure Kubernetes Service](/azure/aks/) (AKS) in the dev environment to save cost before deploying them onto the production [Azure Kubernetes Service](/azure/aks/) (AKS) or App Services for Containers. Simple input and output tests should be performed in order to make sure that the response of the services is as expected.

As a next step, models can be deployed to a desired service. The only deployment compute target today that is GA and is recommended for production workloads is an AKS cluster. This even more holds true if GPU or FPGA support is required. There is currently no other native deployment option available in Azure Machine Learning that supports these hardware requirements. Today, Azure Machine Learning requires a one to one mapping to AKS clusters. Every new connection to an Azure Machine Learning workspace breaks the previous connection between AKS and Azure Machine Learning. Once that limitation is mitigated, it is advised to deploy central AKS clusters as shared resource and attach them to to the respective workspaces. An additional central test AKS instance should then also be hosted if stress tests should be performed before moving a model onto the production AKS. The test environment should provide the same compute resource as the production environment to ensure that the results are as close as possible to the production environment. 

### Batch Scenario

Not all use cases require a deployment on an AKS cluster. In particular, if large amounts of data only need to be scored on a regular basis or based on an event, like data being dropped in a particular storage account.

For these kind of scenarios, Azure Machine Learning pipelines in combination with Azure Machine Learning compute clusters should be used for deployment. Execution of these pipelines should be orchestrated from Data Factory.

### Identifying the right compute resources

Before deploying a model in Azure Machine Learning to an AKS, the user needs to specify the resources (CPU, RAM, GPU) that should be allocated for the respective model. Defining these parameters can be a complex and tedious process. Stress tests with different configurations need to be performed to identify a good set of parameters.

This process can be simplified with the Model Profiling feature in Azure Machine Learning which is a long running job that tests different combinations of resource allocations and identifies an optimal combination based on the identified latency and RTT. This information can then be used for the actual model deployment on AKS.

To safely update models in Azure Machine Learning, teams should use the controlled rollout feature (preview) in order to minimize the downtime and keep the model REST endpoint consistent.

## Workflow and MLOps best practices

### Include sample code in data science repositories

Data Science projects can be significantly simplified and accelerated if certain artifacts and best practices are provided to the teams. Therefore, it is suggested to create artifacts which can be used by all data science teams working on Azure with Azure Machine Learning and the respective tools that are part of the data product environment. The artifacts should be created and provided by Data and ML engineers.

These artifacts should include:

1. **Sample notebooks** that show how to:

    - Load, mount and work with datasets,
    - Log metrics and parameters
    - Submit a training job to compute clusters.

2. **Artifacts** that are required for operationalization:

    - Sample Azure Machine Learning Pipeline
    - Sample Azure DevOps pipelines
    - Additional scripts required to execute the pipeline

3. **Documentation**

### Operationalize pipelines using well-designed artifacts

These artifacts will significantly speed up the exploration and operationalization phase of data science projects and can be scaled across all projects. To scale these artifacts across all projects, a DevOps forking strategy could be used.

Such a setup will also promote the use of git because users will benefit from the provided artifacts. Additionally, the overall automation process will greatly benefit from these artifacts.

> [!TIP]
> The Azure Machine Learning sample pipelines should be either built using the Python SDK or should be based on the new yaml language. The new yaml experience will be more future proof as the AML product team is currently working on a new SDK and CLI offering that will place it's bet on yaml as a definition language for all artifacts within Azure Machine Learning.

It is understood that any sample pipelines will not necessarily work out of the box for each and every project but they can be used as a baseline and fine tuned for the respective projects. The pipeline itself should include the most relevant aspects for each project such as referencing a compute target, referencing datasets, defining parameters, defining inputs and defining two execution steps.

The same should be done for the Azure DevOps pipelines. The pipelines should demonstrate how users can connect to a workspace from within a DevOps pipeline, how to check whether the required compute is available, how to submit a job, how to register a model and deploy a model. The DevOps pipelines should also make use of the Azure Machine Learning SDK or CLI.

In summary, these artifacts will not fit all projects all the time and may require customization but having a foundation in place will speed up project operationalization and deployment significantly.

### Structure the MLOps repository

In order to avoid situations where users can lose track of where different artifacts are stored, requiring additional time for communications in order to understand folder's structure, it is recommended to construct a top-level folder structure for the standard repository in place, which all projects should follow. This can be bundled with the previous recommendation included in the above sections.

> [!NOTE]
> The concepts mentioned in this section can be used across all environments: on-premises, AWS, Palantir and Azure.

The proposed top-level folder structure for a MLOps repository is illustrated in the following image:

![MLOps Repository Structure](../images/repository-structure.png)

Following is a description of the purpose of each of the folders that make up the repository:

|Folder  |Purpose  |
|---------|---------|
|`.cloud`     |Cloud specific code and artifacts should be stored in this folder. This includes configuration files for the Azure Machine Learning workspace including the definition of compute targets, jobs, registered models and endpoints.         |
|`.ado/.github`     |This folder should be used to store Azure DevOps or GitHub related artifacts such as yaml pipelines or definition of code owners.         |
|`code`     |The `code` folder should include the actual code that is developed as part of the project. In this folder can be python packages and some scripts that are used for the respective steps of the machine learning pipeline. Inside this folder, we propose a separation by individual steps that need to be performed. Common steps are **preprocessing**, **model training** and **model registration**. For each step, there should be a definition of the dependencies provided (e.g., conda dependencies, docker image).         |
|`docs`     |`docs` is used for documentation purposes. This folder houses markdown files and images to describe the project.         |
|`pipelines`     |This folder is used to store the definition of Azure Machine Learning pipelines in yaml or python language.         |
|`tests`     |The `tests` folder is used for writing unit and integration tests that need to be executed to discover bugs and issues early on in the project.         |
|`notebooks`     |The `notebooks` folder is used to separate jupyter notebooks from the actual python project. Inside the folder, each individual should have a subfolder to check in their notebooks and prevent git conflicts. The reason for this is that there are known issues with git and jupyter notebooks.         |
