---
title: Organize Oracle Database@Azure resources for consistent deployments
description: Establish consistent deployment patterns and optimize Azure subscriptions through effective Oracle Database@Azure resource organization strategies.
author: sihbher
ms.author: gereyeso
ms.reviewer: gereyeso
ms.date: 07/08/2025
ms.topic: conceptual
ms.custom: e2e-oracle, references_regions
---

# Organize Oracle Database@Azure resources for consistent deployments

This article provides guidance to organize Oracle Database@Azure resources across Azure subscriptions and establish consistent deployment patterns. Proper resource organization reduces operational complexity and improves security posture for Oracle database workloads.

Oracle Database@Azure is an Oracle database service that runs on Oracle Cloud Infrastructure (OCI) hardware colocated in Microsoft datacenters. You can deploy two types of Oracle Database@Azure services:

1. **Oracle Exadata Database@Azure**: Dedicated Exadata racks that you provision and operate inside your Azure subscriptions.
2. **Oracle Autonomous Database@Azure**: Fully managed, self-driving Autonomous Databases that run on shared Exadata infrastructure.

This article expands on considerations and recommendations described in the [Azure landing zone design area](../../ready/landing-zone/design-area/resource-org.md). These recommendations help you create consistent deployment patterns for Oracle Database@Azure services.


## Establish naming and tagging conventions

Consistent naming conventions reduce management complexity and enable teams to identify Oracle Database@Azure resources quickly. These conventions provide operational efficiency and support governance policies across your deployment. You must implement standardized naming patterns that accommodate both Azure requirements and Oracle-specific constraints. Here's how:

1. **Apply Azure baseline naming standards consistently.** The [Azure general naming conventions](../../ready/azure-best-practices/naming-and-tagging.md) establish patterns for resource identification and organization. These conventions work with Oracle Database@Azure resources but require adjustments for Oracle-specific limitations like character restrictions and length limits.

2. **Account for Oracle Database@Azure resource constraints.** VM clusters and database instances have specific naming requirements that differ from standard Azure resources. Oracle Autonomous Database@Azure instance names accept only letters and numbers, limit names to 30 characters maximum, and prohibit spaces or special characters.

3. **Create environment-specific naming patterns.** Use consistent patterns that identify the environment, application, and purpose of each Oracle Database@Azure instance. This standardization simplifies resource management and improves operational visibility across your deployment.

4. **Implement comprehensive tagging strategies.** Tags organize resources, track costs, and enforce governance policies across Oracle Database@Azure deployments. Apply tags for environment classification, cost center allocation, application ownership, and compliance requirements to maintain visibility and control.

### Apply naming conventions for Oracle Database@Azure

Oracle Database@Azure resources have specific naming constraints that require careful consideration. Virtual machine clusters have character limits and allowed character restrictions that differ from standard Azure resources. You must understand these constraints to create effective naming patterns. Use the [Azure general naming conventions](../../ready/azure-best-practices/naming-and-tagging.md) as your baseline and adapt them for Oracle Database@Azure requirements.

Oracle Autonomous Database@Azure instance names can contain only letters and numbers, have a maximum length of 30 characters, and cannot include spaces. Create a consistent naming pattern that clearly identifies the environment, application, and purpose of each Oracle Autonomous Database@Azure instance:

| Environment | Application Type | Azure Region | Example Name |
|-------------|------------------|--------------|--------------|
| Production | ERP applications | East US | adbeuserpprod |
| Disaster Recovery | HR applications | Canada Central | adbcachrdr |
| Quality Assurance | Business Intelligence | Australia East | adbaueabiqa |

For more information about character limits and allowed characters, see [Provision Oracle Database@Azure](/azure/oracle/oracle-db/provision-oracle-database).

### Naming and tagging conventions


When you name Oracle Database@Azure resources, use the [Azure general naming conventions](../../ready/azure-best-practices/naming-and-tagging.md) as a baseline. Consider the resource constraints when you define conventions for Oracle Database@Azure. Some resource types, like virtual machine (VM) clusters, have specific naming constraints, such as [character limits and allowed characters](/azure/oracle/oracle-db/provision-oracle-database). For more information, see:

