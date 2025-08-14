---
title: Organize Oracle Database@Azure Resources for Consistent Deployments
description: Establish consistent deployment patterns and optimize Azure subscriptions through effective Oracle Database@Azure resource organization strategies.
author: Rajani-Janaki-Ram
ms.author: gereyeso
ms.reviewer: pnp
ms.date: 08/12/2025
ms.topic: conceptual
ms.custom: e2e-oracle, references_regions
---

# Organize Oracle Database@Azure resources for consistent deployments

This article describe how to organize Oracle Database@Azure resources across Azure subscriptions and establish consistent deployment patterns. Proper resource organization reduces operational complexity and improves security posture for Oracle database workloads.

Oracle Database@Azure is an Oracle database service that runs on Oracle Cloud Infrastructure (OCI) hardware colocated in Microsoft datacenters. You can deploy two types of Oracle Database@Azure services:
- **Oracle Exadata Database@Azure:** Dedicated Exadata racks that you provision and operate inside your Azure subscriptions
- **Oracle Autonomous Database@Azure:** Fully managed, self-driving autonomous databases that run on shared Exadata infrastructure

This article expands on considerations and recommendations described in the [Azure landing zone design area](../../ready/landing-zone/design-area/resource-org.md). These recommendations help you create consistent deployment patterns for Oracle Database@Azure services.

## Establish naming and tagging conventions

Consistent naming conventions reduce management complexity and enable teams to identify Oracle Database@Azure resources quickly. These conventions provide operational efficiency and support governance policies across your deployment. To implement standardized naming patterns that accommodate both Azure requirements and Oracle-specific constraints, do the following steps:

- **Apply Azure baseline naming standards consistently.** The [Azure general naming conventions](../../ready/azure-best-practices/naming-and-tagging.md) establish patterns for resource identification and organization. These conventions work with Oracle Database@Azure resources but require adjustments for Oracle-specific limitations like character restrictions and length limits.

- **Account for Oracle Database@Azure resource constraints.** Virtual machine (VM) clusters and database instances have specific naming requirements that differ from standard Azure resources. Oracle Autonomous Database@Azure instance names accept only letters and numbers, limit names to 30 characters maximum, and prohibit spaces or special characters.

- **Create environment-specific naming patterns.** Use consistent patterns that identify the environment, application, and purpose of each Oracle Database@Azure instance. This standardization simplifies resource management and improves operational visibility across your deployment.

- **Implement comprehensive tagging strategies.** Tags organize resources, track costs, and enforce governance policies across Oracle Database@Azure deployments. Apply tags for environment classification, cost center allocation, application ownership, and compliance requirements to maintain visibility and control.

### Apply naming conventions for Oracle Database@Azure

Oracle Database@Azure resources have specific naming constraints that require careful consideration. VM clusters have character limits and allowed character restrictions that differ from standard Azure resources. You must understand these constraints to create effective naming patterns. Use the [Azure general naming conventions](../../ready/azure-best-practices/naming-and-tagging.md) as your baseline and adapt them for Oracle Database@Azure requirements.

Oracle Autonomous Database@Azure instance names can contain only letters and numbers, have a maximum length of 30 characters, and cannot include spaces. Create a consistent naming pattern that clearly identifies the environment, application, and purpose of each Oracle Autonomous Database@Azure instance.

| Environment | Application type | Azure region | Example name |
|-------------|------------------|--------------|--------------|
| Production | Enterprise Resource Planning (ERP) applications | East US | adbeuserpprod |
| Disaster recovery | Human Resources (HR) applications | Canada Central | adbcachrdr |
| Quality assurance | Business intelligence | Australia East | adbaueabiqa |

For more information about character limits and allowed characters, see [Provision Oracle Database@Azure](/azure/oracle/oracle-db/provision-oracle-database).

### Apply naming and tagging conventions

When you name Oracle Database@Azure resources, use the [Azure general naming conventions](../../ready/azure-best-practices/naming-and-tagging.md) as a baseline. Consider the resource constraints when you define conventions for Oracle Database@Azure. Some resource types, like VM clusters, have specific naming constraints, such as [character limits and allowed characters](/azure/oracle/oracle-db/provision-oracle-database). For more information, see [Use tags to organize your Azure resources](/azure/azure-resource-manager/management/tag-resources).

Oracle Autonomous Database@Azure has specific constraints. Instance names can contain only letters and numbers, have a maximum length of 30 characters, and can't include spaces. Consider using a consistent naming pattern that clearly identifies the environment, application, and purpose of each Oracle Autonomous Database@Azure instance. Here are some examples:

- **adbeuserpprod:** An autonomous database (adb) in East US (eus) for ERP applications in production (prod).
- **adbcachrdr:** An autonomous database (adb) in Canada Central (cac) for HR applications in disaster recovery (dr).
- **adbaueabiqa:** An autonomous database (adb) in Australia East (auea) for business intelligence in quality assurance (qa). 

## Implement security and isolation best practices

Security isolation protects Oracle Database@Azure deployments from unauthorized access and reduces the blast radius during incidents. Proper isolation strategies ensure that compromises in one environment don't affect other areas across your multiple subscription architecture.

