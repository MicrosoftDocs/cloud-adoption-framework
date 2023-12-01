---
title: Define a sovereignty strategy
description: Use the Cloud Adoption Framework for Azure to learn to build a business justification for sovereignty.
author: mboswell
ms.author: mboswell
ms.date: 12/01/2023
ms.topic: conceptual
ms.custom: think-tank, UpdateFrequency2
---

# Define a sovereignty strategy

Many geopolitical regions have established regulations on handling specific types of data, such as privacy sensitive data and government data classifications. These regulations typically define sovereignty requirements around data residency, control over data, and sometimes around operational independence (sometimes referred to as "autarky"). How you meet these requirements changes when you adopt (hybrid) cloud services. Compliance teams are an important part of the process of determining when and how using cloud services is acceptable.

## Modernize your sovereignty strategy

In your on-premises datacenter, you're responsible for most aspects typically associated with sovereignty. This includes, but isn't limited to, the following:

- Datacenters where data is stored and processed.
- Who has access to the datacenters and physical infrastructure.
- Hardware and software that is deployed, including hardware and software supply chain.
- Assurance processes to achieve trust that hardware and software are performing its functions as it should.
- Infrastructure and processes to satisfy business continuity if there was disaster or geopolitical events.
- Configuration and processes that determine who has access to which data and systems.
- Tools and processes to secure data and systems against outsider and insider threat.

When using cloud services, the responsibility around these aspects shifts to [shared responsibility](/azure/security/fundamentals/shared-responsibility) and this leads to a change in how compliance teams get determine whether sovereignty requirements have been met. This breaks down into two areas:

- Compliance of the cloud services – How do services offered by a cloud provider meet sovereignty and compliance requirements?
- Compliance of the systems and processes your organization is responsible for Which tools are available to help you meet your sovereignty and compliance requirements, and how do you use these tools?

[Microsoft Cloud for Sovereignty](/industry/sovereignty/) offers capabilities that cater to both areas to help customers meet their compliance and sovereignty needs.

### Compliance of cloud services

For compliance of cloud services, compliance teams can use several sources and methods:

- Vendor documentation on how their services work and how these are operated, such as product documentation and System Security Plans as published for [FedRAMP](https://servicetrust.microsoft.com/viewpage/FedRAMP).

- Certifications by independent auditors that certify compliance to global, regional, and industry compliance frameworks. For more information, see [Compliance offerings for Microsoft 365, Azure, and other Microsoft services.](/compliance/regulatory/offering-home)

- Audit reports created by independent auditors that provide deeper insights into how cloud services meet the requirements of global, regional, and industry compliance frameworks, some of which available from the [Service Trust Portal](https://servicetrust.microsoft.com/).

- Audit performed by or on behalf of the compliance team through vendor audit offerings, such as the [Government Security Program](https://www.microsoft.com/securityengineering/gsp) (available to select customers only).

- [Transparency logs](/industry/sovereignty/transparency-logs) that provide details of when Microsoft engineers accessed your resources.

Which (combination) of sources and methods your compliance team uses depends on the level of insight you need, the level of trust you associate with each of the available options, and the resources and budget available. Relying on a third- party auditor certification outsources the required knowledge to perform an audit and is much less costly than (partially) performing your own audit, but requires trust in the auditor and audit process.

### Compliance of your systems and processes

For compliance of the processes and systems your organization is responsible for, existing compliance processes can be enhanced with capabilities provided by cloud services. These include:

- Technical policy enforcement and reporting – blocking deployment of services and configurations or reporting on violations that don't meet technical requirements supporting sovereignty and compliance requirements.

- Pre-built policy blueprints aligned to particular compliance frameworks.

- (Audit) logging and monitoring.

- Security tools as discussed in [Define a security strategy](/azure/cloud-adoption-framework/strategy/define-security-strategy).

- Technical assurance and monitoring capabilities, such as [Azure confidential computing](/azure/confidential-computing/overview)

These capabilities need to be carefully considered in the architecture of your organization's overall environment and for individual workloads. Policy enforcement is a relatively lightweight method to support compliance, although it could restrict which services you can use and how you can use them. Technical assurance by comparison is restrictive because it's only available with few services today and requires a significant knowledge investment.

## How the cloud changes operations

Adopting the cloud, means to adopt a shared responsibility model and it's key to understand which responsibilities shift to the cloud provider and which remain with you. Compliance documentation often describes that in great detail. A higher level view is available from product documentation on various topics:

- Protection of the physical infrastructure is described in [Azure infrastructure security](/azure/security/fundamentals/infrastructure).

- Protection against various threats to the platform and the technical assurance processes are described in [Azure platform integrity and security](/azure/security/fundamentals/platform).

- Data residency is a shared responsibility, with the cloud provider enabling customers to select where data must be stored and processed. This is discussed further in [Data Residency in Azure](https://azure.microsoft.com/explore/global-infrastructure/data-residency/). For customers in the EU, the [Microsoft EU Data Boundary](https://www.microsoft.com/trust-center/privacy/european-data-boundary-eudb) offers extra data residency commitments.

- Business continuity is a shared responsibility, with the cloud provider ensuring continuity of critical systems to operate the cloud and providing customers with different continuity option depending on the service. This is discussed further in [Azure reliability documentation](/azure/reliability/).

- While the cloud provider is responsible for securing access to the cloud platform, both from internal and external threats, customers are responsible for the configuration of their systems to secure their data through identity & access management, encryption, and other security measures. This is discussed further in [Define a security strategy](/azure/cloud-adoption-framework/strategy/define-security-strategy).

## Differentiating by data classification

Different types of data and workloads can have different sovereignty requirements. This might depend on factors such as confidentiality of the data and whether it contains privacy sensitive data. It's important to understand which data classifications apply to your organization and which data and systems are subject to which classifications. Some data and applications can be subject to multiple regulations, potentially leading to combined requirements. For example, there might be a regulation around confidentiality of data and around criticality of systems, and this could result in classifications such as high confidentiality and low criticality or medium confidentiality and high criticality.

Complying with sovereignty requirements could affect other considerations, such as cost, resilience, scalability, security, and service richness. Applying the right controls to a particular data classification should be at the core of your sovereignty strategy. A one-size-fits-all approach leads to an environment that favors the highest compliance requirements, which is likely the costliest, while getting the least benefits from using cloud services.
