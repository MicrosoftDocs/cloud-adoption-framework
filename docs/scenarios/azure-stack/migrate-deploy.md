---
title: Deploy workloads to Azure Stack Hub
description: Learn to deploy workloads in your datacenter using Azure Stack Hub.
author: BrianBlanchard
ms.author: brblanch
ms.date: 05/19/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
ms.custom: internal
---

# Deploy workloads to Azure Stack Hub

By using Azure Stack, your organization can run its own instance of Azure in its datacenter. Organizations include Azure Stack in their cloud strategy because it helps them handle situations when the public cloud won't work for them. The three most common reasons to use Azure Stack are:

- Poor network connectivity to the public cloud.
- Regulatory or contractual requirements.
- Back-end systems that can't be exposed to the internet.

## Infrastructure as a service deployment

Regardless of the reason to deploy infrastructure as a service (IaaS), deployment to Azure Stack Hub is similar to any other IaaS deployment. People often think of IaaS only as virtual machines (VMs), but IaaS is more than that. When you deploy a VM in Azure or Azure Stack, the machine comes with a software-defined network, including Domain Name System, public IPs, firewall rules (also called network security groups), and many other capabilities. The VM deployment also creates disks for your VMs on software-defined storage by using Azure Blob Storage.

For deeper guidance on deploying VMs to Azure Stack, see the [Azure Stack compute overview](/azure-stack/user/azure-stack-compute-overview).

## Platform as a service deployment

In the cloud, all platform as a service (PaaS) resources run on some form of infrastructure service, such as a VM. However, Azure services obfuscate those backend resources so you don't have to manage them. The obfuscation and coordination of those infrastructure resources is managed by Azure Resource Manager. You may have seen one aspect of Resource Manager when deploying to Azure using an Azure Resource Manager template. Those templates tell Azure which resource provider you want to invoke and how you want your resources to be configured.

When the cloud runs in your datacenter, your stack hub administrators will need to be somewhat familiar with the layers of obfuscation. Before your users or developers can use a PaaS resource, the Azure Stack Hub administrator will need to install the resource provider from the marketplace. Those resource providers allow your instance of Azure Stack Hub to replicate the resource provider functionality of Azure in your stack instance. For more information on deploying Azure Stack Hub resource providers, see the [Azure Stack IaaS blog series](https://azure.microsoft.com/blog/azure-stack-iaas-part-one/).

## Deploy workloads

After the Azure Stack Hub administrator has properly configured your stack instance, migrations can continue as they would with most other Azure migration efforts. By using Azure Stack, your team can run any of the following types of migration:

- [Ethereum blockchain network](/azure-stack/user/azure-stack-ethereum)
- [AKS engine](/azure-stack/user/azure-stack-kubernetes-aks-engine-overview)
- [Azure Cognitive Services](/azure-stack/user/azure-stack-solution-template-cognitive-services)
- [C# ASP.NET web app](/azure-stack/user/azure-stack-dev-start-howto-vm-dotnet)
- [Linux VM](/azure-stack/user/azure-stack-dev-start-howto-deploy-linux)
- [Java web app](/azure-stack/user/azure-stack-dev-start-howto-vm-java)

## Additional considerations during migration

The following resources can help your team during migration and modernization:

- [Scalability and availability](https://azure.microsoft.com/blog/azure-stack-iaas-part-six/) services such as pay per use, availability sets, virtual machine scale sets, network adapters, and the ability to add and resize VMs and disks.
- [Storage capacity](https://azure.microsoft.com/blog/azure-stack-iaas-part-3/), including the ability to upload and download and also capture and deploy VM images.
- The [Azure Stack quickstart templates](https://github.com/Azure/AzureStack-QuickStart-Templates) GitHub repository.
- The [Azure quickstart templates](https://github.com/Azure/Azure-QuickStart-Templates) GitHub repository.

## Next steps

For guidance on specific elements of the cloud adoption journey, see:

- [Govern Azure Stack Hub](./govern.md)
- [Manage Azure Stack Hub](./manage.md)
