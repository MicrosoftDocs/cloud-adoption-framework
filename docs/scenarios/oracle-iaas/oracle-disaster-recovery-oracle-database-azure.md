---
title: Business continuity and disaster recovery considerations for Oracle Database@Azure
description: Learn about business continuity and disaster recovery (BCDR) for Oracle Database@Azure and how to build a resilient architecture for your workload environment.
author: gkayali
ms.author: guherk
ms.date: 11/21/2024
ms.topic: conceptual
ms.custom: e2e-oracle
--- 

# Business continuity and disaster recovery considerations for Oracle Database@Azure

This article expands on considerations and recommendations that are defined in the [Azure landing zone design area for business continuity and disaster recovery (BCDR)](../../ready/landing-zone/design-area/management-business-continuity-disaster-recovery.md).

The first step to building a resilient architecture for your workload environment is to identify the availability requirements for your solution. You need to determine the recovery time objective (RTO) and recovery point objective (RPO) for different levels of failure. The RTO defines the maximum downtime that an application can tolerate after an incident. The RPO specifies the maximum data loss that an application can tolerate because of a disaster. After you determine your solution’s requirements, you can design your architecture to meet your RTO and RPO.

## Design considerations

- Colocate Oracle Exadata Database Service on Dedicated Infrastructure with Oracle Database@Azure in Azure datacenters and place the datacenters in one Azure availability zone. Availability zones are specific to a subscription. For example, availability zone 1 in a subscription might not represent the same physical datacenter as availability zone 1 in a different subscription. For more information, see [What are availability zones](/azure/reliability/availability-zones-overview#physical-and-logical-availability-zones).

- The Oracle Database@Azure solution provides native Oracle technologies, such as Real Application Clusters (RAC) and automated Data Guard, for high availability and DR.

- The solution includes an automated Data Guard configuration for the initial standby database, also known as the _first secondary_. You must manually configure any extra Data Guard replicas.

- For active-active environments, consider using [Oracle GoldenGate](https://www.oracle.com/integration/goldengate/) for real-time data integration and replication capabilities. This approach helps ensure high availability and data consistency across your systems. This tool supports a wide range of databases and platforms so that you can seamlessly move and transform data. Use Oracle GoldenGate to minimize downtime during migrations and upgrades, which enhances your DR strategies. Oracle GoldenGate isn't included in the solution, so you might incur licensing costs.

- The Oracle Database@Azure solution and its core components are limited to the subscription and region in which you create the instance. The service isn't multi-zonal and doesn't span multiple regions. To achieve multi-zonal or multi-regional resiliency, you can deploy new instances to target availability zones or target regions.

- Oracle Database@Azure uses redundant Oracle Cloud Infrastructure (OCI) Object Storage to integrate automatic database backups. Oracle Database Autonomous Recovery Service provides protection for Oracle databases that you deploy on Exadata.

## Design recommendations

Consider these BCDR considerations for Oracle Database@Azure.

### Cross-availability zone BCDR

To ensure high availability and DR protection against failures of databases, database clusters, or availability zones, use Oracle RAC on Oracle Database@Azure and a symmetric standby database that's located in another zone. This configuration can help you achieve datacenter resiliency for database services.

For optimal performance, place application services that are dependent on the database in the same availability zone as the database. If the application services are in a different subscription than the database services, you should apply the [appropriate code](/azure/reliability/availability-zones-overview#physical-and-logical-availability-zones). Use the `availabilityZoneMappings` property to identify the physical availability zone where you should colocate your services.

- You can configure Data Guard in Maximum Availability mode with SYNC transport or Max Performance mode with ASYNC transport according to your application services and RPO requirements.

  - We recommend that you use Maximum Availability mode (SYNC) for environments where data integrity and zero data loss are the most important factors.

  - We recommend that you use Maximum Performance mode (ASYNC) for environments where performance is critical, and the environment can tolerate some data loss.

### Cross-region BCDR

- Configure Data Guard in Maximum Performance mode for regional BCDR based on your application capabilities and network latency between regions. For more information, see [Azure network latency test results](/azure/networking/azure-network-latency).

- The combination of cross-availability zone and cross-region BCDR operations aligns with the _Gold_ level of the [Oracle Maximum Availability Architecture reference architectures](https://docs.oracle.com/en/database/oracle/oracle-database/19/haiad/). The Gold level architecture provides protection from a complete regional failure.

- Cross-availability zone and cross-region BCDR recommendations focus on resiliency for the Oracle Database@Azure service. To help ensure resiliency for your application services, you can use Azure Virtual Machine Scale Sets, Azure Site Recovery, Azure Front Door, or other features or services that enable application service availability across availability zones or regions.

- We recommend that you use managed backups and store backup data in OCI Object Storage.

## Other considerations

- Use infrastructure as code (IaC) to deploy the initial Oracle Database@Azure instance and virtual machine clusters.

- Use IaC to deploy databases in OCI. You can use IaC to replicate the same deployment to a DR site and minimize the risk of human error.
  
- Use test failover and switchback operations to help ensure that they work in a real disaster scenario. Automate failover and switchback operations when possible to minimize errors.

## Next steps

- [Identity and access management for Oracle Database@Azure](oracle-iam-odaa.md)
- [Security guidelines for Oracle Database@Azure](oracle-security-overview-odaa.md)
- [Network topology and connectivity for Oracle Database@Azure](oracle-network-topology-odaa.md)
