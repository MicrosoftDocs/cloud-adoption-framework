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

This article provides security considerations and recommendations for a workload that's hosted in Azure Spring Apps. This guidance helps you create a workload that's capable of detecting, preventing, and responding to security vulnerabilities.

A secured application can't guarantee the security of the entire workload. As the workload owner, evaluate human errors, and evaluate the attack surface, like the application and the infrastructure services with which the application interacts.

Azure provides security controls for the network, identity, and data to support your defense in depth strategy. Many of the [controls are built into Azure Spring Apps](/azure/spring-apps/concept-security-controls). This guidance is based on the [Azure security baseline for Azure Spring Apps](/security/benchmark/azure/baselines/azure-spring-apps-security-baseline) that's derived from [Azure Security Benchmark version 2.0](/security/benchmark/azure/overview-v2). The benchmark provides recommendations about how to secure your workload that runs on Azure Spring Apps cloud.

The centralized teams provide networking and identity controls as part of the platform. They provide guardrails to maintain control over platforms, applications, and resources in Azure. The application landing zone subscription provided for the workload is preprovisioned with policies, which are inherited from the management group.

As you design the workload, ensure that the security controls that you own are aligned with the central controls. The design is subject to periodic reviews conducted by the centralized security team. Regularly review the security controls and platform policies with the central teams to make sure the workload requirements are accommodated.

> For information about the platform design, see:
>
> - [Design area: Security](/azure/cloud-adoption-framework/ready/landing-zone/design-area/security)
> - [Design area: Azure governance](/azure/cloud-adoption-framework/ready/landing-zone/design-area/governance)

## Design considerations

- **Internal traffic**. Restrict or allow traffic between internal resources to follow an enterprise segmentation principle that aligns with the business risks. Where necessary, create isolation boundaries through virtual networks and subnets. Implement rules to restrict traffic flows between networks.

- **External traffic**. Use Azure-native resources to protect your workload resources against attacks from external networks, including:

  - Distributed denial of service (DDoS) attacks.
  - Application-specific attacks.
  - Unsolicited and potentially malicious internet traffic.

- **Identity management**. Use Azure Active Directory (Azure AD) features, such as managed identities, single sign-on, strong authentications, managed identities, and conditional access to provide authentication and authorization through Azure AD.

- **Security monitoring**. The system should have monitoring tools to detect threats and measure compliance by using the organization goals and the Azure Security Benchmark controls. These tools should be integrated with central security information and event management (SIEM) systems to get a holistic view of security posture.

- **Data in transit**. Data that's transferred between components, locations, or API calls must be encrypted.

- **Data at rest**. All persisted data, including configuration, must be encrypted.

- **Governance policies**. You should detect deviations from the compliance standards that your organization sets. Azure Policy provides built-in definitions that should be applied to detect the deviations. When you apply policies, it doesn't ensure that you're fully compliant with all requirements of a control. There might be compliant standards that aren't addressed in built-in definitions.

- **Credential exposure**. You can deploy and run code, configurations, and persisted data with identities or secrets. Make sure the credentials are examined when you access the assets.

- **Certificate management**. Certificates must be loaded based on the Zero Trust principle of never trust, always verify, and they must be credential-free. Only trust certificates that are shared by verifying the identity prior to granting access to the certificates.

- **Consistent deployments**. Use infrastructure-as-code (IaC) to automate the provisioning and configuration of all Azure resources and strengthen the security posture.

## Design recommendations

### Network as the perimeter

These network controls create isolation boundaries and restrict flows in and out of the application.

#### Network segmentation

Create or use an existing virtual network when you deploy Azure Spring Cloud service resources.

Create isolation within the virtual network through subnetting. Restrict or allow traffic between internal resources by using your [NSG rules](/azure/virtual-network/tutorial-filter-network-traffic). Use the [Adaptive network hardening](/azure/security-center/security-center-adaptive-network-hardening) feature of Microsoft Defender for Cloud to further harden the NSG configurations that limit ports and source IPs. Base the configurations on external network traffic rules.

