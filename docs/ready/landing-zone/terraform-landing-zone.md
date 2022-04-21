---
title: Introduction to Terraform landing zones
description: Cloud Adoption Framework recommendations to use Terraform with Microsoft Azure in enterprise context.
author: arnaudlh
ms.author: arnaul
ms.date: 04/13/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

<!-- cSpell:ignore eastasia southeastasia vCPUs lalogs tfvars NetworkMonitoring ADAssessment ADReplication AgentHealthAssessment DnsAnalytics KeyVaultAnalytics -->

# Cloud Adoption Framework Terraform landing zones

> [!NOTE]
> This article describes one of two ways to implement landing zones on Azure by using Terraform. For guidance on choosing the right approach, see [this article](deploy-landing-zones-with-terraform.md).

Azure provides multiple native services for deploying your landing zones. Other tools can also help with this effort. One such tool that customers and partners often use to deploy landing zones is Terraform by HashiCorp.

This article illustrates a methodology that some customers use for Terraform on Microsoft Azure to run complex infrastructure as code (IaC) projects. To some extent, it can be called "everything as code." 

To help you take actions, we provide public open-source artifacts where the community builds on GitHub. Those components are curated by our experts and the community. They're published and verified on the HashiCorp registry. They can help you put DevOps to work and advance the operating model of your organization toward a site reliability engineering (SRE) model.

The following video is a good introduction to Cloud Adoption Framework Terraform landing zones.

<!-- markdownlint-disable MD034 -->

> [!VIDEO https://channel9.msdn.com/Shows/Azure-Enablement/Deploying-Azure-Landing-Zones-using-Terraform/player]

<!-- markdownlint-enable MD034 -->

## Key concepts

Before you deploy any component on an Azure subscription, you need to understand a few key concepts to be successful with Terraform on Azure.

### Start with DevOps

The Terraform experience starts with one individual on a laptop But it's likely that you'll work in a team and adopt DevOps and GitOps concepts to realize benefits such as continuous integration and continuous deployment, more reliability, and predictability on your deployments.

On the journey, you'll realize that disruption can happen between the local experience (it works on the developer's laptop) and the pipelines. If there's too much difference between the two environments, you'll likely spend much time troubleshooting issues that are related to this dichotomy and lose focus on delivering value.

Another common caveat is the difficulty of having a consistent development or running environment for the various developers. Terraform is evolving frequently, so make sure that all your developers are running the right versions. But you also need some code excellence tools, like pre-commit validation hooks to avoid committing wrong things in a repository, static code analysis tools, and plan-phase compliance tools. DevOps is not achieved by a single tool. Your running environment might include more tools, like jq, the Azure CLI, PowerShell, PowerShell DSC, Ansible, Chef, and Puppet.

The following diagram shows an overview of a developer environment, including an inner feedback loop with pipelines.

![Diagram of a seamless experience from coding to pipelines.](../../_images/ready/terraform-dev-rover.png)

For all of those reasons, we recommend the use of containers on the developer's machine and in the pipelines. The Cloud Adoption Framework  serves this purpose. All our GitHub repositories have a `.devcontainer` folder that includes a reference to our container (Rover), which contains our recommended runtime environment.

>[!TIP]
>Although Rover is useful, it's not mandatory. You can use any Cloud Adoption Framework Terraform component separately.

### Organize the Terraform state files for the enterprise

When you're working with Terraform in a team of DevOps engineers and with pipelines, you need to share the Terraform state files. Many organizations struggle to find the right level of state management. Although customers can use solutions like Terraform Cloud or Terraform Enterprise from HashiCorp, the Cloud Adoption Framework also comes with a structured approach based on Azure Storage accounts to achieve those objectives.

In the model proposed by Cloud Adoption Framework Terraform landing zones, you can observe the composability where a state file from one level down can be read but can't be changed.

This model allows you to manage multiple state files to segregate levels of privileges and also compose the environment with independent pipelines. The mechanisms to deploy those different levels, as well as reading and composing from different levels are provided as part of the DevOps toolset.

### Innovate faster with inner sourcing

At the beginning of working with Terraform, DevOps teams tend to spend a large amount of time curating their own artifacts. Over time and with experience, those teams start defining a set of common engineering criteria.

In essence, having one code for the module and multiple configuration files used across the organization could be a good way to centralize the quality of the engineering while having the common engineering criteria enumerated will allow the community (internal business users, or public contributors for the Cloud Adoption Framework module). The more people will use the module, contribute and test it, the more quality you will have.

This core concept applies for all areas of your environment. This is why as part of Cloud Adoption Framework Terraform landing zones, we are publishing modules, landing zones, and application landing zone solution accelerators where you can use the community to increase the velocity of the innovation in the enterprise. You can use those components from the community and contribute directly or fork the public components in your private Git repositories to validate them. Then, you can periodically resync with the public (upstream) repository, to sync on latest innovation or to contribute back to the community.

## Empowering the site reliability engineer

As part of Cloud Adoption Framework Terraform, multiple functions are split across multiple components. That level of decomposition and de-correlation might be confusing at the beginning. But it actually allows a maximum of flexibility and reusability of the components, whether any of the follwing cases apply to you: 

- You're using the complete Cloud Adoption Framework Terraform landing zones.
- You want to use the battlefield-tested Cloud Adoption Framework module in your own pipelines or Terraform cloud.
- You want to benefit from the Cloud Adoption Framework naming provider inside your own enterprise-grew modules.

The following diagram shows an overview of the Site Reliability Engineering Components provided by Cloud Adoption Framework Terraform landing zones.

![Diagram of a foundational landing zone using Terraform.](../../_images/ready/terraform-sre-components.png)

