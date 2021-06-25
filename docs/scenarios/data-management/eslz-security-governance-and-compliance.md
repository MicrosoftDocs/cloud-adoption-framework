---
title: "Enterprise-Scale security, governance, and compliance for 'data management and analytics' in Azure"
description: Describe how this enterprise-scale scenario can improve security, governance, and compliance of 'data management and analytics'
author: andrehass
ms.author: anhass
ms.date: 06/21/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Security, governance, and compliance for 'data management and analytics' Enterprise-Scale scenario

 When planning data management and analytics architecture, you should pay special attention to ensuring that the architecture is robust and secure. The goal of this article is to document the security, compliance, and governance design criteria for enterprise-scale data management and analytics on Azure. The article discusses design recommendations, best practices, and design considerations specific to the deployment of the construction set on Azure. To fully prepare for governance of an enterprise solution, it is important to review the guidance in the [enterprise-scale design area for security governance and compliance](../../ready/enterprise-scale/security-governance-and-compliance.md)

Cloud solutions initially hosted single, relatively isolated applications. As the benefits of cloud solutions became clear, the cloud hosted many larger-scale workloads, like SAP on Azure. Addressing security, reliability, performance, and cost concerns of deployments in one or more regions became vital throughout the lifecycle of cloud services.

The vision for data management and analytics enterprise-scale landing zone security, compliance, and governance on Azure is to give organizations tools and processes to prevent risk and make effective decisions. The enterprise-scale landing zones defines security governance and compliance roles and responsibilities, so everyone knows what is expected from them.

The Enterprise Analytics and AI construction set pattern relies on a number of security features which can be enabled on Azure. They include Encryption, Role-Based Access Control, Access Control Lists, and Networking restrictions.

## Security design recommendations

