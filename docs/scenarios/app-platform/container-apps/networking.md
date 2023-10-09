---
title: Security considerations for the Azure Container Apps landing zone accelerator
description: Learn how to secure apps in Azure Container Apps.
author: craigshoemaker
ms.author: cshoe
ms.date: 10/06/2023
ms.topic: conceptual
---

# Networking for the Azure Container Apps - Landing Zone Accelerator

Container Apps is responsible for taking care of OS updates, scaling, failover processes, and resource allocation in an what's known as a Container Apps environment. Environments encapsulate one or more container apps or jobs, by creating a secure boundary through a virtual network (VNet).

By default, a VNet is automatically created for your Container App environment. However, if you want more detailed control over your network, you can use a pre-existing VNet as you create your container app environment.

Environments can accept [external](/azure/container-apps/vnet-custom) requests, or can be locked down to only [internal](/azure/container-apps/vnet-custom-internal) requests.

External environments expose container apps by using a virtual IP address that is accessible over the public internet. Alternatively, internal environments expose its container apps on an IP address inside your virtual network. You can restrict traffic either within the container app environment or via the virtual network. For more information, see [Security considerations for the Azure Container Apps Landing Zone Accelerator](./security.md).

## Considerations

* **Subnet requirements**:

  * A dedicated subnet is required for an environment on the virtual network. The CIDR of the subnet should be `/23` or larger.

* **IP address management**:

  * A base of 60 IPs is reserved in your VNet. This amount could increase as your container environment scales as each app revision gets an IP address from the subnet. Outbound IPs might change over time.

  * Only IPv4 addresses are supported (IPv6 isn't supported).

  * A managed public IP resource handles outbound requests and management traffic, regardless if you have an external or internal environment.

* **Network Security**:

  * You can lock down a network via network security groups (NSG) with more restrictive rules than the default NSG rules that control all inbound and outbound traffic for an environment.

* **Proxy and Encryption**:

  * Container Apps use an Envoy proxy as an edge HTTP proxy. All HTTP requests are automatically redirected to HTTPs. Envoy terminates transport layer security (TLS) after crossing its boundary. Mutual transport layer security (mTLS) is available only when using Dapr. However, because Envoy terminates mTLS, inbound calls from Envoy to Dapr-enabled container apps aren't encrypted.

* **DNS Considerations**:

  * As an environment is deployed, Container Apps performs many DNS lookups. Some of these lookups refer to internal Azure domains. If you force DNS traffic through your custom DNS solution, configure your DNS server to forward unresolved DNS queries to Azure DNS.

  * For applications running internally on Container Apps, the system relies on Azure Private DNS Zones to resolve the DNS name to the internal IP address. Inside the Private DNS Zone, you can point a wildcard (`*`) `A` record to the internal load balancer IP address.

* **Outbound Traffic Management**:

  * Outbound network traffic (egress) should be routed through an Azure Firewall or network virtual appliance cluster.

* **Load balancing across environments**:

  * To run your application on multiple Container Apps environments for resiliency or proximity reasons, consider using a global load-balancing service like Azure Traffic Manager or Azure Front Door.

* **Network Security**:

  * Use network security groups (NSG) to secure your network and block unnecessary inbound and outbound traffic.

  * Use Azure DDoS Protection Standard for the Azure Container Apps Environment.

  * Use Private Link for secure network connections and private IP-based connectivity to other managed Azure services.

  * Ensure all endpoints for the solution (internal and external) accept only TLS encrypted connections (HTTPS).

  * Use a web application firewall with the HTTPS/TCP ingress for internet-facing and security-critical, internal-facing web applications.

  * In some scenarios, you may want to expose a Container Apps web application directly to the internet and protect it with third-party CDN/WAF services.

## Recommendations

* **Network configuration**: Deploy your container apps in a custom virtual network to gain more control over the network configuration.

* **Secure inbound connectivity**: When publishing internet-facing services, use Azure Application Gateway (WAF_v2 SKU) or Azure Front Door (with Web Application Firewall) to secure inbound connectivity.

* **Internal traffic management**: Use an internal network configuration for services like Azure Application Gateway or Azure Front Door, ensuring traffic from the load-balancer to the Azure Container Apps Environment uses an internal connection.

* **Exposing applications**: Enable ingress to expose your application over HTTPs or TCP port.

## References

* [Networking architecture in Azure Container Apps](https://learn.microsoft.com/azure/container-apps/networking)
* [Securing a custom VNET in Azure Container Apps](https://learn.microsoft.com/azure/container-apps/firewall-integration)
* [Network proxying in Azure Container Apps](https://learn.microsoft.com/azure/container-apps/network-proxy)
* [IP ingress restrictions in Azure Container Apps](https://learn.microsoft.com/azure/container-apps/ip-restrictions)
* [Support for User Defined Routes](https://learn.microsoft.com/azure/container-apps/user-defined-routes)
* [Configure UDR with Azure Firewall](https://learn.microsoft.com/azure/container-apps/networking?tabs=azure-cli#configuring-udr-with-azure-firewall)