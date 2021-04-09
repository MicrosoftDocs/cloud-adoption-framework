---
title: Plan and Deploy Azure Migrate for Servers
description: Learn how Contoso sets up an Azure Migrate Server Replication.
author: Alejandra Palacios (mahernan)
ms.author: Alejandra Palacios (mahernan)
ms.date: 04/09/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
ms.custom: azure-fast-track
---

# Plan and Deploy Azure Migrate for Servers

This article shows how the fictional company Contoso prepares its deployment plan for on-premises infrastructure migration using Azure Migrate's server replication features.

When you use this example to help plan your own infrastructure migration efforts, keep in mind that the provided sample plan and deployment is specific to Contoso. Review your organization's business needs, structure, and technical requirements when making important infrastructure migration decisions.

Whether you need all the elements described in this article depends on your migration strategy and needs. For example, you might find it's better to re-deploy a VM in Azure and redeploy the application instead of replicating the on-premises server to Azure.

## Overview

In order for Contoso to migrate to Azure, it's critical to plan for the migration toolset and activities. Generally, Contoso needs to think about 3 areas:

> [!div class="checklist"]
>
> - **Step 1: Tooling & Replication.** How many replication appliances will you need? What are the best practices to enable replication?
> - **Step 2: Testing and Pre/Post Migration Activities.** What pre/post migration activities will resources need to execute? What is the value and when should I plan for a test migration? What are the constraints when testing in an isolated vnet?
> - **Step 3: Cutover and Post-Go-Live.** How does cutover look like? What happens after cutover?

## Before you start

Before we start diving deep in infrastructure migration planning and deployment, consider reading some background information relevant to Azure Migrate Server replication:

- Review Azure Migrate [Server Migration Tool Overview](https://docs.microsoft.com/en-us/azure/migrate/migrate-services-overview#azure-migrate-server-migration-tool).
- Review the differences between the [Azure Migrate appliance](https://docs.microsoft.com/en-us/azure/migrate/common-questions-appliance) and [Server Migration appliance](https://docs.microsoft.com/en-us/azure/migrate/common-questions-server-migration).
- Optionally, walkthrough MS Learn's [Migrate virtual machines and apps using Azure Migrate](https://docs.microsoft.com/en-us/learn/paths/m365-azure-migrate-virtual-machine/) Training.


## Step 1: Tooling & Replication

Contoso needs to figure out considerations on the number of appliances needed for replication and replication traffic impact.

### Capacity Planning for cores quotas

In order to pro-actively ensure that the target migration Azure subscriptions will be able to host the virtual machines created during test migration or production migration, subscriptions core quotas need to be available for the target VM SKUs. Ensure [subscription quotas](https://docs.microsoft.com/en-us/azure/azure-portal/supportability/per-vm-quota-requests) for specific VM families have been increased for the specific target region.

### Replication Appliances Planning and Implementation

After increasing the subscription VM cores quotas, Contoso needs to prepare to deploy the appliances and/or agents needed for replication of their on-premises server infraestructure. 

Using the below workflow, Contoso is able to define whether the Azure Migrate appliance, the Server Migration appliance, or just agents are needed to be deployed. This will aid Contoso in pro-actively defining needed additional infraestructure requests to successfully enable replication of their migratable state. 

![Concept Diagram](./media/contoso-migration-rehost-server-replication/replication-workflow.PNG)

*Figure 1: Replication Appliances and Agents Workflow.*

Further details can be found in the reference links below from the Azure Migrate documentation:

- [Reference Link A](https://docs.microsoft.com/en-us/azure/migrate/migrate-support-matrix-vmware-migration#vm-requirements-agentless).
- [Reference Link B](https://docs.microsoft.com/en-us/azure/migrate/tutorial-migrate-vmware-agent).
- [Reference Link C](https://docs.microsoft.com/en-us/azure/migrate/tutorial-migrate-vmware-powershell).
- [Reference Link D](https://docs.microsoft.com/en-us/azure/migrate/tutorial-migrate-hyper-v).
- Reference Links E:
    - [Physical/Other Hypervisors](https://docs.microsoft.com/en-us/azure/migrate/tutorial-migrate-physical-virtual-machines)
    - [AWS](https://docs.microsoft.com/en-us/azure/migrate/tutorial-migrate-aws-virtual-machines)
    - [GCP](https://docs.microsoft.com/en-us/azure/migrate/tutorial-migrate-gcp-virtual-machines)

As a best practice, Contoso works closely with their virtualization administrators to ensure careful monitoring of core performance counters for CPU, memory and disk space of the deployed appliances and hypervisor hosts. This will ensure hypervisor infraestructure has enough resources to handle additional load from replication appliances and agents.

### Replication

#### Replication Enablement and Monitoring

With replication appliances and agents configured, Contoso can look at replication of their migration groups/waves. 

As a best practice, Contoso will plan to enable initial replication for a subset of their migration groups/waves in order to be cautious of their available bandwidth. Contoso understand that initial replication of servers takes more bandwidth vs. delta replications. Given Contoso's bandwidth constraint considerations, Contoso will only enable replication for migration groups/waves which are close to 1-2 weeks from test migration and cutover dates. 

Further, Contoso will monitor initial and ongoing (delta) replication closely to ensure healthy and stable replication before enabling replication for additional servers. If errors or warnings should arise, Contoso can pro-actively detect these and act on it in advanced to test migration or cutover dates.

#### Replication Tuning

Based on the observed initial and ongoing replications bandwidth patterns Contoso will tune their replication strategy based on the below queries:

- How much bandwidth is needed and available for replications?
- How many VMs, on average, can be initially replicated at the same time?
- How many VMs, on average, can be left replicating (delta replication) at the same time?
- Is there an need to throttle replication within the replication appliances or agents?

## Step 2: Testing and Pre/Post Migration Activities

Given the success in replication toolset deployment and planning for a subset of their migration groups/waves, Contoso decides to start planning their testing needs and pre/post migration activities. 

Contoso understands that migration is both an orchestration of both business and technical groups. Therefore, the below activities are defined as pre and post migration activities.

#### Business

In order to prepare the business and its stakeholders for the migration activities, Contoso defines the below items:

- A maintenance window for each of the applications to migrate.
- Communications on application downtime and impact to business.
- Points of Contacts (POCs) which can provide support for the below key areas during migration testing and cutover:
    - Network Administrators
    - Backup Administrators
    - Server Administrators
    - Application Owners (Fronend and Backend)
    - Microsoft Support
    - Partner (if available)
- Soak Period after the cutover. During the Soak Period after application cutover to Azure, if any issues arise the rollback plan must be executed. After the Soak Period has expired, rollback of the application cannot be committed.

#### Technical: Pre-Migration 

In order to plan for best practice pre-migration activities, Contoso defines the below activities to be executed prior to a migration failover:

- A Rollback Plan.
- Latest backup of the servers.
- Opening of firewalls prefixes, ports and protocols for needed traffic from on-premises to Azure and from within Azure vnets and subnets.
- Attain local administrator accounts or keys for server login purposes.
- [Manual changes needed for Windows and Linux](https://docs.microsoft.com/en-us/azure/migrate/prepare-for-migration#verify-required-changes-before-migrating)
    - For more legacy Linux distributions, instructions to install Hyper-v drivers can be found within the [Hyper-v documentation](https://docs.microsoft.com/en-us/windows-server/virtualization/hyper-v/supported-linux-and-freebsd-virtual-machines-for-hyper-v-on-windows). 
    - For legacy Windows versions (E.G. WS2003 or WS2008), instructions to install Hyper-v drivers can be found in the [Azure Migrate documentation](https://docs.microsoft.com/en-us/azure/migrate/prepare-windows-server-2003-migration).

#### Technical: Post-Migration 
 Further, Contoso defines the below activities to be executed after the migration failover:

- Review Azure Migrate's documented post-migration activities:
    - [VMWare Agentless](https://docs.microsoft.com/en-us/azure/migrate/tutorial-migrate-vmware#complete-the-migration)
    - [VMWare Agent-based](https://docs.microsoft.com/en-us/azure/migrate/tutorial-migrate-vmware-agent#complete-the-migration)
    - [Hyper-v](https://docs.microsoft.com/en-us/azure/migrate/tutorial-migrate-hyper-v#complete-the-migration)
    - [Physical](https://docs.microsoft.com/en-us/azure/migrate/tutorial-migrate-physical-virtual-machines#complete-the-migration), [AWS](https://docs.microsoft.com/en-us/azure/migrate/tutorial-migrate-aws-virtual-machines#complete-the-migration), [GCP](https://docs.microsoft.com/en-us/azure/migrate/tutorial-migrate-gcp-virtual-machines#complete-the-migration)

- In addition, Contoso adds the below activities as best practice post-migration activities:
    
    - Validate login with local account/keys for RDP or SSH.
    - Validate DNS resolves and DNS servers are configured in network settings (E.G. TCP/IP settings) for the OS.
    - Validate IP address has been assigned to server in network settings (E.G. TCP/IP settings) for the OS.
    - Validate access to OS licensing is activated and there is access to cloud-based licensing endpoints (E.G. Azure KMS endpoints).
    - Validate login with domain accounts.
    - Validate application has access to dependencies (E.G. accessing target URLs or connection strings).
    - Validate Install or Update necessary Azure agents:
        - Windows and/or WALinux VM agent.
        - Windows and/or Linux Log Analytics agent/extension.
        - Windows and/or Linux Dependency Map agent/extension.
        - Windows SQL Extension.
    - Validate VM monitoring via new or existing service.
    - Validate VM patching via new or existing service.
    - Validate VM backup via new or existing service.
    - Validate VM Antivirus/endpoint protection via new or existing service.
    - Tag Azure resources.
    - Update any existing CMDB
    - Postmortem and Learnings.

#### Test Migration and Migration

Moving forward Contoso now looks to understand the need for a test migration, what test cases make sense, and which vnets to leverage as targets for the test migration and migration.

##### Define Smoke Test

As a first step, Contoso realizes there's a need to perform a smoke test to simply test that servers they've identified as legacy, highly customized or hardened operating systems will simply boot in Azure. Additionally, Contoso would like to also run a smoke test for servers which have been marked as "Conditionally Ready" by their Azure Migrate assessments. 

Contoso defines a smoke test to be successful when basic server functionality and properties are validated. For example, Smoke testing may include: 

- The server boots in Azure.
- The administrator is able to login to the server using local accounts. 
- TCP/IP settings for DNS, IPv4 and default gateways assignment are updated to the values provided by the Azure vnet. 
- OS licensing is activated.

Typically this test is led by the server administrators or the migration partner.

##### Define UAT Test

As second step, Contoso now looks to perform a UAT test to ensure that the servers applications are functional and accessible by expected users. 

Contoso defines a UAT test to be successful when application functionality and access to dependencies is validated. For example, UAT testing may include: 

- Validate login with domain accounts
- Validate application has access to dependencies (E.G. accessing target URLs or connection strings).

Typically, this is usually led by application owners.

#### Identify Testing and Migration Workflow

Now that test cases have been defined, Contoso developes the below workflow to encompass the various scenarios they may encounter based on each applications and servers needs. 

The majority of Contoso's scenarios require the second and fifth paths in the workflow below. Contoso has quite the amount of legacy servers and servers marked as "Ready with Conditions" which they are unsure will boot in Azure. Therefore, they will test each of those servers in an isolated vnet to ensure each pass the Smoke Test. For this, Contoso will perform a test migration in Azure Migrate which allows for the option to clean up created resources such as VMs and NICs.

Further, Contoso's environment is tightly coupled which means there's a large amount of servers which are interdependent with one another, thus resulting in large migration groups/waves. Contoso has decided to split their large migration groups/waves and migrate servers which are interdependent and have strict latency requirements. As a result, because not all dependencies as outlined in the migration group will be able to be migrated in a single migration wave, Contoso finds it's best that they migrate directly into the production vnet given that the production vnet already has connectivity back to their on-premises dependencies. In this path, Contoso will perform needed smoke test (if not done already) and UAT test. If all is successful, Contoso will conclude the migration as a final cutover for the servers. In this path, Contoso will not be using Azure Migrate's feature for a test Migration and rather will select the option to just migrate.

Nonetheless, Contoso does find value in considering the remainder paths only for scenarios where they find possible migrating all dependencies to an isolated vnet in order to perform UAT testing or where UAT testing is not enforced.

![Concept Diagram](./media/contoso-migration-rehost-server-replication/migration-workflow.PNG)

*Figure 2: Testing and Migration Workflow.*

## Step 3: Cutover and Post-Go-Live

As a final step, Contoso is now ready and confident to perform the production migrations. The envision that during Cutover all hands on deck will be required to ensure end-to-end support. Furthermore, after the soak period concludes, Contoso is looking forward to close-out and call for a successful migration to Azure. 

### Cutover

With the migration activities and workflow defined, Contoso irons out the final plans for cutover by:

- Identifying more specific cutover window, which they have planned for a Friday evening or weekend. Each cutover window will last at a minimum for 4 hours.
- Announce to the business and those impacted by the migration of the maintenance window.
- Reached out to the Network Admins, Backup Admins, Server Admins, App Owners,   Microsoft support and resources and partner to ensure they are available during cutover.
- Ensure a backup of the server has been committed prior to cutover.
- Ensure rollback plan is defined and ready for execution if needed
- Ensure migration handover to operations team by settings expectations that day 2 operations must commence with regards to Azure server backup, patching, monitoring, etc.

### Post-Go Live

Once the cutover successfully concludes, Contoso prepares for decommission of the source servers. Contoso decides that servers decommissioning will be executed after the soak period timeline is concluded.

## Conclusion

In this article, Contoso sets up Azure Migrate replication toolset and plans for their infrastructure migration activities and workflow.

Not every step taken here is required for a server migration. In this case, Contoso planned for a migration workflow, test plans and pre/post migration activities which will be able to handle server migrations by replication pro-actively and reliably.
