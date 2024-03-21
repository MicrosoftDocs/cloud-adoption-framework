---
title: Complete migration to Azure
description: Use the Cloud Adoption Framework for Azure to understand the common tasks and standard prerequisites for promoting a migrated resource to production.
author: Zimmergren
ms.author: tozimmergren
ms.date: 03/21/2024
ms.topic: conceptual
---

# Complete migration

Promotion or cutover to production marks the completion of a workload's migration to the cloud. After the asset and all its dependencies are promoted, production traffic is rerouted. The rerouting of traffic makes the on-premises assets obsolete, allowing them to be decommissioned.

The process of promotion varies according to the workload's architecture. However, there are several consistent prerequisites and a few common tasks. This article describes each and serves as a migration checklist.

You should make sure to add workload specific considerations to your specific checklist.

## Migration window playbook

- **Send pre-promotion communications**. While you have already communicated about the change window, make sure to send out a notification to necessary parties that they're aware that the promotion has begun.
- **Validate resources**. Validate all staged resources are in a functioning state. This includes items like storage accounts, network security groups, and others.
- **Pause monitoring**. While you migrate, you'll likely create a temporary outage. Monitoring should be paused to avoid creating monitoring noise.
- **Final replication**. Depending on your promotion method, you might have final replication steps that need to handle any recent data. If you're using a tool like Azure Migrate to replicate server state, this is included in that process. Otherwise, you might have to do manual steps based on how you staged the application.
- **Hydrate additional resources**. If you're using server state replication like with Azure Migrate, Azure VMs will need to be deployed as part of hydrating after the replication. There might be other items, like load balancing rules or other items you weren't able to stage previously.
- **Power down source servers**. If you still have source servers available after hydrating your resources, power them down so that they aren't interfering with your migration.
- **Isolated testing**. Perform any testing that you're able to without transitioning users over to the migrated workload. This will mostly be IT testing.
- **Transition to the migrated workload**. Update your DNS, connection strings, load balancing, and other items so that when users or systems try to access the application, they do so to the new location.
- **Promotion testing**. Execute your business testing plan again to validate that everything is operating as expected.
- **Final approval**. Perform a final Go/No Go decision for the workload with stakeholders.
- **Resume monitoring**. Enable any disabled monitoring and validate that the environment is within an acceptable state.
- **Communicate successful promotion**. Communicate that the promotion is completed and there are no additional changes forthcoming.

## Next steps

> [!div class="nextstepaction"]
> [Optimize cost after migration](./optimize-cost-after-migration.md)
