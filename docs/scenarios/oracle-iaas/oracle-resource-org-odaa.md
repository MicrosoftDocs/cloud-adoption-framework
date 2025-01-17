---
title: Resource organization for Oracle Database@Azure
description: Learn about design considerations and recommendations for organizing resources in Oracle Database@Azure.
author: sihbher
ms.author: gereyeso
ms.reviewer: gereyeso
ms.date: 01/13/2025
ms.topic: conceptual
ms.custom: e2e-oracle
---

# Resource organization for Oracle Database@Azure

Oracle Database@Azure is an Oracle database service running on Oracle Cloud Infrastructure (OCI), co-located in Microsoft data centers. 

This article expands on considerations and recommendations defined in the [Azure landing zone design area](../../ready/landing-zone/design-area/resource-org.md), incorporating best practices for organizing resources to create consistent deployment patterns for Exadata Database Services on Oracle Database@Azure.

## Design considerations

### Naming and Tagging Conventions

When naming Oracle Database@Azure resources, refer to the [Azure general naming conventions](../../ready/azure-best-practices/naming-and-tagging.md) as a baseline. When defining conventions for Oracle Database@Azure, keep in mind:

- **Resource Constraints**: Some resource types, like VM Clusters, have specific naming constraints, such as character limits and allowed characters. You can review these details in the [overview of provisioning documentation](/azure/oracle/oracle-db/provision-oracle-database).

For more on naming conventions, see [Azure resource naming](../../ready/azure-best-practices/resource-naming.md) and [Develop your naming and tagging strategy for Azure resources](../../ready/azure-best-practices/naming-and-tagging.md).  
For tagging guidance on Azure, refer to [Use tags to organize your Azure resources](/azure/azure-resource-manager/management/tag-resources).

### Security and Isolation Best Practices

To enhance security and management in multi-subscription architectures, implement best practices for isolation as outlined in [Microsoft’s guidance on Securing Multi-Tenant Architectures](/entra/architecture/secure-best-practices). These practices include strategies for logical isolation, least privilege access, and network segmentation. These are particularly relevant for Oracle Database@Azure deployments involving multiple environments (e.g., Production, Development, Disaster Recovery).

### Subscription Design Considerations for Oracle Database@Azure

When designing the subscription setup for Oracle Database@Azure, keep the following in mind:

- **Primary Subscription**: During onboarding, you’ll select an initial Azure subscription, which will serve as the primary subscription for Oracle Database@Azure. This subscription forms the foundation for all Oracle Database@Azure deployments.
- **Secondary Subscriptions**: When expanding into secondary subscriptions, note that VM Clusters in these subscriptions will default to the same Availability Zone as selected in the primary subscription. Align application services with the Availability Zone of the VM Cluster to ensure performance, high availability, and redundancy.
- **Resource Groups**: Within each subscription, resources such as VM Clusters, VNets, and supporting infrastructure can be organized into different resource groups. This allows for logical separation and management of resources, enabling flexibility in how infrastructure components are deployed and maintained.

## Design recommendations

### Subscription Design Recommendations

Based on the subscription considerations, these are the recommended actions:

1. **Leverage Multi-Subscription Architecture**:  
   Design a subscription model where each environment (e.g., Production, Development, Testing, and Disaster Recovery) is isolated in its own Azure subscription. This approach provides clarity for cost tracking, security, and workload management.

2. **Monitor Billing Across Subscriptions**:  
   Regularly review costs using Azure’s Cost Management tools and ensure the billing account configuration matches across all subscriptions. While Azure’s Cost Management tools can provide insights into overall expenses, note that charges related to the Oracle Account resource in the primary subscription (with the private offer) are consolidated under that subscription. This means individual per-subscription billing is not currently itemized in Azure. For independent charges, refer to Oracle Cloud Infrastructure (OCI) for cost tracking and invoicing.

### Implementing a Multi-Subscription Setup for Oracle Database@Azure

Set up a multi-subscription architecture for Oracle Database@Azure, where various environments (Production, Development, Unit Testing, System Integration Testing, and Disaster Recovery) are managed across different Azure subscriptions within the same Tenant.

:::image type="content" source="media/multi-subscription-odaa.png" alt-text="Diagram illustrates a multi-subscription setup for Oracle Database@Azure." border="false" lightbox="media/multi-subscription-odaa.png":::

This diagram illustrates a multi-subscription setup for Oracle Database@Azure.

#### Key Points

- **Logical Availability Zones vs Physical Availability Zones**:  
  When designing an Oracle Database architecture on Azure that spans multiple subscriptions, account for the distinction between logical and physical Availability Zones to ensure proper alignment with database deployments. Logical zones (e.g., Zone 1, Zone 2, Zone 3) in one subscription may not correspond to the same physical zones in another subscription, which can lead to inconsistencies in application access patterns. For example, if you deploy an Oracle Database in Zone 1 of Subscription A and a related client application in Zone 1 of Subscription B, the application may experience unexpected latency if the zones map to physically distant locations. To prevent such issues, [review Azure documentation](/azure/reliability/availability-zones-overview?tabs=azure-cli#physical-and-logical-availability-zones) to understand the zone mappings for each subscription and ensure that applications and databases are deployed in zones with the intended geographical and network proximity. This alignment will help maintain predictable performance for client applications.

- **Exadata Infrastructure**:  
  Configure the [Exadata infrastructure to be shared across multiple environments](/azure/oracle/oracle-db/link-oracle-database-multiple-subscription#use-multiple-azure-subscriptions-with-oracle-databaseazure) (Production, Development, Unit Testing, SIT), illustrating a central infrastructure that serves different workloads and subscriptions specific to Oracle Database@Azure. This will isolate each environment within its own Azure subscription, providing a clear separation for security, networking, cost allocation, and management purposes tailored to Oracle Database@Azure deployments.


## Next steps

- Plan & design networking: [Network topology and connectivity for Oracle Database@Azure](/azure/cloud-adoption-framework/scenarios/oracle-iaas/oracle-network-topology-odaa)
- Enhance Security: Explore Microsoft’s [Secure Future Initiative (SFI)](https://www.microsoft.com/trust-center/security/secure-future-initiative) to implement robust security and compliance strategies for Oracle Database@Azure.
- Review Isolation Best Practices: Refer to Microsoft's [Securing Multi-Tenant Architectures](/entra/architecture/secure-multiple-tenants) to implement secure isolation strategies across Oracle Database@Azure environments.