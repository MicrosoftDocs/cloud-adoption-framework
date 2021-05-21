---
title: Asset protection
description: Learn about asset protection best practices in the Cloud Adoption Framework for Azure.
author: DominicAllen
ms.author: doalle
ms.date: 05/19/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: secure
ms.custom: internal
---

# Asset protection

Assets include physical and virtual items such as laptops, databases, files, and virtual storage accounts. Securing business critical assets often relies on the security of underlying systems, like storage, data, endpoint devices, and application components. The most valuable technical assets are typically data and the availability of applications, such as business websites, production lines, and communications.

Asset protection implements controls to support security architecture, standards, and policy. Each asset type and security requirement is unique. The security standards for any asset type should be consistently applied to all instances.

Asset protection focuses on consistent execution across all control types. Preventive, detective, and others align to meet the policies, standards, and architecture.

Asset protection acts as the technical subject matter expert for assets. It works with other disciplines, such as governance, architecture, security operations, and workload teams. Asset protection ensures that policy and standards are feasible and it enables implementation of controls to support the policy and standards. Asset protection provides feedback for continuous improvement.

> [!NOTE]
> Asset protection is usually implemented by IT operations teams that maintain the assets and are supplemented by expertise in the security team. For more information, see [Design controls as a team](#design-controls-as-a-team).

Threat actors are persistent and seek out vulnerabilities that result from gaps in the application of standards and policy. Attackers can directly target the business-critical data or application. They can also target the infrastructure that grants them access to the business-critical data and applications. Access control focuses on managing authorized access to resources. Asset protection addresses on all other potential out of band ways to gain access or control of resources. These two disciplines compliment each other and should be designed together to meet your architecture, policies, and standards. For more information, see [Access control](.\access-control.md).

![Diagram presents an overview of asset protection and asset control, with sections for get secure and stay secure.](./media/asset-protection.png)

## Get secure

Get secure focuses on bringing resources up to meet your organization's current security standards, policy, and architecture. There are two types of activities:

- **Brownfield:** Retrofit current security standards and controls to existing assets. Organizations might design and operate IT environments with security as low priority. This approach creates a "technical debt": weak security configurations, software that isn't upgraded, unencrypted communication or storage, legacy software and protocols, and more. Bring your security controls up to current approach. This improvement is critical to mitigate risk because attackers continually improve their ability to exploit these opportunities.
- **Greenfield:** Ensure that new assets and new asset types are configured to standards. This process is critical to avoid continuously creating instant legacy or brownfield, or systems that don't meet current standards. This technical debt will have to be addressed later at a greater expense, which results in increased risk exposure until it's complete.

Financially, *get secure* typically maps to capital expenditures (CAPEX) dynamics of a one-time investment. *Greenfield budget* for security should be mapped as closely as feasible to the creation of the asset, with a reserved percentage of the budget for security for each new software project, major software upgrade, or overall cloud adoption initiative. Many organizations reserve around 10 percent of budget for security. *Brownfield budget* is typically a special project funded to bring security controls up to current standards and compliance.

## Stay secure

Everything degrades over time. Physical items wear out. The environment changes around virtual items like software, security controls, and security. They might no longer meet changing requirements. These shifts happen fast today because of the following rapid changes:

- **Business requirements**, driven by digital transformation.
- **Technology requirements**, driven by rapid cloud platform evolution and feature releases.
- **Security requirements**, driven by attacker innovation and rapid evolution of native cloud security capabilities.

This dynamic affects all parts of security, including [security operations](.\security-operations.md), [access control](.\access-control.md), and particularly DevSecOps in [Innovation security](.\innovation-security.md).

Staying secure includes many elements. Focus on these two specific areas of asset protection:

- **Continuous cloud improvement:** Embrace the continuous improvement in security capabilities that the cloud brings. For example, many services in Azure like Azure Storage and Azure SQL Database have added security features to defend against attackers over time.
- **Software end-of-life:** Any software, including operating systems, always reach end-of-life, when security updates are no longer provided. This situation can expose business critical data and applications to cheap and easy attacks. While software as a service (SaaS) and cloud infrastructure and platforms are maintained by the cloud provider, enterprises often have a significant amount of software they install, author, and must maintain.

Plan to upgrade or retire end-of-life software. Investing into your security posture reduces the risk of a major security incident. *Stay secure* is part of the operational expenditures (OPEX) dynamics of a regular ongoing investment.

### The patch dilemma

It's critical for business leaders to support their IT and security leaders and teams. Running complex software in a hostile environment has inherent risk. Security and IT leaders constantly make difficult decisions about operational risk and security risk.

- **Operational risk:** A change to the software where the system runs could disrupt business processes. Such changes affect the assumptions made when the system was customized for the organization. This fact creates pressure to avoiding changing the system.
- **Security risk:** An attack brings the business risk of downtime. Attackers analyze every major security update on release. They can develop a working exploit in 24-48 hours to attack organizations that haven't applied the security update.

Your organization could have this dilemma often because of the continuing changes to technology and evolution of attack technique. Business leaders must recognize the risk of running a business using complex software. Support updating business processes such as these examples:

- **Integrating software maintenance** into the business operational assumptions, schedule, forecasting, and other business processes.
- **Investing in architectures** that make maintenance easier and reduce impact on business operations. This approach could involve updating existing architectures or shifting to new architectures entirely by migrating to cloud services or a service-oriented architecture.

Without business leadership support, security and IT leaders are distracted from supporting important business goals. They must constantly manage the politics of a no-win situation.

### Network isolation

Network isolation might be a valid option for protecting older assets that can no longer be secured, but cannot be immediately retired. This scenario can typically occur for end of life operating systems and applications. It's common in operational technology (OT) environments and legacy systems.

Isolation itself is considered access control, even though the assets that can't be secured are identified as part of asset protection. For more information, see [Avoid firewall and forget](.\access-control.md).

Some systems at end of life are difficult to disconnect and isolate completely. We don't recommend leaving these insecure systems fully connected to a production network. This configuration can allow attackers to compromise the system and gain access to assets in the organization.

It's never cheap or easy to upgrade or replace computer technology that has been working well for a decade or more. There might be limited documentation on its functionality. The potential business impact of losing control of multiple business critical assets often exceeds the cost of upgrade or replacement. For these assets that cannot be isolated, organizations often find that modernizing the workload with cloud technology and analytics can create new business value that can offset or justify the cost of upgrade or replacement.

Staying secure is challenging in a world that is constantly changing. It's critical to constantly decide what assets to modernize and what to secure as best you can. Use business risk and business priorities to evaluate.

## Getting started

To get started with asset protection, we recommend that organizations take the following steps.

- **Focus on well-known resources first:** Think about virtual machines, networks, and identities in the cloud that the team is already familiar with. This technique allows you to make immediate progress and are often easier to manage and secure with native cloud tools like Azure Security Center and Azure Defender.
- **Start with vendor/industry baselines:** Start your security configuration with a well-known and proven solution, for example:

  - **Security baselines in the Azure Security Benchmark.** Microsoft provides security configuration guidance tailored to individual Azure services. These baselines apply the Azure security benchmarks to the unique attributes of each service. This approach enables security teams to secure each service and refine configurations as needed. For more information, see [Security baselines for Azure](/security/benchmark/azure/security-baselines-overview).
  - **Microsoft security baselines.** Microsoft provides security configuration guidance for commonly used technologies including Windows, Microsoft Office, and Microsoft Edge. For more information, see [Microsoft security baselines](https://techcommunity.microsoft.com/t5/microsoft-security-baselines/bg-p/Microsoft-Security-Baselines).Microsoft-security-baselines) for more information
  - **CIS benchmarks.** The Center for Internet Security (CIS) provides specific configuration guidance for many products and vendors. For more information, see [CIS benchmarks](https://www.cisecurity.org/cis-benchmarks/).

## Key information

These key element help guide your asset protection process:

### Accountable and responsible teams

Accountability for security should always reside with the ultimate resource owner in the business that owns all other risks and benefits. The security teams and subject matter experts are collectively responsible for advising the accountable owner on the risks, any mitigation, and on doing the actual implementation.

Asset protection responsibilities might be performed by IT operations that manage enterprise-wide assets, DevOps and DevSecOps teams responsible for their workload's assets, or security teams working with the IT or DevOps and DevSecOps teams.

As organizations move to the cloud, many of these responsibilities can transfer to the cloud provider, for example, updating firmware and virtualization solution, or made easier, for example, security configuration scanning and remediation.

For more information on the shared responsibility model, see [Shared responsibility in the cloud](/azure/security/fundamentals/shared-responsibility).

### Cloud elasticity

Unlike on-premises resources, cloud resources might exist for only a short time. As needed, workloads can create more instances of servers, Azure Functions, and other resources, to do a job. Azure removes the resources afterward. This scenario can happen within months, but sometimes within minutes or hours. Take this possibility into account for your asset protection processes and measurements.

Cloud elasticity requires adjusting many processes. It improves your visibility, with on-demand inventory instead of static reports. Cloud elasticity also improves your ability to correct issues. For instance, building a new virtual machine for security reasons can happen quickly.

### Exception management

Once you identify a best practice for an asset, apply it consistently to all instances of the asset. You might need to make temporary exceptions, but manage the exceptions with specific expiration dates. Be sure that temporary exceptions don't become permanent business risks.

### Challenges with measuring value

 It can be difficult to measure the business value of asset protection. The impact of a problem isn't obvious until there's a real-world failure. The risk of not updating security for vulnerabilities is silent and invisible.

### Prefer automated policy

Favor automated enforcement and remediation mechanisms like Azure Policy for asset protection. This approach helps avoid cost and morale issues from repeatedly doing manual tasks. It also decreases risk from human errors.

Azure Policy allows central teams to specify configurations to use for assets across clouds.

### Design controls as a team

All controls should be designed as a partnership with key stakeholders:

- **Asset protection** provides subject matter expertise on the assets, the controls available for them, and feasibility of implementing the controls.
- **Governance team** provides context of how the controls fit into the security architecture, policies and standards, and regulatory compliance requirements.
- **Security operations** advise on detective controls. They integrate alerts and logs into security operations tools, processes, and training.
- **Vendors and cloud providers** can provide deep subject matter expertise on systems and components to avoid known issues seen across their customer base.

## Next steps

The next discipline to review is [security governance](./security-governance.md)
