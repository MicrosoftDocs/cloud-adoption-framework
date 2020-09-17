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

- Plan the IP addressing and the size of the VNet subnet, to support the scaling of the cluster by adding more nodes, etc.
- Decide on the supported network model for the VNet integration, kubenet or Azure Container Networking Interface (CNI).
  - CNI requires additional planning for IP addresses.
  - Only CNI supports Windows Server node pool.
  - kubenet requires UDRs to be manually applied.
  - Verify the [list](https://docs.microsoft.com/en-us/azure/aks/concepts-network#compare-network-models "list") of supported capabilities.
- Plan and decide on the usage of virtual nodes, and verify the documented [known limitations](https://docs.microsoft.com/en-us/azure/aks/virtual-nodes-portal#known-limitations "known limitations").
- Decide on the VNet subnet setup with an internal load balancer.
  - AKS supports Basic and Standard load balancer SKUs.
  - An internal load balancer can be deployed in the same VNet subnet as the nodes, or in a dedicated subnet.
- Plan and decide on the DNS integration.
  - CoreDNS is configured per default to forward unknown domains to the DNS servers (DNS functionality of the VNet) where the AKS cluster is deployed.
- Plan and decide on the connectivity to other Azure managed (PaaS) services.
  - Consider using available features such as VNet Service Endpoints or Private Link.
- Plan and decide on the Ingress controller.
  - Decide whether an Ingress controller is required for your applications (e.g. more complex routing, additional security features, etc.).
  - Decide whether a Web Application Firewall is required, as part of the Ingress controller.
  - Understand the requirements and differences between off-cluster and in-cluster solutions:
    - An off-cluster Ingress controller offloads compute (HTTP traffic routing, TLS termination, etc.) to another service outside of AKS, e.g.  [Azure Application Gateway Ingress Controller (AGIC) add-on](https://docs.microsoft.com/en-us/azure/application-gateway/ingress-controller-overview "Azure Application Gateway Ingress Controller (AGIC) add-on").
    - An in-cluster solution consumes AKS cluster resources for compute (HTTP traffic routing, TLS termination, etc.).
- Decide on the network for the Ingress controller, and therefore availability of applications and APIs.
  - An Ingress controller can be configured with a public IP address or private IP address; however, the configuration should be aligned with the egress filtering in order to avoid asymmetric routing.
  - AKS supports a basic HTTP application routing add-on to quickly create an Ingress controller.
  - Decide whether TLS termination is required, and what TLS certificate is used.
- Decide on using Azure Policy to control and limit the objects created in your AKS cluster, such as for example to deny the creation of public IP addresses on using Azure Policy to control and limit the options of creating public IP addresses.
- Plan and decide on the egress network traffic.
  - By default, AKS clusters have unrestricted outbound (egress) internet access.
  - Decide whether egress network traffic must be secured using additional features and services.
  - As AKS supports different solutions to secure egress network traffic, decide on a solution that is linked and works with the planned network setup (Azure Virtual WAN, hub and spoke topology, Azure Firewall etc.).
- Decide whether network traffic between pods in a cluster must be filtered.
  - By default, all pods in an AKS cluster can send and receive traffic without limitations.
  - Consider using network policies for improved security.
  - Decide on any of the supported [network policy models](https://docs.microsoft.com/en-us/azure/aks/use-network-policies#network-policy-options-in-aks "network policy models") based on the supported capabilities.
- Decide whether a service mesh is required.
  - A service mesh provides capabilities like traffic management, resiliency, policy, security, strong identity, and observability.
  - Understand the requirements and reasons for installing a service mesh, and verify the documented [selection criteria](https://docs.microsoft.com/en-us/azure/aks/servicemesh-about#selection-criteria "selection criteria").


**Design recommendations**

- Use Azure Container Networking Interface (CNI) as network model, unless you have a limited range of IP addresses that can be assigned to the AKS cluster.
  - Follow the documentation with regards to [IP address planning](https://docs.microsoft.com/en-us/azure/aks/configure-azure-cni#plan-ip-addressing-for-your-cluster "IP address planning") with CNI.
  - If you want to use Windows Server node pools and virtual nodes, only CNI is supported.
- Use Azure DDoS Protection Standard to protect the Azure VNet used for the AKS cluster
- Use the DNS configuration linked to the overall network setup with Azure Virtual WAN or hub and spoke architecture, and Azure Private DNS Zones or a VM-based DNS solution.
- Use Private Link to secure network connections and use private IP-based connectivity to other used managed Azure services that support Private Link, such as Azure Storage, Azure SQL Database, Azure Key Vault, etc.
- Use an Ingress controller like to reduce the number of IP addresses required to expose your applications, and make it more secure.
- Do not use the basic HTTP application routing add-on for production AKS clusters.
- To conserve compute and storage resources of your AKS cluster, use an off-cluster Ingress controller.
  - Use the [Azure Application Gateway Ingress Controller (AGIC)](https://docs.microsoft.com/en-us/azure/application-gateway/ingress-controller-overview "Azure Application Gateway Ingress Controller (AGIC)") add-on, which is a 1st party managed Azure service.
  - With AGIC, deploy a dedicated Azure Application Gateway for each AKS cluster, do not share the same Application Gateway across multiple AKS clusters.
- If there are no resource constraints, or AGIC does not provide the required features, use an in-cluster Ingress controller solution like NGINX or Traefik, or any other Kubernetes-supported solution.
- For Internet-facing  and security-critical internal-facing web applications, use a Web Application Firewall (WAF) with the Ingress controller.
- Azure Application Gateway and Azure Front Door both integrate the [Azure WAF](https://docs.microsoft.com/en-us/azure/web-application-firewall/ag/ag-overview "Azure WAF") to protect web-based applications.
- Secure egress network traffic using Azure Firewall or 3rd party network virtual appliance (NVA) deployed in the (managed) hub VNet.
  - Use User-Defined Routes (UDR) to send egress network traffic to the Azure Firewall or 3rd party NVA.
- With egress network traffic secured using Azure Firewall or 3rd party NVA, use Azure Policy to prevent application teams from creating public IP addresses.
- Use Calico as network policy model to secure traffic between pods in an AKS cluster, unless you require support from Azure support.
