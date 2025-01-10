# Oracle Database@Azure - Exadata Database Service migration connectivity design

Preparing for a successful Oracle Database@Azure - Exadata Database Service migration often involves establishing secure, high-bandwidth connectivity between your current source environment and Azure. This document outlines foundational networking connectivity strategies for migration. For comprehensive migration steps and methodologies, refer to the [Migration Documentation](./oracle-migration-planning.md).

The following architecture diagram describes the connectivity between Oracle Database@Azure - Exadata Database Service and an on-premises or other source site:

![Connectivity to Oracle Database@Azure - Exadata Database Service from on-premise or other sources](./media/on-prem-connectivity.png)

Figure 1: Connectivity to Oracle Database@Azure - Exadata Database Service from on-premise or other sources

NOTE: Due to a current limitation on connectivity from Oracle Database@Azure - Exadata Database Service to Private Endpoints, the above connectivity to a Private Endpoint requires an intermediate hop through a routing device such as an NVA. This can be a Hub NVA such as an Azure Firewall or 3rd Party NVA/Firewall or, for non-production environments, a dedicated VM used for IP forwarding, such as in this [blog post](https://techcommunity.microsoft.com/blog/fasttrackforazureblog/creating-a-local-network-virtual-appliance-in-azure-for-oracle-databaseazure/4218101).

The following diagram includes Azure Netapp Files and does not require an intermediate hop for connectivity.

![Connectivity to other sources and Azure NetApp Files](./media/migration-anf.png)

Figure 2: Connectivity to other sources and Azure NetApp Files

Design Considerations

- **High Throughput Requirements:** Migrations often involve large data transfers. Ensure network paths support sustained high throughput.
- **Connectivity Options:** Both ExpressRoute and VPN tunnels can be used to connect on-premises environments to Oracle Database@Azure - Exadata Database Service. ExpressRoute provides more predictable performance and lower latency.
- **Shared Connectivity Impact:** If the same ExpressRoute or VPN connection is used by other services, ensure that increased migration traffic does not negatively impact their performance.

Design Recommendations

- **Prefer ExpressRoute Over VPN:** For on-premises to Oracle Database@Azure - Exadata Database Service connectivity, ExpressRoute is recommended due to its dedicated bandwidth, predictable performance, and lower latency.
- **Capacity Planning:** Confirm that your chosen ExpressRoute circuit has sufficient bandwidth headroom for the migration phase. Ensure this does not affect other workloads and if necessary, utilize bandwidth limiting.

Next Steps

With your network connectivity planned and established, proceed to the [Migration Documentation](./oracle-migration-planning.md) to begin or refine your migration strategy.
