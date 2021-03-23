---
title: "Policies and Cost Management"
description: Policies and Cost Management in Enterprise Scale Analytics and AI
author: abdale
ms.author: hamoodaleem
ms.date: 03/19/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Policies and Cost Management

Before considering a deployment, it is important for your organization to decide upon the guard rails that you wish to put in place. By using [Azure Policies](/azure/governance/policy/overview), you can implement governance for resource consistency, regulatory compliance, security, cost, and management.

## Background

A core principle of the Enterprise Scale Analytics and AI solution pattern is to enable agility by making it easy to create, read, update, and delete resources as needed. However, while giving unrestricted resource access to developers can make them very agile, it can also lead to unintended cost consequences. The solution to this problem is resource access governance, which is the ongoing process of managing, monitoring, and auditing the use of Azure resources to meet the goals and requirements of your organization.

The [Enterprise-Scale Architecture](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/enterprise-scale/) already uses this concept, and Enterprise Scale Analytics and AI solution pattern builds upon these standards by adding [additional Azure Policies](#azure-policies-for-enterprise-scale-analytics-and-ai) which are applied to our Data Management Landing Zone and Data Landing Zones.

![How Azure Governance works](./images/azure_governance.png)

*Figure 1: How Azure Governance Works*

> [!IMPORTANT]
> Azure Policy is essential to ensuring security and compliance within Enterprise Scale Analytics and AI. It helps to enforce standards and to assess compliance at-scale. Policies can be used to evaluate resources in Azure and compare them to the desired properties. Several policies (business rules) can be grouped into an initiative. Individual policies or initiatives can be assigned to different scopes in Azure, such as management groups, subscriptions, resource groups, or individual resources. The assignment applies to all resources within the scope, and sub-scopes can be excluded with exceptions if necessary.

## Design considerations

Azure policies in Enterprise Scale Analytics And AI were developed with the following design considerations in mind:

- Azure Policy are used to implement governance and enforce rules for resource consistency, regulatory compliance, security, cost, and management. Pre-built policies which are available should be used to save time.
- Policies are assigned to the highest level possible in the management group tree to simplify the management of policies.
- The number of Azure Policy assignments made at the root management group scope are limited to avoid managing through exclusions at inherited scopes.
- Policy exceptions are only be used if required and should require global admin approval.

## Azure Policies for Enterprise Scale Analytics and AI

Following are the Azure policies associated with Enterprise Scale Analytics and AI:

### All

|Policy Name  |Purpose  |Description  |
|---------|---------|---------|
| Deny-PublicIp|Network Isolation|Restrict deployment of public IPs.|
|Deny-PrivateEndpoint-PrivateLinkServiceConnections|Network Isolation| Deny private endpoints to resources outside of the aad tenant and subscription.|
|Row4     |         |         |
|Row5     |         |         |

### Storage

|Policy Name  |Purpose  |Description  |
|---------|---------|---------|
|Append-Storage-Encryption | Encryption |Enforce encryption for storage accounts. |
|Row2     |         |         |
|Row3     |         |         |
|Row4     |         |         |
|Row5     |         |         |

### Key Vault
### Data Factory
### Synapse

### Purview
### Databricks
### Log Analytics
### IoTHub
### EventHub
### Stream Analytics
### Data Explorer
### Cosmos DB
### ACR
### Cognitive Services
### Machine Learning
### SQL Managed Instance
### SQL
### MariaDB
### MySQL
### Postgres
### Search
### DNS
### NSG
### Batch
### Redis Cache
### Container Instance
### Firewall
### HDInsight
### PrivateLinkServicesForPowerBI

## Cost Management

Cost transparency across a technical estate is a critical management challenge faced by every large enterprise organization. Different principles should be followed to reduce, optimize, and allocate cost between organizations.

A well-planned organizational structure for your Azure billing and resource hierarchies helps to give you a good understanding and control over costs as you create your Enterprise Scale Analytics and AI solution.

We recommend checking that your enterprise is aligned to the Cloud Adoption Framework methodology for [Managing Cloud Costs](https://docs.microsoft.com/azure/cloud-adoption-framework/get-started/manage-costs).

You should use Azure Policy to set and track ARM tagging policies. For example, we could require that all of Azure resources are created with the following tags:

* Finance codes - CostCenter tag, etc.
* Application context - AppService tag, etc.
* Deployment context - Environment tag, etc.
* Who is accountable - BusinessOwner tag, etc.

![Example of Tagging in Azure](./images/azure_tagging.png)

*Figure 2: Example of Tagging in Azure*

Resource tags should be used for cost categorization and resource grouping. This model allows a chargeback mechanism for workloads that share a Data Landing Zone or for workloads that span across Data Landing Zones. Resource tags should be enforced and appended through Azure Policy to query and horizontally navigate across the management group hierarchy.

Azure cost management should be used at the first level of aggregation and should be made available to data landing zone owners.

>[!TIP]
>Azure Advisor should be used to implement cost optimization recommendations.

>[!NOTE]
>Regulatory and compliance requirements definitions and Azure RBAC role assignments.