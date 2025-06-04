---
title: Deploy supporting services for migration projects
description: Learn how to deploy the supporting services required for your workloads when migrating to Azure with the Cloud Adoption Framework.
author: Zimmergren
ms.author: pnp
ms.date: 04/05/2024
ms.topic: conceptual
ms.collection: 
 - migration
---

# Deploy supporting services

Every workload you migrate to the cloud requires several supporting services.

You must place replicated or staged servers into virtual networks, and many workloads require load balancers and an application delivery solution. Also, there are considerations for how to [prepare to manage](./prepare-for-management.md) workloads.

When you designed your [workload architecture](../assess/architect.md), you identified these services. Before you begin to migrate resources, *deploy* the services to ensure that you have everything ready for your workload to operate successfully.

This article assumes that you prepared your shared platform solutions by [readying your landing zones for migrations](../../ready/landing-zone/ready-azure-landing-zone.md) and completed your workload architecture.

## Plan for supporting service deployment

It's sometimes unclear when to deploy the supporting services. Some services, like Azure Virtual Network, are based on consumption. Other services, like Azure Application Gateway, are based on runtime, even if you aren't actively using them. If they're powered on, they incur cost.

So, you should plan for the following situations:

- **Services to deploy early in the process**
  - Core, no-cost, and consumption-based services, like virtual networks, network security groups, and storage accounts.
  - Services that can be paused or put in standby mode. Pause them until ready.
- **Deprovision after use**
  - Services that begin billing immediately for testing purposes. Deprovision them when not needed. Use infrastructure as code (IaC) to consistently deploy these resources.

## Required services

While your workload architecture provides a definitive list of services, you can use the following options as a guide to help identify your supporting services:

- **Resource organization**:
  - A subscription to hold your workload
  - Various resource groups to organize your resources
- **Networking**:
  - A virtual network with subnets that match your network design
  - Network security groups assigned to the subnets and restricted to required traffic only
  - A peering connection to your hub virtual network
  - Any necessary user-defined routes to shape traffic, such as to send your default route traffic to a firewall appliance
  - Any application presentation resources for web applications, such as Application Gateway or Azure Front Door
  - Load balancers for workloads that have multiple nodes
- **Identity and security**:
  - Any key vaults to hold certificates or secrets
- **Management**:
  - Any workload-specific  Azure Monitor Logs workspaces
  - Any workload-specific Azure Site Recovery and Azure Backup instances
  - Any workload-specific Azure Update Manager instances
  - Any workload-specific alerts

Also, review [Prepare for management](./prepare-for-management.md) to understand the management-specific considerations.

## Next steps

> [!div class="nextstepaction"]
> [Remediate assets](./remediate.md)
