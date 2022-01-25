---
title: Policies in data management and analytics
description: Learn about Azure policies in data management and analytics. Azure policies help your organization govern resources as needed.
author: abdale
ms.author: hamoodaleem
ms.date: 12/15/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Policies in data management and analytics

Before considering a deployment, it's important for your organization to put guardrails in place. By using [Azure policies](/azure/governance/policy/overview), you can implement governance for resource consistency, regulatory compliance, security, cost, and management.

## Background

A core principle of data management and analytics scenario is to make it easy to create, read, update, and delete resources as needed. However, while giving unrestricted resource access to developers can make them agile, it can also lead to unintended cost consequences. The solution to this problem is resource access governance. This governance is the ongoing process of managing, monitoring, and auditing the use of Azure resources to meet the goals and requirements of your organization.

The [enterprise-scale architecture](../../ready/enterprise-scale/index.md) already uses this concept. Data management and analytics scenario adds [Custom Azure policies](#azure-policies-for-data-management-and-analytics-scenario) to build on these standards. The standards are then applied to our data management landing zones and data landing zones.

![Diagram that shows how Azure governance works.](./images/azure-governance.png)

Azure Policy is important when ensuring security and compliance within data management and analytics scenario. It helps to enforce standards and to assess compliance at scale. Policies can be used to evaluate resources in Azure and compare them to the wanted properties. Several policies, or business rules, can be grouped into an initiative. Individual policies or initiatives can be assigned to different scopes in Azure. These scopes might be management groups, subscriptions, resource groups, or individual resources. The assignment applies to all resources within the scope, and subscopes can be excluded with exceptions if necessary.

## Design considerations

Azure policies in data management and analytics scenario were developed with the following design considerations in mind:

- Use Azure policies to implement governance and enforce rules for resource consistency, regulatory compliance, security, cost, and management.
- Use available prebuilt policies to save time.
- Assign policies to the highest level possible in the management group tree to simplify policy management.
- Limit Azure Policy assignments made at the root management group scope to avoid managing through exclusions at inherited scopes.
- Only use policy exceptions if necessary, and they should require global admin approval.

## Azure policies for data management and analytics scenario

[Implementing custom policies](/azure/governance/policy/tutorials/create-and-manage) allows you to do more with Azure Policy. Data management and analytics scenario comes with a set of pre-created policies to help you implement any required guardrails in your environment.

Data management and analytics scenario contains custom policies related to **resource and cost management, authentication, encryption, network isolation, logging, resilience, and more**. See [Data service policies](./architectures/policies.md) for an updated list of policies.

> [!NOTE]
> The policies provided are not applied by default during deployment. They should be viewed as guidance only, and can be applied depending on business requirements. Policies should always be applied to the highest level possible. In most cases, this is a [management group](/azure/governance/management-groups/overview). All of the policies are available in our GitHub repository.

## Next steps

- [Requirements for governing data in a modern enterprise](./govern-requirements.md)
- [Components needed for data governance](./govern-components.md)
