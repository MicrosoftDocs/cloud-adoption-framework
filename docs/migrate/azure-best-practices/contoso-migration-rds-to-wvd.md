---
title: Move on-premises Remote Desktop Services to Azure Virtual Desktop
description: Learn how to migrate an on-premises Remote Desktop Services environment to Azure Virtual Desktop in the cloud.
author: benstegink
ms.author: martinek
ms.date: 09/07/2021
ms.review: ssumner
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
ms.custom: think-tank
---

# Move on-premises Remote Desktop Services to Azure Virtual Desktop scenario

This article focuses on using Azure Virtual Desktop to move an on-premises RDS environment to Azure. With Azure Virtual Desktop, you can bring your existing Remote Desktop Services (RDS) and Windows Server desktops and apps to any computer. 

> [!NOTE]
> This guidance will not apply for migrating from Citrix or VMWare Horizon.

| Migration options | Outcome |
|--- | --- |
| [Azure Migrate](/azure/migrate/migrate-services-overview) | Assess and migrate on-premises RDS environments. <br><br> Run workloads in an Azure Virtual Desktop environment.

## Business drivers

Working closely with business partners, the Contoso IT team defines the business drivers for a VDI migration to Azure. These drivers might include:

- **Current environment end-of-life:** A datacenter is out of capacity when it reaches the end of a lease or is closing down. Migrating to the cloud provides virtually unlimited capacity. Current software might also be reaching its end of life where it's become necessary to upgrade the software running Contoso's current VDI solution.
- **Multi-session Windows 11 or Windows 10 VDI:** Provide Contoso users with the only multi-session Windows 11 or Windows 10 desktop virtualized in the cloud that's highly scalable, up to date, and available on any device.
- **Optimize for Microsoft 365 Apps for enterprise:** Deliver the best Microsoft 365 Apps for enterprise experience, with multi-session virtual desktop scenarios providing the most productive virtualized experience for Contoso's users.
- **Deploy and scale in minutes:** Quickly virtualize and deploy modern and legacy desktop applications to the cloud in minutes with unified management in the Azure portal.
- **Secure and productive on Azure and Microsoft 365:** Deploy a complete, intelligent solution that enhances creativity and collaboration for everyone. Shift to Microsoft 365 and get Office 365, Windows 11 or Windows 10, and Enterprise Mobility + Security.

## RDS on-premises to Azure Virtual Desktop in the cloud goals

With the business drivers in mind, Contoso pins down goals for this migration:

