---
title: "The virtual datacenter: A network perspective"
description: Use the Cloud Adoption Framework for Azure to learn how to use Azure to seamlessly extend your infrastructure into the cloud and build multitier architectures.
author: tracsman
ms.author: brblanch
manager: rossort
ms.date: 02/25/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: general
ms.custom: think-tank, virtual-network
---

<!-- docutune:disable -->
<!-- cSpell:ignore iptables DDOS ITSM LLAP anycast vwan -->

# The virtual datacenter: A network perspective

Applications migrated from on-premises will benefit from Azure's secure cost-efficient infrastructure, even with minimal application changes. Even so, enterprises should adapt their architectures to improve agility and take advantage of Azure's capabilities.

Microsoft Azure delivers hyperscale services and infrastructure with enterprise-grade capabilities and reliability. These services and infrastructure offer many choices in hybrid connectivity, so customers can choose to access them over the internet or a private network connection. Microsoft partners can also provide enhanced capabilities by offering security services and virtual appliances that are optimized to run in Azure.

Customers can use Azure to seamlessly extend their infrastructure into the cloud and build multitier architectures.

## What is a virtual datacenter?

The cloud began as a platform for hosting public-facing applications. Enterprises recognized the value of the cloud and began migrating internal line-of-business applications. These applications brought additional security, reliability, performance, and cost considerations that required additional flexibility when delivering cloud services. New infrastructure and networking services were designed to provide this flexibility, and new features provided for elastic scale, disaster recovery, and other considerations.

Cloud solutions were initially designed to host single, relatively isolated applications in the public spectrum. This approach worked well for a few years. As the benefits of cloud solutions became clear, multiple large-scale workloads were hosted on the cloud. Addressing security, reliability, performance, and cost concerns of deployments in one or more regions became vital throughout the lifecycle of the cloud service.

In the example cloud deployment diagram below, the red box highlights a security gap. The yellow box shows an opportunity to optimize network virtual appliances across workloads.

![0][0]

Virtual datacenters help achieve the scale required for enterprise workloads. This scale must address the challenges introduced when running large-scale applications in the public cloud.

A virtual datacenter (VDC) implementation includes more than the application workloads in the cloud. It also provides the network, security, management, and other infrastructure such as DNS and Active Directory services. As enterprises migrate additional workloads to Azure, consider the infrastructure and objects that support these workloads. Carefully structuring your resources helps avoid proliferation of hundreds of separately managed "workload islands" with independent data flows, security models, and compliance challenges.

The virtual datacenter concept provides recommendations and high-level designs for implementing a collection of separate but related entities. These entities often have common supporting functions, features, and infrastructure. Viewing your workloads as a virtual datacenter helps realize reduced cost from economies of scale, optimized security via component and data flow centralization, and easier operations, management, and compliance audits.

> [!NOTE]
> A virtual datacenter is **not** a specific Azure service. Rather, various Azure features and capabilities are combined to meet your requirements. A virtual datacenter is a way of thinking about your workloads and Azure usage to optimize your resources and capabilities in the cloud. It provides a modular approach to providing IT services in Azure while respecting the enterprise's organizational roles and responsibilities.

A virtual datacenter helps enterprises deploy workloads and applications in Azure for the following scenarios:

- Host multiple related workloads.
- Migrate workloads from an on-premises environment to Azure.
- Implement shared or centralized security and access requirements across workloads.
- Mix DevOps and centralized IT appropriately for a large enterprise.

## Who should implement a virtual datacenter?

Any customer that has decided to adopt Azure can benefit from the efficiency of configuring a set of resources for common use by all applications. Depending on the size, even single applications can benefit from using the patterns and components used to build a VDC implementation.

Some organizations have centralized teams or departments for IT, networking, security, or compliance. Implementing a VDC can help enforce policy points, separate responsibilities, and ensure the consistency of the underlying common components. Application teams can retain the freedom and control that is suitable for their requirements.

Organizations with a DevOps approach can also use VDC concepts to provide authorized pockets of Azure resources. This method can ensure the DevOps groups have total control within that grouping, at either the subscription level or within resource groups in a common subscription. At the same time, the network and security boundaries stay compliant as defined by a centralized policy in the hub network and centrally managed resource group.

## Considerations for implementing a virtual datacenter

When designing a virtual datacenter, consider these pivotal issues:

### Identity and directory service

Identity and directory services are key capabilities of both on-premises and cloud datacenters. Identity covers all aspects of access and authorization to services within a VDC implementation. To ensure that only authorized users and processes access your Azure resources, Azure uses several types of credentials for authentication, including account passwords, cryptographic keys, digital signatures, and certificates. [Azure Multi-Factor Authentication][multi-factor-authentication] provides an additional layer of security for accessing Azure services using strong authentication with a range of easy verification options (phone call, text message, or mobile app notification) that allow customers to choose the method they prefer.

Any large enterprise needs to define an identity management process that describes the management of individual identities, their authentication, authorization, roles, and privileges within or across their VDC. The goals of this process should be to increase security and productivity while reducing cost, downtime, and repetitive manual tasks.

Enterprise organizations may require a demanding mix of services for different lines of business, and employees often have different roles when involved with different projects. The VDC requires good cooperation between different teams, each with specific role definitions, to get systems running with good governance. The matrix of responsibilities, access, and rights can be complex. Identity management in the VDC is implemented through [Azure Active Directory (Azure AD)][azure-ad] and Azure role-based access control (Azure RBAC).

A directory service is a shared information infrastructure that locates, manages, administers, and organizes everyday items and network resources. These resources can include volumes, folders, files, printers, users, groups, devices, and other objects. Each resource on the network is considered an object by the directory server. Information about a resource is stored as a collection of attributes associated with that resource or object.

All Microsoft online business services rely on Azure Active Directory (Azure AD) for sign-on and other identity needs. Azure Active Directory is a comprehensive, highly available identity and access management cloud solution that combines core directory services, advanced identity governance, and application access management. Azure AD can integrate with on-premises Active Directory to enable single sign-on for all cloud-based and locally hosted on-premises applications. The user attributes of on-premises Active Directory can be automatically synchronized to Azure AD.

A single global administrator isn't required to assign all permissions in a VDC implementation. Instead, each specific department, group of users, or services in the Directory Service can have the permissions required to manage their own resources within a VDC implementation. Structuring permissions requires balancing. Too many permissions can impede performance efficiency, and too few or loose permissions can increase security risks. Azure role-based access control (Azure RBAC) helps to address this problem, by offering fine-grained access management for resources in a VDC implementation.

### Security infrastructure

