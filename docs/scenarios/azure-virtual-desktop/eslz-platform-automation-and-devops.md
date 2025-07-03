---
title: Platform automation and DevOps for Azure Virtual Desktop
description: Learn how this design area can improve platform automation and DevOps for Azure Virtual Desktop.
author: Zimmergren
ms.author: pnp
ms.date: 02/22/2023
ms.topic: conceptual
ms.custom: think-tank, e2e-avd
---

# Platform automation and DevOps considerations for Azure Virtual Desktop

Azure Virtual Desktop is a managed service that provides a Microsoft control plane for your desktop virtualization environment.

This article focuses on the operational tasks you need to run an Azure Virtual Desktop environment. You can apply each recommendation in this article individually. You don't need to implement every recommendation for automation to be worthwhile.

## Design considerations

Review the following considerations while planning and designing your Azure Virtual Desktop environment.

### Integrate with DevOps

Automation doesn't have to mean integration with DevOps, but integration does offer many advantages. Automating the build process for your golden image is worth the investment for multiple reasons:

- When you use a DevOps pipeline, you can better manage your automation flow.
- You can receive reports and alerts about deployments from a DevOps pipeline.
- You can configure your pipeline to integrate with testing frameworks and create approval gates for stages in your automation process.
- You can start pipelines from many predefined events like the release of a new gallery image, application or using a set schedule.
- When you automate host pool creation, it's easy to move your host pool metadata to new geographical locations when new locations are made available.

### Infrastructure as Code

