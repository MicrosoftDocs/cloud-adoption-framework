---
title: Security teams, roles, and functions
description: Learn how to build a security team and their roles.
author: claytonsiemens77
ms.author: csiemens
ms.date: 06/24/2024
ms.topic: conceptual
ms.custom: internal, UpdateFrequency2
---
# Security teams, roles, and functions

This article describes security roles involved in cloud security and the functions they perform related to cloud infrastructure and platforms. These roles ensure that security is part of every stage of the cloud lifecycle from development to operations and continuous improvement.

>[!NOTE]
>The Cloud Adoption Framework (CAF) focuses on cloud infrastructure and platforms that support multiple workloads. For security guidance on for individual workloads, see the [security guidance](/azure/well-architected/security) in the Azure Well-Architected Framework.  

Depending on your organization’s size and other factors, the roles and functions discussed in this article may be fulfilled by people performing multiple functions (roles) rather than having a single person or a team dedicated to the function. Enterprise and large organizations tend to have larger teams with more specialized roles, whereas smaller organizations tend to consolidate multiple roles and functions into a smaller number of people. The specific security responsibilities will also vary by the technical platforms and services in use by the organization.

Some security tasks will be performed directly by technology and cloud teams while others may be performed by specialized security teams operating collaboratively with them. Regardless of the size and structure your organization, it's imperative that stakeholders have a clear understanding of the security "jobs to be done." Everyone must also have awareness of the business requirements and the security risk tolerance of the organization to make good decisions about cloud services that consider and balance security as a key requirement.  

Use the guidance in this article to help understand specific functions that teams and roles perform and how different teams interact to cover the entirety of a cloud security organization. 

## Transformation of security roles

Security Architecture, Engineering, and Operations roles are undergoing a significant transformation of their responsibilities and processes (similar to the cloud-driven transformation of infrastructure and platform roles). This security role transformation has been driven by multiple factors: 

- As security tools are increasingly becoming SaaS based, there's less need to design, implement, test, and operate security tool infrastructures. These roles do still need to support the full lifecycle of configuring cloud services and solutions (including continuous improvement) to ensure they meet security requirements.

- The recognition that "security is everyone’s job" is driving a more collaborative and mature approach for security and technology teams to work together: 

    - Technical engineering teams are accountable to ensure security measures are applied effectively to their workloads. This increases their need for context and expertise from security teams on how to meet these obligations effectively and efficiently.

    - Security teams are shifting from a (slightly adversarial) quality control role to an enablement role for technical teams- making the secure path into the easiest path. Security teams are reducing friction and barriers using automation, documentation, training, and other means.

- Security teams are increasingly broadening their skills to look at security problems across multiple technologies and systems to address the full attacker lifecycle rather than focusing on specific narrow technical areas (network security, endpoint security, application security, cloud security for example). This skill development need is further amplified by how cloud platforms integrate different technologies closely together.

- The increased rate of change from both technology and security cloud services requires security processes to be continuously updated to keep up and manage risk effectively.

- Security threats now reliably bypass network-based security controls, requiring security teams to adopt a Zero Trust approach that includes identity, application, endpoint, cloud, CI/CD, user education, and other controls.

- The adoption of DevOps/DevSecOps processes requires security roles to be more agile to integrate security natively into this accelerated solution development lifecycle.

## Overview of roles and teams

The following sections provide guidance on which teams and roles typically perform key cloud security functions (when these functions are present in the organization). You should map out your existing approach, look for any gaps, and assess whether your organization can and should invest to address those gaps.

The roles who perform security tasks include:

- **Cloud service provider**

- **Infrastructure/Platform Teams (architecture, engineering, and operations)**
- **Security architecture, engineering, posture management teams**
- 
    - **Security Architects and Engineers (Data security, Identity and access management (IAM), Network security, Servers and Container security, Application security and DevSecOps)**
 
    - **Software Security Engineers (Application Security)**

    - **Posture Management (vulnerability management / attack surface management)**

- **Security operations (SecOps/SOC):**
- 
    - **Triage Analysts (Tier 1)**

    - **Investigation Analysts (Tier 2)**

    - **Threat hunting**

    - **Threat intelligence**

    - **Detection Engineering**

- **Security Governance, Risk, and Compliance (GRC)**

- **Security Training and Awareness**

It’s critical to ensure that everyone understands their role in security and how to work with other teams by documenting cross-team security processes and a shared responsibility model for your technical teams. This avoids risk and waste from coverage gaps and from overlapping efforts and also helps avoid common mistakes (antipatterns) like teams selecting weak authentication and cryptography solutions (or even attempting to create their own).

