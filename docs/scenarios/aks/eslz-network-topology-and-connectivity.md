---
title: "Enterprise-Scale network topology and connectivity for <Insert narrative Name>"
description: Describe how this enterprise-scale scenario can improve network topology and connectivity of <Insert Scenario Name>
author: BrianBlanchard
ms.author: brblanch
ms.date: 09/11/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Network topology and connectivity for <Insert narrative Name> Enterprise-Scale scenario

**Design considerations**

- Decide on cluster IP visibility, whether it should have a public or a private IP address
- Plan the IP addressing and the size of the VNet subnet, to support the scaling of the cluster by adding more nodes, etc.
- Decide on the supported network model for the VNet integration, kubenet or Azure Container Networking Interface (CNI).
  - CNI requires additional planning for IP addresses.
  - Only CNI supports Windows Server node pool.
  - kubenet requires UDRs to be manually applied.
  - Verify the [current list](https://docs.microsoft.com/azure/aks/concepts-network#compare-network-models) of supported capabilities by each CNI plugin.
- Plan and decide on the usage of virtual nodes, and verify the documented [known limitations](https://docs.microsoft.com/azure/aks/virtual-nodes-portal#known-limitations).
- Decide on the Azure Load Balancer SKU for the AKS cluster: AKS supports Basic and Standard load balancer SKUs.
- Decide on the VNet subnet setup with an internal load balancer: An internal load balancer can be deployed in the same VNet subnet as the nodes, or in a dedicated subnet.
- Plan and decide on the DNS integration.
  - CoreDNS will resolve cluster-internal domains directly
  - Other domains will be forwarded to the DNS servers configured on the VNet level.
- Plan and decide on the connectivity to other Azure managed (PaaS) services.
  - Consider using available features such as VNet Service Endpoints or Private Link.
- Plan and decide on the Ingress controller.
  - Decide whether an Ingress controller is required for your applications (e.g. more complex routing, additional security features, etc.).
  - Decide whether a Web Application Firewall is required, as part of the Ingress controller.
  - Understand the requirements and differences between off-cluster and in-cluster solutions:
    - An off-cluster Ingress controller offloads compute (HTTP traffic routing, TLS termination, etc.) to another service outside of AKS, e.g.  [Azure Application Gateway Ingress Controller (AGIC) add-on](https://docs.microsoft.com/azure/application-gateway/ingress-controller-overview).
    - An in-cluster solution consumes AKS cluster resources for compute (HTTP traffic routing, TLS termination, etc.). In-cluster ingress-controllers can offer lower cost, but they require careful resource planning and maintenance.
  - If using the Basic HTTP Application Routing Add-on, read the considerations in [HTTP Application Routing](https://docs.microsoft.com/azure/aks/http-application-routing).
- Decide on the network visibility (public or private IP address) for the Ingress controller, and therefore availability of applications and APIs.
  - An Ingress controller can be configured with a public IP address or private IP address; however, the configuration should be aligned with the egress filtering in order to avoid asymmetric routing.
  - Decide whether TLS termination is required, and what TLS certificates are used.
- Decide whether using Azure Policy and the Azure Policy add-on for AKS to control and limit the objects created in your AKS cluster, such as for example to deny the creation of public IP addresses in the cluster.
- Plan and decide on the egress network traffic.
  - By default, AKS clusters have unrestricted outbound (egress) internet access.
  - Decide whether egress network traffic must go through Azure Firewall or a Network Virtual Appliance.
- Decide whether network traffic between pods in a cluster must be filtered.
  - By default, all pods in an AKS cluster can send and receive traffic without limitations. Kubernetes network policies can be used to improve security.
  - Decide on any of the available [network policy models](https://docs.microsoft.com/azure/aks/use-network-policies#network-policy-options-in-aks) based on the capabilities and requirement for support. 
- Decide whether a service mesh is required.
  - A service mesh provides capabilities like traffic management, resiliency, policy, security, strong identity, and observability.
  - Understand the requirements and reasons for installing a service mesh, and verify the documented [selection criteria](https://docs.microsoft.com/azure/aks/servicemesh-about#selection-criteria).
- Consider using a global load balancing mechanism like [Azure Traffic Manager](https://docs.microsoft.com/azure/traffic-manager/traffic-manager-overview) or [Azure Front Door](https://docs.microsoft.com/azure/frontdoor/front-door-overview) to increase resiliency by routing traffic across multiple clusters

**Design recommendations**

- If your security policy mandates having the Kubernetes API with a private IP address (instead of a public IP address), [deploy a private AKS cluster](https://docs.microsoft.com/azure/aks/private-clusters).
- Use Azure Container Networking Interface (CNI) as network model, unless you have a limited range of IP addresses that can be assigned to the AKS cluster.
  - Follow the documentation with regards to [IP address planning](https://docs.microsoft.com/azure/aks/configure-azure-cni#plan-ip-addressing-for-your-cluster) with CNI.
  - If you want to use Windows Server node pools and virtual nodes verify eventual limitations, please refer to the [Windows AKS support FAQ](https://docs.microsoft.com/azure/aks/windows-faq).
- Use Azure DDoS Protection Standard to protect the Azure VNet used for the AKS cluster
- Use the DNS configuration linked to the overall network setup with Azure Virtual WAN or hub and spoke architecture, Azure DNS Zones and your own DNS infrastructure.
- Use Private Link to secure network connections and use private IP-based connectivity to other used managed Azure services that support Private Link, such as Azure Storage, Azure Container Registry, Azure SQL Database, Azure Key Vault, etc.
- Use an Ingress controller to provide advanced HTTP routing and security and offer a single endpoint for applications.
- To conserve compute and storage resources of your AKS cluster, use an off-cluster Ingress controller.
  - Use the [Azure Application Gateway Ingress Controller (AGIC)](https://docs.microsoft.com/azure/application-gateway/ingress-controller-overview) add-on, which is a 1st party managed Azure service.
  - With AGIC, deploy a dedicated Azure Application Gateway for each AKS cluster, do not share the same Application Gateway across multiple AKS clusters.
  - If there are no resource or operational constraints, or AGIC does not provide the required features, use an in-cluster Ingress controller solution like NGINX, Traefik, or any other Kubernetes-supported solution.
- For Internet-facing  and security-critical internal-facing web applications, use a Web Application Firewall (WAF) with the Ingress controller.
  - Azure Application Gateway and Azure Front Door both integrate the [Azure WAF](https://docs.microsoft.com/azure/web-application-firewall/ag/ag-overview) to protect web-based applications.
- If your security policy mandates inspecting all Internet-outbound traffic generated in the AKS cluster, secure egress network traffic using Azure Firewall or a 3rd party network virtual appliance (NVA) deployed in the (managed) hub VNet, see [Limit Egress Traffic](https://docs.microsoft.com/azure/aks/limit-egress-traffic) for more details
