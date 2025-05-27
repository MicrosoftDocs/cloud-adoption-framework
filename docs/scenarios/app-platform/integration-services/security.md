---
title: Security considerations for the Azure Integration Services landing zone accelerator
description: Learn about design considerations and recommendations for security in the Azure Integration Services landing zone accelerator.
author: claytonsiemens77
ms.author: csiemens
ms.date: 03/15/2023
ms.topic: conceptual
---

# Security considerations for the Azure Integration Services landing zone accelerator

Good security is the cornerstone of any Azure application. Azure Integration Services face a particular challenge, as there are many resources that make up an application, and each of these resources has their own security considerations. To ensure that you understand the particular considerations of each service, refer to the following security baselines:

- [Azure security baseline for Logic Apps](/security/benchmark/azure/baselines/logic-apps-security-baseline)

- [Azure security baseline for API Management](/security/benchmark/azure/baselines/api-management-security-baseline)

- [Azure security baseline for Data Factory](/security/benchmark/azure/baselines/data-factory-security-baseline)

- [Azure security baseline for Service Bus](/security/benchmark/azure/baselines/service-bus-security-baseline)

- [Azure security baseline for Functions](/security/benchmark/azure/baselines/functions-security-baseline)

- [Azure security baseline for Storage](/security/benchmark/azure/baselines/storage-security-baseline)

- [Azure security baseline for Key Vault](/security/benchmark/azure/baselines/key-vault-security-baseline)

## Design considerations

When designing your security model, there are two different design areas: **design-time security**, and **run-time security**.

- **Design-time security** involves access to the management of and creation of Azure resources via the Azure portal, or a management API. Within Azure, we use Microsoft Entra ID and role-based access control (RBAC) to achieve this.

- **Run-Time security** involves access to endpoints and resources during the flow of an application - for example, authenticating and authorizing a user that calls a Logic App, or an API operation in API Management.

Decide early on if you need:

- **Private Cloud** - all of your resources reside in a VNet and only use private addressing, with no access to or from the public internet, potentially available to your on-premises resources via VPN or ExpressRoute.
  
- **Public Cloud** - all of your public-facing resources have access to public internet, although locked to down to restrict access from the public internet.

- **Hybrid** - some resources are private, and some are public.

The choice that you make will affect both the cost of your resources, along with how much security you can implement for your applications.

General security considerations include:

- Using Azure services to protect ingress and egress traffic.

- Using Microsoft Entra ID and OAuth 2.0 to manage authentication.

- Enforcing governance policies with Azure Policy.

- Locking down access to resources (access control).

- Encrypting data both in-transit and at-rest.

- Logging all attempts to access resources.

- Auditing access to resources.

## Design recommendations

### Network design recommendations

- Look at the use of an **Application Gateway** (Azure Application Gateway or Azure Front Door) with a **Web Application Firewall** (WAF) in front of your accessible endpoints; this will help with automatic encryption of data and allow you monitor and configure your endpoints more easily.

  - [Front Door](/azure/frontdoor/front-door-overview) is an application delivery network that provides global load-balancing and site acceleration service for web applications. Front Door offers Layer 7 capabilities like SSL offload, path-based routing, fast failover, and caching to improve performance and availability of your applications.

  - [Traffic Manager](/azure/traffic-manager/traffic-manager-overview) is a DNS-based traffic load balancer that lets you distribute traffic optimally to services across global Azure regions, while providing high availability and responsiveness. Because Traffic Manager is a DNS-based load-balancing service, it loads balances only at the domain level. For that reason, it can't fail over as quickly as Front Door because of common challenges around DNS caching and systems not honoring DNS TTL.
  
  - [Application Gateway](/azure/application-gateway/overview) provides a managed application delivery controller with various Layer 7 load-balancing capabilities. You can use Application Gateway to optimize web-farm productivity by offloading CPU-intensive SSL termination to the gateway.
  
  - [Azure Load Balancer](/azure/load-balancer/load-balancer-overview) is a high-performance, ultra-low-latency Layer 4 inbound and outbound load-balancing service for all UDP and TCP protocols. Load Balancer handles millions of requests per second. Load Balancer is zone-redundant, ensuring high availability across Availability Zones.

- Implement network isolation for your integration services resources by using VNet integration to place them in an isolated subnet combined with using [Azure private link](/azure/private-link/private-link-overview) and private endpoints. See the [Network topology and connectivity](./network-topology-and-connectivity.md) article in this series for a review of this design guidance.

