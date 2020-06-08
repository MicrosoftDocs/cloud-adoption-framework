---
title: Scope
description: Scope
author: BrianBlanchard
ms.author: brblanch
ms.date: 05/20/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

<!-- cSpell:ignore AppOps NetOps SecOps OIDC subscopes subresources -->

# Scope

Contoso is a corporation business with headquarters (HQ) in London, UK. Contoso senior leadership has mandated a cloud-first approach, with an overarching strategy to gradually reduce the on-premises datacenter footprint. Contoso has chosen Microsoft Azure as their preferred public cloud provider. Since they have a large overall IT estate and need to migrate their applications, they're concerned about the velocity of workload transformation/migration and how to best establish landing zones for application teams.

Contoso has discovered enterprise-scale architecture, which provides a forward-looking and Azure-native design approach. The Contoso IT leadership team is committed to this approach, and they believe it'll provide secure and streamlined operations, management, and governance across the entire Contoso platform on Microsoft Azure while also allowing legacy and modern apps to move seamlessly at their own pace.

## Contoso architecture

### Enterprise enrollment and Azure Active Directory (Azure AD) tenants

Contoso has opted for simpler Azure Enterprise Agreement design with a single department and multiple Enterprise Agreement accounts. Each Enterprise Agreement account will have an associated service principal account by configuring identity and access management (IAM) permissions as part of the automated subscription provisioning process.

Contoso has three separate Azure AD tenants for development (dev), testing (test), and production, and Azure AD Connect is already in place for the production Azure AD tenant. The dev and test tenants are used for Office 365 validation, and there isn't a requirement to separate identities at the Azure-AD-tenant level across dev, test, and production environments in Azure. Contoso will only use the production Azure AD tenant for Azure access. Additional controls will be in place for networking (isolation), and identity (segregation of duties) to guarantee separation between dev, test, and production workloads. All subscriptions, including all sandbox subscriptions, are considered as production from a networking and identity perspective.

### Identity and access management

Contoso wants to ensure zero standing access for production environments across all Azure control-plane access, and they'll use Azure AD Privileged Identity Management (PIM) to ensure just-in-time control plane access to Azure resources. Contoso will create custom role definitions&mdash;platform owner, NetOps, SecOps, landing zone owner, and AppOps/DevOps&mdash;in accordance with enterprise-scale roles, and they'll be supported by the operating model for the Azure platform.

The identity team will create an Azure-AD-only group for each of the roles above and make a landing zone owner/requestor an owner of the group before creating entitlements for those groups in Azure AD PIM. Those who require to access to Azure resources will be able to search for the Azure AD group by name and use the Azure AD self-service group management capability to join a group. Group owners can determine whether to approve or deny a user request based on an eligibility criteria.

<!-- markdownlint-disable MD033 -->

| Azure AD group name                    | Scope                    | PIM role           |
|-----------------------------------|--------------------------|--------------------|
| <subscription-name>-Owner   | Subscription             | Landing zone owner |
| \<subscription-name>-DevOps | Subscription             | DevOps             |
| <subscription-name>-AppOps | Subscription             | AppOps             |
| SecOps                            | Contoso management group | SecOps             |
| <subscription-name>-NetOps | Contoso management group | NetOps             |
| Platform owner                    | Tenant root (`/`)        | Owner (built-in)   |

<!-- markdownlint-enable MD033 -->

Azure AD will be the primary identity provider where apps support modern federation protocols such as OIDC, SAML, or WS-Fed. Regional domain controllers will be deployed in the `identity` subscription to support scenarios where legacy authentication (LDAP/Kerberos) is required.

### Management group and subscription organization

Contoso is designing their management group hierarchy and subscription organization to optimize for scale, enabling autonomy for the platform and application teams to evolve alongside business requirements. The subscription naming convention will be `tla-of-the-business-unit` followed by `workload-type`, `region`, `workload-name`, and `unique-number` (for example, `fin-prod-neu-payroll-01` and `fin-prod-weu-payroll-01`).

Contoso has decided to use subscriptions with geographic affinity to simplify networking and connectivity. Workloads that do require multiple regions will have at least one subscription for each region, including ones for business continuity and disaster recovery purposes.

Contoso has decided to use Azure resource tags for billing and chargeback instead of blending a cost-management structure within the management group and subscription hierarchy. This will provide horizontal capabilities to query costs across multiple subscriptions. Tags such as department and cost center required for billing will be enforced by the policy at the landing zone management group scope.

![Contoso management group structure](../media/contoso-mg-structure.png)
_Figure 1: Contoso management group structure_

#### Management groups

**Tenant root group:**

The default root management group will not be used directly, allowing for greater flexibility in the future to incorporate an equivalent test environment for their end-to-end Azure architecture.

**Contoso:**

This is the top-level management group implemented within Contoso's Azure tenant, and it will serve as the container for all custom role definitions, policy definitions, and Contoso global policy assignments; it will have minimal direct role assignments. For policy assignments at this scope, the target state is to ensure security and autonomy for the platform when additional subscopes such as child management groups and subscriptions are created.

