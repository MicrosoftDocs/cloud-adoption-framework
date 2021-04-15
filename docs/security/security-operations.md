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

This article provides guidance for organizations planning to establish or modernize a security operation function.

## Context

Security operations works closely with posture management that mitigates potential risks and vulnerabilities to the organization, but it focused on the realized risk of active attackers that currently have access to organizational assets.

Like all security disciplines, security operations. requires a healthy collaborative relationship with IT operations, security governance functions that ensure standards and changes are consistently applied.

Security operations is currently undergoing significant modernization at all levels with the advent of cloud technologies, adversary targeting of IoT and OT resources, and the zero trust transformation of security to a multi-layer discipline (vs. a network centric strategy). This modernization of security operations is becoming urgent because of the massive increase in relevant telemetry (which is hard to process with classic techniques), the availability of cloud services to provide analytics such as machine learning (ML) and behavior analytics, and the time sensitive nature of the security operations mission.

Today, there are two commonly observed patterns for how organizations structure their security functions:

- **IT-driven security** - often within an IT organization, and focussed primarily on reactively responding to threat detections and resolving security incidents. In this structure, security is often defined within the IT organization and builds processes and architectures based on the outcome of securing the infrastructure that runs the business operations.

- **Business-driven security** - in this pattern, IT security is a mechanism for contributing to a broader concept of security within a business. The definition of what needs to be secured and the risk appetite is driven from stakeholders outside of IT and considered in a broader context of what is valuable to the business.
Securing infrastructure and applications is often part of the approach, rather than the success criteria itself, in this model.  

## People and Process

People are the most valuable asset in the SOC—their experience, skill, insight, creativity, and resourcefulness are what makes our SOC effective. By ensuring that people are set up with what they need to succeed and stay engaged, and improving processes, it's possible to decrease the time it takes to train people up and increase employee enjoyment of their jobs.

Empower humans with automation.
Rapidly sorting out  signal (real detections) from the noise (false positives) in the SOC requires investing in both humans and automation. Automation and technology can reduce human toil, but ultimately attackers are human and human judgement is critical to the process for defeating them.

Automation is not necessarily about using efficiency to remove humans from the process—it is about empowering humans. We continuously think about how we can automate repetitive tasks from the analyst’s job, so they can focus on the complex problems that people are uniquely able to solve.

Automation empowers humans to do more in the SOC by increasing response speed and capturing human expertise. The toil our staff experiences comes mostly from repetitive tasks and repetitive tasks come from either attackers or defenders doing the same things over and over. Repetitive tasks are ideal candidates for automation.

We also found that we need to constantly refine the automation because attackers are creative and persistent, constantly innovating to avoid detections and preventive controls. When an effective attack method is identified (like phishing), they exploit it until it stops working. But they also continually innovate new tactics to evade defenses introduced by the cybersecurity community. Given the profit potential of attacks, we expect the challenges of evolving attacks to continue for the foreseeable future.

When repetitive and boring work is automated, analysts can apply more of their creative minds and energy to solving the new problems that attackers present to them and proactively hunting for attackers that got past the first lines of defense. 

Security tools are only as good as the processes that surround them, so it is crucial that organizations design and run a well-structured security operations function to keep the organization safe.

Recent history has repeatedly shown the importance of maintaining a clear watch over the infrastructure and systems within an organization. The very real risk of unauthorized data access or exfiltration, rogue actors affecting production systems or deploying malware that disrupts the business' day to day operations should be top of mind for any company executives.
It is almost impossible to prevent a break in at a house if no one is checking that the doors and windows are shut and locked.

Organizations are becoming hyper-aware of the need to ensure that there are strong processes in place to ensure that the metaphorical doors and windows of their environments are shut and locked, and - when a window is left open - there is a process in place to close it and ensure it stays closed.

## SOC teams and tiers model

![Security Operations teams and tiers diagram](./media/secops-functions.png)

Security operations teams focus on three key outcomes:

- **Incident Management -** Reactively respond to detected attacks, proactively hunting for undetected attacks, and coordinating the legal, communications, and other business implications of security incidents. This is often delivered through teams referred to as a SOC.
- **Incident Preparation -** Helping the organization prepare for future attacks, which is a broader strategic set of activities aimed at building context and muscle memory to better handle attacks as well as develop insights on how to improve security processes overall.
- **Threat Intelligence -** Gathering, processing, and disseminating threat intelligence to security operations, security teams, security leadership, and business leadership stakeholders (via security leadership).  

In order to deliver against these outcomes, Security Operations functions should structure their teams into tiered capabilities, each with a specific focus: 

- **Triage** (Tier 1)
the first line of response for security incidents, focussed on high-volume processing of alerts, typically generated by automation and tools. The triage processes will solve for the majority of common incident types and resolve them within the team. More complex incidents, or those that have not been seen and resolved before should be escalated to Tier 2.
- **Investigation** (Tier 2)
focussed on incidents that require further investigation - often requiring correlation of data points from multiple sources. The investigation tier looks to provide repeatable solutions to issues escalated to them, in order to enable Tier 1 to resolve subsequent reoccurance of that issue type. Tier 2 will also respond to alerts against business critical systems, to reflect the severity of the risk and the need to act quickly.
- **Hunt** (Tier 3)
focussed primarily on proactive hunting for highly-sophisticated attack processes and developing guidance to the wider teams for maturing security controls as a result. The Tier 3 team also acts as an escalation point for major incidents in order to support forensic analysis and response. 

## Security Operations nomenclature disambiguation

