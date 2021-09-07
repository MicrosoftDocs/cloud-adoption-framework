---
title: Azure security best practices
description: Find out what Microsoft recommends as the top Azure security best practices.
author: JanetCThomas
ms.author: brblanch
ms.date: 09/18/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: secure
ms.custom: internal
---

# Azure security best practices

These are the top Azure security best practices that Microsoft recommends based on lessons learned across customers and our own environments.

For a video presentation of these best practices, see [Top 10 best practices for Azure security](https://techcommunity.microsoft.com/t5/video-hub/top-10-best-practices-for-azure-security/m-p/1698837).

## 1. People: Educate teams about the cloud security journey

*The team needs to understand the journey they're on.*

**What**: educate your security and IT teams on the cloud security journey and the changes they will be navigating including:

- Changes to threats in the cloud
- Shared responsibility model and how it impacts security
- Cultural and role/responsibility changes that typically accompany cloud adoption

**Why**: moving to the cloud is a significant change that requires a shift in mindset and approach for security. While the outcomes security provides to the organization won't change, the best way to accomplish this in the cloud often changes, sometimes significantly.

In many ways, moving to the cloud is similar to moving from a standalone house into a high-rise luxury apartment building. You still have basic infrastructure (like plumbing and electricity) and perform similar activities (such as socializing, cooking, TV and internet, and so on). However, there is often quite a difference in what comes with the building (like restaurants or a gym), who provides and maintains them, and your daily routine.

**Who**: everyone in the security and IT organization with any security responsibilities should be familiar with this context and the changes (from CIO/CISO to technical practitioners).

**How**: provide teams with the context required to successfully deploy and operate during the transition to the cloud environment.

Microsoft has published lessons learned by our customers and our own IT organization on their journeys to the cloud:

- How [security roles and responsibilities](../organize/cloud-security.md) are evolving in the security organization
- [Evolution of threat environment, roles, and digital strategies](/security/compass/microsoft-security-compass-introduction#evolution-of-threat-environment-roles--digital-strategies-2004)
- [Transformation of security, strategies, tools, and threats](/security/compass/microsoft-security-compass-introduction#transformation-of-security-strategies-tools--threats-1513)
- [Learnings from Microsoft experience securing hyperscale cloud environment](/security/compass/microsoft-security-compass-introduction#microsoft-security-practices-1349) that can help you on your journey

Also see the Azure Security Benchmark [gs-3: align organization roles, responsibilities, and accountabilities](/security/benchmark/azure/security-controls-v2-governance-strategy#gs-3-align-organization-roles-responsibilities-and-accountabilities).

## 2. People: Educate teams on cloud security technology

*People need to understand where they're going.*

**What**: ensure your teams have time set aside for technical education on securing cloud resources including:

- Cloud technology and cloud security technology
- Recommended configurations and best practices
- Where to learn more technical details as needed

**Why**: technical teams need access to technical information to make sound informed security decisions. Technical teams are good at learning new technologies on the job, but the volume of details in the cloud often overwhelms their ability to fit learning into their daily routine.

Structuring dedicated time for technical learning helps ensure people have time to build confidence on their ability to assess cloud security and think through how to adapt their existing skills and processes. Even the most talented special operations teams in the military need training and intelligence to perform at their best.

**Who:** All roles that directly interact with cloud technology (in security and IT departments) should dedicate time for technical learning on cloud platforms and how to secure them.

Additionally security and IT technical managers (and often project managers) should develop familiarity with some technical details for securing cloud resources (as this will help them more effectively lead and coordinate cloud initiatives).

**How:** Ensure that technical professionals in security have time set aside for self-paced training on how to secure cloud assets. While not always feasible, ideally provide access to formal training with an experienced instructor and hands-on labs.

> [!IMPORTANT]
> Identity protocols are critical to access control in the cloud but often not prioritized in on-premises security, so security teams should ensure to focus on developing familiarity with these protocols and logs.

Microsoft provides extensive resources to help technical professionals ramp up on securing Azure resources and report compliance:

- Azure security
  - Az-500 [learning path](/learn/certifications/exams/az-500?tab=tab-learning-paths) (and certification)
  - [Azure Security Benchmark (ASB)](/security/benchmark/azure/) -prescriptive best practices and controls for Azure security
    - [Security baselines for Azure](/security/benchmark/azure/security-baselines-overview): Application of ASB to individual Azure services
  - [Microsoft security best practices](/security/compass/microsoft-security-compass-introduction) - videos and documentation
- Azure compliance
  - [Regulatory compliance](/azure/security-center/security-center-compliance-dashboard) evaluation with Azure Security Center
- Identity protocols and security
  - [Azure security documentation site](/azure/security/)
  - Azure AD authentication [YouTube series](https://www.youtube.com/playlist?list=PLLasX02E8BPD5vC2XHS_oHaMVmaeHHPLy)
  - [Securing Azure environments with Azure Active Directory](https://azure.microsoft.com/resources/securing-azure-environments-with-azure-active-directory/)

Also see the Azure Security Benchmark [gs-3: align organization roles, responsibilities, and accountabilities](/security/benchmark/azure/security-controls-v2-governance-strategy#gs-3-align-organization-roles-responsibilities-and-accountabilities)

## 3. Process: Assign accountability for cloud security decisions

*If nobody is accountable for making security decisions, they won't get made.*

**What**: designate who is responsible for making each type of security decision for the enterprise Azure environment.

**Why**: clear ownership of security decisions speeds up cloud adoption **and** increases security. Lack of typically creates friction because nobody feels empowered to make decisions, nobody knows who to ask for a decision, and nobody is incentivized to research a well-informed decision. This friction frequently impedes business goals, developer timelines, IT goals, and security assurances, resulting in:

- Stalled projects that are waiting for security approval
- Insecure deployments that couldn't wait for security approval

**Who**: security leadership designates which teams or individuals are accountable for making security decisions about the cloud.

**How**: designate groups (or individuals) that will be responsible for making key security decisions.

Document these owners, their contact information, and socialize this widely within the security, IT, and cloud teams to ensure it's easy for all roles to contact them.

These are the typical areas where security decisions are needed, descriptions, and which teams typically make the decisions.

| Decision         | Description           | Typical team  |
| ------------- |-------------| -----|
| Network security | Configuration and maintenance of Azure Firewall, network virtual appliances (and associated routing), WAFs, NSGs, ASGs, and so on. | *Typically [Infrastructure and endpoint security](../organize/cloud-security-infrastructure-endpoint.md) team focused on network security*  |
| Network management | Enterprise-wide virtual network and subnet allocation | *Typically existing network operations team in [Central IT Operations](../organize/central-it.md)* |
| Server endpoint security | Monitor and remediate server security (patching, configuration, endpoint security, and so on.) | *Typically [Central IT Operations](../organize/central-it.md) and [Infrastructure and endpoint security](../organize/cloud-security-infrastructure-endpoint.md) teams jointly* |
| Incident monitoring and response | Investigate and remediate security incidents in SIEM or source console (Azure Security Center, Azure AD identity protection, and so on.) | *Typically [security operations](../organize/cloud-security-operations-center.md) team* |
| Policy management | Set direction for use of Azure role-based access control (Azure RBAC), Azure Security Center, administrator protection strategy, and Azure Policy to govern Azure resources | *Typically [Policy and Standards](../organize/cloud-security-policy-standards.md) + [Security Architecture](../organize/cloud-security-architecture.md) Teams jointly* |
| Identity security and standards | Set direction for Azure AD directories, PIM/pam usage, multifactor authentication, password/synchronization configuration, application identity standards | *Typically [Identity and Key Management](../organize/cloud-security-identity-keys.md) + [Policy and Standards](../organize/cloud-security-policy-standards.md) + [Security Architecture](../organize/cloud-security-architecture.md) Teams jointly*  |

> [!NOTE]
>
> - Ensure decision makers have the appropriate education in their area of the cloud to accompany this responsibility.
> - Ensure decisions are documented in policy and standards to provide a record and guide the organization over the long term.

Also see the Azure Security Benchmark [gs-3: align organization roles, responsibilities, and accountabilities](/security/benchmark/azure/security-controls-v2-governance-strategy#gs-3-align-organization-roles-responsibilities-and-accountabilities)

## 4. Process: Update incident response processes for cloud

*You don't have time to plan for a crisis during a crisis.*

**What**: update processes and prepare analysts to for responding to security incidents on your Azure cloud platform (including any [native threat detection tools](../get-started/security.md#step-1-establish-essential-security-practices) you have adopted). Update processes, prepare your team, and practice with simulated attacks so they can perform at their best during incident investigation, remediation, and threat hunting.

**Why**: active attackers present an immediate risk to the organization that can quickly become a difficult to control situation, so you must rapidly effectively respond to attacks. This incident response (IR) process must be effective for your entire estate including all cloud platforms hosting enterprise data, systems, and accounts.

While similar in many ways, cloud platforms have important technical difference from on-premises systems that can break existing processes, typically because information is available in a different form. Security analysts may also have challenges rapidly responding to an unfamiliar environment that can slow them down (especially if they are trained only on classic on-premises architectures and network/disk forensics approaches).

**Who**: modernizing the IR processes is typically led by [security operations](../organize/cloud-security-operations-center.md) with support from other groups for knowledge and expertise.

- **Sponsorship:** This process modernization is typically sponsored by the security operations director or equivalent.
- **Execution:** Adapting existing processes (or writing them for the first time) is a collaborative effort involving:

  - [Security operations](../organize/cloud-security-operations-center.md) incident management team or leadership -leads updates to process and integration of key external stakeholders including legal and communications/public relations teams
  - [Security operations](../organize/cloud-security-operations-center.md) security analysts - provide expertise on technical incident investigation and triage
  - [Central IT operations](../organize/central-it.md) - provides expertise on cloud platform (directly, via cloud center of excellence, or via external consultants)

**How**: update processes and prepare your team so they know what to do when they find an active attacker.

- **Processes and playbooks:** Adapt existing investigations, remediation, and threat hunting processes to the differences of how cloud platforms work (new/different tools, data sources, identity protocols, and so on.).

- **Education:** Educate analysts on the overall cloud transformation, technical details of how the platform works, and new/updated processes so that they know what will be different and where to go for what they need.

**Key Focus Areas**: while there are many details described in the resource links, these are key areas to focus your education and planning efforts:

- **Shared responsibility model and cloud architectures:** To a security analyst, Azure is a software defined datacenter that provides many services including VMs (familiar) and others that are very different from on-premises such as Azure SQL Database Azure Functions, and so on. Where the best data is in the service logs or the specialized threat detection services rather than in logs for the underlying OS/VMs (which are operated by Microsoft and service multiple customers). Analysts need to understand and integrate this context into their daily workflows so they know what data to expect, where to get it, and what format it will be in.
- **Endpoint data sources:** Getting insights and data for attacks and malware on cloud hosted servers is often faster, easier, and more accurate with native cloud detection tools like Azure Security Center and endpoint detection and response (EDR) solutions as opposed to traditional approaches of direct disk access. While direct disk forensics are available for scenarios where it's possible and required for legal proceedings ([computer forensics in Azure](/azure/architecture/example-scenario/forensics/)), this is often the most inefficient way to detect and investigate attacks.
- **Network and identity data sources:** Many functions of cloud platforms primarily use identity primarily for access control such as access to the Azure portal (though network access controls are used extensively as well). This requires analysts to develop an understanding of cloud identity protocols to get a full, rich, picture of attacker activity (and legitimate user activity) to support incident investigation and remediation. Identity directories and protocols are also different from on-premises as they are typically based on SAML, OAuth, and OpenID Connect and cloud directories rather than LDAP, Kerberos, NTLM, and Active Directory that are commonly found on-premises.
- **Practice exercises:** Simulated attacks and response can help build organizational muscle memory and technical readiness for your security analysts, threat hunters, incident managers, and other stakeholders in your organization. Learning on the job and adapting is a natural part of incident response, but you should work to minimize how much you have to learn in a crisis.

**Key Resources:**

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

**What**: ensure that you are actively managing the security posture of your Azure environment by:

- Assigning clear ownership of responsibilities for
  - Monitoring security posture
  - Mitigating risks to assets
- Automating and simplifying these tasks

**Why**: rapidly identifying and remediating common security hygiene risks significantly reduces organizational risk.

The software-defined nature of cloud datacenters enables continuous monitoring of security risks (such as software vulnerabilities or security misconfigurations) with extensive asset instrumentation. The speed at which developers and IT team can deploy VMs, databases, and other resources also create a need to ensure resources are configured securely and actively monitored.

These new capabilities offer new possibilities, but realizing value from them requires assigning responsibility for using them. Executing consistently on with rapidly evolving cloud operations also requires keeping human processes as simple and automated as possible. See the "drive simplicity" [security principle](/azure/architecture/framework/security/security-principles).

> [!NOTE]
 > The goal of simplification and automation isn't about getting rid of jobs, but about removing the burden of repetitive tasks from people so they can focus on higher value human activities like engaging with and educating IT and DevOps teams.

**Who**: this is typically divided into two sets of responsibilities:

- [Security posture management](../organize/cloud-security-posture-management.md) - this newer function is often an evolution of existing vulnerability management or governance functions. This includes monitoring overall security posture using Azure Security Center secure score and other data sources, actively working with resource owners to mitigate risks, and reporting risk to security leadership.
- **Security remediation:** Assign accountability for addressing these risks to the teams responsible for managing those resources. This should either the DevOps teams managing their own application resources or the technology-specific teams in **[Central IT Operations](../organize/central-it.md)**:

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

**How**: security is everyone's job, but not everyone currently knows how important it is, what to do, and how to do it.

- Hold resource owners accountable for the security risk just as they are held accountable for availability, performance, cost, and other success factors.
- Support resource owners with a clear understanding of why security risk matters to their assets, what they should do to mitigate risk, and how to implement it with minimal productivity loss.

> [!IMPORTANT]
> The explanations for why, what, and how to secure resources are often similar across different resource types and applications, but it's critical to relate these to what each team already knows and cares about. Security teams should engage with their IT and DevOps counterparts as a trusted advisor and partner focused on enabling these teams to be successful.

**Tooling**: [secure score](/azure/security-center/secure-score-security-controls) in Azure Security Center provides an assessment of the most important security information in Azure for a wide variety of assets. This should be your starting point on posture management and can be supplemented with custom Azure policies and other mechanisms as needed.

**Frequency**: set up a regular cadence (typically monthly) to review Azure secure score and plan initiatives with specific improvement goals. The frequency can be increased as needed.

> [!TIP]
 > Gamify the activity if possible to increase engagement, such as creating fun competitions and prizes for the DevOps teams that improve their score the most.

Also see the Azure Security Benchmark [gs-2: define security posture management strategy](/security/benchmark/azure/security-controls-v2-governance-strategy#gs-2-define-security-posture-management-strategy).

## 6. Technology: Require passwordless or multifactor authentication

*Are you willing to bet the security of your enterprise that professional attackers can't guess or steal your administrator's password?*

**What**: require all critical impact admins to use passwordless or multifactor authentication.

**Why**: just as antique skeleton keys won't protect a house against a modern day burglar, passwords cannot protect accounts against common attacks we see today. Technical details are described in [Your pa$$word doesn't matter](https://techcommunity.microsoft.com/t5/azure-active-directory-identity/your-pa-word-doesn-t-matter/ba-p/731984).

While multifactor authentication was once a burdensome extra step, passwordless approaches today improve the logon experience using biometric approaches like facial recognition in Windows Hello and mobile devices (where you don't have to remember or type a password). Additionally, zero trust approaches remember trusted devices, which reduce prompting for annoying out of band multifactor authentication actions (see [User sign-in frequency](/azure/active-directory/conditional-access/howto-conditional-access-session-lifetime#user-sign-in-frequency)).

**Who**: password and multifactor initiative is typically led by [identity and key management](../organize/cloud-security-identity-keys.md) or [security architecture](../organize/cloud-security-architecture.md).

- **Sponsorship:** This is typically sponsored by CISO, CIO, or director of identity
- **Execution:** This is a collaborative effort involving
  - [Policy and standards](../organize/cloud-security-policy-standards.md) team establish clear requirements
  - [Identity and key management](../organize/cloud-security-identity-keys.md) or [central IT operations](../organize/central-it.md) to implement the policy
  - [Security compliance management](../organize/cloud-security-compliance-management.md) monitors to ensure compliance

**How**: implement passwordless or multifactor authentication, train administrators on how to use it (as needed), and require admins to follow using written policy. This can be accomplished by one or more of these technologies:

- [Passwordless (Windows Hello)](/windows/security/identity-protection/hello-for-business/hello-identity-verification)
- [Passwordless (authenticator app)](/azure/active-directory/authentication/howto-authentication-passwordless-phone)
- [Azure multifactor authentication](/azure/active-directory/authentication/howto-mfa-userstates)
- Third-party multifactor authentication solution

> [!NOTE]
> Text message-based multifactor authentication is now relatively inexpensive for attackers to bypass, so focus on passwordless and stronger multifactor authentication.

Also see the Azure Security Benchmark [ID-4: use strong authentication controls for all Azure Active Directory-based access](/security/benchmark/azure/security-controls-v2-identity-management#id-4-use-strong-authentication-controls-for-all-azure-active-directory-based-access).

## 7. Technology: Integrate native firewall and network security

*Simplify protection of systems and data against network attacks.*

**What**: simplify your network security strategy and maintenance by integrating Azure Firewall, Azure web app firewall (WAF), and distributed denial of service (DDoS) mitigations into your network security approach.

**Why**: simplicity is critical to security as it reduces likelihood of risk from confusion, misconfigurations, and other human errors. See the "drive simplicity" [security principle](/azure/architecture/framework/security/security-principles).

Firewalls and WAFs are important basic security controls to protect applications from malicious traffic, but their setup and maintenance can be complex and consume a significant amount of the security team's time and attention (similar to adding custom aftermarket parts to a car). Azure's native capabilities can simplify implementation and operation of firewalls, web application firewalls, distributed denial of service (DDoS) mitigations, and more.

This can free up your team's time and attention for higher value security tasks like evaluating the security of Azure services, automating security operations, and integrating security with applications and IT solutions.

**Who**:

- **Sponsorship:** This update of network security strategy is typically sponsored by security leadership or IT leadership
- **Execution:** Integrating these into your cloud network security strategy is a collaborative effort involving:

  - [Security architecture](../organize/cloud-security-architecture.md) - establish cloud network security architecture with cloud network and cloud network security leads.
  - **Cloud network leads** ([central IT operations](../organize/central-it.md)) + **Cloud Network security leads** ([infrastructure security team](../organize/cloud-security-infrastructure-endpoint.md))
    - Establish cloud network security architecture with security architects
    - Configure firewall, NSG, and WAF capabilities and work with application architects on WAF rules
  - **Application architects:** Work with network security to build and refine WAF rule sets and DDoS configurations to protect the application without disrupting availability

**How**: organizations looking to simplify their operations have two options:

- **Extend existing capabilities and architectures:** Many organizations often choose to extend the use of existing firewall capabilities so they can capitalize on existing investments into skills and process integration, particularly as they first adopt the cloud.
- **Embrace native security controls:** More and more organizations are starting to prefer using native controls to avoid the complexity of integrating third-party capabilities. These organizations are typically seeking to avoid the risk of a misconfiguration in load balancing, user-defined routes, the firewall/WAF itself, and delays in handoffs between different technical teams. This option is particularly compelling to organizations embracing infrastructure as code approaches as they can automate and instrument the built-in capabilities more easily than third-party capabilities.

Documentation on Azure native network security capabilities can be found at:

- [Azure Firewall](/azure/firewall/overview)
- [Azure Web Application Firewall (WAF)](/azure/web-application-firewall/)
- [Azure DDoS protection](/azure/ddos-protection/ddos-protection-overview)

[Azure Marketplace](https://azuremarketplace.microsoft.com/marketplace/apps?page=1&search=firewall) includes many third-party firewall providers.

Also see the Azure Security Benchmark [ns-4: protect applications and services from external network attacks](/security/benchmark/azure/security-controls-v2-network-security#ns-4-protect-applications-and-services-from-external-network-attacks).

## 8. Technology: Integrate native threat detection

*Simplify detection and response of attacks against Azure systems and data.*

**What**: simplify your threat detection and response strategy by incorporating native threat detection capabilities into your security operations and SIEM.

**Why**: the purpose of security operations is to reduce the impact of active attackers who get access to the environment, as measured by mean time to acknowledge (MTTA) and remediate (MTTR) incidents. This requires both accuracy and speed in all elements of incident response, so the quality of tools and the efficiency of process execution are paramount.

It's difficult to get high threat detections using existing tools and approaches designed for on-premises threat detection because of differences in cloud technology and its rapid pace of change. Natively integrated detections provide industrial scale solutions maintained by the cloud providers that can keep up with current threats and cloud platform changes.

These native solutions also enable security operations teams to focus on incident investigation and remediation instead of wasting time trying to create alerts from unfamiliar log data, integrating tools, and maintenance tasks.

**Who**: this is typically driven by the [security operations](../organize/cloud-security-operations-center.md) team.

- **Sponsorship:** This is typically sponsored by the security operations director or equivalent role.
- **Execution:** Integrating native threat detection is a collaborative effort involving those with:
  - [Security operations](../organize/cloud-security-operations-center.md): Integrate alerts into SIEM and incident investigation processes, educate analysts on cloud alerts and what they mean, and how to use the native cloud tools.
  - [Incident preparation](../organize/cloud-security-incident-preparation.md): Integrate cloud incidents into practice exercises and ensure practice exercises are conducted to drive team readiness.
  - [Threat intelligence](../organize/cloud-security-threat-intelligence.md): Research and integrate information on cloud attacks to inform teams with context and intelligence.
  - [Security architecture](../organize/cloud-security-architecture.md): Integrate native tooling into security architecture documentation.
  - [Policy and standards](../organize/cloud-security-policy-standards.md): Set standards and policy for enabling native tooling throughout the organization. Monitor for compliance.
  - [Infrastructure and endpoint](../organize/cloud-security-infrastructure-endpoint.md) / **[Central IT Operations](../organize/central-it.md):** Configure and enable detections, integrate into automation and infrastructure as code solutions.

**How**: enable [threat detection in Azure Security Center](/azure/security-center/azure-defender) for all the resources you are using and have each team integrate these into their processes as described above.

Also see the Azure Security Benchmark [LT-1: enable threat detection for Azure resources](/security/benchmark/azure/security-controls-v2-logging-threat-detection#lt-1-enable-threat-detection-for-azure-resources).

## 9. Architecture: Standardize on a single directory and identity

*Nobody wants to deal with multiple identities and directories.*

**What**: standardize on a single Azure AD directory and single identity for each application and user in Azure (for all enterprise identity functions).

> [!NOTE]
> This best practice refers specifically to enterprise resources. For partner accounts, use [Azure AD B2B](/azure/active-directory/external-identities/what-is-b2b) so you don't have to create and maintain accounts in your directory. For customer/citizen accounts, use [Azure AD B2C](/azure/active-directory-b2c/) to manage them.

**Why**: multiple accounts and identity directories create unnecessary friction and confusion in daily workflows for productivity users, developers, IT and identity admins, security analysts, and other roles.

Managing multiple accounts and directories also creates an incentive for poor security practices such as reusing the same password across accounts and increases the likelihood of stale/abandoned accounts that attackers can target.

While it sometimes seems easier to quickly stand up a custom LDAP directory for a particular application or workload, this creates much more work to integrate and manage. This is similar to choosing to set up an additional Azure tenant or on-premises Active Directory forest rather than using the existing enterprise tenant. See also the [security principle of driving simplicity](/azure/architecture/framework/security/security-principles).

**Who**: this is often a cross-team effort, driven by [security architecture](../organize/cloud-security-architecture.md) or [identity and key management](../organize/cloud-security-identity-keys.md) teams.

- **Sponsorship:** This is typically sponsored by [identity and key management](../organize/cloud-security-identity-keys.md) and [security architecture](../organize/cloud-security-architecture.md) (though some organizations may require sponsorship by CISO or CIO)
- **Execution:** This is a collaborative effort involving:
  - [Security architecture](../organize/cloud-security-architecture.md): Incorporates into security and IT architecture documents and diagrams
  - [Policy and standards](../organize/cloud-security-policy-standards.md): Document policy and monitor for compliance
  - [Identity and key management](../organize/cloud-security-identity-keys.md) or **[Central IT Operations](../organize/central-it.md)** to implement the policy by enabling features and supporting developers with accounts, education, and so on.
  - **Application developers** or **[Central IT Operations](../organize/central-it.md):** Use identity in applications and Azure service configurations (responsibilities will vary based on level of DevOps adoption)

**How**: adopt a pragmatic approach that starts with new *greenfield* capabilities (growing today) and then clean up challenges with the *brownfield* of existing applications and services as a follow-up exercise:

- **Greenfield:** Establish and implement a clear policy that all enterprise identity going forward should use a single Azure AD directory with a single account for each user.

- **Brownfield:** Many organizations often have multiple legacy directories and identity systems. Address these when the cost of ongoing management friction exceeds the investment to clean it up. While identity management and synchronization solutions can mitigate some of these issues, they lack deep integration of security and productivity features that enable a seamless experience for users, admins, and developers.

The ideal time to consolidate your use of identity is during application development cycles as you:

- Modernize applications for the cloud.
- Update cloud applications with DevOps processes.

While there are valid reasons for a separate directory in the case of extremely independent business units or regulatory requirements, multiple directories should be avoided in all other circumstances.

Also see the Azure Security Benchmark [ID-1: standardize Azure Active Directory as the central identity and authentication system](/security/benchmark/azure/security-controls-v2-identity-management#id-1-standardize-azure-active-directory-as-the-central-identity-and-authentication-system).

> [!IMPORTANT]
> The only exception to the single accounts rule is that privileged users (including IT administrators and security analysts) should have separate accounts for standard user tasks vs. administrative tasks.
>
> For more information, see Azure Security Benchmark [privileged access](/security/benchmark/azure/security-controls-v2-privileged-access).

## 10. Architecture: use identity-based access control (instead of keys)

**What**: use Azure AD identities instead of key-based authentication wherever possible (Azure services, applications, APIs, and so on.).

**Why**: key-based authentication can be used to authenticate to cloud services and APIs but requires managing keys securely, which is challenging to perform well (especially at scale). Secure key management is difficult for non-security professionals like developers and infrastructure professionals and they often fail to do it securely, often creating major security risks for the organization.

Identity-based authentication overcomes many of these challenges with mature capabilities for secret rotation, lifecycle management, administrative delegation, and more.

**Who**: this is often a cross-team effort, driven by [security architecture](../organize/cloud-security-architecture.md) or [identity and key management](../organize/cloud-security-identity-keys.md) teams.

- **Sponsorship:** This is typically sponsored by [security architecture](../organize/cloud-security-architecture.md) or [identity and key management](../organize/cloud-security-identity-keys.md)  (though some organizations may require sponsorship by CISO or CIO).
- **Execution:** This is a collaborative effort involving
  - [Security architecture](../organize/cloud-security-architecture.md): Incorporates into security and IT architecture diagrams and documents.
  - [Policy and standards](../organize/cloud-security-policy-standards.md): Document policy and monitor for compliance.
  - [Identity and key management](../organize/cloud-security-identity-keys.md) or **[Central IT Operations](../organize/central-it.md)** to implement the policy by enabling features and supporting developers with accounts, education, and so on.
  - **App developers** or **[Central IT Operations](../organize/central-it.md):** Use identity in applications and Azure service configurations (responsibilities will vary based on level of DevOps adoption).

**How**: setting an organizational preference and habit for using identity-based authentication requires following a process and enabling technology.

**The process:**

1. **Establish policy** and standards that clearly outline the default identity-based authentication, as well as acceptable exceptions.
2. **Educate** developers and infrastructure teams on why to use the new approach, what they need to do, and how to do it.
3. **Implement** changes in a pragmatic way - starting with new greenfield capabilities being adopted now and in the future (new Azure services, new applications) and then following up with a clean-up of existing brownfield configurations.
4. **Monitor** for compliance and follow up with developer and infrastructure teams to remediate.

**The technologies:** For non-human accounts such as services or automation, use [managed identities](/azure/active-directory/managed-identities-azure-resources/overview). Azure managed identities can authenticate to Azure services and resources that support Azure AD authentication. Authentication is enabled through predefined access grant rules, avoiding hard-coded credentials in source code or configuration files.

For services that do not support managed identities, use Azure AD to create a [service principal](/azure/active-directory/develop/app-objects-and-service-principals) with restricted permissions at the resource level instead. We recommended configuring service principals with certificate credentials and fall back to client secrets. In both cases, [Azure Key Vault](/azure/key-vault/general/overview) can be used in conjunction with Azure managed identities, so that the runtime environment (such as an Azure function) can retrieve the credential from the key vault.

Also see the Azure Security Benchmark [ID-2: manage application identities securely and automatically](/security/benchmark/azure/security-controls-v2-identity-management#id-2-manage-application-identities-securely-and-automatically).

## 11. Architecture: establish a single unified security strategy

*Everyone needs to row in the same direction for the boat to go forward.*

**What**: ensure all teams are aligned to a single strategy that both enables and secures enterprise systems and data.

**Why**: when teams work in isolation without being aligned to a common strategy, their individual actions can inadvertently undermine each other's efforts, creating unnecessary friction that slows down progress against everyone's goals.

One example of this that has played out consistently in many organizations is the segmentation of assets:

- The *network security team* develops a strategy for segmenting a *flat network* to increase security (often based on physical sites, assigned IP address addresses/ranges, or similar)
- Separately, the *identity team* developed a strategy for groups and Active Directory organizational units (OUs) based on their understanding and knowledge of the organization.
- Often, *application teams* find it difficult to work with these systems because they were designed with limited input and understanding of business operations, goals, and risks.

In organizations where this happens, teams frequently experience conflicts over firewall exceptions, which negatively impact both security (exceptions are usually approved) and productivity (deployment is slowed for application functionality the business needs).

While security can create healthy friction by forcing critical thinking, this conflict only creates unhealthy friction that impedes goals. For more information, see [Security strategy guidance: the right level of security friction](../strategy/define-security-strategy.md#modernize-your-security-strategy).

**Who:**

- **Sponsorship:** The unified strategy typically co-sponsored by CIO, CISO, and CTO (often with business leadership support for some high-level elements) and championed by representatives from each team.
- **Execution:** Security strategy must be implemented by everyone, so it should integrate input from across teams to increase ownership, buy-in, and likelihood of success.
  - [Security architecture](../organize/cloud-security-architecture.md): Leads the effort to build security strategy and resulting architecture, actively gather feedback from teams, and document it in presentations, documents, and diagrams for the various audiences.
  - [Policy and standards](../organize/cloud-security-policy-standards.md): Captures the appropriate elements into standards and policy and then monitors for compliance.
  - **All technical IT and security teams:** Provide input requirements, then align to and implement the enterprise strategy.
  - **Application owners and developers:** Read and understand strategy documentation that applies to them (ideally, guidance tailored to their role).

**How**:

Build and implement a security strategy for cloud that includes the input and active participation of all teams. While the process documentation format will vary, this should always include:

- **Active input from teams:** Strategies typically fail if people in the organization don't buy into them. Ideally, get all teams in the same room to collaboratively build the strategy. In the workshops we conduct with customers, we often find organizations have been operating in de facto silos and these meetings often result in people meeting each other for the first time. We also find that inclusiveness is a requirement. If some teams are not invited, this meeting typically has to be repeated until all participants join it (or the project doesn't move forward).
- **Documented and communicated clearly:** All teams should have awareness of the security strategy (ideally a security component of the overall technology strategy) including why to integrate security, what is important in security, and what security success looks like. This should include specific guidance for application and development teams so they can get a clear prioritized guidance without having to read through non-relevant parts of the guidance.
- **Stable, but flexible:** Strategies should remain relatively consistent and stable, but the architectures and the documentation may need changes to add clarity and accommodate the dynamic nature of cloud. For example, filtering out malicious external traffic would stay consistent as a strategic imperative even if you shift from the use of a third-party next generation firewall to Azure Firewall and adjust diagrams/guidance on how to do it.
- **Start with segmentation:** Over the course of cloud adoption, your teams will address many strategy topics large and small, but you need to start somewhere. We recommend starting the security strategy with enterprise asset segmentation as it's a foundational decision that would be challenging to change later and requires both business input and many technical teams.

Microsoft has published video guidance for [applying a segmentation strategy to Azure](/security/compass/microsoft-security-compass-introduction#azure-components-and-reference-model-2151) as well as documents on [enterprise segmentation](/security/compass/governance#enterprise-segmentation-strategy) and [aligning network security to it](/security/compass/network-security-containment#align-network-segmentation-with-enterprise-segmentation-strategy).

The Cloud Adoption Framework includes guidance to help your teams with:

- [Building a cloud strategy team](../get-started/team/cloud-strategy.md): Ideally, security should be integrated into an existing cloud strategy.
- [Build or modernize a security strategy](../strategy/define-security-strategy.md): To meet business and security goals in the current age of cloud services and modern threats.

Also see the [Azure Security Benchmark governance and strategy](/security/benchmark/azure/security-controls-v2-governance-strategy).