- [Use tags to organize your Azure resources](/azure/azure-resource-manager/management/tag-resources)


**Oracle Autonomous Database@Azure–specific constraints:** Oracle Autonomous Database@Azure instance names can contain only letters and numbers, have a maximum length of 30 characters, and can't include spaces. Consider using a consistent naming pattern that clearly identifies the environment, application, and purpose of each Oracle Autonomous Database@Azure instance. For example:
- **adbeuserpprod:** An Autonomous Database (adb) in East US (eus) for ERP applications in production (prod).
- **adbcachrdr:** An Autonomous Database in Canada Central (cac) for HR applications in disaster recovery (dr).
- **adbaueabiqa:** An Autonomous Database in Australia East (auea) for Business Intelligence in quality assurance (qa). 


## Implement security and isolation best practices

Security isolation protects Oracle Database@Azure deployments from unauthorized access and reduces blast radius during incidents. Proper isolation strategies ensure that compromises in one environment don't affect others across your multiple subscription architecture.

You must implement comprehensive isolation measures that protect both Oracle Database@Azure resources and supporting Azure infrastructure. Here's how:

1. **Apply logical isolation between environments.** Each Oracle Database@Azure environment requires separate security boundaries to prevent cross-environment access and maintain compliance requirements. Use Azure subscriptions as primary isolation boundaries and implement role-based access control (RBAC) with environment-specific permissions to ensure development teams can't access production Oracle databases.

2. **Enforce least privilege access principles.** Oracle Database@Azure resources need restricted access that grants users only the minimum permissions necessary for their roles. Configure Azure Active Directory groups with environment-specific access to Oracle Database@Azure resources and regularly audit permissions to maintain security posture and compliance standards.

3. **Implement network segmentation strategies.** Network isolation protects Oracle Database@Azure traffic from unauthorized interception and lateral movement attacks. Use Azure Virtual Networks with dedicated subnets for Oracle Database@Azure resources, configure Network Security Groups (NSGs) with restrictive rules, and implement Azure Firewall or third-party network virtual appliances for advanced threat protection.

4. **Configure monitoring and alerting systems.** Security monitoring detects anomalous activity across Oracle Database@Azure deployments and enables rapid incident response. Deploy Azure Security Center for unified security management, configure Azure Sentinel for security information and event management (SIEM), and establish automated alerts for suspicious Oracle database access patterns or configuration changes.

For comprehensive guidance on isolation architectures, see [best practices for isolation architectures](/entra/architecture/secure-best-practices).


## Use multiple subscription architecture

Multiple subscription architectures provide environment isolation and improve security posture for Oracle Database@Azure deployments. Each environment operates within its own Azure subscription boundary to create clear separation for security, networking, cost allocation, and management purposes. This isolation prevents cross-environment access and reduces the impact radius during security incidents or operational issues. You must design a subscription model where each environment receives its own Azure subscription. Here's how:

1. **Create environment-specific subscriptions.** Establish separate Azure subscriptions for production, development, testing, and disaster recovery environments. This subscription isolation prevents cross-environment access and reduces the impact radius during security incidents or operational issues.

2. **Configure subscription billing alignment.** Ensure all subscriptions use the same billing account as the primary subscription to maintain consistent cost management and avoid billing complications across your Oracle Database@Azure deployment.

3. **Plan for workload isolation in production.** For mission-critical workloads that use Oracle Autonomous Database@Azure, create separate production subscriptions for each major application to minimize impact radius and simplify role-based access control management.

### Verify onboarding permissions

Azure identities need specific permissions to deploy and manage Oracle Database@Azure resources. You must validate that your identity can perform required actions before beginning the onboarding process. This verification prevents deployment failures and ensures smooth resource provisioning.

You need to confirm these permissions in your Azure subscription:

1. **Register required resource providers.** Oracle Database@Azure depends on specific Azure resource providers that must be registered before deployment. Register these providers in each subscription that will host Oracle Database@Azure resources:
   - Oracle.Database
   - Microsoft.BareMetal
   - Microsoft.Network
   - Microsoft.Compute

