---
title: "Enterprise-Scale platform automation and devops for Windows Virtual Desktop"
description: Describe how this enterprise-scale scenario can improve platform automation and devops of <Insert Scenario Name>
author: BrianBlanchard
ms.author: brblanch
ms.date: 09/11/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Platform Automation and DevOps for Windows Virtual Desktop (WVD) Enterprise-Scale Scenario

Windows Virtual Desktop (WVD) is a managed service providing a Microsoft control plane for your desktop virtualization environment.

This article on automation will concentrate on the operational tasks needed to run a WVD environment rather than initial setup or scaling tasks. It should be remembered that each recommendation can be applied individually and not all recommendations need to be implemented for automation to become worthwhile.

## Design considerations

### Pooled vs Personal

As organizations scale out their environment it is usual that most of the workload falls under a ‘pooled’ paradigm rather than a ‘personal’ configuration. While personal is certainly correct for specific workloads, developers being a good example, as they usually need elevated permissions, it will usually be more expensive to run than a pooled configuration.

If you do run host pools in personal mode, you should try to maintain these machines in the same way you maintain your physical desktops. This will reduce the amount of tooling present in your environment.
As pooled is both the most popular configuration and the one which is specific to Desktop Virtualization, we shall concentrate on the pooled configuration type in this article.

Pooled environments should be updated differently than you would do a traditional environment. The VMs should be updated from a gold image at the correct cadence for your organization. That cadence is usually 1-3 months. In highly automated organizations, it's possible to increase that cadence to weekly or even nightly if needed.

### Image Creation

When scaling up your WVD environment, your host pools will generally be created from a gold image. The creation of that image should be via automation. You can alternatively instigate a process where checklists are used, but in large environments, this should only be part of the initial dev/test setup. The more you automate your gold image creation, the more secure you will be in the accuracy of your build and how stable your environment will be.
It is possible to take the 'old' image then use it to create a VM (Virtual Machine), update that VM with the applications and configuration changes for that update and then capture that to your 'new' image. This is not a recommended process for creating gold images as over time it will become risky to maintain and is the major cause of desktop virtualization environments becoming static and fragile. Additionally, Windows is limited to running Sysprep 8 times which will limit how many times you can create a Gold Image (Sysprep (Generalize) a Windows installation | Microsoft Docs).

Many automation tools exist to create gold images and you should use the tool-set that is most appropriate for your organization, whether that is due to the existing skill-set and process or cost considerations.
As you are looking at automation for your WVD environment, ideally you should try and get to 100% of your gold image build process automated but if you can get to at least 80% of the creation of your gold image automated this is still a good investment of your time. It will make it much easier in future to maintain your WVD environment in the best possible health.

### Application installation

Applications can be made available to your users in two basic ways, installed in the image or delivered dynamically per user.

In a large-scale environment, it becomes impractical to install all applications into the image. You may have apps which need to have restricted access, or incompatible apps/versions. At this point you need to split your apps into the two aforementioned groups.

Applications installed in the image should be universal to your users, typical example include security products and the Office 365 suite. These should be a part of your image creation automation.
Applications dynamically delivered per user should be everything else.
Flexibility is needed here as a slavish adherence to these rules can force you to spend too much time trying to fit a round application into a square group.

### Languages Deployment

As WVD environments start to scale out, it is often a requirement that images be localized into the native language for the user. You must consider at this point the basis for your image. The pre optimized Windows 10 gallery image both with and without O365 is only supplied in United States English (en-US). You can either start your image automation from a native language or you can adapt the existing en-US gallery image. Languages should be installed before you install other applications. If you are using Windows 10 multi session, it is not available to start from a native language. You must adapt the provided gallery image.

### Integrate Image Creation with DevOps

Automation does not have to mean integration with DevOps, but there are many advantages to doing so and it's worth spending the extra time here once you have automated the build process for your golden image. A DevOps pipeline will give you better management of your whole automation flow and give you reporting and alerting on your pipeline. You can integrate with testing frameworks and create approval gates for stages in your automation. You can also start pipelines from many events, which could be the release of a new gallery image or application, or just on a schedule.
Windows Virtual Desktop gold images should be available to create host pools in the required Azure Regions.
In WVD you have much more freedom on the geographic placement of your host pools than you would do in a traditional desktop environment as all Azure locations support WVD. You should enable your organization to take advantage of this freedom and adjust the placement of the VMs to the most performant location.

To do this, it's sensible to make your gold image available in the required locations, so you do not have to create VMs from an image across the WAN (Wide Area Network).

Updating or rollback of the VMs in a host pool to a different version.
There are two approaches to updating the image that VMs in a host pool are based upon when using a gold image. The first is to deploy a second host pool and then cut the users over to the new host pool when ready. The old host pool is then available if roll back is needed. The old host pool can then be removed after the organization is satisfied that the new host pool is working correctly.

The second is to set the VMs to drain mode in the host pool and deploy more VMs from the new image into the same host pool. While this is possible, care should be taken not to hit resource constraints/API throttling limits when doubling the number of VMs inside a single host pool.

### Host Pool creation

Whether you decide to update VMs in place or create a side-by–side environment for updating your host pools, automating the creation process for your host pool will give you consistent and reliable results. Even in an environment where the host pools are very static you may want to move your host pool metadata to a new geographical location as new locations are made available over time.

## Design recommendations

The following are best practices for your design:

### Creation of Windows Virtual Desktop Images

Packer should be used to create the image. By using a Packer Pipeline for image management, automation of image creation is possible. Azure DevOps licensing is required to utilize the full suite of tools. There are other prerequisites required as well. Azure AD Global Admin. A Service Principal with Contributor access to the subscription. An Azure Key Vault to store secrets in, giving the Service Principal ‘secret management’ in the access policy.

