---
title: How to evaluate a cloud workload for relocation.
description: How to evaluate a workload for relocation so you can select the best relocation strategy.
author: SomilGanguly
ms.author: ssumner
ms.date: 08/21/2023
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

You should have a prioritized list of workloads, and the list should identify the order you want to relocate your workloads. Workload owners should be involved in the selection process. They can help with identifying risks, outage windows and communications with workload users and other stakeholders. Each time you visit the evaluate step, pick the workload(s) at the top of the list. For smaller teams, you should relocate one workload at a time. It's a chance to learn and improve with each workload relocation. Larger teams should consider relocating multiple workloads. Bulk relocations can help achieve economies of scale. At first, consider picking workloads that are low risk, low in complexity, and have a development or test environment that you can migrate first.

> [!TIP]
> For high risk workloads, consider developing a rollback plan, and test the full migration and rollback processes against non-production environments.

## Conduct discovery

Workload discovery is the foundation of relocation. The primary goal is to identify all dependencies and endpoints. Dependencies are resources or services that the workload needs to run. Dependencies include Azure services, third-party apps, licenses, partner teams. You need to consider networking, firewalls, cost, testing, tagging, identities, product features, zonal support, and policies. You should also identify all the endpoints or IP addresses associated with the workload including those that are configured with private endpoints. It's worth noting that public IP addresses are region specific. You can't move them between regions. You need to export the configuration of a public IP and deploy it to the new target region. For more information, see [Move Azure Public IP configuration to another Azure region](/azure/virtual-network/move-across-regions-publicip-powershell).

Where possible, use automated tools to collect information about applications and Azure services that make up your workload. You can use these tools to perform low-level discovery and architecture design discovery for the relocation of a specific workload. You should use the following Azure tools and services.

Beyond technical discovery, the discovery phase should also include other non-technical aspects of the workload. Consider the following questions:

- Who owns the workload?
- Who are the stakeholders who should be involved in migration decisions or notified about migration activities?
- What are the potential business risks involved in migrating the workload?
- Are there change management processes required for this workload? If so, what are the timelines for reviewing the migration process?
- Are there allowable outage windows during which a migration can be performed?

> [!NOTE]
> It’s important to understand if internal users or external customers could be impacted by any outage the relocation may cause, and how you plan to communicate with these stakeholders.

**Try Azure Resource Mover first.** You should try to use Azure Resource Mover first. It's the easiest discovery tool to use, and you can also relocate services and data. Azure Resource Mover only supports a limited number of services, so make sure your services are supported before continuing. For more information, see [Supported resources for Azure Resource Mover](/azure/resource-mover/overview#what-resources-can-i-move-across-regions).

**Use visualization tools.** If Azure Resource Mover doesn't meet all your needs, you can use visualization tools to aid your discovery. Azure has several visualization tools that you can use to map dependencies. Pick the tool that best supports your needs.

- *Resource group visualizer:* You can you visualize the connections between the resources in a resource group. In the Azure portal, navigate to the resource group and select *Resource visualizer* from the left navigation.

- *Azure Monitor topology:* You can view network dependencies with the topology feature in Azure Monitor. For more information, see [Network insights topology](/azure/network-watcher/network-insights-topology).

- *Application Insights:* Application Insights has an application mapping feature where you can view the logical structure of a distributed application. For more information, see [Application map in Azure Application Insights](/azure/azure-monitor/app/app-map?tabs=net).

- *Azure Resource Explorer:* Azure Resource Explorer lists every resource in your Azure Active Directory (Azure AD) tenant. It gives you visibility but doesn't indicate dependencies. You must map workload components and dependencies manually. For more information, see [Azure Resource Explorer](https://resources.azure.com/).

- *Azure Resource Graph:* Azure Resource Graph allows you to run queries against the resources in an Azure AD tenant. Resource Graph is accessible in the portal and from the command line. You must map workload components and dependencies manually. For more information, see [Azure Resource Graph documentation](/azure/governance/resource-graph/shared-query-azure-cli).

- *Inventory dashboard:* Within the Azure portal you can use the built-in inventory template to create a dashboard to track your existing resources as a quick way of determining which resources you have and how many instances there are.

**Manually create documentation if needed.** If automated discovery approaches aren't enough, you can conduct a manual assessment of the workloads. Most manual assessments rely on interviews with technical experts and technical documentation to get the information needed. Identify product or application owners and interview them. These interviews are optional, but necessary when the team needs to cover gaps in the information the tools provide.

> [!TIP]
> Resource tags can be another way of discovering information about workloads, such as their owners and which environment the resource corresponds to.

## Identify global and regional resources

Some Azure resources are deployed globally, which means they aren't deployed to a specific region. These resources don't need to be recreated, but they might need to be reconfigured. For example, an Azure Front Door profile is a global resource, so it doesn't need to be moved between the source and target regions. However, it might refer to the IP address of a resource that will be moved, and so its configuration might need to be updated when you move your other resources.

## Find region supportability

