---
title: Improve landing zone security
description: Improve landing zone security.
author: Zimmergren
ms.author: pnp
ms.date: 06/21/2022
ms.topic: conceptual
ms.custom: internal
---

# Improve landing zone security

When a workload or the landing zones that hosts it require access to any sensitive data or critical systems, it's important to protect the data and assets.

## Secure

As you're exiting the Ready state, you have the ongoing responsibility to maintain the security of your environment. Cloud security is also an incremental process instead of just a static destination. Focus on objectives and key results when envisioning a security end state. Map concepts, frameworks, and standards to the disciplines in the CAF [secure methodology](../../secure/overview.md) alongside mapping to roles and responsibilities for human discipline. The secure methodology provides guidance.

Below we provide an overview of this guidance with links to the details.

### Risk insights

Business operations have security risks. The security team should inform and advise decision makers on how security risks fit into their frameworks by understanding the business and using security practices to recognize which risk to appropriately plan and take action upon.

- Cybersecurity risks: All potential damage or destruction of the business caused by human attackers attempting to steal currency, inside information, or technology.
- Align your security risk management:  Invest in bridging cybersecurity and organizational leadership to explain security threats using business-friendly terminology, actively listening and communicating to all people across the business.
- Understanding cybersecurity risk: Comprehend the motivations and behavior patterns of human attackers for stealing money, information, or technology and identifying potential impact of different types of attacks.

### Security integration

Ensure that security is an organizational concern and not siloed into a single group. [Security integration](../../secure/strategy.md) provides you with guidance on how to integrate security into everyone's role while minimizing friction with business processes. Specific guidance includes:

- Normalizing relations: Ensure all teams are integrated with security teams and have a shared understanding of security goals. Further, work to find the right level of security controls, ensuring the controls don't outweigh business value.
- Integrate with IT and business operations: Balance the implementation of security updates and mapping how all security processes affect current business impact, and potential security risk in the future.
- Integrate security teams: Avoid operating in silos by responding to active threats and continuously improving the security posture of the organization by practicing security as a dynamic discipline.

### Business resilience

While organizations can never have perfect security, there's still the pragmatic approach of [Business resilience](../../secure/plan.md) in investing the full lifecycle of a security risk before, during, and after an incident.

- Resilience goals: Focus on enabling your business to rapidly innovate, limit the impact, and always seek safe ways to adopt technology.
- Security resilience and assume breach: Assume breach or compromise to follow the key principle of Zero Trust and practice pragmatic security behaviors to prevent attacks, limit damage, and have quick recovery from them.

### Access control

Make an [access control](/security/zero-trust/deploy/identity) strategy that aligns both user experience and security assurances.

- From security perimeter to Zero Trust: Embrace a Zero Trust approach for access control for establishing and improving security assurances when working in the cloud and using new technology.
- Modern access control: Make an access control strategy that is comprehensive, consistent, and flexible. Go beyond a single tactic or technology for multiple workloads, clouds, and various business sensitivity levels.
- Known, trusted, allowed: Follow the dynamic three-step process to ensure known authentication, trusting the user or device, and allowing the appropriate rights and privileges for the application, service, or data.
- Data-driven access decisions: Make informed decisions from the diverse data on the users and devices for fulfilling explicit validation.
- Segmentation: Separate to protect: Create boundaries as separate segments of an internal environment to contain damages of successful attacks.
- Isolation: Avoid firewall and forget: Design an extreme form of segmentation for business-critical assets that consists of: people, process, and technology.

### Security operations

Establish [security operations](../../secure/teams-roles.md) by reducing risk, rapidly responding, and recovery to protect your organization and follow the security discipline of the DevOps process.

- People and process: Create a culture to empower people with tools to enable them as your most valuable asset and diversify your thinking portfolio by including and training non-technical people with strong backgrounds in forensic investigation roles.
- Security operations model: Focus on the outcomes of incident management, incident preparation, and threat intelligence. Delegate the outcomes between subteams to triage, investigate, and hunt on high volume and complex incidents.
- SecOps business touchpoints: Interact with business leadership in order to inform major incidents and determine impact of critical systems. Continuously joint practice response to reduce organizational risk.
- SecOps modernization: Evolve security operations by following trends involving platform coverage, identity-centric security, IoT and OT devices, and relevant telemetry from the cloud.

