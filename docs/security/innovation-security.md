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

Innovation is the lifeblood of an organization in the digital age needs to be both enabled and protected. Innovation security protects the processes and data of innovation against cyberattacks. Innovation in the digital age takes the form of developing applications using the DevOps or DevSecOps method to rapidly innovate without waiting for the traditional waterfall ship schedule that can take months or years between releases.

![DevSecOps Heart](./media/DevSecOpsHeart.png)

Developing new capabilities and applications requires successfully meeting three different requirement types:
 
 - **Business/Development (Dev)** - Your application must meet business and user needs (which are often rapidly evolving).
 - **Security (Sec)** - Your application must be resilient to attacks from rapidly evolving attackers and take advantage of innovations in security defenses.
 - **IT Operations (Ops)** - Your application must be reliable and perform well.

Merging these three requirements together and creating a shared culture is critically important, but often challenging. Leaders for development, IT, and security teams must work together to drive this change, see [The Leadership Imperative: Blend the Cultures](/#the-leadership-imperative-blend-the-cultures) later in this article for more details

## What is DevSecOps?

Technology innovation is frequently developed in the context of a rapid lean/agile development approach that combines development and operations together into a *DevOps* process. We have learned that integrating security into that process is critical to mitigate risk to the innovation process, the organization's growth, and the existing assets in the organizations. Integrating security into the process creates a ***DevSecOps*** process.

## Secure by design and shifting left

As organization adopt DevOps and other rapid innovation methodologies, security must be a thread woven throughout the tapestry of the organization and development processes. Integrating security late in the process is expensive and difficult to fix. 

You must shift security "left" in the timeline to integrate it into the envisioning, design, implementation, and operation of services and products. As development teams shift to DevOps and adopt cloud technologies, security must be a part of that transformation. 

:::image type="content" source="./media/waterfall-devops.png" alt-text="Security Throughout the Process" lightbox="./media/waterfall-devops.png":::

In the waterfall model, security was traditionally a "quality gate" after development finishes in a traditional waterfall approach.

DevOps expanded the traditional development model (people, process, and technology) to include operations teams and reduce friction having them separated. Similarly, DevSecOps expands DevOps to reduce the friction from separate or disparate security teams.  

DevSecOps is the integration of security into every stage of the DevOps lifecycle from idea inception through envisioning, architectural design, iterative application development and into operations. Teams must align simultaneously to goals of innovation speed, reliability, and security resilience. With mutual understanding and mutual respect for each other's needs, the teams will work on the most important issues first, regardless of source. 

[The Cloud Adoption Framework's Organize methodology provides some further context on DevSecOps structures in an organization](../organize/cloud-security-application-security-devsecops.md)

## Why DevSecOps?

DevOps brings agility, DevSecOps brings secure agility. 

As nearly every organization on the planet looks to software development to gain a competitive advantage through innovation, securing the devops process is critical to the success of the organization. Attackers have taken notice of this shift to custom applications are increasingly attacking custom applications during the course of their attacks. These new applications are also often rich sources of valuable intellectual property, containing valuable new ideas that haven't yet been commoditized by the marketplace.

Protecting this innovation requires that organizations address potential security weaknesses and attacks in both the development process and the infrastructure hosting the applications (whether cloud or on-premises)

:::image type="content" source="./media/attacker-opportunities.png" alt-text="Attacker Opportunities" lightbox="./media/attacker-opportunities.png":::

Attackers may exploit weaknesses in both

 - **Development Process** - Attackers may find weaknesses in the application design process (e.g. using weak or no encryption for communications), or in the implementation of of the design (e.g. code doesn't check input and allows common attacks like SQL injection). Additionally, attackers may implant backdoors in code that they later return to exploit in your environment or in your customer's environment. 
 - **IT Infrastructure** - Attackers can compromise endpoint and infrastructure elements that the development process is hosted on using standard attacks. Attackers may also conduct a multi-stage attacks that use stolen credentials or malware to access development infrastructure from other parts of the environment.   

Additionally, the risk of software supply chain attacks makes it critical to integrate security into your process for both

- **Protecting your organization** from malicious code and vulnerabilities in your source code supply chain
- **Protecting your customers** from any security issues in your applications and systems (which may result in reputational, liability, or other negative business impacts on your organization) 

## The DevSecOps journey

Most organizations are coming to find that DevOps or DevSecOps for any given workload or application is actually a two phase process where ideas are first incubated in a safe space and then later released to production and iteratively and continuously updated. 

This diagram depicts the lifecycle of this kind of innovation factory approach:

:::image type="content" source="./media/devsecops-overview.png" alt-text="DevSecOps Phases" lightbox="./media/devsecops-overview.png":::

Secure Innovation is an integrated approach for both of these phases:

 - **Idea Incubation** where an initial idea is built, validated, and made ready for initial production use. This phase begins with a new idea and phase ends when the **First Production Release** meets the minimum viable product (MVP) criteria for
     - *Development* - Functionality meets the minimum business requirements
     - *Security* - Capabilities meet the regulatory compliance, security, and safety requirements for production use
     - *Operations* - Functionality meets the minimum quality, performance, and supportability requirements to be a production system. 
 - **DevOperations** phase is the ongoing iterative development process of the application or workload that enables continuous innovation and improvement. 

### The leadership imperative: blend the cultures 

Meeting these three requirements requires merging these three cultures together to ensure that all team members value all types of requirements and work together to common goals (not working against each other's interests). 

Integrating these cultures and goals together into a true DevSecOps approach can be challenging, but is always worth the investment. Many organizations today experience a high level of unhealthy friction from Development, IT Operations, and Security teams working independently, creating issues with

 - Slow value delivery and low agility
 - Quality and performance issues
 - Security issues

While a small number of issues is normal and expected with new development, inter-team fighting often dramatically increases the number and severity of these issues. This is often because one or two teams have a political advantage and are repeatedly allowed to override requirements of other teams, allowing those neglected issues to grow in volume and seriousness. Left unsolved, this dynamic typically typically gets worse with DevOps as the speed of decisions increase to meet the rapid evolution of business needs and customer preferences.

Solving these problems requires creating a shared culture that values Dev, Sec, and Ops requirements that is supported by leadership. This approach will allow your teams to work better together and solve the most urgent issues on any given sprint, whether they are improving security, operational stability, or adding critical business features. 

#### Leadership techniques  

These key techniques can help leadership build a shared culture:

1. **Nobody wins all the arguments** - Leaders must ensure that no single mindset dominates all decisions, as this causes an imbalance that negatively impacts the business.
1. **Expect Continuous Improvement, Not Perfection** - Leaders should set an expectation of continuous improvement and continuous learning. Building a successful DevSecOps program doesn't happen overnight, it is a continuous journey with incremental progress
1. **Celebrate both common interests and unique individual value** – Ensure the teams can see that they are working toward common outcomes and each provide something the others cannot. All of requirements types are about creating and protecting the same business value. Development is trying to create the new value, while Ops and Security are trying to protect and preserve that value (against different risk scenarios). Leaders at all levels throughout the organization should communicate this commonality and how important it is to meet all types of requirements for both immediate and long term success. 
1. **Develop Shared Understanding** - Everyone on the team should have a basic understanding of
     - *Business urgency* – the team should have a clear picture of revenue at stake. This should include current revenue (if service offline) and potential future that would be impacted by a delay in delivery of applications and/or features. This should be directly based on signals from leadership stakeholders.
     - *Likely risks and threats* – based on threat intelligence team input (if present), the team should establish a sense of the likely threats that the application portfolio will face.
    - *Availability requirements* – the team should have a shared sense of the operational requirements such as required uptime, expected lifetime of the application, and troubleshooting/maintenance requirements (e.g. patching while service online)  
1. **Demonstrate and Model the desired behavior** - Leaders should publicly model the behavior that they want from the teams, showing humility and a focus on learning, showing how they value the other disciplines (e.g. development managers discussing value of security and high quality applications, security managers discussing the value of rapid innovation and application performance, and so on)
1. **Monitor the level of security friction** – Security naturally creates friction that slows down processes, it is critical for leaders to monitor the level and type of  friction that security generates:
      - **Healthy Friction** – just like exercise makes a muscle stronger, integrating the right level of security friction in the DevOps process strengthens the app by forcing critical thinking at the right time. If teams are learning and using those learnings to improve security (e.g. considering how why and how an attacker may try to compromise an application, finding and fixing important security bugs, etc.) then they are on track.  
      - **Unhealthy friction** – Look out for friction that impedes more value than it protects. This often happens when security bugs generated by tools have a high false positive rate (e.g. false alarms) or when the security effort to fix something exceeds the potential impact of an attack.
1. **Integrate Security Into Budget Planning** - Ensure that security budget is allocated proportional to other investments into security. This is analogous to a physical event like a concert where the event budget includes physical security as a norm. Some organizations allocate 10% of total cost for security as a general rule to ensure consistent application of security best practices. 

1. **Establish Shared Goals** - Ensure performance and success metrics for application workloads reflect development, security, and operations goals. 

>[!Note]
>Ideally these teams should collectively create these shared goals to maximize buy in, whether for the whole organization or for a particular project or application. 

### Identify the DevSecOps MVP

In the critical transition from an idea to production, it's critical to ensure that the capability meets the minimum requirements (often call the minimum viable product - MVP) for each requirement type:

- **Developers (Dev)** focus on representing the business needs for rapid delivery of capabilities that meet the expectations of users, customers, and business leaders. Identify the minimum requirements to ensure that the capability helps make the organization successful.  
- **Security (Sec)** brings focus to meeting compliance obligations and defending against the attackers that are continuously seeking illicit gain from the organization's resources. Identify the minimum requirements to meet regulatory compliance requirements, sustain security posture, and ensure security operations can rapidly detect and respond to an active attack. 
- **Operations (Ops)** focuses on performance, quality, and efficiency, ensuring that the workload can continue to deliver value over the long term. Identify the minimum requirements to ensure that the workload can perform and be supported without requiring massive architectural or design changes in the foreseeable future. 

The definitions for MVP can change over time and with different workload types as the team learns together from their own experience and from other organizations. 

### Integrate security natively in the process

Security requirements must focus on natively integrating to the existing process and tools. For example:
 - Design activities like threat modelling should be integrated into design phase
 - Security scanning tools should be integrated into the continuous integration / continuous deployment (CI/CD) systems like Azure DevOps, GitHub, and Jenkins
 - Security issues should be reported using the same bug tracking systems, prioritization scheme, etc. as any other bugs. 

Like with the MVP definition, the way that security is integrated into the process should be continuously improved as the teams learn. 

Security should ensure to mitigate risks to abuse anywhere in the end-to-end development processes, the final production service, and the underlying infrastructure.  

See [DevSecOps Technical Controls](./devsecops-controls.md) for more detailed guidance on DevSecOps

## Tips on navigating the journey

Transformation requires building towards this ideal state incrementally on a journey. Many organizations will have to navigate complexity and challenges on this journey, this section outlines some of the common ones that organizations face. 

- **Education and culture change are critical early steps** – “you go to war with the army you have” – the team you have will often need to develop new skills and adopt new perspectives to understand the other parts of the DevSecOps model. This education and culture change takes time, focus, executive sponsorship, and regular follow up to help individuals fully understand and fully see the value of / buy-in to the change. Changing cultures and skills this much can sometimes tap into professional identity of individuals, creating potential for strong resistance. It's critical to understand and articulate the why, what, and how of the change for each individual and their situation.
- **Change takes time** – You can only move as fast as your team can adapt to the implications of doing things in new ways. Teams will always have to perform their existing jobs while they transform, so it is critical to carefully prioritize what is most important and to manage expectations of how fast this change can happen. Focusing on a crawl, walk, run strategy where the most important and foundational elements come first will serve your organization well. 
- **Limited Resources** – An early challenge organizations usually face is to find funding and talent that is skills in both security and application development. As organizations begin to collaborate more effectively, they may find hidden talent such as developers with a security mindset or security professionals with a development background. 
- **Shifting nature of applications, code, and infrastructure** – The technical definition and composition of an “application” is fundamentally changing with the introduction of technologies like serverless, cloud services, cloud APIs, and codeless applications (such as Power Apps). This is changing development practices, application security, and even empowering non-developers to create applications.


>[!Note]
>Some implementations combine operations and security responsibilities into a **site reliability engineer (SRE)** role. 
>
>While fusing these responsibilities into a single role may be the ideal end-state for some organizations, this is often an extreme change from current enterprise practices, culture, tooling, and skillsets. 
>
> Even if you are targeting a SRE model, we recommend starting by embedding security into DevOps using practical quick wins and incremental progress outlined in this guidance to ensure you are getting good return on investment (ROI) and meeting immediate needs. This will incrementally add security responsibilities to your Operations (and Developer) personnel, which gets your people closer to the end-state of an SRE (if your organization wishes to adopt that model later).


## Next Steps

Review the [DevSecOps Technical Controls](./devsecops-controls.md) for more detailed guidance on DevSecOps

For information on how GitHub Advanced Security integrates security into your continuous integration and continuous delivery (CI/CD) pipelines, see [About GitHub Advanced Security](https://docs.github.com/en/github/getting-started-with-github/about-github-advanced-security)

For additional information and tooling on how Microsoft's IT organization implemented DevSecOps, see the [Secure DevOps Toolkit](https://azsk.azurewebsites.net/)
