---
title: Adopt confidentiality
description: Learn how to protect your organization's confidentiality.
author: claytonsiemens77
ms.author: csiemens
ms.date: 06/24/2024
ms.topic: conceptual
ms.custom: internal, UpdateFrequency2
---

# Adopt confidentiality


Why It Matters

- **Data Protection:** The CIA Triad helps protect sensitive data from breaches, ensuring privacy and compliance with regulations.
Business Continuity: Ensuring data integrity and availability is critical for maintaining business operations and avoiding downtime.
Trust and Reliability: Implementing the CIA Triad builds trust with customers and stakeholders by demonstrating a commitment to data security.
The CIA Triad is crucial for securing data and workloads in the cloud. These three principles work together to provide a comprehensive approach to securing information systems. While CAF: Secure contains articles that address the Integrity and Availability [link to adopt Integrity and Adopt Availability articles, respectively] principles of the triad, this article is focused primarily on Confidentiality and why you should adopt it as a core principle/practice in your enterprise cloud environment.

Adoption of the Confidentiality principle ensures that the organization can protect sensitive data from unauthorized access, maintain customer trust, and meet compliance requirements for data privacy and security. By proactively securing data, the organization reduces the risk of data breaches and builds a reputation for reliability and safety

## Strategy

When defining a strategy for adopting confidentiality in an enterprise cloud environment, it’s essential to consider several key points:

1. **Define business objectives**

- *Prioritize data privacy and protection:* Establish clear business objectives that emphasize the importance of data privacy and protection. This includes compliance with relevant regulations like GDPR, HIPAA, and industry standards.

- *Risk Management:* Identify and assess potential risks to data confidentiality and develop strategies to mitigate these risks.

2. **Implement Zero Trust (ZT) as a strategy**

- *Zero Trust Principles:* Adopt Zero Trust principles, which include verifying explicitly, using least privilege access, and assuming breach. This approach ensures that every access request is authenticated, authorized, and encrypted.

- *Identity and access management (IAM):* Implement robust IAM solutions to control access to cloud resources. This includes multi-factor authentication (MFA) and role-based access control (RBAC).

3. **Microsoft’s support for Zero Trust**

- *Microsoft Zero Trust Framework:* Microsoft supports Zero Trust through a comprehensive framework that integrates various security solutions. This includes Microsoft Entra for identity management, Microsoft Defender for threat protection, and Microsoft Sentinel for security analytics.
 
- *Cloud-native security:* Microsoft provides cloud-native security tools that help organizations implement Zero Trust principles effectively. These tools offer capabilities such as continuous monitoring, automated threat detection, and real-time compliance checks.
Guidance and Best Practices: Microsoft offers detailed guidance and best practices for implementing Zero Trust, tailored to different industries and regulatory requirements.
Summary

By defining clear business objectives, adopting Zero Trust principles, and leveraging Microsoft’s comprehensive security solutions, organizations can effectively ensure data confidentiality in the cloud. This strategy not only protects sensitive information but also enhances overall security posture and compliance.

## Plan 

Once a strategy has been developed and is in place to help guide decision making, development of a comprehensive implementation plan that takes into consideration the Confidentiality principle of the CIA Triad should begin.

1. **Include data protection requirements in cloud migration or development plans**

- *Data classification:* Identify and classify data based on sensitivity and regulatory requirements. This helps in applying appropriate security measures.

- *Encryption:* Ensure that data will be encrypted both at rest and in transit. Use strong encryption standards to protect sensitive information.

- *Access controls:* Implement strict access controls to ensure that only authorized users can access sensitive data. Use multi-factor authentication (MFA) and role-based access control (RBAC), as well as the principle of ZT, Verify Explicitly, always authenticating and authorizing based on all available data points, including user identity, location, device health, service or workload, data classification, and anomalies.

2. **Adopt Azure landing zones**

- *Landing Zones:* A landing zone is a pre-configured, secure, and scalable environment in the cloud that serves as a foundation for your workloads. It includes network topology, identity management, security, and governance components.
    - *Benefits:* Landing zones help standardize cloud environments, ensuring consistency and compliance with security policies. They also facilitate easier management and scalability.

