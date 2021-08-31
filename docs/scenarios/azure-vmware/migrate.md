---
title: Migrate workloads for Azure VMware Solution
description: <<Describe the scenario's impact on migration deployment.>>
author: JanetCThomas
ms.author: janet
ms.date: 08/28/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
ms.custom: e2e-avs
---

# Migrate Azure VMware Solution

Azure VMware Solution (AVS) lets you seamlessly move VMware workloads from your datacenter to Azure and integrate additional Azure services with ease — all while continuing to manage your IT environments with the same VMware tools you already know. You have the choice and flexibility to determine what workloads to migrate, and you decide the right time to migrate them. With platform symmetry, you have complete control to transform based on how your organization defines its unique cloud journey.

Migrating VMware solutions to Azure can accelerate the standard methodology outlined in the Cloud Adoption Framework, as pictured here.

![Diagram of Cloud Adoption Framework migration model.](../../_images/migrate/methodology.png)
*Figure 1*

Planning and preparing your environment for Azure VMWare Solution deployment is critical for a successful migration and creating Azure VMware Solutions (AVS). Use your documented plan as a reference during migration, and make sure you've created a landing zone to host the workloads you plan to build in or migrate to the cloud. A successful deployment results in a production-ready environment for creating or migrating Azure VMware Solutions (AVS).

## Azure VMware Solution process details

Are there data points outside of a standard Azure Migrate assessment that you need to prepare for migration.

- Identify the Azure subscription, resource group, region, and resource name
- Identify the size hosts and determine the number of clusters and hosts
- Request a host quota for eligible Azure plan
- Identify the /22 CIDR IP segment for private cloud management
- Identify a single network segment
- Define the virtual network gateway
- Define VMware HCX network segments

From a technical point of view it's important to get the core foundations right around networking and migration methodology. 

- Networking - right IP address space will ensure that you can mover workloads seamlessly between on-premis, Azure and AVS.
- Upfront planning on migration methodology, live layer, layer3
- Firewall rules: ports need to be open between on-premise and AVS before you deploy the service
- once service is deployed, make sure operating model accommodates AVS.

## Azure VMware Solution process flow

Are there Azure migrate partners that can help get the data? What about other 3rd parties?

There are three ways to deploy Azure VMWare solutions. 

- Azure portal - VMWare solutions can be deployed like any other service.
- Using the Azure landing zone
- Azure command line interface

When you deploy AVS you get SDDC, software defined data center that has vCenter Server, vSAN, vSphere, and NSX-T. As a result, you can migrate workloads from your on-premises environments, deploy new virtual machines (VMs), and consume Azure services from your private clouds. Everything you need to set up a successful migration, transformation, data center extension, is included when you deploy the Azure VMWare solution.

### Example migration process

AVS lets you seamlessly move VMware workloads from your datacenter to Azure and integrate additional Azure services with ease—all while continuing to manage your IT environments with the same VMware tools you already know. On this route, you have the choice and flexibility to determine what workloads to migrate, and you decide the right time to migrate them. With platform symmetry, you have complete control to transform based on how your organization defines its unique cloud journey.

You can take the tooling the operational best practices that you’re already using and repurpose them in Azure with the azure VMWare solution platform.

The hardware and software specifications should familiar if you are a VMWare admin. If you're deploying VMWare solutions it should match up to something that you've got on prem, or maybe it's a version ahead. 

What’s important to note is that you’ll need three nodes per vsphere cluster. That's the minimum. There's a maximum of 16 nodes per vsphere cluster, and then a maximum of 96 nodes in an Azure private cloud instance.
When you deploy AVS you get three nodes and an express route circuit. Because your VMWare is bare metal, it needs to be peered into Azure. You start by connecting the on prem ExpressRoute into Azure, plus your express route circuit that's provided to you by AVS. Then you can enable global reach. That's what handles the east-west traffic routing between the two circuits. This is how you can think about migrating your VMs from on-prem all the way into the AVS private cloud.  See the following illustration.

ADD CONCEPTUAL GRAPHIC HERE

After you deploy AVS, it will look like any other Azure service in the Azure portal. But when you’re building the service, you'll need to provide a management IP address, which is different than the virtual network you're connecting it to. The management IP address requires a minimum of /22 CIDR block. You don't have to worry about subnetting your environment, AVS will do it for you. You can also enable the Internet. This is where you can think about azure virtual LAN, and application gateway.

Once you get your environment into azure, you get a chance to be much closer to the ARM APIs, versus trying to think about that in a hybrid scenario.
On the ExpressRoute circuit you request your private keys, but some of the configuration is done for you. You’ll also need to configure the HCX environment. That's the piece that does the migrations from on-prem into azure. Then configure your public IP and the ExpressRoute global reach.

The vCenter credentials and the NXS-T Manager credentials are set up for you. AVS also handles cycling your passwords so you don’t have to.   You can add segments to the NSX-T, and setup a DHCP if you need it.

You can think about Azure VMWare Solutions as a VMWare service. It's kind of in between IaaS and PaaS. It’s not one over the other. You can configure a Jump host within the environment to access AVS. The jump host is behind an Azure Bastion. The Azure Bastion host is a way to provide secure access into that VM without having to expose the RDP port or the SSH port.  This way you can access your VM if there’s ever an issue with ExpressRoute circuit coming from on prem into Azure.

When you go into your environment, it should look just like it did when it was running on prem.  You can also integrate with Azure and build on it from here. For example, you could build content libraries so when you templatize your VMs, you can spin them up quickly. And when you develop templates, you can store those templates on Azure Blob Storage as well.

You also have the ability to use the web interface, VMWare's PowerShell components or CLI.

Azure VMWare Solutions allows you to work in a familiar environment, with familiar tools, and allows you to iterate, innovate, and modernize at your own pace as you work through your digital transformation.

To get more experience migrating VMWare with Azure VMWare Solutions, try one of these [hands on labs](https://web.hol.vmware.com/landingPages/index.aspx?id=PN5RRQA9).

- Azure VMware Solution Private Cloud Deployment and Connectivity: A guided click through for VMWare administrators, on how to set up the cloud deployment and connectivity.
- Azure VMware Solution Workload Migration with VMware HCX: This lab deals with the migration components. It walks through how to create the environment, deploy the environment, and migrate VMs.

Additional resources:
- [Azure VMware Solution documentation](/azure/azure-vmware/)
- Learn module: [Run VMware workloads on Azure VMware Solution](/learn/paths/run-vmware-workloads-azure-vmware-solution/)

## Azure VMware Solution workload specific activities

Are there specific criteria for workloads in that portfolio that would require the customer to run a well-architected review for any workloads?

## Next step: Release Azure VMware Solution

The following list of articles will take you to guidance found at specific points throughout the cloud adoption journey to help you be successful in the cloud adoption scenario.

- [Govern Azure VMware Solution](./govern.md)
- [Manage Azure VMware Solution](./manage.md)
