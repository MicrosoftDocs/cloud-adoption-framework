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

# Security Integration
Rather than being considered a separate discipline, separated from the general flow of operations, security should be integrated into each facet of the business. 
TODO: Why?

## Integrated disciplines & operations
TODO: Paint the picture. What does the world look like when security is integrated? Are there differences in the processes, team structures, level of protection? How does that impact the business?

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
