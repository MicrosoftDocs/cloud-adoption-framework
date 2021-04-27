---
title: Asset Protection
description: Learn about asset protection best practices in the Cloud Adoption Framework for Azure.
author: DominicAllen
ms.author: doalle
ms.date: 04/04/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: secure
ms.custom: internal
---

# Asset Protection

Assets can take any physical or virtual form such as a laptop, a database, a file, a virtual storage account, an Azure Function, etc. Business critical assets often take the form of business critical data or business critical applications and services, but the security of these often relies on the security of underlying system dependencies like storage, data, endpoint devices, application components, and more. In today's world, the most valuable technical assets to an organization are typically data and the availability of applications (e.g. business websites, production lines, communications, etc.). 

Asset Protection implements controls to support security architecture, standards, and policy. Each asset type and security requirements are unique (identities, endpoints, applications, Azure services, etc.), but the security standards for any asset type should be consistently applied to all instances. 

Asset protection is primarily focused on consistent execution across all control types including preventive, detective, and others aligned to meet the policies, standards, and architecture. Asset protection typically acts as the technical subject matter expert for assets (which is a continuous journey of learning) while working with other disciplines (governance, architecture, security operations, workload teams, etc.). Asset protection ensures that policy and standards are feasible, enables implementation of controls to support the policy and standards, and provides feedback for continuous improvement. 

