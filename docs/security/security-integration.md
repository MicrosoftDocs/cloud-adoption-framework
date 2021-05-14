---
title: Security integration
description: Integrate security insights and practices. Learn how security teams should work with other stakeholders to IT and business operations.
author: NaomiOooo
ms.author: naomio
ms.date: 05/14/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: secure
ms.custom: internal
---

# Security integration

In your organization, security should be a part of everyone's job, just like business requirements, performance, and reliability. Security, at all levels, should be familiar with overall business priorities, IT Initiatives, and risk appetite for your organization. Envision security as a thread that weaves through every aspect of your business. Security should feel like natural part of business. Business should feel like a natural part of security.

Your organization must maintain security assurances while minimizing friction with business processes.

:::image type="content" source="./media/business-process-security-integration.png" alt-text="Diagram shows finance, information technology, and information security departments with a two headed arrow representing internal interactions." lightbox="./media/business-process-security-integration-popout.png":::

Internal friction and low levels of inter-team conflict may occur in organizations. Such conflicts aren't sustainable. All of the teams need to work together in the age of cloud, digital business, and zero trust security. Teams operating with different goals, culture, and language make an organization inefficient and ineffective.

Be sure that security teams aren't operating in silos. The teams should work closely together to ensure smooth process operations and knowledge sharing.

This article describes how you can improve security integration with business and IT teams and integration between security teams.

## Normalize Relations

Overcoming the silo approach can be challenging. Be clear about the end state and on the process. Provide leadership support for tangible goals and for changes in culture and behavior. The following elements are critical to the process:

- Identify shared goals and outcomes.
- Identify the right level of security.

### Identify shared goals and outcomes

Ensure there's a shared understanding of your goals that involves all teams. Security teams sometimes define themselves as quality control over the business and IT functions. This approach creates an adversarial dynamic and generates friction. Business productivity, IT goals, and security goals suffer from this dynamic.

Be sure that security teams are closely integrated with their IT and business counterparts. Security teams are jointly responsible for the business, IT, and security outcomes of any initiative. Share the challenges of designing systems to meet business and IT goals. Share security perspective and expertise at the right time.

Create guardrails against a single voice dominating all decisions, be it business, IT, or security.

### Identify the right level of security

Some security controls, like biometric sign-in, improve user experience and security. For more information, see [Windows Hello for Business](/windows/security/identity-protection/hello-for-business/hello-overview).

Many security measures could slow down business processes. Look first for security measures that are easy and invisible to users and developers. However, sometimes there's a tradeoff.

These joint teams should strive for a healthy level of friction. This balance creates value by driving critical thinking at the right time. For instance, you might consider what an attacker may do with a new feature or how much business impact would come from altering some data.

Stakeholders must all work together to balance business, IT reliability/performance, and security concerns. Consider the following principles:

- Security cannot be skipped. Skipping security can lead to incidents. Incidents can cost more in productivity, revenue, and business impact, than integrating security would have.  
- Security cannot dominate. Security controls can reach an unhealthy level where they impede more value than they protect.

Your organization needs to work on solving for the 80%. Next, come up with a plan for the other 20%. By holding off on controls, features, and capabilities for security until there's a 100% solution, your organization puts everything at risk. Use iterative approaches along with the basics of updating and education.

