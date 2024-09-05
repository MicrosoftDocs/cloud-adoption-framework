---
title: Securely govern your cloud estate
description: Learn how to adopt security best practices in your cloud estate governance phase
author: claytonsiemens77
ms.author: csiemens
ms.date: 06/24/2024
ms.topic: conceptual
ms.custom: internal, UpdateFrequency2
---

# Securely govern your cloud estate

## Introduction

## Security posture modernization

- **Automate governance:** Embrace tooling to automate governance to the extent practical. Tooling can help you manage policies for infrastructure deployments and hardening measures, data protection, and identity and access (IAM) standards.

## Incident preparedness and response

Security governance is critical for maintaining your preparedness. Implementing preparedness and response mechansims and operational practices must be bolstered by strong governance mechanisms and practices to ensure that standards are adhered to with strict enforcement. The following recommendations can help you establish your governance strategy.

### Security policies and compliance

- **Governance and compliance:** Ensure the cloud environment adheres to regulatory requirements and internal security policies. Implement governance frameworks that provide guidelines for data handling, privacy, and security controls. Refer to the  article for detailed guidance on this topic.
    
    - **Policy enforcement:** Implement an automated policy management and enforcement solution, like [Azure Policy](/azure/governance/policy) to reduce the operational burden and potential for human error in implementing your governance framework.

- **Identity, authorization, and access management:** Apply role-based access control (RBAC), identity and access management (IAM), and least privilege principles to secure access to cloud resources. Regularly review and update access policies to ensure they meet the evolving security landscape. Refer to the [Zero trust identity technology pillar](/security/zero-trust/deploy/identity) guide for detailed guidance on this topic.

- **Data protection:** Enforce data encryption, both at rest and in transit, along with data loss prevention (DLP) strategies to protect sensitive information and ensure data integrity. Refer to the [Zero trust data technology pillar](/security/zero-trust/deploy/data) guide for detailed guidance on this topic.

- **Security baselines:** Understand Microsoft's security recommendations for the services in your cloud estate, published as [security baselines](/security/benchmark/azure/security-baselines-overview). These baselines help you ensure that you're existing deployments are secured properly and new deployments are configured properly at the outset, while reducing the risk of misconfigurations.

## Conifidentiality governance

Effective governance is crucial for maintaining security and compliance in enterprise cloud environments. Governance encompasses the policies, procedures, and controls that ensure data is managed securely and in accordance with regulatory requirements. It provides a framework for decision-making, accountability, and continuous improvement, which is essential for protecting sensitive information and maintaining trust. This framework is particularly important for upholding the principle of confidentiality from the CIA Triad, ensuring that sensitive data is accessible only to authorized users and processes.

1. **Policies and their applicability to secure data**

Effective governance in cloud environments begins with robust policies that define how data should be handled, accessed, and protected. While technical policies are crucial, they must be supported by authoritative written policies, standard operating procedures (SOPs), and guidance documents. These provide the framework, requirements, and associated parameters that technical policies must adhere to and enforce.

- *Technical policies:* These include access control policies, data encryption policies, and data masking/tokenization policies. The intent behind these policies is to create a secure environment where data confidentiality is maintained through stringent access controls and robust encryption methods.

- *Written policies:* Written policies act as the governing framework for the entire enterprise environment. They establish the requirements and parameters for data handling, access, and protection. These documents ensure consistency and compliance across the organization, providing clear guidelines for employees and IT staff. Written policies also serve as a reference point for audits and assessments, helping to identify and address any gaps in security practices.

- *Authoritative documentation:* Having documentation that has been vetted and approved by the organization’s leadership is essential. This documentation provides clear direction and guidance for the maintenance and lifecycle management of the enterprise cloud environment. It ensures that all policies and procedures are aligned with the organization’s strategic goals and regulatory requirements. Not all policies lend themselves to automation but instead require consistent human interaction, such as incident response plans, data classification and handling procedures, and regular security training and awareness programs. These policies ensure that human oversight and judgment are applied to critical security processes, maintaining a high level of vigilance and adaptability.
_Data Loss Protection:_ Continuous monitoring and auditing of DLP measures should be conducted to ensure ongoing compliance with confidentiality requirements. This includes regularly reviewing and updating DLP policies, conducting security assessments, and responding to any incidents that may compromise data confidentiality. Establishing DLP programmatically across the organization ensures a consistent and scalable approach to protecting sensitive data.

2. **Modern Service Management (MSM)**

Modern Service Management (MSM) encompasses a set of practices and tools designed to manage and optimize IT services in a cloud environment. MSM focuses on aligning IT services with business needs, ensuring efficient service delivery, and maintaining high standards of security and compliance. It is useful because it provides a structured approach to managing complex cloud environments, enabling organizations to respond quickly to changes, mitigate risks, and ensure continuous improvement. MSM is particularly relevant to the principle of confidentiality, as it includes tools and practices that enforce data protection and monitor access controls.

