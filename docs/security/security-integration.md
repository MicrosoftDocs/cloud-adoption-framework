---
title: Security Integration
description: Integrate security insights and practices into business and IT processes
author: NaomiOooo
ms.author: naomio
ms.date: 04/04/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: secure
ms.custom: internal
---

# Feel free to nuke all content here - saved in OneNote (delete this line after changes)




# Security Integration

While the majority of security functions operate out of sight of daily business workflows, some security goals require integration of security considerations into daily workflows and operations throughout the business organization. Just as security in the physical world is an integrated part of workflows like "if you see something, say something" and airport security checkpoints, so too must security be integrated into the normal experience of planning and operating the business. 

The goal of security integration is to achieve critical security goals while minimizing friction and change for the business, a delicate balance that is important to get right.

## Security Operations nomenclature disambiguation
Within the security space exists many commonly used terms for individual positions or teams whose definition, roles, and duties, can often differ wildly from organization to organization. Even the term for someone working in the security field can require clarification - "Security" might be specific to physical security, while "Cybersecurity" is reserved for all things technology related. However as identity becomes the new perimeter, even this deliniation becomes nebulous as physical security becomes tied to cybersecurity for things such as building or workstation access. What does become clear is the need for security as a concept which needs to be integrated into every part of an organization. 

The following is a breakdown of roles and their responsibilities as utilized in the Cloud Adoption Framework security documentation. Not all of the roles listed here are required to be separate individuals, as the overall workload will vary from company to company. However, the all of the responsibilities listed should have defined owners.