2. **Create Oracle Account resources.** The onboarding process creates an Oracle Account resource that establishes the connection between Azure and OCI. Your identity must have permissions to create and manage these account resources.

3. **Manage network infrastructure.** Oracle Database@Azure requires dedicated network resources including virtual networks, delegated subnets, route tables, and Network Security Groups. Your identity must have permissions to create and configure these networking components.

4. **Assign role-based access control permissions.** You must assign appropriate RBAC permissions to enable team members to access and manage Oracle Database@Azure resources according to their roles and responsibilities.

**Recommended role:** Owner (or Contributor combined with User Access Administrator) provides the necessary permissions for Oracle Database@Azure onboarding and management tasks.

For the complete permissions matrix organized by persona and task, see [Onboarding permissions](https://docs.oracle.com/en-us/iaas/Content/database-at-azure/oaaprerequisites.htm#oaaprereq_1_permissions__onboarding-permissions-table-title) in the Oracle documentation.

### Use multiple subscription architecture

Multiple subscription architectures provide environment isolation and improve security posture for Oracle Database@Azure deployments. Each environment operates within its own Azure subscription boundary, which creates clear separation for security, networking, cost allocation, and management purposes.

You need to design a subscription model where each environment receives its own Azure subscription:

1. **Create environment-specific subscriptions.** Establish separate Azure subscriptions for production, development, testing, and disaster recovery environments. This subscription isolation prevents cross-environment access and reduces blast radius during security incidents or operational issues.

2. **Configure subscription billing alignment.** Ensure all subscriptions use the same billing account as the primary subscription to maintain consistent cost management and avoid billing complications across your Oracle Database@Azure deployment.

3. **Plan for workload isolation in production.** For mission-critical workloads that use Oracle Autonomous Database@Azure, create separate production subscriptions for each major application. This approach minimizes blast radius and simplifies role-based access control management.

### Monitor billing across subscriptions

Cost tracking requires careful monitoring across multiple subscription architectures because Oracle Database@Azure billing consolidates under the primary subscription. You need to understand cost allocation patterns and use appropriate tools for comprehensive expense tracking.

Use Microsoft Cost Management tools to track overall Azure expenses across all subscriptions:

1. **Review costs regularly using Cost Management tools.** These tools provide insights into overall Azure expenses and can track resource usage patterns across your Oracle Database@Azure deployment.

2. **Understand billing consolidation.** Charges related to the Oracle account resource in the primary subscription consolidate under that subscription through the private offer. Individual per-subscription billing details are not itemized in Azure for Oracle Database@Azure resources.

3. **Track independent charges through OCI.** For detailed cost tracking and invoicing specific to Oracle Database@Azure usage, refer to OCI cost management tools and reports.

### Implement multiple subscription setup

Multiple subscription architectures support Oracle Database@Azure deployments across development, testing, production, and disaster recovery environments. This architecture provides environment isolation while maintaining operational efficiency through shared infrastructure components.

The following diagram illustrates a multiple subscription setup for Oracle Exadata Database@Azure:

:::image type="content" source="./media/multiple-subscription-oracle-database-azure.svg" alt-text="Diagram that shows Oracle Exadata Database@Azure deployed across multiple Azure subscriptions. The diagram illustrates how production, development, testing, and disaster recovery environments are isolated in separate subscriptions within the same Azure tenant, with shared Exadata infrastructure serving multiple environments." border="false" lightbox="./media/multiple-subscription-oracle-database-azure.svg":::

1. **Understand availability zone mappings.** Logical availability zones in different subscriptions do not correspond to the same physical availability zones. This mapping difference can create performance inconsistencies for applications that access Oracle databases across subscription boundaries.

   For example, deploying an Oracle database in zone 1 of subscription A and a related client application in zone 1 of subscription B can result in unexpected latency if these zones map to physically distant locations. Review [Azure availability zone documentation](/azure/reliability/availability-zones-overview?tabs=azure-cli#physical-and-logical-availability-zones) to understand zone mappings for each subscription and align applications with databases in zones that provide intended geographical and network proximity.

2. **Configure shared Exadata infrastructure.** Oracle Exadata Database@Azure infrastructure can be [shared across multiple environments](/azure/oracle/oracle-db/link-oracle-database-multiple-subscription#use-multiple-azure-subscriptions-with-oracle-databaseazure) including production, development, unit testing, and system integration testing. This shared infrastructure approach optimizes resource utilization while maintaining environment isolation through separate Azure subscriptions.

Consider these factors when you design the subscription setup for Oracle Database@Azure:

- **Primary subscription:** During onboarding, you choose an initial Azure subscription. This subscription serves as the primary subscription for Oracle Database@Azure and forms the foundation for all Oracle Database@Azure deployments.
  - **Onboarding permissions and resource providers:** See the Onboarding permissions table in the [Oracle documentation](https://docs.oracle.com/en-us/iaas/Content/database-at-azure/oaaprerequisites.htm#oaaprereq_1_permissions__onboarding-permissions-table-title) for the minimum Azure and OCI roles required.
  - **Resource registration:** Oracle Database@Azure operates on Azure as a bare metal service. Register these resource providers as documented in [Oracle prerequisites](https://docs.oracle.com/en-us/iaas/Content/database-at-azure/oaaprerequisites.htm) before you begin Oracle Database@Azure onboarding:
    - Oracle.Database
    - Microsoft.BareMetal/BareMetalConnections/read
    - Microsoft.BareMetal/BareMetalConnections/write
    - Microsoft.BareMetal/BareMetalConnections/delete

- **Secondary subscriptions:** When you expand into secondary subscriptions, Oracle Exadata Database@Azure VM clusters in these subscriptions default to the same availability zone that you chose in the primary subscription. Align application services with the availability zone of the VM cluster to ensure performance, high availability, and redundancy.

- **Resource groups:** Within each subscription, resources such as Oracle Exadata Database@Azure VM clusters, virtual networks, and supporting infrastructure can be organized into different resource groups. This setup allows for the logical separation and management of resources and enables flexibility in how infrastructure components are deployed and maintained.

## Azure resources

The following table lists Azure tools and resources that support Oracle Database@Azure resource organization recommendations:

| Category | Tool | Description |
|----------|------|-------------|
| Resource Organization | [Azure Resource Manager](/azure/azure-resource-manager/management/overview) | Provides deployment and management capabilities for Oracle Database@Azure resources across multiple subscriptions |
| Cost Management | [Microsoft Cost Management](/azure/cost-management-billing/costs/overview-cost-management) | Tracks expenses and usage patterns across Oracle Database@Azure deployments in multiple subscriptions |
| Identity and Access | [Microsoft Entra ID](/entra/fundamentals/whatis) | Manages user identities and access permissions for Oracle Database@Azure resources |
| Resource Tagging | [Azure Resource Tags](/azure/azure-resource-manager/management/tag-resources) | Organizes Oracle Database@Azure resources for cost allocation and governance |
| Security Monitoring | [Microsoft Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction) | Provides unified security management for Oracle Database@Azure resources |
| Network Security | [Azure Network Security Groups](/azure/virtual-network/network-security-groups-overview) | Controls network access to Oracle Database@Azure resources |
| Monitoring and Alerts | [Microsoft Sentinel](/azure/sentinel/overview) | Delivers security information and event management for Oracle Database@Azure deployments |

## Next steps

> [!div class="nextstepaction"]
> [Network topology and connectivity for Oracle Database@Azure](oracle-network-topology-odaa.md)

### Subscription design recommendations

The following recommendations are based on the subscription design considerations.

- **Permissions checklist:** Before you begin onboarding **Oracle Database@Azure**, make sure the identity you’ll use can perform the following actions.

   **Azure subscription**
     - Register the required resource providers.
     - Create an **Oracle Account** resource.
     - Create or manage VNets, delegated subnets, route tables and NSGs.
     - Assign RBAC permissions as needed.

     *Proposed role:* **Owner** (or **Contributor** + **User Access Administrator**).

  **For the complete persona-by-task policy matrix, refer to *Onboarding permissions* in the [documentation for Oracle](https://docs.oracle.com/en-us/iaas/Content/database-at-azure/oaaprerequisites.htm#oaaprereq_1_permissions__onboarding-permissions-table-title)**


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
