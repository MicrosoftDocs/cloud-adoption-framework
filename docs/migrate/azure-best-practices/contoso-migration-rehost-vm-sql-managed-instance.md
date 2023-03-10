---
title: Rehost an on-premises application by migrating to Azure VMs and Azure SQL Managed Instance
description: Learn how Contoso rehosts an on-premises application on Azure VMs by using Azure SQL Managed Instance.
author: givenscj
ms.author: martinek
ms.date: 07/01/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
ms.custom: think-tank
---

# Rehost an on-premises application by migrating to Azure VMs and Azure SQL Managed Instance

This article shows how the fictional company Contoso migrates a two-tier, front-end application based on Windows .NET from VMware virtual machines (VMs) to an Azure VM by using Azure Migrate. The article also shows how Contoso migrates the application database to Azure SQL Managed Instance. This migration follows the preparations that are described in [Deploy a migration infrastructure](./contoso-migration-infrastructure.md).

SmartHotel360, the application in this example, is open-source software. If you want to use it for your own testing purposes, download it from [GitHub](https://github.com/Microsoft/SmartHotel360).

> [!NOTE]
> The example application in this article, SmartHotel360, is archived but remains available on GitHub for reference.

## Business drivers

Contoso's IT leadership team works closely with the company's business partners to understand what they want this migration to achieve. They want it to accomplish the following goals:

- **Address business growth.** Contoso is growing. As a result, pressure has increased on the company's on-premises systems and infrastructure.

- **Increase efficiency.** Contoso needs to remove unnecessary procedures and streamline processes for its developers and users. For the company to deliver quickly on customer requirements, its IT team must be fast and not waste time or money.

- **Increase agility.** IT must be more responsive to the needs of the business. To be successful in the global economy, Contoso must react faster than the changes that occur in the marketplace. IT at Contoso must not get in the way or become a business blocker.

- **Scale.** As the company's business grows successfully, the IT team must provide systems that can grow at the same pace.

## Migration goals

Contoso uses migration goals to determine the best methods of migration. Contoso's cloud team identified goals for this migration:

- **Equal application performance.** After migration, the application in Azure should have the same performance capabilities that the application has today in Contoso's on-premises VMware environment. Migrating the application to the cloud doesn't mean that performance is less critical.

- **No application development.** Contoso doesn't want to invest in the application. The application is critical and important to the business, but they simply want to move it to the cloud in its current form.

- **Minimal administration.** Database administration tasks are minimized after the application is migrated.

- **Avoid Azure SQL Database.** Contoso doesn't want to use Azure SQL Database for this application and is looking for alternatives.

## Solution design

After clarifying the company's goals and requirements, Contoso designs and reviews a deployment solution. Contoso also identifies the migration process and which Azure services to use.

### Current architecture

- Contoso has one main datacenter, `contoso-datacenter`, which is located in New York City. It has a fiber-optic connection to the internet from Metro Ethernet Networks that provides 500 megabits per second. The main datacenter is fully virtualized by VMware products. Contoso has two VMware hosts running ESXi 6.5 that are managed by vCenter Server 6.5.

- Contoso has three branches across the United States. Each branch is connected locally to the internet by using business-class connections, and each branch is connected to the main datacenter via VPN with IPsec. This configuration allows Contoso's entire network to always be connected, and it optimizes internet connectivity. 

- Contoso uses DNS servers on its internal network.

- Contoso uses Active Directory for identity management.

- Contoso has an on-premises domain controller, `contosodc1`. The domain controllers at local branches run on physical servers. The domain controllers run on VMware VMs. The VMware environment is managed by vCenter Server 6.5, `vcenter.contoso.com`, running on a VM.

- SmartHotel360 is tiered across two VMs, `WEBVM` and `SQLVM`, that are located on a VMware host running ESXi version 6.5, `contosohost1.contoso.com`.

:::image type="content" alt-text="Diagram of the current Contoso architecture." source="./media/contoso-migration-rehost-vm-sql-managed-instance/contoso-architecture.png":::

### Proposed architecture

In this scenario, Contoso migrates its two-tier, on-premises travel application as follows:

- Migrate the application database, `SmartHotelDB`, to a SQL Managed Instance.
- Migrate the front end, `WEBVM`, to an Azure VM.
- Decommission the on-premises VMs in the Contoso datacenter after migration is complete.

:::image type="content" border="false" alt-text="Diagram of the scenario architecture." source="./media/contoso-migration-rehost-vm-sql-managed-instance/architecture.png":::

### Database considerations

As part of designing the solution, Contoso compares features between Azure SQL Database and SQL Managed Instance. The company chooses SQL Managed Instances due to the following considerations:

- **Compatibility with existing software.**

  - SQL Managed Instance aims to deliver almost 100% compatibility with the latest on-premises version of SQL Server. We recommend SQL Managed Instance for customers who run SQL Server on-premises or on infrastructure as a service (IaaS) VMs and who want to migrate their applications to a fully managed service with minimal design changes. For more information, see [What is Azure SQL Managed Instance?](/azure/azure-sql/managed-instance/sql-managed-instance-paas-overview)

  - Contoso plans to migrate a large number of applications from on-premises to IaaS. Many of these applications are provided by an ISV. Contoso realizes that using SQL Managed Instance helps to ensure database compatibility for these applications. In contrast, SQL Database might not be supported.

  - SQL Managed Instance supports SQL Server Agent, which is an important component of SmartHotel360. Without this compatibility, Contoso would have to redesign the maintenance plans that the application requires.

- **License exchange.** With Software Assurance, Contoso can exchange its existing licenses for discounted rates on a SQL managed instance by using the [Azure Hybrid Benefit for SQL Server](/azure/azure-sql/azure-hybrid-benefit?view=azuresql-mi&tabs=azure-portal). For this reason, Contoso can save up to 30 percent on SQL Managed Instance.

- **Security technology and network isolation.**

  - SQL Managed Instance supports many security features, which include Always Encrypted, dynamic data masking, row-level security, and threat detection.

  - SQL Managed Instance is fully contained in the virtual network, which provides greater isolation and security for Contoso's data. Contoso can get the benefits of the public cloud while keeping the environment isolated from the public internet.

- **Automated migration.** Contoso can migrate to SQL Managed Instance by using the fully automated Azure Database Migration Service. With this service in place, Contoso can reuse it for future database migrations.



### Solution review

Contoso evaluates the proposed design by putting together a list of pros and cons.

| Consideration | Details |
| --- | --- |
| **Pros** | Contoso can move `WEBVM` to Azure without changes, which makes the migration simple. <br><br> SQL Managed Instance supports Contoso's technical requirements and goals. <br><br> SQL Managed Instance provides 100 percent compatibility with Contoso's current deployment while moving the company away from using SQL Server 2008 R2. <br><br> Contoso can take advantage of its investment in Software Assurance and use the Azure Hybrid Benefit for SQL Server and Windows Server. <br><br> Contoso can reuse Azure Database Migration Service for additional future migrations. <br><br> SQL Managed Instance has built-in fault tolerance that Contoso doesn't need to configure. This feature ensures that the data tier is no longer a single point of failure. |
| **Cons** | `WEBVM` runs Windows Server 2008 R2. Although Azure supports this operating system, it's no longer a supported platform. To learn more, see [Support policy for Microsoft SQL Server products](/troubleshoot/sql/general/support-policy-hardware-virtualization-product). <br><br> The web tier remains a single point of failover with only `WEBVM` providing services. <br><br> Contoso must continue to support the application web tier as a VM rather than moving to a managed service, such as Azure App Service. <br><br> For the data tier, SQL Managed Instance might not be the best solution if Contoso wants to customize the operating system or the database server, or if the company wants to run third-party applications along with SQL Server. Running SQL Server on an IaaS VM could provide this flexibility. |

### Migration process

Contoso migrates the web and data tiers of its application, SmartHotel360, to Azure by completing these steps:

1. Add a couple of specific components to the Azure infrastructure that Contoso previously configured (as described in [Deploy a migration infrastructure](./contoso-migration-infrastructure.md)). Much of the infrastructure that's required for this migration is already in place.

1. Migrate the data tier by using Azure Database Migration Service. This service connects to the on-premises VM that runs SQL Server via a site-to-site VPN connection between the Contoso datacenter and Azure. The service then migrates the database.

1. Migrate the web tier by using Azure Migrate. The process requires preparing the on-premises VMware environment, configuring and enabling replication, and then migrating the VMs by having them fail over to Azure.

   :::image type="content" alt-text="Diagram of the migration architecture." source="./media/contoso-migration-rehost-vm-sql-managed-instance/migration-architecture.png":::

### Azure services

| Service | Description | Cost |
| --- | --- | --- |
| [Azure Database Migration Service](/azure/dms/dms-overview) | Azure Database Migration Service enables seamless migration from multiple database sources to Azure data platforms with minimal downtime. | Learn about [supported regions](/azure/dms/dms-overview#regional-availability) and [Azure Database Migration Service pricing](https://azure.microsoft.com/pricing/details/database-migration/). |
| [Azure SQL Managed Instance](/azure/azure-sql/managed-instance/sql-managed-instance-paas-overview) | SQL Managed Instance is a managed database service that represents a fully managed SQL Server instance in the Azure cloud. It uses the same code as the latest version of SQL Server Database Engine and has the latest features, performance improvements, and security patches. | Using a SQL managed instance running in Azure incurs charges based on capacity. Learn more about [SQL Managed Instance pricing](https://azure.microsoft.com/pricing/details/azure-sql-managed-instance/single/). |
| [Azure Migrate](/azure/migrate/migrate-services-overview) | Contoso uses Azure Migrate to assess its VMware VMs. Azure Migrate assesses the migration suitability of the machines. It provides sizing and cost estimates for running in Azure. | Azure Migrate is available at no additional charge. They might incur charges depending on the tools (first-party or independent software vendor) they decide to use for assessment and migration. Learn more about [Azure Migrate pricing](https://azure.microsoft.com/pricing/details/azure-migrate/). |

## Prerequisites

Contoso and other users must meet the following prerequisites for this scenario.

| Requirements | Details |
| --- | --- |
| **Azure subscription** | Contoso created a subscription in the first article in this series. If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/free/). <br><br> If you create a free account, you're the administrator of your subscription and can perform all actions. <br><br> If you use an existing subscription and you're not the administrator of the subscription, work with the administrator to assign your Owner or Contributor permissions to the necessary resource groups and resources. |
| **Azure infrastructure** | Contoso set up its Azure infrastructure as described in [Azure infrastructure for migration](./contoso-migration-infrastructure.md). |
| **On-premises servers** | The on-premises vCenter Server should be running version 5.5, 6.0, or 6.5. <br><br> An ESXi host should be running version 5.5, 6.0, or 6.5. <br><br> The ESXi host should run one or more VMware VMs. |
| **On-premises VMs** | [Review Linux machines](/azure/virtual-machines/linux/endorsed-distros) that are endorsed to run on Azure. |
| **Database Migration Service** | For Azure Database Migration Service, you need a [compatible on-premises VPN device](/azure/vpn-gateway/vpn-gateway-about-vpn-devices). <br><br> You must be able to configure the on-premises VPN device. It must have an externally facing public IPv4 address. The address can't be located behind a NAT device. <br><br> Make sure that you can access your on-premises SQL Server database. <br><br> Windows Firewall should be able to access the source database engine. For more information, see [Configure a Windows Firewall for Database Engine Access](/sql/database-engine/configure-windows/configure-a-windows-firewall-for-database-engine-access). <br><br> If there's a firewall in front of your database machine, add rules to allow access to the database and files via SMB port 445. <br><br> The credentials for connecting to the source instance of SQL Server and for the targeted SQL Managed Instance must be members of the *sysadmin* server role. <br><br> You need a network share in your on-premises database that Azure Database Migration Service can use to back up the source database. <br><br> Make sure that the service account that runs the source instance of SQL Server has write permissions on the network share. <br><br> Make a note of a Windows user and password that has full-control permissions on the network share. Azure Database Migration Service impersonates these user credentials to upload back-up files to the Azure Storage container. <br><br> The installation process for SQL Server Express sets the TCP/IP protocol to *Disabled* by default. Make sure that it's set to *Enabled*. |

## Scenario steps

Here's how Contoso plans to set up the deployment:

> [!div class="checklist"]
>
> - **Step 1: Prepare a SQL managed instance.** Contoso requires an existing managed instance to which the on-premises SQL Server database migrates.
>
> - **Step 2: Prepare Azure Database Migration Service.** Contoso must register the database migration provider, create an instance, and then create a Database Migration Service project. Contoso also must set up a shared access signature (SAS) uniform resource identifier (URI) for the instance of Database Migration Service. An SAS URI provides delegated access to resources in Contoso's storage account so that Contoso can grant limited permissions to storage objects. Contoso sets up an SAS URI so that Azure Database Migration Service can access the storage account container to which the service uploads the SQL Server backup files.
>
> - **Step 3: Prepare Azure for the Migration and modernization tool.** Contoso adds this tool that's part of Azure Migrate to its Azure Migrate project. Migration and modernization was previously named Azure Migrate: Server Migration.
>
> - **Step 4: Prepare on-premises VMware for the Migration and modernization tool.** Contoso prepares accounts for VM discovery and prepares to connect to Azure VMs after migration.
>
> - **Step 5: Replicate the on-premises VMs.** Contoso sets up replication and starts replicating VMs to Azure Storage.
>
> - **Step 6: Migrate the database via Azure Database Migration Service.** Contoso migrates the database.
>
> - **Step 7: Migrate the VMs with the Migration and modernization tool.** Contoso runs a test migration to make sure everything's working and then runs a full migrate to move the VM to Azure.

## Step 1: Prepare a SQL managed instance

To set up a SQL managed instance, Contoso requires a subnet that meets the following requirements:

- **Connects only the managed instance.** The subnet must be dedicated. It must be empty. It can't contain any other cloud service. The subnet can't be a gateway subnet. After creating the managed instance, Contoso shouldn't add resources to the subnet.

- **Not in a network security group.** The subnet can't have a network security group associated with it.

- **Routes only to the internet.** The subnet must have a user-defined route table. The only route assigned should be `0.0.0.0/0` for next-hop internet.

- **Has no service endpoint.** The subnet must not have a service endpoint associated with it, whether for storage or SQL. Service endpoints should be disabled on the virtual network.

- **Has at least 16 IP addresses.** The subnet must have a minimum of 16 IP addresses. For more information about sizing the subnet for the managed instance, see [Configure an existing virtual network for Azure SQL Managed Instance](/azure/azure-sql/managed-instance/vnet-existing-add-subnet).

- **With custom DNS, includes a specific resolver.** Contoso configures DNS name resolution to use one or more of the company's Azure DNS servers. Because of Contoso's hybrid environment, they must also use custom DNS settings. To use custom DNS, Contoso must add `168.63.129.16`, a virtual IP address, to the list of recursive resolvers in Azure. For more information about custom DNS for a managed instance, see [Resolve private domain names in Azure SQL Managed Instance](/azure/azure-sql/managed-instance/custom-dns-configure).


### Set up a virtual network for the managed instance

To set up the virtual network, the Contoso admins complete the following steps:

1. Create a new virtual network, `VNET-SQLMI-EUS2`, in the primary region, `East US 2`. Contoso adds the virtual network to  `ContosoNetworkingRG`, a resource group.

1. Assign an address space of `10.235.0.0/24`. Contoso verifies that the range doesn't overlap with any other networks in its enterprise.

1. Add two subnets to the network:
    - `SQLMI-DB-EUS2` with an address range of `10.235.0.0/25`.
    - `SQLMI-SAW-EUS2` with an address range of `10.235.0.128/29`. This subnet attaches a directory to the managed instance.

    :::image type="content" alt-text="Screenshot that shows the Create virtual network pane." source="./media/contoso-migration-rehost-vm-sql-managed-instance/mi-vnet.png":::

1. After the virtual network and subnets are deployed, Contoso adds network peering as follows:

    - Peer `VNET-SQLMI-EUS2` with `VNET-HUB-EUS2`, which is the hub virtual network in `East US 2`.
    - Peer `VNET-SQLMI-EUS2` with `VNET-PROD-EUS2`, which is the production network.

    :::image type="content" alt-text="Screenshot that shows the network peering." source="./media/contoso-migration-rehost-vm-sql-managed-instance/mi-peering.png":::

1. Set custom DNS settings. DNS points first to Contoso's domain controllers in Azure. Azure DNS is secondary. The Contoso's domain controllers are configured as follows:

    - Located in the `PROD-DC-EUS2` subnet in `VNET-PROD-EUS2`, which is the production network in `East US 2`.
    - `CONTOSODC3` with the IP address `10.245.42.4`.
    - `CONTOSODC4` address with the IP address `10.245.42.5`.
    - Azure DNS resolver with the IP address `168.63.129.16`.

    :::image type="content" alt-text="Screenshot that shows the network DNS servers." source="./media/contoso-migration-rehost-vm-sql-managed-instance/mi-dns.png":::

**Need more help?**

- [Quickstart: Create a virtual network using the Azure portal](/azure/virtual-network/quick-create-portal)
- [Add, change, or delete a virtual network subnet](/azure/virtual-network/virtual-network-manage-subnet)
- [Create, change, or delete a virtual network peering](/azure/virtual-network/virtual-network-manage-peering)
- [Configure an existing virtual network for Azure SQL Managed Instance](/azure/azure-sql/managed-instance/vnet-existing-add-subnet)
- [Create and configure an Azure Active Directory Domain Services managed domain](/azure/active-directory-domain-services/tutorial-create-instance)

### Set up routing

A private virtual network connects the managed instance. Contoso needs a route table for the virtual network to communicate with the Azure management service. If the virtual network can't communicate with the service that manages it, the virtual network becomes inaccessible.

Contoso considers these factors:

- The route table contains a set of rules (routes) that specify how packets that are sent from the managed instance should be routed in the virtual network.
- Each packet that leaves a subnet follows the route specified by the associated route table.
- A subnet has a single associated route table, but a route table can specify routing for multiple subnets.
- There are no additional charges for creating route tables in Microsoft Azure.

To set up routing, the Contoso admins complete the following steps:

1. Create a user-defined route table, named `MIRouteTable`, that's assigned to `ContosoNetworkingRG`, a resource group.

   :::image type="content" alt-text="Screenshot that shows the route table." source="./media/contoso-migration-rehost-vm-sql-managed-instance/mi-route-table.png":::

1. Add a route that has an address prefix of `0.0.0.0/0`. The **Next hop type** option is set to **Internet**. This configuration meets requirements that pertain to SQL Managed Instance.

   :::image type="content" alt-text="Screenshot that shows the route table prefix." source="./media/contoso-migration-rehost-vm-sql-managed-instance/mi-route-table-prefix.png":::

1. Associate the route table with the `SQLMI-DB-EUS2` subnet in the `VNET-SQLMI-EUS2` network.

   :::image type="content" alt-text="Screenshot that shows the route table subnet." source="./media/contoso-migration-rehost-vm-sql-managed-instance/mi-route-table-subnet.png":::

**Need more help?**

- [Create, change, or delete a route table](/azure/virtual-network/manage-route-table)
- [View and change routes for a managed instance](/azure/azure-sql/managed-instance/instance-create-quickstart#view-and-fine-tune-network-settings)

### Create a managed instance

With the virtual network and the route table in place, the Contoso admins can provision a SQL managed instance by completing the following steps:

1. Because the managed instance serves a business application, they deploy the managed instance in the company's primary region, `East US 2`. They add the managed instance to the `ContosoRG` resource group.

1. They select a pricing tier, compute size, and storage for the instance. For more information about costs, see [SQL Managed Instance pricing](https://azure.microsoft.com/pricing/details/azure-sql-managed-instance/single/).

   :::image type="content" alt-text="Screenshot that shows the SQL Managed Instance pane." source="./media/contoso-migration-rehost-vm-sql-managed-instance/mi-create.png":::

1. With deployment of the managed instance, `ContosoRG` includes two new resources:

    - The SQL managed instance.
    - A virtual cluster that can support multiple managed instances.

    :::image type="content" border="false" alt-text="Screenshot that shows two new resources." source="./media/contoso-migration-rehost-vm-sql-managed-instance/mi-resources.png":::

**Need more help?**

[Quickstart: Create an Azure SQL Managed Instance](/azure/azure-sql/managed-instance/instance-create-quickstart).

## Step 2: Prepare Azure Database Migration Service

To prepare Azure Database Migration Service, the Contoso admins need to complete the following tasks:

- Register the Database Migration Service provider in Azure.

- Grant permission for Database Migration Service to access Azure Storage to upload the backup files that the service uses to migrate a database. To provide access to Azure Storage: 
  - Create an Azure Blob Storage container.
  - Generate an SAS URI for the Blob Storage container.

- Create an Azure Database Migration Service project.

The Contoso admins complete the following steps:

1. Register the database migration provider in Contoso's subscription.

   :::image type="content" alt-text="Screenshot that shows Database Migration Service registration." source="./media/contoso-migration-rehost-vm-sql-managed-instance/dms-subscription.png":::

1. Create an Azure Blob Storage container. Contoso generates an SAS URI so that Azure Database Migration Service can access it.

   :::image type="content" border="false" alt-text="Screenshot that shows generating an SAS URI." source="./media/contoso-migration-rehost-vm-sql-managed-instance/dms-sas.png":::

1. Create an instance of Azure Database Migration Service.

   :::image type="content" border="false" alt-text="Screenshot that shows creating an instance." source="./media/contoso-migration-rehost-vm-sql-managed-instance/dms-instance.png":::

1. Place the Database Migration Service instance in the `PROD-DC-EUS2` subnet of the `VNET-PROD-DC-EUS2` virtual network.
    - The instance must be in `PROD-DC-EUS2` because the service must be in a virtual network that can access the on-premises VM that runs SQL Server via a VPN gateway.
    - `VNET-PROD-EUS2` is peered to `VNET-HUB-EUS2` and has permission to use remote gateways. This permission ensures that the instance can communicate as required. Contoso selects **Use remote gateways** to enable this configuration.

    :::image type="content" border="false" alt-text="Screenshot that shows configuring a network." source="./media/contoso-migration-rehost-vm-sql-managed-instance/dms-network.png":::

**Need more help?**

- [Tutorial: Migrate SQL Server to Azure SQL Managed Instance online in Azure Data Studio](/azure/dms/tutorial-sql-server-managed-instance-online-ads)
- [Quickstart: Create an instance of the Azure Database Migration Service by using the Azure portal](/azure/dms/quickstart-create-data-migration-service-portal)
- [Generate a SAS token](/azure/data-explorer/kusto/api/connection-strings/generate-sas-token)
- [Create a service SAS for a container or blob](/azure/storage/blobs/sas-service-create)
- [Grant limited access to Azure Storage resources using shared access signatures (SAS)](/azure/storage/common/storage-sas-overview)

## Step 3: Prepare Azure for the Migration and modernization tool

To be able to migrate the VMs, Contoso must complete the following tasks:

- Create a virtual network for the Azure VMs that are created during migration.
- Provision the Migration and modernization tool, part of Azure Migrate.

When Contoso prepared for migration to Azure in [Deploy a migration infrastructure](./contoso-migration-infrastructure.md), it set up a network that the Migration and modernization tool can use.

- SmartHotel360 is a production application, and the migration puts the VMs in the Azure production network, `VNET-PROD-EUS2`, in the primary region, `East US 2`.
- `ContosoRG`, a resource group for production resources, includes both VMs.
- The application front-end VM, `WEBVM`, migrates to the front-end subnet, `PROD-FE-EUS2`, of the production network.
- The application database VM, `SQLVM`, migrates to the database subnet, `PROD-DB-EUS2`, of the production network.

## Step 4: Prepare on-premises VMware for the Migration and modernization tool

To migrate the VMs to Azure, Contoso must have the following Azure components:

- A virtual network for the Azure VMs when they're created during migration.
- The Azure Migrate appliance, provisioned and configured.

The Contoso admins set up these components by completing the following steps:

1. When Contoso prepared for migration to Azure in [Deploy a migration infrastructure](./contoso-migration-infrastructure.md), it set up a network that the Migration and modernization tool can use.

    - The SmartHotel360 application is a production application, and in the migration, the VMs move to the Azure production network, `VNET-PROD-EUS2`, in the primary region, `East US 2`.
    - `ContosoRG`, a resource group for production resources, includes both VMs.
    - The application front-end VM, `WEBVM`, migrates to the front-end subnet, `PROD-FE-EUS2`, of the production network.
    - The application database VM, `SQLVM`, migrates to the database subnet, `PROD-DB-EUS2`, of the production network.

1. Provision the Azure Migrate appliance.

    1. From Azure Migrate, download the `.OVA` image file and import it into VMware.

       :::image type="content" alt-text="Screenshot that shows downloading the OVA file." source="./media/contoso-migration-rehost-vm/migration-download-ova.png" lightbox="./media/contoso-migration-rehost-vm/migration-download-ova.png":::

    1. Start the imported image and configure the tool by following these steps:

       1. Set up the prerequisites.

          :::image type="content" alt-text="Screenshot that shows setting up prerequisites." source="./media/contoso-migration-rehost-vm/migration-setup-prerequisites.png":::

       1. Point the tool to the Azure subscription.

          :::image type="content" alt-text="Screenshot that shows selecting the subscription" source="./media/contoso-migration-rehost-vm/migration-register-azure.png":::

       1. Set the VMware vCenter credentials.

          :::image type="content" alt-text="Screenshot that shows setting the VMware vCenter credentials." source="./media/contoso-migration-rehost-vm/migration-vcenter-server.png":::

       1. Add any Linux-based or Windows-based credentials for discovery.

          :::image type="content" alt-text="Screenshot that shows setting Linux and Windows credentials." source="./media/contoso-migration-rehost-vm/migration-credentials.png":::

1. After configuration, the tool takes some time to enumerate all the virtual machines. After the tool completes enumeration, the Contoso admins can see the VMs populated in the Azure Migrate tool in Azure.

**Need more help?**

[Migration and modernization tool](/azure/migrate/migrate-services-overview?branch=main#migration-and-modernization-tool)

### Prepare on-premises VMs

After migration, Contoso wants to connect to the Azure VMs and allow Azure to manage the VMs. The Contoso admins must do the following steps before migration:

1. For access over the internet:

    - Enable RDP or SSH on the on-premises VM before migration.
    - Add TCP and UDP rules for the **Public** profile, if necessary.
    - Check that the operating system's firewall allows RDP or SSH connections.

1. For access over Site-to-Site VPN:

    - Enable RDP or SSH on the on-premises VM before migration.
    - Check that the operating system's firewall allows RDP or SSH connections.
    - For Windows, set the operating system's SAN policy on the on-premises VM to **OnlineAll**.

1. Install the Azure agent:

    - [Azure Linux agent](/azure/virtual-machines/extensions/agent-linux)
    - [Azure Windows agent](/azure/virtual-machines/extensions/agent-windows)

1. Other considerations:

   - For Windows, there should be no pending updates for Windows on the VM when initiating a migration. If there are pending updates, no one is able to sign in to the VM until Windows completes its updates.
   - After migration, an admin can check **boot diagnostics** to view a screenshot of the VM. If this method doesn't work, an admin should verify that the VM is running and review these [troubleshooting tips](https://social.technet.microsoft.com/wiki/contents/articles/31666.troubleshooting-remote-desktop-connection-after-failover-using-asr.aspx).

**Need more help?**

- [Prepare on-premises machines for migration to Azure](/azure/migrate/prepare-for-migration)

## Step 5: Replicate the on-premises VMs

Before the Contoso admins can migrate servers to Azure, they need to set up and enable replication.

With discovery completed, the admins can begin replication of VMware VMs to Azure. They complete the following steps:

1. In the Azure Migrate project, navigate to **Servers** > **Azure Migrate: Server Migration**. Then select **Replicate**.

   :::image type="content" border="false" alt-text="Screenshot that shows the Replicate option." source="./media/contoso-migration-rehost-vm/select-replicate.png":::

1. In **Replicate** > **Source settings** > **Are your machines virtualized?**, select **Yes, with VMware vSphere**.

1. In **On-premises appliance**, select the name of the Azure Migrate appliance that was set up, and then select **OK**.

   :::image type="content" border="false" alt-text="Screenshot that shows the Source settings tab." source="./media/contoso-migration-rehost-vm/source-settings.png":::

1. In **Virtual machines**, select the machines to replicate and choose whether to import migration settings from an assessment. 
    - If the admins ran an assessment for the VMs, they can apply VM sizing and disk type (premium/standard) recommendations from the assessment results. In **Import migration settings from an Azure Migrate assessment?**, select **Yes**.
    - If the admins didn't run an assessment or they don't want to use the assessment settings, select **No**.
    - If the admins choose to use the assessment, select the VM group and assessment name.

    :::image type="content" border="false" alt-text="Screenshot that shows selecting assessments." source="./media/contoso-migration-rehost-vm/select-assessment.png":::

1. In **Virtual machines**, search for VMs as needed and check each VM to migrate. Then select **Next: Target settings**.

1. In **Target settings**, select the subscription and the targeted region that the VMs migrate to. Specify the resource group in which the Azure VMs reside after migration. In **Virtual Network**, select the Azure virtual network/subnet that the Azure VMs join after migration.

1. In **Azure Hybrid Benefit**:

    - Select **No** to apply Azure Hybrid Benefit.
    - Select **Yes** to optionally apply Software Assurance or Windows Server subscriptions to eligible machines running Windows Server.

   Then select **Next**.

1. In **Compute**, review the names, sizes, OS disk types, and availability sets of the VMs. They must conform with Azure requirements. For more information, see VMware requirements in [Support matrix for VMware discovery](/azure/migrate/migrate-support-matrix-vmware#vmware-requirements).

    - **VM size:** When using the recommendations from the assessment results, the list of VM sizes contains the recommended size. Otherwise, Azure Migrate picks a size based on the closest match in the Azure subscription. Alternatively, pick a manual size in **Azure VM size**.
    - **OS disk:** Specify the OS (boot) disk for the VM. The OS disk is the disk that has the operating system bootloader and installer.
    - **Availability set:** If the VM should be in an Azure availability set after migration, specify the set. The set must be in the targeted resource group that is specified for the migration.

1. In **Disks**, specify whether the VM disks should be replicated to Azure. Then select the disk type (Standard SSD/HDD or Premium SSD) in Azure and select **Next**.
    - Optionally exclude disks from replication.
    - An excluded disk isn't on the Azure VM after migration.

1. In **Review + start replication**, review the settings. Then select **Replicate** to start the initial replication for the servers.

> [!NOTE]
> Update replication settings any time *before* replication starts in **Manage** > **Replicating machines**. Settings can't be changed after replication starts.

## Step 6: Migrate the database via Azure Database Migration Service

The Contoso admins need to create a Database Migration Service project and then migrate the database.

### Create an Azure Database Migration Service project

The Contoso admins complete the following steps:

1. Create a Database Migration Service project. 

1. Select the **SQL Server** source server type and **Azure SQL Managed Instance** as the target.

   :::image type="content" border="false" alt-text="Screenshot that shows the New migration project pane." source="./media/contoso-migration-rehost-vm-sql-managed-instance/dms-project.png":::

   The Migration Wizard opens.

### Migrate the database

The Contoso admins complete the following steps:

1. In the Migration Wizard, specify the source VM on which the on-premises database is located. Enter the credentials to access the database.

   :::image type="content" border="false" alt-text="Screenshot that shows the Source details pane." source="./media/contoso-migration-rehost-vm-sql-managed-instance/dms-wizard-source.png":::

1. Select the database to migrate: **SmartHotel.Registration**.

   :::image type="content" border="false" alt-text="Screenshot that shows the Select source databases pane." source="./media/contoso-migration-rehost-vm-sql-managed-instance/dms-wizard-source-db.png":::

1. For the target, enter the name of the managed instance in Azure and the access credentials.

    ![Screenshot that shows the Target details pane.](./media/contoso-migration-rehost-vm-sql-managed-instance/dms-target-details.png)

1. In **New Activity** > **Run migration**, specify settings to run the migration:
    - Source and target credentials.
    - The database to migrate.
    - The network share created on the on-premises VM. Azure Database Migration Service saves source backups to this share.
        - The service account that runs the source instance of SQL Server must have write permissions on this share.
        - The path to the share must be its fully qualified domain name.
    - The SAS URI that provides Azure Database Migration Service with access to the storage account container to which the service uploads the backup files for migration.

    :::image type="content" border="false" alt-text="Screenshot that shows the Configure migration settings screen." source="./media/contoso-migration-rehost-vm-sql-managed-instance/dms-migration-settings.png":::

1. Save the migration settings and then run the migration.

1. In **Overview**, monitor the migration status.

   :::image type="content" border="false" alt-text="Screenshot that shows the status." source="./media/contoso-migration-rehost-vm-sql-managed-instance/dms-monitor1.png":::

1. When migration is finished, verify that the target databases exist on the managed instance.

   :::image type="content" border="false" alt-text="Screenshot that shows verifying the database migration." source="./media/contoso-migration-rehost-vm-sql-managed-instance/dms-monitor2.png":::

## Step 7: Migrate the VMs with the Migration and modernization tool

The Contoso admins run a quick test migration and verify that the VM is working properly. Then they migrate the VM.

### Run a test migration

The Contoso admins complete the following steps:

1. In **Migration goals** > **Servers** > **Azure Migrate: Server Migration**, select **Test migrated servers**.

   :::image type="content" border="false" alt-text="Screenshot that shows the Test migrated servers item." source="./media/contoso-migration-rehost-linux-vm/test-migrated-servers.png":::

1. Select and hold (or right-click) the VM to test, and then select **Test migrate**.

   :::image type="content" border="false" alt-text="Screenshot that shows the Test migrate item." source="./media/contoso-migration-rehost-linux-vm/test-migrate.png":::

1. In **Test migration**, select the Azure virtual network in which the Azure VM will be located after the migration. We recommend using a nonproduction virtual network.

   The **Test migration** job starts. 

1. Monitor the job in the portal notifications.

1. After the migration finishes, view the migrated Azure VM in **Virtual Machines** in the Azure portal. The machine name has a suffix **-Test**.

1. After the test is done, select and hold (or right-click) the Azure VM in **Replicating machines** and then select **Clean up test migration**.

   :::image type="content" border="false" alt-text="Screenshot that shows the Clean up test migration item." source="./media/contoso-migration-rehost-linux-vm/clean-up.png":::

### Migrate the VM

Now the Contoso admins run a full migration to complete the move:

1. In the Azure Migrate project, go to **Servers** > **Azure Migrate: Server Migration** and select **Replicating servers**.

   :::image type="content" border="false" alt-text="Screenshot that shows the Replicating servers item." source="./media/contoso-migration-rehost-linux-vm/replicating-servers.png":::

1. In **Replicating machines**, select and hold (or right-click) the VM, and then select **Migrate**.

1. In **Migrate** > **Shut down virtual machines and perform a planned migration with no data loss**, select **Yes** > **OK**.
    - By default, Azure Migrate shuts down the on-premises VM and runs an on-demand replication to synchronize any VM changes that occurred since the last replication occurred. This action ensures no data loss.
    - To skip shutting down the VM, select **No**.
   
   A migration job starts for the VM. 

1. Track the job in Azure notifications.

1. After the job finishes, view and manage the VM from the **Virtual Machines** page.

1. Update the DNS records for `WEBVM` on one of the Contoso domain controllers.

### Update the connection string

As the final step in the migration process, the Contoso admins update the connection string of the application to point to the migrated database that's running on the SQL managed instance:

1. In the Azure portal, find the connection string by selecting **Settings** > **Connection strings**.

    :::image type="content" border="false" alt-text="Screenshot that shows the Connection strings option." source="./media/contoso-migration-rehost-vm-sql-managed-instance/failover4.png":::

1. Update the string with the user name and password of the SQL managed instance.

1. After configuring the string, replace the current connection string in the `web.config` file of its application.

1. After updating the file and saving it, restart IIS on `WEBVM` by running `iisreset /restart` in a command prompt window.

   After IIS restarts, the application uses the database that's running on the SQL managed instance.

1. Shut down the on-premises `SQLVM` machine. 

   The migration is finished.

**Need more help?**

- [Run a disaster recovery drill to Azure](/azure/site-recovery/tutorial-dr-drill-azure)
- [Create and customize recovery plans](/azure/site-recovery/site-recovery-create-recovery-plans)
- [Run a failover from on-premises to Azure](/azure/site-recovery/site-recovery-failover)

## Clean up after migration

With the migration finished, an Azure VM runs the SmartHotel360 application and SQL Managed Instance hosts the SmartHotel360 database.

Now, Contoso performs these cleanup tasks:

- Remove the `WEBVM` machine from the vCenter Server inventory.
- Remove the `SQLVM` machine from the vCenter Server inventory.
- Remove `WEBVM` and `SQLVM` from local backup jobs.
- Update internal documentation to show the new location and IP address for `WEBVM`.
- Remove `SQLVM` from internal documentation. Alternatively, Contoso can revise the documentation to show `SQLVM` as deleted and no longer in the VM inventory.
- Review any resources that interact with the decommissioned VMs. Update any relevant settings or documentation to reflect the new configuration.

## Review the deployment

With the migrated resources in Azure, Contoso needs to fully operationalize and secure its new infrastructure.

### Security

The Contoso security team checks the Azure VMs and the SQL managed instance for any security issues in the implementation:

- The team reviews the network security groups that control access for the VM. Network security groups help ensure that only traffic that's allowed to the application can pass.
- Contoso's security team also considers securing the data on the disk by using Azure Disk Encryption and Azure Key Vault.
- The team enables threat detection on the managed instance. In the event of a threat, threat detection sends an alert to Contoso's security team/service desk system to open a ticket. For more information about threat detection, see [Configure Advanced Threat Protection in Azure SQL Managed Instance](/azure/azure-sql/managed-instance/threat-detection-configure).

  :::image type="content" border="false" alt-text="Screenshot that shows the Threat detection screen for SQL Managed Instance." source="./media/contoso-migration-rehost-vm-sql-managed-instance/mi-security.png":::

To learn more about security practices for VMs, see [Security best practices for IaaS workloads in Azure](/azure/security/fundamentals/iaas).

### Business continuity and disaster recovery

For business continuity and disaster recovery, Contoso takes the following actions:

- **Keep data safe.** Contoso backs up the data on the VMs by using the Azure Backup service. For more information, see [An overview of Azure VM backup](/azure/backup/backup-azure-vms-introduction).
- **Keep applications up and running.** Contoso replicates the application VMs in Azure to a secondary region by using Site Recovery. For more information, see [Set up disaster recovery to a secondary Azure region for an Azure VM](/azure/site-recovery/azure-to-azure-quickstart).
- **Learn more.** Contoso learns more about managing SQL Managed Instance, which includes [database backups](/azure/azure-sql/database/automated-backups-overview).

### Licensing and cost optimization

- Contoso has existing licensing for `WEBVM`. To take advantage of pricing with [Azure Hybrid Benefit](https://azure.microsoft.com/pricing/hybrid-benefit/), Contoso converts the existing Azure VM.
- Contoso uses [Azure Cost Management + Billing](/azure/cost-management-billing/cost-management-billing-overview) to ensure that the company stays within the budgets that IT leadership established.

## Conclusion

In this article, Contoso rehosts the SmartHotel360 application in Azure by migrating the application front-end VM to Azure by using Azure Migrate. Contoso migrates the on-premises database to a SQL managed instance by using Azure Database Migration Service.

## Next steps

- [Tailwind Traders - sample reference applications](https://github.com/Microsoft/TailwindTraders)
- [Rock, Paper, Scissors, Lizard, Spock - sample application](https://github.com/Microsoft/RockPaperScissorsLizardSpock)
