---
title: "Deploy a migration infrastructure"
description: Learn how Contoso sets up an Azure infrastructure for migration to Azure.
author: deltadan
ms.author: abuck
ms.date: 04/01/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
services: azure-migrate
---

<!-- cSpell:ignore deltadan CSPs untrust CIDR RRAS CONTOSODC sysvol ITIL NSGs ASGs -->

# Deploy a migration infrastructure

This article shows how the fictional company Contoso prepares its on-premises infrastructure for migration, sets up an Azure infrastructure in preparation for migration, and runs the business in a hybrid environment. When you use this example to help plan your own infrastructure migration efforts, keep the following considerations in mind:

- The provided sample architecture is specific to Contoso. Review your own organization's business needs, structure, and technical requirements when making important infrastructure decisions about subscription design or networking architecture.
- Whether you need all the elements described in this article depends on your migration strategy. For example, if you're building only cloud-native apps in Azure, you might need a less complex networking structure.

## Overview

Before Contoso can migrate to Azure, it's critical to prepare an Azure infrastructure. Generally, there are six broad areas Contoso needs to think about:

> [!div class="checklist"]
>
> - **Step 1: Azure subscriptions.** How will Contoso purchase Azure, and interact with the Azure platform and services?
> - **Step 2: Hybrid identity.** How will it manage and control access to on-premises and Azure resources after migration? How does Contoso extend or move identity management to the cloud?
> - **Step 3: Disaster recovery and resilience.** How will Contoso ensure that its apps and infrastructure are resilient if outages and disasters occur?
> - **Step 4: Networking.** How should Contoso design a networking infrastructure, and establish connectivity between its on-premises datacenter and Azure?
> - **Step 5: Security.** How will it secure the hybrid/Azure deployment?
> - **Step 6: Governance.** How will Contoso keep the deployment aligned with security and governance requirements?

## Before you start

Before we start reviewing the infrastructure, consider reading some background information about relevant Azure capabilities:

