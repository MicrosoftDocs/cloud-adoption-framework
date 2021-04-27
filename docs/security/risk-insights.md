---
title: Risk Management Insights
description: Integrate security insights into you risk management framework and digital initiatives
author: NaomiOooo
ms.author: naomio
ms.date: 04/04/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: secure
ms.custom: internal

---

# Risk Management Insights

Business inherently requires risk in order to capture opportunity. The role of security is to inform and advise decision makers (who already own other risks and benefits) on how security risks fit in those frameworks. The goal of security isn't to say "No. Don't take that risk." but to learn the business, apply their security expertise to identify risks to business objectives and assets, and advise those decision makers on the risks and which ones are recommended to accept or not (with the understanding that the final risk acceptance and accountability for consequences lies with the asset/process owner in the business).

> [!NOTE]
> This rule of thumb on who should be accountable for risk helps illustrate the natural ownership of risk:
>
>> The person who owns (and accepts) the risk is the one who will stand in front of the news cameras and explain to the world why the worst case scenario happened.

When mature, the objective of security, is to expose risks, mitigate risks, and empower business change with minimal risk. That level of maturity requires risk insights and deep security integration. At any maturity level of organization, the top security risks to the organization should appear on the organization's risk register and be actively managed down to an acceptable level like any other risk. 

## What is Cybersecurity Risk?

Cybersecurity risk is the damage or destruction of business assets, revenue, and reputation by hostile human attackers seeking illicit gains. 

While these risks happen in the technical environment, they often represent a risk to the organization and should be aligned to the risk measurement, tracking, and mitigations framework used by the organzation. While many organizations still treat cybersecurity risk as a technical problem to be 'solved', this perception is not accurate and does not mitigate the strategic business impact.

This diagram depicts the shift from a typical technically oriented program to a business framework

:::image type="content" source="./media/technical-to-business-transformation.png" alt-text="Risk Transformation" lightbox="./media/technical-to-business-transformation.png":::

Security leaders must step back from the technical lens, learn what assets and data are important to business leaders, and prioritize how teams spend their time, attention, and budget through the lens of business importance. The technical lens will be re-applied as the security and IT teams work through solutions, but looking at this only as a technology problem runs a high risk of solving the wrong problems.

## Process - Aligning Security Risk Management

You should continuously build a stronger bridge between cybersecurity and your organizational leadership, both in human relationships and explicity processes. The dynamic nature of security risk and the divergent dyanmics of business opportunities and security risk sources require ongoing investment into building and improving this relationship. 

A key ongoing process in this relationship is translating how business value maps to specific technical assets. Without this north star, security will not be sure what really matters to the organization and will only succeed at protecting the most important assets with lucky guesses. 
 
It's critical to get started on this journey if you haven't already, starting with developing a better understanding of the most sensitive and business critical assets in the organization. 

The typical process of starting this transformation is:

1. **Aligning the business** in a two-way relationship:
   - **Communicate in their language:** explain security threats in business-friendly language and terminology that helps to quantify the risk and impact to the overall business strategy and mission.
   - **Participate in active listening and learning:** talk to people across the business to understand the important business services and information and the impact if that were compromised or breached. This will provide clear insight into prioritizing the investment in policies, standards, training, and security controls.
2. **Translating learnings** about business priorities and risks into concrete and sustainable actions:
   - **Short term** focus on dealing with burning priorities:
     - Protecting critical assets and high-value information with appropriate security controls (that increases security while enabling business productivity)
     - Focus on immediate and emerging threats that are most likely to cause business impact.
     - Monitoring changes in business strategies and initiatives to stay in alignment.
   - **Long term** set direction and priorities to make steady progress over time, to improve overall security posture:
     - **Zero Trust:** Create a clear vision, strategy, plan, and architecture for reducing risks in your organization aligned to the [zero trust](https://aka.ms/zerotrust) principles of assuming breach, least privilege, and explicit verification. Adopting these principles shifts from static controls to more dynamic risk-based decisions that are based on real-time detections of anomalous behavior irrespective of where the threat derived.
     - **Burn down technical debt** as a consistent strategy by operating security best practices across the organization such as replacing password-based authentication with passwordless and multi-factor authentication (MFA), applying security patches, and retiring (or isolating) legacy systems. Just like paying off a mortgage, you need to make steady payments to realize the full benefit and value of your investments.
     - **Apply data classifications, sensitivity labels, and role-based access controls** to protect data from loss or compromise throughout its lifecycle. While these can’t completely capture the dynamic nature and richness of business context and insight, they are key enablers to guide information protection and governance, limiting the potential impact of an attack.
3. **Establishing a healthy [security culture](https://docs.microsoft.com/azure/cloud-adoption-framework/strategy/define-security-strategy#transformations-mindsets-and-expectations)** by explicitly practicing, communicating, and publicly modeling the right behavior. The culture should focus on open collaboration between business, IT, and security colleagues and applying a ‘growth mindset’ of continuous learning. Culture changes should be focused on removing siloes from security, IT, and the larger business organization to achieve greater knowledge sharing and resilience levels.

You can read more on Microsoft’s recommendations for [security strategy and culture here](https://aka.ms/securitystrategy).

## Understanding Cybersecurity Risk

Because cybersecurity risk is caused by hostile human attackers seeking illicit gains, it's important to understand the motivations and behavior patterns of these human attackers. 

### Motivations

The motivations and incentives for different types of attackers mirrors those of legitimate organizations:

:::image type="content" source="./media/attacker-motivations.png" alt-text="Risk Transformation" lightbox="./media/attacker-motivations.png":::

Understanding the motivation of attacker groups you face can better understand the likelihood and potential impact of different types of attacks. While the security strategies and most important technical controls will be similar across organizations, this context can help guide your security investment focus areas. 

For more information, see [Disrupting Attacker Return on Investment](https://docs.microsoft.com/security/ciso-workshop/ciso-workshop-module-2#part-1-disrupting-attacker-return-on-investment-1431) 

### Behavior Patterns

Organizations face a range of human attacker models that shape their behavior:

 - **Commodity** - The highest volume of threats organizations typically face are for-profit attackers driven by financial return on investment (ROI). These attackers typically use the cheapest and most effective available tools and methods, and the sophistication of these attacks (stealth, tooling, etc.) typically grows steadily new methods are proven by others and made available for high scale use. 
 - **Leading Edge** - Sophisticated attack groups are driven by long term mission outcomes and often have funding available to focus on innovation (e.g investing in supply chain attacks, changing tactics within an attack campaign to hinder detection and investigation, and other means to achieve stealth)

Typically, the attackers are:
 - **Flexible:** Utilize more than one attack vector to gain entry to the network.
 - **Objective driven:** Achieve a defined purpose from accessing your environment. This could be specific to your people, data, or applications, but you may also just fit a class of targets like “a profitable company that is likely to pay to restore access to their data and systems.”
 - **Stealthy:** Take precautions to remove evidence or obfuscate their tracks (though at different investment and priority levels, see figure one)
 - **Patient:** Take time to perform reconnaissance to understand the infrastructure and business environment.
 - **Well-resourced and skilled** in the technologies they are targeting (though the depth of skill can vary).
 - **Experienced:** They use established techniques and tools to gain elevated privileges to access or control different aspects of the estate (which grants them the privileges they need to fulfill their objective).

## Next Steps

In order for risk management to be effective, it must be integrated into all aspects of the governance and compliance activities of an organization. In order for risks to be properly assessed, security must always be considered as part of a comprehensive approach.

 - [Security Integration](./security-integration.md) is the next focus area of security. 
