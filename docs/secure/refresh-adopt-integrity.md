---
title: Adopt integrity
description: Learn how to protect your organization's integrity.
author: claytonsiemens77
ms.author: csiemens
ms.date: 06/24/2024
ms.topic: conceptual
ms.custom: internal, UpdateFrequency2
---

# Adopt integrity

## Intro section

Goal: Adoption of this principle prevents data corruption, reduces errors, and supports decision-making processes. Maintaining high standards of integrity allows the organization to operate more efficiently and with greater confidence in the results produced by its data.

Integrity means that an asset is free from unauthorized alterations. Only authorized entities should be able to modify an asset, and only in specific authorized ways. For example, if you are reviewing orders placed by customers on your online store, you should not be able to increase the price of any items in those orders after they have been purchased.

Cloud environments need to ensure integrity in two general areas: data integrity and system integrity. 

Data integrity is ensured through a variety of methods including:

- **Robust data management practices** that include data validation, data verification, and use of error detection and correction algorithms to ensure accuracy and consistency of data. 
- **Access controls** are implemented to prevent unauthorized access or modification of data. 
- Regular **data backups** are performed to protect against data loss. 
- **Checksums** and **hash functions** are used to detect any unintentional changes to data. 
- **Data encryption** is used to protect data in transit and at rest, preventing unauthorized access and maintaining data integrity.
- **Database normalization** techniques reduce data redundancy and improve data integrity.
- Regular **audits** are conducted to ensure compliance with data integrity standards. 

> [!NOTE]
> Some guidance in this article overlaps with guidance provided in the [Confidentiality](./refresh-adopt-confidentiality.md) article. In those instances, this article will direct you to the Confidentialty guidance to avoid repetition.

## Strategy

