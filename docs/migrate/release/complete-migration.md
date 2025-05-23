---
title: Complete the migration to Azure
description: Use the Cloud Adoption Framework for Azure to understand the common tasks and standard prerequisites for promoting a migrated resource to production.
author: Zimmergren
ms.author: pnp
ms.date: 04/10/2024
ms.topic: conceptual
ms.collection: 
 - migration
---

# Complete the migration

Promotion or cutover to production marks the completion of a workload's migration to the cloud. After you promote the asset and all of its dependencies, production traffic is rerouted. After the traffic is rerouted, the on-premises assets become obsolete, so you can decommission them.

The promotion process varies according to the workload's architecture. However, you can expect several consistent prerequisites and a few common tasks. This article describes each prerequisite and task and serves as a migration checklist.

Make sure you add workload-specific considerations to your checklist.

## Migration window playbook

- **Send pre-promotion communications**. Although you already communicated about the change window, make sure to send a notification to all necessary parties so that they know the promotion has begun.
- **Validate the resources**. Confirm that all staged resources are in a functioning state. These resources include storage accounts and network security groups.
- **Pause monitoring**. While you migrate the workload, you'll likely create a temporary outage. Pause monitoring to prevent noise.
- **Take final replication steps**. Depending on your promotion method, you might need to take final replication steps to handle any recent data. That process includes these steps if you use a tool like Azure Migrate and Modernize to replicate the server state. Otherwise, you might have to take manual steps, depending on how you staged the application.
- **Hydrate additional resources**. If you're using server state replication like with Azure Migrate and Modernize, you need to deploy Azure Virtual Machine instances as part of hydrating after the replication. There might be other items like load balancing rules that you weren't able to stage previously.
- **Turn off source servers**. If you still have source servers available after hydrating your resources, turn them off so that they don't interfere with your migration. If you need to revert back, you can turn on these servers after cleaning up the migration items.
- **Do isolated testing**. Do any testing that you can without transitioning users over to the migrated workload. This testing uses a test plan that's similar to the plan described in [Test your migration deployment in Azure](../deploy/migration-test.md).
- **Transition to the migrated workload**. Update your Domain Name System, connection strings, load balancing, and other items so that when users or systems try to access the application, they access its new location.
- **Do promotion testing**. Run your business testing plan again to confirm that everything works as expected.
- **Seek final approval**. Seek a final go/no-go decision for the workload with stakeholders.
- **Resume monitoring**. Enable any disabled monitoring and confirm that the environment is in an acceptable state.
- **Communicate that the promotion was successful**. Tell all necessary parties that the promotion is finished and that there are no forthcoming changes.

## Next step

> [!div class="nextstepaction"]
> [Optimize cost after migration](./optimize-cost-after-migration.md)
