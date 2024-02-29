---
title: Deciding on migration tools
description: Use this decision tree as high-level guidance for selecting the best tools to use for your Azure migrations based on your migration decisions.
author: Zimmergren
ms.author: tozimmergren
ms.date: 02/29/2024
ms.topic: conceptual
ms.custom: UpdateFrequency2
---

# Deciding on migration tools

This article gives instructions for selecting the necessary migration tools to support your migration. It assumes you are performing a migration featured on rehosting. To learn more about modernization strategies, including replatforming, see [Cloud modernization strategies](/azure/cloud-adoption-framework/modernize/modernize-strategies/).

## Migration tools

Migration tools are used to copy or replicate server states or data from your existing environment to Azure. The exact tools vary on the migration scenario.

For example, if you are migrating to Azure Virtual Machines, you can use Azure Migrate to assess and migrate applications, infrastructure, and data to Azure. Azure Migrate provides a central hub to track discovery, assessment, and migration of on-premises resources and cloud resources.

However, if you are migrating to Azure VMware Services, you would use the built-in Vmotion features to migrate the VMs to their new host.

In addition to these replication tools, you will need to have tools to track migration waves, collect data, and organize communication. Azure DevOps or another user story system can be helpful to organize and visualize this work, and assign data, owners, and tasks.

However, other tools are available to assess workloads and migrate servers. This can depend on your specific needs. You should document any specific requirements that you have, and make sure that your selected to answers all of them.

### Selecting the right migration tool for your scenario

Evaluate existing tools and any specific needs you have to determine the best tool for your scenario. Consider the following:

- **Existing tools**
  - Do you already own a tool for replication that has been used as part of other projects in the past?
  - Does it make sense to reuse this tool?
- **Specific needs**
  - Do you have specific needs that make you incapable of using Azure Migrate, such as specific host environments?
  - Do these needs require you to add an additional tool, or are they items that can be solved by a process?

Proceed to evaluate additional tools. Many tools integrate with Azure Migrate to let you add features or perform more advanced assessments from the discovered data.

You can also use the [Migration Execution Guide](https://github.com/Azure/migration/) (MEG) to determine tooling for common scenarios.

> TBD: Diagram.

> TBD: A table of common migration tools and their features.

## Innovation and migration

In line with the Cloud Adoption Framework's emphasis on incremental migration with the migration disciplines, an initial decision on migration strategy and tooling doesn't rule out future innovation efforts to update an application to take advantage of opportunities presented by the Azure platform.

As you execute your workload assessments and execute migrations, you may revise your needs and identify additional scenarios to select your migration tools.

## Next steps

> [!div class="nextstepaction"]
> [Understanding multiple datacenters](./multiple-datacenters.md)