**Landing zones:**

All business units will create their subscriptions within landing zone management group child management groups. This allows for a generic yet granular approach to policy assignments, and it easily separates active landing zones from sandbox and decommissioned subscriptions.

**Corporate, online, and SAP:**

Contoso has identified the three common archetypes that they'll migrate/deploy to Azure, and they've developed policies to ensure that the appropriate guard rails are in place for each landing zone created for these management groups.

For each created subscription, Azure Policy will require tags to identify ownership, billing, and chargeback.

- Corporate landing zones will include all virtual networks (VNets) that don't expose public endpoints and require connectivity to on-premises and other landing zones.
- Online landing zones include all VNets that have internet-facing apps via an Azure Application Gateway (v2).
- SAP represents a workload that merits separation, given the implied specialization.

**Sandbox:**

App teams and individual users within Contoso wanting to test and explore Azure services will have subscriptions created within the sandbox management group. In this group, policies are in place to ensure that control planes or data plane paths aren't in production environments.

**Decommission:**

All canceled subscriptions will be moved under this management group by Azure Policy, and they'll be deleted after 60 days.

#### Platform subscriptions

**Connectivity:**

A dedicated subscription for centrally managed networking infrastructure will control end-to-end connectivity for all landing zones within Contoso's Azure platform. Azure resources that deployed into this subscription include:

- Azure Virtual WAN and its subresources (virtual hubs and gateways)
- Azure firewalls
- Firewall policies
- Azure Private Domain Name System (DNS) zones

The `connectivity` subscription has the tag `BusinessUnit` with the value `platform`.

**Identity:**

The `identity` subscription will be used to host virtual machines (VMs) running Windows Server Active Directory. There will be at least two domain controllers deployed per Azure region for redundancy purposes and to ensure that regions are independent if a regional outage occurs. Active Directory replication will ensure that all domain controllers are in sync.

**Management:**

A dedicated subscription is for centrally managed platform infrastructure and ensures a holistic, at-scale management capability across all landing zones in Contoso's Azure platform.

The `management` subscription has the tag `BusinessUnit` with the value `platform`.

The following policies are related to management group hierarchy, and subscription organization will be assigned within the Contoso production tenant:

| Policy                                            | Intent                                                        | Assignment scope              | Result                                                                                          |
|---------------------------------------------------|---------------------------------------------------------------|-------------------------------|-------------------------------------------------------------------------------------------------|
| Enforce subscription naming convention            | Ensure all to the naming convention    | Contoso management group      | All subscriptions have valid naming convention                                                  |
| Enforce subscription budget                       | Ensure all subscriptions have a budget associated             | Contoso management group      | No subscription will allow unlimited spending                                                   |
| Enforce subscription tags                         | Ensure all subscriptions have the required tags               | Contoso management group      | All subscriptions are tagged properly to identify business unit owner, intent, and cost center. |
| Move canceled subscriptions                       | Ensure canceled subscriptions are moved from landing zone    | Landing zone management group | Any subscription that gets canceled will be moved to the decommission management group         |
| Allowed regions for resource groups and resources | Ensure all resources are created in the designated regions    | Contoso management group      | All resources are compliant per their location                                                  |
| Assign region policy per subscription             | Ensure subscriptions get policy with correct regions assigned | Contoso management group      | Subscriptions will support regions per their naming convention                                  |

## Network topology and connectivity

Contoso has a presence across Europe and North America, and its HQ is in London, UK. Contoso also has regional HQ offices in Amsterdam and Chicago. There are approximately 500 Contoso branch offices across the US and Europe, with each branch office containing customer-premises equipment connected to the local, regional HQ via site-to-site virtual private network (VPN).

Contoso has decided to adopt enterprise-scale recommendations for building their network architecture in Azure. Key decisions they have adopted include:

1. Deploying a Microsoft-managed network in Azure using Virtual WAN to connect all Azure and on-premises locations around the world.
2. Using ExpressRoute Global Reach to interconnect corporate HQs with regional hubs.
3. Moving away from their traditional demilitarized zone model and adopt a zero-trust network model.
4. Allowing full subscription democratization by granting landing zone owners rights to create subnets within their landing zones to suit their app needs while ensuring the platform maintains compliance and security, as defined by the SecOps team.

Contoso's network design based on enterprise-scale design principles is depicted in the picture shown below:

![Network topology](../media/image5.png)
_Figure 2: Network topology._

With this network design, the following scenarios are possible for Contoso:

- Regional HQ offices connect to Azure via ExpressRoute.
- Branch offices connect to Azure via VPN (site-to-site IP security tunnels).
- Landing zone VNets connect to the regional Virtual WAN VHub.
- Regional HQs connect to each other via ExpressRoute with global reach.
- Regional HQs connect to branch offices via Virtual WAN.
- Regional HQs and branch offices connect to Azure Virtual Network via Virtual WAN.
- Using Azure Firewall within the virtual WAN VHub secures internet-outbound connectivity from the virtual network.

