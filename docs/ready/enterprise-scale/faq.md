---
title: Enterprise-scale FAQ
description: The Enterprise-scale FAQ provides answers to common questions asked about the Enterprise-scale architecture.
author: jtracey93
ms.author: jtracey93
ms.date: 09/13/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

# Enterprise-scale FAQ

This article answers frequently asked questions relating to Enterprise-scale.

## What does a "Landing Zone" map to in Azure in the context of Enterprise-scale?

From an Enterprise-Scale point of view, "Landing Zones" are Azure Subscriptions.

## Why does Enterprise-scale implementation require permission at Tenant root '/' scope?

Management Group creation, Subscription creation, and placing Subscriptions into Management Groups are APIs that operate at the tenant root "`/`" scope.

Therefore, to create the Management Group hierarchy, the Subscriptions, and place them into the Management Groups defined, the initial deployment must  be invoked at the tenant root "`/`" scope. Once you have deployed Enterprise-scale, you can remove the Owner permission from the tenant root "`/`" scope, as you will be made an Owner at the intermediate root Management Group (e.g. "Contoso"), by the Azure platform, that Enterprise-scale has created.

For further guidance on tenant level deployments in Azure, see: [Deploy resources to tenant](/azure/azure-resource-manager/templates/deploy-to-tenant)

## How long does Enterprise-scale take to deploy?

This is dependant on the options you select during the implementation experience. However, it will vary from around 5 minutes to 40 minutes; depending on the options selected.

For example:

- Deploying the conceptual architecture without any networking/connectivity options will take around 5 minutes to deploy.
- Deploying the conceptual architecture with the hub and spoke networking options, including VPN and ExpressRoute gateways, will take around 40 minutes to deploy.

