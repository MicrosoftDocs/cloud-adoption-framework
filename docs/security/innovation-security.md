---
title: Innovation Security
description: Explore the key themes of consideration for integrating security best practices into innovation areas
author: DominicAllen
ms.author: doalle
ms.date: 04/04/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: secure
ms.custom: internal
---

# Innovation Security

Innovation is the lifeblood of growth and needs to be both enabled and protected. Innovation security protects the processes and data of innovation against cyberattacks. Most frequently, by securing the Development or DevOps process using a DevSecOps approach.

In the ideal state, security should be invisible but persistent. Just as delivering on time without sufficient quality will cost you more to fix the quality after the fact, delivering without sufficient security will cost you more to clean up afterward. Security must be a part of the organization's culture from the very top, just like innovation and reliability. 

Cloud technologies enable organizations to innovate faster than ever before. Rapidly implementing new ideas and turning them into products and services at a rate that was not previously possible. Attackers also benefit from the speed of this platform and the challenge of keeping security controls current.

As organization adopt DevOps and other rapid innovation methodologies, security must be a thread woven throughout the tapestry of the organization. 

This article shares Microsoft's learnings on integrating modern security practices (such as DevSecOps) into innovation processes.  A key part of this is aligning security, development, and operational practices.

## Secure by design

Security must be core part of the envisioning, design, implementation, and operation of services and products. As development teams shift to DevOps and adopt cloud technologies, security must be a part of that transformation. 

**Security for DevOps and Cloud** - As part of their development environment, security tools and techniques should be integrated throughout the process and made as invisible as possible. Security should show up where its needed. As a natural part of the workflow, to avoid a "quality gate" role at the end which slows deployment and creates unneccesary friction.

**DevOps and Cloud for Security** - Security should also leverage the speed of the DevOps/DevSecOps cycle and cloud technologies to improve security. Cloud technology offers rapid updating of security tools, real-time access to threat intelligence, easy ability to segment and contain risk, and more. The DevOps/DevSecOps process enables teams to rapidly address security issues rapidly as a natural part of the process/workflow. Automation in the cloud is much more sophisticated and can remove manual steps during the development cycle, further amplifying these benefits. 

This approach is a huge benefit, but can also introduce a risk of unintentional security issues if not approached correctly.
Building security checks into development cycles can reduce the risk of tokens or credentials being checked into a code repository. Scanning for vulnerabilities in third-party libraries can also help to reduce the risk in code and in environments.

Secure by design helps organizations become both more productive and more security, sidestepping natural issues with security as a "quality gate" after development finishes in a traditional waterfall approach.

## What is DevSecOps?

Technology innovation is frequently developed in the context of a rapid lean/agile development approach that combines development and operations together into a *DevOps* process. We have learned that integrating security into that process is critical to mitigate risk to the innovation process, the organization's growth, and the existing assets in the organizations. Integrating security into the process creates a ***DevSecOps*** process.

![Role of Security in Development](./media/security-in-dev.png)

DevSecOps is the integration of security into every stage of the DevOps lifecycle from idea inception through envisioning, architectural design, iterative application development and into operations. The first challenges to address with DevSecOps is the cultural element. Teams must align simultaneously to goals of innovation speed, reliability, and security resilience. The return on this cultural investment continuously pays off with the removal of removing internal friction, leading to rapid, reliable, and safe innovation. 

DevOps expanded the traditional development model (people, process, and technology) to include operations teams and reduce friction having them separated. Similarly, DevSecOps expands DevOps to  reduce the friction from separate or disparate security teams.  

**Development, Security, Operations**. Innovation and development are inherently complicated processes and it's extremely difficult to apply operational reliability and security assurances after the fact on a complex project. These three functions do their best work together in a common model, sharing context and working towards shared goals. 

