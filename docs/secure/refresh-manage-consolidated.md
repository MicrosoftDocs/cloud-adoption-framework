---
title: Securely manage your cloud estate
description: Learn how to adopt security best practices in your cloud estate management phase
author: claytonsiemens77
ms.author: csiemens
ms.date: 06/24/2024
ms.topic: conceptual
ms.custom: internal, UpdateFrequency2
---

# Securely manage your cloud estate

## Introduction


## Security posture mondernization

In the Manage phase of your cloud adoption journey, you should have a robust [observability platform](../manage/monitor/observability.md) with thorough monitoring and intelligent alerting setup already, but modernizing this platform may require a new mindset that focuses heavily on proactive measures and adopting the principles of Zero Trust.

- **Assume breach:** Assuming that there is a breach in one or more of your systems is a key tenet of proactive detection and the driver of threat hunting and detection engineering. *Threat hunting* uses a hypothesis-based approach - that a breach has already happened in more particular form - to intelligently analyze your systems through tooling in an attempt to prove or disprove that hypothesis. *Detection engineering* is the practice of developing specialized detection mechanisms to augment observability platforms that aren't equipped to detect new and novel cyber attacks. Security Information and Event Management (SIEM) and Security Orchestration, Automation, and Response (SOAR) systems are often used to augment monitoring and alerting solutions

- **Verify explicitly:** Moving from a mindset of "trust-by-default" to "trust-by-exception" means that you need to be able to validate trusted activities through visibility. Augmenting your observability platform with intelligent identity and access monitoring can help you detect anomolous behavior in real time.

## Managing incident preparedness and response

- **Incident response planning:** 

