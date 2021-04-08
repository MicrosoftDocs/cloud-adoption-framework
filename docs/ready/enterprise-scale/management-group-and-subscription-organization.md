---
title: Management group and subscription organization
description: Management group and subscription organization.
author: BrianBlanchard
ms.author: brblanch
ms.date: 06/15/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready 
ms.custom: think-tank
---

# Management group and subscription organization

![Diagram that shows management group hierarchy.](./media/sub-org.png)

_Figure 1: Management group hierarchy._

## Define a management group hierarchy

Management group structures within an Azure Active Directory (Azure AD) tenant support organizational mapping and must be considered thoroughly when an organization plans Azure adoption at scale.

**Design considerations:**

- Management groups can be used to aggregate policy and initiative assignments via Azure Policy.
- A management group tree can support up to [six levels of depth](/azure/governance/management-groups/overview#hierarchy-of-management-groups-and-subscriptions). This limit doesn't include the tenant root level or the subscription level.
- Any principal (user, service principal) within an Azure AD tenant can create new management groups as Azure role-based access control (Azure RBAC) authorization for management group operations is not enabled by default.
- All new subscription will be placed under the root management group by default.

**Design recommendations:**

- Keep the management group hierarchy reasonably flat with no more than three to four levels, ideally. This restriction reduces management overhead and complexity.
- Avoid duplicating your organizational structure into a deeply nested management group hierarchy. Management groups should be used for policy assignment versus billing purposes. This approach necessitates using management groups for their intended purpose in enterprise-scale architecture, which is providing Azure policies for workloads that require the same type of security and compliance under the same management group level.
- Create management groups under your root-level management group to represent the types of workloads (archetype) that you'll host and ones based on their security, compliance, connectivity, and feature needs. This grouping structure allows you to have a set of Azure policies applied at the management group level for all workloads that require the same security, compliance, connectivity, and feature settings.
- Use resource tags, which can be enforced or appended through Azure Policy, to query and horizontally navigate across the management group hierarchy. Then you can group resources for search needs without having to use a complex management group hierarchy.
- Create a top-level sandbox management group to allow users to immediately experiment with Azure. Users can then experiment with resources that might not yet be allowed in production environments. The sandbox provides isolation from your development, test, and production environments.
  - For further guidance of the top-level sandbox management group review the [implementation guidelines](./implementation-guidelines.md#sandbox-governance-guidance).
- Use a dedicated service principal name (SPN) to execute management group management operations, subscription management operations, and role assignment. Using an SPN reduces the number of users who have elevated rights and follows least-privilege guidelines.
- Assign the `User Access Administrator` Azure role at the root management group scope (`/`) to grant the SPN just mentioned access at the root level. After the SPN is granted permissions, the `User Access Administrator` role can be safely removed. In this way, only the SPN is part of the `User Access Administrator` role.
- Assign `Contributor` permission to the SPN previously mentioned at the root management group scope (`/`), which allows tenant-level operations. This permission level ensures that the SPN can be used to deploy and manage resources to any subscription within your organization.
- Create a `Platform` management group under the root management group to support common platform policy and Azure role assignment. This grouping structure ensures that different policies can be applied to the subscriptions used for your Azure foundation. It also ensures that the billing for common resources is centralized in one set of foundational subscriptions.
- Limit the number of Azure Policy assignments made at the root management group scope (`/`). This limitation minimizes debugging inherited policies in lower-level management groups.
- Use the policies available for enterprise-scale landing zones to enforce compliance requirements either at management group or subscription scope. Refer to guidance in the [policy-driven governance](#policy-driven-governance) section to learn more about the governance requirements that can be addressed.
- Ensure that only privileged users can operate management groups in the tenant by enabling Azure RBAC authorization in the management group [hierarchy settings](/azure/governance/management-groups/how-to/protect-resource-hierarchy#setting---require-authorization) (by default, all users are authorized to create their own Management Groups under the root management group).
- [Configure](/azure/governance/management-groups/how-to/protect-resource-hierarchy#setting---default-management-group) a default, dedicated management group for new subscriptions to ensure no subscriptions are placed under the root management group. This is especially important if there are users eligible for MSDN or Visual Studio benefits and subscriptions. A good candidate for such management group is a `Sandbox` management group.

>[!NOTE]
 > For testing guidance for Enterprise Scale deployments, please review [Testing approach for Enterprise Scale](azure/cloud-adoption-framework/ready/enterprise-scale/testing-approach)

## Subscription organization and governance

Subscriptions are a unit of management, billing, and scale within Azure. They play a critical role when you're designing for large-scale Azure adoption. This section helps you capture subscription requirements and design target subscriptions based on critical factors. These factors are environment type, ownership and governance model, organizational structure, and application portfolios.

**Design considerations:**

- Subscriptions serve as boundaries for assigning Azure policies. For example, secure workloads such as Payment Card Industry (PCI) workloads typically require additional policies to achieve compliance. Instead of using a management group to group workloads that require PCI compliance, you can achieve the same isolation with a subscription. This way, you don't have too many management groups with a small number of subscriptions.
- Subscriptions serve as a scale unit so that component workloads can scale within the platform [subscription limits](/azure/azure-subscription-service-limits). Make sure to consider subscription resource limits during your workload design sessions.
- Subscriptions provide a management boundary for governance and isolation, which creates a clear separation of concerns.
- There's a manual process, planned future automation, that can be conducted to limit an Azure AD tenant to use only Enterprise Agreement enrollment subscriptions. This process prevents creation of Microsoft Developer Network subscriptions at the root management group scope.

**Design recommendations:**

- Treat subscriptions as a democratized unit of management aligned with business needs and priorities.
- Make subscription owners aware of their roles and responsibilities:
  - Perform an access review in Azure AD Privileged Identity Management quarterly or twice a year to ensure that privileges don't proliferate as users move within the customer organization.
  - Take full ownership of budget spending and resource utilization.
  - Ensure policy compliance and remediate when necessary.
- Use the following principles when identifying requirements for new subscriptions:
  - **Scale limits:** Subscriptions serve as a scale unit for component workloads to scale within platform subscription limits. For example, large, specialized workloads such as high-performance computing, IoT, and SAP are all better suited to use separate subscriptions to avoid limits (such as a limit of 50 Azure Data Factory integrations).
  - **Management boundary:** Subscriptions provide a management boundary for governance and isolation, which allows for a clear separation of concerns. For example, different environments such as development, test, and production are often isolated from a management perspective.
  - **Policy boundary:** Subscriptions serve as a boundary for the assignment of Azure policies. For example, secure workloads such as PCI typically require additional policies to achieve compliance. This additional overhead doesn't need to be considered holistically if a separate subscription is used. Similarly, development environments might have more relaxed policy requirements relative to production environments.
  - **Target network topology:** Virtual networks can't be shared across subscriptions, but they can connect with different technologies such as virtual network peering or Azure ExpressRoute. Consider which workloads must communicate with each other when you decide whether a new subscription is required.
- Group subscriptions together under management groups aligned within the management group structure and policy requirements at scale. Grouping ensures that subscriptions with the same set of policies and Azure role assignments can inherit them from a management group, which avoids duplicate assignments.
- Establish a dedicated management subscription in the `Platform` management group to support global management capabilities such as Azure Monitor Log Analytics workspaces and Azure Automation runbooks.
- Establish a dedicated identity subscription in the `Platform` management group to host Windows Server Active Directory domain controllers, when necessary.
- Establish a dedicated connectivity subscription in the `Platform` management group to host an Azure Virtual WAN hub, private Domain Name System (DNS), ExpressRoute circuit, and other networking resources. A dedicated subscription ensures that all foundation network resources are billed together and isolated from other workloads.
- Avoid a rigid subscription model, and opt instead for a set of flexible criteria to group subscriptions across the organization. This flexibility ensures that as your organization's structure and workload composition changes, you can create new subscription groups instead of using a fixed set of existing subscriptions. One size doesn't fit all for subscriptions. What works for one business unit might not work for another. Some applications might coexist within the same landing zone subscription while others might require their own subscription.

## Configure subscription quota and capacity

Each Azure region contains a finite number of resources. When you consider an enterprise-scale Azure adoption that involves large resource quantities, ensure that sufficient capacity and SKUs are available and the attained capacity can be understood and monitored.

**Design considerations:**

- Consider limits and quotas within the Azure platform for each service that your workloads require.
- Consider the availability of required SKUs within chosen Azure regions. For example, new features might be available only in certain regions. The availability of certain SKUs for given resources such as VMs might be different from one region to another.
- Consider that subscription quotas aren't capacity guarantees and are applied on a per-region basis.

**Design recommendations:**

- Use subscriptions as scale units, and scale out resources and subscriptions as required. Your workload can then use the required resources for scaling out, when needed, without hitting subscription limits in the Azure platform.
- Use reserved instances to prioritize reserved capacity in required regions. Then your workload will have the required capacity even when there's a high demand for that resource in a specific region.
- Establish a dashboard with custom views to monitor used capacity levels. Set up alerts if capacity utilization is reaching critical levels (for example, 90 percent CPU utilization).
- Raise support requests for quota increase as a part of subscription provisioning (for example, total available VM cores within a subscription). This approach ensures your quota limits are set before your workloads require going over the default limits.
- Ensure required services and features are available within the chosen deployment regions.

## Establish cost management

Cost transparency across a technical estate is a critical management challenge faced by every large enterprise organization. This section explores key aspects associated with how cost transparency can be achieved across large Azure environments.

**Design considerations:**

- Potential need for chargeback models where shared platform as a service (PaaS) resources are concerned, such as Azure App Service Environment and Azure Kubernetes Service, which might need to be shared to achieve higher density.
- Use a shutdown schedule for nonproduction workloads to optimize costs.
- Use Azure Advisor to check cost optimization recommendations.

**Design recommendations:**

- Use Azure Cost Management + Billing for cost aggregation. Make it available to application owners.
- Use Azure resource tags for cost categorization and resource grouping. Using tags allows you to have a chargeback mechanism for workloads that share a subscription or for a given workload that spans across multiple subscriptions.

## Policy-driven Governance

Enterprise-scale Azure policies can be used to enforce following governance requirements.

- **Prevent Public IP-based services**

    Most of the Azure Platform-as-a-service (PaaS) services are created with a public IP address assigned to them. This option is good for developers who want to quickly get started with these services. Public endpoint accelerates learning curve and is ideal when developing pilots and small-scale Proof Of Concept (PoC) implementations.

    However, when these pilots/PoCs make transition to production-ready enterprise applications, their use of public IP addresses is sometimes overlooked.

    Production workloads using public IPs without proper security measures in place can increase security risks. Malicious actors can potentially use public IP as a gateway to launch an attack. Many enterprise compliance policies do not allow use of public IP just to avoid exposure to such security risks.

    There's a custom policy on denying creation of public IP address, which prevents public IP getting created in a scope targeted by policy. Enterprises can easily prevent Virtual Machines (VMs) getting created with public IP using this policy.

    Similarly there's a custom Policy Initiative / PolicySet, which helps enterprises prevent Azure services getting created with a public IP address in the first place.

- **Enforce audit and log information collection**

    Lack of auditing and diagnostics information at granular level can affect operational practices. Incomplete audit information makes it difficult to correlate logs from multiple Azure services and create a coherent debugging experience.

    Once Azure services are provisioned, they should provide detailed information about Azure platform they interact with.
    Such information can be broadly divided into logs and metrics. Each Azure service can be further categorized into its sub-components (e.g. An Azure Public IP resource has `DDoSProtectionNotifications`, `DDoSMitigationReports`, and `DDoSMitigationFlowLogs` as its sub-components. Collecting diagnostic information at these sub-categories can greatly enhance auditing and debugging experience.

     A custom Policy Initiative is available to enforce logs and metrics collection at a deeper level, which helps enterprises gather logs and metrics per Azure Service. This initiative includes a policy for every Azure service. Key log categories for each Azure service and all metrics are collected automatically through these policies.

- **Provide comprehensive security for SQL Databases**

     SQL databases are a common Azure service in most Azure deployments. Unfortunately, they are also prime target for malicious activities from within and outside of an enterprise.

    A custom Policy Initiative specifically fo SQL Databases helps implement following key governance practices.

  - **Encrypt SQL data at rest**

    SQL database and its backups are prone to risks of getting into hands of malicious actors. It's easy to restore SQL database from either database files or backup. Without proper defense system in place, malicious actors can have access to all the data.

    Ensuring that SQL database is encrypted at rest is one of the first steps towards building SQL database defense strategy. Azure SQL database Transparent Data Encryption (TDE) ensures that data is encrypted at rest without needing any application code level change.

    A SQL database with TDE enabled makes it hard for malicious actors to get access to data it holds even if its compromised.

    As Azure SQL database deployments within an enterprise increases, it is important they are created with TDE enabled.

    There's a custom policy to ensure that Azure SQL databases have TDE enabled.

  - **Enforce alerts for suspicious activity**

    Bad actors are on the constant lookout to access and exploit business-critical Azure SQL databases. Risk of such attempts going unnoticed can reduce an enterprise's ability to detect and respond to them. In worst case scenario, an enterprise may never know if its SQL database has been compromised.

    Azure SQL database provides way to set up security alerts that can report suspicious activities on SQL server. Such alert sends email to a pre-configured email addresses and optionally to Azure subscription admins and owners.

    There's a custom policy to enforce enabling of security alerts on Azure SQL databases. Enterprise can benefit from identifying malicious activities such as SQL injection attack, brute force attack, etc. though these alerts. Security alerts provide detailed information about every incident. This detailed information is surfaced in Azure portal and also an email message is triggered.

  - **Enforce audit trail of operations**

    A business-critical Azure SQL database can be subject to large number of Data Manipulation Language (DML), Data Control Language (DCL) and Data Definition Language (DDL) commands as part of day to day operations. Without a clear control and insight into these operational activities, it's challenging to distinguish between legitimate and suspicious operations.

    Enabling SQL Auditing can help in gathering important information about all database activities. It's also a requirement for many industry/regional regulatory compliance requirements. SQL Auditing helps generating and reporting audit trail of database events.

    Enterprises can use a custom policy to enforce Azure SQL Database Auditing. This policy audits and reports key database events like ownership changes, successful/failed logins, role membership changes, schema changes, etc. Enterprises can use this policy and audit trail it generates to gain rich insights into database operations and comply with industry or regional regulatory requirements.

- **Enforce evaluation against proven best practices**

    Throughout its lifecycle, Azure SQL database undergoes large number of schema, permission, and configuration changes. There's always a risk of such changes resulting in deviation from best practices. Excessive permissions, orphaned roles, and many such configurational drifts can be exploited by malicious actors.

    Azure SQL database has built-in vulnerability assessment service.  State of Azure SQL database through the lens of Microsoft's best practices for SQL database can be evaluated using vulnerability assessment. A vulnerability assessment scan identifies database and server level security risks. A remediation task in applicable scenario may be also generated to fix the vulnerability.

    A custom policy deployed in  ensures that Azure SQL databases are configured with vulnerability assessment. The assessment scans are done periodically and reports are stored in Azure storage account. Pre-defined email address is used to share the results of periodic scan results for reporting purposes.

- **Protect against intentional/unintentional secret deletion**

    Azure Key Vault is a service to store confidential information such as keys, certificates, passwords, etc. A malicious user can potentially abuse Azure Key Vault service by deleting secrets stored inside it. It's also quite likely that a user may accidentally delete sensitive information stored in Azure Key Vault. Without proper provisions in place, either malicious or accidental deletion in Azure Key Vault can cause significant business harm.

    Azure Key Vault provides protection against intentional or unintentional deletion of contents stored inside it through soft-delete feature. When soft-delete is enabled, deleted keys will be retained for a pre-configured time period. If the delete operation was unintentional then deleted key can be restored within pre-configured time window. If the delete operation was intentional then key content can be deleted until an another *purge* operation is done - typically by someone with higher privileges.

    There's a custom policy to ensure Azure Key vault is enabled with soft-delete feature by default. Enterprises get better control on deletion of Azure Key Vault content for unintentional operations. This policy also provides an extra security layer for malicious deletion of Azure Key Vault content.

- **Enforce Web Application Firewall (WAF)**

    Web applications running on Azure are potential targets of number of malicious attacks. [Top 10 common attacks](https://owasp.org/www-project-top-ten/) - such as - injection, cross-site scripting, etc. try to exploit known vulnerabilities typically associated with web applications. Consequences of a successful attack can be costly and may impact brand value negatively.

    Azure Application Gateway Web Application Firewall (WAF) provides protection against common attacks on web applications. It implements Core Rule Set (CRS) 3.1, 3.0 or 2.2.9 as recommended by the Open Web Application Security Project (OWASP). WAF policies can be associated with Azure Application Gateway either in *Prevention* or *Detection* mode.

    There's a custom policy to help in preventing potential misconfiguration on Azure Application Gateway. It enforces Azure Application Gateway can't be created without a Web Application Firewall (WAF). Web Applications running on Azure and using Azure Application Gateway are protected by Web Application Firewall (WAF) on Azure Application Gateway.

- **Prevent IP forwarding on VMs**

    IP forwarding enables Azure VM to route traffic it receives to other destinations. Unless explicitly required, such routing may potentially expose a VM with public IP address as a router. Other unintended networks can be reached via VM-turned-router with IP forwarding.

    Azure provides an option to configure IP forwarding on Virtual Machines (VMs). This option enables specialized software such as firewalls, load balancers, etc. to be deployed via Azure Marketplace. Any application that may need to use these services, can use them via Azure Marketplace transaction.

    However, outside of specific needs, IP forwarding on VMs may become a security liability. There's a custom policy to prevent VMs acting as IP forwarding routers. This policy is explicitly applied at landing zone scope. VMs in landing zone should be final destinations for user requests. Any routing should be implemented in the connectivity subscription.

- **Enforce centralized DNS record management**

    Azure Private DNS Zones help create and manage DNS records for Azure resources. Uncontrolled proliferation of Azure Private Zones can result in management & network connectivity debugging issues. In hybrid environments where connectivity from on-premise sites to Azure resources is needed, fragmented DNS zones can result in duplication of DNS records and associated maintenance challenges.

    Azure Private DNS Zone can be deployed centrally for easier management of DNS records. Azure Virtual Network linked with Azure Private Zone can potentially run domain controllers, which helps streamlined connectivity from on-premise sites. Azure services, which support Private Link/Endpoint can use centrally managed Azure Private Zone and prevent having to create them per application deployment.

    A custom policy can be deployed to prevent creation of Azure Private DNS Zone in the scope over which its applied. Enterprises can view compliance status against this policy even when the policy enforcement is disabled. This policy helps in streamlining connectivity from on-premise sites and access to Azure PaaS services using Private Link/Endpoint.

- **Enforce network traffic control**

    An Azure Virtual Network (VNet) can be segmented into multiple Subnets. By default, there's no network access control between these subnets. Lack of network access control can result in unsolicited network traffic arriving inside a subnet.

    Azure Network Security Group (NSG) helps is filtering incoming traffic to and from a subnet. NSGs can allow or deny network traffic based on stateful packet inspection. Any resources inside subnet can receive traffic from only allowed IP address range(s).

    There's a custom  policy to enforce every subnet has a NSG associated with it. A combination of subnet and NSG ensures that a default set of rules controls traffic to and from a subnet. Enterprises can add/modify rules to control traffic further based on the needs.

- **Detect and protect against security threats by using Azure Security Center**

    An Azure subscription can hold multiple types of resource like VMs, Container Images, etc. These resources are exposed to risks such as malware/unwanted software installation, uncontrolled access to management ports on a VM, etc. With security attacks getting ever sophisticated and a limited-supply of experienced security professionals, detecting security vulnerabilities and protecting workloads is extremely challenging.

    Azure Security Center is Azure's native security management system, which assesses Azure resources for their security posture against security best practices.  Azure security center helps to detect and prevent threats against data and application services. With multiple integration points, Azure Security center can be deployed quickly.

    A custom policy helps in enrolling Azure subscription(s) with Azure Security Center Standard mode, which enables Azure subscription(s) to start getting security threat detection and protection which are offered by Azure Security Center. This policy ensures key Azure services such as VMs, Storage Accounts and seven other services are automatically covered by Azure Security Center. Enterprises benefits from continuous security assessment and actionable recommendations should there be any deviation from security best practice.

- **Protect against ransomware attacks and other data-loss related issues**

    Increasing frequency of ransomware & intrusion attacks pose yet another concern for enterprises. A successful ransomware attack can disrupt business-critical processes and applications. Attackers are known to hold enterprises as hostage for huge amounts of money.

    Azure Backup provides protection for Azure VMs against accidental or intentional data destruction. Azure Backups are easy to configure and scale. Data is backed up in Azure Recovery Vault for easy management and protection.

    There's a custom policy that protects Azure VMs by configuring Azure Backup for them. This policy automatically provisions Azure Recovery Services Vault and creates backup container for every Azure VM that gets created.

- **Protect against DDoS attacks**

    Any publically reachable Azure resource is exposed to threat of Distributed Denial of Service (DDoS) attack. A successful DDoS attack can affect the application's availability to it's intended users. A prolonged DDoS attack can exhaust all available resources and result in downtime for business-critical application(s).

    Azure DDoS Protection service defends Azure resources against DDoS attacks. Azure DDoS Protection continuously monitors incoming traffic to identify potential indications of a DDoS attack. Enterprises benefit from working with Microsoft's DDoS Rapid Response (DRR) team during an active attack.

    There's a custom policy that automatically provisions Azure DDoS Standard plan on all Azure subscriptions under its scope. Same policy also enables enterprises to select the Azure regions to be covered as part of the assignment.

- **Auto-provision Private Link/Endpoint with Private DNS Zone**

    Azure Private Link and Azure Private Endpoint provide access to Azure Platform-as-a-service (PaaS) services using private IP addresses. However, Azure Private DNS Zone is needed for DNS record resolution. Creation of Azure Private Zones for every application that needs to access Azure PaaS services is a management and maintenance challenge.

    Azure Private DNS Zone Group helps is grouping the Private Link connections by Azure Services like blob, queue, table, sql, etc. using an Azure Private Zone per service.

    Enterprises can create central Azure Private Zones and custom policies will auto-provision connections between Private Link/Endpoint and Private DNS Zone for Azure services.

- **Centrally manage firewall rules**

    Fragmented firewall rules can lead to uncontrolled and ambiguous network traffic paths. Continuous changes in the firewalls rules for every instance of firewall makes it difficult to assess the network security posture. Multiple rules make it impossible to distinguish between centrally managed basic set of rules and workload-specific network path rules.

    Azure Firewall Policy helps to define basic minimum set of rules applicable throughout an enterprise. Application-specific policy can inherit from basic rules to allow creation of hierarchical rules to meet both enterprise and application-specific firewall rule requirements. When rules are configured through policies then they can be centrally managed and monitored.

    A custom policy enables enterprises to define Azure Firewall policies centrally. Enterprises are in control of defining rules and priority to meet their network traffic routing requirements. By defining firewall policies centrally, enterprises can apply them to either Azure Virtual WAN or Azure Hub and Spoke Networking topology depending upon needs.

- **Provision Hub and Spoke Network topology**

    As more workloads start to get deployed in Azure, they start to use a common set of services such as Firewall, VPN gateways, etc. If not carefully planned, common services deployment gets replicated per application deployment resulting not only in unnecessary costs but also operational overhead. In scenarios where on-premise connectivity is needed from Azure, network topology becomes difficult to maintain as this connectivity is established per application deployment.

    Azure Hub and Spoke network topology streamlines the network connectivity needs. A Hub Virtual Network (VNet) can host the shared services while spoke VNets can host application-specific Azure resources. Hub and Spoke VNets are connected with each other via VNet Peering. Hub and Spoke network topology promotes clean network design, easier management, and cost optimization.

    There's a custom policy that provisions Hub VNet with Azure Firewall, VPN Gateway, and ExpressRoute (ER) Gateway. Enterprises can configure all the options for Firewall, VPN, and ER gateway as part of the policy assignment. This policy simplifies the process to deploy Azure Hub and Spoke network topology.

    Another custom policy prevents two Virtual Networks (VNets) getting peered with each other as they can communicate with each other via Hub VNet. When forcing VNets to communicate with each other through Hub, makes it possible to control and monitor network connections. Network topology is simplified from overall maintenance perspective as well.

- **Provision default configuration for Azure Monitor**

    Inability to identify and visualize relationship between Azure platform, Azure service(s), and Azure application(s) may result into an outage or degraded performance going undetected. Operations or Support team may miss an opportunity to take corrective action to a specific condition. An Azure application may not scale itself to respond to either surge or slump in the demand.

    Azure Monitor Logs along with Azure Log Analytics Workspace help enterprises in dealing with critical conditions using Alerts. Azure Monitor Logs and Log Analytics Workspace together, empower enterprises to visualize and interact with rich set of log information through dashboards, workbooks, and Power BI. Enterprises can use Azure Monitor Logs and Log Analytics Workspace together to configure auto-scaling on VMs to automatically adding or removing extra instances.

    A custom policy helps in configuring Log Analytics Workspace with Azure Monitor. This policy deploys pre-packaged dashboard reports referred as Azure Monitor Solutions for specific Azure services such as Azure SQL Database or Azure Active Directory. It also configures data sources such as Linux and Windows VM Performance metrics with Azure Monitor.

- **Enable Log Storage and Querying**

    If not carefully planned, log information coming from multiple sources is Azure can easily become unwieldy. Capturing, storing, and managing logs can consume plenty of resources, time, and costs. Identifying trends or patterns over a long period of time and over huge amount of logs can become challenging.

    Azure Log Analytics enables enterprises to store and manage logs from multiple sources efficiently. Querying the data stored in Azure Log Analytics for trend or pattern analysis is easy with Azure Log Analytics. Alerts or interactive reports can be created using Azure Log Analytics queries.

    There's a custom policy, which creates Azure Log Analytics Workspace that acts as a repository to store log data. An Azure Automation Account is also created and linked with Log Analytics Workspace for automating tasks or deploying Azure Monitor Solutions, which may have dependency on Log Analytics Workspace. It also helps in configuring properties such as log retention period, Azure region, etc.

- **Provision logging for Azure-Arc enabled servers**

    With IT estates spanning multiple clouds, on-premise sites and edge locations, many enterprises may be struggling to manage and govern servers, which are scattered across environments and geographic locations. Using multitude of products to monitor servers can be a jarring experience. Putting servers in multiple environments under a single unified access and identity management solution can be challenging to set up and manage.

    Azure Arc simplifies governance and management of resources such as servers, kubernetes clusters, and data services across heterogeneous environments. By projecting hybrid resources as native Azure resources, Azure Arc provides a single pane of control for management of native and hybrid resources. Azure Arc brings native and hybrid resources under a single unified RBAC solution.

    A pair of custom policies helps enterprises setting up Log Analytics agent on Azure Arc enabled Linux & Windows servers. A Log Analytics Workspace is also configured to store and manage logs. When assigned successfully, policy returns the name of server(s) within the scope of policy, which is configured with Log Analytics agent on it.

- **Enforce Network Traffic Log collection**

    While Azure Virtual Network (VNet) and Subnet provide a logical private network boundary, it is still essential to monitor the network traffic in Azure. Without proper network monitoring, enterprises are exposed to the risk of undesired or unknown traffic coming to Azure networks from compromised IP addresses. It becomes challenging to provision extra capacity for any increase in the network traffic without understanding the current traffic.

    Azure Network Watcher provides a way to monitor and if necessary repair any network issue related to IaaS services in Azure. Network Security Group (NSG) flow logs provides a way to capture information about network traffic traversing through NSG. Enterprises can benefit from traffic analysis & patterns, forecast future capacity needs and enforce compliance against corporate governance policies.

    There is a custom policy, which helps in setting up Azure Network Watcher NSG flow logs. An Azure Storage Account is provisioned as repository to store NSG flow logs. This policy also configuring the retention period to store the NSG flow logs.  

- **Provision at-scale network connectivity solution**

    Network connectivity requirements for an enterprise can be complex. Constant requests for adding New sites, devices, and users to ever-expanding network are very challenging to provision and manage. Network bandwidth and throughput demands by multiple touch-points within an enterprise can be very demanding.

    Azure Virtual WAN (vWAN) is an enterprise-grade network service aimed towards addressing any-to-any connectivity challenges. Azure vWAN provides higher aggregate throughput with network connectivity. It provides optimal routing over Azure backbone and a unified management experience from Azure.

    A custom policy enables setting up an Azure vWAN.
    This policy helps in provisioning Azure vWAN hub inside vWAN. Enterprises can deploy a Virtual Hub, which acts as a central point for connections from multiple sources and destinations. ExpressRoute, VPN gateways and Azure Firewall is also provisioned to address any-to-any network connectivity requirements.  

- **Provision backup for Azure VMs**

    As cloud adoption increases, enterprise face challenges of ensuring that workloads running in Azure are backed up. Conventional IT support model where app development and IT operations are managed by separate Teams, sometimes leaves the door open for unclear ownership of VM backups. In either intentional or unintentional scenario, which requires VM backups for workload restoration, missing backup process can result in costly consequences.

    Azure Backup provides a seamless, easy, and integrated option for backing up VMs running either in Azure or in on-premise sites. Azure Backup uses cloud scale storage and frees enterprises from having to constantly procure and manage storage needed for backups. Azure Backup provides a repository to store data securely in transit and at-rest.

    There is a custom policy that automatically configures Azure backup protection for Windows and Linux VMs. A Recovery Service Vault is configured for storing backup, which securely stores data and provides protection against malicious deletion of backup through soft delete. A default backup policy is created and assigned with pre-configured values for backup schedule, backup retention period, etc.

- **Provision connectivity between Virtual Networks (VNets)**

    It is common to have workloads scattered across multiple subscriptions or virtual networks (VNets) in an enterprise. Without a dedicated and secure network connectivity between them, critical business applications will struggle with data exchange. An internet-based network connectivity will pose inconsistent network bandwidth and performance. Potential high network latency may impact user experience adversely.

    Azure Virtual Network Peering provides network connectivity between two virtual networks (VNets) over Microsoft backbone network. Azure Peering enables high-bandwidth low-latency network connectivity. Data can be exchanged securely between separate Azure subscriptions, tenants, or Azure regions.

    A custom policy provides a template for setting up Virtual Network Peering. A network layout expressed in ARM template definition can be passed as a parameter. This policy will spin up Virtual Networks and configure VNet Peering between them along with dependencies such as NSG, UDR, etc.

- **Enforce Windows VMs to join AD Domain**

    Enterprises have been using domain joined VMs for a consistent management experience. When operations such as corporate password policy, central authentication, etc. are created as part of domain policies, a VM that does not join the domain, is exposed to risks such as weak password, inability to connect with corporate devices, applications, etc. Legacy applications that rely upon authentication protocols such as NTLM, Kerberos may face authentication issues when deployed on VMs that are not domain joined.

    Azure provides managed as well as unmanaged solutions for implementing domain services. With self-managed Active Directory Domain Services (AD DS) in Azure, enterprises get complete control on the setup, configuration, and operations same as in an on-premise environment. Azure Active Directory Domain Service (AAD DS) takes away all the management overhead away from enterprises while still providing essential domain services.

    A custom policy that ensures any newly created Windows VM automatically joins the domain. An extension - *JsonADDomainExtension* - is deployed on the VM that uses other configuration settings such as username, domain, OUPath, etc. to ensure that VM joins the specified domain. This policy uses Azure KeyVault to manage confidential information such as domain username and password.
