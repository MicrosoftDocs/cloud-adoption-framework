---
title: Network connectivity for Azure Arc-enabled SQL Managed Instance
description: Understand the design considerations and recommendations for network connectivity in Azure Arc-enabled SQL Managed Instance
author: welasco
ms.author: vsantana
ms.date: 09/26/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-hybrid, think-tank, ignite-2022
---

# Network connectivity for Azure Arc-enabled SQL Managed Instance

Azure Arc-enabled data services support two different connectivity modes. The [Directly connected and Indirectly connected](/azure/azure-arc/data/connectivity) modes deploy an Azure Arc-enabled SQL Managed Instance running on Azure Arc-enabled Kubernetes clusters with an Azure Arc control plane.

The Arc-enabled data services components are:

* Azure Arc Data Controller
* Azure Arc Active Directory Connector
* Azure Arc-enabled SQL Managed Instance

These components communicate with the Azure Arc endpoints, Active Directory domain controllers, and domain name system (DNS) servers that are running on-premises and in other cloud environments.

This article describes network architecture, design considerations, and design recommendations for connecting to the Azure control plane from on-premises or other cloud infrastructure. You learn how to manage and operate Arc-enabled data services and an Arc-enabled SQL Managed Instance running on Arc-enabled Kubernetes clusters in on-premises and other cloud environments.

## Architecture

The following diagram shows an Arc-enabled data services network architecture that supports directly connected and indirectly connected network modes.

:::image type="content" source="./media/arc-enabled-data-svc-sql-mi-network-connectivity-integrations.png" alt-text="A diagram showing Azure Arc-enabled data services network architecture." lightbox="./media/arc-enabled-data-svc-sql-mi-network-connectivity-integrations.png":::

The following scenario diagram shows an example of various consumer services securely accessing the Arc-enabled SQL Managed Instance.

:::image type="content" source="./media/arc-enabled-data-svc-sql-mi-secure-access-network.png" alt-text="A diagram showing Azure Arc-enabled data services secure access network architecture." lightbox="./media/arc-enabled-data-svc-sql-mi-secure-access-network.png":::

## Design considerations

* Review the [network topology and connectivity design area](../../../ready/enterprise-scale/network-topology-and-connectivity.md) of the Azure landing zones to align Arc-enabled data services network connectivity with your organization's adopted landing zone design.

* Review the [Network connectivity for Azure Arc-enabled Kubernetes](../arc-enabled-kubernetes/eslz-arc-kubernetes-network-connectivity.md) for understanding network architecture and recommendations to make right design decisions for deploying and operating Arc-enabled data services on Arc-enabled Kubernetes cluster. Arc-enabled data services use Azure Arc-enabled Kubernetes network connectivity for service deployment and operations.

