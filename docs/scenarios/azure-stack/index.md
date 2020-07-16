---
title: "Azure in your datacenter - Azure Stack Hub"
description: Deploy Azure in your data center - Azure Stack Hub
author: BrianBlanchard
ms.author: brblanch
ms.date: 05/19/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: strategy
---

# Strategic option to run Azure in your datacenter

Microsoft takes a cloud-first approach. The priority is to move applications and data on one or more of the hyperscale clouds, including the global Azure option or a sovereign, locale-specific cloud such as Azure Germany or Azure Government. Azure Stack Hub acts as another instance of a sovereign cloud, operated by customers in their datacenters or consumed through a cloud service provider. However, Azure Stack Hub is not a hyperscale cloud and Microsoft does not publish or support any service-level agreements (SLA) for Azure Stack Hub.

## Understand your cloud journey

Every organization has a unique journey to the cloud based on its history, business specifics, culture, and maybe most importantly their starting point. The journey to the cloud provides many options, features, functionalities, as well as opportunities to improve existing governance, operations, implement new ones, and even redesign the applications to take advantage of the cloud architectures.

Your journey might identify clear benefits to using the cloud as part of your IT and business strategy. However, your journey could identify equally strong motivations to keep the cloud in your datacenter, _at least for now_. If you're facing these two competing drivers, you don't have to choose. Azure Stack Hub at its core is [infrastructure as a service (IaaS)](https://azure.microsoft.com/blog/azure-stack-iaas-part-one) and also provides platform as a service (PaaS) services that allow you to run a subset of Azure services in your own datacenter.

## Azure Stack Hub in your strategy

Azure Stack Hub migration provides an alternative approach to the migration of existing applications that run either on physical servers or on existing virtualization platforms. By moving these workloads to the Azure Stack Hub IaaS environment, teams can benefit from smoother operations, self-service deployments, standardized hardware configurations, and Azure consistency. Using Azure Stack Hub for modernization or innovation support enables your teams to prepare you applications and workloads to take full advantage of the cloud.

By following a consistent practice for cloud adoption across Azure and Azure Stack Hub, you can apply the same governance and operations models to assets in the public cloud or your own datacenter. Azure Stack Hub uses the same Azure Resource Manager model as Azure, enabling that single-pane of glass view for your solutions.

## Understand the differences

There are some differences between Azure and Azure Stack Hub. Some are very visible, other differences can't be seen until late in implementation cycles. The following are a few differences to be aware of:

- Azure offers near limitless capacity. Azure Stack Hub is built on physical hardware in your datacenter, which leads to capacity limitations.
- API versions and authentication mechanisms may be slightly different between Azure and Azure Stack Hub.
- Azure Stack Hub differs in _who_ operates the cloud, which affects the level of workload operations.
- You must consider which part of the Azure Stack Hub service that the Azure Stack Hub operator runs, because that determines whether the end customer calls a service PaaS or SaaS.

Other differences will be called out in other Azure Stack Hub articles at various points in the cloud adoption lifecycle.

## Next step: Integrate this strategy into your cloud adoption journey

The following list of articles will take you to guidance found at specific points throughout the cloud adoption journey.

- [Planning for Azure Stack Hub migrations](./plan.md)
- [Environmental readiness](./ready.md)
- [Assess workloads for Azure Stack Hub](./migrate-assess.md)
- [Deploy workloads to Azure Stack Hub](./migrate-deploy.md)
- [Govern Azure Stack Hub](./govern.md)
- [Manage Azure Stack Hub](./manage.md)
