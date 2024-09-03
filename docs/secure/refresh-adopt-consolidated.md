---
title: Perform your cloud adoption securely
description: Learn how to adopt security best practices in your cloud estate adoption phase
author: claytonsiemens77
ms.author: csiemens
ms.date: 06/24/2024
ms.topic: conceptual
ms.custom: internal, UpdateFrequency2
---

# Perform your cloud adoption securely

## Security posture modernization adoption

- **Security baselines:** Establish security baselines that include availability requirements to have a well understood foundation to build from. Using a tool like [Microsoft Secure Score](/defender-xdr/microsoft-secure-score-improvement-actions) can help you establish baselines with tangible recommendations for improvements.

- **Automation:** Use automation tools to manage routine tasks, such as scaling resources and applying updates, to reduce the risk of human error and improve consistency. Take advantage of cloud services that have the ability to automate failover and recovery procedures. Automate threat detection and response with tools like the automated investigation and response functionality in [Microsoft Defender XDR](/defender-xdr/m365d-autoir).

- **Zero Trust access and authorization controls:** Strong access controls and identity management systems ensure that only authorized personnel have access to critical systems and data. This reduces the risk of malicious activities that could disrupt services. Standardizing on strictly enforced role-based access controls (RBAC) and requiring multi-factor authentication (MFA) helps prevent unauthorized access to your systems that could disrupt service availability. Refer to the [Securing identity with Zero Trust](/security/zero-trust/deploy/identity) article for detailed guidance on this topic.

### Change management institutionalization

Effective adoption and change management (ACM) methodologies are crucial for ensuring the successful implementation and institutionalization of access controls. Some of the best practices and methodologies include:

- **Prosci ADKAR Model:** This model focuses on five key building blocks for successful change: Awareness, Desire, Knowledge, Ability, and Reinforcement. By addressing each of these elements, organizations can ensure that employees are aware of the need for access controls, have the desire to support the change, possess the necessary knowledge and skills, and receive reinforcement to sustain the change.

- **Kotter’s 8-Step Change Model:** This model outlines eight steps for leading change, including creating a sense of urgency, forming a powerful coalition, developing a vision and strategy, communicating the vision, empowering employees for broad-based action, generating short-term wins, consolidating gains, and anchoring new approaches in the culture. By following these steps, organizations can effectively manage the adoption of access controls.

- **Lewin’s Change Management Model:** This model involves three stages: Unfreeze, Change, and Refreeze. In the Unfreeze stage, organizations prepare for change by identifying the need for access controls and creating a sense of urgency. In the Change stage, new processes and practices are implemented. In the Refreeze stage, the new practices are solidified and integrated into the organizational culture.

