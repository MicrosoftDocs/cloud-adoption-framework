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

### All Services

|Policy  |Purpose  |Description  |
|---------|---------|---------|
| Deny-PublicIp|Network Isolation|Restrict deployment of public IPs.|
|Deny-PrivateEndpoint-PrivateLinkServiceConnections|Network Isolation| Deny private endpoints to resources outside of the aad tenant and subscription.|
|Deploy-DNSZoneGroup-{Service}-PrivateEndpoint|Network Isolation|Deploys the configurations of a Private DNS Zone Group by a parameter for service's private endpoint. Used to enforce the configuration to a single Private DNS Zone.|
|DiagnosticSettings-{Service}-LogAnalytics|Logging|Send diagnostic settings for cosmos db to log analytics workspace.|

### Storage

|Policy  |Purpose  |Description  |
|---------|---------|---------|
|Append-Storage-Encryption|Encryption|Enforce encryption for storage accounts.|
|Deny-Storage-AllowBlobPublicAccess|Network Isolation|Enforces no public access to all blobs or containers in the storage account.|
|Deny-Storage-ContainerDeleteRetentionPolicy|-|Enforce container delete retention policies larger than seven days for storage account.|
|Deny-Storage-CorsRules|Network Isolation|Deny cors rules for storage account.|
|Deny-Storage-InfrastructureEncryption|Encryption|Enforce infrastructure (double) encryption for storage accounts.|
|Deny-Storage-MinimumTlsVersion|Encryption|Enforces minimum tls version 1.2 for storage account.|
|Deny-Storage-NetworkAclsBypass|Network Isolation|Enforces network bypass to none for storage account.|
|Deny-Storage-NetworkAclsIpRules|Network Isolation|Enforces network ip rules for storage account.|
|Deny-Storage-NetworkAclsVirtualNetworkRules|Network Isolation|Denies virtual network rules for storage account.|
|Deny-Storage-Sku|SKU/Type|Enforces storage account SKUs.|
|Deny-Storage-SupportsHttpsTrafficOnly|Encryption|Enforces https traffic for storage account.|
|Deploy-Storage-BlobServices|SKU/Type|Deploy blob services default settings for storage account.|
|Deny-Storage-RoutingPreference|Network Isolation||
|Deny-Storage-Kind|SKU/Type||
|Deny-Storage-NetworkAclsDefaultAction|Network Isolation||

### Key Vault

|Policy  |Purpose  |Description  |
|---------|---------|---------|
|Audit-KeyVault-PrivateEndpointId|Network Isolation|Audit public endpoints that are created in other subscriptions for key vault.|
|Deny-KeyVault-NetworkAclsBypass|Network Isolation|Enforces bypass network level rules for key vault.|
|Deny-KeyVault-NetworkAclsDefaultAction|Network Isolation|Enforces default network acl level action for key vault.|
|Deny-KeyVault-NetworkAclsIpRules|Network Isolation|Enforces network ip rules for key vault.|
|Deny-KeyVault-NetworkAclsVirtualNetworkRules|Network Isolation|Denies virtual network rules for key vault.|
|Deny-KeyVault-PurgeProtection|-|Enforces purge protection for key vault.|
|Deny-KeyVault-SoftDelete|-|Enforces soft delete with minimum number of retention days for key vault.|
|Deny-KeyVault-TenantId|-|Enforce tenant id for key vault.|

### Azure Data Factory

|Policy  |Purpose  |Description  |
|---------|---------|---------|
|Append-DataFactory-IdentityType|Authentication|Enforces use of system assigned identity for data factory.|
|Deny-DataFactory-ApiVersion|SKU/Type|Denies old API version for data factory V1.|
|Deny-DataFactory-IntegrationRuntimeManagedVirtualNetwork|Network Isolation|Denies Integration Runtimes that are not connected to the Managed Virtual Network.|
|Deny-DataFactory-LinkedServicesConnectionStringType|Authentication|Denies non Key Vault stored screts for linked services.|
|Deny-DataFactory-ManagedPrivateEndpoints|Network Isolation|Denies external private endpoints for linked services.|
|Deny-DataFactory-PublicNetworkAccess|Network Isolation|Denies public access to data factory.|
|Deploy-DataFactory-ManagedVirtualNetwork|Network Isolation|Deploy managed virtualnetwork for data factory.|
|Deploy-SelfHostedIntegrationRuntime-Sharing|-|Share self-hosted integration runtime hosted in the Data Hub with Data Factories in teh Data Nodes.|

### Azure Synapse Analytics

