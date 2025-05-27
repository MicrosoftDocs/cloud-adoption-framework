---
title: Network topology and connectivity for Azure Kubernetes Service (AKS)
description: Learn how to improve the network topology and connectivity of the Azure Kubernetes Service (AKS).
author: balunywa
ms.author: mubaluny
ms.reviewer: tozimmergren
ms.date: 05/23/2023
ms.topic: conceptual
ms.custom: think-tank, e2e-aks
---

# Network topology and connectivity considerations for AKS

<!-- docutune:casing "Basic and Standard" -->

## Design considerations

Azure Kubernetes Service (AKS) provides three different networking models for container networking: Kubenet, CNI Overlay, and CNI. Each of these models has its unique set of features and advantages, offering flexibility and scalability options for container networking in AKS.

### Kubenet

Kubenet is a basic networking solution that conserves IP address space and offers simple configuration. It's ideal for small AKS clusters with fewer than 400 nodes, where manually managing and maintaining user-defined routes is acceptable. It's suitable for scenarios where internal or external load balancers are sufficient for reaching pods from outside the cluster.

### Azure CNI

Azure CNI is a network model designed for advanced networking. It provides full virtual network connectivity for pods, allowing for pod-to-pod and pod-to-VM connectivity. It's ideal for scenarios where advanced AKS features, such as virtual nodes, are required. It's suitable for scenarios where sufficient IP address space is available, and external resources need to reach pods directly. AKS network policies are also supported with Azure CNI.

### Azure CNI Overlay

Azure CNI Overlay is designed to address IP address shortages and simplify network configuration. It's suitable for scenarios where scaling up to 1000 nodes and 250 pods per node is sufficient, and an additional hop for pod connectivity is acceptable. AKS egress requirements can also be met with Azure CNI Overlay.

