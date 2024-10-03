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

Security governance bridges your business priorities with technical implementation like architecture, standards, and policy. Governance teams provide oversight and monitoring to sustain and improve security posture over time. These teams also report compliance as required by regulating bodies.

:::image type="content" source="./media/governance-structure.png" alt-text="Security Governance" lightbox="./media/governance-structure-popout.png":::

**Business goals and risk** provide the best direction for security. This direction ensures that security focuses their efforts on important matters for the organization. It also informs risk owners using familiar language and processes in the risk management framework.

This article is a supporting guide to the [Govern](../govern/index.md) methodology, offering areas of security optimization that should be considered as you move through that phase in your journey.

## Security posture modernization

Hope and reporting problems isn't a plan. Governance in the cloud age must have an active component that continuously engages with other teams. Security posture management is an emerging function. It represents a step forward in the long-term convergence of security functions. These functions answer the question "how secure is the environment?", including vulnerability management and security compliance reporting.

In the on-premises world, security governance followed the cadence of data it could get about the environment. This way of getting data might take time and be constantly out of date. Cloud technology now provides on-demand visibility into the current security posture and asset coverage. This visibility drives a major transformation of governance into a more dynamic organization. This organization provides a closer relationship to other security teams to monitor security standards, provide guidance, and improve processes.

In its ideal state, governance is the heart of continuous improvement. This improvement engages across your organization to constantly improve security posture.

The key tenets of success for governance are:

- **Continuous discovery of assets and asset types:** A static inventory isn't possible in a dynamic cloud environment. Your organization must focus on the continuous discovery of assets and asset types. In the cloud, new types of services are added regularly. Workload owners dynamically spin up and down instances of applications and services as needed, making inventory management a dynamic discipline. Governance teams need to continuously discover asset types and instances to keep up with this pace of change.

- **Continuous improvement of asset security posture:** Governance teams should focus on improving standards, and enforcement of those standards, to keep up with the cloud and attackers. Information technology (IT) organizations must react quickly to new threats and adapt accordingly. Attackers are continuously evolving their techniques, and defenses are continuously improving and might need to be enabled. You can't always get all the security you need into the initial configuration.

- **Policy-driven governance:** This governance provides consistent execution by fixing something once in policy that's automatically applied at scale across resources. This process limits any wasted time and effort on repeated manual tasks. It's often implemented using Azure Policy or third-party policy automation frameworks. 

To maintain agility, best practices guidance is often iterative. It digests small pieces of information from multiple sources to create the whole picture and continuously make small adjustments.

### Azure facilitation

- [Microsoft Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction) can help you continuously discover and automatically manage virtual machines in your environment through automatic data collection provisioning.

- [Microsoft Defender for Cloud Apps](/azure/defender-for-cloud/defender-for-cloud-introduction) can help you continuously discover and govern first-party and third-party software-as-service (SaaS) apps being used in your environments.

## Incident preparedness and response

Security governance is critical for maintaining your preparedness. Implementing preparedness and response mechansims and operational practices must be bolstered by strong governance mechanisms and practices to ensure that standards are adhered to with strict enforcement. Consider the following recommendations to help govern incident preparedness and response standards:

### Incident preparedness governance

- **Automate governance:** Embrace tooling to automate governance to the extent practical. Tooling can help you manage policies for infrastructure deployments and hardening measures, data protection, and identity and access (IAM) standards. Automating the governance of these security measures will help ensure that your all resources in your environments are compliant with your own security standards and any compliance frameworks that are required for your business. Review the Govern methodology's [guidance](../govern/enforce-cloud-governance-policies#azure-facilitation-enforcing-cloud-governance-policies-automatically) for additional recommendations.

- **Adhere to Microsoft's security baselines:** Understand Microsoft's security recommendations for the services in your cloud estate, published as [security baselines](/security/benchmark/azure/security-baselines-overview). These baselines help you ensure that you're existing deployments are secured properly and new deployments are configured properly at the outset, while reducing the risk of misconfigurations.