Moderninzing your observability platform is essential for incident detection, and is also the foundation for maintaining your incident response plan. Your incident response plan must be considered a living document that is updated regularly to keep pace with your threat hunting and detection engineering efforts, along with publicly available risk information like the [MITRE ATT&CK](https://attack.mitre.org/) knowledge base. 

In addition to maintaining your incident response plans, you also need to have fully developed incident response and disaster recovery plans.

- **Business continuity and disaster recovery:** Develop and test disaster recovery plans to ensure that the cloud environment is resilient and can quickly recover from incidents. Include backup and recovery strategies that support business continuity. In many cases, individual workloads in your environment will unique recovery targets and processes, so having workload-based plans is a good strategy rather than a single plan that covers all facets of the business. Refer to the Well-Architected [disaster recovery guide](/azure/well-architected/reliability/disaster-recovery) for workload-focused guidance on this topic.

## Managing confidentiality

The ongoing management of your security posture as it relates to confidentiality relies on regularly performing well-designed monitoring and auditing practices, maintaining codified audit procedures, and looking for continuous improvement opportunities.

- **Regular monitoring and auditing:** To ensure the integrity of confidentiality policies, it is essential to establish a regular cadence for both monitoring and auditing. Continuous monitoring helps in the early detection of potential security threats and anomalies. However, monitoring alone is insufficient. Regular audits are necessary to verify that the policies and controls in place are effective and being adhered to. Audits provide a comprehensive review of the security posture and help identify any gaps or weaknesses that need to be addressed.

- **Documenting and institutionalizing audit procedures:** Documenting audit procedures is crucial for consistency and accountability. Institutionalizing these procedures ensures that audits are conducted systematically and regularly. Detailed documentation should include the scope of the audit, methodologies, tools used, and the frequency of audits. This not only helps in maintaining a high standard of security but also provides a clear trail for compliance and regulatory purposes.

- **Continuous improvement:** Continuous improvement is essential for maintaining and enhancing confidentiality in enterprise cloud environments. Documenting the results of configuration management (CM) and audits/inspections is crucial. This documentation provides a historical record that can be analyzed to identify trends, recurring issues, and areas for improvement.

    Implementing lessons learned from past inspections is equally important. By analyzing the outcomes of previous audits and inspections, organizations can identify weaknesses and implement corrective actions to prevent similar issues in the future. This proactive approach ensures that the organization continuously evolves and improves its security posture.

    Real-time monitoring plays a critical role in continuous improvement. By leveraging real-time data, organizations can quickly identify and respond to potential threats, ensuring that security measures are always up-to-date and effective. This dynamic approach helps avoid repeating past mistakes and ensures that the organization remains resilient against emerging threats.

- **Some best practices for enhancing confidentiality**

    - *Separation of Duties (SoD):* Implementing SoD helps prevent conflicts of interest and reduces the risk of fraud. By dividing responsibilities among different individuals, it ensures that no single person has control over all aspects of a critical process.

    - *Proactive user lifecycle maintenance:* Regularly updating and managing user accounts is vital. This includes promptly revoking access for users who no longer need it, updating permissions as roles change, and ensuring that inactive accounts are disabled. Proactive maintenance helps prevent unauthorized access and ensures that only current, authorized users have access to sensitive data.
    
## Managing integrity

Managing your data and system integrity relies on robust monitoring with specific configurations for detecting unauthorized changes to your assets. Other key tenets of the manage phase are adopting continuous improvement and training practices.

- **Data integrity monitoring:** Effectively monitoring data integrity is a complex task and using intelligent tooling can ease the burden of configuring the appropriate monitoring mechanisms. Combining intelligent data governance with SIEM and security orchestration, automation, and response (SOAR) solutions allow you to gain deep insights into activities related to your data and to automate parts of your incident response plan. Your monitoring should detect anomolous behaviors, including unauthorized access to data stores and changes to the data stores. Automated incident responses like immediate lockouts can help minimize the blast radius of malicious activities.

- **System integrity monitoring:** Effectively monitoring for system integrity is more straightforward than data integrity. Most modern monitoring and alerting platforms are well equipped to detect changes to systems. With proper guardrails around deployments, like only allowing changes to the environment through IaC, and a well-designed authentication and access platform, you can ensure that changes happening outside of the approved protocols are detected and investigated immediately.

- **Continuous improvement:** The continuous improvement [guidance](./refresh-adopt-confidentiality.md#manage) provided in the "Adopt confidentiality" article is applicable to integrity. Recommendations specific to integrity are:

    - *Routinely audit your data:* Routinely perform manual audits of your data to ensure that your data governance and monitoring tooling is performing as expected and look for areas of improvement.

    - *Data hygiene:* Adopt good data hygiene habits like:

        - Manually audit data for quality, accuracy and consistency, correcting errors when they are discovered.
    
        - Use strategies to reduce inconsistencies and redundancies like normalization.
    
        - Archive historical data in cold or offline storage when no longer needed in production or purge data that doesn't need to be archived.
    
        - Regularly review encryption configurations to ensure that all sensitive data is encrypted at rest and in transit.
    
        - Regularly review backup configurations to ensure that all data stores containing sensitive data or other critical data is being backed up and perform restore tests to ensure that the backup data is valid.
    
    - *Regularly review access to systems and data:* Access permissions to systems and data stores should happen regularly to ensure that there are no gaps in your access controls and policies. 

- **Integrity training:** As part of your overall training strategy, ensure that employees are trained on your data and system integrity policies and procedures. This training should be mandatory for new hires, with deeper training specific to their roles for those in the security team, and should be regularly recurring for all employees.

## Managing availability

Managing the availability of your cloud estate relies on robust, proactive availability monitoring that is validated through testing.

- **Availability monitoring:** Ensure that all infrastructure and applications are configured for monitoring and that alerting is configured to notify the appropriate teams. Make use of cloud-native logging and [application instrumenting](/azure/well-architected/operational-excellence/instrument-application) functionality to simplify your monitoring design and reduce operational burden.

- **Availability testing:** All infrastructure and applications must be tested regularly for availability as part of your overall testing strategy. [Fault injection and chaos testing](/azure/well-architected/reliability/testing-strategy#fault-injection-and-chaos-engineering-guidance) are excellent strategies to test availability and security by purposely introducing malfunctions.

## Managing security sustainment


