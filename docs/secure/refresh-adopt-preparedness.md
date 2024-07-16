---
title: Adopt preparedness
description: Learn how to prepare for and react to security incidents.
author: claytonsiemens77
ms.author: csiemens
ms.date: 06/24/2024
ms.topic: conceptual
ms.custom: internal, UpdateFrequency2
---

# Adopt preparedness

## Introduction

How an organization handles security threats and incidents is a direct indication of how well it has built its preparedness measures. Preparedness should be the cornerstone of your security strategy and continually evaluated and improved. 

This article defines an approach to preparedness that will help ensure your organization is fully prepared to address and mitigate security threats in its cloud environment. By implementing comprehensive training, rigorous security protocols, and robust incident response plans, the organization strengthens its defenses against cyber threats, ensuring it can rapidly and effectively respond to security incidents and maintain continuity of operations.

## Strategy

Establish a clear vision and well-defined, specific objectives for cloud security readiness, focusing on building security capacity and developing security skills. For example, one of your objectives might be achieving ISO/IEC 27001 certification, and your plan should include concrete steps to achieve that goal. Focus on achievable, realistic goals that align to business and technology requirements.

Refer to the [Define a security strategy](/azure/cloud-adoption-framework/strategy/define-security-strategy) article for throrough guidance.

## Plan

A key tenet of preparedness is continuous improvement. In order to be able to improve, you must first thoroughly understand your current security posture to establish your baseline and move towards finding areas for improvement. 