Contoso decided to deploy a Microsoft-managed, Virtual WAN-based network topology in order to support global interconnectivity between on-premises and Azure, plus a large number of branches that need to connect to Azure. The following diagram depicts the required Azure resources that must be deployed inside the `connectivity` subscription to support Contoso's global Azure network:

![Connectivity subscription](../media/image7.png)

In order to simplify the routing configuration across the entire Azure networking platform, Contoso has assigned the following IP address spaces for Virtual WAN virtual hubs and virtual networks:

- North Europe: `10.1.0.0/16`
- West Europe: `10.2.0.0/16`
- North Central US: `10.3.0.0/16`

Since Contoso must support three Azure regions⁠ (North Europe, West Europe, and North Central US⁠), they've documented the resources and parameters required for the platform to be deployed via Azure Policy and alignment with enterprise-scale guidance. More specifically, all these resources will be deployed within the `connectivity` subscription and enforced by `DeployIfNotExists` policies.

<!-- markdownlint-disable MD033 -->

North Europe:

<table>
<thead>
<tr class="header">
<th>Resource</th>
<th>Resource group</th>
<th>Parameters</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>Virtual WAN</td>
<td>Contoso-global-WAN</td>
<td><p>VWAN name: contoso-vwan</p>
<p>Location: North Europe</p></td>
</tr>
<tr class="even">
<td>Virtual hub</td>
<td>Contoso-global-WAN</td>
<td><p>Virtual WAN: contoso-vwan</p>
<p>Location: North Europe</p>
<p>VHub name: contoso-vhub-neu</p>
<p>VHub address space: 10.1.0.0/24</p>
<p>ExpressRoute Gateway: Yes (1 scale unit) </p>
<p>VPN Gateway: Yes (2 scale units) </p></td>
</tr>
<tr class="odd">
<td>Azure Firewall policy</td>
<td>Contoso-fw-policies</td>
<td><p>Firewall Policy name: contoso-fw-policy-global</p>
<p>Outbound rules: (as required, for example, allow outbound traffic to *.microsoft.com) </p></td>
</tr>
<tr class="even">
<td>Azure Firewall</td>
<td>Contoso-global-WAN</td>
<td>Virtual hub name: contoso-vhub-neu</td>
</tr>
<tr class="odd">
<td>Azure Private DNS</td>
<td>Contoso-global-DNS</td>
<td>Private DNS zone name: azure.contoso.com</td>
</tr>
<tr class="even">
<td>Azure DDoS standard</td>
<td>Contoso-global-DDoS</td>
<td><p>Name: contoso-ddos-std-plan</p>
<p>Region: North Europe</p></td>
</tr>
<tr class="odd">
<td>ExpressRoute circuit</td>
<td>Contoso-er-circuits</td>
<td><p>ExpressRoute resource ID:</p>
<p>/subscriptions/&lt;subscription-id&gt;/resourceGroups/&lt;resourcegroup-name&gt;/providers/Microsoft.Network/expressRouteCircuits/&lt;er-circuit-name&gt;</p>
<p>ExpressRoute authorization key:XXXXXXXXXXXX</p></td>
</tr>
<tr class="even">
<td>Network Watcher</td>
<td>Networkwatcherrg</td>
<td>Location: North Europe</td>
</tr>
</tbody>
</table>

West Europe:

<table>
<thead>
<tr class="header">
<th>Resource</th>
<th>Resource group</th>
<th>Parameters</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>Virtual hub</td>
<td>Contoso-global-WAN</td>
<td><p>Virtual WAN: contoso-vwan</p>
<p>Location: West Europe</p>
<p>VHub name: contoso-vhub-weu</p>
<p>VHub address space: 10.2.0.0/24</p>
<p>ExpressRoute Gateway: Yes (1 scale unit) </p>
<p>VPN Gateway: Yes (2 scale units) </p></td>
</tr>
<tr class="even">
<td>Azure Firewall policy</td>
<td>Contoso-fw-policies</td>
<td><p>Firewall Policy name: contoso-fw-policy-weu</p>
<p>Outbound rules: (as required, for example, allow outbound traffic to *.microsoft.com) </p></td>
</tr>
<tr class="odd">
<td>Azure Firewall</td>
<td>Contoso-global-WAN</td>
<td>Virtual hub name: contoso-vhub-weu</td>
</tr>
<tr class="even">
<td>ExpressRoute circuit</td>
<td>Contoso-er-circuits</td>
<td><p>ExpressRoute resource ID:</p>
<p>/subscriptions/&lt;subscription-id&gt;/resourceGroups/&lt;resourcegroup-name&gt;/providers/Microsoft.Network/expressRouteCircuits/&lt;er-circuit-name&gt;</p>
<p>ExpressRoute authorization key:XXXXXXXXXXXX</p></td>
</tr>
<tr class="odd">
<td>Network Watcher</td>
<td>Networkwatcherrg</td>
<td>Location: West Europe</td>
</tr>
</tbody>
</table>

