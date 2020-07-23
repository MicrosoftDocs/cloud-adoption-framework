---
title: Move on-premises VMware infrastructure to Azure
description: Learn how fictional company Contoso moves on-premises VMware VMs to Azure.
author: deltadan
ms.author: abuck
ms.date: 07/01/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
services: azure-migrate
---

<!-- docsTest:ignore "Bulk Migration" "Cold Migration" -->

# Move on-premises VMware infrastructure to Azure

When fictional company Contoso migrates their VMware virtual machines (VMs) from an on-premises datacenter to Azure, two options are available to them. This article focuses on Azure VMware Solution (AVS), which Contoso has determined to be the better migration option.

| Migration options | Outcome |
| --- | --- |
| [Azure Migrate](https://azure.microsoft.com/services/azure-migrate/) | <li>[Assess](https://docs.microsoft.com/azure/migrate/tutorial-assess-vmware) and [migrate](https://docs.microsoft.com/azure/migrate/tutorial-migrate-vmware) on-premises VMs. <li>Run workloads using Azure infrastructure as a service (IaaS). <li>Manage VMs with [Azure Resource Manager](https://azure.microsoft.com/features/resource-manager/). |
| [Azure VMware Solution](https://azure.microsoft.com/overview/azure-vmware) | <li>Use VMware  Hybrid Cloud Extension (HCX) or vMotion to move on-premises VMs. <li>Run native VMware workloads on Azure bare-metal hardware. <li>Manage VMs using vSphere. |

In this article, Contoso uses Azure VMware Solution to create a private cloud in Azure with native access to VMware vCenter and other tools that are supported by VMware for workload migration. Contoso can confidently use Azure VMware Solution, knowing that it's a first-party Microsoft offering backed by VMware.

## Business drivers

Working closely with business partners, the Contoso IT team defines the business drivers for a VMware migration to Azure. These drivers can include:

- **Datacenter evacuation or shutdown**: Seamlessly move VMware-based workloads when they consolidate or retire existing datacenters.
- **Disaster recovery and business continuity**: Use a VMware stack deployed in Azure as a primary or secondary on-demand disaster recovery site for on-premises datacenter infrastructure.
- **Application modernization**: Tap into the Azure ecosystem to modernize Contoso applications without having to rebuild VMware-based environments.
- **Implementing DevOps**: Bring Azure DevOps tool chains to VMware environments and modernize applications at their own pace.
- **Ensure operational continuity**: Redeploy vSphere-based applications to Azure while avoiding hypervisor conversions and application refactoring. Extend support for legacy applications that run Windows and SQL Server.

## Goals for migrating VMware on-premises to VMware in the cloud

With their business drivers in mind, Contoso has pinned down goals for this migration:

- Continue managing their existing environments with VMware tools that are familiar to their teams, while modernizing the applications with native Azure services.
- Seamlessly move Contoso VMware-based workloads from their datacenter to Azure, and integrate the VMware environment with Azure.
- After migration, the application in Azure should have the same performance capabilities as it does today in VMware. The application remains as critical in the cloud as it is on-premises.

These goals support their decision to use AVS and validate it as the best migration method for Contoso.

## Benefits of running VMware workloads in Azure

By using Azure VMware Solution, Contoso can now seamlessly run, manage, and secure applications across VMware environments and Azure with a common operating framework.

Contoso will capitalize on existing VMware investments, skills, and tools, including VMware vSphere, vSAN, and vCenter. At the same time, Contoso gets the scale, performance, and innovation of Azure. Additionally, they can:

- Set up VMware infrastructure in the cloud in minutes, and modernize applications at their own pace.
- Enhance VMware applications with dedicated, isolated, high-performance infrastructure and unique Azure products and services.
- Move or extend on-premises VMs to Azure without refactoring applications.
- Get scale, automation, and fast provisioning for VMware workloads on global Azure infrastructure.
- Benefit from a solution that's delivered by Microsoft, verified by VMware, and run on Azure infrastructure.

## The solutions design

After Contoso pins down their goals and requirements, they design and review a deployment solution, and identify the migration process.

### Current architecture

Contoso's current architecture features:

- VMs deployed to an on-premises datacenter that's managed by [vSphere](https://www.vmware.com/products/vsphere.html).
- Workloads deployed on a VMware ESXi host cluster that's managed with [vCenter](https://www.vmware.com/products/vcenter-server.html), [vSAN](https://www.vmware.com/products/vsan.html), and [NSX](https://www.vmware.com/products/nsx.html).

### Proposed architecture

In their proposed architecture, Contoso will:

- Deploy an [AVS private cloud](https://docs.microsoft.com/azure/azure-vmware/concepts-private-clouds-clusters) to the West US Azure region.
- Connect the on-premises datacenter to AVS running in West US by using virtual networks and [ExpressRoute](https://docs.microsoft.com/azure/azure-vmware/concepts-networking) with Global Reach enabled.
- Migrate VMs to dedicated Azure VMware Solution by using [VMware Hybrid Cloud Extension (HCX)](https://docs.vmware.com/en/VMware-HCX/services/user-guide/GUID-D0CD0CC6-3802-42C9-9718-6DA5FEC246C6.html).

![Diagram of the proposed architecture.](./media/contoso-migration-vmware-to-azure/on-premises-stretched-network-expressroute.png)

## Solution review

Contoso evaluates their proposed design by putting together a pros and cons list, as shown in the following table:

| Consideration | Details |
| --- | --- |
| **Pros** | <li>Bare-metal VMware infrastructure with high performance. <li>Infrastructure that's fully dedicated to Contoso and is physically isolated from the infrastructure of other customers. <li>Because Contoso is using a rehost that uses VMware, there's no special configuration or migration complexity. <li>Contoso can take advantage of their investment in Software Assurance by using the [Azure Hybrid Benefit](https://azure.microsoft.com/pricing/hybrid-benefit/) and [extended security updates](https://www.microsoft.com/cloud-platform/windows-server-2008) for legacy Windows and SQL platforms. <li>Contoso will retain full control of the application VMs in Azure. <br><br> |
| **Cons** | <li>Contoso will need to continue supporting the application as VMware VMs rather than move them to a managed service such as Azure App Service and Azure SQL Database. <li>Azure VMware Solution is set up and priced based on a minimum of three large nodes rather than individual VMs in Azure IaaS. They will need to plan their capacity needs as they do on-premises today rather than benefit from the on-demand nature of other services in Azure. |

> [!NOTE]
> For information about pricing, see [Azure VMware Solution pricing](https://azure.microsoft.com/pricing/details/azure-vmware/).

## Migration process

Contoso will move VMs to AVS by using the VMware HCX tool. The VMs will run in an AVS private cloud.  [VMware HCX migration methods](https://docs.vmware.com/en/VMware-HCX/services/user-guide/GUID-8A31731C-AA28-4714-9C23-D9E924DBB666.html) include bulk migration, cold migration and, while a workload is running through a live migration, vMotion or Replication-assisted vMotion (RAV).

To complete the process, the Contoso team:

- Plans their networking in Azure and ExpressRoute.
- Creates the AVS private cloud by using the Azure portal.
- Configures the network to include the ExpressRoute circuits.
- Configures the HCX components to connect their on-premises vSphere environment to the AVS private cloud.
- Replicates the VMs and then moves them to Azure by using VMware HCX.

 ![Diagram of the migration process.](./media/contoso-migration-vmware-to-azure/on-premises-vmware-hcx-azure.png)

## Scenarios steps

> [!div class="checklist"]
>
> - **Step 1: Network planning**
> - **Step 2: Create an AVS private cloud**
> - **Step 3: Configure networking**
> - **Step 4: Migrate VMs using HCX**

### Step 1: Network planning

Contoso needs to plan out their networking to include Azure Virtual Network and connectivity between on-premises and Azure. Contoso needs to provide a high-speed connection between the on-premises and Azure-based environments, along with a connection to the AVS private cloud.

This connectivity is delivered through Azure ExpressRoute and will require some specific network address ranges and firewall ports for enabling the services. This high-bandwidth, low-latency connection allows Contoso to access services that run in their Azure subscription from the AVS private cloud environment.

Contoso will need to plan an IP address scheme that includes non-overlapping address space for their [virtual networks](https://docs.microsoft.com/azure/virtual-network/virtual-network-vnet-plan-design-arm). They'll need to include a gateway subnet for the [ExpressRoute gateway](https://docs.microsoft.com/azure/expressroute/expressroute-about-virtual-network-gateways).

The AVS private cloud is connected to Contoso's Azure virtual network by using another Azure ExpressRoute connection. ExpressRoute Global Reach will be enabled to allow [direct connection](https://docs.microsoft.com/azure/azure-vmware/concepts-networking#on-premises-interconnectivity) from on-premises VMs to VMs running on the AVS private cloud. The ExpressRoute Premium SKU is required to enable Global Reach.

![Diagram of ExpressRoute Global Reach with AVS.](./media/contoso-migration-vmware-to-azure/adjacency-overview-drawing-double.png)

AVS private clouds require, at minimum, a */22* CIDR network address block for subnets. To connect to on-premises environments and virtual networks, this must be a non-overlapping network address block.

>[!NOTE]
> To learn about network planning for AVS, see [Networking checklist for Azure VMware Solution](https://docs.microsoft.com/azure/azure-vmware/tutorial-network-checklist/).

### Step 2: Create an AVS private cloud

With their network and IP address planning completed, Contoso will next focus on setting up the AVS service in the West US Azure region. With AVS, Contoso can deploy a vSphere cluster in Azure.

An AVS private cloud is an isolated, VMware software-defined datacenter that supports ESXi hosts, vCenter, vSAN, and NSX. The stack runs on dedicated and isolated bare-metal hardware nodes in an Azure region. The minimum initial deployment for an AVS private cloud is three hosts. Additional hosts can be added one at a time, up to a maximum of 16 hosts per cluster.

For more information, see [AVS preview private cloud and cluster concepts](https://docs.microsoft.com/azure/azure-vmware/concepts-private-clouds-clusters).

AVS private clouds are managed through the AVS portal. They have their own vCenter server in its own management domain.

To learn how to create AVS private clouds, see [Deploy an AVS private cloud in Azure](https://docs.microsoft.com/azure/azure-vmware/tutorial-create-private-cloud).

1. The Contoso team first registers the AVS provider with Azure by running the following command:

    ```bash
    az provider register -n Microsoft.AVS --subscription <your subscription ID>
    ```

1. In the Azure portal, the team creates the AVS private cloud by providing the networking information from their plan and then selects **Review + create**. This step takes about two hours.

    ![Screenshot of the Azure portal pane for creating an AVS private cloud.](./media/contoso-migration-vmware-to-azure/create-private-cloud.png)

1. Contoso verifies that the AVS private cloud deployment is complete by going to the resource group and selecting the private cloud resource. The status is displayed as *Succeeded*.

    ![Screenshot of the Contoso AVS private cloud page showing that the deployment is successful.](./media/contoso-migration-vmware-to-azure/validate-deployment.png)

### Step 3: Configure networking

An Azure VMware Solution private cloud requires a virtual network. Because AVS doesn't support an on-premises vCenter during preview, Contoso requires additional steps for integration with their on-premises environment. Setting up an ExpressRoute circuit and a virtual network gateway will connect their virtual networks to the AVS private cloud.

For more information, see [Configure networking for your VMware private cloud in Azure](https://docs.microsoft.com/azure/azure-vmware/tutorial-configure-networking).

1. Contoso first creates a virtual network with a gateway subnet.

    > [!IMPORTANT]
    > Contoso must use an address space that *does not* overlap with the address space that they used when they created the private cloud.

1. They create the ExpressRoute VPN gateway, making sure to select the correct SKU, and then select **Review + create**.

    ![Screenshot of the "Create virtual network gateway" pane.](./media/contoso-migration-vmware-to-azure/create-virtual-network-gateway.png)

1. They get the authorization key to connect ExpressRoute to the virtual network. The key is found on the connectivity screen of the AVS private cloud resource in the Azure portal.

    ![Screenshot of the ExpressRoute tab on the Contoso AVS private cloud Connectivity pane.](./media/contoso-migration-vmware-to-azure/request-auth-key.png)

1. The team connects the ExpressRoute to the VPN gateway that connects the AVS private cloud to their virtual network. They do this by creating a connection in Azure.

    ![Screenshot of the "Add connection" pane for connecting ExpressRoute to the virtual network.](./media/contoso-migration-vmware-to-azure/add-connection.png)

For more information, see [Learn how to access an AVS private cloud](https://docs.microsoft.com/azure/azure-vmware/tutorial-access-private-cloud).

### Step 4: Migrate by using VMware HCX

To move VMware VMs to Azure using HCX, Contoso will need to follow these high-level steps:

- Install and configure VMware HCX.
- Perform migrations to Azure by using HCX.

For more information, see [Install HCX for Azure VMware Solution](https://docs.microsoft.com/azure/azure-vmware/hybrid-cloud-extension-installation).

<!-- docsTest:ignore L2 -->

#### Install and configure VMware HCX for the public cloud

[VMware HCX](https://cloud.vmware.com/vmware-hcx) is a VMware product that's part of the Azure VMware Solution default installation. HCX Advanced is installed by default, but it can be upgraded to HCX Enterprise as additional features and functionality are required. 

AVS automates the cloud manager component of HCX in AVS. It provides the customer activation keys and download link to the connector HCX appliance that must be configured on the on-premises side and in a customer's vCenter domain. These elements are then paired with the AVS cloud appliance, so that customers can take advantage of services such as migration and L2 stretch.

- Contoso is deploying the HCX by using an OVF package that's provided by VMware.

   ![Screenshot of the "Deploy OVF Template" window.](./media/contoso-migration-vmware-to-azure/configure-template.png)

   To install and configure HCX for your AVS private cloud, see [Install HCX for Azure VMware Solution](https://docs.microsoft.com/azure/azure-vmware/hybrid-cloud-extension-installation).

- As they're configuring HCX, Contoso has chosen to enable migration and other options, including disaster recovery.

   ![Screenshot of the "Create Service Mesh" window for configuring HCX.](./media/contoso-migration-vmware-to-azure/hcx-manager.png)

   For more information, see [HCX installation workflow for HCX public clouds](https://docs.vmware.com/en/VMware-HCX/services/user-guide/GUID-FDE5473E-6B71-4A71-85B6-8C9BA2B73686.html).

#### Migrate VMs to Azure by using HCX

When both the on-premises datacenter (source) and the AVS private cloud (destination) are configured with the VMware cloud and HCX, Contoso can begin migrating their VMs. They can move VMs to and from VMware HCX-enabled datacenters by using multiple migration technologies.

- Contoso's HCX application is online and the status is green. They're now ready to migrate and protect AVS VMs by using HCX.

  ![Screenshot of the VMware vSphere Web Client page.](./media/contoso-migration-vmware-to-azure/appliance-status.png)

#### VMware HCX bulk migration

This migration method uses the VMware vSphere replication protocols to move multiple VMs simultaneously to a destination site. Benefits include:

- This method is designed to move multiple VMs in parallel.
- The migration can be set to finish on a predefined schedule.
- The VMs run at the source site until failover begins. The service interruption is equivalent to a reboot.

#### VMware HCX vMotion live migration

This migration method uses the VMware vMotion protocol to move a single VM to a remote site. Benefits include:

- This method is designed to move one VM at a time.
- There's no service interruption when the VM state is migrated.

#### VMware HCX cold migration

This migration method uses the VMware near-field communication (NFC) protocol. The option is automatically selected when the source VM is powered off.

#### VMware HCX Replication-assisted vMotion

VMware HCX Replication-assisted vMotion (RAV) combines the benefits of VMware HCX bulk migration (parallel operations, resiliency, and scheduling) with the benefits of VMware HCX vMotion migration
(zero downtime during VM state migration).

## Additional resources
For additional VMware technical documentation, see:
- [VMware HCX documentation](https://docs.vmware.com/en/VMware-HCX/index.html)
- [Migrate virtual machines by using VMware HCX](https://docs.vmware.com/en/VMware-HCX/services/user-guide/GUID-D0CD0CC6-3802-42C9-9718-6DA5FEC246C6.html?hWord=N4IghgNiBcIBIGEAaACAtgSwOYCcwBcMB7AOxAF8g)
