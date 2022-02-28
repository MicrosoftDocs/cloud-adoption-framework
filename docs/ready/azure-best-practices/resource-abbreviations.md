---
title: Recommended abbreviations for Azure resource types
description: Review recommended abbreviations to use for various Azure resource types when naming your resources and assets.
author: BrianBlanchard
ms.author: brblanch
ms.date: 4/14/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal, readiness, fasttrack-edit
---

# Recommended abbreviations for Azure resource types

Azure workloads are typically composed of multiple resources and services. Including a naming component in your resource names that represents the type of the Azure resource makes it easier to visually recognize application or service components.

This list provides recommended abbreviations for various Azure resource types to include in your naming conventions. These abbreviations are often used as prefixes in resource names, so each abbreviation is shown below followed by a hyphen (-), except for resource types that disallow hyphens in the resource name. Your naming convention might place the resource type abbreviation in a different location of the name if it's more suitable for your organization's needs.

<!-- cSpell:ignoreRegExp [a-z]+-? -->

## Resource list

| Asset type | Resource provider namespace/Entity | Abbreviation |  
|--|--|--|
| `Analysis Services Server`| `Microsoft.AnalysisServices/servers` | `assvr` |
| `API Management`| `Microsoft.ApiManagement/service` | `apims` |
| `API Management API`| `Microsoft.ApiManagement/service/apis` | `apis` |
| `API Management API Issue`| `Microsoft.ApiManagement/service/apis/issues` | `apii` |
| `API Management API Issue Attachment`| `Microsoft.ApiManagement/service/apis/issues/attachments` | `apiia` |
| `API Management API Issue Comment`| `Microsoft.ApiManagement/service/apis/issues/comments` | `apiic` |
| `API Management API Operation`| `Microsoft.ApiManagement/service/apis/operations` | `apio` |
| `API Management API Operation Tag`| `Microsoft.ApiManagement/service/apis/operations/tags` | `apiot` |
| `API Management API Release`| `Microsoft.ApiManagement/service/apis/releases` | `apir` |
| `API Management API Schema`| `Microsoft.ApiManagement/service/apis/schemas` | `apis` |
| `API Management API Tag Description`| `Microsoft.ApiManagement/service/apis/tagDescriptions` | `apitd` |
| `API Management API Tag`| `Microsoft.ApiManagement/service/apis/tags` | `apitg` |
| `API Management API Version Set`| `Microsoft.ApiManagement/service/api-version-sets` | `apivs` |
| `API Management Authorization Server`| `Microsoft.ApiManagement/service/authorizationServers` | `apias` |
| `API Management Backend`| `Microsoft.ApiManagement/service/backends` | `apib` |
| `API Management Certificate`| `Microsoft.ApiManagement/service/certificates` | `apic` |
| `API Management Diagnostic`| `Microsoft.ApiManagement/service/diagnostics` | `apid` |
| `API Management Group`| `Microsoft.ApiManagement/service/groups` | `apig` |
| `API Management User`| `Microsoft.ApiManagement/service/groups/users` | `apigu` |
| `API Management Identity Provider`| `Microsoft.ApiManagement/service/identityProviders` | `apiip` |
| `API Management Logger`| `Microsoft.ApiManagement/service/loggers` | `apil` |
| `API Management Notification`| `Microsoft.ApiManagement/service/notifications` | `apin` |
| `API Management Recipient Email`| `Microsoft.ApiManagement/service/notifications/recipientEmails` | `recem` |
| `API Management OpenID Connect Provider`| `Microsoft.ApiManagement/service/openidConnectProviders` | `apioi` |
| `API Management Policy`| `Microsoft.ApiManagement/service/policies` | `apipo` |
| `API Management Product`| `Microsoft.ApiManagement/service/products` | `apipr` |
| `API Management Product API`| `Microsoft.ApiManagement/service/products/apis` | `api` |
| `API Management Product Group`| `Microsoft.ApiManagement/service/products/groups` | `grp` |
| `API Management Product Tag`| `Microsoft.ApiManagement/service/products/tags` | `tags` |
| `API Management Property`| `Microsoft.ApiManagement/service/properties` | `prop` |
| `API Management Subscription`| `Microsoft.ApiManagement/service/subscriptions` | `sub` |
| `API Management Tag`| `Microsoft.ApiManagement/service/tags` | `tags` |
| `API Management Template`| `Microsoft.ApiManagement/service/templates` | `temp` |
| `API Management User`| `Microsoft.ApiManagement/service/users` | `user` |
| `App Configuration - Configuration Store`| `Microsoft.AppConfiguration/configurationStores` | `accs` |
| `Lock`| `Microsoft.Authorization/locks` | `lock` |
| `Policy Assignment`| `Microsoft.Authorization/policyAssignments` | `pa` |
| `Policy Definition`| `Microsoft.Authorization/policyDefinitions` | `pd` |
| `Policy Set Definition`| `Microsoft.Authorization/policySetDefinitions` | `psd` |
| `Automation Account`| `Microsoft.Automation/automationAccounts` | `aa` |
| `Automation Account Certificate`| `Microsoft.Automation/automationAccounts/certificates` | `cert` |
| `Automation Account Connection`| `Microsoft.Automation/automationAccounts/connections` | `conn` |
| `Automation Account Credential`| `Microsoft.Automation/automationAccounts/credentials` | `cred` |
| `Automation Account Runbook`| `Microsoft.Automation/automationAccounts/runbooks` | `runbk` |
| `Automation Account Schedule`| `Microsoft.Automation/automationAccounts/schedules` | `sched` |
| `Automation Account Variable`| `Microsoft.Automation/automationAccounts/variables` | `var` |
| `Automation Account Watcher`| `Microsoft.Automation/automationAccounts/watchers` | `watch` |
| `Automation Account Webhook`| `Microsoft.Automation/automationAccounts/webhooks` | `wbhk` |
| `Batch Account`| `Microsoft.Batch/batchAccounts` | `ba` |
| `Batch Account Application`| `Microsoft.Batch/batchAccounts/applications` | `appl` |
| `Batch Account Certificate`| `Microsoft.Batch/batchAccounts/certificates` | `cert` |
| `Batch Account Pool`| `Microsoft.Batch/batchAccounts/pools` | `pool` |
| `Blockchain Member`| `Microsoft.Blockchain/blockchainMembers` | `blchm` |
| `Blueprint Assignment`| `Microsoft.Blueprint/blueprintAssignments` | `bpas` |
| `Blueprint`| `Microsoft.Blueprint/blueprints` | `bp` |
| `Blueprint Artifact`| `Microsoft.Blueprint/blueprints/artifacts` | `bpa` |
| `Blueprint Version`| `Microsoft.Blueprint/blueprints/versions` | `bpv` |
| `Bot Service`| `Microsoft.BotService/botServices` | `botsvc` |
| `Bot Service Channel`| `Microsoft.BotService/botServices/channels` | `chan` |
| `Bot Service Connection`| `Microsoft.BotService/botServices/Connections` | `conn` |
| `Bot Service Enterprise Channel`| `Microsoft.BotService/enterpriseChannels` | `botec` |
| `Redis Cache`| `Microsoft.Cache/Redis` | `redis` |
| `Redis Cache Firewall Rule`| `Microsoft.Cache/Redis/firewallRules` | `rule` |
| `CDN Profile`| `Microsoft.Cdn/profiles` | `cdnp` |
| `CDN Profile Endpoint`| `Microsoft.Cdn/profiles/endpoints` | `cdnep` |
| `Certificate Registration Order`| `Microsoft.CertificateRegistration/certificateOrders` | `cerco` |
| `Cognitive Services Account`| `Microsoft.CognitiveServices/accounts` | `coga` |
| `Availability Set`| `Microsoft.Compute/availabilitySets` | `avset` |
| `Cloud Service`| `Microsoft.Compute/cloudServices` | `cldsvc` |
| `Disk Encryption Set`| `Microsoft.Compute/diskEncryptionSets` | `dskes` |
| `Disk`| `Microsoft.Compute/disks` | `dsk` |
| `Disk`| `Microsoft.Compute/disks` | `osdsk` |
| `Compute Gallery`| `Microsoft.Compute/galleries` | `gal` |
| `Compute Gallery Application`| `Microsoft.Compute/galleries/applications` | `app` |
| `Compute Gallery Image`| `Microsoft.Compute/galleries/images` | `gimg` |
| `Image`| `Microsoft.Compute/images` | `img` |
| `Snapshot`| `Microsoft.Compute/snapshots` | `snap` |
| `Virtual Machine (Windows)`| `Microsoft.Compute/virtualMachines` | `vm` |
| `Virtual Machine Scale Set (Windows)`| `Microsoft.Compute/virtualMachineScaleSets` | `vmss` |
| `Container Instance Group`| `Microsoft.ContainerInstance/containerGroups` | `congp` |
| `Container Registry`| `Microsoft.ContainerRegistry/registries` | `conrg` |
| `Container Registry Build Task`| `Microsoft.ContainerRegistry/registries/buildTasks` | `btsks` |
| `Container Registry Build Task Step`| `Microsoft.ContainerRegistry/registries/buildTasks/steps` | `steps` |
| `Container Registry Replication`| `Microsoft.ContainerRegistry/registries/replications` | `rep` |
| `Container Registry Scope Map`| `Microsoft.ContainerRegistry/registries/scopeMaps` | `scmap` |
| `Container Registry Task`| `Microsoft.ContainerRegistry/registries/tasks` | `tasks` |
| `Container Registry Token`| `Microsoft.ContainerRegistry/registries/tokens` | `tokn` |
| `Container Registry Webhook`| `Microsoft.ContainerRegistry/registries/webhooks` | `webhk` |
| `Container Service Managed Cluster`| `Microsoft.ContainerService/managedClusters` | `aks` |
| `Container Service Open Shift Managed Cluster`| `Microsoft.ContainerServiceopenShiftManagedClusters` | `osmc` |
| `Customer Insight`| `Microsoft.CustomerInsights/hubs` | `cihub` |
| `Customer Insight Authorization Policy`| `Microsoft.CustomerInsights/hubs/authorizationPolicies` | `authp` |
| `Customer Insight Connector`| `Microsoft.CustomerInsights/hubs/connectors` | `conn` |
| `Customer Insight Connector Mapping`| `Microsoft.CustomerInsights/hubs/connectors/mappings` | `map` |
| `Customer Insight Interaction`| `Microsoft.CustomerInsights/hubs/interactions` | `int` |
| `Customer Insight KPI`| `Microsoft.CustomerInsights/hubs/kpi` | `kpi` |
| `Customer Insight Link`| `Microsoft.CustomerInsights/hubs/links` | `link` |
| `Customer Insight Prediction`| `Microsoft.CustomerInsights/hubs/predictions` | `pred` |
| `Customer Insight Profile`| `Microsoft.CustomerInsights/hubs/profiles` | `prof` |
| `Customer Insight Relationship Link`| `Microsoft.CustomerInsights/hubs/relationshipLinks` | `rlink` |
| `Customer Insight Relationship`| `Microsoft.CustomerInsights/hubs/relationships` | `rel` |
| `Customer Insight Role Assignment`| `Microsoft.CustomerInsights/hubs/roleAssignments` | `role` |
| `Customer Insight View`| `Microsoft.CustomerInsights/hubs/views` | `views` |
| `Custom Provider Association`| `Microsoft.CustomProviders/associations` | `cpass` |
| `Custom Provider Resource Provider`| `Microsoft.CustomProviders/resourceProviders` | `cprep` |
| `Data Box Job`| `Microsoft.DataBox/jobs` | `dbjob` |
| `Databricks Workspae`| `Microsoft.Databricks/workspaces` | `dbws` |
| `Data Factory`| `Microsoft.DataFactory/factories` | `adf` |
| `Data Factory Data Flow`| `Microsoft.DataFactory/factories/dataflows` | `flows` |
| `Data Factory Data Set`| `Microsoft.DataFactory/factories/datasets` | `dsets` |
| `Data Factory Integration Runtime`| `Microsoft.DataFactory/factories/integrationRuntimes` | `run` |
| `Data Factory Linked Service`| `Microsoft.DataFactory/factories/linkedservices` | `lksvc` |
| `Data Factory Pipeline`| `Microsoft.DataFactory/factories/pipelines` | `pipe` |
| `Data Factory Trigger`| `Microsoft.DataFactory/factories/triggers` | `trig` |
| `Data Factory Rerun Trigger`| `Microsoft.DataFactory/factories/triggers/rerunTriggers` | `rerun` |
| `Data Lake Analytics Account`| `Microsoft.DataLakeAnalytics/accounts` | `dlaac` |
| `Data Lake Analytics Compute Policy`| `Microsoft.DataLakeAnalytics/accounts/computePolicies` | `cmpol` |
| `Data Lake Analytics Store Account`| `Microsoft.DataLakeAnalytics/accounts/dataLakeStoreAccounts` | `dlsta` |
| `Data Lake Analytics Firewall Rule`| `Microsoft.DataLakeAnalytics/accounts/firewallRules` | `fwrul` |
| `Data Lake Analytics Storage Account`| `Microsoft.DataLakeAnalytics/accounts/storageAccounts` | `sa` |
| `Data Lake Store Account`| `Microsoft.DataLakeStore/accounts` | `dlsa` |
| `Data Lake Store Firewall Rule`| `Microsoft.DataLakeStore/accounts/firewallRules` | `frule` |
| `Data Lake Store Virtual Network Rule`| `Microsoft.DataLakeStore/accounts/virtualNetworkRules` | `vrule` |
| `Data Migration`| `Microsoft.DataMigration/services` | `dms` |
| `Data Migration Project`| `Microsoft.DataMigration/services/projects` | `proj` |
| `DB for Maria DB Server`| `Microsoft.DBforMariaDB/servers` | `mdbsv` |
| `DB for Maria DB Database`| `Microsoft.DBforMariaDB/servers/databases` | `mdbdb` |
| `DB for Maria DB Firewall Rule`| `Microsoft.DBforMariaDB/servers/firewallRules` | `fwrul` |
| `DB for Maria DB Virtual Network Rule`| `Microsoft.DBforMariaDB/servers/virtualNetworkRules` | `vnetr` |
| `DB for MySQL Server`| `Microsoft.DBforMySQL/servers` | `mysql` |
| `DB for MySQL Database`| `Microsoft.DBforMySQL/servers/databases` | `db` |
| `DB for MySQL Firewall Rule`| `Microsoft.DBforMySQL/servers/firewallRules` | `frule` |
| `DB for MySQL Virtual Network Rule`| `Microsoft.DBforMySQL/servers/virtualNetworkRules` | `vrule` |
| `DB for Postgre SQL Server`| `Microsoft.DBforPostgreSQL/servers` | `psql` |
| `DB for Postgre SQL Database`| `Microsoft.DBforPostgreSQL/servers/databases` | `db` |
| `DB for Postgre SQL Firewall Rule`| `Microsoft.DBforPostgreSQL/servers/firewallRules` | `fwrul` |
| `DB for Postgre SQL Virtual Network Rule`| `Microsoft.DBforPostgreSQL/servers/virtualNetworkRules` | `vnetr` |
| `IoT Hub`| `Microsoft.Devices/IotHubs` | `iot` |
| `IoT Hub Certificate`| `Microsoft.Devices/IotHubs/certificates` | `cert` |
| `IoT Hub Consumer Group`| `Microsoft.Devices/IotHubs/eventHubEndpoints/ConsumerGroups` | `congp` |
| `Device Provisioning Service`| `Microsoft.Devices/provisioningServices` | `provs` |
| `Device Provisioning Service Certificate`| `Microsoft.Devices/provisioningServices/certificates` | `cert` |
| `Dev Test Lab`| `Microsoft.DevTestLab/labs` | `dtlab` |
| `Dev Test Lab Custom Image`| `Microsoft.DevTestLab/labs/customimages` | `img` |
| `Dev Test Lab Formula`| `Microsoft.DevTestLab/labs/formulas` | `form` |
| `Dev Test Lab Virtual Machine (Windows)`| `Microsoft.DevTestLab/labs/virtualmachines` | `vm` |
| `Document DB Account`| `Microsoft.DocumentDB/databaseAccounts` | `dbact` |
| `Document DB SQL Database`| `Microsoft.DocumentDB/databaseAccounts/sqlDatabases` | `cosdb` |
| `Event Grid Domain`| `Microsoft.EventGrid/domains` | `evgd` |
| `Event Grid Domain Topic`| `Microsoft.EventGrid/domains/topics` | `egdt` |
| `Event Grid Event Subscription`| `Microsoft.EventGrid/eventSubscriptions` | `egesu` |
| `Event Grid Topic`| `Microsoft.EventGrid/topics` | `egtp` |
| `Event Hub Cluster`| `Microsoft.EventHub/clusters` | `evhcl` |
| `Event Hub Namespace`| `Microsoft.EventHub/namespaces` | `evhns` |
| `Event Hub Namespace Authorization Rule`| `Microsoft.EventHub/namespaces/AuthorizationRules` | `rule` |
| `Event Hub Namespace Disaster Recovery Config`| `Microsoft.EventHub/namespaces/disasterRecoveryConfigs` | `drcfg` |
| `Event Hub Namespace Event Hub`| `Microsoft.EventHub/namespaces/eventhubs` | `evh` |
| `Event Hub Namespace Event Hub Authorization Rule`| `Microsoft.EventHub/namespaces/eventhubs/authorizationRules` | `rule` |
| `Event Hub Namespace Event Hub Consumer Group`| `Microsoft.EventHub/namespaces/eventhubs/consumergroups` | `cgrp` |
| `HD Insight Cluster (Hadoop)`| `Microsoft.HDInsight/clusters` | `hadoop` |
| `HD Insight Cluster (HBase)`| `Microsoft.HDInsight/clusters` | `hbase` |
| `HD Insight Cluster (Kafka)`| `Microsoft.HDInsight/clusters` | `kafka` |
| `HD Insight Cluster (Spark)`| `Microsoft.HDInsight/clusters` | `mls` |
| `HD Insight Cluster (Storm)`| `Microsoft.HDInsight/clusters` | `spark` |
| `HD Insight Cluster (ML Services)`| `Microsoft.HDInsight/clusters` | `storm` |
| `Hybrid Compute Machine`| `Microsoft.HybridCompute/machines` | `arcm` |
| `Import Export Job`| `Microsoft.ImportExport/jobs` | `iejob` |
| `Insights Action Group`| `Microsoft.Insights/actionGroups` | `inag` |
| `Insignts Activity Log Alert`| `Microsoft.Insights/activityLogAlerts` | `inala` |
| `Insights Component`| `Microsoft.Insights/components` | `incom` |
| `Insights Metric Alert`| `Microsoft.Insights/metricAlerts` | `inma` |
| `Insights Scheduled Query Rules`| `Microsoft.Insights/scheduledQueryRules` | `insqr` |
| `IoT Central Application`| `Microsoft.IoTCentral/IoTApps` | `iotapp` |
| `Key Vault`| `Microsoft.KeyVault/vaults` | `kv` |
| `Key Vault Secret`| `Microsoft.KeyVault/vaults/secrets` | `kvs` |
| `Kubernetes Connected Cluster`| `Microsoft.Kubernetes/connectedClusters` | `kubcc` |
| `Kusto Cluster`| `Microsoft.Kusto/clusters` | `kucl` |
| `Kusto Database`| `Microsoft.Kusto/clusters/databases` | `kcdb` |
| `Kusto Data Connection`| `Microsoft.Kusto/clusters/databases/dataConnections` | `dcon` |
| `Kusto Event Hub Connection`| `Microsoft.Kusto/clusters/databases/eventhubconnections` | `ehcon` |
| `Logic Integration Account`| `Microsoft.Logic/integrationAccounts` | `liact` |
| `Logic Assembly`| `Microsoft.Logic/integrationAccounts/assemblies` | `assem` |
| `Logic Batch Configuration`| `Microsoft.Logic/integrationAccounts/batchConfigurations` | `bconf` |
| `Logic Certificate`| `Microsoft.Logic/integrationAccounts/certificates` | `cert` |
| `Logic Map`| `Microsoft.Logic/integrationAccounts/maps` | `map` |
| `Logic Partner`| `Microsoft.Logic/integrationAccounts/partners` | `part` |
| `Logic Rosetta Net Process Configuration`| `Microsoft.Logic/integrationAccounts/rosettanetprocessconfigurations` | `rpcnf` |
| `Logic Schema`| `Microsoft.Logic/integrationAccounts/schemas` | `schem` |
| `Logic Session`| `Microsoft.Logic/integrationAccounts/sessions` | `sess` |
| `Logic Integration Service Environment`| `Microsoft.Logic/integrationServiceEnvironments` | `lise` |
| `Logic Integration Service Environment Managed API`| `Microsoft.Logic/integrationServiceEnvironments/managedApis` | `mapis` |
| `Logic Workflow`| `Microsoft.Logic/workflows` | `lwf` |
| `Machine Learning Commiment Plan`| `Microsoft.MachineLearning/commitmentPlans` | `mlcp` |
| `Machine Learning Web Service`| `Microsoft.MachineLearning/webServices` | `mlweb` |
| `Machine Learning Workspace`| `Microsoft.MachineLearning/workspaces` | `mlws` |
| `Machine Learning Service Workspace`| `Microsoft.MachineLearningServices/workspaces` | `mlsw` |
| `Machine Learning Service Workspace Compute`| `Microsoft.MachineLearningServices/workspaces/computes` | `mlswc` |
| `User Assigned Managed Identity`| `Microsoft.ManagedIdentity/userAssignedIdentities` | `miuai` |
| `Management Group`| `Microsoft.Management/managementGroups` | `mg` |
| `Map Account`| `Microsoft.Maps/accounts` | `macc` |
| `Media Service`| `Microsoft.Media/mediaservices` | `mms` |
| `Media Service Live Event`| `Microsoft.Media/mediaservices/liveEvents` | `lievt` |
| `Media Service Live Event Live Output`| `Microsoft.Media/mediaservices/liveEvents/liveOutputs` | `liout` |
| `Media Service Streaming Endpoint`| `Microsoft.Media/mediaservices/streamingEndpoints` | `strep` |
| `Migrate Assesment Project`| `Microsoft.Migrate/assessmentProjects` | `migap` |
| `Application Gateway`| `Microsoft.Network/applicationGateways` | `agw` |
| `Application Security Group`| `Microsoft.Network/applicationSecurityGroups` | `asg` |
| `Azure Firewall`| `Microsoft.Network/azureFirewalls` | `afw` |
| `Bastion`| `Microsoft.Network/bastionHosts` | `bst` |
| `Connection`| `Microsoft.Network/connections` | `conn` |
| `Express Route Circuit`| `Microsoft.Network/expressRouteCircuits` | `exrc` |
| `Express Route Gateways` | `Microsoft.Network/expressRouteGateways` | `exrgw` |
| `Firewall Policy`| `Microsoft.Network/firewallPolicies` | `waf` |
| `Firewall Policy Rule Group`| `Microsoft.Network/firewallPolicies/ruleGroups` | `wafrg` |
| `Front Door`| `Microsoft.Network/frontDoors` | `fd` |
| `Front Door Web Application Firewall Policy`| `Microsoft.Network/frontdoorWebApplicationFirewallPolicies` | `fdwfp` |
| `Load Balancer (External)`| `Microsoft.Network/loadBalancers` | `lbe` |
| `Load Balancer (Internal)`| `Microsoft.Network/loadBalancers` | `lbi` |
| `Load Balancer Inbound NAT Rule`| `Microsoft.Network/loadBalancers/inboundNatRules` | `inatr` |
| `Local Network Gateway`| `Microsoft.Network/localNetworkGateways` | `lngw` |
| `Network Interface`| `Microsoft.Network/networkInterfaces` | `nic` |
| `Network Security Group`| `Microsoft.Network/networkSecurityGroups` | `nsg` |
| `Network Watcher`| `Microsoft.Network/networkWatchers` | `nwtch` |
| `Private DNS Zone Virtual Network Link`| `Microsoft.Network/privateDnsZones/virtualNetworkLinks` | `pdnsv` |
| `Private Link Service`| `Microsoft.Network/privateLinkServices` | `pls` |
| `Public IP Address`| `Microsoft.Network/publicIPAddresses` | `pip` |
| `Public IP Prefix`| `Microsoft.Network/publicIPPrefixes` | `pippfx` |
| `Route Filter`| `Microsoft.Network/routeFilters` | `nrf` |
| `Route Filter Rule`| `Microsoft.Network/routeFilters/routeFilterRules` | `nrfrr` |
| `Route Table`| `Microsoft.Network/routeTables` | `rtb` |
| `Route Table Route`| `Microsoft.Network/routeTables/routes` | `route` |
| `Service Endpoint Policy`| `Microsoft.Network/serviceEndpointPolicies` | `nsept` |
| `Traffice Manager Profile`| `Microsoft.Network/trafficManagerProfiles` | `ntmp` |
| `Virtual Network Gateway`| `Microsoft.Network/virtualNetworkGateways` | `vnetg` |
| `Virtual Network`| `Microsoft.Network/virtualNetworks` | `vnet` |
| `Subnet`| `Microsoft.Network/virtualnetworks/subnets` | `vnets` |
| `Virtual Network Peering`| `Microsoft.Network/virtualNetworks/virtualNetworkPeerings` | `vnetp` |
| `Virtual WAN`| `Microsoft.Network/virtualWans` | `vwan` |
| `VPN Gateway`| `Microsoft.Network/vpnGateways` | `vpng` |
| `VPN Gateway Connection`| `Microsoft.Network/vpnGateways/vpnConnections` | `vpnc` |
| `VPN Site`| `Microsoft.Network/vpnSites` | `vpnsite` |
| `Notification Hubs Namespace`| `Microsoft.NotificationHubs/namespaces` | `nhns` |
| `Notification Hubs Namespace Authorization Rule`| `Microsoft.NotificationHubs/namespaces/AuthorizationRules` | `nrule` |
| `Notification Hubs Namespace Hub`| `Microsoft.NotificationHubs/namespaces/notificationHubs` | `nhub` |
| `Notification Hub Namespace Authorization Rule`| `Microsoft.NotificationHubs/namespaces/notificationHubs/AuthorizationRules` | `nhrule` |
| `Operational Insights Cluster`| `Microsoft.OperationalInsights/clusters` | `opic` |
| `Operational Insights Workspace`| `Microsoft.OperationalInsights/workspaces` | `opiw` |
| `Dashboard`| `Microsoft.Portal/dashboards` | `pdash` |
| `PowerBI Workspace Collection`| `Microsoft.PowerBI/workspaceCollections` | `pbiwc` |
| `PowerBi Dedicated Capacity`| `Microsoft.PowerBIDedicated/capacities` | `pbidc` |
| `Purview Account`| `Microsoft.Purview/accounts` | `pva` |
| `Recovery Services Vault`| `Microsoft.RecoveryServices/vaults` | `rsv ` |
| `Recovery Services Backup Policy`| `Microsoft.RecoveryServices/vaults/backupPolicies` | `rsvbp` |
| `Relay Namespace`| `Microsoft.Relay/namespaces` | `rns` |
| `Relay Authorization Rule`| `Microsoft.Relay/namespaces/AuthorizationRules` | `rule` |
| `Relay Hybrid Connection`| `Microsoft.Relay/namespaces/HybridConnections` | `hycon` |
| `Relay Hybrid Connection Authorization Rule`| `Microsoft.Relay/namespaces/HybridConnections/authorizationRules` | `rule` |
| `Relay WCF Relay`| `Microsoft.Relay/namespaces/WcfRelays` | `wcfr` |
| `Relay WCF Relay Authorization Rule`| `Microsoft.Relay/namespaces/WcfRelays/authorizationRules` | `wcfra` |
| `Resource Group`| `Microsoft.Resources/resourcegroups` | `rg` |
| `Template Spec`| `Microsoft.Resources/templateSpecs` | `tspec` |
| `Search Service`| `Microsoft.Search/searchServices` | `ssvc` |
| `Service Bus`| `Microsoft.ServiceBus/namespaces` | `sbn` |
| `Service Bus Authorization Rule`| `Microsoft.ServiceBus/namespaces/AuthorizationRules` | `rule` |
| `Service Bus Disaster Recovery Config`| `Microsoft.ServiceBus/namespaces/disasterRecoveryConfigs` | `sbndc` |
| `Service Bus Queue`| `Microsoft.ServiceBus/namespaces/queues` | `que` |
| `Service Bus Queue Authorization Rule`| `Microsoft.ServiceBus/namespaces/queues/authorizationRules` | `rule` |
| `Service Bus Topic`| `Microsoft.ServiceBus/namespaces/topics` | `topic` |
| `Service Bus Topic Authorization Rule`| `Microsoft.ServiceBus/namespaces/topics/authorizationRules` | `trule` |
| `Service Bus Topic Subscription`| `Microsoft.ServiceBus/namespaces/topics/subscriptions` | `tsub` |
| `Service Bus Topic Subscription Rule`| `Microsoft.ServiceBus/namespaces/topics/subscriptions/rules` | `sbtsr` |
| `Service Fabric Cluster`| `Microsoft.ServiceFabric/clusters` | `sfc` |
| `Signal IR Service`| `Microsoft.SignalRService/signalR` | `sssr` |
| `SQL Managed Instance`| `Microsoft.Sql/managedInstances` | `sqlmi` |
| `SQL Database Server`| `Microsoft.Sql/servers` | `sqlds` |
| `SQL Data Warehouse`| `Microsoft.Sql/servers` | `sqldw` |
| `SQL Database`| `Microsoft.Sql/servers/databases` | `sqldb` |
| `SQL Database Sync Group`| `Microsoft.Sql/servers/databases/syncGroups` | `sqlsg` |
| `SQL Elastic Pool`| `Microsoft.Sql/servers/elasticPools` | `sqlep` |
| `SQL Failover Group`| `Microsoft.Sql/servers/failoverGroups` | `sqlfg` |
| `SQL Firewall Rule`| `Microsoft.Sql/servers/firewallRules` | `sqlfw` |
| `Storage Account`| `Microsoft.Storage/storageAccounts` | `stg` |
| `Storage Sync Service`| `Microsoft.StorageSync/storageSyncServices` | `stgsyncsvc` |
| `Storage Sync Group`| `Microsoft.StorageSync/storageSyncServices/syncGroups` | `stgsyncgrp` |
| `Stor Simple Manager`| `Microsoft.StorSimple/managers` | `ssm` |
| `Stream Analytics Cluster`| `Microsoft.StreamAnalytics/cluster` | `sac` |
| `Stream Analytics Job`| `Microsoft.StreamAnalytics/streamingjobs` | `sasj` |
| `Stream Analytics Job Function`| `Microsoft.StreamAnalytics/streamingjobs/functions` | `sjf` |
| `Stream Analytics Job Input`| `Microsoft.StreamAnalytics/streamingjobs/inputs` | `sjin` |
| `Stream Analytics Job Output`| `Microsoft.StreamAnalytics/streamingjobs/outputs` | `sjout` |
| `Stream Analytics Job Transformation`| `Microsoft.StreamAnalytics/streamingjobs/transformations` | `sjtrf` |
| `Subscription`| `Microsoft.Subscription/subscriptions` | `sub` |
| `Synapse Workspace`| `Microsoft.Synapse/workspaces` | `synws` |
| `Synapse SQL Dedicated Pool`| `Microsoft.Synapse/workspaces/sqlPools` | `syndp` |
| `Synapse SQL Spark Pool`| `Microsoft.Synapse/workspaces/sqlPools` | `synsp` |
| `Time Series Insights Environment`| `Microsoft.TimeSeriesInsights/environments` | `tsie` |
| `Time Series Inights Access Policy`| `Microsoft.TimeSeriesInsights/environments/accessPolicies` | `tsiea` |
| `Time Series Insights Event Sources`| `Microsoft.TimeSeriesInsights/environments/eventSources` | `tsiee` |
| `Time Series Insights Reference Data Set`| `Microsoft.TimeSeriesInsights/environments/referenceDataSets` | `tsier` |
| `Web Certificate`| `Microsoft.Web/certificates` | `wbcer` |
| `Web Server Farm`| `Microsoft.Web/serverfarms` | `wbsvf` |
| `Web Site (App Service Environment)`| `Microsoft.Web/sites` | `ase` |
| `Web Site (Azure Static Web App)`| `Microsoft.Web/sites` | `aswba` |
| `Web Site (Function App)`| `Microsoft.Web/sites` | `func` |
| `Web Site (Static Web App)`| `Microsoft.Web/sites` | `wsite` |
| `Web Site (Web App)`| `Microsoft.Web/sites` | `wapp` |
   
## Next steps

Review recommendations for tagging your Azure resources and assets.

> [!div class="nextstepaction"]
> [Define your tagging strategy](./resource-tagging.md)