A wide array of names are used to describe security operations within organization and the role definition and duties within that team can differ from organization to organization. Most of the variations we see are with security operations taking on some or all aspects of posture management (defined in greater detail in the [Azure Security Center Planning and Operations Guide](https://docs.microsoft.com/en-us/azure/security-center/security-center-planning-and-operations-guide), given the need for operational urgency to address software vulnerabilities and the use of security operations data to prioritize preventive controls and policy enforcement.

Rather than merge these two functions (which is a valid configuration) we chose to differentiate between these two while emphasizing the need for their integration (whether part of the same team or separate teams).

## Operations within a security strategy

### Security strategy connections

The Security Operations function should deliver on the requirements set out in the organization's security strategy.
Risk priorities and responsibilities defined in the strategy should be reflected in the day-to-day operations of the security operations.

Guidance as part of the Cloud Adoption Framework's Strategy methodology outlines how to define the organization security strategy:

[Define a security strategy - Cloud Adoption Framework | Microsoft Docs](https://docs.microsoft.com/azure/cloud-adoption-framework/strategy/define-security-strategy)

### Managing a security program

Delivering security controls inside an organization without business stakeholder engagement runs the risk of being seen as a blocker.
Work with the business to establish a basis of understanding that security can be an enabler for innovation and growth, as opposed to a group that always says 'no'. Engaging in discussion with the business to agree how the security strategy can be delivered without compromising technical delivery or creativity.
The resulting set of controls are often referred to as 'guard rails', which are technical boundaries, defined by policy. Enabling flexibility to a point but stops inadvertent increase in security risk or deviation from company policy. [Azure Security Center](https://docs.microsoft.com/en-us/azure/security-center/security-center-introduction) provides centralized definition and control of [Security Policies](https://docs.microsoft.com/en-us/azure/security-center/security-policy-concept) across all your Azure subscriptions

The boundaries defined in the guard rails become the baseline. From this baseline, the security operations team can find and investigate deviations. This may result in a defect or issue being identified that requires resolution or - equally - it could find a use case where the boundary needs reviewing and potentially revising to maintain the balance between business function and security control.

### Building a modern SOC

In a world of hyper-scale distributed compute, the ability to collate, analyze, and respond to events and telemetry at scale is crucially important.
It is not economically (or practically) viable to scale the number of people in a security operations function in direct correlation to the number of workloads managed. Technology must be used to scale the management to meet the demand.
In practical terms, scale requires centralization of telemetry. Bring all of the organization's security signals into a consolidated data set.
This data can be filtered, modelled, and have business logic applied to it in order to find the events and activities that require intervention - automated or human.

Security Information and Event Management (SIEM) tools can help address this goal. Many are designed to ingest telemetry from a wide range of sources - identity platforms, network monitors, applications, device management tools. [Azure Sentinel](https://docs.microsoft.com/en-us/azure/sentinel/overview) is Microsoft's  cloud-native, security information event management (SIEM) and security orchestration automated response (SOAR) solution for alert detection, threat visibility, proactive hunting, and threat response.

## Processes required to 'assume breach'

### Holistic monitoring

Every data point related to an environment helps build a better picture of the activities and anomalies - either by confirming a common behavior or being an antipattern to it.
As a result, security operations teams should seek to ingest as many relevant data feeds as possible in order to develop the most articulate view of activities as possible. This context will prove useful - not only in spotting an anomalous event - but also in responding to the event and determining potential impact and scale.

### Proactive testing and recovery

Assume breach. Assume that the environment is already compromised and approach testing as if you were looking for an attacker.

### Recovering and re-securing

Even with the best processes and technologies in place, there will be bugs or incidents that require resolution. The impact of the incident is influenced by how teams respond and rectify the issue - and learn from it to ensure it cannot happen again.

## Integration with other security teams

![Modern Security Operations diagram](./media/modern-security-operations.png)

- **DevSecOps teams** - note the split expertise and that you need to build a process that leverages joinly how this works
Most of the time, teams have to lean heavily on multiple security teams in partnership to handle security. 
    Skillsets to blend:
    - Security Operations - familiarity with handling security incidents, notification to broad business stakeholders (legal, comms, etc.) in case of a major incident
    - DevOps/DevSecOps- familiarity with the application itself, the value of the data, and the implications to the business if it is offline 

    - Incident types. Active attack always brings in the SOC. Affected app teams are always brought in, but not always at the same level. 
        - App-agnostic - Most security alerts come from SOC (infrastructure alerts, etc.). 
        In this case SOC probably leads and application team assists, provides impact analysis on "did they abuse the app/data, what is the business impact, can we reboot/rebuild/etc. the server/vm, etc."
        - App Specific - Sometimes DevOps/DevSecOps teams see security activity as part of monitoring the application (rare)
        
    If the app is actually deliberately targeted, then the teams need to work closely together to blend the expertise to understand what happened to the app, what the attackers may have ben after, what they actually did and got, etc.
    - Planning controls - requires joint effort to ensure basic/common infra (vms, containers, etc.) have best practices for security (preventive and detective controls). Ideally, app teams have threat modelled and build specific detections/preventions for abuse of the app itself. 

		The most uncomfortable phase in this transition is when teams accept the importance of security, but don't have native teams in the dev(sec)ops process. Before this, teams will try to resist security, after this its easier to integrate security knowledge rather than rely on external teams. 
			Critical to sell them on incremental view of security so they don't feel like they have to be perfect right away (default security communications style / assumption). 
		
		
- **Governance** - provides standards and business rules for the security operations teams to work to. Governance is a key partner in delivering successful security operations, as they provide the criteria for business risk and the controls that need to be monitored.
- **Access Control** - provides identity and network infrastructure to protect the perimeter of the environment. These boundaries are a key definition of where the response starts when breach alerts are raised. 
- **Asset protection** - provide infrastructure and network level encryption to protect data at rest (basic corp standard, not tailored to elevated sensitivity of applications), information protection assistance (e.g. Microsoft Information Protection and Azure Purview). 