- *Unified security management:* MSM tools offer comprehensive security management, integrating various security functions to provide a holistic view of the cloud environment. This helps in enforcing security policies and detecting and responding to threats in real-time.

- *Policy management and compliance:* MSM facilitates the creation, enforcement, and monitoring of policies across the cloud environment. It ensures that all resources comply with organizational standards and regulatory requirements, providing real-time insights and alerts.

- *Continuous monitoring and improvement:* MSM emphasizes continuous monitoring of the cloud environment to identify and address potential issues proactively. This approach supports ongoing optimization and improvement of IT services, ensuring they remain aligned with business objectives.

3. **Monitoring compliance and methods of enforcement**

Monitoring compliance and enforcing policies are critical for maintaining the principle of confidentiality in enterprise cloud environments. These processes ensure that all security measures are consistently applied and effective, protecting sensitive data from unauthorized access and breaches. Regular assessments, automated monitoring, and comprehensive training programs are essential to ensure adherence to established policies and procedures.

- *Regular audits and assessments:* Conducting regular security audits and assessments ensures that policies are being followed and identifies areas for improvement. These audits should cover regulatory, industry, and organizational standards and requirements, and may involve third-party assessors to provide an unbiased evaluation. An approved assessment and inspection program helps maintain high standards of security and compliance, ensuring that all aspects of data confidentiality are thoroughly reviewed and addressed.

- *Automated compliance monitoring:* Tools like [Azure Policy](/azure/governance/policy/overview) automate the monitoring of compliance with security policies, providing real-time insights and alerts. Automated monitoring helps detect and respond to policy violations quickly, reducing the risk of data breaches. It also ensures continuous compliance by regularly checking configurations and access controls against established policies.

- *Training and awareness programs:* Educating employees about data confidentiality policies and best practices is essential for fostering a security-conscious culture. Regular training sessions and awareness programs help ensure that all staff members understand their roles and responsibilities in maintaining data confidentiality. These programs should be updated regularly to reflect changes in policies and emerging threats, ensuring that employees are always equipped with the latest knowledge and skills.

## Integrity governance

Ensuring that your integrity protections are properly maintained requires a well-designed governance strategy that ensures all polices and procedures are documented and enforced and that all systems involved are continuously audited for compliance. 

The guidance provided above in the Confidentialiy governance section also applies to integrity. Some additional recommendations specific to integrity are:

- **Automated data quality governance:** Consider using an off-the-shelf solution to govern your data. For example, [Microsoft Purview Data Quality](/purview/data-quality-overview) offers users the ability to evaluate data quality using no-code/low-code rules, including out-of-the-box (OOB) rules and AI-generated rules. These rules are applied at the column level and aggregated to provide scores at the levels of data assets, data products, and business domains, ensuring end-to-end visibility of data quality within each domain.

- **Automated system integrity governance:** Consider using a centralized, unified tool to automate your system integrity governance. For example, [Azure Arc](/azure/azure-arc/overview) allows you to govern systems across multiple clouds, on-premises data centers, and edge sites. Using a system like this can simplify your governance responsibilities and reduce operational burden.

## Availability governance

After establishing and standardizing your operational practices and implementing workloads and other operational functions, proper governance will help ensure that standards are enforced and regularly reviewed to stay up to date as your cloud estate evolves.

1. **Managing and enforcing standards:** Ensure that all standards are documented and stored in highly available and secure storage. Use version control to ensure that documentation is auditable and reviews are tracked. Enforce standards through regularly recurring mandatory incident response drills. Operators should know where to find their procedures and understand all the steps to follow as they go through their drills. Refer to the [Adopt preparedness](./refresh-adopt-preparedness.md) guide for detailed guidance on this topic. Enforce compliance requirment adherence through tooling, like [Azure Policy](/azure/policy) to reduce the risk of misconfiguration or non-compliant systems.

2. **Continuous improvement of standards:** Your cloud estate will evolve over time, and as technology evolves, so must your operational practices. Without keeping your standards up to date, you risk exposing your business to gaps that may have been introduced through the adoption of new technologies or more advanced attack techniques that come about. To protect against these risks, ensure that every standard is reviewed regularly to keep up to date. Use learnings gained from drills to inform updates to your practices. Your standards should always be considered living documents that should be improved as often as possible.

## Sustaining secure governance

- **Integrity training:** As part of your overall training strategy, ensure that employees are trained on your data and system integrity policies and procedures. This training should be mandatory for new hires, with deeper training specific to their roles for those in the security team, and should be regularly recurring for all employees.
