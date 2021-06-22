---
title: "Azure Enterprise Scale Analytics platform automation and devops Overview"
description: Enterprise-Scale platform automation and devops Overview
author: abdale
ms.author: hamoodaleem
ms.date: 06/21/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# DataOps Overview

The Enterprise Scale Analytics and AI architecture was designed with the following core principles in mind:

1. Self-Service Enablement: Enable project teams to work on their own in order to allow agile development methods.
2. Governance: Enforce guardrails on the whole Azure platform, in order to ensure that project teams are only allowed to see, change, and execute what they are supposed to.
3. Streamlined Deployments: Ensure that common policies are available and can be used across the organization to scale quickly and to enable teams which are not as experienced with some of core designs and artifacts.

The deployment process and Data Ops working model is an essential part and enable for some of these core principles. In order to fulfill these concepts, we prescribe the following design guidelines:

1. Use of Infrastructure as Code (IaC).
2. Deployment templates covering the core use cases within the company
3. Deployment process that includes a forking and branching strategy
4. Central repository and deployment of Data Management Landing Zone

A Platform Group team should be put in place to centrally govern the data platform infrastructure and not duplicate skills required to build and deploy common data infrastructure pieces required for the Data Management Landing Zone as well as the various Data Landing Zones.

The Platform Group team can build, own, and provide the necessary agnostic technology that the Data Integration and Data Products need to capture, process, store, and serve their datasets.

The team should provide the services in a self-service manner, which should include tools for big data storage, data product versioning, data pipeline implementation and orchestration, data de-identification, etc. This is key to remove bottlenecks in the workflow and reduce the lead time to create new Data Products.

The Platform Group team should follow existing best practices outlined in this section to achieve their objective.

Other data product teams should also use the following best practices for proper testing and automation.

## Intro to DevOps and Automation

The term *DevOps* is more of a cultural movement that changes the way of thinking and working, enabling individuals and organizations to develop and maintain sustainable work practices by accelerating the rate at which businesses realize value.

DevOps represents the combination of development and operations and is often associated with tools that enable continuous integration (CI) and continuous delivery (CD) practices. These software engineering practices and tools include source code managers (Git, SVN, Team Foundation Source Control) and automatic build and delivery manager (Azure DevOps Pipelines, GitHub Actions, etc.).

### Source Control

Source Control ensures that code and configuration is persisted and that changes are tracked and versioned. Most source control systems also have built in processes for review and working in different branches of a code repository. The most popular source control type currently is Git which is a distributed version controls system, allowing individuals to work offline and sync to central repositories. Git vendors typically also implement branches and pull request concepts to support the change and review flow.

Branches are used to isolate changes or feature developments without affecting other work that is done in parallel. The use of branches should be emphasized to develop features, fix bugs and safely experiment with new ideas. Changes made to one branch can be merged back into the default branch by using pull requests. These allow a controlled review process. The main branch should be secured to ensure code reviews via pull requests.

>[!IMPORTANT]
>For all of the repositories in Enterprise Scale Analytics and AI we recommend:
>
> - The main branch of a repository should be secured in order to enforce the use of branches and ensure controlled review processes via pull requests.
> - Azure DevOps or GitHub based repositories should be used for source control to track changes to source code and to allow simultaneous code development by multiple team members.
> - Application code as well as infrastructure configuration should be checked into a repository.

## CI/CD Pipelines

Pipelines are ways to configure Continuous Integration (CI) of changes (software code or infrastructure code) and Continuous Deployment (CD) of the packaged/compiled changes. This is also referred to as Build and Release.

CI allows to automatically test and build source code and enables quick iterations and feedback loops to ensure high code quality in CD. CD describes the automatic deployment of applications in one or more environments. CI is usually followed by a CD process and it allows to validate the entire application by using integration tests.

Pipelines can contain multiple stages with various tasks and can have simple to complex approval flows to ensure compliance and validation. It can also be configured in various degrees of automatic triggering based on preference.

