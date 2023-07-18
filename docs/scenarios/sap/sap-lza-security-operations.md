---
title: Security operations for SAP on Azure
description: Learn how to implement a security operation for SAP in Microsoft Cloud to ensure your organization's sensitive data and applications are protected.
author: pankajmeshramCSA
ms.author: pameshra
ms.reviewer: tozimmergren
ms.date: 07/18/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-sap, UpdateFrequency2
---

# Security operations for SAP on Azure

This article is part of the "SAP extend and innovate security: Best practices" article series.

- [SQL Server database security for SAP on Azure](./sap-lza-database-security.md)
- [Microsoft Sentinel for SAP on Azure](./sap-lza-sentinel-for-sap.md)
- [Security operations for SAP on Azure](./sap-lza-security-operations.md)

This article describes best practices for security operations to secure your SAP environment in Azure. Implement a comprehensive security operation for SAP in Microsoft Cloud to ensure your organization's sensitive data and applications are protected from cyber threats.

## Access control

SAP systems are business-critical in an enterprise landscape. To ensure that only authorized personnel can access sensitive data and perform critical tasks, use the principle of least privilege when you provide control and management access to SAP systems and applications. Here are some relevant recommendations:

- Use **role-based access control (RBAC)** to manage access to SAP workload resources that deploy in Azure. Every Azure subscription has a trust relationship with an Azure Active Directory (Azure AD) tenant. Create an Azure AD group for SAP administrators, and use RBAC to grant permissions to the SAP group.

- **Single sign-on (SSO)** between SAP and Azure AD or Azure Directory Federation Services (AD FS) allows SAP users to access SAP applications with SAP front-end software, like SAP GUI, or a browser with HTTP or HTTPS, for example SAP Fiori.

- Use **Azure AD Privileged Identity Management (PIM)** to manage and assign roles to users and groups to allow them to perform privileged actions. These users only have access to the resources when they need to perform their job, such as stopping or starting a virtual machine (VM).

  PIM also provides automated access request and approval, logging, and auditing capabilities to manage and control privileged access to your SAP system resources.

- **Just-in-time (JIT) access** provides authorized personnel temporary elevated access to critical systems. With JIT access, administrators grant temporary access to a specific VM or set of VMs only when it's necessary to perform certain tasks, such as system maintenance or troubleshooting.

- When you run SAP on Azure, use **Azure Key Vault** to manage and protect sensitive data, such as SAP administrator passwords, SAP service account credentials, and encryption keys. Common scenarios to use Key Vault are:
  - **SAP password storage**: SAP systems require passwords for components, such as databases, application servers , and other SAP services. Use Key Vault to securely store these passwords. Retrieve them during system startup or when you need to access the SAP server.
  - **Encryption key storage**: SAP systems often require encryption for data protection. Use Key Vault to store encryption keys and protect them by using hardware security modules, which are tamper-resistant devices that protect cryptographic keys.
  - **Certificate storage**: Use Key Vault to store and manage SSL/TLS certificates, which are required for secure communication between SAP systems and other applications.

## Compliance

Azure provides a comprehensive set of security controls to help you protect your SAP systems that deploy in Azure. Here are some of the example compliance offerings that are relevant to SAP systems:

- **ISO/IEC 27001**: Azure is certified under the ISO/IEC 27001 standard, which provides a framework for implementing and maintaining an information
security management system (ISMS). This certification covers security controls and best practices, including network security, access control, and risk management.
- **SOC 1, SOC 2, and SOC 3**: Azure is audited under the service organization controls (SOC) framework, which provides a set of controls for service providers to manage customer data. SOC 1 is for financial reporting, SOC 2 is for security, availability, processing integrity, confidentiality, and privacy, and SOC 3 is for public disclosure of the SOC 2 report.
- **General Data Protection Regulation (GDPR)**: Azure is compliant with the GDPR, which is a data privacy regulation that applies to organizations that process personal data of individuals in the European Union (EU). This compliance offering includes features, like data protection, data breach notification, and privacy by design.

You can monitor this security baseline, review recommendations, and take remediation actions for noncompliance baseline for SAP workloads by using Microsoft Defender for Cloud.

:::image type="content" source="./media/sap-lza-defender.png" alt-text="Screenshot that shows the Defender for Cloud configuration." lightbox="./media/sap-lza-defender.png":::

## Security patches

For your SAP environment in Azure, there are two important types of security patching: operating system security patching and SAP security patching.

### Operating system security patches

Operating system security patches prevent security breaches, comply with industry regulations, improve performance, and protect your business' reputation. If you run Windows and Linux VMs in Azure, on-premises, or in other cloud environments, you can use the **Update management center** in Azure Automation to manage operating system updates, including security patches.

:::image type="content" source="./media/sap-lza-update-management.png" alt-text="Screenshot that shows the Update management center window." lightbox="./media/sap-lza-update-management.png":::

Critical and security updates are released each month. Automate updates and enable automatic VM guest patching to maintain security compliance for your SAP virtual machines.

> [!NOTE]
>Some Linux images for SAP workload, like Red Hat Enterprise Linux (RHEL) for SAP and SUSE Linux Enterprise Server (SLES) for SAP, aren't supported. Windows server images are supported. For information about requirements to enable automatic VM guest patching and supported operating system images, see [Automatic VM guest patching for Azure VMs](/azure/virtual-machines/automatic-vm-guest-patching#supported-os-images).

### SAP security patches

You can also protect the security of other SAP components, like databases and applications. For more information, see the related SAP notes in the [SAP support portal](https://support.sap.com).

Routinely review the SAP security OSS notes because SAP releases highly critical security patches, or hot fixes, that require immediate action to protect your SAP systems.

The Common Vulnerability Scoring System (CVSS) v3 base score of the SAP security note determines its priority. The CVSS is an open and vendor-neutral framework that determines the characteristics and severity of software vulnerabilities. It unifies the approaches to risk assessment across multiple vendors. CVSS is under the custodial care of the Forum of Incident Response and Security Teams (FIRST). For more information, see [SAP security notes and news](https://support.sap.com/en/my-support/knowledge-base/security-notes-news.html).

## Next steps

- [SQL Server database security for SAP on Azure](./sap-lza-database-security.md)
- [Microsoft Sentinel for SAP on Azure](./sap-lza-sentinel-for-sap.md)