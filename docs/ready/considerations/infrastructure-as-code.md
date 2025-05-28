---
title: Infrastructure as Code
description: Infrastructure as Code for Azure Landing Zones
author: Zimmergren
ms.author: pnp
ms.date: 05/22/2023
ms.topic: conceptual
ms.custom: internal
---

# Infrastructure as Code

Infrastructure as Code (IaC) is a key DevOps practice that involves the management of infrastructure, such as networks, compute services, databases, storages, and connection topology, in a descriptive model. IaC allows teams to develop and release changes faster and with greater confidence. Benefits of IaC include:

- Increased confidence in deployments
- Ability to manage multiple environments
- Improved understanding of the state of infrastructure

For more information about the benefits of using Infrastructure as Code, see [Repeatable infrastructure](/azure/architecture/framework/devops/automation-infrastructure).

## Tooling

There are two approaches you can take when implementing Infrastructure as Code.

- **Imperative Infrastructure as Code** involves writing scripts in languages like Bash or PowerShell. You explicitly state commands that are executed to produce a desired outcome. When you use imperative deployments, it's up to you to manage the sequence of dependencies, error control, and resource updates.
- **Declarative Infrastructure as Code** involves writing a definition that defines how you want your environment to look. In this definition, you specify a desired outcome rather than how you want it to be accomplished. The tooling figures out how to make the outcome happen by inspecting your current state, comparing it to your target state, and then applying the differences.

### ARM Templates

Review information about Azure Resource Manager templates (ARM templates).

- [What are ARM templates?](/azure/azure-resource-manager/templates/overview)

