---
title: Governance
description: Design area guidance for governing your Azure environment
author: DominicAllen
ms.author: doalle
ms.date: 8/1/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Design area: Azure governance

As organizations begin their cloud adoption journey, starting with strong controls in place to government environments is an important success criteria.

Governance provides mechanisms and processes to maintain control over your applications and resources in Azure.

At part of the design area review, explore the considerations and recommendations outlined here in order to make informed decisions as you plan your landing zone. 

The governance design area focusses on the considerations and recommendations for design decisions as part of the landing zone. In addition to this, the [Govern methodology](/govern/index.md) in the Cloud Adoption Framework provides further in-depth guidance for holistic governance processes and tools. 

## Azure governance considerations

### Cost management considerations

- How is the organizations cost and recharging model structured? What are the key data points required in order to accurately reflect spend on cloud services?
- Tagging resources can make the process of tracking and allocating cloud spend easier, find the structure of tags that best fits your cost and recharging model

Add text.....

### Resource consistency considerations


Add text.....

### Azure Policy - Design considerations

Azure Policy is essential to ensuring security and compliance within enterprise technical estates. It can enforce vital management and security conventions across Azure platform services. It can also supplement Azure role-based access control that controls what actions authorized users can do.

- Determine what Azure policies are needed.

- Enforce management and security conventions, such as the use of private endpoints.

- Manage and create policy assignments by using policy definitions can be reused at multiple inherited assignment scopes. You can have centralized, baseline policy assignments at management group, subscription, and resource group scopes.

- Ensure continuous compliance with compliance reporting and auditing.

- Understand that Azure Policy has limits, such as the restriction of definitions at any particular scope: [policy limits](/azure/azure-resource-manager/management/azure-subscription-service-limits).

- Understand regulatory compliance policies. The policies might include HIPAA, PCI DSS, or SOC 2 Trust Services Criteria.

## Azure governance recommendations

### Cost management recommendations

Add text.....

### Resource consistency recommendations

Add text.....

### Azure Policy - Design recommendations

- Identify required Azure tags and use the append policy mode to enforce usage.

- Map regulatory and compliance requirements to Azure Policy definitions and Azure role assignments.

- Establish Azure Policy definitions at the top-level root management group so that they can be assigned at inherited scopes.

- Manage policy assignments at the highest appropriate level with exclusions at bottom levels, if necessary.

- Use Azure Policy to control resource provider registrations at the subscription or management group levels.

- Use built-in policies where possible to minimize operational overhead.

- Assign the built-in Resource Policy Contributor role at a particular scope to enable application-level governance.

- Limit the number of Azure Policy assignments made at the root management group scope to avoid managing through exclusions at inherited scopes.

## Azure governance in the Azure landing zone accelerator

Add text....