[The Cloud Adoption Framework's Organize methodology provides some further context on DevSecOps structures in an organization](../organize/cloud-security-application-security-devsecops.md)

## Why DevSecOps?

DevOps brings agility, DevSecOps brings secure agility. 

As nearly every organization on the planet engages in software development to innovate and gain competitive advantage, securing the devops process is critical to the success of the organization. Attackers have taken notice of this shift to custom applications are increasingly attacking custom applications during the course of their attacks. These new applications are also often rich sources of valuable intellectual property, containing valuable new ideas that haven't yet been commoditized by the marketplace.

Additionally, the risk of software supply chain attacks makes it critical to integrate security into your process for both

- **Protecting your organization** from malicious code and vulnerabilities in your source code supply chain
- **Protecting your customers** from any security issues in your applications and systems (which may result in reputational, liability, or other negative business impacts on your organization) 

## The DevSecOps Journey

DevOps combines and empowers both Developers and Operations, which offers significant business benefits and operational efficiencies. This process of combining two previously “siloed” disciplines is often an all-consuming effort and often leaves security a distant third priority until or unless a security incident abruptly increases focus on security.

Whether you are reactively integrating security into the process or proactively working to prevent the next exposure, it’s important to integrate security knowledge and skills into all roles in a DevSecOps approach. Much like every airport passenger is asked “if you see something, say something”, both Dev and Ops roles play equally important parts in securing applications and their operational environment during business operations.

> [!Note ]Some implementations of this model combine operations and security responsibilities into a site reliability engineer (SRE) role. While fusing these responsibilities into a single role may be the ideal end-state for some organizations, this is an extreme change from current practices for most enterprises given the culture, tooling, and skillsets differences between these roles. We recommend starting by embedding security into DevOps using practical quick wins and incremental progress outlined in this guidance to ensure you are getting good return on investment (ROI) and meeting immediate needs. This will incrementally add security responsibilities to your Operations (and Developer) personnel, which gets your people closer to the end-state of an SRE (if your organization wishes to adopt that model later).

Much like developers adopt a different mindset and when they are accountable for uptime and reliability, so too does assigning security accountability help them see security issues and priorities more clearly. 

## What good looks like

Security’s goal in applications should be to remain resilient in the face on continuous attacks while maximizing the agility of the organization and ability to create value from innovative application development. The overall success factors will be similar across any security program, but the program itself may vary based on the risk appetite of the organization, the availability of budget and talent, the nature of the application portfolio and development process, and other factors. 

**((ADD DIAGRAM- DevSecOps – Native Security Integration))**

Like the product of this process, building a successful DevSecOps program is a continuous journey with incremental progress - The hallmarks of success include:

- **Converged Culture** – Security, Development, and Operations roles should contribute key elements into a shared culture and values. This shared culture should be supported by metrics to avoid natural negative perceptions (naturally see security as a negative impact that slows progress and meeting goals) and bring unique value to all aspects of application development:
  - **Developers (Dev)** prioritize rapid delivery of value and business outcomes, which often drives mindsets and habits of creative solutions.  
  - **Security (Sec)** brings awareness of the consequences of a success attack and commonly seen attack methods, which drives a mindset of security quality and principle driven security risk reduction.
  - **Operations (Ops), both current and future**, is acutely aware of long term support and operations, driving a mindset of prioritizing predictability, stability, and supportability.

Organizations must blend all three cultures together to achieve DevSecOps and ensure that *no one mindset dominates all decisions*, as this would cause an imbalance that negatively impacts the business.

- **The right level of security friction** – Security naturally creates friction that slows down processes, it is critical to identifying which elements are healthy in your DevOps process and which are not:
  - **Healthy Friction** – much like the resistance in exercise makes a muscle stronger, integrating the right level of security friction in the DevOps process strengthens the app by forcing critical thinking at the right time. This typically takes the form of considering how why and how an attacker may try to compromise an application during design creation and review and automatically identifying security vulnerabilities an attacker can exploit as the application is developed. 
  - **Unhealthy friction** – impedes more value than it protects. This often happens when security bugs generated by tools have a high false positive rate (e.g. false alarms) or when the security effort required to address items far exceeds the potential impact of an attack.
- **Commitment to shared goals** - Because security decisions often require difficult judgement calls that may spur conflicting opinions, it’s critical that all team members have a shared understanding of desired outcomes that combine and supersede individual preferences. This clarity of goals and shared accountability helps overcome natural conflicts between the individual legacy cultures. The shared goals of these teams should balance innovation/speed, minimizing security, and minimizing operational risk based on a shared understanding of Business Risk Appetite:

- **Business urgency** – the team should have a clear picture of revenue at stake. This should include current revenue (if service offline) and potential future that would be impacted by a delay in delivery of applications and/or features. This should be directly based on signals from leadership stakeholders.
- **Likely risks and threats** – based on threat intelligence team input (if present), the team should establish a sense of the likely threats that the application portfolio will face.
- **Availability requirements** – the team should have a shared sense of the operational requirements such as required uptime, expected lifetime of the application, and troubleshooting/maintenance requirements (e.g. patching while service online)  

>[!Note] Ideally these teams should collectively create these shared goals to maximize buy in, whether for the whole organization or for a particular project or application. 
>
> Additionally, senior leadership within the organization must formalize these cultural priorities, model the behavior, and continually reinforce the importance of innovation, reliability, and security. 

- **End to End approach** – As developers increasingly include open source components into applications, security strategy and controls must extend across the full software supply chain to ensure .  (position the OS component authors and cloud providers as de facto partners [you depend on these other to achieve your work outcomes] where you have to develop a different strategy than the stuff you manage directly)
- **Native Integration** – because the whole DevSecOps team will be accountable for rapid delivery of applications and features, security capabilities should be integrated natively into workflows to reduce unhealthy friction as much as possible. This can take the form of:
  - Tools are integrated natively into the automated CI/CD process
  - Developers have an equally important view of application quality and security as a quality metric. 
  - Developers and managers are able to assess the potential business impact of a security compromise on the application itself and the organization itself (on their own or in partnership with security and business teams
- **Continuous Improvement**
  - Security (and quality) bugs are steadily decreasing over time
  - Outside views are brought in to provide a sanity check on security periodically
- **Threat modelling** is done for every business critical application, during design and periodically as major changes are planned. Threat modelling enables the team to adopt the mindset of an attack and develop clarity on what security issues to address and which are most important. 
- **Process driven approach** – you can’t modify something that doesn’t exist. Structured repeatable process that enables consistent outcomes and continuous improvement because it doesn’t rely only on the expertise of specific individuals by capturing their knowledge into processes that sustains 80% of the value, can train new people easily, etc.

## Navigating the Journey

Transformation requires building towards this ideal state incrementally on a journey. Many organizations will have to navigate complexity and challenges on this journey, this section outlines some of the common ones that organizations face. 

- **Education and culture change are critical early steps** – “you go to war with the army you have” – the team you have will often need to develop new skills and adopt new perspectives to understand the other parts of the DevSecOps model. This education and culture change takes time, focus, executive sponsorship, and regular follow up to help individuals fully understand and fully see the value of / buy-in to the change. Changing cultures and skills this much can sometimes tap into professional identity of individuals, creating potential for strong resistance. It's critical to understand and articulate the why, what, and how of the change for each individual and their situation.
- **Change takes time** – You can only move as fast as your team can adapt to the implications of doing things in new ways. Teams will always have to perform their existing jobs while they transform, so it is critical to carefully prioritize what is most important and to manage expectations of how fast this change can happen. Focusing on a crawl, walk, run strategy where the most important and foundational elements come first will serve your organization well. 
- **Limited Resources** – An early challenge organizations usually face is to find funding and talent that is skills in both security and application development. As organizations begin to collaborate more effectively, they may find hidden talent such as developers with a security mindset or security professionals with a development background. 
- **Shifting nature of applications, code, and infrastructure** – The technical definition and composition of an “application” is fundamentally changing with the introduction of technologies like serverless, cloud services, cloud APIs, and codeless applications (such as Power Apps). This is changing development practices, application security, and even empowering non-developers to create applications.

### Tips on overcoming these challenges

So that’s a lot of challenges, now lets talk about the methods to overcome them. The DevSecOps teams should establish (and regularly refine) processes around
- bug bar for security and non-security bugs
- application evaluation processes	when to do these things and how deep to do them
- **Business impact** – of applications if it is compromised by attackers. This will help identify how much effort should be put into security efforts. This business impact should include
- Primary effects – of loss of CIA on the application or data (encompassing both direct loss of this applications’ data/functionality
- Secondary effects – if an attacker could access other applications and services in the environment by compromising this application (negatively impact stuff listed in above)
- Design Security - the methods to evaluate the security design and how much effort it will take to do things like threat modelling
- Implementation Security - the tools for generating security findings (and quality rating of them via false positive rate)

This clarity will naturally help identify and resolve tension between security and productivity goals as the team encounters decisions during daily workflows.

## Security in repositories

Typically, developers create, manage, and share their code in repositories such as GitHub or Azure DevOps Repos. This approach provides a central, version controlled library of code that can be collaborate on easily.
However, enabling a number of collaborators on a single codebase can also introduce the risk of changes being introduced. That risk can lead to vulnerabilities or the unintentional inclusion of credentials or tokens in commits.

To address this risk, development teams should evaluate and implement a repository scanning capability. Repository scanning tools perform static code analysis on source code within repositories and look for vulnerabilities or credentials and flag items found for remediation.

This capability acts to protect against human error and is a useful safeguard in distributed teams where a number of people are collaborating in the same repository.
The validation of code can happen both within the Integrated Development Environment (IDE), such as Visual Studio Code, or at the point of creating a pull request to merge code into a branch or repository.

## Security in pipelines

Many organizations use build and release pipelines (often referred to as Continuos Integration and Continuous Delivery or CI/CD) to automate and standardize the processes for building and deploying code.

This use of pipelines allows development teams to make iterative changes to sections of code quickly and at scale, without the need to spend large amounts of time redeploying or upgrading existing environments.
Using pipelines also enables teams to promote code from development environments, through testing environments and ultimately into production.

As part of this automation, development teams should include security tools that run scripted automated tests when code is deployed into testing environments. This can include tests such as unit testing the applications features to check for vulnerabilities or checking for public endpoints to ensure they are intentionally accessible.

## Security in environments

Alongside scanning and securing the code for applications, its important to ensure that the environments that applications are deployed into are also secure.
This is particular key for organizations moving at pace or innovating and potentially using new technologies or creating environments quickly for experimentation.

Azure has capabilities that enable organization's to create security standards from environments - such as Azure Policy that can be used to create policy sets that prevent the creation of certain workload types or configuration items such as public IP addresses.
These 'guardrails' enable teams to experiment within a safe and controlled environment, therefore balancing innovation and governance.

**Penetration testing** is a recommended practice for environments in order to check for any vulnerabilities in the infrastructure or application configuration that may create weaknesses that attackers could exploit.
There are a number of products and partners that provide penetration testing services and [Microsoft provides guidance on how to provide notification of penetration activities.](../azure/security/fundamentals/pen-testing.md)

Testing typical covers the following test types:

- Tests on your endpoints to uncover vulnerabilities
- Fuzz testing (finding program errors by supplying malformed input data) of your endpoints
- Port scanning of your endpoints

**Infrastructure scanning**

Azure includes monitoring and security capabilities designed to detect and alert on anomalous events or configurations that require investigation and potential remediation.

Technologies such as Azure Defender, Aure Security Center, and Sentinel are first party tools that natively integrate into the Azure environments being deployed.

These tools compliment the environment and code security tools to provide a broad reaching set of security monitoring to enable organizations to experiment and innovate, at pace, securely.

## Actionable intelligence

Taken together, the above tools and techniques can significantly contribute towards a holistic security model for organization's wishing to move at pace and experiment with new technologies that aim to drive innovation.

A key element of DevSecOps is data-driven, event-driven processes that enable the three functions to operate effectively in identifying, evaluating and responding to potential risks.

Many organizations choose to integrate these alerts and telemetry into their IT Service Management (ITSM) platform in order to bring the same structured workflow to security events that they use for other incidents are requests.

## Feedback loops

![Continuous Security model](./media/continuous-security.png)

All of these techniques and tools enable teams to find and flag risks and vulnerabilities that require investigation and potential resolution.
Operations teams who receive an alert, or discover a potential issue when investigating a support ticket, need a route back to the development team in order to flag items for review.
This feedback loop being a smooth collaboration is vital to issues being addressed quickly and the risk of a vulnerability being minimized as much as possible.

A common pattern for this feedback is to integrate it into the organization's developer work management system - such as Azure DevOps or Github - to link alerts or incidents to work items for developers to plan and action. This process provides an effective way for developers to resolve issues within their standard workflow, including development, testing and, release.