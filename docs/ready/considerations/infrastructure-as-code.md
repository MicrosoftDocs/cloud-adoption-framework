---
title: Use infrastructure as code to deploy and manage your Azure environment
description: Learn to use infrastructure as code to deploy and manage your Azure environment
author: stephen-sumner
ms.author: pnp
ms.date: 09/29/2025
ms.topic: concept-article
---

# Use infrastructure as code to deploy and manage your Azure environment

Infrastructure as Code (IaC) offers a programmatic method for deploying and managing Azure resources. It transforms infrastructure provisioning from manual and error-prone tasks into automated, consistent, and repeatable deployments.

IaC helps reduce configuration drift, minimize deployment errors, and establish version control across your entire Azure infrastructure. Its programmatic nature allows teams to track changes, roll back deployments, and maintain consistent environments across development, testing, and production stages.

:::image type="content" source="./media/infrastructure-as-code-process.png" alt-text="Diagram showing the infrastructure as code process outlined in this article: select your infrastructure-as-code tools, design modules, and deploy through pipelines." lightbox="./media/infrastructure-as-code-process.png" border="false":::

## Select your infrastructure as code tools

Your choice between Azure-native and third-party tools influences deployment capabilities, support timelines, and integration with your existing technology stack.

1. **Choose Bicep and ARM templates for Azure-first environments.** Use [Bicep](/azure/azure-resource-manager/bicep/overview) or [Azure Resource Manager (ARM) templates](/azure/azure-resource-manager/templates/overview) when your organization focuses primarily on Azure services. These tools typically support new Azure features earlier than third-party options and integrate well with [Azure DevOps](/azure/devops/pipelines/), [GitHub Actions](/azure/azure-resource-manager/bicep/deploy-github-actions), and other Microsoft development platforms. If your team already uses ARM templates, migrating to Bicep offers improved syntax while maintaining compatibility. For new Azure deployments, select Bicep over ARM templates. Bicep provides the same capabilities as ARM templates with simplified syntax that's easier to read, write, and maintain.

2. **Choose Terraform for multi-cloud or existing Terraform environments.** Use [Terraform](/azure/developer/terraform/overview) if your organization operates across multiple cloud providers like AWS or Google Cloud, or if you already have Terraform expertise and modules. Although Terraform supports Azure well through the AzureRM provider, new Azure features might take longer to become available. The [Azure landing zones Terraform module](../landing-zone/deploy-landing-zones-with-terraform.md) provides enterprise-ready templates for deploying foundational infrastructure.

3. **Understand tool-specific considerations for configuration management.** Each tool handles configuration drift and out-of-band changes differently. Bicep doesn't maintain state, but drift detection can be supported using [What-If](/azure/azure-resource-manager/bicep/deploy-what-if) and Azure Policy. Terraform requires you to [import out-of-band changes](/azure/developer/terraform/comparing-terraform-and-bicep#out-of-band-changes) into the state file and update the configuration code. For more information, see [Manage configuration drift](/azure/cloud-adoption-framework/manage/administer#manage-configuration-drift).

4. **Use imperative tools for specific automation scenarios.** While declarative IaC tools like Bicep and Terraform should be your primary approach, [Azure CLI](/cli/azure/) and [Azure PowerShell](/powershell/azure/) are useful for custom scripts, complex workflows with conditional logic, or integration with procedural automation systems. These tools complement declarative templates by offering flexible scripting options.

## Use infrastructure as code modules

IaC modules are self-contained units of code that define a specific set of related resources to be deployed together. This approach promotes code reuse, simplifies maintenance, and enables teams to share proven patterns across deployments. The goal is to avoid duplicating work or creating multiple templates for similar tasks. Develop [Bicep modules](/azure/azure-resource-manager/bicep/modules) or [Terraform modules](/azure/developer/terraform/overview) that break complex templates into smaller, more manageable sets of code. Each module should focus on a specific task and contain resources meant to be deployed together.