North Central US:

<table>
<thead>
<tr class="header">
<th>Resource</th>
<th>Resource group</th>
<th>Parameters</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>Virtual hub</td>
<td>Contoso-global-WAN</td>
<td><p>Virtual WAN: contoso-vwan</p>
<p>Location: North Central US</p>
<p>VHub name: contoso-vhub-ncus</p>
<p>VHub address space: 10.3.0.0/24</p>
<p>ExpressRoute Gateway: Yes (1 scale unit) </p>
<p>VPN Gateway: Yes (2 scale units) </p></td>
</tr>
<tr class="even">
<td>Azure Firewall policy</td>
<td>Contoso-fw-policies</td>
<td><p>Firewall Policy name: contoso--fw-policy-ncus</p>
<p>Outbound rules: (as required, for example, allow outbound traffic to *.microsoft.com) </p></td>
</tr>
<tr class="odd">
<td>Azure Firewall</td>
<td>Contoso-global-WAN</td>
<td>Virtual hub name: Contoso-virtual hub-ncus</td>
</tr>
<tr class="even">
<td>ExpressRoute circuit</td>
<td>Contoso-er-circuits</td>
<td><p>ExpressRoute resource ID:</p>
<p>/subscriptions/&lt;subscription-id&gt;/resourceGroups/&lt;resourcegroup-name&gt;/providers/Microsoft.Network/expressRouteCircuits/&lt;er-circuit-name&gt;</p>
<p>ExpressRoute authorization key:XXXXXXXXXXXX</p></td>
</tr>
<tr class="odd">
<td>Network Watcher</td>
<td>Networkwatcherrg</td>
<td>Location: North Central US</td>
</tr>
</tbody>
</table>

The following networking policies will be assigned in the Contoso production tenant:

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
<td>Enforce virtual network</td>
<td>Ensure all landing zones have a virtual network</td>
<td>Landing zone management group</td>
<td>All landing zones have a virtual network</td>
</tr>
<tr class="even">
<td>Enforce virtual network connectivity</td>
<td>Ensure all landing zones are connected to the connectivity subscription</td>
<td>Contoso management group</td>
<td>All virtual networks are configured and connected per the desired state</td>
</tr>
<tr class="odd">
<td>Deny IP forwarding on NIC</td>
<td>Ensure IP forwarding cannot be enabled</td>
<td>Landing zone management group</td>
<td>No IP forwarding enabled in landing zones</td>
</tr>
<tr class="even">
<td>Deny inbound RDP/SSH on NSGs</td>
<td>Ensure NSGs can't open RDP/SSH from internet</td>
<td>Landing zone management group</td>
<td>No inbound traffic from internet on management ports</td>
</tr>
<tr class="odd">
<td>Enforce NSG on every subnet</td>
<td>Enforce default NSG is always associated to subnet</td>
<td>Landing zone management group</td>
<td>No subnets without NSGs.</td>
</tr>
<tr class="even">
<td>Enable NSG flow logs</td>
<td>Ensure NSG flow logs are being captured</td>
<td>Landing zone management group</td>
<td>No NSG without NSG flow logs</td>
</tr>
<tr class="odd">
<td>Enforce UDR on virtual network injected services subnet</td>
<td>Enforce UDR for direct communication with virtual network injected PaaS services management plane IPs</td>
<td>Landing zone management group</td>
<td>Control plane traffic for virtual network injected PaaS services works properly bypassing the default route</td>
</tr>
<tr class="even">
<td>Onboard virtual network in DDoS standard plan</td>
<td>Ensure virtual networks that will have public IP addresses are onboarded into a DDoS std protection plan</td>
<td>Online management group</td>
<td>All virtual networks with public IP addresses are protected against DDoS attacks</td>
</tr>
<tr class="odd">
<td>Ensure WAF policies are enabled on appgw</td>
<td>Ensure all appgws have WAF policies enabled</td>
<td>Online management group</td>
<td>All appgws deployed are protected with WAF</td>
</tr>
</tbody>
</table>

<!-- markdownlint:enable MD033 -->

## Management and monitoring

Contoso will employ a monitoring strategy where the central team will be responsible for all-up platform logging, security, and networking, and they'll use Azure-native services such as Azure Monitor Logs, Monitor, Security Center, Sentinel, and Network Watcher. All core management infrastructure will exist inside the dedicated `management` subscription and will be deployed and governed by Azure Policy; the requisite configuration for workloads and subscriptions will be driven through Azure Policy as new subscriptions and resources are being created. The following diagram depicts the required Azure resources that must be deployed within the `management` subscription to support Contoso's platform management and monitoring:

![Monitoring subscription](../media/image9.png)
_Figure 3: Monitoring subscription._

Since Contoso has selected West Europe as their primary Azure region, they'll use a single Azure Monitor Log Analytics workspace within West Europe for centralized platform management, which will also act as the hub for all security and networking data across their Azure platform. With this design and implementation, they'll achieve:

