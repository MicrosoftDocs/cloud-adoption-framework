---
title: Management - Operational compliance
description: Design area guidance for establishing operational compliance across your Azure platform services
author: DominicAllen
ms.author: doalle
ms.date: 8/1/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---


# Operational compliance considerations | Management design area

As environments scale and the number of applications and services grows, putting in place capabilities to monitor for deviations from expected configurations becomes increasingly important.

The tools need to include automation where possible to enable them to scale to cover the growing environment footprint and reduce the risk of gaps in observation.

## Monitoring for configuration drift

Monitoring an environment for configuration drift is an important part of ensuring stable, consistent operations.

[Azure Policy](/azure-policy/#overview) is highly valuable within cloud management processes. Azure Policy can audit and remediate Azure resources and can also audit settings inside a machine. The validation is performed by the guest configuration extension and client. The extension, through the client, validates settings such as:

- Operating system configuration.
- Application configuration or presence
- Environment settings

Using this technique as part of your organization management approach within a landing zone can assist with ensuring resources stay in line with expected configuration.

Learn more about the [guest configuration feature of Azure Policy](/azure/governance/policy/concepts/guest-configuration#:~:text=%20Understand%20the%20guest%20configuration%20feature%20of%20Azure,inclusive%20of%20new%20versions.%20Older%20versions...%20More%20) to consider how it can from part of your landing zone management toolkit.

## Update management considerations

- Are there existing update management tools used by the organization? Can they be extended to cover the cloud environment or are new tools required?
- Which teams will be responsible for overseeing update management?
- Are there groups of resources that share similar update schedules?
- Are there groups of resources that cannot be updated at the same time for business continuity reasons?  
