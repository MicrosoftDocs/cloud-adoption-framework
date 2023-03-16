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

This article provides security considerations and recommendations for a workload hosted in Azure Spring Apps so that it's capable of detecting, preventing, and responding to security vulnerabilities. 

Securing the application can't guarantee the security of the entire workload. As the workload owner, **evaluate the attack surface that includes the application _and_ the infrastructure services** with which the application interacts, and also human errors. 

Azure provides various security controls on **network, identity, and data** to support your defense in depth strategy. Many of those [controls are built into Azure Spring Apps](/azure/spring-apps/concept-security-controls). This guidance is based [Azure security baseline for Azure Spring Apps](/security/benchmark/azure/baselines/azure-spring-apps-security-baseline) that's derived from [Azure Security Benchmark version 2.0](/security/benchmark/azure/overview-v2). The benchmark provides recommendations on how you can secure your workload running on Azure Spring Apps cloud.

The centralized teams provide **networking and identity controls** as part of the platform. They also provide guardrails for maintaining control over platforms, applications, and resources in Azure. The application landing zone subscription provided for the workload will be **preprovisioned with policies**, which are inherited from the management group. 

As you design the workload, make sure the security controls owned by you're aligned with the central controls. The design is subject to periodic reviews conducted by the centralized security team. **Regularly review the security controls and platform policies with the central teams** to make sure the workload requirements are accommodated.

> For information about the platform design, see:
>
> -  [Platform design: Security](/azure/cloud-adoption-framework/ready/landing-zone/design-area/security).
> - For information about the platform design, see [Platform design: Governance](/azure/cloud-adoption-framework/ready/landing-zone/design-area/governance).

 
## Design considerations

- **Internal traffic**. Restrict or allow traffic between internal resources to follow an enterprise segmentation principle that aligns with the business risks. Where necessary, _create isolation boundaries_ through virtual networks and subnets. Have rules in place to restrict traffic flows between networks.

- **External traffic**. Use Azure native resources to _protect your workload resources against attacks from external networks_, including:

    - Distributed denial of service (DDoS) attacks. 
    - Application-specific attacks. 
    - Unsolicited and potentially malicious internet traffic. 

- **Identity management**. Make use of _Azure Active Directory (Azure AD) features_ such as managed identities, single sign-on, strong authentications, managed identities, conditional access, and to provide authentication and authorization through Azure AD.

- **Security monitoring**. The system should have monitoring tools in place to _detect threats and measure compliance_ with organization goals and the Azure Security Benchmark controls. These tools should be integrated with central security information and event management (SIEM) systems to get a holistic view of security posture. 

- **Data in transit**. Data that is being transferred between components, locations, or and API calls _must be encrypted_.

- **Data at rest**. All persisted data including configuration _must be encrypted_.

- **Governance policies**. You should detect deviations from compliance standards set by your organization. Azure Policy provides _built-in definitions that should be applied_ to detect those deviations. Applying policies doesn't ensure that you're fully compliant with all requirements of a control. There might be compliant standards that aren't addressed built-in definitions. Also the definitions might change over time. TBD: what's the guidance here. Do custom policies?

- **Credential exposure**. You can deploy and run code, configurations, and persisted data with  identities or secrets. Make sure those _credentials are examined_ when accessing those assets.

- **Certificate management**. Certificates must be loaded based on Zero Trust principle of _never trust, always verify, and credential-free_. Only trust certificates that are shared by verifying identity prior to granting access to those certificates.

- **Consistent deployments**. Using Infrastructure-as-Code (IaC) will _automate the provisioning and configuration_ of all Azure resources and strengthen the security posture. 

## Design recommendations

### Network as the perimeter

These network controls create isolation boundaries and restrict flows in and out of the application.

##### Network segmentation

When you deploy Azure Spring Cloud Service resources, _create or use an existing virtual network_. 

