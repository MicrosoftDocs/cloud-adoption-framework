---
title: "Rehost an app on Azure VMs with Azure Migrate"
description: Learn how Contoso rehosts an on-premises app with a lift and shift migration of on-premises machines to Azure, using the Azure Migrate service.
author: givenscj
ms.author: abuck
ms.date: 04/02/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
services: azure-migrate
---

<!-- cSpell:ignore givenscj WEBVM SQLVM OSTICKETWEB OSTICKETMYSQL contosohost vcenter contosodc NSGs agentless -->

# Rehost an on-premises app on Azure VMs

This article demonstrates how the fictional company Contoso rehosts a two-tier Windows .NET front-end app running on VMware VMs, by migrating the app VMs to Azure VMs.

The SmartHotel360 app used in this example is provided as open source. If you'd like to use it for your own testing purposes, you can download it from [GitHub](https://github.com/Microsoft/SmartHotel360).

## Business drivers

The IT Leadership team has worked closely with business partners to understand what they want to achieve with this migration:

- **Address business growth.** Contoso is growing, and as a result there is pressure on their on-premises systems and infrastructure.
- **Limit risk.** The SmartHotel360 app is critical for the Contoso business. It wants to move the app to Azure with zero risk.
- **Extend.** Contoso doesn't want to modify the app, but does want to ensure that it's stable.

## Migration goals

The Contoso cloud team has pinned down goals for this migration. These goals are used to determine the best migration method:

- After migration, the app in Azure should have the same performance capabilities as it does today in VMware. The app will remain as critical in the cloud as it is on-premises.
- Contoso doesn't want to invest in this app. It is important to the business, but in its current form Contoso simply wants to move it safely to the cloud.
- Contoso doesn't want to change the ops model for this app. Contoso do want to interact with it in the cloud in the same way that they do now.
- Contoso doesn't want to change any app functionality. Only the app location will change.

## Solution design

After pinning down goals and requirements, Contoso designs and review a deployment solution, and identifies the migration process, including the Azure services that Contoso will use for the migration.

### Current app

- The app is tiered across two VMs (**WEBVM** and **SQLVM**).
- The VMs are located on VMware ESXi host **contosohost1.contoso.com** (version 6.5).
- The VMware environment is managed by vCenter Server 6.5 (**vcenter.contoso.com**), running on a VM.
- Contoso has an on-premises datacenter (contoso-datacenter), with an on-premises domain controller (**contosodc1**).

### Proposed architecture

- Since the app is a production workload, the app VMs in Azure will reside in the production resource group ContosoRG.
- The app VMs will be migrated to the primary Azure region (East US 2) and placed in the production network (VNET-PROD-EUS2).
- The web front-end VM will reside in the front-end subnet (PROD-FE-EUS2) in the production network.
- The database VM will reside in the database subnet (PROD-DB-EUS2) in the production network.
- The on-premises VMs in the Contoso data-center will be decommissioned after the migration is done.

![Scenario architecture](./media/contoso-migration-rehost-vm/architecture.png)

### Database considerations

As part of the solution design process, Contoso did a feature comparison between Azure SQL Database and SQL Server. The following considerations helped them to decide to go with SQL Server running on an Azure IaaS VM:

- Using an Azure VM running SQL Server seems to be an optimal solution if Contoso needs to customize the operating system and the database, or if it might want to colocate and run third-party apps on the same VM.
- With Software Assurance, in future Contoso can exchange existing licenses for discounted rates on a SQL Database Managed Instance using the Azure Hybrid Benefit for SQL Server. This can save up to 30% on Managed Instance.

### Solution review

Contoso evaluates the proposed design by putting together a pros and cons list.

<!-- markdownlint-disable MD033 -->

