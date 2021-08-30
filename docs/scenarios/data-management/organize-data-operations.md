---
title: Understand DevOps automation for the data management and analytics scenario in Azure
description: Learn about DevOps automation for the data management and analytics scenario in Azure.
author: abdale
ms.author: hamoodaleem
ms.date: 08/06/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank, e2e-data
---

# Understand DevOps automation for the data management and analytics scenario in Azure

DevOps, the term for Development Operations, has culturally shifted how people think and work, accelerating the rate at which businesses realize value by helping individuals and organizations to develop and maintain sustainable work practices. DevOps combines development and operations, and is often associated with software engineering tools that support continuous integration (CI) and continuous delivery (CD) practices. These tools and practices include source code managers (Git, Apache Subversion, or Team Foundation Source Control) and automatic build and delivery managers (Azure pipelines, GitHub actions, and others).

## Source control

Source control ensures that code and configurations persist and that changes are tracked and versioned. Most source control systems also have built-in processes for review and working in different branches of a code repository. Currently, the most popular source control type currently is Git, which is a distributed version controls system that allows individuals to work offline and sync to central repositories. Git vendors typically also use branches and follow pull request guidance to support the change and review flow.

Branches isolate changes or feature developments without affecting other work that happens at the same time. The use of branches should be promoted to develop features, fix bugs, and safely experiment with new ideas. Pull requests merge the changes made from one branch into the default branch, and they support a controlled review process. For security purposes, the main branch should use pull requests to ensure code reviews.

> [!IMPORTANT]
> We recommend the following guidelines for the data management and analytics scenario repositories:
>
> - Secure the repository's main branch by enforcing branches and pull requests to ensure a controlled review processes.
> - Azure DevOps or GitHub repositories should be used for source control to track changes to the source code and allow multiple team members to develop code at the same time.
> - Application code and infrastructure configurations should be checked into a repository.

## CI/CD pipelines

CI allows teams to automatically test and build source code and enables quick iterations and feedback loops to ensure high code quality in CD. Pipelines are ways to configure the CI of changes (software code or infrastructure code) and CD of the packaged/compiled changes. This is also referred to as *build and release*. CD describes the automatic deployment of applications to one or more environments. CD usually follows a CI process and uses integration tests to validate the entire application.

Pipelines can contain multiple stages with various tasks and can have simple to complex approval flows to ensure compliance and validation. Based on preference, pipelines can also be configured with various automatic triggers. For enterprise-scale and AI deployment, the production steps should always have human pre-approval, and this is built into the operation model. CI/CD pipelines should be built with GitHub Actions or Azure Pipelines, and they should be automated triggers.

### Infrastructure as code

The term *code* in IaC often raises concerns for IT staff without a developer background, but IaC don't refer to writing code the way in which typical software developers do it. However, it adopts many of the same tools and principles from the software development processes to deliver infrastructure in a predictable format.

IaC helps infrastructure to be provisioned, configured, and managed as part of a DevOps pipeline with full change controls, audit history, tests, validations, and approval processes, ensuring that tasks can be delegated to the appropriate roles for the project without compromising security and compliance.

The two approaches to IaC are declarative and imperative:

- Declarative refers to specifying the desired state of the infrastructure and having an orchestration engine execute the necessary actions to achieve the desired state. In Azure, this is done with Azure Resource Manager templates. Third-party abstraction layers like Terraform are also available for this approach.

- The imperative approach refers to executing specific commands in a defined order. For Azure, this can be achieved with the command-line interface or PowerShell, but native programming language software developer kits, for example, .NET, Python, and Java, are also available if integrated solutions are required.

In Azure Resource Manager templates, the core provisioning is in the **resources** section, and the configuration of the individual resources is defined in a **properties** section. For an Azure Data Lake Storage Gen2, the configuration looks like the following:

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

> [!IMPORTANT]
> Every layer of the enterprise-scale for analytics and AI such as data management landing zone, data landing zones, data integrations, or data products, should be defined with a declarative language like Azure Resource Manager or Terraform, checked into a repository, and deployed through CI/CD pipelines. This allows teams to track and version changes to the infrastructure and configuration of Azure scope while supporting different architecture levels to be automated in an agile way. This guidance leads teams to use Git repositories to always have visibility into the state of specific Azure scopes.

## Workflows and automation

Teams should use CI/CD pipelines in multiple stages to ensure that developed code is without errors and ready for production. Some best practices are to have a development environment, a testing environment, and a production environment. These stages should also be reflected in Azure by using separate services for each environment.

The platform team is responsible for providing and maintaining deployment templates to scale quickly within an organization and simplify deployments for teams unfamiliar with IaC. These templates serve as a baseline for new artifacts within the scenario and need to be maintained over time to represent best practices and common standards within the company.

Deployments to test and production should only be managed through a CI/CD pipeline and a service connection with elevated permissions to enforce common best practices (for example, Azure Resource Manager templates).

> [!CAUTION]
> Integration operations (integration ops) and data product teams should only have read access to test and production environments, and deployments to these environments should only be executed through CI/CD pipelines and service connections with elevated permissions. To accelerate the path to production, integration ops and data product teams should have write access to the development environment.

## Next steps

[Personas and teams](./organize-persona-and-teams.md)