The [Zero trust framework modernization guide](/security/zero-trust/adopt/rapidly-modernize-security-posture#technical-plans-and-skills-readiness) offers a four-staged approach to defining your baseline and planning your continuous improvement strategies.

### Establishing a secure cloud estate

- **Landing zones:** Develop secure, scalable landing zones that provide controlled environments for deploying cloud resources. These zones ensure that security policies are consistently applied and that resources are segregated according to their security requirements. Refer to the [security design area](/azure/cloud-adoption-framework/ready/landing-zone/design-area/security) for detailed guidance on this topic.

- **Network segmentation:** Design a network architecture with proper segmentation and isolation to minimize attack surfaces and contain potential breaches. Use techniques such as virtual private clouds (VPCs), subnets, and security groups to manage and control traffic. Refer to the [Plan for network segmentation](/azure/cloud-adoption-framework/ready/azure-best-practices/plan-for-landing-zone-network-segmentation) article for detailed guidance on this topic.

- **Security baselines:** Understand Microsoft's security recommendations for the services in your cloud estate, published as [security baselines](/security/benchmark/azure/security-baselines-overview). These baselines help you ensure that you're existing deployments are secured properly and new deployments are configured properly at the outset, while reducing the risk of misconfigurations.

### Threat readiness and mitigation

- **Incident response:** Develop and maintain an incident response plan that includes detection, analysis, and remediation steps to quickly address and recover from security incidents. Refer to the Well-Architected Framework [incident response](/azure/well-architected/security/incident-response) guide for workload-focused guidance on this topic.

- **Threat detection:** Implement advanced monitoring tools and practices to detect threats in real-time. This includes setting up alert systems for unusual activities and integrating eXtended detection and response (XDR) security information and event management (SIEM) solutions. Refer to the [Zero trust threat protection and XDR](/security/zero-trust/adopt/prevent-reduce-business-damage-breach-threat-protection) guide for detailed guidance on this topic.

- **Vulnerability management:** Regularly identify and mitigate vulnerabilities through patch management and security updates to ensure that systems and applications are protected against known threats.

### Security policies and compliance

- **Governance and compliance:** Ensure the cloud environment adheres to regulatory requirements and internal security policies. Implement governance frameworks that provide guidelines for data handling, privacy, and security controls. Refer to the [security governance](/refresh-security-governance.md) article for detailed guidance on this topic.

- **Identity, authorization, and access management:** Apply role-based access control (RBAC), identity and access management (IAM), and least privilege principles to secure access to cloud resources. Regularly review and update access policies to ensure they meet the evolving security landscape. Refer to the [Zero trust identity technology pillar](/security/zero-trust/deploy/identity) guide for detailed guidance on this topic.

- **Data protection:** Enforce data encryption, both at rest and in transit, along with data loss prevention (DLP) strategies to protect sensitive information and ensure data integrity. Refer to the [Zero trust data technology pillar](/security/zero-trust/deploy/data) guide for detailed guidance on this topic.

### Infrastructure and application security

- **Secure deployment pipelines:** Build CI/CD pipelines with integrated security checks to ensure that applications are securely developed, tested, and deployed. This includes static code analysis, vulnerability scanning, and compliance checks. For detailed guidance, refer to the [Zero trust developer guidance](/security/zero-trust/develop/overview) for detailed articles on this topic.

- **Infrastructure as Code (IaC):** Use Infrastructure as Code (IaC) to manage and automate the deployment of cloud infrastructure. Incorporate security best practices into IaC templates to maintain consistent and secure configurations. Refer to the Well-Architected Framework [IaC guide](/security/zero-trust/develop/overview) for workload-focused guidance that can be broadly applied.

- **Container security:** Implement robust security measures for containerized applications including:
    - Image scanning for vulnerabilities
    - Using a private registry
    - Enforcing runtime security policies
    - Managing container orchestration security
    - Enforce network security

Refer to the [Security for Azure Container Instances](/container-instances/container-instances-image-security) for more details on these recommendations.

### Operational readiness

- **Continuous monitoring and auditing:** Establish continuous monitoring for security events and regular auditing to ensure compliance and maintain an up-to-date security posture. Use tools that provide visibility into cloud resources and help detect potential security issues. Refer to the [Zero trust visibility, automation, and orchestration guide](/security/zero-trust/deploy/visibility-automation-orchestration) for detailed guidance on this topic.

- **Disaster recovery and business continuity:** Develop and test disaster recovery plans to ensure that the cloud environment is resilient and can quickly recover from incidents. Include backup and recovery strategies that support business continuity. In many cases, having workload-based plans is a good strategy rather than a single plan that covers all facets of the business. Refer to the Well-Architected [disaster recovery](/azure/well-architected/reliability/disaster-recovery) guide for workload-focused guidance on this topic.

## Training

### Role-based training

Implement role-specific training programs that equip staff with the knowledge and skills needed to address security threats relevant to their positions. Training should be tailored for the roles detailed in the [Teams and roles](./refresh-teams-and-roles.md) article, ensuring they are proficient in network security, system hardening, and policy enforcement. Incident Response Coordinators should be trained on incident management procedures, leveraging pre-planned responses such as Standard Operating Procedures (SOPs) and Incident Playbooks to respond systematically and efficiently to security threats. Risk management roles focus on risk assessment and mitigation strategies. Executive leaders, such as the CISO and members of the Cloud Governance Team, should understand strategic security planning and compliance requirements, emphasizing their role in fostering a security-conscious culture

### Continuous education

Encourage ongoing education and certification in cloud security practices to stay abreast of evolving threats and technologies. This training should cover:

- **Threat detection:** Use advanced analytics and monitoring tools like Microsoft Sentinel to detect threats early, emphasizing continuous monitoring and proactive identification of threats. Advanced analytics enable the identification of unusual patterns and behaviors that may indicate potential security threats, while integrated threat intelligence provides up-to-date information on known threats, enhancing the system's ability to detect emerging risks. Include training on pre-planned responses such as automated actions for containment to ensure rapid reaction to detected threats.
- **Incident response:** Train the Security Operations Team on robust incident response strategies that integrate Zero Trust principles, assuming threats can come from both internal and external sources. This includes continuous verification of identities and securing access to resources. Training should also cover the use of decision trees and flowcharts to guide response actions based on the specific incident scenarios.
- Data Protection: Provide comprehensive education on data protection, emphasizing the CIA Triad's principles to ensure a thorough understanding of data security approaches:
    - **Confidentiality:** Teach the importance of implementing encryption and strict access controls to protect sensitive information from unauthorized access. Training should cover best practices in data encryption technologies and access management tools to ensure only authorized personnel can access sensitive data.
    - **Integrity:** Educate on the use of DevOps processes for infrastructure as code (IaC) to ensure data accuracy and reliability. DevOps practices, such as version control, continuous integration, and automated testing, help track, audit, and validate changes to the cloud environment's infrastructure before deployment. This is particularly important in maintaining landing zones, as it ensures consistency and integrity in the configuration by providing a systematic way to handle infrastructure changes.
    - **Availability:** Instruct on deploying high availability and disaster recovery solutions using Azure’s services to ensure data and resources remain accessible when needed. This includes maintaining pre-planned responses that outline the steps for maintaining availability during an incident. Education should cover strategies for ensuring continuous access to critical resources, even in the face of disruptions, and include hands-on training in setting up and managing Azure’s high availability and disaster recovery tools.
- **Simulation exercises:** Conduct regular security drills and simulations to prepare the team for real-world scenarios. These exercises should evaluate the organization's ability to respond to incidents within the Zero Trust framework, treating all network segments as potentially compromised until verified secure. Scenarios such as phishing attacks, data breaches, and ransomware should be simulated to identify gaps in response strategies and provide hands-on experience in handling incidents. Drills should emphasize containment strategies by quickly isolating compromised systems to prevent further spread, rapid communication by establishing clear and efficient channels for disseminating information, and evidence preservation by ensuring that all relevant data is securely collected and stored to support subsequent analysis and investigation. Use pre-planned responses like incident playbooks and communication protocols to ensure that actions during these drills are consistent and systematic.
- **Incident response drills:** Regularly test incident response plans through realistic drills that simulate various threat scenarios. These drills should involve all relevant stakeholders, including the Security Operations Center (SOC) Team, Incident Response Coordinators, Governance Lead, Incident Controller, Investigation Lead, Infrastructure Lead, and the Cloud Governance Team, ensuring comprehensive preparedness across the organization. Incorporate elements of the CIA Triad and Zero Trust principles into these drills, such as testing the effectiveness of access controls (Confidentiality), integrity checks for critical data, and procedures for maintaining service availability during an incident. Emphasize effective coordination by ensuring clear communication and collaborative efforts across teams, using pre-planned responses such as predefined roles and responsibilities, and rapid containment by swiftly isolating affected systems and mitigating threats. Ensure detailed documentation of actions taken to provide a clear record for post-incident review and continuous improvement. 

## Resources

- [Zero trust framework modernization guide](/security/zero-trust/adopt/rapidly-modernize-security-posture#technical-plans-and-skills-readiness)

- [Zero trust threat protection and XDR guide](/security/zero-trust/adopt/prevent-reduce-business-damage-breach-threat-protection)

- [Zero trust visibility, automation, and orchestration guide](/security/zero-trust/deploy/visibility-automation-orchestration)

- [Zero trust developer guidance](/security/zero-trust/develop/overview)

- [Zero trust identity technology pillar](/security/zero-trust/deploy/identity)

- [Zero trust data technology pillar](/security/zero-trust/deploy/data)

- [Well-Architected Framework incident response guide](/azure/well-architected/security/incident-response)

- [Well-Architected disaster recovery guide](/azure/well-architected/reliability/disaster-recovery)

- [Microsoft's incident response team's best practices guidance](https://www.microsoft.com/en-us/security/blog/2023/12/11/new-microsoft-incident-response-team-guide-shares-best-practices-for-security-teams-and-leaders/)

### Azure facilitation

**Azure Monitor** provides observability across your entire environment. With no configuration, you automatically get platform metrics, activity logs, and diagnostics logs from most of your Azure resources. The activity logs provide detailed diagnostic and auditing information.

> [!NOTE] 
> Platform logs aren't available indefinitely. You need to keep them so that you can review them later for auditing purposes or offline analysis. Use Azure storage accounts for long-term/archival storage. In Azure Monitor, specify a retention period when you enable diagnostic settings for your resources.

Set up alerts based on predefined or custom metrics and logs to get notifications when specific security-related events or anomalies are detected.

For more information, see [Azure Monitor documentation](/azure/azure-monitor/).

**Microsoft Defender for Cloud** provides built-in capabilities for threat detection. It operates on collected data and analyzes logs. Because it's aware of the types of logs generated, it can use built-in rules to make informed decisions. For example, it checks lists of potentially compromised IP addresses and generates alerts.

Enable built-in threat protection services for Azure resources. For example, enable Microsoft Defender for Azure resources, like virtual machines, databases, and containers, to detect and protect against known threats.

Defender for Cloud provides cloud workload protection platform (CWPP) capabilities for threat detection of all workload resources.

For more information, see [What is Microsoft Defender for Cloud?](/azure/defender-for-cloud/defender-for-cloud-introduction).

Alerts generated by Defender can also feed into SIEM systems. **Microsoft Sentinel** is the native offering. It uses AI and machine learning to detect and respond to security threats in real time. It provides a centralized view of security data and facilitates proactive threat hunting and investigation.

For more information, see [What is Microsoft Sentinel?](/azure/sentinel/overview).

Microsoft Sentinel can also use threat intelligence feeds from various sources. For more information, see [Threat intelligence integration in Microsoft Sentinel](/azure/sentinel/threat-intelligence-integration).

Microsoft Sentinel can analyze user behavior from monitoring data. For more information, see [Identify advanced threats with User and Entity Behavior Analytics (UEBA) in Microsoft Sentinel](/azure/sentinel/identify-threats-with-entity-behavior-analytics).

Defender and Microsoft Sentinel work together, despite some overlap in functionality. This collaboration enhances your overall security posture by helping to ensure comprehensive threat detection and response.

Take advantage of **Azure Business Continuity Center** to identify gaps in your business continuity estate and defend against threats like ransomware attacks, malicious activities, and rogue-administrator incidents. For more information, see [What is Azure Business Continuity Center?](/azure/business-continuity-center/business-continuity-center-overview).
