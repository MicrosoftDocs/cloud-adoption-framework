---
title: Move on-premises Remote Desktop Services to Azure Virtual Desktop
description: Learn how to migrate an on-premises Remote Desktop Services environment to Azure Virtual Desktop in the cloud.
author: benstegink
ms.author: martinek
ms.date: 09/07/2021
ms.reviewer: ssumner
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
ms.custom: think-tank
---

# Move on-premises Remote Desktop Services to Azure Virtual Desktop scenario

[Azure Virtual Desktop](/azure/virtual-desktop/overview) is a desktop and application virtualization service that runs on the cloud. It's the only desktop and application virtualization infrastructure that delivers simplified management, Windows 10 and Windows 11 Enterprise multi-session or Windows Server operating systems, and optimizations for Microsoft 365 Apps for the enterprise. You can deploy and scale Windows desktops and applications on Azure in minutes, and get built-in security and compliance features.

In this article, Contoso migrates and modernizes their on-premises VDI environment based on Remote Desktop Services (RDS) in Windows Server to Azure Virtual Desktop.

> [!IMPORTANT]
> This guidance will not apply for migrating from other VDI solutions like Citrix or VMware Horizon.

| Migration options | Outcome |
|--- | --- |
| [Azure Migrate](/azure/migrate/migrate-services-overview) | Assess and migrate on-premises RDS environments. <br><br> Run workloads in an Azure Virtual Desktop environment.

## Business drivers

Working closely with business partners, the Contoso IT team defines the business drivers for a VDI migration to Azure. These drivers might include:

- **Current environment end-of-life:** A datacenter is out of capacity when it reaches the end of a lease or is closing down. Migrating to the cloud provides virtually unlimited capacity. Current software might also be reaching its end of life where it's become necessary to upgrade the software running Contoso's desktops and application virtualization solution.
- **Reduce cost:** Reduce costs with pooled, multi-session resources. With the new Windows 11 and Windows 10 Enterprise multi-session capability, exclusive to Azure Virtual Desktop, and the Remote Desktop Session Host (RDSH) role on Windows Server, you can greatly reduce the number of virtual machines (VMs) and operating system overhead while still providing the same resources to your users.
- **Optimize for Microsoft 365 Apps for enterprise:** Deliver the best Microsoft 365 Apps for enterprise experience, with multi-session virtual desktop scenarios providing the most productive virtualized experience for Contoso's users.
- **Deploy and scale in minutes:** Quickly virtualize and deploy modern and legacy desktop applications to the cloud in minutes with unified management in the Azure portal.
- **Secure and productive on Azure and Microsoft 365:** Deploy a complete, intelligent solution that enhances creativity and collaboration for everyone. Shift to Microsoft 365, Windows 11 or Windows 10, and Enterprise Mobility + Security.

## RDS on-premises to Azure Virtual Desktop goals

With the business drivers in mind, Contoso defines the goals for this migration:

