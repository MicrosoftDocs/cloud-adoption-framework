---
title: "Azure in your datacenter - Azure Stack Hub"
description: Deploy Azure in your data center - Azure Stack Hub
author: BrianBlanchard
ms.author: brblanch
ms.date: 05/19/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
---

# Deploying workloads to Azure Stack Hub

Azure Stack allows customers to run their own instance of Azure in their datacenter. Organizations pick Azure Stack as part of their cloud strategy because it helps them handle situations when the public cloud won't work for them. The three most common reasons use Azure Stack are because of poor network connectivity to the public cloud, regulatory or contractual requirements, or backend systems that cannot be exposed to the internet.

## Infrastructure as a service (IaaS) deployment

Regardless of the reason for deployment, deployment to Azure Stack Hub is similar to any other IaaS deployment. People often think of IaaS as simply virtual machines, but IaaS is more. When you deploy a VM in Azure or Azure Stack, the machine comes with a software defined network including DNS, public IPs, firewall rules (also called network security groups), and many other capabilities. The VM deployment also creates disks for your VMs on software defined storage using Azure Blob storage.

For deeper guidance on deploying VMs to Azure Stack, see the [Azure Stack compute overview](https://docs.microsoft.com/azure-stack/user/azure-stack-compute-overview?view=azs-2002).

## Platform as a service (PaaS) deployment

In the cloud, all PaaS resources run on some form of infrastructure service, such as a virtual machine (VM). However, Azure services obfuscate those backend resources so you don't have to manage them. The obfuscation and coordination of those infrastructure resources is managed by Azure Resource Manager. You may have seen one aspect of Resource Manager when deploying to Azure using an Azure Resource Manager template. Those templates tell Azure which resource provider you want to invoke and how you want your resources to be configured.

When the cloud runs in your datacenter, your stack hub administrators will need to be a little bit familiar with the layers of obfuscation. Before your users or developers can use a PaaS resource, the Azure Stack Hub administrator will need to install the resource provider from the marketplace. Those resource providers allow your instance of Azure Stack Hub to replicate the resource provider functionality of Azure in your stack instance. For more information on deploying Azure Stack Hub resource providers, see the [Azure Stack IaaS blog series](https://azure.microsoft.com/blog/azure-stack-iaas-part-one/).

## Deploy workloads

Once the Azure Stack Hub administrator has properly configured your stack instance, migrations can continue as they would with most other Azure migration efforts. Below are links to a few specific types of migrations that customers commonly execute on Azure Stack:

- [Ethereum blockchain network](https://docs.microsoft.com/azure-stack/user/azure-stack-ethereum?view=azs-2002)
- [AKS engine](https://docs.microsoft.com/azure-stack/user/azure-stack-kubernetes-aks-engine-overview?view=azs-2002)
- [Azure Cognitive Services](https://docs.microsoft.com/azure-stack/user/azure-stack-solution-template-cognitive-services?view=azs-2002)
- [C# ASP.NET web app](https://docs.microsoft.com/azure-stack/user/azure-stack-dev-start-howto-vm-dotnet?view=azs-2002)
- [Linux VM](https://docs.microsoft.com/azure-stack/user/azure-stack-dev-start-howto-deploy-linux?view=azs-2002)
- [Java web app](https://docs.microsoft.com/azure-stack/user/azure-stack-dev-start-howto-vm-java?view=azs-2002)

## Additional considerations during migration

The following articles can help your team during migration and modernization:

- [Scalability and availability](https://azure.microsoft.com/blog/azure-stack-iaas-part-six/) services such as pay per use, VM availability sets, virtual machine scale sets, network adapters, and the ability to add and resize VMs and disks.
- [Storage capacity](https://azure.microsoft.com/blog/azure-stack-iaas-part-3/), including the ability upload and download and also capture and deploy VM images.
- [Azure Stack quickstart templates](https://github.com/Azure/AzureStack-QuickStart-Templates) GitHub repository.
- [Azure quickstart templates](https://github.com/Azure/Azure-QuickStart-Templates) GitHub repository.

## Next step: Integrate this strategy into your cloud adoption journey

The following list of articles will take you to guidance found at specific points throughout the cloud adoption journey.

- [Govern Azure Stack Hub](./govern.md)
- [Manage Azure Stack Hub](./manage.md)
