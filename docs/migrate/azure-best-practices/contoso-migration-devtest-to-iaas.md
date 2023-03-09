---
title: Rehost an on-premises dev/test environment on Azure Virtual Machines via Azure Migrate
description: Learn how Contoso rehosts an on-premises dev/test environment by migrating on-premises machines to Azure via a lift-and-shift approach and the Migrate service.
author: deltadan
ms.author: martinek
ms.date: 07/1/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
ms.custom: think-tank
---

# Rehost an on-premises dev/test environment on Azure Virtual Machines via Azure Migrate

This article demonstrates how the fictional company, Contoso, rehosts its dev/test environment for two applications that run on VMware virtual machines (VMs) by migrating to Azure Virtual Machines.

The [SmartHotel360](https://github.com/Microsoft/SmartHotel360) and [osTicket](https://github.com/osTicket/osTicket) applications in this example are open source. Download them for your own testing purposes.

## Migration options

Contoso has several options available to move dev/test environments to Azure:

| Migration options | Outcome |
| --- | --- |
| [Azure Migrate](/azure/migrate/migrate-services-overview) | [Assess](/azure/migrate/tutorial-assess-vmware-azure-vm) and [migrate](/azure/migrate/tutorial-migrate-vmware) on-premises VMs. <br><br> Run dev/test servers by using Azure infrastructure as a service (IaaS). <br><br> Manage VMs with [Azure Resource Manager](/azure/azure-resource-manager/management/overview). |
| [Azure DevTest Labs](/azure/devtest-labs/devtest-lab-overview) | Quickly prepare development and test environments. <br><br> Minimize waste with quotas and policies. <br><br> Set automated shutdowns to minimize costs. <br><br> Build Windows and Linux environments. |

> [!NOTE]
> Read how Contoso moved its [dev/test environment to Azure by using DevTest Labs](./contoso-migration-devtest-to-labs.md).

## Business drivers

The development leadership team outlines what they want to achieve with this migration. They aim to quickly move dev/test capabilities out of an on-premises datacenter and stop purchasing hardware to develop software. They seek to empower developers to create and run their environments without involvement from IT.

> [!NOTE]
> Contoso uses the [Pay-As-You-Go Dev/Test subscription offer](https://azure.microsoft.com/offers/ms-azr-0023p/) for its environments. Each active Visual Studio subscriber on the team can use the Microsoft software that's included with the subscription virtual machines for dev/test at no extra charge. Contoso just pays the Linux rate for VMs that it runs. That includes VMs with SQL Server, SharePoint Server, or other software that's usually billed at a higher rate.

## Migration goals

The Contoso development team pins down goals for this migration. These goals are used to determine the best migration method:

- Contoso wants to quickly move out of its on-premises dev/test environments.
- After migration, Contoso's dev/test environment in Azure should have enhanced capabilities over the current system in VMware.
- The operations model moves from IT provisioned to DevOps with self-service provisioning.

## Solution design

After Contoso pins down goals and requirements, they design and review a deployment solution and identify the migration process. The process includes the Azure services that Contoso uses for the migration.

### Current application

- The dev/test VMs for the two applications are running on VMs (`WEBVMDEV`, `SQLVMDEV`, `OSTICKETWEBDEV`, `OSTICKETMYSQLDEV`). These VMs are used for development before code is promoted to the production VMs.
- The VMs are located on VMware ESXi host `contosohost1.contoso.com` (version 6.5).
- The vCenter Server 6.5 (`vcenter.contoso.com`), which runs on a VM, manages the VMware environment.
- Contoso has an on-premises datacenter (`contoso-datacenter`) with an on-premises domain controller (`contosodc1`).

### Proposed architecture

- Because the VMs are used for dev/test, they reside in the `ContosoDevRG` resource group in Azure.
- The VMs are migrated to the primary Azure region (`East US 2`) and placed in the development virtual network (`VNET-DEV-EUS2`).
- The web front-end VMs reside in the front-end subnet (`DEV-FE-EUS2`) in the development network.
- The database VM resides in the database subnet (`DEV-DB-EUS2`) in the development network.
- The on-premises VMs in the Contoso datacenter are decommissioned after the migration is done.

  ![Diagram of the proposed scenario architecture, with on-premises and virtual machines.](./media/contoso-migration-devtest-to-iaas/architecture.png)  
  *Figure 1: Proposed architecture.*

### Database considerations

To support ongoing development, Contoso decides to continue to use existing VMs and migrate them to Azure. In the future, Contoso pursues the use of platform as a service (PaaS) services, such as [Azure SQL Database](/azure/azure-sql/azure-sql-iaas-vs-paas-what-is-overview) and [Azure Database for MySQL](/azure/mysql/overview).

- Database VMs are migrated as is without changes.
- With the use of the Azure Dev/Test subscription offer, the computers running Windows Server and SQL Server don't incur licensing fees. The compute costs are kept to a minimum.
- In the future, Contoso looks to integrate its development with PaaS services.

### Solution review

Contoso evaluates the proposed design by listing pros and cons.

| Consideration | Details |
| --- | --- |
| **Pros** | All of the development VMs are moved to Azure without changes, which makes the migration simple. <br><br> Contoso uses a lift-and-shift approach for both sets of VMs, so special configuration or migration tools aren't needed for the application database. <br><br> Contoso can take advantage of its investment in the Azure Dev/Test subscription to save on licensing fees. <br><br> Contoso retains full control of the application VMs in Azure. <br><br> Developers obtain rights to the subscription, which empowers them to create new resources without waiting for IT to respond to their requests. |
| **Cons** | The migration only moves the VMs and doesn't move them to PaaS services for their development. Contoso needs to start supporting the operations of its VMs, including security patches. IT maintained the operation in the past, so Contoso needs to find a solution for this new operational task. <br><br> The cloud-based solution empowers the developers, and it doesn't have safeguards for overprovisioning systems. Developers can instantly provision their systems, but they might create resources that cost money and aren't included in the budget. |

> [!NOTE]
> Contoso can address the cons in its list by using [DevTest Labs](/azure/devtest-labs/devtest-lab-overview).

### Migration process

Contoso migrates its development front end and database to Azure VMs by using the agentless method in the Azure Migrate: Server Migration tool.

- Contoso prepares and sets up Azure components for Azure Migrate: Server Migration and prepares the on-premises VMware infrastructure.
- The [Azure infrastructure](./contoso-migration-infrastructure.md) is in place, so Contoso configures the replication of the VMs through the Azure Migrate: Server Migration tool.
- With everything prepared, Contoso starts replicating the VMs.
- After replication is enabled and working, Contoso migrates the VMs by testing the migration. If successful, it's failed over to Azure.
- After the development VMs are up and running in Azure, Contoso reconfigures its development workstations to point at the VMs now running in Azure.

[![Diagram of an overview of the migration process.](./media/contoso-migration-devtest-to-iaas/migration-process-az-migrate.png)](./media/contoso-migration-devtest-to-iaas/migration-process-az-migrate.png#lightbox)  
*Figure 2: An overview of the migration process.*

### Azure services

| Service | Description | Cost |
| --- | --- | --- |
| [Azure Migrate: Server Migration](/azure/migrate/) | The service orchestrates and manages migrating on-premises applications, workloads, and AWS or GCP VM instances. | During replication to Azure, Azure Storage charges are incurred. Azure VMs are created and incur charges when the migration occurs and the VMs are running in Azure. Learn more about [charges and pricing](https://azure.microsoft.com/pricing/details/azure-migrate/). |

## Prerequisites

To run this scenario, Contoso needs:

| Requirements | Details |
| --- | --- |
| **Azure Dev/Test subscription** | Contoso creates an [Azure Dev/Test subscription](https://azure.microsoft.com/offers/ms-azr-0023p/) to reduce costs up to 80 percent. <br><br> If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/free/). <br><br> If you create a free account, you're the admin of your subscription, and you can perform all actions. <br><br> If you use an existing subscription, but you're not the admin, work with the admin to assign you owner or contributor permissions. <br><br> If you need more granular permissions, see [Manage Site Recovery access with Azure role-based access control](/azure/site-recovery/site-recovery-role-based-linked-access-control). |
| **Azure infrastructure** | Learn how Contoso [set up an Azure infrastructure](./contoso-migration-infrastructure.md). |
| **On-premises servers** | On-premises vCenter servers should run version 5.5, 6.0, 6.5, or 6.7. <br><br> ESXi hosts should run version 5.5, 6.0, 6.5, or 6.7. <br><br> One or more VMware VMs should run on the ESXi host. |

## Scenario steps

Contoso admins run the migration by following this process:

> [!div class="checklist"]
>
> - **Step 1: Prepare Azure for Azure Migrate: Server Migration.** Add the server migration tool to the Azure Migrate project.
> - **Step 2: Prepare on-premises VMware for Azure Migrate: Server Migration.** Prepare accounts for VM discovery and prepare to connect to Azure VMs after migration.
> - **Step 3: Replicate VMs.** Set up replication and start replicating VMs to Azure Storage.
> - **Step 4: Migrate the VMs with Azure Migrate: Server Migration.** Run a test migration to make sure everything's working and then run a full migration to move the VMs to Azure.

## Step 1: Prepare Azure for the Azure Migrate: Server Migration tool

Contoso migrates the VMs to a virtual network where the Azure VMs reside when they're created, provisioned, and configured through the Azure Migrate: Server Migration tool.

### Set up a network

Contoso already set up a network that can be for Azure Migrate: Server Migration when it [deployed the Azure infrastructure](./contoso-migration-infrastructure.md).

  - The VMs that are migrated are used for development. They're migrated to the Azure development virtual network (`VNET-DEV-EUS2`) in the primary `East US 2` region.
  - Both VMs are placed in the `ContosoDevRG` resource group, which is used for development resources.
  - The application front-end VMs (`WEBVMDEV` and `OSTICKETWEBDEV`) are migrated to the front-end subnet (`DEV-FE-EUS2`) in the development virtual network.
  - The application database VMs (`SQLVMDEV` and `OSTICKETMYSQLDEV`) are migrated to the database subnet (`DEV-DB-EUS2`) in the development virtual network.

### Provision the Azure Migrate: Server Migration tool

 1. From Azure Migrate, download the `.OVA` image file and import it into VMware.

     [![Screenshot of downloading the OVA file in the Discover machines window.](./media/contoso-migration-devtest-to-iaas/migration-download-ova.png)](./media/contoso-migration-devtest-to-iaas/migration-download-ova.png#lightbox)  
    *Figure 3: Download the .OVA file.*

 1. Open the imported image and configure the tool.

 1. Set up the prerequisites.

    [![Screenshot of the section for setting up prerequisites.](./media/contoso-migration-devtest-to-iaas/migration-setup-prerequisites.png)](./media/contoso-migration-devtest-to-iaas/migration-setup-prerequisites.png#lightbox)  
    *Figure 4: Setting up the prerequisites.*

 1. Point the tool to the Azure subscription.

    ![Screenshot of the section for setting up discovery for Azure Migrate.](./media/contoso-migration-devtest-to-iaas/migration-register-azure.png)  
    *Figure 5: The Azure subscription.*

 1. Set the VMware vCenter credentials.

    ![Screenshot of the section for setting VMware vCenter credentials.](./media/contoso-migration-devtest-to-iaas/migration-vcenter-server.png)  
    *Figure 6: Setting the VMware vCenter credentials.*

 1. Add Windows-based credentials for discovery.

    ![Screenshot of the section for discovering applications and dependencies on VMs.](./media/contoso-migration-devtest-to-iaas/migration-credentials.png)  
    *Figure 7: Adding Windows-based credentials for discovery.*

 1. When you complete the configuration, the tool takes time to enumerate all the VMs. They populate in the Azure Migrate tool in Azure when this process finishes.

    For more information, see [Add migration tools](/azure/migrate/how-to-migrate).

## Step 2: Prepare on-premises VMs

After migration, Contoso wants to connect to the Azure VMs and allow Azure to manage the VMs. Before the migration, Contoso admins do the following steps:

1. For access over the internet, the admins:

    - Enable RDP or SSH on the on-premises VM before migration.
    - Ensure that TCP and UDP rules are added for the `Public` profile.
    - Check that RDP or SSH is allowed in the operating system firewall.
    - Install SSH via the command `sudo apt-get ssh install -y`.

1. For access over Site-to-Site VPN, the admins:

    - Enable RDP or SSH on the on-premises VM before migration.
    - Check that RDP or SSH is allowed in the operating system firewall.
    - For Windows, set the operating system's SAN policy on the on-premises VM to `OnlineAll`.

1. Install the [Azure Windows agent](/azure/virtual-machines/extensions/agent-windows) and the [Azure Linux agent](/azure/virtual-machines/extensions/agent-linux).

For Windows, there shouldn't be Windows updates pending on the VM when you trigger a migration. If there are, the admins can't sign in to the VM until the updates finish. After the migration, the admins can check **Boot diagnostics** to view a screenshot of the VM. If it's not visible, they should verify that the VM is running and review [troubleshooting tips](https://social.technet.microsoft.com/wiki/contents/articles/31666.troubleshooting-remote-desktop-connection-after-failover-using-asr.aspx).

For more information, see [Prepare on-premises machines for migration to Azure](/azure/migrate/prepare-for-migration).

## Step 3: Replicate the on-premises VMs

Before Contoso admins can run a migration to Azure, they need to set up and enable replication. With discovery completed, they can begin replicating VMware VMs to Azure.

1. In the Azure Migrate project, go to **Servers** > **Azure Migrate: Server Migration**. Select **Replicate**.

    ![Screenshot that shows the Replicate button in the migration tools section.](./media/contoso-migration-devtest-to-iaas/select-replicate.png)  
    *Figure 8: Replicating VMs.*

1. Go to **Replicate** > **Source settings** > **Are your machines virtualized?**, and select **Yes, with VMware vSphere**.

1. In the **On-premises appliance** field, select the name of the Azure Migrate appliance that you set up, and then select **OK**.

    [![Screenshot that shows source settings and the box for the appliance name.](./media/contoso-migration-devtest-to-iaas/source-settings.png)](./media/contoso-migration-devtest-to-iaas/source-settings.png#lightbox)  
    *Figure 9: The source settings.*

1. In the **Virtual machines** tab, select the machines that you want to replicate.

    - If you've run an assessment for the VMs, you can apply VM sizing and disk type (premium or standard) recommendations from the assessment results. In the **Import migration settings from an assessment?** field, select **Yes, apply migration settings from a Azure Migrate assessment**.
    - If you didn't run an assessment or you don't want to use the assessment settings, select **No, I'll specify the migration settings manually**.
    - If you selected to use the assessment, select the VM group and assessment name.

      [![Screenshot that shows the assessment selection for virtual machines.](./media/contoso-migration-devtest-to-iaas/select-assessment.png)](./media/contoso-migration-devtest-to-iaas/select-assessment.png#lightbox)  
      *Figure 10: How to set up the prerequisites.*

1. In the **Virtual machines** tab, search for VMs as needed and check each VM you want to migrate. Then select **Next: Target settings**.

1. In the **Target settings** tab, select the subscription and target region where you want to migrate. Specify the resource group where the Azure VMs reside after migration. In **Virtual Network**, select the virtual network or subnet to which the Azure VMs are joined after migration.

1. In the **Azure Hybrid Benefit** field, select **No** if you don't want to apply Azure Hybrid Benefit and then select **Next**. Select **Yes** if you have Windows Server machines that are covered with active Software Assurance or Windows Server subscriptions and you want to apply the benefit to the machines you're migrating. Select **Next**.

      > [!NOTE]
      > For Contoso, the admins select **No** for Azure Hybrid Benefit because this is an Azure Dev/Test subscription, so they only pay for the compute. [Azure Hybrid Benefit](https://azure.microsoft.com/pricing/hybrid-benefit/) is only used for production systems that have Software Assurance benefits.

1. In the **Compute** tab, review the VM name, size, OS disk type, and availability set. VMs must conform with [Azure requirements](/azure/migrate/migrate-support-matrix-vmware#vmware-requirements).

    - **VM size:** If you're using assessment recommendations, this dropdown list contains the recommended size. Otherwise, Azure Migrate selects a size based on the closest match in the Azure subscription. You can choose a manual size in **Azure VM size**.
    - **OS disk:** Specify the OS (boot) disk for the VM. The OS disk has the operating system bootloader and installer.
    - **Availability set:** If the VM should be in an Azure availability set after migration, specify the set. The set must be in the target resource group that you specify for the migration.

1. In the **Disks** tab, specify whether to replicate the VM disks to Azure, select the disk type (Standard SSD/HDD or Premium SSD), and then select **Next**. You can exclude disks from replication. If you do, they aren't present on the Azure VM after migration.

1. In the **Review and start replication** tab, review the settings, and select **Replicate** to start the initial replication for the servers.

> [!NOTE]
> Before the replication starts, you can update the replication settings in **Manage** > **Replicating machines**. You can't change the settings after the replication starts.

## Step 4: Migrate the VMs

Contoso admins run a quick test migration and then a full migration to migrate the VMs.

### Run a test migration

1. Go to **Migration goals** > **Servers** > **Azure Migrate: Server Migration**, and select **Test migrated servers**.

    ![Screenshot that shows the selection to test migrated servers.](./media/contoso-migration-devtest-to-iaas/test-migrated-servers.png)  
    *Figure 11: Testing migrated servers.*

2. Select and hold (or right-click) the VM that you want to test, and then select **Test migrate**.

    [![Screenshot that shows the button for testing migration.](./media/contoso-migration-devtest-to-iaas/test-migrate.png)](./media/contoso-migration-devtest-to-iaas/test-migrate.png#lightbox)  
    *Figure 12: Testing the migration.*

3. In **Test Migration**, select the virtual network where the Azure VM is located after the migration. We recommend that you use a nonproduction virtual network.
4. The **Test migration** job starts. Monitor the job in the portal notifications.
5. After the migration finishes, view the migrated Azure VM in **Virtual Machines** in the Azure portal. The machine name has a **-Test** suffix.
6. After the test is done, select and hold (or right-click) the Azure VM in **Replicating machines**, and then select **Clean up test migration**.

    [![Screenshot that shows the selection for cleaning up the test migration.](./media/contoso-migration-devtest-to-iaas/clean-up.png)](./media/contoso-migration-devtest-to-iaas/clean-up.png#lightbox)  
    *Figure 13: Cleaning up the test migration.*

### Run a full migration

Now Contoso admins run a full migration.

1. In the Azure Migrate project, select **Servers** > **Azure Migrate: Server Migration** > **Replicating servers**.

    ![Screenshot that shows the selections for replicating servers.](./media/contoso-migration-devtest-to-iaas/replicating-servers.png)  
    *Figure 14: Replicating servers.*

1. In **Replicating machines**, select and hold (or right-click) the VM, and then select **Migrate**.
1. Go to **Migrate** > **Shut down virtual machines and perform a planned migration with no data loss**, and select **Yes** > **OK**. By default, Azure Migrate shuts down the on-premises VM and runs an on-demand replication to synchronize any VM changes that occurred since the last replication. This process ensures that no data is lost. If you don't want to shut down the VM, select **No**.
1. A migration job starts for the VM. Track the job in Azure notifications.
1. After the job finishes, you can view and manage the VM from the **Virtual Machines** page.

For more information, see [Run a test migration](/azure/migrate/tutorial-migrate-vmware#run-a-test-migration) and [Migrate VMs to Azure](/azure/migrate/tutorial-migrate-vmware#migrate-vms).

## Clean up after migration

The development VMs for the SmartHotel360 and osTicket applications run on Azure VMs when the migration is complete.

Contoso completes cleanup steps:

- After the migration is complete, stop replication.
- Remove the `WEBVMDEV`, `SQLVMDEV`, `OSTICKETWEBDEV`, and `OSTICKETMYSQLDEV` VMs from the vCenter inventory.
- Remove all the VMs from local backup jobs.
- Update the internal documentation to show the new location and IP addresses for the VMs.
- Review any resources that interact with the VMs, and update any relevant settings or documentation to reflect the new configuration.

## Review the deployment

With the application now running, Contoso now needs to fully operationalize and secure it in Azure.

### Security

The Contoso security team reviews the Azure VMs to determine any security issues. To control access, the team reviews the network security groups (NSGs) for the VMs. NSGs are used to ensure that only traffic allowed to the application can reach it. The team considers securing the data on the disk by using Azure Disk Encryption and Azure Key Vault.

For more information, see [Security best practices for IaaS workloads in Azure](/azure/security/fundamentals/iaas).

## Business continuity and disaster recovery

For business continuity and disaster recovery, Contoso keeps the data safe. Contoso backs up the data on the VMs by using the Azure Backup service. For more information, see [An overview of Azure VM backup](/azure/backup/backup-azure-vms-introduction).

## Licensing and cost optimization

Contoso ensures that all development Azure resources are created through an Azure Dev/Test subscription to save 80 percent. The admins enable [Azure Cost Management + Billing](/azure/cost-management-billing/cost-management-billing-overview) to help monitor and manage the Azure resources.

## Conclusion

In this article, Contoso rehosted the development VMs that were used for its SmartHotel360 and osTicket applications in Azure. The admins migrated the application VMs to Azure VMs by using the Azure Migrate: Server Migration tool.
