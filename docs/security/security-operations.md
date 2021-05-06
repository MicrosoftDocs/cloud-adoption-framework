---
title: Security Operations
description: Best practice guidance for establishing a Security Operations function
author: DominicAllen
ms.author: doalle
ms.date: 04/04/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: secure
ms.custom: internal
---

# Security Operations

This article provides strategic guidance for leaders planning to establish or modernize a security operation function. For architecture and technology focused best practices, see https://aka.ms/secopstech

Security Operations reduces organizational risk by limiting damage from attackers who have gained access to the organization's resources. Security operations focuses on reducing the time attackers have access by detecting, responding to, and helping recover from active attacks.

Rapid response and recovery protects the organization by damaging the adversary's return on investment (ROI). When adversaries are evicted and forced to start a new attack, their cost to attack your organization goes up.

Security Operations (SecOps) is sometimes referred to or structured as a Security Operations Center (SOC). [Security posture management](./security-governance.md#security-posture-management) of the operational environment is a function of governance discipline. Security of the DevOps process is part of the [innovation security](innovation-security.md) discipline

## People and Process

While Security Operations can be highly technical, it is first and foremost a human discipline. People are the most valuable asset in security operations — their experience, skill, insight, creativity, and resourcefulness are what makes the discipline effective. 

Attacks on an organization are also planned and conducted motivated by people (criminals, spies, hacktivists, etc.). While some commodity attacks are fully automated, the most damaging ones are often perpetrated by live human attack operators. 

**Focus on empowering (not replacing) people** - Your goal should not be to replace people with automation, but to empower your people with tools that simplify their daily workflows and enable them to keep up with or get ahead of the human adversaries they face. 
 
Rapidly sorting out  signal (real detections) from the noise (false positives) requires investing in both humans and automation. Automation and technology can reduce human toil, but ultimately attackers are human and human judgement is critical to the process for defeating them.

**Diversify your thinking portfolio** - While security operations is highly technical, it is also just another new version of forensic investigation that shows up in many career fields like criminal justice. Don't be afraid to hire people with a strong competency in investigation or deductive/inductive reasons and train them on technology. 

You can increase productivity and employee enjoyment of their jobs by ensuring people are set up with a healthy culture and are  measuring the right outcomes.

### SecOps Culture

:::image type="content" source="./media/secops-people-culture.png" alt-text="Security Operations - People Centric" lightbox="./media/secops-people-culture.png":::

Key cultural elements to focus on include:

- **Mission Alignment** - Because of how challenging this work is, security operations should always have a clear understanding of how their work connects to the overall organization's mission and goals.  
- **Continuous Learning** - Security Operations is highly detailed work and always changing because attackers are creative and persistent. Because of this, it's critical to continuously learn and continuously work to automate highly repetitive or highly manual tasks (which can quickly wear down morale and team effectiveness). Ensure the culture rewards learning and finding and fixing these pain points. 
 - **Teamwork** - We’ve learned that the “lone hero” doesn't work in security operations, nobody is as smart as the whole team together. Teamwork also makes a high-pressure working environment much more fun, enjoyable, and productive. It's important that everyone has each other’s back and share insights, coordinate and check each other’s work, and constantly learn from each other.

### SecOps Metrics

:::image type="content" source="./media/secops-people-metrics.png" alt-text="Security Operations - People Centric" lightbox="./media/secops-people-metrics.png":::

Because metrics drive behavior, measuring success is a critical element to get right. Metrics translate culture into clear measurable objectives that drive outcomes. 

We’ve learned that it’s critical to consider both what you measure, as well as the way that you focus on and enforce those metrics. You must recognize that security operations must manage significant variables that are out of their direct control (attacks, attackers, etc.). Any deviations from targets should be viewed primarily as a learning opportunity for process or tool improvement rather assumed to be a failing on the part of the SOC to meet a goal.

Two main metrics to focus on that have a direct influence on organizational risk are:

 - **Mean Time to acknowledge (MTTA)** — Responsiveness is one of the few elements SecOps has a lot of direct control over. Measure the time between an alert being raised (“light starts to blink”) and when an analyst acknowledges that alert and begins the investigation. Improving this responsiveness requires that analysts don’t waste time investigating false positives while another true positive alert sits waiting. This can be achieved with ruthless prioritization, ensuring that any alert feed that requires an analyst response must have a track record of 90 percent true positive detections. 
 - **Mean Time to remediate (MTTR)** — Effectiveness of reducing risk is measured by the next period of time, from the time the analyst begins the investigation to when the incident is remediated. This identifies how long it takes SecOps to remove the attacker's access from the environment. This information helps identify where to invest in processes and tools to help analysts reduce risk. 
 - *Incidents remediated (manually/with automation)* — Measuring how many incidents are remediated manually and how many are resolved with automation is another key way to inform staffing and tool decisions. 
 - *Escalations between each tier* — tracking how many incidents escalated between tiers helps ensure accurately tracking of the workload to inform staffing and other decisions (e.g. work done on escalated incidents isn't attributed to the wrong team)

## Security Operations Model

Security Operations handles a combination of high volume incidents and high complexity incidents.

:::image type="content" source="./media/secops-model.png" alt-text="Security Operations - Model" lightbox="./media/secops-model-popout.png":::

Security operations teams often focus on three key outcomes:

- **Incident Management -** Manage active attacks on the environment, including both
    - *Reactively respond* to detected attacks
    - *Proactively hunting* for attacks that slipped through traditional threat detections
    - *Coordinating* the legal, communications, and other business implications of security incidents. 
- **Incident Preparation -** Help the organization prepare for future attacks. This a broader strategic set of activities aimed at building muscle memory and context at all levels of the organization, preparing people to better handle major attacks as well as gain insights on security process improvements. 
- **Threat Intelligence -** Gathering, processing, and disseminating threat intelligence to security operations, security teams, security leadership, and business leadership stakeholders (via security leadership).  

In order to deliver against these outcomes, Security Operations teams should be structured to focus on key outcomes. In larger SecOps teams, these are often broken into sub-teams: 

- **Triage** (Tier 1)
the first line of response for security incidents, focussed on high-volume processing of alerts, typically generated by automation and tools. The triage processes will solve for the majority of common incident types and resolve them within the team. More complex incidents, or those that have not been seen and resolved before should be escalated to Tier 2.
- **Investigation** (Tier 2)
focussed on incidents that require further investigation - often requiring correlation of data points from multiple sources. The investigation tier looks to provide repeatable solutions to issues escalated to them, in order to enable Tier 1 to resolve subsequent reoccurance of that issue type. Tier 2 will also respond to alerts against business critical systems, to reflect the severity of the risk and the need to act quickly.
- **Hunt** (Tier 3)
focussed primarily on proactive hunting for highly-sophisticated attack processes and developing guidance to the wider teams for maturing security controls as a result. The Tier 3 team also acts as an escalation point for major incidents in order to support forensic analysis and response. 

## SecOps Business touchpoints

SecOps has multiple potential interactions with business leadership

:::image type="content" source="./media/secops-business.png" alt-text="Security Operations - Business Relationships" lightbox="./media/secops-business-popout.png":::


 - **Business context (to SecOps)** — SecOps needs to understand what is most important to the organization so the team can apply that context to fluid real-time security situations. What would have the most negative impact on the business? Downtime of critical systems? A loss of reputation and customer trust? Disclosure of sensitive data? Tampering with critical data or systems? We’ve learned it’s critical that key leaders and staff in the SOC understand this context as they wade through the continuous flood of information and triage incidents and prioritize their time, attention, and effort.
 - **Joint practice exercises (with SecOps)** — Business leaders should regularly join SecOps in practicing response to major incidents. This builds the muscle memory and relationships that are critical to fast and effective decision making in the high pressure of real incidents, reducing organizational risk. This practice also reduces risk by exposing gaps and assumptions in the process that can be fixed prior to a real incident.
 - **Major incidents updates (from SecOps)** — SecOps should provide updates to business stakeholders for major incidents as they happen. This allows business leaders to understand their risk and take both proactive and reactive steps to manage that risk. For more learnings on major incidents by Microsoft's DART team, see the [incident response reference guide](https://aka.ms/IRRG).
 - **Business intelligence (from the SOC)** — Sometimes SecOps finds that adversaries are targeting a system or data set that isn’t expected. As these discoveries are made, the threat intelligence team should share these signals with business leaders as they may trigger insight for business leaders (e.g. someone outside the company is aware of a secret project, unexpected attacker targets highlight the value of an otherwise overlooked dataset, etc.).


## SecOps Modernization

Just like other security disciplines, security operations faces the transformative effect of continuously evolving business models, attackers, and technology platforms. 

The transformation of security operations is driven primarily by these trends:

 - **Cloud Platform Coverage** - Security operations must detect and respond to attacks across the enterprise estate including cloud resources, a new and rapidly evolving platform that is often unfamilliar to SecOps professionals
 - **Shift to Identity Centric Security** - traditional SecOps relies heavily on network based tools, but now must integrate identity, endpoint, application, and other tools and skills. This is because 
     - Attackers have incorporated identity attacks (phishing, credential theft, password spray) and other attack types into their arsenal that reliably evade network based detections. 
     - Assets of value (such as bring your own devices - BYODs) spend some or all of their lifecycle outside the network perimeter, limiting the utility of network detections. 
 - **IoT and OT Coverage** - Adversary actively target Internet of Things (IoT) and Operational Technology (OT) devices as part of their attack chains. These may be the ultimate purpose of an attack or a means to access or traverse the environment. 
 - **Cloud Processing of Telemetry** - Security operations modernization is required because because of the massive increase in relevant telemetry that comes from the cloud. This is difficult or impossible to process with on-premises resources and classic techniques, driving SecOps to embrace cloud services that provide massive scale analytics, machine learning (ML), and behavior analytics. These technologies help extract the value rapidly to meet the time sensitive needs of security operations. 

It's important to invest in updated SecOps tools and training to ensure security operations can meet these challenges. For resources and guidance on this, see [Update incident response processes for cloud](https://docs.microsoft.com/azure/cloud-adoption-framework/security/security-top-10#4-process-update-incident-response-processes-for-cloud)

For more information on Security Operations role/responsibilities, see [Security Operations](https://docs.microsoft.com/azure/cloud-adoption-framework/organize/cloud-security-operations-center)

For more architecture and technology focused best practices, see  https://aka.ms/secopstech (and [accompanying videos/slides](https://docs.microsoft.com/security/compass/security-operations-videos-and-decks))

## Next Steps

The next discipline is [Asset Protection](./asset-protection.md)