[//]: # (Security people be doin' security things)

### CISO - Chief Information Security Officer / Office of the CISO
>A [CISO](https://en.wikipedia.org/wiki/Chief_information_security_officer) is the senior-level executive within an organization responsible for establishing and maintaining the enterprise vision, strategy, and program to ensure information assets and technologies are adequately protected.

The CISO acts as the executive-level sponsor for all security-centric endevors and is accountable for the overall security posture and establishing the risk tolerance of an organization. The CISO and the Office of the CISO coordinates with other subject matter experts to create guidance, governance, as well as maintaining audit compliance. All security-specific personel generally report under or have a "dotted-line" relationship with the CISO. In larger enterprises, the Office of the CISO may act as a aggregation-only entity, acting as a auditing and reporting body without any hands-on-keyboard interactions with the environment. In other organizations, the CISO may not only define the company's security posture, but have direct reports responsible for the actual implementation of the policies, working hand-in-hand with the Chief Technology Officer (CTO) and their Information Technology (IT) teams.

**Responsibilities** - The CISO is the top executive sponsor, accountable for the establishment, implementation, and maintenance of the overall security posture, as well as ensuring that the organization is abiding by all required compliance and governance standards. The CISO is also responsible for the enterprise security vision, balancing the protection of information versus allowing for agility and growth. 

### SO - Security Operations
> Similar to / also known as: Security Operations Center (SOC), Cyber Defense Operations Center ([CDOC](https://www.microsoft.com/en-us/msrc/cdoc)), Information Security Operations Center (ISOC)

To some organizations, the way we define Security Operations within the Cloud Adoption Framework will potentially be the largest shift compared to some other contemporary definitions of the group. SO is responsible for all of the traditional functions expected of other Operations Center entities (such as the Network Operations Center (NOC)) - that is, monitoring for, and responding to active events - often referred to as **Incident Management**. Within [CAF](https://docs.microsoft.com/azure/cloud-adoption-framework/organize/cloud-security-operations-center), SO takes on additional responsibilities and migrates from a reactive-only stance to also including proactive activities. 

**Responsibilities** - Security Operations encompasses [Security Operations functions](https://docs.microsoft.com/azure/cloud-adoption-framework/organize/cloud-security-operations-center). This includes:

- Elevation to business risk management: SO is growing into a key component of managing business risk for the organization
- Metrics and goals: Tracking SO effectiveness is evolving from "time to detect" to these key indicators:
  - Responsiveness via mean time to acknowledge (MTTA).
  - Remediation speed via mean time to remediate (MTTR).
- Technology evolution: SO technology is evolving from exclusive use of static analysis of logs in a SIEM to add the use of specialized tooling and sophisticated analysis techniques. This provides deep insights into assets that provide high quality alerts and investigation experience that complement the breadth view of the SIEM. Both types of tooling are increasingly using AI and machine learning, behavior analytics, and integrated threat intelligence to help spot and prioritize anomalous actions that could be a malicious attacker.
- Threat hunting: SO is adding hypothesis driven threat hunting to proactively identify advanced attackers and shift noisy alerts out of frontline analyst queues.
- Incident management: Discipline is becoming formalized to coordinate nontechnical elements of incidents with legal, communications, and other teams. Integration of internal context: To help prioritize SO activities such as the relative risk scores of user accounts and devices, sensitivity of data and applications, and key security isolation boundaries to closely defend.
- Practice Exercises / Tabletops: Activity engaging in breach and bug testing activities against internal assets and endpoints to verify proper asset hardening.

**Security Operations versus Security Operations Center?**

When many people think of an IT Operations Center, they imagine a group of people in a room - surrounded by monitors, graphs, and various ticker streams. While this is an example implementation of an operations center, it is not the only option. In smaller organizations, the individuals focused on security may be directly integrated into the day-to-day IT operations staff. In some larger enterprises, a segregated SOC may not exist - its functions absorbed into other monitoring teams. The important takeaway is that all of the security responsibilities are covered.

### Security Architect

Security Architects often report directly to the CISO, being hyper-focused on the security posture of an environment, considering both current and future-tense implementations or changes. The Security Architect generally differs from operations-focused technical personel in scope (a more holistic enterprise view versus workload specific) and consideration of buisiness impact (return on investment, adherence to compliance).

**Responsibilities** 

- Influence [security policies and standards](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/organize/cloud-security-policy-standards)
- Guide the [cloud security posture management](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/organize/cloud-security-posture-management)
- Evangellize security education initiatives for [people security in the cloud](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/organize/cloud-security-people)
- Ensure [governance and compliance](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/organize/cloud-security-compliance-management) management functions are properly aligned with regulatory requirements

### Governance and Compliance

Whether you are operating in a global landscape, a [regulated industry](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/govern/policy-compliance/regulatory-compliance), or building a new online presence, governance and compliance can often present a challenge for an organization. Those focused on governance and compliance are tasked with validating that corporate governance is properly aligned and compliant with all regulations. Many industries may have additional requirements which necessitate third party auditors to validate compliance on a scheduled basis. 

**Responsibilities**

- Work hand-in-hand with the Security Architect to determine applicable regulatory compliance requirements for the enterprise.
- Validate adherance to required regulatory guidelines by way of stateful monitoring and scheduled auditing.


### Platform Security Engineer
> Similar to / also known as: IT Operations, Systems Administrator, Security Administrator

The platform security engineer is the more traditional hands-on role, generally tasked with the work of installing and actually implementing security fixes into the environment. The platform security engineer is generally tightly integrated not only with the Security Architect and Security Operations group, but also with individual workload owner and specialists. While the Security Operations team may often begin the incident response process, it usually falls into the domain of the platform security engineer to act as the subject matter expert (SME) when working to resolve the incident as well as to provide insight during a post mortem process. 

**Responsibilities**

- Have awareness of the risk mitigation posture across the enterprise systems. 
- Deep understanding of systems interconnectivity, endpoints, data classification, and common attack surfaces for enterprise systems.
- Ensure all systems and workloads abide by security requirements.
- Create procedure for regularlly scheduled patch and maintenance events.
- Act as the SME as needed during security incidents.
- 

### Application Security Engineer / DevSecOps

With the shift to serverless applications, the line between the responsibilities of an platform security engineer or the persons responsible for securing an application are becoming muddled. The idea of [DevSecOps](https://www.microsoft.com/en-us/securityengineering/devsecops) blurs the lines further by introducing concepts of continuous integration / continuous delivery (CI/CD) where the workload owners are the ones responsible for continuously updating the application. While DevSecOps and the application security engineer may currently be the outliers, cloud-native and containerized applications are quickly becoming the norm, supplanting traditional virtual machine-hosted workloads. 

**Responsibilities**

- Adoption of a full DevOps pipeline and [Secure Development Lifecycle (SDL)](https://www.microsoft.com/en-us/securityengineering/sdl) engineering practices.
- Understanding all regulatory requirements and defining metrics to successfully meet governance and compliance objectives.
- Utilization of threat modeling in order to reduce risk and further secure application against well known attack vectors.


## Integrated processes

The Security Roles list above can often seem daunting when intially attempting to fufill all of the various positions. The actual size of a security team will vary wildly depending on the size and need of an organization. In very general terms, the following needs must be met:

Regulatory Observance | Risk Management | Security Oversight | Security Event Monitoring | Incident Management | Risk Mitigation | Threat Modeling

Each of the needs eventually feeds into the others. Regulatory requirements often helps determine the risk management threshold of an organization. This in turn helps shape the overall security posture, leading to identifiable metrics which can be utilized to monitor the systems and workloads. Should a security event trigger on one of the monitored resources, an incident is spawned, triaged, and resolved through the mitigation process. The information from the post mortem of the incident can be used to adjust future threat models.

As part of the risk mitigation process or often as a regulatory requirement, user education may be required. The persons needing to be educated may be the application developer who was unaware of a specific type of potential breach attack, or an end user (client) who fell victim to a phishing attempt. 

[//]: # (TODO: Paint the picture. What does the world look like when security is integrated? The following are few questions that can help paint the picture. What processes and people need to be inplace to ensure integration of security? Does the security team have a responsibility to train & ready other teams to integrate security into their decisions? How does this team coordinate with IT staff and/or workload staff?)




### Strategic integration
Security integration begins with integration of security into business processes. Evaluate digital transformation strategy and cloud adoption strategies with the cloud strategy team on a regular rythm. Build on those strategies to identify required changes & risks resulting from that change. Use that risk and risk management insights to educate the business on the risks and other options that may mitigate risks, while empowering change.

### Platform and environment integration
Many security breaches start with inconsistent environmental configuration. Using approaches like Azure Landing Zones, define security requirements that must be included in the configuration of any environments.

### Governance integration
Automate enforcement of security requirements using integration with security governance and IT operations governance. Security requirements that aren't set at the environment level, but can be automatically enforced, should be added to standard governance processes.

### Adoption integration
Integrate with adoption, innovation, and workload teams, to understand cloud adoption plans & the teams which will be making critical decisions. Use those plans to educate technical teams on risks and risk tolerances to aid in decision making. Prepare those teams for innovation within automated security guardrails & any required security reviews. Coach the teams on ways to reach their goals within defined guardrails.

## Technical integration

The following are examples of integrating security into various technical functions across technology environments.

### Starting with Zero Trust
Zero Trust architecture adopts an "Assume Breach" mindset, shifting from a "if a breach occurs" to a "when a breach occurs" security stance. This strategic shift requires both technology and business teams to be in alignment in order for adoption to be succssful. The business must agree to prioritize zero trust activities and technology owners must move forward to create a segmented strategy which is applied to all parts of the enterprise - identity, network, data, application, and others.

#### Building an identity-based perimeter (Identity is the new perimeter)
Zero Trust is succinctly named - "Never trust, always verify" - do not trust identities or assume privileges. Verify and validate at every turn. Instead of relying on a singular authentication method such as a username and password (something you know), utilize multi-factor authentication (MFA) options to increase the likelihood of a user being who they claim to be. Use MFA to add secondary challenges via an authentication application on a registered phone (something you have) or match biometric features (something you are). After the identify is verified, conditional access policies allow additional for configuration options to manage risk and conform to various compliance and governance requirements.

Identity is verified on an resource-by-resource basis - this segmentation allows for a limited surface exposure. Successfully authenticating once will not guarantee that the identity will have access to all resources, but instead will be challenged on each attempt to access additional items.

### Detection
Data tracking for cloud-native, on-prem, a hybrid mix of the two, as well as all of the potential endpoints, is of paramount importance for security. Utilizing [Azure Application Insights](https://docs.microsoft.com/en-us/azure/azure-monitor/app/app-insights-overview) and [Microsoft 365 Defender](https://www.microsoft.com/en-us/microsoft-365/security/microsoft-365-defender) in combination with other tools such as [Azure Sentinel](https://azure.microsoft.com/en-us/services/azure-sentinel) can paint an overall status of your current security landscape. Properly configured, the [Azure Security Center](https://azure.microsoft.com/en-us/services/security-center) provides a wealth of insight from multiple datapoints in your cloud environment.

### Prevention
As the security perimeter has shifted to identity, end user education has never been of more importance. Continuous learning on common phishing attack methods, social engineering, as well as understanding surrounding the reasons for general security hygene should drive home the message that security starts with the user. Data classification and other specific governance requirements should be common knowledge. 

Data should be encrypted whenever possible - while actively being utilized, at rest, as well as in transit. For workloads with high security requirements for data in use, developers can consider utilizing [Azure Confidential Compute](https://azure.microsoft.com/en-us/solutions/confidential-compute/) to create hardware-based compute enclaves.  

DevSecOps places much of the security of the infrastructure of workloads into the hands of the application developer. As such, developers should follow well-known software development methodologies such as the [Microsoft Secure Lifecycle](https://www.microsoft.com/en-us/securityengineering/sdl/practices) (SDL) through the life of their applications. Utilizing the SDL will keep security at the forefront of the development and implementation processes. From creating a threat model, defining encryption requirements, to helping define an active penetration testing outline. 

Application security owners should work in concert with their Security Operations counterparts in order to perform regular security testing exercises. Depending on the industry, publications such as [NIST 800-84](https://csrc.nist.gov/publications/detail/sp/800-84/final) may provide information on meeting compliance requirements. Assigning roles such as [Blue Team](https://www.microsoft.com/security/blog/2020/06/11/blue-teams-helping-red-teams-a-tale-of-a-process-crash-powershell-and-the-mitre-attck-evaluation/) and [Red Team](https://www.microsoft.com/security/blog/2021/01/21/the-dynamic-duo-how-to-build-a-red-and-blue-team-to-strengthen-your-cybersecurity-part-2/) can help drive focus and allow for a more specific mindset when approaching security testing. Using a cybersecurity knowledge base such as [MITRE ATT&CK](https://attack.mitre.org/) will help in ensuring that testing includes real world scenarios. 
