---
title: Policies in Azure Enterprise Scale Analytics and AI
description: Policies in Enterprise Scale Analytics and AI
author: abdale
ms.author: hamoodaleem
ms.date: 03/19/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Policies

Before considering a deployment, it is important for your organization to decide upon the guard rails that you wish to put in place. By using [Azure Policies](/azure/governance/policy/overview), you can implement governance for resource consistency, regulatory compliance, security, cost, and management.

## Background

A core principle of the Enterprise Scale Analytics and AI construction set is to enable agility by making it easy to create, read, update, and delete resources as needed. However, while giving unrestricted resource access to developers can make them very agile, it can also lead to unintended cost consequences. The solution to this problem is resource access governance, which is the ongoing process of managing, monitoring, and auditing the use of Azure resources to meet the goals and requirements of your organization.

The [Enterprise-Scale Architecture](/azure/cloud-adoption-framework/ready/enterprise-scale/) already uses this concept, and Enterprise Scale Analytics and AI construction set builds upon these standards by adding [custom Azure Policies](#azure-policies-for-enterprise-scale-analytics-and-ai) which are applied to our Data Management Landing Zone and Data Landing Zones.

![How Azure Governance works](./images/azure-governance.png)
*Figure 1: How Azure Governance Works*

Azure Policy is essential to ensuring security and compliance within Enterprise Scale Analytics and AI. It helps to enforce standards and to assess compliance at-scale. Policies can be used to evaluate resources in Azure and compare them to the desired properties. Several policies (business rules) can be grouped into an initiative. Individual policies or initiatives can be assigned to different scopes in Azure, such as management groups, subscriptions, resource groups, or individual resources. The assignment applies to all resources within the scope, and sub-scopes can be excluded with exceptions if necessary.

## Design considerations

Azure policies in Enterprise Scale Analytics And AI were developed with the following design considerations in mind:

- Azure Policy are used to implement governance and enforce rules for resource consistency, regulatory compliance, security, cost, and management.
- Pre-built policies which are available should be used to save time.
- Policies are assigned to the highest level possible in the management group tree to simplify the management of policies.
- The number of Azure Policy assignments made at the root management group scope are limited to avoid managing through exclusions at inherited scopes.
- Policy exceptions are only be used if required and should require global admin approval.

## Azure Policies for Enterprise Scale Analytics and AI

[Implementing custom policies](/azure/governance/policy/tutorials/create-and-manage) allows you to do more with Azure Policy. Enterprise Scale Analytics and AI comes with a set of pre-created policies to help you implement the required guard rails in your environment.

Enterprise Scale Analytics and AI contains custom policies pertaining to **resource and cost management, authentication, encryption, network isolation, logging, resilience and more**. An updated list of policies can be found here:

[Data service policies](https://github.com/Azure/data-management-zone/tree/main/infra/Policies/readme.md)

> [!NOTE]
> The policies provided are not applied by default during deployment. They should be viewed as guidance-only and can be applied depending on business requirements. Policies should always be applied to the highest level possible and in most cases this will be a [management group](/azure/governance/management-groups/overview). All the policies are available in our GitHub repository.