3. **MOVE TO BOTTOM - FACILITATION**
- Azure Migrate: A comprehensive service that helps you discover, assess, and migrate on-premises workloads to Azure. It supports various migration scenarios, including servers, databases, and applications1.
Microsoft Defender for Cloud: Provides unified security management and advanced threat protection across hybrid cloud environments. It helps detect and respond to threats, ensuring the security of your workloads.
Azure landing zones accelerators: Microsoft offers Azure Landing Zones as part of the Cloud Adoption Framework. These are blueprints that provide a well-architected environment, incorporating best practices for security, governance, and compliance.
Azure Confidential Computing: Protects data in use by performing computations in a hardware-based trusted execution environment (TEE). This ensures that data remains confidential even during processing.
Summary

By including data protection requirements in your cloud migration plans, leveraging landing zones for a standardized and secure environment, and utilizing Microsoft’s tools and services, you can effectively plan and implement a robust confidentiality strategy in the cloud. This approach ensures that your data and workloads are protected throughout the migration process and beyond.

## Ready

With the overarching strategy and implementation plan for adopting the CIA Triad principle of confidentiality already in place, the next step is to prepare the environment. This involves configuring secure landing zones and implementing robust data access controls, conditional access controls, and role-based access controls.

1. **Configuring secure landing zones**

Landing zones are pre-configured environments that provide a secure and consistent foundation for deploying and managing workloads in the cloud. They are essential for enforcing data access controls and ensuring that the environment is secure from the outset.

Azure Landing Zones: These are scalable and modular environments that follow key design principles across various areas such as identity and access management, network topology, and security. They help isolate and scale application resources and platform resources, ensuring that data access controls are consistently applied. Microsoft offers both ready-made and customizable templates for Azure Landing Zones. Ready-made templates, often referred to as landing zone accelerators, provide a quick and efficient way to deploy a secure environment using Infrastructure as Code (IaC) technologies like ARM, Bicep, and Terraform. These accelerators automate the deployment process, ensuring consistency and compliance with best practices. For organizations with specific requirements, customizable templates allow for tailored configurations to meet unique business needs. More detailed information on landing zones and their configuration can be found on the Azure Landing Zone overview page.

2. **Implementing data access controls**

Data access controls are critical for maintaining confidentiality in cloud environments. They ensure that only authorized users can access sensitive data.

- *Principle of least privilege:* Grant users the minimum access required to perform their tasks.

- *Role-Based Access Control (RBAC):* Assign roles and permissions based on job responsibilities. This helps in managing access efficiently and reduces the risk of unauthorized access.

- *Multi-Factor Authentication (MFA):* Implement MFA to add an extra layer of security.

- *Data confidentiality and sensitivity protections:* Implement data classification and labeling to identify and protect sensitive information. Use encryption both at rest and in transit to safeguard data from unauthorized access and breaches.

- *Microsoft Data Access Management:* Microsoft offers comprehensive data access management solutions that help protect your data from inappropriate or unauthorized access. Microsoft solutions also help organizations meet industry and regulatory requirements, such as GDPR, HIPPA, and CCPA. These solutions include Microsoft Purview, which offers comprehensive compliance and data protection capabilities. More information can be found on the Microsoft Compliance page and the Microsoft Data Access Management page.


3. **Conditional access controls**

Conditional access controls provide additional security by enforcing policies based on specific conditions.

- *Microsoft Entra Conditional Access:* This allows administrators to assign controls to specific applications, services, actions, or authentication contexts. Policies can be tailored based on user identity, device health, location, and more.

- *Session Controls:* These enable limited experiences within specific cloud applications based on device compliance and user actions.
Conditional access controls can be tailored to various use cases. For example, organizations can enforce policies that block access from untrusted networks, require multi-factor authentication for high-risk sign-ins, or restrict access to sensitive data based on device compliance. These controls help balance security and user experience by applying stricter measures only when necessary. To learn more about Conditional Access Controls, visit the Microsoft Conditional Access overview page.

4. **Role-Based Access Controls**

Role-Based Access Control (RBAC) is a fundamental component of cloud security, providing a structured way to manage access to cloud resources. Imagine you have a large enterprise cloud environment with various resources like databases, virtual machines, and applications. Not everyone in the organization needs access to all these resources. Role-Based Access Control (RBAC) helps manage who can access what based on their role within the company. For example, a database administrator can access and manage databases, while a developer can only access the resources needed for their development tasks. This ensures that access is granted appropriately and IAW the principle of Confidentiality, keeping the environment secure and organized.

