---
title: Governance and compliance for Oracle on Azure Virtual Machines landing zone accelerator
description: Learn about governance and compliance for Oracle on Azure Virtual Machines landing zone accelerator.
author: jjaygbay1
ms.author: jacobjaygbay
ms.reviewer: ramakoni
ms.date: 01/10/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: 
  - think-tank
  - e2e-oracle
  - engagement-fy24
---

# Governance and compliance for Oracle on Azure Virtual Machines landing zone accelerator

This article describes how to holistically control Oracle workload on Azure Virtual Machines landing zone accelerator throughout its lifecycle. You also learn to explore specific design elements and provide governance and compliance recommendations for Oracle workload on Azure Virtual Machines landing zone accelerator.

## Design considerations

When you deploy your Oracle workload to Azure, take the following design consideration to build robust environments.

### Security and access control

- Ensure encrypted communication between database and its clients.
- Use RBAC to ensure the least privileged access to your database server and data (including backups).
- Consider enforcing zero-trust [network security](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/landing-zone/design-area/security#zero-trust) across the network perimeter.

### Compliance

Use Azure compliance capabilities to abide by industry and regulatory requirements. For more information on industry and regulatory standards supported, see the following resources:

- [Azure compliance documentation](https://learn.microsoft.com/azure/compliance/)

- [Azure and other Microsoft cloud services compliance offerings - Azure Compliance](https://learn.microsoft.com/azure/compliance/offerings/)

- [Compliance in the trusted cloud](https://azure.microsoft.com/explore/trusted-cloud/compliance/) 

### Capacity allocation and sizing

- Ensure the right sizing for your Oracle Workload on Azure Virtual Machines, both for primary and for secondary (BCDR) environments.  

- Cost monitoring and management

- Use [tagging](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/azure-best-practices/resource-naming-and-tagging-decision-guide) to monitor and manage costs and use Azure Policy to enforce tagging standards. 

### Logging and monitoring  

- [Monitor availability](https://learn.microsoft.com/azure/architecture/best-practices/monitoring#availability-monitoring) in Azure.

- Monitor Oracle virtual machines for both metrics and logs.

- Monitor network services.

- Monitor Azure service health.

    - Monitor resources to detect usage pattern changes and proactively initiate changes. For example,  increase memory or number of vCPUs by upgrading to a different virtual machine SKU.

- Create alerts to detect early warning signs for potential problems.
- For Oracle database application monitoring consider implementing Oracle Enterprise Manager for database specific insights.

### Data management

- If your workload has specific requirements for data retention, ensure your design incorporates necessary policies for data retention.

- If your workload has specific requirements for data residency, ensure your design incorporates necessary policies to ensure data always resides in the geography where requirements dictate. 

## Design recommendations

The following sections provide design recommendations for Oracle workload on Azure Virtual Machines landing zone accelerator.

### Adopt Azure policy

Azure Policy helps to enforce organizational standards and to assess, monitor and enforce compliance at-scale. Use Azure Policy at the heart of your compliance design to enforce standards set for your environment.

### Microsoft Defender for cloud

Enable [Microsoft Defender for Cloud](https://learn.microsoft.com/azure/defender-for-cloud/defender-for-cloud-introduction) to improve your security posture and protect your workload.

Use the [regulatory compliance dashboard](https://learn.microsoft.com/azure/defender-for-cloud/regulatory-compliance-dashboard) provided with Microsoft Defender for Cloud to help ensure compliance to your regulatory requirements.

### Encrypt data at rest

Depending on your requirements, you can use [Azure data encryption at-rest](https://learn.microsoft.com/azure/security/fundamentals/encryption-atrest) or [Oracle Transparent Data Encryption (TDE)](https://docs.oracle.com/en-us/iaas/autonomous-database/doc/data-encryption.html) to ensure compliance with your organizational standards.  

### Data retention  

Use [immutable data retention policies](https://learn.microsoft.com/azure/storage/blobs/immutable-time-based-retention-policy-overview) for your [Oracle on Azure backups](https://learn.microsoft.com/azure/virtual-machines/workloads/oracle/oracle-database-backup-strategies) to ensure compliance with your regulatory requirements.

### Data residency

Use Azure policy to ensure database instances can only be created where your data residency requirements dictate. For an example, see the built-in policy definition [Azure Cosmos DB Allowed Locations](https://ms.portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F0473574d-2d43-4217-aefe-941fcdf7e684) .

### Adapt Azure monitoring

- Collect logs and metrics from Oracle database virtual machines into a Log Analytics workspace for further analysis and auditing. You can still use Oracle Enterprise Manager for database specific monitoring but also use Azure Monitoring infrastructure to provide a holistic view of your solution components such as virtual machines, disks, network components.

- Configure diagnostic settings to forward resource logs to [Azure Monitor](https://learn.microsoft.com/azure/azure-monitor/overview) logs.

- Enable [Azure Virtual Machine insights](https://learn.microsoft.com/azure/azure-monitor/vm/vminsights-overview).

- Monitor reachability, latency, and network topology changes between the Virtual Machine and the endpoint using [Azure Network Watcher](https://learn.microsoft.com/azure/network-watcher/network-watcher-monitoring-overview).

- Design your log analytics environment with geographical location, data isolation and data retention configurations according to best practices defined in [Design Log Analytics Workspace](https://learn.microsoft.com/azure/storage/blobs/immutable-time-based-retention-policy-overview).  

Governance framework is a crucial component of any cloud-based solution to ensure organizational standards are always adhered to. Guidelines provided in this document help you to deploy and manage your Oracle environment on Azure in a scalable and secure way.

## Next steps

This article is based on the Cloud Adoption Framework enterprise-scale landing zone architectural design principles and guidelines. For more information, see the following articles:

- [Azure landing zone design principles](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/landing-zone/design-principles)

- [Azure landing zone design guidelines](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/landing-zone/design-areas)

- [Manage and monitor Oracle workloads on Azure IaaS](oracle-manage-monitor-workload.md)