### Design Bicep modules

Bicep supports modular development by allowing you to create and reuse modules. Modules are self-contained units that define a set of related resources. Once created, a module can be called from any other Bicep template, promoting reuse and consistency across deployments. A well-designed Bicep module typically encapsulates multiple resources that logically belong together. Bicep modules commonly use:

- **Parameters** to accept values from a calling module.
- **Output values** to return results to a calling module.
- **Resources:** to define one or more infrastructure objects for a module to manage.

### Design Terraform modules

Terraform modules allow you to organize and reuse infrastructure code. Every Terraform configuration includes a root module, which consists of resources defined in `.tf` files. Modules can call other modules, including child modules, and can be reused across configurations. Common elements include:

- **Input variables** to accept values from a calling module.
- **Output values** to return results to a calling module.
- **Resources** to define one or more infrastructure objects for a module to manage.

### Establish module publishing and distribution strategies

Your strategy for distributing modules affects collaboration, version control, and deployment reliability. Use public registries when modules meet your requirements and trusted providers maintain them. For Bicep and Terraform, [Azure Verified Modules](https://azure.github.io/Azure-Verified-Modules/overview/introduction/) offer tested and supported implementations aligned with Azure best practices. Always verify the support and maintenance commitments before using external modules in production.

#### Bicep module publishing

You can publish and share Bicep modules using several methods:

- **Public registry** hosted in the [Microsoft Container Registry (MCR)](https://github.com/azure/bicep-registry-modules).
- **Private registry** using Azure Container Registry (ACR) and CI/CD pipelines
- [**Template Specs**](/azure/azure-resource-manager/templates/template-specs?tabs=azure-powershell) to store versioned ARM templates compiled from Bicep templates for reuse. They aren't a registry for raw Bicep modules.
- **Version control system** such as GitHub or Azure DevOps for collaborative development, then [reference](/azure/azure-resource-manager/bicep/modules#path-to-a-module) via local paths or publish to a registry or template spec.

#### Terraform module publishing

Terraform modules can be published and shared through:

- **Public registry** such as the HashiCorp's Terraform Module Registry and [Azure modules](https://registry.terraform.io/namespaces/Azure) published in the Terraform Module Registry.
- **Private registry** including Terraform Cloud Private Registry or Azure Container Registry
- **Version control system** like GitHub. For supported sources, see [Terraform module sources](https://www.terraform.io/language/modules/sources).

## Deploy infrastructure as code through pipelines

Automated pipelines ensure consistent and repeatable deployments while providing visibility and enabling rapid recovery.

1. **Implement CI/CD pipelines for all infrastructure deployments.** Platforms like [Azure DevOps](/azure/devops/pipelines/) or [GitHub Actions](/azure/azure-resource-manager/bicep/deploy-github-actions) help automate IaC deployments. Pipelines should include linting, security scanning, testing, and approval gates before production deployment. They help reduce errors, ensure consistency, and support compliance through audit trails.

2. **Establish environment promotion strategies with appropriate testing.** Deploy infrastructure through development, testing, staging, and production environments with increasing validation. Use [deployment stacks](/azure/azure-resource-manager/bicep/deployment-stacks) or Terraform state management to track resource lifecycle and enable safe updates. Implement automated testing that validates infrastructure configuration, security posture, and functionality before promoting to the next environment. Test modules in isolation before integrating them into larger deployments. Use tools like [ARM template test toolkit](/azure/azure-resource-manager/templates/test-toolkit) and [Terratest](https://terratest.gruntwork.io/) for Terraform modules. Establish processes to verify module functionality, security, and compliance before publishing.

3. **Understand your deployment scopes before deploying.** Review the [Azure management levels and hierarchy](../azure-setup-guide/organize-resources.md) to understand where your resources need to be deployed. Each IaC template must target the appropriate scope, and different tools have varying capabilities at each scope level. For example, tenant-level deployments require specific permissions and support different resource types than resource group deployments.
