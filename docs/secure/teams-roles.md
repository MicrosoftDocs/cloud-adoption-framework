---
title: Security Teams, Roles, and Functions
description: Learn how to create a security team and its roles. These roles help you ensure that security is part of every stage of the cloud lifecycle.
author: stephen-sumner
ms.author: pnp
ms.date: 11/05/2025
ms.topic: concept-article
---
# Security teams, roles, and functions

This article describes the security roles required for cloud security and the functions they perform related to cloud infrastructure and platforms. These roles help you ensure that security is part of every stage of the cloud lifecycle, from development to operations and continuous improvement.

:::image type="content" source="./media/caf-secure-teams-roles.png" alt-text="Diagram showing the methodologies involved in cloud adoption. The diagram has boxes for each phase: teams and roles, strategy, plan, ready, adopt, govern, and manage. The box for this article is highlighted." lightbox="./media/caf-secure-teams-roles.png" border="false":::

>[!NOTE]
>The Cloud Adoption Framework for Azure focuses on cloud infrastructure and platforms that support multiple workloads. For security guidance for individual workloads, see the [security guidance](/azure/well-architected/security) in the Azure Well-Architected Framework.  

Depending on your organization's size and other factors, the roles and functions discussed in this article might be fulfilled by people who perform multiple functions (roles) rather than by a single person or team. Enterprises and large organizations tend to have larger teams with more specialized roles, whereas smaller organizations tend to consolidate multiple roles and functions among a smaller number of people. The specific security responsibilities also vary depending on the technical platforms and services that the organization uses.

Some security tasks will be performed directly by technology and cloud teams. Others might be performed by specialized security teams that operate collaboratively with the technology teams. Regardless of the size and structure of your organization, stakeholders must have a clear understanding of the security jobs that need to be done. Everyone must also be aware of the business requirements and the security risk tolerance of the organization so they can make good decisions about cloud services that take into account and balance security as a key requirement.  

Use the guidance in this article to help understand specific functions that teams and roles perform and how different teams interact to cover the entirety of a cloud security organization. 

## Minimum viable security team for small organisations

Smaller organisations often cannot dedicate one person per security function. In such environments the goal is to cover essential responsibilities with as few roles as possible. A practical baseline is to combine cloud platform engineering and security into a single role that manages secure configuration, identity hygiene, monitoring and basic incident response. Tasks that require specialised expertise or continuous coverage, such as threat detection tuning, penetration testing or compliance reviews, can be outsourced to managed security providers. Cloud-native tools such as posture management, identity protection, configuration baselines and automated policy enforcement help maintain a consistent security level without large teams and reduce operational overhead.

## Transformation of security roles

Security architecture, engineering, and operations roles are undergoing a substantial shift as organizations adopt cloud platforms and modern development practices. This transformation affects how security work is performed, how teams collaborate, and how responsibilities are distributed across technical functions.

Several factors are driving this change:

- **Shift to SaaS-based and cloud-native security tooling.**  
  Many traditional security functions no longer require teams to deploy or maintain underlying infrastructure. Instead, security roles focus on configuring, integrating, and continuously improving cloud services to ensure they meet security requirements.

- **Security as a shared responsibility across engineering teams.**  
  All technical teams are now directly accountable for applying security controls to the workloads and services they build or operate. Security teams provide patterns, guidance, automation, and guardrails that make secure implementation the default and reduce friction in delivery processes.

- **Broader, cross-technology skill requirements.**  
  Security teams increasingly need to understand a wide range of technologies and how attackers move across systems. Because cloud platforms integrate identity, network, compute, application, and operations layers, security professionals must evaluate end-to-end attack paths rather than focus on narrow technical domains.

- **Continuous change in cloud platforms and security capabilities.**  
  Cloud services evolve rapidly, and new capabilities appear frequently. Security processes must adapt continuously to remain effective, requiring greater agility from architecture, engineering, and operations roles.

