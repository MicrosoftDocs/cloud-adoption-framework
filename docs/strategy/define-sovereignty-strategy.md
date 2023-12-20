---
title: Define sovereignty strategy
description: Use the Cloud Adoption Framework for Azure to learn to build a business justification for sovereignty.
author: mboswell
ms.author: mboswell
ms.date: 12/01/2023
ms.topic: conceptual
---

# Define sovereignty strategy

Many geopolitical regions have established regulations on handling specific types of data, such as privacy sensitive data and government data classifications. These regulations typically define sovereignty requirements around data residency, control over data, and sometimes around operational independence (sometimes referred to as "autarky"). Organizations that need to adhere to these regulations should define a strategy to meet these requirements and to demonstrate compliance with the regulations. When organizations adopt cloud services, this strategy needs to be adjusted, because how you meet these requirements and how you can demonstrate that changes. This article discusses how you can define a sovereignty strategy when using cloud services.

## Modernize your sovereignty strategy

In your on-premises datacenter, you're responsible for most aspects typically associated with sovereignty. This includes, but isn't limited to, the following:

- Datacenters where data is stored and processed.
- Who has access to the datacenters and physical infrastructure.
- Hardware and software that is deployed, including hardware and software supply chain.
- Assurance processes to achieve trust that hardware and software are performing its functions as it should.
- Infrastructure and processes to satisfy business continuity if there was disaster or geopolitical events.
- Configuration and processes that determine who has access to which data and systems.
- Tools and processes to secure data and systems against outsider and insider threat.

When using cloud services, the responsibility around these aspects shifts to a [shared responsibility](/azure/security/fundamentals/shared-responsibility), leading to a change in how compliance teams determine whether sovereignty requirements have been met. This breaks down into two areas:

- Compliance of the cloud services. How do services offered by a cloud provider meet sovereignty and compliance requirements?
- Compliance of the systems and processes your organization is responsible for. Which tools are available to help you meet your sovereignty and compliance requirements, and how do you use these tools?

Note that regardless of which of the two areas, compliance teams may need to work with a regulator to get buy-in to use alternative methods to achieve the same goals. In some cases, a regulation may need to change by adding additional options or to change a directive to use a certain solution to describing the intended result. For example, a regulation may bar organizations from using certain cloud services because isolation requirements have been described in a way that the only way to achieve those is with hardware isolation typically not available in the cloud, while the intended result can also be achieved with virtual isolation. As part of your strategy, you need to determine how you work with regulators and auditors when these potential blockers arise.

[Microsoft Cloud for Sovereignty](/industry/sovereignty/) offers capabilities that cater to both areas to help customers meet their compliance and sovereignty needs and many of these can be used to help discussions with regulators and auditors.

### Compliance of cloud services

Compliance teams can use several sources and methods to verify cloud service compliance, including these:

- Vendor documentation on how their services work and how these are operated, such as product documentation and System Security Plans as published for [FedRAMP](https://servicetrust.microsoft.com/viewpage/FedRAMP).

- Certifications by independent auditors that certify compliance to global, regional, and industry compliance frameworks. For more information, see [Compliance offerings for Microsoft 365, Azure, and other Microsoft services.](/compliance/regulatory/offering-home)

- Audit reports created by independent auditors that provide deeper insights into how cloud services meet the requirements of global, regional, and industry compliance frameworks, some of which available from the [Service Trust Portal](https://servicetrust.microsoft.com/).

- Audit performed by or on behalf of the compliance team through vendor audit offerings, such as the [Government Security Program](https://www.microsoft.com/securityengineering/gsp) (available to select customers only).

- [Transparency logs](/industry/sovereignty/transparency-logs) that provide details of when Microsoft engineers accessed your resources.

Which combination of sources and methods your compliance team uses depends on the level of insight you need, the level of trust you associate with each of the available options, and the resources and budget available. Relying on a third-party auditor certification outsources the required knowledge to perform an audit and is much less costly than partially performing your own audit but requires trust in the auditor and audit process.

### Compliance of your systems and processes

Your organization's compliance processes and systems can benefit from the added capabilities of cloud services. These enhancements include:

- Enforcing or reporting on technical policies: Blocking deployment of services and configurations or reporting on violations that don't meet technical requirements supporting sovereignty and compliance requirement

- Pre-built policy definitions aligned to particular compliance frameworks.

- Audit logging and monitoring.

- Security tools as discussed in [Define a security strategy](/azure/cloud-adoption-framework/strategy/define-security-strategy).

- Technical assurance and monitoring capabilities, such as [Azure confidential computing](/azure/confidential-computing/overview)

These capabilities need to be carefully considered in the architecture of your organization's overall environment and for individual workloads, as the effort, applicability, and impact differ per capability. For example policy enforcement is a relatively lightweight method to support compliance, although it could restrict which services you can use and how you can use them. By comparison, technical assurance takes considerable effort and is more restrictive because it's only available with few services today and requires a significant knowledge investment.

## Differentiating by data classification

Different types of data and workloads can have different sovereignty requirements. This might depend on factors such as confidentiality of the data and whether it contains privacy sensitive data. It's important to understand which data classifications apply to your organization and which data and systems are subject to which classifications. Some data and applications can be subject to multiple regulations, potentially leading to combined requirements. For example, there might be a regulation around confidentiality of data and around criticality of systems, and this could result in classifications such as high confidentiality and low criticality or medium confidentiality and high criticality.

Complying with sovereignty requirements could affect other considerations, such as cost, resilience, scalability, security, and service richness. Applying the right controls to a particular data classification should be at the core of your sovereignty strategy. A one-size-fits-all approach leads to an environment that favors the highest compliance requirements, which is likely the costliest, while getting the least benefits from using cloud services.

## Next steps

Adopting the cloud, means adopting a shared responsibility model. Understanding which responsibilities shift to the cloud provider and which remain with you and understanding how that impacts sovereignty requirements outlined in regulations is key. The compliance documentation referenced in the [Compliance of cloud services](#compliance-of-cloud-services) section often describes that in great detail. However, getting a higher level view will help with understanding the more detailed documentation. Product documentation on various topics is a good starting point for this:

- Protection of the physical infrastructure is described in [Azure infrastructure security](/azure/security/fundamentals/infrastructure).

- Protection against various threats to the platform and the technical assurance processes are described in [Azure platform integrity and security](/azure/security/fundamentals/platform).

- Data residency features are described in [Data Residency in Azure](https://azure.microsoft.com/explore/global-infrastructure/data-residency/). For customers in the EU, the [Microsoft EU Data Boundary](https://www.microsoft.com/trust-center/privacy/european-data-boundary-eudb) offers extra data residency commitments.

- Business continuity is partially provided by the cloud provider through resilience of the platform and ensuring continuity of critical systems to operate the cloud. Customers need to build their workloads using the continuity options available from the services a workload uses or with additional services such as [Azure Backup](/azure/backup/backup-overview) or [Azure Site Recovery](/azure/site-recovery/site-recovery-overview). This is discussed further in [Azure reliability documentation](/azure/reliability/).

- While the cloud provider is responsible for securing access to the cloud platform, both from internal and external threats, customers are responsible for the configuration of their systems to secure their data through identity & access management, encryption, and other security measures. This is discussed further in [Define a security strategy](/azure/cloud-adoption-framework/strategy/define-security-strategy).
- [Microsoft Cloud for Sovereignty](/industry/sovereignty/) brings many of these topics together.
