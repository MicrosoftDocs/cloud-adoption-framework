---
title: Security, governance, and compliance for enterprise-scale cloud-scale analytics
description: Learn how to improve security, governance, and compliance for enterprise-scale cloud-scale analytics in Azure.
author: Zimmergren
ms.author: tozimmergren
ms.date: 11/27/2024
ms.topic: conceptual
ms.custom: e2e-data-management, think-tank
---

# Security, governance, and compliance for cloud-scale analytics

When planning cloud-scale analytics architecture, pay special attention to ensure that the architecture is robust and secure. This article addresses security, compliance, and governance design criteria for enterprise-scale cloud-scale analytics. This article also discusses design recommendations and best practices for deployment of a cloud-scale analytics on Azure. Review [enterprise-scale security governance and compliance](../../ready/landing-zone/design-area/governance.md) to fully prepare for governance of an enterprise solution.

Cloud solutions initially hosted single, relatively isolated applications. As the benefits of cloud solutions became clear, larger-scale workloads were hosted in the cloud, such as SAP on Azure. So it became vital to address the security, reliability, performance, and cost of regional deployments throughout the lifecycle of cloud services.

The vision for cloud-scale analytics landing zone security, compliance, and governance on Azure is to provide tools and processes that help you minimize risk and make effective decisions. The Azure landing zones define security governance and compliance roles and responsibilities.

Cloud-scale analytics pattern relies on several security features that can be enabled in Azure. These features include encryption, role-based access control, access control lists, and networking restrictions.

## Security design recommendations