Security infrastructure refers to the segregation of traffic in a VDC implementation's specific virtual network segment. This infrastructure specifies how ingress and egress are controlled in a VDC implementation. Azure is based on a multitenant architecture that prevents unauthorized and unintentional traffic between deployments by using virtual network isolation, access control lists, load balancers, IP filters, and traffic flow policies. Network address translation (NAT) separates internal network traffic from external traffic.

The Azure fabric allocates infrastructure resources to tenant workloads and manages communications to and from virtual machines (VMs). The Azure hypervisor enforces memory and process separation between VMs and securely routes network traffic to guest OS tenants.

### Connectivity to the cloud

A virtual datacenter requires connectivity to external networks to offer services to customers, partners, or internal users. This need for connectivity refers not only to the Internet, but also to on-premises networks and datacenters.

Customers control which services can access and be accessed from the public internet. This access is controlled by using [Azure Firewall][AzFW] or other types of virtual network appliances (NVAs), custom routing policies by using [user-defined routes][UDR], and network filtering by using [network security groups][NSG]. We recommend that all internet-facing resources also be protected by the [Azure DDoS Protection Standard][DDoS].

Enterprises may need to connect their virtual datacenter to on-premises datacenters or other resources. This connectivity between Azure and on-premises networks is a crucial aspect when designing an effective architecture. Enterprises have two different ways to create this interconnection: transit over the Internet or via private direct connections.

An [Azure Site-to-Site VPN][VPN] connects on-premises networks to your virtual datacenter in Azure. The link is established through secure encrypted connections (IPsec tunnels). Azure Site-to-Site VPN connections are flexible, quick to create, and typically don't require any additional hardware procurement. Based on industry standard protocols, most current network devices can create VPN connections to Azure over the internet or existing connectivity paths.

[ExpressRoute][ExR] enables private connections between your virtual datacenter and any on-premises networks. ExpressRoute connections don't go over the public Internet, and offer higher security, reliability, and higher speeds (up to 100 Gbps) along with consistent latency. ExpressRoute provides the benefits of compliance rules associated with private connections. With [ExpressRoute Direct][ExRD], you can connect directly to Microsoft routers at either 10 Gbps or 100 Gbps.

Deploying ExpressRoute connections usually involves engaging with an ExpressRoute service provider (ExpressRoute Direct being the exception). For customers that need to start quickly, it's common to initially use Site-to-Site VPN to establish connectivity between a virtual datacenter and on-premises resources. Once your physical interconnection with your service provider is complete, then migrate connectivity over your ExpressRoute connection.

For large numbers of VPN or ExpressRoute connections, [Azure Virtual WAN][virtual-wan] is a networking service that provides optimized and automated branch-to-branch connectivity through Azure. Virtual WAN lets you connect to and configure branch devices to communicate with Azure. Connecting and configuring can be done either manually or by using preferred provider devices through a Virtual WAN partner. Using preferred provider devices allows ease of use, simplification of connectivity, and configuration management. The Azure WAN built-in dashboard provides instant troubleshooting insights that can help save you time, and gives you an easy way to view large-scale site-to-site connectivity. Virtual WAN also provides security services with an optional Azure Firewall and Firewall Manager in your Virtual WAN hub.

### Connectivity within the cloud

[Azure Virtual Networks][virtual-network] and [virtual network peering][virtual-network-peering] are the basic networking components in a virtual datacenter. A virtual network guarantees an isolation boundary for virtual datacenter resources. Peering allows intercommunication between different virtual networks within the same Azure region, across regions, and even between networks in different subscriptions. Both inside and between virtual networks, traffic flows can be controlled by sets of security rules specified for [network security groups][NSG], firewall policies ([Azure Firewall][AzFW] or [network virtual appliances][NVA]), and custom [user-defined routes][UDR].

Virtual networks are also anchor points for integrating platform as a service (PaaS) Azure products like [Azure Storage][Storage], [Azure SQL][SQL], and other integrated public services that have public endpoints. With [service endpoints][ServiceEndpoints] and [Azure Private Link][PrivateLink], you can integrate your public services with your private network. You can even take your public services private, but still enjoy the benefits of Azure-managed PaaS services.

## Virtual datacenter overview

### Topologies

A virtual datacenter can be built using one of these high-level topologies, based on your needs and scale requirements:

In a *Flat topology*, all resources are deployed in a single virtual network. Subnets allow for flow control and segregation.

![11][11]

In a *Mesh topology*, virtual network peering connects all virtual networks directly to each other.

![12][12]

A *Peering hub and spoke topology* is well suited for distributed applications and teams with delegated responsibilities.

![13][13]

An *Azure Virtual WAN topology* can support large-scale branch office scenarios and global WAN services.

![14][14]

The peering hub and spoke topology and the Azure Virtual WAN topology both use a hub and spoke design, which is optimal for communication, shared resources, and centralized security policy. Hubs are built using either a virtual network peering hub (labeled as `Hub Virtual Network` in the diagram) or a Virtual WAN hub (labeled as `Azure Virtual WAN` in the diagram). Azure Virtual WAN is designed for large-scale branch-to-branch and branch-to-Azure communications, or for avoiding the complexities of building all the components individually in a virtual networking peering hub. In some cases, your requirements might mandate a virtual network peering hub design, such as the need for network virtual appliances in the hub.

In both of the hub and spoke topologies, the hub is the central network zone that controls and inspects all traffic between different zones: internet, on-premises, and the spokes. The hub and spoke topology helps the IT department centrally enforce security policies. It also reduces the potential for misconfiguration and exposure.

The hub often contains the common service components consumed by the spokes. The following examples are common central services:

- The Windows Active Directory infrastructure, required for user authentication of third parties that access from untrusted networks before they get access to the workloads in the spoke. It includes the related Active Directory Federation Services (AD FS).
- A Distributed Name System (DNS) service to resolve naming for the workload in the spokes, to access resources on-premises and on the internet if [Azure DNS][DNS] isn't used.
- A public key infrastructure (PKI), to implement single sign-on on workloads.
- Flow control of TCP and UDP traffic between the spoke network zones and the internet.
- Flow control between the spokes and on-premises.
- If needed, flow control between one spoke and another.

A virtual datacenter reduces overall cost by using the shared hub infrastructure between multiple spokes.

The role of each spoke can be to host different types of workloads. The spokes also provide a modular approach for repeatable deployments of the same workloads. Examples include dev/test, user acceptance testing, preproduction, and production. The spokes can also segregate and enable different groups within your organization. An example is DevOps groups. Inside a spoke, it's possible to deploy a basic workload or complex multitier workloads with traffic control between the tiers.

### Subscription limits and multiple hubs

