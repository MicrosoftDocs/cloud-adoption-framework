---
title: Business continuity and disaster recovery (BCDR) for Oracle Database@Azure
description: Learn about continuity and disaster recovery (BCDR) for Oracle Database@Azure.
author: jfaurskov
ms.author: janfaurs
ms.date: 05/10/2024
ms.topic: conceptual
ms.custom: 
  - think-tank
  - e2e-oracle
  - engagement-fy24
--- 


# Business continuity and disaster recovery (BCDR) for Oracle Database@Azure

This article builds on the considerations and recommendations that are defined in the [Azure landing zone design area for BCDR](../../ready/landing-zone/design-area/management-business-continuity-disaster-recovery.md). 


The first step to building a resilient architecture for your workload environment is to determine availability requirements for your solution. You need to identify the recovery time objective (RTO) and recovery point objective (RPO) for different levels of failure. RTO is the maximum amount of downtime that an application can tolerate being unavailable after an incident. RPO is the maximum amount of data loss that can be tolerated due to a disaster. After you determine the requirements for your solution, the next step is to design your architecture to meet your RTO and RPO objectives. 

## Design Considerations

- Oracle Exadata Database Service on Dedicated Infrastructure with Oracle Database@Azure is colocated in Azure datacenters and placed in one single Azure availability zone. In light of this, it's important to remember that availability zones are specific to a subscription, that is, availability zone 1 isn't necessarily the same physical datacenter in one subscription as availability zone 1 in another. This is described in more detail in [What are availability zones](/azure/reliability/availability-zones-overview?tabs=azure-cli#physical-and-logical-availability-zones). You need to consider Cross-AZs (same region) and Cross-Regions BCDR sections in this article.
- The Oracle Database@Azure solution, out-of-the-box, provides native Oracle technologies for high availability and disaster recovery, such as Real Application Cluster (RAC) and Data Guard.
- Automated Data Guard configuration is included in the solution. Be mindful though that only a single secondary can be configured in this way. For more Data Guard replicas, you need to configure it manually.
- For active-active requirements you should consider using [Oracle GoldenGate](https://www.oracle.com/integration/goldengate/) due to its real-time data integration and replication capabilities, which ensure high availability and data consistency across your systems. This tool supports a wide range of databases and platforms, allowing seamless data movement and transformation. By leveraging Oracle GoldenGate, you can minimize downtime during migrations and upgrades, enhancing your disaster recovery strategies. Oracle Golden Gate isn't included in the solution and license costs might be incurred.
- The Oracle Database@Azure solution and core components are constrained to the subscription and region where the instance is created. The service isn't multi-zonal and doesn't span multiple regions. For zonal or multi-region resiliency you'll therefore need to deploy new instances to either target availability zones or target regions.
- Oracle Database@Azure integrates automatic database backups to redundant OCI Object Storage. Oracle’s Autonomous Recovery Service is available and provides protection for Oracle Databases deployed on Exadata.


## Design Recommendations

### Cross-AZs, same region

For high availability and disaster recovery protection from database, database cluster, or availability zone (AZ) failure, use Oracle RAC on Oracle Database@Azure and a symmetric standby database located in another AZ. This configuration enables you to achieve data center resiliency for database services. 

Application services dependent on the database should be in the same availability zone as the database services for best performance. This is relevant if the application services are in a different subscription than the database services. If that is the case, you should apply the code found in [What are availability zones](/azure/reliability/availability-zones-overview?tabs=azure-cli#physical-and-logical-availability-zones). From the availabilityZoneMappings property, determine the physical availability zone where you should co-locate the services.


- When configuring Data Guard for comprehensive production database protection, you can configure Data Guard in Maximum Availability mode with SYNC transport or Max Performance mode with ASYNC transport depending on application and RPO requirements. In terms of choosing between the two modes:
  -	Maximum Availability Mode (SYNC) is recommended for environments where data integrity and zero data loss are paramount.
  -	Maximum Performance Mode (ASYNC) is better suited for environments where performance is critical and some data loss can be tolerated.


### Cross-Regions BCDR


  - For regional disaster recovery, based on your application capabilities, and depending on the network latency between regions, you should configure Data Guard with maximum performance mode. For more information on network latency between regions, see [Azure Network Latency Test Results](/azure/networking/azure-network-latency).
  - The combination of Cross-AZs and Cross-Region BCDR aligns with the "Gold" level of the [Oracle MAA Reference Architectures](https://docs.oracle.com/en/database/oracle/oracle-database/19/haiad/). This provides protection from a complete regional failure. 
Cross-AZs and Cross-Region BCDR recommendations are focused on resiliency for the Oracle Database@Azure service. Resiliency for application services should be ensured through other means such as Virtual Machine Scale Sets, Azure Site Recovery, Azure Front Door, or other features that enable application service availability across availability zones or regions.

For backup of databases, use managed backups and store backup data in OCI Object Storage. 



## Additional Considerations

- Use Infrastructure-as-Code to deploy the initial Oracle Database@Azure instance and VM Clusters. This enables you to easily replicate the same deployment to a disaster recovery site and minimize the risk of human errors.
- Use Infrastructure-as-Code to deploy databases in Oracle Cloud Infrastructure. This enables you to easily replicate the same deployment and minimizes the risk of human errors.
- Test failover and switchback operations to ensure that you can execute them in a real disaster scenario. Automate failover and switchback operations as much as possible to minimize the risk of human errors.

## Next steps
- [Identity and access management for Oracle Database@Azure](oracle-iam-odaa.md)
- [Security guidelines for Oracle Database@Azure](oracle-security-overview-odaa.md)
- [Network topology and connectivity for Oracle Database@Azure](oracle-network-topology-odaa.md)