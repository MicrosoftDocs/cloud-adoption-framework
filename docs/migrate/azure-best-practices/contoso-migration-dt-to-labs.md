---
title: "Migrate a dev/test environment using Azure DevTest Labs"
description: Learn how Contoso moves their on-premises DevTest to Azure using Azure DevTest Labs.
author: deltadan
ms.author: abuck
ms.date: 05/11/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
services: azure-migrate
---

<!-- cSpell:ignore vcenter -->

# Migrate a dev/test environment to Azure using DevTest Labs (scenario)

This article demonstrates how the fictional company Contoso migrates their dev/test environment to Azure using DevTest Labs.

## Migration options

Contoso has several options available when moving their dev/test environment to Azure.

| Migration options | Outcome |
| --- | --- |
| [Azure Migrate](https://docs.microsoft.com/azure/migrate/migrate-services-overview) | [Assess](https://docs.microsoft.com/azure/migrate/tutorial-assess-vmware) and [migrate](https://docs.microsoft.com/azure/migrate/tutorial-migrate-vmware) on-premises VMs <br><br> Run dev/test servers using Azure IaaS <br><br> Manage VMs with [Azure Resource Manager](https://azure.microsoft.com/features/resource-manager/) |
| [Azure DevTest Labs](https://docs.microsoft.com/azure/devtest-labs/devtest-lab-overview) | Quickly provision development and test environments <br><br> minimize waste with quotas and policies <br><br> Set automated shutdowns to minimize costs <br><br> Build Windows and Linux environments |

> [!NOTE]
> This article focuses on using Azure DevTest Labs to move an on-premises dev/test environment to Azure. Read how Contoso moved [dev/test to Azure IaaS](./contoso-migration-dt-to-iaas.md) via Azure Migrate.

## Business drivers

The development leadership team has outlined what they want to achieve with this migration:

- Empower developers with access to DevOps tools and self service environments.
- Access to DevOps tools for CI/CD pipelines and cloud-native tools for dev/test such as AI, machine learning and serverless.
- Ensure governance and compliance in dev/test environments.
- Save costs by moving all dev/test environments out of their datacenter, and no longer purchase hardware to develop software.

> [!NOTE]
> Contoso will use the [Pay-As-You-Go Dev/Test subscription offer](https://azure.microsoft.com/offers/ms-azr-0023p) for their environments. Each active Visual Studio subscriber on their team can use the Microsoft software included with their subscription on Azure Virtual Machines for dev/test at no extra charge. Contoso will just pay the Linux rate for VMs they run, even VMs with SQL Server, SharePoint Server, or other software that is normally billed at a higher rate.

<!-- -->

> [!NOTE]
>Azure customers with a enterprise agreements can also benefit from the [dev/test subscription offer](https://azure.microsoft.com/offers/ms-azr-0148p/). To learn more, review this [video](https://channel9.msdn.com/blogs/EA.Azure.com/Enabling-and-Creating-EA-DevTest-Subscriptions-through-the-EA-Portal) on creating a dev/test subscription using the Enterprise Agreement portal.

## Migration goals

The Contoso development team has pinned down goals for this migration. These goals are used to determine the best migration method:

- Quickly provision development and test environments. It should take minutes not months to build the infrastructure a developer needs to write or test software.
- After migration, Contoso's dev/test environment in Azure should have enhanced capabilities over the current system on-premises.
- The operations model will move from IT provisioned VMs to DevOps with self-service provisioning.
- Contoso wants to quickly move out of their on-premises dev/test environments.
- All developers to connect to dev/test environments remotely, but in a secure manner.

## Solution design

After pinning down goals and requirements, Contoso designs and reviews a deployment solution, including the Azure services they will use for dev/test.

### Current architecture

- The dev/test VMs for Contoso's applications are running on VMware in their on-premises datacenter.
- These VMs are used for development and testing prior to code being promoted to the production VMs.
- Developers maintain their own workstations, but need new solutions for connecting remotely since many of them are working from home.

### Proposed architecture

- Contoso will use a [dev/test subscription](https://azure.microsoft.com/offers/ms-azr-0023p) to reduce costs for Azure resources. This subscription offers significant savings including VMs that don't incur licensing fees for Microsoft software.
- Azure DevTest Labs will be used for managing the environments. New VMs will be created in DevTest Labs to support their move to new tools for development and test in the cloud.
- The on-premises dev/test VMs in the Contoso datacenter will be decommissioned after the migration is done.
- Developers and testers will have access to Windows Virtual Desktop for their workstations.

![Scenario architecture](./media/contoso-migration-dt-to-labs/architecture.png)

### Database considerations

To support ongoing development, Contoso has decided to continue use databases running on VMs, but the current VMs will be replaced with new ones running in Azure DevTest Labs. In the future, Contoso will pursue the use of PaaS services such as [Azure SQL Database](https://docs.microsoft.com/azure/azure-sql/database/sql-database-paas-overview) and [Azure Database for MySQL](https://docs.microsoft.com/azure/mysql/overview).

- Current VMware database VMs will be decommissioned and replaced with Azure VMs in DevTest Labs. The existing databases will be migrated with simple backups and restores.
- By using the Azure Dev/Test subscription offer, the Windows and SQL servers will not incur licensing fees which will minimize compute costs.

### Solution review

Contoso evaluates the proposed design by putting together a pros and cons list.

<!-- markdownlint-disable MD033 -->

| Consideration | Details |
| --- | --- |
| **Pros** | All of the current development VMs (application and database), will be replaced by new VMs running in Azure DevTest Labs. This means they can take advantage of the features of a purpose-built cloud development environment. <br><br> Contoso can take advantage of their investment in the Azure Dev/Test subscription to save on licensing fees. <br><br> Contoso will retain full control of the app VMs in Azure. <br><br> Developers will be provided with rights to the subscription which empowers them to create new resources without waiting for IT to respond to their requests. |
| **Cons** | The migration will only move development to the cloud, but since they're still using VMs they won't be using using PaaS services in their development. This means that Contoso will need have to start supporting the operations of their VMs including security patches. This was maintained by IT in the past, so they will need to find a solution to this new operational task. <br><br> Contoso will have to build new application and database VMs, but in doing so they will be automating the process. This means they can take advantage of building VMs in the cloud and tools provided by DevTest Labs, so this is a positive outcome even with a con on their list. |

<!-- markdownlint-enable MD033 -->

### Migration process

Contoso will migrate their development application and databases VMs to new Azure VMs using Azure DevTest Labs.

- They already have the [Azure infrastructure](./contoso-migration-infrastructure.md) in place, including their development virtual network.
- With everything prepared, Contoso provisions and configures DevTest Labs.
- They will configure the development virtual network, assign a resource group and set policies.
- Contoso will create Windows virtual desktops for developers to use remote locations.
- Create VMs within DevTest Labs for development and migrate databases.

![Migration process](./media/contoso-migration-dt-to-labs/migration-process-devtest-labs.png)

## Prerequisites

Here's what Contoso needs to run this scenario.

| Requirements | Details |
| --- | --- |
| **Azure Dev/Test subscription** | Contoso creates an [Azure Dev/Test subscription](https://azure.microsoft.com/offers/ms-azr-0023p) to take advantage of up to 80% reduction in costs. <br><br> If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/pricing/free-trial). <br><br> If you create a free account, you're the administrator of your subscription and can perform all actions. <br><br> If you use an existing subscription and you're not the administrator, you need to work with the admin to assign you owner or contributor permissions. <br><br> If you need more granular permissions, review [this article](https://docs.microsoft.com/azure/site-recovery/site-recovery-role-based-linked-access-control). |
| **Azure infrastructure** | [Learn how](./contoso-migration-infrastructure.md) Contoso set up an Azure infrastructure. |

<!-- markdownlint-enable MD033 -->

## Scenario steps

Here's how Contoso admins will run the migration:

> [!div class="checklist"]
>
> - **Step 1: Provision new dev/test subscription and create a DevTest Labs.**
> - **Step 2: Configure the development virtual network, assign a resource group and set policies.**
> - **Step 3: Create Windows 10 multi-session virtual desktops for developers to use from remote locations.**
> - **Step 4: Create formulas and VMs within DevTest Labs for development and migrate databases.**

## Step 1: Provision new dev/test subscription and create a DevTest Labs instance

Contoso first needs a provision a new subscription using the Azure Dev/Test offer and then create a DevTest Labs instance.

They set these up as follows:

1. Contoso follows the link to the [Azure Dev/Test subscription offer](https://azure.microsoft.com/offers/ms-azr-0023p) and provisions a new subscription, saving them up to 80 percent on their systems. This offer allows Contoso to run Windows 10 images on Azure for dev/test. They will gain access to [Windows Virtual Desktop](https://docs.microsoft.com/azure/virtual-desktop/overview) to simplify the management experience of the remote developers.

    ![DevTest Offer](./media/contoso-migration-dt-to-labs/dt-sub.png)

2. With their new subscription provisioned, Contoso uses the Azure portal to create a new DevTest Labs instance.

    - The new lab is created in the `ContosoDevRG` resource group.

    ![Create DevTest Labs with Portal](./media/contoso-migration-dt-to-labs/new-lab.png)

## Step 2: Configure the development virtual network, assign a resource group, and set policies

With the DevTest Labs created Contoso will complete configurations on the following items:

- Configure the virtual network
- Assign a resource group
- Set lab policies

They set these up as follows:

1. Configure the virtual network:

    - In the portal, Contoso opens the DevTest Labs instance and selects ***configuration and policies:**

    ![Configuration and policies](./media/contoso-migration-dt-to-labs/config-lab.png)

    - Contoso selects virtual networks, clicking +add and then selects `vnet-dev-eus2` and then save. This allows the development VNet to be used for VM deployments. There is also a virtual network that was created during the deployment of the DevTest Labs instance.

    ![Virtual networks](./media/contoso-migration-dt-to-labs/vnets.png)

2. Assign resource group

    - To ensure that resources are deployed to the `ContosoDevRG` resource group, Contoso configures this in the lab settings. They also configure their developers as contributor.

    ![Assign resource group](./media/contoso-migration-dt-to-labs/rg.png)

    > [!NOTE]
    > The contributor role is an administrator level role with all rights with the exception of having the ability to provide access to to other users. Read more about [Azure RBAC controls](https://docs.microsoft.com/azure/role-based-access-control/overview).

3. Set lab policies

    - Contoso needs to ensure that their developers are using DevTest Labs within the policies of their team. They configure the DevTest Labs with these policies.

    - Auto-shutdown is enabled with a local time of 7:00:00 pm and the correct timezone.

    ![Auto shutdown](./media/contoso-migration-dt-to-labs/autoshutdown.png)

    - Auto-start is enabled to have their VMs up and running when the developers come online to work. They're configured to the local timezone and for the days of the week when they work.

     ![Auto start](./media/contoso-migration-dt-to-labs/autostart.png)

    - The allowed VM sizes are configured, insuring that large and expensive VMs are not allowed to be started.

    ![Allowed VM Sizes](./media/contoso-migration-dt-to-labs/vmsizes.png)

    - The support message is configured.

    ![Support Message](./media/contoso-migration-dt-to-labs/support.png)

## Step 3: Create Windows 10 multi-session virtual desktops for developers to use from remote locations

Contoso needs to create a Windows Virtual Desktop for remote developers.

1. Contoso creates a Windows 10 multi-session VM from a base.

- Contoso opens **All virtual machines**, clicks **+Add**, and selects a **Windows 10 enterprise multi-session** base.

    ![Windows 10 base](./media/contoso-migration-dt-to-labs/win10vm.png)

- Next the size of the VM is configured along with the artifacts to be installed. In this case, the developers will have access to common development tools such as Visual Studio Code, Git, and Chocolatey.

    ![Artifacts](./media/contoso-migration-dt-to-labs/artifacts.png)

- The VM configuration is reviewed for accuracy.

    ![Create virtual machine from base](./media/contoso-migration-dt-to-labs/vmfrombase.png)

- Once the VM is created, Contoso's remote developers can then connect and use this development workstation for their work. The artifacts selected are installed saving developers time configuring their workstation.

    ![RemoteDevs VM](./media/contoso-migration-dt-to-labs/remotevm.png)

## Step 4: Create formulas and VMs within DevTest Labs for development and migrate databases

With Azure DevTest Labs configured and the remote developers workstation up and running, Contoso focuses on building their VMs for development. To get started, Contoso completes the following steps:

- Create formulas (reusable bases), for application and database VMs.
- Provision application and database VMs using the formulas.

1. Create formulas for application and database VMs:

    - Contoso opens **Formulas**, clicks **+Add**, and selects a **Windows 2012 R2 Datacenter** base.

    ![Windows 2012R2 Base](./media/contoso-migration-dt-to-labs/win2012base.png)

    - Next, the size of the VM is configured along with the artifacts to be installed. In this case, the developers will have access to common development tools such as Visual Studio Code, Git, and Chocolatey.

    ![Windows 2012R2 base configuration](./media/contoso-migration-dt-to-labs/win2012baseconfig.png)

    - To create the database VM formula, Contoso follows the same basic steps this time selecting a SQL Server 2012 image for the base.

     ![SQL 2012R2 base](./media/contoso-migration-dt-to-labs/sql2012base.png)

    - The formula is configured, with the size and artifacts, including SQL Server Management Studio, which is required for this database development VM formula.

    ![SQL 2012R2 base config](./media/contoso-migration-dt-to-labs/sql2012baseconfig.png)

    Learn more about using [formulas](https://docs.microsoft.com/azure/lab-services/devtest-lab-manage-formulas) with Azure DevTest Labs.

    - Contoso has now created the Windows base formulas for their developers to use for their applications and databases.

    ![Configured database VM](./media/contoso-migration-dt-to-labs/contosoformulas.png)

2. Provision application and database VMs using the formulas:

    - With the formulas created, Contoso next selects **All virtual machines** and then the **Windows2012AppDevVmBase** formula to match the configuration of their current application development VMs.

    ![Application VM](./media/contoso-migration-dt-to-labs/appvm.png)

    - The VM is configured, with the size and artifacts that are required for this application VM.

    ![Configured App VM](./media/contoso-migration-dt-to-labs/appvmconfig.png)

    - Next, the database VM is provisioned using the **SQLDbDevVmBase** formula to match the configuration of their current database development VMs.

    ![Database VM](./media/contoso-migration-dt-to-labs/dbvm.png)

    - The VM is configured, with the size and artifacts that are required.

    ![Database VM Config](./media/contoso-migration-dt-to-labs/dbvmconfig.png)

    - With their first VMs created along with their remote developer's workstation, Contoso's developers are ready to start writing code in Azure.

    ![Contoso VMs](./media/contoso-migration-dt-to-labs/contosovms.png)

    - Contoso can now restore their development databases either from backups or using some type of code generation process to build the schema on the VMs. With the SQL management studio already installed using the artifacts, these are simple tasks that don't require installing any tools.

## Clean up after migration

Contoso will continue using these steps to migrate their VMs to Azure using DevTest Labs. With each migration complete, all development VMs are now running in Azure DevTest Labs.

Now, Contoso needs to complete these cleanup steps:

- Remove the VMs from the vCenter inventory.
- Remove all the VMs from from local backup jobs.
- Update internal documentation to show the new location, and IP addresses for the VMs.
- Review any resources that interact with the VMs, and update any relevant settings or documentation to reflect the new configuration.

### Security

The Contoso security team reviews the Azure VMs, to determine any security issues.

- To control access, the team reviews the network security groups (NSGs) for the VMs. NSGs are used to ensure that only traffic allowed to the app can reach it.
- The team also considers securing the data on the disk using Azure Disk Encryption and Azure Key Vault.

For more information, see [Security best practices for IaaS workloads in Azure](https://docs.microsoft.com/azure/security/fundamentals/iaas).

### Licensing and cost optimization

- Contoso will ensure that all development Azure resources are created using this dev/test subscription to take advantage of the 80% savings.
- Budgets will be reviewed for all DevTest Labs and policies for the type of VMs will be put in place to ensure costs are contained and overprovisioning doesn't happen mistakenly.
- Contoso will enable [Azure Cost Management and Billing](https://docs.microsoft.com/azure/cost-management-billing/cost-management-billing-overview) to help monitor and manage the Azure resources.

## Conclusion

In this article, Contoso moved their development environments to Azure DevTest Labs. They also implemented Windows Virtual Desktop as a platform for remote and contract developers.

**Need more help?**

- [Create an Azure DevTest Labs instance](https://docs.microsoft.com/azure/lab-services/devtest-lab-create-lab) in your subscription now.
- Learn how to use [Azure DevTest Labs for developers](https://docs.microsoft.com/azure/lab-services/devtest-lab-developer-lab).