Not every region in Azure offers the same services, so you must make sure the services your workload needs to run are available in the target region. It might seem late in the process to make this determination, but you need the discovery details to ensure supportability. To determine region supportability for your workload, see the [products and services available in each Azure region](https://azure.microsoft.com/explore/global-infrastructure/products-by-region).

Know if the target region is a paired region or not and if it supports availability zones. Region pairing and availability zones don't affect the relocation effort, but they do affect your business continuity and disaster recovery (BCDR) strategy in the target region. For more information, see [Azure geographies](https://azure.microsoft.com/explore/global-infrastructure/geographies/#geographies) and [Availability zones](/azure/reliability/availability-zones-service-support#azure-regions-with-availability-zone-support).

## Categorize workload services

Relocation happens at the service and component level. Most workloads use multiple services. There are two primary types of services, stateful and stateless. You need to categorize each service as stateful or stateless. This knowledge helps you determine dependencies, understand service integrations, and narrows your relocation automation options.

**Stateless services:** Stateless services have configuration information only. These services don't need continuous replication of data to move. Examples include virtual networks, network adapters, load balancers, and network security groups.

**Stateful services:** Stateful services have configuration information and data that need to move. Examples include virtual machines and SQL databases.

## Evaluate potential side effects of the relocation

In any migration project, there’s a risk of something breaking during the relocation process. Outages can happen by accident, or due to the way that the service being relocated is designed. Wherever possible, it’s best to identify these issues during the discovery stage so that you can put a plan in place to mitigate the risk of an outage or misconfiguration. Here are some points to consider:

- **Automation, scripts and infrastructure as code:** Your organization might have invested in automation techniques, which can be helpful with the relocation process. However, be sure to identify and change any references to Azure regions, service names, or service URLs to reflect the destination Azure region. Ideally, values that can change during the lifecycle of an application should be looked up dynamically, or configured as parameters within the code, to make the changes less onerous.

- **Public IP addresses:** Azure allocates public IP addresses from a range unique to each Azure region. This means that when a new public IP address is provisioned in the new target Azure region, the public IP addresses used by your resources will have changed from what it is currently. As you go live with the services in the new Azure region, plan how you update your external DNS records to reflect the new IP addresses in use. If external parties have allowlisted your organization’s public IP addresses, then they need to be supplied with the new IP addressed of the relocated services.

- **Load balancing services:** Most workloads use a load balancing service. Load balancers include DNS-based load balancers like Azure Traffic Manager, reverse proxies like Azure API Management, Azure Front Door, or Azure Application Gateway, and layer 3/layer 4 load balancers like Azure Load Balancer. Consider whether you need to update your load balancer's configuration to point to a new backend IP address or host. If you do, there might be some downtime while failover occurs. The load balancer might need to detect that traffic can no longer flow to the source region, then update its configuration to send traffic to the target region. For DNS-based load balancers, the change might take some time to propagate based on DNS caches and time-to-live (TTL) record expiry.

   Consider whether you can reduce the downtime by temporarily reducing DNS records' TTL settings and by temporarily reconfiguring the load balancer to poll backend health more aggressively. However, ensure that you revert these changes after the migration is completed so that you don't incur performance and cost penalties in the future.

- **Resource DNS names and URLs:** Many Azure resources can be configured with globally unique DNS names. For example, Azure Storage uses DNS names similar to `<unique_name>.blob.core.windows.net`, and Azure App Service uses DNS names similar to `<unique_name>.azurewebsites.net`. Similarly, if you have any public IP address resources that you attach to virtual machines or networking resources, they might be configured to use a DNS name similar to `<unique-name>.<region-name>.cloudapp.azure.com`.

  Evaluate whether your migration plan requires you to provision new instances of services within the new target Azure region while the current service is still provisioned in the old Azure region. If you do, there might be a naming conflict: two resources can’t share the same DNS name at the same time. Consider whether you can use different names for each resource.

  In some situations, your DNS records might be able to provide a layer of abstraction by using CNAME records, which makes a service name change easier to manage.

- **Private endpoints:** Many Azure services enable you to access your resources by using a private endpoint in your own virtual network. Often, this approach uses the resource’s URL, such as in your private DNS zones. The preceding consideration described how a resource’s URL can change during the migration process, so ensure that you plan how you configure your private endpoints and DNS zones.

- **Azure Backup recovery points:** When virtual machines are relocated to the new target Azure region, they first need to be de-registered with the current Azure Backup service and then re-registered with a new instance of Azure Backup located in the new region. This process causes existing recovery points for that virtual machine to be unavailable, because recovery points can’t be relocated to a different vault.

- **Log Analytics workspaces:** It’s best to deploy a separate Log Analytics workspace for each region, which means you should deploy a new workspace in your target region. It’s not possible to move a Log Analytics Workspace to another region, which means the data from your original workspace won’t be available in the target region’s workspace.

  If it’s important that you keep the historical Log Analytics data, consider either of the following approaches:
  - Keep the current workspace until you're confident you no longer require the data. Treat the workspace as read-only.
  - Export the workspace’s data to a storage account in the new target Azure region.

## Next steps

Evaluating your workload provides enough information to select a relocation method and the tools to execute the method you choose. The Select step walks you through the decisions to pick a relocation method and the correct tools for the relocation method.

> [!div class="nextstepaction"]
> [Select](select.md)
