---
title: "Enterprise-Scale management and monitoring for data management"
description: Describe how this enterprise-scale scenario can improve management and monitoring of data management
author: abdale
ms.author: hamoodaleem
ms.date: 04/12/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Management and monitoring for data management Enterprise-Scale scenario

This section explores how to operationally maintain an Azure Enterprise Scale Analytics and AI platform with centralized management and monitoring.

## Plan platform management and monitoring

At the heart of Enterprise Scale Analytics and AI is its data management capability which is enabled through the [Data Management Landing Zone](eslz-data-management-landing-zone.md), which is a subscription responsible for the governance of the platform.

**Design considerations:**

Here are some design considerations for monitoring and management in Enterprise Scale Analytics and AI.

- An Enterprise Scale Analytics and AI deployment comes with custom [policies](eslz-policies.md) pertaining to resource and cost management, authentication, encryption, network isolation, logging, resilience and more. Consider using these policies to help implement the required guard rails in your environment.
- Consider a centralized Azure Log Analytics workspace with Azure Monitor and Application Insights for establishing platform and application-layer monitoring.

**Design recommendations:**

Here are some design recommendations for monitoring and management in Enterprise Scale Analytics and AI.

- Apply policies to the highest level possible. In most cases this will be a [management group](/azure/governance/management-groups/overview).

*work in progress*