- A single, central, and horizontal view of the platform across security, auditing, and networking, all enforced by Azure Policy and `DeployIfNotExists`.
  - Consume security data centrally from all subscriptions.
  - Consume networking data centrally from all regions and subscriptions where networks are deployed.
- Granular data retention per data table in Azure Monitor logs.
- Resource-centric and granular role-based access controls (RBAC) for application teams to access their monitoring data.
- At-scale emergency VM patching as well as granular VM patching for application teams per RBAC.
- Centralized alerting from a platform perspective.
- Centralized, interactive Azure dashboards through the lenses of networking, security, and overall platform health.

Contoso has documented the resources and parameters that it requires so that the platform can be managed and monitored via policy as per enterprise-scale guidance. All these resources will be deployed in the `management` subscription.

<table>
<thead>
<tr class="header">
<th>Resource</th>
<th>Resource group</th>
<th>Parameters</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>Azure Monitor Log Analytics workspace</td>
<td>Weu-mgmt</td>
<td><p>Workspace name: weu-la</p>
<p>Location: West Europe</p></td>
</tr>
<tr class="even">
<td>Scheduled Azure Monitor Logs query</td>
<td>Weu-mgmt</td>
<td><p>Name: weu-la-activityquery</p>
<p>Location: West Europe</p></td>
</tr>
<tr class="odd">
<td>Actiongroup</td>
<td>Weu-mgmt</td>
<td>Receiver: {function https URL}</td>
</tr>
<tr class="even">
<td>Azure function</td>
<td>Weu-mgmt</td>
<td>Name: Weu-mgmt-azf<br>
Location: West Europe</td>
</tr>
<tr class="odd">
<td>Storage account</td>
<td>Weu-mgmt</td>
<td><p>Name: contweumgmtsa01</p>
<p>Location: West Europe</p></td>
</tr>
<tr class="even">
<td>Key Vault</td>
<td>Weu-mgmt</td>
<td><p>Name: contweumgmtkv01</p>
<p>Location: West Europe<br>
Secrets: gitwebhookuri, gitpattoken</p></td>
</tr>
<tr class="odd">
<td>Automation account</td>
<td>Weu-mgmt</td>
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
<td>Enforce Azure Monitor Logs for platform logging</td>
<td>Ensure infrastructure for logging and security is in place for the Azure platform</td>
<td>Management subscription</td>
<td>Deploys and configures Azure Monitor Logs for Contoso's Azure platform</td>
</tr>
<tr class="even">
<td>Deploy logdispatcher</td>
<td>Ensure infrastructure is in place to forward activitylog events to Git</td>
<td>Management subscription</td>
<td>Resources deployed to weu-mgmt resource group to enable drift detection and reconciliation in Git</td>
</tr>
<tr class="odd">
<td>Enforce activity logs</td>
<td>Enable and configure activity logs on every subscription</td>
<td>Contoso management group</td>
<td>Ensures activity log from all subscriptions is collected centrally</td>
</tr>
<tr class="even">
<td>Enforce VM logging</td>
<td>Ensure all virtual machines are connected to Azure Monitor Logs</td>
<td>Landing zone management group</td>
<td>Every VM deployed into a landing zone will have the Azure Monitor Logs VM extension installed and be connected to an Azure Monitor Log Analytics workspace</td>
</tr>
<tr class="odd">
<td>Enforce Network Watcher</td>
<td>Deploy Network Watcher on all subscriptions with virtual network</td>
<td>Contoso management group</td>
<td>Every subscription with virtual networks will have associated network watchers deployed per region</td>
</tr>
<tr class="even">
<td>Enforce ad domain join</td>
<td>Deploys ad domain join VM extension</td>
<td>Corp management group</td>
<td>All VMs within corp will be connected to Active Directory domain</td>
</tr>
<tr class="odd">
<td>Deny automation account child resources</td>
<td>Ensure automation account can only be used for central &AMP; app-centric VM patching</td>
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
<li><p>KeyVault</p></li>
<li><p>Traffic Manager</p></li>
<li><p>Express Route</p></li>
<li><p>DNS</p></li>
<li><p>App Gateway</p></li>
</ul></td>
<td>Ensure supported resources will ingest telemetry to Azure Monitor Logs</td>
<td>Landing zone management group</td>
<td>All platform-related telemetry is routed to central Azure Monitor Log Analytics workspace</td>
</tr>a
</tbody>
</table>

## Business continuity and disaster recovery

Core Contoso enterprise-scale platform components across all regions consider an active-active design such as identity, management, and networking as highly available in all regions and functional independent of each other.

Contoso has defined the following business continuity and disaster guidelines for moving apps to Azure in order to allow app owners to ensure that their apps, whether cloud-native apps or traditional infrastructure-as-a-service (IaaS) workloads, are architected and deployed to meet requirements for high availability and disaster recovery.