- **Increased reliance on Zero Trust principles.**  
  Modern attackers routinely bypass network perimeter controls, making identity, device health, application context, and telemetry central to security decisions. Roles across engineering, operations, and security must incorporate Zero Trust thinking into design, configuration, and monitoring activities.

- **Integration of security into DevOps and platform engineering practices.**  
  Accelerated release cycles require security activities to shift earlier in the lifecycle and operate through automation. Security roles increasingly collaborate with engineering and platform teams to embed security checks, policy enforcement, and validation into CI/CD workflows and operational processes.

These changes reshape how existing roles work together rather than creating new roles. The goal is to ensure that security becomes an integrated, continuous part of how cloud services are designed, built, deployed, and operated.


## Overview of roles and teams

The following sections provide guidance on which teams and roles typically perform key cloud security functions (when these functions are present in the organization). You should map out your existing approach, look for gaps, and assess whether your organization can and should invest to address those gaps.

The roles that perform security tasks include the following roles.

- Cloud service provider

- Infrastructure/platform teams (architecture, engineering, and operations)
- Security architecture, engineering, and posture management teams:
    - Security architects and engineers (data security, identity and access management (IAM), network security, servers and container security, application security, and DevSecOps)
 
    - Software security engineers (application security)

    - Posture management (vulnerability management / attack surface management)

- Security operations (SecOps/SOC):
    - Triage analysts (tier 1)

    - Investigation analysts (tier 2)

    - Threat hunting

    - Threat intelligence

    - Detection engineering

- Security Governance, Risk, and Compliance (GRC)

- Security training and awareness

It's critical to ensure that everyone understands their role in security and how to work with other teams. You can accomplish this goal by documenting cross-team security processes and a shared responsibility model for your technical teams. Doing so helps you avoid risk and waste from coverage gaps and from overlapping efforts. It also helps you avoid common mistakes (antipatterns), like teams selecting weak authentication and cryptography solutions or even attempting to create their own.

>[!NOTE]
>A shared responsibility model is similar to a Responsible, Accountable, Consulted, Informed (RACI) model. The shared responsibility model helps illustrate a collaborative approach on who makes decisions and what teams must do to work together for particular items and outcomes.

### Cloud service provider

Cloud service providers are effectively virtual team members that provide security functions and capabilities for the underlying cloud platform. Some cloud providers also provide security features and capabilities that your teams can use to manage your security posture and incidents. For more information on what cloud services providers perform, see the [cloud shared responsibility model](/azure/security/fundamentals/shared-responsibility).  

