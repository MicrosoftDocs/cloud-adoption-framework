---
title: Security considerations for the Azure Spring Apps landing zone accelerator
description: Security considerations and recommendations for a Spring Boot workload.
author: pagewriter-msft
ms.author: prwilk
ms.date: 03/01/2023
ms.topic: conceptual
ms.service: caf
ms.subservice: caf-scenario-spring-apps
---

# Security considerations for the Azure Spring Apps landing zone accelerator

This article provides security considerations and recommendations for making sure that the workload hosted in Azure Spring Apps is capable of detecting, preventing, and responding to security vulnerabilities. 

Security of the workload cannot be guaranteed by just the application. As the workload owner, evaulate the attack surface that includes the application, the infrastructure services with which the application interacts, and also human errors. Azure provides various security controls on network, identity, and data to support your defense in depth strategy. 

For information about built-in security features of Azure Spring Apps, see [Security controls for Azure Spring Apps Service](/azure/spring-apps/concept-security-controls).

The centralized teams will provide networking and identity controls as part of the platform. Review those contols to make design decisions for the workload. The design is subject to periodic reviews conducted by the centralized security team.

> For information about the platform design, see [Platform design: Security](/azure/cloud-adoption-framework/ready/landing-zone/design-area/security).

The organization will also provide guardrails for maintaining control over platforms, applications, and resources in Azure. The centralized plaform teams will apply policies to the application landing zone subscription, which are inherited from the management group. Work with the central team to regularly review the platform policies and participate in change management to make sure the workload requirements are accomodated.

> For information about the platform design, see [Platform design: Governance](/azure/cloud-adoption-framework/ready/landing-zone/design-area/governance).


## Design considerations

- **Internal traffic**. Restrict or allow traffic between internal resources to follow an enterprise segmentation principle that aligns with the business risks. Where necessary, create isolation boundaries through virtual networks and subnets. Have rules in place to retrict traffic flows between networks.

- **External traffic**. Use Azure native resources to protect your workload resources against attacks from external networks, including:

    - Distributed denial of service (DDoS) attacks. 
    - Application-specific attacks. 
    - Unsolicited and potentially malicious internet traffic. 

- **Domain Name Service (DNS)**. Protect DNS zones and records from accidental or malicious modification. Common attacks are: 
    - Dangling DNS 
    - DNS amplifications attacks 
    - DNS poisoning and spoofing 

## Design recommendations

#### Network controls

These network controls will create isolation boundaries and restrict flows in and out of the application.

##### Network as the perimeter

When you deploy Azure Spring Cloud Service resources, create or use an existing virtual network. 

Create isolation within the virtual network through subnetting. Restrict or allow traffic between internal resources using your [NSG rules](/azure/virtual-network/tutorial-filter-network-traffic) . Use the [Adaptive network hardening](/azure/security-center/security-center-adaptive-network-hardening) feature of Microsoft Defender for Cloud to further harden the NSG configurations that limit ports and source IPs. Base the configurations on external network traffic rules.

Use [Azure service tags](/azure/virtual-network/service-tags-overview) to define network access controls instead of specific IP addresses when creating security rules. By specifying the service tag name in the appropriate rule's source or destination field, allow or deny the traffic for the corresponding service. Microsoft manages the address prefixes that are encompassed by the service tag. It automatically updates the service tag as addresses change. 

Use the `AzureSpringCloud` service tag on network security groups or Azure Firewall, to allow traffic to applications in Azure Spring Apps. 

For more information, see [Customer responsibilities for running Azure Spring Cloud in a virtual network](/azure/spring-cloud/vnet-customer-responsibilities). 

##### Connection with private networks

Using Azure ExpressRoute or Azure virtual private network (VPN) to create private connections between Azure datacenters and on-premises infrastructure in a colocated environment. [ExpressRoute connections](/azure/expressroute/expressroute-connectivity-models) don't go over the public internet with reliability, faster speeds, and lower latencies. 

For [point-to-site VPN and site-to-site VPN](/azure/vpn-gateway/vpn-gateway-about-vpngateways), connect on-premises devices or networks to a virtual network. Use any combination of these VPN options and Azure ExpressRoute. 