### High availability

- App architectures should be built with a combination of availability zones across North and West Europe paired Azure regions. More specifically, apps and their data should be synchronously replicated across availability zones within an Azure region (North Europe) for high-availability purposes and asynchronously replicated across Azure regions (West Europe) for disaster recovery protection.
- Azure services that provide native replication across availability zones should be used as a preference, such as zone-redundant storage and Azure SQL db.
- Stateless VM workloads should be deployed across multiple instances in availability zones behind a load balancer standard or app gateway (v2).
- Stateful VM workloads should use app-level replication across availability zones, such as SQL AlwaysOn.
- Stateful VM workloads that don't support app-level replication should use Azure Site Recovery zonal-replication (preview).

### Disaster recovery

- App architectures should use native app replication technologies such as SQL AlwaysOn for stateful VMs in order to replicate data from one Azure region (North Europe) region to the paired Azure region (West Europe).
- Apps should use Azure Site Recovery to replicate stateful VMs that don't support app-level replication.
- Stateless VM workloads can be quickly recreated (or preprovisioned) in the paired Azure region (West Europe). Alternately, Azure Site Recovery could also be used.
- For externally facing apps that must always be available, an active/active or active/passive deployment pattern across the North Europe and West Europe regions should be used, utilizing either Azure front door or Azure Traffic Manager to ensure apps are accessible at all times even if one of the Azure regions isn't available.
- Apps should be transformed and modernized where possible to use Azure platform-as-as-service (PaaS) services that provide native replication techniques across regions, such as Azure Cosmos DB, SQL Database, and Key Vault.

### Backup

Azure Backup is the native backup solution built into the platform and is recommended to use for all supported services. In cases where it's not supported, the app team in charge of the respective landing zone needs to consider other options need to ensure data consistency and business continuity.

The platform team will provide a high-availability/disaster recovery baseline for VM backup policies across Azure, which will be deployed to each landing zone through policies. This will ensure that each resource group within a landing zone containing VMs has a backup vault and that the backup setting is enabled. Additionally, the platform team will collect backup diagnostic data in the central Azure Monitor Logs instance, providing a horizontal view over the entire backup estate.

| Policy                                                                   | Intent                                                          | Assignment scope                 | Result                                                                                                          |
| ------------------------------------------------------------------------ | --------------------------------------------------------------- | -------------------------------- | --------------------------------------------------------------------------------------------------------------- |
| Deploy backup vault and enforce backup setting for Windows and Linux VMs | Deploy backup vault and enable backup                           | Landing zone's management group | Every resource group with VMs in a landing zone subscription has a backup vault to which all VMs are backed up. |
| Add diagnostic setting to a backup vault                                   | Link backup vault diagnostics to a central Azure Monitor Logs instance | Landing zone's management group | The platform team has a horizontal view over all VM backups                                                            |

Contoso also recognizes the need to add backup capabilities to other resource types other than VMs. Given the highly specific nature of these backups and the different approaches an app team can take to do this, Contoso doesn't enforce these settings centrally.

## Security, governance, and compliance

For Contoso to understand what controls must be implemented and where these controls must be layered in their Azure architecture, they've developed and established a control framework to map their requirements to Azure platform capabilities. The framework principles are data protection, network protection, key management, vulnerability, and least privilege to ensure for whitelisted Azure service to conform to Contoso's enterprise security requirements, which are implemented using Azure Policy, AD PIM, RBAC, Security Center, Sentinel, and Monitor.

Through policy-driven management, Contoso's policy implementation will ensure that new subscriptions and resources quickly achieve their target compliance state. The primary policy effects used by Contoso to achieve this are `DeployIfNotExists`, `Deny`, `Append`, and `Modify`.

- For `DeployIfNotExists` policies, Contoso ensures that IaaS and PaaS resources and new subscriptions are compliant during creation regardless of how it's created.

- For `Deny` policies, Contoso ensures that appropriate guard rails are in place to avoid misconfigurations such as accidentally deploying a workload that isn't whitelisted and/or deploying to a region that isn't explicitly allowed.

- For `Append` policies, Contoso can add tags to resources without requiring user interaction or input upfront, helping to ensure that appropriate cost centers are applied.

- For `Modify` policies and in case of organizational changes, expansions, or other factors that may affect how resources are organized, Contoso can make horizontal changes to tagged metadata on resources.

Contoso's existing Azure subscriptions will initially start with `Audit` and `AuditIfNotExists` policies to understand the current resource distribution from a compliance perspective, as well as what changes are necessary to bring the existing subscriptions with their resources into the target landing zones.

From a platform architecture perspective, Contoso's policy implementation principles will ensure that:

- **The platform is autonomous.** When a new subscription is created, Azure Policy will automate and ensure that necessary plumbing such as security, networking, logging, and workload-specific policies mapped to Contoso's controls are in place.

