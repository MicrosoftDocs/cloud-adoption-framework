---
title: Detail of Policies in Azure enterprise-scale for analytics and AI
description: Learn about Azure policies details in enterprise-scale for analytics and AI. Azure policies help your organization govern resources as needed.
author: marvinbuss
ms.author: mabuss
ms.date: 09/21/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Azure Policies

[Implementing custom policies](/azure/governance/policy/tutorials/create-and-manage) allows you to do more with Azure Policy. Enterprise-Scale Analytics and AI comes with a set of pre-created policies to help you implement the required guard rails in your environment.

Enterprise-Scale Analytics and AI contains custom policies pertaining to **resource and cost management, authentication, encryption, network isolation, logging, resilience and more** that apply to the following services and areas:

- [All Services](#all-services)
- [Storage](#storage)
- [Key Vault](#key-vault)
- [Azure Data Factory](#azure-data-factory)
- [Azure Synapse Analytics](#azure-synapse-analytics)
- [Azure Purview](#azure-purview)
- [Azure Databricks](#azure-databricks)
- [Azure IoT Hub](#azure-iot-hub)
- [Azure Event Hubs](#azure-event-hubs)
- [Azure Stream Analytics](#azure-stream-analytics)
- [Azure Data Explorer](#azure-data-explorer)
- [Azure Cosmos DB](#azure-cosmos-db)
- [Azure Container Registry](#azure-container-registry)
- [Azure Cognitive Services](#azure-cognitive-services)
- [Azure Machine Learning](#azure-machine-learning)
- [Azure SQL Managed Instance](#azure-sql-managed-instance)
- [Azure SQL](#azure-sql)
- [Azure Database for MariaDB](#azure-database-for-mariadb)
- [Azure Database for MySQL](#azure-database-for-mysql)
- [Azure Database for PostgreSQL](#azure-database-for-postgresql)
- [Azure Cognitive Search](#azure-cognitive-search)
- [Azure DNS](#azure-dns)
- [Network Security Group](#network-security-group)
- [Batch](#batch)
- [Azure Cache for Redis](#azure-cache-for-redis)
- [Container Instances](#container-instances)
- [Azure Firewall](#azure-firewall)
- [HDInsight](#hdinsight)
- [Power BI](#power-bi)

> [!NOTE]
> The policies provided below are not applied by default during deployment. They should be viewed as guidance-only and can be applied depending on business requirements. Policies should always be applied to the highest level possible and in most cases this will be a [management group](/azure/governance/management-groups/overview). All the policies are available in our GitHub repository.

## All Services

|Policy Name  |Policy Area  |Description  |
|---------|---------|---------|
| Deny-PublicIp|Network Isolation|Restrict deployment of public IPs.|
|Deny-PrivateEndpoint-PrivateLinkServiceConnections|Network Isolation| Deny private endpoints to resources outside of the aad tenant and subscription.|
|Deploy-DNSZoneGroup-{Service}-PrivateEndpoint|Network Isolation|Deploys the configurations of a Private DNS Zone Group by a parameter for service's private endpoint. Used to enforce the configuration to a single Private DNS Zone.|
|DiagnosticSettings-{Service}-LogAnalytics|Logging|Send diagnostic settings for cosmos db to log analytics workspace.|

## Storage

|Policy Name  |Policy Area  |Description  |
|---------|---------|---------|
|Append-Storage-Encryption|Encryption|Enforce encryption for storage accounts.|
|Deny-Storage-AllowBlobPublicAccess|Network Isolation|Enforces no public access to all blobs or containers in the storage account.|
|Deny-Storage-ContainerDeleteRetentionPolicy|Resilience|Enforce container delete retention policies larger than seven days for storage account.|
|Deny-Storage-CorsRules|Network Isolation|Deny cors rules for storage account.|
|Deny-Storage-InfrastructureEncryption|Encryption|Enforce infrastructure (double) encryption for storage accounts.|
|Deny-Storage-MinimumTlsVersion|Encryption|Enforces minimum tls version 1.2 for storage account.|
|Deny-Storage-NetworkAclsBypass|Network Isolation|Enforces network bypass to none for storage account.|
|Deny-Storage-NetworkAclsIpRules|Network Isolation|Enforces network ip rules for storage account.|
|Deny-Storage-NetworkAclsVirtualNetworkRules|Network Isolation|Denies virtual network rules for storage account.|
|Deny-Storage-Sku|Resource Management|Enforces storage account SKUs.|
|Deny-Storage-SupportsHttpsTrafficOnly|Encryption|Enforces https traffic for storage account.|
|Deploy-Storage-BlobServices|Resource Management|Deploy blob services default settings for storage account.|
|Deny-Storage-RoutingPreference|Network Isolation||
|Deny-Storage-Kind|Resource Management||
|Deny-Storage-NetworkAclsDefaultAction|Network Isolation||

## Key Vault

|Policy Name  |Policy Area  |Description  |
|---------|---------|---------|
|Audit-KeyVault-PrivateEndpointId|Network Isolation|Audit public endpoints that are created in other subscriptions for key vault.|
|Deny-KeyVault-NetworkAclsBypass|Network Isolation|Enforces bypass network level rules for key vault.|
|Deny-KeyVault-NetworkAclsDefaultAction|Network Isolation|Enforces default network acl level action for key vault.|
|Deny-KeyVault-NetworkAclsIpRules|Network Isolation|Enforces network ip rules for key vault.|
|Deny-KeyVault-NetworkAclsVirtualNetworkRules|Network Isolation|Denies virtual network rules for key vault.|
|Deny-KeyVault-PurgeProtection|Resilience|Enforces purge protection for key vault.|
|Deny-KeyVault-SoftDelete|Resilience|Enforces soft delete with minimum number of retention days for key vault.|
|Deny-KeyVault-TenantId|Resource Management|Enforce tenant ID for key vault.|

## Azure Data Factory

|Policy Name  |Policy Area  |Description  |
|---------|---------|---------|
|Append-DataFactory-IdentityType|Authentication|Enforces use of system assigned identity for data factory.|
|Deny-DataFactory-ApiVersion|Resource Management|Denies old API version for data factory V1.|
|Deny-DataFactory-IntegrationRuntimeManagedVirtualNetwork|Network Isolation|Denies Integration Runtimes that are not connected to the Managed Virtual Network.|
|Deny-DataFactory-LinkedServicesConnectionStringType|Authentication|Denies non Key Vault stored secrets for linked services.|
|Deny-DataFactory-ManagedPrivateEndpoints|Network Isolation|Denies external private endpoints for linked services.|
|Deny-DataFactory-PublicNetworkAccess|Network Isolation|Denies public access to data factory.|
|Deploy-DataFactory-ManagedVirtualNetwork|Network Isolation|Deploy managed virtual network for data factory.|
|Deploy-SelfHostedIntegrationRuntime-Sharing|Resilience|Share self-hosted integration runtime hosted in the Data Hub with Data Factories in the Data Nodes.|

## Azure Synapse Analytics

|Policy Name  |Policy Area  |Description  |
|---------|---------|---------|
|Append-Synapse-LinkedAccessCheckOnTargetResource|Network Isolation|Enforce [LinkedAccessCheckOnTargetResource](/dotnet/api/microsoft.azure.management.synapse.models.managedvirtualnetworksettings.linkedaccesscheckontargetresource) in managed vnet settings when Synapse Workspace is created.|
|Append-Synapse-Purview|Network Isolation|Enforce connection between central purview instance and Synapse Workspace.|
|Append-SynapseSpark-ComputeIsolation|Resource Management|When a Synapse Spark Pool is created without compute isolation then this will add it.|
|Append-SynapseSpark-DefaultSparkLogFolder|Logging|When a Synapse Spark Pool is created without logging then this will add it.|
|Append-SynapseSpark-SessionLevelPackages|Resource Management|When a Synapse Spark Pool is created without session level packages then this will add it.|
|Audit-Synapse-PrivateEndpointId|Network Isolation|Audit public endpoints that are created in other subscriptions for Synapse.|
|Deny-Synapse-AllowedAadTenantIdsForLinking|Network Isolation||
|Deny-Synapse-Firewall|Network Isolation|Setup firewall of Synapse.|
|Deny-Synapse-ManagedVirtualNetwork|Network Isolation|When a Synapse Workspace is created without managed virtual network then this will add it.|
|Deny-Synapse-PreventDataExfiltration|Network Isolation|Enforced prevention of data exfiltration for Synapse managed virtual network.|
|Deny-SynapsePrivateLinkHub|Network Isolation|Denies Synapse Private Link Hub.|
|Deny-SynapseSpark-AutoPause|Resource Management|Enforces auto pause for Synapse Spark Pools.|
|Deny-SynapseSpark-AutoScale|Resource Management|Enforces auto scale for Synapse Spark Pools.|
|Deny-SynapseSql-Sku|Resource Management|Denies certain Synapse Sql Pool SKUs.|
|Deploy-SynapseSql-AuditingSettings|Logging|Send auditing logs for Synapse SQL pools to log analytics.|
|Deploy-SynapseSql-MetadataSynch|Resource Management|Setup metadata sync for Synapse sql pools.|
|Deploy-SynapseSql-SecurityAlertPolicies|Logging|Deploy Synapse sql pool security alert policy.|
|Deploy-SynapseSql-TransparentDataEncryption|Encryption|Deploy Synapse SQL transparent data encryption.|
|Deploy-SynapseSql-VulnerabilityAssessment|Logging|Deploy Synapse SQL pool vulnerability assessments.|

## Azure Purview

|Policy Name  |Policy Area  |Description  |
|---------|---------|---------|
|Deny-Purview|Resource Management|Restrict deployment of Purview accounts to avoid proliferation.|

## Azure Databricks

|Policy Name  |Policy Area  |Description  |
|---------|---------|---------|
|Append-Databricks-PublicIp|Network Isolation|Enforces no public access on Databricks workspaces.|
|Deny-Databricks-Sku|Resource Management|Deny non-premium Databricks sku.|
|Deny-Databricks-VirtualNetwork|Network Isolation|Deny non-virtual network deployment for databricks.|

Additional policies that are applied in the Databricks workspace through cluster policies:

|Cluster Policy  |Policy Area  |
|---------|---------|
|Restrict Spark version|Resource Management|
|Restrict cluster size and VM types|Resource Management|
|Enforce Cost Tagging|Resource Management|
|Enforce Autoscale|Resource Management|
|Enforce AutoPause|Resource Management|
|Restrict DBUs per hour|Resource Management|
|Deny public SSH|Authentication|
|Cluster credential passthrough enabled|Authentication|
|Enable process isolation|Network Isolation|
|Enforce spark monitoring|Logging|
|Enforce cluster logs|Logging|
|Allow only SQL, python|Resource Management|
|Deny additional setup scripts|Resource Management|

## Azure IoT Hub

|Policy Name  |Policy Area  |Description  |
|---------|---------|---------|
|Append-IotHub-MinimalTlsVersion|Encryption|Enforces minimal tls version for iot hub.|
|Audit-IotHub-PrivateEndpointId|Network Isolation|Audit public endpoints that are created in other subscriptions for iot hubs.|
|Deny-IotHub-PublicNetworkAccess|Network Isolation|Denies public network access for iot hub.|
|Deny-IotHub-Sku|Resource Management|Enforces iot hub SKUs.|
|Deploy-IotHub-IoTSecuritySolutions|Security|Deploy Azure defender for IoT for IoT Hubs.|

## Azure Event Hubs

|Policy Name  |Policy Area  |Description  |
|---------|---------|---------|
|Deny-EventHub-Ipfilterrules|Network Isolation|Deny adding ip filter rules for event hub.|
|Deny-EventHub-MaximumThroughputUnits|Network Isolation|Denies public network access for my sql servers.|
|Deny-EventHub-NetworkRuleSet|Network Isolation|Enforces default virtual network rules for event hub.|
|Deny-EventHub-Sku|Resource Management|Denies certain Skus for event hubs.|
|Deny-EventHub-Virtualnetworkrules|Network Isolation|Deny adding virtual network rules for event hub.|

## Azure Stream Analytics

|Policy Name  |Policy Area  |Description  |
|---------|---------|---------|
|Append-StreamAnalytics-IdentityType|Authentication|Enforces use of system assigned identity for stream analytics.|
|Deny-StreamAnalytics-ClusterId|Resource Management|Enforces use of Stream Analytics cluster.|
|Deny-StreamAnalytics-StreamingUnits|Resource Management|Enforces number of stream analytics streaming units.|

## Azure Data Explorer

|Policy Name  |Policy Area  |Description  |
|---------|---------|---------|
|Deny-DataExplorer-DiskEncryption|Encryption|Enforces use of disk encryption for data explorer.|
|Deny-DataExplorer-DoubleEncryption|Encryption|Enforces use of double encryption for data explorer.|
|Deny-DataExplorer-Identity|Authentication|Enforces use of system or user assigned identity for data explorer.|
|Deny-DataExplorer-Sku|Resource Management|Enforces data explorer SKUs.|
|Deny-DataExplorer-TrustedExternalTenants|Network Isolation|Denies external tenants for data explorer.|
|Deny-DataExplorer-VirtualNetworkConfiguration|Network Isolation|Enforces virtual network ingestion for data explorer.|

## Azure Cosmos DB

|Policy Name  |Policy Area  |Description  |
|---------|---------|---------|
|Append-Cosmos-DenyCosmosKeyBasedMetadataWriteAccess|Authentication|Deny key based metadata write access for Cosmos DB accounts.|
|Append-Cosmos-PublicNetworkAccess|Network Isolation|Enforces no public network access for Cosmos DB accounts.|
|Audit-Cosmos-PrivateEndpointId|Network Isolation|Audit public endpoints that are created in other subscriptions for Cosmos DB.|
|Deny-Cosmos-Cors|Network Isolation|Denies CORS rules for Cosmos DB accounts."|
|Deny-Cosmos-PublicNetworkAccess|Network Isolation|Denies public network access for Cosmos DB accounts.|

## Azure Container Registry

|Policy Name  |Policy Area  |Description  |
|---------|---------|---------|
|Audit-ContainerRegistry-PrivateEndpointId|Network Isolation|Audit public endpoints that are created in other subscriptions for cognitive services.|
|Deny-ContainerRegistry-PublicNetworkAccess|Network Isolation|Denies public network access for container registry.|
|Deny-ContainerRegistry-Sku|Resource Management|Enforces premium Sku for container registry.|

## Azure Cognitive Services

|Policy Name  |Policy Area  |Description  |
|---------|---------|---------|
|Append-CognitiveServices-IdentityType|Authentication|Enforces use of system assigned identity for cognitive services.|
|Audit-CognitiveServices-PrivateEndpointId|Network Isolation|Audit public endpoints that are created in other subscriptions for cognitive services.|
|Deny-CognitiveServices-Encryption|Encryption|Enforces use of encryption for cognitive services.|
|Deny-CognitiveServices-PublicNetworkAccess|Network Isolation|Enforces no public network access for cognitive services.|
|Deny-CognitiveServices-Sku|Resource Management|Deny cognitive services free sku.|
|Deny-CognitiveServices-UserOwnedStorage|Network Isolation|Enforces user owned storage for cognitive services.|

## Azure Machine Learning

|Policy Name  |Policy Area  |Description  |
|---------|---------|---------|
|Append-MachineLearning-PublicAccessWhenBehindVnet|Network Isolation|Deny public access behind vnet for machine learning workspaces.|
|Audit-MachineLearning-PrivateEndpointId|Network Isolation|Audit public endpoints that are created in other subscriptions for machine learning.|
|Deny-MachineLearning-HbiWorkspace|Network Isolation|Enforce high business impact machine learning workspaces across the environment.|
|Deny-MachineLearningAks|Resource Management|Deny AKS creation (not attaching) in machine learning.|
|Deny-MachineLearningCompute-SubnetId|Network Isolation|Deny public IP for machine learning compute clusters and instances.|
|Deny-MachineLearningCompute-VmSize|Resource Management|Limit allowed vm sizes for machine learning compute clusters and instances.|
|Deny-MachineLearningComputeCluster-RemoteLoginPortPublicAccess|Network Isolation|Deny public access of clusters via SSH.|
|Deny-MachineLearningComputeCluster-Scale|Resource Management|Enforce scale settings for machine learning compute clusters.|

## Azure SQL Managed Instance

|Policy Name  |Policy Area  |Description  |
|---------|---------|---------|
|Append-SqlManagedInstance-MinimalTlsVersion|Encryption|Enforces minimal TLS version for SQL Managed Instance servers.|
|Deny-SqlManagedInstance-PublicDataEndpoint|Network Isolation|Denies public data endpoint for SQL Managed Instances.|
|Deny-SqlManagedInstance-Sku|Resource Management||
|Deny-SqlManagedInstance-SubnetId|Network Isolation|Enforces deployments to subnets of SQL Managed Instances.|
|Deploy-SqlManagedInstance-AzureAdOnlyAuthentications|Authentication|Enforces Azure AD only authentication for SQL Managed Instance.|
|Deploy-SqlManagedInstance-SecurityAlertPolicies|Logging|Deploy SQL Managed Instance security alert policies.|
|Deploy-SqlManagedInstance-VulnerabilityAssessment|Logging|Deploy SQL Managed Instance vulnerability assessments.|

## Azure SQL

|Policy Name  |Policy Area  |Description  |
|---------|---------|---------|
|Append-Sql-MinimalTlsVersion|Encryption|Enforces minimal TLS version for sql servers.|
|Audit-Sql-PrivateEndpointId|Network Isolation|Audit public endpoints that are created in other subscriptions for Azure SQL.|
|Deny-Sql-PublicNetworkAccess|Network Isolation|Denies public network access for sql servers.|
|Deny-Sql-StorageAccountType|Resilience|Enforces geo-redundant database backup.|
|Deploy-Sql-AuditingSettings|Logging|Deploy SQL auditing settings.|
|Deploy-Sql-AzureAdOnlyAuthentications|Authentication|Enforces Azure AD only authentication for SQL server.|
|Deploy-Sql-SecurityAlertPolicies|Logging|Deploy SQL security alert policies.|
|Deploy-Sql-TransparentDataEncryption|Encryption|Deploy SQL transparent data encryption.|
|Deploy-Sql-VulnerabilityAssessment|Logging|Deploy SQL vulnerability assessments.|
|Deploy-SqlDw-AuditingSettings|Logging|Deploy SQL DW auditing settings.|

## Azure Database for MariaDB

|Policy Name  |Policy Area  |Description  |
|---------|---------|---------|
|Append-MariaDb-MinimalTlsVersion|Encryption|Enforces minimal TLS version for MariaDB servers.|
|Audit-MariaDb-PrivateEndpointId|Network Isolation|Audit public endpoints that are created in other subscriptions for MariaDB.|
|Deny-MariaDb-PublicNetworkAccess|Network Isolation|Denies public network access for my MariaDB servers.|
|Deny-MariaDb-StorageProfile|Resilience|Enforces geo-redundant database backup with minimum retention time in days.|
|Deploy-MariaDb-SecurityAlertPolicies|Logging|Deploy SQL security alert policies for MariaDB|

## Azure Database for MySQL

|Policy Name  |Policy Area  |Description  |
|---------|---------|---------|
|Append-MySQL-MinimalTlsVersion|Encryption|Enforces minimal TLS version for MySQL servers.|
|Audit-MySql-PrivateEndpointId|Network Isolation|Audit public endpoints that are created in other subscriptions for MySQL.|
|Deny-MySQL-InfrastructureEncryption|Encryption|Enforces infrastructure encryption for MySQL servers.|
|Deny-MySQL-PublicNetworkAccess|Network Isolation|Denies public network access for MySQL servers.|
|Deny-MySql-StorageProfile|Resilience|Enforces geo-redundant database backup with minimum retention time in days.|
|Deploy-MySql-SecurityAlertPolicies|Logging|Deploy SQL security alert policies for MySQL.|

## Azure Database for PostgreSQL

|Policy Name  |Policy Area  |Description  |
|---------|---------|---------|
|Append-PostgreSQL-MinimalTlsVersion|Encryption|Enforces minimal TLS version for PostgreSQL servers.|
|Audit-PostgreSql-PrivateEndpointId|Network Isolation|Audit public endpoints that are created in other subscriptions for PostgreSQL.|
|Deny-PostgreSQL-InfrastructureEncryption|Encryption|Enforces infrastructure encryption for PostgreSQL servers.|
|Deny-PostgreSQL-PublicNetworkAccess|Network Isolation|Denies public network access for PostgreSQL servers.|
|Deny-PostgreSql-StorageProfile|Resilience|Enforces geo-redundant database backup with minimum retention time in days.|
|Deploy-PostgreSql-SecurityAlertPolicies|Logging|Deploy SQL security alert policies for PostgreSQL.|

## Azure Cognitive Search

|Policy Name  |Policy Area  |Description  |
|---------|---------|---------|
|Append-Search-IdentityType|Authentication|Enforces use of system assigned identity for Cognitive Search.|
|Audit-Search-PrivateEndpointId|Network Isolation|Audit public endpoints that are created in other subscriptions for Cognitive Search.|
|Deny-Search-PublicNetworkAccess|Network Isolation|Denies public network access for Cognitive Search.|
|Deny-Search-Sku|Resource Management|Enforces Cognitive Search SKUs.|

## Azure DNS

|Policy Name  |Policy Area  |Description  |
|---------|---------|---------|
|Deny-PrivateDnsZones|Resource Management|Restrict deployment of private DNS zones to avoid proliferation.|

## Network Security Group

|Policy Name  |Policy Area  |Description  |
|---------|---------|---------|
|Deploy-Nsg-FlowLogs|Logging|Deploy NSG flow logs and traffic analytics.|

## Batch

|Policy Name  |Policy Area  |Description  |
|---------|---------|---------|
|Deny-Batch-InboundNatPools|Network Isolation|Denies inbound NAT pools for batch account VM pools.|
|Deny-Batch-NetworkConfiguration|Network Isolation|Denies public IP addresses for batch account VM pools.|
|Deny-Batch-PublicNetworkAccess|Network Isolation|Denies public network access for batch accounts.|
|Deny-Batch-Scale|Resource Management|Denies certain scale configurations for batch account VM pools.|
|Deny-Batch-VmSize|Resource Management|Denies certain VM sizes for batch account VM pools.|

## Azure Cache for Redis

|Policy Name  |Policy Area  |Description  |
|---------|---------|---------|
|Deny-Cache-Enterprise|Resource Management|Denies Redis Cache Enterprise.|
|Deny-Cache-FirewallRules|Network Isolation|Denies firewall rules for Redis Cache.|
|Deny-Cache-MinimumTlsVersion|Encryption|Enforces minimum TLS version for Redis Cache.|
|Deny-Cache-NonSslPort|Network Isolation|Enforces turning off the non-SSL port for Redis Cache.|
|Deny-Cache-PublicNetworkAccess|Network Isolation|Enforces no public network access for Redis Cache.|
|Deny-Cache-Sku|Resource Management|Enforces certain Skus for Redis Cache.|
|Deny-Cache-VnetInjection|Network Isolation|Enforces use of private endpoints and denies vnet injection for Redis Cache.|

## Container Instances

|Policy Name  |Policy Area  |Description  |
|---------|---------|---------|
|Deny-ContainerInstance-PublicIpAddress|Network Isolation|Denies public Container Instances created from Azure Machine Learning.|

## Azure Firewall

|Policy Name  |Policy Area  |Description  |
|---------|---------|---------|
|Deny-Firewall|Resource Management|Restrict deployment of Azure Firewall to avoid proliferation.|

## HDInsight

|Policy Name  |Policy Area  |Description  |
|---------|---------|---------|
|Deny-HdInsight-EncryptionAtHost|Encryption|Enforce encryption at host for HDInsight clusters.|
|Deny-HdInsight-EncryptionInTransit|Encryption|Enforces encryption in transit for HDInsight clusters.|
|Deny-HdInsight-MinimalTlsVersion|Encryption|Enforces minimal TLS version for HDInsight clusters.|
|Deny-HdInsight-NetworkProperties|Network Isolation|Enforces private link enablement for HDInsight clusters.|
|Deny-HdInsight-Sku||Enforces certain SKU's for HDInsight clusters.|
|Deny-HdInsight-VirtualNetworkProfile|Network Isolation|Enforces virtual network injection for HDInsight clusters.|

## Power BI

|Policy Name  |Policy Area  |Description  |
|---------|---------|---------|
|Deny-PrivateLinkServicesForPowerBI|Resource Management|Restrict deployment of private link services for Power BI to avoid proliferation.|

## Next Steps

[Connecting to Environments Privately](connect-to-environments-privately.md)
