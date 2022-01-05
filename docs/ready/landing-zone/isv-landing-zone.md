---
title: Independent Software Vendor (ISV) considerations for Azure landing zones
description: Learn Independent Software Vendor (ISV) specific considerations for Azure landing zones.
author: arsenvlad
ms.author: arsenv
ms.date: 01/04/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Independent Software Vendor (ISV) considerations for Azure landing zones

For many organizations, the [Azure landing zones](./index.md) conceptual architecture represents the destination in their cloud adoption journey via multi-subscription Azure environment that accounts for scale, security, governance, networking, and identity. It's based on feedback and lessons learned from enterprise customers.

It's helpful to think about Azure landing zones as the "city plan" and the architecture of the specific workloads deployed into the landing zone as the "building plan".

As an Independent Software Vendor (ISV) building and operating your solution on Azure, refer to the following resources:

* [Azure landing zones](./index.md): guidance for the overall Azure environment, analogous to a "city plan".
* [Azure Well-Architected Framework](/azure/architecture/framework/): architectural guidance applicable to all workloads, analogous to a "building plan".
* [Architecting multitenant solutions on Azure](/azure/architecture/guide/multitenant/overview): architectural guidance applicable specifically to developers of **multitenant** solutions on Azure.

While as an ISV, SaaS provider, or a Startup your specific implementation might vary, the Azure landing zones conceptual architecture will help you set a direction for the overall approach.

ISV solutions often fit one of the following three deployment models. Each of these models has different key considerations for Azure landing zones.

## Pure SaaS deployment model

In the pure SaaS model, the ISV software is deployed fully in the ISV's own Azure subscriptions and end-customers consume the software-as-a-service without deploying it in their own Azure subscriptions. Examples of pure SaaS software are SendGrid, Confluent Cloud, Snowflake, and many other [SaaS listings in Azure Marketplace](https://azuremarketplace.microsoft.com/marketplace/apps?filters=saas).

![Diagram showing pure SaaS deployment model](./media/isv-pure-saas-deployment.png)

As a SaaS ISV, you should look at the Azure landing zone guidance for how to properly architect your overall Azure environment for scale and should also review the [Architecting multitenant solutions on Azure](/azure/architecture/guide/multitenant/overview) series that provides guidance on how to design, build, and operate your own multitenant solutions on Azure.

As a smaller SaaS ISV, today, you might not have your application architected in a multi-subscription way because it currently functions properly within Azure subscription limits. Review the [Enterprise-scale landing zone design principles](../enterprise-scale/design-principles.md), such as subscription democratization, and familiarize yourself with the [architectural approaches for multitenancy](/azure/architecture/guide/multitenant/approaches/overview) to plan for future growth as required.

ISVs building pure SaaS solutions should consider:

* How to decide if all resources making up the SaaS solution should be in one Azure subscription or partitioned across multiple Azure subscriptions?
* Should each customer of an ISV's SaaS solution be hosted in a dedicated Azure subscription or can resources be created in one or a few shared subscriptions?
* How to apply the [deployment stamp (scale unit) pattern](/azure/architecture/guide/multitenant/approaches/overview) for all tiers of the solution?
* How to think about [Azure resource organization in multitenant solutions](/azure/architecture/guide/multitenant/approaches/resource-organization) to avoid facing scale challenges and Azure subscription limits?

## Customer-deployed deployment model

In the customer-deployed model, the end-customers purchase software from the ISV and deploy it into customers' own Azure subscriptions. The deployment could be initiated from the Azure Marketplace as a Virtual Machine or an Azure Application, or done manually via instructions and scripts provided by the ISV. Examples of customer-deployed ISV products are Barracuda firewall appliance, SoftNAS appliance, and many other [Virtual Machines](https://azuremarketplace.microsoft.com/marketplace/apps?filters=virtual-machine-images) and [Azure Applications](https://azuremarketplace.microsoft.com/marketplace/apps?filters=solution-templates) in Azure Marketplace.

For some customer-deployed solutions, ISVs, Solution Integrators (SI), or Managed Service Providers (MSP), can still provide management and updates of the solution deployed within the end-customer Azure subscriptions using [Azure Lighthouse](/azure/lighthouse/overview) or [Azure Managed Application](/azure/azure-resource-manager/managed-applications/overview) capabilities.

Customers frequently deploy multiple separate ISV products into the customer's own Azure subscriptions and compose these individual products into a solution. For example, they might deploy a database from ISV A, network virtual appliance from ISV B, and a web application from ISV C. As such, "Customer's Other Workload" boxes in the diagram below can represent either customer's own workload or another ISV product in the customer's Azure subscription.

![Diagram showing customer-deployed deployment model](./media/isv-customer-deployed-deployment.png)

Customer-deployed ISV solutions would be considered a standard "application workload" from Azure landing zone perspective. That's why, as an ISV building customer-deployed software, you should look at Azure landing zones for guidance on how to properly design your software so that it "plays nicely" with the Azure landing zones design principles adopted by your Azure customers.

Proper understanding of the Azure landing zone concepts is especially relevant during ISV migrations where an ISV is moving their existing customers' workloads from on-premises to Azure.

ISVs building customer-deployed solutions should consider:

* When should the customer deploy the ISV solution into its own dedicated subscription and when should it be deployed into an existing subscription that contains related workloads?
* How will customers establish network connectivity between their existing workloads and the ISV solution being deployed into their Azure subscription?
* Does ISV solution support authentication mechanisms provided by Azure AD or will it require LDAP or Kerberos?
* How can the ISV decrease Azure Policy conflicts between the ISV's solution templates and customer's Azure policies?

## Dual deployment SaaS deployment model

Some SaaS solutions interact with or use resources that are deployed in the customers' Azure subscriptions. For example, NetApp Virtual Desktop provides a console UI to control Azure Virtual Desktops in the customers' Azure subscriptions, NetApp Cloud Sync provides backup service but requires a Data Broker VM in the customers' Azure subscription, and Upsolver provides a SaaS console for data analytics but dynamically creates and deletes compute node virtual machines in the customers' subscription.

![Diagram showing dual deployment SaaS also known as SaaS Hybrid](./media/isv-dual-deployment.png)

As a dual deployment ISV, you should refer to the Azure landing zone for guidance on both how to structure your own Azure environment hosting your SaaS service and how to make the components that deploy into your customers' Azure subscriptions interact properly with the customers' Azure landing zones.

ISVs building dual deployment SaaS solutions should consider:

* Review all of the considerations applicable to ISVs building pure SaaS and customer-deployed solutions.
* Which components of the solution will be hosted in the ISV's own Azure subscriptions and which components will be customer-deployed?
* How will you ensure secure provisioning and interactions with the resources deployed in the customer Azure subscriptions?

## Azure landing zone design principles and implementations

Although [Azure landing zone design principles](../enterprise-scale/design-principles.md) recommend aligning to Azure-native platform capabilities and provides specific [Azure landing zone implementation options](./implementation-options.md), as an ISV, you might have reasons to implement your own landing zone environment and might decide to continue using your existing preferred tools for logging, monitoring, and so on.

In any case, it's recommended to use Azure landing zone guidance and implementation as a reference and as a way to align your approach to what was proven to work for Azure's enterprise customers.

## Azure Active Directory considerations for SaaS ISVs

Azure landing zone [Azure Active Directory tenant guidance](./design-area/azure-ad-define.md) strongly recommends using a single Azure AD tenant, which is the correct approach for most enterprise customers. However, as a SaaS ISV, you might have reasons to separate the Azure AD tenant used by your SaaS Operations team versus the Azure AD tenant used by your Corporate IT.

For some SaaS ISVs, the Corporate IT team that owns the Corp resources is different from the group that develops software and that operates this software as SaaS for the end-customers. In fact, Corporate IT might not even be allowed to manage the SaaS related components. These SaaS ISVs can have two separate Azure AD tenants: one for their Corp IT resources like Office 365 and a separate one for Azure resources of the SaaS solution.

The [securing Azure environments with Azure Active Directory whitepaper](https://azure.microsoft.com/resources/securing-azure-environments-with-azure-active-directory/) discussed the decision points for when it makes sense for SaaS providers to have more than one Azure AD tenant.

## Management Group hierarchy considerations for SaaS ISVs

As a SaaS ISV, you might find that the recommended Azure landing zone [Management Group hierarchy](./design-area/resource-org-management-groups.md) of Corp and Online archetypes isn't applicable to how you develop and operate your SaaS solution. Also, Azure landing zone [Enterprise-scale FAQ](../enterprise-scale/faq.md#how-do-we-handle-devtestproduction-workload-landing-zones-in-enterprise-scale-architecture) explains how to handle the "dev/test/production" workload landing zones for enterprise customers, but it might still not be applicable to SaaS providers whose single workload is partitioned across multiple Azure subscriptions.

SaaS ISVs often organize their cloud environments by modeling their software development lifecycle promotional environments of dev, test, stage, and prod. The primary difference between the dev, test, stage, and prod groups of subscriptions is frequently the Azure RBAC such as who can access these groups of subscriptions - DevOps, SaaSOps, Developers, or Testers. The Azure Policy differences are less pronounced since these groups of subscriptions often have similar guardrails such as which Azure regions and VM sizes can be used in each environment. Also, SaaS ISVs with multiple tiers of service, can have extra separation between free-tier shared instances of the  and premium-tier dedicated instances of the application.

If you're such an ISV, you might prefer to use Management Groups for grouping multiple subscriptions that correspond to the separate promotional environments "dev/test/production" and which have different Azure RBAC and Azure Policies.

The diagram below shows a potential management group and subscription hierarchy that is relatable to many SaaS ISVs. The "stage" management group and the distinction between multitenant and isolated production subscriptions are optional since they might not be applicable to all ISVs. For example, smaller ISVs can decide to only start with three subscriptions such as platform, dev/test, and prod, but might want to include extra subscriptions as separate deployment stamps as they grow.

![ISV promotional environment Management Group hierarchy](./media/isv-mg-hierarchy.png)

## Next steps

* If you're building a multitenant solution, learn more about [architecting multitenant solutions on Azure](/azure/architecture/guide/multitenant/overview)
* Learn [what is an Azure landing zone](./index.md)
* Learn about [Azure landing zone design areas](./design-areas.md)