- [ARM Templates - Infrastructure as Code overview](/dotnet/architecture/cloud-native/infrastructure-as-code#azure-resource-manager-templates)

### Bicep

[Bicep](/azure/azure-resource-manager/bicep/overview?tabs=bicep) is a domain-specific language (DSL) that uses declarative syntax to deploy Azure resources. In Bicep files, you define the infrastructure you intend to deploy and its properties. Compared to ARM templates, Bicep files are easier to read and write for a non-developer audience because they use a concise syntax.

This sample Bicep code deploys an Azure Storage Account in the resource group's region. It applies Standard_LRS redundancy and the StorageV2 kind. The access tier is set to 'Hot' for frequent data access.

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

Review information about Terraform.

- [Overview of Terraform on Azure](/azure/developer/terraform/overview)

- [Terraform - Infrastructure as Code overview](/dotnet/architecture/cloud-native/infrastructure-as-code#terraform)

### Azure CLI

Review information about Azure CLI.

- [Azure Command-Line Interface (CLI)](/cli/azure/what-is-azure-cli)

- [Azure CLI - Infrastructure as Code overview](/dotnet/architecture/cloud-native/infrastructure-as-code#azure-cli-scripts-and-tasks)

## Infrastructure as Code modules

One of the goals of using code to deploy infrastructure is to avoid duplicating work or creating multiple templates for the same or similar purposes. Infrastructure modules should be reusable and flexible and should have a clear purpose.

Modules are independent files, typically containing set of resources meant to be deployed together. Modules allow you to break complex templates into smaller, more manageable sets of code. You can ensure that each module focuses on a specific task and that all modules are reusable for multiple deployments and workloads.

### Bicep modules

Bicep allows you to create and call modules. Once modules are created, they can be consumed from any other Bicep template. A high quality Bicep module should define multiple related resources. For example, when you define an Azure function, you typically deploy a particular application, a hosting plan for that application, and a storage account for that application´s metadata. These components are separately defined, but they form a logical grouping of resources, so you should consider defining them together as a module.

Bicep modules commonly use:

- **Parameters** to accept values from a calling module.
- **Output values** to return results to a calling module.
- **Resources** to define one or more infrastructure objects for a module to manage.

#### Publish Bicep modules

You have several options for publishing and sharing Bicep modules.

- **Public registry:** The public module registry is hosted in a Microsoft container registry (MCR). Its source code and the modules it contains are stored in [GitHub](https://github.com/azure/bicep-registry-modules).
- **Private registry:** You can use Azure container registry to publish modules to a private registry. For information on publishing modules to a registry in a CI/CD pipeline, see [Bicep and GitHub Actions](/training/modules/publish-reusable-bicep-code-using-github-actions/), or if you prefer, [Bicep and Azure Pipelines](/training/modules/publish-reusable-bicep-code-using-azure-pipelines/).
- **Template Spec:** You can use [template specs](/azure/azure-resource-manager/templates/template-specs?tabs=azure-powershell) to publish Bicep modules. Template specs are meant to be complete templates, but Bicep allows you to use template specs to deploy modules.
- **Version control system:** You can load modules directly from version control tools like GitHub or Azure DevOps.

### Terraform modules

Terraform allows you to create and call modules. Each Terraform configuration has at least one module, known as its *root module*, consisting of resources defined in `.tf` files in your main working directory. Each module can call other modules, which allows you to include child modules in your main configuration file. Modules can also be called multiple times within the same configuration or from different configurations.

Modules are defined with all of the same configuration language concepts. They most commonly use:

- **Input variables** to accept values from a calling module.
- **Output values** to return results to a calling module.
- **Resources** to define one or more infrastructure objects for a module to manage.

#### Publishing Terraform modules

You have several options for publishing and sharing Terraform modules:

- **Public registry:** HashiCorp has their own Terraform Module Registry that allows users to generate sharable Terraform modules. There are currently several [Azure modules](https://registry.terraform.io/namespaces/Azure) published in the Terraform Module Registry.
- **Private registry:** You can seamlessly publish Terraform modules to a private repository like Terraform Cloud Private Registry or Azure Container Registry.
- **Version control system:** You can load private modules directly from version control tools like GitHub. For information on supported sources, see [Terraform module sources](https://www.terraform.io/language/modules/sources).

## Design considerations

- Consider using IaC when deploying landing zone resources to Azure. IaC fully realizes deployment optimization, reduces configuration effort, and automates the entire environment´s deployments.

- Determine whether you should take an imperative or declarative IaC approach.

  - If taking an imperative approach, explicitly state commands to be executed that produce your desired outcome.

  - If taking a declarative approach, specify your desired outcome rather than how you want it done.

- Consider deployment scopes. Have a good understanding of [Azure management levels and hierarchy](../azure-setup-guide/organize-resources.md). Each IaC deployment must know the scope at which Azure resources are deployed.

- Determine whether you should use an Azure native or Azure non-native IaC tool. Some points to consider:

  - Azure native tools like Azure CLI, ARM Templates, and Bicep are fully supported by Microsoft, which allows their new features to be integrated faster.

  - Non-native tools like Terraform allow you to manage infrastructure as code across multiple cloud providers like AWS or GCP. However, new Azure features can take some time to be included in non-native. If your organization is multicloud or your organization is already using and well-versed in Terraform, consider using Terraform to deploy Azure landing zones.

- Since modules enable you to break complex templates into smaller sets of code, consider using IaC modules for resources that are commonly deployed together. You can ensure each module focuses on a specific task and is reusable for multiple deployments and workloads.

- Consider adopting a publishing strategy for IaC modules by choosing between public registries, private registries or a version control system like a Git repository.

- Consider using a CI/CD pipeline for IaC deployments. A pipeline enforces the reusable process you set to ensure the quality of your deployments and Azure environment.

## Design recommendations

- Adopt an IaC approach to deploying, managing, governing, and supporting Azure landing zone deployments.

- Use Azure native tools for IaC in the following scenarios:

  - You want to use only Azure native tools. Your organization might have prior ARM or Bicep template deployment experience.

  - Your organization wants to have immediate support for all preview and GA versions of Azure services.

- Use non-native tools for IaC in the following scenarios:

  - Your organization currently uses Terraform to deploy infrastructure to other clouds like AWS or GCP.

  - Your organization doesn't need to have immediate support for all preview and GA versions of Azure services.

- Use reusable IaC modules to avoid repetitive work. You can share modules across your organization to deploy multiple projects or workloads and manage less complex code.

- Publish and use IaC modules from public registries in the following scenarios:

  - You want to use modules for Azure Landing Zone already published to public registries. For more information, see [Azure landing zones Terraform module](../landing-zone/deploy-landing-zones-with-terraform.md).

  - You want to use modules that are maintained, updated, and supported by Microsoft, Terraform, or other module providers.
    - Make sure you check the support statement from any module provider you evaluate.

- Publish and use IaC modules from private registries or version control systems in the following scenarios:

  - You want to create your own modules based on your organizational requirements.

  - You want to have full control of all features and maintain, update, and publish new versions of modules.

- Use a CI/CD pipeline to deploy IaC artifacts and ensure the quality of your deployment and Azure environments.
