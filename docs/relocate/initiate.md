---
title: How to initiate a cloud relocation project.
description: Learn how to initiate a cloud relocation project so you can relocate workloads and applications to another region.
author: SomilGanguly
ms.author: ssumner
ms.date: 08/09/2023
ms.reviewer: ssumner
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: adopt
ms.custom: internal, seo-caf-relocate
keywords: cloud adoption, cloud framework, cloud adoption framework
---
# Initiate a cloud relocation project

The Initiate phase is a single step to establish the relocation project. The guidance in the Initiate phase is more important for large relocation efforts with multiple workloads in scope. For small relocation with a single workload in scope, you can skip to [create a relocation plan](#create-a-relocation-plan). A single relocation project can include multiple source and target regions. There's no need to plan them separately. The goal of the Initiate phase is to provide stakeholders with the information they want and get the relocation the resources it needs. Here's a framework for initiating a relocation.

:::image type="content" source="../_images/relocate/caf-relocate-initiate.png" alt-text="Diagram showing the relocation process and highlights the Initiate step in the Initiate phase. In the relocation process, there are two phases and five steps. The first phase is the Initiate phase, and it has one step called Initiate. The second phase is the Move phase, and it has four steps that you repeat for each workload. The steps are Evaluate, Select, Migrate, and Cutover." lightbox="../_images/relocate/caf-relocate-initiate.png" border="false":::

## Identify objectives

The need to meet specific objectives drives relocation projects. You should capture these objectives so you can scope and prioritize your relocation efforts. The following table provides examples of relocation objectives.

|Objective |Motivation |Priority|
| --- | --- | --- |
|1. Comply with data-residency laws. | Meet all legal and ethical standards. | High|
|2. Improve application performance for users in a different region. | Meet revenue targets. |Medium|
|3. Add new services to internal productivity tools. | Increase employee productivity. |Low|

## Determine scope

You should use the objectives to scope your relocation plan. Identify all the workloads in scope of these objectives. The workload should be the smallest unit of relocation during scoping. Anything smaller, such as environment or service, makes planning difficult to manage. In execution, you relocate workloads by migrating or redeploying workload services and components. But for planning and scoping, focus on the workload as a whole. For more information, see [What is a workload?](../plan/workloads.md#what-is-a-workload).

When defining the scope of your relocation plan, it’s important to understand the integrations each workload may have with other services. For example, consider these questions:

- Does the relocated workload need to communicate with workloads that remain in your source region?
- Are there scripts, automation tools or CI/CD pipelines associated with the migrated workloads that need to be updated to reflect the new region?
- How will network ingress and egress work for the workload once relocated?

## Prioritize workloads

The order you relocate workloads should reflect the priority of your objectives. Any technical dependencies, such as platforms and landing zones, should go first. Outside of technical dependencies, the order is up to you. For more information, see [Platform vs application landing zones](../ready/landing-zone/index.md#platform-landing-zones-vs-application-landing-zones).

## Create a relocation plan

You should create a relocation plan that addresses service capacity and high-level project planning. At the service level, you want to verify the target region meets the capacity needs for each workload service. At the workload architecture level, you want to verify that the target region can support the architectural approach used by your applications. For example, if you have a multi-region workload that uses Azure region pairs for global scaling or geo-redundancy, then check whether your destination region supports region pairing. Similarly, if you're moving from or to a region with availability zone support, consider how you use zonal or zone-redundant deployment approaches.

The rest of your relocation plan should center on the relocation project and getting stakeholder approval to proceed. Most stakeholders want to know about the schedule, team, and cost. Rather than spending time trying to estimate the schedule, resources, and cost, start the relocation process and refine the estimates as you learn more. Here are recommendations for creating a minimum viable plan to get started.

**Build a soft schedule.** The schedule depends on the complexity of the workloads being relocated and the experience of the team involved. Instead of spending time figuring out how long it takes, start relocating the first workload. The experience allows you to better estimate a completion date, and it saves you time.

**Use a multi-disciplinary team.** The relocation team needs technical, business, and legal/compliance expertise. The business stakeholders own the workload and should guide the technical team to meet the objectives. You need the legal or compliance teams if the workload is being relocated due to regulatory requirements.

**Know cost factors.** Relocation has a cost. Moving data and using services isn't free. To minimize cost, you should move data once and avoid duplicating services or environments for extended periods of time. A hidden cost you might not consider comes from suppliers, partners, or third-party technical support. You might need their help to relocate a workload, and they typically charge a fee. For some Azure services, the price varies for each region, so be sure to review the pricing before you start the relocation project. If you use Azure Reservations to reduce your Azure costs in your source region, consider whether you can exchange them to your destination region.

## Evaluate potential side effects of the relocation

In any migration project, there’s a risk of something breaking during the relocation process. Outages can happen by accident, or due to the way that the service being relocated is designed. Wherever possible, it’s best to identify these issues during the discovery stage so that you can put a plan in place to mitigate the risk of an outage or misconfiguration. Here are some points to consider:

- **Automation, scripts and infrastructure as code:** Your organization might have invested in automation techniques, which can be helpful with the relocation process. However, be sure to identify and change any references to Azure regions, service names, or service URLs to reflect the destination Azure region. Ideally, values that can change during the lifecycle of an application should be looked up dynamically, or configured as parameters within the code, to make the changes less onerous.

- **Public IP addresses:** Azure allocates public IP addresses from a range unique to each Azure region. This means that when a new public IP address is provisioned in the new target Azure region, the public IP addresses used by your resources will have changed from what it is currently. As you go live with the services in the new Azure region, plan how you update your external DNS records to reflect the new IP addresses in use. If external parties have allowlisted your organization’s public IP addresses, then they need to be supplied with the new IP addressed of the relocated services.

- **Resource DNS names and URLs:** Many Azure resources can be configured with globally unique DNS names. For example, Azure Storage uses DNS names similar to `<unique_name>.blob.core.windows.net`, and Azure App Service uses DNS names similar to `<unique_name>.azurewebsites.net`. Similarly, if you have any public IP address resources that you attach to virtual machines or networking resources, they might be configured to use a DNS name similar to `<unique-name>.<region-name>.cloudapp.azure.com`.

  Evaluate whether your migration plan requires you to provision new instances of services within the new target Azure region while the current service is still provisioned in the old Azure region. If you do, there might be a naming conflict: two resources can’t share the same DNS name at the same time. Consider whether you can use different names for each resource.

  In some situations, your DNS records might be able to provide a layer of abstraction by using CNAME records, which makes a service name change easier to manage.

- **Private endpoints:** Many Azure services enable you to access your resources by using a private endpoint in your own virtual network. Often, this approach uses the resource’s URL, such as in your private DNS zones. The preceding consideration described how a resource’s URL can change during the migration process, so ensure that you plan how you configure your private endpoints and DNS zones.

- **Azure Backup recovery points:** When virtual machines are relocated to the new target Azure region, they first need to be de-registered with the current Azure Backup service and then re-registered with a new instance of Azure Backup located in the new region. This process causes existing recovery points for that virtual machine to be unavailable, because recovery points can’t be relocated to a different vault.

- **Log Analytics workspaces:** It’s best to deploy a separate Log Analytics workspace for each region, which means you should deploy a new workspace in your target region. It’s not possible to move a Log Analytics Workspace to another region, which means the data from your original workspace won’t be available in the target region’s workspace.

  If it’s important that you keep the historical Log Analytics data, consider either of the following approaches:
  - Keep the current workspace until you're confident you no longer require the data. Treat the workspace as read-only.
  - Export the workspace’s data to a storage account in the new target Azure region.


## Next step

The next step is the Move phase of relocation. The Move phase has four steps: evaluate, select, migrate, and cutover. You might have one or more workloads to relocate. Regardless of number, you should work through these four steps for any workload you want to relocate.

> [!div class="nextstepaction"]
> [Evaluate](evaluate.md)
