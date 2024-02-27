---
title: Migration tools decision guide
description: Use this decision tree as high-level guidance for selecting the best tools to use for your Azure migrations based on your migration decisions.
author: Zimmergren
ms.author: tozimmergren
ms.date: 02/27/2024
ms.topic: conceptual
ms.custom: UpdateFrequency2
---

# Migration tools decision guide

This article gives instructions for selecting the necessary migration tools to support your migration. It assumes you're performing a migration featured on rehosting. See [Cloud modernization strategies](/azure/cloud-adoption-framework/modernize/modernize-strategies/) for information about planning Modernization programs focused on replatforming applications.

## Migration tools

Migration tools are used to copy or replicate server states or data from your existing environment to Azure. The exact tools vary on the migration scenario.

For example, if you're migrating to Azure Virtual Machines, you can use Azure Migrate. Azure Migrate is a free service to assess and migrate applications, infrastructure, and data to Azure. Azure Migrate provides a central hub to track discovery, assessment, and migration of on-premises resources and cloud resources.

However, if you're migrating to Azure VMware Services, you would use the built-in Vmotion features to migrate the VMs to their new host.

In addition to these replication tools, you'll need to have tools to track migration waves, collect data, and organize communication. Azure DevOps or another user story system can be helpful to organize and visualize this work, and assign data, owners, and tasks.

## Selecting the right migration tool for your scenario

To ensure you're selecting the right migration tools, you should consider the following steps:

### Evaluate and assess Azure Migrate

The primary tool for migrating to Azure is [Azure Migrate](/azure/migrate/migrate-services-overview). It's a free service that provides a central hub to track discovery, assessment, and migration of on-premises resources and cloud resources. Azure Migrate provides a unified experience to track and manage your migration journey.

Build a deeper understanding of Azure Migrate with the [Migrate virtual machines and apps using Azure Migrate](/training/paths/m365-azure-migrate-virtual-machine/) Learning Path.

### Evaluate additional considerations

- **Existing tools**
  - Do you already own a tool for replication that has been used as part of other projects in the past?
  - Does it make sense to reuse this tool?
- **Specific needs**
  - Do you have specific needs that make you incapable of using Azure Migrate, such as specific host environments?
  - Do these needs require you to add an additional tool, or are they items that can be solved by a process?

Proceed to evaluate additional tools. Many tools integrate with Azure Migrate to let you add features or perform more advanced assessments from the discovered data.

You can also use the [Migration Execution Guide](https://github.com/Azure/migration/) (MEG) to determine tooling for common scenarios.

> TBD: Diagram.

## Innovation and migration

In line with the Cloud Adoption Framework's emphasis on incremental migration with the migration disciplines, an initial decision on migration strategy and tooling doesn't rule out future innovation efforts to update an application to take advantage of opportunities presented by the Azure platform.

As you execute your workload assessments and execute migrations, you may revise your needs and identify additional scenarios to select your migration tools.

## Learn more

- [How to decide which Azure Migrate appliance is right for your environment?](https://techcommunity.microsoft.com/t5/fasttrack-for-azure/how-to-decide-which-azure-migrate-appliance-is-right-for-your/bc-p/4061639)

## Next steps

> [!div class="nextstepaction"]
> [Understanding multiple datacenters](./multiple-datacenters.md)
