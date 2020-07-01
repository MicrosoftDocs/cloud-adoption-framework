---
title: "Rehost an on-premises app by migrating to Azure VMs and Azure SQL Managed Instance"
description: Learn how Contoso rehosts an on-premises app on Azure VMs and by using Azure SQL Database Managed Instance.
author: givenscj
ms.author: abuck
ms.date: 04/02/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
services: azure-migrate
---

<!-- docsTest:ignore ".NET" -->

<!-- cSpell:ignore givenscj WEBVM SQLVM OSTICKETWEB OSTICKETMYSQL contosohost vcenter contosodc NSGs agentless SQLMI iisreset -->

# Rehost an on-premises app on an Azure VM and SQL Managed Instance

This article shows how the fictional company Contoso migrates a two-tier Windows .NET front-end app running on VMware VMs to an Azure VM using the Azure Migrate service. It also shows how Contoso migrates the app database to Azure SQL Managed Instance.

The SmartHotel360 app used in this example is provided as open source. If you'd like to use it for your own testing purposes, you can download it from [GitHub](https://github.com/Microsoft/SmartHotel360).

## Business drivers

Contoso's IT leadership team has worked closely with the company's business partners to understand what the business wants to achieve with this migration:

- **Address business growth.** Contoso is growing. As a result, pressure has increased on the company's on-premises systems and infrastructure.
- **Increase efficiency.** Contoso needs to remove unnecessary procedures, and to streamline processes for its developers and users. The business needs IT to be fast and to not waste time or money, so the company can deliver faster on customer requirements.
- **Increase agility.** Contoso IT needs to be more responsive to the needs of the business. It must be able to react faster than the changes that occur in the marketplace for the company to be successful in a global economy. IT at Contoso must not get in the way or become a business blocker.
- **Scale.** As the company's business grows successfully, Contoso IT must provide systems that can grow at the same pace.

## Migration goals

The Contoso cloud team has identified goals for this migration. The company uses migration goals to determine the best migration method.

- After migration, the app in Azure should have the same performance capabilities that the app has today in Contoso's on-premises VMware environment. Moving to the cloud doesn't mean that app performance is less critical.
- Contoso doesn't want to invest in the app. The app is critical and important to the business, but Contoso simply wants to move the app in its current form to the cloud.
- Database administration tasks should be minimized after the app is migrated.
- Contoso doesn't want to use an Azure SQL Database for this app. It's looking for alternatives.

## Solution design

After pinning down their goals and requirements, Contoso designs and reviews a deployment solution, and identifies the migration process, including the Azure services that it will use for the migration.

### Current architecture

- Contoso has one main datacenter (`contoso-datacenter`) . The datacenter is located in the city of New York in the eastern United States.
- Contoso has three additional local branches across the United States.
- The main datacenter is connected to the internet with a fiber metro ethernet connection (500 Mbps).
- Each branch is connected locally to the internet by using business-class connections with IPsec VPN tunnels back to the main datacenter. The setup allows Contoso's entire network to be permanently connected and optimizes internet connectivity.
- The main datacenter is fully virtualized with VMware. Contoso has two ESXi 6.5 virtualization hosts that are managed by vCenter Server 6.5.
- Contoso uses Active Directory for identity management. Contoso uses DNS servers on the internal network.
- Contoso has an on-premises domain controller (`contosodc1`).
- The domain controllers run on VMware VMs. The domain controllers at local branches run on physical servers.
- The SmartHotel360 app is tiered across two VMs (`WEBVM` and `SQLVM`) that are located on a VMware ESXi version 6.5 host (`contosohost1.contoso.com`).
- The VMware environment is managed by vCenter Server 6.5 (`vcenter.contoso.com`) running on a VM.

![Current Contoso architecture](./media/contoso-migration-rehost-vm-sql-managed-instance/contoso-architecture.png)

### Proposed architecture

In this scenario, Contoso wants to migrate its two-tier on-premises travel app as follows:

- Migrate the app database (`SmartHotelDB`) to an Azure SQL Managed Instance.
- Migrate the front-end `WEBVM` to an Azure VM.
- The on-premises VMs in the Contoso datacenter will be decommissioned when the migration is finished.

![Scenario architecture](./media/contoso-migration-rehost-vm-sql-managed-instance/architecture.png)

### Database considerations

As part of the solution design process, Contoso did a feature comparison between Azure SQL Database and SQL Managed Instance. The following considerations helped them to decide to use SQL Managed Instance.

