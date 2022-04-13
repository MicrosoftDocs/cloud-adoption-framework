---
title: Network topology and connectivity considerations for Azure API Management
description: <<Describe how this landing zone accelerator can improve network topology and connectivity of Azure API Management.>>
author: BrianBlanchard
ms.author: brblanch
ms.date: 04/12/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: internal
---

# Network topology and connectivity considerations for <<Token-LongName>> landing zone accelerator

[Intro paragraph. Disclose any required dependency on ESLZ design area or other ALZ design areas, with links to those supporting materials.]

## Design considerations

The following is a bulleted list of things you must think about when preparing for **any** deployment of API Management

- Decide if the Gateway should be deployed to an internal network 
- Decide if the APIs are accessible externally or internally
- Decide if there should be multiple gateways deployed (and how these are load balanced) e.g. by using Application Gateway
- Decide if the network setup requires cross-region connectivity
- Decide if private end point connectivity is required
- Decide how to connect to on-prem workloads
- Decide how to connect to external (3rd party) w

## Design recommendations

The following is a bulleted list of best practices that should be included in any deployment of <<Token-LongName>>.

## Enterprise-scale assumptions

The following are assumptions that went into the development of the deployable asset: Enterprise-scale for <<Token-LongName>>.

## Additional considerations

Create as many H2 "##" headers as is required to educate the customer on this topic.
