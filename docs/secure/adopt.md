---
title: Perform Your Cloud Adoption Securely
description: Learn how to adopt security best practices in your cloud estate adoption phase so that your infrastructure is secure, compliant, and resilient from the start.
author: claytonsiemens77
ms.author: pnp
ms.date: 10/18/2024
ms.topic: conceptual
ms.custom: internal, UpdateFrequency2
---

# Perform your cloud adoption securely

When you implement your cloud estate and migrate workloads in, it's essential to establish robust security mechanisms and practices. This approach ensures that your workloads are secure from the start and prevents the need to address security gaps after the workloads are in production. Prioritize security during the Adopt phase to ensure that workloads are built consistently and according to best practices. Established security practices also prepare IT teams for cloud operations through well-designed policies and procedures.

Whether you're migrating workloads into the cloud or building an entirely new cloud estate, you can apply the guidance in this article. The Cloud Adoption Framework [Adopt](../adopt/index.md) methodology incorporates the [Migrate](../migrate/index.md), [Modernize](../modernize/index.md), [Innovate](../innovate/index.md), and [Relocate](../relocate/index.md) scenarios. Regardless of the path that you take during the Adopt phase of your cloud journey, it's important to consider the recommendations in this article as you establish the foundational elements of your cloud estate and build or migrate workloads.


:::image type="content" source="./media/caf-secure-adopt.png" alt-text="Diagram showing the methodologies involved in cloud adoption. The diagram has boxes for each phase: teams and roles, strategy, plan, ready, adopt, govern, and manage. The box for this article is highlighted." lightbox="./media/caf-secure-adopt.png" border="false":::


This article is a supporting guide to the [Adopt](../adopt/index.md) methodology. It provides areas of security optimization that you should consider as you move through that phase in your journey.

## Security posture modernization adoption

Consider the following recommendations as you work toward modernizing your security posture as part of the Adopt phase:

- **Security baselines:** Define security baselines that include availability requirements to establish a clear and robust foundation for development. To save you time and reduce the risk of human error in analyzing your environments, use an off-the-shelf security baseline analysis tool.

- **Embrace automation:** Use automation tools to manage routine tasks to reduce the risk of human error and improve consistency. Take advantage of cloud services that can automate failover and recovery procedures. Tasks that you might consider automating include:

  - Infrastructure deployments and management
  - Software development lifecycle activities
  - Testing
  - Monitoring and alerting
  - Scaling

- **Zero Trust access and authorization controls:** Implement strong access controls and identity management systems to ensure that only authorized personnel have access to critical systems and data. This approach reduces the risk of malicious activities that could disrupt services. Standardize strictly enforced role-based access controls (RBACs) and require multifactor authentication to prevent unauthorized access that could disrupt service availability. For more information, see [Securing identity with Zero Trust](/security/zero-trust/deploy/identity).

### Change management institutionalization

Effective adoption and change management (ACM) methodologies are crucial for ensuring the successful implementation and institutionalization of access controls. Some of the best practices and methodologies include:

- **Prosci ADKAR Model:** This model focuses on five key building blocks for successful change. These components are Awareness, Desire, Knowledge, Ability, and Reinforcement. By addressing each element, organizations can ensure that employees understand the need for access controls, are motivated to support the change, have the necessary knowledge and skills, and receive ongoing reinforcement to maintain the change.

- **Kotter's 8-Step Change Model:** This model outlines eight steps for leading change. These steps include creating a sense of urgency, forming a powerful coalition, developing a vision and strategy, communicating the vision, empowering employees for broad-based action, generating short-term wins, consolidating gains, and anchoring new approaches into the culture. By following these steps, organizations can effectively manage the adoption of access controls.

- **Lewin's Change Management Model:** This model has three stages, which are Unfreeze, Change, and Refreeze. In the Unfreeze stage, organizations prepare for change by identifying the need for access controls and creating a sense of urgency. In the Change stage, new processes and practices are implemented. In the Refreeze stage, the new practices are solidified and integrated into the organizational culture.