For a summary of recommended use cases per network model, see [Compare network models in AKS](/azure/aks/concepts-network#compare-network-models).

In addition, when designing your AKS cluster, it's important to carefully plan the IP addressing and size of the virtual network subnet to support scaling. Virtual nodes can be used for quick cluster scaling, but there are some known limitations.

AKS clusters support Basic and Standard Azure Load Balancer SKUs, and services can be exposed with public or internal load balancers. AKS uses CoreDNS to provide name resolution to pods running in the cluster, and outbound (egress) network traffic can be sent through an Azure Firewall or network virtual appliance cluster.

By default, all pods in an AKS cluster can send and receive traffic without limitations. However, Kubernetes network policies can be used to improve security and filter network traffic between pods in an AKS cluster. Two network policy models are available for AKS: Azure network policies and Calico.

Finally, AKS sets up a network security group (NSG) on the subnet in which the cluster is deployed. It's recommended not to manually edit this NSG, but services deployed in AKS can influence it.

Overall, selecting the appropriate network model and carefully planning network resources can help optimize the performance, security, and cost of your AKS cluster.


### Private clusters

AKS cluster IP visibility can be either public or private. [Private clusters](/azure/aks/private-clusters) expose the Kubernetes API over a private IP address, but not over a public one. This private IP address is represented in the AKS virtual network through a [private endpoint](/azure/private-link/private-endpoint-overview). The Kubernetes API shouldn't be accessed through its IP address, but instead through its fully qualified domain name (FQDN). The resolution from the Kubernetes API FQDN to its IP address will typically be performed by an [Azure Private DNS zone](/azure/dns/private-dns-overview). This DNS zone can be created by Azure in the [AKS node resource group](/azure/aks/faq#why-are-two-resource-groups-created-with-aks), or you can specify an [existing DNS zone](/azure/aks/private-clusters#no-private-dns-zone-prerequisites).

Following enterprise-scale proven practices, DNS resolution for Azure workloads is offered by centralized DNS servers deployed in the connectivity subscription, either in a hub virtual network or in a shared services virtual network connected to an Azure Virtual WAN. These servers will conditionally resolve Azure-specific and public names using Azure DNS (IP address `168.63.129.16`), and private names using corporate DNS servers. However, these centralized DNS servers won't be able to resolve the AKS API FQDN until they're connected with the DNS private zone created for the AKS cluster. Each AKS has a unique DNS private zone, since a random GUID is prepended to the zone name. So, for each new AKS cluster, its corresponding private DNS zone should be connected to the virtual network where the central DNS servers are located.

All virtual networks should be configured to use these central DNS servers for name resolution. However, if the AKS virtual network is configured to use the central DNS servers, and these DNS servers aren't connected to the private DNS zone yet, the AKS nodes won't be able to resolve the FQDN of the Kubernetes API, and the creation of the AKS cluster will fail. The AKS virtual network should be configured to use the central DNS servers only after cluster creation.

Once the cluster is created, the connection is created between the DNS private zone and the virtual network where the central DNS servers are deployed. The AKS virtual network has also been configured to use the central DNS servers in the connectivity subscription, and administrator access to the AKS Kubernetes API will follow this flow:

![Diagram showing a network for a private cluster.](./media/network-private-cluster.png)

> [!NOTE]
> The images in this article reflect the design using the traditional hub and spoke connectivity model. Enterprise-scale landing zones can opt for the Virtual WAN connectivity model, in which the central DNS servers would be in a shared services virtual network connected to a Virtual WAN hub.

1. The administrator resolves the FQDN of the Kubernetes API. The on-premises DNS servers forward the request to the authoritative servers: the DNS resolvers in Azure. These servers forward the request to the Azure DNS server (`168.63.129.16`), which will get the IP address from the Azure Private DNS zone.
2. After resolving the IP address, traffic to the Kubernetes API is routed from on-premises to the VPN or ExpressRoute gateway in Azure, depending on the connectivity model.
3. The private endpoint will have introduced a `/32` route in the hub virtual network. The VPN and ExpressRoute gateways send traffic straight to the Kubernetes API private endpoint deployed in the AKS virtual network.

### Traffic from application users to the cluster

Incoming (ingress) controllers can be used to expose applications running in the AKS clusters.

- Ingress controllers provide application-level routing at the cost of a slight complexity increase.
- Ingress controllers can incorporate Web Application Firewall (WAF) functionality.
- Ingress controllers can run off-cluster and in-cluster:
  - An off-cluster ingress controller offloads compute (such as HTTP traffic routing or TLS termination) to another service outside of AKS, like the [Azure Application Gateway Ingress Controller (AGIC) add-on](/azure/application-gateway/ingress-controller-overview).
  - An in-cluster solution consumes AKS cluster resources for compute (such as HTTP traffic routing or TLS termination). In-cluster ingress controllers can offer lower cost, but they require careful resource planning and maintenance.
- The basic HTTP application routing add-on is easy to use, but has some restrictions as documented in [HTTP application routing](/azure/aks/http-application-routing).

Ingress controllers can expose applications and APIs with a public or a private IP address.

- The configuration should be aligned with the egress filtering design to avoid asymmetric routing. UDRs can cause asymmetric routing (potentially), but not necessarily. Application Gateway can SNAT on traffic, meaning return traffic goes back to Application Gateway node and not to UDR route if UDR is only set up for internet traffic.
- If TLS termination is required, management of TLS certificates must be considered.

Application traffic can come from either on-premises or the public internet. The following picture describes an example where an [Azure Application Gateway](/azure/application-gateway/overview) is configured to reverse-proxy connections to the clusters both from on-premises and from the public internet.

![Diagram showing application-related network traffic.](./media/network-app-access.png)

Traffic from on-premises follows the flow of the numbered blue callouts in the previous diagram.

1. The client resolves the FQDN assigned to the application, either using the DNS servers deployed in the connectivity subscription or on-premises DNS servers.
2. After resolving the application FQDN to an IP address (the private IP address of the application gateway), traffic is routed through a VPN or ExpressRoute gateway.
3. Routing in the gateway subnet is configured to send the request to the web application firewall.
4. The web application firewall sends valid requests to the workload running in the AKS cluster.

The Azure Application Gateway in this example can be deployed in the same subscription as the AKS cluster, since its configuration is closely related to the workloads deployed in AKS and is therefore managed by the same application team. Access from the internet follows the flow of the numbered green callouts in the previous diagram.

1. Clients from the public internet resolve the DNS name for the application using [Azure Traffic Manager](/azure/traffic-manager/traffic-manager-overview). Alternatively, other global load-balancing technologies like [Azure Front Door](/azure/frontdoor/front-door-overview) can be used.
2. The application public FQDN will be resolved by Traffic Manager to the public IP address of the application gateway, which clients access over the public internet.
3. The application gateway accesses the workload deployed in AKS.

> [!NOTE]
> These flows are only valid for web applications. Non-web applications are outside the scope of this article, and they can be exposed through the Azure Firewall in the hub virtual network, or the secure virtual hub if using the Virtual WAN connectivity model.

Alternatively, the traffic flows for web-based applications can be made to traverse both the Azure Firewall in the connectivity subscription and the WAF in the AKS virtual network. This approach has the advantage of offering some more protection, such as using [Azure Firewall intelligence-based filtering](/azure/firewall/threat-intel) to drop traffic from known malicious IP addresses in the internet. However, it has some drawbacks too. For example, the loss of the original client IP address, and the extra coordination required between the firewall and the application teams when exposing applications. This is because destination network address translation (DNAT) rules will be needed in the Azure Firewall.

### Traffic from the AKS pods to backend services

The pods running inside of the AKS cluster might need to access backend services such as Azure Storage, Azure SQL databases, or Azure Cosmos DB NoSQL databases. [Virtual network service endpoints](/azure/virtual-network/virtual-network-service-endpoints-overview) and [Private Link](/azure/private-link/private-link-overview) can be used to secure connectivity to these Azure managed services.

If you're using Azure private endpoints for backend traffic, DNS resolution for the Azure services can be performed using Azure Private DNS zones. Since the DNS resolvers for the whole environment are in the hub virtual network (or the shared services virtual network if using the Virtual WAN connectivity model), these private zones should be created in the connectivity subscription. To create the A-record required to resolve the FQDN of the private service, you can associate the private DNS zone (in the connectivity subscription) with the private endpoint (in the application subscription). This operation requires certain privileges in those subscriptions.

It's possible to create the A-records manually, but associating the private DNS zone with the private endpoint results in a setup less prone to misconfigurations.

Backend connectivity from AKS pods to Azure PaaS services exposed through private endpoints follow this sequence:

![Backend traffic](./media/network-backend-access.png)

1. The AKS pods resolve the FQDN of the Azure platform as a service (PaaS) using the central DNS servers in the connectivity subscription, which are defined as custom DNS servers in the AKS virtual network.
2. The resolved IP is the private IP address of the private endpoints, which are accessed directly from the AKS pods.

Traffic between the AKS pods and the private endpoints per default won't go through the Azure Firewall in the hub virtual network (or the secure virtual hub if using Virtual WAN), even if the AKS cluster is configured for [egress filtering with Azure Firewall](/azure/aks/limit-egress-traffic). The reason is that the private endpoint creates a `/32` route in the subnets of the application virtual network, where AKS is deployed.

## Design recommendations

- If your security policy mandates having the Kubernetes API with a private IP address (instead of a public IP address), [deploy a private AKS cluster](/azure/aks/private-clusters).
  - Use custom private DNS zones when creating a private cluster, rather than letting the creation process use a [system private DNS zone](/azure/aks/private-clusters#configure-private-dns-zone).
- Use Azure Container Networking Interface (CNI) as a network model, unless you have a limited range of IP addresses that can be assigned to the AKS cluster.
  - Follow the documentation about [IP address planning](/azure/aks/configure-azure-cni#plan-ip-addressing-for-your-cluster) with CNI.
  - To use Windows Server node pools and virtual nodes to verify eventual limitations, refer to the [Windows AKS support FAQ](/azure/aks/windows-faq).
- Use Azure DDoS Protection to protect the virtual network used for the AKS cluster **unless you use Azure Firewall or WAF in a centralized subscription**.
- Use the DNS configuration linked to the overall network setup with Azure Virtual WAN or hub and spoke architecture, Azure DNS zones, and your own DNS infrastructure.
- Use Private Link to secure network connections and use private IP-based connectivity to other managed Azure services used that support Private Link, such as Azure Storage, Azure Container Registry, Azure SQL Database, and Azure Key Vault.
- Use an ingress controller to provide advanced HTTP routing and security, and to offer a single endpoint for applications.
- All web applications configured to use an ingress should use TLS encryption and not allow access over unencrypted HTTP. This policy is already enforced if the subscription includes the recommended policies in [Policies included reference implementations of enterprise-scale landing zones](https://github.com/Azure/Enterprise-Scale/blob/main/docs/ESLZ-Policies.md).
- Optionally, to conserve the compute and storage resources of your AKS cluster, use an off-cluster ingress controller.
  - Use the [Azure Application Gateway Ingress Controller (AGIC)](/azure/application-gateway/ingress-controller-overview) add-on, which is a first-party managed Azure service.
  - With AGIC, deploy a dedicated Azure Application Gateway for each AKS cluster and don't share the same Application Gateway across multiple AKS clusters.
  - If there are no resource or operational constraints, or AGIC doesn't provide the required features, use an in-cluster ingress controller solution like NGINX, Traefik, or any other Kubernetes-supported solution.
- For internet-facing and security-critical, internal-facing web applications, use a web application firewall with the ingress controller.
  - Azure Application Gateway and Azure Front Door both integrate the [Azure Web Application Firewall](/azure/web-application-firewall/ag/ag-overview) to protect web-based applications.
- If your security policy mandates inspecting all outbound internet traffic generated in the AKS cluster, secure egress network traffic using Azure Firewall or a third-party network virtual appliance (NVA) deployed in the managed hub virtual network. For more information, see [Limit egress traffic](/azure/aks/limit-egress-traffic). The AKS [outbound type UDR](/azure/aks/egress-outboundtype#deploy-a-cluster-with-outbound-type-of-udr-and-azure-firewall) requires associating a route table to the AKS node subnet, so it can't be used today with the dynamic route injection supported by Azure Virtual WAN or Azure Route Server.
- For non-private clusters, use authorized IP ranges.
- Use the Standard tier rather than the Basic tier of Azure Load Balancer.
- When designing a Kubernetes cluster in Azure, one of the key considerations is selecting the appropriate network model for your specific requirements. Azure     Kubernetes Service (AKS) offers three different networking models: Kubenet, Azure CNI, and Azure CNI Overlay. To make an informed decision, it's essential to understand the capabilities and characteristics of each model.

For a feature comparison between the three network models in AKS; Kubenet, Azure CNI, and Azure CNI Overlay, see [Compare network models in AKS](/azure/aks/concepts-network#compare-network-models).