>[!NOTE]
>A shared responsibility is similar to a responsible / accountable / consulted / informed (RACI) model. The shared responsibility model helps illustrate a collaborative approach on who makes decisions and what teams must to work together for particular topics and outcomes.

### Cloud service provider

Cloud service providers are effectively "virtual team members" that provide security functions and capabilities for the underlying cloud platform. Some cloud providers also provide security features and capabilities for your teams to use to manage your security posture and incidents. For more information on what cloud services providers do, see the [cloud shared responsibility model](/azure/security/fundamentals/shared-responsibility).  

Many cloud service providers provide information on their security practices and controls upon request or via a portal like the [Microsoft service trust portal](https://servicetrust.microsoft.com/).

### Infrastructure/Platform Teams (architecture, engineering, and operations)

Infrastructure/Platform architecture, engineering, and operations teams implement and integrate cloud security, privacy, and compliance controls across the cloud infrastructure and platform environments (across servers, containers, networking, identity, and other technical elements).  

The engineering and operations roles may be focused primarily on cloud or continuous integration/deployment (CI/CD) systems, or they may work across a full range of cloud, CI/CD, on premises, and other infrastructure and platforms.  

These teams are responsible for meeting all the availability, scalability, security, privacy, and other requirements for the organization’s cloud services hosting business workloads. These teams work collaboratively with security, risk, compliance, and privacy experts to drive outcomes that blend and balance all these requirements.  
  
### Security architecture, engineering, posture management teams

Security teams work with infrastructure and platform roles (and others) to help translate security strategy, policy, and standards into actionable architectures, solutions, and design patterns. These teams focus on enabling the security success of the cloud teams by evaluating and influencing the security of the infrastructure as well as the processes and tools used to manage it. These are some of the common tasks performed by security teams for the infrastructure:

- **Security Architects and Engineers** adapt security policies, standards, and guidelines for cloud environments to design and implement controls in partnership with their infrastructure/platform counterparts. Security Architects and Engineers assist with a broad range of topics including:

    - *Tenants/Subscriptions* - **Security Architects and Engineers** collaborate with **Infrastructure Architects and Engineers** and **Access Architects** (Identity, Networking, App, and others) to help establish security configurations for cloud tenants, subscriptions, and accounts across cloud providers (which are monitored by **Security Posture Management** teams).

    - *Identity and access management (IAM)* - **Access Architects** (Identity, Networking, App, and others) collaborate with **Identity Engineers and Operations**, and infrastructure/platform teams to design, implement, and operate the access management solutions. These solutions protect against unauthorized usage of the organization’s business assets while enabling authorized users to follow business processes to easily and securely access organizational resources. These teams work on solutions include identity directories and single sign-on (SSO) solutions, passwordless and multifactor authentication (MFA), risk based conditional access solutions, workload identities, privileged identity/access management (PIM/PAM) cloud infrastructure and entitlement management (CIEM), and more.  These teams also collaborate with network engineers and operations to design, implement, and operate security service edge (SSE) solutions. These capabilities can be leveraged by workload teams to provide seamless and secure access to individual workload and application components.  

    - *Data security* -  **Security Architects and Engineers** collaborate with **Data and Artificial Intelligence (AI) Architects and Engineers** to help infrastructure/platform teams establish foundational data security capabilities for all data and advanced capabilities that can be leveraged to classify and protect data in individual workloads. For more information on foundational data security, refer to the Microsoft security [Data protection benchmark](/security/benchmark/azure/mcsb-data-protection). For more information on protecting data in individual workloads, refer to the Well-Architected Framework [guidance](/azure/well-architected/security/data-classification).
    
    - *Network security* - **Security Architects and Engineers** collaborate with **Network Architects and Engineers** to help infrastructure/platform teams establish foundational network security capabilities such as connectivity to cloud (private/leased lines), remote access strategies and solutions, ingress/egress firewalls, [Web Application Firewalls (WAFs)](/azure/web-application-firewall/), [network segmentation](../ready/azure-best-practices/plan-for-landing-zone-network-segmentation.md), and more. These teams also collaborate with identity architects, engineers, and operations to design, implement, and operate security service edge (SSE) solutions. These capabilities can be leveraged by workload teams to provide discrete protection or isolation of individual workload and application components.

    - *Servers and Container security* - **Security Architects and Engineers** collaborate with **Infrastructure Architects and Engineers** to help infrastructure/platform teams establish foundational security capabilities for servers, virtual machines (VMs), containers, orchestration/management, continuous integration/deployment (CI/CD), and related systems. These teams establish discovery and inventory processes, security baseline/benchmark configurations, maintenance and patching process, allowlisting (formerly whitelisting) for executable binaries, template images, management processes, and more. These foundational infrastructure capabilities can also be leveraged by workload teams to secure servers and containers for individual workload and application components.  

    - *Software Security Foundations (for Application Security and DevSecOps)* - **Security Architects and Engineers** collaborate with **Software Security Engineers** to help infrastructure/platform teams establish application security capabilities that can be leveraged by individual workloads such as code scanning, software bill of materials (SBOM) tools, web application firewalls (WAFs), application scanning, and more. See [DevSecOps controls](./devsecops-controls.md) for more information on how to establish a security development lifecycle (SDL).  For more information on how these capabilities are used by workload teams, see the [security development lifecycle](/azure/well-architected/security/secure-development-lifecycle) guidance in the Azure Well-Architected Framework.

-  **Software Security Engineers** – evaluate code, scripts, and other automated logic used to manage the infrastructure including Infrastructure as Code (IaC), continuous integration and deployment (CI/CD) workflows, and any other custom-built tools or applications. These engineers should be engaged to protect formal code in a compiled application, scripts, configurations of automation platforms, and any other form of executable code/script that could allow attackers to manipulate the operation of the system. This may simply be performing a threat model analysis of a system or it may involve code review and security scanning tools. See [DevSecOps controls](./devsecops-controls.md) for more information on how to establish a security development lifecycle (SDL).  

- **Posture Management (vulnerability management / attack surface management)** - is the operational security team focused on security enablement for technical operations teams. Posture management focuses on helping these teams prioritize and successfully implement controls to block or mitigate attack techniques. Posture management teams work across all technical operations teams (including cloud) and often serve as their primary conduit to understand security requirements, compliance requirements, and governance processes.</br></br>Posture management often acts as a center of excellence (CoE) for security infrastructure teams, similar to the way software engineers often act as a security CoE for application development teams. Typical tasks for these teams include:

    - *Monitor security posture* - monitor all technical systems using posture management tools like Microsoft Exposure Management, Microsoft Entra Permission Management (EPM), 3rd party vulnerability and External Attack Surface Management (EASM) and Cloud infrastructure entitlement management (CIEM) tools, and custom security posture tools and dashboards. Additionally, posture management performs additional analysis to build insights by:

        -  *Anticipating highly likely and damaging attack paths* – Attackers "think in graphs" and seek out paths to business-critical systems by chaining together multiple assets and vulnerabilities across different systems (for example, compromise user endpoints, then use the hash/ticket to capture an admin credential, then access the business-critical data). Posture management teams work with security architects and engineers to discover and mitigate these hidden risks that don’t always show up in technical lists and reports.

        - *Conducting security assessments* to review systems configurations and operational processes to gain deeper understanding and insights beyond the technical data from security posture tools. These may take the form of informal discovery conversations or formal threat modeling exercises.

    - *Assist with prioritization* – Posture management teams make these available to technical teams to proactively monitor their assets and help them prioritize security work. Posture management helps put the risk mitigation work into context using  security risk impact (informed by experience, security operations incident reports and other threat intelligence, business intelligence, and other sources) as well as security compliance requirements.

    - *Training, Mentoring, and Champions* – increase the security knowledge and skills of technical engineering team through training, mentoring individuals, and informal knowledge transfer. Posture management roles may also work with **Organizational Readiness / Training** and **Security Education and Engagement** roles on formal security training and setting up security within technical teams who evangelize and educate their peers on security.

    - *Identifying gaps and advocating for fixes* - Identify overall trends, process gaps, tooling gaps, and other insights into risks and mitigations. Posture management roles collaborate and communicate with security architects and engineers to develop solutions, build a case for funding solutions, and assist with rollout of fixes.

    - *Coordinating with security operations (SecOps)* – Posture management teams also often help technical teams work with SecOps roles like detection engineering and threat hunting teams. This continuity across all operational roles helps ensure that detections are in place and implemented correctly, security data is available for incident investigation and threat hunting, processes are in place for collaboration, and more.

    - *Reporting* - Provide timely and accurate reports on security incidents, trends, and performance metrics to senior management and stakeholders to update organizational risk processes.
    
    Posture management teams often evolve from existing software vulnerability management roles that grow to address the full set of functional, configuration, and operational vulnerability types described in The Open Group’s Zero Trust Reference Model. Each type of vulnerability can allow unauthorized users (including attackers) to take control of software or systems, enabling them to cause damage to business assets.

    - *Functional vulnerabilities* occur in software design or implementation that can allow unauthorized control of the affected software. These may be flaws in software your own teams developed or flaws in commercial or open source software (typically tracked by a Common Vulnerabilities and Exposures (CVE) identifier).
    
    - *Configuration vulnerabilities* are misconfigurations of systems that allow unauthorized access to system functionality. These can be introduced during ongoing operations (sometimes called configuration drift), during the initial deployment and configuration of software and systems, and by weak security defaults from the vendor. Some common examples include:

        - Orphaned objects that allow unauthorized access like DNS records and group membership.

        - Excessive administrative roles or permissions to resources.

        - Use of a weaker/older authentication protocol or cryptographic algorithm with known security issues.

        - Weak default configurations or default passwords.

    - *Operational vulnerabilities* are weaknesses in standard operating processes and practices that allow unauthorized access or control of systems. Examples include:

        - Administrators using shared accounts to perform privileged tasks instead of their own individual accounts.

        - Use of ['browse-up configurations'](https://www.ncsc.gov.uk/whitepaper/security-architecture-anti-patterns) that create elevation of privilege paths which can be abused by attackers. This occurs when high privileged administrative accounts log onto lower trust user devices and workstations (like standard user workstations and user-owned devices), sometimes employing  "jump servers" that don’t effectively mitigate these risks. See securing privileged access and privileged access workstations (PAWs) for more information.

### Security operations (SecOps/SOC)

The Security Operations (SecOps) team is sometimes referred to as a Security Operations Center (SOC). The SecOps team focuses on rapidly finding and removing adversary access to the organization’s assets in close partnership with technology operations and engineering teams. SecOps roles may work across all technologies in the organization including traditional IT, Operational Technology (OT), Internet of Things (IoT), and more. The SecOps roles that will most often interact with cloud teams are:

   - **Triage Analysts (Tier 1)** – Responds to incident detections for well-known attack techniques and follows documented procedures to rapidly resolve them (or escalate to investigation analysts as appropriate). Depending on the SecOps scope and maturity level, this may include detections and alerts from email, endpoint antimalware solutions, cloud services, network detections, or other technical systems.

   - **Investigation Analysts (Tier 2)** – Responds to higher complexity and higher severity incident investigations that require more experience and expertise (beyond well documented resolution procedures). This team typically investigates attacks that are conducted by live human adversaries and attacks that affect multiple systems. These teams work in close partnership with technology operations and engineering teams to investigate incidents and resolve them.

   - **Threat hunting** - Proactively search for hidden threats within the technical estate that have evaded standard detection mechanisms, using advanced analytics and hypothesis-driven investigations.

   - **Threat intelligence** – Gather and disseminate information about attackers and threats to all stakeholders including business, technology, and security. Threat intelligence teams perform research, share their findings (formally or informally), and disseminate them to various stakeholders including cloud security team. This security context helps these teams make cloud services more resilient to attacks because they're using real world attack information in the design, implementation, testing, operation, and continuously improvement.

   - **Detection Engineering** – Builds custom attack detections and customizes attack detections provided by vendors and the broader community. These custom attack detections supplement vendor-provided detections for common attacks commonly found in extended detection and response (XDR) tools and some security information and event management (SIEM) tools. Detection Engineers work with cloud security teams to identify opportunities for designing and implementing detections, the data required to support them, and the response/recovery procedures for the detections.

### Security Governance, Risk, and Compliance (GRC)

Security Governance, Risk, and Compliance (GRC) is a set of interrelated disciplines that integrate the technical work of security teams with organizational goals and expectations. These roles and teams may be a hybrid of two or more disciplines or may be discrete roles. Cloud teams will interact with each of these over the course of the cloud technology lifecycle:

- The **Governance** discipline is a foundational capability that focuses on ensuring the organization is consistently executing across all aspects of security. Governance teams focus on decision rights (who makes what decisions) and process frameworks that connect and guide teams. Without effective governance, an organization with all the right controls, policies, and technology may still be breached by attackers who found areas where the intended defenses weren’t executed well, fully, or at all.

- The **Risk management** discipline focuses on ensuring the organization is effectively assessing, understanding, and mitigating risk. Risk management roles work with many teams across the organization to build a clear picture on the organization’s risk and keep it current. Because many critical business services can be hosted on cloud infrastructure and platforms, cloud and risk teams need to collaborate to assess and manage this organizational risk. Additionally, supply chain security focuses on risks associated with third-party vendors, open source components, and partners.

- The **Compliance** discipline ensures that systems and processes are compliant with regulatory requirements and internal policies. Without this, the organization may be exposed to risk related to noncompliance with external obligations (fines, liability, loss of revenue from inability to operate in some markets, and more). Compliance requirements typically can't keep up with the speed of attacker evolution, but are an important requirement source nonetheless.

All three of these disciplines operate across all technologies and systems to drive organizational outcomes across all teams. All three also rely on context they get from each other and benefit significantly from current high-fidelity data on threats, business, and the technology environment. These disciplines also rely on architecture to express an actionable vision that can be executed and security education and policy to establish rules and guide teams through the many daily decisions.

Cloud engineering and operation teams may work with **Posture Management** roles, **Compliance and Audit** teams, **Security Architecture and Engineering**, or **Chief Information Security Officers (CISOs)** roles on GRC topics.

### Security education and policy

Organizations must ensure that all roles have basic security literacy as well as guidance on what they're expected to do in security and how to do it using a combination of written policy and education. The education for cloud teams may be informal mentoring by security professionals working directly with them or it may be a formal program with documented curriculum and designated security champions. 

In a larger organization, security teams work with **Organizational Readiness / Training** and **Security Education and Engagement** roles on formal security training and setting up security champions within technical teams to evangelize and educate their peers on security.

Security education and policy must help each role understand:

- **Why** - Show each role why it's important to them and their goals in the context of their role responsibilities. If people don’t clearly feel **why** security matters to them, they'll judge it to be unimportant and move onto something else.

- **What** – Summarize what security tasks they need to do in language the roles already understand. If people don’t know what they're being asked to do, they'll assume security isn’t important or relevant to them and move onto something else.

- **How** -  Ensure each role has clear explanation/instructions on how to apply it in their life/role/job. If people don’t know how to actually do what they're being asked to do (for example, patch servers identify whether it’s a phishing link, report the message properly, review code, or perform threat model), they'll fail and move onto something else.

## Example scenario: Typical interoperability between teams

When an organization deploys and operationalizes a Web Application Firewall (WAF), several security teams must collaborate to ensure its effective deployment, management, and integration into the existing security infrastructure. Here’s how the interoperability among the teams might look in an enterprise security organization:

1. **Planning and design**
    1. The *Governance team* identifies the need for enhanced web application security and allocates budget for a WAF.
    1. The *Network Security Architect* designs the WAF deployment strategy, ensuring it integrates seamlessly with existing security controls and aligns with the organization's security architecture.
1. **Implementation**
    1. The *Network Security Engineer* deploys the WAF according to the architect’s design, configuring it to protect the specific web applications, and enables monitoring.
    1. The *IAM Engineer* sets up access controls, ensuring only authorized personnel can manage the WAF.
1. **Monitoring and management**
    1. The *Posture management team* provides instructions for the *SOC* to configure monitoring and alerting for the WAF and to set up dashboards to track WAF activity.
    1. The *Threat Intelligence and Detection Engineering teams* help develop response plans for incidents involving the WAF and in conducting simulations to test these plans.
1. **Compliance and risk management**
    1. The *Compliance and Risk Management Officer* reviews the WAF deployment to ensure it meets regulatory requirements and conducts periodic audits.
    1. The *Data Security Engineer* ensures that the WAF's logging and data protection measures comply with data privacy regulations.
1. **Continuous improvement and training**
    1. The *DevSecOps Engineer* integrates WAF management into the continuous integration and continuous deployment (CI/CD) pipeline, ensuring that updates and configurations are automated and consistent.
    1. The *Security Education and Engagement Specialist* develops and delivers training programs to ensure that all relevant personnel understand how to use and manage the WAF effectively.
    1. The *Cloud Governance team member* reviews the WAF deployment and management processes to ensure they align with organizational policies and standards
    
By collaborating effectively, these roles ensure that the WAF is not only deployed correctly but also continuously monitored, managed, and improved to protect the organization's web applications from evolving threats.

## Next step

> [!div class="nextstepaction"]
> [Integrate security in your cloud adoption strategy](./secure-strategy.md)