---
title: Replicate assets in a cloud migration
description: Learn about the role of replication in the migration process and how to plan for the prerequisites and risks of replication activities.
author: Zimmergren
ms.author: pnp
ms.date: 04/05/2024
ms.topic: conceptual
ms.collection: 
 - migration
---

# Replicate assets in a cloud migration

On-premises datacenters store physical assets, like servers, appliances, and network devices. But each physical asset, like a server, is only a shell. The real value comes from the binary that runs on the server. The datacenter exists because of the applications and data, which are the primary binaries that you migrate. Digital assets and binary sources, like operating systems, network routes, files, and security protocols, power the applications and data stores.

The replication process consists of the following steps:

1. **Replication**: Copies a point-in-time version of various binaries.

1. **Seeding**:  Copies the binary snapshots to a new platform and deploys them onto new hardware. The seeded copy of the binary behaves exactly like the original binary on the old hardware. But the snapshot of the binary is out of date and misaligned with the original source.
1. **Synchronization**: Aligns the new binary and the old binary. This process continuously updates the copy that's stored on the new platform. Synchronization continues until the asset is promoted in alignment with the chosen promotion model. At that point, the synchronization stops.

## Prerequisites for replication

Before replication, you should complete the activities in the [prepare](../prepare/index.md) and [assessment](../assess/index.md) phases. To begin replicating, you need to have:

- A subscription for your migrated resources.

- A migration tool to move the binary copies over.
- The source binaries, prepared for replication and synchronization. Their exact configuration depends on your migration tool. Preparation includes remediating any replication problems that you found in the assessment phase. For an example of how to initiate replication, see [Migrate from VMware via agentless migration](/azure/migrate/tutorial-migrate-vmware).
- Any dependencies for your workload that you identified during the [workload architecture design](../assess/architect.md) step. These dependencies can include resource groups, virtual networks, and subnets in which you intend to deploy the replicated virtual machines. For more information, see [Deploy supporting services](../deploy/deploy-supporting-services.md).

## Replication risks: Physics of replication

When you plan and perform binary source replication to a new destination, consider the following fundamental laws:

- **Speed of light**: When you move high volumes of data, fiber is the fastest option. But fiber cables can only move data at two-thirds the speed of light. There's no method for instantaneous or unlimited replication of data.

- **Speed of the WAN pipeline**: The uplink bandwidth is even more important than the speed of data movement. The volume of data per second that your company's existing WAN transfers to the target datacenter determines the uplink bandwidth.

- **Speed of WAN expansion**: If budget allows, you can add more bandwidth to your company's WAN solution. But it can take weeks or months to procure, prepare, and integrate more fiber connections.

- **Speed of disks**: Even with infinite data speed and an infinite bandwidth limit between the source binary and the target destination, physics still limits replication. Data replication occurs only as quickly as source disks can read the data.

- **Speed of human calculations**: Disks and light move faster than human decision processes. When a group of people collaborate and make decisions together, the results come slowly. Replication can't overcome delays related to human calculations.

Each of these laws of physics drives the following risks that commonly affect migration plans:

- **Replication time**: Replication requires time and bandwidth. Plans should include realistic timelines that reflect the amount of time it takes to replicate binaries.

  *Total available migration bandwidth* is the amount of up-bound bandwidth that other higher priority business needs don't consume. The up-bound bandwidth is measured in megabits per second (Mbps) or gigabits per second (Gbps). *Total migration storage* is the total disk space, measured in gigabytes (GBs) or terabytes (TBs), required to store a snapshot of assets to be migrated.

  To determine an initial time estimate, divide the *total migration storage* by the *total available migration bandwidth*. Note the conversion from bits to bytes. The next item describes a more accurate calculation of time.

- **Cumulative effect of disk drift**: From the point of replication to the promotion of an asset to production, the source and destination binaries must remain synchronized.

  *Drift* in binaries consumes extra bandwidth because you must replicate changes to the binary on a recurring basis. During synchronization, the calculation for total migration storage includes all binary drift. The longer it takes to promote an asset to production, the more cumulative drift occurs. The more synchronized assets that you have, the more bandwidth you consume. For each asset in a synchronization state, you have less total available migration bandwidth available.

- **Time-to-business change**: Synchronization time has a cumulative negative effect on migration speed. Prioritization of the migration backlog and advanced preparation for the [change communication](../release/change-communication.md) plan are crucial to the speed of migration.

  The most significant test of business and technical alignment during a migration effort is the pace of promotion. The faster an asset is promoted to production, the less disk drift affects bandwidth. And you can allocate more bandwidth and time to the next workload's replication.

## Plan for when data requirements exceed network capacity

In a cloud migration, you replicate and synchronize assets over a network between an existing datacenter and the cloud. The existing data size requirements of various workloads might exceed network capacity. In such a scenario, the migration process might be radically slowed, or in some cases, stopped entirely.

If your assessment, initial replication, or testing identifies a capacity problem, consider using [Azure Data Box](/azure/databox/data-box-overview) to transfer independent data stores. Use this approach to ship large volumes of data to the cloud before the workload migration.

Some non-Microsoft partner solutions also use Data Box for migrations. With these solutions, you can move a large volume of data via an offline transfer, but you synchronize it later at a lower scale over the network.

## Next step

> [!div class="nextstepaction"]
> [Prepare for management](./prepare-for-management.md)