Both Microsoft and customers share responsibility for security. For accepted security guidance, refer to [Cybersecurity best practices](https://www.cisecurity.org/cybersecurity-best-practices/) by the Center for Internet Security. The following sections are security design recommendations.

### Data-at-rest encryption

Data-at-rest encryption refers to the encryption of data as it persists in storage, and addresses the security risks related to direct physical access of storage media. Data-at-rest is a critical security control since the underlying data is unrecoverable and can't be changed without its decryption key. DData-at-rest is an important layer in the defense-in-depth strategy of Microsoft datacenters. Often, there are compliance and governance reasons to deploy data-at-rest encryption.

Several Azure services support data-at-rest encryption, including Azure Storage and Azure SQL databases. Although common concepts and models influence the design of Azure services, each service can apply data-at-rest encryption at different stack layers or have different encryption requirements.

> [!IMPORTANT]
> All services that support data-at-rest encryption should have it enabled by default.

### Secure data in transit

Data is considered in transit or in flight when it moves from one location to another. This transit can occur internally, on-premises or within Azure, or externally, such as across the internet to an end user. Azure offers several mechanisms, including encryption, to keep data private during transit. These mechanisms include:

- Communication through VPNs using IPsec/IKE encryption.
- Transport Layer Security (TLS)
- Protocols available on Azure Virtual Machines, such as Windows IPsec or SMB.

Encryption using MACsec (media access control security), an IEEE standard at the data-link layer, is automatically enabled for all Azure traffic between Azure datacenters. This encryption ensures customer data confidentiality and integrity. For more information, see [Azure customer data protection](/azure/security/fundamentals/protection-customer-data).

### Manage keys and secrets

To control and manage disk encryption keys and secrets for cloud-scale analytics, use Azure Key Vault. Key Vault has capabilities for provisioning and managing SSL/TLS certificates. You can also protect secrets with hardware security modules (HSMs).

### Microsoft Defender for Cloud

Microsoft Defender for Cloud provides security alerts and advanced threat protection for virtual machines, SQL databases, containers, web applications, virtual networks, and more.

When you enable Defender for Cloud from the pricing and settings area, the following Microsoft Defender plans are enabled simultaneously and provide comprehensive defenses for the compute, data, and service layers of your environment:

- [Microsoft Defender for servers](/azure/security-center/defender-for-servers-introduction?branch=master)
- [Microsoft Defender for App Service](/azure/security-center/defender-for-app-service-introduction)
- [Microsoft Defender for Storage](/azure/security-center/defender-for-storage-introduction)
- [Microsoft Defender for SQL](/azure/security-center/defender-for-sql-introduction)
- [Microsoft Defender for Kubernetes](/azure/security-center/defender-for-kubernetes-introduction)
- [Microsoft Defender for container registries](/azure/security-center/defender-for-container-registries-introduction)
- [Microsoft Defender for Key Vault](/azure/security-center/defender-for-key-vault-introduction)
- [Microsoft Defender for Resource Manager](/azure/security-center/defender-for-resource-manager-introduction)
- [Microsoft Defender for DNS](/azure/security-center/defender-for-dns-introduction)

These plans are explained separately in the Defender for Cloud documentation.

> [!IMPORTANT]
> Where Defender for Cloud is available for platform as a service (PaaS) offerings, you should enable this feature by default, especially for Azure Data Lake Storage accounts. For more information, see [Introduction to Microsoft Defender for Cloud](/azure/security-center/azure-defender) and [configure Microsoft Defender for Storage](/azure/storage/common/azure-defender-storage-configure?tabs=azure-security-center).

### Microsoft Defender for Identity

Microsoft Defender for Identity is part of the advanced data security offering, which is a unified package for advanced security capabilities. Microsoft Defender for Identity can be accessed and managed via the Azure portal.

> [!IMPORTANT]
> Enable Microsoft Defender for Identity by default whenever it's available for the PaaS services you use.

### Enable Microsoft Sentinel

[Microsoft Sentinel](/azure/sentinel/overview) is a scalable, cloud-native, security information event management (SIEM), and security orchestration automated response (SOAR) solution. Microsoft Sentinel delivers intelligent security analytics and threat intelligence across the enterprise, providing a single solution for alert detection, threat visibility, proactive hunting, and threat response.

## Networking

Cloud-scale analytics prescribed view is to use Azure private endpoints for all PaaS services and not uses public IPs for all infrastructure as a service (IaaS) services. For more information, see [Cloud-scale analytics networking](./eslz-network-topology-and-connectivity.md).

## Compliance and governance design recommendations

[Azure Advisor](/azure/advisor/advisor-overview) helps you get a consolidated view across your Azure subscriptions. Consult Azure Advisor for reliability, resiliency, security, performance, operational excellence, and cost recommendations. The following sections are compliance and governance design recommendations.

### Use Azure Policy

[Azure Policy](/azure/governance/policy/overview) helps enforce organizational standards and assess compliance at scale. Through its compliance dashboard, it provides an aggregated view of the overall state of the environment, with the ability to drill down into individual resources or policies.

Azure Policy helps bring your resources into compliance through bulk remediation of existing resources and automatic remediation of new resources. Several built-in policies are available, for example to restrict the location of new resources, require a tag and its value on resources, create a VM using a managed disk, or enforce naming policies.

### Automate deployments

You can save time and reduce errors by automating deployments. Reduce the deployment complexity of end-to-end data landing zones and data applications (which create data products) by creating reuseable code templates. This automation minimizes the time to deploy or redeploy solutions. For more information, see [Understand DevOps automation for the cloud-scale analytics in Azure](../cloud-scale-analytics/manage.md)

### Lock resources for production workloads

Create required core data management and data landing zone Azure resources at the start of your project. When all additions, moves, and changes are finished, and the Azure deployment is operational, lock all resources. Then, only an administrator can unlock or modify resources. For more information, see [Lock resources to prevent unexpected changes](/azure/azure-resource-manager/management/lock-resources).

### Implement role-based access control

You can customize role-based access control (RBAC) on Azure subscriptions to manage who has access to Azure resources, what they can do with those resources, and what areas they have access to. For example, you can allow team members to deploy core assets to a data landing zone, but prevent them from altering any of the network components.

### Compliance and governance scenarios

The following recommendations apply to various compliance and governance scenarios. These scenarios represent a cost-effective and scalable solution.

| Scenario | Recommendation |
|-|-|
| Configure a governance model with standard naming conventions, and pull reports based on cost center. | Use Azure Policy and tags to meet your requirements. |
| Avoid accidental deletion of Azure resources. | Use Azure resource locks to prevent accidental deletion. |
| Get a consolidated view of opportunity areas for cost optimization, resiliency, security, operational excellence, and performance for Azure resources. | Use Azure Advisor to get a consolidated view across SAP on Azure subscriptions. |

## Next steps

[Azure policies for cloud-scale analytics](./eslz-policies.md)
