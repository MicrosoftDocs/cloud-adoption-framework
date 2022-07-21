---
title: Network topology and connectivity for Azure Red Hat OpenShift (ARO)
description: Learn how to improve the network topology and connectivity of the Azure Red Hat OpenShift (ARO).
author: Victor Santana
ms.author: Welasco
ms.date: 06/03/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-aro
---

# Network topology and connectivity considerations for ARO

<!-- docutune:casing "Basic and Standard" -->

## Design considerations

- ARO requires two subnets a master subnet and worker subnet.
  - The master subnet is used to deploy the cluster's master nodes.
  - The worker subnet is used to deploy the cluster's worker nodes.
  - Worker subnet and master subnet should be minimum /27.
  - Worker subnet and master subnet cannot be changed after cluster deployment.
  - The master and worker subnets must not have a NSG associated. A NSG will be created and managed by ARO cluster.
  - Worker subnet and master subnet cannot overlap with on-premises networks or any other Azure Network.

  -
- IP addressing and the size of the virtual network subnet must be carefully planned to support the scaling of the cluster. For example, you can add more nodes.
- ARO services and [routes](https://docs.openshift.com/container-platform/latest/networking/routes/route-configuration.html) can be exposed with public or internal load balancers. Internal load balancers will be configured in the same subnet as the worker nodes. In case of a restricted egress cluster public load balancers cannot be used due to asymmetric routing.
- ARO uses CoreDNS to provide name resolution to pods running in the cluster.
  - [CoreDNS](https://docs.openshift.com/container-platform/latest/networking/dns-operator.html) will resolve cluster-internal domains directly.
  - ARO also supports [custom DNS servers](/azure/openshift/howto-custom-dns) in the Virtual Network.
  - Other domains will be forwarded to the DNS servers configured in Azure Virtual Network, which will be either the default Azure DNS resolver, or any custom DNS servers configured at the virtual network level.
  - It's possible to customize the [DNS forwarding in ARO CoreDNS](/azure/openshift/dns-forwarding).
  - ARO will use the default Azure DNS resolver if no custom DNS servers are configured in the Virtual Network.
  - For additional information on DNS, see [Azure Private Endpoint DNS configuration](/azure/private-link/private-endpoint-dns).
- Outbound (egress) network traffic can be sent through an Azure Firewall or network virtual appliance cluster.
  - By default, ARO clusters have unrestricted egress internet access.
  - ARO can be deployed with restricted egress traffic by adding a User Defined Routing with a 0.0.0.0/0 route to an Azure Firewal or network virtual appliance. ARO has an [Egress lockdown](/azure/openshift/concepts-egress-lockdown) functionality that ensures access even if the outbound (egress) traffic is restricted by a firewall appliance or other means.
  - There are two deployment models for ARO with [private API server endpoint and a private ingress controller](/azure/openshift/howto-create-private-cluster-4x) or [public API server endpoint and public ingress controller](/azure/openshift/tutorial-create-cluster).
  - If using unrestricted egress access, you must carefully manage outbound ports, since you might use up the available outbound ports. For more information see [Use Source Network Address Translation (SNAT) for outbound connections](/azure/load-balancer/load-balancer-outbound-connections).
- By default, all pods in an ARO cluster can send and receive traffic without limitations. All pods in a project are accessible from other pods and network endpoints. To isolate one or more pods in a project, you can create NetworkPolicy objects in that project to indicate the allowed incoming connections. OpenShift SDN supports using [network policy](https://docs.openshift.com/container-platform/latest/networking/network_policy/about-network-policy.html) in its default network isolation mode.
- A service mesh provides capabilities like traffic management, resiliency, policy, security, strong identity, and observability. For more information about OpenShift service mesh, see [Service Mesh and Istio differences](https://docs.openshift.com/container-platform/latest/service_mesh/v2x/ossm-vs-community.html).
- Global load-balancing mechanisms such as [Azure Traffic Manager](/azure/traffic-manager/traffic-manager-overview) and [Azure Front Door](/azure/openshift/howto-secure-openshift-with-front-door) increase resiliency by routing traffic across multiple clusters, potentially in different Azure regions.

### Private clusters

ARO API cluster IP visibility can be either public or private. [Private clusters](/azure/openshift/howto-create-private-cluster-4x) expose the ARO API over a private IP address, but not over a public one. The ARO API shouldn't be accessed through its IP address, [but instead through its fully qualified domain name (FQDN)](/azure/openshift/tutorial-connect-cluster). The resolution from the ARO API FQDN to its IP address will handled by Azure DNS.

Following enterprise-scale proven practices, DNS resolution for Azure workloads is offered by centralized DNS servers deployed in the connectivity subscription, either in a hub virtual network or in a shared services virtual network connected to an Azure Virtual WAN. These servers will conditionally resolve Azure-specific and public names using Azure DNS (IP address 168.63.129.16), and private names using corporate DNS servers. This connectivity model is a common practice and is important to allow private access to other Azure resources when using Private Endpoints.

![Diagram showing a network for a private cluster.](./media/aro_landing_zone_Architecture.png)

### Traffic from application users to the cluster

Incoming (ingress) controllers can be used to expose applications running in the ARO clusters.

- [Ingress controllers](https://docs.openshift.com/container-platform/latest/networking/ingress-operator.html) provide application-level routing at the cost of a slight complexity increase.
- ARO creates a generic DNS entry that simplify access to exposed applications in the cluster like *.apps.<ClusterID>.<Region>.aroapp.io. It's useful for Private cluster to route traffic for the application.
- ARO offers a built in [Ingress Controller and routes](https://docs.openshift.com/container-platform/latest/networking/configuring_ingress_cluster_traffic/configuring-ingress-cluster-traffic-ingress-controller.html).
- ARO Ingress can be used with [Azure Front Door](/azure/openshift/howto-secure-openshift-with-front-door).
- The configuration should be aligned with the egress filtering design to avoid asymmetric routing. UDRs can cause asymmetric routing (potentially), but not necessarily.
- If [TLS termination](https://docs.openshift.com/container-platform/latest/networking/ingress-operator.html) is required, management of TLS certificates must be considered.

> [!IMPORTANT]
> When you use Azure Firewall to restrict egress traffic and create a user-defined route (UDR) to force all egress traffic, make sure you create an appropriate DNAT rule in Firewall to correctly allow ingress traffic. Using Azure Firewall with a UDR breaks the ingress setup due to asymmetric routing. (The issue occurs if the ARO subnet has a default route that goes to the firewall's private IP address, but you're using a public load balancer - ingress or Kubernetes service of type: LoadBalancer). In this case, the incoming load balancer traffic is received via its public IP address, but the return path goes through the firewall's private IP address. Because the firewall is stateful, it drops the returning packet because the firewall isn't aware of an established session. To learn how to integrate Azure Firewall with your ingress or service load balancer, see [Integrate Azure Firewall with Azure Standard Load Balancer](/azure/firewall/integrate-lb).

The following flow applies when using [Azure Front Door](/azure/openshift/howto-secure-openshift-with-front-door) in conjunction with ARO Private Cluster and Ingress Controller:

1. Clients from the public internet resolve the DNS name for the application pointing to [Azure Front Door](/azure/openshift/howto-secure-openshift-with-front-door).
2. Azure Front Door will use a Private Link Service to access the Private IP of Azure Internal Network Loadbalancer to access an application in ARO Ingress Controller.

For non-web application accessing ARO Private the following flow applies:

1. Clients from the public internet resolve the DNS name for the application pointing to the public IP of Azure Firewall or a Network Virtual Appliance.
2. Azure Firewall or Network Virtual Appliance will forward the traffic (DNAT) to ARO Private cluster using the Private IP of Azure Internal Network Loadbalancer to access the application in ARO Ingress Controller.

### Traffic from the ARO pods to backend services

The pods running inside of the ARO cluster might need to access backend services such as Azure Storage, Azure Key Vault, Azure SQL databases, or Azure Cosmos DB NoSQL databases. [Virtual network service endpoints](/azure/virtual-network/virtual-network-service-endpoints-overview) and [Private Link](/azure/private-link/private-link-overview) can be used to secure connectivity to these Azure managed services.

If you are using Azure private endpoints for backend traffic, DNS resolution for the Azure services can be performed using Azure Private DNS zones. Since the DNS resolvers for the whole environment are in the hub virtual network (or the shared services virtual network if using the Virtual WAN connectivity model), these private zones should be created in the connectivity subscription. To create the A-record required to resolve the FQDN of the private service, you can associate the private DNS zone (in the connectivity subscription) with the private endpoint (in the application subscription). This operation requires certain privileges in those subscriptions.

It's possible to create the A-records manually, but associating the private DNS zone with the private endpoint results in a setup less prone to misconfigurations.

Backend connectivity from ARO pods to Azure PaaS services exposed through private endpoints will follow this sequence:

1. The ARO pods will resolve the FQDN of the Azure platform as a service (PaaS) using the central DNS servers in the connectivity subscription, which are defined as custom DNS servers in the ARO virtual network.
2. The resolved IP will be the private IP address of the private endpoints, which are accessed directly from the ARO pods.

Traffic between the ARO pods and the private endpoints per default will not go through the Azure Firewall in the hub virtual network (or the secure virtual hub if using Virtual WAN), even if the ARO cluster is configured for [egress filtering with Azure Firewall](/azure/openshift/howto-restrict-egress). The reason is that the private endpoint will create a `/32` route in the subnets of the application virtual network, where ARO is deployed.

## Design recommendations

- If your security policy mandates having the ARO API with a private IP address (instead of a public IP address), [deploy a private ARO cluster](/azure/openshift/howto-create-private-cluster-4x).
- Use Azure DDoS Protection Standard to protect the virtual network used for the ARO cluster **unless you use Azure Firewall or WAF in a centralized subscription**.
- Use the DNS configuration linked to the overall network setup with Azure Virtual WAN or hub and spoke architecture, Azure DNS zones, and your own DNS infrastructure.
- Use Private Link to secure network connections and use private IP-based connectivity to other managed Azure services used that support Private Link, such as Azure Storage, Azure Container Registry, Azure SQL Database, and Azure Key Vault.
- Use an ingress controller to provide advanced HTTP routing and security, and to offer a single endpoint for applications.
- All web applications configured to use an ingress should use TLS encryption and not allow access over unencrypted HTTP.
- Use [Azure Front Door](/azure/openshift/howto-secure-openshift-with-front-door) with [WAF](/azure/frontdoor/web-application-firewall) to secure publish ARO applications to internet.
- If your security policy mandates inspecting all outbound internet traffic generated in the ARO cluster, secure egress network traffic using Azure Firewall or a third-party network virtual appliance (NVA) deployed in the managed hub virtual network. For more information, see [Control egress traffic ARO cluster](/azure/openshift/howto-restrict-egress).
- Use the Standard tier rather than the Basic tier of Azure Load Balancer for non-Web applications.