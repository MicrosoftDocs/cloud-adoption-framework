---
title: Business resilience
description: Learn what your organization should do before, during, and after an attack to keep services and products online and available.
author: NaomiOooo
ms.author: naomio
ms.date: 04/04/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: secure
ms.custom: internal
---

# Business resilience

An organization can never have perfect security, but it can become resilient to security attacks. Like we are never perfectly immune to all health and safety risks in the physical world, the data and information systems we operate are also never 100 percent safe from all attacks all the time.

Focus your security efforts on increasing the resilience of business operations in the face of security incidents. These efforts can reduce risk and enable continuous improvements in security posture and your ability to respond to incidents.

Resilience requires taking a pragmatic view that assumes a breach. It needs continuous investment across the full lifecycle of security risk.

:::image type="content" source="./media/security-resilience-cycle.png" alt-text="Security Resilience Cycle" lightbox="./media/security-resilience-cycle-popout.png":::

- **Before an incident:** Continuously improve security posture and the organization's ability to respond to an incident. Continuously improving security posture helps limit the likelihood and potential impact of a security incident on your business operations and assets. There are many techniques covered throughout the security disciplines, but all of them are designed to raise the cost of attack. Make the attackers develop and try new techniques because you've made their old ones stop working. These techniques raise their costs and friction, slowing them down and limiting their success.

- **During an incident:** Business operations must continue during an incident, even if they're degraded, slower, or limited to only critical systems. During an attack, a hospital can't stop caring for patients, ships need to move cargo, and planes must continue to fly safely. The two main priorities during an incident are:
  - **Protect critical operations:** If threatened, all efforts should focus on protecting and sustaining critical business operations over all other functions.
  - **Prevent further damage:** The default priority for security operations is to discover the full extent of attacker access, and then rapidly evict them from the environment. This eviction prevents further damage by the attackers, including retaliation.

- **After an incident:** If business operations are damaged during an attack, repairs must start immediately to restore full business operations. These repairs apply even if that means restoring operations without data that was lost in an attack, for example ransomware or a destructive attack like NotPetya.
- **Feedback loop:** Attackers repeat themselves, or repeat what other attackers have found to work. Attackers learn from attacking your organization, so you must continuously learn from their attacks. Focus on taking the proven and available techniques that were attempted before. Then ensure you can block, detect, rapidly respond, and recover from them. Your efforts raise the cost of attack on your organization and deter or slow down future attacks.

## Resilience goals

Security resiliency is focused on supporting the resiliency of your business.

- **Enable your business** to rapidly innovate and adapt to the ever changing business environment. Security should always be seeking safe ways to say *yes* to business innovation and technology adoption. Your organization can then adapt to unexpected changes in the business environment, like the sudden shift to working from home during COVID-19.
- **Limit the impact** and likelihood of disruptions before, during, and after active attacks to business operations.

## Security resilience and assume breach

Good security starts with assuming breach or assuming compromise. Understand that information technology (IT) systems operate over the open internet where criminals are constantly attacking and compromising organizations. This assumption is a key principle of zero trust, which drives healthy and pragmatic security behaviors. Zero trust prepares your organization to prevent attacks, limit their damage, and quickly recover from them.

> [!NOTE]
> The *assume breach* principle doesn't assume that every compromise is a reportable event to regulators. The principle assumes that some level of security defenses have been breached or compromised. It then drives a focus on making the organization resilient through improvements to security posture and response processes.

Assuming compromise should drive changes across people, process, and technology in your organization. Education, exercises, and other incident preparation activities are good examples. For more information, see [Incident preparation](../organize/cloud-security-incident-preparation.md).

Assuming compromise is a significant shift from the classic security mindset. That mindset assumed organizations could establish a perfectly safe network protected by a security perimeter, restricting all valuable business activity to that network. Elements of this strategy provide value in a resilient enterprise. But the assumption of a perfectly safe network didn't in the world of mobile work and evolving business models, technology platforms, and security threats.

Resiliency requires a close partnership between business stakeholders, IT professionals and leaders, and security professionals.

## Next steps

The security disciplines in the Secure methodology align to the goal of increasing resilience to security incidents. For more information, see:

- [Access control](./access-control.md)
- [Security operations](./security-operations.md)
- [Asset protection](./asset-protection.md)
- [Security governance](./security-governance.md)
- [Innovation security](./innovation-security.md)
