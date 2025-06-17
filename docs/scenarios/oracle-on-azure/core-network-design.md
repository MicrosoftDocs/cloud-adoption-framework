---
title: Network Topology and Connectivity for Oracle Database@Azure - Core Network Design
description: Learn about Oracle Database@Azure core network concepts, key design considerations, and effective implementation practices for seamless integration.
author: moisesjgomez
ms.author: mgomezcortez
ms.date: 02/08/2025
ms.topic: conceptual
ms.custom: e2e-oracle
---

# Network topology and connectivity for Oracle Database@Azure - Core network design

Understanding the core networking concepts of Oracle Exadata Database@Azure is foundational for successful adoption. Unlike most Azure services, Oracle Database@Azure has a unique architecture. It's hosted within an Azure datacenter and provides default connectivity to the Oracle Cloud Infrastructure (OCI) control plane. This article covers key design considerations and recommendations for how to configure and manage network connectivity to support Oracle Exadata Database@Azure workloads effectively.

The following diagram illustrates the core networking architecture and relationship between Azure virtual networks and OCI virtual cloud networks (VCNs) for Oracle Exadata Database@Azure.

:::image type="content" source="./media/basic-virtual-network-integration.svg" alt-text="Diagram that shows the core network design." border="false" lightbox="./media/basic-virtual-network-integration.svg":::

The client subnet in the OCI VCN maps to the Oracle Database delegated subnet in Azure. A backup subnet is also created within the OCI VCN that's used solely for OCI-managed backups.

## Design considerations

When you design your network topology for Oracle Exadata Database@Azure, consider the following factors:

- **Inherited region and availability zone settings:** When you deploy an Exadata Infrastructure instance, the region and availability zones are mapped to it, and any virtual machine (VM) clusters created within the Exadata Infrastructure instance inherit the same settings.

- **VM cluster limits:** Each Oracle Exadata Database@Azure SKU can include up to [eight VM clusters](https://docs.oracle.com/iaas/exadatacloud/doc/exa-service-desc.html#ECSCM-GUID-B0820870-D946-4879-85BF-C95FF25979CF). Ensure that your virtual network is configured before VM cluster creation, and decide whether to connect clusters to the same virtual network or separate virtual networks.

- **Scheduled patching:** Scheduled patching for Oracle Exadata Database@Azure is delivered through the OCI control plane and doesn't require direct internet access. This method reduces the need for outbound connectivity in typical maintenance scenarios.

- **Internet access requirements:** Oracle Exadata Database@Azure has no direct internet access by default. If internet access is required for one-off patching, outbound telemetry, or downloading packages, it must be explicitly configured.

- **Subnet sizing:** Define subnet sizes according to Oracle's SKU specifications, which differ based on the chosen instance type. For more information about sizing guidelines, see [Plan for IP address space for Oracle Exadata Database@Azure](/azure/oracle/oracle-db/oracle-database-plan-ip).

- **NSG configuration options:** Network security groups (NSGs) can be applied from either Azure or OCI. If you prefer to manage network security policies in Azure, consider allowing all traffic from OCI-side NSGs and enforcing restrictions by using NSGs on the Azure-delegated subnet.

- **Delegated subnet limitation:** You can create only one Oracle Database@Azure delegated subnet for each virtual network. This constraint influences how you plan your virtual network layout, especially if you anticipate multiple database deployments across availability zones or regions. For more information, see [Network planning for Oracle Database@Azure](/azure/oracle/oracle-db/oracle-database-network-plan). Also, you can create up to five Oracle-delegated subnets in a region. If you need more subnets, submit a support ticket with Oracle to increase the limit.

- **Split Domain Name System (DNS) model:** Oracle Database@Azure follows a split DNS model. DNS must be configured on both Azure and OCI. For more information, see [Oracle Database@Azure DNS setup](https://techcommunity.microsoft.com/blog/fasttrackforazureblog/oracle-databaseazure-dns-setup/4304513).

- **Private DNS zone naming rules:** When default DNS settings are used to create VM clusters, the private DNS zone is automatically named based on the virtual network and subnet that you choose for the VM cluster. The name of this zone is "oci" plus the first 10 alphabetic characters of the virtual network and subnet names. For example, if the virtual network is "vnet-exadata-prod" and the subnet is "snet-exadata-prod", the private DNS zone name is *ocisnetexadat.ocivnetexadat.oraclevcn.com*.

## Design recommendations

- **Plan virtual network configuration:** Ensure that your virtual network is configured before you create your VM cluster and determine the workload topology based on the documentation across application, business continuity and disaster recovery (BCDR), and migration connectivity.

- **Minimize network virtual appliances (NVAs):** Minimize the use of NVAs in the network path because each extra hop introduces latency that can degrade database performance. Use NVAs only when required, such as for traffic inspection or compliance purposes, and ensure that their placement is optimized to reduce unnecessary routing.

- **Optimize for bandwidth and latency:** Optimize bandwidth and latency by colocating resources that interact with Oracle Database@Azure – Exadata Database Service within the same availability zone.

- **Configure NSGs:** Configure the OCI-side NSG to allow all traffic, and enforce access control by applying an NSG to the delegated subnet in Azure. Use least-privilege rules to explicitly allow required traffic from approved sources and deny all other inbound access.

- **Use unique DNS names:** When you use the default DNS settings, ensure that the first 10 characters of the virtual network and subnet names for any Exadata environments are unique. If not, a DNS resolver can't distinguish between the environments.

### Other guidance

Beyond the core network design concepts for Oracle Exadata Database@Azure, also consider the connectivity requirements for your applications, other Azure services (like Azure Blob Storage or Azure NetApp Files), on-premises environments, and your BCDR configuration.

## Next step

Proceed to the [application connectivity design](application-connectivity-design.md) guidance to learn how to connect your applications to Oracle Exadata Database@Azure efficiently and securely.
