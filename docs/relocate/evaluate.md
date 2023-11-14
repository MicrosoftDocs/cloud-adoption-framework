---
title: How to evaluate a cloud workload for relocation.
description: How to evaluate a workload for relocation so you can select the best relocation strategy.
author: SomilGanguly
ms.author: ssumner
ms.date: 08/29/2023
ms.reviewer: ssumner
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: adopt
ms.custom: internal, seo-caf-relocate
keywords: cloud adoption, cloud framework, cloud adoption framework
---
# Evaluate a cloud workload for relocation

Evaluate is the first step in the Move phase of relocation. The goal of the Evaluate step is to understand the workload you want to relocate so you can move it successfully. Every workload you relocate must go through the four steps of the Move phase, starting with the Evaluate step.

:::image type="content" source="../_images/relocate/caf-relocate-evaluate.png" alt-text="Diagram showing the relocation process and highlights the Evaluate step in the Move phase. In the relocation process, there are two phases and five steps. The first phase is the Initiate phase, and it has one step called Initiate. The second phase is the Move phase, and it has four steps that you repeat for each workload. The steps are Evaluate, Select, Migrate, and Cutover." lightbox="../_images/relocate/caf-relocate-evaluate.png" border="false":::

## Pick workload(s)

You should have a prioritized list of workloads, and the list should identify the order you want to relocate your workloads. Each time you visit the evaluate step, pick the workload(s) at the top of the list. For smaller teams, you should relocate one workload at a time. It's a chance to learn and improve with each workload relocation. Larger teams should consider relocating multiple workloads. Bulk relocations can help achieve economies of scale.

## Conduct discovery

Workload discovery is the foundation of relocation. The primary goal is to identify all dependencies and endpoints. Dependencies are resources or services that the workload needs to run. Dependencies include Azure services, third-party apps, licenses, partner teams. 

- *Be comprehensive.* You need to consider networking, firewalls, cost, testing, tagging, identities, product features, zonal support, and policies. 
*Include all endpoints.* You should also identify all the endpoints or IP addresses associated with the workload including those that are configured with private endpoints. It's worth noting that public IP addresses are region specific. You can't move them between regions. You need to export the configuration of a public IP and deploy it to the new target region. For more information, see [Move Azure Public IP configuration to another Azure region](/azure/virtual-network/move-across-regions-publicip-powershell).
- *Reconfigure global services.* Global Azure resources don't deploy to a specific region, so you don't need to recreate them. You just might need to reconfigure them. For example, you might need to update IP addresses in Azure Front Door profile to point to the new IP address of a relocated workload.

Where possible, use automated tools to collect information about applications and Azure services that make up your workload. You can use these tools to perform low-level discovery and architecture design discovery for the relocation of a specific workload. You should use the following Azure tools and services.

Beyond technical discovery, the discovery phase should also include other non-technical aspects of the workload. It is important to determine the following:

- Identify the workload owner(s).
- Identify the stakeholders who should be involved in migration decisions or notified about migration activities.
- Determine the potential business risks involved in migrating the workload.
- Determine if the workload is subject to a change management processes.
- Identify allowable outage windows during which a migration can be performed.
- Identify internal users or external customers could be impacted by any outage the relocation may cause and put a communicate plan inplace to notifiy them.

**Try Azure Resource Mover first.** You should try to use Azure Resource Mover first. It's the easiest discovery tool to use, and you can also relocate services and data. Azure Resource Mover only supports a limited number of services, so make sure your services are supported before continuing. For more information, see [Supported resources for Azure Resource Mover](/azure/resource-mover/overview#what-resources-can-i-move-across-regions).

**Use visualization tools.** If Azure Resource Mover doesn't meet all your needs, you can use visualization tools to aid your discovery. Azure has several visualization tools that you can use to map dependencies. Pick the tool that best supports your needs.

- *Resource group visualizer:* You can you visualize the connections between the resources in a resource group. In the Azure portal, navigate to the resource group and select *Resource visualizer* from the left navigation.

- *Azure Monitor topology:* You can view network dependencies with the topology feature in Azure Monitor. For more information, see [Network insights topology](/azure/network-watcher/network-insights-topology).

- *Application Insights:* Application Insights has an application mapping feature where you can view the logical structure of a distributed application. For more information, see [Application map in Azure Application Insights](/azure/azure-monitor/app/app-map?tabs=net).

- *Azure Resource Explorer:* Azure Resource Explorer lists every resource in your Azure Active Directory (Azure AD) tenant. It gives you visibility but doesn't indicate dependencies. You must map workload components and dependencies manually. For more information, see [Azure Resource Explorer](https://resources.azure.com/).

- *Azure Resource Graph:* Azure Resource Graph allows you to run queries against the resources in an Azure AD tenant. Resource Graph is accessible in the portal and from the command line. You must map workload components and dependencies manually. For more information, see [Azure Resource Graph documentation](/azure/governance/resource-graph/shared-query-azure-cli).

