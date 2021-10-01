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

## Resource List in Alphabetical Order

### AnalysisServices

 | Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `servers` | `assvr` |
 
### ApiManagement
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `service` | `apims` |
 | `service/apis` | `apis` |
 | `service/apis/issues` | `apii` |
 | `service/apis/issues/attachments` | `apiia` |
 | `service/apis/issues/comments` | `apiic` |
 | `service/apis/operations` | `apio` |
 | `service/apis/operations/tags` | `apiot` |
 | `service/apis/releases` | `apir` |
 | `service/apis/schemas` | `apis` |
 | `service/apis/tagDescriptions` | `apitd` |
 | `service/apis/tags` | `apitg` |
 | `service/api-version-sets` | `apivs` |
 | `service/authorizationServers` | `apias` |
 | `service/backends` | `apib` |
 | `service/certificates` | `apic` |
 | `service/diagnostics` | `apid` |
 | `service/groups` | `apig` |
 | `service/groups/users` | `apigu` |
 | `service/identityProviders` | `apiip` |
 | `service/loggers` | `apil` |
 | `service/notifications` | `apin` |
 | `service/notifications/recipientEmails` | `recem` |
 | `service/openidConnectProviders` | `apioi` |
 | `service/policies` | `apipo` |
 | `service/products` | `apipr` |
 | `service/products/apis` | `api` |
 | `service/products/groups` | `grp` |
 | `service/products/tags` | `tags` |
 | `service/properties` | `prop` |
 | `service/subscriptions` | `subsr` |
 | `service/tags` | `tags` |
 | `service/templates` | `temp` |
 | `service/users` | `user` |
 
### AppConfiguration
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `configurationStores` | `accs` |
 
### Authorization
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `locks` | `locks` |
 | `policyAssignments` | `polas` |
 | `policyDefinitions` | `polde` |
 | `policySetDefinitions` | `psd` |
 | `automationAccounts` | `aa` |
 | `automationAccounts/certificates` | `cert` |
 | `automationAccounts/connections` | `conn` |
 | `automationAccounts/credentials` | `cred` |
 | `automationAccounts/runbooks` | `runbk` |
 | `automationAccounts/schedules` | `sched` |
 | `automationAccounts/variables` | `var` |
 | `automationAccounts/watchers` | `watch` |
 | `automationAccounts/webhooks` | `wbhk` |
 
### Batch
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `batchAccounts` | `ba` |
 | `batchAccounts/applications` | `appl` |
 | `batchAccounts/certificates` | `cert` |
 | `batchAccounts/pools` | `pool` |
 
### Blockchain
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `blockchainMembers` | `blchm` |
 
### Blueprint
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `blueprintAssignments` | `bpas` |
 | `blueprints` | `bp` |
 | `blueprints/artifacts` | `bpa` |
 | `blueprints/versions` | `bpv` |
 
### BotService
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `botServices` | `botsvc` |
 | `botServices/channels` | `chan` |
 | `botServices/Connections` | `conn` |
 | `enterpriseChannels` | `botec` |
 
### Cache
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `Redis` | `redis` |
 | `Redis/firewallRules` | `rule` |
 
### Cdn
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `profiles` | `cdnp` |
 | `profiles/endpoints` | `cdnep` |
 
### CertificateRegistration
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `certificateOrders` | `cerco` |
 
### CognitiveServices
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `accounts` | `coga` |
 
### Compute
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `availabilitySets` | `avset` |
 | `cloudServices` | `cldsvc` |
 | `diskEncryptionSets` | `dskes` |
 | `disks` | `dsk` |
 | `disks` | `osdsk` |
 | `galleries` | `gal` |
 | `galleries/applications` | `app` |
 | `galleries/applications/versions` | `apver` |
 | `galleries/images` | `gimg` |
 | `images` | `cimg` |
 | `snapshots` | `snap` |
 | `virtualMachines` | `vm` |
 | `virtualMachineScaleSets` | `vmss` |
 | `containerGroups` | `congp` |
 
### ContainerRegistry
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `registries` | `conrg` |
 | `registries/buildTasks` | `btsks` |
 | `registries/buildTasks/steps` | `steps` |
 | `registries/replications` | `rep` |
 | `registries/scopeMaps` | `scmap` |
 | `registries/tasks` | `tasks` |
 | `registries/tokens` | `tokn` |
 | `registries/webhooks` | `webhk` |
 