To implement comprehensive isolation measures that protect both Oracle Database@Azure resources and supporting Azure infrastructure, apply the following practices:

- **Apply logical isolation between environments.** Each Oracle Database@Azure environment requires separate security boundaries to prevent cross-environment access and maintain compliance requirements. Use Azure subscriptions as primary isolation boundaries and implement Azure role-based access control (RBAC) with environment-specific permissions to ensure that development teams can't access production Oracle databases.

- **Enforce least privilege access principles.** Oracle Database@Azure resources need restricted access that grants users only the minimum permissions necessary for their roles.
  
  - Configure Microsoft Entra ID groups with environment-specific access to Oracle Database@Azure resources.
  - Audit permissions regularly to maintain security posture and compliance standards.

- **Implement network segmentation strategies.** Network isolation protects Oracle Database@Azure traffic from unauthorized interception and lateral movement attacks.
  
  - Use Azure virtual networks that have dedicated subnets for Oracle Database@Azure resources.
  - Configure network security groups (NSGs) by defining restrictive rules.
  - Implement Azure Firewall or non-Microsoft network virtual appliances for advanced threat protection.

- **Configure monitoring and alerting systems.** Security monitoring detects anomalous activity across Oracle Database@Azure deployments and enables rapid incident response.

  - Deploy Azure Security Center for unified security management.
  - Configure Microsoft Sentinel for security information and event management (SIEM).
  - Establish automated alerts for suspicious Oracle database access patterns or configuration changes.

For comprehensive guidance about isolation architectures, see [Best practices for isolation architectures](/entra/architecture/secure-best-practices).

## Use a multiple subscription architecture

Multiple subscription architectures provide environment isolation and improve security posture for Oracle Database@Azure deployments. Each environment operates within its own Azure subscription boundary to create clear separation for security, networking, cost allocation, and management purposes. This isolation prevents cross-environment access and reduces the impact radius during security incidents or operational problems.

Design a subscription model where each environment receives its own Azure subscription:

1. **Create environment-specific subscriptions.** Establish separate Azure subscriptions for production, development, testing, and disaster recovery environments. This subscription isolation prevents cross-environment access and reduces the impact radius during security incidents or operational problems.

2. **Configure subscription billing alignment.** Ensure that all subscriptions use the same billing account as the primary subscription to maintain consistent cost management and avoid billing complications across your Oracle Database@Azure deployment.

3. **Plan for workload isolation in production.** For mission-critical workloads that use Oracle Autonomous Database@Azure, create separate production subscriptions for each major application to minimize the impact radius and simplify RBAC management.

### Verify onboarding permissions

Azure identities need specific permissions to deploy and manage Oracle Database@Azure resources. You must validate that your identity can perform required actions before beginning the onboarding process. This verification prevents deployment failures and ensures smooth resource provisioning.

You need to confirm the following permissions in your Azure subscription:

- **Register required resource providers.** Oracle Database@Azure depends on specific Azure resource providers that you must register before deployment. Register the following providers in each subscription that hosts Oracle Database@Azure resources:

   - Oracle.Database
   - Microsoft.BareMetal
   - Microsoft.Network
   - Microsoft.Compute

- **Create Oracle account resources.** The onboarding process creates an Oracle account resource that establishes the connection between Azure and OCI. Your identity must have permissions to create and manage these account resources.

- **Manage network infrastructure.** Oracle Database@Azure requires dedicated network resources, including virtual networks, delegated subnets, route tables, and NSGs. Your identity must have permissions to create and configure these networking components.

- **Assign RBAC permissions.** You must assign appropriate RBAC permissions to enable team members to access and manage Oracle Database@Azure resources according to their roles and responsibilities.

**Recommended role:** The Owner role, or the Contributor role combined with the User Access Administrator role, provides the necessary permissions for Oracle Database@Azure onboarding and management tasks.