### Incident repsonse governance

- **Governance of the incident response plan:** The incident response plan should be maintained with same care as other critical documents in your estate. 
 
    - It should be version controlled to ensure that teams are working off of the most recent version, and the versioning can be audited.
 
    - It should be stored in highly available and secure storage.

    - It should be reviewed on a regular cadence and updated when changes to the environment necessitate it.

- **Governance of incident response training:** Training materials for incident response should also be version-controlled for auditability and ensuring that the most recent version is being used at any given time. They should also be reviewed on a regular cadence and updated when updates to the incident response plan are made.

### Azure facilitation

- [Azure Policy](/azure/governance/policy) is a policy management solution that helps enforce organizational standards and to assess compliance at-scale. Take advantage of [built-in policy definitions](/azure/governance/policy/samples/built-in-policies) to automate policy enforcement for many Azure services.

- [Microsoft Defender for Cloud](/azure/defender-for-cloud/security-policy-concept) provides security policies that can automate compliance with your security standards.

## Conifidentiality governance

Effective governance is crucial for maintaining security and compliance in enterprise cloud environments. Governance encompasses the policies, procedures, and controls that ensure data is managed securely and in accordance with regulatory requirements. It provides a framework for decision-making, accountability, and continuous improvement, which is essential for protecting sensitive information and maintaining trust. This framework is particularly important for upholding the principle of confidentiality from the CIA Triad, ensuring that sensitive data is accessible only to authorized users and processes.

- *Technical policies:* These include access control policies, data encryption policies, and data masking/tokenization policies. The intent behind these policies is to create a secure environment where data confidentiality is maintained through stringent access controls and robust encryption methods.

- *Written policies:* Written policies act as the governing framework for the entire enterprise environment. They establish the requirements and parameters for data handling, access, and protection. These documents ensure consistency and compliance across the organization, providing clear guidelines for employees and IT staff. Written policies also serve as a reference point for audits and assessments, helping to identify and address any gaps in security practices.

- *Data Loss Protection:* Continuous monitoring and auditing of DLP measures should be conducted to ensure ongoing compliance with confidentiality requirements. This includes regularly reviewing and updating DLP policies, conducting security assessments, and responding to any incidents that may compromise data confidentiality. Establishing DLP programmatically across the organization ensures a consistent and scalable approach to protecting sensitive data.

3. **Monitoring compliance and methods of enforcement**

Monitoring compliance and enforcing policies are critical for maintaining the principle of confidentiality in enterprise cloud environments. These processes ensure that all security measures are consistently applied and effective, protecting sensitive data from unauthorized access and breaches. Regular assessments, automated monitoring, and comprehensive training programs are essential to ensure adherence to established policies and procedures.

- *Regular audits and assessments:* Conducting regular security audits and assessments ensures that policies are being followed and identifies areas for improvement. These audits should cover regulatory, industry, and organizational standards and requirements, and may involve third-party assessors to provide an unbiased evaluation. An approved assessment and inspection program helps maintain high standards of security and compliance, ensuring that all aspects of data confidentiality are thoroughly reviewed and addressed.

- *Automated compliance monitoring:* Tools like [Azure Policy](/azure/governance/policy/overview) automate the monitoring of compliance with security policies, providing real-time insights and alerts. Automated monitoring helps detect and respond to policy violations quickly, reducing the risk of data breaches. It also ensures continuous compliance by regularly checking configurations and access controls against established policies.

- *Training and awareness programs:* Educating employees about data confidentiality policies and best practices is essential for fostering a security-conscious culture. Regular training sessions and awareness programs help ensure that all staff members understand their roles and responsibilities in maintaining data confidentiality. These programs should be updated regularly to reflect changes in policies and emerging threats, ensuring that employees are always equipped with the latest knowledge and skills.

