---
title: Rehost an application on Azure VMs by using Azure Migrate
description: Learn how Contoso uses the Azure Migrate service to perform a lift-and-shift migration of on-premises machines to Azure and rehost an on-premises application.
author: givenscj
ms.author: abuck
ms.date: 07/01/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
ms.custom: think-tank
---

<!-- cSpell:ignore WEBVM SQLVM OSTICKETWEB OSTICKETMYSQL contosohost vcenter contosodc NSGs agentless -->

# Rehost an on-premises application on Azure VMs by using Azure Migrate

This article demonstrates how the fictional company Contoso rehosts a two-tier Windows .NET front-end application running on VMware virtual machines (VMs) by migrating application VMs to Azure VMs.

The SmartHotel360 application used in this example is provided as open-source software. If you want to use it for your own testing purposes, you can download it from [GitHub](https://github.com/Microsoft/SmartHotel360).

## Business drivers

The IT leadership team has worked closely with business partners to understand what they want to achieve with this migration. They want to:

- **Address business growth.** Contoso is growing, so there's pressure on the company's on-premises systems and infrastructure.
- **Limit risk.** The SmartHotel360 application is critical for the Contoso business. The company wants to move the application to Azure with zero risk.
- **Extend.** Contoso doesn't want to modify the application, but it does want to ensure that the application is stable.

## Migration goals

The Contoso cloud team has pinned down goals for this migration. It used these goals to determine the best migration method:

- After migration, the application in Azure should have the same performance capabilities as it does today in VMware. The application will remain as critical in the cloud as it is on-premises.
- Although this application is important to Contoso, the company doesn't want to invest in it at this time. Contoso wants to move the application safely to the cloud in its current form.
- Contoso doesn't want to change the ops model for this application. Contoso does want to interact with it in the cloud in the same way that it does now.
- Contoso doesn't want to change any application functionality. Only the application location will change.

## Solution design

After establishing goals and requirements, Contoso designs and reviews a deployment solution. Contoso identifies the migration process, including the Azure services that it will use for the migration.

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

![Diagram that shows the scenario architecture.](./media/contoso-migration-rehost-vm/architecture.png)

### Database considerations

As part of the solution design process, Contoso did a feature comparison between Azure SQL Database and SQL Server. The following considerations helped the company to decide to use SQL Server running on an Azure IaaS VM:

- Using an Azure VM running SQL Server seems to be an optimal solution if Contoso needs to customize the operating system and the database, or co-locate and run partner applications on the same VM.
- With Software Assurance, Contoso can later exchange existing licenses for discounted rates on Azure SQL Managed Instance by using the Azure Hybrid Benefit for SQL Server. This can save up to 30 percent on SQL Managed Instance.

### Solution review

Contoso evaluates the proposed design by putting together a list of pros and cons.

| Consideration | Details |
| --- | --- |
| **Pros** | Both the application VMs will be moved to Azure without changes, making the migration simple. <br><br> Because Contoso is using a lift-and-shift approach for both application VMs, it doesn't need any special configuration or migration tools for the application database. <br><br> Contoso can take advantage of its investment in Software Assurance by using the Azure Hybrid Benefit. <br><br> Contoso will retain full control of the application VMs in Azure. |
| **Cons** | `WEBVM` and `SQLVM` are running Windows Server 2008 R2. Azure supports the operating system for specific roles. [Learn more](/troubleshoot/azure/virtual-machines/server-software-support). <br><br> The web and data tiers of the application remain as single points of failure. <br><br> `SQLVM` is running on SQL Server 2008 R2. SQL Server 2008 R2 is no longer in mainstream support, but it is supported for Azure VMs. [Learn more](/azure/azure-sql/virtual-machines/windows/sql-server-2008-extend-end-of-support). <br><br> Contoso must continue supporting the application on Azure VMs rather than moving to a managed service such as Azure App Service or Azure SQL Database. |

### Migration process

Contoso will migrate the application front-end and database VMs to Azure VMs by using the agentless method in the Azure Migrate: Server Migration tool.

- As a first step, Contoso prepares and sets up Azure components for Azure Migrate: Server Migration, and prepares the on-premises VMware infrastructure.
- The [Azure infrastructure](./contoso-migration-infrastructure.md) is in place, so Contoso just needs to configure the replication of the VMs through the Azure Migrate: Server Migration tool.
- With everything prepared, Contoso can start replicating the VMs.
- After replication is enabled and working, Contoso will migrate the VM by testing the migration and failing it over to Azure, if successful.

![Diagram that shows the steps in the migration process.](./media/contoso-migration-rehost-vm/migration-process-az-migrate.png)

### Azure services

| Service | Description | Cost |
| --- | --- | --- |
| [Azure Migrate: Server Migration](../index.md) | The service orchestrates and manages migration of on-premises applications and workloads as well as Amazon Web Services (AWS) and Google Cloud Platform (GCP) VM instances. | During replication to Azure, Azure Storage charges are incurred. Azure VMs are created, and incur charges, when the migration occurs and the VMs are running in Azure. Learn more about [charges and pricing](https://azure.microsoft.com/pricing/details/azure-migrate/). |

## Prerequisites

Contoso and other users must meet the following prerequisites for this scenario.

| Requirements | Details |
| --- | --- |
| **Azure subscription** | Contoso created subscriptions in an earlier article in this series. If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/free/). <br><br> If you create a free account, you're the administrator of your subscription and can perform all actions. <br><br> If you use an existing subscription and you're not the administrator, work with the admin to assign you Owner or Contributor permissions. <br><br> If you need more granular permissions, see [Manage Site Recovery access with Azure role-based access control](/azure/site-recovery/site-recovery-role-based-linked-access-control). |
| **Azure infrastructure** | Learn how Contoso [set up an Azure infrastructure](./contoso-migration-infrastructure.md). <br><br> Learn more about specific [prerequisites](./contoso-migration-devtest-to-iaas.md#prerequisites) for Azure Migrate: Server Migration. |
| **On-premises servers** | On-premises vCenter servers should be running version 5.5, 6.0, 6.5, or 6.7. <br><br> ESXi hosts should run version 5.5, 6.0, 6.5, or 6.7. <br><br> One or more VMware VMs should be running on the ESXi host. |

## Scenario steps

Here's how Contoso admins will run the migration:

> [!div class="checklist"]
>
> - **Step 1: Prepare Azure for Azure Migrate: Server Migration.** They add the server migration tool to their Azure Migrate project.
> - **Step 2: Replicate on-premises VMs.** They set up replication and start replicating VMs to Azure Storage.
> - **Step 3: Migrate the VMs with Azure Migrate: Server Migration.** They run a test migration to make sure everything's working, and then run a full migration to move the VMs to Azure.

## Step 1: Prepare Azure for Azure Migrate: Server Migration

To migrate the VMs to Azure, Contoso needs a virtual network in which Azure VMs will be located when they're created during migration. It also needs the Azure Migrate: Server Migration tool (OVA file) provisioned and configured.

1. Set up a network. Contoso already set up one that can be used for Azure Migrate: Server Migration when it [deployed the Azure infrastructure](./contoso-migration-infrastructure.md).

    - The SmartHotel360 application is a production application, and the VMs will be migrated to the Azure production network (`VNET-PROD-EUS2`) in the primary region (`East US 2`).
    - Both VMs will be placed in the `ContosoRG` resource group, which is used for production resources.
    - The application front-end VM (`WEBVM`) will migrate to the front-end subnet (`PROD-FE-EUS2`) in the production network.
    - The application database VM (`SQLVM`) will migrate to the database subnet (`PROD-DB-EUS2`) in the production network.

1. Provision the Azure Migrate: Server Migration tool.

    1. From Azure Migrate, download the OVA image and import it into VMware.

       ![Screenshot that shows the **Download** button for the O V A file.](./media/contoso-migration-rehost-vm/migration-download-ova.png)

    1. Start the imported image and configure the tool, including the following steps:

       - Set up the prerequisites.

         ![Screenshot that shows the area for setting up prerequisite license terms.](./media/contoso-migration-rehost-vm/migration-setup-prerequisites.png)

       - Point the tool to the Azure subscription.

         ![Screenshot that shows selections for registering with Azure Migrate.](./media/contoso-migration-rehost-vm/migration-register-azure.png)

       - Set the VMware vCenter credentials.

         ![Screenshot that shows selections for specifying a vCenter server.](./media/contoso-migration-rehost-vm/migration-vcenter-server.png)

       - Add any Windows-based credentials for discovery.

         ![Screenshot of the area for discovering applications and dependencies on virtual machines.](./media/contoso-migration-rehost-vm/migration-credentials.png)

When you complete the configuration, the tool will take some time to enumerate all the VMs. You'll see them populate the Azure Migrate tool in Azure when this process finishes.

**Need more help?**

Learn about how to set up the [Azure Migrate: Server Migration tool](/azure/migrate/migrate-services-overview#azure-migrate-server-migration-tool).

### Prepare on-premises VMs

After migration, Contoso wants to connect to the Azure VMs and allow Azure to manage the VMs. The Contoso admins must do the following steps before migration:

1. For access over the internet:

    - Enable RDP or SSH on the on-premises VM before migration.
    - Ensure that TCP and UDP rules are added for the **Public** profile.
    - Check that RDP or SSH is allowed in the operating system firewall.

2. For access over Site-to-Site VPN:

    - Enable RDP or SSH on the on-premises VM before migration.
    - Check that RDP or SSH is allowed in the operating system firewall.
    - For Windows, set the operating system's SAN policy on the on-premises VM to **OnlineAll**.

3. Install the [Azure Windows agent](/azure/virtual-machines/extensions/agent-windows).

Other considerations:

- For Windows, there should be no Windows updates pending on the VM when you're triggering a migration. If there are, the admins won't be able to sign in to the VM until the updates finish.
- After migration, the admins can check **Boot diagnostics** to view a screenshot of the VM. If this doesn't work, they should verify that the VM is running and review [troubleshooting tips](https://social.technet.microsoft.com/wiki/contents/articles/31666.troubleshooting-remote-desktop-connection-after-failover-using-asr.aspx).

**Need more help?**

Learn about how to [prepare VMs for migration](/azure/migrate/prepare-for-migration).

## Step 2: Replicate the on-premises VMs

Before the Contoso admins can run a migration to Azure, they need to set up and enable replication.

With discovery completed, they can begin replication of VMware VMs to Azure.

1. In the Azure Migrate project, go to **Servers** > **Azure Migrate: Server Migration**. Then select **Replicate**.

    ![Screenshot of selections for replicating virtual machines.](./media/contoso-migration-rehost-vm/select-replicate.png)

2. In **Replicate** > **Source settings** > **Are your machines virtualized?**, select **Yes, with VMware vSphere**.

3. In **On-premises appliance**, select the name of the Azure Migrate appliance that you set up, and then select **OK**.

    ![Screenshot that shows source settings.](./media/contoso-migration-rehost-vm/source-settings.png)

4. In **Virtual machines**, select the machines that you want to replicate.
    - If you've run an assessment for the VMs, you can apply VM sizing and disk type (premium or standard) recommendations from the assessment results. To do this, in **Import migration settings from an Azure Migrate assessment?**, select the **Yes** option.
    - If you didn't run an assessment, or you don't want to use the assessment settings, select the **No** option.
    - If you selected to use the assessment, select the VM group and assessment name.

    ![Screenshot that shows the box for selecting virtual machines to be migrated.](./media/contoso-migration-rehost-vm/select-assessment.png)

5. In **Virtual machines**, search for VMs as needed and check each VM that you want to migrate. Then select **Next: Target settings**.

6. In **Target settings**, select the subscription and target region to which you'll migrate. Then specify the resource group in which the Azure VMs will reside after migration. In **Virtual Network**, select the Azure virtual network or subnet to which the Azure VMs will be joined after migration.

7. In **Azure Hybrid Benefit**:

    - Select **No** if you don't want to apply Azure Hybrid Benefit. Then select **Next**.
    - Select **Yes** if you have Windows Server machines that are covered with active Software Assurance or Windows Server subscriptions and you want to apply the benefit to the machines that you're migrating. Then select **Next**.

8. In **Compute**, review the VM name, size, OS disk type, and availability set. VMs must conform with [Azure requirements](/azure/migrate/migrate-support-matrix-vmware#vmware-requirements).

    - **VM size:** If you're using assessment recommendations, the VM size drop-down list will contain the recommended size. Otherwise, Azure Migrate picks a size based on the closest match in the Azure subscription. Alternatively, pick a manual size in **Azure VM size**.
    - **OS disk:** Specify the OS (boot) disk for the VM. The OS disk has the operating system bootloader and installer.
    - **Availability set:** If the VM should be in an Azure availability set after migration, specify the set. The set must be in the target resource group that you specify for the migration.

9. In **Disks**, specify whether the VM disks should be replicated to Azure, and select the disk type (standard SSD/HDD or premium-managed disks) in Azure. Then select **Next**.

   You can exclude disks from replication. If you exclude disks, they won't be present on the Azure VM after migration.

10. In **Review and start replication**, review the settings, and then select **Replicate** to start the initial replication for the servers.

> [!NOTE]
> You can update replication settings at any time before replication starts, in **Manage** > **Replicating machines**. Settings can't be changed after replication starts.

## Step 3: Migrate the VMs with Azure Migrate: Server Migration

The Contoso admins run a quick test migration and then a full migration to migrate the VMs.

### Run a test migration

1. In **Migration goals** > **Servers** > **Azure Migrate: Server Migration**, select **Test migrated servers**.

    ![Screenshot of the button for starting a test of migrated servers.](./media/contoso-migration-rehost-vm/test-migrated-servers.png)

2. Select and hold (or right-click) the VM to test, and then select **Test migrate**.

    ![Screenshot of a selected virtual machine and the button to start the migration test.](./media/contoso-migration-rehost-vm/test-migrate.png)

3. In **Test Migration**, select the Azure virtual network in which the Azure VM will be located after the migration. We recommend that you use a nonproduction virtual network.
4. The **Test migration** job starts. Monitor the job in the portal notifications.
5. After the migration finishes, view the migrated Azure VM in **Virtual Machines** in the Azure portal. The machine name has a **-Test** suffix.
6. After the test is done, select and hold (or right-click) the Azure VM in **Replicating machines**, and then select **Clean up test migration**.

    ![Screenshot of the selections for cleaning up migration.](./media/contoso-migration-rehost-vm/clean-up.png)

### Migrate the VMs

Now the Contoso admins run a full migration.

1. In the Azure Migrate project, select **Servers** > **Azure Migrate: Server Migration** > **Replicating servers**.

    ![Screenshot of the selections for replicating servers.](./media/contoso-migration-rehost-vm/replicating-servers.png)

2. In **Replicating machines**, select and hold (or right-click) the VM, and then select **Migrate**.
3. In **Migrate** > **Shut down virtual machines and perform a planned migration with no data loss**, select **Yes** > **OK**.

    By default, Azure Migrate shuts down the on-premises VM and runs an on-demand replication to synchronize any VM changes that occurred since the last replication. This ensures no data loss. If you don't want to shut down the VM, select **No**.
4. A migration job starts for the VM. Track the job in Azure notifications.
5. After the job finishes, you can view and manage the VM from the **Virtual Machines** page.

**Need more help?**

- Learn about how to [run a test migration](/azure/migrate/tutorial-migrate-vmware#run-a-test-migration).
- Learn about how to [migrate VMs to Azure](/azure/migrate/tutorial-migrate-vmware#migrate-vms).

## Clean up after migration

With migration complete, the SmartHotel360 application tiers are now running on Azure VMs.

Now, Contoso needs to do these cleanup steps:

- After the migration is complete, stop replication.
- Remove the `WEBVM` machine from the vCenter inventory.
- Remove the `SQLVM` machine from the vCenter inventory.
- Remove `WEBVM` and `SQLVM` from local backup jobs.
- Update internal documentation to show the new location and IP addresses for the VMs.
- Review any resources that interact with the VMs, and update any relevant settings or documentation to reflect the new configuration.

## Review the deployment

With the application now running, Contoso needs to fully operationalize and secure it in Azure.

### Security

The Contoso security team reviews the Azure VMs to determine any security issues. To control access, the team reviews the network security groups (NSGs) for the VMs. NSGs are used to ensure that only traffic allowed to the application can reach it. The team also considers securing the data on the disk by using Azure Disk Encryption and Key Vault.

For more information, see [Security best practices for IaaS workloads in Azure](/azure/security/fundamentals/iaas).

## Business continuity and disaster recovery

For business continuity and disaster recovery, Contoso takes the following actions:

- Keep data safe: Contoso [backs up the data on the VMs by using Azure Backup](/azure/backup/backup-overview).
- Keep applications up and running: Contoso [replicates the application VMs in Azure to a secondary region by using Azure Site Recovery](/azure/site-recovery/azure-to-azure-quickstart).

### Licensing and cost optimization

Contoso has existing licensing for its VMs and will take advantage of the Azure Hybrid Benefit. Contoso will convert the existing Azure VMs to take advantage of this pricing.

Contoso will enable [Azure Cost Management + Billing](/azure/cost-management-billing/cost-management-billing-overview) to help monitor and manage Azure resources.

## Conclusion

In this article, Contoso rehosted the SmartHotel360 application in Azure. The admins migrated the application VMs to Azure VMs by using the Azure Migrate: Server Migration tool. You can also review the Azure DevOps projects which have been published in the [DevOps generator](https://aka.ms/adopt/plan/generator). Once in the generator, download the [Server Migration Project](https://azuredevopsdemogenerator.azurewebsites.net/?name=servermigration) under the Cloud Adoption Framework navigation.
