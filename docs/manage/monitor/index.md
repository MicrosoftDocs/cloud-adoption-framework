---
title: Cloud monitoring guide
description: Learn about Azure Monitor, System Center Operations Manager, and the recommended strategy for monitoring each of the cloud deployment models.
author: Zimmergren
ms.reviewer: tozimmergren
ms.date: 04/06/2023
ms.author: tozimmergren
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: manage
ms.custom: think-tank, engagement-fy23, UpdateFrequency2
products: azure-monitor
---

# The cloud monitoring guide

This article is part of a series. The following articles are meant to be read together, in this order:

- Introduction (this article)
- [Cloud monitoring strategy](../../strategy/monitoring-strategy.md)
- [Monitoring platform strategy for cloud deployment models](./cloud-models-monitor-overview.md)
- [Observability](./observability.md)
- [Service Level Objectives](./service-level-objectives.md)
- [Collect the right data](./data-collection.md)
- [Response](./response.md)

## Introduction

IT departments must effectively monitor applications or services in and outside Azure while maintaining optimized DevOps processes. Digital transformation allows for infrastructure, workload, and application modernization. Adopting a hybrid cloud model might be part of the migration journey from on-premises to the cloud based on business strategy.

Stakeholders often desire SaaS-based monitoring and management tools for cloud solutions. Understanding available services is crucial to achieving end-to-end visibility, cost reduction, and less focus on traditional IT operations tools.

This guide aims to provide a reference for enterprise IT managers, decision-makers, architects, and developers to comprehend the following:

- Monitoring platforms for Azure, including overviews and comparison of their capabilities.
- The best-fit solution for monitoring hybrid, private, and Azure native workloads.
- The recommended end-to-end monitoring approach for both infrastructure and applications. This approach includes deployable solutions for migrating these typical workloads to Azure.

This guide isn't a how-to article for using or configuring individual Azure services and solutions, but it does reference those sources when they're applicable or available. After you've read it, you'll understand how to successfully operate a workload by following best practices and patterns.

Review the [monitoring platforms overview](./platform-overview.md) page to learn how Azure Monitor and System Center Operations Manager work and how they compare.

## Audience

This guide is useful primarily for enterprise administrators, IT operations, IT security and compliance, application architects, workload development owners, and workload operations owners.

## Products and services

A few software and services are available to help you monitor and manage various resources that are hosted in Azure, your corporate network, or other cloud providers. They are:

- [Azure Monitor](/azure/azure-monitor/overview) (includes Log Analytics and Application Insights)
- [System Center Operations Manager](/system-center/scom/welcome)
- [Azure Policy](/azure/governance/policy/overview) and [Azure Blueprints](/azure/governance/blueprints/overview)
- [Azure Arc](/azure/azure-arc/)
- [Azure Automation](/azure/automation/automation-intro)
- [Azure Logic Apps](/azure/logic-apps/logic-apps-overview)
- [Azure Event Hubs](/azure/event-hubs/event-hubs-about)

The guide covers mainly our current monitoring platform, Azure Monitor, and will also guide you through how System Center Operations Manager fit in for hybrid and migration scenarios. It also outlines our recommended strategy for monitoring each cloud deployment model. Additionally, it includes a set of monitoring recommendations, starting with data collection, observability, and alerting.

## Next steps

> [!div class="nextstepaction"]
> [Monitoring strategy for cloud deployment models](./cloud-models-monitor-overview.md)