> [!IMPORTANT]
> Based on the size of your Azure deployments, a multiple hub strategy may be needed. When designing your hub and spoke strategy, ask "can this design scale to use another hub virtual network in this region?", also, "can this design scale to accommodate multiple regions?" It's far better to plan for a design that scales and not need it, than to fail to plan and need it.
>
> When to scale to a secondary (or more) hub will depend on myriad factors, usually based on inherent limits on scale. Be sure to review the subscription, virtual network, and virtual machine [limits][limits] when designing for scale.

In Azure, every component, whatever the type, is deployed in an Azure subscription. The isolation of Azure components in different Azure subscriptions can satisfy the requirements of different lines of business, such as setting up differentiated levels of access and authorization.

A single VDC implementation can scale up to large number of spokes, although, as with every IT system, there are platform limits. The hub deployment is bound to a specific Azure subscription, which has restrictions and limits (for example, a maximum number of virtual network peerings. For details, see [Azure subscription and service limits, quotas, and constraints][limits]). In cases where limits may be an issue, the architecture can scale up further by extending the model from a single hub-spokes to a cluster of hub and spokes. Multiple hubs in one or more Azure regions can be connected using virtual network peering, ExpressRoute, Virtual WAN, or Site-to-Site VPN.

![2][2]

The introduction of multiple hubs increases the cost and management effort of the system. It is only justified due to scalability, system limits, redundancy, regional replication for end-user performance, or disaster recovery. In scenarios requiring multiple hubs, all the hubs should strive to offer the same set of services for operational ease.

### Interconnection between spokes

Inside a single spoke, or a flat network design, it's possible to implement complex multitier workloads. Multitier configurations can be implemented using subnets, one for every tier or application, in the same virtual network. Traffic control and filtering are done using network security groups and user-defined routes.

An architect might want to deploy a multitier workload across multiple virtual networks. With virtual network peering, spokes can connect to other spokes in the same hub or different hubs. A typical example of this scenario is the case where application processing servers are in one spoke, or virtual network. The database deploys in a different spoke, or virtual network. In this case, it's easy to interconnect the spokes with virtual network peering and, by doing that, avoid transiting through the hub. A careful architecture and security review should be done to ensure that bypassing the hub doesn't bypass important security or auditing points that might exist only in the hub.

![3][3]

Spokes can also be interconnected to a spoke that acts as a hub. This approach creates a two-level hierarchy: the spoke in the higher level (level 0) becomes the hub of lower spokes (level 1) of the hierarchy. The spokes of a VDC implementation are required to forward the traffic to the central hub so that the traffic can transit to its destination in either the on-premises network or the public internet. An architecture with two levels of hubs introduces complex routing that removes the benefits of a simple hub-spoke relationship.

Although Azure allows complex topologies, one of the core principles of the VDC concept is repeatability and simplicity. To minimize management effort, the simple hub-spoke design is the VDC reference architecture that we recommend.

### Components

The virtual datacenter is made up of four basic component types: **Infrastructure**, **Perimeter Networks**, **Workloads**, and **Monitoring**.

Each component type consists of various Azure features and resources. Your VDC implementation is made up of instances of multiple components types and multiple variations of the same component type. For instance, you may have many different, logically separated workload instances that represent different applications. You use these different component types and instances to ultimately build the VDC.

![4][4]

The preceding high-level conceptual architecture of the VDC shows different component types used in different zones of the hub-spokes topology. The diagram shows infrastructure components in various parts of the architecture.

As good practice in general, access rights and privileges should be group-based. Dealing with groups rather than individual users eases maintenance of access policies, by providing a consistent way to manage it across teams, and aids in minimizing configuration errors. Assigning and removing users to and from appropriate groups helps keeping the privileges of a specific user up to date.

Each role group should have a unique prefix on their names. This prefix makes it easy to identify which group is associated with which workload. For example, a workload hosting an authentication service might have groups named **AuthServiceNetOps**, **AuthServiceSecOps**, **AuthServiceDevOps**, and **AuthServiceInfraOps**. Centralized roles, or roles not related to a specific service, might be prefaced with **Corp**. An example is **CorpNetOps**.

Many organizations use a variation of the following groups to provide a major breakdown of roles:

- The central IT team named **Corp** has the ownership rights to control infrastructure components. Examples are networking and security. The group needs to have the role of contributor on the subscription, control of the hub, and network contributor rights in the spokes. Large organizations frequently split up these management responsibilities between multiple teams. Examples are a network operations **CorpNetOps** group with exclusive focus on networking and a security operations **CorpSecOps** group responsible for the firewall and security policy. In this specific case, two different groups need to be created for assignment of these custom roles.
- The dev/test group named **AppDevOps** has the responsibility to deploy app or service workloads. This group takes the role of virtual machine contributor for IaaS deployments or one or more PaaS contributor's roles. For more information, see [Azure built-in roles][Roles]. Optionally, the dev/test team might need visibility on security policies (network security groups) and routing policies (user-defined routes) inside the hub or a specific spoke. In addition to the role of contributor for workloads, this group would also need the role of network reader.
- The operation and maintenance group called **CorpInfraOps** or **AppInfraOps** has the responsibility of managing workloads in production. This group needs to be a subscription contributor on workloads in any production subscriptions. Some organizations might also evaluate if they need an additional escalation support team group with the role of subscription contributor in production and the central hub subscription. The additional group fixes potential configuration issues in the production environment.

The VDC is designed so that groups created for the central IT team, managing the hub, have corresponding groups at the workload level. In addition to managing hub resources only, the central IT team can control external access and top-level permissions on the subscription. Workload groups can also control resources and permissions of their virtual network independently from the central IT team.

The virtual datacenter is partitioned to securely host multiple projects across different lines of business. All projects require different isolated environments (dev, UAT, and production). Separate Azure subscriptions for each of these environments can provide natural isolation.

![5][5]

The preceding diagram shows the relationship between an organization's projects, users, and groups and the environments where the Azure components are deployed.

Typically in IT, an environment (or tier) is a system in which multiple applications are deployed and executed. Large enterprises use a development environment (where changes are made and tested) and a production environment (what end-users use). Those environments are separated, often with several staging environments in between them to allow phased deployment (rollout), testing, and rollback if problems arise. Deployment architectures vary significantly, but usually the basic process of starting at development (DEV) and ending at production (PROD) is still followed.

A common architecture for these types of multitier environments consists of DevOps for development and testing, UAT for staging, and production environments. Organizations can use single or multiple Azure AD tenants to define access and rights to these environments. The previous diagram shows a case where two different Azure AD tenants are used: one for DevOps and UAT, and the other exclusively for production.

The presence of different Azure AD tenants enforces the separation between environments. The same group of users, such as the central IT team, need to authenticate by using a different URI to access a different Azure AD tenant to modify the roles or permissions of either the DevOps or production environments of a project. The presence of different user authentications to access different environments reduces possible outages and other issues caused by human errors.