To connect two or more virtual networks in Azure together, use [virtual network peering](/azure/virtual-network/virtual-network-peering-overview). Network traffic between peered virtual networks is private. This type of traffic is kept on the Azure backbone network. 


##### Attacks from external networks

Place controls on inbound traffic and block application layer attacks with [Azure Application Gateway with integrated web application firewall (WAF)](/azure/web-application-firewall/ag/ag-overview). 

Use [Azure Firewall](/azure/firewall/tutorial-firewall-deploy-portal) restrict outbound traffic from the application. It can also be used to protect applications and services against potentially malicious traffic from the internet and other external locations. 

Azure Firewall threat intelligence-based filtering can alert on or block traffic to and from known malicious IP addresses and domains. The IP addresses and domains are sourced from the Microsoft Threat Intelligence feed. When payload inspection is necessary, deploy a third-party [intrusion detection/intrusion prevention system (IDS/IPS) from Azure Marketplace](https://azuremarketplace.microsoft.com/marketplace?search=IDS) with payload inspection capabilities. Alternatively, you can use host-based IDS/IPS or a host-based [endpoint detection](/windows/security/threat-protection/microsoft-defender-atp/overview-endpoint-detection-response) and response (EDR) solution with or instead of network-based IDS/IPS. 

To protect the workload resources against DDoS attacks, enable [DDoS standard protection](/azure/virtual-network/manage-ddos-protection) on your Azure virtual networks. Use[ Microsoft Defender for Cloud](/azure/security-center/recommendations-reference#recs-network) to detect misconfiguration risks to your network-related resources. 

##### Protect Domain Name Service (DNS) 

Use Azure DNS for hosting DNS domains. DNS zones and records should be protected from bad actors. Azure role-based access control (Azure RBAC) and resource locks are recommended for that purpose. For more information, see [Prevent dangling DNS entries and avoid subdomain takeover](/azure/security/fundamentals/subdomain-takeover). 

#### Identity controls

Azure provides identity controls through Azure Active Directory (Azure AD). The application make use of many features such as single sign-on, strong authentications, managed identities, conditional access, and others. The design choices for the application are covered in [Design are: Identity and access management](./identity-and-access-management.md).

This section covers the security aspect of those choices. 

##### Integration with the centralized identity system 

Azure landing zones use Azure AD as the default identity and access management service. Using  centralized Azure AD to govern the workload services is recommended. This includes the use of the organization's network resources, Azure Storage, Key Vault, and other services that your application depends on. 

If you want to grant access the Azure Spring Apps data plane, use [Azure Spring Cloud Data Reader](/azure/role-based-access-control/built-in-roles#azure-spring-cloud-data-reader) built-in role. This role gives read-only permissions. 

##### Application identities

The application might need to access other Azure services. Suppose it wants to retrieve secrets from Azure Key Vault.

Use [managed identities](/azure/active-directory/managed-identities-azure-resources/overview) with Azure Spring Apps so that the application can authenticate itself to other service by using Azure AD. Avoid using service principals for this purpose. The managed identities authentication process doesn't use credentials that are hardcoded in source code or configuration files. 

If you need to use service principals with certificate credentials and fall back to client secrets, it's recommended that you use Azure AD to create a [service principal](/azure/create-azure-service-principal-azureps) with restricted permissions at the resource level. 

In both cases, Key Vault can be used with Azure-managed identities. A runtime environment (such as an Azure function) can be used to retrieve the secrets from Key Vault. For more information, see [Use Key Vault for security principal registration](/azure/key-vault/general/authentication). 

##### Azure AD single sign-on (SSO)

Using [Azure AD SSO](/azure/active-directory/manage-apps/what-is-single-sign-on) is recommended for authenticating access to the application from other applications (or devices) running in the cloud or on-premises. SSO also provides access management to internal and external users such as partner and vendors. 


##### 





## Next step

Review the critical design areas to make complete considerations and recommendations for your architecture. 

> [!div class="nextstepaction"] 
> [Monitoring operations](./management.md)