As you move towards embracing DevOps practices, you have to choose a tool to deploy your Azure resources. There are two different [categories of IaC tooling](/azure/architecture/framework/devops/automation-infrastructure#categories-of-iac-tooling). The preferred option is a declarative IaC tool. 

Azure provides native options with [ARM templates](/azure/azure-resource-manager/templates/overview) and [Azure Bicep](/azure/azure-resource-manager/bicep/overview).

You can also find third-party IaC tools, such as HashiCorp's [Terraform](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs).

### Pooled vs. personal

As your organization scales out its environment, most of the workload falls under a *pooled* configuration rather than a *personal* configuration.

Personal configurations are often more expensive to run than pooled configurations. They're suitable for specific workload users like developers who usually require elevated permissions. If you run host pools in personal mode, try to maintain the machines like you maintain your physical desktops so you reduce the amount of tooling required in your environment.

Pooled configurations are the most popular for desktop virtualization, which is why they're the focus of this article. Pooled environments have to be updated differently than traditional environments. Update your virtual machines (VMs) from a gold image at the correct cadence for your organization (usually every 1-3 months). If your organization is highly automated, you might be able to increase the cadence to weekly or even nightly if necessary.

### Image creation

When scaling up your Azure Virtual Desktop environment, you create a host pool from your gold image, which you ideally create through an automated process.

You can also use a build checklist to scale up. If you have a large environment, the checklist process should only be part of your initial dev/test setup. The more you automate your gold image creation, the more confident you can be in the accuracy of your build and environment stability.

We don't recommend using your existing image to create a VM that you update with new applications and configuration changes and then capture for use as your "new" gold image. Maintaining this scenario involves significant risk and is a major factor in desktop virtualization environments becoming static and fragile.

There are many automation tools for creating gold images, including the Packer process we describe later in this article. Use the tool set that's most appropriate for your organization. Regardless of which tools that you choose, automate as much of your gold image creation as possible so you can more easily maintain your Azure Virtual Desktop environment's health.

### Application installation

Applications can be made available to your users two ways: installed in the image, or delivered dynamically per user.

Applications installed in the image should be universal to your users and a part of your automated image creation process. Image-installed applications can include security products and the Microsoft 365 suite.

Applications dynamically delivered per user should include everything else that requires a more flexible approach. Dynamically delivered applications can include applications that are restricted to a specific group and applications that aren't compatible with other applications.

### Language deployment

As your Azure Virtual Desktop environments start to scale out, you might need to localize images into the native language for your users. You can start from the local language if you prefer, or you can add more languages to your image on build. Consider this requirement while selecting your base image. The pre-optimized Windows 10 gallery image, for example, both with and without Microsoft 365, is only supplied in United States English (en-US).

> [!NOTE]
> If you're using Windows 10 Enterprise multi-session, you can't build it using a different language. In this case, you must adapt the provided gallery image. To adapt the existing en-US gallery image, install the additional languages before you install other applications.

### Deployment locations

Azure Virtual Desktop offers more freedom around the geographic placement of your host pools than traditional desktop environments do. This freedom exists because all Azure locations support Azure Virtual Desktop. Avoid creating VMs from an image across a broad wide area network (WAN) by making your gold image available in each of the same locations as your users.

### Host pool gold image updates

There are two ways you can update the gold image your VMs in a particular host pool are based on.

Method one:

- Deploy a second host pool, then cut users over to the new host pool when you're ready.
- Make the old host pool available for if a rollback is needed.
- You can remove the old host pool once your organization is satisfied that the new host pool is working correctly.

Method two:

- Set your existing VMs to drain mode in the host pool.
- Deploy new VMs from your updated gold image into that same host pool.
- Take care not to hit resource constraints or API throttling limits when you double the number of VMs in a single host pool.

## Design recommendations

Review the following recommendations as you design your organization's Azure Virtual Desktop environment.

### Source code management

We recommend using [Git](https://git-scm.com/) for managing source code and [keeping a simple branching strategy.](/azure/devops/repos/git/git-branching-guidance) When using Git for your environment:

- Keep your Git repo and Azure DevOps project private unless your company policy specifies that repositories must be public.
- Initialize your repo with a README file so you can start filling in information about your project.
- Amend your project permissions to allow other team members access.
- Adopt a basic work item process to develop the pipeline and keep your workloads streamlined.
- At minimum, you should maintain two repos: one repo for managing your gold image builds, and another repo for managing your Azure Virtual Desktop deployments.

### Pipelines

Your pipeline deployment system is dictated by which source code management system you choose.

If your organization has standardized on Azure DevOps, use [Azure Pipelines](/azure/devops/pipelines/get-started/what-is-azure-pipelines). If your organization has standardized on GitHub, use [GitHub Actions](https://docs.github.com/actions). Either option provides the ability to deploy a self-hosted agent within in your network, which has several benefits, including:

- Allowance for longer build times
- Ability to access resources within your network

Gate your deployment pipelines so they can be automatically triggered to deploy to a validation host pool, but not automatically pushed to your production host pool without explicit approval.

### Variables and Azure Key Vault

Use variable groups when working in Azure Pipelines.
- Variable groups let you have repeatable parameters in your pipelines like secrets and file locations.
- Variables within variable groups can be stored as key/value pairs, but the recommended method is [Linking a variable group to an Azure Key Vault](/azure/devops/pipelines/release/azure-key-vault?view=azure-devops&preserve-view=true) to pull in secrets for use in your deployment pipeline.

### Create Azure Virtual Desktop images

Use the [Azure Image Builder](/azure/virtual-machines/image-builder-overview) (AIB) service to automate the build, update, sysprep, and distribution processes for your gold images. This service can use a supported base image from the Azure Marketplace for each build to ensure you have the latest updates.

> [!NOTE]
> Azure Image Builder is currently available within [select regions](/azure/virtual-machines/image-builder-overview), but you can distribute images outside of these regions.

As part of your gold image build process, consider all the applications you need to install and determine if they can be installed via scripts. Make sure you have application installation commands scripted in PowerShell and committed to your Git repo. If you can't download application installers over public internet, consider placing the applications in Azure Blob Storage. If your application installation processes need secrets, consider placing them in Azure Key Vault.

To get started with Azure Image Builder, see [Create an Azure Virtual Desktop image using Azure VM Image Builder and PowerShell](/azure/virtual-machines/windows/image-builder-virtual-desktop)

To invoke Azure Image Builder using CI/CD pipelines, use either the [Azure Image Builder Service DevOps Task](/azure/virtual-machines/linux/image-builder-devops-task) for Azure Pipelines or the [Build Azure Virtual Machine Image Action](https://github.com/marketplace/actions/build-azure-virtual-machine-image) for GitHub Actions.

HashiCorp Packer is an open source alternative. It offers the same capabilities as Azure Image Builder (which is built on top of HashiCorp Packer), including the ability to distribute to an Azure Compute Gallery.

For more information about Packer, see the [Packer website](https://www.packer.io/docs/builders/azure).

The Packer method has the following prerequisites:

- Azure DevOps licensing must use the full suite of Packer tools.
- You must assign a user the appropriate role in Microsoft Entra ID.
- You must give a service principals contributor access to the subscription.
- You must have an Azure Key Vault to store secrets in, giving the service principal **secret management** in the access policy.

When working with Packer in your deployment pipeline:

- Install Packer tools on the build agent you'll use in your deployment pipeline.
- Create a validation stage in your pipeline to validate that the build works.
- After validation, clone your validation stage and set the deployment mode to **Incremental**.

Other considerations for Packer file storage:

- Store your Packer files and provisions in a centralized location that Azure Pipelines can access. We recommend using Azure file shares to securely store these files.
- Store access credentials for Azure Files in Key Vault. You can pull the access credentials from Key Vault on build using pipeline variables.
- Additionally, store your Packer file name and account key in the key vault linked to the variable group in Azure DevOps. Pipelines access these credentials to download Packer files to the VM used to create the image.
- Store the UNC path as a variable in the Azure DevOps variable group.

### Store Azure Virtual Desktop images

The Azure Compute Gallery service is the simplest way to build structure and organization around your gold images. It provides:

- Global replication of images to different Azure regions.
  - Make sure you've deployed images in the regions that Azure Virtual Desktop session hosts (VMs) deploy to.
- Image versioning and grouping for easier management. Versioning and grouping are helpful for rolling back Azure Virtual Desktop host pools to previous image versions.
- Highly available images with zone-redundant storage (ZRS) accounts in regions that support Availability Zones. ZRS offers better resilience against zonal failures.
- Azure Virtual Desktop image sharing across subscriptions, and even between Microsoft Entra tenants, through role-based access control (RBAC).
- Deployment scaling with image replicas in each region.
  - Plan on deploying [one replica for every 20 VMs](/azure/virtual-machines/shared-image-galleries) you plan to deploy concurrently.

For more information, see the [Azure Compute Gallery service overview](/azure/virtual-machines/shared-image-galleries).

### Application installation in Azure Virtual Desktop images

- For universal applications installed in your gold image, use the Packer method described earlier in this article.
- **App Attach** is the supported method for dynamically delivering applications to users in Azure Virtual Desktop. App Attach allows applications to be containerized or presented via a virtual disk and attached at user logon, reducing the size and complexity of the base image. This approach improves flexibility, simplifies updates, and supports modern DevOps practices.
- Use CI/CD pipelines to automate the packaging and delivery of applications used with App Attach. For packaging guidance, see the [CI/CD overview for application packaging](/windows/msix/desktop/cicd-overview).

### Deploy languages in Azure Virtual Desktop images

Microsoft has processes for installing language packs manually or automatically. We recommend keeping as little administration overhead as possible and automating your language installation process.

The process involves downloading a PowerShell script onto the VM that will be converted into your image. You can find example automation scripts in Microsoft documentation. If you're following the recommendation for Packer pipelines, you can include this process as an extra build task.

For more information on installing language packs in Windows 10 Enterprise multi-session, see [Install language packs on Windows 10 VMs in Azure Virtual Desktop](/azure/virtual-desktop/language-packs).

### Create Azure Virtual Desktop host pools from Azure Compute Gallery images

Use an Infrastructure as Code (IaC) approach to the deployment and customization of Azure Virtual Desktop resources. They should be used whenever possible to ensure consistency in deployments. ARM templates can be used to deploy Azure Virtual Desktop resources as part of a CI/CD pipeline task. You can also use them when using the Azure portal, Azure PowerShell, or Azure CLI.

Below is a recommended host pool update strategy:

- Set up a CI/CD pipeline to build and distribute gold images to Azure Compute Gallery.
- Designate a validation host pool and deploy new session hosts into the validation host pool using CI/CD pipelines.
- Test your automation by using a validation host pool.
- Tag your session hosts with a build number or image version to identify the version of the image they're running.
- Before you deploy, validate (or check) to ensure that you have sufficient compute quota within your subscription.
- Upon successful testing in the validation pool, put existing session hosts into drain mode - tagged VMs will be easy to identify.
- Deploy new session hosts and allow users to connect.
- Upon successful testing in production, begin to deallocate old session hosts to not incur any more compute charges and eventually delete to not incur any more managed disk charges.
- Deleted sessions hosts will only be removed from Azure. Computer objects will remain in your AD, so these computer objects will need to be deleted manually or via script.

The example above shows one method of image automation using Azure DevOps and a continuous integration and continuous delivery (CI/CD) pipeline. This is a cloud-native approach and offers a less disruptive rollout of new session hosts with no downtime. It's important to note that you should consider the surge in virtual machine counts as you phase old images out and bring new images online.

As mentioned above, the Azure Compute Gallery is a service that helps you build structure and organization around your images. These images can be referred to in your IaC deployments of your Azure Virtual Desktop session hosts. The service allows for versioning, grouping, and replication of images.

When you deploy your session hosts with an [ARM template](https://github.com/Azure/RDS-Templates/tree/master/ARM-wvd-templates/CreateAndProvisionHostPool) or [Terraform](https://github.com/Azure/terraform/tree/master/quickstart/101-azure-virtual-desktop), we recommend using the resource ID of the image you created in your gallery as the VM custom image source ID. The image that you're using must be replicated via the Azure Compute Gallery service to the Azure regions where you're deploying your Azure Virtual Desktop host pools.

## Next steps

Learn how to deploy Azure Virtual Desktop by using the landing zone accelerator for enterprise-scale scenarios.

> [!div class="nextstepaction"]
> [1. Azure Virtual Desktop landing zone accelerator design areas](./enterprise-scale-landing-zone.md)

> [!div class="nextstepaction"]
> [2. Azure Virtual Desktop landing zone accelerator Github repository](https://github.com/Azure/avdaccelerator)