* Review the [Arc-enabled data services feature availability by connectivity-mode](/azure/azure-arc/data/connectivity#feature-availability-by-connectivity-mode) and [network requirements](/azure/azure-arc/data/connectivity) for Azure Arc-enabled data services. Decide if directly connected mode or indirectly connected mode aligns best with your organization network security policies of on-premises network or other cloud providers.

* Directly Connected mode requires a direct connection to Azure and provides other benefits by nature of this connectivity. Consider the trade-offs needed to enable this [direct connection](/azure/azure-arc/data/connectivity#connectivity-modes) based on your organization security and compliance requirements.

* Depending on where the Arc-enabled Kubernetes cluster runs, consider using a [Kubernetes _LoadBalancer_](https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/) or [_NodePort_ type](https://kubernetes.io/docs/concepts/services-networking/service/#type-nodeport). These services expose Arc-enabled data services such as Data Controller and SQL Managed Instance. A load balancer maintains the same port number across multiple instances whereas node port requires different port numbers for each Arc-enabled SQL Managed Instance.

* For Arc-enabled SQL Managed Instance service, consider deploying software load balancer types such as [MetalLB](https://metallb.universe.tf/) in on-premises environments and internal load balancers in cloud-based environments. Load balancers provide consistent IP addresses and SQL server ports such as 1433 or custom port and load balances nodes in the Kubernetes cluster. Node IPs change in auto-scale clusters. They don't provide high availability when pods move from one Kubernetes worker node to another. Such as, during failover, upgrades, and maintenance of Kubernetes clusters, Data Controllers, and Arc-enabled SQL Managed Instance.

* Consider using Transport Layer Security (TLS) ports such as 636 and 3269 versus non-TLS ports 389 and 3268 with [Active Directory Domain Services](/windows-server/identity/ad-ds/active-directory-domain-services). TLS ports keep connections secure when using [AD authentication](/azure/azure-arc/data/active-directory-introduction) in an Azure Arc-enabled SQL Managed Instance.

* When you use Azure Key Vault to protect [Kubernetes secrets](/azure/aks/csi-secrets-store-driver) of the Arc-enabled SQL Managed Instance for AD authentication, consider using [Azure Key Vault private endpoints](/azure/key-vault/general/private-link-service?tabs=portal) to keep connections private. See [Azure Key Vault Secrets Provider extension](/azure/azure-arc/kubernetes/tutorial-akv-secrets-provider) to learn how to fetch secrets into Azure Arc-enabled Kubernetes clusters and for more details on using Azure Key Vault with Arc-enabled Kubernetes clusters.

* Evaluate public versus private endpoints when using [Azure Storage Account archive blob](/azure/storage/blobs/archive-blob?tabs=azure-portal) to retain Arc-enabled SQL Managed Instance database backup files for long-term retention.

## Design recommendations

* Review Azure [Arc-enabled Kubernetes networking design recommendations](../arc-enabled-kubernetes/eslz-arc-kubernetes-network-connectivity.md#design-recommendations) as Arc-enabled SQL Managed Instance deployed on an existing Arc-enabled Kubernetes cluster.

* Use Direct connectivity mode instead of Indirect connectivity mode deployment of your Arc-enabled data services and Arc-enabled SQL Managed Instance to gain the [feature benefits](/azure/azure-arc/data/connectivity#feature-availability-by-connectivity-mode) of directly connected mode deployment.

* Choose Kubernetes _LoadBalancer_ service type above the _NodePort_ service type for Arc-enabled data services such as data controller, dashboards, and Arc-enabled SQL Managed Instance. _LoadBalancer_ type provides resiliency across Kubernetes node failures, node restarts, and node removal during [upgrade and maintenance](./eslz-arc-data-service-sql-managed-instance-upgradeability-disciplines.md) of Kubernetes clusters.

* Use internal load balancers over external load balancers when using public cloud infrastructure for Arc-enabled data services deployment. The internal load balancer assigns private IP addresses from the virtual network and keeps database traffic private to the internal network.

* For on-premises deployment, use a containerized load balancer such as [MetalLB](https://metallb.universe.tf/#why) to support the [load balancer service type](https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/). A containerized load balancer simplifies firewall rules using standard SQL port 1433. It's easier to remember versus using random ports with the _NodePort_ service type. Be sure to [allocate a subnet CIDR size](https://metallb.universe.tf/concepts/#address-allocation) to support the number of Arc-enabled SQL Managed Instances deployed on the Azure Arc-enabled Kubernetes cluster.

* When using [AD authentication](/azure/azure-arc/data/active-directory-introduction) for your Arc-enabled SQL Managed Instance in both system-managed or customer-managed key tab modes, be sure to automate DNS registration for Arc-enabled SQL Managed Instance endpoints. Automation helps you discover services using on-premises or other cloud DNS servers. It also eliminates operations overhead and automatically updates IP addresses when they change or when you delete a service instance.

* Use firewall rules to restrict network access to Arc-enabled SQL Managed Instance, data controller, and dashboards endpoints to prevent access from untrusted sources. Firewall rules reduce the attack surface of the Arc-enabled SQL Managed Instance and prevent data exfiltration.

* When you use Azure private endpoints for Microsoft Artifact Registry (also known as Microsoft Container Registry or MCR), Azure Key Vault, Azure Log Analytics, and storage accounts, configure [on-premises DNS servers to forward DNS queries](/azure/private-link/private-endpoint-dns#on-premises-workloads-using-a-dns-forwarder) to DNS forwarder in Azure. This approach enables auto-discovery of these private endpoints using DNS names and eliminates the need to use host entries or DNS entry registration in on-premises DNS servers.

* AD authentication for Arc-enabled SQL Managed Instance requires a connection to Active Directory Domain Services. Set up connectivity to domain controllers in primary and disaster recovery sites for high availability. As many enterprises deploy site recovery forests across geographies, use the nearest site to reduce network latency to domain controllers. Review [Arc-enabled SQL Managed Instance business continuity and disaster recovery](./eslz-arc-data-service-sql-managed-instance-business-continuity-disaster-recovery.md) for more guidance.

## Next steps

For more information about your hybrid cloud and multicloud journey, see the following articles:

* Review [Azure Arc-enabled data services connectivity modes and requirements](/azure/azure-arc/data/connectivity).
* Review [Active Directory authentication](/azure/azure-arc/data/active-directory-introduction).
* Review the [Network connectivity for Azure Arc-enabled Kubernetes](../arc-enabled-kubernetes/eslz-arc-kubernetes-network-connectivity.md).
* Use Arc-enabled SQL Managed Instance automated scenarios with [Azure Arc Jumpstart](https://azurearcjumpstart.io/azure_arc_jumpstart/azure_arc_data/).
* Review the [Azure Arc learning path on Microsoft Learn](/learn/paths/manage-hybrid-infrastructure-with-azure-arc/).
