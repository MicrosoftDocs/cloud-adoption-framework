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

Security should feel like natural part of business, and business should feel like a natural part of security

Security should be a part of everyone's job in the organization just like business requirements, performance, and reliability. Conversely, security at all levels should be familiar with overall business priorities, IT Initiatives, and risk appetite for the organization.

Maintaining security assurances while minimizing friction to the business processes is a delicate balance that is important to get right.

:::image type="content" source="./media/security-Integration.png" alt-text="Security Integration" lightbox="./media/security-Integration-popout.png":::

While internal friction and low levels of inter-team conflict are often the norm in many organizations, this is no longer sustainable. It is critical for all of these teams to work together in the age of cloud, digital business, and zero trust security. The pace of change driven by business environment, technical platforms, and attackers makes an organization inefficient and ineffective if they these teams are operating with separate goals, culture, and language. 

An additional priority is to ensure security teams are not operating within silos, but are working closely together to ensure smooth process operations and knowledge sharing. 

This section will outline how you can improve security integration with the business and IT teams and integration between security teams. 

## Normalize Relations

While overcoming the silo approach that is prevalent at many organizations can be challenging, it can be done. The main elements are to provide clarity on the end state, clarity on the process, and ongoing leadership support for both tangible objectives and for culture and behavior changes. 

The two most critical elements in this process are to
1. Identify Shared Goals and Outcomes
2. Identify Right level of security

### 1. Identify Shared Goals and Outcomes

The first step is to ensure there is a shared vision of what good looks like that involves all teams. Security teams have often defined themselves as a kind of quality control over the business and IT functions, creating an adversarial dynamic and generating friction that drains energy and focus away from everyone's goals. Business productivity, IT goals, and security goals often suffer in this dynamic. 

The vision must include security teams integrated closely with their IT and business counterparts and being jointly responsible for the business, IT, and security outcomes of any initiative. By sharing in the challenges of designing systems to meet business and IT goals, and by sharing their security perspective and expertise at the right time, security will be part of the process and less likely to delay or derail projects (or be too late to fix security issues). 

As systems are being designed, implemented, operated, and continuously improved with security involved, it's critical to set guardrails so that *no voice dominates all decisions* (Business, IT, or security). 

### 2. Identify Right level of security** 

