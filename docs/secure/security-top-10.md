---
title: Azure security best practices
description: Find out what Microsoft recommends as the top Azure security best practices.
author: JanetCThomas
ms.author: brblanch
ms.date: 01/06/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: secure
ms.custom: internal
---

# Azure security best practices

This list includes the top Azure security best practices that Microsoft recommends based on lessons learned across customers and our own environments.

For a video presentation of these best practices, see [Top 10 best practices for Azure security](https://techcommunity.microsoft.com/t5/video-hub/top-10-best-practices-for-azure-security/ba-p/1698837).

## 1. People: Educate teams about the cloud security journey

*The team needs to understand the journey they're on.*

### What 

Educate your security and IT teams on the cloud security journey and the changes they'll be navigating including:

- Changes to threats in the cloud
- Shared responsibility model and how it impacts security
- Cultural and role/responsibility changes that typically come with cloud adoption

### Why 

Moving to the cloud is a significant change that requires a shift in mindset and approach for security. While the outcomes security provides to the organization won't change, the best way to accomplish these outcomes in the cloud often changes, sometimes significantly.

The transition to the cloud is similar to moving from a standalone house into a high-rise apartment building. You still have basic infrastructure (like plumbing and electricity) and do similar activities (such as socializing, cooking, TV and internet, and so on). However, there's often quite a difference in what comes with the building, who provides and maintains them, and your daily routine.

### Who 

Everyone in the security and IT organization with any security responsibilities should be familiar with this context and the changes (from CIO/CISO to technical practitioners).

### How 

Provide teams with the context required to successfully deploy and operate during the transition to the cloud environment.

Microsoft has published the following lessons that customers and IT organization have learned on their journeys to the cloud:

- How [security roles and responsibilities](../organize/cloud-security.md) are evolving in the security organization
- [Evolution of threat environment, roles, and digital strategies](/security/compass/microsoft-security-compass-introduction)
- [Transformation of security, strategies, tools, and threats](/security/compass/microsoft-security-compass-introduction#transformation-of-security-strategies-tools--threats-1513)
- [Learnings from Microsoft experience securing hyperscale cloud environment](/security/compass/microsoft-security-compass-introduction#microsoft-security-practices-1349) that can help you on your journey

Also see the Azure Security Benchmark [gs-3: align organization roles, responsibilities, and accountabilities](/security/benchmark/azure/security-controls-v2-governance-strategy#gs-3-align-organization-roles-responsibilities-and-accountabilities).

## 2. People: Educate teams on cloud security technology

*People need to understand where they're going.*

### What

Ensure your teams have time set aside for technical education on securing cloud resources including:

- Cloud technology and cloud security technology
- Recommended configurations and best practices
- Where to learn more technical details as needed

### Why 

Technical teams need access to technical information to make sound informed security decisions. Technical teams are good at learning new technologies on the job, but the volume of details in the cloud often overwhelms their ability to fit learning into their daily routine.

Set aside dedicated time for technical learning. This learning helps ensure people have time to build confidence on their ability to assess cloud security and think through how to adapt their existing skills and processes. Even the most talented special operations teams in the military need training and intelligence to work at their best.

### Who 

All security and IT roles that directly interact with cloud technology should dedicate time for technical learning on cloud platforms and how to secure them.

Additionally security, IT technical managers, and project managers should develop familiarity with some technical details for securing cloud resources. This familiarity helps them more effectively lead and coordinate cloud initiatives.

### How 

Ensure that technical professionals in security have time set aside for self-paced training on how to secure cloud assets. While not always feasible, ideally provide access to formal training with an experienced instructor and hands-on labs.

> [!IMPORTANT]
> Identity protocols are critical to access control in the cloud but often not prioritized in on-premises security, so security teams should ensure to focus on developing familiarity with these protocols and logs.

Microsoft provides extensive resources to help technical professionals ramp up on securing Azure resources and report compliance:

- Azure security
  - Az-500 [learning path](/learn/certifications/exams/az-500?tab=tab-learning-paths) (and certification)
  - [Azure Security Benchmark (ASB)](/security/benchmark/azure/) -prescriptive best practices and controls for Azure security
    - [Security baselines for Azure](/security/benchmark/azure/security-baselines-overview): Application of ASB to individual Azure services
  - [Microsoft security best practices](/security/compass/microsoft-security-compass-introduction) - videos and documentation
- Azure compliance
  - [Regulatory compliance](/azure/security-center/security-center-compliance-dashboard) evaluation with Microsoft Defender for Cloud
- Identity protocols and security
  - [Azure security documentation site](/azure/security/)
  - Azure AD authentication [YouTube series](https://www.youtube.com/playlist?list=PLLasX02E8BPD5vC2XHS_oHaMVmaeHHPLy)
  - [Securing Azure environments with Azure Active Directory](https://azure.microsoft.com/resources/securing-azure-environments-with-azure-active-directory/)

Also see the Azure Security Benchmark [gs-3: align organization roles, responsibilities, and accountabilities](/security/benchmark/azure/security-controls-v2-governance-strategy#gs-3-align-organization-roles-responsibilities-and-accountabilities)

## 3. Process: Assign accountability for cloud security decisions

*If nobody is accountable for making security decisions, they won't get made.*

### What 

Choose who is responsible for making each type of security decision for the enterprise Azure environment.

### Why 

Clear ownership of security decisions speeds up cloud adoption **and** increases security. Lack of ownership typically creates friction. It creates friction because nobody feels empowered to make decisions. Also, nobody knows who to ask for a decision and nobody is incentivized to research a well-informed decision. Friction frequently impedes:

* Business goals
* Developer timelines
* IT goals
* Security assurances

The friction can result in:

- Stalled projects that are waiting for security approval
- Insecure deployments that couldn't wait for security approval

### Who 

Security leadership chooses which teams or individuals are accountable for making security decisions about the cloud.

### How

Choose groups (or individuals) that will be responsible for making key security decisions.

Document these owners, their contact information, and socialize the information widely within the security, IT, and cloud teams to ensure it's easy for all roles to contact them.

These areas are typically areas where security decisions are needed. The following table shows the decision category, category description, and which teams typically make the decisions.

| Decision         | Description           | Typical team  |
| ------------- |-------------| -----|
| Network security | Configuration and maintenance of Azure Firewall, network virtual appliances (and associated routing), Web Application Firewalls (WAFs), NSGs, ASGs, and so on. | *Typically [Infrastructure and endpoint security](../organize/cloud-security-infrastructure-endpoint.md) team focused on network security*  |
| Network management | Enterprise-wide virtual network and subnet allocation | *Typically existing network operations team in [Central IT Operations](../organize/central-it.md)* |
| Server endpoint security | Monitor and remediate server security (patching, configuration, endpoint security, and so on.) | *Typically [Central IT Operations](../organize/central-it.md) and [Infrastructure and endpoint security](../organize/cloud-security-infrastructure-endpoint.md) teams jointly* |
| Incident monitoring and response | Investigate and remediate security incidents in SIEM or source console (Microsoft Defender for Cloud, Azure AD identity protection, and so on.) | *Typically [security operations](../organize/cloud-security-operations-center.md) team* |
| Policy management | Set direction for use of Azure role-based access control (Azure RBAC), Microsoft Defender for Cloud, administrator protection strategy, and Azure Policy to govern Azure resources | *Typically [Policy and Standards](../organize/cloud-security-policy-standards.md) + [Security Architecture](../organize/cloud-security-architecture.md) Teams jointly* |
| Identity security and standards | Set direction for Azure AD directories, PIM/pam usage, multi-factor authentication, password/synchronization configuration, application identity standards | *Typically [Identity and Key Management](../organize/cloud-security-identity-keys.md) + [Policy and Standards](../organize/cloud-security-policy-standards.md) + [Security Architecture](../organize/cloud-security-architecture.md) Teams jointly*  |

> [!NOTE]
>
> - Ensure decision makers have the appropriate education in their area of the cloud to accompany this responsibility.
> - Ensure decisions are documented in policy and standards to provide a record and guide the organization over the long term.

Also see the Azure Security Benchmark [gs-3: align organization roles, responsibilities, and accountabilities](/security/benchmark/azure/security-controls-v2-governance-strategy#gs-3-align-organization-roles-responsibilities-and-accountabilities)

## 4. Process: Update incident response processes for cloud

*You don't have time to plan for a crisis during a crisis.*

### What

Update processes and prepare analysts to for responding to security incidents on your Azure cloud platform. This preparation includes any [native threat detection tools](../get-started/security.md#step-1-establish-essential-security-practices) you've adopted. Update processes, prepare your team, and practice with simulated attacks so they can work at their best during incident investigation, remediation, and threat hunting.

### Why 

Active attackers present an immediate risk to the organization. The risk can quickly become a difficult to control situation. Respond quickly and effectively to attacks. This incident response (IR) process must be effective for your entire estate including all cloud platforms hosting enterprise data, systems, and accounts.

While similar in many ways, cloud platforms are different technically from on-premises systems. On-premises systems can break existing processes, typically because information is available in a different form. Security analysts may also have challenges rapidly responding to an unfamiliar environment that can slow them down. This statement is true, especially if they're trained only on classic on-premises architectures and network/disk forensics approaches.

### Who 

IR processes modernization is typically led by [security operations](../organize/cloud-security-operations-center.md). The effort often comes with support from other groups for knowledge and expertise.

- **Sponsorship**: This process modernization is typically sponsored by the security operations director or equivalent.
- **Execution**: Adapting existing processes (or writing them for the first time) is a collaborative effort involving:

  - [Security operations](../organize/cloud-security-operations-center.md) incident management team or leadership - leads process and integration updates to key external stakeholders. These teams include legal and communications or public relations teams
  - [Security operations](../organize/cloud-security-operations-center.md) security analysts - provide expertise on technical incident investigation and triage
  - [Central IT operations](../organize/central-it.md) - provides expertise on cloud platform (directly, via cloud center of excellence, or via external consultants)

### How 

Update processes and prepare your team so they know what to do when they find an active attacker.

- **Processes and playbooks**: Adapt existing investigations, remediation, and threat hunting processes to the differences of how cloud platforms work. The differences include new or different tools, data sources, identity protocols, and so on.
- **Education**: Educate analysts on the overall cloud transformation, technical details of how the platform works, and new or updated processes. This information lets them know what will be different and where to go for what they need.
- **Key Focus Areas**: While there are many details described in the resource links, these areas are where to focus your education and planning efforts:
- **Shared responsibility model and cloud architectures**: To a security analyst, Azure is a software-defined datacenter that provides many services. These services include VMs and others that are different from on-premises, such as Azure SQL Database Azure Functions and so on. The best data is in the service logs or the specialized threat detection services. It's not in logs for the underlying OS/VMs, which are operated by Microsoft and service multiple customers. Analysts need to understand and integrate this context into their daily workflows. That way they know what data to expect, where to get it, and what format it will be in.
- **Endpoint data sources**: Getting insights and data for attacks and malware on cloud hosted servers is often faster, easier, and more precise with native cloud-detection tools. Tools like Microsoft Defender for Cloud and endpoint detection and response (EDR) solutions provide more precise data than traditional approaches of direct disk access. Direct disk forensics are available for scenarios where it's possible and required for legal proceedings. For more information, see ([computer forensics in Azure](/azure/architecture/example-scenario/forensics/)). Often, though, this approach is the most inefficient way to detect and investigate attacks.
- **Network and identity data sources**: Many functions of cloud platforms primarily use identity for access control. This access control includes access to the Azure portal, though network access controls are used extensively as well. This access control requires analysts to develop an understanding of cloud identity protocols to get a full, rich picture of attacker activity and legitimate user activity to support incident investigation and remediation. Identity directories and protocols are also different from on-premises ones. They're typically based on SAML, OAuth, and OpenID Connect and cloud directories rather than LDAP, Kerberos, NTLM, and Active Directory.
- **Practice exercises**: Simulated attacks and response can help build organizational muscle memory and technical readiness. They provide preparation for your security analysts, threat hunters, incident managers, and other stakeholders in your organization. Learning on the job and adapting is a natural part of incident response, but you should work to minimize how much you have to learn in a crisis.

### Key Resources

- [Incident response reference guide (IRRG)](https://aka.ms/IRRG)
- Guidance on [building your own security incident response process](https://msrc-blog.microsoft.com/2019/07/01/inside-the-msrc-building-your-own-security-incident-response-process/)
- [Azure logging and alerting](/azure/security/fundamentals/log-audit)
- Microsoft security best practices
  - [Transformation of security, strategies, tools, & threats](/security/compass/microsoft-security-compass-introduction#transformation-of-security-strategies-tools--threats-1513)
  - [Security operations](/security/compass/security-operations-videos-and-decks)
- Microsoft learnings from Cyber Defense Operations Center (CDOC)
  - [Overall lessons learned](https://www.microsoft.com/security/blog/2019/02/21/lessons-learned-from-the-microsoft-soc-part-1-organization/)
  - [Incident investigation](https://www.microsoft.com/security/blog/2019/12/23/ciso-series-lessons-learned-from-the-microsoft-soc-part-3b-a-day-in-the-life/)
  - [Incident remediation](https://www.microsoft.com/security/blog/2020/05/04/lessons-learned-microsoft-soc-part-3c/)

Also see the Azure Security Benchmark [IR-1: preparation - update incident response process for Azure](/security/benchmark/azure/security-controls-v2-incident-response#ir-1-preparation--update-incident-response-process-for-azure).

## 5. Process: Establish security posture management

*First, know thyself.*

### What 

Ensure that you're actively managing the security posture of your Azure environment by:

- Assigning clear ownership of responsibilities for
  - Monitoring security posture
  - Mitigating risks to assets
- Automating and simplifying these tasks

### Why 

Rapidly identifying and remediating common security hygiene risks significantly reduces organizational risk.

The software-defined nature of cloud datacenters enables continuous monitoring of security risks (such as software vulnerabilities or security misconfigurations) with extensive asset instrumentation. The speed at which developers and IT team can deploy VMs, databases, and other resources also create a need to ensure resources are configured securely and actively monitored.

These new capabilities offer new possibilities, but realizing value from them requires assigning responsibility for using them. Executing consistently on with rapidly evolving cloud operations also requires keeping human processes as simple and automated as possible. See the "drive simplicity" [security principle](/azure/architecture/framework/security/security-principles).

> [!NOTE]
 > The goal of simplification and automation isn't about getting rid of jobs, but about removing the burden of repetitive tasks from people so they can focus on higher value human activities like engaging with and educating IT and DevOps teams.

### Who 

This practice is typically divided into two sets of responsibilities:

- **[Security posture management](../organize/cloud-security-posture-management.md)**: This function is often an evolution of existing vulnerability management or governance functions. The result includes monitoring overall security posture using Microsoft Defender for Cloud secure score and other data sources. It also includes actively working with resource owners to mitigate risks and reporting risk to security leadership.
- **Security remediation**: Assign accountability for addressing these risks to the teams responsible for managing those resources. This accountability should belong to either the DevOps teams managing their own application resources or the technology-specific teams in **[Central IT Operations](../organize/central-it.md)**:

  - **Compute and application resources:**
    - **App services:** Application development/security teams
    - **Containers:** Application development or infrastructure/IT operations
    - **VMs/scale sets/compute:** IT/infrastructure operations
  - **Data and storage resources:**
    - **SQL/Redis/Data Lake Analytics/data lake store:** Database team
    - **Storage accounts:** Storage/infrastructure team
  - **Identity and access resources:**
    - **Subscriptions:** Identity teams
    - **Key Vault:** Identity or information/data security team
  - **Networking resources:** Network security team
  - **IoT security:** IoT operations team

### How 

Security is everyone's job. Not everyone, though, currently knows how important it is, what to do, and how to do it.

- Hold resource owners accountable for the security risk just as they're held accountable for availability, performance, cost, and other success factors.
- Support resource owners with a clear understanding of why security risk matters to their assets, what they should do to mitigate risk, and how to implement it with minimal productivity loss.

> [!IMPORTANT]
> The explanations for why, what, and how to secure resources are often similar across different resource types and applications, but it's critical to relate these to what each team already knows and cares about. Security teams should engage with their IT and DevOps counterparts as a trusted advisor and partner focused on enabling these teams to be successful.

**Tooling**: [secure score](/azure/security-center/secure-score-security-controls) in Microsoft Defender for Cloud provides an assessment of the most important security information in Azure for a wide variety of assets. This assessment should be your starting point on posture management and can be supplemented with custom Azure policies and other mechanisms as needed.

**Frequency**: set up a regular cadence (typically monthly) to review Azure secure score and plan initiatives with specific improvement goals. The frequency can be increased as needed.

> [!TIP]
 > Gamify the activity if possible to increase engagement, such as creating fun competitions and prizes for the DevOps teams that improve their score the most.

Also see the Azure Security Benchmark [gs-2: define security posture management strategy](/security/benchmark/azure/security-controls-v2-governance-strategy#gs-2-define-security-posture-management-strategy).

## 6. Technology: Require passwordless or multi-factor authentication

*Are you willing to bet the security of your enterprise that professional attackers can't guess or steal your administrator's password?*

### What 

Require all critical impact admins to use passwordless or multi-factor authentication.

### Why 

Just as antique skeleton keys won't protect a house against a modern day burglar, passwords can't protect accounts against common attacks we see today. Technical details are described in [Your pa$$word doesn't matter](https://techcommunity.microsoft.com/t5/azure-active-directory-identity/your-pa-word-doesn-t-matter/ba-p/731984).

Multi-factor authentication was once a burdensome extra step. Passwordless approaches today improve how users sign in using biometric approaches like facial recognition in Windows Hello and mobile devices. Additionally, zero trust approaches remember trusted devices. This method reduces prompting for annoying out of band multi-factor authentication actions. For more information, see [User sign-in frequency](/azure/active-directory/conditional-access/howto-conditional-access-session-lifetime#user-sign-in-frequency).

### Who 

Password and multifactor initiative is typically led by [identity and key management](../organize/cloud-security-identity-keys.md) or [security architecture](../organize/cloud-security-architecture.md).

- **Sponsorship:** Typically sponsored by CISO, CIO, or director of identity.
- **Execution:** A collaborative effort involving:
  - [Policy and standards](../organize/cloud-security-policy-standards.md) team establish clear requirements
  - [Identity and key management](../organize/cloud-security-identity-keys.md) or [central IT operations](../organize/central-it.md) to implement the policy
  - [Security compliance management](../organize/cloud-security-compliance-management.md) monitors to ensure compliance

### How 

Implement passwordless or multi-factor authentication. Also, train administrators on how to use it as they need it, and require admins to follow using written policy. This can be accomplished by one or more of these technologies:

- [Passwordless (Windows Hello)](/windows/security/identity-protection/hello-for-business/hello-identity-verification)
- [Passwordless (authenticator app)](/azure/active-directory/authentication/howto-authentication-passwordless-phone)
- [Azure multifactor authentication](/azure/active-directory/authentication/howto-mfa-userstates)
- Third-party multi-factor authentication solution

> [!NOTE]
> Text message-based multifactor authentication is now relatively inexpensive for attackers to bypass, so focus on passwordless and stronger multifactor authentication.

Also see the Azure Security Benchmark [ID-4: use strong authentication controls for all Azure Active Directory-based access](/security/benchmark/azure/security-controls-v2-identity-management#id-4-use-strong-authentication-controls-for-all-azure-active-directory-based-access).

## 7. Technology: Integrate native firewall and network security

*Simplify protection of systems and data against network attacks.*

### What 

Simplify your network security strategy and maintenance by integrating Azure Firewall, Azure web app firewall (WAF), and distributed denial of service (DDoS) mitigations into your network security approach.

### Why

Simplicity is critical to security as it reduces likelihood of risk from confusion, misconfigurations, and other human errors. See the "drive simplicity" [security principle](/azure/architecture/framework/security/security-principles).

Firewalls and WAFs are important basic security controls to protect applications from malicious traffic, but their setup and maintenance can be complex and consume a significant amount of the security team's time and attention (similar to adding custom aftermarket parts to a car). Azure's native capabilities can simplify implementation and operation of firewalls, web application firewalls, distributed denial of service (DDoS) mitigations, and more.

This practice can free up your team's time and attention for higher value security tasks like:

* Evaluating the security of Azure services
* Automating security operations
* Integrating security with applications and IT solutions

### Who

- **Sponsorship**: This update of network security strategy is typically sponsored by security leadership or IT leadership
- **Execution**: Integrating strategies into your cloud network security strategy is a collaborative effort involving:

  - [Security architecture](../organize/cloud-security-architecture.md) - establish cloud network security architecture with cloud network and cloud network security leads.
  - **Cloud network leads** ([central IT operations](../organize/central-it.md)) + **Cloud Network security leads** ([infrastructure security team](../organize/cloud-security-infrastructure-endpoint.md))
    - Establish cloud network security architecture with security architects
    - Configure firewall, NSG, and WAF capabilities and work with application architects on WAF rules
  - **Application architects:** Work with network security to build and refine WAF rule sets and DDoS configurations to protect the application without disrupting availability

### How 

Organizations looking to simplify their operations have two options:

- **Extend existing capabilities and architectures:** Many organizations often choose to extend the use of existing firewall capabilities so they can capitalize on existing investments into skills and process integration, particularly as they first adopt the cloud.
- **Embrace native security controls:** More organizations are starting to prefer using native controls to avoid the complexity of integrating third-party capabilities. These organizations are typically seeking to avoid the risk of a misconfiguration in load balancing, user-defined routes, the firewall or WAF itself, and delays in handoffs between different technical teams. This option is compelling to organizations embracing infrastructure as code approaches as they can automate and instrument the built-in capabilities more easily than third-party capabilities.

Documentation on Azure native network security capabilities can be found at:

- [Azure Firewall](/azure/firewall/overview)
- [Azure Web Application Firewall (WAF)](/azure/web-application-firewall/)
- [Azure DDoS protection](/azure/ddos-protection/ddos-protection-overview)

[Azure Marketplace](https://azuremarketplace.microsoft.com/marketplace/apps?page=1&search=firewall) includes many third-party firewall providers.

Also see the Azure Security Benchmark [ns-4: protect applications and services from external network attacks](/security/benchmark/azure/security-controls-v2-network-security#ns-4-protect-applications-and-services-from-external-network-attacks).

## 8. Technology: Integrate native threat detection

*Simplify detection and response of attacks against Azure systems and data.*

### What 

Simplify your threat detection and response strategy by incorporating native threat detection capabilities into your security operations and SIEM.

### Why 

The purpose of security operations is to reduce the impact of active attackers who get access to the environment. The impact is measured by mean time to acknowledge (MTTA) and remediate (MTTR) incidents. This practice requires both accuracy and speed in all elements of incident response. The result helps ensure the quality of tools and the efficiency of process execution are paramount.

It's difficult to get high threat detections using existing tools and approaches. The tools and approaches are designed for on-premises threat detection because of differences in cloud technology and its rapid pace of change. Natively integrated detections provide industrial scale solutions maintained by the cloud providers that can keep up with current threats and cloud platform changes.

These native solutions also enable security operations teams to focus on incident investigation and remediation. Focus on those items rather than wasting time by creating alerts from unfamiliar log data, integrating tools, and maintenance tasks.

### Who 

Typically driven by the [security operations](../organize/cloud-security-operations-center.md) team.

- **Sponsorship**: Typically sponsored by the security operations director or equivalent role.
- **Execution**: Integrating native threat detection is a collaborative effort involving those solutions with:
  - [Security operations](../organize/cloud-security-operations-center.md): Integrate alerts into SIEM and incident investigation processes. Also, educate analysts on cloud alerts and what they mean, and how to use the native cloud tools.
  - [Incident preparation](../organize/cloud-security-incident-preparation.md): Integrate cloud incidents into practice exercises and ensure practice exercises are conducted to drive team readiness.
  - [Threat intelligence](../organize/cloud-security-threat-intelligence.md): Research and integrate information on cloud attacks to inform teams with context and intelligence.
  - [Security architecture](../organize/cloud-security-architecture.md): Integrate native tooling into security architecture documentation.
  - [Policy and standards](../organize/cloud-security-policy-standards.md): Set standards and policy for enabling native tooling throughout the organization. Monitor for compliance.
  - [Infrastructure and endpoint](../organize/cloud-security-infrastructure-endpoint.md) / **[Central IT Operations](../organize/central-it.md):** Configure and enable detections, integrate into automation and infrastructure as code solutions.

### How 

Enable [threat detection in Microsoft Defender for Cloud](/azure/security-center/azure-defender) for all the resources you're using and have each team integrate these resources into their processes as described above.

Also see the Azure Security Benchmark [LT-1: enable threat detection for Azure resources](/security/benchmark/azure/security-controls-v2-logging-threat-detection#lt-1-enable-threat-detection-for-azure-resources).

## 9. Architecture: Standardize on a single directory and identity

*Nobody wants to deal with multiple identities and directories.*

### What 

Standardize on a single Azure AD directory. Also, standardize a single identity for each application and user in Azure.

> [!NOTE]
> This best practice refers specifically to enterprise resources. For partner accounts, use [Azure AD B2B](/azure/active-directory/external-identities/what-is-b2b) so you don't have to create and maintain accounts in your directory. For customer/citizen accounts, use [Azure AD B2C](/azure/active-directory-b2c/) to manage them.

### Why 

Multiple accounts and identity directories create unnecessary friction. They also create confusion in daily workflows for:

* Productivity users
* Developers
* IT and identity admins
* Security analysts
* Other roles

Managing multiple accounts and directories also creates an incentive for poor security practices. These practices include things like password reuse across accounts. It also increases the likelihood of stale or abandoned accounts that attackers can target.

While it sometimes seems easier to quickly stand up a custom LDAP directory for a particular application or workload, this action creates much more work to integrate and manage. This work is similar to choosing to set up an additional Azure tenant or on-premises Active Directory forest rather than using the existing enterprise tenant. See also the [security principle of driving simplicity](/azure/architecture/framework/security/security-principles).

### Who 

Often a cross-team effort, driven by [security architecture](../organize/cloud-security-architecture.md) or [identity and key management](../organize/cloud-security-identity-keys.md) teams.

- **Sponsorship**: Typically sponsored by [identity and key management](../organize/cloud-security-identity-keys.md) and [security architecture](../organize/cloud-security-architecture.md) (though some organizations may require sponsorship by CISO or CIO)
- **Execution**: A collaborative effort involving:
  - [Security architecture](../organize/cloud-security-architecture.md): Incorporates into security and IT architecture documents and diagrams
  - [Policy and standards](../organize/cloud-security-policy-standards.md): Document policy and monitor for compliance
  - [Identity and key management](../organize/cloud-security-identity-keys.md) or **[Central IT Operations](../organize/central-it.md)** to implement the policy by enabling features and supporting developers with accounts, education, and so on.
  - **Application developers** or **[Central IT Operations](../organize/central-it.md)**: Use identity in applications and Azure service configurations (responsibilities will vary based on level of DevOps adoption)

### How 

Adopt a pragmatic approach that starts with new *greenfield* capabilities. Then, clean up challenges with the *brownfield* of existing applications and services as a follow-up exercise:

- **Greenfield**: Establish and implement a clear policy that all enterprise identity should use a single Azure AD directory with a single account for each user.

- **Brownfield**: Many organizations often have multiple legacy directories and identity systems. Address these legacy items when the cost of ongoing management friction exceeds the investment to clean it up. While identity management and synchronization solutions can mitigate some of these issues, they lack deep integration of security and productivity features. These features enable a seamless experience for users, admins, and developers.

The ideal time to combine your use of identity is during application development cycles as you:

- Modernize applications for the cloud.
- Update cloud applications with DevOps processes.

While there are valid reasons for a separate directory for independent business units or regulatory requirements, multiple directories should be avoided in all other circumstances.

Also see the Azure Security Benchmark [ID-1: standardize Azure Active Directory as the central identity and authentication system](/security/benchmark/azure/security-controls-v2-identity-management#id-1-standardize-azure-active-directory-as-the-central-identity-and-authentication-system).

> [!IMPORTANT]
> The only exception to the single accounts rule is that privileged users (including IT administrators and security analysts) should have separate accounts for standard user tasks vs. administrative tasks.
>
> For more information, see Azure Security Benchmark [privileged access](/security/benchmark/azure/security-controls-v2-privileged-access).

## 10. Architecture: use identity-based access control (instead of keys)

### What 

Use Azure AD identities instead of key-based authentication wherever possible (Azure services, applications, APIs, and so on.).

### Why 

Key-based authentication can be used to authenticate to cloud services and APIs. But, it requires managing keys securely, which is challenging to do well, especially at scale. Secure key management is difficult for non-security professionals like developers and infrastructure professionals and they often fail to do it securely, often creating major security risks for the organization.

Identity-based authentication overcomes many of these challenges with mature capabilities. The capabilities include secret rotation, lifecycle management, administrative delegation, and more.

### Who

Often a cross-team effort, driven by [security architecture](../organize/cloud-security-architecture.md) or [identity and key management](../organize/cloud-security-identity-keys.md) teams.

- **Sponsorship**: Typically sponsored by [security architecture](../organize/cloud-security-architecture.md) or [identity and key management](../organize/cloud-security-identity-keys.md)  (though some organizations may require sponsorship by CISO or CIO).
- **Execution**: A collaborative effort involving
  - [Security architecture](../organize/cloud-security-architecture.md): Incorporates into security and IT architecture diagrams and documents.
  - [Policy and standards](../organize/cloud-security-policy-standards.md): Document policy and monitor for compliance.
  - [Identity and key management](../organize/cloud-security-identity-keys.md) or **[Central IT Operations](../organize/central-it.md)** to implement the policy by enabling features and supporting developers with accounts, education, and so on.
  - **App developers** or **[Central IT Operations](../organize/central-it.md)**: Use identity in applications and Azure service configurations (responsibilities will vary based on level of DevOps adoption).

### How

Setting an organizational preference and habit for using identity-based authentication requires following a process and enabling technology.

**The process**:

1. **Establish policy** and standards that clearly outline the default identity-based authentication, and acceptable exceptions.
2. **Educate** developers and infrastructure teams on why to use the new approach, what they need to do, and how to do it.
3. **Implement** changes in a pragmatic way - starting with new green field capabilities being adopted now and in the future (new Azure services, new applications) and then following up with a clean-up of existing brownfield configurations.
4. **Monitor** for compliance and follow up with developer and infrastructure teams to remediate.

**The technologies**: For non-human accounts such as services or automation, use [managed identities](/azure/active-directory/managed-identities-azure-resources/overview). Azure managed identities can authenticate to Azure services and resources that support Azure AD authentication. Authentication is enabled through predefined access grant rules, avoiding hard-coded credentials in source code or configuration files.

For services that don't support managed identities, use Azure AD to create a [service principal](/azure/active-directory/develop/app-objects-and-service-principals) with restricted permissions at the resource level instead. We recommended configuring service principals with certificate credentials and fallback to client secrets. In both cases, [Azure Key Vault](/azure/key-vault/general/overview) can be used with Azure managed identities, so that the runtime environment (such as an Azure function) can retrieve the credential from the key vault.

Also see the Azure Security Benchmark [ID-2: manage application identities securely and automatically](/security/benchmark/azure/security-controls-v2-identity-management#id-2-manage-application-identities-securely-and-automatically).

## 11. Architecture: establish a single unified security strategy

*Everyone needs to row in the same direction for the boat to go forward.*

### What 

Ensure all teams are aligned to a single strategy that both enables and secures enterprise systems and data.

### Why 

When teams work in isolation without being aligned to a common strategy, their individual actions can inadvertently weaken each other's efforts. The misalignment can create unnecessary friction that slows down progress against everyone's goals.

One example of teams working in isolation that has played out consistently in many organizations is the segmentation of assets:

- The *network security team* develops a strategy for segmenting a *flat network*. The strategy increases security, often based on physical sites, assigned IP address addresses/ranges, or similar items.
- Separately, the *identity team* developed a strategy for groups and Active Directory organizational units (OUs) based on their understanding and knowledge of the organization.
- Often, *application teams* find it difficult to work with these systems. It's difficult because they were designed with limited input and understanding of business operations, goals, and risks.

In organizations where this limitation happens, teams frequently experience conflicts over firewall exceptions. The conflicts can negatively impact security because teams approve exceptions. Also, productivity negatively impacts security because deployments slowdown for application functionality the business needs.

While security can create healthy friction by forcing critical thinking, this conflict only creates unhealthy friction that impedes goals. For more information, see [Security strategy guidance: the right level of security friction](../strategy/define-security-strategy.md#modernize-your-security-strategy).

### Who

- **Sponsorship**: The unified strategy typically cosponsored by the CIO, CISO, and CTO. The sponsorship often comes with business leadership support for some high-level elements and is championed by representatives from each team.
- **Execution**: The security strategy must be implemented by everyone. It should integrate data from various teams to increase ownership, buy-in, and likelihood of success.
  - [Security architecture](../organize/cloud-security-architecture.md): Leads the effort to build security strategy and resulting architecture. Also, actively gathers feedback from teams and documents it in presentations, documents, and diagrams for the various audiences.
  - [Policy and standards](../organize/cloud-security-policy-standards.md): Captures the appropriate elements into standards and policy and then monitors for compliance.
  - **All technical IT and security teams**: Provide input requirements, then align to and implement the enterprise strategy.
  - **Application owners and developers**: Read and understand strategy documentation that applies to them (ideally, guidance tailored to their role).

### How

Build and implement a security strategy for cloud that includes the input and active participation of all teams. While the process documentation format will vary, it should always include:

- **Active input from teams**: Strategies typically fail if people in the organization don't buy into them. Ideally, get all teams in the same room to collaboratively build the strategy. In the workshops we conduct with customers, we often find organizations have been operating in de facto silos and these meetings often result in people meeting each other for the first time. We also find that inclusiveness is a requirement. If some teams aren't invited, this meeting typically has to be repeated until all participants join it. If they don't join, then the project doesn't move forward.
- **Documented and communicated clearly**: All teams should have awareness of the security strategy. Ideally, the security strategy is a security component of the overall technology strategy. This strategy includes why to integrate security, what is important in security, and what security success looks like. This strategy should also include specific guidance for application and development teams so they can get clear, organized guidance without having to read through non-relevant information.
- **Stable, but flexible**: Strategies should remain relatively consistent and stable. But, the architectures and the documentation may need changes to add clarity and accommodate the dynamic nature of cloud. For example, filtering out malicious external traffic would stay consistent as a strategic imperative even if you shift from the use of a third-party next generation firewall to Azure Firewall and adjust diagrams and guidance on how to do it.
- **Start with segmentation**: Over the course of cloud adoption, your teams will address many strategy issues large and small, but you need to start somewhere. We recommend starting the security strategy with enterprise asset segmentation. This segmentation is a foundational decision that would be challenging to change later and requires both business input and many technical teams.

Microsoft has published video guidance for [applying a segmentation strategy to Azure](/security/compass/microsoft-security-compass-introduction#azure-components-and-reference-model-2151). There are also documents published about [enterprise segmentation](/security/compass/governance#enterprise-segmentation-strategy) and [aligning network security to it](/security/compass/network-security-containment#align-network-segmentation-with-enterprise-segmentation-strategy).

The Cloud Adoption Framework includes guidance to help your teams with:

- [Building a cloud strategy team](../get-started/team/cloud-strategy.md): Ideally, security should be integrated into an existing cloud strategy.
- [Build or modernize a security strategy](../strategy/define-security-strategy.md): To meet business and security goals in the current age of cloud services and modern threats.

Also see the [Azure Security Benchmark governance and strategy](/security/benchmark/azure/security-controls-v2-governance-strategy).