[!Note] Asset protection is typically implemented by IT Operations teams that maintain the assets and is often supplemented by expertise in the security team. See [Designing Controls as a team](#designing-controls-as-a-team) at the end of this article for more information.


Asset protection is critically important because threat actors are persistent and seek out and exploit vulnerablities that result from gaps in the application of standards and policy. Attackers can directly target the business-critical data or application, but also frequently target the underlying infrastructure that grants them access to the business-critical data and applications. Whereas [Access Control](.\access-control.md) focuses on managing authorized access to resources, asset protection focuses on all other potential "out of band" ways to gain access or control of resources. These two disciplines complement each other and should be designed together to meet the organizations architecture, policies, and standards.  

![Asset Protection](./media/asset-protection.png)

## Get Secure
Get secure focuses on bringing resources up to meet the organization's current security standards, policy, and architecture. The two types of activities are:
 - **Greenfield** - Ensuring that new assets and new asset types are configured to standards is critical to avoid continuously creating instant legacy/brownfield (systems that don't meet current standards). This technical debt will have to be addressed later at a greater expense (and results in increased risk exposure until that is done). 
 - **Brownfield** – Retrofit current security standards and controls to existing assets. Organizations often designed and operated IT environments for decades with security as minimal priority, resulting in a large amount of 'technical debt' in the form of weak security configurations, unpatched software, unencrypted communication or storage, legacy software and protocols, and more. Bringing security controls up to current approaches is critical to mitigate risk as attackers are continually improving their ability to exploit these opportunities for profit with ransomware and other illicit business models.

Financially, get secure typically maps to Capital Expenditures (CapEx) dynamics of a one time investment. *Greenfield budget* for security should be linked as closely as feasible to the creation of the asset, reserving percentage of budget for security for each new software project, major software updgrade, or overall cloud adoption initiative, etc. (many organizations reserve around 10% of budget for security). *Brownfield budget* is typically a special project funded to bring security controls up to current standards/compliance.


## Stay Secure

Everything degrades over time to where it no longer meets current requirements including physical items that wear out, but also virtual items like software, security controls, and security. While software itself remains identical over time, the environment around it and requirements to meet those needs continually change. This happens particularly fast today because of rapid changes in
  - *Business requirements* driven by digital transformation
 - *Technology requirements* driven by rapid cloud platform evolution and feature releases
 - *Security requirements* driven by attacker innovation and rapid evolution of native cloud security capabilties

This dynamic affects all parts of security, including [Security Operations](.\security-operations.md), [Access Control](.\access-control.md), and particularly DevSecOps in [Innovation Security](.\innovation-security.md)

While staying secure encompasses many elements, two specific areas that you should focus asset protection on are: 
 - **Continuous Cloud Improvement** - Embrace the continuous improvement in security capabilties that cloud brings. For example, many services in Azure like Azure Storage and  Azure SQL added security features to defend against attackers that weren't available when the service first launched. 
 - **Software End of Life** - Any software, including Windows and Linux operating systems, will always reach end of life and security updates won’t be provided for them, potentially exposing business critical data and applications to cheap and easy attacks. While Software as a service (SaaS) and cloud infrastructure/platforms are maintained by the cloud provider, enterprises often have a significant amount of software they install, author, and must maintain (most frequently installed on Infrastructure as a Server (IaaS) VMs) 

Ensuring your security risk level sustains or improves over time requires regular ongoing investment and resources to upgrade or retire the use of end of life software. Like regularly changing the oil in a car avoids big expensive costs over time, investing into your security posture reduces risk of a major security incident. Stay Secure roughly maps to Operational Expenditures (OpEx) dynamics of a regular ongoing investment. 

### The Patch Dilemma - Risk if you do, risk if you don't

It is critical for business leaders to support their IT and Security leaders and teams as they face a very difficult dilemma that occurs regularly. While the complex software environments of today provide incredible benefits to business over the preceding generation of paper based business processes, running complex software in an hostile environment has inherent risk. Security and IT leaders are constantly making difficult decisions on:

 - **Operational Risk** - A change to the software the system is running on could disrupt business processes by changing an implicit assumptions that were made when the system was customized and tailored to meet the unique needs of the organization. This creates pressure to avoiding changing the system if possible. 
 - **Security Risk** - Business risk of downtime from an attack is the other side of the equation. Attackers immediately and aggressively analyze every major security update as it's released, often developing a working exploit in 24-48 hours that can be used to attack organizations that haven't yet applied the security update. This potential for massive business interruption creates an urgency to patch immediately, but forces the organization to accept the operational risk.  

This difficult dilemma visits organizations continuously because of the continuing changes to technology and continuous evolution of attack technique. Business leaders must recognize the inherent risk of running a business using complex software, and must support updating business processes such as:

 - **Integrating software maintenance** into the business operational assumptions, schedule, forecasting, and other business processes. 
 - **Investing into architectures** that make  maintenance easier and reduce impact on business operations. This could involve updating existing architectures or shifting to new architectures entirely by migrating to cloud services or a service oriented architecture. 

Without business leadership support, security and IT leaders will be constantly distracted from supporting other important business goals by constantly managing the politics of a no-win situation. 


### Network Isolation

Network isolation may be a valid option for protecting older assets that can no longer secured but cannot be immediately retired (typically end of life operating systems and applications). This is common in operational technology (OT) environment and legacy systems. 

Isolation itself is considered an Access Control, though these unsecurable assets are identified as part of asset protection discipline. See [Avoid Firewall and Forget](.\access-control.md\#avoid-firewall-and-forget) in Access Control for more details. 


Some systems are end of life, but are difficult to disconnect and isolate completely. We do not recommend leaving these insecure system fully connected to a production network as this can allow attackers to easily compromise it and  gain access to business critical assets in the organization. 

While it's never cheap or easy to upgrade or replace computer technology that has been working well for a decade or more (often with limited documentation on its exact functionality), the potential business impact of losing control of multiple business critical assets often exceeds the cost of upgrade or replacement. For these assets that cannot be isolated, organizations often find that modernizing the workload with cloud technology and analytics can create new business value that can offset or justify the cost of upgrade and/or replacement.

Staying secure is challenging in a world that is constantly changing. It is critical to constantly prioritize what assets to modernize and what to secure as best you can using business risk and business priorities as your guiding light. 

## Getting started

Asset protection can be challenging because of the breadth and depth of the discipline, particularly for securing newer asset types like Azure and AWS Services. 

We recommend that organizations
 
 - **Focus on well-known resources first** like virtual machines, networks, and identities in the cloud that the team is already familiar with. This allows you to make immediate progress and are often easier to manage and secure with native cloud tools like Azure Security Center and Azure Defender. 
  - **Start with vendor/industry baselines** - Start your security configuration with a well known and proven solution like
      - *Azure Baselines* in Azure Security Benchmark - Microsoft provides security configuration guidance tailored to individual Azure services. These baselines apply the Azure security benchmarks to the unique attributes of each service, enabling security teams to rapidly adopt secure each service (and refine configurations as needed. See [Security Baselines for Azure](https://docs.microsoft.com/security/benchmark/azure/security-baselines-overview) 
     - *Microsoft Security Baselines* - Microsoft provides security configuration guidance for commonly used technologies including Windows, Office, and Edge to help organizations rapidly secure them. See [Microsoft Security Baselines](https://techcommunity.microsoft.com/t5/microsoft-security-baselines/bg-p/Microsoft-Security-Baselines) for more information
     - *CIS Benchmarks* - The Center for Internet Security (CIS) provides specific configuration guidance for many products and vendors. See [CIS Benchmarks](https://www.cisecurity.org/cis-benchmarks/) for more information

## Key Learnings

These are key learnings to help guide your asset protection process: 

### Accountable and Responsible Teams

Accountability for security should always resides with the ultimate resource owner in the business that owns all other risks and benefits. The security teams and subject matter experts are collectively responsible for advising the accountable owner on the risks, mitigations, and performing the actual implementation.  

Asset Protection responsibilities may be performed by IT operations that manage enterprise-wide assets, DevOps/DevSecOps teams responsible for their workload’s assets, or security teams working with the IT or DevOps/DevSecOps teams.

As organizations move to the cloud, many of these responsibilities (though not all) are either transferred to the cloud provider (e.g. updating firmware and virtualization solution) or made easier (e.g. security configuration scanning and remediation). 

For more information on the shared responsibility model, see [Shared responsibility in the cloud](https://docs.microsoft.com/azure/security/fundamentals/shared-responsibility)

### Cloud Elasticity

Unlike on premises, cloud resources may exist for only short timeframes. As needed, workloads can spin up more instances of servers, Azure Functions, etc. to perform a job and then spin them down afterward. Sometimes this happens within months, but sometimes within minutes or hours. Your asset protection processes and measurements should take this into account.

While this requires adjusting many processes, this improves your visibility (on demand inventory instead of static reports) and your ability to correct issues (e.g. building a new virtual machine for security reasons can happen very quickly)

### Exception Management
Once a best practice is identified for an asset, it should be consistently applied to all instances of it. While temporary exceptions may need to be approved, these should be managed closely with specific expiration dates to ensure that temporary exceptions don’t become a permanent business risk. 

### Challenges with measuring value/impact

 One of the difficulties with measuring the business value of asset protection investments is that the impact of a problem isn’t often apparent until there is a real-world failure. Just like changing your oil in a car seems like an expensive nuisance until the engine fails, risk of not patching security vulnerabilities is silent and invisible until an attacker exploits them and causes a major business impacting incident.

### Prefer Automated Policy

Asset protection should favor automated enforcement and remediation mechanisms like Azure Policy or another automation framework. This helps avoid cost and morale issues from repeatedly performing manual tasks (and increased security risk from human errors)

Azure policy allows central teams to specify certain configurations that should be used in order to ensure that the resources are considered secure across clouds (virtual machines, containers, databases, storage, networks, etc.).

### Designing Controls as a team
All controls should designed as a partnership with key stakeholders. This typically includes: 
 - **Asset protection** provides subject matter expertise on the assets, the controls available for them, and feasibility of implementing the controls. 
 - **Governance team** including provides context of how the control(s) fit into the overall security architecture, policies and standards, and regulatory compliance requirements.  
 - **Security Operations** advise on detective controls and ensure alerts and logs are integrated into security operations tools, processes, and training
 - **Vendors and Cloud Providers** can provide deep subject matter expertise on systems and components to avoid known issues seen across their customer base. 