| **Consideration** | **Details** |
| --- | --- |
| **Pros** | Both the app VMs will be moved to Azure without changes, making the migration simple. <br><br> Since Contoso is using a lift and shift approach for both app VMs, no special configuration or migration tools are needed for the app database. <br><br> Contoso can take advantage of their investment in Software Assurance, using the Azure Hybrid Benefit. <br><br> Contoso will retain full control of the app VMs in Azure. |
| **Cons** | WEBVM and SQLVM are running Windows Server 2008 R2. The operating system is supported by Azure for specific roles. [Learn more](https://support.microsoft.com/help/2721672/microsoft-server-software-support-for-microsoft-azure-virtual-machines). <br><br> The web and data tiers of the app will remain a single point of failure. <br><br> SQLVM is running on SQL Server 2008 R2, which is no longer in mainstream support. However, it is supported for Azure VMs. [Learn more](https://docs.microsoft.com/azure/virtual-machines/windows/sql/virtual-machines-windows-sql-server-2008-eos-extend-support). <br><br> Contoso must continue supporting the app on Azure VMs, rather than moving to a managed service such as Azure App Service and Azure SQL Database. |

<!-- markdownlint-enable MD033 -->

### Migration process

Contoso will migrate the app front-end and database VMs to Azure VMs using the Azure Migrate: Server Migration tool agentless method.

- As a first step, Contoso prepares and sets up Azure components for Azure Migrate: Server Migration, and prepares the on-premises VMware infrastructure.
- They already have the [Azure infrastructure](./contoso-migration-infrastructure.md) in place, so Contoso just needs to add configure the replication of the VMs through the Azure Migrate: Server Migration tool.
- With everything prepared, Contoso can start replicating the VMs.
- After replication is enabled and working, Contoso will migrate the VM by testing the migration and if successful, failing it over to Azure.

![Migration process](./media/contoso-migration-rehost-vm/migration-process-az-migrate.png)

### Azure services

| **Service** | **Description** | **Cost** |
| --- | --- | --- |
| [Azure Migrate: Server Migration](https://docs.microsoft.com/azure/migrate/contoso-migration-rehost-vm) | The service orchestrates and manages migration of your on-premises apps and workloads, and AWS/GCP VM instances. | During replication to Azure, Azure Storage charges are incurred. Azure VMs are created, and incur charges, when the migration occurs and the VMs are running in Azure. [Learn more](https://azure.microsoft.com/pricing/details/azure-migrate) about charges and pricing. |

## Prerequisites

Here's what Contoso needs to run this scenario.

<!-- markdownlint-disable MD033 -->

| **Requirements** | **Details** |
| --- | --- |
| **Azure subscription** | Contoso created subscriptions in an earlier article in this series. If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/pricing/free-trial). <br><br> If you create a free account, you're the administrator of your subscription and can perform all actions. <br><br> If you use an existing subscription and you're not the administrator, you need to work with the admin to assign you Owner or Contributor permissions. <br><br> If you need more granular permissions, review [this article](https://docs.microsoft.com/azure/site-recovery/site-recovery-role-based-linked-access-control). |
| **Azure infrastructure** | [Learn how](./contoso-migration-infrastructure.md) Contoso set up an Azure infrastructure. <br><br> Learn more about specific [prerequisites](https://docs.microsoft.com/azure/migrate/contoso-migration-rehost-vm#prerequisites) requirements for Azure Migrate: Server Migration. |
| **On-premises servers** | On-premises vCenter Servers should be running version 5.5, 6.0, 6.5 or 6.7. <br><br> ESXi hosts should run version 5.5, 6.0, 6.5 or 6.7. <br><br> One or more VMware VMs should be running on the ESXi host. |

<!-- markdownlint-enable MD033 -->

## Scenario steps

Here's how Contoso admins will run the migration:

> [!div class="checklist"]
>
> - **Step 1: Prepare Azure for Azure Migrate: Server Migration.** They add the Server Migration tool to their Azure Migrate project.
> - **Step 2: Prepare on-premises VMware for Azure Migrate: Server Migration.** They prepare accounts for VM discovery, and prepare to connect to Azure VMs after migration.
> - **Step 3: Replicate VMs.** They set up replication, and start replicating VMs to Azure storage.
> - **Step 4: Migrate the VMs with Azure Migrate: Server Migration.** They run a test migration to make sure everything's working, and then run a full migration to move the VMs to Azure.

## Step 1: Prepare Azure for the Azure Migrate: Server Migration tool

Here are the Azure components Contoso needs to migrate the VMs to Azure:

- A VNet in which Azure VMs will be located when they're created during migration.
- The Azure Migrate: Server Migration tool (OVA) provisioned and configured.

They set these up as follows:

1. Set up a network-Contoso already set up a network that can be for Azure Migrate: Server Migration when they [deployed the Azure infrastructure](./contoso-migration-infrastructure.md)

    - The SmartHotel360 app is a production app, and the VMs will be migrated to the Azure production network (VNET-PROD-EUS2) in the primary East US 2 region.
    - Both VMs will be placed in the ContosoRG resource group, which is used for production resources.
    - The app front-end VM (WEBVM) will migrate to the front-end subnet (PROD-FE-EUS2), in the production network.
    - The app database VM (SQLVM) will migrate to the database subnet (PROD-DB-EUS2), in the production network.

2. Provision the Azure Migrate: Server Migration tool.

    - From Azure Migrate, download the OVA image and import it into VMWare.

        ![Download the OVA file](./media/contoso-migration-rehost-vm/migration-download-ova.png)

    - Start the imported image and configure the tool, including the following steps:

      - Set up the prerequisites.

        ![Configure the tool](./media/contoso-migration-rehost-vm/migration-setup-prerequisites.png)

      - Point the tool to the Azure subscription.

        ![Configure the tool](./media/contoso-migration-rehost-vm/migration-register-azure.png)

      - Set the VMWare vCenter credentials.

        ![Configure the tool](./media/contoso-migration-rehost-vm/migration-vcenter-server.png)

      - Add any Windows-based credentials for discovery.

        ![Configure the tool](./media/contoso-migration-rehost-vm/migration-credentials.png)

3. Once configured, it will take some time for the tool to enumerate all the virtual machines. Once complete, you will see them populate in the Azure Migrate tool in Azure.

**Need more help?**

Learn about setting up the [Azure Migrate: Server Migration tool](https://docs.microsoft.com/azure/migrate/migrate-services-overview#azure-migrate-server-migration-tool).
### Prepare on-premises VMs

After migration, Contoso wants to connect to the Azure VMs and allow Azure to manage the VMs. To do this, Contoso admins do the following before migration:

1. For access over the internet, they:

    - Enable RDP or SSH on the on-premises VM before migration.
    - Ensure that TCP and UDP rules are added for the **Public** profile.
    - Check that RDP or SSH is allowed in the operating system firewall.

2. For access over site-to-site VPN, they:

    - Enable RDP or SSH on the on-premises VM before migration.
    - Check that RDP or SSH is allowed in the operating system firewall.
    - For windows, Set the operating system's SAN policy on the on-premises VM to **OnlineAll**.

3. Install the Azure agent.

    - [Azure Windows Agent](https://docs.microsoft.com/azure/virtual-machines/extensions/agent-windows)

4. Other considerations:

   - For Windows, there should be no Windows updates pending on the VM when triggering a migration. If there are, they won't be able to log into the VM until the update completes.
   - After migration, they can check **boot diagnostics** to view a screenshot of the VM. If this doesn't work, they should verify that the VM is running, and review these [troubleshooting tips](https://social.technet.microsoft.com/wiki/contents/articles/31666.troubleshooting-remote-desktop-connection-after-failover-using-asr.aspx).

5. Need more help?

   - Learn about [preparing VMs for migration](https://docs.microsoft.com/azure/migrate/contoso-migration-rehost-vm#prepare-vms-for-migration).

## Step 2: Replicate the on-premises VMs

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

    - **VM size:** If you're using assessment recommendations, the VM size dropdown will contain the recommended size. Otherwise Azure Migrate picks a size based on the closest match in the Azure subscription. Alternatively, pick a manual size in **Azure VM size**.
    - **OS disk:** Specify the OS (boot) disk for the VM. The OS disk is the disk that has the operating system bootloader and installer.
    - **Availability set:** If the VM should be in an Azure availability set after migration, specify the set. The set must be in the target resource group you specify for the migration.

9. In **Disks**, specify whether the VM disks should be replicated to Azure, and select the disk type (standard SSD/HDD or premium-managed disks) in Azure. Then select **Next**.
    - You can exclude disks from replication.
    - If you exclude disks, won't be present on the Azure VM after migration.

10. In **Review and start replication**, review the settings, then select **Replicate** to start the initial replication for the servers.

> [!NOTE]
> You can update replication settings any time before replication starts, in **Manage** > **Replicating machines**. Settings can't be changed after replication starts.

## Step 3: Migrate the VMs

Contoso admins run a quick test migration, and then a full migration to migrate the VMs.

### Run a test migration

1. In **Migration goals** > **Servers** > **Azure Migrate: Server Migration**, select **Test migrated servers**.

     ![Test migrated servers](./media/contoso-migration-rehost-vm/test-migrated-servers.png)

2. Right-click the VM to test, then select **Test migrate**.

    ![Test migration](./media/contoso-migration-rehost-vm/test-migrate.png)

3. In **Test Migration**, select the Azure VNet in which the Azure VM will be located after the migration. We recommend you use a nonproduction VNet.
4. The **Test migration** job starts. Monitor the job in the portal notifications.
5. After the migration finishes, view the migrated Azure VM in **Virtual Machines** in the Azure portal. The machine name has a suffix **-Test**.
6. After the test is done, right-click the Azure VM in **Replicating machines**, then select **Clean up test migration**.

    ![Clean up migration](./media/contoso-migration-rehost-vm/clean-up.png)

### Migrate the VMs

Now Contoso admins run a full migration.

1. In the Azure Migrate project > **Servers** > **Azure Migrate: Server Migration**, then select **Replicating servers**.

    ![Replicating servers](./media/contoso-migration-rehost-vm/replicating-servers.png)

2. In **Replicating machines**, right-click the VM > **Migrate**.
3. In **Migrate** > **Shut down virtual machines and perform a planned migration with no data loss**, select **Yes** > **OK**.
    - By default Azure Migrate shuts down the on-premises VM, and runs an on-demand replication to synchronize any VM changes that occurred since the last replication occurred. This ensures no data loss.
    - If you don't want to shut down the VM, select **No**.
4. A migration job starts for the VM. Track the job in Azure notifications.
5. After the job finishes, you can view and manage the VM from the **Virtual Machines** page.

**Need more help?**

- Learn about [running a test migration](https://docs.microsoft.com/azure/migrate/tutorial-migrate-vmware#run-a-test-migration).
- Learn about [migrating VMs to Azure](https://docs.microsoft.com/azure/migrate/tutorial-migrate-vmware#migrate-vms).

## Clean up after migration

With migration complete, the SmartHotel360 app tiers are now running on Azure VMs.

Now, Contoso needs to complete these cleanup steps:

- After the migration is complete, stop replication.
- Remove the WEBVM machine from the vCenter inventory.
- Remove the SQLVM machine from the vCenter inventory.
- Remove WEBVM and SQLVM from local backup jobs.
- Update internal documentation to show the new location, and IP addresses for the VMs.
- Review any resources that interact with the VMs, and update any relevant settings or documentation to reflect the new configuration.

## Review the deployment

With the app now running, Contoso now needs to fully operationalize and secure it in Azure.

### Security

The Contoso security team reviews the Azure VMs, to determine any security issues.

- To control access, the team reviews the network security groups (NSGs) for the VMs. NSGs are used to ensure that only traffic allowed to the app can reach it.
- The team also consider securing the data on the disk using Azure Disk Encryption and Key Vault.

For more information, see [Security best practices for IaaS workloads in Azure](https://docs.microsoft.com/azure/security/fundamentals/iaas).

## Business continuity and disaster recovery

For business continuity and disaster recovery (BCDR), Contoso takes the following actions:

- Keep data safe: Contoso backs up the data on the VMs using [Azure Backup](https://docs.microsoft.com/azure/backup/backup-overview).
- Keep apps up and running: Contoso [replicates the app VMs in Azure to a secondary region using Site Recovery](https://docs.microsoft.com/azure/site-recovery/azure-to-azure-quickstart).

### Licensing and cost optimization

- Contoso has existing licensing for their VMs, and will take advantage of the Azure Hybrid Benefit. Contoso will convert the existing Azure VMs, to take advantage of this pricing.
- Contoso will enable [Azure Cost Management](https://docs.microsoft.com/azure/cost-management-billing/cost-management-billing-overview) to help monitor and manage the Azure resources.

## Conclusion

In this article, Contoso rehosted the SmartHotel360 app in Azure by migrating the app VMs to Azure VMs using the Azure Migrate: Server Migration tool.
