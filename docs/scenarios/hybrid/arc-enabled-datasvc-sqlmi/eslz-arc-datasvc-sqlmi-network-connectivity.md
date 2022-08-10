---
title: Network connectivity for Azure Arc-enabled data services
description: Understand the design considerations and recommendations for network connectivity in Arc-enabled data services
author: welasco
ms.author: vsantana
ms.date: 07/21/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-hybrid, event-tier1-build-2022
---

# Network connectivity for Azure Arc-enabled data services

Arc-enabled data services supports two different connectivity modes [Directly connected and Indirectly connected](/azure/azure-arc/data/connectivity) to deploy Azure Arc-enabled SQL Managed Instance running on Azure Arc-enabled Kubernetes clusters with Azure Arc's control plane. Azure Arc-enabled data services components such as Azure Arc Data Controller, Azure Arc Active Directory connector, and Azure Arc-enabled SQL Managed Instances communicate with Azure Arc endpoints, Active Directory domain controllers, and DNS servers running on-premises and other cloud environments.

This document explains network architecture, design considerations, and design recommendations that help you understand connectivity to the Azure control plane and on-premises or other cloud infrastructure and help you manage and operate Arc-enabled data services and Arc-enabled SQL Managed Instance running on Arc-enabled Kubernetes clusters in on-premises and other cloud environments.

## Architecture

The following diagram displays an Azure Arc-enabled data services network architecture that supports directly connected and indirectly-connected network connectivity modes.

[![A diagram showing Azure Arc-enabled data services network architecture.](./media/arc-enabled-sqlmi-network.png)](./media/arc-enabled-sqlmi-network.png#lightbox)

The following is a scenario diagram for securely accessing Azure Arc-enabled SQL Managed Instance by various consumer services.

[![A diagram showing Azure Arc-enabled data services secure access network architecture.](./media/arc-enabled-sqlmi-secure-access-network.png)](./media/arc-enabled-sqlmi-secure-access-network.png#lightbox)

## Design considerations

- Review the [network topology and connectivity design area](/azure/cloud-adoption-framework/ready/enterprise-scale/network-topology-and-connectivity) of the Azure landing zones to align Azure Arc-enabled data services network connectivity with your organization adopted landing zone design.

- Review the [Network connectivity for Azure Arc-enabled Kubernetes](/azure/cloud-adoption-framework/scenarios/hybrid/arc-enabled-kubernetes/eslz-arc-kubernetes-network-connectivity) for understanding network architecture and recommendations to make right design decisions for deploying and operating Azure Arc-enabled data services on Azure ARc-enabled Kubernetes cluster. Azure Arc-enabled data services uses Azure Arc-enabled Kubernetes network connectivity for service deployment and operations.

- Review the [Azure Arc-enabled data services feature availability by connectivity-mode](/azure/azure-arc/data/connectivity#feature-availability-by-connectivity-mode) and [network requirements](/azure/azure-arc/data/connectivity) for Azure Arc-enabled data services and consider whether directly connected mode or indirectly connected mode option is better suited to align with your organization network security policies of on-premises network or other cloud providers.

- Consider the trade-offs between your organization's security and compliance requirements and the benefits Azure Arc-enabled data services offers your organization. Decide between [directly connected mode or indirectly connected mode](/azure/azure-arc/data/connectivity#connectivity-modes) for your implementation.

- Depending on where Azure Arc-enabled Kubernetes cluster is running, consider between [load balancer](https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/) or [node port type](https://kubernetes.io/docs/concepts/services-networking/service/#type-nodeport) to expose Azure Arc-enabled data services such as data controller and SQL Managed Instance. Load balancer allows to maintain same port number across multiple instances whereas node port requires different port number for each instance.

- Consider deploying software load balancer types such as [MetalLB](https://metallb.universe.tf/) to support Load balancer in on-premises Arc-enabled Kubernetes cluster to support load balancer type in SQL Managed Instance and other Arc-enabled services. This allows organizations to use their standard SQL server port such as 1433 or custom port rather than using random ports when using node ports.

- Consider using TLS ports such as 636 and 3269 vs non-TLS ports 389 and 3268 with [Active Directory Domain Services(ADDS)](/windows-server/identity/ad-ds/active-directory-domain-services) to keep connections secure when using [Active Directory(AD) authentication](/azure/azure-arc/data/active-directory-introduction) in Azure Arc-enabled SQL Managed Instance.

- When using Azure Key Vault to protect [Kubernetes secrets](/azure/aks/csi-secrets-store-driver) of Azure Arc-enabled SQL Managed Instance for AD authentication, consider using [Azure Key Vault private endpoints](/azure/key-vault/general/private-link-service?tabs=portal) to keep connections private.

- Consider between public vs private endpoints when using [Azure Storage Account archive blob](/azure/storage/blobs/archive-blob?tabs=azure-portal) to retain Azure Arc-enabled SQL Managed Instance database backup files for long term retention.

## Design recommendations

- Prefer Directly connected mode over Indirectly connected mode deployment of Azure Arc-enabled data services and Azure Arc-enabled SQL Managed Instance to gain the [feature benefits](/azure/azure-arc/data/connectivity#feature-availability-by-connectivity-mode) associated with Directly connected mode deployment.

- Prefer load balancer service type over node port service type for Azure Arc-enabled data services such as data controller, dashboards, and Azure Arc-enabled SQL Managed instances. Use internal load balancers over external when using public cloud for Azure Arc-enabled data services deployment. For on-premises deployment prefer containerized load balancer such as [MetalLB](https://metallb.universe.tf/#why) to support [load balancer service type](https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/). This simplifies firewall rules using standard SQL port 1433 and easy to remember rather than using random ports when using node port service type. Make sure to [allocate a subnet CIDR size](https://metallb.universe.tf/concepts/#address-allocation) to support number of Azure Arc-enabled SQL Managed Instances deployed on Azure Arc-enabled Kubernetes cluster.

- When using [AD authentication](/azure/azure-arc/data/active-directory-introduction) in Azure Arc-enabled SQL Managed Instance in both system-managed or customer-managed keytab modes, automate DNS registration for Azure Arc-enabled SQL Managed Instance endpoints to discover service using on-premises or other cloud DNS servers.

- Use firewall rules to restrict network access to Azure Arc-enabled SQL Managed Instance, data controller, and dashboards to prevent access from untrusted sources.

- When using Azure private endpoints for Microsoft Container Registry, Key Vault, Log Analytics, and Storage Accounts configure [on-premises DNS servers to forward DNS queries](/azure/private-link/private-endpoint-dns#on-premises-workloads-using-a-dns-forwarder) to DNS forwarder in Azure.

- As AD authentication in Azure Arc-enabled SQL Managed Instance requires connectivity to Windows domain controllers, make sure to have connectivity to domain controllers in primary and disaster recovery site for high availability. Many enterprises deploy site recovery forests across geographies, make sure to use nearest site to reduce network latency to domain controllers.

## Next steps

For more information about your hybrid and multicloud cloud journey, see the following articles:

- Review [Azure Arc-enabled data services connectivity modes and requirements](/azure/azure-arc/data/connectivity)
- Review [Active Directory authentication](/azure/azure-arc/data/active-directory-introduction)
- Review the [Network connectivity for Azure Arc-enabled Kubernetes](/azure/cloud-adoption-framework/scenarios/hybrid/arc-enabled-kubernetes/eslz-arc-kubernetes-network-connectivity)
