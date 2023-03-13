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

- **Domain Name Service (DNS)**. Protect DNS zones and records from accidental or malicious modification 
DNS security to mitigate against common attacks, such as: 

Dangling DNS 

DNS amplifications attacks 

DNS poisoning and spoofing 

## Design recommendations

#### Network controls

These network controls will create isolation boundaries and restrict flows in and out of the application.

##### Network as the perimeter

When you deploy Azure Spring Cloud Service resources, create or use an existing virtual network. 

Create isolation within the virtual network through subnetting. Restrict or allow traffic between internal resources using your [NSG rules](/azure/virtual-network/tutorial-filter-network-traffic) . Use the [Adaptive network hardening](/azure/security-center/security-center-adaptive-network-hardening) feature of Microsoft Defender for Cloud to further harden the NSG configurations that limit ports and source IPs. Base the configurations on external network traffic rules.

Use [Azure service tags](/azure/virtual-network/service-tags-overview) to define network access controls instead of specific IP addresses when creating security rules. By specifying the service tag name in the appropriate rule's source or destination field, allow or deny the traffic for the corresponding service. Microsoft manages the address prefixes that are encompassed by the service tag. It automatically updates the service tag as addresses change. 

Use the `AzureSpringCloud` service tag on network security groups or Azure Firewall, to allow traffic to applications in Azure Spring Apps. 

For more information, see [Customer responsibilities for running Azure Spring Cloud in a virtual network](/azure/spring-cloud/vnet-customer-responsibilities). 

##### Private networks

Using Azure ExpressRoute or Azure virtual private network (VPN) to create private connections between Azure datacenters and on-premises infrastructure in a colocated environment. [ExpressRoute connections](/azure/expressroute/expressroute-connectivity-models) don't go over the public internet with reliability, faster speeds, and lower latencies. 

For [point-to-site VPN and site-to-site VPN](/azure/vpn-gateway/vpn-gateway-about-vpngateways), connect on-premises devices or networks to a virtual network. Use any combination of these VPN options and Azure ExpressRoute. 

To connect two or more virtual networks in Azure together, use [virtual network peering](/azure/virtual-network/virtual-network-peering-overview). Network traffic between peered virtual networks is private. This type of traffic is kept on the Azure backbone network. 


##### Attacks from external networks

Place controls on inbound traffic and block application layer attacks with [Azure Application Gateway with integrated web application firewall (WAF)](/azure/web-application-firewall/ag/ag-overview). 

Use [Azure Firewall](/azure/firewall/tutorial-firewall-deploy-portal) restrict outbound traffic from the application. It can also be used to protect applications and services against potentially malicious traffic from the internet and other external locations. 