- Protect your egress traffic with [Azure Firewall](/azure/firewall/overview)

- Use IP Filtering to lock down your endpoints so they can only be accessed by known network addresses (this is applicable for logic apps not integrated into VNets).

- If you have resources available publicly, use DNS obfuscation to deter any attackers; obfuscation means either custom domain names, or specific Azure resource names that don’t reveal the purpose or owner of a resource.

### Encryption design recommendations

- When storing data (in Azure Storage or Azure SQL Server, for example), always enable **Encryption at Rest**. Lock down access to the data, ideally only to services and a limited number of administrators. Remember that this also applies to log data as well. For more information, see [Azure data encryption at rest](/azure/security/fundamentals/encryption-atrest) and [Azure encryption overview](/azure/security/fundamentals/encryption-overview).

- Always use **Encryption in Transit** (TLS traffic, for example) when transferring data between resources; never send data over an unencrypted channel.

- When using TLS protocols, always use TLS 1.2 or greater.

- Keep secrets in [**Azure Key Vault**](/azure/key-vault/general/basic-concepts), and then link these to **App Settings** (Functions, Logic Apps), **Named Values** (API Management), or **Configuration Entries** (App Configuration).

- Implement a key rotation policy to ensure that all keys in use in your environment are regularly rotated to prevent against attacks using jeopardized keys

- For Logic App, [use obfuscation](/azure/logic-apps/logic-apps-securing-a-logic-app?tabs=azure-portal#secure-data-in-run-history-by-using-obfuscation) to secure data in run history.

### Authentication and access design recommendations

- Always follow the principle of least privilege when assigning access: give an identity the minimum permissions it needs. Sometimes this will involve creating a custom Microsoft Entra role. If there isn’t a built-in role with the minimal permissions you need, consider creating a custom role with just these permissions.

- Whenever possible, always use **Managed Identities** when a resource needs to access a service. For example, if your Logic App workflow needs to access Key Vault to retrieve a secret, use the [Managed Identity](/azure/logic-apps/create-managed-service-identity) of your Logic App to achieve this; Managed Identities provide a more secure, easier to manage mechanism to access resources, as Azure manages the identity on your behalf.

- Use **OAuth 2.0** as the authentication mechanism between resource endpoints:

  - In Logic Apps or Functions, enable Easy Auth, which requires all external callers to use an OAuth identity (usually Microsoft Entra ID, but could be any Identity provider).
  
  - In API Management, use the jwt-validation policy element to require an OAuth flow for connections to endpoints.
  
  - In Azure Storage and Key Vault, setup access policies to restrict access to specific identities.

### Governance design recommendations

- Actively use [**Azure Policy**](/azure/governance/policy/overview) to look for security issues or flaws. For example, endpoints without IP Filtering.

- Where available, use [**Microsoft Defender for Cloud**](/azure/defender-for-cloud/defender-for-cloud-introduction) to scan your resources and identify potential weaknesses.

- Regularly review audit logs (ideally using an automated tool) to identify both security attacks, and any unauthorized access to your resources.

- Consider the use of penetration testing to identify any weaknesses in your security design.

- Use automated deployment processes to configure security. Where possible, use a CI/CD pipeline like Azure DevOps with Terraform to not only deploy your resources, but also to configure security. This ensures your resources will be automatically protected whenever they are deployed.

## Next step

Review the critical design areas to make complete considerations and recommendations for your architecture. 

> [!div class="nextstepaction"]
> [Management](./management.md)

## Recommended content

- [What is Microsoft Defender for Cloud?](/azure/defender-for-cloud/defender-for-cloud-introduction)

- [What are managed identities for Azure resources?](/entra/identity/managed-identities-azure-resources/overview)

- [Authenticate access to Azure resources with managed identities in Azure Logic Apps](/azure/logic-apps/create-managed-service-identity?tabs=standard)

- [Security considerations for data movement in Azure Data Factory](/azure/data-factory/data-movement-security-considerations)

- [Trigger workflows in Standard logic apps with Easy Auth](https://techcommunity.microsoft.com/t5/integrations-on-azure-blog/trigger-workflows-in-standard-logic-apps-with-easy-auth/ba-p/3207378)

- [Protect an API in Azure API Management using OAuth 2.0 authorization with Azure Active  Directory](/azure/api-management/api-management-howto-protect-backend-with-aad)

- [Azure Key Vault security](/azure/key-vault/general/security-features)

- [Storage Accounts and security](/azure/architecture/framework/services/storage/storage-accounts/security)
