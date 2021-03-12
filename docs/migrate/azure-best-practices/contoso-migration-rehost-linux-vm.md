---
title: Rehost an on-premises Linux application to Azure VMs
description: Learn how Contoso rehosts an on-premises Linux application by migrating to Azure VMs.
author: deltadan
ms.author: abuck
ms.date: 07/01/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
ms.custom: think-tank
---

<!-- cSpell:ignore OSTICKETWEB OSTICKETMYSQL OSTICKETWEB OSTICKETMYSQL contosohost vcenter contosodc osTicket binlog systemctl NSGs distros -->

# Rehost an on-premises Linux application to Azure VMs

This article shows how the fictional company Contoso rehosts a two-tier [LAMP-based](https://wikipedia.org/wiki/LAMP_software_bundle) application by using Azure infrastructure as a service (IaaS) virtual machines (VMs).

The service desk application used in this example, osTicket, is provided as open-source software. If you want to use it for your own testing purposes, you can download it from [GitHub](https://github.com/osTicket/osTicket).

## Business drivers

The IT leadership team has worked closely with business partners to understand what they want to achieve with this migration:

- **Address business growth.** Contoso is growing, and as a result there's pressure on the on-premises systems and infrastructure.
- **Limit risk.** The service desk application is critical for the Contoso business. Contoso wants to move it to Azure with zero risk.
- **Extend.** Contoso doesn't want to change the application right now. It wants to ensure that the application is stable.

## Migration goals

The Contoso cloud team has pinned down goals for this migration to determine the best migration method:

- After migration, the application in Azure should have the same performance capabilities as it does today in the company's on-premises VMware environment. The application will remain as critical in the cloud as it is on-premises.
- Contoso doesn't want to invest in this application. It's important to the business, but in its current form Contoso simply wants to move it safely to the cloud.
- Contoso doesn't want to change the ops model for this application. It wants to interact with the application in the cloud in the same way that it does now.
- Contoso doesn't want to change application functionality. Only the application location will change.
- Having completed a couple of Windows application migrations, Contoso wants to learn how to use a Linux-based infrastructure in Azure.

## Solution design

After pinning down goals and requirements, Contoso designs and reviews a deployment solution and identifies the migration process. The Azure services that Contoso will use for the migration also are identified.

### Current application

- The osTicket application is tiered across two VMs (`OSTICKETWEB` and `OSTICKETMYSQL`).
- The VMs are located on VMware ESXi host `contosohost1.contoso.com` (version 6.5).
- The VMware environment is managed by vCenter Server 6.5 (`vcenter.contoso.com`) and runs on a VM.
- Contoso has an on-premises datacenter (`contoso-datacenter`) with an on-premises domain controller (`contosodc1`).

### Proposed architecture

- Because the application is a production workload, the VMs in Azure will reside in the production resource group `ContosoRG`.
- The VMs will be migrated to the primary region (East US 2) and placed in the production network (`VNET-PROD-EUS2`):
  - The web VM will reside in the front-end subnet (`PROD-FE-EUS2`).
  - The database VM will reside in the database subnet (`PROD-DB-EUS2`).
- The on-premises VMs in the Contoso datacenter will be decommissioned after the migration is done.

![Diagram of the scenario architecture.](./media/contoso-migration-rehost-linux-vm/architecture.png)

### Solution review

Contoso evaluates the proposed design by putting together a list of pros and cons.

| Consideration | Details |
| --- | --- |
| **Pros** | Both the application VMs will be moved to Azure without changes, which makes the migration simple. <br><br> Because Contoso is using a lift-and-shift approach for both application VMs, no special configuration or migration tools are needed for the application database. <br><br> Contoso will retain full control of the application VMs in Azure. <br><br> The application VMs are running Ubuntu 16.04-TLS, an endorsed Linux distribution. Learn more about [endorsed Linux distributions on Azure](/azure/virtual-machines/linux/endorsed-distros). |
| **Cons** | The web and data tier of the application remain single points of failover. <br><br> Contoso will need to continue supporting the application as Azure VMs rather than moving to a managed service, such as Azure App Service and Azure Database for MySQL. <br><br> Contoso realizes that by keeping things simple with a lift-and-shift VM migration, the company isn't taking full advantage of the features provided by [Azure Database for MySQL](/azure/mysql/overview). These features include built-in high availability, predictable performance, simple scaling, automatic backups, and built-in security. |

### Migration process

Contoso will complete the migration process as follows:

- As a first step, Contoso prepares and sets up Azure components for Azure Migrate: Server Migration and prepares the on-premises VMware infrastructure.
- The company already has the [Azure infrastructure](./contoso-migration-infrastructure.md) in place, so it just needs to configure the replication of the VMs through the Azure Migrate: Server Migration tool.
- With everything prepared, Contoso can start replicating the VMs.
- After replication is enabled and working, Contoso will migrate the VM by failing it over to Azure.

![Diagram of the migration process.](./media/contoso-migration-rehost-linux-vm/migration-process-az-migrate.png)

### Azure services

| Service | Description | Cost |
| --- | --- | --- |
| [Azure Migrate: Server Migration](../index.md) | The service orchestrates and manages migration of your on-premises applications and workloads as well as Amazon Web Services (AWS) and Google Cloud Platform (GCP) VM instances. | During replication to Azure, Azure Storage charges are incurred. Azure VMs are created, and incur charges, when migration occurs. Learn more about [charges and pricing](https://azure.microsoft.com/pricing/details/azure-migrate/). |

## Prerequisites

Here's what Contoso needs for this scenario.

Requirements | Details |
| --- | --- |
| **Azure subscription** | Contoso created subscriptions in an earlier article in this series. If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/free/). <br><br> If you create a free account, you're the administrator of your subscription and can perform all actions. <br><br> If you use an existing subscription and you're not the administrator, work with the admin to assign you Owner or Contributor permissions. <br><br> If you need more granular permissions, see [Manage Site Recovery access with Azure role-based access control (Azure RBAC)](/azure/site-recovery/site-recovery-role-based-linked-access-control). |
| **Azure infrastructure** | Learn how [Contoso set up an Azure infrastructure](./contoso-migration-infrastructure.md). <br><br> Learn more about specific [prerequisites](./contoso-migration-devtest-to-iaas.md#prerequisites) for Azure Migrate: Server Migration. |
| **On-premises servers** | The on-premises vCenter Server should be running version 5.5, 6.0, or 6.5. <br><br> An ESXi host running version 5.5, 6.0, or 6.5. <br><br> One or more VMware VMs running on the ESXi host. |
| **On-premises VMs** | [Review Linux distros](/azure/virtual-machines/linux/endorsed-distros) that are endorsed to run on Azure. |

## Scenario steps

Here's how Contoso will complete the migration:

> [!div class="checklist"]
>
> - **Step 1: Prepare Azure for Azure Migrate: Server Migration.** Add the Azure Migrate: Server Migration tool to the Azure Migrate project.
> - **Step 2: Prepare on-premises VMware for Azure Migrate: Server Migration.** Prepare accounts for VM discovery, and prepare to connect to Azure VMs after migration.
> - **Step 3: Replicate VMs.** Set up replication, and start replicating VMs to Azure Storage.
> - **Step 4: Migrate the VMs with Azure Migrate: Server Migration.** Run a test migration to make sure everything's working, and then run a migration to move the VMs to Azure.

## Step 1: Prepare Azure for the Azure Migrate: Server Migration tool

Here are the Azure components Contoso needs to migrate the VMs to Azure:

- A virtual network in which Azure VMs will be located when they're created during migration.
- The Azure Migrate: Server Migration tool provisioned.

They set up these components as follows:

1. Set up a network. Contoso already set up a network that can be used for Azure Migrate: Server Migration when the company [deployed the Azure infrastructure](./contoso-migration-infrastructure.md)

    - The SmartHotel360 application is a production application. The VMs will be migrated to the Azure production network (`VNET-PROD-EUS2`) in the primary region (`East US 2`).
    - Both VMs will be placed in the `ContosoRG` resource group, which is used for production resources.
    - The application front-end VM (`OSTICKETWEB`) will migrate to the front-end subnet (`PROD-FE-EUS2`) in the production network.
    - The application database VM (`OSTICKETMYSQL`) will migrate to the database subnet (`PROD-DB-EUS2`) in the production network.

1. Provision the Azure Migrate: Server Migration tool. With the network and storage account in place, Contoso now creates a Recovery Services vault (`ContosoMigrationVault`) and places it in the `ContosoFailoverRG` resource group in the primary region (`East US 2`).

    ![Screenshot that shows the Azure Migrate Server Migration tool](./media/contoso-migration-rehost-linux-vm/server-migration-tool.png)

**Need more help?**

Learn about how to [set up the Azure Migrate: Server Migration tool](/azure/migrate/).

## Step 2: Prepare on-premises VMware for Azure Migrate: Server Migration

After migration to Azure, Contoso wants to be able to connect to the replicated VMs in Azure. There are a couple of things that the Contoso admins need to do:

- To access Azure VMs over the internet, they enable SSH on the on-premises Linux VM before migration. For Ubuntu, this step can be completed by using the following command: `sudo apt-get ssh install -y`.
- Install the [Azure Linux agent](/azure/virtual-machines/extensions/agent-linux)
- After they run the migration, they can check **Boot diagnostics** to view a screenshot of the VM.
- If it doesn't work, they'll need to check that the VM is running and review these [troubleshooting tips](https://social.technet.microsoft.com/wiki/contents/articles/31666.troubleshooting-remote-desktop-connection-after-failover-using-asr.aspx).

**Need more help?**

Learn about how to [prepare VMs for migration](/azure/migrate/prepare-for-migration).

## Step 3: Replicate the on-premises VMs

Before Contoso admins can run a migration to Azure, they need to set up and enable replication.

With discovery finished, begin replication of VMware VMs to Azure.

1. In the Azure Migrate project, go to **Servers** > **Azure Migrate: Server Migration**, and select **Replicate**.

    ![Screenshot that shows the Replicate option.](./media/contoso-migration-rehost-linux-vm/select-replicate.png)

2. In **Replicate** > **Source settings** > **Are your machines virtualized?**, select **Yes, with VMware vSphere**.

3. In **On-premises appliance**, select the name of the Azure Migrate appliance that you set up, and then select **OK**.

    ![Screenshot that shows the Source settings tab.](./media/contoso-migration-rehost-linux-vm/source-settings.png)

4. In **Virtual machines**, select the machines you want to replicate.
    - If you've run an assessment for the VMs, you can apply VM sizing and disk type (premium/standard) recommendations from the assessment results. In **Import migration settings from an Azure Migrate assessment?**, select the **Yes** option.
    - If you didn't run an assessment, or you don't want to use the assessment settings, select the **No** option.
    - If you selected to use the assessment, select the VM group and assessment name.

    ![Screenshot that shows selecting assessments.](./media/contoso-migration-rehost-linux-vm/select-assessment.png)

5. In **Virtual machines**, search for VMs as needed, and select each VM you want to migrate. Then select **Next: Target settings**.

6. In **Target settings**, select the subscription and target region to which you'll migrate. Specify the resource group in which the Azure VMs will reside after migration. In **Virtual Network**, select the Azure virtual network/subnet to which the Azure VMs will be joined after migration.

7. In **Azure Hybrid Benefit**:

    - Select **No** if you don't want to apply Azure Hybrid Benefit. Then select **Next**.
    - Select **Yes** if you have Windows Server machines that are covered with active Software Assurance or Windows Server subscriptions and you want to apply the benefit to the machines you're migrating. Then select **Next**.

8. In **Compute**, review the VM name, size, OS disk type, and availability set. VMs must conform with [Azure requirements](/azure/migrate/migrate-support-matrix-vmware#vmware-requirements).

    - **VM size:** If you're using assessment recommendations, the VM size drop-down list will contain the recommended size. Otherwise, Azure Migrate picks a size based on the closest match in the Azure subscription. Alternatively, pick a manual size in **Azure VM size**.
    - **OS disk:** Specify the OS (boot) disk for the VM. The OS disk is the disk that has the operating system bootloader and installer.
    - **Availability set:** If the VM should be in an Azure availability set after migration, specify the set. The set must be in the target resource group you specify for the migration.

9. In **Disks**, specify whether the VM disks should be replicated to Azure. Select the disk type (standard SSD/HDD or premium-managed disks) in Azure. Then select **Next**.
    - You can exclude disks from replication.
    - If you exclude disks, they won't be present on the Azure VM after migration.

10. In **Review + Start replication**, review the settings. Then select **Replicate** to start the initial replication for the servers.

> [!NOTE]
> You can update replication settings any time before replication starts in **Manage** > **Replicating machines**. Settings can't be changed after replication starts.

## Step 4: Migrate the VMs

Contoso admins run a quick test migration and then a migration to move the VMs.

### Run a test migration

1. In **Migration goals** > **Servers** > **Azure Migrate: Server Migration**, select **Test migrated servers**.

     ![Screenshot that shows the Test migrated servers option.](./media/contoso-migration-rehost-linux-vm/test-migrated-servers.png)

1. Select and hold (or right-click) the VM to test. Then select **Test migrate**.

    ![Screenshot that shows the Test migrate item.](./media/contoso-migration-rehost-linux-vm/test-migrate.png)

1. In **Test Migration**, select the Azure virtual network in which the Azure VM will be located after the migration. We recommend you use a nonproduction virtual network.
1. The **Test migration** job starts. Monitor the job in the portal notifications.
1. After the migration finishes, view the migrated Azure VM in **Virtual Machines** in the Azure portal. The machine name has a suffix **-Test**.
1. After the test is done, select and hold (or right-click) the Azure VM in **Replicating machines**. Then select **Clean up test migration**.

    ![Screenshot that shows the Clean up test migration item.](./media/contoso-migration-rehost-linux-vm/clean-up.png)

### Migrate the VMs

Now Contoso admins run a full migration to complete the move.

1. In the Azure Migrate project, go to **Servers** > **Azure Migrate: Server Migration**, and select **Replicating servers**.

    ![Screenshot that shows the Replicating servers option.](./media/contoso-migration-rehost-linux-vm/replicating-servers.png)

1. In **Replicating machines**, select and hold (or right-click) the VM and select **Migrate**.
1. In **Migrate** > **Shut down virtual machines and perform a planned migration with no data loss**, select **Yes** > **OK**.
    - By default, Azure Migrate shuts down the on-premises VM and runs an on-demand replication to synchronize any VM changes that occurred since the last replication occurred. This action ensures no data loss.
    - If you don't want to shut down the VM, select **No**.
1. A migration job starts for the VM. Track the job in Azure notifications.
1. After the job finishes, you can view and manage the VM from the **Virtual Machines** page.

### Connect the VM to the database

As the final step in the migration process, Contoso admins update the connection string of the application to point to the application database running on the `OSTICKETMYSQL` VM.

1. Make an SSH connection to the `OSTICKETWEB` VM by using PuTTY or another SSH client. The VM is private, so connect by using the private IP address.

    ![Screenshot that shows the Connect to virtual machine pane.](./media/contoso-migration-rehost-linux-vm/db-connect.png)

    ![Screenshot that shows the connection to the database.](./media/contoso-migration-rehost-linux-vm/db-connect2.png)

1. Make sure that the `OSTICKETWEB` VM can communicate with the `OSTICKETMYSQL` VM. Currently, the configuration is hardcoded with the on-premises IP address `172.16.0.43`.

    **Before the update:**

    ![Screenshot that shows the IP before the update.](./media/contoso-migration-rehost-linux-vm/update-ip1.png)

    **After the update:**

    ![Screenshot that shows the IP after the update.](./media/contoso-migration-rehost-linux-vm/update-ip2.png)

1. Restart the service with **systemctl restart apache2**.

    ![Screenshot that shows the service restart.](./media/contoso-migration-rehost-linux-vm/restart.png)

1. Finally, update the DNS records for `OSTICKETWEB` and `OSTICKETMYSQL` on one of the Contoso domain controllers.

    ![Screenshot that shows updating a DNS record.](./media/contoso-migration-rehost-linux-vm-mysql/update-dns.png)

    ![Screenshot that shows updating a DNS record.](./media/contoso-migration-rehost-linux-vm-mysql/update-dns.png)

**Need more help?**

- Learn about how to [run a test migration](/azure/migrate/tutorial-migrate-vmware#run-a-test-migration).
- Learn about how to [migrate VMs to Azure](/azure/migrate/tutorial-migrate-vmware#migrate-vms).

## Clean up after migration

With migration complete, the osTicket application tiers are now running on Azure VMs.

Now, Contoso needs to do the following tasks:

- Remove the on-premises VMs from the vCenter inventory.
- Remove the on-premises VMs from local backup jobs.
- Update the internal documentation to show the new location and IP addresses for `OSTICKETWEB` and `OSTICKETMYSQL`.
- Review any resources that interact with the VMs. Update any relevant settings or documentation to reflect the new configuration.
- Contoso used the Azure Migrate service with management VM to assess the VMs for migration. Admins should remove the migration VM and web VMs from VMware ESXi server.

## Review the deployment

With the application now running, Contoso needs to fully operationalize and secure its new infrastructure.

### Security

The Contoso security team reviews the `OSTICKETWEB` and `OSTICKETMYSQL` VMs to determine any security issues.

- The team reviews the network security groups (NSGs) for the VMs to control access. NSGs are used to ensure that only traffic allowed to the application can pass.
- The team also considers securing the data on the VM disks by using Azure Disk Encryption and Azure Key Vault.

For more information, see [Security best practices for IaaS workloads in Azure](/azure/security/fundamentals/iaas).

### Business continuity and disaster recovery

For business continuity and disaster recovery, Contoso takes the following actions:

- **Keep data safe.** Contoso backs up the data on the VMs by using [Azure VM backup](/azure/backup/backup-azure-vms-introduction).

- **Keep applications up and running.** Contoso replicates the application VMs in Azure to a secondary region by using Site Recovery. For more information, see [Quickstart: Set up disaster recovery to a secondary Azure region for an Azure VM](/azure/site-recovery/azure-to-azure-quickstart).

### Licensing and cost optimization

- After deploying resources, Contoso assigns Azure tags as defined during the [Azure infrastructure deployment](./contoso-migration-infrastructure.md#set-up-tagging).
- Contoso has no licensing issues with the Ubuntu servers.
- Contoso will use [Azure Cost Management + Billing](/azure/cost-management-billing/cost-management-billing-overview) to ensure the company stays within budgets established by the IT leadership.
