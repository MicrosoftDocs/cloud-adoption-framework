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

Given the success in replication planning for a subset of their migration groups/waves, Contoso decides to 


## Step 3: Cutover and Post-Go-Live



## Conclusion

In this article, Contoso set up an Azure infrastructure and policy for Azure subscription, hybrid identify, disaster recovery, network, governance, and security.

Not every step taken here is required for a cloud migration. In this case, Contoso planned a network infrastructure that can handle all types of migrations while being secure, resilient, and scalable.

## Next steps

After setting up its Azure infrastructure, Contoso is ready to begin migrating workloads to the cloud. See the [migration patterns and examples overview](./contoso-migration-overview.md#windows-server-workloads) for a selection of scenarios that use this sample infrastructure as a migration target.