- Several options are available for purchasing Azure access, including Pay-As-You-Go, Enterprise Agreements (EA), Open Licensing from Microsoft resellers, or from Microsoft Partners known as Cloud Solution Providers (CSPs). Learn about [purchase options](https://azure.microsoft.com/pricing/purchase-options), and read about how [Azure subscriptions are organized](https://azure.microsoft.com/blog/organizing-subscriptions-and-resource-groups-within-the-enterprise).
- Get an overview of Azure [identity and access management](https://www.microsoft.com/security/business/identity). In particular, learn about [Azure AD and extending on-premises Active Directory to the cloud](https://docs.microsoft.com/azure/active-directory/identity-fundamentals). There's a useful downloadable e-book about [identity and access management (IAM) in a hybrid environment](https://azure.microsoft.com/resources/hybrid-cloud-identity).
- Azure provides a robust networking infrastructure with options for hybrid connectivity. Get an overview of [networking and network access control](https://docs.microsoft.com/azure/security/security-network-overview).
- Read the [introduction to Azure Security](https://docs.microsoft.com/azure/security/fundamentals/overview), and learn how to create a plan for [Azure governance](https://docs.microsoft.com/azure/governance).

## On-premises architecture

Here's a diagram showing the current Contoso on-premises infrastructure.

 ![Contoso architecture](./media/contoso-migration-infrastructure/contoso-architecture.png)

- Contoso has one main datacenter located in the city of New York in the eastern United States.
- There are three additional local branches across the United States.
- The main datacenter is connected to the internet with a fiber metro ethernet connection (500 Mbps).
- Each branch is connected locally to the internet using business class connections, with IPSec VPN tunnels back to the main datacenter. This approach allows the entire network to be permanently connected, and optimizes internet connectivity.
- The main datacenter is fully virtualized with VMware. Contoso has two ESXi 6.5 virtualization hosts, managed by vCenter Server 6.5.
- Contoso uses Active Directory for identity management, and DNS servers on the internal network.
- The domain controllers in the datacenter run on VMware virtual machines. The domain controllers at local branches run on physical servers.

## Step 1: Buy and subscribe to Azure

Contoso needs to figure out how to buy Azure, how to architect subscriptions, and how to license services and resources.

### Buy Azure

Contoso is enrolling in an [Enterprise Agreement (EA)](https://azure.microsoft.com/pricing/enterprise-agreement). This agreement entails an upfront monetary commitment to Azure, entitling Contoso to earn great benefits, including flexible billing options and optimized pricing.

- Contoso estimated what its yearly Azure spend will be. When it signed the agreement, Contoso paid for the first year in full.
- Contoso needs to use all commitments before the year is over, or lose the value for those dollars.
- If for some reason Contoso exceeds its commitment and spends more, Microsoft will invoice them for the difference.
- Any cost incurred above the commitment will be at the same rates as those in the Contoso contract. There are no penalties for going over.

### Manage subscriptions

After paying for Azure, Contoso needs to figure out how to manage Azure subscriptions. Contoso has an EA, and thus no limit on the number of Azure subscriptions it can set up.

- An Azure Enterprise Enrollment defines how a company shapes and uses Azure services, and defines a core governance structure.
- As a first step, Contoso has defined a structure known as an enterprise scaffold for Enterprise Enrollment. Contoso used the [Azure enterprise scaffold guidance](https://docs.microsoft.com/azure/azure-resource-manager/resource-manager-subscription-governance) to help understand and design a scaffold.
- For now, Contoso has decided to use a functional approach to manage subscriptions.
  - Inside the enterprise, it will use a single IT department that controls the Azure budget. This will be the only group with subscriptions.
  - Contoso will extend this model in the future, so that other corporate groups can join as departments in the Enterprise Enrollment.
  - Inside the IT department, Contoso has structured two subscriptions, Production and Development.
  - If Contoso requires additional subscriptions in the future, it needs to manage access, policies, and compliance for those subscriptions. Contoso will do that by introducing [Azure management groups](https://docs.microsoft.com/azure/azure-resource-manager/management-groups-overview), as an additional layer above subscriptions.

  ![Enterprise structure](./media/contoso-migration-infrastructure/enterprise-structure.png)

### Examine licensing

With subscriptions configured, Contoso can look at Microsoft licensing. The licensing strategy will depend on the resources that Contoso wants to migrate to Azure and how virtual machines (VMs) and services are selected and deployed in Azure.

#### Azure Hybrid Benefit

When deploying VMs in Azure, standard images include a license that will charge Contoso by the minute for the software being used. However, Contoso has been a long-term Microsoft customer, and has maintained EAs and open licenses with Software Assurance (SA).

Azure Hybrid Benefit provides a cost-effective method for migration, allowing Contoso to save on Azure VMs and SQL Server workloads by converting or reusing Windows Server Datacenter and Standard edition licenses covered with Software Assurance. This allows Contoso to pay a lower base compute rate for VMs and SQL Server. For more information, see [Azure Hybrid Benefit](https://azure.microsoft.com/pricing/hybrid-benefit).

#### License Mobility

License Mobility through Software Assurance gives Microsoft Volume Licensing customers like Contoso the flexibility to deploy eligible server apps with active SA on Azure. This eliminates the need to purchase new licenses. With no associated mobility fees, existing licenses can easily be deployed in Azure. For more information, see [License Mobility through Software Assurance on Azure](https://azure.microsoft.com/pricing/license-mobility).

#### Reserve instances for predictable workloads

Predictable workloads are those that always need to be available with VMs running. For example, line-of-business apps such as an SAP ERP system. On the other hand, unpredictable workloads are those that are variable, such as VMs that are on during high demand and off when demand is low.

![Reserved instance](./media/contoso-migration-infrastructure/reserved-instance.png)

In exchange for using reserved instances for specific VM instances must be maintained for large durations of time, Contoso can get both a discount and prioritized capacity. Using [Azure Reserved Instances](https://azure.microsoft.com/pricing/reserved-vm-instances) together with Azure Hybrid Benefit can save Contoso up to 82% off regular pay-as-you-go pricing (as of April 2018).

## Step 2: Manage hybrid identity

Giving and controlling user access to Azure resources with identity and access management (IAM) is an important step in pulling together an Azure infrastructure.

- Contoso decides to extend its on-premises Active Directory into the cloud, rather than build a new separate system in Azure.
- It creates an Azure-based Active Directory to do this.
- Contoso doesn't have Office 365 in place, so it needs to provision a new Azure AD.
- Office 365 uses Azure AD for user management. If Contoso was using Office 365, it would already have an Azure AD tenant, and can use that as the primary directory.
- Learn more about [Azure AD for Office 365](https://docs.microsoft.com/office365/enterprise/about-office-365-identity).
- Learn how to [add a subscription to an existing Azure AD tenant](https://docs.microsoft.com/azure/active-directory/fundamentals/active-directory-how-subscriptions-associated-directory).

### Create an Azure AD directory

Contoso is using the Azure AD Free edition that's included with an Azure subscription. Contoso admins create an Azure AD directory:

1. In the [Azure portal](https://portal.azure.com), they navigate to **Create a resource** > **Identity** > **Azure Active Directory**.
2. In **Create directory**, they specify a name for the directory, an initial domain name, and the region where the directory should be created.

    ![Create an Azure AD directory](./media/contoso-migration-infrastructure/azure-ad-create.png)

    > [!NOTE]
    > The directory that's created has an initial domain name in the form `domain-name.onmicrosoft.com`. The name can't be changed or deleted. Instead, they need to add its registered domain name to Azure AD.

### Add the domain name

To use its standard domain name, Contoso admins need to add it as a custom domain name to Azure AD. This option allows them to assign familiar user names. For example, a user can sign in with the email address `billg@contoso.com` instead of `billg@contosomigration.microsoft.com`.

To set up a custom domain name, they add it to the directory, add a DNS entry, and then verify the name in Azure AD.

1. In **Custom domain names** > **Add custom domain**, they add the domain.
2. To use a DNS entry in Azure, they need to register it with their domain registrar.

    - In the **Custom domain names** list, they note the DNS information for the name. It's using an MX entry.
    - They need access to the name server to do this. They log into the `contoso.com` domain, and create a new MX record for the DNS entry provided by Azure AD, using the details noted.

3. After the DNS records propagate, in the details name for the domain, they select **Verify** to check the custom domain name.

     ![Azure AD DNS](./media/contoso-migration-infrastructure/azure-ad-dns.png)

### Set up on-premises and Azure groups and users

Now that the Azure AD directory is established, Contoso admins need to add employees to on-premises Active Directory groups that will synchronize to Azure AD. They should use on-premises group names that match the names of resource groups in Azure. This makes it easier to identify matches for synchronization purposes.

#### Create resource groups in Azure

Azure resource groups gather Azure resources together. Using a resource group ID allows Azure to perform operations on the resources within the group.

- An Azure subscription can have multiple resource groups. A resource group exists in a single subscription.
- In addition, a single resource group can have multiple resources. A resource belongs to a single resource group.

Contoso admins set up Azure resource groups as shown in the following table.

<!-- markdownlint-disable MD033 -->

| Resource group | Details |
| --- | --- |
| `ContosoCobRG` | This group contains all resources related to continuity of business (COB). It includes vaults that Contoso will use for the Azure Site Recovery service, and the Azure Backup service. <br><br> It will also include resources used for migration, including Azure Migrate and Azure Database Migration Service. |
| `ContosoDevRG` | This group contains development and test resources. |
| `ContosoFailoverRG` | This group serves as a landing zone for failed over resources. |
| `ContosoNetworkingRG` | This group contains all networking resources. |
| `ContosoRG` | This group contains resources related to production apps and databases. |

They create resource groups as follows:

1. In the Azure portal > **Resource groups**, they add a group.
2. For each group, they specify a name, the subscription to which the group belongs, and the region.
3. Resource groups appear in the **Resource groups** list.

  ![Resource groups](./media/contoso-migration-infrastructure/resource-groups.png)

##### Scale resource groups

In future, Contoso will add other resource groups based on needs. For example, they could define a resource group for each app or service, so that they can be managed and secured independently.

#### Create matching security groups on-premises

1. In the on-premises Active Directory, Contoso admins set up security groups with names that match the names of the Azure resource groups.

    ![On-premises Active Directory security groups](./media/contoso-migration-infrastructure/on-prem-ad.png)

2. For management purposes, they create an additional group that will be added to all of the other groups. This group will have rights to all resource groups in Azure. A limited number of Global Admins will be added to this group.

### Synchronize Active Directory

Contoso wants to provide a common identity for accessing resources on-premises and in the cloud. To do this, it will integrate the on-premises Active Directory with Azure AD. With this model:

- Users and organizations can take advantage of a single identity to access on-premises applications and cloud services such as Office 365, or thousands of other sites on the internet.
- Admins can use the groups in Active Directory to implement [Role Based Access Control (RBAC)](https://docs.microsoft.com/azure/role-based-access-control/role-assignments-portal) in Azure.

To facilitate integration, Contoso uses the [Azure AD Connect tool](https://docs.microsoft.com/azure/active-directory/connect/active-directory-aadconnect). When you install and configure the tool on a domain controller, it synchronizes the on-premises Active Directory identities to Azure AD.

### Download the tool

1. In the Azure portal, Contoso admins go to **Azure Active Directory** > **Azure AD Connect**, and download the latest version of the tool to the server they're using for synchronization.

    ![Download Azure AD Connect](./media/contoso-migration-infrastructure/download-ad-connect.png)

2. They start the `AzureADConnect.msi` installation, using **Express Settings**. This is the most common installation, and can be used for a single-forest topology with password-hash synchronization for authentication.

    ![Azure AD Connect Wizard](./media/contoso-migration-infrastructure/ad-connect-wiz1.png)

3. In **Connect to Azure AD**, they specify the credentials for connecting to the Azure AD (in the form `admin@contoso.com` or `admin@contoso.onmicrosoft.com`).

    ![Azure AD Connect Wizard](./media/contoso-migration-infrastructure/ad-connect-wiz2.png)

4. In **Connect to AD DS**, they specify credentials for the on-premises Active Directory (in the form `CONTOSO\admin` or `contoso.com\admin`).

     ![Azure AD Connect Wizard](./media/contoso-migration-infrastructure/ad-connect-wiz3.png)

5. In **Ready to configure**, they select **Start the synchronization process when configuration completes** to start the sync immediately. Then they install.

    Note the following:
  
    - Contoso has a direct connection to Azure. If your on-premises Active Directory is behind a proxy, review [Troubleshoot Azure AD connectivity](https://docs.microsoft.com/azure/active-directory/connect/active-directory-aadconnect-troubleshoot-connectivity).

    - After the first synchronization, on-premises Active Directory objects are visible in the Azure AD directory.

      ![On-premises Active Directory in Azure](./media/contoso-migration-infrastructure/on-prem-ad-groups.png)

    - The Contoso IT team is represented in each group, based on its role.

      ![On-premises Active Directory members in Azure](./media/contoso-migration-infrastructure/on-prem-ad-group-members.png)

### Set up RBAC

Azure [role-based access control (RBAC)](https://docs.microsoft.com/azure/role-based-access-control/role-assignments-portal) enables fine-grained access management for Azure. Using RBAC, you can grant only the amount of access that users need to perform tasks. You assign the appropriate RBAC role to users, groups, and applications at a scope level. The scope of a role assignment can be a subscription, a resource group, or a single resource.

Contoso admins then assign roles to the Active Directory groups that they synchronized from on-premises.

1. In the `ControlCobRG` resource group, they select **Access control (IAM)** > **Add role assignment**.
2. In **Add role assignment** > **Role**, > **Contributor**, they select the `ContosoCobRG` group from the list. The group then appears in the **Selected members** list.
3. They repeat this with the same permissions for the other resource groups (except for `ContosoAzureAdmins`), by adding `Contributor` permissions to the account that matches the resource group.
4. For the `ContosoAzureAdmins` group, they assign the `Owner` role.

    ![On-premises Active Directory members in Azure](./media/contoso-migration-infrastructure/on-prem-ad-groups.png)

## Step 3: Design for resiliency

### Set up regions

Azure resources are deployed within regions.

- Regions are organized into geographies, and data residency, sovereignty, compliance, and resiliency requirements are honored within geographical boundaries.
- A region is composed of a set of datacenters. These datacenters are deployed within a latency-defined perimeter, and connected through a dedicated regional low-latency network.
- Each Azure region is paired with a different region for resiliency.
- Read about [Azure regions](https://azure.microsoft.com/global-infrastructure/regions), and understand [how regions are paired](https://docs.microsoft.com/azure/best-practices-availability-paired-regions).

Contoso has decided to use `East US 2` (located in Virginia) as the primary region and `Central US` (located in Iowa) as the secondary region, for several reasons:

- The Contoso datacenter is located in New York, and Contoso considered latency to the closest datacenter.
- `East US 2` has all the services and products that Contoso needs. Not all Azure regions have the same products and services available. For more information, see [Azure products by region](https://azure.microsoft.com/global-infrastructure/services).
- `Central US` is the Azure paired region for `East US 2`.

As it thinks about the hybrid environment, Contoso needs to consider how to build resilience and a disaster recovery strategy into the region design. Broadly, strategies range from a single-region deployment, which relies on Azure platform features such as fault domains and regional pairing for resilience, through to a full active-active model in which cloud services and database are deployed and servicing users from two regions.

Contoso has decided to take a middle road. It will deploy apps and resources in a primary region, and keep a full copy of the infrastructure in the secondary region, so that it's ready to act as a full backup if a complete app disaster or regional failure occurs.

### Set up availability

**Availability sets:**

Availability sets help protect apps and data from a local hardware and networking outage within a datacenter.

- Availability sets distribute Azure VMs across different physical hardware within a datacenter.
- Fault domains represent underlying hardware with a common power source and network switch within the datacenter. VMs in an availability set are distributed across different fault domains to minimize outages caused by a single hardware or networking failure.
- Update domains represent underlying hardware that can undergo maintenance or be rebooted at the same time. Availability sets also distribute VMs across multiple update domains to ensure at least one instance will be running at all times.

Contoso will implement availability sets whenever VM workloads require high availability. For more information, see [Manage the availability of Windows virtual machines in Azure](https://docs.microsoft.com/azure/virtual-machines/windows/manage-availability).

**Availability zones:**

Availability zones help protect apps and data from failures affecting an entire datacenter within a region.

- Each availability zone represents a unique physical location within an Azure region.
- Each zone is made up of one or more datacenters equipped with independent power, cooling, and networking.
- There's a minimum of three separate zones in all enabled regions.
- The physical separation of zones within a region protects applications and data from datacenter failures.

Contoso will deploy availability zones as applications require scalability, high-availability, and resiliency. For more information, see [Regions and Availability Zones in Azure](https://docs.microsoft.com/azure/availability-zones/az-overview).

### Configure backup

**Azure Backup:**

Azure Backup allows you to back up and restore Azure VM disks.

- Azure backup allows automated backups of VM disk images, stored in Azure storage.
- Backups are application consistent, ensuring backed up data is transactionally consistent and that applications will boot up post-restore.
- Azure Backup supports locally redundant storage (LRS) to replicate multiple copies of your backup data within a datacenter if a local hardware failure occurs.
- If a regional outage occurs, Azure Backup also supports geo-redundant storage (GRS), replicating your backup data to a secondary paired region.
- Azure Backup encrypts data in-transit using AES-256. Backed-up data at rest is encrypted using [Storage Service Encryption (SSE)](https://docs.microsoft.com/azure/storage/common/storage-service-encryption).

Contoso will use Azure Backup with GRS on all production VMs to ensure that workload data is backed up and can be quickly restored if a disruption occurs. For more information, see the [Overview of Azure Backup](https://docs.microsoft.com/azure/backup/backup-overview).

### Set up disaster recovery

**Azure Site Recovery:**

Azure Site Recovery helps ensure business continuity by keeping business apps and workloads running during regional outages.

- Azure Site Recovery continuously replicates Azure VMs from a primary to a secondary region, ensuring functional copies in both locations.
- In the event of an outage in the primary region, your application or service fails over to using the VM instances replicated in the secondary region, minimizing potential disruption.
- When operations return to normal, your applications or services can fail back to VMs in the primary region.

Contoso will implement [Azure Site Recovery](https://docs.microsoft.com/azure/site-recovery/site-recovery-overview) for all production VMs used in mission-critical workloads, ensuring minimal disruption during an outage in the primary region.

## Step 4: Design a network infrastructure

With the regional design in place, Contoso is ready to consider a networking strategy. It needs to think about how the on-premises datacenter and Azure connect and communicate with each other, and how to design the network infrastructure in Azure. Specifically Contoso needs to:

- **Plan hybrid network connectivity.** Figure out how it's going to connect networks across on-premises and Azure.
- **Design an Azure network infrastructure.** Decide how it will deploy networks over regions. How will networks communicate within the same region, and across regions?
- **Design and set up Azure networks.** Set up Azure networks and subnets, and decide what will reside in them.

### Plan hybrid network connectivity

Contoso considered a [number of architectures](https://docs.microsoft.com/azure/architecture/reference-architectures/hybrid-networking) for hybrid networking between Azure and the on-premises datacenter. For more information, see [Choose a solution for connecting an on-premises network to Azure](https://docs.microsoft.com/azure/architecture/reference-architectures/hybrid-networking/considerations).

As a reminder, the Contoso on-premises network infrastructure currently consists of the datacenter in New York, and local branches in the eastern half of the US. All locations have a business class connection to the internet. Each of the branches is then connected to the datacenter via an IPSec VPN tunnel over the internet.

![Contoso network](./media/contoso-migration-infrastructure/contoso-networking.png)

Here's how Contoso decided to implement hybrid connectivity:

1. Set up a new site-to-site VPN connection between the Contoso datacenter in New York and the two Azure regions in East US 2 and Central US.
2. Branch office traffic bound for virtual networks in Azure will route through the main Contoso datacenter.
3. As Contoso scales up Azure deployment, it will establish an ExpressRoute connection between the datacenter and the Azure regions. When this happens, Contoso will retain the VPN site-to-site connection for failover purposes only.
    - Learn more about [choosing between a VPN and ExpressRoute hybrid solution](https://docs.microsoft.com/azure/architecture/reference-architectures/hybrid-networking/considerations).
    - Verify [ExpressRoute locations and support](https://docs.microsoft.com/azure/expressroute/expressroute-locations-providers).

**VPN-only:**

![Contoso VPN](./media/contoso-migration-infrastructure/hybrid-vpn.png)

**VPN and ExpressRoute:**

![Contoso VPN/ExpressRoute](./media/contoso-migration-infrastructure/hybrid-vpn-expressroute.png)

### Design the Azure network infrastructure

Contoso's network configuration must make the hybrid deployment secure and scalable. Contoso is taking a long-term approach to this, designing virtual networks to be resilient and enterprise ready. For more information, see [Plan virtual networks](https://docs.microsoft.com/azure/virtual-network/virtual-network-vnet-plan-design-arm).

To connect the two regions, Contoso will implement a hub-to-hub network model:

- Within each region, Contoso will use a hub and spoke model.
- To connect networks and hubs, Contoso will use Azure network peering.

#### Network peering

[Virtual network peering](https://docs.microsoft.com/azure/virtual-network/virtual-network-peering-overview) in Azure connects virtual networks and hubs. Global peering allows connections between virtual network or hubs in different regions. Local peering connects virtual networks in the same region. Virtual network peering provides several advantages:

- Network traffic between peered VNets is private.
- Traffic between the VNets is kept on the Microsoft backbone network. No public internet, gateways, or encryption is required in the communication between the VNets.
- Peering provides a default, low-latency, high-bandwidth connection between resources in different VNets.

#### Hub-to-hub across regions

Contoso will deploy a hub in each region. A hub is a virtual network in Azure that acts as a central point of connectivity to your on-premises network. The hub VNets will connect to each other via global VNet peering, which connects VNets across Azure regions.

- The hub in each region is peered to its partner hub in the other region.
- The hub is peered to every network in its region, and can connect to all network resources.

    ![Global peering](./media/contoso-migration-infrastructure/global-peering.png)

#### Hub and spoke model within a region

Within each region, Contoso will deploy VNets for different purposes, as spoke networks from the region hub. VNets within a region use peering to connect to their hub, and to each other.

#### Design the hub network

Within the hub and spoke model that Contoso has chosen, it needs to think about how traffic from the on-premises datacenter, and from the internet, will be routed. Here's how Contoso has decided to handle routing for both the `East US 2` and `Central US` hubs:

- Contoso is designing a network that allows traffic from the internet as well as from their corporate network using a VPN to Azure.
- The network architecture has two boundaries, an untrusted front-end perimeter zone and a back-end trusted zone.
- A firewall will have a network adapter in each zone, controlling access to trusted zones.
- From the internet:
  - Internet traffic will hit a load-balanced public IP address on the perimeter network.
  - This traffic is routed through the firewall, and subject to firewall rules.
  - After network access controls are implemented, traffic will be forwarded to the appropriate location in the trusted zone.
  - Outbound traffic from the VNet will be routed to the internet using user-defined routes. The traffic is forced through the firewall, and inspected in line with Contoso policies.
- From the Contoso datacenter:
  - Incoming traffic over site-to-site VPN or ExpressRoute hits the public IP address of the Azure VPN gateway.
  - Traffic is routed through the firewall and subject to firewall rules.
  - After applying firewall rules, traffic is forwarded to an internal load balancer (Standard SKU) on the trusted internal zone subnet.
  - Outbound traffic from the trusted subnet to the on-premises datacenter over VPN is routed through the firewall, and rules applied, before going over the VPN site-to-site connection.

### Design and set up Azure networks

With a network and routing topology in place, Contoso is ready to set up Azure networks and subnets.

- Contoso will implement a Class A private network in Azure (`10.0.0.0/8`). This works, since on-premises it currently has a Class B private address space (`172.160.0.0/16`), so Contoso can be sure there won't be any overlap between address ranges.
- Contoso will deploy VNets in both the primary and secondary regions.
- Contoso will use a naming convention that includes the prefix `VNET` and the region abbreviation `EUS2` or `CUS`. Using this standard, the hub networks will be named `VNET-HUB-EUS2` (in the `East US 2` region), and `VNET-HUB-CUS` (in the `Central US` region).

#### Virtual networks in `East US 2`

`East US 2` is the primary region that Contoso will use to deploy resources and services. Here's how Contoso will design networks in that region:

- **Hub:** The hub VNet in `East US 2` is considered their primary connectivity to the on-premises datacenter.
- **Virtual networks:** The spoke VNets in `East US 2` can be used to isolate workloads if necessary. In addition to the Hub VNet, Contoso will have two spoke VNets in `East US 2`:
  - `VNET-DEV-EUS2`. This VNet will provide the development and test team with a fully functional network for dev projects. It will act as a production pilot area, and will rely on the production infrastructure to function.
    - `VNET-PROD-EUS2`. Azure IaaS production components will be located in this network.
  - Each VNet will have its own unique address space, with no overlap. Contoso intend to configure routing without requiring NAT.
- **Subnets:**
  - There will be a subnet in each network for each app tier.
  - Each subnet in the Production network will have a matching subnet in the Development VNet.
  - In addition, the Production network has a subnet for domain controllers.

VNets in `East US 2` are summarized in the following table.

| **VNet** | **Range** | **Peer** |
| --- | --- | --- |
| `VNET-HUB-EUS2` | `10.240.0.0/20` | `VNET-HUB-CUS2`, `VNET-DEV-EUS2`, `VNET-PROD-EUS2` |
| `VNET-DEV-EUS2` | `10.245.16.0/20` | `VNET-HUB-EUS2` |
| `VNET-PROD-EUS2` | `10.245.32.0/20` | `VNET-HUB-EUS2`, `VNET-PROD-CUS` |

![Hub and spoke model in the primary region](./media/contoso-migration-infrastructure/primary-hub-peer.png)

#### Subnets in the `East US 2 Hub` network (`VNET-HUB-EUS2`)

| Subnet/zone | CIDR | Usable IP addresses |
| --- | --- | --- |
| `IB-UntrustZone` | `10.240.0.0/24`  | 251 |
| `IB-TrustZone`   | `10.240.1.0/24`  | 251 |
| `OB-UntrustZone` | `10.240.2.0/24`  | 251 |
| `OB-TrustZone`   | `10.240.3.0/24`  | 251 |
| `GatewaySubnets` | `10.240.10.0/24` | 251 |

#### Subnets in the `East US 2` development network (`VNET-DEV-EUS2`)

The Development VNet is used by the development team as a production pilot area. It has three subnets.

| Subnet | CIDR | Addresses | In subnet |
| --- | --- | --- | --- |
| `DEV-FE-EUS2` | `10.245.16.0/22` | 1019 | Front-ends/web-tier VMs |
| `DEV-APP-EUS2` | `10.245.20.0/22` | 1019 | App-tier VMs |
| `DEV-DB-EUS2` | `10.245.24.0/23` | 507 | Database VMs |

#### Subnets in the `East US 2` Production network (`VNET-PROD-EUS2`)

Azure IaaS components are located in the Production network. Each app tier has its own subnet. Subnets match those in the Development network, with the addition of a subnet for domain controllers.

| Subnet | CIDR | Addresses | In subnet |
| --- | --- | --- | --- |
| `PROD-FE-EUS2` | `10.245.32.0/22` | 1019 | Front-ends/web tier VMs |
| `PROD-APP-EUS2` | `10.245.36.0/22` | 1019 | App-tier VMs |
| `PROD-DB-EUS2` | `10.245.40.0/23` | 507 | Database VMs |
| `PROD-DC-EUS2` | `10.245.42.0/24` | 251 | Domain controller VMs |

![Hub network architecture](./media/contoso-migration-infrastructure/azure-networks-eus2.png)

#### Virtual networks in `Central US` (secondary region)

`Central US` is Contoso's secondary region. Here's how Contoso will architect networks within it:

- **Hub:** The hub VNet in `Central US` is considered their secondary point of connectivity to the on-premises datacenter, and the spoke VNets in `Central US` can be used to isolate workloads if necessary, managed separately from other spokes.
- **VNets:** Contoso will have two VNets in `Central US`:
  - `VNET-PROD-CUS`: This VNet is a production network and can be thought of as a secondary hub.
  - `VNET-ASR-CUS`: This VNet will act as a location in which VMs are created after failover from on-premises, or as a location for Azure VMs that are failed over from the primary to the secondary region. This network is similar to the production networks, but without any domain controllers on it.
  - Each VNet in the region will have its own address space, with no overlap. Contoso will configure routing without NAT.
- **Subnets:** The subnets will be designed in a similar way to those in `East US 2`.

The VNets in `Central US` are summarized in the following table.

| VNet | Range | Peer |
| --- | --- | --- |
| **VNET-HUB-CUS** | 10.250.0.0/20 | VNET-HUB-EUS2, VNET-ASR-CUS, VNET-PROD-CUS |
| **VNET-ASR-CUS** | 10.255.16.0/20 | VNET-HUB-CUS, VNET-PROD-CUS |
| **VNET-PROD-CUS** | 10.255.32.0/20 | VNET-HUB-CUS, VNET-ASR-CUS, VNET-PROD-EUS2 |

![Hub and spoke model in paired region](./media/contoso-migration-infrastructure/paired-hub-peer.png)

#### Subnets in the Central US Hub network (VNET-HUB-CUS)

**Subnet** | **CIDR** | **Usable IP addresses**
--- | --- | ---
**IB-UntrustZone** | 10.250.0.0/24 | 251
**IB-TrustZone** | 10.250.1.0/24 | 251
**OB-UntrustZone** | 10.250.2.0/24 | 251
**OB-TrustZone** | 10.250.3.0/24 | 251
**GatewaySubnet** | 10.250.2.0/24 | 251

#### Subnets in the Central US Production network (VNET-PROD-CUS)

In parallel with the production network in the primary East US 2 region, there's a production network in the secondary Central US region.

| **Subnet** | **CIDR** | **Addresses** | **In subnet** |
| --- | --- | --- | --- |
| **PROD-FE-CUS** | 10.255.32.0/22 | 1019 | Front-ends/web-tier VMs |
| **PROD-APP-CUS** | 10.255.36.0/22 | 1019 | App-tier VMs |
| **PROD-DB-CUS** | 10.255.40.0/23 | 507 | Database VMs |
| **PROD-DC-CUS** | 10.255.42.0/24 | 251 | Domain controller VMs |

#### Subnets in the Central US failover/recovery network in Central US (VNET-ASR-CUS)

The VNET-ASR-CUS network is used for purposes of failover between regions. Site Recovery will be used to replicate and fail over Azure VMs between the regions. It also functions as a Contoso datacenter to Azure network for protected workloads that remain on-premises, but fail over to Azure for disaster recovery.

VNET-ASR-CUS is the same basic subnet as the production VNet in East US 2, but without the need for a domain controller subnet.

| **Subnet** | **CIDR** | **Addresses** | **In subnet** |
| --- | --- | --- | --- |
| **ASR-FE-CUS** | 10.255.16.0/22 | 1019 | Front-ends/web-tier VMs |
| **ASR-APP-CUS** | 10.255.20.0/22 | 1019 | App-tier VMs |
| **ASR-DB-CUS** | 10.255.24.0/23 | 507 | Database VMs |

![Hub network architecture](./media/contoso-migration-infrastructure/azure-networks-cus.png)

#### Configure peered connections

The hub in each region will be peered to the hub in the other region, and to all VNets within the hub region. This allows for hubs to communicate, and to view all VNets within a region. Note that:

- Peering creates a two-sided connection. One from the initiating peer on the first VNet, and another one on the second VNet.
- In a hybrid deployment, traffic that passes between peers needs to be visible from the VPN connection between the on-premises datacenter and Azure. To enable this, there are some specific settings that must be set on peered connections.

For any connections from spoke VNets through the hub to the on-premises datacenter, Contoso needs to allow traffic to be forwarded, and transverse the VPN gateways.

##### Domain controller

For the domain controllers in the VNET-PROD-EUS2 network, Contoso wants traffic to flow both between the EUS2 hub/production network, and over the VPN connection to on-premises. To do this, Contoso admins must allow the following:

1. **Allow forwarded traffic** and **Allow gateway transit configurations** on the peered connection. In our example, this would be the VNET-HUB-EUS2 to VNET-PROD-EUS2 connection.

    ![Peering](./media/contoso-migration-infrastructure/peering1.png)

2. **Allow forwarded traffic** and **Use remote gateways** on the other side of the peering, on the VNET-PROD-EUS2 to VNET-HUB-EUS2 connection.

    ![Peering](./media/contoso-migration-infrastructure/peering2.png)

3. On-premises they'll set up a static route that directs the local traffic to route across the VPN tunnel to the VNet. The configuration would be completed on the gateway that provides the VPN tunnel from Contoso to Azure. They use RRAS for this.

    ![Peering](./media/contoso-migration-infrastructure/peering3.png)

##### Production networks

A spoked peer network can't see a spoked peer network in another region via a hub.

For Contoso's production networks in both regions to see each other, Contoso admins need to create a direct peered connection for VNET-PROD-EUS2 and VENT-PROD-CUS.

![Peering](./media/contoso-migration-infrastructure/peering4.png)

### Set up DNS

When you deploy resources in virtual networks, you have a couple of choices for domain name resolution. You can use name resolution provided by Azure, or provide DNS servers for resolution. The type of name resolution you use depends on how your resources need to communicate with each other. Get [more information](https://docs.microsoft.com/azure/virtual-network/virtual-networks-name-resolution-for-vms-and-role-instances#azure-provided-name-resolution) about the Azure DNS service.

Contoso admins have decided that the Azure DNS service isn't a good choice in the hybrid environment. Instead, they will use the on-premises DNS servers.

<!-- docsTest:ignore "on premises" -->

- Since this is a hybrid network, all the VMs on premises and in Azure need to be able to resolve names to function properly. This means that custom DNS settings must be applied to all the VNets.
- Contoso currently has DCs deployed in the Contoso datacenter and at the branch offices. The primary DNS servers are CONTOSODC1 (172.16.0.10) and CONTOSODC2 (172.16.0.1).
- Once the VNets are deployed, the on-premises domain controllers are configured as DNS servers in the networks.
- If an optional custom DNS is specified for the virtual network, the virtual IP address `168.63.129.16` for the recursive resolvers in Azure must be added to the list. To do this, Contoso configures DNS server settings on each VNet. For example, the custom DNS settings for the VNET-HUB-EUS2 network would be as follows:

    ![Custom DNS](./media/contoso-migration-infrastructure/custom-dns.png)

In addition to the on-premises domain controllers, Contoso will implement four more domain controllers to support the Azure networks, two for each region. Here's what Contoso will deploy in Azure.

| Region | DC | VNet | Subnet | IP address |
| --- | --- | --- | --- | --- |
| EUS2 | CONTOSODC3 | VNET-PROD-EUS2 | PROD-DC-EUS2 | 10.245.42.4 |
| EUS2 | CONTOSODC4 | VNET-PROD-EUS2 | PROD-DC-EUS2 | 10.245.42.5 |
| CUS | CONTOSODC5 | VNET-PROD-CUS | PROD-DC-CUS | 10.255.42.4 |
| CUS | CONTOSODC6 | VNET-PROD-CUS | PROD-DC-CUS | 10.255.42.4 |

After deploying the on-premises domain controllers, Contoso needs to update the DNS settings on networks on either region to include the new domain controllers in the DNS server list.

#### Set up domain controllers in Azure

After updating network settings, Contoso admins are ready to build out the domain controllers in Azure.

1. In the Azure portal, they deploy a new Windows Server VM to the appropriate VNet.
2. They [create availability sets](https://docs.microsoft.com/azure/virtual-machines/windows/tutorial-availability-sets) in each location for the VM. Availability sets do the following:

    - Ensure that the Azure fabric separates the VMs into different infrastructures in the Azure Region.
    - Allows Contoso to be eligible for the 99.95% SLA for VMs in Azure.

    ![Availability group](./media/contoso-migration-infrastructure/availability-group.png)

3. After the VM is deployed, they open the network interface for the VM. They set the private IP address to static, and specify a valid address.

    ![VM NIC](./media/contoso-migration-infrastructure/vm-nic.png)

4. Now, they attach a new data disk to the VM. This disk contains the Active Directory database, and the sysvol share.
    - The size of the disk will determine the number of IOPS that it supports.
    - Over time the disk size might need to increase as the environment grows.
    - The drive shouldn't be set to Read/Write for host caching. Active Directory databases don't support this.

     ![Active Directory disk](./media/contoso-migration-infrastructure/ad-disk.png)

5. After the disk is added, they connect to the VM over Remote Desktop, and open Server Manager.

6. Then in **File and Storage Services**, they run the New Volume Wizard, ensuring that the drive is given the letter F: or above on the local VM.

     ![New Volume Wizard](./media/contoso-migration-infrastructure/volume-wizard.png)

7. In Server Manager, they add the **Active Directory Domain Services** role. Then, they configure the VM as a domain controller.

      ![Server role](./media/contoso-migration-infrastructure/server-role.png)

8. After the VM is configured as a DC and rebooted, they open DNS Manager and configure the Azure DNS resolver as a forwarder. This allows the DC to forward DNS queries it can't resolve in the Azure DNS.

    ![DNS forwarder](./media/contoso-migration-infrastructure/dns-forwarder.png)

9. Now, they update the custom DNS settings for each VNet with the appropriate domain controller for the VNet region. They include on-premises DCs in the list.

### Set up Active Directory

Active Directory is a critical service in networking, and must be configured correctly. Contoso admins will build Active Directory sites for the Contoso datacenter, and for the EUS2 and CUS regions.

1. They create two new sites (`AZURE-EUS2`, and `AZURE-CUS`) along with the datacenter site (`ContosoDatacenter`).
2. After creating the sites, they create subnets in the sites, to match the VNets and datacenter.

    ![DC subnets](./media/contoso-migration-infrastructure/dc-subnets.png)

3. Then, they create two site links to connect everything. The domain controllers should then be moved to their location.

    ![DC links](./media/contoso-migration-infrastructure/dc-links.png)

4. After everything is configured, the Active Directory replication topology is in place.

    ![DC replication](./media/contoso-migration-infrastructure/ad-resolution.png)

5. With everything complete, a list of the domain controllers and sites is shown in the on-premises Active Directory Administrative Center.

    ![Active Directory Administrative Center](./media/contoso-migration-infrastructure/ad-center.png)

## Step 5: Plan for governance

Azure provides a range of governance controls across services and the Azure platform. For more information, see the [Azure governance options](https://docs.microsoft.com/azure/security/governance-in-azure).

As they configure identity and access control, Contoso has already begun to put some aspects of governance and security in place. Broadly, there are three areas it needs to consider:

- **Policy:** Azure Policy applies and enforces rules and effects over your resources, so that resources stay compliant with corporate requirements and SLAs.
- **Locks:** Azure allows you to lock subscriptions, resources groups, and other resources, so that they can be modified only by those with authority to do so.
- **Tags:** Resources can be controlled, audited, and managed with tags. Tags attach metadata to resources, providing information about resources or owners.

### Set up policies

The Azure Policy service evaluates your resources, scanning for those not compliant with the policy definitions you have in place. For example, you might have a policy that only allows certain types of VMs, or requires resources to have a specific tag.

Policies specify a policy definition, and a policy assignment specifies the scope in which a policy should be applied. The scope can range from a management group to a resource group. [Learn](https://docs.microsoft.com/azure/governance/policy/tutorials/create-and-manage) about creating and managing policies.

Contoso wants to begin a couple of policies:

- It wants a policy to ensure that resources can be deployed in the EUS2 and CUS regions only.
- It wants to limit VM SKUs to approved SKUs only. The intention is to ensure that expensive VM SKUs aren't used.

#### Limit resources to regions

Contoso uses the built-in policy definition **Allowed locations** to limit resource regions.

1. In the Azure portal, select **All services**, and search for **Policy**.
2. Select **Assignments** > **Assign policy**.
3. In the policy list, select **Allowed locations**.
4. Set **Scope** to the name of the Azure subscription, and select the two regions in the allowed list.

    ![Policy allowed regions](./media/contoso-migration-infrastructure/policy-region.png)

5. By default the policy is set with **Deny**, meaning that if someone starts a deployment in the subscription that isn't in EUS2 or CUS, the deployment will fail. Here's what happens if someone in the Contoso subscription tries to set up a deployment in West US.

    ![Policy failed](./media/contoso-migration-infrastructure/policy-failed.png)

#### Allow specific VM SKUs

Contoso will use the built-in policy definition `Allow virtual machine SKUs` to limit the types of VMs that can be created in the subscription.

![Policy SKU](./media/contoso-migration-infrastructure/policy-sku.png)

#### Check policy compliance

Policies go into effect immediately, and Contoso can check resources for compliance.

1. In the Azure portal, select the **Compliance** link.
2. The compliance dashboard appears. You can drill down for further details.

    ![Policy compliance](./media/contoso-migration-infrastructure/policy-compliance.png)

### Set up locks

Contoso has long been using the ITIL framework for the management of its systems. One of the most important aspects of the framework is change control, and Contoso wants to make sure that change control is implemented in the Azure deployment.

Contoso will [lock resources](https://docs.microsoft.com/azure/azure-resource-manager/resource-group-lock-resources) as follows:

- Any production or failover component must be in a resource group that has a ReadOnly lock. This means that to modify or delete production items, the lock must be removed.
- Nonproduction resource groups will have CanNotDelete locks. This means that authorized users can read or modify a resource, but cannot delete it.

### Set up tagging

To track resources as they're added, it will be increasingly important for Contoso to associate resources with an appropriate department, customer, and environment.

In addition to providing information about resources and owners, tags will enable Contoso to aggregate and group resources, and to use that data for chargeback purposes.

Contoso needs to visualize its Azure assets in a way that makes sense for the business, such as by role or department. Note that resources don't need to reside in the same resource group to share a tag. Contoso will create a tag taxonomy so that everyone uses the same tags.

| **Tag name** | **Value** |
| --- | --- |
| `CostCenter` | 12345: It must be a valid cost center from SAP. |
| `BusinessUnit` | Name of business unit (from SAP). Matches `CostCenter`. |
| `ApplicationTeam` | Email alias of the team that owns support for the app. |
| `CatalogName` | Name of the app or `ShareServices`, per the service catalog that the resource supports. |
| `ServiceManager` | Email alias of the ITIL Service Manager for the resource. |
| `COBPriority` | Priority set by the business for BCDR. Values of 1-5. |
| `ENV` | `DEV`, `STG`, and `PROD` are the allowed values, representing development, staging, and production. |

For example:

 ![Azure tags](./media/contoso-migration-infrastructure/azure-tag.png)

After creating the tag, Contoso will go back and create new policy definitions and assignments, to enforce the use of the required tags across the organization.

## Step 6: Consider security

Security is crucial in the cloud, and Azure provides a wide array of security tools and capabilities. These help you to create secure solutions, on the secure Azure platform. Read [Confidence in the trusted cloud](https://azure.microsoft.com/overview/trusted-cloud) to learn more about Azure security.

There are a few aspects for Contoso to consider:

- **Azure Security Center:** [Azure Security Center](https://docs.microsoft.com/azure/security-center/security-center-intro) provides unified security management and advanced threat protection across hybrid cloud workloads. Use it to apply security policies across your workloads, limit your exposure to threats, and detect and respond to attacks.
- **Network security groups:** A [network security group (NSG)](https://docs.microsoft.com/azure/virtual-network/security-overview) filters network traffic based on a list of security rules allowing or denying network traffic to resources connected to Azure VNets.
- **Data encryption:** [Azure Disk Encryption](https://docs.microsoft.com/azure/security/fundamentals/encryption-atrest) is a capability that helps you encrypt your Windows and Linux IaaS virtual machine disks.

### Work with the Azure Security Center

Contoso is looking for a quick view into the security posture of its new hybrid cloud, and specifically its Azure workloads. As a result, Contoso has decided to implement Azure Security Center starting with the following features:

- Centralized policy management.
- Continuous assessment.
- Actionable recommendations.

#### Centralize policy management

With centralized policy management, Contoso will ensure compliance with security requirements by centrally managing security policies across the entire environment. It can simply and quickly implement a policy that applies to all of its Azure resources.

![Security policy](./media/contoso-migration-infrastructure/security-policy.png)

#### Assess and action

Contoso will take advantage of the continuous security assessment that monitors the security of machines, networks, storage, data, and applications; to discover potential security issues.

- Security Center analyzes the security state of the Contoso compute, infrastructure, and data resources, and of Azure apps and services.
- Continuous assessment helps the Contoso operations team to discover potential security issues, such as systems with missing security updates or exposed network ports.
- In particular Contoso wants to make sure all of the VMs are protected. Security Center helps with this, verifying VM health, and making prioritized and actionable recommendations to remediate security vulnerabilities before they're exploited.

![Monitoring](./media/contoso-migration-infrastructure/monitoring.png)

### Work with NSGs

Contoso can limit network traffic to resources in a virtual network using network security groups.

- A network security group contains a list of security rules that allow or deny inbound or outbound network traffic based on source or destination IP address, port, and protocol.
- When applied to a subnet, rules are applied to all resources in the subnet. In addition to network interfaces, this includes instances of Azure services deployed in the subnet.
- Application security groups (ASGs) enable you to configure network security as a natural extension of an app structure, allowing you to group VMs and define network security policies based on those groups.
  - Application security groups mean that Contoso can reuse the security policy at scale, without manual maintenance of explicit IP addresses. The platform handles the complexity of explicit IP addresses and multiple rule sets, allowing you to focus on your business logic.
  - Contoso can specify an application security group as the source and destination in a security rule. After a security policy is defined, Contoso can create VMs, and assign the VM NICs to a group.

Contoso will implement a mix of NSGs and ASGs. Contoso is concerned about NSG management. It's also worried about the overuse of NSGs, and the added complexity for operations staff. Here's what Contoso will do:

- All traffic into and out of all subnets (north-south), will be subject to an NSG rule, except for the GatewaySubnets in the Hub networks.
- Any firewalls or domain controller will be protected by both subnet NSGs and NIC NSGs.
- All production applications will have ASGs applied.

Contoso has built a model of how this will look for its applications.

![Security](./media/contoso-migration-infrastructure/asg.png)

The NSGs associated with the ASGs will be configured with least privilege to ensure that only allowed packets can flow from one part of the network to its destination.

| Action | Name | Source | Target | Port |
| --- | --- | --- | --- | --- |
| `Allow` | `AllowInternetToFE` | `VNET-HUB-EUS1`/`IB-TrustZone` | `APP1-FE` | 80, 443 |
| `Allow` | `AllowWebToApp` | `APP1-FE` | `APP1-APP` | 80, 443 |
| `Allow` | `AllowAppToDB` | `APP1-APP` | `APP1-DB` | 1433 |
| `Deny`  | `DenyAllInbound` | Any | Any | Any |

### Encrypt data

Azure Disk Encryption integrates with Azure Key Vault to help control and manage the disk-encryption keys and secrets in a Key Vault subscription. It ensures that all data on VM disks are encrypted at rest in Azure storage.

- Contoso has determined that specific VMs require encryption.
- Contoso will apply encryption to VMs with customer, confidential, or PPI data.

## Conclusion

In this article, Contoso set up an Azure infrastructure and policy for Azure subscription, hybrid identify, disaster recovery, networking, governance, and security.

Not every step taken here is required for a cloud migration. In this case, Contoso planned a network infrastructure that could handle all types of migrations while being secure, resilient, and scalable.

With this infrastructure, Contoso is ready to move on and try out migration.

## Next steps

After setting up their Azure infrastructure, Contoso is ready to begin migrating workloads to the cloud. See the [migration patterns and examples overview](./contoso-migration-overview.md#windows-server-workloads) section for a selection of scenarios using this sample infrastructure as a migration target.