- SQL Managed Instance aims to deliver almost 100% compatibility with the latest on-premises SQL Server version. Microsoft recommends SQL Managed Instance for customers who are running SQL Server on-premises or on IaaS VMs and want to migrate their apps to a fully managed service with minimal design changes.
- Contoso is planning to migrate a large number of apps from on-premises to IaaS. Many of these are ISV provided. Contoso realizes that using SQL Managed Instance will help ensure database compatibility for these apps, rather than using SQL Database, which might not be supported.
- Contoso can perform a lift and shift migration to SQL Managed Instance using the fully automated Azure Database Migration Service. With this service in place, Contoso can reuse it for future database migrations.
- SQL Managed Instance supports SQL Server agent, an important component of the SmartHotel360 app. Contoso needs this compatibility, otherwise it will have to redesign maintenance plans required by the app.
- With Software Assurance, Contoso can exchange their existing licenses for discounted rates on a SQL Managed Instance using the Azure Hybrid Benefit for SQL Server. This can allow Contoso to save up to 30% on SQL Managed Instance.
- SQL Managed Instance is fully contained in the virtual network, so it provides greater isolation and security for Contoso's data. Contoso can get the benefits of the public cloud, while keeping the environment isolated from the public internet.
- SQL Managed Instance supports many security features, including always-encrypted, dynamic data masking, row-level security, and threat detection.

### Solution review

Contoso evaluates the proposed design by putting together a pros and cons list.

<!-- markdownlint-disable MD033 -->