The Azure DevOps Project should be Private unless your company policy specifies repositories must be Public. Git is the recommended approach for version control. You should amend the project permissions to allow other team members access to the project. A basic work item process should be adopted to develop the pipeline and keep workloads streamlined.

When using Azure Repositories, the repo should be initialized with a README file. This will allow you to start filling information into the repository about this project. A recommended structure for the repository is to have two folders in the root of the repository. One called ‘ARM Templates’ to store the ARM Templates and one for the build you are planning e.g. ‘Windows 2004 - EVD’
When working in Azure DevOps you should utilize variable groups in your pipelines. This will allow you to have repeatable parameters in your pipelines such as secrets and names to use. There will be two variable groups. One which stores standard variables and another which is linked to Azure Key Vault to be pull across secrets to use in the pipeline.

Your packer files and provisions should be stored in a centralized location for Azure Pipelines to access. Microsoft recommend using Azure File Shares to store these files in a secure manner. The access credentials are also an example of what will be stored in the key vault that is linked to the Variable Group.
When using the Azure File Share for the packer files, the name and account key should be stored in the Key Vault that is linked to the Variable Group in Azure DevOps. This will be accessed by Pipelines to download the Packer files to the VM that is used to create the image. As well as the storage account name and Primary key, the UNC Path should also be stored as a variable in the Variable Group.

Azure DevOps Pipelines has a multitude of different features that can be used. The recommendations that we suggest when it comes to setting up Packer are the use of Gateways, Marketplace, and deployment services.
When working with Packer in the deployment pipeline, the installation of Packer Tools is required. This will allow the image we are building to install the Packer Tools onto the VM to be configured to be in the image.
Microsoft recommends creating a Validation stage in the pipeline. The validation stage of the deployment allows the pipeline to validate that the build will work in a successful manner.

The deployment pipeline is required afterwards as another stage. This can be achieved by cloning the Validation stage and set the Deployment Mode to Incremental.

More information about Packer can be found on the [Packer website](https://www.packer.io/docs/builders/azure).

### Application installation in WVD Images

For universal applications installed in the gold image the same method as above using Packer should be used as above to install applications.
[App-V](https://docs.microsoft.com/windows/application-management/app-v/appv-getting-started) is the currently supported method from Microsoft for streaming apps on a per-user basis.

FSLogix [App Masking](https://docs.microsoft.com/fslogix/implement-application-masking-tutorial) can also be used to hide or reveal applications or plug-ins where those applications do not play well with App-V.

Third parties also available.

### Deployment of Languages in WVD Images

WVD can work in a variety of languages. There are two main ways Microsoft recommend doing the language packs. The first way is to split them up by different host pools. The second way is to have users with different language and localization requirements in the same host pool but customize their images to ensure they can select whichever language they need.
Microsoft have processes of installing language packs manually and in an automated manner. It is recommended to keep as little administration overhead as possible, therefore it is recommended to automate the process of language installation.
The automated process involves downloading a PowerShell script onto the virtual machine that’s being converted to an image. Example automation scripts are found in Microsoft documentation. If following the recommendation of Packer pipelines, this can be included as an additional task.

See [Install language packs on Windows 10 VMs in Windows Virtual Desktop - Azure](https://docs.microsoft.com/azure/virtual-desktop/language-packs) | Microsoft Docs for more details on installing language packs in Windows 10 Multi-session.

### Integrate WVD Golden Image Creation with DevOps

Windows Virtual Desktop gold images should be available to create host pools in the required Azure Regions.

There are several options available to automate the distribution of your WVD golden image to different Azure regions which then can be used to create your WVD host pools. However, the Shared Image Gallery service in Azure is the simplest option to use and it helps to build structure and organization around your images. Beyond image replication to different Azure regions to support WVD automation, it will also provide:

* Global replication of images to different Azure Regions.
* Versioning and grouping of images for easier management. This is helpful should you need to roll back WVD host pools to previous image versions
* Highly available images with Zone Redundant Storage (ZRS) accounts in regions that support Availability Zones. ZRS offers better resilience against zonal failures.
* Sharing WVD Images across subscriptions, and even between Active Directory (AD) tenants, using RBAC.
* Scaling your deployments with image replicas in each region.
See [Shared Image Galleries](https://docs.microsoft.com/azure/virtual-machines/shared-image-galleries) for more details.

### Create WVD host pools using ARM Templates from Images in Shared Image Galleries

Using ARM templates allows for an infrastructure as code approach to the deployment and customization of WVD resources and should be used when possible to ensure consistency in deployments. ARM templates can be used to deploy WVD resources as either part of a DevOps pipeline task, or by a user utilizing the Azure Portal, Azure PowerShell or CLI.
Where possible, Microsoft recommend automating as much of the process of building an image as possible. The example above in this doc shows one of the methods of image automation utilizing Azure DevOps and a Packer CI/CD pipeline. Part of the underlying technology in the process is an ARM Template.
The shared image gallery is a service that helps you build structure and organization around your images. These images can be referred to in your Infrastructure-as-Code deployments of your WVD session hosts. The service allows for versioning, grouping and replication of images.

When using the [ARM Template](https://github.com/Azure/RDS-Templates/tree/master/ARM-wvd-templates/CreateAndProvisionHostPool) to deploy your session hosts, Microsoft recommends utilizing the resource ID of the image you created in your shared image gallery as the VM Custom Image Source Id. The image that you are using needs to be replicated utilizing the shared image gallery to the Azure regions where you are deploying your WVD host pools.