- Modernize the desktop and application virtualization environment for the cloud.
- Take advantage of existing [Microsoft 365 licenses](/azure/virtual-desktop/prerequisites#operating-systems-and-licenses) with Azure Virtual Desktop.
- Improve the security of corporate data while providing service to remote and hybrid users.
- Optimize the new environment for cost and enterprise-scale growth.

These goals support the decision to use Azure Virtual Desktop and validate it as the best migration method for Contoso.

## Benefits of running Azure Virtual Desktop

Using Azure Virtual Desktop, Contoso can now seamlessly run, manage, and scale its desktop and application virtualization solution quickly and easily. The company can also provide an optimized multi-session solution on Windows 10 or Windows 11 environments to its users.

Contoso capitalizes on existing Microsoft 365 licenses while using the scale, performance, security, and innovation of Azure.

Additional benefits might include:

- Access to Azure Virtual Desktop from anywhere.
- Optimized Microsoft 365 Apps for enterprise environment.
- Azure Virtual Desktop for dev/test environments.
- Removing the need for RDS CAL (Client Access License) licenses, when replacing Windows server multi-session hosts with Windows 10 or Windows 11 multi-session.

## Current architecture

RDS personal and pooled resources are deployed to an on-premises datacenter. Microsoft 365 is licensed and in use by the organization.

## Solution design

After assessing current RDS deployment, defining goals and requirements, Contoso designs and reviews a deployment solution and identifies the migration process.

## Proposed architecture

The following diagram outlines the architecture that will be built to migrate RDS on-premises deployment to Azure Virtual Desktop.

   :::image type="content" border="false" source="https://raw.githubusercontent.com/Azure/avdaccelerator/main/workload/docs/diagrams/avd-accelerator-baseline-architecture.png" alt-text="*Figure 1: Proposed architecture: Azure Virtual Desktop LZA will deploy the resources contained under the Azure Virtual Desktop LZ Subscription*" lightbox="https://raw.githubusercontent.com/Azure/avdaccelerator/main/workload/docs/diagrams/avd-accelerator-baseline-architecture.png":::
   *Figure 1: Proposed architecture: Azure Virtual Desktop LZA will deploy the resources contained under the Azure Virtual Desktop LZ Subscription*

   Download [Visio file](https://raw.githubusercontent.com/Azure/avdaccelerator/main/workload/docs/diagrams/avd-accelerator-baseline-architecture.vsdx)

The diagram outlines resources that are prerequisites for the migration (Identity, management, connectivity, AAD sync) and the resources that are created by the Azure Virtual Desktop Landing Zone Accelerator deployment under the AVD LZ and AVD Shared Services LZ subscriptions. More information on resources deployed can be found in the Azure Virtual Desktop [Landing Zone Accelerator resource organization diagram](https://raw.githubusercontent.com/Azure/avdaccelerator/main/workload/docs/diagrams/avd-accelerator-resource-organization-naming.png).

## Migration process

Contoso will go through the following flow to migrate from on-premises RDS to Azure Virtual Desktop:

   :::image type="content" border="false" source="./media/contoso-migration-rds-to-wvd/rds-to-avd-migration-flow.png" alt-text="*Figure 2: The migration process.*" lightbox="./media/contoso-migration-rds-to-wvd/rds-to-avd-migration-flow.png":::
   *Figure 2: The migration process.*

The migration flow will be structured in the following migration steps:

1. [Define prerequisites](./contoso-migration-rds-to-wvd.md#step-1-prerequisites).
1. [Assess the current RDS on-premises environment](./contoso-migration-rds-to-wvd.md#step-2-assess-the-current-rds-on-premises-environment).
1. [Deploy Azure Virtual Desktop Landing Zone Accelerator (LZA)](./contoso-migration-rds-to-wvd.md#step-3-deploy-azure-virtual-desktop-landing-zone-accelerator-lza).
1. [Prepare users for new profiles using FSLogix](./contoso-migration-rds-to-wvd.md#step-4-prepare-users-for-new-profiles-using-fslogix).
1. [Migrate VMs that must persist to Azure (optional)](./contoso-migration-rds-to-wvd.md#step-5-migrate-vms-that-must-persist-to-azure-optional).
1. [Migrate VM images that must persist to Azure (optional)](./contoso-migration-rds-to-wvd.md#step-6-migrate-vm-images-that-must-persist-to-azure-optional).
1. [Manage the Azure Virtual Desktop](./contoso-migration-rds-to-wvd.md#step-7-manage-azure-virtual-desktop).
1. [Optimize the Azure Virtual Desktop](./contoso-migration-rds-to-wvd.md#step-8-optimize-azure-virtual-desktop).

## Migration

Contoso will now progress through the steps required to complete the Azure Virtual Desktop migration:

### Step 1: Prerequisites

1. An Azure subscription is required ([subscription requirements](https://github.com/Azure/avdaccelerator/blob/main/workload/docs/getting-started-baseline.md#subscription-requirements)).

1. Make sure that domain services, either Active Directory Domain Services (AD DS) or Azure Active Directory Domain Services (Azure AD DS), are synchronized with Azure Active Directory (Azure AD). Ensure the domain service is accessible from the Azure subscription and virtual network where you deploy Azure Virtual Desktop session hosts. Azure Virtual Desktop requires hybrid user identities for majority of your Azure Virtual Desktop deployments and desired features. The Azure Virtual Desktop service requires users user principal name (UPN) or security identifier (SID) to match between on-premises AD and Azure AD.

1. Prior to the deployment of the Azure Virtual Desktop LZA, ensure the [Azure Virtual Desktop LZA Prerequisites](https://github.com/Azure/avdaccelerator/blob/main/workload/docs/getting-started-baseline.md#prerequisites) are met.

   > [!NOTE]
   > Learn more about:
   >
   > - *[Azure Virtual Desktop identities and authentication](/azure/virtual-desktop/authentication)* provides a comprehensive list of requirements and supported features based on your identity strategy and configuration.
   > - Active Directory sync options:
       > - *[Azure AD Connect](/azure/active-directory/hybrid/how-to-connect-install-express)*
       > - *[Azure AD Connect Cloud Sync](/azure/active-directory/cloud-sync/concept-how-it-works)*
   > - *[Azure AD DS](/azure/active-directory-domain-services/tutorial-create-instance)* and synchronizing with Azure AD.
   > - Firewall rules *[Required URLs for Azure Virtual Desktop](/azure/virtual-desktop/safe-url-list?tabs=azure#session-host-virtual-machines)* to ensure all required URLs are whitelisted for connectivity from hosts and clients to Azure Virtual Desktop resources.
   > - Azure Virtual Desktop *[LZA Baseline Deployment URL Requirements](https://github.com/Azure/avdaccelerator/blob/main/workload/docs/getting-started-baseline.md#prerequisites)*.

### Step 2: Assess the current RDS on-premises environment

1. Sign in to the [Azure portal](https://portal.azure.com).
1. In the search bar, type *Azure Migrate* and select the matching service entry.
1. In **Get started** for Azure Migrate, select **Discover, assess and migrate**.

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

   :::image type="content" border="false" source="./media/contoso-migration-rds-to-wvd/lakeside-login.png" alt-text="Screenshot of signing in to connect Azure and Lakeside." lightbox="./media/contoso-migration-rds-to-wvd/lakeside-login.png":::
   *Figure 9: Connecting Azure to Lakeside.*

1. Contoso continues with the Lakeside tool to create a new tenant and start assessing the current on-premises RDS environment. From the dashboard, Contoso can access the deployment guide, download the assessment client to deploy to the current environment, and review the data collected from these agents.

   :::image type="content" border="false" source="./media/contoso-migration-rds-to-wvd/lakeside-new-tenant-dashboard.png" alt-text="Screenshot of the Lakeside dashboard." lightbox="./media/contoso-migration-rds-to-wvd/lakeside-new-tenant-dashboard.png":::
   *Figure 10: The Lakeside dashboard.*

1. After (3) standard business cycles with average usage an adequate amount of data is captured and Contoso reviews the assessment data to determine the best migration path. This assessment data includes the raw assessment data from the desktops data and the data broken into different user personas. This information includes the:

    - Number of users in each persona.
    - Applications in use by users.
    - Resource consumption by user.
    - Resource utilization averages by user persona.
    - VDI server performance data.
    - Concurrent user reports.
    - Top software packages in use.

   :::image type="content" border="false" source="./media/contoso-migration-rds-to-wvd/lakeside-dashboard-reports.png" alt-text="Screenshot of Lakeside dashboard reports." lightbox="./media/contoso-migration-rds-to-wvd/lakeside-dashboard-reports.png":::
   *Figure 11: Lakeside dashboard reports.*

    The data is analyzed by Contoso to determine the most cost-effective use of both pooled Azure Virtual Desktop resources and personal Azure Virtual Desktop resources.

> [!IMPORTANT]
> Reviewing the assessment data, Contoso defines two RDS scenarios:
>
> 1. **Multi-session (non-persistent):** RDS hosts running Windows server and allowing multiple users connections to the same host.
> 1. **Single-session (persistent):** RDS hosts running Windows 10 or Windows 11.
> [!NOTE]
> To improve performance of Azure Virtual Desktop users flows, Contoso will also need to migrate application servers and data sources that will be consumed by the Azure Virtual Desktop environment. This same methodology should be applied to platform shared services (domain Controllers, DNS, network devices, among others) that Azure Virtual Desktop will rely on. Best practice is to host these services in the same Azure Region as the Azure Virtual Desktop session hosts.

### Step 3: Deploy Azure Virtual Desktop Landing Zone Accelerator (LZA)

Contoso is ready to deploy Azure Virtual Desktop. The Azure Virtual Desktop LZA is Microsoft's enterprise-ready solution that can be used to deploy an end-to-end Azure Virtual Desktop enterprise-ready environment. To deploy the accelerator follow the Azure Virtual Desktop [LZA Deployment Walk Through](https://github.com/Azure/avdaccelerator/blob/main/workload/docs/deploy-baseline.md) guide.

> [!IMPORTANT]
> Based on the outcome of the assessment phase, two Azure Virtual Desktop LZA deployments in *East US 2* will be required to address Contoso scenarios:
> 1. **Multi-session (pooled host pool):** Azure Virtual Desktop management plane (workspace, host pool, application group, scaling plan) deployment with Windows 10 or Windows 11 multi-session session hosts and FSLogix to manage users profile data.
> 1. **Single-session (personal host pool):** Azure Virtual Desktop management plane (workspace, host pool, application group, scaling plan) deployment without the creation of new session hosts (personal VMs will be migrated from RDS).

| Deployment Type | Link |
|:--|:--|
| Azure portal UI |[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Favdaccelerator%2Fmain%2Fworkload%2Farm%2Fdeploy-baseline.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Favdaccelerator%2Fmain%2Fworkload%2Fportal-ui%2Fportal-ui-baseline.json)
| Command line (Bicep/ARM) | [![Powershell/Azure CLI implementation](https://raw.githubusercontent.com/Azure/avdaccelerator/main/workload/docs/icons/powershell.png)](https://github.com/Azure/avdaccelerator/tree/main/workload/bicep/readme.md#avd-accelerator-baseline) |
| Terraform | [![Terraform implementation](https://raw.githubusercontent.com/Azure/avdaccelerator/main/workload/docs/icons/terraform.png)](https://github.com/Azure/avdaccelerator/tree/main/workload/terraform/greenfield/readme.md) |

At this point, the Azure Virtual Desktop environment is available. Contoso can continue to prepare users profiles data to be moved to new FSLogix profiles in the Azure Virtual Desktop environment.

### Step 4: Prepare users for new profiles using FSLogix

> [!NOTE]
> Microsoft does not support migrating profiles from User Profile Disks (UPD) or Roaming User Profiles (RUP) to FSLogix.

Azure Virtual Desktop doesn't support user profile disks (UPDs), so Contoso needs to prepare their users for new profiles using FSLogix. Starting users with new profiles provides the best transition from UPD or RUP profiles. To make this transition, Contoso needs to enable the users to save or backup their data before they sign into their desktops for the first time.

1. Enable **[Microsoft Edge enterprise sync](https://github.com/deployedge/microsoft-edge-enterprise-sync)**. If other browsers are used, export and import bookmarks or favorites to Microsoft Edge.
1. Enable OneDrive for the users moving to Azure Virtual Desktop.
1. Enable **[known folder redirection](https://github.com/sharepoint/redirect-known-folders)** to OneDrive (optional).
Both user and non-user data should be saved or backed up to OneDrive, SharePoint or other document repositories.
1. Both user and non-user data should be saved or backed up to OneDrive, SharePoint or other document repositories.

> [!IMPORTANT]
> Users might require settings or application data in their profile from third party or other line-of-business applications. If that data is necessary, you should preserve it following the recommendation of the vendor. Microsoft is not responsible for this data.

For more information about FSLogix:

- **[Tutorial: Configure profile containers](https://github.com/fslogix/tutorial-configure-profile-containers)**
- **[Configuration examples](https://github.com/fslogix/concepts-configuration-examples)**
- **[FSLogix FAQ](https://github.com/fslogix/overview-faq)**

At this point, the users have saved or backed up their important profile data. Contoso can continue to start replicating and persisting VMs to Azure Virtual Desktop.

### Step 5: Migrate VMs that must persist to Azure (optional)

The next optional step in the migration process for Contoso is to migrate the RDS host (running Windows Server) that must persist to Azure Virtual Desktop. To do this, Contoso goes back to the *Azure Migrate: Server Migration* job it created on step 2.

> [!IMPORTANT]
> - Instead of migrating RDS hosts, Microsoft recommends to redeploy VMs using Azure market place images or custom images built from the marketplace, as these will ensure compatibility and remove any possible bloat from the existing on-premises images. Tooling for building new images is available at the Azure Virtual Desktop LZA *[Custom Image Build - Getting Started](https://github.com/Azure/avdaccelerator/blob/main/workload/docs/getting-started-custom-image-build.md)*
> - Azure Migrate only supports Windows Server Operating System migrations. Client Operating Systems such as Windows 10 can be Migrated using *[Azure Site Recovery replication and failover](./azure/site-recovery/migrate-tutorial-on-premises-azure#migrate-with-site-recovery)*, once these VMs are available in Azure, skip to section 5 to install and configure the AVD agents.

1. Contoso starts by selecting **Discover** in the Azure Migrate: Server Migration tools.

   :::image type="content" border="false" source="./media/contoso-migration-rds-to-wvd/wvd-persist-discover.png" alt-text="Screenshot of the Azure Migrate: Server Migration discover option." lightbox="./media/contoso-migration-rds-to-wvd/wvd-persist-discover.png":::
   *Figure 16: Discovering a server migration.*

1. Contoso converts an appliance in its environment that's going to manage the replication of the machines to Azure Virtual Desktop. Ensure that the target region is set to *East US 2*, where the Azure Virtual Desktop environment was created. For full Azure Migrate OS Support matrix, see [Support Matrix for Hyper-V](/azure/migrate/migrate-support-matrix-hyper-v-migration) and [Support Matrix for VMware vSphere](/azure/migrate/migrate-support-matrix-vmware-migration).

   :::image type="content" source="./media/contoso-migration-rds-to-wvd/azure-migrate-discover-resources.png" alt-text="Screenshot that shows creating an appliance for managing the replication.":::
   *Figure 17: Converting an appliance.*

1. Contoso downloads, installs, and registers the replication provider to the Azure Migrate project to start the replication to Azure.

   :::image type="content" source="./media/contoso-migration-rds-to-wvd/azure-migrate-discover-prepare-replication.png" alt-text="Screenshot that shows downloading and configuring replication.":::
   *Figure 18: Prerequisites for replicating to Azure.*

1. The replication of the hosts into Azure Blob Storage starts. Contoso can continue to let the replication occur until it's ready to test the VMs and then migrate them into production.

1. As migrated VMs start running in Azure, Contoso will need to install and configure Azure Virtual Desktop agents on each migrated:
   - Get host pool registration token, following guidance outlined in [Generate a registration key](/azure/virtual-desktop/add-session-hosts-host-pool#generate-a-registration-key).
   - Install Azure Virtual Desktop agents and register VMs to the host pool following the guidance outlined in [Register session hosts to a host pool](/azure/virtual-desktop/add-session-hosts-host-pool#register-session-hosts-to-a-host-pool).

> [!NOTE]
> Contoso can automate this process by using `msiexec` commands and passing in the registration token or by using VM custom script extension to deploy the agents Azure Virtual Desktop (*[LZA Automation](https://github.com/Azure/avdaccelerator)*).

At this point, Contoso finalizes the migration of the machines that must persist and continues to gradually migrate the rest of the on-premises RDS hosts to Azure Virtual Desktop.

### Step 6: Migrate VM images that must persist to Azure (optional)

> [!IMPORTANT]
> Instead of migrating VM images, Microsoft recommends to use Azure market place or custom images built from the marketplace, as these will ensure compatibility and remove any possible bloat from the existing on-premises images. Tooling for building new VM images is available at the Azure Virtual Desktop LZA *[Custom Image Build - Getting Started](https://github.com/Azure/avdaccelerator/blob/main/workload/docs/getting-started-custom-image-build.md)*.

For scenarios on which VM image must persist to Azure Virtual Desktop, the following article provides guidance to  [prepare a Windows VHD or VHDX to upload to Azure](/azure/virtual-machines/windows/prepare-for-upload-vhd-image).

### Step 7: Manage Azure Virtual Desktop

1. **Publish applications and desktops**: Azure Virtual Desktop LZA deployment creates by default one application group for desktops and has the option to also deploy a remote apps application group. Post deployment there is no need to manage desktops as they are published by default, remote apps can be managed by following the guidance on the docs:
   - [Manage application groups with the Azure portal](/azure/virtual-desktop/manage-app-groups).
   - [Manage application groups using PowerShell or the Azure CLI](/azure/virtual-desktop/manage-app-groups-powershell?tabs=azure-powershell).
   - [Publish built-in apps in Azure Virtual Desktop](/azure/virtual-desktop/publish-apps).

1. **Managing session hosts**: once the session hosts are deployed and joined to the domain, they can be managed using existing tools like SCCM and Group Policy. Microsoft Intune can also be used to help you manage your devices and apps. To get started with Intune, refer to the [Microsoft Intune documentation](https://learn.microsoft.com/en-us/mem/intune/fundamentals/get-started-with-intune).

1. **User access assignments**: as the last step before the final migration, Contoso selects the **Users** item in the Azure Virtual Desktop settings to map the servers to their respective users and groups.

      :::image type="content" source="./media/contoso-migration-rds-to-wvd/azure-virtual-desktop-users-map-servers.png" alt-text="[Screenshot that shows assigning Azure Virtual Desktop resources to users and groups.":::
      *Figure 19: The last step prior to the final migration.*

   Additional user assignment information can be found at [Manage application groups with the Azure portal](/azure/virtual-desktop/manage-app-groups).

1. **Host pool scaling**: Azure Virtual Desktop LZA deployment has the option to create an Azure Virtual Desktop scaling plan (enabled by default) that is assigned and enabled on the host pool (pooled host pools), the scaling plan is pre configured with to schedules (weekdays and weekend) in the same time zone as the session hosts and default scaling rules.

   :::image type="content" border="false" source="./media/contoso-migration-rds-to-wvd/azure-migrate-scaling-plans.png" alt-text="Azure Virtual Desktop LZA scaling plan." lightbox="./media/contoso-migration-rds-to-wvd/azure-migrate-scaling-plans.png":::
   *Figure 20: Azure Virtual Desktop scaling plan schedules sample.*

   Scaling rules should be modified to meet the specific needs of the workloads the Azure Virtual Desktop environment is hosting. Information on configuring scaling plans can be found at [Autoscale scaling plans and example scenarios](/azure/virtual-desktop/autoscale-scenarios).

1. **Monitoring**: Azure Virtual Desktop LZA deployment has the option to deploy all diagnostics settings (enabled by default) required by the Azure Virtual Desktop insights workbook, including the creation of a new log analytics workspace (option to use existing is available) to gather Azure Virtual Desktop logs, metrics and events.

   :::image type="content" border="false" source="./media/contoso-migration-rds-to-wvd/azure-migrate-avd-insights.png" alt-text="Azure Virtual Desktop LZA insights." lightbox="./media/contoso-migration-rds-to-wvd/azure-migrate-avd-insights.png":::
   *Figure 21: Azure Virtual Desktop monitor insights sample.*

   More information on Azure Virtual Desktop monitoring can be found at [Use Azure Virtual Desktop Insights to monitor your deployment](/azure/virtual-desktop/insights).

### Step 8: Optimize Azure Virtual Desktop

1. **Security**: Contoso's security team reviews the Azure VMs to determine any security issues. To control access, the team reviews the network security groups (NSGs) for the VMs. NSGs are used to ensure that only traffic allowed to the application can reach it. The team also considers securing the data on the disk by using Azure Disk Encryption and Azure Key Vault. Session Hosts should also be protected using Defender for Endpoint or the product of choosing, ensure your vendor supports their product in Azure VDI environments. Also opt to protect Azure Virtual Desktop landing zone subscriptions with Defender for Cloud for increased visibility and compliance controls.

   > [!NOTE]
   > Learn more about Azure Virtual Desktop security with Azure Virtual Desktop *[security best practices](/azure/virtual-desktop/security-guide)*.

1. **Licensing**: [Microsoft 365 licenses](https://azure.microsoft.com/pricing/details/virtual-desktop/) are used for the desktop deployments. If Windows Server session hosts are still required, Contoso will need to bring their RDS CAL (Client Access License) licenses. Thanks to Azure Virtual Desktop licensing entitlement, there is no OS cost for any operating system, including Windows Server.

1. **Cost optimization**: Contoso will use the following features to help with cost optimization:
   - Contoso will enable [Azure Cost Management + Billing](/azure/cost-management-billing/cost-management-billing-overview) to help monitor and manage the Azure resources.
   - Contoso will use Azure Virtual Desktop [Tagging](/azure/virtual-desktop/tag-virtual-desktop-resources) to track costs and group it based on related resources to the host pool.
   - Contoso will monitor utilization across their entire Azure Virtual Desktop deployments using Azure Virtual Desktop [Insights](/azure/virtual-desktop/insights) and assess the cost savings opportunities of Reserved Instances, Savings Plans or Reserved Capacity.

1. **Configure Business continuity and disaster recovery (BCDR)**: Azure Virtual Desktop uses a combination of Microsoft managed components that come with a non-financially backed SLA targeting 99.9% uptime for our Azure Virtual Desktop Gateways, Brokers, Web Access, and diagnostics. These services meta-data and service-data are backed up and replicated behind the scenes to recover to alternate regions in the event of an outage. Contoso is responsible for the customer managed components, that includes Virtual Machines, Storage, Images, Applications, and the network components for their DR requirements.

    - For large-scale global deployments of Azure Virtual Desktop, we recommend adopting a multi-region architecture to reduce single point of failures on any single region.
    - The following diagram is an example of an Azure Virtual Desktop multi-region architecture designed for regional Azure Virtual Desktop deployments to be entirely independent. Depending on the SLA requirements, there can be varying levels of dependencies on the primary region. Sample diagrams for varying levels of dependency can be found in the Azure Virtual Desktop Landing Zone Accelerator documentation Azure Virtual Desktop**[Landing Zone Accelerator Diagrams](https://github.com/Azure/avdaccelerator/tree/main/workload/docs/diagrams)**
    
       :::image type="content" border="false" source="https://raw.githubusercontent.com/Azure/avdaccelerator/main/workload/docs/diagrams/avd-accelerator-baseline-architecture-multi-region-stage-3.png" alt-text="Azure Virtual Desktop Multi-region deployment Stage 3." lightbox="https://raw.githubusercontent.com/Azure/avdaccelerator/main/workload/docs/diagrams/avd-accelerator-baseline-architecture-multi-region-stage-3.png":::
       *Figure 22: Sample of an Azure Virtual Desktop multi-region architecture.*
    
       Download [Visio file.](https://raw.githubusercontent.com/Azure/avdaccelerator/main/workload/docs/diagrams/avd-accelerator-baseline-architecture-multi-region-stage-3.vsdx)
    
   > [!NOTE]
   > Learn more about BCDR options with *[Business continuity and disaster recovery considerations for Azure Virtual Desktop](/azure/cloud-adoption-framework/scenarios/wvd/eslz-business-continuity-and-disaster-recovery)*.

## Conclusion

In this article, Contoso moved its RDS deployment to Azure Virtual Desktop.
