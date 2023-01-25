---
title: How to select automation for relocating cloud workloads
description: Learn how to select the best methods and automated tools for relocating cloud workloads and applications.
author: SomilGanguly
ms.author: ssumner
ms.date: 2/3/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: adopt
ms.custom: internal, seo-caf-relocate
keywords: cloud adoption, cloud framework, cloud adoption framework
---
# Select automation for relocating cloud workloads

For each workload, you need to select the best relocation strategy. The Select step provides guidance to help you make those decisions. The selections you make depend on the services and the criticality of the workload.

:::image type="content" source="../_images/relocate/caf-relocate-select.png" alt-text="Image showing the relocation process and highlights the Select step in the Move phase. In the relocation process, there are two phases and five steps. The first phase is the initiate phase, and it has one step called initiate. The second phase is the Move phase. It has four steps that you repeat for each workload. The steps are Evaluate, Select, Migrate, and Cutover." lightbox="../_images/relocate/caf-relocate-select.png" border="false":::
*Figure 1. The Select step of relocation.*

## Select a relocation method

You need to pick a relocation method for each workload. The relocation method depends on the services in the workload and how critical the workload is. Cold relocation is for stateless services and for non-essential workloads. Hot and warm relocation is for mission-critical stateful services. We recommend using a hot relocation strategy if the service supports it. To execute each relocation method, you select and apply service and data relocation tools, which we discuss later. Here we survey the three relocation methods.

:::image type="content" source="../_images/relocate/relocation-methods-decision-tree.png" alt-text="Image showing a decision tree for selecting the right relocation method. There are three decision points. 1. Is downtime okay? If yes, then cold relocation is the right relocation method. 2. Is it a stateless service? If yes, then cold relocation is again the right relocation method. 3. Does the service support synchronous data replication? If yes, then hot relocation is the right relocation method. If no, then warm relocation is the right relocation method." lightbox="../_images/relocate/relocation-methods-decision-tree.png" border="false":::

*Figure 2. Relocation method decision tree.*

### Cold relocation (stateless and stateful services)

Cold relocation is for stateless services or workloads that can withstand downtime. It’s the most cost-effective approach to relocation because you don’t duplicate any environments during relocation. Here’s an overview of the cold relocation process.

1. Back up workload data to the new target region.
1. Take the source region offline and shutdown services.
1. Deploy the cloud services to the new target region.
1. Restore workload data.

Cold relocation can take a few minutes or a few days depending on the number of services and volume of data.

### Hot relocation (stateful services)

The hot relocation method is for workloads that need minimal to zero downtime. For critical workloads with stateful service, you should see if the service supports hot relocation before trying a warm approach. Hot relocation helps minimize the data delta after cutover.  Hot relocation is only possible if the service supports synchronous data replication. Some services don’t have this feature, and you’ll need to use a warm relocation approach instead. Here’s the hot relocation process.

1. Start the service in the new target region.
1. Keep the workload running in the source region.
1. Start synchronous data replication.
1. After the data synchronizes, activate the endpoints, and validate.
1. Stop the data synchronization.
1. Shut down the service in source region.

### Warm relocation (stateful services)

Warm relocation is for critical workloads with a stateful service that doesn’t support hot relocation. Warm relocation uses asynchronous data replication and environment replication. Here’s the warm-relocation process.

1. Start the service in the new target region.
1. Keep the workload is running in the source region.
1. Create a backup of the source data. We recommend you back up the data off peak hours to minimize potential data loss.
1. Restore the data in the new target region.
1. Switch endpoints and validate.
1. Shut down the workload in the source region.

## Select service-relocation automation

There are three primary service-relocation tools. The following paragraphs give an overview of each tool choice with links to more guidance. Azure Resource Mover and Azure Site Recovery can move stateless and stateful services. If you use infrastructure as code to move the workload, you’ll need to find a separate data relocation tool. You should review the capabilities of each service-relocation tool and select the service-relocation tool that best meets your needs.

**Azure Resource Mover.** Azure Resource Mover is a built-in Azure service that allows you to move Azure resources between regions, subscriptions, and resource groups. We recommend using Azure Resource Mover as a first option for all cold relocations. It supports a limited number of stateful and stateless services. For more information, see:

