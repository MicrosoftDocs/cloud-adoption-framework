---
title: Infrastructure as Code
description: Infrastructure as Code for Azure Landing Zones
author: emguzman13
ms.author: emguzman
ms.date: 04/08/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Infrastructure as Code

Infrastructure as Code is the management of infrastructure - such as networks, compute services, databases, storages, and connection topology - in a descriptive model. Infrastructure as Code is a key DevOps practice, and it allows you and your team to not only develop and release changes faster, but with higher confidence in your deployments. Some of the biggest benefits of Infrastructure as Code include increased confidence in your deployments, the ability to manage multiple environments, and improved understanding of the state of your infrastructure. To learn more about the benefits of using Infrastructure as Code see [repeatable infrastructure](/architecture/framework/devops/automation-infrastructure).

## Infrastructure as Code tooling

There are two approaches to Infrastructure as Code:

* **Imperative Infrastructure as Code** involves writing scripts in languages like Bash or PowerShell; you explicitly state the commands that are executed to produce the desired outcome. When using imperative deployments, it is up to you to manage the sequence of dependencies, error control, and resource updates.
* **Declarative Infrastructure as Code** involves writing a definition of how you want your environment to look where you specify the desired outcome instead of specifying how you want it accomplished; the tooling figures out how to make this happen by inspecting your current state, comparing it to the target state, and finally applying the differences.

### ARM Templates

Review more information about Azure Resource Manager templates.

* [What are ARM templates?](/azure/azure-resource-manager/templates/overview)

