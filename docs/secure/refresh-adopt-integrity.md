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
> Some guidance in this article overlaps with guidance provided in the [Adopt confidentiality](./refresh-adopt-confidentiality.md) article. In those instances, this article will direct you to the relevant guidance in that article to avoid repetition.

## Strategy

Refer to the [cross-cutting recommendations](./refresh-adopt-confidentiality.md#cross-cutting-guidance) in the "Adopt confidentialiy" guide.

## Plan 

Refer to the [cross-cutting recommendations](./refresh-adopt-confidentiality.md#cross-cutting-guidance) in the "Adopt confidentialiy" guide.

## Ready

After establishing your cloud adoption strategy and plan, you can begin your [landing zone](../ready/landing-zone/index.md) configurations, designing data management practices, and designing system integrity patterns. 

1. **Configuring secure landing zones**

- When building out your landing zones, apply the principle of integrity by ensuring that you've designed a secure [network topology](../ready/landing-zone/design-area/network-topology-and-connectivity) and [identity and access management](../ready/landing-zone/design-area/identity-access) platform, which helps ensure that data can't be altered by unauthorized users or systems.

2. **Data management practices**

- *Data classification:* Create a data classification framework and sensitivity label taxonomy that defines high level categories of data security risk. That taxonomy will be used to simplify everything from data inventory or activity insights, to policy management to investigation prioritization. Refer to the [Create a well-designed data classification framework](/compliance/assurance/assurance-create-data-classification-framework) for detailed guidance on this topic.

- *Data verification and validation:* Invest in tooling that automates data verification and validation to relieve burden on your data engineers and administrators and to reduce the risk of human error.

- *Robust access control management:* Protecting data from unauthorized modifications requires a strong access control strategy. Refer to the [guidance](./refresh-adopt-confidentiality.md#identity-and-access-management) provided in the "Adopt confidentialty" guide for detailed guidance on this topic.

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

- *Data verifcation and validation:* Take advantage of built-in verification and validation functionality in the services that you deploy. For example, Azure Data Factory has built-in functionality to [verify data consistency](/azure/data-factory/copy-activity-data-consistency) when moving data from a source to a destination store. Consider adopting practices like:
    - Using the CHECKSUM and BINARY_CHECKSUM functions in SQL to ensure data isn't corrupted in transit.
    - Storing hashes in tables and creating subroutines that modify the hashes when the last modified date changes.

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

Ensuring that your integrity protections are properly maintained requires a well-designed governance strategy that ensures all polices and procedures are documented and enforced and that all systems involved are continuously audited for compliance. 

The guidance provided in the [Govern](./refresh-adopt-confidentiality.md#govern) section of the "Adopt confidentiality" guide is applicable for data and system integrity. Some additional recommendations specific to integrity are:

- **Automated data quality governance:** Consider using an off-the-shelf solution to govern your data. For example, [Microsoft Purview Data Quality](/purview/data-quality-overview) offers users the ability to evaluate data quality using no-code/low-code rules, including out-of-the-box (OOB) rules and AI-generated rules. These rules are applied at the column level and aggregated to provide scores at the levels of data assets, data products, and business domains, ensuring end-to-end visibility of data quality within each domain.

- **Automated system integrity governance:** Consider using a centralized, unified tool to automate your system integrity governance. For example, [Azure Arc](/azure/azure-arc/overview) allows you to govern systems across multiple clouds, on-premises data centers, and edge sites. Using a system like this can simplify your governance responsibilities and reduce operational burden.

### Summary

Governing your data and system integrity is a crucial facet of maintaining a high degree of integrity. Codifying your procedures and protocols and automating governance tasks will ensure that your integrity strategy is as strong in practice as it is on paper. 

Refer to the [Govern](../govern/) methodology section for detailed guidance on cloud governance topics.

## Manage

Managing your data and system integrity relies on robust monitoring with specific configurations for detecting unauthorized changes to your assets. Other key tenets of the manage phase are adopting continuous improvement and training practices.

1. **Data integrity monitoring:** Effectively monitoring data integrity is a complex task and using intelligent tooling can ease the burden of configuring the appropriate monitoring mechanisms. Combining intelligent data governance with SIEM and security orchestration, automation, and response (SOAR) solutions allow you to gain deep insights into activities related to your data and to automate parts of your incident response plan. Your monitoring should detect anomolous behaviors, including unauthorized access to data stores and changes to the data stores. Automated incident responses like immediate lockouts can help minimize the blast radius of malicious activities.

2. **System integrity monitoring:** Effectively monitoring for system integrity is more straightforward than data integrity. Most modern monitoring and alerting platforms are well equipped to detect changes to systems. With proper guardrails around deployments, like only allowing changes to the environment through IaC, and a well-designed authentication and access platform, you can ensure that changes happening outside of the approved protocols are detected and investigated immediately.

3. **Continuous improvement:** The continuous improvement [guidance](./refresh-adopt-confidentiality.md#manage) provided in the "Adopt confidentiality" article is applicable to integrity. Recommendations specific to integrity are:

- *Routinely audit your data:* Routinely perform manual audits of your data to ensure that your data governance and monitoring tooling is performing as expected and look for areas of improvement.
- *Data hygiene:* Adopt good data hygiene habits like routinely reviewing access permissions to your data stores and deleting sensitive data when its no longer valuable or necessary. 

4. **Integrity training:** As part of your overall training strategy, ensure that employees are trained on your data and system integrity policies and procedures. This training should be mandatory for new hires, with deeper training specific to their roles for those in the security team, and should be regularly recurring for all employees.

### Summary

Detecting and reacting to changes in your data or to your systems is key to maintaining integrity. Implementing intelligent tooling to facilitate these activities will help your data and security teams work efficiently while reducing the risk of human error. Combining these strategies with continuous improvement efforts and a well-designed training program will help ensure that your integrity policies, procedures, and mechanisms are managed to the highest degree possible.

## References

- [**Zero Trust data pillar:**](/security/zero-trust/deploy/data) Learn about the Microsoft's Zero Trust guidance for data.

- [**Zero Trust infrastructure pillar:**](/security/zero-trust/deploy/infrastructure) Learn about Microsoft's Zero Trust guidance for infrastructure.

- [**Well-Architected Framework recommendations for data classification:**](/azure/well-architected/security/data-classification) Learn about data classification recommendations for workloads in Azure.

- [**Well-Architected Framework recommendations for encryption**](/azure/well-architected/security/encryption) Learn about encryption recommendations for workloads in Azure.

## Azure facilitation

### Policy management

- [**Azure Policy**](/azure/governance/policy) Azure Policy is a cloud governance solution for Azure environments. It allows you to define policies for your environment and automatically enforce those policies. It has built-in support for many compliance frameworks and integrates seamlessly with other Microsoft tools like Azure Arc, and Defender for Cloud.

### Data security

- [**Purview data security:**](/purview/purview-security) Microsoft Purview is a comprehensive set of solutions that can help your organization govern, protect, and manage data, wherever it lives. Microsoft Purview solutions provide integrated coverage and help address the fragmentation of data across organizations, the lack of visibility that hampers data protection and governance, and the blurring of traditional IT management roles.

### Data governance

- [**Microsoft Purview Data Quality:**](/purview/data-quality-overview) Microsoft Purview Data Quality is a comprehensive solution that empowers business domain and data owners to assess and oversee the quality of their data ecosystem, facilitating targeted actions for improvement.

### System governance

- [**Azure Arc:**](/azure/azure-arc/overview) Azure Arc is a centralized and unified infrastructure governance solution that allows you to manage multi-cloud, on-premises, and hybrid environments. Azure Arc integrates with [Azure Policy](/azure/azure-arc/servers/policy-reference) to easily apply your policies across environments.

### Data encryption

- **Azure Encryption:** Use comprehensive encryption solutions to protect data at rest and in transit, including encryption for various storage solutions such as file, disk, blob, and table storage. Azure offers encryption for services like Azure SQL Database, Azure Cosmos DB, and Azure Data Lake. The encryption models supported include server-side encryption with service-managed keys, customer-managed keys in Azure Key Vault, and customer-managed keys on customer-controlled hardware. Client-side encryption models support data encryption by an application before it is sent to Azure. For more detailed information, you can refer to the [Azure Encryption Overview](/azure/security/fundamentals/encryption-overview) guide.

### Identity and access management
 
- [**Microsoft Entra ID:**](/entra/fundamentals/whatis) Formerly known as Azure Active Directory, Microsoft Entra ID offers comprehensive identity and access management capabilities. It supports multi-factor authentication (MFA), conditional access policies, and single sign-on (SSO) to ensure that only authorized users can access sensitive data.
Role-Based Access Control (RBAC): Azure RBAC allows fine-grained access management for Azure resources, ensuring that users have only the permissions they need to perform their tasks.

### Threat detection and mitigation

- [**Microsoft Defender for Cloud:**](/azure/defender-for-cloud/defender-for-cloud-introduction) This comprehensive security management solution provides advanced threat protection across hybrid cloud environments. It continuously assesses security posture, protects against threats, and provides actionable insights to mitigate risks.