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

## Introduction

As you implement your cloud estate and move workloads in, having robust security mechanisms and practices in place will help ensure that your workloads will be secure at the outset and you won't have to go back and fill in security gaps once workloads are in production. Building out your security mechansims and practices should be prioritized in the Adopt phase to ensure that workloads are consistently built according to best practices and IT teams are prepared for cloud operations through well-designed policies and procedures.

The guidance provided in this article is applicable whether you're migrating workloads into the cloud or building an entirely new cloud estate. The CAF [Adopt](../adopt/index.md) methodology focuses on the following scenarios: [Migrate](../migrate), [Modernize](../modernize/), [Innovate](../innovate/), and [Relocate](../relocate/). No matter which path you followin the Adopt phase of your cloud journey, the recommendations provided in this article should be considered as you go through the process of building up the foundational elements of your cloud estate and building or migrating workloads.

This article is a supporting guide to the [Adopt](../adopt/index.md) methodology, offering areas of security optimization that should be considered as you move through that phase in your journey.

## Security posture modernization adoption

Consider the following recommendations as you work towards modernizing your security posture as part of the Adopt phase:

- **Security baselines:** Establish security baselines that include availability requirements to have a well understood foundation to build from. Using an off-the-shelf security baseline analysis tool can save you time and reduce the risk of human error in analyzing your environments.

- **Embrace automation:** Use automation tools to manage routine tasks to reduce the risk of human error and improve consistency. Take advantage of cloud services that have the ability to automate failover and recovery procedures. Tasks that you may consider automating include:

    - Infrastructre deployments and management

    - Software development lifecycle activities

    - Testing

    - Monitoring and alerting

    - Scaling

- **Zero Trust access and authorization controls:** Strong access controls and identity management systems ensure that only authorized personnel have access to critical systems and data. This reduces the risk of malicious activities that could disrupt services. Standardizing on strictly enforced role-based access controls (RBAC) and requiring multi-factor authentication (MFA) helps prevent unauthorized access to your systems that could disrupt service availability. Refer to the [Securing identity with Zero Trust](/security/zero-trust/deploy/identity) article for detailed guidance on this topic.

### Change management institutionalization

Effective adoption and change management (ACM) methodologies are crucial for ensuring the successful implementation and institutionalization of access controls. Some of the best practices and methodologies include:

- **Prosci ADKAR Model:** This model focuses on five key building blocks for successful change: Awareness, Desire, Knowledge, Ability, and Reinforcement. By addressing each of these elements, organizations can ensure that employees are aware of the need for access controls, have the desire to support the change, possess the necessary knowledge and skills, and receive reinforcement to sustain the change.

- **Kotter’s 8-Step Change Model:** This model outlines eight steps for leading change, including creating a sense of urgency, forming a powerful coalition, developing a vision and strategy, communicating the vision, empowering employees for broad-based action, generating short-term wins, consolidating gains, and anchoring new approaches in the culture. By following these steps, organizations can effectively manage the adoption of access controls.

- **Lewin’s Change Management Model:** This model involves three stages: Unfreeze, Change, and Refreeze. In the Unfreeze stage, organizations prepare for change by identifying the need for access controls and creating a sense of urgency. In the Change stage, new processes and practices are implemented. In the Refreeze stage, the new practices are solidified and integrated into the organizational culture.