| Consideration  | Details |
| --- | --- |
| **Pros** | `WEBVM` will be moved to Azure without changes, making the migration simple. <br><br> SQL Managed Instance supports Contoso's technical requirements and goals. <br><br> SQL Managed Instance will provide 100% compatibility with their current deployment, while moving them away from SQL Server 2008 R2. <br><br> They can take advantage of their investment in Software Assurance and using the Azure Hybrid Benefit for SQL Server and Windows Server. <br><br> They can reuse the Azure Database Migration Service for additional future migrations. <br><br> SQL Managed Instance has built-in fault tolerance that Contoso doesn't need to configures. This ensures that the data tier is no longer a single point of failover. |
| **Cons** | The `WEBVM` is running Windows Server 2008 R2. Although this operating system is supported by Azure, it is no longer supported platform. [Learn more](https://support.microsoft.com/help/956893). <br><br> The web tier remains a single point of failover with only `WEBVM` providing services. <br><br> Contoso will need to continue supporting the app web tier as a VM rather than moving to a managed service, such as Azure App Service. <br><br> For the data tier, SQL Managed Instance might not be the best solution if Contoso wants to customize the operating system or the database server, or if they want to run third-party apps along with SQL Server. Running SQL Server on an IaaS VM could provide this flexibility. |

<!-- markdownlint-enable MD033 -->

### Migration process

Contoso will migrate the web and data tiers of its SmartHotel360 app to Azure by completing these steps:

1. Contoso already has its Azure infrastructure in place, so it just needs to add a couple of specific Azure components for this scenario.
2. The data tier will be migrated by using the Azure Database Migration Service. This service connects to the on-premises SQL Server VM across a site-to-site VPN connection between the Contoso datacenter and Azure. The service then migrates the database.
3. The web tier will be migrated by using a lift and shift migration by using Azure Migrate. The process entails preparing the on-premises VMware environment, setting up and enabling replication, and migrating the VMs by failing them over to Azure.

     ![Migration architecture](./media/contoso-migration-rehost-vm-sql-managed-instance/migration-architecture.png)

### Azure services

| Service | Description | Cost |
| --- | --- | --- |
| [Azure Database Migration Service](https://docs.microsoft.com/azure/dms/dms-overview) | The Azure Database Migration Service enables seamless migration from multiple database sources to Azure data platforms with minimal downtime. | Learn about [supported regions](https://docs.microsoft.com/azure/dms/dms-overview#regional-availability) and | [Database Migration Service pricing](https://azure.microsoft.com/pricing/details/database-migration). |
| [Azure SQL Managed Instance](https://docs.microsoft.com/azure/sql-database/sql-database-managed-instance) | SQL Managed Instance is a managed database service that represents a fully managed SQL Server instance in the Azure cloud. It uses the same code as the latest version of SQL Server database engine, and has the latest features, performance improvements, and security patches. | Using a SQL Managed Instance running in Azure incurs charges based on capacity. Learn more about [SQL Managed Instance pricing](https://azure.microsoft.com/pricing/details/sql-database/managed). |
| [Azure Migrate](https://docs.microsoft.com/azure/migrate/migrate-services-overview) | Contoso uses the Azure Migrate service to | Assess its VMware VMs. Azure Migrate assesses the migration suitability | Of the machines. It provides sizing and cost estimates for running in | Azure. | As of may 2018, Azure Migrate is a free service. |

## Prerequisites

Contoso and other users must meet the following prerequisites for this scenario:

<!-- markdownlint-disable MD033 -->

| Requirements | Details |
| --- | --- |
| **Azure subscription** | You should have already created a subscription when you perform the assessment in the first article in this series. If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/pricing/free-trial). <br><br> If you create a free account, you're the administrator of your subscription and can perform all actions. <br><br> If you use an existing subscription and you're not the administrator of the subscription, you need to work with the admin to assign you owner or contributor permissions to the necessary resource groups and resources. |
| **Azure infrastructure** | Contoso set up their Azure infrastructure as described in [Azure infrastructure for migration](./contoso-migration-infrastructure.md). |
| **On-premises servers** | The on-premises vCenter server should be running version 5.5, 6.0, or 6.5. <br><br> An ESXi host running version 5.5, 6.0 or 6.5. <br><br> One or more VMware VMs running on the ESXi host. |
| **On-premises VMs** | [Review Linux machines](https://docs.microsoft.com/azure/virtual-machines/linux/endorsed-distros) that are endorsed to run on Azure. |
| **Database Migration Service** | For the Azure Database Migration Service, you need a [compatible on-premises VPN device](https://docs.microsoft.com/azure/vpn-gateway/vpn-gateway-about-vpn-devices). <br><br> You must be able to configure the on-premises VPN device. It must have an external-facing public IPv4 address. The address can't be located behind a NAT device. <br><br> Make sure you can access your on-premises SQL Server database. <br><br> Windows firewall should be able to access the source database engine. Learn how to [configure Windows firewall for database engine access](https://docs.microsoft.com/sql/database-engine/configure-windows/configure-a-windows-firewall-for-database-engine-access). <br><br> If there's a firewall in front of your database machine, add rules to allow access to the database and files via SMB port 445. <br><br> The credentials that are used to connect to the source SQL Server instance and which target SQL Managed Instance must be members of the sysadmin server role. <br><br> You need a network share in your on-premises database that the Azure Database Migration Service can use to back up the source database. <br><br> Make sure that the service account running the source SQL Server instance has write permissions on the network share. <br><br> Make a note of a Windows user and password that has full control permissions on the network share. The Azure Database Migration Service impersonates these user credentials to upload backup files to the Azure Storage container. <br><br> The SQL Server express installation process sets the TCP/IP protocol to **Disabled** by default. Make sure that it's enabled. |

<!-- markdownlint-enable MD033 -->

## Scenario steps

Here's how Contoso plans to set up the deployment:

> [!div class="checklist"]
>
> - **Step 1: Prepare a SQL Managed Instance.** Contoso needs an existing managed instance to which the on-premises SQL Server database will migrate.
> - **Step 2: Prepare the Azure Database Migration Service.** Contoso must register the database migration provider, create an instance, and then create an Azure Database Migration Service project. Contoso also must set up a shared access signature (SAS) uniform resource identifier (URI) for the Azure Database Migration Service. An SAS URI provides delegated access to resources in Contoso's storage account, so Contoso can grant limited permissions to storage objects. Contoso sets up an SAS URI, so the Azure Database Migration Service can access the storage account container to which the service uploads the SQL Server backup files.
> - **Step 3: Prepare Azure for Azure Migrate: Server Migration.** They add the server migration tool to their Azure Migrate project.
> - **Step 4: Prepare on-premises VMware for Azure Migrate: Server Migration.** They prepare accounts for VM discovery, and prepare to connect to Azure VMs after migration.
> - **Step 5: Replicate VMs.** They set up replication, and start replicating VMs to Azure Storage.
> - **Step 6: Migrate the database using the Azure Database Migration Service.** Contoso migrates the database.
> - **Step 7: Migrate the VM with Azure Migrate: Server Migration.** They run a test migration to make sure everything's working, and then run a full migrate to move the VMs to Azure.

## Step 1: Prepare a SQL Managed Instance

To set up an Azure SQL Managed Instance, Contoso needs a subnet that meets the following requirements:

- The subnet must be dedicated. It must be empty, and it can't contain any other cloud service. The subnet can't be a gateway subnet.
- After the managed instance is created, Contoso should not add resources to the subnet.
- The subnet can't have a network security group associated with it.
- The subnet must have a user-defined route table. The only route assigned should be `0.0.0.0/0` next-hop internet.
- If an optional custom DNS is specified for the virtual network, the virtual IP address `168.63.129.16` for the recursive resolvers in Azure must be added to the list. Learn how to [configure custom DNS for an Azure SQL Managed Instance](https://docs.microsoft.com/azure/sql-database/sql-database-managed-instance-custom-dns).
- The subnet must not have a service endpoint (storage or SQL) associated with it. Service endpoints should be disabled on the virtual network.
- The subnet must have a minimum of 16 IP addresses. Learn how to [size the managed instance subnet](https://docs.microsoft.com/azure/sql-database/sql-database-managed-instance-vnet-configuration).
- In Contoso's hybrid environment, custom DNS settings are required. Contoso configures DNS settings to use one or more of the company's Azure DNS servers. Learn more about [DNS customization](https://docs.microsoft.com/azure/sql-database/sql-database-managed-instance-custom-dns).

### Set up a virtual network for the managed instance

Contoso admins set up the virtual network as follows:

1. They create a new virtual network (`VNET-SQLMI-EU2`) in the primary region (`East US 2`). It adds the virtual network to the `ContosoNetworkingRG` resource group.
2. They assign an address space of `10.235.0.0/24`. They ensure that the range doesn't overlap with any other networks in its enterprise.
3. They add two subnets to the network:
    - `SQLMI-DS-EUS2` (`10.235.0.0/25`).
    - `SQLMI-SAW-EUS2` (`10.235.0.128/29`). This subnet is used to attach a directory to the managed instance.

      ![Managed Instance - Create virtual network](./media/contoso-migration-rehost-vm-sql-managed-instance/mi-vnet.png)

4. After the virtual network and subnets are deployed, they peer networks as follows:

    - Peers `VNET-SQLMI-EUS2` with `VNET-HUB-EUS2` (the hub virtual network in `East US 2`).
    - Peers `VNET-SQLMI-EUS2` with `VNET-PROD-EUS2` (the production network).

      ![Network peering](./media/contoso-migration-rehost-vm-sql-managed-instance/mi-peering.png)

5. They set custom DNS settings. DNS points first to Contoso's Azure domain controllers. Azure DNS is secondary. The Contoso Azure domain controllers are located as follows:

    - Located in the `PROD-DC-EUS2` subnet, in the `East US 2` production network (`VNET-PROD-EUS2`).
    - `CONTOSODC3` address: `10.245.42.4`.
    - `CONTOSODC4` address: `10.245.42.5`.
    - Azure DNS resolver: `168.63.129.16`.

      ![Network DNS servers](./media/contoso-migration-rehost-vm-sql-managed-instance/mi-dns.png)

**Need more help?**

- Read the [SQL Managed Instance overview](https://docs.microsoft.com/azure/sql-database/sql-database-managed-instance).
- Learn how to [create a virtual network for a SQL Managed Instance](https://docs.microsoft.com/azure/sql-database/sql-database-managed-instance-vnet-configuration).
- Learn how to [set up peering](https://docs.microsoft.com/azure/virtual-network/virtual-network-manage-peering).
- Learn how to [update Azure Active Directory DNS settings](https://docs.microsoft.com/azure/active-directory-domain-services/tutorial-create-instance).

### Set up routing

The managed instance is placed in a private virtual network. Contoso needs a route table for the virtual network to communicate with the Azure management service. If the virtual network can't communicate with the service that manages it, the virtual network becomes inaccessible.

Contoso considers these factors:

- The route table contains a set of rules (routes) that specify how packets sent from the managed instance should be routed in the virtual network.
- The route table is associated with subnets where managed instances are deployed. Each packet that leaves a subnet is handled based on the associated route table.
- A subnet can be associated with only one route table.
- There are no additional charges for creating route tables in Microsoft Azure.

 To set up routing, Contoso admins do the following:

1. They create a user-defined route table in the `ContosoNetworkingRG` resource group.

    ![Route table](./media/contoso-migration-rehost-vm-sql-managed-instance/mi-route-table.png)

2. To comply with SQL Managed Instance requirements, after the route table (`MIRouteTable`) is deployed, they add a route that has an address prefix of `0.0.0.0/0`. The **Next hop type** option is set to **Internet**.

    ![Route table prefix](./media/contoso-migration-rehost-vm-sql-managed-instance/mi-route-table-prefix.png)

3. They associate the route table with the `SQLMI-DB-EUS2` subnet (in the `VNET-SQLMI-EUS2` network).

    ![Route table subnet](./media/contoso-migration-rehost-vm-sql-managed-instance/mi-route-table-subnet.png)

**Need more help?**

Learn how to [set up routes for a managed instance](https://docs.microsoft.com/azure/sql-database/sql-database-managed-instance-get-started).

### Create a managed instance

Now, Contoso admins can provision a SQL Managed Instance:

1. Because the managed instance serves a business app, they deploy the managed instance in the company's primary region (`East US 2`). They add the managed instance to the `ContosoRG` resource group.
2. They select a pricing tier, size compute, and storage for the instance. Learn more about [SQL Managed Instance pricing](https://azure.microsoft.com/pricing/details/sql-database/managed).

    ![Managed Instance](./media/contoso-migration-rehost-vm-sql-managed-instance/mi-create.png)

3. After the managed instance is deployed, two new resources appear in the `ContosoRG` resource group:

    - A virtual cluster in case Contoso has multiple managed instances.
    - The SQL Server database SQL Managed Instance.

      ![Managed Instance](./media/contoso-migration-rehost-vm-sql-managed-instance/mi-resources.png)

**Need more help?**

Learn how to [provision a managed instance](https://docs.microsoft.com/azure/sql-database/sql-database-managed-instance-get-started).

## Step 2: Prepare the Azure Database Migration Service

To prepare the Azure Database Migration Service, Contoso admins need to do a few things:

- Register the Azure Database Migration Service provider in Azure.
- Provide the Azure Database Migration Service with access to Azure Storage for uploading the backup files that are used to migrate a database. To provide access to Azure Storage, they create an Azure Blob storage container. They generate an SAS URI for the Blob storage container.
- Create an Azure Database Migration Service project.

Then, they complete the following steps:

1. They register the database migration provider under its subscription. ![Database Migration Service - Register](./media/contoso-migration-rehost-vm-sql-managed-instance/dms-subscription.png)

2. They create a Blob storage container. Contoso generates an SAS URI so that the Azure Database Migration Service can access it.

    ![Database Migration Service - Generate an SAS URI](./media/contoso-migration-rehost-vm-sql-managed-instance/dms-sas.png)

3. They create an Azure Database Migration Service instance.

    ![Database Migration Service - Create instance](./media/contoso-migration-rehost-vm-sql-managed-instance/dms-instance.png)

4. They place the Azure Database Migration Service instance in the `PROD-DC-EUS2` subnet of the `VNET-PROD-DC-EUS2` virtual network.
    - The Azure Database Migration Service is placed here because the service must be in a virtual network that can access the on-premises SQL Server VM via a VPN gateway.
    - `VNET-PROD-EUS2` is peered to `VNET-HUB-EUS2` and is allowed to use remote gateways. The **Use remote gateways** option ensures that the Azure Database Migration Service can communicate as required.

        ![Database Migration Service - Configure network](./media/contoso-migration-rehost-vm-sql-managed-instance/dms-network.png)

**Need more help?**

- Learn how to [set up the Azure Database Migration Service](https://docs.microsoft.com/azure/dms/quickstart-create-data-migration-service-portal).
- Learn how to [create and use SAS](https://docs.microsoft.com/azure/storage/blobs/storage-dotnet-shared-access-signature-part-2).

## Step 3: Prepare Azure for the Azure Migrate: Server Migration tool

Here are the Azure components Contoso needs to migrate the VMs to Azure:

- A VNet in which Azure VMs will be located when they're created during migration.
- The Azure Migrate: Server Migration tool provisioned.

They set these up as follows:

1. **Set up a network:** Contoso already set up a network that can be for Azure Migrate: Server Migration when they [deployed the Azure infrastructure](./contoso-migration-infrastructure.md)

    - The SmartHotel360 app is a production app, and the VMs will be migrated to the Azure production network (`VNET-PROD-EUS2`) in the primary region (`East US 2`).
    - Both VMs will be placed in the `ContosoRG` resource group, which is used for production resources.
    - The app front-end VM (`WEBVM`) will migrate to the front-end subnet (`PROD-FE-EUS2`) of the production network.
    - The app database VM (`SQLVM`) will migrate to the database subnet (`PROD-DB-EUS2`) of the production network.

## Step 4: Prepare on-premises VMware for Azure Migrate: Server Migration

Here are the Azure components Contoso needs to migrate the VMs to Azure:

- A VNet in which Azure VMs will be located when they're created during migration.
- The Azure Migrate appliance (server discovery tool), provisioned and configured.

They set these up as follows:

1. Set up a network-Contoso already set up a network that can be for Azure Migrate: Server Migration when they [deployed the Azure infrastructure](./contoso-migration-infrastructure.md)

    - The SmartHotel360 app is a production app, and the VMs will be migrated to the Azure production network (`VNET-PROD-EUS2`) in the primary region (`East US 2`).
    - Both VMs will be placed in the `ContosoRG` resource group, which is used for production resources.
    - The app front-end VM (`WEBVM`) will migrate to the front-end subnet (`PROD-FE-EUS2`), in the production network.
    - The app database VM (`SQLVM`) will migrate to the database subnet (`PROD-DB-EUS2`), in the production network.

2. Provision the Azure Migrate appliance (server discovery tool).

    - From Azure Migrate, download the OVA image and import it into VMware.

        ![Download the OVA file](./media/contoso-migration-rehost-vm/migration-download-ova.png)

    - Start the imported image and configure the tool, including the following steps:

      - Set up the prerequisites.

        ![Configure the tool](./media/contoso-migration-rehost-vm/migration-setup-prerequisites.png)

      - Point the tool to the Azure subscription.

        ![Configure the tool](./media/contoso-migration-rehost-vm/migration-register-azure.png)

      - Set the VMware vCenter credentials.

        ![Configure the tool](./media/contoso-migration-rehost-vm/migration-vcenter-server.png)

      - Add any Linux-based or Windows-based credentials for discovery.

        ![Configure the tool](./media/contoso-migration-rehost-vm/migration-credentials.png)

3. Once configured, it will take some time for the tool to enumerate all the virtual machines. Once complete, you will see them populate in the Azure Migrate tool in Azure.

**Need more help?**

Learn about setting up the [Azure Migrate appliance](https://docs.microsoft.com/azure/migrate/migrate-services-overview#azure-migrate-server-migration-tool).

### Prepare on-premises VMs

After migration, Contoso wants to connect to the Azure VMs and allow Azure to manage the VMs. To do this, Contoso admins do the following before migration:

1. For access over the internet, they:

    - Enable RDP or SSH on the on-premises VM before migration.
    - Ensure that TCP and UDP rules are added for the **Public** profile.
    - Check that RDP or SSH is allowed in the operating system firewall.

2. For access over site-to-site VPN, they:

    - Enable RDP or SSH on the on-premises VM before migration.
    - Check that RDP or SSH is allowed in the operating system firewall.
    - For Windows, set the operating system's SAN policy on the on-premises VM to **OnlineAll**.

3. Install the Azure agent:

    - [Azure Linux agent](https://docs.microsoft.com/azure/virtual-machines/extensions/agent-linux)
    - [Azure Windows agent](https://docs.microsoft.com/azure/virtual-machines/extensions/agent-windows)

4. Miscellaneous

   - For Windows, there should be no Windows updates pending on the VM when triggering a migration. If there are, they won't be able to log into the VM until the update completes.
   - After migration, they can check **boot diagnostics** to view a screenshot of the VM. If this doesn't work, they should verify that the VM is running, and review these [troubleshooting tips](https://social.technet.microsoft.com/wiki/contents/articles/31666.troubleshooting-remote-desktop-connection-after-failover-using-asr.aspx).

**Need more help?**

- Learn about [preparing VMs for migration](https://docs.microsoft.com/azure/migrate/contoso-migration-rehost-vm#prepare-vms-for-migration).

## Step 5: Replicate the on-premises VMs

Before Contoso admins can run a migration to Azure, they need to set up and enable replication.

With discovery completed, you can begin replication of VMware VMs to Azure.

1. In the Azure Migrate project > **Servers**, **Azure Migrate: Server Migration**, select **Replicate**.

    ![Replicate VMs](./media/contoso-migration-rehost-vm/select-replicate.png)

2. In **Replicate**, > **Source settings** > **Are your machines virtualized?**, select **Yes, with VMware vSphere**.

3. In **On-premises appliance**, select the name of the Azure Migrate appliance that you set up > **OK**.

    ![Source settings](./media/contoso-migration-rehost-vm/source-settings.png)

4. In **Virtual machines**, select the machines you want to replicate.
    - If you've run an assessment for the VMs, you can apply VM sizing and disk type (premium/standard) recommendations from the assessment results. To do this, in **Import migration settings from an Azure Migrate assessment?**, select the **Yes** option.
    - If you didn't run an assessment, or you don't want to use the assessment settings, select the **No** options.
    - If you selected to use the assessment, select the VM group, and assessment name.

    ![Select assessment](./media/contoso-migration-rehost-vm/select-assessment.png)

5. In **Virtual machines**, search for VMs as needed, and check each VM you want to migrate. Then select **Next: Target settings**.

6. In **Target settings**, select the subscription, and target region to which you'll migrate, and specify the resource group in which the Azure VMs will reside after migration. In **Virtual Network**, select the Azure VNet/subnet to which the Azure VMs will be joined after migration.

7. In **Azure Hybrid Benefit**, select the following:

    - Select **No** if you don't want to apply Azure Hybrid Benefit. Then select **Next**.
    - Select **Yes** if you have Windows Server machines that are covered with active Software Assurance or Windows Server subscriptions, and you want to apply the benefit to the machines you're migrating. Then select **Next**.

8. In **Compute**, review the VM name, size, OS disk type, and availability set. VMs must conform with [Azure requirements](https://docs.microsoft.com/azure/migrate/migrate-support-matrix-vmware#vmware-requirements).

    - **VM size:** If you're using assessment recommendations, the VM size dropdown will contain the recommended size. Otherwise Azure Migrate picks a size based on the closest match in the Azure subscription. Alternatively, pick a manual size in **Azure VM size.**
    - **OS disk:** Specify the OS (boot) disk for the VM. The OS disk is the disk that has the operating system bootloader and installer.
    - **Availability set:** If the VM should be in an Azure availability set after migration, specify the set. The set must be in the target resource group you specify for the migration.

9. In **Disks**, specify whether the VM disks should be replicated to Azure, and select the disk type (standard SSD/HDD or premium-managed disks) in Azure. Then select **Next**.
    - You can exclude disks from replication.
    - If you exclude disks, won't be present on the Azure VM after migration.

10. In **Review and start replication**, review the settings, and select **Replicate** to start the initial replication for the servers.

> [!NOTE]
> You can update replication settings any time before replication starts, in **Manage** > **Replicating machines**. Settings can't be changed after replication starts.

## Step 6: Migrate the database using the Azure Database Migration Service

Contoso admins need to create an Azure Database Migration Service project, and then migrate the database.

### Create an Azure Database Migration Service project

1. They create an Azure Database Migration Service project. They select the **SQL Server** source server type, and **Azure SQL Managed Instance** as the target.

     ![Database Migration Service - New migration project](./media/contoso-migration-rehost-vm-sql-managed-instance/dms-project.png)

2. The migration wizard opens.

### Migrate the database

1. In the migration wizard, they specify the source VM on which the on-premises database is located. They enter the credentials to access the database.

    ![Database Migration Service - Source details](./media/contoso-migration-rehost-vm-sql-managed-instance/dms-wizard-source.png)

2. They select the database to migrate (**SmartHotel.registration**):

    ![Database Migration Service - Select source databases](./media/contoso-migration-rehost-vm-sql-managed-instance/dms-wizard-source-db.png)

3. For the target, they enter the name of the managed instance in Azure, and the access credentials.

    ![Database Migration Service - Target details](./media/contoso-migration-rehost-vm-sql-managed-instance/dms-target-details.png)

4. In **New Activity** > **Run migration**, they specify settings to run migration:
    - Source and target credentials.
    - The database to migrate.
    - The network share created on the on-premises VM. The Azure Database Migration Service takes source backups to this share.
        - The service account that runs the source SQL Server instance must have write permissions on this share.
        - The FQDN path to the share must be used.
    - The SAS URI that provides the Azure Database Migration Service with access to the storage account container to which the service uploads the backup files for migration.

        ![Database Migration Service - Configure migration settings](./media/contoso-migration-rehost-vm-sql-managed-instance/dms-migration-settings.png)

5. They save the migration settings, and then run the migration.
6. In **Overview**, they monitor the migration status.

    ![Database Migration Service - Monitor](./media/contoso-migration-rehost-vm-sql-managed-instance/dms-monitor1.png)

7. When migration is finished, they verify that the target databases exist on the managed instance.

    ![Database Migration Service - Verify the database migration](./media/contoso-migration-rehost-vm-sql-managed-instance/dms-monitor2.png)

## Step 7: Migrate the VMs with Azure Migrate: Server Migration

Contoso admins run a quick test migration and verify the VM is working properly, and then migrate the VM.

### Run a test migration

1. In **Migration goals** > **Servers** > **Azure Migrate: Server Migration**, select **Test migrated servers**.

     ![Test migrated servers](./media/contoso-migration-rehost-linux-vm/test-migrated-servers.png)

2. Select and hold (or right-click) the VM to test, and select **Test migrate**.

    ![Test migration](./media/contoso-migration-rehost-linux-vm/test-migrate.png)

3. In **Test Migration**, select the Azure VNet in which the Azure VM will be located after the migration. We recommend you use a nonproduction VNet.
4. The **Test migration** job starts. Monitor the job in the portal notifications.
5. After the migration finishes, view the migrated Azure VM in **Virtual Machines** in the Azure portal. The machine name has a suffix **-Test**.
6. After the test is done, select and hold (or right-click) the Azure VM in **Replicating machines**, and select **Clean up test migration**.

    ![Clean up migration](./media/contoso-migration-rehost-linux-vm/clean-up.png)

### Migrate the VMs

Now Contoso admins run a full migration to complete the move.

1. In the Azure Migrate project > **Servers** > **Azure Migrate: Server Migration**, select **Replicating servers**.

    ![Replicating servers](./media/contoso-migration-rehost-linux-vm/replicating-servers.png)

2. In **Replicating machines**, select and hold (or right-click) the VM > **Migrate**.
3. In **Migrate** > **Shut down virtual machines and perform a planned migration with no data loss**, select **Yes** > **OK**.
    - By default Azure Migrate shuts down the on-premises VM, and runs an on-demand replication to synchronize any VM changes that occurred since the last replication occurred. This ensures no data loss.
    - If you don't want to shut down the VM, select **No**.
4. A migration job starts for the VM. Track the job in Azure notifications.
5. After the job finishes, you can view and manage the VM from the **Virtual Machines** page.
6. Finally, they update the DNS records for `WEBVM` on one of the Contoso domain controllers.

### Update the connection string

As the final step in the migration process, Contoso admins update the connection string of the application to point to the migrated database that's running on Contoso's SQL Managed Instance.

1. In the Azure portal, they find the connection string by selecting **Settings** > **Connection strings**.

    ![Connection strings](./media/contoso-migration-rehost-vm-sql-managed-instance/failover4.png)

2. They update the string with the user name and password of the SQL Managed Instance.
3. After the string is configured, they replace the current connection string in the `web.config` file of its application.
4. After updating the file and saving it, they restart IIS on `WEBVM` by running `iisreset /restart` in a command prompt window.
5. After IIS is restarted, the app uses the database that's running on the SQL Managed Instance.
6. At this point, they can shut down on-premises the SQLVM machine. The migration has been completed.

**Need more help?**

- Learn how to [run a test failover](https://docs.microsoft.com/azure/site-recovery/tutorial-dr-drill-azure).
- Learn how to [create a recovery plan](https://docs.microsoft.com/azure/site-recovery/site-recovery-create-recovery-plans).
- Learn how to [fail over to Azure](https://docs.microsoft.com/azure/site-recovery/site-recovery-failover).

## Clean up after migration

With the migration complete, the SmartHotel360 app is running on an Azure VM and the SmartHotel360 database is available in the Azure SQL Managed Instance.

Now, Contoso needs to do the following cleanup tasks:

- Remove the `WEBVM` machine from the vCenter server inventory.
- Remove the `SQLVM` machine from the vCenter server inventory.
- Remove `WEBVM` and `SQLVM` from local backup jobs.
- Update internal documentation to show the new location and IP address for `WEBVM`.
- Remove `SQLVM` from internal documentation. Alternatively, Contoso can revise the documentation to show `SQLVM` as deleted and no longer in the VM inventory.
- Review any resources that interact with the decommissioned VMs. Update any relevant settings or documentation to reflect the new configuration.

## Review the deployment

With the migrated resources in Azure, Contoso needs to fully operationalize and secure its new infrastructure.

### Security

The Contoso security team reviews the Azure VMs and SQL Managed Instance to check for any security issues with its implementation:

- The team reviews the network security groups that are used to control access for the VM. Network security groups help ensure that only traffic that is allowed to the app can pass.
- Contoso's security team also is considering securing the data on the disk by using Azure Disk Encryption and Azure Key Vault.
- The team enables threat detection on the managed instance. Threat detection sends an alert to Contoso's security team/service desk system to open a ticket if a threat is detected. Learn more about [threat detection for SQL Managed Instance](https://docs.microsoft.com/azure/sql-database/sql-database-managed-instance-threat-detection).

     ![Managed Instance security - Threat detection](./media/contoso-migration-rehost-vm-sql-managed-instance/mi-security.png)

To learn more about security practices for VMs, see [Security best practices for IaaS workloads in Azure](https://docs.microsoft.com/azure/security/fundamentals/iaas).

### BCDR

For business continuity and disaster recovery (BCDR), Contoso takes the following actions:

- Keep data safe: Contoso backs up the data on the VMs using the Azure Backup service. [Learn more](https://docs.microsoft.com/azure/backup/backup-overview).
- Keep apps up and running: Contoso replicates the app VMs in Azure to a secondary region using Site Recovery. [Learn more](https://docs.microsoft.com/azure/site-recovery/azure-to-azure-quickstart).
- Contoso learns more about managing SQL Managed Instance, including [database backups](https://docs.microsoft.com/azure/sql-database/sql-database-automated-backups).

### Licensing and cost optimization

- Contoso has an existing licensing for WEBVM. To take advantage of pricing with Azure Hybrid Benefit, Contoso converts the existing Azure VM.
- Contoso will use [Azure Cost Management and Billing](https://docs.microsoft.com/azure/cost-management-billing/cost-management-billing-overview) to ensure they stay within budgets established by their IT leadership.

## Conclusion

In this article, Contoso rehosts the SmartHotel360 app in Azure by migrating the app front-end VM to Azure by using the Azure Migrate service. Contoso migrates the on-premises database to an Azure SQL Managed Instance by using the Azure Database Migration Service.
