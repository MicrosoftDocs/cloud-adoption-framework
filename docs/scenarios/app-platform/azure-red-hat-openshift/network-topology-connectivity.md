---
title: Network topology and connectivity for Azure Red Hat OpenShift
description: Learn how to improve the network topology and connectivity of the Azure Red Hat OpenShift landing zone accelerator.
author: Welasco
ms.author: vsantana
ms.date: 06/03/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-aro
---

# Network topology and connectivity considerations for Azure RedHat OpenShift

Get design considerations and recommendations for network topology and connectivity when you use the Azure Red Hat OpenShift landing zone accelerator.

## Design considerations

- Azure Red Hat OpenShift requires two subnets: a primary subnet and secondary subnet.
  - Use the primary subnet to deploy the cluster's primary nodes.
  - Use the secondary subnet to deploy the cluster's secondary nodes.
  - The secondary subnet and the primary subnet should both be a minimum `/27`.
  - The secondary subnet and the primary subnet can't be changed after the cluster is deployed.
  - The primary and secondary subnets must not have a network security group associated with them. The Azure Red Hat OpenShift cluster creates and manages a network security group.
  - The secondary subnet and the primary subnet can't overlap with on-premises networks or any other network in Azure.
- IP addressing and the size of the virtual network subnet must be carefully planned to support the scaling of the cluster. For example, you can add more nodes.
- You can expose Azure Red Hat OpenShift services and [routes](https://docs.openshift.com/container-platform/latest/networking/routes/route-configuration.html) by using public or internal load balancers. Configure internal load balancers in the same subnet as the secondary nodes. In a restricted egress cluster, you can't use public load balancers due to asymmetric routing.
- Azure Red Hat OpenShift uses CoreDNS to provide name resolution to pods running in the cluster.
  - [CoreDNS](https://docs.openshift.com/container-platform/latest/networking/dns-operator.html) directly resolves cluster-internal domains.
  - Azure Red Hat OpenShift also supports [custom DNS servers](/azure/openshift/howto-custom-dns) in the virtual network.
  - Other domains are forwarded to the DNS servers you configure in Azure Virtual Network. The DNS servers will be either the default Azure DNS resolver, or any custom DNS servers you configure at the virtual network level.
  - You can customize the [DNS forwarding in Azure Red Hat OpenShift CoreDNS](/azure/openshift/dns-forwarding).
  - If no custom DNS servers are configured in the virtual network, Azure Red Hat OpenShift uses the default Azure DNS resolver.
  - For more information about DNS, see [Azure Private Endpoint DNS configuration](/azure/private-link/private-endpoint-dns).
- You can send outbound (egress) network traffic through Azure Firewall or a network virtual appliance cluster.
  - By default, Azure Red Hat OpenShift clusters have unrestricted egress internet access.
  - You can deploy Azure Red Hat OpenShift with restricted egress traffic by adding a user-defined route (UDR) that has a `0.0.0.0/0` route to Azure Firewall or to a network virtual appliance. Azure Red Hat OpenShift has an [egress lockdown](/azure/openshift/concepts-egress-lockdown) function that ensures access, even if the outbound (egress) traffic is restricted by a firewall appliance or by other means.
  - You can choose from two Azure Red Hat OpenShift deployment models: A [private API server endpoint and private ingress controller](/azure/openshift/howto-create-private-cluster-4x) or a [public API server endpoint and public ingress controller](/azure/openshift/tutorial-create-cluster).
  - If you use unrestricted egress access, you must carefully manage outbound ports to be sure you don't use all available outbound ports. For more information, see [Use Source Network Address Translation (SNAT) for outbound connections](/azure/load-balancer/load-balancer-outbound-connections).
- By default, all pods in an Azure Red Hat OpenShift cluster can send and receive traffic without limitations. All pods in a project are accessible from other pods and network endpoints. To isolate one or more pods in a project, you can create `NetworkPolicy` objects in the project to indicate the allowed incoming connections. Red Hat OpenShift software-defined networking (SDN) supports using [network policy](https://docs.openshift.com/container-platform/latest/networking/network_policy/about-network-policy.html) in its default network isolation mode.
- A service mesh provides capabilities like traffic management, resiliency, policy, security, strong identity, and observability. For more information about Red Hat OpenShift Service Mesh, see [Service Mesh and Istio differences](https://docs.openshift.com/container-platform/latest/service_mesh/v2x/ossm-vs-community.html).
- Global load-balancing mechanisms like [Azure Traffic Manager](/azure/traffic-manager/traffic-manager-overview) and [Azure Front Door](/azure/openshift/howto-secure-openshift-with-front-door) increase resiliency by routing traffic across multiple clusters, potentially in different Azure regions.

### Private clusters

Azure Red Hat OpenShift API cluster IP visibility can be either public or private. [Private clusters](/azure/openshift/howto-create-private-cluster-4x) expose the Azure Red Hat OpenShift API over a private IP address but not over a public one. The Azure Red Hat OpenShift API shouldn't be accessed through its IP address. Instead, access the Azure Red Hat OpenShift API through its [fully qualified domain name (FQDN)](/azure/openshift/tutorial-connect-cluster). The resolution from the Azure Red Hat OpenShift API FQDN to its IP address is handled by Azure DNS.

Per enterprise-scale proven practices, DNS resolution for Azure workloads is offered by centralized DNS servers that are deployed in the connectivity subscription. Azure DNS servers are either in a hub virtual network or in a shared services virtual network that's connected to an instance of Azure Virtual WAN. These servers conditionally resolve Azure-specific and public names by using Azure DNS (IP address `168.63.129.16`). The servers resolve private names by using corporate DNS servers. This connectivity model is a common practice and is important to allow private access to other Azure resources if you use private endpoints.

:::image type="content" source="media/landing-zone-architecture.png" border="false" alt-text="Diagram that shows a network for a private cluster.":::

### Traffic from application users to the cluster

Incoming (ingress) controllers can be used to expose applications running in the Azure Red Hat OpenShift clusters.

- [Ingress controllers](https://docs.openshift.com/container-platform/latest/networking/ingress-operator.html) provide application-level routing at the cost of a slight complexity increase.
- Azure Red Hat OpenShift creates a generic DNS entry that simplifies access to exposed applications in the cluster, like `*.apps.<cluster-ID>.<region>.aroapp.io`. It's useful for a private cluster to route traffic for the application.
- Azure Red Hat OpenShift offers a built-in [ingress controller and routes](https://docs.openshift.com/container-platform/latest/networking/configuring_ingress_cluster_traffic/configuring-ingress-cluster-traffic-ingress-controller.html).
- You can use Azure Red Hat OpenShift ingress with [Azure Front Door](/azure/openshift/howto-secure-openshift-with-front-door).
- Align the configuration with the egress filtering design to avoid asymmetric routing. UDRs potentially might cause asymmetric routing but not necessarily.
- If your scenario requires [TLS termination](https://docs.openshift.com/container-platform/latest/networking/ingress-operator.html), consider how you'll manage TLS certificates.

> [!IMPORTANT]
> When you use Azure Firewall to restrict egress traffic and create a UDR to force all egress traffic, make sure that you create an appropriate DNAT rule in Azure Firewall to correctly allow ingress traffic. Using Azure Firewall with a UDR breaks the ingress setup due to asymmetric routing. The issue occurs if the Azure Red Hat OpenShift subnet has a default route that goes to the firewall's private IP address, but you're using a public load balancer (ingress or Kubernetes service of type: Load Balancer). In this case, the incoming load balancer traffic is received via its public IP address, but the return path goes through the firewall's private IP address. Because the firewall is stateful, it drops the returning packet because the firewall doesn't detect an established session. To learn how to integrate Azure Firewall with your ingress or service load balancer, see [Integrate Azure Firewall with Azure Standard Load Balancer](/azure/firewall/integrate-lb).

The following flow applies when you use [Azure Front Door](/azure/openshift/howto-secure-openshift-with-front-door) with an Azure Red Hat OpenShift private cluster and ingress controller:

1. Clients from the public internet resolve the DNS name for the application that points to [Azure Front Door](/azure/openshift/howto-secure-openshift-with-front-door).
1. Azure Front Door uses a Private Link Service to access the private IP address of the Azure internal network load balancer to access an application in the Azure Red Hat OpenShift ingress controller.

For non-web application that access an Azure Red Hat OpenShift private cluster, the following flow applies:

1. Clients from the public internet resolve the DNS name for the application pointing to the public IP of Azure Firewall or a network virtual appliance.
1. Azure Firewall or the network virtual appliance forward the traffic (DNAT) to the Azure Red Hat OpenShift private cluster by using the private IP address of the Azure internal network load balancer to access the application in the Azure Red Hat OpenShift ingress controller.

### Traffic from the Azure Red Hat OpenShift pods to back-end services

The pods running inside the Azure Red Hat OpenShift cluster might need to access back-end services like Azure Storage, Azure Key Vault, Azure SQL Database, and Azure Cosmos DB. You can use [virtual network service endpoints](/azure/virtual-network/virtual-network-service-endpoints-overview) and [Azure Private Link](/azure/private-link/private-link-overview) to secure connectivity to these Azure managed services.

If you're using Azure private endpoints for back-end traffic, you can use Azure Private DNS zones for DNS resolution for the Azure services. Because the DNS resolvers for the entire environment are in the hub virtual network (or in the shared services virtual network if you use the virtual WAN connectivity model), create these private zones in the connectivity subscription. To create the A-record that's required to resolve the FQDN of the private service, you can associate the private DNS zone in the connectivity subscription with the private endpoint in the application subscription. This operation requires specific permissions in those subscriptions.

You can manually create the A-records, but associating the private DNS zone with the private endpoint results in a setup that's less prone to misconfigurations.

Back-end connectivity from Azure Red Hat OpenShift pods to Azure platform as a service (PaaS) services exposed through private endpoints follow this sequence:

1. The Azure Red Hat OpenShift pods resolve the FQDN of the Azure PaaS by using the central DNS servers in the connectivity subscription, which are defined as custom DNS servers in the Azure Red Hat OpenShift virtual network.
1. The resolved IP address is the private IP address of the private endpoints, which are accessed directly from the Azure Red Hat OpenShift pods.

Traffic between the Azure Red Hat OpenShift pods and the private endpoints by default don't go through the Azure Firewall instance in the hub virtual network (or the secure virtual hub, if you're using a virtual WAN), even if the Azure Red Hat OpenShift cluster is configured for [egress filtering with Azure Firewall](/azure/openshift/howto-restrict-egress). The private endpoint creates a `/32` route in the subnets of the application virtual network in which Azure Red Hat OpenShift is deployed.

## Design recommendations

- If your security policy requires you to use a private IP address for the Azure Red Hat OpenShift API, [deploy a private Azure Red Hat OpenShift cluster](/azure/openshift/howto-create-private-cluster-4x).
- Use Azure DDoS Protection Standard to protect the virtual network you use for the Azure Red Hat OpenShift cluster *unless you use Azure Firewall or Azure Web Application Firewall in a centralized subscription*.
- Use the DNS configuration linked to the overall network setup with Azure Virtual WAN or hub and spoke architecture, Azure DNS zones, and your own DNS infrastructure.
- Use Private Link to secure network connections and use private IP-based connectivity to other managed Azure services used that support Private Link, such as Azure Storage, Azure Container Registry, Azure SQL Database, and Azure Key Vault.
- Use an ingress controller to provide advanced HTTP routing and security, and to offer a single endpoint for applications.
- All web applications you configure to use an ingress should use TLS encryption and not allow access over unencrypted HTTP.
- Use [Azure Front Door](/azure/openshift/howto-secure-openshift-with-front-door) with [Azure Web Application Firewall](/azure/frontdoor/web-application-firewall) to securely publish Azure Red Hat OpenShift applications to the internet.
- If your security policy requires you to inspect all outbound internet traffic that's generated in the Azure Red Hat OpenShift cluster, secure egress network traffic by using Azure Firewall or a third-party network virtual appliance that's deployed in the managed hub virtual network. For more information, see [Control egress traffic to an Azure Red Hat OpenShift cluster](/azure/openshift/howto-restrict-egress).
- Use the Azure Load Balancer Standard tier instead of the Basic tier for non-web applications.
