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

## Roadmap

We intend to update the content within this repo in alignment with Azure Semester planning.

| Milestone | Scope | Status |
|----------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------|
| Design Principles and Architecture Guidelines | North Star design principles and architecture guidelines for Azure. | Complete (January, 2020)|
| Automated build/test for code and deployment artefacts for community contribution | Validate and test deployment artefacts in test engineering tenant to ensure quality and end to end deployment. | Complete (March, 2020) |
| Contoso Scope and Design | Prescriptive first-party reference implementation for the North Star architecture guidelines. Real-world example of applying North Star design principles to make contextualised decisions across all 8 design areas and define their target state. | Complete (March, 2020) |
| Contoso Reference Implementation | End to end reference implementation to supplement Architecture and Design recommendations. | In-Progress (April, 2020) |
| Publish North Star Git Hub Action in Actions marketplace | This will allow to service discovery, deploy and operationalize codebase. | Planned (May, 2020) |
| Workload Specific Landing Zones for Contoso | WVD, SAP, HPC, Analytics <br/> (Seeking community Contribution) |  Planned |
| Hybrid Management for Contoso | Azure Arc | Planned |