- **Security is nonnegotiable:** Any workload deployed onto Contoso's Azure environment is monitored from a security perspective, and enforcement is in place to ensure data protection, network protection, encryption at-rest and in-transit, and key management. This will reduce vulnerability scenarios regardless of whether resources are subject to testing in a sandbox subscription or if they're connected to the corporate network, the internet, or any other landing zone. Contoso will use Compliance View in Azure Policy with Azure Sentinel workbooks to review and monitor the tenant's overall compliance and security posture.

- **App teams are autonomous:** Contoso's Azure platform doesn't dictate how application teams should use Azure, leaving them free to use any client to interact with, deploy, and manage their apps in their subscriptions. Azure Policy will support their apps to be deployed in a compliant way by enforcing security, logging, backup, connectivity, and appropriate access.

All of Contoso's policy definitions and assignments are treated as source code, and will be developed, reviewed, and deployed from their Git repo.

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
<td>Azure Sentinel is configured and deployed to the platform Azure Monitor Log Analytics workspace</td>
</tr>
<tr class="odd">
<td>Enforce Azure Security Center</td>
<td>Deploy Azure Security Center on every Azure subscription</td>
<td>Contoso management group</td>
<td>All subscriptions will have Azure Security Center enabled when they're created</td>
</tr>
<tr class="even">
<td>Enforce Azure security monitoring</td>
<td>Enable Azure Security Center monitoring on every subscription</td>
<td>Contoso management group</td>
<td>All subscriptions will have all the security monitors enabled</td>
</tr>
<tr class="odd">
<td>Enforce Azure Security Center alerts</td>
<td>Enforce consumption of Azure Security Center alerts</td>
<td>Contoso management group</td>
<td>All subscriptions will have Azure Security Center alerts exported to platform Azure Monitor Log Analytics workspace</td>
</tr>
<tr class="even">
<td>Enforce audit of Key Vault</td>
<td>Ensure logging is enabled for Key Vault</td>
<td>Contoso management group</td>
<td>All key vaults will have logging enabled, and stored centrally to Azure Monitor Log Analytics workspace</td>
</tr>
<tr class="even">
<td>Enforce anti-malware</td>
<td>Ensure all VMs have anti-malware enabled</td>
<td>Landing zone management group</td>
<td>Every VM will have the anti-malware VM extension installed</td>
</tr>
<tr class="even">
<td>Allowed resources</td>
<td>Ensure no resources can be created</td>
<td>Decommission management group</td>
<td>No resources can be deployed to a decommissioned subscription</td>
</tr>
<tr class="odd">
<td>Allowed resources</td>
<td>Ensure that irrelevant resources aren't created</td>
<td><p>Management subscription,</p>
<p>Connectivity subscription</p></td>
<td>Only allowed resources can be created in the management and connectivity subscription</td>
</tr>
<tr class="even">
<td>Deny resources</td>
<td>Explicitly deny resources from being created</td>
<td>Landing zone management group</td>
<td>Azure services that aren't whitelisted can't be deployed into a landing zone</td>
</tr>
<tr class="odd">
<td>Enforce Key Vault recovery</td>
<td>Ensure Key Vault objects can be recoverable</td>
<td>Contoso management group</td>
<td>All Key Vault objects are recoverable in Contoso tenant</td>
</tr>
<tr class="even">
<td><p>Enforce Private Link for <a href="https://docs.microsoft.com/azure/private-link/private-link-overview#availability"> Azure services </a> </p>
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
<p>AKS (API) </p></td>
<td>Ensure Private Link is used for all supported Azure services</td>
<td>Landing zone management group</td>
<td> <a href='https://docs.microsoft.com/azure/private-link/private-link-overview#availability'> Supported Azure services </a> Always use Private Link to communicate to PaaS service over the virtual network</td>
</tr>
</tbody>
</table>

From an identity and access perspective, Contoso will develop and customize RBAC roles and appropriate permissions (actions/NotActions) to ensure that control- and data-plane access is granted to right persona at the right scope in the Azure hierarchy. This will be subject to just-in-time access with multi-factor authentication to all high-privileged roles. Contoso will use Azure AD reporting capabilities to generate access control audit reports.

## Platform automation and DevOps

### Contoso: roles and responsibilities

Contoso has acknowledged that their existing on-premises operating model requires change to ensure they maximize the benefits of the cloud. Contoso has decided to create a platform operations team who will oversee execution of the enterprise-scale architecture and will be accountable for the Contoso Azure platform. This platform team will have representations from the following IT functions:

<table>
<thead>
<tr class="header">
<th>Role name</th>
<th>Description</th>
</tr>
</thead>

<tbody>

<tr class="even">
<td>Systems ops</td>
<td><p>Make AppOps and DevOps teams effective through a federated delegation model that is centrally governed; for example, monitoring, patching, backups, and taking corrective action centrally when necessary</p>
<p>Manage platform-wide monitoring and alerts, alignment with Azure scheduled maintenance events</p>
<p>Author and assign Azure Policy to set up and manage VM/operating system standards</p></td>
</tr>