- [**Microsoft's Adoption and Change Management Framework:**](https://adoption.microsoft.com/en-us/virtual-hub/adoption-governance/adoption-change-management/) This framework provides a structured approach to driving adoption and change, including defining success criteria, engaging stakeholders, preparing the organization, and measuring success. It emphasizes the importance of communication, training, and support to ensure that access controls are effectively adopted and institutionalized.

By incorporating these ACM methodologies and best practices, organizations can ensure that access controls are not only implemented but also embraced by employees, leading to a more secure and compliant enterprise environment.

### Azure facilitation

- **Establishing a security baseline:** [Microsoft Secure Score](/defender-xdr/microsoft-secure-score-improvement-actions) can help you establish baselines with tangible recommendations for improvements. It is offered as part of the Microsoft Defender XDR suite and can analyze the security of many [Microsoft and third-party products](/defender-xdr/microsoft-secure-score#products-included-in-secure-score).

- **Infrastructure deployment automation:** [Azure Resource Manager templates (ARM templates)](/azure/azure-resource-manager/templates/overview) and [Bicep](/azure/azure-resource-manager/bicep/overview) are Azure-native tools for deploying infrastructure-as-code (IaC) by using declarative syntax. ARM templates are written in JSON, whereas Bicep is a domain-specific language. Both can easily be integrated into [Azure pipelines](/azure/azure-resource-manager/bicep/add-template-to-azure-pipelines) or [GitHub Actions](/devops/deliver/iac-github-actions) CI/CD pipelines.

    - [Terraform](/azure/developer/terraform/overview) is another declarative IaC tool that's fully supported in Azure. It can be used to deploy and manage infrastructure, and can be integrated into your CI/CD pipeline.

    - You can use Microsoft Defender for Cloud to [discover misconfigurations in IaC](/azure/defender-for-cloud/iac-vulnerabilities).

    - **Azure Deployment Environments**: [Deployment Environments](/azure/deployment-environments/overview-what-is-azure-deployment-environments) enables development teams to quickly create consistent app infrastructure by using project-based templates. These templates minimize setup time and maximize security, compliance, and cost efficiency. A deployment environment is a collection of Azure resources that are deployed in predefined subscriptions. Development infrastructure administrators can enforce enterprise security policies and provide a curated set of predefined IaC templates.

    Development infrastructure administrators define deployment environments as catalog items. Catalog items are hosted in a GitHub or Azure DevOps repository, called a *catalog*. A catalog item consists of an IaC template and a manifest.yaml file.

    You can script the creation of deployment environments and programmatically manage the environments.

     - Refer to the Well-Architected Framework's [Infrastructure as Code](/azure/well-architected/operational-excellence/infrastructure-as-code-design) for detailed, workload-focused guidance on this topic.

- **Routine task automation:** 

    - **Azure Functions**: [Azure Functions](/azure/azure-functions/functions-overview) is a serverless tool that you can use to automate tasks by using your preferred development language. Functions provides a comprehensive set of event-driven triggers and bindings that connect your functions to other services. You don't have to write extra code.

    - **Azure Automation**: PowerShell and Python are popular programming languages for automating operational tasks. Use these languages to perform operations like restarting services, transferring logs between data stores, and scaling infrastructure to meet demand. You can express these operations in code and run them on demand. Alone, these languages don't offer a platform for centralized management, version control, or run history. The languages also lack a native mechanism for responding to events like monitoring-driven alerts. To provide these capabilities, you need an automation platform. [Automation](/azure/automation/overview) provides an Azure-hosted platform for hosting and running PowerShell and Python code across cloud and on-premises environments, both Azure and non-Azure. PowerShell and Python code is stored in an Automation runbook. Use Automation to:

        - Trigger runbooks on demand, on a schedule, or through a webhook.

        - Run history and logging.

        - Integrate a secrets store.

        - Integrate source control.

    - **Azure Update Manager**: [Update Manager](/azure/update-manager/overview) is a unified service to help manage and govern updates for virtual machines. You can monitor Windows and Linux update compliance across your workload. You can also use Update Manager to make real-time updates or schedule them within a defined maintenance window. Use Update Manager to:

        - Oversee compliance on your entire fleet of machines.

        - Schedule recurring updates.

        - Deploy critical updates.

- **Azure Logic Apps and Microsoft Power Automate**: When you build custom digital process automation (DPA) to handle workload tasks like approval flows or building ChatOps integrations, consider using [Logic Apps](/azure/logic-apps/) or [Power Automate](https://azure.microsoft.com/products/power-automate/). You can construct workflows from built-in connectors and templates. Logic Apps and Power Automate are built on the same underlying technology and are both well-suited for trigger-based or time-based tasks.

- **Automatic scaling**: Many Azure technologies have built-in automatic scaling capabilities. You can also program other services to automatically scale by using APIs. Refer to the Azure Architecture Center's [Autoscaling](/azure/architecture/best-practices/auto-scaling) guidance for more information.

- **Azure Monitor action groups**: To automatically run self-healing operations when an alert is triggered, use [Azure Monitor action groups](/azure/azure-monitor/alerts/action-groups). You can define these operations by using a runbook, an Azure function, or a webhook.

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

### Azure facilitation

- **Threat detection and response automation:** Automate threat detection and response with the automated investigation and response functionality in [Microsoft Defender XDR](/defender-xdr/m365d-autoir).

- **IaC deployment security:** Use [deployment stacks](/azure/azure-resource-manager/bicep/deployment-stacks) to manage Azure resources as a single, cohesive unit. Prevent users from performing unauthorized modifications using [deny settings](/azure/azure-resource-manager/bicep/deployment-stacks?tabs=azure-powershell#protect-managed-resources).

## Adopt the principle of confidentiality

With the overarching strategy and implementation plan for adopting the CIA Triad principle of confidentiality already in place, the next step is to focus on adoption and change management. This involves ensuring that encryption and secure access controls are effectively implemented and institutionalized across the enterprise cloud environment. In the adoption phase, DLP measures are implemented to protect sensitive data in transit and at rest. This involves deploying encryption solutions, configuring access controls, and ensuring that all employees are trained in the importance of data confidentiality and how to adhere to DLP policies.

### Implement encryption and secure access controls

To protect sensitive information from unauthorized access, it is crucial to implement robust encryption and secure access controls. Encryption ensures that data is unreadable to unauthorized users, while access controls regulate who can access specific data and resources. Understand the encryption capabilities of the cloud services that you deploy and enable the appropriate encryption mechanisms to meet your business requirements.

### Incorporating and adopting associated standards

Developing and adopting associated standards is essential for ensuring the consistent implementation of encryption and access controls. Organizations should establish clear guidelines and best practices for using encryption and access controls, and ensure that these standards are communicated to all employees. For example, a standard might specify that all sensitive data must be encrypted using AES-256 encryption, and that access to this data must be restricted to authorized personnel only. By incorporating these standards into the organization's policies and procedures, and providing regular training and support, organizations can ensure that encryption and access controls are consistently applied across the enterprise. Other examples include:

- **Strong encryption:** Enable encryption on data stores when practical and consider managing your own keys. Your cloud provider may offer encryption at rest for the storage that your data store is hosted on, and give you the option of enabling database encryption like [transparent data encryption](/azure/azure-sql/database/transparent-data-encryption-tde-overview) in Azure SQL Database. Apply the extra layer of encryption when practical.

- **Access controls:** Apply role-based access controls (RBAC), conditional access controls, just-in-time access, and just-enough-access to all data stores and standardize practices of reviewing permissions regularly. Lockdown write access to configuration systems and allow write access only through specific automation account which applies the changes after comprehensive review processes, typically as part of DevOps pipelines. 

- **Standards adoption:** The organization might develop a standard that requires all emails containing sensitive information to be encrypted using [Microsoft Purview Information Protection](/purview/information-protection). This ensures that sensitive data is protected during transmission and can only be accessed by authorized recipients.

### Azure facilitation

- **SIEM and SOAR solutions:** [Microsoft Sentinel](/azure/sentinel/overview?tabs=azure-portal) is a scalable, cloud-native security information and event management (SIEM) that delivers an intelligent and comprehensive solution for SIEM and security orchestration, automation, and response (SOAR). Microsoft Sentinel provides cyberthreat detection, investigation, response, and proactive hunting, with a bird's-eye view across your enterprise.

- **Azure Encryption:** Azure offers encryption for services like Azure SQL Database, Azure Cosmos DB, and Azure Data Lake. The encryption models supported include server-side encryption with service-managed keys, customer-managed keys in Azure Key Vault, and customer-managed keys on customer-controlled hardware. Client-side encryption models support data encryption by an application before it is sent to Azure. For more detailed information, you can refer to the [Azure Encryption Overview](/azure/security/fundamentals/encryption-overview) guide.

-  **Access control management:** [Microsoft Entra ID](/entra/fundamentals/whatis) Formerly known as Azure Active Directory, Microsoft Entra ID offers comprehensive identity and access management capabilities. It supports multi-factor authentication (MFA), conditional access policies, and single sign-on (SSO) to ensure that only authorized users can access sensitive data.

    - [Microsoft Entra ID Protection](/entra/id-protection/overview-identity-protection) uses advanced machine learning to identify sign-in risks and unusual user behavior to block, challenge, limit, or allow access. It helps prevent identity compromise, protects against credential theft and provides insights into your identity security posture.

    - [Microsoft Defender for Indentity](/defender-for-identity/what-is) is a cloud-based security identity threat detection (ITDR) solution that helps secure your identity monitoring across your organization. It can help you better identify, detect, and investigate advanced threats directed at your organization through automated threat detection and response mechanisms.
  
- [**Azure Confidential Computing:**](/azure/confidential-computing/overview) This service protects data while it is being processed. It uses hardware-based trusted execution environments (TEEs) to isolate and protect data in use, ensuring that even cloud administrators cannot access the data.

## Adopt the principle of integrity

In the adopt phase, planning and designs are turned into real-world implementations. In the context of data and system integrity, this means building out your systems according to the standards that you developed in the earlier phases and ensuring that engineers, administrators, and operators are trained on protocols and procedures. 

### Data integrity adoption

- **Data classification:** Implement your data classification framework through automation when possible and manually when necessary. Use off the shelf tools to automate your data classification and identify sensitive information. Use manual labeling for documents and containers, and manually curate data sets used in analytics where classification and sensitivity are best established by knowledgeable users.

- **Data verifcation and validation:** Take advantage of built-in verification and validation functionality in the services that you deploy. For example, Azure Data Factory has built-in functionality to [verify data consistency](/azure/data-factory/copy-activity-data-consistency) when moving data from a source to a destination store. Consider adopting practices like:

    - Using the CHECKSUM and BINARY_CHECKSUM functions in SQL to ensure data isn't corrupted in transit.

    - Storing hashes in tables and creating subroutines that modify the hashes when the last modified date changes.

- **Monitoring and alerting:** Monitor your data stores for changes with detailed change history information to help with reviews. Configure alerting to ensure that you have appropriate visibility and you can take efficient actions in case of any incidents that could affect data integrity.

- **Backup policies:** Apply backup policies on all appropriate systems. Understand the backup capabilities of platform as a service (PaaS) ans software as a service (SaaS) services. For example, Azure SQL Database includes [automatic backups](/azure/azure-sql/database/automated-backups-overview) and you can configure the retention policy as necessary.

- **Share design standards:** Publish and share application design standards that incorporate data integrity mechanisms across the organization. Design standards should include nonfunctional requirements like tracking configuration and data changes at the application level natively and capturing this history in the data schema. This approach mandates that the data schema retains details about data history and configuration history as part of the datastore, in addition to standard logging mechanisms to bolster your integrity monitoring.
 
### System integrity adoption

- **Security monitoring:** Use a robust monitoring solution to automatically enroll all resources in your cloud estate and ensure that alerting is enabled and configured to notify appropriate teams when incidents occur.

- **Automated configuration management:** Deploy and configure a configuration management system that automatically enrolls new systems and manages your configurations continuously.

- **Automated patch management:** Deploy and configure a patch management system that automatically enrolls new systems and manages patching according to your policies. Prefer native tooling to your cloud platform.

### Azure facilitation

- **Data classification and labeling:** [Microsoft Purview](/purview/purview) is a robust set of solutions that can help your organization govern, protect, and manage data, wherever it lives. It offers manual and automatic [data classification](/purview/concept-classification) and [sensitivity labeling](/purview/create-sensitivity-label).

- **Configuration management:** [Azure Arc](/azure/azure-arc/overview) is a centralized and unified infrastructure governance and managment platform that can manage configurations for cloud-based and on-premises systems. Using Azure Arc, you can extend your Security Baselines from [Azure Policy](/azure/governance/policy/overview), your [Microsoft Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction) policies, and Secure Score evaluations, as well as logging and monitoring all your resources in one place.

- **Patch management:** [Azure Update Manager](/azure/update-manager/overview) is a unified update management solution for Windows and Linux machines that can be used for Azure, on-premises and multi-cloud environments. It has built-in support for [Azure Policy](/azure/governance/policy) and [Azure Arc](/azure/azure-arc/overview) managed machines.

## Adopt the principle of availability

With resilient design patterns defined, your organization can move on to the adoption phase. For detailed guidance on workload availability, refer to the Well-Architected Framework's [reliability](/azure/well-architected/reliability) pillar and the [Azure reliability](/azure/reliability/overview) documentation. In the context of cloud adoption, the focus is on establishing and codifying operational practices that support availability.

### Establishing operational practices to support availability

Maintaining a highly available cloud estate can only be done if the teams operating the cloud systems have standardized, mature practices that are strictly followed. These practices should include:

- **Operational continuity:** Organizations must plan for continuous operations even under attack conditions. This includes establishing processes for rapid recovery and maintaining critical services at a degraded level until full recovery is possible. 

- **Robust and continuous observability:** An organization's ability to detect security incidents as they happen allows them to initiate their incident response plans quickly, helping to minimize the business impact as much as possible. Incident detection is only possible through a well-designed monitoring and alerting system, following best-practices for threat detection. Refer to the Well-Architected Framework's [observability guide](/azure/well-architected/operational-excellence/observability) and [security monitoring and threat detection guide](/azure/well-architected/security/monitor-threats) for detailed guidance on this topic.

- **Proactive maintenance:** System updates should be standardized and enforced through policies. Schedule regular maintenance windows to apply updates and patches to systems without disrupting services. Conduct regular health checks and maintenance activities to ensure all components are functioning optimally​.

- **Standardized governance policies:** Enforce all security standards through tooling-supported policies. Use a policy management tool to ensure that all of your systems are compliant with your business requirements by default and that your policies are easily auditable. 

- **Disaster recovery preparedness:** Develop and regulary test disaster recovery plans for your workloads to ensure that they will be able to be recovered in the event of a disaster. Refer to the Azure reliability [disaster recovery](/azure/reliability/disaster-recovery-overview) documentation for detailed guidance on this topic.

    - Automate recovery activities to the extent practical. For example, make use of automatic failvoer capabilities in services like [Azure SQL Database](/azure/azure-sql/database/failover-group-sql-db)

- **Understanding service-level agreements:** Service-level agreements (SLAs) that are provided by your cloud platform for their services help you understand the guaranteed uptime for the components of your workloads. Using those SLAs as your basis, you can then develop your own target metrics for the SLAs you offer your customers. Microsoft publishes the SLAs for all cloud services at [Service-level agreements for online services](https://www.microsoft.com/licensing/docs/view/Service-Level-Agreements-SLA-for-Online-Services)

- **Compliance requirements:** Adhering to regulations such as GDPR and HIPAA ensures that systems are designed and maintained to high standards, including those related to availability. Non-compliance can lead to legal actions and fines that might disrupt business operations. Compliance often isn't limited to system configuration. Most compliance frameworks also require risk management and incident response standards. Ensure that your operational standards meet the framework requirements and staff is trained regularly.

### Azure facilitation

**Policy and compliance management:** 

- [Azure Policy](/azure/governance/policy) is a policy management solution that helps enforce organizational standards and to assess compliance at-scale. Take advantage of [built-in policy definitions](/azure/governance/policy/samples/built-in-policies) to automate policy enforcement for many Azure services.

- [Microsoft Defender for Cloud](/azure/defender-for-cloud/security-policy-concept) provides security policies that can automate compliance with your security standards.

**Operational continuity and disaster recovery:** Many Azure services have built-in recovery capabilities that can be incorporated into your operational continuity and disaster recovery plans. Refer to the [Azure services reliability guides](/azure/reliability/overview-reliability-guidance) for detailed guidance on this topic.

## Adopt security sustainment

Consider the following recommendations to help ensure that the security mechanisms and practices that you have put in place as part of your cloud adoption can be sustained and consinously improved as you continue your journey:

- **Institue a Security Review Board:** Create a Security Review Board that continuously reviews projects and mandates security controls. Review your processes regularly to find areas of improvement. Develop processes to ensure that security is always top of mind for everyone.

- **Implement a vulnerability management solution:**  Use a vulnerability management solution to monitor the security vulnerability risk score and have a process defined to act on the highest risk score to lowest to minimize the risk. Keep track of the latest CVE risks and have a policy to apply those mitigations regularly for remediation.

- **Harden production infrastructure:** Infrastructure hardening is critical to securing your cloud estate. Follow benchmarking guidance like the Center for Internet Security (CIS) [benchmarks](https://www.cisecurity.org/cis-benchmarks) to harden your infrastructure according to industry best practices.

- **Utilize the MITRE ATT&CK knowledge base:** Use the [MITRE ATT&CK](https://attack.mitre.org/) knowledge base to help develop threat models and methodologies for common real-world attack tactics and techniques.
 
- **Shift left:** Use segregated environments with different access levels for pre-production vs production. This approach will help you shift left, adding security concerns to all phases of development and providing flexibility in lower environments.

### Azure facilitation

**Vulnerability management:** [Microsoft Defender Vulnerability Management](/defender-vulnerability-management/defender-vulnerability-management) is a comprehensive risk-based vulnerability management solution that helps you identify, assess, remediate, and track all your biggest vulnerabilities across your most critical assets, all in a single solution.