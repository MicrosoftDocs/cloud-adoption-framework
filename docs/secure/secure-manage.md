---
title: Manage your cloud estate with enhanced security
description: Learn how to adopt security best practices during your cloud estate management phase.
author: claytonsiemens77
ms.author: csiemens
ms.date: 10/16/2024
ms.topic: conceptual
ms.custom: internal, UpdateFrequency2
---

# Manage your cloud estate with enhanced security

The Manage phase of a cloud adoption journey focuses on the ongoing operation of your cloud estate. Maintaining and strengthening your security posture continuously is critical to successfully managing your estate and should be considered the cornerstone of your management practices. If you neglect security in favor of cost savings or performance improvements, you risk exposing your business to threats that could severely damage your business and reverse any short-term benefits that doing so brought. Investing in security mechanisms and practices sets your business up for long-term success by minimizing the risks of detrimental attacks.

This article is a supporting guide to the [Manage](../manage/index.md) methodology. It describes areas of security optimization that you should  consider as you move through that phase in your journey.

## Security posture modernization

During the Manage phase of your cloud adoption journey, you should have a robust [observability platform](../manage/monitor/observability.md) with thorough monitoring and intelligent alerting set up already, but modernizing this platform might require a new mindset that focuses heavily on proactive measures and adopting the principles of Zero Trust.

- **Assume breach:** Assuming that there's a breach in one or more of your systems is a key tenet of proactive detection and the driver of threat hunting and detection engineering. *Threat hunting* uses a hypothesis-based approach - that a breach has already happened in more particular form - to intelligently analyze your systems through tooling in an attempt to prove or disprove that hypothesis. *Detection engineering* is the practice of developing specialized detection mechanisms to augment observability platforms that aren't equipped to detect new and novel cyberattacks. 

- **Verify explicitly:** Moving from a mindset of "trust-by-default" to "trust-by-exception" means that you need to be able to validate trusted activities through visibility. Augmenting your observability platform with intelligent identity and access monitoring can help you detect anomalous behavior in real time.

### Azure facilitation

- [Microsoft Defender XDR](/defender-xdr/advanced-hunting-overview) provides advanced threat hunting across multiple domains, like endpoints, cloud apps, and identity. 

## Managing incident preparedness and response

- **Incident preparedness:** 

    - Implement a security information and event management (SIEM) and security orchestration, automation, and response (SOAR) solution to augment your infrastructure monitoring and alerting systems to detect and respond to security incidents.

    - Proactively scan your cloud systems for vulnerabilities. Using a vulnerability scanner that can be integrated with a SIEM system consolidates security data from across your environment, which helps you efficiently detect and respond to multiple types of security risks and incidents.
    
    - Increase the depth of your visibility into security risks in your environment by implementing an extended detection and response (XDR) solution. Feeding this data into your SIEM system unifies security monitoring into a single pane of glass and optimizes your [Security Operations](./secure-teams-and-roles.md) team's efficiency.

