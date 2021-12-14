---
title: Enterprise-scale security governance and compliance
description: Expand security to Arc and Hybrid
author: sitarant
ms.author: sitarant
ms.date: 12/14/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-hybrid, think-tank
---
### Enterprise-scale security governance and compliance

This article defines encryption and key management, helps you plan for governance, defines security monitoring and an audit policy, and enables you to plan for platform security.
At the end of this guidance, refer to tables that describes a framework to assess enterprise security readiness of Azure services.


### Secure public key

- The Azure connected machine agent uses public key authentication to communicate with the Azure service. After you onboard a server to Azure Arc, a private key is saved
  to the disk and used whenever the agent communicates with Azure.
- If stolen, the private key can be used on another server to communicate with the service and act as if it were the original server.
  This includes getting access to the system-assigned identity and any resources that identity has access to.
- The private key file is protected to only allow the hybrid Instance Metadata Service (himds) account access to read it.
  To prevent offline attacks, we strongly recommend the use of full disk encryption (for example, BitLocker, dm-crypt, and so on). On the operating system volume of your server.
  We recommend using Azure Policy guest configuration to [audit Windows or Linux machines](/azure/virtual-machines/policy-reference#microsoftcompute), 
  that have the specified applications installed, such as the one's mentioned.
  
  
### Threat protection and cloud security posture management

Microsoft Defender for Cloud provides a unified security-management platform segmented as a [cloud security posture management (CSPM)](/cloud-app-security/tutorial-cloud-platform-security) and cloud workload protection platform (CWPP). 
To increase security on your hybrid landing zone, it's important to protect the data and assets hosted in Azure and elsewhere. 
[Microsoft Defender for servers](/azure/security-center/defender-for-servers-introduction) extend these capabilities to Azure Arc-enabled servers 
and [Microsoft Defender for Endpoint](/microsoft-365/security/defender-endpoint/microsoft-defender-endpoint?view=o365-worldwide) 
provides [endpoint detection and response (EDR)](/mem/intune/protect/endpoint-security-edr-policy). 
To strengthen the security of your hybrid landing zone, consider the following:

- Use Azure Arc-enabled servers to onboard hybrid resources in [Microsoft Defender for Cloud](/azure/security-center/quickstart-onboard-machines?pivots=azure-portal).
- Implement an [Azure Policy guest configuration](/azure/azure-arc/servers/learn/tutorial-assign-policy-portal) 
  to make sure all resources are compliant and its security data is collected into the Log Analytics workspaces.
- Enable Microsoft Defender for all subscriptions and use Azure Policy to ensure compliance.
- Use security information and event management integration with Microsoft Defender for Cloud and [Microsoft Sentinel](/azure/azure-arc/servers/scenario-onboard-azure-sentinel).
- Protect your endpoints with Microsoft Defender for Cloud's integration with Microsoft Defender for Endpoint.
- For securing the connectivity between Azure Arc-enabled servers and Azure, 
  review the [Network connectivity for Azure Arc-enabled servers](./eslz-arc-servers-connectivity.md) section of this guide.
  
### Change Tracking and Inventory

Centralizing logs drives reports that can be used as additional layers of security and reduces the chances for gaps in observability. 
[Change Tracking and Inventory in Azure Automation](/azure/automation/change-tracking/overview) forward and collects the data in a Log Analytics workspace. 
When using Microsoft Defender for servers, you get File Integrity Monitoring (FIM) to examine and track software changes, for Windows services and Linux daemons 
on your Azure Arc-enabled servers.