Security is a shared responsibility between Microsoft and customers. For generally-accepted security guidance, refer to the [cybersecurity best practices](https://www.cisecurity.org/cybersecurity-best-practices/) from the Center for Internet Security (CIS).

### Data-at-Rest Encryption

Data-at-Rest (DaR) encryption refers to the encryption of data as it persists in storage. DaR encryption is a critical security control by Microsoft as it addresses security risks related to direct physical access to storage media as the underlying data is not recoverable and cannot be changed without the underlying decryption key. This makes it an important layer in the defense-in-depth strategy of Microsoft data centers. In addition, there are often compliance and governance reasons to deploy DaR encryption.

There are multiple services that support DaR encryption, including Storage Accounts and SQL Databases. Additionally, each service may apply DaR encryption at different layers in the stack. Each specific service referenced in this document that has a specific DaR encryption requirement will be addressed in the relevant section. However, there are common concepts and models to be addressed that influence the design decisions of services throughout the Azure stack.

>[!IMPORTANT]
>All services which support Encryption at Rest should have it enabled by default.

### Secure data in transit

Data is in transit or in flight when it moves from one location to another, whether internally on-premises or within Azure, or externally, like across the internet to the end user. Azure offers several mechanisms to keep data private in transit. All the mechanisms can use protection methods like encryption. These mechanisms include:

- Communication through virtual private networks (VPNs), using IPsec/IKE encryption
- Transport Layer Security (TLS) 1.2 or later via Azure components like Azure Application Gateway or Azure Front Door
- Protocols available on the Azure VMs, like Windows IPsec or SMB

Encryption using MACsec, an IEEE standard at the data-link layer, is automatically enabled for all Azure traffic between Azure datacenters. This encryption ensures customer data confidentiality and integrity. For more information, see [Azure customer data protection](/azure/security/fundamentals/protection-customer-data).

### Manage keys and secrets

To control and manage disk encryption keys and secrets for the construction set, use Azure Key Vault. Key Vault has capabilities for provisioning and managing SSL/TLS certificates. You can also protect secrets with hardware security modules (HSMs).

### Azure Defender

Azure Defender provides security alerts and advanced threat protection for virtual machines, SQL databases, containers, web applications, virtual networks, and more.

When you enable Azure Defender from the **Pricing and settings** area of Azure Security Center, the following Defender plans are all enabled simultaneously and provide comprehensive defenses for the compute, data, and service layers of your environment:

- [Azure Defender for servers](/azure/security-center/defender-for-servers-introduction)
- [Azure Defender for App Service](/azure/security-center/defender-for-app-service-introduction)
- [Azure Defender for Storage](/azure/security-center/defender-for-storage-introduction)
- [Azure Defender for SQL](/azure/security-center/defender-for-sql-introduction)
- [Azure Defender for Kubernetes](/azure/security-center/defender-for-kubernetes-introduction)
- [Azure Defender for container registries](/azure/security-center/defender-for-container-registries-introduction)
- [Azure Defender for Key Vault](/azure/security-center/defender-for-key-vault-introduction)
- [Azure Defender for Resource Manager](/azure/security-center/defender-for-resource-manager-introduction)
- [Azure Defender for DNS](/azure/security-center/defender-for-dns-introduction)

Each of these plans is explained separately in the Security Center documentation.

>[!IMPORTANT]
>Where this Azure Defender is available for the PaaS Services, we recommend enabling this feature by default, especially for the Azure Data Lake Storage accounts. See [Introduction to Azure Defender](/azure/security-center/azure-defender) and [Configure Azure Defender for Storage](/azure/storage/common/azure-defender-storage-configure?tabs=azure-security-center) for further details.

### Advanced Threat Protection

Advanced Threat Protection is part of the Advanced Data Security offering, which is a unified package for advanced security capabilities. Advanced Threat Protection can be accessed and managed via the Azure portal.

Where Advanced Threat Protection is available for the PaaS Services, we recommend enabling this feature by default.

### Enable Azure Sentinel

[Azure Sentinel](/azure/sentinel/overview) is a scalable, cloud-native, security information event management (SIEM) and security orchestration automated response (SOAR) solution. Azure Sentinel delivers intelligent security analytics and threat intelligence across the enterprise, providing a single solution for alert detection, threat visibility, proactive hunting, and threat response.

## Networking

The Enterprise Scale Analytics and AI prescribed view is to use Private Endpoints for all PaaS services and no public IPs for any IaaS (Infrastructure-as-a-Service). See [Enterprise Scale Analytics and AI Networking](./eslz-network-topology-and-connectivity.md).

## Compliance and governance design recommendations

[Azure Advisor](/azure/advisor/advisor-overview) is free and helps you get a consolidated view across your Azure subscriptions. Consult the Azure Advisor recommendations for reliability, resiliency, security, performance, cost, and operational excellence design recommendations.

### Use Azure Policy

Azure Policy helps enforce organizational standards and assess compliance at scale through its compliance dashboard. Azure Policy provides an aggregated view to evaluate the overall state of the environment, with the ability to drill down to per-resource, per-policy granularity.

Azure Policy also helps bring your resources to compliance through bulk remediation for existing resources and automatic remediation for new resources. Sample Azure policies are applying allowed locations to management group, requiring a tag and its value on resources, creating a VM using a managed disk, or naming policies.

### Automate deployments

Save time and reduce errors by automating deployments. Reduce the complexity of deploying end to end data landing zones, data integrations and data products by creating reuseable code templates. This will lessen the time to deploy or redeploy solutions.  For more information, see [DataOps Overview](dataops.md)

### Lock resources for production workloads

Create required core data management and data landing zone Azure resources at the start of your project. When all additions, moves, and changes are finished, and the Azure deployment is operational, lock all resources. Only a super administrator can then unlock and permit a resource, such as a data catalog, to be modified. For more information, see [Lock resources to prevent unexpected changes](/azure/azure-resource-manager/management/lock-resources).

### Implement role-based access control

Customize role-based access control (RBAC) roles on Azure spoke subscriptions to avoid accidental related changes. You can allow the data platform ops or data landing zone ops team members to deploy core assets to an data landing zone but restrict them from altering any of the network components.

### Compliance and governance scoping decisions

The following recommendations are for various compliance and governance scenarios. The in-scope requirements are for the solution to be cost-effective and scalable.

|Scope (scenario)  |Recommendation    |Notes          |
|---------|---------|---------|
|Configure a governance model for standard naming conventions, and pull reports based on cost center.     |     Azure Policy and Azure tags    |  Use Azure Policy and tagging together to meet the requirements.       |
|Avoid accidental deletion of Azure resources.      |   Azure resource locks      |    Azure resource locks prevent accidental resource deletion.      |
|Get a consolidated view of opportunity areas for cost optimization, resiliency, security, operational excellence, and performance for Azure resources     |    Azure Advisor              |    Azure Advisor is free and helps get a consolidated view across SAP on Azure subscriptions.      |
