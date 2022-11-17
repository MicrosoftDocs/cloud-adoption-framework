---
title: Governance considerations for the Azure App Service landing zone accelerator
description: Learn about design considerations and recommendations for governance in the Azure App Service landing zone accelerator
author: BrianBlanchard
ms.author: martinek
ms.date: 03/23/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: internal
---

# Governance considerations the Azure App Service landing zone accelerator

This article provides design considerations and recommendations for governance when using the Azure App Service landing zone accelerator. Azure governance establishes the tooling needed to support cloud governance, compliance auditing, and automated guardrails.

Learn more about the [Azure governance](../../../ready/landing-zone/design-area/governance.md) design area.

## Design considerations

The following is a bulleted list of things you must think about when preparing for **any** deployment of App Service:

- Consider what level of logging is necessary to meet your organization’s compliance requirements.
- Review which [Web Application Firewall rule sets](/azure/web-application-firewall/ag/application-gateway-crs-rulegroups-rules?tabs=owasp32) and/or custom rules are necessary to meet your security and compliance requirements.

## Design recommendations

The following is a bulleted list of things you must think about when preparing for **any** deployment of App Service:

- Use [Azure Policy](/azure/app-service/policy-reference) to assess and enforce Regulatory Compliance controls
- Review the list of SSL cyphers.
- Apps should only be accessible over HTTPS.
- Use the latest TLS version when encrypting information in transit.
