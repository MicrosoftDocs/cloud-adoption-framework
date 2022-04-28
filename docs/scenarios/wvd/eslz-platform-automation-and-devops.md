---
title: Platform automation and DevOps for Azure Virtual Desktop
description: Learn how this design area can improve platform automation and DevOps for Azure Virtual Desktop.
author: BrianBlanchard
ms.author: brblanch
ms.date: 05/18/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-avd
---

# Platform automation and DevOps considerations for Azure Virtual Desktop

Azure Virtual Desktop is a managed service that provides a Microsoft-managed control plane for your desktop virtualization environment.

This article on automation focuses on the operational tasks you need to run an Azure Virtual Desktop environment. Each recommendation can be applied individually, and not all recommendations need to be implemented for automation to be worthwhile.

## Design considerations

### Integrate with DevOps

Automation doesn't have to mean integration with DevOps, but there are many advantages to doing so. It's worth spending the time to automate the build process for your gold image and deployment of Azure Virtual Desktop because:

- Using a Continuous Integration and Continuous Deployment (CI/CD) pipeline gives you better management of your automation flow.
- A CI/CD pipeline provides reporting and alerting on deployments.
- You can configure your pipeline to integrate with testing frameworks and create approval gates for the stages in your automation process.
- You can start pipelines from many predefined events like the release of a new gallery image, application or using a set schedule.
- Automating host pool creation makes it easy to move your host pool metadata to a new geographical location as new locations are made available.

### Infrastructure-as-Code (IaC)