## Integrity governance

Ensuring that your integrity protections are properly maintained requires a well-designed governance strategy that ensures all polices and procedures are documented and enforced and that all systems involved are continuously audited for compliance. 

The guidance provided above in the Confidentialiy governance section also applies to the principle of integrity. Some additional recommendations specific to integrity are:

- **Automated data quality governance:** Consider using an off-the-shelf solution to govern your data. Using a pre-built solution relieves your data governance team burden of manual quality validation and reduces the risk of unauthorized access and alterations to data when performing quality validation.

- **Automated system integrity governance:** Consider using a centralized, unified tool to automate your system integrity governance. For example, [Azure Arc](/azure/azure-arc/overview) allows you to govern systems across multiple clouds, on-premises data centers, and edge sites. Using a system like this can simplify your governance responsibilities and reduce operational burden.

### Azure facilitation

- [Microsoft Purview Data Quality](/purview/data-quality-overview) offers users the ability to evaluate data quality using no-code/low-code rules, including out-of-the-box (OOB) rules and AI-generated rules. These rules are applied at the column level and aggregated to provide scores at the levels of data assets, data products, and business domains, ensuring end-to-end visibility of data quality within each domain.

## Availability governance

The architecture designs that you standardize in your cloud estate require governance to ensure that they aren't deviated from and your availability isn't compromised by nonconforming design patterns. Likewise, your disaster recovery plans must also be governed to ensure that they are well-maintained.

### Availability design governance

- **Maintaining standardized design patterns:** Infrastructure and application design patterns should be codified and strictly enforced. Maintainence of those standards of design must be governed to keep them up-to-date and safe from unauthorized access or alteration. As such, these standards should be treated with the same care as other policies.

 - When possible, automate the enforcement of maintaining design patterns. For example, you can enable policies to control the types of resources that are allowed to be deployed and the regions where deployments are allowed.  

### Disaster recovery governance

- **Governance of the disaster recovery plans:** Disaster recovery plans should be treated with the same criticality as incident response plans:

    - They should be version controlled to ensure that teams are working off of the most recent version, and the versioning can be audited.

    - They should be stored in highly available and secure storage.

    - They should be reviewed on a regular cadence and updated when changes to the environment necessitate it.

- **Governance of disaster recovery drills:** Disaster recovery drills are not only for training on the plans, they are also learning opportunities to improve the plan itself and potentially for operational or design standards. Meticulous record keeping of disaster recovery drills will help find areas for improvement and will satisfy compliance requiements for auditing of disaster preparedness. Storing records of drills in the same repository as plans helps keep things organized and secure.

## Sustaining secure governance

### Modern Service Management (MSM)

Modern Service Management (MSM) encompasses a set of practices and tools designed to manage and optimize IT services in a cloud environment. MSM focuses on aligning IT services with business needs, ensuring efficient service delivery, and maintaining high standards of security and compliance. It is useful because it provides a structured approach to managing complex cloud environments, enabling organizations to respond quickly to changes, mitigate risks, and ensure continuous improvement. MSM is particularly relevant to the principle of confidentiality, as it includes tools and practices that enforce data protection and monitor access controls.

- *Unified security management:* MSM tools offer comprehensive security management, integrating various security functions to provide a holistic view of the cloud environment. This helps in enforcing security policies and detecting and responding to threats in real-time.

- *Policy management and compliance:* MSM facilitates the creation, enforcement, and monitoring of policies across the cloud environment. It ensures that all resources comply with organizational standards and regulatory requirements, providing real-time insights and alerts.

- *Continuous monitoring and improvement:* MSM emphasizes continuous monitoring of the cloud environment to identify and address potential issues proactively. This approach supports ongoing optimization and improvement of IT services, ensuring they remain aligned with business objectives.

## Next step

> [!div class="nextstepaction"]
> [Securely manage your cloud estate](./refresh-manage-consolidated.md)