## Navigation Menu

* [Overview](../README.md)
* [North Star Architecture](./NorthStar-Architecture.md)
  * [Design Principles](./Design-Principles.md)
  * [Design Guidelines](./Design-Guidelines.md)
    * [A - Enterprise Enrollment and Azure AD Tenants](./A-Enterprise-Enrollment-and-Azure-AD-Tenants.md)
    * [B - Identity and Access Management](./B-Identity-and-Access-Management.md)
    * [C - Management Group and Subscription Organization](./C-Management-Group-and-Subscription-Organization.md)
    * [D - Network Topology and Connectivity](./D-Network-Topology-and-Connectivity.md)
    * [E - Management and Monitoring](./E-Management-and-Monitoring.md)
    * [F - Business Continuity and Disaster Recovery](./F-Business-Continuity-and-Disaster-Recovery.md)
    * [G - Security, Governance and Compliance](./G-Security-Governance-and-Compliance.md)
    * [H - Platform Automation and DevOps](./H-Platform-Automation-and-DevOps.md)
  * [Implementation Guide](./Implementation-Guide.md)
* [Contoso Reference](./Contoso/Readme.md)
  * [Scope and Design](./Contoso/Scope.md)
  * [Implementation](./Contoso/Design.md)
* [Using reference implementation in your own environment](./Deploy/Readme.md)
  * [Getting started](./Deploy/Getting-Started.md)
    * [Prerequisites](./Deploy/Prerequisites.md)
    * [Validate prerequisites](./Deploy/Validate-prereqs.md)
  * [Configure your own environment](./Deploy/Using-Reference-Implementation.md)
    * [Configure GitHub](./Deploy/Configure-run-initialization.md)
    * [Provision Platform](./Deploy/Deploy-platform-infra.md)
    * [Create Landing Zones](./Deploy/Deploy-lz.md)
    * [Trigger deployments locally](./Deploy/Trigger-local-deployment.md)
  * [North Star template schema](./Deploy/NorthStar-schema.md)
    * [Generic North Star ARM template](./Deploy/NorthStar-template-schema.md)
    * [North Star ARM parameters file](./Deploy/NorthStar-parameters-schema.md)
  * [Known Issues](./Deploy/Known-Issues.md)    
* [How Do I Contribute?](./Northstar-Contribution.md)
* [FAQ](./Northstar-FAQ.md)
* [Roadmap](./Northstar-roadmap.md)

---

# Design Principles

The **North Star** architecture prescribed in this playbook is based on the design principles described in this section. These principles serve as a compass for subsequent design decisions across critical technical domains. Readers are strongly advised to familiarize themselves with these principles to better understand their impact and the trade-offs associated with non-adherence.

## Subscription Democratization

Subscriptions should be used as a unit of management and scale aligned with business needs and priorities, to support business areas and portfolio owners to accelerate application migrations and new application development. Subscriptions should be provided to business units to support the design and development/testing of new workloads and migration of workloads.

## Policy Driven Governance

Azure Policy should be used to provide the **guard-rails** and ensure the continued compliance of the customer platform and applications deployed onto it, whilst also providing application owners sufficient freedom and a secure unhindered path to cloud.

## Single Control and Management Plane

The "North Star" architecture should not consider any abstraction layers such as customer developed portals or tooling and should provide a consistent experience for both AppOps (centrally managed operation teams) and DevOps (dedicated application operation teams). Azure provides a unified and consistent control plane across all Azure resources and provisioning channels which should be used to establish a consistent set of policies and controls for governing the entire customer estate, subject to RBAC and policy driven controls.

## Application Centric and Archetype-Neutral

The "North Star" architecture should focus on application centric migrations and development rather than a pure infrastructure "lift and shift" migration (i.e. movement of virtual machines) and should not differentiate between old/new applications or IaaS/PaaS applications. Ultimately, it should provide the foundation for all application types to be deployed onto the customer Azure platform securely and safely.

## Azure Native Design and Roadmap Aligned

The **Enterprise Scale architecture** approach advocates the use of native platform services and capabilities whenever possible, which should be aligned with Azure platform roadmaps to ensure new capabilities are made available within customer environments. Azure platform roadmaps should help inform the migration strategy and **North Star** trajectory.

## Recommendations

-   Be prepared to trade off functionality as not everything will likely be required on day one.
-   Leverage preview services and take dependencies on service roadmaps in order to remove technical blockers.
