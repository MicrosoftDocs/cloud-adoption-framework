---
title: Decommission retired assets
description: Use the Cloud Adoption Framework for Azure to learn how to properly decommission retired resources with minimal business interruptions.
author: Zimmergren
ms.author: tozimmergren
ms.date: 02/13/2024
ms.topic: conceptual
---

# Decommission retired assets

After a workload is promoted to production, the assets that previously hosted the production workload are no longer required to support business operations. At that point, the older assets are considered retired. Until an asset is decommissioned, it continues to consume power, environmental support, and other resources that drive costs. Retired assets can then be decommissioned, reducing operational costs.

Decommissioning a resource can be as simple as turning off the power to the asset and disposing of the asset responsibly. Unfortunately, decommissioning resources can sometimes have undesired consequences. The following guidance can aid in properly decommissioning retired resources, with minimal business interruptions.

## Testing windows and dependency validation

Even with the best planning, production workloads might still contain dependencies on assets that are presumed retired. In such cases, turning off a retired asset could cause unexpected system failures. As such, the termination of any assets should be treated with the same level of rigor as a system maintenance activity. Proper testing and outage windows should be established to facilitate the termination of the resource.

## Continued monitoring

After a migrated workload is promoted, the assets to be retired should continue to be monitored to validate that no more production traffic is being routed to the wrong assets.

## Holding period and data validation

It's not uncommon for migrations to miss data during replication processes. This is especially true for older data that isn't used regularly. After a retired asset has been turned off, it's still wise to maintain the asset for a while to serve as a temporary backup of the data. Companies should allow at least 30 days for holding and testing before destroying retired assets.

## Next steps

After retired assets are decommissioned, the migration is completed. This creates a good opportunity to improve the migration process, and a [retrospective](./retrospective.md) engages the cloud adoption team in a review of the release in an effort to learn and improve.

> [!div class="nextstepaction"]
> [Retrospective](./retrospective.md)
