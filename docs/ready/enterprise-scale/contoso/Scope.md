---
title: "CAF enterprise-scale landing zone - Contoso Reference Implementation - Scope"
titleSuffix: Cloud Adoption Framework
description: CAF enterprise-scale landing zone - Contoso Reference Implementation - Scope
author: rkuehfus
ms.author: brblanch
ms.date: 02/01/2020
ms.topic: guide
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: csu
---

# Scope

Contoso Corporation is a multi-national business with headquarters in London, U.K. Contoso senior leadership has mandated a "cloud-first" approach, with an overarching strategy to reduce and gradually divest the on-premises data center footprint. Contoso has chosen Azure as their preferred public cloud provider. They have a large overall IT estate and are concerned about the velocity of workload transformation/migration and how they can establish landing zones for application teams to migrate their applications.

Contoso has come across the CAF enterprise-scale landing zone architecture, which provides a forward-looking and Azure-native design approach. The Contoso IT leadership team has committed to this, as they believe it will allow applications (legacy or modern) to seamlessly move at their own pace while also providing secure and streamlined operations, management, and governance across the entire Contoso platform on Azure.

## Contoso architecture

### Enterprise enrollment and Azure AD tenants

Contoso has opted for simpler EA design with a single Department and multiple EA Accounts. Each EA account will have an associated service principal account by configuring IAM permission as part of the (automated) subscription provisioning process.

Contoso has three separate Azure AD tenants for Dev, Test, and Prod and Azure AD Connect is already in place for the Production Azure AD tenant. The dev and test tenants are used for Office 365 validation, and there is no requirement to separate Identities at the Azure AD tenant level across dev, test, and production environments in Azure, so Contoso will only leverage the Production Azure AD tenant for Azure access.  

Additional controls will be in place for networking (isolation) and identity (segregation of duties) to guarantee separation between dev, test, and production workloads. From a networking and identity perspective, all subscriptions include sandbox subscriptions and are considered as production.

### Identity and access management

Contoso wants to ensure zero standing access for production environments across all Azure control plane access and will use Azure AD Privileged Identity Management (PIM) to ensure just-in-time control plane access to Azure resources. Contoso will create custom role definitions (Platform Owner, NetOps, SecOps, Landing Zone Owner, AppOps/DevOps) in accordance with CAF enterprise-scale landing zone roles to be supported by the operating model for the Azure platform.

The identity team will create an Azure-AD-only group for each of the roles above and make landing zone Owner/Requestor an owner of the group before creating entitlements for those groups in Azure AD PIM. Those who require to access to Azure resources will be able to search for the Azure AD group by name and optimize the Azure AD self-service group management capability to join a group. Group owners can determine whether to approve or deny a user request based on eligibility criteria.

| Azure AD Group Name                    | Scope                    | PIM Role           |
|-----------------------------------|--------------------------|--------------------|
| \<\<Subscription-Name\>\>-Owner   | Subscription             | Landing Zone Owner |
| \<\<Subscription -Name\>\>-DevOps | Subscription             | DevOps             |
| \<\<Subscription -Name\>\>-AppOps | Subscription             | AppOps             |
| SecOps                            | Contoso Management Group | SecOps             |
| \<\<Subscription -Name\>\>-NetOps | Contoso Management Group | NetOps             |
| Platform Owner                    | Tenant Root ("/")        | Owner (Built-in)   |


Azure AD will be the primary IDP where applications support modern federation protocols such as OIDC, SAML, or WS-Fed. Regional domain controllers will be deployed in the identity subscription to support scenarios where legacy authentication (LDAP/Kerberos) is required.

### Management group and subscription organization

Contoso is designing their management group hierarchy and subscription organization to optimize for scale, enabling autonomy for the platform and application teams to evolve alongside business requirements. The subscription naming convention will be "TLA-of-the-business-Unit" followed by "Workload-Type", "Region", "Workload-Name" and "Unique-Number", for example FIN-Prod-NEU-Payroll-01, FIN-Prod-WEU-Payroll-01.

Contoso has decided to use geo-affinitized subscriptions to simplify networking and connectivity. Workloads that do require multiple regions will have at least one subscription for each region, including ones for business continuity and disaster recovery purposes.

Contoso has decided to use Azure resource tags for billing and chargeback purposes instead of blending a cost-management structure within the management group and subscription hierarchy. This will provide horizontal capabilities to query cost across multiple subscriptions. Tags required for billing (department and cost center) will be enforced by the policy within the landing zone management group scope.

