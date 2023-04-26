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

# Move on-premises Remote Desktop Services to Azure Virtual Desktop (AVD) scenario

[Azure Virtual Desktop](https://learn.microsoft.com/azure/virtual-desktop/overview) (AVD) is a desktop and app virtualization service that runs on the cloud. It's the only desktop and application virtualization infrastructure that delivers simplified management, Windows 10 or Windows 11 Enterprise multi-session (Windows server also available) and optimizations for Microsoft 365 Apps for the enterprise. Deploy and scale Windows desktops and applications on Azure in minutes, and get built-in security and compliance features.

> [!NOTE]
> This guidance will not apply for migrating from Citrix or VMware Horizon.

| Migration options | Outcome |
|--- | --- |
| [Azure Migrate](https://learn.microsoft.com/azure/migrate/migrate-services-overview) | Assess and migrate on-premises RDS environments. <br><br> Run workloads in an AVD environment.

## Business drivers

Working closely with business partners, the Contoso IT team defines the business drivers for a VDI migration to Azure. These drivers might include:

- **Current environment end-of-life:** A datacenter is out of capacity when it reaches the end of a lease or is closing down. Migrating to the cloud provides virtually unlimited capacity. Current software might also be reaching its end of life where it's become necessary to upgrade the software running Contoso's current desktops and application virtualization solution.
- **Reduce cost:** Reduce costs with pooled, multi-session resources. With the new Windows 11 and Windows 10 Enterprise multi-session capability, exclusive to AVD and the Remote Desktop Session Host (RDSH) role on Windows Server, you can greatly reduce the number of virtual machines and operating system overhead while still providing the same resources to your users.
- **Optimize for Microsoft 365 Apps for enterprise:** Deliver the best Microsoft 365 Apps for enterprise experience, with multi-session virtual desktop scenarios providing the most productive virtualized experience for Contoso's users.
- **Deploy and scale in minutes:** Quickly virtualize and deploy modern and legacy desktop applications to the cloud in minutes with unified management in the Azure portal.
- **Secure and productive on Azure and Microsoft 365:** Deploy a complete, intelligent solution that enhances creativity and collaboration for everyone. Shift to Microsoft 365 and get Office 365, Windows 11 or Windows 10, and Enterprise Mobility + Security.

## RDS on-premises to AVD goals

With the business drivers in mind, Contoso defines the goals for this migration:

- Modernize the desktop and application virtualization environment for the cloud.
- Take advantage of existing [Microsoft 365 licenses](https://learn.microsoft.com/azure/virtual-desktop/prerequisites#operating-systems-and-licenses) with AVD.
- Improve security of corporate data while providing service to remote and hybrid users.
- Optimize the new environment for cost and enterprise scale growth.

These goals support the decision to use AVD and validate it as the best migration method for Contoso.

## Benefits of running AVD

Using AVD, Contoso can now seamlessly run, manage, and scale its desktop and application virtualization solution quickly and easily. The company can also provide an optimized multi-session solution on Windows 10 or Windows 11 environments to its users.

Contoso capitalizes on existing Microsoft 365 licenses while using the scale, performance, security, and innovation of Azure.

Additional benefits might include:

- Access to AVD from anywhere.
- Optimized Microsoft 365 Apps for enterprise environment.
- AVD for dev/test environments.
- Removing the need for RDS CAL licenses, when replacing Windows server multi-session hosts with Windows 10 or Windows 11 multi-session.

## Current architecture

RDS personal and pooled resources are deployed to an on-premises datacenter. Microsoft 365 is licensed and in use by the organization.

## Solutions design

After assessing current RDS deployments, defining goals and requirements, Contoso designs and reviews a deployment solution and identifies the migration process.

## Proposed architecture

The following diagram outlines the architecture that will be built to migrate RDS on-premises deployment to AVD, the activities will include:

- Sync Active Directory to Azure Active Directory.
- Deploy [AVD Landing Zone Accelerator (LZA)](https://github.com/Azure/avdaccelerator#avd-accelerator-baseline).
- Convert user profile disks (UPDs) to FSLogix profile containers (Optional).
- Migrate user profile data from FSLogix on-premisses to AVD FSLogix storage (Optional).
- Migrate on-premisses VMs that most persist (Optional).

  [![AVD LZA diagram.](https://raw.githubusercontent.com/Azure/avdaccelerator/main/workload/docs/diagrams/avd-accelerator-baseline-architecture.png)](https://raw.githubusercontent.com/Azure/avdaccelerator/main/workload/docs/diagrams/avd-accelerator-baseline-architecture.png)
  *Figure 1: Proposed architecture: AVD LZA will deploy the resources contained under the AVD LZ Subscription*.

    [Download the Visio file.](https://raw.githubusercontent.com/Azure/avdaccelerator/main/workload/docs/diagrams/avd-accelerator-baseline-architecture.vsdx)

## Migration process

Contoso will go through the following flow to migrate from on-premises RDS to AVD:

- Run the assessment and define AVD deployment.
- Create AVD LZA deployment and migrate objects that must persist (VMs, profiles, images).
- Manage AVD published items, assignments, monitoring and scaling.
- Optimize Azure state.

  ![Diagram shows the migration process.](./media/contoso-migration-rds-to-wvd/rds-to-avd-migration-flow.png)
  *Figure 2: The migration process.*

## Migration steps

1. Prerequisites.
1. Assess the current RDS on-premises environment.
1. Deploy [AVD Landing Zone Accelerator (LZA)](https://github.com/Azure/avdaccelerator#avd-accelerator-baseline).
1. Convert user profiles disks (UPDs) to FSLogix profile containers (Optional).
1. Migrate FSLogix on-premise data to Azure (Optional).
1. Migrate VMs that must persist to Azure (Optional).

### Step 1: Prerequisites

1. An Azure subscription is required ([Subscription requirements](https://github.com/Azure/avdaccelerator/blob/main/workload/docs/getting-started-baseline.md#subscription-requirements)).

1. Make sure that domain services, either Active Directory or Azure AD DS, are synchronized with Azure Active Directory (Azure AD). Ensure the domain service is accessible from the Azure subscription and virtual network where you deploy AVD session hosts. AVD requires hybrid user identities for majority of your AVD deployments and desired features. The AVD service requires users UPN or SID to match between on-prem AD and Azure AD.

   > [!NOTE]
   > Review [AVD identities and authentication](https://learn.microsoft.com/azure/virtual-desktop/authentication) for a comprehensive list of requirements and supported features based on your identity strategy and configuration.
   > [!NOTE]
   > Learn more about the options to sync Active Directory on-premises with [Azure AD Connect](https://learn.microsoft.com/azure/active-directory/hybrid/how-to-connect-install-express) or  [Azure AD Connect Cloud Sync](https://learn.microsoft.com/active-directory/cloud-sync/concept-how-it-works).
   > [!NOTE]
   > Learn more about provisioning [Azure AD DS](https://learn.microsoft.com/azure/active-directory-domain-services/tutorial-create-instance) and synchronizing Azure AD to it.

1. Prior to the deployment of the AVD LZA, ensure the the requirements of the deployment are met ([AVD LZA Prerequisites](https://github.com/Azure/avdaccelerator/blob/main/workload/docs/getting-started-baseline.md#prerequisites)).

### Step 2: Assess the current RDS on-premises environment

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
   > This location isn't where the new AVD environment will be deployed. Only the data related to the Azure Migrate project will be stored here.

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

    The data is analyzed by Contoso to determine the most cost-effective use of both pooled AVD resources and personal AVD resources.

> [!IMPORTANT]
> Reviewing the assessment data, Contoso defines two RDS scenarios:
> 1. **Multi-session (non-persistent):** RDS hosts running Windows server and allowing multiple users connections to the same host.
> 1. **Single-session (persistent):** RDS hosts running Windows 11.
> [!NOTE]
> To reduce improve performance of AVD users flows, Contoso will also need to migrate application servers and data sources that will be consumed by the AVD environment. This same methodology should be applied to platform shared services (Domain Controllers, DNS, network devices, among others) that AVD will rely on. Best practice is to host these services in the same Azure Region as the AVD session hosts.

**Next steps:**

- Execute AVD LZA deployments with the defined scenario steps.

### Step 3: Deploy AVD Landing Zone Accelerator (LZA)

The AVD LZA is Microsoft's enterprise-ready solution that can be used to deploy an end-to-end AVD enterprise ready environment, to deploy the accelerator follow the [AVD LZA Deployment Walk Through](https://github.com/Azure/avdaccelerator/blob/main/workload/docs/deploy-baseline.md) guide.

> [!IMPORTANT]
> Based on the outcome of the assessment phase, two AVD LZA deployments will be required to address Contoso scenarios:
> 1. **Multi-session (Pooled hostpool):** AVD management plane (workspace, hostpool, application group, scaling plan) deployment with Windows 10 multi-session session hosts and FSLogix to manage users profile data.
> 1. **Single-session (Personal hostpool):** AVD management plane (workspace, hostpool, application group, scaling plan) deployment without de deployment of new session hosts (personal VMs will be migrated from RDS).
> [!NOTE]
> To reduce improve performance of AVD users flows, Contoso will also need to migrate application servers and data sources that will be consumed by the AVD environment. This same methodology should be applied to platform shared services (Domain Controllers, DNS, network devices, among others) that AVD will rely on. Best practice is to host these services in the same Azure Region as the AVD session hosts.

**Next steps:**

- Migrate user profile data that must persist.
- Migrate VMs that must persist
- Deploy the necessary applications to the users.

### Step 4: Convert the UPDs to FSLogix profile containers (Optional)

Because AVD doesn't support user profile disks (UPDs), Contoso need to convert all the UPDs to FSLogix via the [FSLogixMigration PowerShell module](https://aka.ms/FSLogixMigrationPreviewModule).

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

> [!IMPORTANT]
> The FSLogix Azure Files share created by the AVD LZA deployment, can be mounted on the on-premises host  executing the conversion and be used as the target path. This option will convert UPDs or roaming profiles to FSLogix containers while also moving them to the Azure storage.

At this point, the migration has enabled using pooled resources with Windows Enterprise multi-session. Contoso can begin to deploy the necessary applications to the users who will use Windows Enterprise multi-session.

But now Contoso must migrate the virtual machines that must persist (in cases where VMs can't be recreated) to Azure.

### Step 5: Migrate FSLogix on-premise data to Azure (Optional)

### Step 6: Migrate VMs that must persist to Azure (Optional)

The next step in the migration process for Contoso is to migrate its persistent VMs to AVD. To do this, Contoso goes back to the Azure Migrate: Server Migration job it created on step 1.

1. Contoso starts by selecting **Discover** in the Azure Migrate: Server Migration tools.

   ![Screenshot of the Azure Migrate: Server Migration discover option.](./media/contoso-migration-rds-to-wvd/wvd-persistent-discover.png)
   *Figure 16: Discovering a server migration.*

1. Contoso converts an appliance in its environment that's going to manage the replication of the machines to AVD. Ensure that the target region is set to **East US 2**, where the AVD environment was created. For full Azure Migrate OS Support matrix, see [Support Matrix for Hyper-V](https://learn.microsoft.com/azure/migrate/migrate-support-matrix-hyper-v-migration) and [Support Matrix for VMware vSphere](https://learn.microsoft.com/azure/migrate/migrate-support-matrix-vmware-migration).

   :::image type="content" source="./media/contoso-migration-rds-to-wvd/azure-migrate-discover-resources.png" alt-text="Screenshot that shows creating an appliance for managing the replication.":::
   *Figure 17: Converting an appliance.*

1. Contoso downloads, installs, and registers the replication provider to the Azure Migrate project to start the replication to Azure.

   :::image type="content" source="./media/contoso-migration-rds-to-wvd/azure-migrate-discover-prepare-replication.png" alt-text="Screenshot that shows downloading and configuring replication.":::
   *Figure 18: Prerequisites for replicating to Azure.*

1. The replication of the hosts into Azure Blob Storage starts. Contoso can continue to let the replication occur until it's ready to test the VMs and then migrate them into production.
   - As machines start running in Azure, Contoso installs the [AVD VM agent](https://aka.ms/wvdvmagent) on each machine.
   - As a part of the installation, enter the registration token for the AVD environment to associate the server with the correct environment.

1. The registration token can be obtained by using the following commands:

    ```powershell
    Export-RDSRegistrationInfo -TenantName "Contoso" -HostPoolName "ContosoWVD" | Select-Object -ExpandProperty Token > .\registration-token.txt
    ```

   > [!NOTE]
   > Contoso can also automate this process by using `msiexec` commands and passing in the registration token as a variable.

   > [!NOTE]
   > Microsoft generally recommends to rebuild an image in Azure to ensure compatibility and remove any possible bloat from the existing on-premises images. 
   >
   >For scenarios on which an image needs to be migrated to Azure, [this guide](https://learn.microsoft.com/azure/virtual-machines/windows/prepare-for-upload-vhd-image) contains detailed instructions on preparing and uploading an image to Azure. This guide covers the steps needed to package the image into a virtual hard disk (VHD) format. Once the VHD is prepared, you can then upload it to Azure and use it to create new VMs in your Azure environment.

   > [!NOTE]
   > It's important to note that if VMs are being migrated through replication, the image will migrate with them, so you will not need to upload it separately. However, if you are creating new VMs in Azure, or if you want to use the same image across multiple VMs, then you will need to follow the steps outlined in the guide to prepare and upload the image to Azure.

1. As the last step before the final migration, Contoso selects the **Users** item in the AVD settings to map the servers to their respective users and groups.

   :::image type="content" source="./media/contoso-migration-rds-to-wvd/azure-virtual-desktop-users-map-servers.png" alt-text="[Screenshot that shows assigning AVD resources to users and groups.":::
   *Figure 19: The last step prior to the final migration.*

After host pools are assigned to users, Contoso finalizes the migration of those machines and continues to gradually migrate the rest of the on-premises VDI hosts to Azure.

## Review the deployment

With the virtual desktops and application servers now running in Azure, Contoso now needs to fully operationalize and secure the deployment.

### Security

The Contoso security team reviews the Azure VMs to determine any security issues. To control access, the team reviews the network security groups (NSGs) for the VMs. NSGs are used to ensure that only traffic allowed to the application can reach it. The team also considers securing the data on the disk by using Azure Disk Encryption and Azure Key Vault. Session Hosts should also be protected using Defender for Endpoint or the product of choosing, ensure your vendor supports their product in Azure VDI environments. Also opt to protect AVD landing zone subscriptions with Defender for Cloud for increased visibility and compliance controls.

For more information, see [AVD security best practices](https://learn.microsoft.com/en-us/azure/virtual-desktop/security-guide).

### Business continuity and disaster recovery

AVD uses a combination of Microsoft managed components that come with a non-financially backed SLA targeting 99.9% uptime for our AVD Gateways, Brokers, Web Access, and diagnostics. These services meta-data and service-data are backed up and replicated behind the scenes to recover to alternate regions in the event of an outage. Contoso is responsible for the customer managed components, that includes Virtual Machines, Storage, Images, Applications, and the network components for their DR requirements. 

   > [!NOTE]
   > Learn more about BCDR options with [Business continuity and disaster recovery considerations for AVD](https://learn.microsoft.com/azure/cloud-adoption-framework/scenarios/wvd/eslz-business-continuity-and-disaster-recovery).

Contoso backs up the data on the VMs by using Azure Backup to keep data safe. For more information, see [An overview of Azure VM backup](https://learn.microsoft.com/azure/backup/backup-azure-vms-introduction).

### Licensing and cost optimization

- [Microsoft 365 licenses](https://azure.microsoft.com/pricing/details/virtual-desktop/) are used for the desktop deployments. If Windows Server session hosts are still required, Contoso will need to bring their RDS user CAL licenses. Thanks to AVD licensing entitlement, there is no OS cost for any operating system, including Windows Server.
- Contoso will enable [Azure Cost Management + Billing](https://learn.microsoft.com/azure/cost-management-billing/cost-management-billing-overview) to help monitor and manage the Azure resources.
- Contoso will use [AVD Tagging](https://learn.microsoft.com/azure/virtual-desktop/tag-virtual-desktop-resources) to track costs and group it based on related resources to the hostpool.
- Contoso will monitor utilization across their entire AVD deployments using [AVD Insights](https://learn.microsoft.com/azure/virtual-desktop/insights) and assess the cost savings opportunities of Reserved Instances, Savings Plans or Reserved Capacity.

## Conclusion

In this article, Contoso moved its RDS deployment to AVD.
