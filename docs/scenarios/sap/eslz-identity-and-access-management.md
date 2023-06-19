---
title: Identity and access management for SAP on Azure
description: Learn more about design considerations and recommendations that relate to identity and access management in an SAP deployment on Microsoft Azure.
author: JefferyMitchell
ms.author: martinek
ms.date: 02/12/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-sap
---

<!-- docutune:casing LMS -->

# Identity and access management for SAP

This article builds on a number of considerations and recommendations defined in the Azure landing zone article [Azure landing zone design area for identity and access management](../../ready/landing-zone/design-area/identity-access.md). Following the guidance in this article will help examine design considerations and recommendations that relate to identity and access management specific to the deployment of an SAP platform on Microsoft Azure. Since SAP is an mission-critical platform, the guidance on the Azure landing zone design areas should also be included in your design.

**Design considerations:**

- Review the Azure administration and management activities you require your teams to do. Consider your SAP on Azure landscape. Determine the best possible distribution of responsibilities within your organization.

- Determine the Azure resource administration boundaries versus the SAP Basis administration boundaries between the infrastructure team and the SAP Basis team. Consider providing the SAP Basis team with elevated Azure resource administration access in an SAP non-production environment. For example, give them a [Virtual Machine Contributor](/azure/role-based-access-control/built-in-roles#virtual-machine-contributor) role. You can also give them partially elevated administration access like partial Virtual Machine Contributor in a production environment. Both options achieve a good balance between separation of duties and operational efficiency.

- Consider using Privileged Identity Management (PIM) and multifactor authentication to provide access to SAP Virtual Machine resources from Azure portal and the underlying infrastructure for central IT and SAP basis teams.

Here are common Azure admin activities involved in administration and management of SAP on Azure:

| Azure resource | Azure resource provider | Activities |
|---|---|---|
| Virtual machines | Microsoft.Compute/virtualMachines | Start, stop, restart, deallocate, deploy, redeploy, change, resize, extensions, availability sets, proximity placement groups |
| Virtual machines | Microsoft.Compute/disks | Read and write to disk |
| Storage | Microsoft.Storage | Read, change on storage accounts (for example boot diagnostics) |
| Storage | Microsoft.NetApp | Read, change on NetApp capacity pools and volumes |
| Storage | Microsoft.NetApp | ANF snapshots |
| Storage | Microsoft.NetApp | ANF Cross-region replication |
| Networking | Microsoft.Network/networkInterfaces | Read, create, change network interfaces |
| Networking | Microsoft.Network/loadBalancers | Read, create, change load balancers |
| Networking | Microsoft.Network/networkSecurityGroups | Read NSG |
| Networking | Microsoft.Network/azureFirewalls | Read firewall |

- If you're using SAP Business Technology Platform (BTP) services, consider using principal propagation to forward an identity from SAP BTP application to your SAP landscape using SAP Cloud Connector.

- Consider Azure AD Provisioning service to automatically provision and de-provision users and groups to [SAP Analytics Cloud](/azure/active-directory/saas-apps/sap-analytics-cloud-provisioning-tutorial) and [SAP Identity Authentication](/azure/active-directory/saas-apps/sap-cloud-platform-identity-authentication-provisioning-tutorial).

- Consider a migration to Azure an opportunity to review and realign identity and access management processes. Review the processes in your SAP landscape and the processes at your enterprise level:
  - Review SAP dormant user lockout policies.
  - Review SAP user password policy and align it with Azure Active Directory (Azure AD).
  - Review leavers, movers, and starters (LMS) procedures and align them with Azure AD. If you're using SAP Human Capital Management (HCM), it's likely that SAP HCM drives the LMS process.

- Consider provisioning users from [SuccessFactors Employee Central](/azure/active-directory/saas-apps/sap-successfactors-inbound-provisioning-cloud-only-tutorial) into Azure Active Directory, with optional write-back of email address to SuccessFactors.

- Secure Network File System (NFS) communication between Azure NetApp Files and Azure Virtual Machines with [NFS client encryption using Kerberos](/azure/azure-netapp-files/configure-kerberos-encryption). Azure NetApp Files supports both Active Directory Domain Services (AD DS) and Azure Active Directory Domain Services for Azure AD connections. Consider the [performance impact of Kerberos on NFS v4.1](/azure/azure-netapp-files/configure-kerberos-encryption#kerberos_performance).

- SAP Identity Management (IDM) integrates with Azure AD using SAP cloud identity provisioning as a proxy service. Consider Azure AD as a central data source for users if you are using SAP IDM. Secure the Network File System (NFS) communication between Azure NetApp Files and Azure Virtual Machines with NFS client encryption using Kerberos. Azure NetApp Files requires either Active Directory Domain Services (AD DS) or Azure Active Directory Domain Services connection (AADDS) for Kerberos ticketing. Consider the performance impact of Kerberos on NFS v4.1.

- Secure Remote Function Call (RFC) connections between SAP systems with secure network communications (SNC) using appropriate protection level like quality of protection (QoP). SNC protection generates some performance overhead. To protect RFC communication between application servers of the same SAP system, SAP recommends using network security instead of SNC. As of this writing, the following Azure services support SNC-protected RFC connections to an SAP target system: Providers of Azure Monitor for SAP Solutions, the self-hosted integration runtime in Azure Data Factory, and the on-premises data gateway in case of Power BI, Power Apps, Power Automate, Azure Analysis Services, and Azure Logic Apps. SNC is required to configure single sign-on (SSO) in these cases.

**Design recommendations:**

- Implement SSO using Windows AD, Azure AD or Active Directory Federation Services (AD FS) depending on the access type so that the end 
  users can connect to SAP applications without a user ID and password once they are successfully authenticated by the central identity provider. 
  - Implement SSO to SAP SaaS applications like [SAP Analytics Cloud](/azure/active-directory/saas-apps/sapboc-tutorial), [SAP Cloud Platform](/azure/active-directory/saas-apps/sap-hana-cloud-platform-tutorial), [Business by design](/azure/active-directory/saas-apps/sapbusinessbydesign-tutorial), [SAP Qualtrics](/azure/active-directory/saas-apps/qualtrics-tutorial) and [SAP C4C](/azure/active-directory/saas-apps/sap-customer-cloud-tutorial) with Azure AD using SAML.
  - Implement SSO to [SAP NetWeaver](/azure/active-directory/saas-apps/sap-netweaver-tutorial)-based web applications like [SAP Fiori](/azure/active-directory/saas-apps/sap-fiori-tutorial), SAP Web GUI, and so on, with SAML. 
  - You can implement SSO to SAP GUI using either SAP NetWeaver SSO or a partner solution.
  - For SSO for SAP GUI and web browser access, implement SNC – Kerberos/SPNEGO (Simple and Protected GSSAPI Negotiation Mechanism) due to its ease of configuration and maintenance. For SSO with X.509 client certificates, consider SAP Secure Login Server that is a component of SAP Single Sign-On (SSO) solution. 
  - Implement [SSO using OAuth for SAP NetWeaver](/azure/active-directory/saas-apps/sap-netweaver-tutorial#configure-sap-netweaver-for-oauth) to allow third-party or custom applications to access SAP NetWeaver OData services.
  - Implement [SSO to SAP HANA](/azure/active-directory/saas-apps/saphana-tutorial)

- Consider AAD is identity provider for SAP systems hosted on RISE. Please see details [here](https://help.sap.com/docs/identity-authentication/identity-authentication/integrating-service-with-microsoft-azure-ad). https://help.sap.com/docs/IDENTITY_AUTHENTICATION/6d6d63354d1242d185ab4830fc04feb1/626b17331b4d4014b8790d3aea70b240.htmlFor applications that access SAP, you may want to use [principal propagation to establish SSO](https://github.com/azuredevcollege/SAP/blob/master/sap-oauth-saml-flow/README.md)

- If you're using SAP BTP services or SaaS solutions that require SAP Identity Authentication Service (IAS), [consider implementing SSO between SAP Cloud Identity Authentication Services and Azure Active Directory](/azure/active-directory/saas-apps/sap-hana-cloud-platform-identity-authentication-tutorial) to access those SAP services. This integration lets SAP IAS act as a proxy identity provider and forward authentication requests to Azure AD as the central user store and identity provider.

- If you're using SAP SuccessFactors, it's recommended to use the [automated user provisioning](/azure/active-directory/saas-apps/sap-successfactors-inbound-provisioning-cloud-only-tutorial) feature of Azure AD. With this integration, as you add new employees to SAP SuccessFactors, you can automatically create their user accounts in Azure AD. Optionally, user accounts can be created in Microsoft 365 and other SaaS applications supported by Azure AD. Use write-back of the email address to SAP SuccessFactors.