### Asset protection

Secure business critical [assets](../../secure/govern.md), which include all physical and virtual items by implementing security controls that are unique to each asset type. Consistently execute preventive and detective protection to meet policies, standards, and architecture.

- Get secure: Bring resources up to your organization's latest security standards and policy by applying current controls to brownfield assets and ensuring greenfield assets are set to the most recent standards.
- Stay secure: Practice continuous cloud improvement and plan for upgrading or retiring end-of-life software as business, technology, and security requirements change rapidly.
- Get started: Start protecting assets by focusing on well-known cloud resources first and use well-known and proven vendor/industry baselines for your security configuration.
- Key information: Use key elements of accountable and responsible teams to manage enterprise-wide assets such as cloud elasticity workload needs and design controls to identify best practices. Measure business value of asset protection and favor automated policy to avoid cost and manual repetition.

### Security governance

Perform oversight and monitoring with [security governance](../../secure/govern.md) for sustaining and improving security posture over time by using business goals and risk to determine the best direction for security.

- Compliance and reporting: Have both external and internal security policies meet mandatory requirements in a given industry.
- Architecture and standards: Create a unified view across your enterprise estate as most enterprises are a hybrid environment that includes both on-premises and cloud resources.
- Security posture management: Plan for governance to monitor security standards, provide guidance, and improve processes. Maintain agility by driven governance through policy and continuous improvement.
- Governance and protection disciplines: Apply security controls and provide feedback to identify the best solutions.
- Governance and security operations: Ensure that lessons learned from incidents are integrated into security operations and governance.

### Innovation security

Protect the processes and data of innovation against cyberattacks as new applications are developed with [innovation security](/security/zero-trust/develop/identity-zero-trust-compliance) in mind.

- DevSecOps: Integrated security into the already combined process of development and operations in DevOps to mitigate risks in the innovation process.
- Secure by design and shifting left: Involve security in all stages of the DevOps lifecycle and have teams align with innovation speed, reliability, and resilience.
- Why DevSecOps: To secure the DevOps process protecting against attackers exploiting weaknesses in all IT infrastructure within your organization, which in turn protects your customers.
- The DevSecOps Journey: Use idea incubation and DevOps as a two-phase process like most organizations. Identify the MVP (minimum viable product) requirements, use leadership techniques to resolve teams conflicts, and integrate security in existing processes and tools.
- Tips on navigating the journey: As you transform your security, there will be common challenges throughout the journey that will involve education, time, resourcing, and the overall shifting nature of IT operations.

### DevSecOps controls

Add security to each stage of continuous integration and continuous delivery (CI/CD) when making [DevSecOps controls](/security/zero-trust/develop/secure-devops-environments-zero-trust).

- Secure the design: Bring security to the planning phase in modern development methodologies to implement threat modeling, IDE security plugins/pre-commit, and peer review.
- Secure the code: Evaluate and implement vulnerability scanning capability to your centralized repositories to discover risks and perform remediation.
- Secure the pipeline: Use build and release pipelines for automation and standardization for the processes of building and deploying secure code without spending large amounts of time in redeploying or upgrading existing environments.
- Secure operations: Oversee and manage the state of security when the solution is brought to production. Use infrastructure scanning tools and penetration testing practices for enabling teams to find risks and vulnerabilities to address.

## Test-driven development cycle

Before beginning any security improvements, it's important to understand the "definition of done" and all "acceptance criteria." For more information, see the articles on [test-driven development of landing zones](./development-strategy-test-driven-development.md) and [test-driven development in Azure](./development-strategy-test-driven-development.md).

## Next steps

Understand how to [improve landing zone operations](./landing-zone-operations.md) to support critical applications.

> [!div class="nextstepaction"]
> [Improve landing zone operations](./landing-zone-operations.md)
