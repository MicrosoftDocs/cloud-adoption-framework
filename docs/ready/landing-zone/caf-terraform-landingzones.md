---
title: Introduction to Terraform landing zones 
description: CAF Recommendations to use Terraform with Microsoft Azure in enterprise context.
author: arnaudlh
ms.author: arnaul
ms.date: 03/23/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

<!-- cSpell:ignore eastasia southeastasia vCPUs lalogs tfvars NetworkMonitoring ADAssessment ADReplication AgentHealthAssessment DnsAnalytics KeyVaultAnalytics -->

# CAF Terraform landing zones

Azure provides multiple native services for deploying your landing zones. Other third-party tools can also help with this effort. One such tool that customers and partners often use to deploy landing zones is Terraform by HashiCorp.

In this section, we illustrate a methodology used by some customers for Terraform on Microsoft Azure to run complex Infrastructure-as-Code projects. To some extent, it can also be called Everything-as-Code. To help you take actions, we provide public open-source artifacts where the community builds on GitHub. Those components are curated by our experts and the community and are published and verified on the Hashicorp registry.

Those components are here to help you to put DevOps to work and evolve the operating model of your organization towards Site Reliability Engineering (SRE) model.

The following video is a good introduction of what CAF Terraform landing zones are, and what are the main components it defines or uses:

<!-- markdownlint-disable MD034 -->