### ContainerService
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `managedClusters` | `aks` |
 
### ContainerServiceopenShiftManagedClusters
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `ContainerServiceopenShiftManagedClusters` | `osmc` |
 
### CustomerInsights
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `hubs` | `cihub` |
 | `hubs/authorizationPolicies` | `authp` |
 | `hubs/connectors` | `conn` |
 | `hubs/connectors/mappings` | `map` |
 | `hubs/interactions` | `int` |
 | `hubs/kpi` | `kpi` |
 | `hubs/links` | `link` |
 | `hubs/predictions` | `pred` |
 | `hubs/profiles` | `prof` |
 | `hubs/relationshipLinks` | `rlink` |
 | `hubs/relationships` | `rel` |
 | `hubs/roleAssignments` | `role` |
 | `hubs/views` | `views` |
 
### CustomProviders
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `associations` | `cpass` |
 | `resourceProviders` | `cprep` |
 
### DataBox
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `jobs` | `dbjob` |
 
### Databricks
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `workspaces` | `dbws` |
 
### DataFactory
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `factories` | `adf` |
 | `factories/dataflows` | `flows` |
 | `factories/datasets` | `dsets` |
 | `factories/integrationRuntimes` | `run` |
 | `factories/linkedservices` | `lksvc` |
 | `factories/pipelines` | `pipe` |
 | `factories/triggers` | `trig` |
 | `factories/triggers/rerunTriggers` | `rerun` |
 
### DataLakeAnalytics
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `accounts` | `dlaac` |
 | `accounts/computePolicies` | `cmpol` |
 | `accounts/dataLakeStoreAccounts` | `dlsta` |
 | `accounts/firewallRules` | `fwrul` |
 | `accounts/storageAccounts` | `sa` |
 
### DataLakeStore
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `accounts` | `dlsa` |
 | `accounts/firewallRules` | `frule` |
 | `accounts/virtualNetworkRules` | `vrule` |
 
### DataMigration
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `services` | `dms` |
 | `services/projects` | `proj` |
 
### DBforMariaDB
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `servers` | `mdbsv` |
 | `servers/databases` | `mdbdb` |
 | `servers/firewallRules` | `fwrul` |
 | `servers/virtualNetworkRules` | `vnetr` |
 
### DBforMySQL
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `servers` | `mysql` |
 | `servers/databases` | `db` |
 | `servers/firewallRules` | `frule` |
 | `servers/virtualNetworkRules` | `vrule` |
 
### DBforPostgreSQL
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `servers` | `psql` |
 | `servers/databases` | `db` |
 | `servers/firewallRules` | `fwrul` |
 | `servers/virtualNetworkRules` | `vnetr` |
 
### Devices
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `IotHubs` | `iot` |
 | `IotHubs/certificates` | `cert` |
 | `IotHubs/eventHubEndpoints/ConsumerGroups` | `congp` |
 | `provisioningServices` | `provs` |
 | `provisioningServices/certificates` | `cert` |
 
### DevTestLab
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `labs` | `dtlab` |
 | `labs/customimages` | `img` |
 | `labs/formulas` | `form` |
 | `labs/virtualmachines` | `vm` |
 | `databaseAccounts` | `dbact` |
 | `databaseAccounts/sqlDatabases	` | `cosdb` |
 
### EventGrid
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `domains` | `evgd` |
 | `domains/topics` | `egdt` |
 | `eventSubscriptions` | `egesu` |
 | `topics` | `egtp` |
 
### EventHub
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `clusters` | `evhcl` |
 | `namespaces` | `evhns` |
 | `namespaces/AuthorizationRules` | `rule` |
 | `namespaces/disasterRecoveryConfigs` | `drcfg` |
 | `namespaces/eventhubs` | `evh` |
 | `namespaces/eventhubs/authorizationRules` | `rule` |
 | `namespaces/eventhubs/consumergroups` | `cgrp` |
 
### HDInsight
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `clusters` | `hadoop` |
 | `clusters` | `hbase` |
 | `clusters` | `kafka` |
 | `clusters` | `mls` |
 | `clusters` | `spark` |
 | `clusters` | `storm` |
 