Azure RBAC: This helps manage who has access to Azure resources, what they can do with those resources, and what scopes they can access. It simplifies maintenance of access policies and ensures consistent access management across teams.
RBAC Implementation Models: There are various models ranging from basic to advanced, each providing different levels of granularity in access control.
RBAC is crucial for maintaining the confidentiality aspect of the CIA Triad. By ensuring that only authorized individuals have access to specific resources, RBAC helps protect sensitive information from unauthorized access and potential breaches. This structured approach to access management is essential for safeguarding data and maintaining trust within the organization. To learn more about Role Based Access Controls, visit the Microsoft Azure RBAC overview page.

Summary

By configuring secure landing zones and implementing robust data access controls, conditional access controls, and role-based access controls, organizations can effectively move from the planning phase to preparing their cloud environments, ensuring the confidentiality of their data.

## Adopt 

With the overarching strategy and implementation plan for adopting the CIA Triad principle of confidentiality already in place, the next step is to focus on adoption and change management. This involves ensuring that encryption and secure access controls are effectively implemented and institutionalized across the enterprise cloud environment.

1. Implement Encryption and Secure Access Controls

To protect sensitive information from unauthorized access, it is crucial to implement robust encryption and secure access controls. Encryption ensures that data is unreadable to unauthorized users, while access controls regulate who can access specific data and resources. Microsoft provides several options for encryption, including:

Azure Encryption: Use comprehensive encryption solutions to protect data at rest and in transit, including encryption for various storage solutions such as file, disk, blob, and table storage. Azure offers encryption for services like Azure SQL Database, Azure Cosmos DB, and Azure Data Lake. The encryption models supported include server-side encryption with service-managed keys, customer-managed keys in Azure Key Vault, and customer-managed keys on customer-controlled hardware. Client-side encryption models support data encryption by an application before it is sent to Azure. For more detailed information, you can refer to the Azure Encryption Overview page.
Azure Disk Encryption: Uses BitLocker for Windows and DM-Crypt for Linux to provide volume encryption for virtual machines. This ensures that data stored on the disks is protected from unauthorized access. For more information on Azure Disk encryption, see Azure Disk Encryption for Linux VMs or Azure Disk Encryption for Windows VMs.
Azure Key Vault: Helps manage and safeguard cryptographic keys and secrets used by cloud applications and services. It provides secure key management capabilities to protect data and ensure compliance with regulatory requirements. For more information, see Azure Key Vault Overview page.
Azure Information Protection: Allows organizations to classify, label, and protect data based on its sensitivity. It helps ensure that sensitive information is properly secured and can only be accessed by authorized individuals. For more information, see Azure information protection Overview page.
By leveraging these tools, organizations can ensure that their data is encrypted and secure, both in storage and during transmission.

2. Access Controls: Adoption and Enterprise Institutionalization

Adopting access controls involves more than just implementing technical measures; it requires a cultural shift within the organization. Employees must understand the importance of access controls and be trained on how to use them effectively. This can be achieved through regular training sessions, workshops, and awareness campaigns. Additionally, access controls should be integrated into the organization's policies and procedures, ensuring that they become standard practice across all departments.

Effective adoption and change management (ACM) methodologies are crucial for ensuring the successful implementation and institutionalization of access controls. Some of the best practices and methodologies include:

Prosci ADKAR Model: This model focuses on five key building blocks for successful change: Awareness, Desire, Knowledge, Ability, and Reinforcement. By addressing each of these elements, organizations can ensure that employees are aware of the need for access controls, have the desire to support the change, possess the necessary knowledge and skills, and receive reinforcement to sustain the change.
Kotter’s 8-Step Change Model: This model outlines eight steps for leading change, including creating a sense of urgency, forming a powerful coalition, developing a vision and strategy, communicating the vision, empowering employees for broad-based action, generating short-term wins, consolidating gains, and anchoring new approaches in the culture. By following these steps, organizations can effectively manage the adoption of access controls.
Lewin’s Change Management Model: This model involves three stages: Unfreeze, Change, and Refreeze. In the Unfreeze stage, organizations prepare for change by identifying the need for access controls and creating a sense of urgency. In the Change stage, new processes and practices are implemented. In the Refreeze stage, the new practices are solidified and integrated into the organizational culture.
Microsoft’s Adoption and Change Management Framework: This framework provides a structured approach to driving adoption and change, including defining success criteria, engaging stakeholders, preparing the organization, and measuring success. It emphasizes the importance of communication, training, and support to ensure that access controls are effectively adopted and institutionalized.
By incorporating these ACM methodologies and best practices, organizations can ensure that access controls are not only implemented but also embraced by employees, leading to a more secure and compliant enterprise environment.

