---
title: Risk management insights
description: Learn how to integrate security insights into your risk management framework and digital initiatives.
author: NaomiOooo
ms.author: naomio
ms.date: 04/04/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: secure
ms.custom: internal
---

# Risk management insights

Operating a business comes with risk. A security team's role is to inform and advise decision makers on how security risks fit in their frameworks. The goal of security is to learn about your business, and then use their security expertise to identify risks to business goals and assets. Security then advises your decision makers on each risk and then recommends which ones are acceptable. This information is provided with the understanding that the responsibility for these decisions lies with your asset or process owner.

> [!NOTE]
> The general rule for risk accountability is:
>
> The person who owns and accepts the risk is the person that explains to the world what went wrong (often in front of TV cameras).

When mature, the goal of security is to expose and mitigate risks, and then empower the business to change with minimal risk. That level of maturity requires risk insights and deep security integration. At any level of maturity for your organization, the top security risks should appear on the risk register. Those risks are then managed down to an acceptable level.

## What is cybersecurity risk?

Cybersecurity risk is the potential damage or destruction of business assets, revenue, and reputation. This damage is caused by human attackers attempting to steal money, information, or technology.

While these attacks happen in the technical environment, they often represent a risk to your entire organization. Cybersecurity risk should be aligned to your risk measurement, tracking, and mitigation framework. Many organizations still treat cybersecurity risk as a technical problem to be *solved*. This perception leads to the wrong conclusions that don't mitigate the strategic business impact of risk.

The following diagram shows the shift from a typical technically oriented program to a business framework.

:::image type="content" source="./media/technical-to-business-transformation.png" alt-text="Diagram that shows the shift from a typical technically oriented program to a business framework." lightbox="./media/technical-to-business-transformation-popout.png":::

Security leaders must step back from the technical lens and learn what assets and data are important to business leaders. Then prioritize how teams spend their time, attention, and budget relating to business importance. The technical lens is reapplied as the security and IT teams work through solutions. But looking at cybersecurity risk only as a technology problem runs the risk of solving the wrong problems.

## Align your security risk management

Continuously work to build a stronger bridge between cybersecurity and your organizational leadership. This concept applies to both human relationships and explicit processes. The nature of security risk and the divergent dynamics of business opportunities are always changing. Security risk sources require ongoing investment into building and improving this relationship.

Key to this relationship is understanding how business value connects to specific technical assets. Without this direction, security can't be sure what's most important to your organization. They only succeed at protecting the most important assets with lucky guesses.

It's important to begin this process immediately. Start by gaining a better understanding of sensitive and business critical assets in your organization.

The typical process of starting this transformation is:

1. **Align the business** in a two-way relationship:
   - **Communicate in their language** to explain security threats using business-friendly terminology. This explanation helps to quantify the risk and impact to the overall business strategy and mission.
   - **Actively listen and learn** by talking to people across the business. Work to understand the impact to important business services and information if they were compromised or breached. This understanding provides clear insight into the importance of investing in policies, standards, training, and security controls.
2. **Translate learnings** about business priorities and risks into concrete and sustainable actions, such as:
   - **Short term** that focuses on dealing with important priorities.
     - Protect critical assets and high-value information with appropriate security controls. These controls increase security while enabling business productivity.
     - Focus on immediate and emerging threats that are most likely to cause business impact.
     - Monitor changes in business strategies and initiatives to stay in alignment.
   - **Long term** sets direction and priorities to make steady progress over time, improving the overall security posture.
     - Use **Zero trust** to create a strategy, plan, and architecture for reducing risks in your organization. Align them with the [zero trust](https://aka.ms/zerotrust) principles of assuming breach, least privilege, and explicit verification. Adopting these principles shifts from static controls to more dynamic risk-based decisions. These decisions are based on real-time detections of strange behavior no matter where the threat started.
     - **Pay off technical debt** as a consistent strategy by operating security best practices across the organization. For example, replace password-based authentication with passwordless and multifactor authentication, apply security patches, and retire or isolate legacy systems. Like paying off a mortgage, you must make steady payments to realize the full benefit and value of your investments.
     - **Apply data classifications, sensitivity labels, and role-based access control** to protect data from loss or compromise throughout its lifecycle. These efforts can't completely capture the dynamic nature and richness of business context and insight. But these key enablers are used to guide information protection and governance, limiting the potential impact of an attack.
3. **Establish a healthy [security culture](../strategy/define-security-strategy.md#transformations-mindsets-and-expectations)** by explicitly practicing, communicating, and publicly modeling the right behavior. The culture should focus on open collaboration between business, IT, and security colleagues. Then apply that focus to a 'growth mindset' of continuous learning. Focus culture changes on removing silos from security, IT, and the larger business organization. These changes achieve greater knowledge sharing and resilience levels.

For more information, see [Define a security strategy](../strategy/define-security-strategy.md).

## Understanding cybersecurity risk

Cybersecurity risk is caused by human attackers trying to steal money, information, or technology. It's important to understand the motivations and behavior patterns of these attackers.

### Motivations

The motivations and incentives for different types of attackers mirror those of legitimate organizations.

:::image type="content" source="./media/attacker-motivations.png" alt-text="Diagram that shows the motivations of attackers." lightbox="./media/attacker-motivations-popout.png":::

Understanding the attackers' motivations can help you understand the likelihood and potential impact of different types of attacks. While the security strategies and most important technical controls are similar across organizations, this context can help guide your security investment focus areas.

For more information, see [Disrupting attacker return on investment](/security/ciso-workshop/ciso-workshop-module-2#part-1-disrupting-attacker-return-on-investment-1431).

### Behavior patterns

Organizations face a range of human attacker models that shape their behavior:

- **Commodity:** Most of the threats organizations typically face are for-profit attackers, driven by a financial return on investment (ROI). These attackers typically use the cheapest and most effective available tools and methods. The sophistication of these attacks (for example, stealth and tooling) typically grows as new methods are proven by others and made available for high scale use.

- **Leading edge:** Sophisticated attack groups are driven by long-term mission outcomes and often have funding available. This funding is used to focus on innovation. This innovation might include investing in supply chain attacks or changing tactics within an attack campaign to hinder detection and investigation.

Typically, the attackers are:

- **Flexible:** They use more than one attack vector to gain entry to the network.
- **Objective-driven:** They achieve a defined purpose from accessing your environment. The goals might be specific to your people, data, or applications, but you might also fit a certain class of targets. For example, "A profitable company that's likely to pay to restore access to their data and systems."
- **Stealthy:** They take precautions to remove evidence or hide their tracks, usually at different investment and priority levels.
- **Patient:** They take time to do reconnaissance to understand your infrastructure and business environment.
- **Well-resourced and skilled:** They're educated in the technologies they're targeting, though the depth of skill can vary.
- **Experienced:** They use established techniques and tools to gain elevated privileges to access or control different aspects of the estate.

## Next steps

For risk management to be effective, it must be rolled into all aspects of your governance and compliance activities. For risks to be properly assessed, security must always be considered as part of a comprehensive approach.

- [Security integration](./security-integration.md) is the next focus area of security.