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

## This article should cover the "practices and tools implemented for secure development" question at the CAF level

- A list of dependencies, frameworks and libraries used by this workload is maintained and updated regularly.As part of the workload inventory the application team should maintain a framework and library list, along with versions in use. Understanding of the frameworks and libraries (custom, OSS, 3rd party, etc.) used by the application and the resulting vulnerabilities is important. There are automated solutions on the market that can help with this assessment: OWASP Dependency-Check, NPM audit or Whitesource Bolt.
- Framework and library updates are included into the workload lifecycle.Application frameworks are frequently provided with updates (e.g. security), released by the vendor or communities. Critical and important security patches need to be prioritized.
- Technologies and frameworks used in this workload are fully understood, including their vulnerabilities.It is important to understand what technologies are used by the application and must be managed, such as .NET Core , Spring, or Node.js. Each choice of technology also has consequences for security.
- Security updates to VMs are applied in a timely manner, and strong passwords exist on those VMs for any local administrative accounts that may be in use.Attackers constantly scan public cloud IP ranges for open management ports and attempt "easy" attacks like common passwords and unpatched vulnerabilities.
- All cloud services used by this workload are identified and it is understood how to configure them securely.It is important to understand what Azure services, such as App Services and Event Hubs, are used by the workload to host both application code and data. Selection should be made with security in mind.
- Personally identifiable information (PII) is detected and removed/obfuscated automatically for this workload, including application logs.Extra care should be take around logging of sensitive application areas. PII (contact information, payment information etc.) should not be stored in any application logs and protective measures should be applied (such as obfuscation). Machine learning tools like Azure Cognitive Search PII detection can help with this.
- Azure Tags are used to enrich Azure resources with operational metadata.Using tags can help to manage resources and make it easier to find relevant items during operational procedures.
- Elevated security capabilities such as dedicated Hardware Security Modules (HSMs) or the use of Confidential Computing was implemented or considered implementing?

