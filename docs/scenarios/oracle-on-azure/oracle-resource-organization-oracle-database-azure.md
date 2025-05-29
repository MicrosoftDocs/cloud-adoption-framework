---
title: Resource Organization for Oracle Database@Azure
description: Learn about design considerations and recommendations for how to organize resources and optimize deployments in Oracle Database@Azure.
author: sihbher
ms.author: gereyeso
ms.reviewer: gereyeso
ms.date: 02/08/2025
ms.topic: conceptual
ms.custom: e2e-oracle, references_regions
---

# Resource organization for Oracle Database@Azure

Oracle Database@Azure is an Oracle database service that's colocated in Microsoft datacenters and runs on Oracle Cloud Infrastructure (OCI). This article provides guidance on resource organization for the following offerings:
1. **Oracle Exadata Database@Azure**: Dedicated Exadata racks that you provision and operate inside your Azure subscriptions.
2. **Oracle Autonomous Database@Azure:** Fully managed, self‑driving Autonomous Databases running on shared Exadata infrastructure.

This article expands on considerations and recommendations described in the [Azure landing zone design area](../../ready/landing-zone/design-area/resource-org.md). It incorporates best practices for organizing resources to create consistent deployment patterns for Oracle Database@Azure Services.

## Design considerations

### Naming and tagging conventions

When you name Oracle Database@Azure resources, use the [Azure general naming conventions](../../ready/azure-best-practices/naming-and-tagging.md) as a baseline. Consider the resource constraints when you define conventions for Oracle Database@Azure. Some resource types, like virtual machine (VM) clusters, have specific naming constraints, such as [character limits and allowed characters](/azure/oracle/oracle-db/provision-oracle-database). For more information, see:

- [Azure resource naming](../../ready/azure-best-practices/resource-naming.md)

- [Develop your naming and tagging strategy for Azure resources](../../ready/azure-best-practices/naming-and-tagging.md)

- [Use tags to organize your Azure resources](/azure/azure-resource-manager/management/tag-resources)

**Oracle Autonomous Database@Azure–specific constraints:** Oracle Autonomous Database@Azure instance names can contain only letters and numbers, have a maximum length of 30 characters, and can't include spaces. Consider using a consistent naming pattern that clearly identifies the environment, application, and purpose of each Oracle Autonomous Database@Azure instance. For example:
- **adbeuserpprod:** An Autonomous Database (adb) in East US (eus) for ERP applications in production (prod).
- **adbcachrdr:** An Autonomous Database in Canada Central (cac) for HR applications in disaster recovery (dr).
- **adbaueabiqa:** An Autonomous Database in Australia East (auea) for Business Intelligence in quality assurance (qa). 


### Security and isolation best practices

To enhance security and management in multiple subscription architectures, implement [best practices for isolation architectures](/entra/architecture/secure-best-practices). These practices include strategies for logical isolation, least privilege access, and network segmentation. These measures are relevant for Oracle Database@Azure deployments that include multiple environments, such as production, development, and disaster recovery (DR) environments.


### Subscription design considerations

Consider the following factors when you design the subscription setup for Oracle Exadata Database@Azure.

