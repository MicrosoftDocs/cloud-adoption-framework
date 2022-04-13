---
title: Governance considerations for Azure API Management
description: <<Describe how this landing zone accelerator can improve can improve governance of Azure API Management
author: BrianBlanchard
ms.author: brblanch
ms.date: 04/12/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: internal
---

# Governance considerations for API Managment landing zone accelerator

Intro paragraph. Disclose any required dependency on ESLZ design area or other ALZ design areas, with links to those supporting materials.

## Design considerations

The following is a bulleted list of things you must think about when preparing for **any** deployment of API Management.

- Research the available built-in RBAC roles available for the API Management service
- Consider what level of logging is necessary to meet your organization’s compliance requirements. 
- Consider how non-compliance should be detected.
- Consider how to standardize error responses returned by APIs.

## Design recommendations

The following is a bulleted list of best practices that should be included in any deployment of API Management

- Use Azure built-in roles to provide least privilege permissions to manage the API Management service.
- Configure diagnostics settings within API Management to output logs and metrics to Azure Monitor.
- Implement an error handling policy at the global level.
- All policies should call <base/>

## Enterprise-scale assumptions

The following are assumptions that went into the development of the deployable asset: Enterprise-scale for <<Token-LongName>>.

## Additional considerations

Create as many H2 "##" headers as is required to educate the customer on this topic.
