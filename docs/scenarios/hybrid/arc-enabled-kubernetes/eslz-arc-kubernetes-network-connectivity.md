---
title: Network connectivity for Azure Arc-enabled Kubernetes
description: Understand the design considerations and recommendations for network connectivity of Arc-enabled Kubernetes.
author: chintalavr
ms.author: vchintala
ms.date: 11/15/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-hybrid
---

# Network topology & connectivity for Azure Arc-enabled Kubernetes

Arc-enabled Kubernetes supports [fully connected and semi-connected modes](/azure/azure-arc/kubernetes/conceptual-connectivity-modes#understand-connectivity-modes) to onboard and manage Kubernetes cluster with Azure Arc control plane. Azure Arc-enabled Kubernetes agents communicate with Azure Arc endpoints to [exchange different types of metadata information](/azure/azure-arc/kubernetes/conceptual-data-exchange) using pull and push methods from the Kubernetes cluster.

This document explains network architecture to support these connectivity modes, design considerations, and recommendations when enabling connectivity to Azure control plane to manage and operate Arc-enabled Kubernetes clusters running on-premises and other cloud environments.

## Architecture

The following is an Azure Arc-enabled Kubernetes network architecture diagram to support fully connected and semi-connected network connectivity modes.

[ ![A diagram showing Azure Arc-enabled Kubernetes network architecture](./media/arc-enabled-kubernetes-network.png)](./media/arc-enabled-kubernetes-network.png#lightbox)

The following is a network architecture diagram that supports cluster access from any network location using [Azure Arc-enabled Kubernetes Cluster Connect capability](/azure/azure-arc/kubernetes/conceptual-cluster-connect) feature.

[ ![A diagram showing Azure Arc-enabled Kubernetes Cluster Connect network architecture](./media/arc-enabled-kubernetes-cluster-connect-network.png)](./media/arc-enabled-kubernetes-cluster-connect-network.png#lightbox)

## Design considerations

- Review the [network topology and connectivity design area](/azure/cloud-adoption-framework/ready/enterprise-scale/network-topology-and-connectivity) of the Azure landing zones to assess the impact of Azure Arc-enabled Kubernetes on your connectivity model.
- Review the Azure Arc-enabled Kubernetes [network requirements](/azure/azure-arc/kubernetes/quickstart-connect-cluster?tabs=azure-cli#meet-network-requirements) to understand how your Azure Arc-enabled Kubernetes clusters will communicate with Azure from your on-premises network or other cloud providers.
- Consider the trade-offs between the organization's security and compliance requirements versus Azure Arc-enabled Kubernetes benefits to the organizations, decide between [fully connected vs semi-connected mode](/azure/azure-arc/kubernetes/conceptual-connectivity-modes#understand-connectivity-modes).
- Decide between public or private endpoints to connect to [Azure Log Analytics](/azure/azure-monitor/logs/private-link-design) workspaces through ExpressRoute or VPN versus internet connectivity.
- Decide between public or private endpoints to connect to [Azure Key Vaults](/azure/azure-arc/kubernetes/tutorial-akv-secrets-provider) through ExpressRoute or VPN versus internet connectivity.
- Decide between the network connectivity options for Azure Arc-enabled Kubernetes cluster management as Azure Arc-enabled Kubernetes cluster supports [cluster management from any network](/azure/azure-arc/kubernetes/conceptual-cluster-connect). Refer [Identity and Access Management](./eslz-arc-kubernetes-identity-access-management.md) for design considerations and recommendations when deciding the network independent cluster management.
- Consider managing Azure Arc-enabled Kubernetes cluster securely using [Cluster Connect capability to access anywhere](/azure/azure-arc/kubernetes/conceptual-cluster-connect) by eliminating opening inbound network ports and allowing only outbound communication to Azure Arc services in Azure.
- When using on-premises or multicloud [firewalls or proxy servers for TLS inspection](/azure/firewall/premium-features#tls-inspection) of outbound traffic and network intrusion detection and prevention system (IDPS), decide whether to exempt Azure Arc-enabled Kubernetes endpoints as some of the server certificates could not have been trusted by these firewalls or proxy servers.

## Design recommendations

- Use fully connected mode for onboarded Kubernetes clusters in order to stay current with the latest product releases, security updates, policies, and installed extensions to bring Azure cloud services to on-premises or multicloud environments.
- Ensure the Azure Arc-enabled Kubernetes [network requirements](/azure/azure-arc/kubernetes/quickstart-connect-cluster?tabs=azure-cli#meet-network-requirements) are met, based upon your chosen connectivity model.
- Enable [Azure Private Link](/azure/azure-monitor/logs/private-link-security) to access Azure resources such as [Key Vault](/azure/azure-arc/kubernetes/tutorial-akv-secrets-provider), [storage accounts](/azure/storage/common/storage-account-overview), [Microsoft Container Registry](/azure/container-registry/), and [Log Analytics](/azure/azure-monitor/logs/log-analytics-workspace-overview) from Kubernetes cluster running on-premises or other cloud environments through Azure [Express Route](/azure/expressroute/expressroute-introduction) or [VPN connection](/azure/vpn-gateway/vpn-gateway-about-vpngateways).
  - Configure a [DNS forwarder](/azure/private-link/private-endpoint-dns#on-premises-workloads-using-a-dns-forwarder) to to resolve the Azure service public DNS zone in Azure.
- When [Azure Arc-enabled Kubernetes agents](/azure/azure-arc/kubernetes/conceptual-agent-overview) traffic is going through the firewalls or proxy servers, create a source and destination object groups and/or tags to simplify outbound internet traffic rules to support additional URL Allow list for Azure Arc extensions.
- Use Azure Monitor to keep track of [the Azure Arc-enabled Kubernetes clusters connectivity status](/azure-arc/kubernetes/conceptual-connectivity-modes#connectivity-status) and raise alerts to notify Kubernetes cluster administrators when connectivity state changes. Use [Azure Resource Graph queries](/azure/azure-arc/kubernetes/resource-graph-samples?tabs=azure-cli) along with Azure Monitor.
- When using [the semi-connected network connectivity mode](/azure/azure-arc/kubernetes/conceptual-connectivity-modes#understand-connectivity-modes), it is recommended to connect the cluster to Azure Arc at least once in 30 days to export billing data and once in 90 days to renew managed identity certificates and update Azure Arc-enabled Kubernetes resource and agents.

## Next steps

For more information about your hybrid and multicloud cloud journey, see the following articles:

- Review the [prerequisites](/azure/azure-arc/kubernetes/quickstart-connect-cluster?tabs=azure-cli#prerequisites) for Azure Arc-enabled Kubernetes.
- Review [validated Kubernetes distributions](/azure/azure-arc/kubernetes/validation-program#validated-distributions) for Azure Arc-enabled Kubernetes.
- Review [Manage hybrid and multicloud environments](/azure/cloud-adoption-framework/scenarios/hybrid/manage).
- [Connect an existing Kubernetes cluster to Azure Arc](/azure/azure-arc/kubernetes/quickstart-connect-cluster?tabs=azure-cli).
- [Azure Arc-enabled Kubernetes connectivity modes](/azure/azure-arc/kubernetes/conceptual-connectivity-modes).
- [Data exchanged between Azure Arc-enabled Kubernetes cluster and Azure](/azure/azure-arc/kubernetes/conceptual-data-exchange).
- [Apply configurations at-scale using Azure Policy](/azure/azure-arc/kubernetes/use-azure-policy).
- [Azure Resource Graph sample queries for Azure Arc-enabled Kubernetes](/azure/azure-arc/kubernetes/resource-graph-samples?tabs=azure-cli).
- Understand [Azure Arc-enabled Open Service Mesh](/azure/azure-arc/kubernetes/tutorial-arc-enabled-open-service-mesh) to secure Azure Arc-enabled Kubernetes cluster communication and [services observability](./eslz-arc-kubernetes-services-observability.md) critical design area.
- [Access Azure Arc-enabled Kubernetes cluster from anywhere using Cluster Connect](/azure/azure-arc/kubernetes/conceptual-cluster-connect).
- Experience Azure Arc-enabled Kubernetes automated scenarios with the [Azure Arc Jumpstart](https://azurearcjumpstart.io/azure_arc_jumpstart/azure_arc_k8s/).
- To learn more about Azure Arc, review the [Azure Arc learning path on Microsoft Learn](/learn/paths/manage-hybrid-infrastructure-with-azure-arc/).
- Review [Frequently Asked Questions - Azure Arc-enabled](/azure/azure-arc/kubernetes/faq) to get answers to most common questions.
