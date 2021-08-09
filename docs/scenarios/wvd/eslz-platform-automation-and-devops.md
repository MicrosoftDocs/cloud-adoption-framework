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

# Platform automation and DevOps considerations for an Azure Virtual Desktop

Azure Virtual Desktop is a managed service that provides a Microsoft control plane for your desktop virtualization environment.

This article on automation focuses on the operational tasks you need to run an Azure Virtual Desktop environment. Each recommendation can be applied individually, and not all recommendations need to be implemented for automation to be worthwhile.

## Design considerations

### Integrate image creation with DevOps

Automation doesn't have to mean integration with DevOps, but there are many advantages to doing so. It's worth spending the time to automate the build process for your golden image because:

- Using a DevOps pipeline gives you better management of your automation flow.
- A DevOps pipeline provides reporting and alerting on deployments.
- You can configure your pipeline to integrate with testing frameworks and create approval gates for the stages in your automation process.
- You can start pipelines from many predefined events like the release of a new gallery image, application or using a set schedule.
- Automating host pool creation makes it easy to move your host pool metadata to a new geographical location as new locations are made available.

### Pooled vs. personal

As organizations scale out their environment, most of the workload falls under a *pooled* configuration rather than a *personal* configuration. A personal configuration is often more expensive to run than a pooled configuration, but it's suitable for specific workload users like developers, since developers usually require elevated permissions. If you run host pools in personal mode, try to maintain the machines like you maintain your physical desktops. This method reduces the amount of tooling required in your environment.

Since pooled is the most popular configuration for desktop virtualization, it's the focus of this article.

You'll update pooled environments differently than in a traditional environment. The virtual machines (VMs) should be updated from a gold image at the correct cadence for your organization, which is usually every 1-3 months. In highly automated organizations, it's possible to increase that cadence to weekly or even nightly if needed.

### Image creation

When scaling up your Azure Virtual Desktop environment, your host pools are created from a gold image, which is ideally created using an automated process.

Another option is to use a build checklist. In large environments, this process should only be part of the initial dev/test setup. The more you automate your gold image creation, the more secure you'll be in the accuracy of your build and environment stability.

The process of using your existing image to create a VM which is updated with new with your applications and configuration changes, then captured for use as your "new" gold image is not recommended. This process is risky to maintain and is a major cause of desktop virtualization environments becoming static and fragile.

There are many automation tools available to create gold images including the Packer process outlined later in this article. However, organizations should use the tool set that's most appropriate for them. Regardless of the tools that you choose, try to get as much of your gold image creation automated so its easier to maintain the health of your Azure Virtual Desktop environment.

### Application installation

Applications are made available to your users in two ways: installed in the image or delivered dynamically per user.

- Applications installed in the image should be universal to your users. For example, security products and the Microsoft 365 suite. These applications should be a part of your automated image creation process.

- Applications dynamically delivered per user should include everything else that requires a more flexible approach, such as applications that are restricted to a specific group or aren't compatible with other applications.

### Language deployment

As Azure Virtual Desktop environments start to scale out, your images may need to be localized into the native language for your users. You can start from the local language if you prefer or you can add additional languages to your image on build. Consider this requirement when selecting your base image. The pre-optimized Windows 10 gallery image for example, both with and without Microsoft 365, is only supplied in United States English (en-US).

> [!NOTE]
> If you're using Windows 10 Enterprise multi-session, this cannot be built using a different language. In this case, you must adapt the provided gallery image. To adapt the existing en-US gallery image, install the additional languages before you install other applications.

### Image location

In Azure Virtual Desktop, you have more freedom around the geographic placement of your host pools than in a traditional desktop environment. This freedom exists because all Azure locations support Azure Virtual Desktop. To avoid creating VMs from an image across the wide area network (WAN) make your gold image available in the same locations as your users.

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

### Creation of Azure Virtual Desktop images

Microsoft recommend using Packer pipelines to automate image creation and management. To use this method, prerequisites are:

- Azure DevOps licensing is required to use the full suite of Packer tools.
- A user assigned the Global Administrator role in Azure Active Directory (Azure AD).
- A service principal with contributor access to the subscription.
- An Azure Key Vault to store secrets in, giving the service principal **secret management** in the access policy.