* [ARM Templates - Infrastructure as Code overview](/dotnet/architecture/cloud-native/infrastructure-as-code#azure-resource-manager-templates)

### Bicep

[Bicep](/azure/azure-resource-manager/bicep/overview?tabs=bicep) is a domain-specific language (DSL) that uses declarative syntax to deploy Azure resources. In a Bicep file, you define the infrastructure you intend to deploy and the properties of that infrastructure. In comparison to ARM templates, Bicep files are easier to read and write for a non-developer audience as they use a concise syntax.

```bicep
param location string = resourceGroup().location
param storageAccountName string = 'toylaunch${uniqueString(resourceGroup().id)}'
resource storageAccount 'Microsoft.Storage/storageAccounts@2021-06-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}
```

### Terraform

Review more information about Terraform.

* [Overview of Terraform on Azure](/azure/developer/terraform/overview)

* [Terraform - Infrastructure as Code overview](/dotnet/architecture/cloud-native/infrastructure-as-code#terraform)

### Azure CLI

Review more information about Azure CLI.

* [Azure Command-Line Interface (CLI)](/cli/azure/what-is-azure-cli)

* [Azure CLI - Infrastructure as Code overview](/dotnet/architecture/cloud-native/infrastructure-as-code#azure-cli-scripts-and-tasks)


## Infrastructure as Code modules

One of the goals of deploying infrastructure by using code is to avoid duplicating effort, or even creating several templates for the same or similar purposes. An infrastructure module is intended to be reusable and flexible and should have a clear purpose.

Modules are independent files and typically contain set of resources that are deployed together. Modules enable you to break a complex template into smaller sets of code that are more manageable. You can ensure that each module is focused on a specific task, and that modules are reusable for multiple deployment and workloads.

### Bicep modules

Bicep allows you to create and call modules. These modules are independent files and contain sets of resources that are commonly deployed together. Once modules are created, they can be consumed from any other Bicep template. A good Bicep module typically defines multiple related resources. For example, when you define an Azure Function, you typically deploy the app, a hosting plan for the app, and a storage account for the app´s metadata. These components are defined separately, but they represent a logical grouping of resources, so consider defining them as a module.

Bicep modules commonly use:

* **Parameters** to accept values from the calling module.
* **Output values** to return results to the calling module.
* **Resources** to define one or more infrastructure objects that the module will manage.

#### Publish Bicep modules

There are several options for publishing and sharing Bicep modules:

* **Public registry:** The public module registry is hosted in a Microsoft container registry (MCR). The source code and the modules are stored in [GitHub](https://github.com/azure/bicep-registry-modules).
* **Private registry:** You can use Azure container registry to publish modules to a private registry. To learn more publishing modules to a registry in a CI/CD pipeline, see [Bicep and GitHub Actions](/learn/modules/publish-reusable-bicep-code-using-github-actions/) or if you prefer [Bicep and Azure Pipelines](/learn/modules/publish-reusable-bicep-code-using-azure-pipelines/).
* **Template Spec:** You can use [template specs](/azure/azure-resource-manager/templates/template-specs?tabs=azure-powershell) to publish Bicep modules. Even though template specs are designed to be deployed as a complete template, Bicep also allows you to use template specs to deploy a module.
* **Version control system:** You can load modules directly from version control such as GitHub or Azure DevOps.

### Terraform modules

Terraform allows you to create and call modules; every terraform configuration has at least one module, known as its root module, which consists of the resources defined in the `.tf` files in the main working directory. A module can call other modules, which allows you to include child modules in the main configuration file. Modules can also be called multiple times, either within the same configuration or in different configurations.

Modules are defined using all of the same configuration language concepts. Most commonly, modules use:

* **Input variables** to accept values from the calling module.
* **Output values** to return results to the calling module.
* **Resources** to define one or more infrastructure objects that the module will manage.

#### Publishing Terraform modules

There are several options to publish and share Terraform modules:

* **Public registry:** HashiCorp has their own Terraform Module Registry that allows users to generate Terraform modules that can be shared. Currently there are several [Azure modules](https://registry.terraform.io/namespaces/Azure) published in the Terraform Module Registry.
* **Private registry:** You can seamlessly publish Terraform modules to private repositories such as Terraform Cloud Private Registry or Azure Container Registry.
* **Version control system:** You can load private modules directly from version control such as GitHub. For more information about supported sources visit [Terraform module sources](https://www.terraform.io/language/modules/sources).

## Design considerations

* Consider using Infrastructure as Code when deploying landing zone resources to Azure. Infrastructure as Code fully realizes deployment optimization, reduces configuration effort, and automates the entire environment´s deployments.

* Consider infrastructure as code approaches, imperative vs declarative.

  * With an imperative approach, you explicitly state the commands that are executed to produce the desired outcome. 

  * With a declarative approach, you specify the desired outcome instead of specifying how you want it done.

* Consider deployment scopes. You should have a good understanding of [Azure management levels and hierarchy](/cloud-adoption-framework/ready/azure-setup-guide/organize-resources). An Infrastructure as Code deployment needs to know the scope at which Azure resources will be deployed.

* Guidance on choosing an Infrastructure as Code tool: Azure native vs non-native.

  * Azure native tools such as Azure CLI, ARM Templates, Bicep are fully supported by Microsoft which allow new features to be integrated faster.

  * Non-native tools such as Terraform allow you to manage infrastructure as code across multiple cloud provides such as AWS or GCP. The downside is that new Azure features might take some time to be included. Consider using Terraform to deploy Azure landing zones if your organization is multi-cloud and/or your organization is already using and well-versed in Terraform. 

* Consider using Infrastructure as Code modules for resources that are commonly deployed together, modules enable you to break a complex template into smaller set of code. You can ensure that each module is focused on a specific task, and that modules are reusable for multiple deployment and workloads.

* Consider adopting a publishing strategy for Infrastructure as Code modules by choosing between public registries, private registries or a version control system, such as a Git repository. 

Consider using CI/CD pipeline for Infrastructure as Code deployment. A pipeline enforces the reusable process that you set to ensure the quality of your deployments and of your Azure environment.

## Design recommendations

* Adopt an Infrastructure as Code approach to deploy, manage, govern, and support Azure landing zone deployments. 

* Adopt the use of Azure native tools for Infrastructure as Code for the following scenarios:

  * You want to use only Azure native tools. Your organization may have experience with prior experience with deploying ARM templates. 

  * Your organization wants to have immediate support for all preview and GA versions of Azure services.
  
* Adopt the use of non-native tools for Infrastructure as Code for the following scenarios:
  
  * Your organization currently uses Terraform to deploy infrastructure to other clouds such as AWS or GCP.

  * Your organization is not looking to have immediate support for all preview and GA versions of Azure services.

* Use Infrastructure as Code modules that are reusable to avoid repetitive work. Modules can be shared across the organization to deploy multiple projects or workloads and allow you to manage less complex code.

* Publish and use Infrastructure as Code modules from public registries for the following scenarios:

  * You want to use modules for Azure Landing Zone already published to public registries. See [Terraform module for Azure landing zones](/azure/cloud-adoption-framework/ready/landing-zone/terraform-module%3C).

  * You are looking to use modules that are maintained, updated, and supported by Microsoft, Terraform, or other module providers.

* Publish and use Infrastructure as Code modules from private registries or version control systems for the following scenarios:

  * You are looking to create your own modules based on organizational requirements.

  * You are looking to have full control of the features, as well as maintaining, updating, and publishing new versions of modules.
  
* Deploy the Infrastructure as Code artifacts with CI/CD pipeline to ensure quality of your deployment and of your Azure environments.

