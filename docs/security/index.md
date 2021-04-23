---
title: Cloud Adoption Framework - Security Methodology
description: Integrating security through the cloud adoption journey
author: MarkSimos
ms.author: mas
ms.date: 04/04/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: secure
ms.custom: internal
---

# Secure Methodology - Building security into your cloud adoption journey

Just cloud adoption is a journey, cloud security is also an ongoing journey of incremental progress and maturity, not a static destination.

## Envision a security end state

A journey without a target destination is just wandering. The Secure methodology provides a vision of the complete end state to guide the improvement of your security program over time. The following infographic provides a visual mapping of the key ways that security integrates with the larger organization and the disciplines within security.

![CAF Secure Methodology](../_images/security/secure-methodology.png)

The Cloud Adoption Framework provides security guidance for this security journey by providing clarity for the processes, best practices, models, and experiences. This guidance is based on the lessons learned and real world experiences of real customers, Microsoft's security journey, and work with organizations like NIST, [The Open Group, and the [Center for Internet Security (CIS)](https://www.cisecurity.org/).

## Mapping to concepts, frameworks, and standards

Security itself is both a standalone organizational discipline and a quality/attribute that is integrated/overlaid on other disciplines, which makes it difficult to precisely define and map in detail. The security industry uses many different frameworks to capture risk, plan controls, and operate. This is a quick summary of how the disciplines in the CAF secure methodology disciplines relates to other security concepts and guidance:

 - **Zero Trust** - Microsoft believes all security disciplines should follow the  Zero Trust principles of *assume breach, verify explicity,* and *use least privilege access*. These underpin any sound [security strategy](https://aka.ms/securitystrategy) and also must be balanced with *business enablement* goals. The first and most visible part of zero trust is in access control, so it is  highlighted in the description of access control security discipline.  
	
 - **The Open Group** - These security disciplines map closely to the Zero Trust Components in the [Core principles whitepaper](https://publications.opengroup.org/security-library/w210) published by The Open Gropu, where Microsoft actively participates. The one notable exception is that Microsoft elevated the discipline of Innovation Security so that DevSecOps is a top level element because of how new, important, and transformative this discipline is for many organizations. 
	
 - **NIST Cybersecurity Framework (CSF)** - For organizations that use the [NIST cybersecurity framework](https://www.nist.gov/cyberframework), we have highlighted bold text where the NIST CSF most closely maps. Modern access control and DevSecOps map broadly to the full spectrum of CSF so aren't noted individually. 

## Mapping to Roles and Responsibilities

At the organizational level, the security disciplines map to standard plan-build-run phases seen widely across industries and organizations. While this cycle is accelerating with the digital age and the advent of DevOps and DevSecOps, these fundamentals help illustrate how security maps to normal business processes. Security is both a unique discipline, but it also integrates with normal business operations. 

![Security Personas](./media/securitypersonas.png)

The bottom section of this diagram has the specific organizational functions within security (sometimes called "jobs to be done" or responsibilities) that are detailed in https://aka.ms/securityroles. 

The middle (dark blue) section groups these roles into security personas that have common skillsets and career profiles. This helps provide clarity on how industry trends are impacting security professionals:

 - **Security Leadership** - This spans across functions, ensuring that teams coordinate with each other, providing prioritization and setting cultural norms, policies, and standards for security.
 - **Security Architect** - Spans across functions with a strong emphasis on governance to ensure that all of the technical functions are working harmoniously within a consistent architecture
 - **Security Posture & Compliance** - This represents the combination of security posture management disciplines like vulnerability management with compliance reporting functions. These functions are increasingly working with the same near real-time data feeds and their scope is converging into all forms of risk and vulnerabilities to the organization (technology itself like software updates, technology configuration, and operational practices)
 - **Platform security engineer** - Technology roles focused on platforms that host multiple workloads, focused on access control and asset protection. These roles are often broken teams with specialized technical skillsets including network security, infrastructure and endpoints, identity and key management, and others. This includes preventive controls and detective controls with detective controls in partnership with SecOps and preventive controls primarily in partnership with IT Operations. 
 - **Application Security Engineer** - Technology roles focused on security controls for specific workloads, supporting both classic development models and modern DevOps/DevSecOps model. This is a blend of application/development security skills for unique code and infrastructure skills for common technical components like VMs, databases, and containers. 
>[!Note]
> As both DevOps and Infrastructure as code trends progress, we expect to see some security talent migrate from platform security engineering teams to application security teams and posture management roles. This is because the DevOps model requires infrastructure security skills (e.g. securing the "ops" in devops) and governance teams will also require these skills and experience to effectively monitor technical security posture in real time. Additionally, infrastructure as code will automate repetitive manual technical tasks, reducing the volume of time required for these skills in the platform security engineer roles (though increasing the need for broad technical skillsets and automation/scripting skills).  

For more information on detailed security functions held by roles, see https://aka.ms/securityroles



## Security Transformation

As organizations adopt the cloud, they quickly find that static security processes cannot keep up with the pace of change in cloud platforms, the threat environment, and the evolution of security technologies. Security must shift to a continuously evolving approach to match pace with this change that will transform organizational culture and daily processes throughout the organization.

To guide this transformation, this methodology provides guidance on the integration of security with business processes (top row) and security technical disciplines (bottom row). These collectively enable meaningful and sustainable progress on your security journey to reduce organizational risk. Few organizations can master all of these at once, but all organizations should steadily mature each process and discipline.

### Change Drivers

Security organizations are experiencing two types of major transformations at the same time

- **Security as business risk:** Security has been propelled into the realm of business risk management from a purely technical quality-oriented discipline. This is driven by dual forces of
  - *digital transformation* - increases in digital footprint are continuously increasing the potential attack surface of the organization
  -  *threat landscape* - increases in attack volume and sophistication that are fueled by an industrialized attack economy with specialized skills and continuous commoditization of attack tools and techniques
- **Platform change:** Security is also grappling with a technical platform change to the cloud. This shift is on the scale of factories shifting from running their own electrical generators to plugging into an electrical grid. While security teams often have the right foundational skills, they are becoming overwhelmed by the changes to nearly every process and technology they use everyday.
- **Shift in expectations:** In the past decade, digital innovation has redefined entire industries. Business agility, especially agility related to digital transformation, can quickly unseat an organization as a market leader. Likewise, loss of consumer confidence can have a similar impact on the business. While it was once acceptable for security to start with "No" to block a project and protect the organization,  the urgency of embracing digital transformation must change the engagement model to "Let's talk about how to stay safe while you do what is needed to stay relevant."

## Guiding lasting transformation

Transforming how the business and tech teams view security requires aligning security closely to the priorities, processes, and risk framework. Key areas that drive success are

- **Culture:** The culture of security must be focused on safely meeting the business mission, not impeding it. At the same time, security must become a normalized part of the culture of the organization as the internet upon which the business operates is open, allow adversaries to attempt attacks at any time. This cultural shift requires improved processes, partnerships, and ongoing leadership support at all levels to communicate the change, model the behavior, and reinforce the shift.
- **Risk ownership:** The accountability for security risk should be assigned to the same roles that own all other risks, freeing security up to be a trusted advisor and subject matter expert rather than a scapegoat. Security should be responsible for sound and balanced advice that is communicated in the language of those leaders, but should not be held accountable for decisions they do not own. 
- **Security Talent:**  Security talent is in a chronic shortage and organizations should always be planning how to best develop and distribute security knowledge and skills. In addition to growing security teams directly with technical security skillsets, mature security teams are also diversifying their strategy by focusing on
  - *Growing security skillsets and knowledge* within existing teams in IT and the business. This is particularly important for DevOps teams with a DevSecOps approach and can take many forms (security helpdesk, identify and train champions within the community, job swapping programs, etc.).  
  - *Recruiting diverse skillsets* to security teams to bring fresh perspectives and frameworks to problems (business, human psychology, economics, etc.) and build better relationships within the organization. To a hammer, all problems look like nails. 

### Business Alignment

Because of these shifts, your cloud adoption program should focus heavily on business alignment in three categories

- **Risk Insights:** Align and integrate security insights and risk signals/sources to the business initiatives. Ensure repeatable processes educate all teams on the application of those insights and hold teams accountable for improvements.
- **Security Integration:** Integrate security knowledge, skills, and insights deeper into daily operations of the business and IT environment via repeatable processes and  deep partnership at all levels of the organization. 
- **Operational Resiliency** - Focus on ensuring the organization is resilient by being able to continue operations during an attack (even if at a degraded state) and that the organization rapidly bounces back to full operations. 

### Security Disciplines

This transformation will affect each security discipline differently. While all of these are extremely important and require investment , these are ordered (roughly) by which ones have the most immediate opportunities for quick wins as you adopt the cloud :

- **Access Control:** Application of network and identity create access boundaries and segmentation to reduce the frequency and reach of any security breaches
- **Security Operations:** Monitor IT operations to detect, respond, and recover from breach. Use data to continously reduce risk of breach
- **Asset Protection:** Maximize protection of all assets (VMs, Data, Applications, Networks, and Identities) to minimize risk to the overall environment
- **Security Governance:** Delegated decisions accelerate innovation and introduce new risks. Monitor decisions, configurations, and data to govern decisions made across the environment and within all workloads across the portfolio.
- **Innovation Security:** As organization adopt DevOps models to increase the pace of innovation, security must become an integral part of a DevSecOps process and integrate security expertise and resources directly into this high speed cycle. This involves shifting some decision making from centralized teams to empower workload-focused teams.

### Guiding Principles

All security activities should be aligned to and shaped by a dual focus on

- **Business Enablement:** Align to organization's business objective and risk framework
- **Security Assurances:** Focused on applying zero trust principles of
  - *Assume Breach:* When designing security for any component or system, reduce risk of attackers expanding access by assuming other resources in the organization are compromised
  - *Explicit Verification:* Explicitly validate trust using all available data points, rather than assuming trust. (e.g. in access control validate the user identity, location, device health, service or workload, data classification, and anomalies rather than simply allowing access from an implicitly trusted internal network)
  - *Least Privileged Access:* Limit the risk of a compromised user or resource by providing just-in-time and just-enough-access (JIT/JEA), risk-based adaptive polices, and data protection to help secure both data and productivity.


### Additional Resources

This CAF Secure methodology is part of a comprehensive set of security guidance that also includes
 - [**Azure Well-Architected Framework**](https://docs.microsoft.com/azure/architecture/framework/security/overview) - Guidance on securing your workloads on Azure
 - [**Azure Security Benchmarks**](https://aka.ms/benchmarkdocs) - Prescriptive Best Practices and Controls for Azure Security
 - [**Enterprise Scale Landing Zone**](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/enterprise-scale/security-governance-and-compliance) -Azure Reference architecture and implementation with integrated security
 - [**Azure Top 10 Security Best Practices**](https://aka.ms/azuresecuritytop10) - Top Azure security best practices that Microsoft recommends based on lessons learned across customers and our own environments.