For more information about Packer, see the [Packer website](https://www.packer.io/docs/builders/azure).

### Version control

- We recommend using Git for version control.
- The Git repo and Azure DevOps project should be private unless your company policy specifies that repositories must be public.
- Initialize the repo with a README file. The file lets you start filling information into the repository about your project.
- A good structure for the repository is to have two folders in the root of the repository: one called `ARM templates` to store the Azure Resource Manager (ARM) templates, and one for the build you're planning, such as `Windows 2004 - EVD`.
- Amend your project permissions to allow other team members access to the project.
- Adopt a basic work item process to develop the pipeline and keep your workloads streamlined.

### Pipelines

Azure Pipelines has many different features. Our recommendations when it comes to setting up Packer are to use gateways, marketplace, and deployment services.

When working with Packer in the deployment pipeline:

- You must install Packer tools into the VM you will use as your base image.
- We recommend creating a validation stage in the pipeline to validate that the build works.
- After validation, clone the validation stage and set the deployment mode to **Incremental**.

### Variables and Azure Key Vault

- When working in Azure Pipelines, use variable groups.
- Variable groups let you have repeatable parameters in your pipelines, such as secrets and file locations.
- There are two variable groups in Azure DevOps: one stores standard variables, and the other is linked to Azure Key Vault. The variable group linked to Azure Key Vault is used to pull across secrets for use in the pipeline.

### Packer file storage

- Store your Packer files and provisions in a centralized location for Azure Pipelines to access. We recommend using Azure file shares to securely store these files.
- Store the access credentials for Azure Files in Key Vault. You can pull the access credentials from Key Vault on build using the pipeline variables.
- Additionally, store the Packer file name and account key in the key vault that's linked to the variable group in Azure DevOps. These credentials are accessed by pipelines to download the Packer files to the VM that's used to create the image.
- Like the storage account name and primary key, store the UNC path as a variable in the Azure DevOps variable group.

### Shared Image Gallery service

The Shared Image Gallery service in Azure is the simplest way to build structure and organization around your golden images. It provides:

- Global replication of images to different Azure regions.
- Versioning and grouping of images for easier management. It's helpful if you need to roll back Azure Virtual Desktop host pools to previous image versions.
- Highly available images with zone-redundant storage (ZRS) accounts in regions that support Availability Zones. ZRS offers better resilience against zonal failures.
- Sharing Azure Virtual Desktop images across subscriptions, and even between Azure AD tenants, using role-based access control (RBAC).
- Scaling your deployments with image replicas in each region.

For more information, see the [Shared Image Gallery service overview](/azure/virtual-machines/shared-image-galleries).

### Application installation in Azure Virtual Desktop images

- For universal applications installed in the gold image, use the same Packer method as above to install applications.
- [App-V](/windows/application-management/app-v/appv-getting-started) is currently the supported method from Microsoft for streaming applications on a per-user basis.
- Use [FSLogix application masking](/fslogix/implement-application-masking-tutorial) to hide or reveal applications or plug-ins when those applications don't work well with App-V.

### Deployment of languages in Azure Virtual Desktop images

Microsoft has processes for installing language packs manually or automatically. We recommended keeping as little administration overhead as possible and automating the process of language installation. This involves downloading a PowerShell script onto the VM that will be converted into your image. Example automation scripts are found in Microsoft documentation. If you're following the recommendation for Packer pipelines, you can include this process as an extra build task.

For more information on installing language packs in Windows 10 Enterprise multi-session, see [Install language packs on Windows 10 VMs in Azure Virtual Desktop](/azure/virtual-desktop/language-packs).

### Create Azure Virtual Desktop host pools using ARM templates from images in shared image galleries

Using ARM templates allows for an infrastructure as code (IaC) approach to the deployment and customization of Azure Virtual Desktop resources. They should be used whenever possible to ensure consistency in deployments. ARM templates can be used to deploy Azure Virtual Desktop resources as part of a DevOps pipeline task. You can also use them when using the Azure portal, Azure PowerShell, or Azure CLI.

The example above shows one method of image automation using Azure DevOps and a Packer continuous integration and continuous delivery (CI/CD) pipeline. Part of the underlying technology in the process is an ARM template.

The Shared Image Gallery is a service that helps you build structure and organization around your images. These images can be referred to in your IaC deployments of your Azure Virtual Desktop session hosts. The service allows for versioning, grouping, and replication of images.

When you deploy your session hosts with an [ARM template](https://github.com/Azure/RDS-Templates/tree/master/ARM-wvd-templates/CreateAndProvisionHostPool), we recommend using the resource ID of the image you created in your gallery as the VM custom image source ID. The image that you're using must be replicated via the Shared Image Gallery service to the Azure regions where you're deploying your Azure Virtual Desktop host pools.
