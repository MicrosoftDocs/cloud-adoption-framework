---
title: Strategic option to run Azure in your datacenter
description: Deploy Azure in your datacenter by using Azure Stack Hub.
author: BrianBlanchard
ms.author: brblanch
ms.date: 05/19/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: strategy
---

# Strategic option to run Azure in your datacenter

Microsoft takes a cloud-first approach. The priority is to move applications and data to one or more of the hyperscale clouds, including the global Azure option or a sovereign, locale-specific cloud such as Azure Germany or Azure Government. Azure Stack Hub acts as another instance of a sovereign cloud, operated by customers in their datacenters or consumed through a cloud service provider. However, Azure Stack Hub is not a hyperscale cloud, and Microsoft does not publish or support any service-level agreements (SLA) for Azure Stack Hub.

## Understand your cloud journey

All organizations have a unique journey to the cloud based on their history, business specifics, culture and, maybe most importantly, their starting point. Their journey provides many options, features, and functionalities. It also presents opportunities to improve their existing governance and operations, implement new ones, and even redesign their applications to take advantage of the cloud architectures.

Your organization's journey might identify clear benefits to using the cloud as part of your IT and business strategy. However, your journey could identify equally strong motivations to keep the cloud in your existing datacenter, _at least for now_. If you're facing these two competing drivers, you don't have to choose. At its core, Azure Stack Hub is [infrastructure as a service (IaaS)](https://azure.microsoft.com/blog/azure-stack-iaas-part-one). It also provides platform as a service (PaaS) services that allow you to run a subset of Azure services in your own datacenter.

## Azure Stack Hub in your strategy

Azure Stack Hub provides an alternative approach to the migration of existing applications that run on either physical servers or existing virtualization platforms. By moving these workloads to the Azure Stack Hub IaaS environment, teams can benefit from smoother operations, self-service deployments, standardized hardware configurations, and Azure consistency. Using Azure Stack Hub for modernization or innovation support enables your teams to prepare your applications and workloads to take full advantage of the cloud.

By following a consistent practice for cloud adoption across Azure and Azure Stack Hub, you can apply the same governance and operations models to assets in the public cloud or your own datacenter. Azure Stack Hub uses the same Azure Resource Manager model as Azure, enabling that single-pane of glass view for your solutions.

## Compare Azure with Azure Stack Hub

There are some differences between Azure and Azure Stack Hub. Some are very visible, and others can't be seen until late in the implementation cycle. Be aware of the following differences:

- Azure offers near limitless capacity. Azure Stack Hub is built on physical hardware in your datacenter, which leads to capacity limitations.
- API versions and authentication mechanisms might be slightly different between Azure and Azure Stack Hub.
- Azure Stack Hub differs in _who_ operates the cloud, which affects the level of workload operations.
- Consider which part of the Azure Stack Hub service the Azure Stack Hub operator runs on, because that determines whether the customer calls a service PaaS or SaaS.

Other differences will be called out in other Azure Stack Hub articles at various points in the cloud adoption lifecycle.

## Next steps

For guidance on specific elements of the cloud adoption journey, see:

- [Plan for Azure Stack Hub migration](./plan.md)
- [Environmental readiness](./ready.md)
- [Assess workloads for Azure Stack Hub](./migrate-assess.md)
- [Deploy workloads to Azure Stack Hub](./migrate-deploy.md)
- [Govern Azure Stack Hub](./govern.md)
- [Manage Azure Stack Hub](./manage.md)
