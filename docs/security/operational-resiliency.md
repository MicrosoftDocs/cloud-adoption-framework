---
title: Operational Resiliency
description: Staying online and available, and recovering after an attack
author: NaomiOooo
ms.author: naomio
ms.date: 04/04/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: secure
ms.custom: internal

---
# Secure Operational Resiliency

Security can never be perfect, but it can effectively reduce risk. Like we are never perfectly immune to all health and safety risks in the physical world, the data and information systems we operate are also never perfectly safe. Taking a pragmatic view of the security threats we face can enable security to provide resiliency that allows the business to operate during an attack and rapidly recover full functionality after an attack. 

Good security starts with assuming compromise, recognizing the essential truth that IT systems operate over the open internet where hostile criminals are continuously attacking organizations and sometimes succeed in compromising them. This assumption is a key principle of zero trust which drives healthy and pragmatic security behaviors, better preparing the organization to prevent attacks, limit their damage, and bounce back rapidly from them. 

Assuming compromise is a significant shift from the classic security mindset that assumed organizations could establish a perfectly safe network protected by a security perimeter (and restrict all valuable business activity to that network). While elements of this strategy provide value in a resilient enterprise, the overall assumption of a perfectly safe network didn't survive contact with the real world of mobile work and continuously evolving business models, technology platforms, and security threats.

Resiliency requires a close partnership between business stakeholders, information technology (IT) leaders and professionals, and security professionals. 

## What are the goals of resiliency?

Security resiliency is focused on supporting the resiliency of the business through:

1. **enabling the business** to rapidly innovate and adapt to the ever changing business environment. Security should always be seeking safe ways to say "yes" to business innovation and technology adoption so that the organization is able to adapt to unexpected changes int eh business environment like the WFH of COVID-19. 
1. **limiting the impact** to the business from active attacks (through blocking them ahead of time, limiting their blast radius, and rapidly responding to contain the time of damage)
1. **ensuring rapid recovery** - from an attack (particularly major attacks) so that the business is able to return to full functionality as rapidly as possible. 


>**======================================================**


By adopting the "Assume Breach" mindset, the focus is shifted away from prevention-only methods. Risk of post-breach impact is reduced by increasing the security toolkit with proceses and technology focused specifically on recovery and resiliency. Teaming sound resiliency practices that include processes for risk management insights, security integration, and the disciplines of cloud security, reduces the potential attack surface limiting resiliency needs to singular, segmented, areas of impact. 

Business alignment around operational resiliencey requires the following commitments and processes to ensure rapid recovery from breach:

- Incident response plan
- Impact evaluation
- Rapid response

The following sections describe these processese in greater details. The security disciplines in this methodology will aid in implementing tools to automate or support these critical processes.

## Creating and Maintaining an incident response plan
In the event of a security incident, the general responsibility of a security operations team is to coordinate the activities of the Incident Response Plan, and verify that the affected system or systems has returned to an active and secured run state. Depending on the system, this may be a single step instruction to alert a specialist and request they take ownership of the issue, or it may be a multi-step, detailed, procedure to capture data and actively take steps to secure a system. 

Which approach is taken is dependent on the mission and purpose of the affected system. Creating an effective incident response plan (IRP) requires a deep understanding of not only the technical aspects of a system, but its overall value to the organization. 

### Understanding Impact - Risk Management meets Incident Response
Should losing a front-end web server hosting a company's main page to a distributed denial of service (DDoS) attack be treated as the same severity level as detecting unauthorized access to a e-commerce database? The answer will likely depend on the organization and specific importance placed on those services. The exercise of identifying, analyzing, and moderating risk through a risk management assessment assigns a value which is utilized when determining system impact severity during a security event. 

A risk assessment should be considered a prerequisite to creating a incident response plan. Understanding the value of a resource is a fundamental requirement before determining how to respond to a potential event. Many of the artifacts produced during the assessment can be reused during the creation of the incident response plan. 

As an example, during the process of determining the risk value for a particular application, a mapping of all resources utilized and utilized by the system might was created. That artifact will be used during the creation of the incident response plan as it lays out potential upstream and downstream pain points during an outage for that system. In most cases, very few systems or applications are truly standalone implementations with zero dependencies - understanding system interconnectivity is crucial to assigning proper a proper risk assessment and creating a incident response plan with the proper response urgency. 

Understanding all of the technical inter-connectivity exemplifies the need for the technical expert to weigh in during the risk assessment. 

## Rapid Response

After the creation of the incident response plan, the next question revolves around the personel responsible for carrying out the plan.

Response to an incident will vary from event to event - generally, the body responsible for the initial response is the Security Operations Center (SOC). In many organizations, the SOC may be integrated into the general operations center team; while in others, the SOC is a fully autonomous body. 

The detection of a security event along with initial analysis generally falls to the SOC for ownership. When an event occurs, the SOC follows a prescribed action plan - this should be the incident response plan created above. This plan may be as simple as verifying that a log in was authentic and notating the event as resolved. In more complex situations, the operations center may act as a coordinator between multiple stakeholders, with acting in hands-on-keyboard or communications facilitator capacities. In these more complex incident scenarios, the need for experts outside of the SOC often arises. 

In a large scale breach incident, the SOC will begin coordinating efforts with multiple subject matter experts (SMEs). A War Room may be created in order to coordinate efforts and consolidate communications to a single source of truth. Network experts, database experts, application owners, and other integrated systems owners will start the process to analyze available data and coordinate the recovery process. Leadership and management teams will continuously assess impact and risk and work with legal and compliance teams to determine notification requirements. During the analysis, specific individuals may also be tasked with gathering forensic data as part of the discovery process. These specialists are tasked with gathering evidence about the attacker and the processes that they used in order to breach the systems. As the event moves towards resolution, the systems are resecured and potential downstream and upstream systems are validated as impacted or non-impacted. Systems are re-secured, and updates, patches, and fixes are applied in order to fortify against similar attacks in the future. These fixes may be temporary until a more permanent solution is found, however it resolves the current issue at hand. The incident moves towards the closing and lessons-learned phase; not only concentrating on the technical aspects, but the incident response process as well. What went well? What information was needed sooner? Were all of the proper resources available to reach a conclusion in a timely manner? This input is recycled back into the maintenance cycle of managing the incidence response plan, evolving the plan in preparation for future events. 

Examples of creating and implementing an incident response team can be found in documentation such as the [NIST SP 800-61 Rev. 2 Computer Security Incident Handling Guide](https://csrc.nist.gov/publications/detail/sp/800-61/rev-2/final).
