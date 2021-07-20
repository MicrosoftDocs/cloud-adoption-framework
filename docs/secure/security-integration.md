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

In your organization, security should be a part of everyone's job, just like business requirements, performance, and reliability. Security, at all levels, should be familiar with overall business priorities, IT initiatives, and risk appetite for your organization. Envision security as a thread that weaves through every aspect of your business. Security should feel like natural part of business. Business should feel like a natural part of security.

Your organization must maintain security assurances while minimizing friction with business processes.

:::image type="content" source="./media/business-process-security-integration.png" alt-text="Diagram shows finance, information technology, and information security departments with a two headed arrow that represents internal interactions." lightbox="./media/business-process-security-integration-popout.png":::

Internal friction and low levels of conflict between teams might occur in organizations. Such conflicts aren't sustainable. It's critical for all of the teams to work together in the age of cloud, digital business, and zero trust security. Teams operating with different goals, culture, and language make an organization inefficient and ineffective.

Be sure that security teams aren't operating in silos. The teams should work closely together to ensure smooth process operations and knowledge sharing.

This guidance describes how you can improve security integration with business and IT teams and integration between security teams.

## Normalize relations

Overcoming the silo approach that is prevalent at many organizations can be a challenge, however it can be done. The main elements are to be clear about the end state, provide clarity on the process, and provide ongoing leadership support for tangible goals and for changes in culture and behavior. The following elements are critical to the process:

- Identify shared goals and outcomes.
- Identify the right level of security.

### Identify shared goals and outcomes

Ensure there's a shared understanding of your goals that involves all teams. Security teams sometimes define themselves as quality control over the business and IT functions. This approach creates an adversarial dynamic and generates friction. Business productivity, IT goals, and security goals can suffer from this dynamic.

Be sure that security teams are closely integrated with their IT and business counterparts. Security teams are jointly responsible for the business, IT, and security outcomes of any initiative. Share the challenges of designing systems to meet business and IT goals. Share security perspective and expertise at the right time.

As systems are being designed, implemented, operated, and continuously improved, it's critical to set guardrails so that *no voice dominates all decisions* that are related to business, IT, or security.

### Identify the right level of security

Some security controls like biometric sign-in with [Windows Hello for Business](/windows/security/identity-protection/hello-for-business/hello-overview) have the dual benefits of making the user experience better and the security stronger. Many security measures add friction to business processes and can slow them down. We strive to first find security measures that are easy and invisible to users and developers. We must accept that sometimes a tradeoff must be made.

These joint teams should always strive for a healthy level of friction in the process that creates value by driving critical thinking at the right time. For example, you might consider what an attacker might do with a new feature or how much business impact would come from altering some data.

Teams should strive for the best balance between two absolute truths:

- Security cannot be skipped. Skipping security often leads to incidents that cost more in the end (productivity, revenue, overall business impact) than integrating security would have.
- Security controls can reach an unhealthy level of friction where the security friction impedes more value than it protects.

It's critical to find a balance as security is integrated into the process. Stakeholders must all work together to ensure business concerns, IT reliability and performance concerns, and security concerns are considered and balanced. Organizations need to also work on solving for the 80 percent and planning for the other 20 percent. By holding off on controls, features, and capabilities for security until there is a 100 percent solution, organizations will put everything they do at risk of exposure. Iterative approaches work well, as do the basics of updating and education.