_Create isolation within the virtual network through subnetting_. Restrict or allow traffic between internal resources using your [NSG rules](/azure/virtual-network/tutorial-filter-network-traffic) . Use the [Adaptive network hardening](/azure/security-center/security-center-adaptive-network-hardening) feature of Microsoft Defender for Cloud to further _harden the NSG configurations_ that limit ports and source IPs. Base the configurations on external network traffic rules.

Use [Azure service tags](/azure/virtual-network/service-tags-overview) to define network access controls instead of specific IP addresses when creating security rules. By specifying the service tag name in the appropriate rule's source or destination field, allow or deny the traffic for the corresponding service. Microsoft manages the address prefixes covered by the service tag. It automatically updates the service tag as addresses change. 

_Use the `AzureSpringCloud` service tag_ on network security groups or Azure Firewall, to allow traffic to applications in Azure Spring Apps. 

For more information, see [Customer responsibilities for running Azure Spring Cloud in a virtual network](/azure/spring-cloud/vnet-customer-responsibilities). 

##### Connection with private networks

Using Azure ExpressRoute or Azure virtual private network (VPN) to create private connections between Azure datacenters and on-premises infrastructure in a colocated environment. [ExpressRoute connections](/azure/expressroute/expressroute-connectivity-models) don't go over the public internet with reliability, faster speeds, and lower latencies. 

For [point-to-site VPN and site-to-site VPN](/azure/vpn-gateway/vpn-gateway-about-vpngateways), connect on-premises devices or networks to a virtual network. Use any combination of these VPN options and Azure ExpressRoute. 

To connect two or more virtual networks in Azure together, use [virtual network peering](/azure/virtual-network/virtual-network-peering-overview). Network traffic between peered virtual networks is private. This type of traffic is kept on the Azure backbone network. 


##### Attacks from external networks

Place controls on inbound traffic and _block application layer attacks_ with [Azure Application Gateway with integrated web application firewall (WAF)](/azure/web-application-firewall/ag/ag-overview). 

Use [Azure Firewall](/azure/firewall/tutorial-firewall-deploy-portal) restrict outbound traffic from the application. It can also be used to _protect applications and services against potentially malicious traffic from the internet_ and other external locations. 