#### Component type: Infrastructure

This component type is where most of the supporting infrastructure resides. It's also where your centralized IT, security, and compliance teams spend most of their time.

![6][6]

Infrastructure components provide an interconnection for the different components of a VDC implementation, and are present in both the hub and the spokes. The responsibility for managing and maintaining the infrastructure components is typically assigned to the central IT team or security team.

One of the primary tasks of the IT infrastructure team is to guarantee the consistency of IP address schemas across the enterprise. The private IP address space assigned to a VDC implementation must be consistent and **not** overlapping with private IP addresses assigned on your on-premises networks.

While NAT on the on-premises edge routers or in Azure environments can avoid IP address conflicts, it adds complications to your infrastructure components. Simplicity of management is one of the key goals of the VDC, so using NAT to handle IP concerns, while a valid solution, is not a recommended solution.

Infrastructure components have the following functionality:

- [Identity and directory services][azure-ad]. Access to every resource type in Azure is controlled by an identity stored in a directory service. The directory service stores not only the list of users, but also the access rights to resources in a specific Azure subscription. These services can exist cloud-only, or they can be synchronized with on-premises identity stored in Active Directory.
- [Virtual Network][virtual-network]. Virtual networks are one of main components of the VDC, and enable you to create a traffic isolation boundary on the Azure platform. A virtual network is composed of a single or multiple virtual network segments, each with a specific IP network prefix (a subnet, either IPv4 or dual stack IPv4/IPv6). The virtual network defines an internal perimeter area where IaaS virtual machines and PaaS services can establish private communications. VMs (and PaaS services) in one virtual network can't communicate directly to VMs (and PaaS services) in a different virtual network, even if both virtual networks are created by the same customer, under the same subscription. Isolation is a critical property that ensures customer VMs and communication remains private within a virtual network. Where cross-network connectivity is desired, the following features describe how that can be accomplished.
- [Virtual network peering][virtual-network-peering]. The fundamental feature used to create the infrastructure of a VDC is virtual network peering, which connects two virtual networks in the same region, either through the Azure datacenter network or using the Azure worldwide backbone across regions.
- [Virtual Network service endpoints][ServiceEndpoints]. Service endpoints extend your virtual network private address space to include your PaaS space. The endpoints also extend the identity of your virtual network to the Azure services over a direct connection. Endpoints allow you to secure your critical Azure service resources to only your virtual networks.
- [Private Link][PrivateLink]. Azure Private Link enables you to access Azure PaaS Services (for example, [Azure Storage][Storage], [Azure Cosmos DB][cosmos-db], and [Azure SQL Database][SQL]) and Azure hosted customer/partner services over a Private Endpoint in your virtual network. Traffic between your virtual network and the service traverses over the Microsoft backbone network, eliminating exposure from the public Internet. You can also create your own [Private Link Service][PrivateLinkSvc] in your virtual network and deliver it privately to your customers. The setup and consumption experience using Azure Private Link is consistent across Azure PaaS, customer-owned, and shared partner services.
- [User-defined routes][UDR]. Traffic in a virtual network is routed by default based on the system routing table. A user-defined route is a custom routing table that network administrators can associate to one or more subnets to override the behavior of the system routing table and define a communication path within a virtual network. The presence of user-defined routes guarantees that egress traffic from the spoke transit through specific custom VMs or network virtual appliances and load balancers present in both the hub and the spokes.
- [Network security groups][NSG]. A network security group is a list of security rules that act as traffic filtering on IP sources, IP destinations, protocols, IP source ports, and IP destination ports (also called a Layer 4 five-tuple). The network security group can be applied to a subnet, a Virtual NIC associated with an Azure VM, or both. The network security groups are essential to implement a correct flow control in the hub and in the spokes. The level of security afforded by the network security group is a function of which ports you open, and for what purpose. Customers should apply additional per-VM filters with host-based firewalls such as iptables or the Windows Firewall.
- [DNS][DNS]. DNS provides name resolution for resources in a virtual datacenter. Azure provides DNS services for both [public][DNS] and [private][PrivateDNS] name resolution. Private zones provide name resolution both within a virtual network and across virtual networks. You can have private zones not only span across virtual networks in the same region, but also across regions and subscriptions. For public resolution, Azure DNS provides a hosting service for DNS domains, providing name resolution using Microsoft Azure infrastructure. By hosting your domains in Azure, you can manage your DNS records using the same credentials, APIs, tools, and billing as your other Azure services.
- [Management group][MgmtGrp], [subscription](../ready/azure-best-practices/scale-subscriptions.md), and [resource group][RGMgmt] management. A subscription defines a natural boundary to create multiple groups of resources in Azure. This separation can be for function, role segregation, or billing. Resources in a subscription are assembled together in logical containers known as resource groups. The resource group represents a logical group to organize the resources in a virtual datacenter. If your organization has many subscriptions, you may need a way to efficiently manage access, policies, and compliance for those subscriptions. Azure management groups provide a level of scope above subscriptions. You organize subscriptions into containers known as management groups and apply your governance conditions to the management groups. All subscriptions within a management group automatically inherit the conditions applied to the management group. To see these three features in a hierarchy view, see [Organizing your resources](../ready/azure-setup-guide/organize-resources.md) in the Cloud Adoption Framework.
- [Azure role-based access control (Azure RBAC)][RBAC]. Azure RBAC can map organizational roles and rights to access specific Azure resources, allowing you to restrict users to only a certain subset of actions. If you're synchronizing Azure Active Directory with an on-premises Active Directory, you can use the same Active Directory groups in Azure that you use on-premises. With Azure RBAC, you can grant access by assigning the appropriate role to users, groups, and applications within the relevant scope. The scope of a role assignment can be an Azure subscription, a resource group, or a single resource. Azure RBAC allows inheritance of permissions. A role assigned at a parent scope also grants access to the children contained within it. Using Azure RBAC, you can segregate duties and grant only the amount of access to users that they need to perform their jobs. For example, one employee can manage virtual machines in a subscription, while another can manage SQL Server databases in the same subscription.

#### Component Type: Perimeter Networks

Components of a perimeter network (sometimes called a DMZ network) connect your on-premises or physical datacenter networks, along with any internet connectivity. The perimeter typically requires a significant time investment from your network and security teams.

Incoming packets should flow through the security appliances in the hub before reaching the back-end servers and services in the spokes. Examples include the firewall, IDS, and IPS. Before they leave the network, internet-bound packets from the workloads should also flow through the security appliances in the perimeter network. This flow enables policy enforcement, inspection, and auditing.

Perimeter network components include:

- [Virtual networks][virtual-network], [user-defined routes][UDR], and [network security groups][NSG]
- [Network virtual appliances][NVA]
- [Azure Load Balancer][ALB]
- [Azure Application Gateway][AppGW] with [web application firewall (WAF)][AppGWWAF]
- [Public IPs][PIP]
- [Azure Front Door][azure-front-door] with [web application firewall (WAF)][AFDWAF]
- [Azure Firewall][AzFW] and [Azure Firewall Manager][AzFWMgr]
- [Standard DDoS Protection][DDoS]

Usually, the central IT team and security teams have responsibility for requirement definition and operation of the perimeter networks.

![7][7]

The preceding diagram shows the enforcement of two perimeters with access to the internet and an on-premises network, both resident in the DMZ hub. In the DMZ hub, the perimeter network to internet can scale up to support many lines of business, using multiple farms of Web Application Firewalls (WAFs) or Azure Firewalls. The hub also allows for on-premises connectivity via VPN or ExpressRoute as needed.

> [!NOTE]
> In the preceding diagram, in the "DMZ Hub", many of the following features can be bundled together in an Azure Virtual WAN hub (such as virtual networks, user-defined routes, network security groups, VPN gateways, ExpressRoute gateways, Azure load balancers, Azure Firewalls, Firewall Manager, and DDOS). Using Azure Virtual WAN hubs can make the creation of the hub virtual network, and thus the VDC, much easier, since most of the engineering complexity is handled for you by Azure when you deploy an Azure Virtual WAN hub.

[Virtual networks][virtual-network]. The hub is typically built on a virtual network with multiple subnets to host the different types of services that filter and inspect traffic to or from the internet via Azure Firewall, NVAs, WAF, and Azure Application Gateway instances.

[User-defined routes][UDR]. Using user-defined routes, customers can deploy firewalls, IDS/IPS, and other virtual appliances, and route network traffic through these security appliances for security boundary policy enforcement, auditing, and inspection. User-defined routes can be created in both the hub and the spokes to guarantee that traffic transits through the specific custom VMs, Network Virtual Appliances, and load balancers used by a VDC implementation. To guarantee that traffic generated from virtual machines residing in the spoke transits to the correct virtual appliances, a user-defined route needs to be set in the subnets of the spoke by setting the front-end IP address of the internal load balancer as the next hop. The internal load balancer distributes the internal traffic to the virtual appliances (load balancer back-end pool).

[Azure Firewall][AzFW] is a managed network security service that protects your Azure Virtual Network resources. It's a stateful managed firewall with high availability and cloud scalability. You can centrally create, enforce, and log application and network connectivity policies across subscriptions and virtual networks. Azure Firewall uses a static public IP address for your virtual network resources. It allows outside firewalls to identify traffic that originates from your virtual network. The service is fully integrated with Azure Monitor for logging and analytics.

If you use the Azure Virtual WAN topology, the [Azure Firewall Manager][AzFWMgr] is a security management service that provides central security policy and route management for cloud-based security perimeters. It works with Azure Virtual WAN hub, a Microsoft-managed resource that lets you easily create hub and spoke architectures. When security and routing policies are associated with such a hub, it's referred to as a secured virtual hub.

[Network virtual appliances][NVA]. In the hub, the perimeter network with access to the internet is normally managed through an Azure Firewall instance or a farm of firewalls or web application firewall (WAF).

Different lines of business commonly use many web applications, which tend to suffer from various vulnerabilities and potential exploits. Web application firewalls are a special type of product used to detect attacks against web applications, HTTP/HTTPS, in more depth than a generic firewall. Compared with tradition firewall technology, WAFs have a set of specific features to protect internal web servers from threats.

An Azure Firewall or NVA firewall both use a common administration plane, with a set of security rules to protect the workloads hosted in the spokes, and control access to on-premises networks. The Azure Firewall has scalability built in, whereas NVA firewalls can be manually scaled behind a load balancer. Generally, a firewall farm has less specialized software compared with a WAF, but has a broader application scope to filter and inspect any type of traffic in egress and ingress. If an NVA approach is used, they can be found and deployed from Azure Marketplace.

We recommend that you use one set of Azure Firewall instances, or NVAs, for traffic originating on the internet. Use another for traffic originating on-premises. Using only one set of firewalls for both is a security risk as it provides no security perimeter between the two sets of network traffic. Using separate firewall layers reduces the complexity of checking security rules and makes it clear which rules correspond to which incoming network request.

[Azure Load Balancer][ALB] offers a high availability Layer 4 (TCP/UDP) service, which can distribute incoming traffic among service instances defined in a load-balanced set. Traffic sent to the load balancer from front-end endpoints (public IP endpoints or private IP endpoints) can be redistributed with or without address translation to a set of back-end IP address pool (such as network virtual appliances or virtual machines).

Azure Load Balancer can probe the health of the various server instances as well, and when an instance fails to respond to a probe, the load balancer stops sending traffic to the unhealthy instance. In a virtual datacenter, an external load balancer is deployed to the hub and the spokes. In the hub, the load balancer is used to efficiently route traffic across firewall instances, and in the spokes, load balancers are used to manage application traffic.

[Azure Front Door][azure-front-door] (AFD) is Microsoft's highly available and scalable Web Application Acceleration Platform, Global HTTP Load Balancer, Application Protection, and Content Delivery Network. Running in more than 100 locations at the edge of Microsoft's Global Network, AFD enables you to build, operate, and scale out your dynamic web application and static content. AFD provides your application with world-class end-user performance, unified regional/stamp maintenance automation, BCDR automation, unified client/user information, caching, and service insights. The platform offers:

- Performance, reliability, and support service-level agreements (SLAs).
- Compliance certifications.
- Auditable security practices that are developed, operated, and natively supported by Azure.

Azure Front Door also provides a web application firewall (WAF), which protects web applications from common vulnerabilities and exposures.

[Azure Application Gateway][AppGW] is a dedicated virtual appliance providing a managed application delivery controller. It offers various Layer 7 load-balancing capabilities for your application. It allows you to optimize web farm performance by offloading CPU-intensive SSL termination to the application gateway. It also provides other Layer 7 routing capabilities, such as round-robin distribution of incoming traffic, cookie-based session affinity, URL-path-based routing, and the ability to host multiple websites behind a single application gateway. A web application firewall (WAF) is also provided as part of the application gateway WAF SKU. This SKU provides protection to web applications from common web vulnerabilities and exploits. Application Gateway can be configured as internet-facing gateway, internal-only gateway, or a combination of both.

[Public IPs][PIP]. With some Azure features, you can associate service endpoints to a public IP address so that your resource is accessible from the internet. This endpoint uses NAT to route traffic to the internal address and port on the virtual network in Azure. This path is the primary way for external traffic to pass into the virtual network. You can configure public IP addresses to determine which traffic is passed in and how and where it's translated onto the virtual network.