### HybridCompute
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `machines` | `arcm` |
 
### ImportExport
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `jobs` | `iejob` |
 
### Insights
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `actionGroups` | `inag` |
 | `activityLogAlerts` | `inala` |
 | `components` | `incom` |
 | `metricAlerts` | `inma` |
 | `scheduledQueryRules` | `insqr` |
 
### IoTCentral
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `IoTApps` | `iotapp` |
 
### KeyVault
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `vaults` | `kv` |
 | `vaults/secrets` | `kvs` |
 
### Kubernetes
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `connectedClusters` | `kubcc` |
 
### Kusto
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `clusters` | `kucl` |
 | `clusters/databases` | `kcdb` |
 | `clusters/databases/dataConnections` | `dcon` |
 | `clusters/databases/eventhubconnections` | `ehcon` |
 
### Logic
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `integrationAccounts` | `liact` |
 | `integrationAccounts/assemblies` | `assem` |
 | `integrationAccounts/batchConfigurations` | `bconf` |
 | `integrationAccounts/certificates` | `cert` |
 | `integrationAccounts/maps` | `map` |
 | `integrationAccounts/partners` | `part` |
 | `integrationAccounts/rosettanetprocessconfigurations` | `rpcnf` |
 | `integrationAccounts/schemas` | `schem` |
 | `integrationAccounts/sessions` | `sess` |
 | `integrationServiceEnvironments` | `lise` |
 | `integrationServiceEnvironments/managedApis` | `mapis` |
 | `workflows` | `lwf` |
 
### MachineLearning
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `commitmentPlans` | `mlcp` |
 | `webServices` | `mlweb` |
 | `workspaces` | `mlws` |
 
### MachineLearningServices
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `workspaces` | `mlsw` |
 | `workspaces/computes` | `mlswc` |
 
### ManagedIdentity
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `userAssignedIdentities` | `miuai` |
 
### Management
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `managementGroups` | `mg` |
 
### Maps
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `accounts` | `macc` |
 
### Media
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `mediaservices` | `mms` |
 | `mediaservices/liveEvents` | `lievt` |
 | `mediaservices/liveEvents/liveOutputs` | `liout` |
 | `mediaservices/streamingEndpoints` | `strep` |
 
### Migrate
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `assessmentProjects` | `migap` |
 
### Network
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `applicationGateways` | `agw` |
 | `applicationSecurityGroups` | `asg` |
 | `azureFirewalls` | `afw` |
 | `bastionHosts` | `bash` |
 | `connections` | `conn` |
 | `dnsZones` | `dnsz` |
 | `expressRouteCircuits` | `erc` |
 | `firewallPolicies` | `waf` |
 | `firewallPolicies/ruleGroups` | `wafrg` |
 | `frontDoors` | `fd` |
 | `frontdoorWebApplicationFirewallPolicies` | `fdwfp` |
 | `loadBalancers` | `lbe` |
 | `loadBalancers` | `lbi` |
 | `loadBalancers/inboundNatRules` | `inatr` |
 | `localNetworkGateways` | `lngw` |
 | `networkInterfaces` | `nic` |
 | `networkSecurityGroups` | `nsg` |
 | `networkSecurityGroups/securityRules` | `nsgsr` |
 | `networkWatchers` | `nw` |
 | `privateDnsZones` | `pdnsz` |
 | `privateDnsZones/virtualNetworkLinks` | `pdnsv` |
 | `privateLinkServices` | `pls` |
 | `publicIPAddresses` | `pip` |
 | `publicIPPrefixes` | `pipp` |
 | `routeFilters` | `nrf` |
 | `routeFilters/routeFilterRules` | `nrfrr` |
 | `routeTables` | `netrt` |
 | `routeTables/routes` | `route` |
 | `serviceEndpointPolicies` | `nsept` |
 | `trafficManagerProfiles` | `ntmp` |
 | `virtualNetworkGateways` | `vnetg` |
 | `virtualNetworks` | `vnet` |
 | `virtualnetworks/subnets` | `vnets` |
 | `virtualNetworks/virtualNetworkPeerings` | `vnetp` |
 | `virtualWans` | `vwan` |
 | `vpnGateways` | `vpng` |
 | `vpnGateways/vpnConnections` | `vpnc` |
 | `vpnSites` | `vpns` |
 