Many cloud service providers provide information on their security practices and controls upon request or via a portal like the [Microsoft service trust portal](https://servicetrust.microsoft.com/).

### Infrastructure/platform teams (architecture, engineering, and operations)

Infrastructure/platform architecture, engineering, and operations teams implement and integrate cloud security, privacy, and compliance controls across the cloud infrastructure and platform environments (across servers, containers, networking, identity, and other technical components).  

The engineering and operations roles can focus primarily on cloud or continuous integration and continuous deployment (CI/CD) systems, or they can work across a full range of cloud, CI/CD, on-premises, and other infrastructures and platforms.  

These teams are responsible for meeting all the availability, scalability, security, privacy, and other requirements for the organization's cloud services that host business workloads. They work collaboratively with security, risk, compliance, and privacy experts to drive outcomes that blend and balance all these requirements.  
  
### Security architecture, engineering, and posture management teams

Security teams work with infrastructure and platform roles (and others) to help translate security strategy, policy, and standards into actionable architectures, solutions, and design patterns. These teams focus on enabling the security success of cloud teams by evaluating and influencing the security of the infrastructure and the processes and tools that are used to manage it. Following are some of the common tasks performed by security teams for the infrastructure:

- **Security architects and engineers** adapt security policies, standards, and guidelines for cloud environments to design and implement controls in partnership with their infrastructure/platform counterparts. Security architects and engineers assist with a broad range of elements, including:

    - *Tenants/subscriptions.* **Security architects and engineers** collaborate with **infrastructure architects and engineers** and **access architects** (identity, networking, app, and others) to help establish security configurations for cloud tenants, subscriptions, and accounts across cloud providers (which are monitored by **security posture management** teams).

    - *IAM.* **Access architects** (identity, networking, app, and others) collaborate with **identity engineers and operations** and infrastructure/platform teams to design, implement, and operate access management solutions. These solutions protect against unauthorized use of the organization's business assets while enabling authorized users to follow business processes to easily and securely access organizational resources. These teams work on solutions like identity directories and single sign-on (SSO) solutions, passwordless and multifactor authentication (MFA), risk-based Conditional Access solutions, workload identities, privileged identity/access management (PIM/PAM), cloud infrastructure and entitlement management (CIEM), and more. These teams also collaborate with network engineers and operations to design, implement, and operate security service edge (SSE) solutions. Workload teams can take advantage of these capabilities to provide seamless and more secure access to individual workload and application components.  

    - *Data security.* **Security architects and engineers** collaborate with **data and AI architects and engineers** to help infrastructure/platform teams establish foundational data security capabilities for all data and advanced capabilities that can be used to classify and protect data in individual workloads. For more information on foundational data security, see the Microsoft security [Data Protection benchmark](/security/benchmark/azure/mcsb-data-protection). For more information on protecting data in individual workloads, see the Well-Architected Framework [guidance](/azure/well-architected/security/data-classification).
    
    - *Network security.* **Security architects and engineers** collaborate with **network architects and engineers** to help infrastructure/platform teams establish foundational network security capabilities like connectivity to the cloud (private/leased lines), remote access strategies and solutions, ingress and egress firewalls, [web application firewalls (WAFs)](/azure/web-application-firewall/), and [network segmentation](../ready/azure-best-practices/plan-for-landing-zone-network-segmentation.md). These teams also collaborate with identity architects, engineers, and operations to design, implement, and operate SSE solutions. Workload teams can take advantage of these capabilities to provide discrete protection or isolation of individual workload and application components.

    - *Servers and container security.* **Security architects and engineers** collaborate with **infrastructure architects and engineers** to help infrastructure/platform teams establish foundational security capabilities for servers, virtual machines (VMs), containers, orchestration/management, CI/CD, and related systems. These teams establish discovery and inventory processes, security baseline/benchmark configurations, maintenance and patching processes, allowlisting for executable binaries, template images, management processes, and more. Workload teams can also take advantage of these foundational infrastructure capabilities to provide security for servers and containers for individual workload and application components.  

    - *Software security foundations (for application security and DevSecOps).* **Security architects and engineers** collaborate with **software security engineers** to help infrastructure/platform teams establish application security capabilities that can be used by individual workloads, code scanning, software bill of materials (SBOM) tools, WAFs, and application scanning. See [DevSecOps controls](/security/zero-trust/develop/secure-devops-environments-zero-trust) for more information on how to establish a security development lifecycle (SDL).  For more information on how workload teams use these capabilities, see the [security development lifecycle](/azure/well-architected/security/secure-development-lifecycle) guidance in the Well-Architected Framework.

-  **Software security engineers** evaluate code, scripts, and other automated logic that's used to manage the infrastructure, including infrastructure as code (IaC), CI/CD workflows, and any other custom-built tools or applications. These engineers should be engaged to protect formal code in compiled applications, scripts, configurations of automation platforms, and any other form of executable code or script that could allow attackers to manipulate the operation of the system. This evaluation might entail simply performing a threat model analysis of a system, or it might involve code review and security scanning tools. See the [SDL practices](https://www.microsoft.com/securityengineering/sdl/practices) guidance for more information on how to establish an SDL.  

- **Posture management (vulnerability management / attack surface management)** is the operational security team that focuses on security enablement for technical operations teams. Posture management helps these teams prioritize and implement controls to block or mitigate attack techniques. Posture management teams work across all technical operations teams (including cloud teams) and often serve as their primary means of understanding security requirements, compliance requirements, and governance processes.

   Posture management often serves as a center of excellence (CoE) for security infrastructure teams, similar to the way software engineers often serve as a security CoE for application development teams. Typical tasks for these teams include the following.

    - *Monitor security posture.* Monitor all technical systems by using posture management tools like Microsoft Security Exposure Management, Microsoft Entra Permissions Management, non-Microsoft vulnerability and External Attack Surface Management (EASM) and CIEM tools, and custom security posture tools and dashboards. Additionally, posture management performs analysis to provide insights by:

        -  *Anticipating highly likely and damaging attack paths.* Attackers "think in graphs" and seek out paths to business-critical systems by chaining together multiple assets and vulnerabilities across different systems (for example, compromise user endpoints, then use the hash/ticket to capture an admin credential, then access the business-critical data). Posture management teams work with security architects and engineers to discover and mitigate these hidden risks, which don't always appear in technical lists and reports.

        - *Conducting security assessments* to review system configurations and operational processes to gain deeper understanding and insights beyond the technical data from security posture tools. These assessments can take the form of informal discovery conversations or formal threat modeling exercises.

    - *Assist with prioritization.* Help technical teams proactively monitor their assets and prioritize security work. Posture management helps put the risk mitigation work into context by considering security risk impact (informed by experience, security operations incident reports and other threat intelligence, business intelligence, and other sources) in addition to security compliance requirements.

    - *Train, mentor, and champion.* Increase the security knowledge and skills of technical engineering teams through training, mentoring individuals, and informal knowledge transfer. Posture management roles might also work with **organizational readiness / training** and **security education and engagement** roles on formal security training and setting up security within technical teams that evangelize and educate their peers on security.

    - *Identify gaps and advocate for fixes.* Identify overall trends, process gaps, tooling gaps, and other insights into risks and mitigations. Posture management roles collaborate and communicate with security architects and engineers to develop solutions, build a case for funding solutions, and assist with rolling out fixes.

    - *Coordinate with security operations (SecOps).* Help technical teams work with SecOps roles like detection engineering and threat hunting teams. This continuity across all operational roles helps ensure that detections are in place and implemented correctly, security data is available for incident investigation and threat hunting, processes are in place for collaboration, and more.

    - *Provide reports.* Provide timely and accurate reports on security incidents, trends, and performance metrics to senior management and stakeholders to update organizational risk processes.
    
    Posture management teams often evolve from existing software vulnerability management roles to address the full set of functional, configuration, and operational vulnerability types described in the Open Group Zero Trust Reference Model. Each type of vulnerability can allow unauthorized users (including attackers) to take control of software or systems, enabling them to cause damage to business assets.

    - *Functional vulnerabilities* occur in software design or implementation. They can allow unauthorized control of the affected software. These vulnerabilities might be flaws in software that your own teams developed or flaws in commercial or open source software (typically tracked by a Common Vulnerabilities and Exposures identifier).
    
    - *Configuration vulnerabilities* are misconfigurations of systems that allow unauthorized access to system functionality. These vulnerabilities can be introduced during ongoing operations, also known as configuration drift. They can also be introduced during the initial deployment and configuration of software and systems, or by weak security defaults from a vendor. Some common examples include:

        - Orphaned objects that allow unauthorized access to items like DNS records and group membership.

        - Excessive administrative roles or permissions to resources.

        - Use of a weaker authentication protocol or cryptographic algorithm that has known security issues.

        - Weak default configurations or default passwords.

    - *Operational vulnerabilities* are weaknesses in standard operating processes and practices that allow unauthorized access or control of systems. Examples include:

        - Administrators using shared accounts instead of their own individual accounts to perform privileged tasks.

        - Use of ["browse-up" configurations](https://www.ncsc.gov.uk/whitepaper/security-architecture-anti-patterns) that create elevation-of-privilege paths that can be abused by attackers. This vulnerability occurs when high-privileged administrative accounts sign in to lower-trust user devices and workstations (like standard user workstations and user-owned devices), sometimes via jump servers that don't effectively mitigate these risks. For more information, see [securing privileged access](/security/privileged-access-workstations/privileged-access-strategy) and [privileged access devices](/security/privileged-access-workstations/privileged-access-devices).

### Security operations (SecOps/SOC)

The SecOps team is sometimes referred to as a Security Operations Center (SOC). The SecOps team focuses on rapidly finding and removing adversary access to the organization's assets. They work in close partnership with technology operations and engineering teams. SecOps roles can work across all technologies in the organization, including traditional IT, operational technology (OT), and Internet of Things (IoT). Following are the SecOps roles that most often interact with cloud teams:

   - **Triage analysts (tier 1).** Responds to incident detections for well-known attack techniques and follows documented procedures to rapidly resolve them (or escalate them to investigation analysts as appropriate). Depending on the SecOps scope and maturity level, this might include detections and alerts from email, endpoint antimalware solutions, cloud services, network detections, or other technical systems.

   - **Investigation analysts (tier 2).** Responds to higher-complexity and higher-severity incident investigations that require more experience and expertise (beyond well-documented resolution procedures). This team typically investigates attacks that are conducted by live human adversaries and attacks that affect multiple systems. It works in close partnership with technology operations and engineering teams to investigate incidents and resolve them.

   - **Threat hunting.** Proactively searches for hidden threats within the technical estate that have evaded standard detection mechanisms. This role uses advanced analytics and hypothesis-driven investigations.

   - **Threat intelligence.** Gathers and disseminates information about attackers and threats to all stakeholders, including business, technology, and security. Threat intelligence teams perform research, share their findings (formally or informally), and disseminate them to various stakeholders, including the cloud security team. This security context helps these teams make cloud services more resilient to attacks because they're using real-world attack information in design, implementation, testing, and operation, and continuously improving.

   - **Detection engineering.** Creates custom attack detections and customizes attack detections provided by vendors and the broader community. These custom attack detections supplement vendor-provided detections for common attacks that are commonly found in extended detection and response (XDR) tools and some security information and event management (SIEM) tools. Detection engineers work with cloud security teams to identify opportunities for designing and implementing detections, the data required to support them, and the response/recovery procedures for the detections.

### Security Governance, Risk, and Compliance

Security Governance, Risk, and Compliance (GRC) is a set of interrelated disciplines that integrate the technical work of security teams with organizational goals and expectations. These roles and teams can be a hybrid of two or more disciplines or can be discrete roles. Cloud teams interact with each of these disciplines over the course of the cloud technology lifecycle:

- The **governance** discipline is a foundational capability that focuses on ensuring the organization is consistently implementing all aspects of security. Governance teams focus on decision rights (who makes what decisions) and process frameworks that connect and guide teams. Without effective governance, an organization with all the right controls, policies, and technology can still be breached by attackers who found areas where the intended defenses aren't implemented well, fully, or at all.

- The **risk management** discipline focuses on ensuring that the organization is effectively assessing, understanding, and mitigating risk. Risk management roles work with many teams across the organization to create a clear representation of the organization's risk and keep it current. Because many critical business services can be hosted on cloud infrastructure and platforms, cloud and risk teams need to collaborate to assess and manage this organizational risk. Additionally, supply chain security focuses on risks associated with external vendors, open source components, and partners.

- The **compliance** discipline ensures that systems and processes are compliant with regulatory requirements and internal policies. Without this discipline, the organization might be exposed to risk related to noncompliance with external obligations (fines, liability, loss of revenue from inability to operate in some markets, and more). Compliance requirements typically can't keep up with the speed of attacker evolution, but they're an important requirement source nonetheless.

All three of these disciplines operate across all technologies and systems to drive organizational outcomes across all teams. All three also rely on context they get from each other and benefit significantly from current high-fidelity data on threats, business, and the technology environment. These disciplines also rely on architecture to express an actionable vision that can be implemented and security education and policy to establish rules and guide teams through the many daily decisions.

Cloud engineering and operation teams might work with **posture management** roles, **compliance and audit** teams, **security architecture and engineering**, or **chief information security officer (CISO)** roles on GRC topics.

### Security education, awareness, and policy

Organizations must ensure that all roles have the knowledge, guidance, and confidence to apply security effectively in their daily work. Education and awareness are often the weakest links in an organization’s security posture, so they must be continuous, role-aware, and embedded into normal operations rather than treated as one-off training events.

A strong program includes structured education, informal mentoring, and designated security champions within technical teams. Training should cover phishing awareness, identity hygiene, secure configuration practices, and a secure development mindset for engineering roles. These efforts reinforce a security-first culture, where individuals clearly understand why security matters, what actions are expected of them, and how to perform those actions correctly.

Security education and policy must help each role understand:

- **Why.** Why security is important in the context of their responsibilities and goals. Without this understanding, individuals deprioritize security and focus on other tasks.
- **What.** What specific security tasks and expectations apply to them, described in language aligned with their role. Without clarity, people assume security is not relevant to them.
- **How.** How to correctly perform the required security tasks, such as patching systems, identifying phishing attempts, reviewing code securely, or completing a threat model. Without practical guidance, people fail even when willing.

To ensure impact and accountability, organizations should define measurable security KPIs. Examples include training completion rates, reduction in repeated risky behaviors, vulnerability remediation timelines, patching cadence, and participation in security exercises. Tracking these metrics provides visibility into the effectiveness of security education, supports compliance requirements, and highlights areas where additional investment or support is needed.

## Example scenario: Typical interoperability among teams

When an organization deploys and operationalizes a WAF, several security teams must collaborate to ensure its effective deployment, management, and integration into the existing security infrastructure. Here's how the interoperability among teams might look in an enterprise security organization:

1. **Planning and design**
    1. The *governance team* identifies the need for enhanced web application security and allocates budget for a WAF.
    1. The *network security architect* designs the WAF deployment strategy, ensuring it integrates seamlessly with existing security controls and aligns with the organization's security architecture.
1. **Implementation**
    1. The *network security engineer* deploys the WAF according to the architect's design, configuring it to protect the specific web applications, and enables monitoring.
    1. The *IAM engineer* sets up access controls, ensuring that only authorized personnel can manage the WAF.
1. **Monitoring and management**
    1. The *posture management team* provides instructions for the *SOC* to configure monitoring and alerting for the WAF and to set up dashboards to track WAF activity.
    1. The *threat intelligence and detection engineering teams* help to develop response plans for incidents that involve the WAF and to conduct simulations to test these plans.
1. **Compliance and risk management**
    1. The *compliance and risk management officer* reviews the WAF deployment to ensure it meets regulatory requirements and conducts periodic audits.
    1. The *data security engineer* ensures that the WAF's logging and data protection measures comply with data privacy regulations.
1. **Continuous improvement and training**
    1. The *DevSecOps engineer* integrates WAF management into the CI/CD pipeline, ensuring that updates and configurations are automated and consistent.
    1. The *security education and engagement specialist* develops and delivers training programs to ensure that all relevant personnel understand how to use and manage the WAF effectively.
    1. The *cloud governance team member* reviews the WAF deployment and management processes to ensure that they align with organizational policies and standards.

By collaborating effectively, these roles ensure that the WAF is deployed correctly and also continuously monitored, managed, and improved to protect the organization's web applications from evolving threats.

## Next step

> [!div class="nextstepaction"]
> [Integrate security into your cloud adoption strategy](./strategy.md)