When you create security rules, use [Azure service tags](/azure/virtual-network/service-tags-overview) to define the network access controls instead of specific IP addresses. When you specify the service tag name in the appropriate rule's source or destination field, allow or deny the traffic for the corresponding service. Microsoft manages the address prefixes that are covered by the service tag. It automatically updates the service tag as addresses change.

Use the `AzureSpringCloud` service tag on network security groups or Azure Firewall to allow traffic to applications in Azure Spring Apps.

For more information, see [Customer responsibilities for running Azure Spring Cloud in a virtual network](/azure/spring-cloud/vnet-customer-responsibilities).

##### Connection with private networks

In a colocated environment, use Azure ExpressRoute or Azure virtual private network (VPN) to create private connections between Azure datacenters and on-premises infrastructure. [ExpressRoute connections](/azure/expressroute/expressroute-connectivity-models) don't go over the public internet with reliability, faster speeds, and lower latencies.

For [point-to-site VPN and site-to-site VPN](/azure/vpn-gateway/vpn-gateway-about-vpngateways), connect on-premises devices or networks to a virtual network. Use any combination of these VPN options and Azure ExpressRoute.

To connect two or more virtual networks in Azure, use [virtual network peering](/azure/virtual-network/virtual-network-peering-overview). Network traffic between peered virtual networks is private. This type of traffic is kept on the Azure backbone network.

##### Attacks from external networks

Place controls on inbound traffic and block application layer attacks with [Azure Application Gateway with integrated web application firewall (WAF)](/azure/web-application-firewall/ag/ag-overview).

Use [Azure Firewall](/azure/firewall/tutorial-firewall-deploy-portal) to restrict outbound traffic from the application. You can use Azure Firewall to protect applications and services against potentially malicious traffic from the internet and other external locations.

