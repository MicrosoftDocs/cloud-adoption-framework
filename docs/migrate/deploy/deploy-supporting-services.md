---
title: Deploy supporting services
description: Learn how to deploy the supporting services required for your workloads when migrating to Azure with the Cloud Adoption Framework.
author: Zimmergren
ms.author: tozimmergren
ms.date: 03/01/2024
ms.topic: conceptual
---

# Deploy supporting services

Every workload you migrate to the cloud has some several supporting services required to support it.

Replicated or staged servers need to be placed into virtual networks, and many workloads require load balancers and application delivery solution. In addition, there are considerations for how to prepare to manage (link to new article) workloads.

When you designed your [workload architecture](../assess/architect.md), you identified these services. Now, before you begin to migrate resources, you should deploy these services to make sure you have everything ready for your workload to operate successfully.

This article assumes that you have already prepared your shared platform solutions via [readying your landing zones for migrations](../prerequisites/ready-alz.md) and have completed your workload architecture.

## Planning for supporting service deployment

It can be unclear when to deploy your supporting services. While some services, like Azure Virtual Networks, are based on consumption, others like Application Gateways are based on runtime – even if you weren’t actively using them, if they're powered on they have a cost.

As a result, you should plan for the following:

- Deploy out core, no-cost or consumption based services like virtual networks, network security groups, and storage accounts as early in the process as possible.
- Deploy out services that can be paused or put in to standby mode early, and pause them until ready.
- Deploy services that begin billing immediately for testing purposes, and then deprovision them when not needed. Use Infrastructure as Code to consistently deploy these resources.

## Required services

While your workload architecture gives you a definitive list of services, you can use the following as a guide to help make sure your supporting services are identified:

- **Resource organization**:
  - A subscription to hold your workload.
  - A number of resource groups to organize your resources.
- **Networking**:
  - A Virtual Network with subnets matching your network design.
  - Network security groups assign to the subnets, restricted to required traffic only.
  - A peering connection to your hub virtual network.
  - Any necessary user defined routes to shape traffic, such as to send your default route traffic to a firewall appliance.
  - Any application presentation resources for web applications, such as Application Gateway or Azure FontDoor.
  - Load balancers for workloads that have multiple nodes.
- **Identity and security**:
  - Any Key Vaults to hold certificates or secrets.
- **Management**:
  - Any workload specific log analytics workspaces.
  - Any workload specific Azure Site Recovery and Azure Backup instances.
  - Any workload specific Azure update management instances.
  - Any workload specific alerts.

In addition, you should review [prepare for management](./prepare-for-management.md) for any management specific considerations.

## Next steps

> [!div class="nextstepaction"]
> [Remediate assets](./remediate.md)