Azure Firewall threat intelligence-based filtering can alert on or block traffic to and from known malicious IP addresses and domains. The IP addresses and domains are sourced from the Microsoft Threat Intelligence feed. When payload inspection is necessary, deploy a third-party [intrusion detection/intrusion prevention system (IDS/IPS) from Azure Marketplace](https://azuremarketplace.microsoft.com/marketplace?search=IDS) with payload inspection capabilities. Alternatively, you can use host-based IDS/IPS or a host-based [endpoint detection](/windows/security/threat-protection/microsoft-defender-atp/overview-endpoint-detection-response) and response (EDR) solution with or instead of network-based IDS/IPS. 

To protect the workload resources against DDoS attacks, enable [DDoS standard protection](/azure/virtual-network/manage-ddos-protection) on your Azure virtual networks. Use[ Microsoft Defender for Cloud](/azure/security-center/recommendations-reference#recs-network) to detect misconfiguration risks to your network-related resources. 

##### Protect Domain Name Service (DNS) 

Use Azure DNS for hosting DNS domains. DNS zones and records should be protected from bad actors. Azure role-based access control (Azure RBAC) and resource locks are recommended for that purpose. For more information, see [Prevent dangling DNS entries and avoid subdomain takeover](/azure/security/fundamentals/subdomain-takeover). 

### Identity as the perimeter

Azure provides identity controls through Azure Active Directory (Azure AD). The application makes use of many features such as single sign-on, strong authentications, managed identities, conditional access, and others. The design choices for the architecture are covered in [Design are: Identity and access management](./identity-and-access-management.md).

This section covers the security aspect of those choices. 

##### Integration with the centralized identity system 

Azure landing zones use Azure AD as the default identity and access management service. Using  centralized Azure AD to govern the workload services is recommended. This includes access to the organization's network resources, Azure Storage, Key Vault, and other services that your application depends on. 

If you want to grant access the Azure Spring Apps data plane, use [Azure Spring Cloud Data Reader](/azure/role-based-access-control/built-in-roles#azure-spring-cloud-data-reader) built-in role. This role gives read-only permissions. 

These Azure AD features are recommended:

- **Application identities**. The application might need to access other Azure services. Suppose it wants to retrieve secrets from Azure Key Vault.

    Use [managed identities](/azure/active-directory/managed-identities-azure-resources/overview) with Azure Spring Apps so that the application can authenticate itself to other service by using Azure AD. Avoid using service principals for this purpose. The managed identities authentication process doesn't use credentials that are hardcoded in source code or configuration files. 

    If you need to use service principals with certificate credentials and fall back to client secrets, it's recommended that you use Azure AD to create a [service principal](/azure/active-directory/develop/howto-authenticate-service-principal-powershell) with restricted permissions at the resource level. 

    In both cases, Key Vault can be used with Azure-managed identities. A runtime component (such as an Azure function) can be used to retrieve the secrets from Key Vault. For more information, see [Use Key Vault for security principal registration](/azure/key-vault/general/authentication). 

- **Azure AD single sign-on (SSO)**. [Azure AD SSO](/azure/active-directory/manage-apps/what-is-single-sign-on) is recommended for authenticating access to the application from other applications (or devices) running in the cloud or on-premises. SSO also provides identity management to internal and external users such as partner and vendors. 

- **Strong authentication controls**. Azure AD supports strong authentication controls through multi-factor authentication (MFA) and strong passwordless methods. For administrators and privileged users, use the highest level of the strong authentication method to reduce the blast radius in case of a breach. Then roll out the appropriate strong authentication policy to other users. For more information, see [Enable MFA in Azure](/azure/active-directory/authentication/howto-mfa-getstarted) and [Introduction to passwordless authentication options for Azure AD](/azure/active-directory/authentication/concept-authentication-passwordless).

- **Conditional access to resources**. Azure Spring Apps supports [Azure AD conditional access](/azure/active-directory/conditional-access/overview) for a more granular access control that's based on user-defined conditions. You can set conditions include user sign-ins from certain IP ranges that need to sign in using MFA. These [conditional access policies](/azure/active-directory/conditional-access/concept-conditional-access-policy-common) only apply to user accounts that authenticate to Azure AD to access and manage applications. Those policies don't apply to service principals, keys, or tokens that are used to connect to your workload resources. 

- **Privileged access**. Implement [Azure AD Privileged Identity Management](/azure/active-directory/privileged-identity-management/pim-configure) to ensure least-privilege access and deep reporting in your entire Azure environment. Teams should begin recurring access reviews to ensure the right people and service principles have current and correct authorization levels.

#### Data controls

While network and identity controls restrict access to the application, the data itself needs to be protected. Encryption ensures data integrity and is a key security capability that must applied to mitigate threats. 

##### Data in transit

Data being transferred is susceptible to out-of-band attacks, such as traffic capture. Use encryption to make sure attackers can't easily read or modify that data. Azure provides _encryption for data in transit_ between Azure data centers. 

Azure Spring Apps supports encryption with Transport Layer Security (TLS) v1.2 or greater. TLS provides secure communications through identity and trust, and encrypts communications of all types. You can use any type of TLS certificate. For example, certificates issued by a certificate authority, extended validation certificates, wildcard certificates with support for any number of subdomains, or self-signed certificates for dev and testing environments.

Encryption is critical for traffic on external and public networks. All _public endpoints must use HTTPS_ for inbound traffic by default. Also management calls to configure Azure Spring Apps service through Azure Resource Manager API calls must be over HTTPS.

For HTTP traffic, make sure clients that connect to your Azure resources can _negotiate TLS v1.2 or later_. _Don't use obsolete versions or protocols_. Disable weak ciphers. 

For remote management, instead of using an unencrypted protocol, use Secure Shell (SSH) for Linux or Remote Desktop Protocol (RDP) and TLS for Windows. 

 
##### Data at rest

The workload will need to store state for source and artifacts, config server settings, app settings, and storage. Server-side data at rest is protected by [Azure Storage encryption](/azure/storage/common/storage-service-encryption). Storage automatically encrypts the content with Microsoft-managed keys. 

Config server cache, runtime binaries built from uploaded source, and application logs during the application lifetime are saved to Azure managed disk. This data is also [automatically encrypted](/azure/virtual-machines/disk-encryption). Container images, which are built from user uploaded source are saved in [Azure Container Registry](/azure/container-registry/container-registry-storage), are encrypted.

For support scenarios, when Microsoft needs access to relevant customer data,  using [Customer Lockbox for Microsoft Azure](/azure/security/fundamentals/customer-lockbox-overview) is recommended because the access must be approved by your team or organization. 


### Monitor and alert on account anomalies

Microsoft Defender for Cloud is recommended for _getting alerts about suspicious activities_, such as excessive number of failed authentication attempts or deprecated accounts in the subscription. 

Azure Spring Apps is integrated with Azure AD, which can track sign-in activities including risky sign-ins. You can use audit logs to detect changes made to any resource within Azure AD. The data is integrated with Azure Monitor and can be exported to Azure Sentinel. 


For more information, see these articles:

- [Audit activity reports in Azure AD](/azure/active-directory/reports-monitoring/concept-audit-logs) 
- [View Azure AD risky sign-ins](/azure/active-directory/reports-monitoring/concept-risky-sign-ins) 
- [Identify Azure AD users flagged for risky activity](/azure/active-directory/reports-monitoring/concept-user-at-risk) 
- [Monitor users' identity and access activity in Microsoft Defender for Cloud](/azure/security-center/security-center-identity-access) 
- [Alerts in Microsoft Defender for Cloud's threat intelligence protection module](/azure/security-center/alerts-reference) 


### Governance policies

Azure built-in definition of [Azure Spring Cloud should use network injection](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2Faf35e2a4-ef96-44e7-a9ae-853dd97032c4)	will allow you to enforce [network controls](#network-as-the-perimeter). 

 1. Detect the implementation of isolation boundaries for the application from the internet. 
 2. Enable Azure Spring Apps to communicate with private networks in on-premises data centers or Azure service in other virtual networks. 
 3. Control inbound and outbound network communications for Azure Spring Apps virtual network.

### Certificate management

An app might need public TLS certificates when communicating with backend services or on-premises systems. You can upload those certificates in Azure Key Vault. 

To _securely load certificates from Azure Key Vault_, Spring Boot apps use managed identities and Azure role-based access control (RBAC). Azure Spring Apps uses a provider service principal and Azure role-based access control. This secure loading is powered using the Azure Key Vault Java Cryptography Architecture (JCA) Provider. For more information, see [Azure Key Vault JCA client library for Java](https://github.com/Azure/azure-sdk-for-java/tree/main/sdk/keyvault/azure-security-keyvault-jca).

If your Spring code, Java code, or open-source libraries, such as OpenSSL, rely on the JVM default JCA chain to implicitly load certificates into the JVM's trust store, you can import your TLS certificates from Key Vault into Azure Spring Apps and use those certificates within the app. For more information, see [Use TLS/SSL certificates in your application in Azure Spring Apps](/azure/spring-apps/how-to-use-tls-certificate).


### Credential scanning

Implement Credential Scanner to identify credentials that access code, configurations, and persisted data. Credential Scanner also encourages moving discovered credentials to more secure locations, such as Key Vault. 

For GitHub, you can use the native secret scanning feature to identify credentials or other forms of secrets within the code. 

For more information, see these articles:

- [Set up Credential Scanner](https://secdevtools.azurewebsites.net/helpcredscan.html) 
- [GitHub secret scanning](https://docs.github.com/github/administering-a-repository/about-secret-scanning) 




## Next step

Review the critical design areas to make complete considerations and recommendations for your architecture. 

> [!div class="nextstepaction"] 
> [Monitoring operations](./management.md)