Azure Firewall threat intelligence-based filtering can send you an alert or block traffic to and from known malicious IP addresses and domains. The IP addresses and domains are sourced from the Microsoft Threat Intelligence feed. When payload inspection is necessary, deploy a third-party [intrusion detection/intrusion prevention system (IDS/IPS) from Azure Marketplace](https://azuremarketplace.microsoft.com/marketplace?search=IDS) with payload inspection capabilities. Alternatively, you can use host-based IDS/IPS or a host-based [endpoint detection](/windows/security/threat-protection/microsoft-defender-atp/overview-endpoint-detection-response) and response (EDR) solution with, or instead of, network-based IDS/IPS.

To protect the workload resources against DDoS attacks, enable [DDoS standard protection](/azure/virtual-network/manage-ddos-protection) on your Azure virtual networks. Use [Microsoft Defender for Cloud](/azure/security-center/recommendations-reference#recs-network) to detect misconfiguration risks to your network-related resources.

##### Protect Domain Name Service (DNS)

Use Azure DNS to host DNS domains. Protect DNS zones and records from bad actors. Azure role-based access control (Azure RBAC) and resource locks are recommended for that purpose. For more information, see [Prevent dangling DNS entries and avoid subdomain takeover](/azure/security/fundamentals/subdomain-takeover).

### Identity as the perimeter

Azure provides identity controls through Azure Active Directory (Azure AD). The application has many features, such as single sign-on, strong authentications, managed identities, and conditional access. For information about the design choices for the architecture, see [Identity considerations for the Azure Spring Apps landing zone accelerator](./identity-and-access-management.md).

The following section describes the security aspects of those choices.

#### Integration with the centralized identity system

Azure landing zones use Azure AD as the default identity and access management service. To govern the workload services, centralized Azure AD  is recommended. Centralized Azure AD includes access to the organization's network resources, Azure Storage, Key Vault, and other services that your application depends on.

If you want to grant access the Azure Spring Apps data plane, use the [Azure Spring Cloud Data Reader](/azure/role-based-access-control/built-in-roles#azure-spring-cloud-data-reader) built-in role. This role gives read-only permissions.

These Azure AD features are recommended:

- **Application identities**. The application might need to access other Azure services. For example, if it wants to retrieve secrets from Azure Key Vault.

  Use [managed identities](/azure/active-directory/managed-identities-azure-resources/overview) with Azure Spring Apps so the application can authenticate itself to other services by using Azure AD. Avoid using service principals for this purpose. The managed identities authentication process doesn't use credentials that are hardcoded in source code or configuration files.

  If you need to use service principals with certificate credentials and fall back to client secrets, it's recommended that you use Azure AD to create a [service principal](/azure/active-directory/develop/howto-authenticate-service-principal-powershell) with restricted permissions at the resource level.

  In both cases, Key Vault can be used with Azure-managed identities. A runtime component, such as an Azure function, can be used to retrieve the secrets from Key Vault. For more information, see [Authentication in Azure Key Vault](/azure/key-vault/general/authentication).

- **Azure AD single sign-on (SSO)**. [Azure AD SSO](/azure/active-directory/manage-apps/what-is-single-sign-on) is recommended to authenticate access to the application from other applications or devices that run in the cloud or on-premises. SSO provides identity management to internal and external users, such as partners or vendors.

- **Strong authentication controls**. Azure AD supports strong authentication controls through multi-factor authentication (MFA) and strong passwordless methods. For administrators and privileged users, use the highest level of the strong authentication method to reduce the blast radius if there's a breach. Then roll out the appropriate strong authentication policy to other users. For more information, see [Enable MFA in Azure](/azure/active-directory/authentication/howto-mfa-getstarted) and [Passwordless authentication options for Azure Active Directory](/azure/active-directory/authentication/concept-authentication-passwordless).

- **Conditional access to resources**. Azure Spring Apps supports [Azure AD conditional access](/azure/active-directory/conditional-access/overview) for a more granular access control that's based on user-defined conditions. You can set conditions to include user sign-ins from certain IP ranges that need to sign in by using MFA. These [Conditional Access policies](/azure/active-directory/conditional-access/concept-conditional-access-policy-common) only apply to user accounts that authenticate to Azure AD to access and manage applications. Those policies don't apply to service principals, keys, or tokens that are used to connect to your workload resources.

- **Privileged access**. Implement [Azure AD Privileged Identity Management](/azure/active-directory/privileged-identity-management/pim-configure) to ensure least-privilege access and deep reporting in your entire Azure environment. Teams should begin recurring access reviews to ensure the right people and service principles have current and correct authorization levels.

#### Data controls

Network and identity controls restrict access to the application, but the data needs to be protected. Encryption ensures data integrity and is a key security capability that must be applied to mitigate threats.

##### Data in transit

Transferred data is susceptible to out-of-band attacks, such as traffic capture. Use encryption to make sure attackers can't easily read or modify that data. Azure provides encryption for data in transit between Azure data centers.

Azure Spring Apps supports encryption with Transport Layer Security (TLS) v1.2 or greater. TLS provides secure communications through identity and trust, and encrypts communications of all types. You can use any type of TLS certificate. For example, certificates issued by a certificate authority, extended validation certificates, wildcard certificates with support for any number of subdomains, or self-signed certificates for dev and testing environments.

Encryption is critical for traffic on external and public networks. All public endpoints must use HTTPS for inbound traffic by default. Management calls to configure Azure Spring Apps service through Azure Resource Manager API calls must be over HTTPS.

For HTTP traffic, make sure clients that connect to your Azure resources can negotiate TLS v1.2 or later. Don't use obsolete versions or protocols. Disable weak ciphers.

For remote management, instead of using an unencrypted protocol, use Secure Shell (SSH) for Linux or Remote Desktop Protocol (RDP) and TLS for Windows.

##### Data at rest

The workload needs a store state for source and artifacts, config server settings, app settings, and storage. Server-side data at rest is protected by [Azure Storage encryption](/azure/storage/common/storage-service-encryption). Storage automatically encrypts the content with Microsoft-managed keys.

Config server cache, runtime binaries built from uploaded sources, and application logs during the application lifetime are saved to an Azure managed disk. This data is [automatically encrypted](/azure/virtual-machines/disk-encryption). Container images, which are built from user uploaded source are encrypted and saved in [Azure Container Registry](/azure/container-registry/container-registry-storage).

For support scenarios, when Microsoft needs access to relevant customer data, use [Customer Lockbox for Microsoft Azure](/azure/security/fundamentals/customer-lockbox-overview) because your team or organization must approve the access.

### Monitor and alert on account anomalies

Microsoft Defender for Cloud is recommended to receive alerts about suspicious activities, such as an excessive number of failed authentication attempts or deprecated accounts in the subscription.

Azure Spring Apps is integrated with Azure AD, which can track sign-in activities including risky sign-ins. You can use audit logs to detect changes that are made to any resources within Azure AD. The data is integrated with Azure Monitor and can be exported to Azure Sentinel.

For more information, see:

- [Audit activity reports in Azure AD](/azure/active-directory/reports-monitoring/concept-audit-logs)
- [View Azure AD risky sign-ins](/azure/active-directory/reports-monitoring/concept-risky-sign-ins#investigate-risk)
- [Identify Azure AD users flagged for risky activity](/azure/active-directory/reports-monitoring/concept-user-at-risk)
- [Monitor users' identity and access activity in Microsoft Defender for Cloud](/azure/security-center/security-center-identity-access)
- [Alerts in Microsoft Defender for Cloud's threat intelligence protection module](/azure/security-center/alerts-reference)

### Governance policies

Azure's built-in definition called [Azure Spring Cloud should use network injection](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2Faf35e2a4-ef96-44e7-a9ae-853dd97032c4) allows you to enforce [network controls](#network-as-the-perimeter).

 1. Detect the implementation of isolation boundaries for the application from the internet.
 2. Enable Azure Spring Apps to communicate with private networks in on-premises data centers or Azure service in other virtual networks.
 3. Control inbound and outbound network communications for Azure Spring Apps virtual network.

### Certificate management

An app might need public TLS certificates when communicating with backend services or on-premises systems. You can upload the certificates in Key Vault.

To securely load certificates from Key Vault, Spring Boot apps use managed identities and Azure role-based access control (RBAC). Azure Spring Apps uses a provider service principal and Azure role-based access control. This secure loading is powered by using the Azure Key Vault Java Cryptography Architecture (JCA) Provider. For more information, see [Azure Key Vault JCA client library for Java](https://github.com/Azure/azure-sdk-for-java/tree/main/sdk/keyvault/azure-security-keyvault-jca).

If your Spring code, Java code, or open-source libraries, such as OpenSSL, rely on the JVM default JCA chain to implicitly load certificates into the JVM's trust store, you can import your TLS certificates from Key Vault into Azure Spring Apps. Use those certificates within the app. For more information, see [Use TLS/SSL certificates in your application in Azure Spring Apps](/azure/spring-apps/how-to-use-tls-certificate).

### Credential scanning

Implement Credential Scanner to identify credentials that access code, configurations, and persisted data. Credential Scanner encourages that you move discovered credentials to more secure locations, such as Key Vault.

For GitHub, you can use the native secret scanning feature to identify credentials or other forms of secrets within the code.

For more information, see:

- [Set up Credential Scanner](https://secdevtools.azurewebsites.net/helpcredscan.html)
- [GitHub secret scanning](https://docs.github.com/github/administering-a-repository/about-secret-scanning)

## Next steps

Review the critical design areas to make complete considerations and recommendations for your architecture.

[Monitoring operations](./management.md)