For more information about healthy security friction, see the [right level of security friction](../strategy/define-security-strategy.md#the-right-level-of-security-friction) in the security strategy guidance.

The next section illustrates how to integrate security stakeholders with IT, end users, and workload owners. It also includes examples for within the security team.

## Integrate with IT and business operations

While most security functions operate out of sight, some security considerations appear in daily business and IT workflows. Security thinking must be integrated into the normal experience of planning and operating a business.

### Security update process

Security updates are one of the most common and visible points where business processes and security processes interact. It's a common source of friction because it involves the difficult balance of two different forces, that map to separate stakeholders in the organization:

- **Immediate business impact:** Security updates often require testing and system reboots, which consume time and resources for application owners and IT teams, and potentially result in business impact from downtime.
- **Potential future business impact as security risk:** If updates aren't applied completely, attackers can exploit the vulnerabilities and cause business impacts.

If teams operate without shared goals and responsibility (for example, IT and the business focused 100 percent on immediate business impact, security accountable for 100 percent of the security risk), then they will be in constant conflict over security updates. This conflict distracts the teams with endless arguments rather than them working together to solve the problem, which allows them to move onto the next problem, risks, and business value creation opportunity. Ongoing communication across the organization and creating a culture where updates are embraced will go a long way to limit push back from end users. If the users know they'll be better protected, able to be more productive, and be able to build the business because security is side by side with them, they will be more likely to embrace updates and ongoing education.

Correctly placing the accountability for all benefits and risk on the asset owners makes it easier for them to consider immediate and potential future impact. Making identifying the solution a joint responsibility of all subject matter experts in security, IT, and business increases the quality of the solution by considering more and diverse perspectives. Make everyone a stakeholder in the security story across the company. While everyone might not have security as their day to day role, they do have security requirements to perform their role.

This example process illustrates how organizations are starting to solve this problem using shared responsibility and flexibility within a limited time frame:

:::image type="content" source="./media/update-process.png" alt-text="Diagram shows the process of distributing security updates." lightbox="./media/update-process-popout.png":::

This process is followed on a regular schedule:

- Enterprise IT and security teams start the process by identifying which security updates, or patches, are required and the highest impact. They make these updates available to end users or workload owners through enterprise-wide distribution channels.
- End users have a fixed period to test the updates, apply them, and restart their devices. After that period expires, enterprise IT and security teams either apply the update or block access to corporate resources. They might use a mechanism like Azure AD Conditional Access or a third-party network access control solution.
- Workload owners are given a fixed period of time to test the updates, apply them to production systems, and reboot as required. After that self-service period, and any grace period expires, enterprise IT and security teams will either force the update to apply or isolate them from other corporate resources. Some organizations with stringent requirements might decommission the assets by deleting them from Azure subscriptions or AWS accounts.
- Enterprise IT and security teams monitor the status of the update and conduct any forced remediation that's identified.

This process is not static and it's not set up in one day. It's built iteratively and continuously improved over time. Start wherever you are and continually improve the process to make incremental progress toward this end state. Use the following dimensions for continuous improvement planning:

- **Coverage:** Start with a few application teams that have a high chance of success or have a large business impact if compromised. Add more until you cover all workloads in your environment.
- **Time:** Start with deadlines that you know you can accomplish and set a clear roadmap to continually shorten them until you are close to fully updated in a week or less.
- Technology scope. Continuously improve what patches and technologies you cover, including applications, middleware, and open-source components used in application code. You should encourage the use of components that are updated for you to lower the maintenance burden. For example, use [Azure SQL Database](/azure/azure-sql/) instead of installing and updating your own SQL Server.
- **Processes:** Continually improve communication channels between teams, prioritization guidance, exception processes, and all other aspects of this process.

## Integrate security teams

Security teams should work together and collaborate to avoid increased business risk resulting from operating in silos. When learnings and key insights aren't shared across security teams, the organization might experience greater damage and impact from a future incident that could have been avoided.

Security is a dynamic discipline that must always be responding to active threats and always be learning and continuously improving processes, tools, and technologies. Security must constantly adapt to the shifts in attacker techniques, technology platforms, and business models of their organization. Security teams should work together to rapidly respond to threats and continuously integrate insights and learnings into processes that both improve the security posture of the organization, and the ability to rapidly respond to attacks.

The following workflow diagram illustrates how security disciplines should collaborate to completely integrate learnings and insights to improve security overall.

:::image type="content" source="./media/complete-risk-mitigation.png" alt-text="Diagram shows collaboration to reduce security risks." lightbox="./media/complete-risk-mitigation-popout.png":::

Security's primary mission is to rapidly respond to the following situations:

- **New incidents:** Active attackers with access to organizational resources pose an immediate risk to the organization that must be rapidly remediated as a first priority. After remediation, these attacks represent the best opportunity to learn what future attacks will look like. Whether they succeeded or failed, attackers are likely to repeat pursuing the same target, technique, or monetization model again.

- **New insights and learnings:** New insights and learnings can come from the following sources:

  - External incidents. Incidents at other organizations can offer insights on attackers. They might attempt the same on your organization. This knowledge informs improvement plans or validates that your investments are on the right track. Discover external incidents through an information sharing and analysis center (ISAC), direct relationships with peer organizations, or other public reporting and analysis on incidents.

  - New technical capabilities. Cloud providers and software vendors continuously innovate. They add capabilities to their products:
    - Business capabilities that require security defenses.
    - Security capabilities that improve the ability of security to defend the assets. These capabilities might be native security capabilities integrated into cloud platforms or other platform technology. They might be traditional stand-alone security capabilities.
    - The visibility and telemetry available from cloud-based security far outweighs what organizations could get from their single on-premises environment. All of this data is gathered by using metadata from all over. The data is put through a rigorous analysis process, including behavioral analytics, detonation chambers, machine learning, and AI.

  - **Industry best practices:** Industry best practices from vendors and organizations like National Institute of Standards and Technology (NIST), Center for Internet Security (CIS), and The Open Group. These organizations have a charter to gather and share learnings and best practices that security teams can learn from.

  - Vulnerabilities are anything that an attacker can exploit to take control of an asset, such as software vulnerabilities. There are also security configuration choices, weaknesses in cryptographic algorithms, insecure practices, and processes for using or managing systems. As you discover vulnerabilities, evaluate them for how they affect your security posture and ability to detect, respond to, and recover from an attack.

- **Respond to threat:** Security operations teams investigate detections. They respond to them by evicting adversaries from their control points in the organization. Depending on the size of the organization and complexity of the incident, this response might involve several security teams.

- **Root cause analysis:** Identifying the key contributing factors that made a major incident higher likelihood or higher impact generates insights learnings that can improve the organizations security posture and ability to respond. These learnings can happen along many dimensions including attack tools and infrastructure, attack techniques, targets, motivation, and monetization models. Root cause analysis can inform preventive controls, detective controls, security operations processes, or any other element of the security program or architecture.

- **Hunt for threat:** Hunting proactively for threats is an ongoing activity. Hunting should always consider new insights or learnings in the hunt planning and hypothesis development. Hunt teams might want to focus on key aspects:
  - Recently widespread or high impact vulnerability.
  - A new attacker group.
  - A new attack technique that was demonstrated at a conference.

- **Design and implement mitigation:** Lessons learned must be integrated into the technical environment and both security and business processes. Teams should work together to integrate lessons into architecture, policy, and standards. For example, the theft of administrative credentials in a recent internal or public incident might spur the organization to adopt the controls in Microsoft's privilege access. For more information, see [Security rapid modernization plan](/security/compass/security-rapid-modernization-plan).

## Next steps

As you plan your cloud adoption, focus on integrating security functions together. Integrate security with your larger organization. Pay close attention to the friction that security generates. Be sure the friction is healthy. Healthy friction reduces risk for the organization without creating slowdowns that erode more value than they protect.

- Review [define a security strategy](../strategy/define-security-strategy.md)
- Review [cloud security functions](../organize/cloud-security.md)

- Review [business resilience](./business-resilience.md), which is the next focus area of security.