Below is a quick overview of the different components.

### The Cloud Adoption Framework supermodule

We have seen numerous customers spending much times creating their own Terraform modules in their own private repositories and while it's hard to find the right balance of what components should be inside a single module, it's a very time consuming task. As part of our engagements with customers, we took an approach enabled by Terraform 0.13 to develop a concept of supermodule (similar to the concept of superapp) allowing you to create configurations files for any Azure components while focusing on one tested logic. The advantage of having one module is to be able to easily compose across all components inside the module: ie: you can describe a virtual machine, how it's linked to a virtual network, a key vault and so on.

The core concept of the module is to compose an environment based on Terraform configuration files instead of writing ad hoc code for each components. We want to promote "infrastructure-as-data" in favor of ad hoc "infrastructure-as-code", to make composition more accessible and rely on a strong community to write code.

Using this module you can:

- Accelerate innovation with the community: many users use and contribute to the module across the world, have tested it and using it in production, so your DevOps teams can focus on delivering value instead of coding and testing a module.
- Compose across all the Azure components enables you to compose new architectures with an unmatchable speed.

It's important to note that although the module is part of the Cloud Adoption Framework landing zones solution, it can be used as any standalone module, directly from the Terraform Registry or from pipelines, as showed in the [HashiCorp blog post](https://www.hashicorp.com/blog/go-big-or-go-small-building-in-azure-caf-with-terraform-cloud).

The Cloud Adoption Framework Terraform module is verified by HashiCorp and is present in the [HashiCorp Terraform Registry](https://registry.terraform.io/modules/aztfmod) and you can contribute to the module [on GitHub](https://github.com/aztfmod/terraform-azurerm-caf).

### The Cloud Adoption Framework provider

Naming convention is important, the Cloud Adoption Framework provider helps you manage naming convention (either relying on Cloud Adoption Framework recommended naming convention or using your own).

The naming convention provider allows you to go faster from integration to production: while you are running it testing mode, it will generate name randomly (useful to test resources which names need to be unique in the world). Once you are done and ready to deploy for production, you select pass-through mode to use your own name (after cleaning the name based on the allowed character set for each Azure resources).

The Cloud Adoption Framework Terraform provider is verified by HashiCorp and is present in the [HashiCorp Terraform Registry](https://registry.terraform.io/providers/aztfmod/azurecaf/latest) and you can contribute to it [on GitHub](https://github.com/aztfmod/terraform-azurerm-caf).

### The rover

Although as a first approach it might seem more natural and simple to use Terraform on your laptop, the Cloud Adoption Framework **rover** is helping you managing your enterprise Terraform deployments on Microsoft Azure and is composed of two parts:

- **A Docker container**
  - Allows consistent developer experience on PC, Mac, Linux, including the right tools, Git hooks and DevOps tools.
  - Native integration with [Visual Studio Code](https://code.visualstudio.com/docs/remote/containers), [GitHub Codespaces](https://github.com/features/codespaces).
  - Contains the versioned toolset you need to apply landing zones.
  - Helps you switching components versions fast by separating the run environment and the configuration environment.
  - Ensure pipeline ubiquity and abstraction run the rover everywhere, whichever pipeline technology.

- **A Terraform wrapper**
  - Helps you store and retrieve Terraform state files transparently on Azure Storage account.
  - Facilitates the transition to CI/CD.
  - Enables seamless experience (state connection, execution traces, and so on.) Locally and inside pipelines.

Using rover has the following advantages:

- Simplifies setup and configuration across DevOps teams: everyone works with the same versions of the tools.
- Abstracts and helps with the Terraform state management.
- Helps preserve stability across components versions.
- Helps testing different versions of binaries (new version of Terraform, Azure CLI, jq, tflint and so on.)
- Facilitates the identity transition to any CI/CD: namely all CI/CD have container capabilities.
- Allows easy transition from one DevOps environment to another (GitHub Actions, Azure DevOps, Jenkins, CircleCI and so on.)

Rover is an open-source project and you can use it directly from [Docker hub](https://hub.docker.com/search?q=aztfmod&type=image), or create your own, to match your organization's own DevOps toolkit. You can find the [rover project here](https://github.com/aztfmod/rover).

### The Azure landing zone module

We use the Azure landing zones (enterprise-scale) module to deploy the management groups and policies recommendations per the enterprise-scale critical design area. The this module is available from the [HashiCorp Terraform Registry](https://registry.terraform.io/modules/Azure/caf-enterprise-scale/azurerm/latest).

The configuration of enterprise-scale module using either the default parameters or a highly customized environment for management groups and policy is left to the implementation phase to map the needs of each organization.

### The landing zones

In Cloud Adoption Framework Terraform, a landing zone is a set of resources that are sharing a Terraform state and that deliver an environment.

We mainly distinguish core **platform** and **application landing zones**.

A special landing zone is called launchpad and it acts as your DevOps foundations and deploys:

- Storage accounts to deploy the Terraform state files.
- Key vaults defining the core of secrets storage for the Terraform state.

Most of the time, unless you are a core Cloud Adoption Framework contributor, you don't need to worry too much about the landing zones logic and will be only consuming it from the repository and customizing it with variables. In case you want to review the details, landing zones can be found [here](https://github.com/Azure/caf-terraform-landingzones).

### The starter project

The starter project is a template for your configuration repository for your IaC. It's purpose is to show you an example of configuration files put together in order to deploy a complete environment.

You can find the starter project [here](https://github.com/Azure/caf-terraform-landingzones-platform-starter).

## Getting started

You can get started with the [landing zones](https://aka.ms/caf/terraform).

> [!div class="nextstepaction"]
> [Get started](https://aka.ms/caf/terraform)