- **Primary subscription:** During onboarding, you choose an initial Azure subscription. This subscription serves as the primary subscription for Oracle Database@Azure and forms the foundation for all Oracle Database@Azure deployments.
  - **Onboarding permissions and resource providers:** See the Onboarding permissions table in the [Oracle documentation](https://docs.oracle.com/en-us/iaas/Content/database-at-azure/oaaprerequisites.htm#oaaprereq_1_permissions__onboarding-permissions-table-title) for the minimum Azure and OCI roles required.
  - **Resource registration:** Oracle Database@Azure run on Azure as a bare metal service. Resource providers should be registered before you begin Oracle Database@Azure onboarding. Make sure you registered this resource providers
    - Oracle.Database
    - Microsoft.BareMetal/BareMetalConnections/read
    - Microsoft.BareMetal/BareMetalConnections/write
    - Microsoft.BareMetal/BareMetalConnections/delete

- **Secondary subscriptions:** When you expand into secondary subscriptions, Oracle Exadata Database@Azure VM clusters in these subscriptions default to the same availability zone that you chose in the primary subscription. Align application services with the availability zone of the VM cluster to help ensure performance, high availability, and redundancy.

- **Resource groups:** Within each subscription, resources such as  Oracle Exadata Database@Azure VM clusters, virtual networks, and supporting infrastructure can be organized into different resource groups. This setup allows for the logical separation and management of resources. And it enables flexibility in how infrastructure components are deployed and maintained.

## Design recommendations

### Subscription design recommendations

The following recommendations are based on the subscription design considerations.

- **Permissions checklist:** Before you begin onboarding **Oracle Database@Azure**, make sure the identity you’ll use can perform the following actions.

  1. **Azure subscription**
     - Register the required resource providers.
     - Create an **Oracle Account** resource.
     - Create or manage VNets, delegated subnets, route tables and NSGs.
     - Assign RBAC permissions as needed.

     *Proposed role:* **Owner** (or **Contributor** + **User Access Administrator**).

  2. **OCI tenancy**
     - Accept / purchase the private offer.
     - Create Exadata infrastructure **or** Autonomous Database instances.
     - Create networking objects (VCNs, subnets, DRGs) that relate to Azure.

     *Proposed role:* **Tenancy Administrator** or a custom group that has the same privileges.

  **For the complete persona-by-task policy matrix, refer to *Onboarding permissions* in the [documentation for Oracle](https://docs.oracle.com/en-us/iaas/Content/database-at-azure/oaaprerequisites.htm#oaaprereq_1_permissions__onboarding-permissions-table-title)**


- **Resource registration:** Oracle Database@Azure runs on Azure as a bare metal service. Please ensure your register necessary resources as documented in [step 4 of this document](https://docs.oracle.com/en-us/iaas/Content/database-at-azure/oaaprerequisites.htm). 
  - Oracle.Database
  - Microsoft.BareMetal/BareMetalConnections/read
  - Microsoft.BareMetal/BareMetalConnections/write
  - Microsoft.BareMetal/BareMetalConnections/delete

- **Use a multiple subscription architecture:** Design a subscription model where each environment, such as production, development, testing, and DR, is isolated in its own Azure subscription. This approach provides insights into cost tracking, security, and workload management.

- **Monitor billing across subscriptions:** Regularly review costs by using Microsoft Cost Management tools and ensure that the billing account configuration matches across all subscriptions. Cost Management tools can provide insights into overall expenses, but charges related to the Oracle account resource in the primary subscription (with the private offer) are consolidated under that subscription. Therefore, individual per-subscription billing isn't itemized in Azure. For independent charges, refer to OCI for cost tracking and invoicing.

**Production workload isolation for Oracle Autonomous Database@Azure:** For mission‑critical workloads that run on Oracle Autonomous Database@Azure, consider separating each major application into its own production subscription to minimize blast radius and simplify role‑based access control (RBAC).

### Implement a multiple subscription setup

Establish a multiple subscription architecture for Oracle Database@Azure, where various environments, such as production, development, unit testing, system integration testing (SIT), and DR, are managed across different Azure subscriptions within the same tenant. The following diagram shows a multiple subscription setup for Oracle Exadata Database@Azure.



:::image type="content" source="./media/multiple-subscription-oracle-database-azure.svg" alt-text="Diagram that illustrates a multiple subscription setup for Oracle Database@Azure." border="false" lightbox="./media/multiple-subscription-oracle-database-azure.svg":::

#### Key points

- **Logical availability zones versus physical availability zones:** When you design an Oracle Database architecture on Azure that spans multiple subscriptions, consider the distinction between logical availability zones and physical availability zones to ensure proper alignment with database deployments. Logical zones in one subscription might not correspond to the same physical zones in another subscription. This discrepancy can result in inconsistencies in application access patterns.

  For example, if you deploy an Oracle database in zone 1 of subscription A and a related client application in zone 1 of subscription B, the application might experience unexpected latency if the zones map to physically distant locations. To prevent this latency, [review Azure documentation](/azure/reliability/availability-zones-overview?tabs=azure-cli#physical-and-logical-availability-zones) to understand the zone mappings for each subscription and ensure that applications and databases are deployed in zones with the intended geographical and network proximity. This alignment helps maintain predictable performance for client applications.

- **Oracle Exadata Database@Azure infrastructure:** Configure the [Exadata infrastructure to be shared across multiple environments](/azure/oracle/oracle-db/link-oracle-database-multiple-subscription#use-multiple-azure-subscriptions-with-oracle-databaseazure), such as production, development, unit testing, and SIT. This central infrastructure serves different workloads and subscriptions that are specific to Oracle Database@Azure. This setup isolates each environment within its own Azure subscription, which provides a clear separation for security, networking, cost allocation, and management purposes tailored to Oracle Database@Azure deployments.


## Next steps

- For more information about how to [manage resources in Oracle Database@Azure](/azure/oracle/oracle-db/oracle-database-manage-autonomous-database-resources)
- For more information about how to plan and design networking, see [Network topology and connectivity for Oracle Database@Azure](/azure/cloud-adoption-framework/scenarios/oracle-iaas/oracle-network-topology-odaa).
- For more information about how to enhance security, see [Secure Future Initiative](https://www.microsoft.com/trust-center/security/secure-future-initiative).
- For more information about isolation best practices, see [Resource isolation with multiple tenants](/entra/architecture/secure-multiple-tenants).
