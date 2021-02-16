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
To be perfectly secure, a system must be perfectly inaccessable. As being inaccessable generally defeats the purpose of most systems, the conclusion we reach is that the security will not be perfect. It is not a question of *if* a breach will occur, but rather *when*. 

Originally, security was concerned with stopping attackers and idealizing a prevention-centric defense. If the installed firewalls, intrusion detection systems, and antivirus scanners returned "All clear" signals, it was assumed that the infrastructure was secure and uncompromised. However, reviewing the recent large data breaches, we have seen time and time again that attackers had often had access to the compromised systems for multiple months before being detected. These breaches resulted in hundreds of millions of pieces of Personally Identifiable Information (PII), credit card data, username/password combinations, and other data being stolen. In addition to losing consumer confidence, these companies were often fined millions of dollars by regulators for being unable to protect their customers' data. 

By adopting the "Assume Breach" mindset, the focus is shifted away from prevention-only methods. By increasing the security toolkit with options for detection, response, and recovery, combined with a properly implemented zero trust access model, the potential attack surface is limited to a singular, segmented, area. 


## Creating and Maintaining an incident response plan
In the event of a security incident, the general responsibility of a security operations team is to coordinate the activities of the Incident Response Plan, and verify that the affected system or systems has returned to an active and secured run state. Depending on the system, this may be a single step instruction to alert a specialist and request they take ownership of the issue, or it may be a multi-step, detailed, procedure to capture data and actively take steps to secure a system. 

Which approach is taken is dependent on the mission and purpose of the affected system. Creating an effective incident response plan (IRP) requires a deep understanding of not only the technical aspects of a system, but its overall value to the organization. 

### Understanding Impact - Risk Management meets Incident Response
Should losing a front-end web server hosting a company's main page to a distributed denial of service (DDoS) attack be treated as the same severity level as detecting unauthorized access to a e-commerce database? The answer will likely depend on the organization and specific importance placed on those services. The exercise of identifying, analyzing, and moderating risk through a risk management assessment assigns a value which is utilized when determining system impact severity during a security event. 

A risk assessment should be considered a prerequisite to creating a incident response plan. Understanding the value of a resource is a fundamental requirement before determining how to respond to a potential event. Many of the artifacts produced during the assessment can be reused during the creation of the incident response plan. 

As an example, during the process of determining the risk value for a particular application, a mapping of all resources utilized and utilized by the system might was created. That artifact will be used during the creation of the incident response plan as it lays out potential upstream and downstream pain points during an outage for that system. In most cases, very few systems or applications are truly standalone implementations with zero dependencies - understanding system interconnectivity is crucial to assigning proper a proper risk assessment and creating a incident response plan with the proper response urgency. 

Understanding all of the technical inter-connectivity exemplifies the need for the technical expert to weigh in during the risk assessment. 


## Response

After the creation of the incident response plan, the next question revolves around the personel responsible for carrying out the plan.

Response to an incident will vary from event to event - generally, the body responsible for the initial response is the Security Operations Center (SOC). In many organizations, the SOC may be integrated into the general operations center team; while in others, the SOC is a fully autonomous body. 

The detection of a security event along with initial analysis generally falls to the SOC for ownership. When an event occurs, the SOC follows a prescribed action plan - this should be the incident response plan created above. This plan may be as simple as verifying that a log in was authentic and notating the event as resolved. In more complex situations, the operations center may act as a coordinator between multiple stakeholders, with acting in hands-on-keyboard or communications facilitator capacities. In these more complex incident scenarios, the need for experts outside of the SOC often arises. 

In a large scale breach incident, the SOC will begin coordinating efforts with multiple subject matter experts (SMEs). A War Room may be created in order to coordinate efforts and consolidate communications to a single source of truth. Network experts, database experts, application owners, and other integrated systems owners will start the process to analyze available data and coordinate the recovery process. Leadership and management teams will continuously assess impact and risk and work with legal and compliance teams to determine notification requirements. During the analysis, specific individuals may also be tasked with gathering forensic data as part of the discovery process. These specialists are tasked with gathering evidence about the attacker and the processes that they used in order to breach the systems. As the event moves towards resolution, the systems are resecured and potential downstream and upstream systems are validated as impacted or non-impacted. Systems are re-secured, and updates, patches, and fixes are applied in order to fortify against similar attacks in the future. These fixes may be temporary until a more permanent solution is found, however it resolves the current issue at hand. The incident moves towards the closing and lessons-learned phase; not only concentrating on the technical aspects, but the incident response process as well. What went well? What information was needed sooner? Were all of the proper resources available to reach a conclusion in a timely manner? This input is recycled back into the maintenance cycle of managing the incidence response plan, evolving the plan in preparation for future events. 

Examples of creating and implementing an incident response team can be found in documentation such as the [NIST SP 800-61 Rev. 2 Computer Security Incident Handling Guide](https://csrc.nist.gov/publications/detail/sp/800-61/rev-2/final).
