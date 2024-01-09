---
title: Define a sovereignty strategy
description: Learn how to define a sovereignty strategy when you use cloud services, so you can meet the sovereignty requirements of your country/region.
author: mboswell
ms.author: mboswell
ms.date: 01/08/2024
ms.topic: conceptual
---

# Define a sovereignty strategy

This article describes how to plan your sovereignty strategy when you use cloud services. Many geopolitical regions have regulations for handling specific types of data, such as privacy-sensitive data and government data. The regulations typically enforce sovereignty requirements related to data residency, the control over data, and sometimes operational independence (referred to as *autarky*).

When your organization needs to adhere to these regulations, you should define a strategy to meet the sovereignty requirements. If your organization shifts from on-premises services to cloud services, you must adjust the sovereignty strategy accordingly.

## Modernize your sovereignty strategy

For your on-premises datacenter, you're responsible for most aspects that are typically associated with sovereignty, including:

- Datacenters, where data is stored and processed.
- Access to the datacenters and physical infrastructure.
- Hardware and software, including the hardware and software supply chain.
- Assurance processes that validate hardware and software.
- Infrastructure and processes that ensure business continuity if there's a disaster or geopolitical event.
- Configurations and processes that determine who has access to which data and systems.
- Tools and processes that secure data and systems against outside and inside threats.

When you adopt cloud services, the responsibility of these aspects shifts to a [shared responsibility](/azure/security/fundamentals/shared-responsibility). Your compliance team changes the strategy that they use to determine if sovereignty requirements are met. The compliance team considers:

- The compliance of the cloud services. How do the cloud provider's services meet sovereignty and compliance requirements?

- The compliance of the systems and processes that your organization is responsible for. Which tools are available to help you meet sovereignty and compliance requirements, and how do you use these tools?

The compliance team might need to work with a regulator to get permission to use alternative methods that achieve the same goals. In some cases, a regulation might need to be changed by adding more options or adjusting a directive to use a certain solution to obtain an intended result. Changing regulation can be a lengthy process. However, it might be possible to get exemptions if you can demonstrate you have achieved the intent of a regulation.

For example, a regulation might restrict organizations from using certain cloud services because the isolation requirements can only be met with hardware isolation that's typically not available in the cloud. But the intended result can also be obtained with virtual isolation. As part of your strategy, you need to determine how to work with regulators and auditors when these potential blockers arise.

For more information about how to meet your compliance and sovereignty needs, see [Microsoft Cloud for Sovereignty](/industry/sovereignty).

### Compliance of cloud services

The compliance team uses various sources and methods to verify cloud service compliance, including:

- **Vendor documentation** about how their services work and how to use them, for example the US Federal Risk and Authorization Management Program ([FedRAMP](https://servicetrust.microsoft.com/viewpage/FedRAMP)) product documentation and system security plans.

- **Independent auditor certifications** that certify compliance to global, regional, and industry compliance frameworks. For more information, see [Compliance offerings for Microsoft 365, Azure, and other Microsoft services](/compliance/regulatory/offering-home).

- **Audit reports** that independent auditors create to provide insights into how cloud services meet the requirements of global, regional, and industry compliance frameworks. Some audit reports are available in the [Service Trust Portal](https://servicetrust.microsoft.com).

- **Audits** that are performed by or on behalf of the compliance team via vendor audit offerings, such as the [Government Security Program](https://www.microsoft.com/securityengineering/gsp) (available to select customers only).

- [**Transparency logs**](/industry/sovereignty/transparency-logs) that provide details about when Microsoft engineers access your resources.

The combination of sources and methods that your compliance team uses depends on the level of insight that you need, the trust you have in the different options, and your resources and budget. A third-party auditor certification eliminates the need for your team to perform an audit and costs less but requires trust in the auditor and audit process.

### Compliance of your systems and processes

Your organization's compliance processes and systems can benefit from the added capabilities of cloud services. You can use these capabilities to:

- Enforce or report on technical policies. For example, you might block the deployment of services or configurations or report on violations that don't meet technical requirements for sovereignty and compliance.

- Use pre-built policy definitions that are aligned to specific compliance frameworks.

- Log and monitor audits.

- Use security tools. For more information, see [Define a security strategy](/azure/cloud-adoption-framework/strategy/define-security-strategy).

- Perform technical assurance and monitoring capabilities, such as [Azure confidential computing](/azure/confidential-computing/overview).

Carefully consider these capabilities for your organization's environment and individual workloads. For each capability, consider the amount of effort needed, the applicability, and the function. For example, policy enforcement is a relatively simple method that supports compliance, but it can restrict which services you can use and how you can use them. In comparison, technical assurance takes considerable effort and is more restrictive because it's only available for a few services. It also requires a significant amount of knowledge.

### Adopt shared responsibility

When you adopt cloud services, you adopt a shared responsibility model. Determine which responsibilities shift to the cloud provider and which remain with you. Understand how those changes affect the sovereignty requirements for regulations. For more information, see the resources in [Compliance of cloud services](#compliance-of-cloud-services). To get a high-level view, consider the following resources:

- [Azure infrastructure security](/azure/security/fundamentals/infrastructure) describes how Microsoft provides protection for the physical infrastructure.

- [Azure platform integrity and security](/azure/security/fundamentals/platform) describes how Microsoft provides protection against threats to the platform and the technical assurance processes.

- [Data residency in Azure](https://azure.microsoft.com/explore/global-infrastructure/data-residency) describes data residency features. For customers in the European Union (EU), see [Microsoft EU Data Boundary](https://www.microsoft.com/trust-center/privacy/european-data-boundary-eudb).

The cloud provider partially provides business continuity via the resilience of the platform by ensuring the continuity of critical systems that operate the cloud. The services that a workload uses provide continuity options that you can use to build your workloads. Or you can use other services, such as [Azure Backup](/azure/backup/backup-overview) or [Azure Site Recovery](/azure/site-recovery/site-recovery-overview). For more information, see [Azure reliability documentation](/azure/reliability).

The cloud provider is responsible for securing access to the cloud platform from both internal and external threats. Customers are responsible for configuring their systems to secure their data through identity and access management, encryption, and other security measures. For more information, see [Define a security strategy](/azure/cloud-adoption-framework/strategy/define-security-strategy).

## Use classifications to differentiate data

Different types of data and workloads can have different sovereignty requirements, depending on factors such as the confidentiality of the data and whether it contains privacy-sensitive data. It's important to understand which data classifications apply to your organization and which data and systems are subject to which classifications. Some data and applications are subject to multiple regulations, which can create the need for combined requirements. For example, there might be a regulation related to the confidentiality of data and the criticality of a system. The resulting classifications might be high confidentiality and low criticality or medium confidentiality and high criticality.

When you comply with sovereignty requirements, it can affect other factors, such as cost, resilience, scalability, security, and service richness. For your sovereignty strategy, it's important to apply the right controls to a data classification. A one-size-fits-all approach leads to an environment that favors the highest compliance requirements, which is likely the costliest and least beneficial.

## Next steps

- [Cloud for Sovereignty](/industry/sovereignty) provides insights into sovereign capabilities on the Azure platform and describes how to address sovereignty requirements.

- Security and sovereignty aren't the same, but you can't be sovereign if you aren't secure. You must therefore [define a security strategy](/azure/cloud-adoption-framework/strategy/define-security-strategy) that integrates with your sovereignty strategy.