- [Azure Resource Mover overview](/azure/resource-mover/overview)
- [Supported resources](/azure/resource-mover/overview#what-resources-can-i-move-across-regions).

**Azure Site Recovery.** Azure Site Recovery can replicate any application running on a supported virtual machine in Azure. It’s a disaster recovery tool by design, but it can relocate stateful and stateless workloads. It uses a Recovery Services Vault like Azure Backup and can move services quickly. It requires a few cleanup steps after relocation sine it’s a disaster recovery tool. For more information, see:

- [Azure Site Recovery overview](/azure/site-recovery/site-recovery-overview)
- [Applications Azure Site Recovery can move](/azure/site-recovery/site-recovery-workload#workload-summary)
- [Replicate DNS and Active Directory](/azure/site-recovery/site-recovery-workload#replicate-active-directory-and-dns)

**Infrastructure as code (IaC) custom automation.** Infrastructure as code allows you to copy and redeploy Azure services. You can download the JSON view for the services in the source region and deploy  services in the new target region with your preferred infrastructure-as-code tool. For stateful services, you’ll need another tool to relocate workload data. For more information, see [infrastructure as code overview](/azure/cloud-adoption-framework/ready/considerations/infrastructure-as-code).

## Select data-relocation automation

If you used infrastructure as code to relocate your stateful service, you’ll need to pick a data-relocation tool to move the data.

**Geo-replication.** Active geo-replication is a business continuity solution. You can perform quick disaster recovery of individual databases if a regional disaster or large-scale outage occurs. Once geo-replication is set up, you can initiate a geo-failover to a geo-secondary in a different Azure region. For more information, see [geo-replication](/azure/azure-sql/database/active-geo-replication-overview).

**Synchronous data replication.** Synchronous data replication replicates data in near real-time across regions. It’s the preferred data relocation approach for hot relocation because it limits downtime and data delta migrations after cutover. However, it’s not an Azure tool. This capability is built into some Azure services such as Azure SQL and Azure Cosmos DB. You need to check each service in your workload to see if it’s available. For more information, see:

- [Azure SQL](/azure/azure-sql/database/sql-data-sync-data-sql-server-sql-database)
- [Azure Cosmos DB](/azure/cosmos-db/nosql/how-to-multi-master)

**Azure Site Recovery.** Azure Site Recovery can relocate services and data. It supports cold and warm relocation strategies. For more information, see [overview Azure Site Recovery](/azure/site-recovery/site-recovery-overview).

**AzCopy.** AzCopy is a command-line utility that automates data movements in and out of Azure Storage. You need to download the tool and then use Azure Active Directory or shared access signature (SAS) tokens to authorize the move. For more information, see:

- [AzCopy overview](/azure/storage/common/storage-ref-azcopy)
- [Use AzCopy](/azure/storage/common/storage-use-azcopy-v10)

**Azure Data Factory.** Azure Data Factory is a fully managed cloud-based data integration service that orchestrates and automates the movement and transformation of data. Azure Data Factory can move data lakes and warehouses. For more information, see:

- [Supported targets and sources](/azure/data-factory/copy-activity-overview#supported-data-stores-and-formats)
- [Copy data tool](/azure/data-factory/copy-data-tool)

**Azure Storage Explorer.** Azure Storage Explorer is a standalone app that allows you to relocate Azure Storage data. For more information, see [how to use Storage Explorer](/azure/vs-azure-tools-storage-manage-with-storage-explorer).

**Azure Backup.** With Azure Backup, you can back up and restore data in another region. We recommend trying Azure Backup first for non-essential cold and warm relocations. Azure Backup provides application-consistent, file-system consistent, and crash-consistent backups for virtual machines. It also supports managed disks, files shares, and blobs. For more information, see [Azure Backup overview](/azure/backup/backup-overview).

**Manual backup and restore.** Backup and restore here refers to a process, not a specific tool. Many services in Azure provide redundancy options that let you back up data to a separate region and restore them manually. You need to perform a manual backup and restore for specific services like Azure Key Vault. For more information, see [move Key Vault to another region](/azure/key-vault/general/move-region).

*Table 1. Data migration tools and the relocation method(s) they support.*

|Tools | Relocation method|
| --- | --- |
[Geo-replication](/azure/azure-sql/database/active-geo-replication-overview) |Hot|
|[Synchronous data replication](/azure/azure-sql/database/sql-data-sync-data-sql-server-sql-database)|Hot, Warm|
|[Azure Site Recovery](/azure/site-recovery/site-recovery-overview)|Warm, Cold|
|[AzCopy](/azure/storage/common/storage-use-azcopy-v10)|Warm, Cold|
|[Azure Data Factory](/azure/data-factory/quickstart-get-started)| Warm, Cold |
|[Azure Storage Explorer](/azure/vs-azure-tools-storage-manage-with-storage-explorer)| Warm, Cold|
|[Azure Backup](/azure/backup/backup-overview)| Cold|
|[Manual backup and restore](/azure/key-vault/general/move-region)| Cold|

## Select cutover approach

Cutover is when you transition from the old workload to the new one. You direct traffic to the workload in the target region and no longer to the source region. DNS is central to this redirection. As a reminder, DNS tells browsers where to get a response. It resolves domain names to IP addresses. Every domain needs a domain host to manage it. We recommend Azure DNS. There are different approaches to workload cutover, and the approach you take depends on the services in your workload. Choose the approach that best meets the needs of your workload.

**Azure DNS:** For domains hosted in Azure DNS, you can perform a manual cutover by switching the CNAME. This approach is a business continuity failover process that works for cutover. For more information, see [manual cutover using Azure DNS](/azure/networking/disaster-recovery-dns-traffic-manager?toc=%2Fazure%2Fdns%2Ftoc.json#manual-failover-using-azure-dns).

**Traffic Manager:** It’s also possible to use a routing service like Traffic Manager for cutover and route workload traffic to different endpoints. Traffic Manager is a DNS-based routing service. For more information, see [configure DNS names with Traffic Manager](/azure/app-service/configure-domain-traffic-manager).

**App Service:** Application-layer services, such as Azure App Service, have features that allow you to update the domain name. For more information, see [migrate an active DNS name to Azure App Service](/azure/app-service/app-service-web-tutorial-custom-domain?tabs=a%2Cazurecli).

## Next step

You've selected a relocation method and the tools to relocate your workload. Move on to the Migrate step to execute the relocation using these tools.

> [!div class="nextstepaction"]
> [Migrate](migrate.md)
