---
title: "Moving on-premises VMware infrastructure to Azure (scenario) "
description: Learn how Contoso moves on-premises VMware VMs to Azure
author: deltadan
ms.author: abuck
ms.date: 06/11/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
services: azure-migrate
---

<!-- cSpell:ignore -->

# Moving on-premises VMware infrastructure to Azure (scenario)

Contoso has several options available when migrating VMware virtual machines (VMs) from an on-premises datacenter to Azure.

| Migration options | Outcome |
| --- | --- |
| [Azure Migrate](https://azure.microsoft.com//services/azure-migrate/) | [Assess](https://docs.microsoft.com//azure/migrate/tutorial-assess-vmware) and [migrate](https://docs.microsoft.com//azure/migrate/tutorial-migrate-vmware) on-premises VMs. <br><br> Run workloads using Azure IaaS. <br><br> Manage VMs with [Azure Resource Manager](https://azure.microsoft.com//features/resource-manager/). |
| [Azure VMware Solution](https://azure.microsoft.com/overview/azure-vmware) | Use VMware hcx or vmotion to move on-premises VMs. <br><br> Run native VMware workloads on Azure bare metal hardware. <br><br> Manage VMs using vsphere. |

Azure VMware Solution is used to create a private cloud in Azure with native access to VMware vCenter, and other tools supported by VMware for workload migration. Contoso can then confidently use Azure VMware Solution, knowing that they're first-party Microsoft offerings backed by VMware.

> [!NOTE]
> This article focuses on using Azure VMware Solution (avs), to move on-premises VMware environment VMs to Azure.

## Business drivers

Working closely with business partners, the Contoso IT team will define the business drivers for a VMware migration to Azure. These drivers may include:

- Datacenter evacuation or shutdown. Seamlessly move VMware-based workloads when they consolidate or retire existing datacenters.
- Disaster recovery and business continuity. Use a VMware stack deployed in Azure as a primary or secondary on-demand disaster recovery site for on-premises datacenter infrastructure.
- Application modernization. Tap into the Azure ecosystem to modernize Contoso's applications without having to rebuild VMware-based environments.
- Implementing DevOps. Bring Azure DevOps tool chains to VMware environments and modernize applications at their own pace.
- Ensure operational continuity. Redeploy vsphere-based applications to Azure while avoiding hypervisor conversions and application refactoring. Extend support for legacy applications running Windows and SQL Server.

## VMware on-premises to VMware in the cloud goals

With the business drivers in mind, Contoso has pinned down goals for this migration:

- Continue managing their existing environments with VMware tools familiar to their teams, while modernizing the applications with native Azure services.
- Seamlessly move Contoso's VMware-based workloads from their datacenter to Azure and integrate the VMware environment with Azure.
- After migration, the app in Azure should have the same performance capabilities as it does today in VMware. The app will remain as critical in the cloud as it is on-premises.

These goals support the decision to use avs and validate it as the best migration method for Contoso.

## Benefits of running VMware workloads in Azure

Using Azure VMware Solution (avs), Contoso can now seamlessly run, manage, and secure applications across VMware environments and Microsoft Azure with a common operating framework.

Contoso will capitalize on existing VMware investments, skills, and tools, including VMware vsphere, vsan, and vCenter, while using the scale, performance, and innovation of Azure. Additional benefits may include:

- Provision VMware infrastructure in the cloud in minutes and modernize applications at their own pace.
- Enhance VMware applications with dedicated, isolated, high-performance infrastructure and unique Azure products and services.
- Move or extend on-premises VMs to Azure without refactoring applications.
- Get scale, automation, and fast provisioning for VMware workloads on global Azure infrastructure.
- Azure VMware Solution are delivered by Microsoft, verified by VMware, and run on Azure infrastructure.

## Solutions design

After pinning down goals and requirements, Contoso designs and reviews a deployment solution, and identifies the migration process.

### Current architecture

- VMs deployed to an on-premises datacenter managed by [vsphere](https://www.vmware.com/products/vsphere.html).
- Workloads deployed on a VMware ESXi host cluster managed with [vCenter](https://www.vmware.com/products/vcenter-server.html), [vsan](https://www.vmware.com/products/vsan.html) and [nsx](https://www.vmware.com/products/nsx.html).

### Proposed architecture

- Deploy [avs private cloud](https://docs.microsoft.com/azure/azure-vmware/concepts-private-clouds-clusters) into the West US Azure region.
- Connect the on-premises datacenter to avs running in West US using virtual networks and [ExpressRoute](https://docs.microsoft.com/azure/azure-vmware/concepts-networking) with global reach enabled.
- Migrate VMs to dedicated Azure VMware Solution using [VMware hybrid cloud extension (hcx)](https://docs.vmware.com/en/VMware-HCX/services/user-guide/GUID-D0CD0CC6-3802-42C9-9718-6DA5FEC246C6.html).

![Proposed Architecture](./media/contoso-migration-vmware-to-azure/on-premises-stretched-network-expressroute.png)

## Solution review

Contoso evaluates the proposed design by putting together a pros and cons list.

| Consideration | Details |
| --- | --- |
| **Pros** | Bare metal VMware infrastructure with high performance. Infrastructure that is fully dedicated to Contoso and is physically isolated from infrastructure of other customers. <br><br> Since Contoso is using a rehost using VMware there is, no special configuration or migration complexity. <br><br> Contoso can take advantage of their investment in Software Assurance, using the [Azure Hybrid Benefit](https://azure.microsoft.com/pricing/hybrid-benefit/) and [extended security updates](https://www.microsoft.com/cloud-platform/windows-server-2008) for legacy Windows and SQL platforms. <br><br> Contoso will retain full control of the app VMs in Azure. <br><br> |
| **Cons** | Contoso will need to continue supporting the app as VMware VMs rather than moving them to a managed service such as Azure App Service and Azure SQL Database. <br><br> Azure VMware Solution are provisioned and priced based on a minimum of three large nodes rather than individual VMs in Azure IaaS. They will need to plan their capacity needs as they don on-premises today rather than benefits from the on-demand nature of other services in Azure. |

> [!NOTE]
> Learn more about the [pricing](https://azure.microsoft.com/pricing/details/azure-vmware/) of Azure VMware Solution.

## Migration process

Contoso will move VMs to avs using the VMware hcx tool. The VMs will run in an avs private cloud.  [VMware hcx migration types](https://docs.vmware.com/en/VMware-HCX/services/user-guide/GUID-8A31731C-AA28-4714-9C23-D9E924DBB666.html) include bulk migration, cold migration, and even while a workload is running through live migration using vmotion or replication assisted vmotion (rav).

- Contoso plans their networking in Azure and ExpressRoute.
- Contoso creates the avs private cloud using the Azure portal.
- The network is then configured including the ExpressRoute circuits.
- Contoso next configures the hcx components to connects their on-premises vsphere environment to the avs private cloud.
- The VMs are then replicated and moved to Azure using VMware hcx.

 ![Migration process](./media/contoso-migration-vmware-to-azure/on-premises-vmware-hcx-azure.png)

## Scenarios steps

1. Network planning
1. Create an avs private cloud
1. Configure networking
1. Migrate VMs using hcx

### Step 1: Network planning

Contoso needs to plan out their networking including Azure Virtual Network and connectivity between on-premises and Azure. Contoso needs to provide a high speed connection between the on-premises and the Azure-based environments along with connection to avs private cloud.

This connectivity is delivered through Azure ExpressRoute and will require some specific network address ranges and firewall ports for enabling the services. This high bandwidth, low latency connection allows Contoso's users to access services running in their Azure subscription from the avs private cloud environment.

Contoso will need to plan a IP addresses scheme which includes non-overlapping address space for their [virtual networks](https://docs.microsoft.com/azure/virtual-network/virtual-network-vnet-plan-design-arm). They will need to include a gatewaysubnet for the [ExpressRoute gateway](https://docs.microsoft.com/azure/expressroute/expressroute-about-virtual-network-gateways).

The avs private cloud is connected to Contoso's Azure Virtual Network using another Azure ExpressRoute connection. ExpressRoute Global Reach will be enabled to allow [direct connection](https://docs.microsoft.com/azure/azure-vmware/concepts-networking#on-premises-interconnectivity) from on-premises to VMs running on the avs private cloud. The ExpressRoute Premium SKU is required to enable global reach.

![ExpressRoute Global Reach with AVS](./media/contoso-migration-vmware-to-azure/adjacency-overview-drawing-double.png)

Avs private clouds require a minimum of a /22 CIDR network address block for subnets. In order to connect to on-premises environments and virtual networks, this must be a non-overlapping network address block.

>[!NOTE]
> Learn about network planning for avs using a [tutorial](https://docs.microsoft.com/azure/azure-vmware/tutorial-network-checklist/).

### Step 2: Create an avs private cloud

With their network and IP address planning completed, Contoso will next focus on provisioning the avs service in the West US Azure region. Avs gives Contoso the ability to deploy a vsphere cluster in Azure.

An avs private cloud is an isolated VMware software-defined datacenter that supports ESXi hosts, vCenter, vsan, and nsx. The stack runs on dedicated and isolated bare metal hardware nodes in an Azure region. The minimum initial deployment for an avs private cloud is three hosts. Additional hosts can be added one at a time, up to a maximum of 16 hosts per cluster.

>[!NOTE]
> Learn more about avs [private cloud concepts](https://docs.microsoft.com/azure/azure-vmware/concepts-private-clouds-clusters).

Avs private clouds are managed through the avs portal. They have their own vCenter server in its own management domain.

>[!NOTE]
> Learn to create avs private clouds using a [tutorial](https://docs.microsoft.com/azure/azure-vmware/tutorial-create-private-cloud).

- Contoso first registers the avs provider with Azure using the following command.

```azurecli-interactive
az provider register -n Microsoft.AVS --subscription <your subscription ID>
```

- Using the Azure portal, Contoso creates the avs private cloud providing the networking information from their plan.

![Create AVS private cloud](./media/contoso-migration-vmware-to-azure/create-private-cloud.png)

> [!NOTE]
> This step takes roughly two hours.

- Contoso verifies the avs private cloud deployment has completed by navigating to the resource group and selecting the private cloud resource. When the deployment is completed the status of shows as **Succeeded**.

![Validate private cloud deployment](./media/contoso-migration-vmware-to-azure/validate-deployment.png)

### Step 3: Configure networking

An Azure VMware Solution (avs) private cloud requires a virtual network. Because avs won't support your on-premises vCenter during preview, additional steps for integration with your on-premises environment are needed. Setting up an ExpressRoute circuit and a virtual network gateway will connect their virtual networks to the avs private cloud.

>[!NOTE]
> Learn about configuring networking for avs using a [tutorial](https://docs.microsoft.com/azure/azure-vmware/tutorial-configure-networking).

- Contoso first creates a virtual network with an gatewaysubnet.

> [!IMPORTANT]
> Contoso must use an address space that **does not** overlap with the address space used when they created the private cloud.

- Next, they create the ExpressRoute VPN gateway making sure to select the correct SKU.

![ExpressRoute VPN Gateway](./media/contoso-migration-vmware-to-azure/create-virtual-network-gateway.png)

- They need the authorization key to connect ExpressRoute to the virtual network. This is found on the connectivity screen of the avs private cloud resource in the Azure portal.

![ER Auth Key](./media/contoso-migration-vmware-to-azure/request-auth-key.png)

- Finally, they connect the ExpressRoute to the VPN gateway connecting the avs private cloud to their virtual network. This is accomplished by creating an connection in Azure.

![Connect ER to Vnet](./media/contoso-migration-vmware-to-azure/add-connection.png)

>[!NOTE]
> Learn how to access the private cloud and connect to vsphere using this [tutorial](https://docs.microsoft.com/azure/azure-vmware/tutorial-access-private-cloud).

### Step 4: Migrate using VMware hcx

To move VMware VMs to Azure using hcx, Contoso will need to follow these high-level steps:

- Install and configure VMware hcx
- Perform migrations to Azure using hcx

>[!NOTE]
> Learn how to install hcx for avs using this [tutorial](https://docs.microsoft.com/azure/azure-vmware/hybrid-cloud-extension-installation).

#### Install and configure VMware hcx for public cloud

[VMware hcx](https://cloud.vmware.com/vmware-hcx) is a VMware product part of the Azure VMware Solution default installation. By default hcx advanced is installed but can be upgraded to hcx enterprise for more features as an additional feature. Avs automates the "cloud manager" component of hcx in avs and provides the customer activation keys and download link to the "connector" hcx appliance required to be configured on the on-premises side and in the customers vCenter domain. These will then be paired with the avs cloud appliance and customers can start to enjoy services like migration and l2 stretch if so desired.

- Contoso is deploying the hcx using an OVA provided by VMware.

![HCX OVA](./media/contoso-migration-vmware-to-azure/configure-template.png)

Please refer to this guide for configuring hcx for your avs private cloud.

>[!NOTE]
> Learn how to install hcx for avs using this [tutorial](https://docs.microsoft.com/azure/azure-vmware/hybrid-cloud-extension-installation).

- During the configuration of hcx, Contoso has selected to enable migration among other options including disaster recovery.

![HCX Configure](./media/contoso-migration-vmware-to-azure/hcx-manager.png)

> Note: learn more about [hcx installation workflow for hcx public clouds](https://docs.vmware.com/en/VMware-HCX/services/user-guide/GUID-FDE5473E-6B71-4A71-85B6-8C9BA2B73686.html).

#### Perform migrations to Azure using hcx

When both the on-premises datacenter (source), and avs private cloud (destination) configured with VMware cloud and hcx, Contoso can begin migrating VMs. Virtual machines can be moved to and from VMware hcx-enabled datacenters using multiple migration technologies.

- Contoso's hcx application is online and the status is green. They're now ready to migrate and protect avs VMs using hcx

![HCX status](./media/contoso-migration-vmware-to-azure/appliance-status.png)

#### VMware hcx bulk migration

This migration method uses the VMware vsphere replication protocols to move the virtual machines to a destination site.

- The bulk migration option is designed for moving virtual machines in parallel.
- This migration type can set to complete on a predefined schedule.
- The virtual machine runs at the source site until the failover begins. The service interruption with the bulk migration is equivalent to a reboot.

#### VMware hcx live vmotion

This method uses the VMware vmotion protocol to move a virtual machine to a remote site.

- The vmotion option is designed for moving a single virtual machine at a time.
- Virtual machine state is moved. There is no service interruption during the VMware hcx vmotion.

#### VMware hcx cold migration

This migration method uses the VMware nfc protocol. It is automatically selected when the source virtual machine is powered off.

#### VMware hcx replication assisted vmotion

VMware hcx replication assisted vmotion (rav) combines advantages from VMware hcx bulk migration (parallel operations, resiliency, and scheduling) with VMware hcx vmotion (zero downtime virtual machine state migration).

> [!IMPORTANT]
> See [VMware hcx documentation](https://docs.vmware.com/en/VMware-HCX/index.html) and [migrating virtual machines with VMware hcx](https://docs.vmware.com/en/VMware-HCX/services/user-guide/GUID-D0CD0CC6-3802-42C9-9718-6DA5FEC246C6.html?hWord=N4IghgNiBcIBIGEAaACAtgSwOYCcwBcMB7AOxAF8g) in the VMware technical documentation.
