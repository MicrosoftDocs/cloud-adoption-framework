---
title: Security Title
description: Security Description
author: joanabmartins
ms.author: joamar
ms.date: 22/04/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: secure
ms.custom: internal
---

# Security Monitoring
Monitoring is a critical component of cloud security and management. In this article, we give you some best practices to have in mind to efficiently monitor the security of your environment.

## Azure Security Center 
Keeping your resources safe is a joint effort between your cloud provider, Azure, and you, the customer. [Azure Security Center](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-setup-guide/govern-org-compliance?tabs=AzureSecurityCenter) helps you understand what Microsoft is already addressing in trems of security vs what is your responsability, providing you the tools needed to harden your network, secure your services and make sure you're on top of your security posture. 

Azure Security Center covers two broad pillars of cloud security:

* **Cloud security posture management (CSPM)** - Free service that allows you to manage and track compliance based on several built-in policies, and associating them with a [Secure Score](https://docs.microsoft.com/en-us/azure/security-center/secure-score-security-controls) 
* **Cloud Workload protection (CWP)** - [Azure Defender](https://docs.microsoft.com/en-us/azure/security-center/azure-defender) brings advanced, intelligent, protection of your Azure and hybrid resources and workloads.

## Sentinel
[Azure Sentinel](https://docs.microsoft.com/en-us/azure/sentinel/overview) is a scalable, cloud-native, **security information event management (SIEM)** and **security orchestration automated response (SOAR)** solution. Azure Sentinel delivers intelligent security analytics and threat intelligence across the enterprise, providing a single solution for alert detection, threat visibility, proactive hunting, and threat response. 

As today's cyberattacks are more advanced than ever before, it makes sense to use Azure Sentinel as your birds-eye view across the enterprise. Some of its characteristics inluces:

* Collect data from different data sources

* Detect previously undetected threats

* Investigate and hunt threats and suspicious activities with artificial intelligence

* Respond to incidents 

Note: Not all environments require such a sophisiticate tool like Sentinel to keep them protected. However, there should be thoughtout processes for investigating, hunting and communiting security events. 

## SecOps Team 
The main objective of a [cloud security operations center (SOC)](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/organize/cloud-security-operations-center) is to detect, respond to, and recover from active attacks on enterprise assets.

As the SOC matures, security operations should:

* Reactively respond to attacks detected by tools
* Proactively hunt for attacks that slipped past reactive detections

### SecOps Team Access 
Security organizations require visibility into the technical environment to perform their duties. Ensure the security organization is aware of all enrollments and associated subscriptions connected to the existing environment and is able to monitor those resources as part of the overall enterprise security posture. 

Nevertheless, you should always:
- Restrict access based on [need to know and least privilege](https://docs.microsoft.com/en-us/azure/security/fundamentals/identity-management-best-practices?bc=%2fazure%2fcloud-adoption-framework%2f_bread%2ftoc.json&toc=%2fazure%2fcloud-adoption-framework%2ftoc.json#use-role-based-access-control) security principles. 
- Pleaser refer to this article on [RBAC](https://docs.microsoft.com/en-us/azure/role-based-access-control/overview), for guidance on how to ensure it.

## Identity monitoring 
Identity is increasingly considered the primary security perimeter in the cloud, which is a shift from the traditional focus on network security. Identity services provide the core mechanisms supporting access control and organization within IT environments, and the [Identity Baseline](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/govern/identity-baseline/) discipline complements the [Security Baseline](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/govern/security-baseline/) discipline by consistently applying authentication and authorization requirements across cloud adoption efforts. It is really important that you define the [metrics, indicators and risk tolerance](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/govern/identity-baseline/metrics-tolerance) associated with your Identity Baseline and that you actively incorporate monitoring it in your security processes.

There are also serveral [identity management and access control security best practices](https://docs.microsoft.com/en-us/azure/security/fundamentals/identity-management-best-practices?bc=%2fazure%2fcloud-adoption-framework%2f_bread%2ftoc.json&toc=%2fazure%2fcloud-adoption-framework%2ftoc.json) that you should consider following:
* Treat identity as the primary security perimeter
* Centralize identity management
* Manage connected tenants
* Enable single sign-on
* Turn on Conditional Access
* Plan for routine security improvements
* Enable password management
* Enforce multi-factor verification for users
* Use role-based access control
* Lower exposure of privileged accounts
* Control locations where resources are located
* Use Azure AD for storage authentication

For bigger and more complexed environments there are several [other considerations](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/enterprise-scale/identity-and-access-management) that you should take into consideration, such as, using the capabilities for Azure AD Premium P2 that will allow you to do [Access Reviews](https://docs.microsoft.com/en-us/azure/active-directory/governance/access-reviews-overview) and use just-in-time access to Azure AD  and Azure resources (with [Priviledge Identity Management](https://docs.microsoft.com/en-us/azure/active-directory/governance/access-reviews-overview)).


## Accountability
To ensure accountability, we recommend following these steps:
- Designate who is responsible for monitoring and making each type of security decision for the enterprise Azure environment. Estabilish Clear ownership of security areas speeds up cloud adoption and increases security. Lack of, typically creates friction. This friction frequently impedes business goals, developer timelines, IT goals, and security assurances. 
- [Document these owners,](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/security/security-top-10#3-process-assign-accountability-for-cloud-security-decisions) their contact information, and socialize this widely within the security, IT, and cloud teams to ensure it's easy for all roles to contact them. 

It is also extremelly important to make sure you have set the right owners for [Azure incident notifications](https://docs.microsoft.com/en-us/azure/service-health/alerts-activity-log-service-notifications-portal) from Microsoft.