Refer to the [cross-cutting recommendations](./refresh-adopt-confidentiality.md#cross-cutting-guidance) in the Confidentialiy guide.

## Plan 

Refer to the [cross-cutting recommendations](./refresh-adopt-confidentiality.md#cross-cutting-guidance) in the Confidentialiy guide.

## Ready

After establishing your cloud adoption strategy and plan, you can begin your [landing zone](../ready/landing-zone/index.md) configurations, designing data management practices, and designing system integrity patterns. 

1. **Configuring secure landing zones**

- When building out your landing zones, apply the principle of integrity by ensuring that you've designed a secure [network topology](../ready/landing-zone/design-area/network-topology-and-connectivity) and [identity and access management](../ready/landing-zone/design-area/identity-access) platform, which helps ensure that data can't be altered by unauthorized users or systems.

2. **Data management practices**

- *Data classification:* Create a data classification framework and sensitivity label taxonomy that defines high level categories of data security risk. That taxonomy will be used to simplify everything from data inventory or activity insights, to policy management to investigation prioritization. Refer to the [Create a well-designed data classification framework](/compliance/assurance/assurance-create-data-classification-framework) for detailed guidance on this topic.

- *Data verification and validation:* Invest in tooling that automates data verification and validation to relieve burden on your data engineers and administrators and to reduce the risk of human error.

- *Robust access control management:* Protecting data from unauthorized modifications requires a strong access control strategy. Refer to the [guidance](./refresh-adopt-confidentiality.md#identity-and-access-management) provided in the Adopt confidentialty guide for detailed guidance on this topic.

- *Backup policies:* Codify backup policies to ensure that all data is regularly backed up. Backups and restores should be regularly tested to ensure that backups are both successfully occuring and for data correctness and consistency.

- *Strong encryption:* Ensure that your cloud provider encrypts your data at rest and in transit by default. In Azure, your data is encrypted end-to-end. Refer to the [Microsoft Trust Center](https://www.microsoft.com/en-us/trust-center/privacy#securing_your_data) for full details. For the services that you use in your workloads, ensure that strong encryption is supported and appropriately configured to meet your business requirements.

3. **System integrity design patterns**

- *Security monitoring:* To help detect unauthorized changes to your cloud systems, design a robust security monitoring platform as part of your overall monitoring and observability strategy. Refer to the Manage methodology [monitoring section](/azure/cloud-adoption-framework/manage/monitor/) for detailed guidance on overall guidance and the Zero Trust [Visibility, automation, and orchestration](/security/zero-trust/deploy/visibility-automation-orchestration) guide for recommendations on security monitoring.

    - *Security information and event management (SIEM) and threat detection:* Include the use of SIEM tooling like [Microsoft Sentinel](/azure/sentinel/overview) and threat detection tooling like [Microsoft Defender XDR](/defender-xdr/microsoft-365-defender) to detect suspicious activities and potential threats to your infrastructure. 

- *Automated configuration management:* Codify the use of tooling like [Azure Policy](/azure/governance/policy) and [Microsoft Defender for Cloud](/defender-for-cloud/defender-for-cloud-introduction) to automate configuration management. Automation helps ensure that all system configurations are consistent, free from human error, and enforced .

- *Automated patch management:* Codify the use of tooling like [Azure Update Manager](/azure/update-manager/overview) to manage and govern updates for virtual machines (VMs). Automated patching helps ensure that all systems are patched regularly and system versions are consistent.

- *Automated infrastructure deployments:* Codify the use of infrastructure as code (IaC) for all deployments. Apply the same [safe deployment practices](/azure/well-architected/operational-excellence/safe-deployments) for IaC deployments as you would for software deployments.

### Summary

By configuring landing zones and adopting data and system integrity design patterns and practices, organizations can successfully move on to deploying their workloads in the Adopt phase. Landing zones configurations should include a secure network topology and strong identity and access controls. Data integrity designs and practices should include data classification, data verification and validation, access controls, backups, encryption. System integrity designs and practices should include security monitoring including SIEM and threat detection and automated configuration management, patch management, and infrastructure deployments.

Refer to the [Ready](../ready/) methodology section for detailed guidance on topics related to preparing for cloud adoption.

## Adopt

In the adopt phase, planning and designs are turned into real-world implementations. In the context of data and system integrity, this means building out your systems according to the standards that you developed in the earlier phases and ensuring that engineers, administrators, and operators are trained on protocols and procedures. 

1. **Data integrity adoption**

- *Data classification:* Implement your data classification framework through automation when possible and manually when necessary. Tools like [Microsoft Purview](/purview) can automate some of your data classification, finding sensitive information through pattern matching. Use manual labeling for documents and containers, and manually curate data sets used in analytics where classification and sensitivity are best established by knowledgeable users.

- *Data verifcation and validation:* Take advantage of built-in verification and validation functionality in the services that you deploy. For example, Azure Data Factory has built-in functionality to [verify data consistency](/azure/data-factory/copy-activity-data-consistency) when moving data from a source to a destination store. 

- *Access controls:* Apply role-based access controls (RBAC), conditional access controls, just-in-time access, and just-enough-access to all data stores and standardize practices of reviewing permissions regularly.

- *Backup policies:* Apply backup policies on all appropriate systems. Understand the backup capabilities of platform as a service (PaaS) ans software as a service (SaaS) services. For example, Azure SQL Database includes [automatic backups](azure/azure-sql/database/automated-backups-overview?view=azuresql) and you can configure the retention policy as necessary.

- *Strong encryption:* Enable encryption on data stores when practical and consider managing your own keys. Your cloud provider may offer encryption at rest for the storage that your data store is hosted on, and give you the option of enabling database encryption like [transparent data encryption](/azure/azure-sql/database/transparent-data-encryption-tde-overview) in Azure SQL Database. Apply the extra layer of encryption when practical.
 
2. **System integrity adoption**

- *Security monitoring:* Use a robust monitoring solution to automatically enroll all resources in your cloud estate and ensure that alerting is enabled and configured to notify appropriate teams when incidents occur.

    - *SIEM and threat detection:* Ensure that appropriate systems are monitored by your SIEM and threat detection systems to identify suspicious activity and other threats.

- *Automated configuration management:* Deploy and configure a configuration management system that automatically enrolls new systems and manages your configurations continuously.

- *Automated patch management:* Deploy and configure a patch management system that automatically enrolls new systems and manages patching according to your policies. Prefer native tooling to your cloud platform.

- *Automated infrastructure deployments:* Ensure that you have policies and procedures in place to block any manual deployments from the portal and to ensure that all IaC assets are co-located with other code assets and that the development team has been trained on your safe deployment practices.

### Summary

Adopting the recommendations above as you build out your cloud estate will help ensure that you will have strong data and system integrity from the outset and you'll have well-defined and strongly enforced practices in place to maintain integrity.

Refer to the [Adopt](../adopt/) methodology section for detailed guidance on cloud adoption topics.

## Govern

Implement governance frameworks that review data integrity regularly.

## Manage

Deploy monitoring tools that alert on data anomalies or alterations.

## Secure

Apply measures to prevent unauthorized data modification.

## References - TBD

## Azure facilitation - TBD