- **Incident response planning:** 

  Modernizing your observability platform is essential for incident detection. It's also the foundation for maintaining your incident response plan. Your incident response plan must be a living document that's updated regularly. It needs to keep pace with your threat hunting and detection engineering efforts, along with publicly available risk information like the [MITRE ATT&CK](https://attack.mitre.org/) knowledge base. 

  In addition to maintaining your incident response plans, you also need to have fully developed incident response and disaster recovery plans.

- **Business continuity and disaster recovery:** Develop and test disaster recovery plans to ensure that the cloud environment is resilient and can quickly recover from incidents. Include backup and recovery strategies that support business continuity. In many cases, individual workloads in your environment will have unique recovery targets and processes, so having workload-based plans is a good strategy rather than a single plan that covers all facets of the business. Refer to the Well-Architected [disaster recovery guide](/azure/well-architected/reliability/disaster-recovery) for workload-focused guidance on this topic.

### Azure facilitation

- [Microsoft Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction) has modules to monitor and protect many workload resources like [Servers](/azure/defender-for-cloud/plan-defender-for-servers-select-plan), [Storage](/azure/defender-for-cloud/defender-for-storage-introduction), [Containers](/azure/defender-for-cloud/defender-for-containers-introduction), [SQL](/azure/defender-for-cloud/quickstart-enable-database-protections), [DNS](/azure/defender-for-cloud/defender-for-dns-introduction), and more. These modules allow you to discover deep insights into their respective resources that you might otherwise be unable to find with your existing monitoring solution.

    - Defender for Server includes [Microsoft Defender Vulnerability Management](/azure/defender-for-cloud/deploy-vulnerability-assessment-defender-vulnerability-management) for vulnerability scanning against your Azure-based or Azure Arc-enabled VMs.

- [Microsoft Sentinel](/azure/sentinel/overview) is Microsoft's cloud-native SIEM and SOAR solution. You can use it as a standalone solution or it integrates with Microsoft Defender to provide a [unified security operations platform](/azure/sentinel/microsoft-sentinel-defender-portal).

- [Automated investigation and response in Microsoft Defender XDR ](/defender-xdr/m365d-autoir) helps your security operations team address threats more efficiently and effectively by providing automated detection and self-healing capabilities for many scenarios.

## Managing confidentiality

The ongoing management of your security posture as it relates to confidentiality relies on regularly performing well-designed monitoring and auditing practices, maintaining codified audit procedures, and looking for continuous improvement opportunities.

- **Regular monitoring and auditing:** To ensure the integrity of confidentiality policies, it's critical to establish a regular cadence for both monitoring and auditing. Continuous monitoring helps in the early detection of potential security threats and anomalies. However, monitoring alone is insufficient. Regular audits are necessary to verify that the policies and controls in place are effective and being adhered to. Audits provide a comprehensive review of the security posture and help identify any gaps or weaknesses that need to be addressed.

- **Documenting and institutionalizing audit procedures:** Documenting audit procedures is crucial for consistency and accountability. Institutionalizing these procedures ensures that audits are conducted systematically and regularly. Detailed documentation should include the scope of the audit, methodologies, tools used, and the frequency of audits. This practice not only helps in maintaining a high standard of security but also provides a clear trail for compliance and regulatory purposes.

- **Some best practices for enhancing confidentiality**

    - *Separation of Duties (SoD):* Implementing SoD helps prevent conflicts of interest and reduces the risk of fraud. By dividing responsibilities among different individuals, it ensures that no single person has control over all aspects of a critical process.

    - *Proactive user lifecycle maintenance:* Regularly updating and managing user accounts is vital. This practice includes promptly revoking access for users who no longer need it, updating permissions as roles change, and ensuring that inactive accounts are disabled. Proactive maintenance helps prevent unauthorized access and ensures that only current, authorized users have access to sensitive data. The Access Architects should include these measures in their standard operating procedures (SOPs).

### Azure facilitation

- [Microsoft Purview Data Loss Prevention (DLP)](/purview/dlp-learn-about-dlp) can help you detect and prevent exfiltration through common processes used by attackers today.  Microsoft Purview DLP can detect adversaries utilizing any first time use (FTU) or cloud application to exfiltrate sensitive data from endpoint devices. Microsoft Purview DLP can also identify the execution of these tools when adversaries rename them to remain undetected.

- [Microsoft Purview Insider Risk Management](/purview/insider-risk-management-solution-overview) can help detect and prevent potential malicious or inadvertent insider risks, such as IP theft, data leakage, and security violations.

## Managing integrity

Managing your data and system integrity relies on robust monitoring with specific configurations for detecting unauthorized changes to your assets. Other key tenets of the manage phase are adopting continuous improvement and training practices.

- **Data integrity monitoring:** Effectively monitoring data integrity is a complex task and using intelligent tooling can ease the burden of configuring the appropriate monitoring mechanisms. Combining intelligent data governance with SIEM and SOAR solutions allow you to gain deep insights into activities related to your data and to automate parts of your incident response plan. Your monitoring should detect anomalous behaviors, including unauthorized access to data stores and changes to the data stores. Automated incident responses like immediate lockouts can help minimize the blast radius of malicious activities.

- **System integrity monitoring:** Effectively monitoring for system integrity is more straightforward than data integrity. Most modern monitoring and alerting platforms are well equipped to detect changes to systems. With proper guardrails around deployments, like only allowing changes to the environment through IaC, and a well-designed authentication and access platform, you can ensure that changes happening outside of the approved protocols are detected and investigated immediately.

### Azure facilitation

### Data integrity monitoring

- [Microsoft Purview Data Estate Health](/purview/data-estate-health) helps you codify data standards and measure how the data in your estate complies with those standards over time. It provides reports to track data health and helps data owners remediate issues that arise.

## Managing availability

Managing the availability of your cloud estate relies on robust, proactive availability monitoring that is validated through testing.

- **Availability monitoring:** Ensure that all infrastructure and applications are configured for monitoring and that alerting is configured to notify the appropriate teams. Make use of cloud-native logging and [application instrumenting](/azure/well-architected/operational-excellence/instrument-application) functionality to simplify your monitoring design and reduce operational burden.

- **Availability testing:** All infrastructure and applications must be tested regularly for availability as part of your overall testing strategy. [Fault injection and chaos testing](/azure/well-architected/reliability/testing-strategy#fault-injection-and-chaos-engineering-guidance) are excellent strategies to test availability and security by purposely introducing malfunctions.

### Azure facilitation

In addition to the Microsoft Defender for Cloud solutions discussed above, consider the following solutions:

- [Autoinstrumentation for Azure Monitor Application Insights](/azure/azure-monitor/app/codeless-overview) allows you to easily instrument your application for rich telemetry monitoring through [Application Insights](/azure/azure-monitor/app/app-insights-overview). Many Azure-based and on-premises hosting types are supported for autoinstrumentation.

- [Azure Chaos Studio](/azure/chaos-studio/chaos-studio-overview) is a managed service that uses chaos engineering to help you measure, understand, and improve your cloud application and service resilience.

## Managing security sustainment

### Continuous education

Encourage ongoing education and certification in cloud security practices to stay abreast of evolving threats and technologies. This training should cover:

- **Threat detection:** Use advanced analytics and monitoring tools like Microsoft Sentinel to detect threats early, emphasizing continuous monitoring and proactive identification of threats. Advanced analytics enable the identification of unusual patterns and behaviors that may indicate potential security threats, while integrated threat intelligence provides up-to-date information on known threats, enhancing the system's ability to detect emerging risks. Include training on preplanned responses such as automated actions for containment to ensure rapid reaction to detected threats.

- **Incident response:** Train the Security Operations Team on robust incident response strategies that integrate Zero Trust principles, assuming threats can come from both internal and external sources. This activity includes continuous verification of identities and securing access to resources. Training should also cover the use of decision trees and flowcharts to guide response actions based on the specific incident scenarios.

    - **Availability:** Instruct on deploying high availability and disaster recovery solutions using Azure’s services to ensure data and resources remain accessible when needed. This training includes maintaining preplanned responses that outline the steps for maintaining availability during an incident. Education should cover strategies for ensuring continuous access to critical resources, even in the face of disruptions, and include hands-on training in setting up and managing Azure’s high availability and disaster recovery tools.
- **Simulation exercises:** Conduct regular security drills and simulations to prepare the team for real-world scenarios. These exercises should evaluate the organization's ability to respond to incidents within the Zero Trust framework, treating all network segments as potentially compromised until verified secure. Scenarios such as phishing attacks, data breaches, and ransomware should be simulated to identify gaps in response strategies and provide hands-on experience in handling incidents. Drills should emphasize containment strategies by quickly isolating compromised systems to prevent further spread, rapid communication by establishing clear and efficient channels for disseminating information, and evidence preservation by ensuring that all relevant data is securely collected and stored to support subsequent analysis and investigation. Use preplanned responses like incident playbooks and communication protocols to ensure that actions during these drills are consistent and systematic.

- **Incident response drills:** Regularly test incident response plans through realistic drills that simulate various threat scenarios. These drills should involve all relevant stakeholders, including the Security Operations Center (SOC) Team, Incident Response Coordinators, Governance Lead, Incident Controller, Investigation Lead, Infrastructure Lead, and the Cloud Governance Team, ensuring comprehensive preparedness across the organization. Incorporate elements of the CIA Triad and Zero Trust principles into these drills, such as testing the effectiveness of access controls (Confidentiality), integrity checks for critical data, and procedures for maintaining service availability during an incident. Emphasize effective coordination by ensuring clear communication and collaborative efforts across teams, using preplanned responses such as predefined roles and responsibilities, and rapid containment by swiftly isolating affected systems and mitigating threats. Ensure detailed documentation of actions taken to provide a clear record for post-incident review and continuous improvement.

### Continuous improvement strategies for confidentiality and integrity

Continuous improvement is essential for maintaining and enhancing confidentiality and integrity in enterprise cloud environments. Documenting the results of configuration management (CM) and audits/inspections is crucial. This documentation provides a historical record that can be analyzed to identify trends, recurring issues, and areas for improvement.

- **Confidentiality strategies:**

    - *Learn from the past:* Implementing lessons learned from past inspections is a key tenet of continuous improvement. By analyzing the outcomes of previous audits and inspections, organizations can identify weaknesses and implement corrective actions to prevent similar issues in the future. This proactive approach ensures that the organization continuously evolves and improves its security posture.

    - *Leverage real-time data:* Real-time monitoring plays a critical role in continuous improvement. By leveraging real-time data, organizations can quickly identify and respond to potential threats, ensuring that security measures are always up-to-date and effective. This dynamic approach helps avoid repeating past mistakes and ensures that the organization remains resilient against emerging threats.

    - *Confidentiality training:* As part of your overall training strategy, ensure that employees are trained on your confidentiality policies and procedures. This training should be mandatory for new hires, with deeper training specific to their roles for those in the security team, and should be regularly recurring for all employees. Teach the importance of implementing encryption and strict access controls to protect sensitive information from unauthorized access. Training should cover best practices in data encryption technologies and access management tools to ensure only authorized personnel can access sensitive data.
    
- **Integrity strategies:**

    - *Routinely audit your data:* Routinely perform manual audits of your data to ensure that your data governance and monitoring tooling is performing as expected and look for areas of improvement.

        - *Data hygiene:* Adopt good data hygiene habits like:

            - Manually audit data for quality, accuracy, and consistency, correcting errors when they're discovered.

            - Use strategies to reduce inconsistencies and redundancies like normalization.

            - Archive historical data in cold or offline storage when no longer needed in production or purge data that doesn't need to be archived.

            - Regularly review encryption configurations to ensure that all sensitive data is encrypted at rest and in transit. Be sure to regularly review industry standards for encryption and ensure that your systems align with those standards.

        - Regularly review backup configurations to ensure that all data stores containing sensitive data or other critical data is being backed up and perform restore tests to ensure that the backup data is valid. Regularly test restores to ensure that your systems are in compliance with your organization's recovery time objective (RTO) and recovery point objective (RPO) targets.
    
    - *Regularly review access to systems and data:* Access permissions to systems and data stores should happen regularly to ensure that there are no gaps in your access controls and policies. 

    - *Integrity training:* As part of your overall training strategy, ensure that employees are trained on your data and system integrity policies and procedures. This training should be mandatory for new hires, with deeper training specific to their roles for those in the security team, and should be regularly recurring for all employees. Educate on the use of DevOps processes for infrastructure as code (IaC) to ensure data accuracy and reliability. DevOps practices, such as version control, continuous integration, and automated testing, help track, audit, and validate changes to the cloud environment's infrastructure before deployment. DevOps practices are particularly important in maintaining landing zones, as they ensure consistency and integrity in the configuration by providing a systematic way to handle infrastructure changes.

## Next step

> [!div class="nextstepaction"]
> Review the [Zero Trust adoption framework](/security/zero-trust/adopt/zero-trust-adoption-overview) to learn about integrating Zero Trust approaches throughout your cloud adoption journey.
> Review the Well-Architected Framework's [Security](/azure/well-architected/security) pillar to find workload-focused security guidance.