- [**Microsoft's Adoption and Change Management Framework:**](https://adoption.microsoft.com/en-us/virtual-hub/adoption-governance/adoption-change-management/) This framework provides a structured approach to driving adoption and change, including defining success criteria, engaging stakeholders, preparing the organization, and measuring success. It emphasizes the importance of communication, training, and support to ensure that access controls are effectively adopted and institutionalized.

By incorporating these ACM methodologies and best practices, organizations can ensure that access controls are not only implemented but also embraced by employees, leading to a more secure and compliant enterprise environment.

## Incident preparedness and response adoption

After establishing your landing zone or other platform design with secure network segmentation and well-designed subscription and resource organization, you can begin implementation with a focus on incident preparedness and response. In this phase, building out your preparedness and response mechanisms including your incident response plan will ensure that cloud estate and your operational practices align with business goals. The adoption phase should approach the theme of incident preparedness and response from two perspective: Threat readiness and mitigation and infrastructure and application security.

### Threat readiness and mitigation

- **Threat detection:** Implement advanced monitoring tools and practices to detect threats in real-time. This includes setting up alert systems for unusual activities and integrating eXtended detection and response (XDR) and security information and event management (SIEM) solutions. Refer to the [Zero trust threat protection and XDR](/security/zero-trust/adopt/prevent-reduce-business-damage-breach-threat-protection) guide for detailed guidance on this topic.

- **Vulnerability management:** Regularly identify and mitigate vulnerabilities through patch management and security updates to ensure that systems and applications are protected against known threats.

- **Incident response:** Develop and maintain an incident response plan that includes detection, analysis, and remediation steps to quickly address and recover from security incidents. Refer to the Well-Architected Framework [incident response](/azure/well-architected/security/incident-response) guide for workload-focused guidance on this topic.

    - Automate mitigation activities to the extent possible to make these activities more efficient and less prone to human error. For example, if you detect a SQL injection, you could have a runbook or workflow that automatically locks all connections to SQL to contain the incident.

### Infrastructure and application security

- **Secure deployment pipelines:** Build CI/CD pipelines with integrated security checks to ensure that applications are securely developed, tested, and deployed. This includes static code analysis, vulnerability scanning, and compliance checks. For detailed guidance, refer to the [Zero trust developer guidance](/security/zero-trust/develop/overview) for detailed articles on this topic.

- **Infrastructure as Code deployments:** All infrastructure should be deployed through code, without exception. Reduce the risk of misconfigured infrastructure and unauthorized deployments by mandating this standard. All infrastructure code assets should be colocated with application code assets and treated with same [safe deployment practices](/azure/well-architected/operational-excellence/safe-deployments) as software deployments.

## Adopt the principal of confidentiality

With the overarching strategy and implementation plan for adopting the CIA Triad principle of confidentiality already in place, the next step is to focus on adoption and change management. This involves ensuring that encryption and secure access controls are effectively implemented and institutionalized across the enterprise cloud environment. In the adoption phase, DLP measures are implemented to protect sensitive data in transit and at rest. This involves deploying encryption solutions, configuring access controls, and ensuring that all employees are trained in the importance of data confidentiality and how to adhere to DLP policies.

### Implement encryption and secure access controls

To protect sensitive information from unauthorized access, it is crucial to implement robust encryption and secure access controls. Encryption ensures that data is unreadable to unauthorized users, while access controls regulate who can access specific data and resources. Understand the encryption capabilities of the cloud services that you deploy and enable the appropriate encryption mechanisms to meet your business requirements.

### Incorporating and adopting associated standards

Developing and adopting associated standards is essential for ensuring the consistent implementation of encryption and access controls. Organizations should establish clear guidelines and best practices for using encryption and access controls, and ensure that these standards are communicated to all employees. For example, a standard might specify that all sensitive data must be encrypted using AES-256 encryption, and that access to this data must be restricted to authorized personnel only. By incorporating these standards into the organization's policies and procedures, and providing regular training and support, organizations can ensure that encryption and access controls are consistently applied across the enterprise. Other examples include:

- **Strong encryption:** Enable encryption on data stores when practical and consider managing your own keys. Your cloud provider may offer encryption at rest for the storage that your data store is hosted on, and give you the option of enabling database encryption like [transparent data encryption](/azure/azure-sql/database/transparent-data-encryption-tde-overview) in Azure SQL Database. Apply the extra layer of encryption when practical.

- **Access controls:** Apply role-based access controls (RBAC), conditional access controls, just-in-time access, and just-enough-access to all data stores and standardize practices of reviewing permissions regularly. Lockdown write access to configuration systems and allow write access only through specific automation account which applies the changes after comprehensive review processes, typically as part of DevOps pipelines. 

- **Standards adoption:** The organization might develop a standard that requires all emails containing sensitive information to be encrypted using [Microsoft Purview Information Protection](/purview/information-protection). This ensures that sensitive data is protected during transmission and can only be accessed by authorized recipients.

## Adopt the principle of integrity

In the adopt phase, planning and designs are turned into real-world implementations. In the context of data and system integrity, this means building out your systems according to the standards that you developed in the earlier phases and ensuring that engineers, administrators, and operators are trained on protocols and procedures. 

### Data integrity adoption

- **Data classification:** Implement your data classification framework through automation when possible and manually when necessary. Tools like [Microsoft Purview](/purview) can automate some of your data classification, finding sensitive information through pattern matching. Use manual labeling for documents and containers, and manually curate data sets used in analytics where classification and sensitivity are best established by knowledgeable users.

- **Data verifcation and validation:** Take advantage of built-in verification and validation functionality in the services that you deploy. For example, Azure Data Factory has built-in functionality to [verify data consistency](/azure/data-factory/copy-activity-data-consistency) when moving data from a source to a destination store. Consider adopting practices like:

    - Using the CHECKSUM and BINARY_CHECKSUM functions in SQL to ensure data isn't corrupted in transit.

    - Storing hashes in tables and creating subroutines that modify the hashes when the last modified date changes.

- **Monitoring and alerting:** Monitor your data stores for changes with detailed change history information to help with reviews. Configure alerting to ensure that you have appropriate visibility and you can take efficient actions in case of any incidents that could affect data integrity.

- **Backup policies:** Apply backup policies on all appropriate systems. Understand the backup capabilities of platform as a service (PaaS) ans software as a service (SaaS) services. For example, Azure SQL Database includes [automatic backups](azure/azure-sql/database/automated-backups-overview?view=azuresql) and you can configure the retention policy as necessary.

- **Share design standards:** Publish and share application design standards that incorporate data integrity mechanisms across the organization. Design standards should include nonfunctional requirements like tracking configuration and data changes at the application level natively and capturing this history in the data schema. This approach mandates that the data schema retains details about data history and configuration history as part of the datastore, in addition to standard logging mechanisms to bolster your integrity monitoring.
 
### System integrity adoption

- **Security monitoring:** Use a robust monitoring solution to automatically enroll all resources in your cloud estate and ensure that alerting is enabled and configured to notify appropriate teams when incidents occur.

    - **SIEM and threat detection:** Ensure that appropriate systems are monitored by your SIEM and threat detection systems to identify suspicious activity and other threats.

- **Automated configuration management:** Deploy and configure a configuration management system that automatically enrolls new systems and manages your configurations continuously.

- **Automated patch management:** Deploy and configure a patch management system that automatically enrolls new systems and manages patching according to your policies. Prefer native tooling to your cloud platform.

- **Automated infrastructure deployments:** Ensure that you have policies and procedures in place to block any manual deployments from the portal and to ensure that all IaC assets are co-located with other code assets and that the development team has been trained on your safe deployment practices.

## Adopt the principle of availability

With resilient design patterns defined, your organization can move on to the adoption phase. For detailed guidance on workload availability, refer to the Well-Architected Framework's [reliability](/azure/well-architected/reliability) pillar and the [Azure reliability](/azure/reliability/overview) documentation. In the context of cloud adoption, the focus is on establishing and codifying operational practices that support availability.

### Establishing operational practices to support availability

Maintaining a highly available cloud estate can only be done if the teams operating the cloud systems have standardized, mature practices that are strictly followed. These practices should include:

- **Operational continuity:** Organizations must plan for continuous operations even under attack conditions. This includes establishing processes for rapid recovery and maintaining critical services at a degraded level until full recovery is possible. Refer to the [Adopt preparedness](./refresh-adopt-preparedness.md) guide for detailed guidance on this topic.

- **Robust and continuous observability:** An organization's ability to detect security incidents as they happen allows them to initiate their incident response plans quickly, helping to minimize the business impact as much as possible. Incident detection is only possible through a well-designed monitoring and alerting system, following best-practices for threat detection. Refer to the Well-Architected Framework's [observability guide](/azure/well-architected/operational-excellence/observability) and [security monitoring and threat detection guide](/azure/well-architected/security/monitor-threats) for detailed guidance on this topic.

- **Proactive maintenance:** System updates should be standardized and enforced through policies. Schedule regular maintenance windows to apply updates and patches to systems without disrupting services. Conduct regular health checks and maintenance activities to ensure all components are functioning optimally​.

- **Standardized governance policies:** Enforce all security standards through tooling-supported policies. Use a policy management tool like [Azure Policy](/azure/governance/policy/overview) to ensure that all of your systems are compliant with your business requirements by default and that your policies are easily auditable. Refer to the [security governance](./refresh-security-governance.md) guide for further details on this topic.

- **Disaster recovery preparedness:** Develop and regulary test disaster recovery plans for your workloads to ensure that they will be able to be recovered in the event of a disaster. Refer to the Well-Architected Framework's [disaster recovery guidance](/azure/well-architected/reliability/disaster-recovery) for detailed guidance on this topic.

    - Automate recovery activities to the extent practical. For example, make use of automatic failvoer capabilities in services like [Azure SQL Database](/azure/azure-sql/database/failover-group-sql-db?view=azuresql)

- **Understanding service-level agreements:** Service-level agreements (SLAs) that are provided by your cloud platform for their services help you understand the guaranteed uptime for the components of your workloads. Using those SLAs as your basis, you can then develop your own target metrics for the SLAs you offer your customers. Microsoft publishes the SLAs for all cloud services at [Service-level agreements for online services](https://www.microsoft.com/licensing/docs/view/Service-Level-Agreements-SLA-for-Online-Services)

- **Compliance requirements:** Adhering to regulations such as GDPR and HIPAA ensures that systems are designed and maintained to high standards, including those related to availability. Non-compliance can lead to legal actions and fines that might disrupt business operations. Compliance often isn't limited to system configuration. Most compliance frameworks also require risk management and incident response standards. Ensure that your operational standards meet the framework requirements and staff is trained regularly.

## Adopt security sustainment

Consider the following recommendations to help ensure that the security mechanisms and practices that you have put in place as part of your cloud adoption can be sustained and consinously improved as you continue your journey:

- **Institue a Security Review Board:** Create a Security Review Board that continuously reviews projects and mandates security controls. Review your processes regularly to find areas of improvement. Develop processes to ensure that security is always top of mind for everyone.

- **Implement a vulnerability management solution:**  Use tooling like [Microsoft Defender Vulnerability Management](defender-vulnerability-management/defender-vulnerability-management) to monitor the security vulnerability risk score and have a process defined to act on the highest risk score to lowest to minimize the risk. Keep track of latest CVE risks and have a policy to apply those mitigations regularly for remediation.

- **Harden production infrastructure:** Hardening is critical part of prevention process, so follow benchmarking guidance like the Center for Internet Security (CIS) [benchmarks](https://www.cisecurity.org/cis-benchmarks).

- **Utilize the MITRE ATT&CK knowledge base:** Use the [MITRE ATT&CK](https://attack.mitre.org/) knowledge base to help develop threat models and methodologies for common real-world attack tactics and techniques.
 
- **Shift left:** Use segregated environments with different access levels for pre-production vs production. This approach will help you shift left, addign security concerns to all phases of development and providing flexibility in lower environments.