3. Incorporating and Adopting Associated Standards

Developing and adopting associated standards is essential for ensuring the consistent implementation of encryption and access controls. Organizations should establish clear guidelines and best practices for using encryption and access controls, and ensure that these standards are communicated to all employees. For example, a standard might specify that all sensitive data must be encrypted using AES-256 encryption, and that access to this data must be restricted to authorized personnel only. By incorporating these standards into the organization's policies and procedures, and providing regular training and support, organizations can ensure that encryption and access controls are consistently applied across the enterprise. Other examples include:

Encryption: An organization might use Azure Disk Encryption to encrypt the virtual machines hosting their sensitive data. This ensures that even if the physical disks are compromised, the data remains protected.
Access Controls: The organization could implement role-based access control (RBAC) to restrict access to sensitive data. For instance, only employees in the finance department might have access to financial records, while HR personnel have access to employee records.
Standards Adoption: The organization might develop a standard that requires all emails containing sensitive information to be encrypted using Azure Information Protection. This ensures that sensitive data is protected during transmission and can only be accessed by authorized recipients.
Summary

Adopting the confidentiality principle of the CIA Triad in enterprise cloud environments involves implementing robust encryption and secure access controls to protect sensitive information from unauthorized access. Comprehensive encryption solutions safeguard data at rest and in transit while developing and adopting access controls, information protection and associated standards and best practices ensures consistent application of security measures across the enterprise. Effective adoption and change management (ACM) methodologies are crucial for ensuring that access controls are embraced by employees and integrated into the organization's culture. By focusing on these strategies, organizations can effectively institutionalize the confidentiality principle and enhance their overall security posture.

Provide a similar link to the “Adoption” CAF overview, similar to those at the end of the other sections

## Govern: Establish policies that continuously monitor and enforce data confidentiality

Effective governance is crucial for maintaining security and compliance in enterprise cloud environments. Governance encompasses the policies, procedures, and controls that ensure data is managed securely and in accordance with regulatory requirements. It provides a framework for decision-making, accountability, and continuous improvement, which is essential for protecting sensitive information and maintaining trust. This framework is particularly important for upholding the principle of confidentiality from the CIA Triad, ensuring that sensitive data is accessible only to authorized users and processes.

1. Policies and Their Applicability to Secure Data

Effective governance in cloud environments begins with robust policies that define how data should be handled, accessed, and protected. While technical policies are crucial, they must be supported by authoritative written policies, standard operating procedures (SOPs), and guidance documents. These provide the framework, requirements, and associated parameters that technical policies must adhere to and enforce.

Technical Policies: These include access control policies, data encryption policies, and data masking/tokenization policies. The intent behind these policies is to create a secure environment where data confidentiality is maintained through stringent access controls and robust encryption methods.
Written Policies: Written policies act as the governing framework for the entire enterprise environment. They establish the requirements and parameters for data handling, access, and protection. These documents ensure consistency and compliance across the organization, providing clear guidelines for employees and IT staff. Written policies also serve as a reference point for audits and assessments, helping to identify and address any gaps in security practices.
Authoritative Documentation: Having documentation that has been vetted and approved by the organization’s leadership is essential. This documentation provides clear direction and guidance for the maintenance and lifecycle management of the enterprise cloud environment. It ensures that all policies and procedures are aligned with the organization’s strategic goals and regulatory requirements. Not all policies lend themselves to automation but instead require consistent human interaction, such as incident response plans, data classification and handling procedures, and regular security training and awareness programs. These policies ensure that human oversight and judgment are applied to critical security processes, maintaining a high level of vigilance and adaptability.
2. Modern Service Management (MSM)

Modern Service Management (MSM) encompasses a set of practices and tools designed to manage and optimize IT services in a cloud environment. MSM focuses on aligning IT services with business needs, ensuring efficient service delivery, and maintaining high standards of security and compliance. It is useful because it provides a structured approach to managing complex cloud environments, enabling organizations to respond quickly to changes, mitigate risks, and ensure continuous improvement. MSM is particularly relevant to the principle of confidentiality, as it includes tools and practices that enforce data protection and monitor access controls.

