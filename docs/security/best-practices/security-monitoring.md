---
title: Security Title
description: Security Description
author: GitHubAlias
ms.author: msftalias
ms.date: 04/04/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: secure
ms.custom: internal
---

# Generic space holder - remember to edit the metadata before publication

## This article should cover all of the items under the "monitoring security events" question at the CAF level

- Tools like Azure Security Center are used to discover and remediate common risks within Azure tenants.Identifying and remediating common security hygiene risks significantly reduces overall risk to the organization by increasing cost to attackers. Azure Secure Score in Azure Security Center monitors the security posture of machines, networks, storage and data services, and applications to discover potential security issues (internet connected VMs, or missing security updates, missing endpoint protection or encryption, deviations from baseline security configurations, missing Web Application Firewall (WAF), and more).
- A central SecOps team monitors security related telemetry data for this workload.Organization is monitoring the security posture across workloads and central SecOps team is monitoring security-related telemetry data and investigating security breaches.
- The security team has read-only access into all cloud environment resources for this workload.Provide security teams read-only access to the security aspects of all technical resources in their purview. Security organizations require visibility into the technical environment to perform their duties of assessing and reporting on organizational risk. Without this visibility, security will have to rely on information provided from groups, operating the environment, who have a potential conflict of interest (and other priorities). Note that security teams may separately be granted additional privileges if they have operational responsibilities or a requirement to enforce compliance on Azure resources. For example in Azure, assign security teams to the Security Readers permission that provides access to measure security risk (without providing access to the data itself). Because security will have broad access to the environment (and visibility into potentially exploitable vulnerabilities), you should consider them critical impact accounts and apply the same protections as administrators.
- The security team has access to and monitor all subscriptions and tenants that are connected to the existing cloud environment, relative to this workload.Ensure the security organization is aware of all enrollments and associated subscriptions connected to the existing environment and is able to monitor those resources as part of the overall enterprise security posture.
- Identity related risk events related to potentially compromised identities are actively monitored.Most security incidents take place after an attacker initially gains access using a stolen identity. These identities can often start with low privileges, but attackers then use that identity to traverse laterally and gain access to more privileged identities. This repeats as needed until the attacker controls access to the ultimate target data or systems. Reported risk events for Azure AD can be viewed in Azure AD reporting, or Azure AD Identity Protection. Additionally, the Identity Protection risk events API can be used to programmatically access identity related security detections using Microsoft Graph.
- Communication, investigation and hunting activities are aligned with the workload team.Development team needs to be aware of those activities to align their security improvement activities with the outcome of those activities.
- Periodic & automated access reviews of the workload are conducted to ensure that only authorized people have access?As people in the organization and on the project change, it is crucial to make sure that only the right people have access to the application infrastructure. Auditing and reviewing the access control reduces the attack vector to the application. Azure control plane depends on Azure AD and access reviews are often centrally performed often as part of internal or external audit activities. For the application specific access it is recommended to do the same at least twice a year.
- Cloud application security broker (CASB) is leveraged in this workload.CASBs provide rich visibility, control over data travel, and sophisticated analytics to identify and combat cyberthreats across all Microsoft and third-party cloud services.
- A designated point of contact was assigned for this workload to receive Azure incident notifications from Microsoft.
