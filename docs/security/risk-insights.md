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

Business inherently deal with risk at all levels and security's role is to inform and advise the owners of the risk how how security risks fit in those frameworks. The goal of security isn't to say "No. Don't take that risk." but to learn the business, apply their security expertise to identify risks to business objectives and assets, and advise those decision makers on the risks. Once risks are identified they should be well documented and explained to the risk owners the potential outcome of not handling them in some fashion. Businesses can choose to ignore (not recommended), accept, mitigate, transfer, or defer risk. Security should be providing an overall recommendation on what the business could do (with the understanding that the final risk acceptance and accountability and what consequences lies with the asset/process owner in the business).

> [!NOTE]
> This rule of thumb on who should be accountable for risk helps illustrate the natural ownership of risk:
>
>>The person who owns (and accepts) the risk is the one who will stand in front of the news cameras and explain to the world why the worst case scenario happened. The issue is that while this is true often times risks do not make it to this level of an organization for review. It is important to gain the highest level of coordination and visibility for organizational risks so leadership is aware and knows what is happening in their risk management program. Often times there is also a board level member who is responsible for oversight of risk and should be at a minimum briefed regularly on risk exposure and mitigation plans. 

When mature, the objective of security, is to expose risks, mitigate risks, and empower business change with minimal risk. That level of maturity requires risk insights and deep security integration. At any maturity level of organization, the top security risks to the organization should appear on the organization's risk register and be actively managed down to an acceptable level like any other risk. 

## What is Cybersecurity Risk?

Cybersecurity risk is the exposure/potential for damage or destruction of business assets, revenue, and reputation by hostile human attackers seeking illicit gains. 

While these risks happen in the technical environment, they often represent a risk to the organization and should be aligned to the risk measurement, tracking, and mitigations framework used by the organzation. While many organizations still treat cybersecurity risk as a technical problem to be 'solved', this perception is not accurate and does not mitigate the strategic business impact.

This diagram depicts the shift from a typical technically oriented program to a business framework

