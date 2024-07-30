---
title: Business continuity and disaster recovery considerations for Oracle Database@Azure
description: Learn about business continuity and disaster recovery for Oracle Database@Azure.
author: jfaurskov
ms.author: janfaurs
ms.date: 07/30/2024
ms.topic: conceptual
ms.custom: 
  - think-tank
  - e2e-oracle
  - engagement-fy24
--- 


# Business continuity and disaster recovery considerations for Oracle Database@Azure

This article builds on considerations and recommendations defined in the [Azure landing zone design area for business continuity and disaster recovery (BCDR)](../../ready/landing-zone/design-area/management-business-continuity-disaster-recovery.md). 

The first step to building a resilient architecture for your workload environment is to determine the availability requirements for your solution. You need to identify the recovery time objective (RTO) and recovery point objective (RPO) for different levels of failure. RTO is the maximum amount of downtime that an application can tolerate being unavailable after an incident. RPO is the maximum amount of data loss that can be tolerated due to a disaster. After you determine the requirements for your solution, you can design your architecture to meet your RTO and RPO objectives. 

## Design considerations

- Oracle Exadata Database Service on Dedicated Infrastructure with Oracle Database@Azure is colocated in Azure datacenters and placed in one Azure availability zone. It's important to remember that availability zones are specific to a subscription. Availability zone 1 might not represent the same physical datacenter as availability zone 1 in another subscription. For more information, see [What are availability zones](/azure/reliability/availability-zones-overview?tabs=azure-cli#physical-and-logical-availability-zones). 
- The Oracle Database@Azure solution provides native Oracle technologies, such as Real Application Cluster (RAC) and Automated Data Guard, for high availability and disaster recovery.
- Automated Data Guard configuration for the first secondary is included in the solution. You must configure extra Data Guard replicas manually.
- For active-active environments, consider using [Oracle GoldenGate](https://www.oracle.com/integration/goldengate/) for real-time data integration and replication capabilities, which help to ensure high availability and data consistency across your systems. This tool supports a wide range of databases and platforms, allowing seamless data movement and transformation. By using Oracle GoldenGate, you can minimize downtime during migrations and upgrades, enhancing your disaster recovery strategies. Oracle GoldenGate isn't included in the solution and licensing costs might be incurred.
- The Oracle Database@Azure solution and core components are constrained to the subscription and region where the instance is created. The service isn't multi-zonal and doesn't span multiple regions. You can deploy new instances to either target availability zones or target regions to achieve multi-zonal or multi-regional resiliency.
- Oracle Database@Azure integrates automatic database backups by using redundant Oracle Cloud Infrastructure (OCI) Object Storage. The Oracle Database Autonomous Recovery Service provides protection for Oracle Databases deployed on Exadata.

## Design recommendations

### Cross-AZ BCDR

For high availability and disaster recovery protection from database, database cluster, or availability zone failure, use Oracle RAC on Oracle Database@Azure and a symmetric standby database located in another zone. This configuration can help you achieve data center resiliency for database services. 

Application services that are dependent on the database should be in the same availability zone as the database for best performance. If the application services are in a different subscription than the database services, you should apply the code found in [What are availability zones](/azure/reliability/availability-zones-overview?tabs=azure-cli#physical-and-logical-availability-zones). From the availabilityZoneMappings property, determine the physical availability zone where you should co-locate the services.

- You can configure Data Guard in Maximum Availability mode with SYNC transport or Max Performance mode with ASYNC transport depending on your application services and RPO requirements.
  -	Maximum Availability Mode (SYNC) is recommended for environments where data integrity and zero data loss are paramount.
  -	Maximum Performance Mode (ASYNC) is better suited for environments where performance is critical and some data loss can be tolerated.

### Cross-Region BCDR

- Configure Data Guard in Maximum Performance Mode for regional BCDR based on your application capabilities and network latency between regions. For more information on network latency, see [Azure Network Latency Test Results](/azure/networking/azure-network-latency).
- The combination of Cross-AZ and Cross-Region BCDR aligns with the "Gold" level of the [Oracle MAA Reference Architectures](https://docs.oracle.com/en/database/oracle/oracle-database/19/haiad/). The gold level architecture provides protection from a complete regional failure.
- Cross-AZ and Cross-Region BCDR recommendations are focused on resiliency for the Oracle Database@Azure service. You can help to ensure resilience for other application services by using Virtual Machine Scale Sets, Azure Site Recovery, Azure Front Door, or other features that enable application service availability across availability zones or regions.
- We recommend that you use managed backups and store backup data in OCI Object Storage. 

## Additional considerations

- Use infrastructure as code (IaC) to deploy the initial Oracle Database@Azure instance and virtual machine (VM) clusters. 
- Use IaC to deploy databases in the Oracle Cloud Infrastructure.
  - By using IaC, you can easily replicate the same deployment to a disaster recovery site and minimize the risk of human error.
- Test failover and switchback operations to help ensure that they work in a real disaster scenario. Automate failover and switchback operations as much as possible to minimize errors.

## Next steps

- [Identity and access management for Oracle Database@Azure](oracle-iam-odaa.md)
- [Security guidelines for Oracle Database@Azure](oracle-security-overview-odaa.md)
- [Network topology and connectivity for Oracle Database@Azure](oracle-network-topology-odaa.md)