- Modernize the virtual desktop environment for the cloud.
- Take advantage of existing [Microsoft 365 licenses](/azure/virtual-desktop/prerequisites#operating-systems-and-licenses) on Azure Virtual Desktop.
- Improve security of corporate data when users work remotely.
- Optimize the new environment for cost and growth.

These goals support the decision to use Azure Virtual Desktop and validate it as the best migration method for Contoso.

## Benefits of running Azure Virtual Desktop

Using Azure Virtual Desktop, Contoso can now seamlessly run, manage, and scale its VDI solution quickly and easily. The company can also provide an optimized multi-session Windows 11 or Windows 10 environment to its users.

Contoso capitalizes on existing Microsoft 365 licenses while using the scale, performance, security, and innovation of Azure.

Additional benefits might include:

- Access to Azure Virtual Desktop from anywhere.
- Optimized Microsoft 365 Apps for enterprise environment.
- Azure Virtual Desktop for dev/test environments.

## Solutions design

After assessing current RDS deployments, pinning down goals and requirements, Contoso designs and reviews a deployment solution and identifies the migration process.

### Current architecture

RDS is deployed to an on-premises datacenter. Microsoft 365 is licensed and in use by the organization.

### Proposed architecture

- Sync Active Directory or Azure Active Directory Domain Services (Azure AD DS).
- Deploy Azure Virtual Desktop.
- Migrate on-premises RDS servers to Azure.
- Convert user profile disks (UPDs) to FSLogix profile containers.

  ![Diagram shows the proposed architecture.](./media/contoso-migration-rds-to-wvd/proposed-architecture.png)
  *Figure 1: Proposed architecture.*

## Solution review

Contoso evaluates the proposed design by putting together a list of pros and cons.

| Consideration | Details |
| --- | --- |
| **Pros** | Windows 11 or Windows 10 Enterprise multi-session environment. <br><br> Cloud-based, allowing access from anywhere. <br><br> Take advantage of other Azure services like Azure Files within the Azure Virtual Desktop environment. <br><br> Optimized for the Microsoft modern desktop. |
| **Cons** | To fully optimize for Azure, Contoso will have to rebuild Windows 11 images optimized for multiuser sessions. <br><br> Azure Virtual Desktop doesn't support user profile disks, so UPDs must be migrated to FSLogix profile containers. |

## Migration process

Contoso moves VMs to Azure Virtual Desktop by using the Lakeside assessment tool and Azure Migrate. Contoso needs to:

- Run the assessment tool against its on-premises RDS infrastructure to establish the scale of the Azure Virtual Desktop deployment in Azure.
- Migrate to Azure Virtual Desktop via either Windows 11 or Windows 10 Enterprise multi-session or persistent virtual machines.
- Optimize the Azure Virtual Desktop multi-session by scaling up and down as needed to manage costs.
- Virtualize applications and assign users as needed to continue to secure and manage the Azure Virtual Desktop environment.

  ![Diagram shows the migration process.](./media/contoso-migration-rds-to-wvd/migration-process-01.png)
  *Figure 2: The migration process.*

## Scenario steps

1. Assess the current RDS environment.
2. Create the VDI and new images in Azure and migrate and persist VMs to Azure.
3. Convert UPDs to FSLogix profile containers.
4. Migrate any session hosts that most persist (can't be recreated).

## Step 1: Assess the current on-premises environment

Contoso provisions the Azure Virtual Desktop service in the **East US 2** Azure region. With Azure Virtual Desktop, Contoso can provision virtual machines, host pools, and create application groups. With Azure Virtual Desktop, Contoso can create a high-available VDI environment (using Azure availability zones or availability sets) and to scale up and down quickly as needed.

> [!NOTE]
> Contoso reviews two scenarios during the assessment: multi-session (shared) instances of RDS and persistent (or user-dedicated) virtual machines.

1. Make sure that domain services, either Active Directory or Azure AD DS, are synchronized with Azure Active Directory (Azure AD). Ensure the domain service is accessible from the Azure subscription and virtual network where you deploy Azure Virtual Desktop session hosts. AVD requires hybrid user identities for majority of your AVD deployments and desired features. The AVD service requires users UPN or SID to match between on-prem AD and Azure AD.

   > [!NOTE]
   > Review [Azure Virtual Desktop identities and authentication](https://learn.microsoft.com/azure/virtual-desktop/authentication) for a comprehensive list of requirements and supported features based on your identity strategy and configuration.

   <!-- -->

   > [!NOTE]
   > Learn more about the options to sync Active Directory on-premises with [Azure AD Connect](/azure/active-directory/hybrid/how-to-connect-install-express) or  [Azure AD Connect Cloud Sync](/active-directory/cloud-sync/concept-how-it-works).

   <!-- -->

   > [!NOTE]
   > Learn about provisioning [Azure AD DS](/azure/active-directory-domain-services/tutorial-create-instance) and synchronizing Azure AD to it.

1. In Azure Migrate, select **Discover, assess and migrate**.

   :::image type="content" source="./media/contoso-migration-rds-to-wvd/azure-migrate-get-started.png" alt-text="Screenshot that shows the overview page and Get Started tab for Azure Migrate.":::
   *Figure 3: Getting started.*

1. Select **Create project**.

   :::image type="content" source="./media/contoso-migration-rds-to-wvd/azure-migrate-create-project.png" alt-text="Screenshot that shows the Create Project button.":::
   *Figure 4: Creating a new Azure Migrate project.*

1. Set the subscription, resource group, project name, and geography for the migrate job data, and then select **Create**.

   :::image type="content" source="./media/contoso-migration-rds-to-wvd/azure-migrate-add-job-data.png" alt-text="Screenshot of adding job data to the Azure Migrate project.":::
   *Figure 5: Adding job data to the migration.*

    > [!IMPORTANT]
    > This location isn't where the new Azure Virtual Desktop environment will be deployed. Only the data related to the Azure Migrate project will be stored here.

1. Select **VDI**, and then select **Click here** under **Assessment tools**.

   :::image type="content" source="./media/contoso-migration-rds-to-wvd/azure-migrate-vdi-add-tool.png" alt-text="Screenshot that shows adding an assessment tool on the VDI page.":::
   *Figure 6: Adding an assessment tool*

   > [!NOTE]
   > The migration tool **Azure Migrate: Server Migration** is automatically added during the project creation.

1. Select **Lakeside: SysTrack** as the assessment tool, and then select **Add**.

   :::image type="content" source="./media/contoso-migration-rds-to-wvd/azure-migrate-select-lakeside-systrack.png" alt-text="Screenshot that shows adding the Lakeside:SysTrack tool to the project.":::
   *Figure 7: Adding tools to the migration.*

1. Start the assessment of the current environment by selecting **Register with Azure Migrate** in the Lakeside tool.

   :::image type="content" source="./media/contoso-migration-rds-to-wvd/azure-migrate-register-lakeside.png" alt-text="Screenshot that shows Lakeside registration with Azure Migrate.":::
   *Figure 8: Register with Azure Migrate.*

1. Contoso connects Azure Migrate and Lakeside, and accepts any requested permissions.

   ![Screenshot of signing in to connect Azure and Lakeside.](./media/contoso-migration-rds-to-wvd/lakeside-login.png)
   *Figure 9: Connecting Azure to Lakeside.*

1. Contoso continues with the Lakeside tool to create a new tenant and start assessing the current on-premises RDS environment. From the dashboard, Contoso can access the deployment guide, download the assessment client to deploy to the current environment, and review the data collected from these agents.

   ![Screenshot of the Lakeside dashboard.](./media/contoso-migration-rds-to-wvd/lakeside-new-tenant-dashboard.png)
   *Figure 10: The Lakeside dashboard.*
1. After an adequate amount of data is captured, Contoso reviews the assessment data to determine the best migration path. This assessment data includes the raw assessment data from the desktops data and the data broken into different user personas. This information includes the:

- Number of users in each persona.
- Applications in use by users.
- Resource consumption by user.
- Resource utilization averages by user persona.
- VDI server performance data.
- Concurrent user reports.
- Top software packages in use.

    ![Screenshot of Lakeside dashboard reports.](./media/contoso-migration-rds-to-wvd/lakeside-dashboard-reports.png)
    *Figure 11: Lakeside dashboard reports.*

The data is analyzed by Contoso to determine the most cost-effective use of both pooled Azure Virtual Desktop resources and personal Azure Virtual Desktop resources.

> [!NOTE]
> Contoso will also need to migrate application servers to Azure to get the company closer to the Azure Virtual Desktop environment and reduce network latency for its users. This same methodology should be applied to Domain Controllers and DNS servers that Azure Virtual Desktops session hosts will rely on. Best practice is to host these services in the same Azure Region as the Azure Virtual Desktop session hosts.

## Step 2: Create the Azure Virtual Desktop environment with the AVD Landing Zone Accelerator

The Azure Virtual Desktop Landing Zone Accelerator is Microsoft's enterprise-ready solution that can be leveraged to deploy an end-to-end AVD environment, see [here](https://github.com/Azure/avdaccelerator).

## Step 3: Convert the UPDs to FSLogix profile containers

Because Azure Virtual Desktop doesn't support user profile disks (UPDs), Contoso needs to convert all the UPDs to FSLogix via the [FSLogixMigration PowerShell module](https://aka.ms/FSLogixMigrationPreviewModule).

<!-- docutune:casing FSLogixMigration -->

After Contoso imports the FSLogixMigration module, it runs the following PowerShell cmdlets to migrate from UPDs to FSLogix.

> [!IMPORTANT]
> The PowerShell modules for Hyper-V, Active Directory, and Pester are prerequisites to running the cmdlets to convert UPDs to FSLogix.

A UDP conversion:

```powershell
Convert-RoamingProfile -ParentPath "C:\Users\" -Target "\\Server\FSLogixProfiles$" -VHDMaxSizeGB 20 -VHDLogicalSectorSize 512
```

A roaming profile conversion:

```powershell
Convert-RoamingProfile -ProfilePath "C:\Users\User1" -Target "\\Server\FSLogixProfiles$" -VHDMaxSizeGB 20 -VHDLogicalSectorSize 512 -VHD -IncludeRobocopyDetails -LogPath C:\temp\Log.txt
```
Optionally, the FSLogix Azure Files share created for Azure Virtual Desktop, can be connected to the on-premises host where the conversion will be executed, so it is used as target in the conversions. This option will convert UPDs or roaming profiles and also storage the new FSLogix containers in the Azure hosted file share.

At this point, the migration has enabled using pooled resources with Windows 11 Enterprise multi-session. Contoso can begin to deploy the necessary applications to the users who will use Windows 11 Enterprise multi-session.

But now Contoso must migrate the virtual machines that need to persist (in cases where VMs can't be recreated) to Azure.

## Step 4: Replicate VMs to Azure Virtual Desktop

The next step in the migration process for Contoso is to migrate its persistent and non-persistent (when required) virtual machines to Azure Virtual Desktop. To do this, Contoso goes back to the Azure Migrate: Server Migration job it created at the beginning of the process.

1. Contoso starts by selecting **Discover** in the Azure Migrate: Server Migration tools.

   ![Screenshot of the Azure Migrate: Server Migration discover option.](./media/contoso-migration-rds-to-wvd/wvd-persistent-discover.png)
   *Figure 16: Discovering a server migration.*

1. Contoso converts an appliance in its environment that's going to manage the replication of the machines to Azure Virtual Desktop. Ensure that the target region is set to **East US 2**, where the Azure Virtual Desktop environment was created. For full Azure Migrate OS Support matrix, see [Support Matrix for Hyper-V](/azure/migrate/migrate-support-matrix-hyper-v-migration) and [Support Matrix for VMware vSphere](/azure/migrate/migrate-support-matrix-vmware-migration).

   :::image type="content" source="./media/contoso-migration-rds-to-wvd/azure-migrate-discover-resources.png" alt-text="Screenshot that shows creating an appliance for managing the replication.":::
   *Figure 17: Converting an appliance.*

1. Contoso downloads, installs, and registers the replication provider to the Azure Migrate project to start the replication to Azure.

   :::image type="content" source="./media/contoso-migration-rds-to-wvd/azure-migrate-discover-prepare-replication.png" alt-text="Screenshot that shows downloading and configuring replication.":::
   *Figure 18: Prerequisites for replicating to Azure.*

1. The replication of the hosts into Azure Blob Storage starts. Contoso can continue to let the replication occur until it's ready to test the VMs and then migrate them into production.
   - As machines start running in Azure, Contoso installs the [Azure Virtual Desktop VM agent](https://aka.ms/wvdvmagent) on each machine.
   - As a part of the installation, enter the registration token for the Azure Virtual Desktop environment to associate the server with the correct environment.

1. The registration token can be obtained by using the following commands:

    ```powershell
    Export-RDSRegistrationInfo -TenantName "Contoso" -HostPoolName "ContosoWVD" | Select-Object -ExpandProperty Token > .\registration-token.txt
    ```

   > [!NOTE]
   > Contoso can also automate this process by using `msiexec` commands and passing in the registration token as a variable.

    > [!NOTE]
    > Microsoft generally recommends to rebuild an image in Azure to ensure compatibility and remove any possible bloat from the existing on-premises images, but you may also want to migrate any existing images or VMs that you want to use in Azure.
    
    <!-- -->
    
    > If you do have an image that you want to migrate to Azure, see [here](/azure/virtual-machines/windows/prepare-for-upload-vhd-image) for detailed instructions on preparing and uploading an image to Azure. This guide covers the steps needed to package the image into a virtual hard disk (VHD) format. Once the VHD is prepared, you can then upload it to Azure and use it to create new VMs in your Azure environment.
    > It's important to note that if you are migrating the VMs through replication, the image will migrate with them, so you will not need to upload it separately. However, if you are creating new VMs in Azure, or if you want to use the same image across multiple VMs, then you will need to follow the steps outlined in the guide to prepare and upload the image to Azure.

1. As the last step before the final migration, Contoso selects the **Users** item in the Azure Virtual Desktop settings to map the servers to their respective users and groups.

   :::image type="content" source="./media/contoso-migration-rds-to-wvd/azure-virtual-desktop-users-map-servers.png" alt-text="[Screenshot that shows assigning Azure Virtual Desktop resources to users and groups.":::
   *Figure 19: The last step prior to the final migration.*

After host pools are assigned to users, Contoso finalizes the migration of those machines and continues to gradually migrate the rest of the on-premises VDI hosts to Azure.

## Review the deployment

With the virtual desktops and application servers now running in Azure, Contoso now needs to fully operationalize and secure the deployment.

### Security

The Contoso security team reviews the Azure VMs to determine any security issues. To control access, the team reviews the network security groups (NSGs) for the VMs. NSGs are used to ensure that only traffic allowed to the application can reach it. The team also considers securing the data on the disk by using Azure Disk Encryption and Azure Key Vault. Session Hosts should also be protected using Defender for Endpoint or the product of choosing, ensure your vendor supports their product in Azure VDI environments. Also opt to protect Azure Virtual Desktop landing zone subscriptions with Defender for Cloud for increased visibility and compliance controls.

For more information, see [Security best practices for IaaS workloads in Azure](/azure/security/fundamentals/iaas).

## Business continuity and disaster recovery

Azure virtual desktop uses a combination of Microsoft managed components that come with a non-financially backed SLA targeting 99.9% uptime for our Azure Virtual Desktop Gateways, Brokers, Web Access, and diagnostics. These services meta-data and service-data are backed up and replicated behind the scenes to recover to alternate regions in the event of an outage. Contoso is responsible for the customer managed components, that includes Virtual Machines, Storage, Images, Applications, and the network components for their DR requirements. 

    > [!NOTE]
    > Learn more about BCDR options with [Business continuity and disaster recovery considerations for Azure Virtual Desktop](/azure/cloud-adoption-framework/scenarios/wvd/eslz-business-continuity-and-disaster-recovery).

    <!-- -->

Contoso backs up the data on the VMs by using Azure Backup to keep data safe. For more information, see [An overview of Azure VM backup](/azure/backup/backup-azure-vms-introduction).

### Licensing and cost optimization

- [Microsoft 365 licenses](/pricing/details/virtual-desktop/) are used for the desktop deployments. If Windows Server session hosts are still required, Contoso will need to bring their RDS user CAL licenses. Thanks to AVD licensing entitlement, there is no OS cost for any operating system, including Windows Server.
- Contoso will enable [Azure Cost Management + Billing](/azure/cost-management-billing/cost-management-billing-overview) to help monitor and manage the Azure resources.
- Contoso will use [Azure Virtual Desktop Tagging](/azure/virtual-desktop/tag-virtual-desktop-resources) to track costs and group it based on related resources to the hostpool.
- Contoso will monitor utilization across their entire AVD deployments using [AVD Insights](/azure/virtual-desktop/insights) and assess the cost savings opportunities of Reserved Instances, Savings Plans or Reserved Capacity.

## Conclusion

In this article, Contoso moved its RDS deployment to Azure Virtual Desktop hosted in Azure.