(DIAGRAM from https://www.microsoft.com/security/blog/2021/02/24/becoming-resilient-by-understanding-cybersecurity-risks-part-3-a-security-pros-perspective/)

Security leaders must step back from the technical lens, learn what assets and data are important to business leaders, and prioritize how teams spend their time, attention, and budget through the lens of business importance. The technical lens will be re-applied as the security and IT teams work through solutions, but looking at this only as a technology problem runs a high risk of solving the wrong problems. Businesses are living in a new world where their data is no longer sitting in on premises data centers but sitting at a cloud provider or within a software as a service provider who inherently also sits within a cloud provider. This expands the apperture even further so security leaders need to focus on risk to data and software regardless of where it sits in the world. 

## Process - Aligning Security Risk Management

You should continuously build a stronger bridge between cybersecurity and your organizational leadership, both in human relationships and explicity processes. The dynamic nature of security risk and the divergent dyanmics of business opportunities and security risk sources require ongoing investment into building and improving this relationship. Risk registry was mentioned earlier and is often overlooked by businesses at all levels. There should be a clear owner of this registry in the organization and a risk "committee" with cross company representation represented. Having executive level sponsorship is also key and should not be overlooked. 

A key ongoing process in this relationship is translating how business value maps to specific technical assets. Without this north star, security will not be sure what really matters to the organization and will only succeed at protecting the most important assets with lucky guesses. 
 
It's critical to get started on this journey if you haven't already, starting with developing a better understanding of the most sensitive and business critical assets in the organization. This doesn't have to be a "paper drill" but something that can be done with technology. Todays networks can be mapped with technology and data can be identified, labeled, and placed wherever it is required. The system over time can help an organization identify what is sensitive and what is business critical. 

The typical process of starting this transformation is:

1. **Aligning the business** in a two-way relationship:
   - **Communicate in their language:** explain security threats in business-friendly language and terminology that helps to quantify the risk and impact to the overall business strategy and mission. Use clear risk terms they understand like "this risk was identified and then measured using the standard equation of type of threat x type of vulnerability x rate of potential occurance". This will show them likelyhood of occurance and the organization can start to put a quantitative measurement on what the impact will be. Higher threats with potential for regular occurance could cost more and therefore be higher up on the registry. 
   - **Participate in active listening and learning:** talk to people across the business to understand the important business services and information and the impact if that were compromised or breached. This will provide clear insight into prioritizing the investment in policies, standards, training, and security controls.
2. **Translating learnings** about business priorities and risks into concrete and sustainable actions:
   - **Short term** focus on dealing with burning priorities:
     - Protecting critical assets and high-value information with appropriate security controls (that increases security while enabling business productivity)
     - Focus on immediate and emerging threats that are most likely to cause business impact.
     - Monitoring changes in business strategies and initiatives to stay in alignment.
   - **Long term** set direction and priorities to make steady progress over time, to improve overall security posture:
     - **Zero Trust:** Create a clear vision, strategy, plan, and architecture for reducing risks in your organization aligned to the [zero trust](https://aka.ms/zerotrust) principles of assuming breach, least privilege, and explicit verification. Adopting these principles shifts from static controls to more dynamic risk-based decisions that are based on real-time detections of anomalous behavior irrespective of where the threat derived.
     - **Burndown technical debt** as a consistent strategy by operating security best practices across the organization such as replacing password-based authentication with passwordless and multi-factor authentication (MFA), applying security patches, and retiring (or isolating) legacy systems. Just like paying off a mortgage, you need to make steady payments to realize the full benefit and value of your investments.
     - **Apply data classifications, sensitivity labels, and role-based access controls** to protect data from loss or compromise throughout its lifecycle. While these can’t completely capture the dynamic nature and richness of business context and insight, they are key enablers to guide information protection and governance, limiting the potential impact of an attack.
3. **Establishing a healthy [security culture](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/strategy/define-security-strategy#transformations-mindsets-and-expectations)** by explicitly practicing, communicating, and publicly modeling the right behavior. The culture should focus on open collaboration between business, IT, and security colleagues and applying a ‘growth mindset’ of continuous learning. Culture changes should be focused on removing siloes from security, IT, and the larger business organization to achieve greater knowledge sharing and resilience levels.

You can read more on Microsoft’s recommendations for [security strategy and culture here](https://aka.ms/securitystrategy).

## Understanding Cybersecurity Risk

**TODO - *Determine whether this should be separate article** <-- I believe this should be a seperate article or be linked to some content produced by MSTIC and/or DART based on their real world experience. They would be able to best articulate what they are seeing and why risk management is critical to business success. 

Because cybersecurity risk is caused by hostile human attackers seeking illicit gains, it's important to understand the motivations and behavior patterns of these human attackers. 

### Motivations

(DIAGRAMs from CISO workshop Module 2)

### Behavior Patterns

Organizations face a range of human attacker models that shape their behavior:
 - **Commodity** - The highest volume of threats organizations typically face are for-profit attackers driven by financial return on investment (ROI). These attackers typically use the cheapest and most effective available tools and methods, and the sophistication of these attacks (stealth, tooling, etc.) typically grows steadily new methods are proven by others and made available for high scale use. 
 - **Leading Edge** - Sophisticated attack groups are driven by long term mission outcomes and often have funding available to focus on innovation (e.g investing in supply chain attacks, changing tactics within an attack campaign to hinder detection and investigation, and other means to achieve stealth)

This diagram depicts commonalities and differences between these two methods using for-profit ransomware and espionage campaigns as examples:

(DIAGRAM - 1st one from https://www.microsoft.com/security/blog/2021/02/24/becoming-resilient-by-understanding-cybersecurity-risks-part-3-a-security-pros-perspective/)

Typically, the attackers are:
 - **Flexible:** Utilize more than one attack vector to gain entry to the network.
 - **Objective driven:** Achieve a defined purpose from accessing your environment. This could be specific to your people, data, or applications, but you may also just fit a class of targets like “a profitable company that is likely to pay to restore access to their data and systems.”
 - **Stealthy:** Take precautions to remove evidence or obfuscate their tracks (though at different investment and priority levels, see figure one)
 - **Patient:** Take time to perform reconnaissance to understand the infrastructure and business environment.
 - **Well-resourced and skilled** in the technologies they are targeting (though the depth of skill can vary).
 - **Experienced:** They use established techniques and tools to gain elevated privileges to access or control different aspects of the estate (which grants them the privileges they need to fulfill their objective).
NOTE: It is wise to understand that in some cases attackers might simply be a single person or small group of extremely dedicated people who have the means, opportunity, and intent on making your company go through great pain. It doesn't have to be a nation state, a large group, or even someone with a lot of experience and skill. Don't underestimate who might be exploiting a vulnerability. 

## Risk Management
TODO: Ok, as a non-technical person, I can see the value. In a paragraph or less, what is the Risk Management thing you're talking about?
Risk management is simply a way of identifying, documenting, and managing your risk. Organizations, large and small, deal with risk every day and should have some way of handling them. It all starts with awareness and understanding the potential threats that might impact your business and how often this might occur without mitigation. A textbook risk management program would have an executive sponsor, cross company participation, and a risk registry that is regularly reviewed, worked, and updated as risks are worked/identified across the organization. Security needs to work with finance and the business to put numbers to risks identified so leadership can make decisions. If the potential is high and the cost is high then business should be made aware. 

## Insights
TODO: When we are good at this, what kind of insights should we see & why are those example insights important to the business? <-- Not sure what to put here. Mark S.?

## Risk Management integration
In order for risk management to be effective, it must be integrated into all aspects of the governance and compliance activities of an organization. In order for risks to be properly assessed, security must always be considered as part of a comprehensive approach.

The International Organization for Standardization (ISO) is the world's largest independant develpoper of international standards. Following the risk management framework published by the ISO in [31000](https://www.iso.org/obp/ui/#iso:std:iso:31000:ed-2:v1:en) (or similarly well-adopted frameworks by other organizations) helps ensure a non-biased approach to utilizing a framework which accurately determines risk tolerance and mitigation practices for your organization.

In earlier risk management models, security was seen as a risk modifier - adding or removing various security solutions would, in turn, increase or decrease the amount of risk mitigation for a specific item. As many recent high profile security breaches have demonstrated, security can not be treated as "just another variable" - it must be a priority and considered in all scenarios. 


## Risk management standards in information technology
Risk management in regards to information technology should be a concept which is utilized in all layers of an organization. Whether it is determining the likelihood of a physical piece of equipment failing or the potential of an external actor breaching a data source, it is critical that as you progress through your risk management journey, you start with a solid foundation.

Which standard you utilize to determine your risk may be predetermined by external factors, such as insurance or industry requirements. Public companies may be required to become [ISO 27001](https://www.iso.org/isoiec-27001-information-security.html) certified, while those in the United States Government may need to abide by the [NIST Cybersecurity Framework](https://www.nist.gov/cyberframework). In many cases, these standardizations work in concert with each other in order to create a more robust risk managment approach. 