<tr class="odd">
<td>Security ops</td>
<td><p>Define an Azure Platform baseline to ensure compliance of security requirements and controls are met</p>
<p>Create Policy Compliance and Security Dashboards for organizational and resource-centric views</p>
<p>Define break glass/emergency process to grant and revoke access</p>
<p>Management of platform keys and secrets</p>
<p>Security Policy remediation and compliance initiatives</p></td>
</tr>
<tr class="even">
<td>Automation</td>
<td><p>Develop and maintain DevOps pipeline and standards</p>
<p>Develop and maintain business processes and integration points (such as CMDB or other tools) </p>
<p>Support the team's use of the DevOps pipeline and standards</p>
<p>Support the team to develop SME-specific artifacts</p></td>
</tr>
<tr class="odd">
<td>Network ops</td>
<td><p>Network design, deployment, configuration, and management</p>
<p>Manage inbound, outbound, and east-west networking flows</p>
<p>Manage routing and network segregation within the Virtual Network and hybrid connectivity</p>
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
<p>Manage Azure AD Applications, Service Principals, and Azure AD Application Proxies; registration of Service Principals and Applications with configured delegation</p>
<p>Windows Server Active Directory administration</p>
<p>Define and manage JML for AD and Azure AD users and groups for Azure IAM</p>
<p>Manage MFA sign-in for the Azure control plane and data plane access</p></td>
</tr>
<tr class="odd">
<td>Management</td>
<td><p>Manage Management Groups and Subscription lifecycles</p>
<p>Resource provider registration</p>
<p>Manage Azure Policy Definitions and Assignments at Management group level and Subscription levels</p>
<p>Create Dashboard and Management views for application- and platform-centric management, monitoring, and policy compliance</p>
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

Contoso will use the enterprise-scale Git repo for infrastructure-as-code (IaC) and instantiate their management group and subscription hierarchy using the tenant-level Azure Resource Manager template deployment examples provided within the enterprise-scale repo. This repo is used for bootstrapping and managing their entire platform and will require access permissions for the service principal at a tenant-root scope. To simplify RBAC and managing Service Principal secrets, Contoso will use one Service Principal that will be scoped at the tenant-root scope and will have access to all resources inside the tenant. This account is the highest-privileged account, and no user will have direct access to its secrets.

**Initialization:**

Before starting the enterprise-scale journey, Contoso will discover Azure configurations that can serve as a platform baseline. The consequence of not discovering the existing environment is not having a reference point to roll back or forward after a deployment. Initialization is also key since it can provide a crucial on-ramp path to IaC and allow transitioning without starting over. For the purpose of initialization, the following resources are considered within the scope of the overall Azure platform. This will initialize an empty Git repo with the current configuration and establish a baseline configuration that encompasses the following:

- Management group hierarchy and subscription organization
  - Resource types:
    - `Microsoft.Management/managementGroups`
    - `Microsoft.Management/managementGroups/subscriptions`
    - `Microsoft.Subscription/subscriptions`
- Policy definition and policy assignment for governance
  - Resource types:
    - `Microsoft.Authorization/policyDefinitions`
    - `Microsoft.Authorization/policyAssignments`
- Role definition and role assignment
  - Resource types:
    - `Microsoft.Authorization/roleDefinitions`
    - `Microsoft.Authorization/roleAssignments`

Contoso will default to a platform schema that represents these configurations in Git, which involves calling Azure APIs using PowerShell.

**Deployment:**

Contoso's IaC Git repo will have hundreds if not thousands of tracked and version-controlled configuration artifacts. Platform developers will modify a small subset of these artifacts on an ongoing basis via pull requests (PRs). Since Git represents the source of truth and change history, Contoso will use Git to determine differential changes in each PR and trigger subsequent Azure deployment actions for only those artifacts that have been changed versus of triggering a full deployment for all artifacts involved.

**Operationalization:**

Operational changes are bound to happen in a production environment. Ideally, Contoso will use IaC principles to ensure that changes are made in a structured way. A change would be made by adding or updating a template within the Git repo, relying on an automated test and release process to deploy the required operational changes.
Due to operational demands, manual changes made via the Azure portal may be unavoidable. This leads to a configuration drift where the environment described in source
control no longer reflects the actual state of Azure resources. To deal with this conflict, enterprise-scale envisions not only a control mechanism to push changes within the IaC source to the Azure environment, but also the capacity to pull changes made outside of IaC back into source control. By establishing a feedback loop, we can ensure that the environment described in source control always reflects the actual state of Azure subscriptions and that manual changes don't inadvertently roll back by the next automated resource deployment.

Through Azure Policy, changes to Azure resources within the Contoso management group scope are captured within an Azure Monitor Logs instance in the `management` subscription. A log search alert will activate a webhook and notify Git if a resource configuration is updated or modified, prompting the resource state to export it as a PR for review. This will allow repo owners to control whether to roll forward the change by merging the PR or roll it back by making new configuration changes that'll override the out-of-band configuration change.