|Policy  |Purpose  |Description  |
|---------|---------|---------|
|Append-Synapse-LinkedAccessCheckOnTargetResource|-|Enforce LinkedAccessCheckOnTargetResource in managed vnet settings when Synapse Workspace is created.|
|Append-Synapse-Purview|-|Enforce connection between central purview instance and Synapse Workspace.|
|Append-SynapseSpark-ComputeIsolation|Network Isolation|When a Synapse Spark Pool is created without compute isolation then this will add it.|
|Append-SynapseSpark-DefaultSparkLogFolder|Logging|When a Synapse Spark Pool is created without logging then this will add it.|
|Append-SynapseSpark-SessionLevelPackages|-|When a Synapse Spark Pool is created without session level packages then this will add it.|
|Audit-Synapse-PrivateEndpointId|-|Audit public endpoints that are created in other subscriptions for synapse.|
|Deny-Synapse-AllowedAadTenantIdsForLinking|Network Isolation||
|Deny-Synapse-Firewall|Network Isolation|Setup firewall of Synapse.|
|Deny-Synapse-ManagedVirtualNetwork|Network Isolation|When a Synapse Workspace is created without managed virtual network then this will add it.|
|Deny-Synapse-PreventDataExfiltration|Network Isolation|Enforced prevention of data exfiltration for Synapse managed virtual network.|
|Deny-SynapsePrivateLinkHub|Network Isolation|Denies Synapse Private Link Hub.|
|Deny-SynapseSpark-AutoPause|SKU/Type|Enforces autopause for Synapse Spark Pools.|
|Deny-SynapseSpark-AutoScale|SKU/Type|Enforces autoscale for Synapse Spark Pools.|
|Deny-SynapseSql-Sku|SKU/Type|Denies certain Synapse Sql Pool Sku's.|
|Deploy-SynapseSql-AuditingSettings|Logging|Send auditing logs for Synapse SQL pools to log analytics.|
|Deploy-SynapseSql-MetadataSynch|-|Setup metadata sync for Synapse sql pools.|
|Deploy-SynapseSql-SecurityAlertPolicies|Logging|Deploy Synapse sql pool security alert policy.|
|Deploy-SynapseSql-TransparentDataEncryption|Encryption|Deploy Synapse SQL transparent data encryption.|
|Deploy-SynapseSql-VulnerabilityAssessment|Logging|Deploy Synapse SQL pool vulnerability assessments.|

### Azure Purview

|Policy  |Purpose  |Description  |
|---------|---------|---------|
|Deny-Purview|SKU/Type|Restrict deployment of Purview accounts to avoid proliferation.|

### Databricks

|Policy  |Purpose  |Description  |
|---------|---------|---------|
|Append-Databricks-PublicIp|Network Isolation|Enforces no public access on Databricks workspaces.|
|Deny-Databricks-Sku|SKU/Type|Deny non-premium Databricks sku.|
|Deny-Databricks-VirtualNetwork|Network Isolation|Deny non-virtual network deployment for databricks.|

Additional policies that are applied through Databricks cluster policies:

- Restrict spark version
- Restrict cluster size and VM types
- Enforce Cost Tagging
- Enforce Autoscale
- Enforce AutoPause
- Restrict DBUs per hour
- Deny public SSH
- Cluster credential passthrough enabled
- Enable process isolation
- Enforce spark monitoring
- Enforce cluster logs
- Allow only SQL, python
- Deny additional setup scripts

### IoT Hub

|Policy  |Purpose  |Description  |
|---------|---------|---------|
||||
||||
||||
||||
||||

### EventHub

|Policy  |Purpose  |Description  |
|---------|---------|---------|
||||
||||
||||
||||
||||
||||
||||
||||

### Stream Analytics

|Policy  |Purpose  |Description  |
|---------|---------|---------|
||||
||||
||||
||||
||||
||||
||||
||||

### Data Explorer

|Policy  |Purpose  |Description  |
|---------|---------|---------|
||||
||||
||||
||||
||||
||||
||||
||||

### Cosmos DB

|Policy  |Purpose  |Description  |
|---------|---------|---------|
||||
||||
||||
||||
||||
||||
||||
||||

### ACR

|Policy  |Purpose  |Description  |
|---------|---------|---------|
||||
||||
||||
||||
||||
||||
||||
||||

### Cognitive Services

|Policy  |Purpose  |Description  |
|---------|---------|---------|
||||
||||
||||
||||
||||
||||
||||
||||

### Machine Learning

|Policy  |Purpose  |Description  |
|---------|---------|---------|
||||
||||
||||
||||
||||
||||
||||
||||

### SQL Managed Instance

|Policy  |Purpose  |Description  |
|---------|---------|---------|
||||
||||
||||
||||
||||
||||
||||
||||

### SQL

|Policy  |Purpose  |Description  |
|---------|---------|---------|
||||
||||
||||
||||
||||
||||
||||
||||

### MariaDB

|Policy  |Purpose  |Description  |
|---------|---------|---------|
||||
||||
||||
||||
||||
||||
||||
||||

### MySQL

|Policy  |Purpose  |Description  |
|---------|---------|---------|
||||
||||
||||
||||
||||
||||
||||
||||

### Postgres

|Policy  |Purpose  |Description  |
|---------|---------|---------|
||||
||||
||||
||||
||||
||||
||||
||||

### Search

|Policy  |Purpose  |Description  |
|---------|---------|---------|
||||
||||
||||
||||
||||
||||
||||
||||

### DNS

|Policy  |Purpose  |Description  |
|---------|---------|---------|
||||
||||
||||
||||
||||
||||
||||
||||

### NSG

|Policy  |Purpose  |Description  |
|---------|---------|---------|
||||
||||
||||
||||
||||
||||
||||
||||

### Batch

|Policy  |Purpose  |Description  |
|---------|---------|---------|
||||
||||
||||
||||
||||
||||
||||
||||

### Redis Cache

|Policy  |Purpose  |Description  |
|---------|---------|---------|
||||
||||
||||
||||
||||
||||
||||
||||

### Container Instance

|Policy  |Purpose  |Description  |
|---------|---------|---------|
||||
||||
||||
||||
||||
||||
||||
||||

### Firewall

|Policy  |Purpose  |Description  |
|---------|---------|---------|
||||
||||
||||
||||
||||
||||
||||
||||

### HDInsight

|Policy  |Purpose  |Description  |
|---------|---------|---------|
||||
||||
||||
||||
||||
||||
||||
||||

### PrivateLinkServicesForPowerBI

|Policy  |Purpose  |Description  |
|---------|---------|---------|
||||
||||
||||
||||
||||
||||
||||
||||

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