[Azure DDoS Protection Standard][DDoS] provides additional mitigation capabilities over the [Basic service][DDoS] tier that are tuned specifically to Azure Virtual Network resources. DDoS Protection Standard is simple to enable and requires no application changes. Protection policies are tuned through dedicated traffic monitoring and machine learning algorithms. Policies are applied to public IP addresses associated to resources deployed in virtual networks. Examples include Azure Load Balancer, Azure Application Gateway, and Azure Service Fabric instances. Near real-time, system-generated logs are available through Azure Monitor views during an attack and for history. Application layer protection can be added through the Azure Application Gateway web application firewall. Protection is provided for IPv4 and IPv6 Azure public IP addresses.

The hub and spoke topology uses virtual network peering and user-defined routes to route traffic properly.

![8][8]

In the diagram, the user-defined route ensures that traffic flows from the spoke to the firewall before passing to on-premises through the ExpressRoute gateway (if the firewall policy allows that flow).

#### Component type: Monitoring

[Monitoring components][MonitorOverview] provide visibility and alerting from all the other component types. All teams should have access to monitoring for the components and services they have access to. If you have a centralized help desk or operations teams, they require integrated access to the data provided by these components.

Azure offers different types of logging and monitoring services to track the behavior of Azure-hosted resources. Governance and control of workloads in Azure is based not just on collecting log data but also on the ability to trigger actions based on specific reported events.

[Azure Monitor][AzureMonitor]. Azure includes multiple services that individually perform a specific role or task in the monitoring space. Together, these services deliver a comprehensive solution for collecting, analyzing, and acting on system-generated logs from your applications and the Azure resources that support them. They can also work to monitor critical on-premises resources in order to provide a hybrid monitoring environment. Understanding the tools and data that are available is the first step in developing a complete monitoring strategy for your applications.

There are two fundamental types of logs in Azure Monitor:

- [Metrics][Metrics] are numerical values that describe some aspect of a system at a particular point in time. They are lightweight and capable of supporting near real-time scenarios. For many Azure resources, you'll see data collected by Azure Monitor right in their Overview page in the Azure portal. As an example, look at any virtual machine and you'll see several charts displaying performance metrics. Select any of the graphs to open the data in metrics explorer in the Azure portal, which allows you to chart the values of multiple metrics over time. You can view the charts interactively or pin them to a dashboard to view them with other visualizations.

- [Logs][Logs] contain different kinds of data organized into records with different sets of properties for each type. Events and traces are stored as logs along with performance data, which can all be combined for analysis. Log data collected by Azure Monitor can be analyzed with queries to quickly retrieve, consolidate, and analyze collected data. Logs are stored and queried from [Log Analytics][LogAnalytics]. You can create and test queries using Log Analytics in the Azure portal and then either directly analyze the data using these tools or save queries for use with visualizations or alert rules.

![9][9]

Azure Monitor can collect data from a variety of sources. You can think of monitoring data for your applications in tiers ranging from your application, any operating system, and the services it relies on, down to the Azure platform itself. Azure Monitor collects data from each of the following tiers:

- **Application monitoring data:** Data about the performance and functionality of the code you have written, regardless of its platform.
- **Guest OS monitoring data:** Data about the operating system on which your application is running. This OS could be running in Azure, another cloud, or on-premises.
- **Azure resource monitoring data:** Data about the operation of an Azure resource.
- **Azure subscription monitoring data:** Data about the operation and management of an Azure subscription, as well as data about the health and operation of Azure itself.
- **Azure tenant monitoring data:** Data about the operation of tenant-level Azure services, such as Azure Active Directory.
- **Custom sources:** Logs sent from on-premises sources can be included as well. Examples include on-premises server events or network device syslog output.

Monitoring data is only useful if it can increase your visibility into the operation of your computing environment. Azure Monitor includes several features and tools that provide valuable insights into your applications and other resources that they depend on. Monitoring solutions and features such as Application Insights and Azure Monitor for containers provide deep insights into different aspects of your application and specific Azure services.

Monitoring solutions in Azure Monitor are packaged sets of logic that provide insights for a particular application or service. They include logic for collecting monitoring data for the application or service, queries to analyze that data, and views for visualization. Monitoring solutions are available from Microsoft and partners to provide monitoring for various Azure services and other applications.

With all of this rich data collected, it's important to take proactive action on events happening in your environment where manual queries alone won't suffice. Alerts in Azure Monitor proactively notify you of critical conditions and potentially attempt to take corrective action. Alert rules based on metrics provide near real-time alerting based on numeric values, while rules based on logs allow for complex logic across data from multiple sources. Alert rules in Azure Monitor use action groups, which contain unique sets of recipients and actions that can be shared across multiple rules. Based on your requirements, action groups can perform such actions as using webhooks that cause alerts to start external actions or to integrate with your ITSM tools.

Azure Monitor also allows the creation of custom dashboards. Azure dashboards allow you to combine different kinds of data, including both metrics and logs, into a single pane in the Azure portal. You can optionally share the dashboard with other Azure users. Elements throughout Azure Monitor can be added to an Azure dashboard in addition to the output of any log query or metrics chart. For example, you could create a dashboard that combines tiles that show a graph of metrics, a table of activity logs, a usage chart from Application Insights, and the output of a log query.

Finally, Azure Monitor data is a native source for Power BI. Power BI is a business analytics service that provides interactive visualizations across a variety of data sources and is an effective means of making data available to others within and outside your organization. You can configure Power BI to automatically import log data from Azure Monitor to take advantage of these additional visualizations.

[Azure Network Watcher][NetWatch] provides tools to monitor, diagnose, and view metrics and enable or disable logs for resources in a virtual network in Azure. It's a multifaceted service that allows the following functionalities and more:

- Monitor communication between a virtual machine and an endpoint.
- View resources in a virtual network and their relationships.
- Diagnose network traffic filtering problems to or from a VM.
- Diagnose network routing problems from a VM.
- Diagnose outbound connections from a VM.
- Capture packets to and from a VM.
- Diagnose problems with an virtual network gateway and connections.
- Determine relative latencies between Azure regions and internet service providers.
- View security rules for a network interface.
- View network metrics.
- Analyze traffic to or from a network security group.
- View diagnostic logs for network resources.

#### Component type: Workloads

Workload components are where your actual applications and services reside. It's where your application development teams spend most of their time.

The workload possibilities are endless. The following are just a few of the possible workload types:

**Internal applications:** Line-of-business applications are critical to enterprise operations. These applications have some common characteristics:

- **Interactive:** Data is entered, and results or reports are returned.
- **Data-driven:** Data intensive with frequent access to databases or other storage.
- **Integrated:** Offer integration with other systems within or outside the organization.

