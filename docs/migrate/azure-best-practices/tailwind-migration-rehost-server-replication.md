---
title: Migration execution with Azure Migrate for servers
description: Learn how Tailwind Traders migrates its servers to Azure by using the Migration and modernization tool in Azure Migrate.
author: alejandra8481
ms.author: martinek
ms.date: 04/09/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
ms.custom: azure-fast-track, think-tank
---

# Migration execution with Azure Migrate for servers

This article shows how the fictional company Tailwind Traders prepares its deployment plan for the migration of on-premises infrastructure to Azure. [Migration and modernization](/azure/migrate/migrate-services-overview?branch=main#migration-and-modernization-tool), a tool that's integrated into Azure Migrate, provides the server replication features described in this scenario.

When you use this example to help plan the migration of your own infrastructure, remember that the sample plan and deployment that are described in this article are specific to Tailwind Traders. Be sure to review your organization's business needs, structure, and technical requirements when making important decisions about migrating your own infrastructure.

Whether you need all the elements that are described in this article depends on your migration strategy and needs. For example, you might prefer to redeploy a VM in Azure and redeploy the application instead of replicating the on-premises server to Azure.

## Overview

For Tailwind Traders to migrate to Azure, it's critical to plan for the migration toolset and activities. Generally, Tailwind Traders needs to think about the following areas:

> [!div class="checklist"]
>
> - **Step 1: Tooling and replication.** How many replication appliances are required? What are best practices to enable replication?
>
> - **Step 2: Migration cutover preparation.** What activities must resources execute before and after the migration? What value do they provide, and when should a test migration occur? What constraints apply when testing in an isolated virtual network?
>
> - **Step 3: Migration cutover execution.** What does cutting over look like? What happens afterward?

## Before you start

Before diving deeply into planning your migration of infrastructure and its deployment, consider reading background information that's relevant to server replication with Azure Migrate:

- Review [Migration and modernization tool](/azure/migrate/migrate-services-overview#migration-and-modernization-tool).
- Review the differences between the following tools:
  - [Azure Migrate appliance](/azure/migrate/common-questions-appliance)
  - [Replication appliance](/azure/migrate/migrate-replication-appliance)
  - [Hyper-V migration architecture](/azure/migrate/hyper-v-migration-architecture)
- Complete [Migrate virtual machines and applications using Azure Migrate](/training/paths/m365-azure-migrate-virtual-machine/), a learning path.

## Step 1: Tooling and replication

Tailwind Traders must decide on the number of appliances that are required for replication and the effects of replication traffic.

### Capacity planning for virtual CPU quotas

To ensure that the Azure subscriptions for the target migration are able to host the virtual machines that Azure Migrate creates during the migration (both test and production), the virtual CPU (vCPU) quotas of the subscriptions must be high enough for the target VM SKUs. Ensure that vCPU quotas for specific VM SKUs are increased for the specific target region. For more information, see [Increase VM-family vCPU quotas](/azure/azure-portal/supportability/per-vm-quota-requests).

### Server migration tooling planning and implementation

After increasing the vCPU quotas of the subscriptions, Tailwind Traders must prepare to deploy the appliances or agents that are required for replication of their on-premises server infrastructure.

By using the following workflow, Tailwind Traders can identify the tools that are required for server migration to enable replication of on-premises servers. This workflow aids Tailwind Traders in actively identifying the infrastructure requests that are necessary to successfully enable replication of their migratable estate.

:::image type="content" alt-text="Diagram of the replication workflow." source="./media/tailwind-migration-rehost-server-replication/replication-workflow.png" lightbox="./media/tailwind-migration-rehost-server-replication/replication-workflow.png":::

*Figure 1: Replication appliances and agents workflow.*

For more information, see these Azure Migrate articles:

- [Support matrix for VMware migration](/azure/migrate/migrate-support-matrix-vmware-migration#vm-requirements-agentless).
- [Migrate VMware VMs to Azure (agent-based)](/azure/migrate/tutorial-migrate-vmware-agent).
- [Migrate VMware VMs to Azure (agentless) - PowerShell](/azure/migrate/tutorial-migrate-vmware-powershell).
- [Migrate Hyper-V VMs to Azure](/azure/migrate/tutorial-migrate-hyper-v).
- Other hypervisors:
  - [Migrate machines as physical servers to Azure](/azure/migrate/tutorial-migrate-physical-virtual-machines)
  - [Discover, assess, and migrate Amazon Web Services (AWS) VMs to Azure](/azure/migrate/tutorial-migrate-aws-virtual-machines)
  - [Discover, assess, and migrate Google Cloud Platform (GCP) VMs to Azure](/azure/migrate/tutorial-migrate-gcp-virtual-machines)

As a best practice, Tailwind Traders works closely with their virtualization administrators to ensure careful monitoring of key performance counters for CPU, memory, and storage space of the deployed appliances and hypervisor hosts. This monitoring helps to ensure that the virtualization infrastructure has enough resources to handle additional load from replication appliances and agents.

### Replication

Tailwind Traders plans their migration strategy, monitors the progress, and tunes their configuration based on results.

#### Enable and monitor replication

With replication appliances and agents configured, Tailwind Traders can start planning the replication of their on-premises servers. A collection of applications and their dependencies that must be migrated simultaneously is commonly referred to as a *migration wave* or *migration group*. Tailwind Traders will use the term *migration wave* to maintain consistency across planning activities.

As a best practice, Tailwind Traders plans to enable initial replication for only a subset of their migration waves due to caution about their available bandwidth. The initial replication is a full copy of the servers and consumes more bandwidth as compared to ongoing (delta) replications. Given their bandwidth constraint, Tailwind Traders enables replication for only the migration waves that are nearing test migration and cutover dates.

Tailwind Traders also monitors initial and ongoing replication closely to ensure healthy and stable replication before enabling replication for more servers. If errors or warnings arise, Tailwind Traders can actively detect and respond before test migration or cutover dates.

#### Replication tuning

Based on the observed initial and ongoing replications bandwidth patterns, Tailwind Traders tunes their replication strategy based on the following questions:

- How much bandwidth is needed and available for replications?
- How many VMs, on average, can be initially replicated at the same time?
- How many VMs, on average, can be left replicating (delta replication) at the same time?
- Is there a need to throttle replication within the replication appliances or agents?

## Step 2: Migration cutover preparation

Given the success in deploying the replication toolset and planning for a subset of their migration waves, Tailwind Traders decides to start planning their testing needs and pre-migration and post-migration activities.

Migrations are an orchestration of both business and technical groups. Therefore, Tailwind Traders defines the following activities as *pre-migration* and *post-migration* activities.

### Business: Pre-migration

In order to prepare the business and its stakeholders for the migration activities, Tailwind Traders defines the following items:

- A maintenance window for each of the migrated applications.
- Communications on application downtime and effects on business.
- Points of contact (POCs) who can provide support for key areas during migration testing and cutover:
  - Network administrators
  - Backup administrators
  - Server administrators
  - Identity administrators
  - Application owners (front-end and back-end applications)
  - Microsoft Support
  - Partners (if available)
- A soak test after the cutover of the application to Azure. During the soak period, if any issues arise, then Tailwind Traders must execute the rollback plan. After the soak period has expired, the application can't be rolled back.

### Technical: Pre-migration

As best practices, Tailwind Traders identifies the following activities for execution prior to a migration failover:

- Design a rollback plan.

- Create a current backup of the servers.

- Open the firewall prefixes, ports, and protocols that are necessary for traffic between on-premises resources to Azure and within Azure virtual networks and subnets.

- Obtain local administrator credentials or keys for signing in to servers.

- Review the changes for Windows and Linux that are described in [Verify required changes before migrating](/azure/migrate/prepare-for-migration#verify-required-changes-before-migrating) that must be manually configured:
  - For legacy Linux distributions, install Hyper-V drivers as described in [Supported Linux and FreeBSD virtual machines for Hyper-V on Windows Server and Windows](/windows-server/virtualization/hyper-v/supported-linux-and-freebsd-virtual-machines-for-hyper-v-on-windows).
  - For legacy Windows versions such as Windows Server 2003 or Windows Server 2008, install Hyper-V drivers as described in [Prepare Windows Server 2003 machines for migration](/azure/migrate/prepare-windows-server-2003-migration).

- Prepare isolated virtual networks for test migrations.
  - Plan for secure access via RDP or SSH for system management by using a service like [Azure Bastion](/azure/bastion/bastion-overview).
  - Plan for an isolated virtual network in each subscription that contains the migrated VMs. The test migration functionality in Azure Migrate must use a virtual network in the same subscription where the migrated VM will reside.

### Technical: Post-migration

After the migration failover, Tailwind Traders reviews the completion procedures for the source environments in their migration. There are completion procedures available for the following environments:

- [VMware agentless VMs](/azure/migrate/tutorial-migrate-vmware#complete-the-migration)
- [VMware agent-based VMs](/azure/migrate/tutorial-migrate-vmware-agent#complete-the-migration)
- [Hyper-V VMs](/azure/migrate/tutorial-migrate-hyper-v#complete-the-migration)
- [Physical servers](/azure/migrate/tutorial-migrate-physical-virtual-machines#complete-the-migration)
- [AWS VMs](/azure/migrate/tutorial-migrate-aws-virtual-machines#complete-the-migration)
- [GCP VMs](/azure/migrate/tutorial-migrate-gcp-virtual-machines#complete-the-migration)

In addition, Tailwind Traders adds the following post-migration activities as best practices:

- Validate sign-in with local credentials or keys for RDP or SSH.

- Verify that DNS servers are configured in TCP/IP settings for the OS and that name resolution works correctly.

- Verify that the TCP/IP settings for the OS enable the server to receive an IP address via DHCP.

- Verify that access to OS licensing is activated and that there's access to cloud-based licensing endpoints (such as Azure endpoints for key management services).

- Validate sign-in with domain credentials.

- Verify that the application has access to dependencies (such as target URLs or connection strings).

- Verify installation or update required Azure agents:
  - Azure VM agents for Windows or Linux.
  - Log Analytics agent for Windows or Linux.
  - Service Map agent for Windows or Linux.
  - SQL Server IaaS Agent extension.

- Validate VM monitoring via a new or existing service.

- Validate VM patching via a new or existing service.

- Validate VM backup via a new or existing service.

- Validate VM antivirus and endpoint protection via a new or existing service.

- Tag Azure resources.

- Update any existing configuration management database (CMDB).

- Conduct a post-mortem and document lessons learned.

#### Test migration and actual migration

Tailwind Traders seeks to understand the need for a test migration, what test cases make sense for their situation, and which virtual networks to use as targets for the test migration and actual migration.

##### Define a smoke test

As a first step, Tailwind Traders performs a smoke test to validate that the servers that are identified for migration boot correctly in Azure. An isolated virtual network should be the context for the smoke test of all the servers that are migrated. Tailwind Traders follows this recommendation and is especially focused on the smoke test for servers that are legacy, highly customized, or contain hardened operating systems. Additionally, Tailwind Traders runs a smoke test for servers that have been marked as *Conditionally Ready* by their Azure Migrate assessments.

Tailwind Traders defines a smoke test to be successful when basic server functionality and properties are validated. For example, smoke testing might include:

- Testing whether the server boots in Azure.
- Testing whether the administrator can sign in to the server by using local credentials.
- Updating the TCP/IP settings for DNS, IPv4, and default gateways to the values that are provided by the Azure virtual network via DHCP.
- Activating OS licensing.

Typically, a server administrator or migration partner leads a smoke test.

##### Define user acceptance testing

As a second step, Tailwind Traders performs user acceptance testing (UAT) to ensure that the applications are functional and accessible by the expected users. UAT helps to find missed configuration changes that are necessary for a successful migration, which might include hard-coded IP addresses.

Tailwind Traders defines UAT to be successful when application functionality and access to dependencies are validated. For example, UAT might include:

- Validate sign-in by using domain credentials.
- Verify that the application has access to dependencies (such as target URLs and connection strings).
- Validate application functionality with test users.

Typically, application owners lead UAT.

#### Identify testing and migration workflow

After defining test cases, Tailwind Traders develops the following workflow to encompass the various scenarios it might encounter based on the needs of each application or server.

Tailwind Traders has many legacy servers and other servers marked as *Ready with Conditions*, which might not boot in Azure. Therefore, Tailwind Traders tests those servers in an isolated virtual network to ensure that each server passes a smoke test. For the smoke test, Tailwind Traders performs a test migration in Azure Migrate, which allows for automated clean-up of created resources, such as VMs and network interfaces.

Further, Tailwind Traders's environment is tightly coupled—it has a large number of servers that are interdependent with one another, which results in large migration waves. Tailwind Traders decides to split their large migration waves and to migrate servers together that have the most strict latency requirements. As a result, some application dependencies must remain on-premises for a given migration wave. Tailwind Traders determines that it should migrate directly into the production virtual network, since that network already has connectivity to their on-premises dependencies. Tailwind Traders performs the necessary smoke tests in an isolated virtual network and performs UAT in the production virtual network. If successful, Tailwind Traders concludes the migration as a final cutover for the servers.

:::image type="content" alt-text="Diagram of the migration workflow." source="./media/tailwind-migration-rehost-server-replication/tailwind-migration-rehost-server-replication-workflow.svg" lightbox="./media/tailwind-migration-rehost-server-replication/tailwind-migration-rehost-server-replication-workflow.svg":::

*Figure 2: Testing and migration workflow.*

## Step 3: Final step

As a final step, Tailwind Traders performs the production migrations. Tailwind Traders expects that all hands are required during cutover to ensure end-to-end support. Furthermore, after the soak test concludes, Tailwind Traders looks forward to close-out and for a successful migration to Azure.

### Cutover

With the migration activities and workflow defined, Tailwind Traders irons out the final plans for cutover by completing the following tasks:

- Identify a more specific cutover window, which is planned for a Friday evening or weekend. Each cutover window will last for a minimum for 4 hours.

- Notify the business and those users who are affected by the migration of the maintenance window. The maintenance window includes a meeting invitation that includes the migration plan and a conference bridge to discuss any open items during the migration.

- Contact the following parties to ensure that each is available during cutover:
  - Network administrators
  - Backup administrators
  - Server administrators
  - Identity administrators
  - Application owners
  - Microsoft support resources
  - Partners

- Ensure that a backup of the server has been committed prior to cutover.

- Ensure that the rollback plan is defined and ready for execution if needed.

- Ensure the operations team is ready for migration handover by setting their expectation that backup, patching, monitoring, and so on, of Azure servers must commence on Day 2.

### Post-go-live

After the cutover successfully concludes, Tailwind Traders prepares to decommission the source servers. Tailwind Traders decides to decommission servers after the soak test concludes.

After each migration wave, Tailwind Traders also conducts a brief retrospective to discuss what went well and what can be improved for future migration waves. Tailwind Traders understands these incremental lessons and improvements ensure smoother migrations for all subsequent migration waves.

## Conclusion

In this article, Tailwind Traders set up the Migration and modernization tool, part of Azure Migrate. Tailwind Traders also planned a migration workflow, test plans, and pre-migration and post-migration activities, which can be accomplished by proactive and reliable replication. However, not every server migration requires all of the steps described in this article.

## Next steps

If you're still exploring migration to Azure, read about other migration scenarios.

> [!div class="nextstepaction"]
> [Migration scenarios](../../scenarios/index.md#migration-scenarios)