Azure Firewall threat intelligence-based filtering can alert on or block traffic to and from known malicious IP addresses and domains. The IP addresses and domains are sourced from the Microsoft Threat Intelligence feed. When payload inspection is necessary, deploy a third-party [intrusion detection/intrusion prevention system (IDS/IPS) from Azure Marketplace](https://azuremarketplace.microsoft.com/marketplace?search=IDS) with payload inspection capabilities. Alternatively, you can use host-based IDS/IPS or a host-based [endpoint detection](/windows/security/threat-protection/microsoft-defender-atp/overview-endpoint-detection-response) and response (EDR) solution with or instead of network-based IDS/IPS. 

To protect the workload resources against DDoS attacks, enable [DDoS standard protection](/azure/virtual-network/manage-ddos-protection) on your Azure virtual networks. Use[ Microsoft Defender for Cloud](/azure/security-center/recommendations-reference#recs-network) to detect misconfiguration risks to your network-related resources. 


Component	Version	Location
Design Considerations
1. Azure Security Baseline for Azure Spring Apps Service
This security baseline applies guidance from the Azure Security Benchmark version 2.0 to Azure Spring App Service. The Azure Security Benchmark provides recommendations on how you can secure your cloud solutions on Azure. The content is grouped by the security controls defined by the Azure Security Benchmark and the related guidance applicable to Azure Spring App Service.

You can monitor this security baseline and its recommendations using Microsoft Defender for Cloud. Azure Policy definitions will be listed in the Regulatory Compliance section of the Microsoft Defender for Cloud dashboard.

When a section has relevant Azure Policy Definitions, they are listed in this baseline to help you measure compliance to the Azure Security Benchmark controls and recommendations. Some recommendations may require a paid Microsoft Defender plan to enable certain security scenarios.

Controls not applicable to Azure Spring App Service, and those for which the global guidance is recommended verbatim, have been excluded. To see how Azure Spring App Service completely maps to the Azure Security Benchmark, see the full Azure Spring App Service security baseline mapping file.

2. Data Protection Security Controls
Security Control	Yes/No	Notes	Documentation
Server-side encryption at rest:	Yes	User uploaded source and artifacts, config server settings, app settings, and data in persistent storage are stored in Azure	Azure Storage encryption for data at REST
Microsoft-Managed Keys	Yes	Storage, which automatically encrypts the content at rest. Config server cache, runtime binaries built from uploaded source, and application logs during the application lifetime are saved to Azure managed disk, which automatically encrypts the content at rest. Container images built from user uploaded source are saved in Azure Container Registry, which automatically encrypts the image content at rest.	Server-side encryption of Azure managed disks Container image storage in Azure Container Registry
Encryption in transient	Yes	User app public endpoints use HTTPS for inbound traffic by default.	---------------
API calls encrypted	Yes	Management calls to configure Azure Spring Apps service occur via Azure Resource Manager calls over HTTPS.	Azure Resource Manager
Customer Lockbox	Yes	Provide Microsoft with access to relevant customer data during support scenarios.	Customer Lockbox for Microsoft Azure
3. Network Access Security Controls
Security Control	Yes/No	Notes	Documentation
Service Tag	Yes	Use Azure Spring App service tag to define outbound network access controls on network security groups or Azure Firewall, to allow traffic to applications in Azure Spring Apps.	Service tags
4. Micrsoft Defender for Cloud Monitoring
The Azure Security Benchmark is the default policy initiative for Microsoft Defender for Cloud and is the foundation for Microsoft Defender for Cloud's recommendations. The Azure Policy definitions related to this control are enabled automatically by Microsoft Defender for Cloud. Alerts related to this control may require an Microsoft Defender plan for the related services.

5. Azure Policy Built-in Definitions - Microsoft.AppPlatform
Name	Description	Effect(s)	Version
Azure Spring App should use network injection	Azure Spring App instances should use virtual network injection for the following purposes: 1. Isolate Azure Spring App from Internet. 2. Enable Azure Spring App to interact with systems in either on premises data centers or Azure service in other virtual networks. 3. Empower customers to control inbound and outbound network communications for Azure Spring App.	Audit, Disabled, Deny	1.0.0
6. Secure Internet Communications
The TLS/SSL protocol establishes identity and trust, and encrypts communications of all types. TLS/SSL makes secure communications possible, particularly web traffic carrying commerce and customer data.

You can use any type of TLS/SSL certificate. For example, you can use certificates issued by a certificate authority, extended validation certificates, wildcard certificates with support for any number of subdomains, or self-signed certificates for dev and testing environments.

7. Load Certificates Securitty with Zero Trust
Zero Trust is based on the principle of "never trust, always verify, and credential-free". Zero Trust helps to secure all communications by eliminating unknown and unmanaged certificates. Zero Trust involves trusting only certificates that are shared by verifying identity prior to granting access to those certificates. For more information, see the Zero Trust Guidance Center.

To securely load certificates from Azure Key Vault, Spring Boot apps use managed identities and Azure role-based access control (RBAC). Azure Spring Apps uses a provider service principal and Azure role-based access control. This secure loading is powered using the Azure Key Vault Java Cryptography Architecture (JCA) Provider. For more information, see Azure Key Vault JCA client library for Java.

If your Spring code, Java code, or open-source libraries, such as OpenSSL, rely on the JVM default JCA chain to implicitly load certificates into the JVM's trust store, then you can import your TLS/SSL certificates from Key Vault into Azure Spring Apps and use those certificates within the app. For more information, see Use TLS/SSL certificates in your application in Azure Spring Apps.

8. Upload well known public TLS/SSL certificates for Backend Systems
For an app to communicate to backend services in the cloud or in on-premises systems, it may require the use of public TLS/SSL certificates to secure communication. You can upload those TLS/SSL certificates for securing outbound communications. For more information, see Use TLS/SSL certificates in your application in Azure Spring Apps.

9. Automate provisioning and configuration for Securing Communications
Using an ARM Template, Bicep, or Terraform, you can automate the provisioning and configuration of all the Azure resources mentioned above for securing communications.

Design Recommendations
1. Azure Policy Regulatory Compliance Controls for Azure Spring Apps
Azure Spring Apps is the new name for the Azure Spring App service. Although the service has a new name, you'll see the old name in some places for a while as we work to update assets such as screenshots, videos, and diagrams.

Regulatory Compliance in Azure Policy provides Microsoft created and managed initiative definitions, known as built-ins, for the compliance domains and security controls related to different compliance standards. This page lists the compliance domains and security controls for Azure Spring Apps. You can assign the built-ins for a security control individually to help make your Azure resources compliant with the specific standard.

The title of each built-in policy definition links to the policy definition in the Azure portal. Use the link in the Policy Version column to view the source on the Azure Policy GitHub repo.

Each control is associated with one or more Azure Policy definitions. These policies might help you assess compliance with the control. However, there often isn't a one-to-one or complete match between a control and one or more policies. As such, Compliant in Azure Policy refers only to the policies themselves. This doesn't ensure that you're fully compliant with all requirements of a control. In addition, the compliance standard includes controls that aren't addressed by any Azure Policy definitions at this time. Therefore, compliance in Azure Policy is only a partial view of your overall compliance status. The associations between controls and Azure Policy Regulatory Compliance definitions for these compliance standards can change over time.

2. Azure Security Benchmark
The Azure Security Benchmark provides recommendations on how you can secure your cloud solutions on Azure. To see how this service completely maps to the Azure Security Benchmark, see the [Azure Security Benchmark mapping files](https://github.com/MicrosoftDocs/SecurityBenchmarks/tree/master/Azure Offer Security Baselines).

To review how the available Azure Policy built-ins for all Azure services map to this compliance standard, see Azure Policy Regulatory Compliance - Azure Security Benchmark.

Domain	Control ID	Control Title	Policy	Policy Version
Network Security	NS-2	Secure cloud services with network controls	Azure Spring App should use network injection	1.1.0
3. FedRAMP High
To review how the available Azure Policy built-ins for all Azure services map to this compliance standard, see Azure Policy Regulatory Compliance - FedRAMP High. For more information about this compliance standard, see FedRAMP High.

Domain	Control ID	Control Title	Policy	Policy Version
Access Control	AC-17	Remote Access	Azure Spring App should use network injection	1.1.0
Access Control	AC-17 (1)	Automated Monitoring / Control	Azure Spring App should use network injection	1.1.0
4. FedRAMP Moderate
To review how the available Azure Policy built-ins for all Azure services map to this compliance standard, see Azure Policy Regulatory Compliance - FedRAMP Moderate. For more information about this compliance standard, see [FedRAMP Moderate](https://www.fedramp.gov/.

Domain	Control ID	Control Title	Policy	Policy Version
Access Control	AC-17	Remote Access	Azure Spring App should use network injection	1.1.0
Access Control	AC-17 (1)	Automated Monitoring / Control	Azure Spring App should use network injection	1.1.0
5. New Zealand ISM Restricted
To review how the available Azure Policy built-ins for all Azure services map to this compliance standard, see Azure Policy Regulatory Compliance - New Zealand ISM Restricted. For more information about this compliance standard, see New Zealand ISM Restricted.

Domain	Control ID	Control Title	Policy	Policy Version
Infrastructure	INF-9	10.8.35 Security Architecture	Azure Spring App should use network injection	1.1.0
6. NIST SP 800-53 Rev. 5
To review how the available Azure Policy built-ins for all Azure services map to this compliance standard, see Azure Policy Regulatory Compliance - NIST SP 800-53 Rev. 5. For more information about this compliance standard, see NIST SP 800-53 Rev. 5.

Domain	Control ID	Control Title	Policy	Policy Version
Access Control	AC-17	Remote Access	Azure Spring App should use network injection	1.1.0
Access Control	AC-17 (1)	Monitoring and Control	Azure Spring App should use network injection	1.1.0
7. NZ ISM Resticted v3.5
To review how the available Azure Policy built-ins for all Azure services map to this compliance standard, see Azure Policy Regulatory Compliance - NZ ISM Restricted v3.5. For more information about this compliance standard, see NZ ISM Restricted v3.5.

Domain	Control ID	Control Title	Policy	Policy Version
Infrastructure	NZISM Security Benchmark INF-9	10.8.35 Security Architecture	Azure Spring App should use network injection	1.1.0
8. Reserve Bank of India IT Framerwork for Banks v2016
To review how the available Azure Policy built-ins for all Azure services map to this compliance standard, see Azure Policy Regulatory Compliance - RBI ITF Banks v2016. For more information about this compliance standard, see RBI ITF Banks v2016 (PDF).

Domain	Control ID	Control Title	Policy	Policy Version
Patch/Vulnerability & Change Management		Patch/Vulnerability & Change Management-7.7	Azure Spring App should use network injection	1.1.0
Patch/Vulnerability & Change Management		Patch/Vulnerability & Change Management-7.7	Azure Spring App should use network injection	1.1.0
Anti-Phishing		Anti-Phishing-14.1	Azure Spring App should use network injection	1.1.0
Appendix A: Checklists
Pending Review. I will add a link to the various Checklist.


## Next step

Review the critical design areas to make complete considerations and recommendations for your architecture. 

> [!div class="nextstepaction"] 
> [Monitoring operations](./management.md)