As you move towards embracing DevOps practices, you will need to decide on a tool for deploying your Azure resources. There are two different [categories of IaC tooling](/azure/architecture/framework/devops/automation-infrastructure#categories-of-iac-tooling). The preferred option is to use a declarative IaC tool. Azure provides native options with [ARM templates](/azure/azure-resource-manager/templates/overview) and [Azure Bicep](/azure/azure-resource-manager/bicep/overview).

There are 3rd party IaC tools such as HashiCorp's [Terraform](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs) as well.

### Pooled vs. personal

As organizations scale out their environment, most of the workload falls under a _pooled_ configuration rather than a _personal_ configuration. A personal configuration is often more expensive to run than a pooled configuration, but it's suitable for specific workload users like developers, since developers usually require elevated permissions. If you run host pools in personal mode, try to maintain the machines like you maintain your physical desktops. This method reduces the amount of tooling required in your environment.

Since pooled is the most popular configuration for desktop virtualization, it's the focus of this article.

You'll update pooled environments differently than in a traditional environment. The virtual machines (VMs) should be updated from a gold image at the correct cadence for your organization, which is usually every 1-3 months. In highly automated organizations, it's possible to increase that cadence to weekly or even nightly if needed.

### Image creation

When scaling up your Azure Virtual Desktop environment, your host pools are created from a gold image, which is ideally created using an automated process.

Another option is to use a build checklist. In large environments, this process should only be part of the initial dev/test setup. The more you automate your gold image creation, the more secure you'll be in the accuracy of your build and environment stability.

The process of using your existing image to create a VM which is updated with new with your applications and configuration changes, then captured for use as your "new" gold image is not recommended. This process is risky to maintain and is a major cause of desktop virtualization environments becoming static and fragile.

There are many automation tools available to create gold images including the Azure Image Builder and HashiCorp Packer. However, organizations should use the tool set that's most appropriate for them. Regardless of the tools that you choose, try to get as much of your gold image creation process automated so its easier to maintain the health of your Azure Virtual Desktop environment.

### Application installation

Applications are made available to your users in two ways: installed in the image or delivered dynamically per user.

- Applications installed in the image should be universal to your users. For example, security products and the Microsoft 365 suite. These applications should be a part of your automated image creation process.

- Applications dynamically delivered per user should include everything else that requires a more flexible approach, such as applications that are restricted to a specific group or aren't compatible with other applications.

### Language deployment

As Azure Virtual Desktop environments start to scale out, your images might need to be localized into the native language for your users. You can start from the local language if you prefer or you can add additional languages to your image on build. Consider this requirement when selecting your base image. The pre-optimized Windows 10 gallery image for example, both with and without Microsoft 365, is only supplied in United States English (en-US).

> [!NOTE]
> If you're using Windows 10 Enterprise multi-session, this cannot be built using a different language. In this case, you must adapt the provided gallery image. To adapt the existing en-US gallery image, install the additional languages before you install other applications.

### Deployment locations

In Azure Virtual Desktop, you have more freedom around the geographic placement of your host pools than in a traditional desktop environment. This freedom exists because all Azure locations support Azure Virtual Desktop session host (VM) deployments. To avoid creating VMs from an image across the wide area network (WAN) make your gold image available in the same locations as your users.

### Host pool gold image updates

There are two approaches to updating the gold image that VMs in a host pool are based on:

- Deploy a second host pool, then cut the users over to the new host pool when you're ready.
- The old host pool is then available if a rollback is needed.
- The old host pool can be removed after the organization is satisfied that the new host pool is working correctly.

Or:

- Set the existing VMs to drain mode in the host pool.
- Deploy new VMs from the updated gold image into the same host pool.
- Take care not to hit resource constraints or API throttling limits when doubling the number of VMs in a single host pool.

## Design recommendations

### Source code management

- We recommend using [Git](https://git-scm.com/) for source code management and [keeping a simple branching strategy.](/azure/devops/repos/git/git-branching-guidance&preserve-view=true?view=azure-devops/)
- The Git repo and Azure DevOps project (or GitHub repo) should be private unless your company policy specifies that repositories must be public.
- Initialize the repo with a README file. The file lets you start filling information into the repository about your project.
- Amend your project permissions to allow other team members access to the project.
- Adopt a basic work item process to develop the pipeline and keep your workloads streamlined.
- At minimum, you should have two repos; one repo for managing your gold image builds, and another repo for managing your Azure Virtual Desktop deployments.

### Pipelines

The pipeline deployment system will be dictated by the source code management system you choose. If your organization has standardized on Azure DevOps, then use [Azure Pipelines](/azure/devops/pipelines/get-started/what-is-azure-pipelines&preserve-view=true?view=azure-devops). If your organization has standardized on GitHub, then use [GitHub Actions](https://docs.github.com/actions). Either option gives you the ability to deploy a self-hosted agent within in your network. This has several benefits including:

- Allowing for longer build times.
- Ability to access resources within your network.

Deployment pipelines should be gated so that they can be automatically triggered to deploy to a validation host pool but not automatically pushed to the production host pool without explicit approval.

### Variables and Azure Key Vault

- When working in Azure Pipelines, use variable groups.
- Variable groups let you have repeatable parameters in your pipelines, such as secrets and file locations.
- Variables within variable groups can be stored as key/value pairs, but the recommended way is to [link to a variable group to an Azure Key Vault](/azure/devops/pipelines/release/azure-key-vault&preserve-view=true?view=azure-devops) to pull in secrets for use in your deployment pipeline.

### Creation of Azure Virtual Desktop images

Use the [Azure Image Builder](/azure/virtual-machines/image-builder-overview) (AIB) service to automate the build, update, sysprep, and distribution processes for your gold images. This service can use a supported base image from the Azure Marketplace for each build to ensure you have the latest updates.

> [!NOTE]
> Azure Image Builder is currently available within [select regions](/azure/virtual-machines/image-builder-overview); however, images can be distributed outside of these regions.

As part of your gold image build process, consider all the applications that need to be installed and determine if they can be installed via scripts. Make sure you have application installation commands scripted in PowerShell and committed to your Git repo. If application installers cannot be downloaded over public internet, consider placing the applications in Azure Blob Storage. Lastly, if application installation processes need secrets, consider placing them in Azure Key Vault.

To get started with Azure Image Builder, see [Create an Azure Virtual Desktop image using Azure VM Image Builder and PowerShell](/azure/virtual-machines/windows/image-builder-virtual-desktop)

To invoke Azure Image Builder using CI/CD pipelines, use either the [Azure Image Builder Service DevOps Task](/azure/virtual-machines/linux/image-builder-devops-task) for Azure Pipelines or the [Build Azure Virtual Machine Image Action](https://github.com/marketplace/actions/build-azure-virtual-machine-image) for GitHub Actions.

HashiCorp Packer is an open source alternative and will offer the same capabilities as Azure Image Builder (AIB is built on top of HashiCorp Packer) including the ability to distribute to an Azure Compute Gallery.

For more information about Packer, see the [Packer website](https://www.packer.io/docs/builders/azure).

To use Packer method, prerequisites are:

- Azure DevOps licensing is required to use the full suite of Packer tools.
- A user assigned the Global Administrator role in Azure Active Directory (Azure AD).
- A service principal with contributor access to the subscription.
- An Azure Key Vault to store secrets in, giving the service principal **secret management** in the access policy.

When working with Packer in the deployment pipeline:

- You must install Packer tools on the build agent that you will use in your deployment pipeline.
- We recommend creating a validation stage in the pipeline to validate that the build works.
- After validation, clone the validation stage and set the deployment mode to **Incremental**.

Additional considerations for Packer file storage:

- Store your Packer files and provisions in a centralized location for Azure Pipelines to access. We recommend using Azure file shares to securely store these files.
- Store the access credentials for Azure Files in Key Vault. You can pull the access credentials from Key Vault on build using the pipeline variables.
- Additionally, store the Packer file name and account key in the key vault that's linked to the variable group in Azure DevOps. These credentials are accessed by pipelines to download the Packer files to the VM that's used to create the image.
- Like the storage account name and primary key, store the UNC path as a variable in the Azure DevOps variable group.

### Storing Azure Virtual Desktop images

The Azure Compute Gallery service in Azure is the simplest way to build structure and organization around your gold images. It provides:

- Global replication of images to different Azure regions.
  - Be sure you have deployed images in the regions where AVD session hosts (VMs) will be deployed to.
- Versioning and grouping of images for easier management. It's helpful if you need to roll back Azure Virtual Desktop host pools to previous image versions.
- Highly available images with zone-redundant storage (ZRS) accounts in regions that support Availability Zones. ZRS offers better resilience against zonal failures.
- Sharing Azure Virtual Desktop images across subscriptions, and even between Azure AD tenants, using role-based access control (RBAC).
- Scaling your deployments with image replicas in each region.
  - You should plan on deploying [1 replica for every 20 VMs](/azure/virtual-machines/shared-image-galleries) you plan to deploy concurrently.

For more information, see the [Azure Compute Gallery service overview](/azure/virtual-machines/shared-image-galleries).

### Application installation in Azure Virtual Desktop images

- For universal applications installed in the gold image, use the same Packer method as above to install applications.
- [App-V](/windows/application-management/app-v/appv-getting-started) is currently the supported method from Microsoft for streaming applications on a per-user basis.
- Use [FSLogix application masking](/fslogix/implement-application-masking-tutorial) to hide or reveal applications or plug-ins when those applications don't work well with App-V.
- Use [MSIX app attach](/azure/virtual-desktop/what-is-app-attach) where possible to dynamically deliver applications to users and reduce the overall size of your gold image. The process of packaging applications into the MSIX format can also be automated using CI/CD pipelines. To learn more, please refer to this [guide](/msix/desktop/cicd-overview)

### Deployment of languages in Azure Virtual Desktop images

Microsoft has processes for installing language packs manually or automatically. We recommended keeping as little administration overhead as possible and automating the process of language installation. This involves downloading a PowerShell script onto the VM that will be converted into your image. Example automation scripts are found in Microsoft documentation. If you're following the recommendation for Packer pipelines, you can include this process as an extra build task.

For more information on installing language packs in Windows 10 Enterprise multi-session, see [Install language packs on Windows 10 VMs in Azure Virtual Desktop](/azure/virtual-desktop/language-packs).

### Create Azure Virtual Desktop host pools from images in Azure Compute Gallery

Use an Infrastructure as Code (IaC) approach to the deployment and customization of Azure Virtual Desktop resources. They should be used whenever possible to ensure consistency in deployments. ARM templates can be used to deploy Azure Virtual Desktop resources as part of a CI/CD pipeline task. You can also use them when using the Azure portal, Azure PowerShell, or Azure CLI.

Below is a recommended host pool update strategy:

- Setup a CI/CD pipeline to build and distribute gold images to Azure Compute Gallery.
- Designate a validation host pool and deploy new session hosts into the validation host pool using CI/CD pipelines.
- Test your automation by using a validation host pool.
- Tag your session hosts with a build number or image version to identify the version of the image they are running.
- Before you deploy, validate (or check) to ensure that you have sufficient compute quota within your subscription.
- Upon successful testing in the validation pool, put existing session hosts into drain mode - tagged VMs will be easy to identify.
- Deploy new session hosts and allow users to connect.
- Upon successful testing in production, begin to deallocate old session hosts to not incur any more compute charges and eventually delete to not incur any more managed disk charges.
- Deleted sessions hosts will will only be removed from Azure. Computer objects will remain in your AD, so these computer objects will need to be deleted manually or via script.

The example above shows one method of image automation using Azure DevOps and a continuous integration and continuous delivery (CI/CD) pipeline. This is a cloud-native approach and offers a less disruptive rollout of new session hosts with no downtime. It is important to note that you should consider the surge in virtual machine counts as you phase old images out and bring new images online.

As mentioned above, the Azure Compute Gallery is a service that helps you build structure and organization around your images. These images can be referred to in your IaC deployments of your Azure Virtual Desktop session hosts. The service allows for versioning, grouping, and replication of images.

When you deploy your session hosts with an [ARM template](https://github.com/Azure/RDS-Templates/tree/master/ARM-wvd-templates/CreateAndProvisionHostPool) or [Terraform](https://github.com/Azure/terraform/tree/master/quickstart/101-azure-virtual-desktop), we recommend using the resource ID of the image you created in your gallery as the VM custom image source ID. The image that you're using must be replicated via the Azure Compute Gallery service to the Azure regions where you're deploying your Azure Virtual Desktop host pools.
