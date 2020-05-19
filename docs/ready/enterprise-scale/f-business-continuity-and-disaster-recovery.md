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

# F. Business Continuity and Disaster Recovery

### 1. Planning for BCDR

This section will help readers capture customer disaster recovery requirements to design suitable platform level capabilities that application workloads can subsequently consume to meet their specific RTO and RPO requirements.

***Design Considerations***

-   Application and data availability requirements and the use of active-active and active-passive availability patterns i.e. workload RTO and RPO requirements.

-   BCDR for PaaS services and the availability of native DR and HA features.

-   Support for multi-region deployments for failover purposes.

    -   Component proximity for performance reasons.

-   Application operations with reduced functionality or degraded performance in the presence of an outage.

-   Workload suitability for Availability Zones or Availability Sets.

    -   Data sharing and dependencies between zones.

    -   Impact of Availability Zones on update domains compared to Availability Sets; percentage of workload that can be simultaneously under maintenance.

    -   Support for specific VM SKUs with Availability Zones.

    -   If Ultra-Disks are used, usage of Availability Zones is mandatory.

-   Consistent backups for applications and its data.

    -   VM snapshots and the use of Azure Backup and Recovery Service Vaults.

    -   Subscription limits restricting the number of Recovery Service Vaults and the size of each vault.

    -   Geo-replication and disaster recovery capabilities for PaaS services.

-   Network connectivity in the case of a failover.

    -   Bandwidth capacity planning for ExpressRoute.

    -   Paired failover regions.

    -   Traffic routing in the case of a region/zone/network outage.

-   Planned and unplanned failovers.

    -   IP address consistency requirements and the potential need to maintain IP addresses after failover and failback.

    -   Maintained engineering DevOps capabilities.

-   Key Vault DR for application keys, certificates, and secrets.

***Design Recommendations***

-   Employ Azure Site Recovery for Azure to Azure Virtual Machine DR scenarios to replicate workloads across regions.

    -   ASR provides built-in platform capabilities for VM workloads to meet low RPO/RTO requirements through real-time replication and recovery automation. Additionally, the service provides the ability to run recovery drills without affecting the workloads in production.

-   Utilize native PaaS service DR capabilities.

    -   The built-in features provide an easy solution to the complex task of building replication and failover into a workload architecture, simplifying both design and deployment automation. An organization that has defined a standard for the services they use can also audit and enforce the service configuration through Azure Policy.

-   Leverage Azure native backup capabilities.

    -   Azure Backup, and PaaS native backup features, remove the need for managing third party backup software and infrastructure. As with other native features, backup configurations can be set, audited, and enforced with Azure Policy, ensuring services remain compliant with organizational requirements.

-   Use multiple regions and peering locations for ExpressRoute connectivity.

    -   A redundant hybrid network architecture can help ensure uninterrupted cross-premises connectivity in the event of an outage affecting an Azure region or peering provider location.

-   Refer to [Azure Region Pairs](https://docs.microsoft.com/en-us/azure/best-practices-availability-paired-regions) documentation when selecting locations for your organizations DR layouts.

-   Use Azure paired regions when planning for BCDR.

  -   Planned Azure system updates are rolled out to paired regions sequentially (not at the same time) to minimize downtime, the effect of bugs, and logical failures in the rare event of a bad update.

  -   In the event of a broad outage, recovery of one region is prioritized out of every pair. Applications that are deployed across paired regions are guaranteed to have one of the regions recovered with priority. If an application is deployed across regions that are not paired, recovery might delayed in the worst case the chosen region may be the last two to be recovered.


<!-- -->

-   Avoid using overlapping IP address ranges for Production and DR sites.
  
    -   Whenever possible, plan for a BCDR network architect that provides for concurrent connectivity to all sites. DR networks that utilize the same CIDR blocks as production networks will require a network failover process that can complicate and delay application failover in the event of an outage.