- *Inventory dashboard:* Within the Azure portal you can use the built-in inventory template to create a dashboard to track your existing resources. It's a quick way of determining the resources you have and the number of instances.

**Manually create documentation if needed.** If automated discovery approaches aren't enough, you can conduct a manual assessment of the workloads. Most manual assessments rely on interviews with technical experts and technical documentation to get the information needed. Identify product or application owners and interview them. These interviews are optional, but necessary when the team needs to cover gaps in the information the tools provide. And the app owner can pull the tags and manually identify dependencies.

## Find region supportability

Not every region in Azure offers the same services, so you must make sure the services your workload needs to run are available in the target region. It might seem late in the process to make this determination, but you need the discovery details to ensure supportability. To determine region supportability for your workload, see the [products and services available in each Azure region](https://azure.microsoft.com/explore/global-infrastructure/products-by-region).

Know if the target region is a paired region or not and if it supports availability zones. Region pairing and availability zones don't affect the relocation effort, but they do affect your business continuity and disaster recovery (BCDR) strategy in the target region. For more information, see [Azure geographies](https://azure.microsoft.com/explore/global-infrastructure/geographies/#geographies) and [Availability zones](/azure/reliability/availability-zones-service-support#azure-regions-with-availability-zone-support).

## Categorize workload services

Relocation happens at the service and component level. Most workloads use multiple services. There are two primary types of services, stateful and stateless. You need to categorize each service as stateful or stateless. This knowledge helps you determine dependencies, understand service integrations, and narrows your relocation automation options.

**Stateless services:** Stateless services have configuration information only. These services don't need continuous replication of data to move. Examples include virtual networks, network adapters, load balancers, and network security groups.

**Stateful services:** Stateful services have configuration information and data that need to move. Examples include virtual machines and SQL databases.

## Evaluate relocation updates

In any migration project, there’s a risk of something breaking during the relocation process. Outages can happen by accident, or due to the way that the service being relocated is designed. Wherever possible, it’s best to identify these issues during the discovery stage so that you can put a plan in place to mitigate the risk of an outage or misconfiguration. Here are some points to consider:

- *Update automation.* Your organization might have implemented automation techniques, such as scripts and infrastructure as code. You must update any references to Azure regions, service names, or service URLs within the scripts or code. The references need to correspond to the new Azure region you're moving to.

You should avoid hardcoding any values in your code that are subject to change during the workload lifecycle. Instead, retrieve these values dynamically or use configurable parameters within the code. This approach will make any necessary changes less burdensome and ensure a smoother relocation process."

- *Update DNS records.* Azure assigns public IP addresses to endpoints depending on the region. When you move an endpoint to a different Azure region, it will have a different IP address. Make sure to update your DNS records with these new IP addresses. Also, you need to provide the new IP address to any system that has the former IP address on its 'allowed' list.

- *Update load balancers.* Update load balancers to point to any new backend IP addresses or hosts. For DNS-based load balancers, the change might take some time to propagate based on DNS caches and time-to-live (TTL) record expiry. For more information, see [Azure load balancing services](/azure/architecture/guide/technology-choices/load-balancing-overview#https-vs-non-https). Consider temporarily decreasing the Time to Live (TTL) settings for your DNS records. It helps the DNS records switch to new IP address faster. Also, consider setting your load balancer to check the health of your backend systems more frequently for a short period. Remember to change these settings back to normal after the migration to avoid extra costs and reduced performance later on.

- *Resolve naming conflicts.* Check if you need to deploy new resources in the new Azure region before you turned off the old ones. If so, you could run into issues where two resources can't have the same DNS name at once. Think about using unique names for each service to avoid this problem. In some cases, you might be able to use CNAME records to provide a layer of abstraction. It makes resource name changes easier to manage.


- *Update private endpoints.* If you connect to your resources through a private endpoint, these endpoints link to private DNS zones that resolve the resource's network address within your virtual network. In a relocation, you need to update the DNS records within the private DNS zones to maintain connectivity.

- *Update Azure Backup registration.* When you move virtual machines to a new Azure region, make sure to unregister them from the Azure Backup service in the current region and register them with the Azure Backup service in the new region. Be aware that you won't be able to access the existing backup recovery points because they cannot be transferred to the new backup vault. You need to start creating new recovery points in the new region.

- *Create a new Log Analytics workspace.* You should have a separate Log Analytics workspace for each region. Create a new workspace in the target region. Since can't move a Log Analytics Workspace to another region, you need to create a new Log Analytics workspace in the target region.  There are two options to preserve the data in the original workspace. You can keep the keep the current workspace until you don't need the data, treating the data as read-only. You can also export the workspace data to a storage account in the new target Azure region.

## Next steps

Evaluating your workload provides enough information to select a relocation method and the tools to execute the method you choose. The Select step walks you through the decisions to pick a relocation method and the correct tools for the relocation method.

> [!div class="nextstepaction"]
> [Select](select.md)
