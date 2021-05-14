---
title: Enterprise-scale platform automation and DevOps for Windows Virtual Desktop
description: Learn how this enterprise-scale scenario can improve platform automation and DevOps for Windows Virtual Desktop.
author: BrianBlanchard
ms.author: brblanch
ms.date: 09/11/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Platform automation and DevOps for a Windows Virtual Desktop enterprise-scale scenario

Windows Virtual Desktop is a managed service that provides a Microsoft control plane for your desktop virtualization environment.

This article on automation focuses on the operational tasks you need to run a Windows Virtual Desktop environment. Each recommendation can be applied individually, and not all recommendations need to be implemented for automation to be worthwhile.

## Design considerations

### Pooled vs. personal

As organizations scale out their environment, most of the workload falls under a *pooled* configuration instead of *personal*. Personal is correct for specific workloads, like developers. Since developers usually need elevated permissions, personal is often more expensive to run than a pooled configuration.

If you run host pools in personal mode, try to maintain the machines like you maintain your physical desktops. This method reduces the amount of tooling in your environment. Since pooled is the most popular configuration and specific to desktop virtualization, it's the focus of this article.

You'll update pooled environments differently than in a traditional environment. The virtual machines (VMs) should be updated from a gold image at the correct cadence for your organization. That cadence is usually every 1-3 months. In highly automated organizations, it's possible to increase that cadence to weekly or even nightly if needed.

### Image creation

When scaling up your Windows Virtual Desktop environment, your host pools are created from a gold image. You create that image through automation.

Another option is to start a process where checklists are used. In large environments, this process should only be part of the initial dev/test setup. The more you automate your gold image creation, the more secure you'll be in the accuracy of your build and environment stability.

It's possible to take the 'old' image, and then use it to create a VM. You can update that VM with the applications and configuration changes for that update, and then capture that to your 'new' image. We don't recommend this process for creating gold images, as it's risky to maintain. It's the major cause of desktop virtualization environments becoming static and fragile. Windows is limited to running [Sysprep](/windows-hardware/manufacture/desktop/sysprep--generalize--a-windows-installation) eight times, which limits how many times you can create a gold image.

There are many automation tools available to create gold images. Use the tool set that's most appropriate for your organization. You can choose the tool set based on the existing skill set and process, or cost considerations.

When you're considering automation for your Windows Virtual Desktop environment, try to get 100 percent of your gold image build process automated. If you can get at least 80% of your gold image creation automated, it's still a good investment of your time. It makes it much easier to maintain the health of your Windows Virtual Desktop environment.

### Application installation

Applications are made available to your users in two ways: installed in the image, or delivered dynamically per user.

In a large-scale environment, it's impractical to install all of the applications into the image. You might have applications that must have restricted access, or incompatible applications or versions. Now you must split your applications into the two groups previously mentioned.

Applications installed in the image should be universal to your users. For example, security products and the Microsoft 365 suite. These applications should be a part of your image creation automation.

Applications dynamically delivered per user should be everything else. You'll need flexibility here, as following these rules can force you to spend too much time making an incompatible application fit into a group.

### Languages deployment

As Windows Virtual Desktop environments start to scale out, it's often required that images be localized into the native language for the user. Consider the basis for your image. The pre-optimized Windows 10 gallery image both with and without Microsoft 365 is only supplied in United States English (en-US). You can start your image automation from a native language, or you can adapt the existing en-US gallery image. Install languages before you install other applications. If you're using Windows 10 Enterprise multi-session, it's not available to start from a native language, and you must adapt the provided gallery image.

### Integrate image creation with DevOps

Automation doesn't have to mean integration with DevOps. But there are many advantages to doing so, and it's worth spending the extra time once you've automated the build process for your golden image. A DevOps pipeline gives you better management of your automation flow and provides reporting and alerting on your pipeline. You can integrate with testing frameworks and create approval gates for the stages in your automation. You can also start pipelines from many events. These events might be the release of a new gallery image or application, or just on a schedule.

Windows Virtual Desktop gold images should be available to create host pools in the required Azure regions.

In Windows Virtual Desktop, you have more freedom on the geographic placement of your host pools than in a traditional desktop environment. This freedom exists because all Azure locations support Windows Virtual Desktop. Enable your organization to take advantage of this freedom and adjust the placement of the VMs to the most effective location.

To do adjust the VM placement, make your gold image available in the required locations. Then you don't have to create VMs from an image across the wide area network (WAN).

You can update or roll back the VMs in a host pool to a different version.

There are two approaches to updating the image that VMs in a host pool are based on when using a gold image.

- Deploy a second host pool, and then cut the users over to the new host pool when you're ready. The old host pool is then available if a rollback is needed. The old host pool can be removed after the organization is satisfied that the new host pool is working correctly.

- Set the VMs to drain mode in the host pool and deploy more VMs from the new image into the same host pool. Take care not to hit resource constraints or API throttling limits when doubling the number of VMs in a single host pool.

### Host pool creation

You can decide to update VMs in place, or create a side-by-side environment for updating your host pools. Either way, automating the creation process for your host pool provides you with consistent and reliable results. Even in an environment where the host pools are static, you might want to move your host pool metadata to a new geographical location. This movement is recommended because new locations are made available over time.

## Design recommendations

### Creation of Windows Virtual Desktop images

Use Packer to create the image. By using a Packer pipeline for image management, you can automate image creation. Azure DevOps licensing is required to use the full suite of tools. The other prerequisites are:

- A user assigned the Global Administrator role in Azure Active Directory (Azure AD).
- A service principal with contributor access to the subscription.
- An Azure Key Vault to store secrets in, giving the service principal **secret management** in the access policy.

The Azure DevOps project should be private unless your company policy specifies that repositories must be public. We recommend using Git for version control. Amend the project permissions to allow other team members access to the project. Adopt a basic work item process to develop the pipeline and keep your workloads streamlined.

When you use Azure Repos, initialize the repo with a README file. The file lets you start filling information into the repository about your project. A good structure for the repository is to have two folders in the root of the repository: one called `ARM templates` to store the Azure Resource Manager (ARM) templates, and one for the build you're planning, such as `Windows 2004 - EVD`.

When working in Azure DevOps, use variable groups in your pipelines. Variable groups let you have repeatable parameters in your pipelines, such as secrets and names. There are two variable groups. One stores standard variables, and the other is linked to Azure Key Vault. The second group is used to pull across secrets for use in the pipeline.

Store your Packer files and provisions in a centralized location for Azure Pipelines to access. We recommend using Azure file shares to securely store these files. The access credentials are an example of what's stored in the key vault that's linked to the variable group.

When you use Azure file share for the Packer files, store the name and account key in the key vault that's linked to the variable group in Azure DevOps. These credentials are accessed by pipelines to download the Packer files to the VM that's used to create the image. Like the storage account name and primary key, store the unc path as a variable in the variable group.

Azure Pipelines has many different features. Our recommendations when it comes to setting up Packer are to use gateways, marketplace, and deployment services.

When working with Packer in the deployment pipeline, you must install Packer tools. The image being built can install Packer tools onto the VM configured to be in the image.

We recommend creating a validation stage in the pipeline. The validation stage allows the pipeline to validate that the build works.

After validation, you need the deployment pipeline as another stage. Clone the validation stage and set the deployment mode to **Incremental**.

For more information about Packer, see the [Packer website](https://www.packer.io/docs/builders/azure).

### Application installation in Windows Virtual Desktop images

For universal applications installed in the gold image, use the same Packer method as above to install applications.

[App-V](/windows/application-management/app-v/appv-getting-started) is currently the supported method from Microsoft for streaming applications on a per-user basis.

Use FSLogix [App Masking](/fslogix/implement-application-masking-tutorial) to hide or reveal applications or plug-ins when those applications don't work well with App-V.

Third parties also available.

### Deployment of languages in Windows Virtual Desktop images

Windows Virtual Desktop works in many languages. There are two ways we recommend doing the language packs. The first is to split them up by different host pools. The second is to have users with different language and localization requirements in the same host pool. But, those users customize their images to ensure that they can select the language they need.

Microsoft has processes for installing language packs manually or automatically. We recommended keeping as little administration overhead as possible and automating the process of language installation.

The automated process involves downloading a PowerShell script onto the VM that's being converted to an image. Example automation scripts are found in Microsoft documentation. If you're following the recommendation for Packer pipelines, you can include this process as an extra task.

For more information on installing language packs in Windows 10 Enterprise multi-session, see [Install language packs on Windows 10 VMs in Windows Virtual Desktop](/azure/virtual-desktop/language-packs).

### Integrate Windows Virtual Desktop golden image creation with DevOps

Make sure that Windows Virtual Desktop gold images are available to create host pools in the required Azure regions.

There are several options to automate the distribution of your Windows Virtual Desktop golden image to different Azure regions. These options can then be used to create your Windows Virtual Desktop host pools. The Shared Image Gallery service in Azure is the simplest option to use, and it helps to build structure and organization around your images. It provides image replication to different Azure regions to support Windows Virtual Desktop automation, and:

- Global replication of images to different Azure regions.
- Versioning and grouping of images for easier management. It's helpful if you need to roll back Windows Virtual Desktop host pools to previous image versions.
- Highly available images with zone-redundant storage (ZRS) accounts in regions that support Availability Zones. ZRS offers better resilience against zonal failures.
- Sharing Windows Virtual Desktop images across subscriptions, and even between Azure AD tenants, using role-based access control (RBAC).
- Scaling your deployments with image replicas in each region.

For more information, see [Shared Image Galleries](/azure/virtual-machines/shared-image-galleries).

### Create Windows Virtual Desktop host pools using ARM templates from images in shared image galleries

Using ARM templates allows for an infrastructure as code (IaC) approach to the deployment and customization of Windows Virtual Desktop resources. They should be used when possible to ensure consistency in deployments. ARM templates can be used to deploy Windows Virtual Desktop resources as part of a DevOps pipeline task. You can also use them when using the Azure portal, Azure PowerShell, or Azure CLI.

We recommend automating as much of the process of building an image as possible. The example above shows one method of image automation using Azure DevOps and a Packer continuous integration and continuous delivery (CI/CD) pipeline. Part of the underlying technology in the process is an ARM template.

The Shared Image Gallery is a service that helps you build structure and organization around your images. These images can be referred to in your IaC deployments of your Windows Virtual Desktop session hosts. The service allows for versioning, grouping, and replication of images.

When you deploy your session hosts with an [ARM template](https://github.com/Azure/RDS-Templates/tree/master/ARM-wvd-templates/CreateAndProvisionHostPool), we recommend using the resource ID of the image you created in your gallery as the VM custom image source ID. The image that you're using must be replicated via the Shared Image Gallery service to the Azure regions where you're deploying your Windows Virtual Desktop host pools.
