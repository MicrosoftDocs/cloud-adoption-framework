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

Security governance monitors and sustains the application of best practices, policies, and standards over time. Governance ensures these are consistently applied across the full scope of assets and processes in your enterprise, helping ensure security and compliance posture improve consistently over time and doesn’t' regress. Governance also informs the risk management process of the organization based on it's monitoring the security and compliance posture of the organization. 

## Transformation to Active Governance

Hope (and reporting problems) is not a plan. Governance in the cloud age must have an active component that engages continuously with other teams.

In the on-premises world, security governance often followed the cadence of audits that were schedule months or years apart, but cloud technology now provides near-realtime visibility into the security posture and asset coverage. This often drives a major transformation of governance into a dynamic organization with closer relationships to other security teams to monitor security standards, provide guidance, and improve processes.

In it's ideal state, governance is the beating heart of continuous improvement, dynamically engaging across the organization to drive security posture of the organization forward. Governance should be continuously 
 - Monitoring the posture of the organization and guiding security and IT teams to address them
 - Researching and seeking new types of vulnerabilites (in partnership with threat intelligence teams if present) to identify the potential risk to the organization

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

