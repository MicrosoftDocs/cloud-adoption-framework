---
title: The role of replication in the migration process
description: Learn about the role of replication in the migration process and how to plan for the prerequisites and risks of replication activities.
author: martinekuan
ms.author: martinek
ms.date: 04/04/2019
ms.topic: conceptual
ms.custom: internal
---

# The role of replication in the migration process

On-premises datacenters store physical assets, like servers, appliances, and network devices. But each server is only a physical shell. The real value comes from the binary that runs on the server. The applications and data are the reason why the datacenter exists. They're the primary binaries to migrate. Digital assets and binary sources, like operating systems, network routes, files, and security protocols, power the applications and data stores.

Replication is the workhorse of migration efforts. It copies a point-in-time version of various binaries. The binary snapshots are then copied to a new platform and deployed onto new hardware in a process called *seeding*. When this process is executed properly, the seeded copy of the binary behaves identically to the original binary on the old hardware. But the snapshot of the binary is out of date and misaligned with the original source. To keep the new binary and the old binary aligned, a process called *synchronization* continuously updates the copy that's stored in the new platform. Synchronization continues until the asset is promoted in alignment with the chosen promotion model. At that point, the synchronization stops.

## Prerequisites for replication

Prior to replication, the new platform and hardware is prepared to receive the binary copies. Learn about the [minimum environment requirements](../prerequisites/index.md) to create a safe, robust, high-performance platform to receive the binary replicas.

The *source binaries* are prepared for replication and synchronization. The articles on [assessment](../assess/index.md), [architecture](../assess/architect.md), and [remediation](./remediate.md) address the actions necessary to ensure that the source binary is ready for replication and synchronization.

A *toolchain* that aligns with the new platform and source binaries are implemented to execute and manage the replication and synchronization processes. Learn about [various tools that could contribute to a migration to Azure](./replicate-options.md).

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
- **Time to business change.** As mentioned previously, synchronization time has a cumulative negative effect on migration speed. Prioritization of the migration backlog and advanced preparation for the [business change plan](../optimize/business-change-plan.md) are crucial to the speed of migration. The most significant test of business and technical alignment during a migration effort is the pace of promotion. The faster an asset is promoted to production, the less effect disk drift has on bandwidth and the more bandwidth and time is allocated to the replication of the next workload.

## Next steps

[Understand staging activities during a migration](./stage.md)