> [!VIDEO https://channel9.msdn.com/Shows/Azure-Enablement/Deploying-Azure-Landing-Zones-using-Terraform/player]

<!-- markdownlint-enable MD034 -->

Before deploying any component on an Azure Subscription, we need to understand a few key concepts to be successful with Terraform on Azure:

### Start with DevOps

While the Terraform experience starts with one individual on a laptop, it is likely that you are going to work in a team and adopt DevOps and GitOps concepts to realize benefits such as continuous integration and continuous deployment, more reliability, and predictability on your deployments.

On the journey, you will realize there can be disruption between the local experience (it works on the developer's laptop) and the pipelines. If there is too much difference between the two environments, you are likely to spend much time troubleshooting issues that are related to this dichotomy and lose focus off delivering value.

Another common caveat is the difficulty of consistent development or running environment for the different developers: Terraform is evolving frequently so you need to make sure all your developers are running the right versions, but you also need some code excellence tools (pre-commit validation hooks to avoid wrong things to be committed in a repository, static code analysis tools, plan-phase compliance tools, etc.). DevOps is not achieved by one and single tool, your running environment might be assuming presence of more tools like: jq, az cli, PowerShell, PowerShell DSC, Ansible, Chef, Puppet, etc.

![Seemless experience from coding to pipelines](../../_images/ready/terraform-dev-rover.png)
*Figure 1: An overview of Developer environment including Inner feedback loop with pipelines*

For all of those reasons, we recommend the usage of containers to be used on the developer's machine as well as in the pipelines. We provide you with the CAF rover serving this purpose, and this is why in all our repo, you will see a ```.devcontainer``` folder that contains reference to our container (rover) containing our recommended runtime environment.

[!TIP] Please note that although very useful, rover is not mandatory and you can perfectly use any CAF Terraform component separately.

### Organize the Terraform state files for the enterprise

When working with Terraform in a team of DevOps engineers and with pipelines, you will need to share the Terraform state files. We have seen many organizations struggling with finding the right level of state management, and while customers can leverage solutions like Terraform Cloud or Terraform Enterprise from Hashicorp, Cloud Adoption Framework also comes with a structured approach based on Azure storage accounts to achieve those objectives.

In the model proposed by CAF Terraform landing zones, you can observe the composability where a state file from one level down can be read but cannot be changed.

This model allows you to manage multiple state files to segregate different level of privileges and also compose the environment with independent pipelines. The mechanisms to deploy those different levels, as well as reading and composing from different levels are provided as part of the DevOps toolset.

### Innovate faster with inner-sourcing

We have frequently observed that at the beginning of working with Terraform, the DevOps teams tend to spend a large amount of time curating their own artifacts and only over time and with experience start defining a set of common engineering criteria.

In essence, having one code for the module and multiple configuration files used across the organization could be a good way to centralize the quality of the engineering while having the common engineering criteria enumerated will allow the community (internal business users, or public contributors for the CAF module). The more people will use the module, contribute and test it, the more quality you will have.

This core concept applies for all areas of your environment, this is why as part of CAF Terraform landing zones, we are publishing modules, landing zones, and application landing zone solution accelerators where you can leverage the community to increase the velocity of the innovation in the enterprise. You can use those components from the community and contribute directly or fork the public components in your private git repositories to validate them, and then periodically resync with the public (upstream) repository, to sync on latest innovation or to contribute back to the community.

## Empowering the Site Reliability Engineer

As part of CAF Terraform, multiple functions are split across multiple components. That level of decomposition and de-correlation might be confusing at the beginning, but actually allows a maximum of flexibility and reusability of the components whether you're using the complete CAF Terraform landing zones, or you want to use the battlefield-tested CAF module in your own pipelines or Terraform Cloud, or benefit from the CAF naming provider inside your own enterprise-grew modules.  

![Foundational landing zone using Terraform](../../_images/ready/terraform-sre-components.png)
*Figure 4: An overview of the Site Reliability Engineering Components provided by CAF Terraform landing zones*

Below is a quick overview of the different components.

### The CAF supermodule

We have seen numerous customers spending much times creating their own Terraform modules in their own private repositories and while it's hard to find the right balance of what components should be inside a single module, it is a very time consuming task. As part of our engagements with customers, we took an approach enabled by Terraform 0.13 to develop a concept of supermodule (similar to the concept of superapp) allowing you to create configurations files for any Azure components while focusing on one tested logic. The advantage of having one module is to be able to easily compose across all components inside the module: ie: you can describe a Virtual machine, how it is linked to a virtual network, a Key Vault etc.

The core concept of the module is to compose an environment based on Terraform configuration files instead of writing ad-hoc code for each components. We want to promote "infrastructure-as-data" in favor of adhoc "infrastructure-as-code", to make composition more accessible and rely on a strong community to write code.

Using this module you can:

* Accelerate innovation with the community: many users use and contribute to the module across the world, have tested it and using it in production, so your DevOps teams can focus on delivering value instead of coding and testing a module.
* Compose across all the Azure components enables you to compose new architectures with an un-matchable speed.

It is important to note that although the module is part of the CAF landing zones solution, it can be used as any standalone module, directly from the Terraform registry or from pipelines, as showed in the [Hashicorp blog post](https://www.hashicorp.com/blog/go-big-or-go-small-building-in-azure-caf-with-terraform-cloud).

The CAF Terraform module is verified by Hashicorp and is present in the [Hashicorp Terraform registry here](https://registry.terraform.io/modules/aztfmod) and you can contribute to the module [on GitHub.](https://github.com/aztfmod/terraform-azurerm-caf)

### The CAF provider

Naming convention is important, the CAF provider helps you manage naming convention (either relying on CAF recommended naming convention or using your own).

The naming convention provider allows you to go faster from integration to production: while you are running it testing mode, it will generate name randomly (useful to test resources which names need to be unique in the world). Once you are done and ready to deploy for production, you select pass-through mode to use your own name (after cleaning the name based on the allowed character set for each Azure resources).

The CAF Terraform provider is verified by Hashicorp and is present in the [Hashicorp Terraform registry here](https://registry.terraform.io/providers/aztfmod/azurecaf/latest) and you can contribute to it [on GitHub.](https://github.com/aztfmod/terraform-azurerm-caf)

### The rover

Although as a first approach it might seem more natural and simple to use Terraform on your laptop, the CAF **rover** is helping you managing your enterprise Terraform deployments on Microsoft Azure and is composed of two parts:

* **A docker container**
  * Allows consistent developer experience on PC, Mac, Linux, including the right tools, git hooks and DevOps tools.
  * Native integration with [Visual Studio Code](https://code.visualstudio.com/docs/remote/containers), [GitHub Codespaces](https://github.com/features/codespaces).
  * Contains the versioned toolset you need to apply landing zones.
  * Helps you switching components versions fast by separating the run environment and the configuration environment.
  * Ensure pipeline ubiquity and abstraction run the rover everywhere, whichever pipeline technology.

* **A Terraform wrapper**
  * Helps you store and retrieve Terraform state files transparently on Azure storage account.
  * Facilitates the transition to CI/CD.
  * Enables seamless experience (state connection, execution traces, etc.) locally and inside pipelines.

Using rover has the following advantages:

* Simplifies setup and configuration across DevOps teams: everyone works with the same versions of the tools.
* Abstracts and helps with the Terraform state management.
* Helps preserve stability across components versions.
* Helps testing different versions of binaries (new version of Terraform, Azure CLI, jq, tflint etc.)
* Facilitates the identity transition to any CI/CD: namely all CI/CD have container capabilities.
* Allows easy transition from one DevOps environment to another (GitHub Actions, Azure DevOps, Jenkins, CircleCI etc.)

Rover is an open-source project and you can use it directly from [Docker Hub](https://hub.docker.com/search?q=aztfmod&type=image), or create your own, to match your organization's own DevOps toolkit. You can find the [rover project here](https://github.com/aztfmod/rover).

### The Azure landing zone module

We use the Azure landing zones (enterprise-scale) module to deploy the management groups and policies recommendations per the enterprise-scale critical design area. The this module is available from the [Hashicorp Terraform registry](https://registry.terraform.io/modules/Azure/caf-enterprise-scale/azurerm/latest.).

The configuration of enterprise-scale module using either the default parameters or a highly customized environment for management groups and policy is left to the implementation phase to map the needs of each organization.

### The landing zones

In CAF Terraform, a landing zone is a set of resources that are sharing a Terraform state and that deliver an environment.

We mainly distinguish core **platform** and **application landing zones**.

A special landing zone is called launchpad and it acts as your DevOps foundations and deploys:

* Storage accounts to deploy the Terraform state files.
* Key Vaults defining the core of secrets storage for the Terraform state.

Most of the time, unless you are a core CAF contributor, you don't need to worry too much about the landing zones and will be only consuming it from the repository. In can you want to review the details, landing zones can be found [here](https://github.com/Azure/caf-terraform-landingzones)

### The starter project

The starter project is a template for your configuration repository for your IaC. It's purpose is to show you an example of configuration files put together in order to deploy a complete environment.

You can find the starter project [here](https://github.com/Azure/caf-terraform-landingzones-platform-starter)

## Getting started

You can get started with the [landing zones](https://aka.ms/caf/terraform).

> [!div class="nextstepaction"]
> [Get started](https://aka.ms/caf/terraform)
