---
title: Move on-premises VMware infrastructure to Azure VMWare Solution
description: Learn how fictional company Contoso moves on-premises VMware VMs to Azure VMWare Solution (AVS).
author: Zimmergren
ms.author: tozimmergren
ms.date: 06/27/2023
ms.topic: conceptual
ms.custom: think-tank
---

# Move on-premises VMware infrastructure to Azure VMWare Solution

When the Contoso company decides to move its VMware virtual machines (VMs) from an on-premises datacenter to Azure, the IT team has two migration options to consider:

| Migration options | Outcome |
| --- | --- |
| [Azure Migrate](https://azure.microsoft.com/services/azure-migrate/) | <li> [Assess](/azure/migrate/tutorial-assess-vmware-azure-vm) and [migrate](/azure/migrate/tutorial-migrate-vmware) on-premises VMs. <li> Run workloads by using the Azure infrastructure as a service (IaaS). <li> Manage VMs with [Azure Resource Manager](https://azure.microsoft.com/features/resource-manager/). |
| [Azure VMware Solution](https://azure.microsoft.com/services/azure-vmware/) | <li> Use VMware HCX or VMware vMotion to move on-premises VMs. <li> Run native VMware workloads on Azure bare-metal hardware. <li> Manage VMs using VMware vSphere. |

Contoso reviews the options, and then it chooses Azure VMware Solution as the best migration option for its business.

In this article, Contoso uses Azure VMware Solution to create a private cloud in Azure. The cloud has native access to VMware vCenter Server and other VMware tools that are designed for workload migration. Contoso can confidently use Azure VMware Solution because it's a first-party Microsoft offering that's backed by VMware.

## Business drivers

The Contoso IT team works closely with business partners to define the business drivers for a VMware migration to Azure. These drivers might include:

- **Datacenter evacuation or shutdown:** Seamlessly move VMware-based workloads when IT consolidates or retires existing datacenters.
- **Disaster recovery and business continuity:** Use a VMware stack deployed in Azure as a primary or secondary on-demand disaster recovery site for the on-premises datacenter infrastructure.
- **Application modernization:** Tap into the Azure ecosystem to modernize Contoso applications without rebuilding VMware-based environments.
- **DevOps expansion:** Bring Azure DevOps tool chains to VMware environments and modernize applications at the IT team's own pace.
- **Operational continuity:** Redeploy vSphere-based applications to Azure without hypervisor conversions and application refactoring. Extend support for legacy applications that run on Windows and SQL Server.

## Migration goals

With its business drivers in mind, Contoso identifies goals for migrating VMware on-premises to VMware in the cloud:

- Continue to manage Contoso's existing environments by using VMware tools that are familiar to its teams, but modernize its applications through native Azure services.
- Seamlessly move Contoso VMware-based workloads from its datacenter to Azure, and integrate the VMware environment with Azure.
- After migration, the applications in Azure have the same performance capabilities as they do today in VMware. The applications will remain as critical in the cloud as they were on-premises.

These goals support Contoso's decision to use Azure VMware Solution, and they validate Azure VMware Solution as the company's best migration method.

## Benefits of running VMware workloads in Azure

Azure VMware Solution gives Contoso a common operating framework to use to seamlessly run, manage, and secure applications across its VMware environment and Azure.

Contoso can continue to capitalize on its existing VMware investments, experience, and tools, which include VMware vSphere, VMware vSAN, and VMware vCenter Server. But Contoso also gets the scale, performance, and innovation of Azure.

With this solution, Contoso also can:

- Set up its VMware infrastructure in the cloud in minutes.
- Modernize applications at its own pace.
- Enhance VMware applications with dedicated, isolated, high-performance infrastructure and unique Azure products and services.
- Move or extend on-premises VMs to Azure without refactoring applications.
- Get scale, automation, and fast provisioning for VMware workloads on a global Azure infrastructure.
- Benefit from a solution that's delivered by Microsoft, verified by VMware, and runs on the Azure infrastructure.

## Solution design

After Contoso solidifies its goals and requirements, the company designs and reviews a deployment solution and identifies the migration process.

### Current architecture

Here's how Contoso's current architecture is set up:

- VMs deploy to an on-premises datacenter that's managed through [vSphere](https://www.vmware.com/products/vsphere.html).
- Workloads deploy on a VMware ESXi host cluster that's managed through [vCenter Server](https://www.vmware.com/products/vcenter-server.html), [vSAN](https://www.vmware.com/products/vsan.html), and [VMware NSX](https://www.vmware.com/products/nsx.html).

### Proposed architecture

To create its proposed architecture, Contoso must complete these steps:

- Deploy an [Azure VMware Solution private cloud](/azure/azure-vmware/concepts-private-clouds-clusters) to the West US Azure region.
- Connect the on-premises datacenter to Azure VMware Solution and run in the West US Azure region by using virtual networks and [Azure ExpressRoute](/azure/azure-vmware/concepts-networking) with the Global Reach option enabled.
- Migrate VMs to dedicated Azure VMware Solution by using [VMware HCX](https://docs.vmware.com/en/VMware-HCX/services/user-guide/GUID-D0CD0CC6-3802-42C9-9718-6DA5FEC246C6.html).

:::image type="content" source="media/contoso-migration-vmware-to-azure/on-premises-stretched-network-expressroute.png" border="false" alt-text="Diagram of the proposed architecture.":::

## Solution review

Contoso evaluates its proposed design by creating a list of pros and cons for the solution:

| Consideration | Details |
| --- | --- |
| **Pros** | <li> Bare-metal VMware infrastructure with high performance. <li> Infrastructure that's fully dedicated to Contoso and is physically isolated from the infrastructure of other customers. <li> Because Contoso is using a rehost that uses VMware, migration complexity and special configurations aren't factors the company needs to plan for. <li> Contoso can take advantage of its investment in Software Assurance by using the [Azure Hybrid Benefit](https://azure.microsoft.com/pricing/hybrid-benefit/) and [extended security updates](/windows-server/) for legacy Windows and SQL Server platforms. <li> Contoso retains full control of the application VMs in Azure. <br><br> |
| **Cons** | <li> Contoso will need to continue supporting its application as VMware VMs instead of moving the applications to a managed service like Azure App Service or Azure SQL Database. <li> Azure VMware Solution is set up and priced based on a minimum of three large nodes rather than individual VMs in the Azure IaaS. Contoso currently uses an on-premises environment that restricts it from the on-demand nature of other services in Azure, so the company must carefully plan its capacity needs. |

> [!NOTE]
> For information about pricing, see [Azure VMware Solution pricing](https://azure.microsoft.com/pricing/details/azure-vmware/).

## Migration process

Contoso will move its VMs to Azure VMware Solution by using the VMware HCX tool. The VMs will run in an Azure VMware Solution private cloud. [VMware HCX migration methods](https://docs.vmware.com/en/VMware-HCX/services/user-guide/GUID-8A31731C-AA28-4714-9C23-D9E924DBB666.html) include running a bulk migration or a cold migration. VMware vMotion or replication-assisted vMotion (RAV) is a method that's reserved for workloads that run through a live migration.

To complete the process, the Contoso team takes these steps:

- Plans its networking in Azure and ExpressRoute.
- Creates the Azure VMware Solution private cloud by using the Azure portal.
- Configures the network to include the ExpressRoute circuits.
- Configures the HCX components to connect its on-premises vSphere environment to the Azure VMware Solution private cloud.
- Replicates the VMs, and then moves the VMs to Azure by using VMware HCX.

  :::image type="content" source="media/contoso-migration-vmware-to-azure/on-premises-vmware-hcx-azure.png" border="false" alt-text="Diagram of the migration process.":::

## Scenarios steps

> [!div class="checklist"]
>
> - **Step 1: Plan networking**
> - **Step 2: Create an Azure VMware Solution private cloud**
> - **Step 3: Configure networking**
> - **Step 4: Migrate VMs by using HCX**

### Step 1: Plan networking

Contoso needs to plan out its networking to include Azure Virtual Network and connectivity between on-premises environment and Azure. The company needs to provide a high-speed connection between its on-premises environment and Azure-based environments. It also needs a connection to the Azure VMware Solution private cloud.

Network connectivity is delivered through Azure ExpressRoute and requires specific network address ranges and firewall ports to enable the services. Contoso will use the high-bandwidth, low-latency connection to access services that run in its Azure subscription from the Azure VMware Solution private cloud environment.

Contoso needs to plan an IP address scheme that includes non-overlapping address space for its [virtual networks](/azure/virtual-network/virtual-network-vnet-plan-design-arm). The company needs to include a gateway subnet for the [ExpressRoute gateway](/azure/expressroute/expressroute-about-virtual-network-gateways).

The Azure VMware Solution private cloud is connected to Contoso's virtual network in Azure by using another ExpressRoute connection. Contoso will use the ExpressRoute Global Reach option to allow [direct connection](/azure/azure-vmware/concepts-networking#on-premises-interconnectivity) from on-premises VMs to VMs running on the Azure VMware Solution private cloud. The ExpressRoute Premium SKU is required to enable Global Reach.

:::image type="content" source="media/contoso-migration-vmware-to-azure/adjacency-overview-drawing-double.png" border="false" alt-text="Diagram of ExpressRoute Global Reach with Azure VMware Solution." lightbox="media/contoso-migration-vmware-to-azure/adjacency-overview-drawing-double.png":::

Azure VMware Solution private clouds require, at minimum, a `/22` CIDR network address block for subnets. To connect to on-premises environments and virtual networks, the network address block must be non-overlapping.

> [!NOTE]
> To learn about network planning for Azure VMware Solution, see [Networking checklist for Azure VMware Solution](/azure/azure-vmware/tutorial-network-checklist).

### Step 2: Create an Azure VMware Solution private cloud

With its network and IP address planning completed, Contoso next focuses on setting up the Azure VMware Solution service in the West US Azure region. Contoso can use Azure VMware Solution to deploy a vSphere cluster in Azure.

An Azure VMware Solution private cloud is an isolated, VMware software-defined datacenter that supports ESXi hosts, vCenter Server, vSAN, and NSX. The stack runs on dedicated and isolated bare-metal hardware nodes in an Azure region. The minimum initial deployment for an Azure VMware Solution private cloud is 3 hosts. Additional hosts can be added one at a time, up to a maximum of 16 hosts per cluster.

For more information, see [Azure VMware Solution preview private cloud and cluster concepts](/azure/azure-vmware/concepts-private-clouds-clusters).

Azure VMware Solution private clouds are managed through the Azure VMware Solution portal. Contoso has an instance of vCenter Server in its own management domain.

To learn how to create Azure VMware Solution private clouds, see [Deploy an Azure VMware Solution private cloud in Azure](/azure/azure-vmware/tutorial-create-private-cloud).

1. The Contoso team first registers the Azure VMware Solution provider with Azure by running the following command:

    ```bash
    az provider register -n Microsoft.AVS --subscription <the subscription ID>
    ```

1. In the Azure portal, the team creates the Azure VMware Solution private cloud by providing the networking information from the plan. The team then selects **Review + create**. This step takes about two hours.

   :::image type="content" source="media/contoso-migration-vmware-to-azure/create-private-cloud.png" alt-text="Screenshot of the Azure portal pane for creating an Azure VMware Solution private cloud.":::

1. The team verifies that the Azure VMware Solution private cloud deployment is successful by going to the resource group and selecting the private cloud resource. The status is displayed as **Succeeded**.

   :::image type="content" source="media/contoso-migration-vmware-to-azure/validate-deployment.png" alt-text="Screenshot of the Contoso Azure VMware Solution private cloud page showing that the deployment is successful.":::

### Step 3: Configure networking

An Azure VMware Solution private cloud requires a virtual network. Because Azure VMware Solution doesn't support an on-premises instance of vCenter Server during preview, Contoso requires additional steps for integration with its on-premises environment. By setting up an ExpressRoute circuit and a virtual network gateway, the team connects its virtual networks to the Azure VMware Solution private cloud.

1. The Contoso team first creates a virtual network with a gateway subnet.

    > [!IMPORTANT]
    > The team must use an address space that *does not* overlap with the address space that it used when it created the private cloud.

1. The team creates the ExpressRoute VPN gateway. The team makes sure it selects the correct SKU, and then selects **Review + create**.

   :::image type="content" source="media/contoso-migration-vmware-to-azure/create-virtual-network-gateway.png" alt-text="Screenshot of the Create virtual network gateway pane.":::

1. The team gets the authorization key to connect ExpressRoute to the virtual network. The key is shown in the Azure portal under **Connectivity** for the Azure VMware Solution private cloud resource.

   :::image type="content" source="media/contoso-migration-vmware-to-azure/request-auth-key.png" alt-text="Screenshot of the ExpressRoute tab on the Contoso Azure VMware Solution private cloud connectivity pane.":::

1. The team connects the ExpressRoute to the VPN gateway that connects the Azure VMware Solution private cloud to the Contoso virtual network. To connect the private cloud to the virtual network, it creates a connection in Azure.

   :::image type="content" source="media/contoso-migration-vmware-to-azure/add-connection.png" alt-text="Screenshot of the Add connection pane for connecting ExpressRoute to the virtual network.":::

For more information, see [Configure networking for your VMware private cloud in Azure](/azure/azure-vmware/tutorial-configure-networking) and [Learn how to access an Azure VMware Solution private cloud](/azure/azure-vmware/tutorial-access-private-cloud).

### Step 4: Migrate by using VMware HCX

To move VMware VMs to Azure by using HCX, the Contoso team completes these high-level steps:

- Install and configure VMware HCX for the public cloud
- Perform migrations to Azure by using HCX

For more information, see [Install HCX for Azure VMware Solution](/azure/azure-vmware/configure-vmware-hcx).

#### Install and configure VMware HCX for the public cloud

[VMware HCX](https://www.vmware.com/products/hcx.html) is a VMware product that's part of the Azure VMware Solution default installation. HCX Advanced is installed by default, but you can upgrade to HCX Enterprise if you require more features and functionality.

Azure VMware Solution automates the cloud manager component of HCX in Azure VMware Solution. It provides the customer activation keys and the download link to the connector HCX appliance that must be configured on the on-premises side and in a customer's vCenter Server domain. These elements are then paired with the Azure VMware Solution cloud appliance so that customers can take advantage of services like migration and Layer 2 stretch.

- The Contoso team deploys the HCX appliance by using an OVF package that's provided by VMware.

  :::image type="content" source="media/contoso-migration-vmware-to-azure/configure-template.png" alt-text="Screenshot of the Deploy OVF Template window.":::

   To learn how to install and configure HCX for your Azure VMware Solution private cloud, see [Install HCX for Azure VMware Solution](/azure/azure-vmware/configure-vmware-hcx).

- As the team configures HCX, it enables migration and other options, including disaster recovery.

  :::image type="content" source="media/contoso-migration-vmware-to-azure/hcx-manager.png" alt-text="Screenshot of the Create Service Mesh window for configuring HCX." lightbox="media/contoso-migration-vmware-to-azure/hcx-manager.png":::

   For more information, see [HCX installation workflow for HCX public clouds](https://docs.vmware.com/en/VMware-HCX/services/user-guide/GUID-FDE5473E-6B71-4A71-85B6-8C9BA2B73686.html).

#### Migrate VMs to Azure by using HCX

When both the on-premises datacenter (source) and the Azure VMware Solution private cloud (destination) are configured with the VMware cloud and HCX, Contoso begins to migrate its VMs. The team can move VMs to and from VMware HCX-enabled datacenters by using multiple migration technologies.

- Contoso's HCX application is online, and the status is green. The team is now ready to migrate and protect Azure VMware Solution VMs by using HCX.

  :::image type="content" source="media/contoso-migration-vmware-to-azure/appliance-status.png" alt-text="Screenshot of the VMware vSphere web client page." lightbox="media/contoso-migration-vmware-to-azure/appliance-status.png":::

#### VMware HCX bulk migration

The HCX bulk migration method uses the VMware vSphere replication protocols to move multiple VMs simultaneously to a destination site. Benefits include:

- This method is designed to move multiple VMs in parallel.
- The migration can be set to finish on a predefined schedule.
- The VMs run at the source site until failover begins. The service interruption is equivalent to a reboot.

#### VMware HCX vMotion live migration

The HCX vMotion live migration method uses the VMware vMotion protocol to move a single VM to a remote site. Benefits include:

- This method is designed to move one VM at a time.
- No service interruption when the VM state is migrated.

#### VMware HCX cold migration

The HCX cold migration method uses the VMware near-field communication protocol. The option is automatically selected when the source VM is turned off.

#### VMware HCX replication-assisted vMotion

VMware HCX RAV combines the benefits of VMware HCX bulk migration with VMware HCX vMotion live migration. It offers parallel operations, resiliency, and scheduling, with zero downtime during VM state migration.

## VMware resources

For more information about VMware, see these resources:

- [VMware HCX documentation](https://docs.vmware.com/en/VMware-HCX/index.html)
- [Migrate virtual machines by using VMware HCX](https://docs.vmware.com/en/VMware-HCX/services/user-guide/GUID-D0CD0CC6-3802-42C9-9718-6DA5FEC246C6.html?hWord=N4IghgNiBcIBIGEAaACAtgSwOYCcwBcMB7AOxAF8g)