**Customer-facing web sites (internet-facing or internally facing):** Most internet applications are web sites. Azure can run a web site via either an IaaS virtual machine or an [Azure Web Apps][WebApps] site (PaaS). Azure Web Apps integrates with virtual networks to deploy web apps in a spoke network zone. Internally facing web sites don't need to expose a public internet endpoint because the resources are accessible via private non-internet routable addresses from the private virtual network.

**Big data analytics:** When data needs to scale up to larger volumes, relational databases may not perform well under the extreme load or unstructured nature of the data. [Azure HDInsight][HDInsight] is a managed, full-spectrum, open-source analytics service in the cloud for enterprises. You can use open-source frameworks such as Hadoop, Apache Spark, Apache Hive, LLAP, Apache Kafka, Apache Storm, and R. HDInsight supports deploying into a location-based virtual network, can be deployed to a cluster in a spoke of the virtual datacenter.

**Events and Messaging:** [Azure Event Hubs][EventHubs] is a big data streaming platform and event ingestion service. It can receive and process millions of events per second. It provides low latency and configurable time retention, enabling you to ingest massive amounts of data into Azure and read it from multiple applications. A single stream can support both real-time and batch-based pipelines.

You can implement a highly reliable cloud messaging service between applications and services through [Azure Service Bus][ServiceBus]. It offers asynchronous brokered messaging between client and server, structured first-in-first-out (FIFO) messaging, and publishes and subscribe capabilities.

![10][10]

These examples barely scratch the surface of the types of workloads you can create in Azure&mdash;everything from a basic Web and SQL app to the latest in IoT, big data, machine learning, AI, and so much more.

### Highly availability: multiple virtual datacenters

So far, this article has focused on the design of a single VDC, describing the basic components and architectures that contribute to resiliency. Azure features such as Azure load balancer, NVAs, availability zones, availability sets, scale sets, and other capabilities that help you include solid SLA levels into your production services.

However, because a virtual datacenter is typically implemented within a single region, it might be vulnerable to outages that affect the entire region. Customers that require high availability must protect the services through deployments of the same project in two or more VDC implementations deployed to different regions.

In addition to SLA concerns, several common scenarios benefit from running multiple virtual datacenters:

- Regional or global presence of your end users or partners.
- Disaster recovery requirements.
- A mechanism to divert traffic between datacenters for load or performance.

#### Regional/global presence

Azure datacenters exist in many regions worldwide. When selecting multiple Azure datacenters, consider two related factors: geographical distances and latency. To optimize user experience, evaluate the distance between each virtual datacenter as well as the distance from each virtual datacenter to the end users.

An Azure region that hosts your virtual datacenter must conform with regulatory requirements of any legal jurisdiction under which your organization operates.

#### Disaster recovery

The design of a disaster recovery plan depends on the types of workloads and the ability to synchronize state of those workloads between different VDC implementations. Ideally, most customers desire a fast fail-over mechanism, and this requirement may need application data synchronization between deployments running in multiple VDC implementations. However, when designing disaster recovery plans, it's important to consider that most applications are sensitive to the latency that can be caused by this data synchronization.

Synchronization and heartbeat monitoring of applications in different VDC implementations requires them to communicate over the network. Multiple VDC implementations in different regions can be connected through:

- Hub-to-hub communication built into Azure Virtual WAN hubs across regions in the same Virtual WAN.
- Virtual network peering to connect hubs across regions.
- ExpressRoute private peering, when the hubs in each VDC implementation are connected to the same ExpressRoute circuit.
- Multiple ExpressRoute circuits connected via your corporate backbone, and your multiple VDC implementations connected to the ExpressRoute circuits.
- Site-to-Site VPN connections between the hub zone of your VDC implementations in each Azure region.

Typically, Virtual WAN hubs, virtual network peering, or ExpressRoute connections are preferred for network connectivity, due to the higher bandwidth and consistent latency levels when passing through the Microsoft backbone.

Run network qualification tests to verify the latency and bandwidth of these connections, and decide whether synchronous or asynchronous data replication is appropriate based on the result. It's also important to weigh these results in view of the optimal recovery time objective (RTO).

#### Disaster recovery: diverting traffic from one region to another

Both [Azure Traffic Manager][azure-traffic-manager] and [Azure Front Door][azure-front-door] periodically check the service health of listening endpoints in different VDC implementations and, if those endpoints fail, route automatically to the next closest VDC. Traffic Manager uses real-time user measurements and DNS to route users to the closest (or next closest during failure). Azure Front Door is a reverse proxy at over 100 Microsoft backbone edge sites, using anycast to route users to the closest listening endpoint.

### Summary

A virtual datacenter approach to datacenter migration creates a scalable architecture that optimizes Azure resource use, lowers costs, and simplifies system governance. The virtual datacenter is typical based on hub and spoke network topologies (using either virtual network peering or Virtual WAN hubs). Common shared services provided in the hub, and specific applications and workloads are deployed in the spokes. The virtual datacenter also matches the structure of company roles, where different departments such as Central IT, DevOps, and Operations and Maintenance all work together while performing their specific roles. The virtual datacenter supports migrating existing on-premises workloads to Azure, but also provides many advantages to cloud-native deployments.

## References

Learn more about the Azure capabilities discussed in this document.

:::row:::
    :::column:::
        **Network features** <br>
        [Azure Virtual Networks][virtual-network] <br>
        [Network Security Groups][NSG] <br>
        [Service Endpoints][ServiceEndpoints] <br>
        [Private Link][PrivateLink] <br>
        [User-Defined Routes][UDR] <br>
        [Network Virtual Appliances][NVA] <br>
        [Public IP Addresses][PIP] <br>
        [Azure DNS][DNS]
    :::column-end:::
    :::column:::
        **Load balancing** <br>
        [Azure Front Door][azure-front-door] <br>
        [Azure Load Balancer (Layer 4)][ALB] <br>
        [Application Gateway (Layer 7)][AppGW] <br>
        [Azure Traffic Manager][azure-traffic-manager]
    :::column-end:::
    :::column:::
        **Connectivity** <br>
        [Virtual Network Peering][virtual-network-peering] <br>
        [Virtual Private Network][VPN] <br>
        [Virtual WAN][virtual-wan] <br>
        [ExpressRoute][ExR] <br>
        [ExpressRoute Direct][ExRD]
    :::column-end:::
:::row-end:::