Unified Security Management: MSM tools offer comprehensive security management, integrating various security functions to provide a holistic view of the cloud environment. This helps in enforcing security policies and detecting and responding to threats in real-time.
Policy Management and Compliance: MSM facilitates the creation, enforcement, and monitoring of policies across the cloud environment. It ensures that all resources comply with organizational standards and regulatory requirements, providing real-time insights and alerts.
Continuous Monitoring and Improvement: MSM emphasizes continuous monitoring of the cloud environment to identify and address potential issues proactively. This approach supports ongoing optimization and improvement of IT services, ensuring they remain aligned with business objectives.
3. Monitoring Compliance and Methods of Enforcement

Monitoring compliance and enforcing policies are critical for maintaining the principle of confidentiality in enterprise cloud environments. These processes ensure that all security measures are consistently applied and effective, protecting sensitive data from unauthorized access and breaches. Regular assessments, automated monitoring, and comprehensive training programs are essential to ensure adherence to established policies and procedures.

Regular Audits and Assessments: Conducting regular security audits and assessments ensures that policies are being followed and identifies areas for improvement. These audits should cover regulatory, industry, and organizational standards and requirements, and may involve third-party assessors to provide an unbiased evaluation. An approved assessment and inspection program helps maintain high standards of security and compliance, ensuring that all aspects of data confidentiality are thoroughly reviewed and addressed.
Automated Compliance Monitoring: Tools like Azure Policy automate the monitoring of compliance with security policies, providing real-time insights and alerts. Automated monitoring helps detect and respond to policy violations quickly, reducing the risk of data breaches. It also ensures continuous compliance by regularly checking configurations and access controls against established policies.
Training and Awareness Programs: Educating employees about data confidentiality policies and best practices is essential for fostering a security-conscious culture. Regular training sessions and awareness programs help ensure that all staff members understand their roles and responsibilities in maintaining data confidentiality. These programs should be updated regularly to reflect changes in policies and emerging threats, ensuring that employees are always equipped with the latest knowledge and skills.
Summary

Effective governance is the cornerstone of maintaining security and compliance in enterprise cloud environments. It encompasses a comprehensive framework of policies, procedures, and controls that ensure data is managed securely and in accordance with regulatory requirements. The components of governance further enhance this framework by offering tools and methodologies for continuous monitoring, policy enforcement, and compliance management. These practices ensure that security measures are consistently applied and effective, protecting sensitive data from unauthorized access and breaches. By integrating robust governance practices with advanced tools and continuous monitoring, organizations can uphold the principle of confidentiality, safeguarding their data and maintaining trust. For more detailed guidance on governance in cloud environments, you can refer to Microsoft’s Azure Governance documentation.

For more information on governance for cloud adoption please refer to the following article:

## Manage

1. Regular Monitoring and Auditing

To ensure the integrity of confidentiality policies, it is essential to establish a regular drumbeat for both monitoring and auditing. Continuous monitoring helps in the early detection of potential security threats and anomalies. However, monitoring alone is insufficient. Regular audits are necessary to verify that the policies and controls in place are effective and being adhered to. Audits provide a comprehensive review of the security posture and help identify any gaps or weaknesses that need to be addressed.

2. Documenting and Institutionalizing Audit Procedures

Documenting audit procedures is crucial for consistency and accountability. Institutionalizing these procedures ensures that audits are conducted systematically and regularly. Detailed documentation should include the scope of the audit, methodologies, tools used, and the frequency of audits. This not only helps in maintaining a high standard of security but also provides a clear trail for compliance and regulatory purposes.

3. Continuous Improvement

Continuous improvement is essential for maintaining and enhancing confidentiality in enterprise cloud environments. Documenting the results of configuration management (CM) and audits/inspections is crucial. This documentation provides a historical record that can be analyzed to identify trends, recurring issues, and areas for improvement.

Implementing lessons learned from past inspections is equally important. By analyzing the outcomes of previous audits and inspections, organizations can identify weaknesses and implement corrective actions to prevent similar issues in the future. This proactive approach ensures that the organization continuously evolves and improves its security posture.

Real-time monitoring plays a critical role in continuous improvement. By leveraging real-time data, organizations can quickly identify and respond to potential threats, ensuring that security measures are always up-to-date and effective. This dynamic approach helps avoid repeating past mistakes and ensures that the organization remains resilient against emerging threats.

4. Some Best Practices for Enhancing Confidentiality