While some security controls like biometric logon with [Windows Hello for Business](https://docs.microsoft.com/windows/security/identity-protection/hello-for-business/hello-overview) have the dual benefits of making the user experience better and the security stronger, many security measures add friction to business processes and could slow them down. We always strive to first find security measures that are easy and invisible to users and developers, but we have to accept that sometimes a tradeoff must be made. 
	
These joint teams should always strive for a healthy level of friction in the process that creates value by driving critical thinking at the right time (considering what an attacker may do with a new feature, how much business impact would incur from altering this data, etc.)
Teams should strive for the best balance between two absolute truths:
 - **Security cannot be skipped** – skipping security often leads to incidents that cost more in the long run (productivity, revenue, overall business impact) than integrating security would have.  
 - **Security cannot dominate** – Security controls can reach an unhealthy level of friction where the security friction impedes more value than it protects

It is critical to find a balance between these as security is integrated into the process. Stakeholders must all work together to ensure business concerns, IT reliability/performance concerns, and security concerns are considered and balanced

For more on healthy security friction, see [The right level of security friction](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/strategy/define-security-strategy#the-right-level-of-security-friction) in the security strategy guidance. 

The examples in the following section illustrate some example processes on how to integrate security stakeholders with IT, end users, workload owners, as well as some examples within the security teams. 

## Integration with IT and Business operations
While the majority of security functions operate out of sight of daily business workflows, some security considerations appear in daily business and IT workflows. Just as security in the physical world is an integrated part of workflows like walking through an airport (and reporting anything suspicious as part of  "if you see something, say something", so too must security thinking be integrated into the normal experience of planning and operating a digital business. 

### Security Update Process

Security Updates are one of the most common and visible points where business processes and security processes regularly interact. This is a common source of friction because it involves a difficult balance of two different forces which are often mapped to separate stakeholders in the organization:

 - *Immediate business impact* - Security updates often require testing and system reboots, which consume time/resources for application owners and IT teams, and potentially result in business impact from downtime.
 - *Potential future business impact (via security risk)* - If updates are not applied completely, attackers can exploit the vulnerabilities and cause even greater business impact.  

If teams are operating without shared goals and responsibility (IT/business focused 100% on immediate business impact, security accountable for 100% of the security risk, then they will be in constant conflict over security updates (fiercely defending their positions at the expense of the other). This distracts the teams with endless arguments instead of working together to solve this problem, then moving onto the next problems, risks, and business value creation opportunities. 

Correctly placing the accountability for all benefits and risk on the asset owners (usually application owners in the business) makes it easier for that one person to consider immediate and potential future impact. Making identifying the solution a joint responsibility of all subject matter experts in security, IT, and business increases the quality of the solution by considering more and diverse perspectives. 

This example process illustrates how organizations are starting to solve this problem using shared responsibility and flexibility within a limited timeframe:

:::image type="content" source="./media/Security-update-process.png" alt-text="Security Updates Flow" lightbox="./media/Security-update-process-popout.png":::

This process is followed on a regular schedule

  - **Enterprise IT and Security Teams** start the process by identifying which patches (aka security updates) are required and the highest impact. These are then made available to end users and/or workload owners through enterprise-wide distribution channels. 
 - **End Users** are given a fixed period of time to test the patches, apply them, and reboot their devices. After that self-service period (and any grace period) expires, Enterprise IT and Security teams will either force the patch to apply or block access to corporate resources (through a mechanism like Azure AD Conditional Access or 3rd party network access control solution)
 - **Workload Owners** are given a fixed period of time to test the patches, apply them to production systems, and reboot as required. After that self-service period (and any grace period) expires, Enterprise IT and Security teams will either force the patch to apply or isolate them from other corporate resources. Some organizations with stringent requirements may also decommission the assets by deleting them from Azure Subscriptions or AWS Accounts. 
- **Enterprise IT and Security Teams** also monitors the status of the patching and conduct any forced remediation that the organization has identified. 

This process is not static and it's not set up in one day. It is built iteratively and continuously improved over time. Start wherever you are and continually improve the process to make incremental progress towards this end state. Dimensions you can use for continuous improvement planning include

 - *Coverage* - Start with a few application teams that have a high chance of success (or have an outsized business impact if compromised) and continually add more until you are covering all workloads in the environment
 - *Time* - Start with deadlines that you know can be accomplished and set a clear roadmap to continually shorten those until you are as close as possible to fully patched in a week or less. 
 - *Technology scope* - Continuously improve what patches and technologies you cover, including applications, middleware, and open source components used in application code. You should also encourage use of components that are patched for you to lower the maintenance burden (e.g. using [Azure SQL](https://docs.microsoft.com/azure/azure-sql/) instead of installing and patching your own SQL server)
 - *Processes* - Continually improve communication channels between teams, prioritization guidance, exception processes, and all other aspects of this process
 

## Integration within Security Teams

Security teams should work together and collaborate to avoid increased business risk resulting from operating in silos. When learnings and key insights aren't shared across security teams, the organization may experience greater damage and impact from a future incident that could have been avoided. 

Security is a dynamic discipline that must always be responding to active threats and always be learning and continuously improving processes, tools, and technologies. Security must constantly adapt to the shifts in attacker techniques, technology platforms, and business models of their organization. Security teams should work together to rapidly respond to threats and continuously integrate insights and learnings into processes that both improve the security posture of the organization and ability to rapidly respond to attacks.  

The following workflow diagram illustrates how security disciplines should collaborate to completely integrate learnings and insights to improve security overall 

:::image type="content" source="./media/complete-risk-mitigation.png" alt-text="Security Integration" lightbox="./media/complete-risk-mitigation-popout.png":::

Security's primary mission is to rapidly respond to:

 - **New Incidents** Active attackers with access to organizational resource pose an immediate risk to the organization that must be *rapidly and completely* remediated as a first priority. After remediation, these attacks represent the best opportunity to learn what future attacks will look like. Whether they succeeded or failed, attackers are extremely likely to repeat pursuing the same target, technique, or monetization model again. 

- **New Insights/learnings** can come from additional sources including:

     - *External incidents* - incidents at other organizations can offer similar insights on what attackers are likely to attempt on your organization, helping inform improvement plans or validate that the organization's investments are on the right track. These can be discovered through Information Sharing and Analysis Center (ISACs), direct relationships with industry peer organizations, or other public reporting and analysis on incidents.
     -  *New technical capabilities* - cloud providers and software vendors are continuously innovating and adding capabilities to their products to remain relevant to customers and competitive in the marketplace. These include new or updated 
         - *business capabilities* that require security defenses 
         - *security capabilities* that improve the ability of security to defend the assets. These may be native security capabilities integrated into cloud platforms or other platform technology, or they may be traditional standalone security capabilities. 
     - *Industry best practices* from vendors and organizations like National Institute of Standards and Technology (NIST), Center for Internet Security (CIS), The Open Group, and others. These organizations have a charter to gather and share learnings and best practices that security teams can learn from.  
     - *New vulnerabilities* - Vulnerabilities anything that an attacker can exploit to take control of an asset without authorization. This often takes the form of software vulnerabilities, but can also be  security configuration choices, mathematical weaknesses in cryptographic algorithms, insecure practices and processes for using or managing systems, and more. As these vulnerabilities are discovered, they should be evaluated for how much they impact the organizations security posture and ability to detect, respond to, and recovery from an attack. 
 - **Respond to Threat** - Security Operations team(s) investigate detections and respond to them by evicting adversaries from their control points in the organization. Depending on the size of the organization and complexity of the incident, this may involve one or more teams within security operations.  
 - **Root Cause Analysis** - Identifying the key contributing factors that made a major incident higher likelihood or higher impact generates insights learnings that can improve the organizations security posture and ability to respond. These learnings could happen along many dimensions including attack tools and infrastructure, attack techniques, targets, motivation and monetization models, and more). These can inform preventive controls, detective controls, security operations processes, or any other element of the security program or architecture.  
- **Hunt for threat** - Hunting proactively for threats is an ongoing activity at all times. Hinting should always consider new insights or learnings in their hunt planning and hypothesis development. Hunt teams may want to prioritize hunting for exploitation of a recently  widespread or high impact vulnerability, for a new attacker group that was recently found, for a new attack technique that was demonstrated at a conference, and so on.  
- **Design/Implement Migitation** - To fully learn a lesson, it must be integrated into the techncal environment and security/business processes going forward. Teams should work together to integrate learnings into the architecture, policy, standards, and more. For example, the theft of administrative credentials in a recent internal or public incident may spur the organization to adopt the controls in Micrsoft's privilege access [Rapid Modernization plan (RaMP)](https://aka.ms/SPA-RAMP)   


## Next Steps
As you plan your cloud adoption, focus on integrating security functions more closely together and integrating security with the larger organization. Pay close attention to the kind of friction that security generates in processes, ensuring that it is generating the healthy friction that reduces risk for the organization without creating slowdowns that erode more value than they protect.
 
 - Review the [Security Strategy Guidance](https://aka.ms/securitystrategy)
 - Review the [Security Organizational Functions](https://aka.ms/securityroles)
 - Review [Security Operational Resilience](./operational-resiliency.md)