:::row:::
    :::column:::
        **Identity** <br>
        [Azure Active Directory][azure-ad] <br>
        [Multi-Factor Authentication][multi-factor-authentication] <br>
        [Azure role-based access control][RBAC] <br>
        [Azure built-in roles][Roles]
    :::column-end:::
    :::column:::
        **Monitoring** <br>
        [Network Watcher][NetWatch] <br>
        [Azure Monitor][MonitorOverview] <br>
        [Log Analytics][LogAnalytics]
    :::column-end:::
    :::column:::
        **Best practices** <br>
        [Management Group][MgmtGrp] <br>
        [Subscription Management](../ready/azure-best-practices/scale-subscriptions.md) <br>
        [Resource Group Management][RGMgmt] <br>
        [Azure Subscription Limits][limits]
    :::column-end:::
:::row-end:::

:::row:::
    :::column:::
        **Security** <br>
        [Azure Firewall][AzFW] <br>
        [Firewall Manager][AzFWMgr] <br>
        [Application Gateway WAF][AppGWWAF] <br>
        [Front Door WAF][AFDWAF] <br>
        [Azure DDoS][DDoS]
    :::column-end:::
    :::column:::
        **Other Azure services** <br>
        [Azure Storage][Storage] <br>
        [Azure SQL][SQL] <br>
        [Azure Web Apps][WebApps] <br>
        [Azure Cosmos DB][cosmos-db] <br>
        [HDInsight][HDInsight] <br>
        [Event Hubs][EventHubs] <br>
        [Service Bus][ServiceBus] <br>
        [Azure IoT][IoT] <br>
        [Azure Machine Learning][machine-learning]
    :::column-end:::
:::row-end:::

## Next steps

- Learn more about [virtual network peering][virtual-network-peering], the core technology of hub and spoke topologies.
- Implement [Azure Active Directory][azure-ad] to use [Azure role-based access control][RBAC].
- Develop a subscription and resource management model using Azure role-based access control that fits the structure, requirements, and policies of your organization. The most important activity is planning. Analyze how reorganizations, mergers, new product lines, and other considerations will affect your initial models to ensure you can scale to meet future needs and growth.

<!-- images -->

[0]: ../_images/vdc/networking-vdc-redundant.png "Examples of component overlap"
<!-- *1* >: ../_images/vdc/networking-vdc-high-level.png "Example of hub and spoke VDC" -->
[2]: ../_images/vdc/networking-vdc-cluster.png "Cluster of hubs and spokes"
[3]: ../_images/vdc/networking-vdc-spoke-to-spoke.png "Spoke-to-spoke"
[4]: ../_images/vdc/networking-vdc-block-level-diagram.png "Block level diagram of the VDC"
[5]: ../_images/vdc/networking-vdc-users-groups-subscriptions.png "Users, groups, subscriptions, and projects"
[6]: ../_images/vdc/networking-vdc-infrastructure.png "Infrastructure diagram"
[7]: ../_images/vdc/networking-vdc-perimeter.png "Infrastructure diagram"
[8]: ../_images/vdc/networking-vdc-perimeter-peering.png "Virtual Network Peering and perimeter networks"
[9]: ../_images/vdc/networking-vdc-monitoring.png "Diagram of Azure Monitor"
[10]: ../_images/vdc/networking-vdc-workloads.png "Diagram of Workloads"
[11]: ../_images/vdc/networking-vdc-brief-flat.png "Example of a flat network"
[12]: ../_images/vdc/networking-vdc-brief-mesh.png "Example of a meshed network"
[13]: ../_images/vdc/networking-vdc-brief-hub.png "Example of a hub and spoke VDC"
[14]: ../_images/vdc/networking-vdc-brief-vwan.png "Example of a Virtual WAN VDC"

<!-- links -->

[limits]: /azure/azure-resource-manager/management/azure-subscription-service-limits
[Roles]: /azure/role-based-access-control/built-in-roles
[virtual-network]: /azure/virtual-network/virtual-networks-overview
[NSG]: /azure/virtual-network/network-security-groups-overview
[PrivateLink]: /azure/private-link/private-link-overview
[PrivateLinkSvc]: /azure/private-link/private-link-service-overview
[ServiceEndpoints]: /azure/virtual-network/virtual-network-service-endpoints-overview
[DNS]: /azure/dns/dns-overview
[PrivateDNS]: /azure/dns/private-dns-overview
[virtual-network-peering]: /azure/virtual-network/virtual-network-peering-overview
[UDR]: /azure/virtual-network/virtual-networks-udr-overview
[RBAC]: /azure/role-based-access-control/overview
[multi-factor-authentication]: /azure/active-directory/authentication/concept-mfa-howitworks
[azure-ad]: /azure/active-directory/fundamentals/active-directory-whatis
[VPN]: /azure/vpn-gateway/vpn-gateway-about-vpngateways
[ExR]: /azure/expressroute/expressroute-introduction
[ExRD]: /azure/expressroute/expressroute-erdirect-about
[virtual-wan]: /azure/virtual-wan/virtual-wan-about
[NVA]: /azure/architecture/reference-architectures/dmz/nva-ha
[AzFW]: /azure/firewall/overview
[AzFWMgr]: /azure/firewall-manager/overview
[MgmtGrp]: /azure/governance/management-groups/overview
[RGMgmt]: /azure/azure-resource-manager/management/manage-resource-groups-portal#what-is-a-resource-group
[ALB]: /azure/load-balancer/load-balancer-overview
[DDoS]: /azure/ddos-protection/ddos-protection-overview
[PIP]: /azure/virtual-network/virtual-network-public-ip-address
[azure-front-door]: /azure/frontdoor/front-door-overview
[AFDWAF]: /azure/web-application-firewall/afds/afds-overview
[AppGW]: /azure/application-gateway/overview
[AppGWWAF]: /azure/web-application-firewall/ag/ag-overview
[MonitorOverview]: /azure/networking/networking-overview#monitor
[AzureMonitor]: /azure/azure-monitor/overview
[Metrics]: /azure/azure-monitor/essentials/data-platform-metrics
[Logs]: /azure/azure-monitor/logs/data-platform-logs
[LogAnalytics]: /azure/azure-monitor/logs/log-analytics-tutorial
[NetWatch]: /azure/network-watcher/network-watcher-monitoring-overview
[WebApps]: /azure/app-service/
[HDInsight]: /azure/hdinsight/hdinsight-overview
[EventHubs]: /azure/event-hubs/event-hubs-about
[ServiceBus]: /azure/service-bus-messaging/service-bus-messaging-overview
[azure-traffic-manager]: /azure/traffic-manager/traffic-manager-overview
[Storage]: /azure/storage/common/storage-introduction
[SQL]: /azure/azure-sql/database/sql-database-paas-overview
[cosmos-db]: /azure/cosmos-db/introduction
[IoT]: /azure/iot-fundamentals/iot-introduction
[machine-learning]: /azure/machine-learning/overview-what-is-azure-ml

<!--docutune:enable -->