### NotificationHubs
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `namespaces` | `nhns` |
 | `namespaces/AuthorizationRules` | `nrule` |
 | `namespaces/notificationHubs` | `nhub` |
 | `namespaces/notificationHubs/AuthorizationRules` | `nhrule` |
 
### OperationalInsights
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `clusters` | `opic` |
 | `workspaces` | `opiw` |
 
### OperationsManagement
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `dashboards` | `pdash` |
 
### PowerBI
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `workspaceCollections` | `pbiwc` |
 
### PowerBIDedicated
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `capacities` | `pbidc` |
 
### Purview
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `accounts` | `pva` |
 
### RecoveryServices
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `vaults` | `rsv ` |
 | `vaults/backupPolicies` | `rsvbp` |
 
### Relay
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `namespaces` | `rns` |
 | `namespaces/AuthorizationRules` | `rule` |
 | `namespaces/HybridConnections` | `hycon` |
 | `namespaces/HybridConnections/authorizationRules` | `rule` |
 | `namespaces/WcfRelays` | `wcfr` |
 | `namespaces/WcfRelays/authorizationRules` | `wcfra` |
 
### Resources
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `deployments` | `deloy` |
 | `resourcegroups` | `rg` |
 | `templateSpecs` | `tspec` |
 
### Search
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `searchServices` | `ssvc` |
 
### ServiceBus
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `namespaces` | `sbn` |
 | `namespaces/AuthorizationRules` | `rule` |
 | `namespaces/disasterRecoveryConfigs` | `sbndc` |
 | `namespaces/migrationConfigurations` | `migc` |
 | `namespaces/queues` | `que` |
 | `namespaces/queues/authorizationRules` | `rule` |
 | `namespaces/topics` | `topic` |
 | `namespaces/topics/authorizationRules` | `trule` |
 | `namespaces/topics/subscriptions` | `tsub` |
 | `namespaces/topics/subscriptions/rules` | `sbtsr` |
 
### ServiceFabric
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `clusters` | `sfc` |
 
### SignalRService
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `signalR` | `sssr` |
 
### Sql
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `managedInstances` | `sqlmi` |
 | `servers` | `sqlds` |
 | `servers` | `sqldw` |
 | `servers/databases` | `sqldb` |
 | `servers/databases/syncGroups` | `sqlsg` |
 | `servers/elasticPools` | `sqlep` |
 | `servers/failoverGroups` | `sqlfg` |
 | `servers/firewallRules` | `sqlfw` |
 
### Storage
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `storageAccounts` | `sa` |
 | `storageAccounts` | `savm` |
 | `storageSyncServices` | `ssss` |
 | `storageSyncServices/syncGroups` | `sgrp` |
 
### StorSimple
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `managers` | `ssm` |
 
### StreamAnalytics
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `cluster` | `sac` |
 | `streamingjobs` | `sasj` |
 | `streamingjobs/functions` | `sjf` |
 | `streamingjobs/inputs` | `sjin` |
 | `streamingjobs/outputs` | `sjout` |
 | `streamingjobs/transformations` | `sjtrf` |
 
### Subscription
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `subscriptions` | `subcr` |
 
### Synapse
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `workspaces` | `synws` |
 | `workspaces/sqlPools` | `syndp` |
 | `workspaces/sqlPools` | `synsp` |
 
### TimeSeriesInsights
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `environments` | `tsie` |
 | `environments/accessPolicies` | `tsiea` |
 | `environments/eventSources` | `tsiee` |
 | `environments/referenceDataSets` | `tsier` |
 
### Web
 
| Resource provider namespace/Entity | Abbreviation |  
|--|--|
 | `certificates` | `wbcer` |
 | `serverfarms` | `wbsvf` |
 | `sites` | `ase` |
 | `sites` | `aswba` |
 | `sites` | `func` |
 | `sites` | `wsite` |
 | `sites` | `wapp` |
 | `sites/slots` | `slot` |

## Next steps

Review recommendations for tagging your Azure resources and assets.

> [!div class="nextstepaction"]
> [Define your tagging strategy](./resource-tagging.md)