![Contoso MG structure](./media/contoso&#32;mg&#32;structure.png)

#### Management groups

**Tenant root group**

The default root management group will not be used directly, allowing for greater flexibility in the future to incorporate an equivalent test environment for their end to end Azure architecture.

**Contoso**

This is the top-level management group implemented within Contoso's Azure tenant and will serve as the container for all custom role definitions, custom policy definitions, and Contoso global policy assignments, but will have minimal direct role assignments. For policy assignments at this scope, the target state is to ensure security and autonomy for the platform as additional sub scopes are created, such as child management groups and subscriptions.

**Landing zones**

All business units will create their subscriptions within child management groups of the Landing Zones management groups. This allows for a generic yet more granular approach to policy assignments, to more easily separate active landing zones from sandbox subscriptions and decommissioned subscriptions.

**Corporation, online, and SAP**

Contoso has identified three common archetypes they will migrate/deploy to Azure and have developed the requisite policies to ensure appropriate guardrails are in place for each landing zone that is created as these management groups.

Azure policy will require creating tags to identify ownership, billing, and chargeback within each subscription.

* Corp landing zones will include all VNets that do not expose public endpoints and that require connectivity to on-premises as well as connectivity to other landing zones. 
* Online landing zones include all VNets that have internet-facing applications via an Azure Application Gateway (v2). 
* SAP represents a workload that merits separation given the implied specialization.

**Sandbox**

Application teams and individual users within Contoso wanting to test and explore Azure services will have subscriptions created within the Sandbox management group. In this group, policies are in place to ensure there's no control plane or data plane path to production environments.

**Decommission**

All canceled subscriptions will be moved under this management group by Azure Policy, and will be deleted after 60 days.

#### Platform subscriptions

**Connectivity**

A dedicated subscription for the centrally managed networking infrastructure, which will control end to end connectivity for all landing zones within Contoso's Azure platform. Azure resources that will be deployed into this subscription include Azure Virtual WAN and its subresources (VHubs, Gateways), Azure Firewalls, Firewall Policies, and Azure Private DNS Zones.

The "Connectivity" subscription has the tag "BusinessUnit" with the "Platform" value.

**Identity**

The "Identity" subscription will be used to host VMs running Windows Server Active Directory. There will be at least two domain controllers deployed per Azure region for redundancy purposes, and to ensure regions are independent in the case of a regional outage. AD replication will ensure all domain controllers are kept in sync.

**Management**

A dedicated subscription for centrally managed platform infrastructure, to ensure a holistic at-scale management capability across all landing zones in Contoso's Azure platform

The "Management" subscription has the tag "BusinessUnit" with a "Platform" value.

The following policies related to Management Group hierarchy and Subscription organization will be assigned within the Contoso production tenant:

| Policy                                            | Intent                                                        | Assignment scope              | Result                                                                                          |
|---------------------------------------------------|---------------------------------------------------------------|-------------------------------|-------------------------------------------------------------------------------------------------|
| Enforce subscription naming convention            | Ensure all subscriptions conform to the naming convention    | Contoso management group      | All subscriptions have valid naming convention                                                  |
| Enforce subscription budget                       | Ensure all subscriptions have a budget associated             | Contoso management group      | No subscription will allow unlimited spending                                                   |
| Enforce subscription tags                         | Ensure all subscriptions have the required tags               | Contoso management group      | All subscriptions are tagged properly to identify business unit owner, intent, and cost center. |
| Move canceled subscriptions                      | Ensure canceled subscriptions are moved from Landing Zone    | Landing Zone management group | Any subscription that gets canceled will be moved to the Decommission Management group         |
| Allowed regions for resource groups and resources | Ensure all resources are created in the designated regions    | Contoso management group      | All resources are compliant per their location                                                  |
| Assign region policy per subscription             | Ensure subscriptions get policy with correct regions assigned | Contoso management group      | Subscriptions will support regions per their naming convention                                  |

## Network topology and connectivity

Contoso has a presence across Europe and North America. Contoso's headquarters are located in London, UK. Contoso also has regional HQ offices in Amsterdam and Chicago. Contoso has a large number of branch offices (around 500), which are located across the US and Europe, with each branch office containing a CPE that is connected to the local regional HQ via S2S VPN.

Contoso has decided to adopt CAF enterprise-scale landing zone recommendations for building their network architecture in Azure. Key decisions they have adopted include:

1. The deployment of a Microsoft-managed network in Azure using Azure Virtual WAN to interconnect all Azure and on-premises locations around the world.

2. Use of ExpressRoute Global Reach to interconnect corporate HQs with regional hubs.

3. Move away from their traditional DMZ-model and adopt a Zero-Trust network model.

4. Allow full subscription democratization by giving Landing Zone Owners' rights to create subnets within their landing zones to suit their application needs, while ensuring the platform maintains compliance and security as defined by the SecOps team.

Contoso's network design is based on CAF enterprise-scale landing zone design principles and is pictured below:

![Network topology](./media/image5.png)

With this network design, Contoso enables the following scenarios:

* Regional HQ offices connectivity to Azure via ExpressRoute.
* Branch offices connectivity to Azure via VPN (S2S IPSec tunnels).
* Landing Zone VNets are connected to the regional Azure Virtual WAN VHub.
* Regional HQs to Regional HQs connectivity via ExpressRoute with Global Reach.
* Regional HQs to branch offices connectivity via Azure Virtual WAN.
* Regional HQs and branch offices connectivity to Azure VNets via Azure Virtual WAN.
* Internet-outbound connectivity from Azure VNets is secured using Azure Firewall within the Virtual WAN VHub.

Contoso decided to deploy a Microsoft-managed, Azure Virtual WAN-based network topology to enable global interconnectivity between on-premises and Azure and to support a large number of branches that need to connect to Azure. The following diagram depicts the required Azure resources which must be deployed inside the "Connectivity" subscription to support Contoso's global Azure network:

![Connectivity subscription](./media/image7.png)

In order to simplify the routing configuration across the entire Azure networking platform, Contoso has assigned the following IP address spaces for Azure Virtual WAN VHubs and Virtual Networks:

* North Europe: 10.1.0.0/16
* West Europe: 10.2.0.0/16
* North Central US: 10.3.0.0/16

Since Contoso must support these three Azure regions--North Europe, West Europe, and North Central US--it has documented the resources and parameters required for the platform to be deployed in alignment with the Azure policy and CAF enterprise-scale landing zone guidance. All these resources will be deployed within the "Connectivity" subscription and enforced by Deploy-If-Not-Exist Policies.

North Europe:

<table>
<thead>
<tr class="header">
<th>Resource</th>
<th>Resource Group</th>
<th>Parameters</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>Virtual WAN</td>
<td>contoso-global-wan</td>
<td><p>VWAN name: contoso-vwan</p>
<p>Location: North Europe</p></td>
</tr>
<tr class="even">
<td>Virtual HUB</td>
<td>contoso-global-wan</td>
<td><p>Virtual WAN: contoso-vwan</p>
<p>Location: North Europe</p>
<p>VHub name: contoso-vhub-neu</p>
<p>VHub address space: 10.1.0.0/24</p>
<p>ExpressRoute Gateway: Yes (1 scale unit)</p>
<p>VPN Gateway: Yes (2 scale units)</p></td>
</tr>
<tr class="odd">
<td>Azure Firewall Policy</td>
<td>contoso-fw-policies</td>
<td><p>Firewall Policy name: contoso-fw-policy-global</p>
<p>Outbound rules: (as required, for example, allow outbound traffic to *.microsoft.com)</p></td>
</tr>
<tr class="even">
<td>Azure Firewall</td>
<td>contoso-global-wan</td>
<td>VHub name: contoso-vhub-neu</td>
</tr>
<tr class="odd">
<td>Azure Private DNS</td>
<td>contoso-global-dns</td>
<td>Private DNS Zone name: azure.Contoso.com</td>
</tr>
<tr class="even">
<td>Azure DDoS Standard</td>
<td>contoso-global-ddos</td>
<td><p>Name: contoso-ddos-std-plan</p>
<p>Region: North Europe</p></td>
</tr>
<tr class="odd">
<td>ExpressRoute circuit</td>
<td>contoso-er-circuits</td>
<td><p>ExpressRoute resource ID:</p>
<p>/subscriptions/&lt;subscription-id&gt;/resourceGroups/&lt;resourcegroup-name&gt;/providers/Microsoft.Network/expressRouteCircuits/&lt;er-circuit-name&gt;</p>
<p>ExpressRoute authorization key: XXXXXXXXXXXX</p></td>
</tr>
<tr class="even">
<td>Network Watcher</td>
<td>NetworkWatcherRG</td>
<td>Location: North Europe</td>
</tr>
</tbody>
</table>


West Europe:

<table>
<thead>
<tr class="header">
<th>Resource</th>
<th>Resource Group</th>
<th>Parameters</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>Virtual HUB</td>
<td>contoso-global-wan</td>
<td><p>Virtual WAN: contoso-vwan</p>
<p>Location: West Europe</p>
<p>VHub name: contoso-vhub-weu</p>
<p>VHub address space: 10.2.0.0/24</p>
<p>ExpressRoute Gateway: Yes (1 scale unit)</p>
<p>VPN Gateway: Yes (2 scale units)</p></td>
</tr>
<tr class="even">
<td>Azure Firewall Policy</td>
<td>contoso-fw-policies</td>
<td><p>Firewall Policy name: contoso-fw-policy-weu</p>
<p>Outbound rules: (as required, for example, allow outbound traffic to *.microsoft.com)</p></td>
</tr>
<tr class="odd">
<td>Azure Firewall</td>
<td>contoso-global-wan</td>
<td>VHub name: contoso-vhub-weu</td>
</tr>
<tr class="even">
<td>ExpressRoute circuit</td>
<td>contoso-er-circuits</td>
<td><p>ExpressRoute resource ID:</p>
<p>/subscriptions/&lt;subscription-id&gt;/resourceGroups/&lt;resourcegroup-name&gt;/providers/Microsoft.Network/expressRouteCircuits/&lt;er-circuit-name&gt;</p>
<p>ExpressRoute authorization key: XXXXXXXXXXXX</p></td>
</tr>
<tr class="odd">
<td>Network Watcher</td>
<td>NetworkWatcherRG</td>
<td>Location: West Europe</td>
</tr>
</tbody>
</table>

North Central US:

<table>
<thead>
<tr class="header">
<th>Resource</th>
<th>Resource Group</th>
<th>Parameters</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>Virtual HUB</td>
<td>contoso-global-wan</td>
<td><p>Virtual WAN: contoso-vwan</p>
<p>Location: North Central US</p>
<p>VHub name: contoso-vhub-ncus</p>
<p>VHub address space: 10.3.0.0/24</p>
<p>ExpressRoute Gateway: Yes (1 scale unit)</p>
<p>VPN Gateway: Yes (2 scale units)</p></td>
</tr>
<tr class="even">
<td>Azure Firewall Policy</td>
<td>contoso-fw-policies</td>
<td><p>Firewall Policy name: contoso--fw-policy-ncus</p>
<p>Outbound rules: (as required, for example, allow outbound traffic to *.microsoft.com)</p></td>
</tr>
<tr class="odd">
<td>Azure Firewall</td>
<td>contoso-global-wan</td>
<td>VHub name: contoso-vhub-ncus</td>
</tr>
<tr class="even">
<td>ExpressRoute circuit</td>
<td>contoso-er-circuits</td>
<td><p>ExpressRoute resource ID:</p>
<p>/subscriptions/&lt;subscription-id&gt;/resourceGroups/&lt;resourcegroup-name&gt;/providers/Microsoft.Network/expressRouteCircuits/&lt;er-circuit-name&gt;</p>
<p>ExpressRoute authorization key: XXXXXXXXXXXX</p></td>
</tr>
<tr class="odd">
<td>Network Watcher</td>
<td>NetworkWatcherRG</td>
<td>Location: North Central US</td>
</tr>
</tbody>
</table>

The following policies related to networking will be assigned in the Contoso production tenant:

<table>
<thead>
<tr class="header">
<th>Policy</th>
<th>Intent</th>
<th>Assignment scope</th>
<th>Result</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>Enforce Virtual Network</td>
<td>Ensure all landing zones have a Virtual Network</td>
<td>Landing Zone management group</td>
<td>All landing zones have a Virtual Network</td>
</tr>
<tr class="even">
<td>Enforce Virtual Network connectivity</td>
<td>Ensure all landing zones are connected to the connectivity subscription</td>
<td>Contoso management group</td>
<td>All virtual networks are configured and connected per the desired state</td>
</tr>
<tr class="odd">
<td>Deny IP forwarding on NIC</td>
<td>Ensure IP forwarding cannot be enabled</td>
<td>Landing Zone management group</td>
<td>No IP forwarding enabled in landing zones</td>
</tr>
<tr class="even">
<td>Deny inbound RDP/SSH on NSGs</td>
<td>Ensure NSGs can't open RDP/SSH from internet</td>
<td>Landing Zone management group</td>
<td>No inbound traffic from internet on management ports</td>
</tr>
<tr class="odd">
<td>Enforce NSG on every subnet</td>
<td>Enforce default NSG is always associated to subnet</td>
<td>Landing Zone management group</td>
<td>No subnets without NSGs.</td>
</tr>
<tr class="even">
<td>Enable NSG flow logs</td>
<td>Ensure NSG flow logs are being captured</td>
<td>Landing Zone management group</td>
<td>No NSG without NSG flow logs</td>
</tr>
<tr class="odd">
<td>Enforce UDR on VNet injected services subnet</td>
<td>Enforce UDR for direct communication with VNet injected PaaS services management plane IPs</td>
<td>Landing Zone management group</td>
<td>Control plane traffic for VNet injected PaaS services works properly bypassing the default route</td>
</tr>
<tr class="even">
<td>Onboard VNet in DDoS Standard Plan</td>
<td>Ensure VNets that will have public IP addresses are onboarded into a DDoS Std Protection Plan</td>
<td>Online management group</td>
<td>All VNets with public IP addresses are protected against DDoS attacks</td>
</tr>
<tr class="odd">
<td>Ensure WAF policies are enabled on AppGW</td>
<td>Ensure all AppGWs have WAF policies enabled</td>
<td>Online management group</td>
<td>All AppGWs deployed are protected with WAF</td>
</tr>
</tbody>
</table>

## Management and monitoring

Contoso will employ a monitoring strategy where the central team will be responsible for the all-up platform logging, security and networking, and will use Azure native services such as Log Analytics, Monitor, Security Center, Sentinel, and Network Watcher. All core management infrastructure will exist inside the dedicated Management subscription and will be deployed and governed by Azure Policy; the requisite configuration for workloads and subscriptions will be driven through Azure policy as new subscriptions and resources are being created. The following diagram depicts the required Azure resources that must be deployed within the "Management" subscription to support Contoso's platform management and monitoring:

![Monitoring subscription](.//media/image9.png)

Since Contoso has selected West Europe as their primary Azure region, they will use a single Log Analytics workspace within West Europe for centralized platform management, which will also be the hub for all security and networking data across their Azure platform. With this design and implementation, they will achieve:

* A single, central, and horizontal view of the platform across security, auditing, and networking, all enforced by Azure Policy and "deployIfNotExists".
  * Consume security data centrally from all subscriptions.
  * Consume networking data centrally from all regions and subscriptions where networks are deployed.
* Granular data retention per data table in Log Analytics.
* Resource centric and granular RBAC for application teams to access their monitoring data.
* At scale emergency VM patching as well as granular VM patching for application teams per RBAC.
* Centralized alerting from a platform perspective.
* Centralized, interactive Azure dashboards through the lenses of networking, security, and overall platform health.

Contoso has documented the resources and parameters that it requires so that the platform can be managed and monitored via Policy as per CAF enterprise-scale landing zone guidance. All these resources will be deployed in the "Management" subscription.


<table>
<thead>
<tr class="header">
<th>Resource</th>
<th>Resource Group</th>
<th>Parameters</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>Log Analytics workspace</td>
<td>weu-mgmt</td>
<td><p>Workspace name: weu-la</p>
<p>Location: West Europe</p></td>
</tr>
<tr class="even">
<td>Scheduled Log Analytics Query</td>
<td>weu-mgmt</td>
<td><p>Name: weu-la-activityquery</p>
<p>Location: West Europe</p></td>
</tr>
<tr class="odd">
<td>ActionGroup</td>
<td>weu-mgmt</td>
<td>Receiver: {function https url}</td>
</tr>
<tr class="even">
<td>Azure Function</td>
<td>weu-mgmt</td>
<td>Name: weu-mgmt-azf<br />
Location: West Europe</td>
</tr>
<tr class="odd">
<td>Storage Account</td>
<td>weu-mgmt</td>
<td><p>Name: contweumgmtsa01</p>
<p>Location: West Europe</p></td>
</tr>
<tr class="even">
<td>Key Vault</td>
<td>weu-mgmt</td>
<td><p>Name: contweumgmtkv01</p>
<p>Location: West Europe<br />
Secrets: GitWebhookURI, GitPATToken</p></td>
</tr>
<tr class="odd">
<td>Automation account</td>
<td>weu-mgmt</td>
<td><p>Automation account name: weu-aa</p>
<p>Location: West Europe</p></td>
</tr>
</tbody>
</table>

The following policies related to management and monitoring will be assigned in the Contoso production tenant:

<table>
<thead>
<tr class="header">
<th>Policy</th>
<th>Intent</th>
<th>Assignment scope</th>
<th>Result</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>Enforce Log Analytics for platform logging</td>
<td>Ensure infrastructure for logging and security is in place for the Azure platform</td>
<td>Management subscription</td>
<td>Deploys and configures Log Analytics for Contoso's Azure platform</td>
</tr>
<tr class="even">
<td>Deploy LogDispatcher</td>
<td>Ensure infrastructure is in place to forward ActivityLog events to Git</td>
<td>Management Subscription</td>
<td>Resources deployed to weu-mgmt resource group to enable drift detection and reconciliation in Git</td>
</tr>
<tr class="odd">
<td>Enforce Activity Logs</td>
<td>Enable and configure activity logs on every subscription</td>
<td>Contoso management group</td>
<td>Ensures activity logs from all subscriptions are collected centrally</td>
</tr>
<tr class="even">
<td>Enforce VM logging</td>
<td>Ensure all virtual machines are connected to Log Analytics</td>
<td>Landing Zone management group</td>
<td>Every virtual machine deployed into a Landing Zone will have the Log Analytics VM extension installed and be connected to a Log Analytics workspace</td>
</tr>
<tr class="odd">
<td>Enforce Network Watcher</td>
<td>Deploy Network Watcher on all subscriptions with virtual network</td>
<td>Contoso management group</td>
<td>Every subscription with virtual networks will have associated network watchers deployed per region</td>
</tr>
<tr class="even">
<td>Enforce AD Domain Join</td>
<td>Deploys AD domain join VM extension</td>
<td>Corp management group</td>
<td>All VMs within Corp will be connected to Active Directory domain</td>
</tr>
<tr class="odd">
<td>Deny Automation account child resources</td>
<td>Ensure automation account can only be used for central and app-centric VM patching</td>
<td>Management subscription</td>
<td>No one can use the automation account for any other purpose than VM patching</td>
</tr>
<tr class="even">
<td><p>Enforce diagnostics/metrics to platform workspace</p>
<ul>
<li><p>NSG</p></li>
<li><p>Public IP</p></li>
<li><p>vNic</p></li>
<li><p>Recovery Vaults</p></li>
<li><p>Key Vault</p></li>
<li><p>Traffic Manager</p></li>
<li><p>Express Route</p></li>
<li><p>DNS</p></li>
<li><p>App Gateway</p></li>
</ul></td>
<td>Ensure supported resources will ingest telemetry to Log Analytics</td>
<td>Landing Zone management group</td>
<td>All platform-related telemetry is routed to central Log Analytics workspace</td>
</tr>
</tbody>
</table>

## Business continuity and disaster recovery

Core Contoso CAF enterprise-scale landing zone platform components across all regions consider an active-active design; e.g., identity, management, and networking are considered highly available in all regions and can function independently of each other.

Contoso has defined the following BCDR guidelines when applications are moved to Azure, to allow application owners to ensure their applications (either cloud native apps or traditional IaaS workloads) are architected and deployed to meet HA and DR requirements:

### High availability

* Application architectures should be built using a combination of Availability Zones across the North Europe and West Europe paired Azure regions. More specifically, applications and their data should be synchronously replicated across Availability Zones within an Azure region (North Europe) for high-availability purposes, and asynchronously replicated across Azure regions (West Europe) for disaster recovery protection.
* Azure services that provide native replication across Availability Zones should be used as a preference, such as Zone-Redundant Storage and Azure SQL DB.
* Stateless virtual machine workloads should be deployed across multiple instances in Availability Zones behind a Load Balancer standard or Application Gateway (v2).
* Stateful virtual machine workloads should leverage application-level replication across Availability Zones, such as SQL AlwaysOn.
* Stateful virtual machine workloads that do not support application level replication should use Azure Site Recovery Zonal-Replication (preview).

### Disaster Recovery

* Application architectures should use native application replication technologies such as SQL AlwaysOn, for stateful virtual machines in order to replicate data from one Azure region (North Europe) region to the paired Azure region (West Europe).
* Applications should use Azure Site Recovery to replicate stateful virtual machines that do not support application-level replication.
* Stateless virtual machine workloads can be quickly recreated (or pre-provisioned) in the paired Azure region (West Europe). Alternatively, Azure Site Recovery could also be used.
* For externally facing applications that must always be available, an active/active or active/passive deployment pattern across the North Europe and West Europe regions should be used, utilizing either Azure Front Door or Azure Traffic Manager to ensure applications are accessible at all times even if one of the Azure regions is not available.
* Applications should be transformed and modernized where possible to use Azure PaaS services that provide native replication techniques across regions, such as Cosmos DB, Azure SQL DB, and Azure Key Vault.

### Backup

Azure Backup is the native backup solution built into the platform and is recommended to use for all supported services. In cases where it is not supported, other options need to be considered by the application team in charge of the respective landing zone to ensure data consistency and business continuity.  

The platform team will provide a HA/DR baseline for VM backup policies across Azure, which will be deployed to each landing zone through policy. This will ensure that each resource group within a landing zone containing virtual machines has a backup vault and that the backup setting is enabled. Additionally, the platform team will collect backup diagnostic data in the central Log Analytics instance, providing a horizontal view over the entire backup estate.

| Policy                                                                   | Intent                                                          | Assignment scope                 | Result                                                                                                          |
| ------------------------------------------------------------------------ | --------------------------------------------------------------- | -------------------------------- | --------------------------------------------------------------------------------------------------------------- |
| Deploy the backup vault and enforce backup setting for Windows and Linux VMs | Deploy the backup vault and enable backup                           | 'Landing Zones' management group | Every Resource Group with VMs in a landing zone subscription has a backup vault to which all VMs are backed up. |
| Add diagnostic setting to the backup vault                                   | Link backup vault diagnostics to central Log Analytics instance | 'Landing Zones' management group | Platform team has horizontal view over all VM backup                                                            |


Contoso also recognizes the need to add backup capabilities to other resource types other than Virtual Machines. Given the highly specific nature of these backups and the different approaches an application team can take to back up, Contoso does not enforce these settings centrally.

## Security, governance, and compliance

For Contoso to understand what controls must be implemented, and where these controls must be layered in their Azure architecture, they have developed and established a control framework to map their requirements to Azure platform capabilities. The framework principals are data protection, network protection, key management, vulnerability, and least privilege to ensure any whitelisted Azure service can conform to Contoso's enterprise security requirements, which are implemented using Azure Policy, Azure AD PIM, Azure RBAC, Azure Security Center, Azure Sentinel, and Azure Monitor.

Through policy driven management, Contoso's policy implementation will ensure new subscriptions and resources will immediately be brought to their target compliance state. The primary policy effects used by Contoso to achieve this is "deployIfNotExists", "deny", "append", and "modify".

* For "deployIfNotExist" policies, Contoso ensures IaaS and PaaS resources, as well as new subscriptions are compliant during creation regardless of *how* it is being created.

* For "deny" policies, Contoso ensures the appropriate guardrails are in place to avoid misconfigurations, such as accidentally deploying a workload that is not whitelisted and/ot deploying to a region that is not explicitly allowed.

* For "append" policies, Contoso can add the necessary tags to resources without requiring user interaction or input upfront, helping to ensure appropriate cost centers etc. are applied.

* For "modify" policies, Contoso can easily make horizontal changes to the tag metadata on resources in case of organizational changes, expansions, or other factors that may impact the organization of resources.

Contoso's existing Azure subscriptions will initially start with "audit" and "auditIfNotExists" policies to understand the current resource distribution from a compliance perspective, as well as what changes are necessary to bring the existing subscriptions with their resources into the target landing zones.  

From a platform architecture perspective, the principals of Contoso policy implementation will ensure that:

* Platform is autonomous
When a new subscription is created, Azure Policy will automate and ensure requisite plumbing is in place, such as security, networking, logging, and workload-specific policies mapped to Contoso's controls.

* Security is non-negotiable  
Any workload deployed onto Contoso's Azure environment is monitored from a security perspective, and enforcement is in place to ensure data protection, network protection, encryption at-rest, encryption in-transit, and key management. This will reduce any vulnerability scenarios regardless of whether resources are subject to testing in a sandbox subscription, connected to the corporate network or the internet, or any other landing zone.
Contoso will use Compliance view in Azure Policy together with Azure Sentinel workbooks to review and monitor overall compliance and security posture for the tenant.

* Application teams are autonomous  
Contoso's Azure platform doesn't dictate how application teams should use Azure, leaving them free to use any client to interact with, deploy, and manage their applications in their subscriptions, where Azure Policy will guarantee that their applications are deployed in a compliant way by enforcing security, logging, backup, connectivity, and appropriate access.

All of Contoso's policy definitions and policy assignments are treated as source code and will be developed, reviewed, and deployed from their Git repository.

The following policies related to security and governance will be assigned in the Contoso production tenant:

<table>
<thead>
<tr class="header">
<th>Policy</th>
<th>Intent</th>
<th>Assignment scope</th>
<th>Result</th>
</tr>
</thead>
<tbody>
<tr class="even">
<td>Enforce Azure Sentinel</td>
<td>Ensure Azure Sentinel is deployed and configured</td>
<td>Management subscription</td>
<td>Azure Sentinel is configured and deployed to the platform Log Analytics workspace</td>
</tr>
<tr class="odd">
<td>Enforce Azure Security Center</td>
<td>Deploy ASC on every Azure subscription</td>
<td>Contoso management group</td>
<td>All subscriptions will have ASC enabled when they are created</td>
</tr>
<tr class="even">
<td>Enforce Azure Security monitoring</td>
<td>Enable ASC monitoring on every subscription</td>
<td>Contoso management group</td>
<td>All subscriptions will have all the security monitors enabled</td>
</tr>
<tr class="odd">
<td>Enforce Azure Security Center alerts</td>
<td>Enforce consumption of ASC alerts</td>
<td>Contoso management group</td>
<td>All subscriptions will have ASC alerts exported to platform Log Analytics workspace</td>
</tr>
<tr class="even">
<td>Enforce audit of Key Vault</td>
<td>Ensure logging is enabled for Key Vault</td>
<td>Contoso management group</td>
<td>All Key Vaults will have logging enabled, and stored centrally to Log Analytics workspace</td>
</tr>
<tr class="even">
<td>Enforce anti-malware</td>
<td>Ensure all virtual machines have anti-malware enabled</td>
<td>Landing Zone management group</td>
<td>Every virtual machine will have the anti-malware VM extension installed</td>
</tr>
<tr class="even">
<td>Allowed resources</td>
<td>Ensure no resources can be created</td>
<td>Decommission management group</td>
<td>No resources can be deployed to a decommissioned subscription</td>
</tr>
<tr class="odd">
<td>Allowed resources</td>
<td>Ensure no non-relevant resources can be created</td>
<td><p>Management subscription,</p>
<p>Connectivity subscription</p></td>
<td>Only allowed resources can be created in the management and connectivity subscription</td>
</tr>
<tr class="even">
<td>Deny resources</td>
<td>Explicitly deny resources from being created</td>
<td>Landing Zone management group</td>
<td>Azure services that are not whitelisted can't be deployed into a landing zone</td>
</tr>
<tr class="odd">
<td>Enforce Key Vault recovery</td>
<td>Ensure Key Vault objects can be recoverable</td>
<td>Contoso management group</td>
<td>All Key Vault objects are recoverable in Contoso tenant</td>
</tr>
<tr class="even">
<td><p>Enforce Private Link for <a href="https://docs.microsoft.com/azure/private-link/private-link-overview#availability"> Azure Services </a> </p>
<ul>
<li><p>Storage</p></li>
<li><p>ADLS Gen2</p></li>
<li><p>SQL DB</p></li>
<li><p>Synapse</p></li>
<li><p>Cosmos DB</p></li>
<li><p>PostgreSQL</p></li>
<li><p>MySQL</p></li>
<li><p>MariaDB</p></li>
<li><p>Key Vault</p></li>
</ul>
<p>AKS (API)</p></td>
<td>Ensure Private Link is used for all supported Azure services</td>
<td>Landing Zone management group</td>
<td> <a href='https://docs.microsoft.com/azure/private-link/private-link-overview#availability'> Supported Azure services </a> always use Private Link to communicate to PaaS service over the vNet</td>
</tr>
</tbody>
</table>

From an identity and access perspective, Contoso will develop their own custom RBAC roles to ensure the appropriate permissions (actions/notActions) for control plane and data plane access are available for the right persona at the right scope in the Azure hierarchy. This will be subject to just-in-time access with multi-factor authentication for all high-privileged roles. Contoso will use Azure AD reporting capabilities to generate access control audit reports.

## Platform automation and DevOps

### Contoso - roles and responsibilities

Contoso has acknowledged that their existing on-premises operating model requires change to ensure they maximize the benefits of the cloud. They've decided to create a Platform Operations team to oversee execution of CAF enterprise-scale landing zone architecture and be accountable for the company's Azure Platform. This Platform team will have representations from the following IT functions:

<table>
<thead>
<tr class="header">
<th>Role Name</th>
<th>Description</th>
</tr>
</thead>

<tbody>

<tr class="even">
<td>Systems Ops</td>
<td><p>Make AppOps and DevOps teams effectively through a federated delegation model that is governed centrally; e.g., monitoring, patching, and backups and taking corrective, centralized action when necessary</p>
<p>Manage platform-wide monitoring and alerts, align with Azure, and schedule maintenance events</p>
<p>Author and assign Azure Policy to set up and manage VM/OS standards</p></td>
</tr>

<tr class="odd">
<td>Security Ops</td>
<td><p>Define an Azure Platform baseline to ensure compliance of security requirements and controls are met</p>
<p>Create policy compliance and security dashboards for organizational and resource-centric views</p>
<p>Define a break glass/emergency process to grant and revoke access</p>
<p>Manage platform keys and secrets</p>
<p>Security policy remediation and compliance initiatives</p></td>
</tr>
<tr class="even">
<td>Automation</td>
<td><p>Develop and maintain DevOps pipeline and standards</p>
<p>Develop and maintain business processes and integration points (such as CMDB etc.)</p>
<p>Support the team's use of the DevOps pipeline and standards</p>
<p>Support the team to develop SME-specific artifacts</p></td>
</tr>
<tr class="odd">
<td>Network Ops</td>
<td><p>Network design, deployment, configuration, and management</p>
<p>Manage inbound, outbound, and east-west networking flows</p>
<p>Manage routing and network segregation within Azure virtual networks and hybrid connectivity</p>
<p>Network troubleshooting</p>
<p>Azure network monitoring and auditing</p>
<p>Performance metrics and counters</p>
<p>Network forensics</p></td>
</tr>
<tr class="even">
<td><p>Identity and</p>
<p>Access</p>
<p>Management</p></td>
<td><p>Establish organizational relationship between Azure AD and Azure Subscriptions in the Enterprise Portal</p>
<p>Manage IAM entitlements and Role definitions for Management Groups and Subscriptions</p>
<p>Manage Azure AD Applications, Service Principles, and Azure AD Application Proxies; registration of Service Principles and Applications with configured delegation</p>
<p>Windows Server Active Directory administration</p>
<p>Define and manage JML for AD and Azure AD users and groups for Azure IAM</p>
<p>Manage MFA sign-in for the Azure control plane and data plane access</p></td>
</tr>
<tr class="odd">
<td>Management</td>
<td><p>Manage management groups and subscription lifecycles</p>
<p>Resource provider registration</p>
<p>Manage Azure policy definitions and assignments at management-group level and subscription levels</p>
<p>Create Dashboard and Management views for Application centric and Platform Centric management, monitoring, and policy compliance</p>
<p>Enable auxiliary functions on the Azure platform, such as Cost Management and Azure Advisor</p></td>
</tr>
<tr class="even">
<td>Enablement</td>
<td><p>Support the onboarding of application teams to the platform</p>
<p>Develop reusable artifacts to accelerate application team onboarding such as templates</p>
<p>Collect, compile, and manage feedback to improve the platform</p></td>
</tr>
</tbody>
</table>

### Contoso platform DevOps

Contoso will use the CAF enterprise-scale landing zone Git repo for Infrastructure-as-code (IaC) and instantiate their Management Group and Subscription hierarchy using the tenant level Azure Resource Manager template deployment examples provided within the CAF enterprise-scale landing zone repo. This repository is used for bootstrapping and managing their entire platform and hence will require access permissions for service principle at a tenant root scope. To simplify RBAC and management of client secrets for service principles, Contoso will use a single-service principle scoped at the tenant root scope, which will have access to all resources inside a tenant. This account is the highest-privileged account, and no user will have direct access to the secrets of this service account.

**Initialization**

Before starting the CAF enterprise-scale landing zone journey, Contoso will discover existing configuration in Azure that can serve as a platform baseline. The consequence of not discovering the existing environment will be no reference point to roll back or forward after  deployment. Initialization is also important since it can provide a crucial on-ramp path to infrastructure-as-code and allow transitioning without starting over. For the purpose of initialization, the following resources are considered within the scope of the overall Azure platform.
This will initialize an empty Git repo with the current configuration establish a baseline configuration encompassing the following:

* Management group hierarchy and subscription organization
  * Resource types:
    * Microsoft.Management/managementGroups
    * Microsoft.Management/managementGroups/subscriptions
    * Microsoft.Subscription/subscriptions
* Policy definition and policy assignment for governance
  * Resource types:
    * Microsoft.Authorization/policyDefinitions
    * Microsoft.Authorization/policyAssignments
* Role definition and assignment
  * Resource types:
    * Microsoft.Authorization/roleDefinitions
    * Microsoft.Authorization/roleAssignments

Contoso will default to a platform schema that represents these configurations in Git, which involves calling Azure APIs using PowerShell.

**Deployment**

Contoso's infrastructure as code Git repo will have hundreds if not thousands of artifact-tracked and version-controlled configurations. Platform developers will be modifying a very small subset of these artifacts on an ongoing basis via pull requests. Since Git represents the source of truth and change history, Contoso will optimize Git to determine differential changes in each pull request and trigger subsequent Azure deployment actions for only those artifacts that have been changed rather than for all artifacts.

**Operationalize**

In production environment, operational changes are bound to happen. Ideally Contoso will ensure changes are made in a structured way, using the principles of Infrastructure-as-code (IaC): A change would be made by adding or updating template within the Git repository, relying on an automated test and release process to deploy required operational changes.

However, manual changes (e.g., those made using the Azure portal) may be unavoidable due to urgent operational demands. This leads to 'Configuration Drift', where the environment as described in source control no longer reflects the actual state of the Azure resources. To deal with this situation, CAF enterprise-scale landing zone envisions not only a control mechanism to push changes within the IaC source to the Azure environment, but also to pull changes made outside IaC back into source control.  

By establishing a feedback loop we can ensure that:

* The environment described in source control always reflects the actual state of Azure subscriptions.
* Changes made manually are not inadvertently rolled back by the next automated deployment of a resource.

Through Azure Policy, changes to the Azure resources within the Contoso management group scope are captured within the Log Analytics instance in the management subscription. A Log Search Alert will notify Git by activating a webhook if a resource configuration is updated or modified so that resource state will be exported and made available as a pull\_request (PR) for review. This will allow repo owners to control whether to roll the change forward by merging the PR or roll it back by making new configuration changes to override the out-of-band configuration change.
