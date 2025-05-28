---
title: Governance considerations for the Azure API Management landing zone accelerator
description: Learn about design considerations and recommendations for governance in the Azure API Management landing zone accelerator
author: Zimmergren
ms.author: pnp
ms.date: 04/12/2022
ms.topic: conceptual
ms.custom: internal
---

# Governance considerations for the API Management landing zone accelerator

This article provides design considerations and recommendations for governance when using the API Management landing zone accelerator. Azure governance establishes the tooling needed to support cloud governance, compliance auditing, and automated guardrails.

Learn more about the [Azure governance](../../../ready/landing-zone/design-area/governance.md) design area.

## Design considerations

- Research the available [built-in RBAC roles](/azure/api-management/api-management-role-based-access-control) available for the API Management service.
- Review the [Azure Policy built-in policy definitions](/azure/api-management/policy-reference) and the [Azure Policy Regulatory Compliance controls](/azure/api-management/security-controls-policy) for API Management. Azure Policy can help enforce vital management and security conventions across Azure platform services.
- Consider what level of logging is necessary to meet your organization’s compliance requirements.
- Consider how non-compliance should be detected.
- Consider how to standardize error responses returned by APIs.

## Design recommendations

- Use Azure built-in roles to provide least-privilege permissions to manage the API Management service.
- Configure [diagnostics settings](/azure/api-management/api-management-howto-use-azure-monitor) within API Management to output logs and metrics to Azure Monitor.
- Implement an [error handling policy](/azure/api-management/api-management-error-handling-policies) at the global level.
- All API Management policies should include a [`<base/>`](/azure/api-management/set-edit-policies#use-base-element-to-set-policy-evaluation-order) element.