For Enterprise Scale and AI deployment stages to production should always have human pre-approval and this is built into the operation model. CI/CD pipelines should be build using GitHub Actions or Azure DevOps Pipelines and should be automated using appropriate triggers.

### Infrastructure as Code (IaC)

The inclusion of the word "Code" in IaC often raises concern at seasoned IT staff without a developer background, but IaC does not refer to writing code the way typical software developers do. However, it adopts many of the same tools and principals from the software development processes to deliver infrastructure in a prescriptive format.

IaC enables infrastructure to be provisioned, configured and managed as part of a DevOps Pipeline with full change control, audit history, tests, validations and approval processes ensuring that the tasks can be delegated to the appropriate role for the project without compromising security and compliance.

There are two approaches to IaC (declarative and imperative):

- Declarative refers to specifying the desired state of the infrastructure and having an orchestration engine execute the necessary actions to achieve the desired state. In Azure this is done by Azure Resource Manager (ARM) using Azure Resource Manager templates. Third-party abstraction layers like Terraform is also available for this approach.
- The imperative approach refers to executing specific commands in a defined order. For Azure this can be achieved using Azure CLI or Azure PowerShell, but native programming language SDKs also exists for e.g. .Net, Python and Java if integrated solutions are required.

In ARM templates, the core provisioning is in the resources section, and the configuration of the individual resources is defined in a properties section. For an Azure Data Lake Gen 2, it would look like this:

```json
{
    "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "resources": [
        {
            "type": "Microsoft.MachineLearningServices/workspaces/datastores",
            "name": "[concat(parameters('workspaceName'), '/', parameters('datastoreName'))]",
            "apiVersion": "2020-05-01-preview",
            "location": "[parameters('location')]",
            "properties": {
                "DataStoreType": "adls-gen2",
                "SkipValidation": "[parameters('skipValidation')]",
                "ClientId": "[parameters('clientId')]",
                "ClientSecret": "[parameters('clientSecret')]",
                "FileSystem": "[parameters('fileSystem')]",
                "AccountName": "[parameters('accountName')]",
                "TenantId": "[parameters('tenantId')]",
                "ResourceUrl": "[parameters('resourceUrl')]",
                "AuthorityUrl": "[parameters('authorityUrl')]"
            }
        }
    ]
}

```

>[!IMPORTANT]
>Every layer of the Enterprise Scale Analytics and AI construction set (Data Management Landing Zone, Data Landing Zones, Data Integrations or Data Products) should be defined through a declarative language such as ARM or Terraform, should be checked into a repository and deployed through CI/CD pipelines. This allows teams to keep track and version changes to the infrastructure and configuration of Azure scope and ultimately allows an agile self-service automation of different levels of the architecture.\
\
>This concept allows to always have a clear representation of the state inside a specific scope in Azure in a Git repository.

## Workflow and Automation

To ensure that developed code is free of errors and ready for production, it should always be provisioned through CI/CD pipelines using multiple stages. Common practice is to have a development environment, a testing environment, and a production environment. These stages should also be reflected in Azure, by using separate services for each environment.

In order to scale quickly within an organization and simplify the deployment process for teams, which are not as familiar with the concept of IaC, the Platform Team has the responsibility to provide and maintain deployment templates. These templates are used as a baseline for new artifacts within the solution pattern and need to be maintained over time, in order to constantly represent best practices and common standards within the company.

Deployments to test and production should only be manageable through a CI/CD pipeline and a service connection with elevated rights to enforce common best practices (e.g. ARM templates).

>[!CAUTION]
>Integration Ops and Data Product teams should only have read access to have read access to test and production environments. Deployments to these environments should only be executable through CI/CD pipelines and service connections with elevated rights. \
\
>However, Integration Ops and Data Product teams should have write access to the development environment to speed up time to production.
