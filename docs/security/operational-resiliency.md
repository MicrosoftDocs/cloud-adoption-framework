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
# Business Resilience


An organization can never have perfect security, but it can become resilient to security attacks. Like we are never perfectly immune to all health and safety risks in the physical world, the data and information systems we operate are also never 100% safe from all attacks all the time. 

Security efforts should be focused primarily on increasing the resilience of business operations in the face of security incidents. This can meaningfully reduce risk and enable continuously improvements in security posture and ability to respond to incidents.  

Resilience requires taking a pragmatic view that assumes breach, and requires continuous investment across the full lifecycle of security risk:

:::image type="content" source="./media/security-resilience-cycle.png" alt-text="Security Resilience Cycle" lightbox="./media/security-resilience-cycle-popout.png":::

 - **Before an Incident** - Prior to an incident, the organization should continuously improve security posture and the organization’s ability to respond to an incident. This helps limit the likelihood and potential impact of a security incident on business operations and assets. There are many techniques here covered throughout the security disciplines, but all of them are designed to raise the cost of attack. Making the attackers have to develop and try new techniques because you have made their old reliable ones stop working raises their costs and friction, slowing them down and limiting their success. 

 - **During an Incident** - Business operations must continue during an incident, even if they are degraded, slower, or limited to only critical systems. During an attack, a hospital cannot stop caring for patients, ships must be able to load and unload cargo, government services that people depend on must be available, and planes must continue to fly safely. The two main priorities during an incident are
     - *Protect critical operations* – If at threat, all efforts should focus on protecting and sustaining critical business operations first over all other functions. 
     - *Prevent further damage* - The default first priority for security operations is always to discover the full extent of attacker access and rapidly evict them from the environment. This prevents further damage by the attackers, including retaliation actions. 

 - **After an incident** - If business operations are damaged during an attack, repairs must start immediately to restore full business operations (even if that means doing so without data that was lost in a destructive or ransomware attack. 
 - **Feedback Loop** - Attackers will repeat themselves, or repeat what other attackers have found to work. Just as they will continuously learn from attacking your organization, you must continuously learn from their attacks. Focus on taking the proven and available techniques that were attempted before and ensure you can block, detect, and rapidly respond and recover from them. This will continuously raise the cost of attack to your organization and deter or slow down future attacks. 

## Resilience Goals

Security resiliency is focused on supporting the resiliency of the business through:

1. **Enabling the business** to rapidly innovate and adapt to the ever changing business environment. Security should always be seeking safe ways to say "yes" to business innovation and technology adoption so that the organization is able to adapt to unexpected changes in the business environment like the sudden shift to working from home during COVID-19. 
1. **Limiting the impact** and likelihood of disruptions to business operations from active attacks (before, during, and after).

## Security Resilience and Assume Breach

Good security starts with assuming breach or assuming compromise, recognizing the essential truth that IT systems operate over the open internet where hostile criminals are continuously attacking organizations and sometimes succeed in compromising them. This assumption is a key principle of zero trust which drives healthy and pragmatic security behaviors, better preparing the organization to prevent attacks, limit their damage, and bounce back rapidly from them. 

[!Note] The principle assume breach doesn't assume that every compromise is a reportable event to regulators. The principle assumes that some level of security defenses have been breached or compromised, driving a focus on making the organization reslient through improvements to security posture and response processes. 

Assuming compromise should drive changes across people, process, and technology in your organization like education, exercises, and other incident preparation activities. See [Incident preparation](https://docs.microsoft.com/azure/cloud-adoption-framework/organize/cloud-security-incident-preparation) for more details.

Assuming compromise is a significant shift from the classic security mindset that assumed organizations could establish a perfectly safe network protected by a security perimeter (and restrict all valuable business activity to that network). While elements of this strategy provide value in a resilient enterprise, the overall assumption of a perfectly safe network didn't survive contact with the real world of mobile work and continuously evolving business models, technology platforms, and security threats.

Resiliency requires a close partnership between business stakeholders, information technology (IT) leaders and professionals, and security professionals. 

## Next Steps

The security disciplines in this methodology align to the goal of increasing resilience to security incidents.

 - Access Control
 - Security Operations
 - Asset Protection
 - Security Governance
 - Innovation Security
