---
title: Rehost an application on Azure VMs with Azure Migrate
description: Learn how Contoso rehosts an on-premises app with a lift-and-shift migration of on-premises machines to Azure by using the Azure Migrate service.
author: givenscj
ms.author: abuck
ms.date: 07/01/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
services: azure-migrate
---

<!-- cSpell:ignore givenscj WEBVM SQLVM OSTICKETWEB OSTICKETMYSQL contosohost vcenter contosodc NSGs agentless -->

# Rehost an on-premises application on Azure VMs with Azure Migrate

This article demonstrates how the fictional company Contoso rehosts a two-tier Windows .NET front-end application running on VMware VMs by migrating the application VMs to Azure VMs.

The SmartHotel360 application used in this example is provided as open source. If you want to use it for your own testing purposes, download it from [GitHub](https://github.com/Microsoft/SmartHotel360).

## Business drivers

The IT leadership team has worked closely with business partners to understand what they want to achieve with this migration. They want to:

- **Address business growth.** Contoso is growing, and as a result there's pressure on its on-premises systems and infrastructure.
- **Limit risk.** The SmartHotel360 application is critical for the Contoso business. It wants to move the application to Azure with zero risk.
- **Extend.** Contoso doesn't want to modify the application but does want to ensure that it's stable.

## Migration goals

The Contoso cloud team has pinned down goals for this migration. These goals are used to determine the best migration method:

- After migration, the application in Azure should have the same performance capabilities as it does today in VMware. The application will remain as critical in the cloud as it is on-premises.
- Contoso doesn't want to invest in this application. It's important to the business, but in its current form Contoso simply wants to move it safely to the cloud.
- Contoso doesn't want to change the ops model for this application. Contoso does want to interact with it in the cloud in the same way that it does now.
- Contoso doesn't want to change any application functionality. Only the application location will change.

## Solution design

After pinning down goals and requirements, Contoso designs and reviews a deployment solution and identifies the migration process. The Azure services that Contoso will use for the migration also are identified.

### Current application

- The application is tiered across two VMs (`WEBVM` and `SQLVM`).
- The VMs are located on VMware ESXi host `contosohost1.contoso.com` (version 6.5).
- The VMware environment is managed by vCenter Server 6.5 (`vcenter.contoso.com`) running on a VM.
- Contoso has an on-premises datacenter (`contoso-datacenter`) with an on-premises domain controller (`contosodc1`).

### Proposed architecture

- Because the application is a production workload, the application VMs in Azure will reside in the production resource group `ContosoRG`.
- The application VMs will be migrated to the primary Azure region (East US 2) and placed in the production network (`VNET-PROD-EUS2`).
- The web front-end VM will reside in the front-end subnet (`PROD-FE-EUS2`) in the production network.
- The database VM will reside in the database subnet (`PROD-DB-EUS2`) in the production network.
- The on-premises VMs in the Contoso datacenter will be decommissioned after the migration is done.

![Diagram of the scenario architecture.](./media/contoso-migration-rehost-vm/architecture.png)

### Database considerations

As part of the solution design process, Contoso did a feature comparison between Azure SQL Database and SQL Server. The following considerations helped the company to decide to use SQL Server running on an Azure infrastructure as a service (IaaS) VM:

- Using an Azure VM running SQL Server seems to be an optimal solution if Contoso needs to customize the operating system and the database, or if it might want to colocate and run third-party applications on the same VM.
- With Software Assurance, in the future Contoso can exchange existing licenses for discounted rates on a SQL Managed Instance by using the Azure Hybrid Benefit for SQL Server. This option can save up to 30 percent on SQL Managed Instance.

### Solution review

Contoso evaluates the proposed design by putting together a list of pros and cons.

| Consideration | Details |
| --- | --- |
| **Pros** | Both the application VMs will be moved to Azure without changes, which makes the migration simple. <br><br> Because Contoso is using a lift-and-shift approach for both application VMs, no special configuration or migration tools are needed for the application database. <br><br> Contoso can take advantage of its investment in Software Assurance by using the Azure Hybrid Benefit. <br><br> Contoso will retain full control of the application VMs in Azure. |
| **Cons** | `WEBVM` and `SQLVM` are running Windows Server 2008 R2. The operating system is supported by Azure for specific roles. To learn more, see [Microsoft server software support for Microsoft Azure virtual machines](https://support.microsoft.com/help/2721672/microsoft-server-software-support-for-microsoft-azure-virtual-machines). <br><br> The web and data tiers of the application remain as single points of failure. <br><br> SQLVM is running on SQL Server 2008 R2, which is no longer in mainstream support. But it is supported for Azure VMs. To learn more, see [Extend support for SQL Server 2008 and SQL Server 2008 R2 with Azure](https://docs.microsoft.com/azure/virtual-machines/windows/sql/virtual-machines-windows-sql-server-2008-eos-extend-support). <br><br> Contoso must continue supporting the application on Azure VMs rather than moving to a managed service, such as Azure App Service and Azure SQL Database. |

### Migration process

Contoso will migrate the application front-end and database VMs to Azure VMs by using the Azure Migrate: Server Migration tool agentless method.

- As a first step, Contoso prepares and sets up Azure components for Azure Migrate: Server Migration and prepares the on-premises VMware infrastructure.
- Contoso already has the [Azure infrastructure](./contoso-migration-infrastructure.md) in place, so it just needs to configure the replication of the VMs through the Azure Migrate: Server Migration tool.
- With everything prepared, Contoso can start replicating the VMs.
- After replication is enabled and working, Contoso will migrate the VM by testing the migration and, if successful, failing it over to Azure.

![Diagram of the migration process.](./media/contoso-migration-rehost-vm/migration-process-az-migrate.png)

### Azure services

| Service | Description | Cost |
| --- | --- | --- |
| [Azure Migrate: Server Migration](https://docs.microsoft.com/azure/migrate/contoso-migration-rehost-vm) | The service orchestrates and manages migration of on-premises applications and workloads and Amazon Web Services (AWS)/Google Cloud Platform (GCP) VM instances. | During replication to Azure, Azure Storage charges are incurred. Azure VMs are created, and incur charges, when the migration occurs and the VMs are running in Azure. Learn more about [charges and pricing](https://azure.microsoft.com/pricing/details/azure-migrate).  |

## Prerequisites

Here's what Contoso needs to run this scenario.

| Requirements | Details |
| --- | --- |
| **Azure subscription** | Contoso created subscriptions in an earlier article in this series. If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/free). <br><br> If you create a free account, you're the administrator of your subscription and can perform all actions. <br><br> If you use an existing subscription and you're not the administrator, work with the admin to assign you Owner or Contributor permissions. <br><br> If you need more granular permissions, review [this article](https://docs.microsoft.com/azure/site-recovery/site-recovery-role-based-linked-access-control). |
| **Azure infrastructure** | Learn how Contoso set up an [Azure infrastructure](./contoso-migration-infrastructure.md). <br><br> Learn more about specific [prerequisites](./contoso-migration-devtest-to-iaas.md#prerequisites) requirements for Azure Migrate: Server Migration. |
| **On-premises servers** | On-premises vCenter servers should be running version 5.5, 6.0, 6.5, or 6.7. <br><br> ESXi hosts should run version 5.5, 6.0, 6.5, or 6.7. <br><br> One or more VMware VMs should be running on the ESXi host. |

## Scenario steps

Here's how Contoso admins will run the migration:

> [!div class="checklist"]
>
> - **Step 1: Prepare Azure for Azure Migrate: Server Migration.** They add the server migration tool to their Azure Migrate project.
> - **Step 2: Prepare on-premises VMware for Azure Migrate: Server Migration.** They prepare accounts for VM discovery and prepare to connect to Azure VMs after migration.
> - **Step 3: Replicate VMs.** They set up replication and start replicating VMs to Azure Storage.
> - **Step 4: Migrate the VMs with Azure Migrate: Server Migration.** They run a test migration to make sure everything's working and then run a full migration to move the VMs to Azure.

## Step 1: Prepare Azure for the Azure Migrate: Server Migration tool

Here are the Azure components Contoso needs to migrate the VMs to Azure:

- A virtual network in which Azure VMs will be located when they're created during migration.
- The Azure Migrate: Server Migration tool (OVA) provisioned and configured.

Contoso admins set up these components as follows:

1. Set up a network. Contoso already set up a network that can be used for Azure Migrate: Server Migration when it [deployed the Azure infrastructure](./contoso-migration-infrastructure.md)

    - The SmartHotel360 application is a production application, and the VMs will be migrated to the Azure production network (`VNET-PROD-EUS2`) in the primary region (`East US 2`).
    - Both VMs will be placed in the `ContosoRG` resource group, which is used for production resources.
    - The application front-end VM (`WEBVM`) will migrate to the front-end subnet (`PROD-FE-EUS2`) in the production network.
    - The application database VM (`SQLVM`) will migrate to the database subnet (`PROD-DB-EUS2`) in the production network.

1. Provision the Azure Migrate: Server Migration tool.

    1. From Azure Migrate, download the OVA image and import it into VMware.

        ![Screenshot that shows downloading the OVA file.](./media/contoso-migration-rehost-vm/migration-download-ova.png)

    1. Start the imported image and configure the tool, which includes the following steps:

       1. Set up the prerequisites.

          ![Screenshot that shows setting up prerequisites.](./media/contoso-migration-rehost-vm/migration-setup-prerequisites.png)

       1. Point the tool to the Azure subscription.

          ![Screenshot that shows selecting the subscription.](./media/contoso-migration-rehost-vm/migration-register-azure.png)

       1. Set the VMware vCenter credentials.

           ![Screenshot that shows setting the VMware vCenter credentials.](./media/contoso-migration-rehost-vm/migration-vcenter-server.png)

       1. Add any Windows-based credentials for discovery.

          ![Screenshot that shows setting Windows credentials.](./media/contoso-migration-rehost-vm/migration-credentials.png)

1. After configuration, it takes some time for the tool to enumerate all the virtual machines. After the process is finished, the Contoso admins can see the VMs populated in the Azure Migrate tool in Azure.

**Need more help?**

Learn about how to set up the [Azure Migrate: Server Migration tool](https://docs.microsoft.com/azure/migrate/migrate-services-overview#azure-migrate-server-migration-tool).

### Prepare on-premises VMs

After migration, Contoso wants to connect to the Azure VMs and allow Azure to manage the VMs. Contoso admins must do the following before migration:

1. For access over the internet, they:

    - Enable RDP or SSH on the on-premises VM before migration.
    - Ensure that TCP and UDP rules are added for the **Public** profile.
    - Check that RDP or SSH is allowed in the operating system firewall.

1. For access over site-to-site VPN, they:

    - Enable RDP or SSH on the on-premises VM before migration.
    - Check that RDP or SSH is allowed in the operating system firewall.
    - For Windows, set the operating system's SAN policy on the on-premises VM to **OnlineAll**.

1. They install the Azure agent.

    - [Azure Windows agent](https://docs.microsoft.com/azure/virtual-machines/extensions/agent-windows)

1. Other considerations:

   - For Windows, there should be no Windows updates pending on the VM when triggering a migration. If there are, they won't be able to log in to the VM until the update completes.
   - After migration, they can check **boot diagnostics** to view a screenshot of the VM. If this doesn't work, they should verify that the VM is running, and review these [troubleshooting tips](https://social.technet.microsoft.com/wiki/contents/articles/31666.troubleshooting-remote-desktop-connection-after-failover-using-asr.aspx).

**Need more help?**

Learn about how to [prepare VMs for migration](https://docs.microsoft.com/azure/migrate/prepare-for-migration).

## Step 2: Replicate the on-premises VMs

Before Contoso admins can run a migration to Azure, they need to set up and enable replication.

With discovery completed, they can begin replication of VMware VMs to Azure.

1. In the Azure Migrate project, go to **Servers** > **Azure Migrate: Server Migration**. Then select **Replicate**.

    ![Screenshot that shows the Replicate option.](./media/contoso-migration-rehost-vm/select-replicate.png)

1. In **Replicate** > **Source settings** > **Are your machines virtualized?**, select **Yes, with VMware vSphere**.

1. In **On-premises appliance**, select the name of the Azure Migrate appliance that was set up, and then select **OK**.

    ![Screenshot that shows the Source settings tab.](./media/contoso-migration-rehost-vm/source-settings.png)

1. In **Virtual machines**, select the machines you want to replicate.
    - If you've run an assessment for the VMs, you can apply VM sizing and disk type (premium/standard) recommendations from the assessment results. In **Import migration settings from an Azure Migrate assessment?**, select the **Yes** option.
    - If you didn't run an assessment, or you don't want to use the assessment settings, select the **No** option.
    - If you selected to use the assessment, select the VM group and assessment name.

    ![Screenshot that shows selecting assessments.](./media/contoso-migration-rehost-vm/select-assessment.png)

1. In **Virtual machines**, search for VMs as needed and check each VM you want to migrate. Then select **Next: Target settings**.

1. In **Target settings**, select the subscription and target region to which you'll migrate. Specify the resource group in which the Azure VMs will reside after migration. In **Virtual Network**, select the Azure virtual network/subnet to which the Azure VMs will be joined after migration.

1. In **Azure Hybrid Benefit**, select the following:

    - Select **No** if you don't want to apply Azure Hybrid Benefit. Then select **Next**.
    - Select **Yes** if you have Windows Server machines that are covered with active Software Assurance or Windows Server subscriptions and you want to apply the benefit to the machines you're migrating. Then select **Next**.

1. In **Compute**, review the VM name, size, OS disk type, and availability set. VMs must conform with [Azure requirements](https://docs.microsoft.com/azure/migrate/migrate-support-matrix-vmware#vmware-requirements).

    - **VM size:** If you're using assessment recommendations, the VM size drop-down list contains the recommended size. Otherwise, Azure Migrate picks a size based on the closest match in the Azure subscription. Alternatively, you can pick a manual size in **Azure VM size.**
    - **OS disk:** Specify the OS (boot) disk for the VM. The OS disk is the disk that has the operating system bootloader and installer.
    - **Availability set:** If the VM should be in an Azure availability set after migration, specify the set. The set must be in the target resource group you specified for the migration.

1. In **Disks**, specify whether the VM disks should be replicated to Azure. Select the disk type (standard SSD/HDD or premium-managed disks) in Azure, and select **Next**.
    - You can exclude disks from replication.
    - If disks are excluded, they won't be present on the Azure VM after migration.

1. In **Review + start replication**, review the settings. Then select **Replicate** to start the initial replication for the servers.

> [!NOTE]
> Replication settings can be updated any time before replication starts in **Manage** > **Replicating machines**. Settings can't be changed after replication starts.

## Step 3: Migrate the VMs

Contoso admins run a quick test migration and then a full migration to migrate the VMs.

### Run a test migration

1. In **Migration goals** > **Servers** > **Azure Migrate: Server Migration**, select **Test migrated servers**.

     ![Screenshot that shows the Test migrated servers item.](./media/contoso-migration-rehost-vm/test-migrated-servers.png)

1. Select and hold (or right-click) the VM to test, then select **Test migrate**.

    ![Screenshot that shows the Test migrate item.](./media/contoso-migration-rehost-vm/test-migrate.png)

1. In **Test Migration**, select the Azure virtual network in which the Azure VM will be located after the migration. We recommend the use of a nonproduction virtual network.
1. The **Test migration** job starts. Monitor the job in the portal notifications.
1. After the migration finishes, view the migrated Azure VM in **Virtual Machines** in the Azure portal. The machine name has a suffix **-Test**.
1. After the test is done, select and hold (or right-click) the Azure VM in **Replicating machines** and then select **Clean up test migration**.

    ![Screenshot that shows the Clean up test migration item.](./media/contoso-migration-rehost-vm/clean-up.png)

### Migrate the VMs

Now Contoso admins run a full migration.

1. In the Azure Migrate project, go to **Servers** > **Azure Migrate: Server Migration**, and select **Replicating servers**.

    ![Screenshot that shows the Replicating servers item.](./media/contoso-migration-rehost-vm/replicating-servers.png)

1. In **Replicating machines**, select and hold (or right-click) the VM > **Migrate**.
1. In **Migrate** > **Shut down virtual machines and perform a planned migration with no data loss**, select **Yes** > **OK**.
    - By default, Azure Migrate shuts down the on-premises VM and runs an on-demand replication to synchronize any VM changes that occurred since the last replication occurred. This action ensures no data loss.
    - If you don't want to shut down the VM, select **No**.
1. A migration job starts for the VM. Track the job in Azure notifications.
1. After the job finishes, you can view and manage the VM from the **Virtual Machines** page.

**Need more help?**

- Learn about how to [run a test migration](https://docs.microsoft.com/azure/migrate/tutorial-migrate-vmware#run-a-test-migration).
- Learn about how to [migrate VMs to Azure](https://docs.microsoft.com/azure/migrate/tutorial-migrate-vmware#migrate-vms).

## Clean up after migration

With migration complete, the SmartHotel360 application tiers are now running on Azure VMs.

Now, Contoso needs to do these cleanup steps:

- After the migration is complete, stop replication.
- Remove the `WEBVM` machine from the vCenter inventory.
- Remove the `SQLVM` machine from the vCenter inventory.
- Remove `WEBVM` and `SQLVM` from local backup jobs.
- Update internal documentation to show the new location and IP addresses for the VMs.
- Review any resources that interact with the VMs. Update any relevant settings or documentation to reflect the new configuration.

## Review the deployment

With the application now running, Contoso needs to fully operationalize and secure it in Azure.

### Security

The Contoso security team reviews the Azure VMs to determine any security issues.

- To control access, the team reviews the network security groups (NSGs) for the VMs. NSGs are used to ensure that only traffic allowed to the application can reach it.
- The team also considers securing the data on the disk by using Azure Disk Encryption and Azure Key Vault.

For more information, see [Security best practices for IaaS workloads in Azure](https://docs.microsoft.com/azure/security/fundamentals/iaas).

## Business continuity and disaster recovery

For business continuity and disaster recovery (BCDR), Contoso takes the following actions:

- **Keep data safe:** Contoso backs up the data on the VMs by using [Azure Backup](https://docs.microsoft.com/azure/backup/backup-overview).
- **Keep applications up and running:** Contoso [replicates the application VMs in Azure to a secondary region using Site Recovery](https://docs.microsoft.com/azure/site-recovery/azure-to-azure-quickstart).

### Licensing and cost optimization

- Contoso has existing licensing for its VMs and will take advantage of the Azure Hybrid Benefit. Contoso will convert the existing Azure VMs to take advantage of this pricing.
- Contoso will enable [Azure Cost Management and Billing](https://docs.microsoft.com/azure/cost-management-billing/cost-management-billing-overview) to help monitor and manage the Azure resources.

## Conclusion

In this article, Contoso rehosted the SmartHotel360 application in Azure by migrating the application VMs to Azure VMs by using the Azure Migrate: Server Migration tool.