- [**Microsoft Adoption and change management framework:**](https://adoption.microsoft.com/virtual-hub/adoption-governance/adoption-change-management/) This framework provides a structured approach to driving adoption and change by defining success criteria, engaging stakeholders, and preparing the organization. This framework also measures success to ensure the effectiveness of the implementation. It emphasizes the importance of communication, training, and support to ensure that access controls are effectively adopted and institutionalized.

Organizations can ensure that access controls are implemented and embraced by employees by incorporating these ACM methodologies and best practices. This approach results in a more secure and compliant enterprise environment.

### Azure facilitation

- **Establish a security baseline:** [Microsoft Secure Score](/defender-xdr/microsoft-secure-score-improvement-actions) can help you establish baselines with tangible recommendations for improvements. It's provided as part of the Microsoft Defender XDR suite and can analyze the security of many [Microsoft and non-Microsoft products](/defender-xdr/microsoft-secure-score#products-included-in-secure-score).

- **Infrastructure deployment automation:** [Azure Resource Manager templates (ARM templates)](/azure/azure-resource-manager/templates/overview) and [Bicep](/azure/azure-resource-manager/bicep/overview) are Azure-native tools for deploying infrastructure as code (IaC) by using declarative syntax. ARM templates are written in JSON, whereas Bicep is a domain-specific language. You can easily integrate both into [Azure Pipelines](/azure/azure-resource-manager/bicep/add-template-to-azure-pipelines) or [GitHub Actions](/devops/deliver/iac-github-actions) continuous integration and continuous delivery (CI/CD) pipelines.

  - [Terraform](/azure/developer/terraform/overview) is another declarative IaC tool that's fully supported in Azure. You can use Terraform to deploy and manage infrastructure, and you can integrate it into your CI/CD pipeline.

  - You can use Microsoft Defender for Cloud to [discover misconfigurations in IaC](/azure/defender-for-cloud/iac-vulnerabilities).

  - **Azure Deployment Environments:** [Deployment Environments](/azure/deployment-environments/overview-what-is-azure-deployment-environments) enables development teams to quickly create consistent app infrastructure by using project-based templates. These templates minimize setup time and maximize security, compliance, and cost efficiency. A deployment environment is a collection of Azure resources that are deployed in predefined subscriptions. Development infrastructure administrators can enforce enterprise security policies and provide a curated set of predefined IaC templates.

    Development infrastructure administrators define deployment environments as catalog items. Catalog items are hosted in a GitHub or Azure DevOps repository, called a *catalog*. A catalog item consists of an IaC template and a manifest.yml file.

    You can script the creation of deployment environments and programmatically manage the environments. For detailed, workload-focused guidance, see the Azure Well-Architected Framework's [IaC approach](/azure/well-architected/operational-excellence/infrastructure-as-code-design).

- **Routine task automation:**

  - **Azure Functions:** [Azure Functions](/azure/azure-functions/functions-overview) is a serverless tool that you can use to automate tasks by using your preferred development language. Functions provides a comprehensive set of event-driven triggers and bindings that connect your functions to other services. You don't have to write extra code.

  - **Azure Automation:** PowerShell and Python are popular programming languages for automating operational tasks. Use these languages to perform operations like restarting services, transferring logs between data stores, and scaling infrastructure to meet demand. You can express these operations in code and run them on demand. Individually, these languages lack a platform for centralized management, version control, or tracking run history. The languages also lack a native mechanism for responding to events like monitoring-driven alerts. To provide these capabilities, you need an automation platform. [Automation](/azure/automation/overview) provides an Azure-hosted platform for hosting and running PowerShell and Python code across cloud and on-premises environments, including Azure and non-Azure systems. PowerShell and Python code is stored in an Automation runbook. Use Automation to:

    - Trigger runbooks on demand, on a schedule, or through a webhook.

    - Run history and logging.

    - Integrate a secrets store.

    - Integrate source control.

  - **Azure Update Manager:** [Update Manager](/azure/update-manager/overview) is a unified service that you can use to manage and govern updates for virtual machines. You can monitor Windows and Linux update compliance across your workload. You can also use Update Manager to make real-time updates or schedule them within a defined maintenance window. Use Update Manager to:

    - Oversee compliance on your entire fleet of machines.

    - Schedule recurring updates.

    - Deploy critical updates.

- **Azure Logic Apps and Microsoft Power Automate:** When you build custom digital process automation (DPA) to handle workload tasks like approval flows or building ChatOps integrations, consider using [Logic Apps](/azure/logic-apps/) or [Power Automate](https://azure.microsoft.com/products/power-automate/). You can construct workflows from built-in connectors and templates. Logic Apps and Power Automate are built on the same underlying technology and are well-suited for trigger-based or time-based tasks.

- **Automatic scaling:** Many Azure technologies have built-in automatic scaling capabilities. You can also program other services to automatically scale by using APIs. For more information, see [Autoscaling](/azure/architecture/best-practices/auto-scaling).

- **Azure Monitor action groups:** To automatically run self-healing operations when an alert is triggered, use [Azure Monitor action groups](/azure/azure-monitor/alerts/action-groups). You can define these operations by using a runbook, an Azure function, or a webhook.

## Incident preparedness and response adoption

After you establish your landing zone or other platform design with secure network segmentation and well-designed subscription and resource organization, you can begin implementation with a focus on incident preparedness and response. During this phase, developing your preparedness and response mechanisms, including your incident response plan, ensures that your cloud estate and operational practices align with business goals. This alignment is crucial for maintaining efficiency and achieving strategic objectives. The adoption phase should approach incident preparedness and response from two perspectives. These perspectives are threat readiness and mitigation, and infrastructure and application security.

### Threat readiness and mitigation

- **Threat detection:** Implement advanced monitoring tools and practices to detect threats in real-time. This implementation includes setting up alert systems for unusual activities and integrating extended detection and response (XDR) and security information and event management (SIEM) solutions. For more information, see [Zero Trust threat protection and XDR](/security/zero-trust/adopt/prevent-reduce-business-damage-breach-threat-protection).

- **Vulnerability management:** Identify and mitigate vulnerabilities regularly through patch management and security updates to ensure that systems and applications are protected against known threats.

- **Incident response:** Develop and maintain an incident response plan that includes detection, analysis, and remediation steps to quickly address and recover from security incidents. For workload-focused guidance, see [Recommendations for security incident response](/azure/well-architected/security/incident-response). Automate mitigation activities as much as possible to make these activities more efficient and less prone to human error. For example, if you detect a SQL injection, you can have a runbook or workflow that automatically locks all connections to SQL to contain the incident.

### Infrastructure and application security

- **Secure deployment pipelines:** Build CI/CD pipelines with integrated security checks to ensure that applications are securely developed, tested, and deployed. This solution includes static code analysis, vulnerability scanning, and compliance checks. For more information, see [Zero Trust developer guidance](/security/zero-trust/develop/overview).

- **IaC deployments:** Deploy all infrastructure through code, without exception. Reduce the risk of misconfigured infrastructure and unauthorized deployments by mandating this standard. Colocate all IaC assets with application code assets and apply the same [safe deployment practices](/azure/well-architected/operational-excellence/safe-deployments) as software deployments.

### Azure facilitation

- **Threat detection and response automation:** Automate threat detection and response with the automated investigation and response functionality in [Microsoft Defender XDR](/defender-xdr/m365d-autoir).

- **IaC deployment security:** Use [deployment stacks](/azure/azure-resource-manager/bicep/deployment-stacks) to manage Azure resources as a single, cohesive unit. Prevent users from performing unauthorized modifications by using [deny settings](/azure/azure-resource-manager/bicep/deployment-stacks?tabs=azure-powershell#protect-managed-resources).

## Adopt the principle of confidentiality

After the overarching strategy and implementation plan for adopting the CIA Triad principle of confidentiality is already in place, the next step is to focus on ACM. This step includes ensuring that encryption and secure access controls are effectively implemented and institutionalized across the enterprise cloud environment. In the adoption phase, data loss prevention (DLP) measures are implemented to protect sensitive data in transit and data at rest. The implementation involves deploying encryption solutions, configuring access controls, and training all employees on the importance of data confidentiality and adherence to DLP policies.

### Implement encryption and secure access controls

To protect sensitive information from unauthorized access, it's crucial that you implement robust encryption and secure access controls. Encryption ensures that data is unreadable to unauthorized users, while access controls regulate who can access specific data and resources. Understand the encryption capabilities of the cloud services that you deploy and enable the appropriate encryption mechanisms to meet your business requirements.

### Incorporate and adopt associated standards

To ensure the consistent implementation of encryption and access controls, it's essential to develop and adopt associated standards. Organizations should establish clear guidelines and best practices for using encryption and access controls, and ensure that these standards are communicated to all employees. For example, a standard might specify that all sensitive data must be encrypted by using AES-256 encryption, and that access to this data must be restricted to authorized personnel only. Organizations can ensure that encryption and access controls are consistently applied across the enterprise by incorporating these standards into their policies and procedures. Providing regular training and support further reinforces these practices among employees. Other examples include:

- **Strong encryption:** Enable encryption on data stores when possible and consider managing your own keys. Your cloud provider might offer encryption at rest for the storage that your data store is hosted on, and give you the option of enabling database encryption like [transparent data encryption](/azure/azure-sql/database/transparent-data-encryption-tde-overview) in Azure SQL Database. Apply the extra layer of encryption when possible.

- **Access controls:** Apply RBAC, Conditional Access controls, just-in-time access, and just-enough-access to all data stores. Standardize the practice of reviewing permissions regularly. Restrict write access to configuration systems, which allows changes only through a designated automation account. This account applies modifications after thorough review processes, typically as part of Azure Pipelines.

- **Standards adoption:** The organization might develop a standard that requires all emails that contain sensitive information to be encrypted by using [Microsoft Purview Information Protection](/purview/information-protection). This requirement ensures that sensitive data is protected during transmission and only accessible by authorized recipients.

### Azure facilitation

- **SIEM and SOAR solutions:** [Microsoft Sentinel](/azure/sentinel/overview?tabs=azure-portal) is a scalable, cloud-native SIEM that delivers an intelligent and comprehensive solution for SIEM and security orchestration, automation, and response (SOAR). Microsoft Sentinel provides threat detection, investigation, response, and proactive hunting, with a high-level overview of your enterprise.

- **Azure encryption:** Azure provides encryption for services like Azure SQL Database, Azure Cosmos DB, and Azure Data Lake. The supported encryption models include server-side encryption with service-managed keys, customer-managed keys in Azure Key Vault, and customer-managed keys on customer-controlled hardware. Client-side encryption models support data encryption by an application before it's sent to Azure. For more information, see [Azure encryption overview](/azure/security/fundamentals/encryption-overview).

- **Access control management:** Formerly known as Azure Active Directory, [Microsoft Entra ID](/entra/fundamentals/whatis) provides comprehensive identity and access management capabilities. It supports multifactor authentication, Conditional Access policies, and single sign-on to ensure that only authorized users can access sensitive data.

  - [Microsoft Entra ID Protection](/entra/id-protection/overview-identity-protection) uses advanced machine learning to identify sign-in risks and unusual user behavior to block, challenge, limit, or grant access. It helps prevent identity compromise, protects against credential theft, and provides insights into your identity security posture.

  - [Microsoft Defender for Identity](/defender-for-identity/what-is) is a cloud-based security identity threat detection solution that helps secure your identity monitoring across your organization. It can help you better identify, detect, and investigate advanced threats directed at your organization through automated threat detection and response mechanisms.
  
- [**Azure confidential computing:**](/azure/confidential-computing/overview) This service protects data while it's being processed. It uses hardware-based trusted execution environments to isolate and protect data in use, ensuring that even cloud administrators can't access the data.

## Adopt the principle of integrity

In the Adopt phase, planning and designs are turned into real-world implementations. To ensure data and system integrity, build your systems according to the standards that you developed in earlier phases. Additionally, train engineers, administrators, and operators on the relevant protocols and procedures.

### Data integrity adoption

- **Data classification:** Implement your data classification framework through automation when possible and manually when necessary. Use off-the-shelf tools to automate your data classification and identify sensitive information. Manually label documents and containers to ensure accurate classification. Curate data sets for analytics by taking advantage of the expertise of knowledgeable users to establish sensitivity.

- **Data verification and validation:** Take advantage of built-in verification and validation functionality in the services that you deploy. For example, Azure Data Factory has built-in functionality to [verify data consistency](/azure/data-factory/copy-activity-data-consistency) when you move data from a source to a destination store. Consider adopting practices like:

  - Using the CHECKSUM and BINARY_CHECKSUM functions in SQL to ensure that data isn't corrupted in transit.

  - Storing hashes in tables and creating subroutines that modify the hashes when the last modified date changes.

- **Monitoring and alerting:** Monitor your data stores for changes with detailed change history information to help with reviews. Configure alerting to ensure that you have appropriate visibility and can take efficient actions if there are any incidents that might affect data integrity.

- **Backup policies:** Apply backup policies on all appropriate systems. Understand the backup capabilities of platform as a service and software as a service services. For example, Azure SQL Database includes [automatic backups](/azure/azure-sql/database/automated-backups-overview), and you can configure the retention policy as necessary.

- **Share design standards:** Publish and share application design standards that incorporate data integrity mechanisms across the organization. Design standards should encompass nonfunctional requirements, such as natively tracking configuration and data changes at the application level and recording this history within the data schema. This approach mandates that the data schema retains details about data history and configuration history as part of the datastore, in addition to standard logging mechanisms to strengthen your integrity monitoring.

### System integrity adoption

- **Security monitoring:** Use a robust monitoring solution to automatically enroll all resources in your cloud estate and ensure that alerting is enabled and configured to notify appropriate teams when incidents occur.

- **Automated configuration management:** Deploy and configure a configuration management system that automatically enrolls new systems and manages your configurations continuously.

- **Automated patch management:** Deploy and configure a patch management system that automatically enrolls new systems and manages patching according to your policies. Prefer native tooling to your cloud platform.

### Azure facilitation

- **Data classification and labeling:** [Microsoft Purview](/purview/purview) is a robust set of solutions that can help your organization govern, protect, and manage data, wherever it lives. It offers manual and automatic [data classification](/purview/concept-classification) and [sensitivity labeling](/purview/create-sensitivity-label).

- **Configuration management:** [Azure Arc](/azure/azure-arc/overview) is a centralized and unified infrastructure governance and management platform that you can use to manage configurations for cloud-based and on-premises systems. By using Azure Arc, you can extend your security baselines from [Azure Policy](/azure/governance/policy/overview), your [Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction) policies, and Secure Score evaluations, as well as logging and monitoring all your resources in one place.

- **Patch management:** [Azure Update Manager](/azure/update-manager/overview) is a unified update management solution for Windows and Linux machines that you can use for Azure, on-premises, and multicloud environments. It has built-in support for [Azure Policy](/azure/governance/policy) and [Azure Arc](/azure/azure-arc/overview) managed machines.

## Adopt the principle of availability

After the resilient design patterns are defined, your organization can move on to the adoption phase. For detailed guidance on workload availability, refer to the Well-Architected Framework's [Reliability](/azure/well-architected/reliability) pillar and the [Azure reliability](/azure/reliability/overview) documentation. In the context of cloud adoption, the focus is on establishing and codifying operational practices that support availability.

### Establish operational practices to support availability

To maintain a highly available cloud estate, teams that operate the cloud systems must adhere to standardized, mature practices. These practices should include:

- **Operational continuity:** Organizations must plan for continuous operations even under attack conditions. This approach includes establishing processes for rapid recovery and maintaining critical services at a degraded level until full recovery is possible.

- **Robust and continuous observability:** An organization's ability to detect security incidents as they happen allows them to initiate their incident response plans quickly. This strategy helps minimize the business effects as much as possible. Incident detection is only possible through a well-designed monitoring and alerting system, which follows best practices for threat detection. For more information, see the [observability guide](/azure/well-architected/operational-excellence/observability) and [Security monitoring and threat detection guide](/azure/well-architected/security/monitor-threats).

- **Proactive maintenance:** Standardize and enforce system updates through policies. Schedule regular maintenance windows to apply updates and patches to systems without disrupting services. Conduct regular health checks and maintenance activities to ensure that all components are functioning optimally​.

- **Standardized governance policies:** Enforce all security standards through tooling-supported policies. Use a policy management tool to ensure that all of your systems are compliant with your business requirements by default and that your policies are easily auditable.

- **Disaster recovery preparedness:** Develop and regularly test disaster recovery plans for your workloads to ensure that they're recoverable if a disaster occurs. For more information, see [Disaster recovery](/azure/reliability/disaster-recovery-overview). Automate recovery activities as much as possible. For example, use automatic failover capabilities in services like [Azure SQL Database](/azure/azure-sql/database/failover-group-sql-db).

- **Service-level agreements:** Service-level agreements (SLAs) that your cloud platform provides for their services help you understand the guaranteed uptime for the components of your workloads. Use those SLAs as your basis to then develop your own target metrics for the SLAs that you provide to your customers. Microsoft publishes the SLAs for all cloud services at [SLAs for online services](https://www.microsoft.com/licensing/docs/view/Service-Level-Agreements-SLA-for-Online-Services).

- **Compliance requirements:** Adhere to regulations such as the General Data Protection Regulation (GDPR) and HIPAA to ensure that systems are designed and maintained to high standards, including standards that are related to availability. Noncompliance can result in legal actions and fines that might disrupt business operations. Compliance often isn't limited to system configuration. Most compliance frameworks also require risk management and incident response standards. Ensure that your operational standards meet the framework requirements and that staff is trained regularly.

### Azure facilitation

**Policy and compliance management:**

- [Azure Policy](/azure/governance/policy) is a policy management solution that helps enforce organizational standards and assess compliance at-scale. To automate policy enforcement for many Azure services, take advantage of [built-in policy definitions](/azure/governance/policy/samples/built-in-policies).

- [Defender for Cloud](/azure/defender-for-cloud/security-policy-concept) provides security policies that can automate compliance with your security standards.

- **Operational continuity and disaster recovery:** Many Azure services have built-in recovery capabilities that you can incorporate into your operational continuity and disaster recovery plans. For more information, see [Azure services reliability guides](/azure/reliability/overview-reliability-guidance).

## Adopt security sustainment

Consider the following recommendations to help ensure that the security mechanisms and practices that you put in place as part of your cloud adoption can be sustained and continuously improved as you continue your journey:

- **Institute a security review board:** Create a security review board that continuously reviews projects and mandates security controls. Review your processes regularly to find areas of improvement. Develop processes to ensure that security is always top of mind for everyone.

- **Implement a vulnerability management solution:** Use a vulnerability management solution to monitor the security vulnerability risk score and have a process defined to act on the highest risk score to lowest to minimize the risk. Track the latest common vulnerabilities and exposures risks. Have a policy to apply those mitigations regularly for remediation.

- **Harden production infrastructure:** Secure your cloud estate by hardening your infrastructure. To harden your infrastructure according to industry best practices, follow benchmarking guidance like the [Center for Internet Security (CIS) benchmarks](https://www.cisecurity.org/cis-benchmarks).

- **Use the MITRE ATT&CK knowledge base:** Use the [MITRE ATT&CK](https://attack.mitre.org/) knowledge base to help develop threat models and methodologies for common real-world attack tactics and techniques.

- **Shift left:** Use segregated environments with different access levels for preproduction versus production. This approach helps you shift left, which adds security concerns to all phases of development and provides flexibility in lower environments.

### Azure facilitation

**Vulnerability management:** [Microsoft Defender Vulnerability Management](/defender-vulnerability-management/defender-vulnerability-management) is a comprehensive risk-based vulnerability management solution that you can use to identify, assess, remediate, and track all your biggest vulnerabilities across your most critical assets, all in a single solution.

## Next step

> [!div class="nextstepaction"]
> [Securely govern your cloud estate](./govern.md)