For more information about healthy security friction, see [The right level of security friction](/azure/cloud-adoption-framework/strategy/define-security-strategy#the-right-level-of-security-friction) in the security strategy guidance.

The next section illustrates how to integrate security stakeholders with IT, end users, and workload owners.

## Integrate with IT and business operations

While most security functions operate out of sight, some security considerations appear in daily business and IT workflows. Security thinking must be integrated into the normal experience of planning and operating a business.

### Security update process

Security updates are a point where business processes and security processes regularly interact. This interaction is a source of friction because it involves two forces:

- Immediate business impact. Security updates often require testing and system restarts. Updates consume time and resources for application owners and IT teams.
- Potential future business impact as security risk. If updates aren't applied completely, attackers can exploit the vulnerabilities and cause business impacts.

If teams operate without shared goals and responsibility, it causes conflict over security updates. This conflict distracts when teams could be working together to solve the problem.

Foster ongoing communication across your organization and create a culture where updates are embraced. This approach limits pushback from end users. They understand they're better protected, able to be more productive, and build the business because security. Users will be more likely to embrace updates and ongoing education.

Placing the accountability on the asset owners makes it easier for one person to consider effects. Make identifying the solution a joint responsibility of security, IT, and business. They can consider more and diverse perspectives to increase the quality of the solution.

Make everyone a stakeholder in the security story across the company. While everyone might not have security as their day to day role, they do have security requirements in their roles.

This example process illustrates how organizations can solve this problem using shared responsibility and flexibility:

:::image type="content" source="./media/update-process.png" alt-text="Diagram shows the process of distributing security updates." lightbox="./media/update-process-popout.png":::

This process is followed on a regular schedule:

- Enterprise IT and security teams start the process by identifying which security updates, or patches, are required and the highest impact. They make these updates available to end users or workload owners through enterprise-wide distribution channels.
- End users have a fixed period to test the updates, apply them, and restart their devices. After that period expires, enterprise IT and security teams either apply the update or block access to corporate resources. They might use a mechanism like Azure AD Conditional Access or a third-party network access control solution.
- Workload owners have a fixed period of time to test the updates, apply them to production systems, and restart as required. After that period expires, enterprise IT and security teams either apply the update or isolate systems from corporate resources. Some organizations with stringent requirements may also decommission the assets by deleting them from Azure Subscriptions or AWS Accounts.
- Enterprise IT and security teams also monitor the status of the update and conduct any forced remediation identified.

This process isn't static. The process is built iteratively and continuously improved over time. Start with your current process. Continually improve the process to make incremental progress towards this end state. Use the following dimensions for continuous improvement planning:

- Coverage. Start with application teams that have a high chance of success or have a large business impact if compromised. Add more until you cover all workloads in your environment.
- Time. Start with deadlines that you can accomplish. Set a clear plan to tighten deadlines until you're close to fully updating in a week or less.
- Technology scope. Improve which updates and technologies you cover. These items include applications, middleware, and open-source components used in application code. Encourage use of components that are updated to lower the maintenance burden. For instance, use [Azure SQL](/azure/azure-sql/) instead of installing and updating your own SQL server.
- Processes. Improve communication channels between teams, prioritization guidance, exception processes, and all other aspects of this process.

## Integrate security teams

Security teams should work together and collaborate. They should avoid the increased business risk from operating in silos. Share learning and key insights across security teams. This communication avoids greater damage and impact from future incidents that you can avoid.

Security is a dynamic discipline. It responds to active threats and always learns and improves processes, tools, and technologies. Security constantly adapts to shifts in attacker techniques, technology platforms, and business models of their organization. Security teams work together to rapidly respond to threats and continuously integrate insights and learning into processes. This integration improves the security posture of the organization and ability to rapidly respond to attacks.  

The following diagram illustrates how security disciplines collaborate to integrate learning and insights to improve security:

:::image type="content" source="./media/complete-risk-mitigation.png" alt-text="Diagram shows collaboration to reduce security risks." lightbox="./media/complete-risk-mitigation-popout.png":::

Security's primary mission is to rapidly respond to the following situations:

- New incidents. Active attackers with access to an organizational resource pose an immediate risk to the organization. Security teams must rapidly and completely remediate this risk. After remediation, these attacks offer an opportunity to learn about future attacks. Whether attacks succeed or fail, attackers often repeat the same target, technique, or monetization model.

- New insights and learning can come from the following sources:

  - External incidents. Incidents at other organizations can offer insights on attackers. They might attempt the same on your organization. This knowledge informs improvement plans or validates that your investments are on the right track. Discover external incidents through Information Sharing and Analysis Center (ISACs), direct relationships with peer organizations, or other public reporting and analysis on incidents.
  - New technical capabilities. Cloud providers and software vendors continuously innovate. They add capabilities to their products:

    - Business capabilities that require security defenses.
    - Security capabilities that improve the ability of security to defend the assets. These capabilities may be native security capabilities integrated into cloud platforms or other platform technology. They might be traditional stand-alone security capabilities.
    - The visibility and telemetry available from cloud-based security far outweighs what organizations could get from their single on-premises environment. All of this data is gathered by using metadata from all over. The data is put through a rigorous analysis process, including behavioral analytics, detonation chambers, machine learning, and AI.

  - Industry best practices from vendors and organizations like National Institute of Standards and Technology (NIST), Center for Internet Security (CIS), and The Open Group.
  
  - New vulnerabilities. Vulnerabilities are anything that an attacker can exploit to take control of an asset, such as software vulnerabilities. There are also security configuration choices, weaknesses in cryptographic algorithms, insecure practices, and processes for using or managing systems. As you discover vulnerabilities, evaluate them for how they affect your security posture and ability to detect, respond to, and recover from an attack.

- Respond to threat. Security teams investigate detections. They respond to them by evicting adversaries from their control points in the organization. Depending on the size of the organization and complexity of the incident, this response may involve several security teams.

- Root cause analysis. Security teams identify key factors that make an incident more likely or have a bigger impact generates. Analysis improves your security posture and ability to respond. Analysis can involve attack tools and infrastructure, attack techniques, targets, motivation, and monetization models. Root cause analysis can inform preventive controls, detective controls, security operations processes, or any other element of the security program or architecture.

- Hunt for threat. Hunt for threats proactively. Hunting considers new insights or learning in their planning and hypothesis development. Hunt teams may want to focus on key aspects:
  - Recently widespread or high impact vulnerability.
  - A new attacker group.
  - A new attack technique that was demonstrated at a conference.  

- Design and implement mitigation. Lessons learned must be integrated into the technical environment and both security and business processes. Teams should work together to integrate lessons into architecture, policy, and standards. For example, the theft of administrative credentials in a recent internal or public incident may spur the organization to adopt the controls in Microsoft's privilege access. For more information, see [Security rapid modernization plan](https://aka.ms/SPA-RAMP).

## Next steps

As you plan your cloud adoption, focus on integrating security functions together. Integrate security with your larger organization. Pay close attention to the friction that security generates. Be sure the friction is healthy. Healthy friction reduces risk for the organization without creating slowdowns that erode more value than they protect.

- Review the [Security Strategy Guidance](https://aka.ms/securitystrategy)
- Review the [Security Organizational Functions](https://aka.ms/securityroles)

[Business Resilience](./business-resilience.md) is the next focus area of security.