Separation of Duties (SoD): Implementing SoD helps prevent conflicts of interest and reduces the risk of fraud. By dividing responsibilities among different individuals, it ensures that no single person has control over all aspects of a critical process.
Least Privilege: This principle involves granting users the minimum level of access necessary to perform their job functions. By limiting access rights, the potential damage from insider threats or compromised accounts is minimized.
Zero Trust: Adopting a Zero Trust model means that no entity, whether inside or outside the network, is trusted by default. Every access request is verified, and continuous authentication and authorization are enforced. This approach significantly enhances the confidentiality of data in the cloud.
Proactive User Lifecycle Maintenance: Regularly updating and managing user accounts is vital. This includes promptly revoking access for users who no longer need it, updating permissions as roles change, and ensuring that inactive accounts are disabled. Proactive maintenance helps prevent unauthorized access and ensures that only current, authorized users have access to sensitive data.
Summary

Maintaining confidentiality in enterprise cloud environments requires a multifaceted approach that combines continuous monitoring, regular auditing, and adherence to best practices. By establishing a regular drumbeat for monitoring and auditing, documenting and institutionalizing audit procedures, and focusing on continuous improvement, organizations can significantly enhance the confidentiality of their cloud environments. These measures ensure that sensitive data remains protected against unauthorized access and breaches, thereby maintaining the trust and integrity of the enterprise.

For more information on cloud management in the CAF please refer to the following article:

## Secure

In enterprise cloud environments, keeping sensitive information secure is crucial. Confidentiality involves protecting sensitive information from unauthorized access and breaches. As enterprises increasingly migrate to cloud environments, leveraging cloud-native capabilities becomes essential to uphold this principle. Microsoft Azure offers a robust suite of tools and services designed to enhance security and maintain confidentiality.

Securing the Enterprise Cloud Environment

Organizational, industry, and regulatory requirements, standards, and best practices are essential, fundamental areas to consider in securing your enterprise cloud environment. They directly impact the security and confidentiality of data and workloads and require strong controls to ensure the proper protections. Below are key areas of consideration and examples of how Microsoft Azure provides cloud-native tools to support them:

1. Data Encryption:

At Rest: Azure provides encryption for data at rest using Azure Storage Service Encryption (SSE). This ensures that data stored in Azure is automatically encrypted and decrypted transparently using 256-bit AES encryption.
In Transit: Azure enforces encryption for data in transit using Transport Layer Security (TLS). This protects data as it moves between clients and Azure services.
2. Identity and Access Management:

Microsoft Entra ID: Formerly known as Azure Active Directory, Microsoft Entra ID offers comprehensive identity and access management capabilities. It supports multi-factor authentication (MFA), conditional access policies, and single sign-on (SSO) to ensure that only authorized users can access sensitive data.
Role-Based Access Control (RBAC): Azure RBAC allows fine-grained access management for Azure resources, ensuring that users have only the permissions they need to perform their tasks.
3. Confidential Computing:

Azure Confidential Computing: This service protects data while it is being processed. It uses hardware-based trusted execution environments (TEEs) to isolate and protect data in use, ensuring that even cloud administrators cannot access the data.
4. Network Security:

Azure Firewall: A cloud-native, intelligent network firewall security service that provides threat protection for cloud workloads. It offers built-in high availability and unrestricted cloud scalability.
Azure DDoS Protection: This service protects applications by monitoring and automatically mitigating network attacks, ensuring the confidentiality and availability of data.
5. Monitoring and Threat Detection:

Microsoft Defender for Cloud: This comprehensive security management solution provides advanced threat protection across hybrid cloud environments. It continuously assesses security posture, protects against threats, and provides actionable insights to mitigate risks.
6. Compliance and Governance:

Azure Policy: This service helps enforce organizational standards and assess compliance at scale. It allows the creation of policies to ensure that resources are compliant with corporate standards and regulatory requirements.
By integrating these Microsoft cloud-native capabilities, enterprises can significantly enhance the confidentiality of their cloud environments. These tools not only protect sensitive data from unauthorized access but also provide robust mechanisms for monitoring, threat detection, and compliance, ensuring a secure and trustworthy cloud infrastructure.

For more information on security in the CAF for Azure please refer to the following article:

## References - TBD

- https://www.microsoft.com/en-us/security/business/security-101/what-is-cspm

## Azure facilitation

- Purview data security https://learn.microsoft.com/en-us/purview/purview-security
- 