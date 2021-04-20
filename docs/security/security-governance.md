---
title: Security Governance, Risk, and Compliance
description: Security description goes here
author: NaomiOooo
ms.author: brblanch
ms.date: 04/04/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: secure
ms.custom: internal
---

# Governance in Security

Security governance provides the bridge from business priorities to technical implementation with architecture, standards, and policy. Governance also provides oversight and monitoring to sustain and improve security posture over time and also reports compliance as required by regulatory authorities. 

***((INSERT PICTURE HERE))***

**Business goals and risk** provide the true north star for security, ensuring that security is focusing efforts on what matters to the organization and is informing the risk owners using familiar language and processes in the risk management framework

### Compliance and reporting

Compliance and reporting on external security requirements (and sometimes internal policy) are often basic required elements of operating in a given industry. The mandatory requirements are like feeding the bear in the zoo, if you don’t feed the bear every day, it may eat you. 

### Architecture and Standards

Architecture, Standards, and Policy provide the critical translation from business requirements and risk into the technical environment. We strongly recommend a unified view across your enterprise estate rather than splitting up cloud vs. on premises. Attackers don’t care about your internal processes and will attack any point in the organization and move laterally if that is the easiest path to their target. Most enterprises today are a hybrid environment that spans 
 - **On-premises** – including multiple generations of technology, often significant numbers of legacy software and hardware (and sometimes operational technology controlling physical systems with a potential life/safety impact).
 - **Clouds** – typically including multiple providers for
   - Software as a Service (SaaS) applications
   - Infrastructure and Platform as a Service (IaaS/PaaS) providers 

### Security Posture Management

Hope (and reporting problems) is not a plan. Governance in the cloud age must have an active component that engages continuously with other teams. Security posture management is a new/emerging function that represents a step forward in the long term convergence of security functions that answer the question “How secure is the environment?” (including vulnerability management and security compliance reporting)

In the on-premises world, security governance often followed the cadence of the data it could get about the environment, which may take a long time and be constantly out of date. Cloud technology now provides on demand visibility into the current security posture and asset coverage. This drives a major transformation of governance into a more dynamic organization with closer relationships to other security teams to monitor security standards, provide guidance, and improve processes.

In it's ideal state, governance is the beating heart of continuous improvement, dynamically engaging across the organization to drive security posture of the organization forward.

The key tenets of success for this are
 - **Continuous discovery of assets and asset types** - The cloud is a dynamic environment where new types of services are offered regularly and workload owners dynamically spin up and down instances of applications and services as needed. Governance teams need to perform continuously discovery to keep up with this pace of change. 
 - **Continuous improvement of asset security posture** -  Attackers are continuously evolving, defenses are continuously improving, and you can’t always get all the security in the initial configuration, so governance teams should focus on continuously improving standards and enforcement of them. 
 - **Policy Driven Governance** provides consistent execution by fixing something once in policy that is automatically applied at scale across resources. This limits wasted time/effort on repeated manual tasks and is often implemented using Azure Policy or 3rd party policy automation frameworks

## Security governance integration

In even a small company, the amount of data produced by security incidents can be overwhelming for a singular individual - therefore governance needs to be integrated into the Information Technology (IT) organization at every step - including most, if not all, roles. While specific individuals are empowered as security leads and given the authority to make point-in-time decisions when necessary, it is the duty of all individuals to be security-minded. 

The current environment is such that a zero-day exploit can be weaponized into a deployable attack less than a day after a vulnerability patch is released. IT organizations must be able to react quickly to new threats and adapt accordingly. The speed at which a system can be guarded against an attack is often a major factor in the successful negation of an attempted breach. 

In order to maintain this agility, best practices guidance is often iterative - digesting small pieces of information from multiple sources in order to create a complete picture and continuously make small adjustments.

Examples of the information provided by the operations, monitoring, workload owners, and other teams can include: attack incidents, potential business impact, comparison to current risk management standards, as well as validation that the systems are compliant with all current security requirements. Post-mortems from attack events often contain workaround and fix implementation intelligence. With this material, the governance team is able to determine whether a change in any of the current security policies is needed.

This not only ensures that the application of best practice standards has been consistently applied across the business, but also that these standards continue to remain relevant and evolve as time moves forward.

## Governance and Protection Disciplines

For the protection disciplines (Access Control, Asset Protection, and Innovation Security), the Security governance team provides standards and guidance to drive consistent execution of security best practices and controls. 

 In the ideal state, these protection teams then apply these and provide feedback on what is working, what challenges they have applying them, and the teams work together to identify the best solutions for them.  

## Governance and Security Operations

Security Governance and security operations together provide complete risk visibility in your enterprise and the mechanism to help ensure that the same incident type doesn't recur. 

Governance and security operations provide complementary types of visiblity:
. 
 - *Security operations* provides insight into the immediate risk of active attacks
 - *Security governance* provides the big picture/long view of risk from potential future attacks and attack vectors. 
 
The security architects within the governance function help identifying lessons learned from incidents (root cause of major incidents, trends, etc.) and capturing those into the organization's standards to ensure they are applied consistently across the enterprise (rather than as a one off correction or not at all).

The following diagram illustrates how this relationship mitigates risk from major incidents and vulnerabilities:

![Governance and Security Operations](./media/Governance-and-SecurityOps.png)

This full process should be followed for the highest impact vulnerabilities and incidents to ensure there are no active attackers (realized risk) and the door is closed for future attacker (potential risk). The full process isn't necessary for all severity levels of vulnerabilities and incidents, but illustrates how teams should work together:  

 - **Active Incident (Major)** - where attackers pose a significant risk to the organization
     - *Security Operations* responds to the threat by investigating and remediating the active attack. 
     - *Security Governance* identifies any vulnerabilities that the attacker exploited (either as a post mortem exercise or in realtime if warranted), ensures that a standard exists to mitigate the risk, and works with protection teams to ensure it is mitigated throughout the environment (including any closely related permutations)
 - **Major Vulnerability** - where an attacker could pose a significant risk to the organization via a vulnerability (software update, configuration error, insecure operational practice, etc.)
     - *Security Operations* proactively hunts for signs that an attacker has exploited the vulnerability
     - *Security Governance* ensures that a standard exists to mitigate the risk, and works with protection teams to ensure it is mitigated throughout the environment 


> [!Note] While some organizations may choose to put monitoring of security posture in security operations, we generally recommend having this in the governance to foster deeper empathy and relationships with the IT engineering and operations teams that have to apply the standards. This often results in higher quality communications and better security outcomes than a governance team that is completely abstracted completely away the real world impact of their standards. 