For the complete permissions matrix organized by persona and task, see [Onboarding permissions](https://docs.oracle.com/en-us/iaas/Content/database-at-azure/oaaprerequisites.htm#oaaprereq_1_permissions__onboarding-permissions-table-title).

### Monitor billing across subscriptions

Cost tracking requires careful monitoring across multiple subscription architectures because Oracle Database@Azure billing consolidates under the primary subscription. Understand cost allocation patterns and use appropriate tools for comprehensive expense tracking.

Use Microsoft Cost Management tools to track overall Azure expenses across all subscriptions:

1. **Review costs regularly using Cost Management tools.** These tools provide insights into overall Azure expenses and can track resource usage patterns across your Oracle Database@Azure deployment.

2. **Understand billing consolidation.** Charges related to the Oracle account resource in the primary subscription consolidate under that subscription through the private offer. Individual per-subscription billing details are not itemized in Azure for Oracle Database@Azure resources.

3. **Track independent charges through OCI.** For detailed cost tracking and invoicing specific to Oracle Database@Azure usage, refer to OCI cost management tools and reports.

### Implement a multiple subscription setup

Multiple subscription architectures support Oracle Database@Azure deployments across development, testing, production, and disaster recovery environments. This architecture provides environment isolation while maintaining operational efficiency through shared infrastructure components.

The following diagram illustrates a multiple subscription setup for Oracle Exadata Database@Azure.

:::image type="complex" source="./media/multiple-subscription-oracle-database-azure.svg" alt-text="Diagram that shows Oracle Exadata Database@Azure deployed across multiple Azure subscriptions." border="false" lightbox="./media/multiple-subscription-oracle-database-azure.svg":::
The diagram illustrates a multiple subscription architecture deployed across two Azure regions: US East and US West. The subscriptions are labeled production, development, unit, system integration testing (SIT), and disaster recovery (DR). Each subscription includes a set of components: an application layer, a virtual network subnet, a virtual machine cluster, and an ExaInfra infrastructure element. In the US East region, the ExaInfra component is shared between the development, unit, and SIT subscriptions, which indicates a consolidated infrastructure for nonproduction environments. In contrast, the production and DR subscriptions maintain isolated ExaInfra instances. The US West region hosts the DR subscription.
:::image-end:::

1. **Understand availability zone mappings.** Logical availability zones in different subscriptions don't correspond to the same physical availability zones. This mapping difference can create performance inconsistencies for applications that access Oracle databases across subscription boundaries.

   For example, deploying an Oracle database in zone 1 of subscription A and a related client application in zone 1 of subscription B can result in unexpected latency if these zones map to physically distant locations. Understand zone mappings for each subscription and align applications with databases in zones that provide intended geographical and network proximity. For more inforation, see [Physical and logical availability zones](/azure/reliability/availability-zones-overview#physical-and-logical-availability-zones).

2. **Configure shared Exadata infrastructure.** You can [share Oracle Exadata Database@Azure infrastructure across multiple environments](/azure/oracle/oracle-db/link-oracle-database-multiple-subscription#use-multiple-azure-subscriptions-with-oracle-databaseazure), including production, development, unit testing, and system integration testing. This shared infrastructure approach optimizes resource usage while maintaining environment isolation through separate Azure subscriptions.

Consider the following factors when you design the subscription setup for Oracle Database@Azure:

- **Primary subscription:** During onboarding, you choose an initial Azure subscription. This subscription serves as the primary subscription for Oracle Database@Azure and forms the foundation for all Oracle Database@Azure deployments.

  - **Onboarding permissions and resource providers:** See the [onboarding permissions table](https://docs.oracle.com/en-us/iaas/Content/database-at-azure/oaaprerequisites.htm#oaaprereq_1_permissions__onboarding-permissions-table-title) for the minimum Azure and OCI roles required.
  - **Resource registration:** Oracle Database@Azure operates on Azure as a bare metal service. [Register the following resource providers](https://docs.oracle.com/en-us/iaas/Content/database-at-azure/oaaprerequisites.htm#oaaprereq_4_register_resource_provider) before you begin Oracle Database@Azure onboarding:
 
    - Oracle.Database
    - Microsoft.BareMetal/BareMetalConnections/read
    - Microsoft.BareMetal/BareMetalConnections/write
    - Microsoft.BareMetal/BareMetalConnections/delete

- **Secondary subscriptions:** When you expand into secondary subscriptions, Oracle Exadata Database@Azure VM clusters in these subscriptions default to the same availability zone as the primary subscription. Align application services with the availability zone of the VM cluster to ensure performance, high availability, and redundancy.

- **Resource groups:** Within each subscription, you can organize resources such as Oracle Exadata Database@Azure VM clusters, virtual networks, and supporting infrastructure into different resource groups. This setup allows for the logical separation and management of resources and enables flexibility in how you deploy and maintain infrastructure components.

## Azure resources

The following table lists Azure tools and resources that support Oracle Database@Azure resource organization recommendations.

| Category | Tool | Description |
|----------|------|-------------|
| Resource organization | [Azure Resource Manager](/azure/azure-resource-manager/management/overview) | Provides deployment and management capabilities for Oracle Database@Azure resources across multiple subscriptions |
| Cost management | [Cost Management](/azure/cost-management-billing/costs/overview-cost-management) | Tracks expenses and usage patterns across Oracle Database@Azure deployments in multiple subscriptions |
| Identity and access | [Microsoft Entra ID](/entra/fundamentals/whatis) | Manages user identities and access permissions for Oracle Database@Azure resources |
| Resource Tagging | [Azure resource tags](/azure/azure-resource-manager/management/tag-resources) | Organizes Oracle Database@Azure resources for cost allocation and governance |
| Security monitoring | [Microsoft Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction) | Provides unified security management for Oracle Database@Azure resources |
| Network security | [Azure NSGs](/azure/virtual-network/network-security-groups-overview) | Controls network access to Oracle Database@Azure resources |
| Monitoring and alerts | [Microsoft Sentinel](/azure/sentinel/overview) | Delivers SIEM for Oracle Database@Azure deployments |

## Next step

> [!div class="nextstepaction"]
> [Network topology and connectivity for Oracle Database@Azure](oracle-network-topology-odaa.md)