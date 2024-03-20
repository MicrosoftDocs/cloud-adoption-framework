---
title: Replicate assets in a cloud migration
description: Learn about the role of replication in the migration process and how to plan for the prerequisites and risks of replication activities.
author: Zimmergren
ms.author: tozimmergren
ms.date: 03/05/2024
ms.topic: conceptual
---

# Replicate assets in a cloud migration

On-premises datacenters store physical assets, like servers, appliances, and network devices. But each server is only a physical shell. The real value comes from the binary that runs on the server. The applications and data are the reason why the datacenter exists. They're the primary binaries to migrate. Digital assets and binary sources, like operating systems, network routes, files, and security protocols, power the applications and data stores.

- **Replication:** Copies a point-in-time version of various binaries.
  - The binary snapshots are then copied to a new platform and deployed onto new hardware in a process called seeding.
- **Seeding:** The seeded copy of the binary behaves identically to the original binary on the old hardware. But, the snapshot of the binary is out of date and misaligned with the original source. To keep the new binary and the old binary aligned, a process called synchronization takes place.
- **Synchronization:** Continuously updates the copy that's stored in the new platform. Synchronization continues until the asset is promoted in alignment with the chosen promotion model. At that point, the synchronization stops.

## Prerequisites for replication

Prior to replication, you should have completed the activities in the [prepare](../prepare/index.md) and [assessment](../assess/index.md) phase. To begin replicating, you need to have:

- A subscription created for your migrated resources.
- A selected migration tool that enables you to move the binary copies over.
- The _source binaries_ prepared for replication and synchronization. The exact configuration needed varies on your migration tool.
  - This includes remediating any of the issues with replication found in your assessment phase.
  - For example, review the guide for [Migrate from VMware via agentless migration](/azure/migrate/tutorial-migrate-vmware) to see one example of how replication can be initiated.
- Any dependencies for your workload that you identified during the [design workload architectures before migration](../assess/architect.md) step, such as the resource groups, virtual networks, and subnets you intend to deploy the replicated virtual machines inside of. For more information, see [deploy supporting services](../deploy/deploy-supporting-services.md).

## Replication risks: Physics of replication

When you plan and execute the replication of a binary source to a new destination, there are fundamental laws to consider.

- **Speed of light.** When you move high volumes of data, fiber is the fastest option. But fiber cables can only move data at two-thirds the speed of light. There's no method for instantaneous or unlimited replication of data.
- **Speed of WAN pipeline.** More important than the speed of data movement is the uplink bandwidth. The uplink bandwidth defines the volume of data per second that can be carried over a company's existing WAN to the target datacenter.
- **Speed of WAN expansion.** If budget allows, more bandwidth can be added to a company's WAN solution. But it can take weeks or months to procure, prepare, and integrate more fiber connections.
- **Speed of disks.** If data could move faster and there was no limit to the bandwidth between the source binary and the target destination, physics would still be a limiter. Data can be replicated only as quickly as it can be read from source disks. Reading every one or zero from every spinning disk in a datacenter takes time.
- **Speed of human calculations.** Disks and light move faster than human decision processes. When a group of humans collaborate and make decisions together, the results come slowly. Replication can't overcome delays related to human intelligence.

Each of these laws of physics drives the following risks that commonly affect migration plans.

- **Replication time.** Replication requires time and bandwidth. Plans should include realistic timelines that reflect the amount of time it takes to replicate binaries. *Total available migration bandwidth* is the amount of up-bound bandwidth that other higher priority business needs don't consume. The up-bound bandwidth is measured in megabits per second (Mbps) or gigabits per second (Gbps). *Total migration storage* is the total disk space, measured in gigabytes or terabytes, required to store a snapshot of assets to be migrated. An initial estimate of time is calculated by dividing the *total migration storage* by the *total available migration bandwidth*. Note the conversion from bits to bytes. See the next item for a more accurate calculation of time.
- **Cumulative effect of disk drift.** From the point of replication to the promotion of an asset to production, the source and destination binaries must remain synchronized. *Drift* in binaries consumes extra bandwidth because changes to the binary must be replicated on a recurring basis. During synchronization, all binary drift is included in the calculation for total migration storage. The longer it takes to promote an asset to production, the more cumulative drift occurs. The more assets that are synchronized, the more bandwidth is consumed. With each asset that's held in a synchronization state, more of the total available migration bandwidth is lost.
- **Time to business change.** Synchronization time has a cumulative negative effect on migration speed. Prioritization of the migration backlog and advanced preparation for the [change communication](../release/change-communication.md) plan are crucial to the speed of migration. The most significant test of business and technical alignment during a migration effort is the pace of promotion. The faster an asset is promoted to production; the less effect disk drift has on bandwidth and the more bandwidth and time is allocated to the replication of the next workload.

## Plan for when data requirements exceed network capacity

In a cloud migration, you replicate and synchronize assets over the network between the existing datacenter and the cloud. It's not uncommon for the existing data size requirements of various workloads to exceed network capacity. In such a scenario, the process of migration can be radically slowed, or in some cases, stopped entirely.

If your assessment, initial replication, or testing has identified it as an issue, consider using [Azure Data Box](/azure/databox/data-box-overview) to transfer independent data stores. This allows you to ship large volumes of data to the cloud, prior to the workload migration.

There are also third-party partner solutions that use Azure Data Box for a migration. With these solutions, you move a large volume of data via an offline transfer, but you synchronize it later at a lower scale over the network.

## Next steps

> [!div class="nextstepaction"]
> [Prepare for management](./prepare-for-management.md)
