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

## This article should cover all of the items under the "managing secrets in a secure way" question at the CAF level

- There's a clear guidance or requirement on what type of keys (PMK - Platform Managed Keys vs. CMK - Customer Managed Keys) should be used for this workload.Different approaches can be used by the workload team. Decisions are often driven by security, compliance and specific data classification requirements. Understanding these requirements is important to determine which key types are best suitable (MMK - Microsoft-managed Keys, CMK - Customer-managed Keys or BYOK - Bring Your Own Key).
- Passwords and secrets are managed outside of application artifacts, using tools like Azure Key Vault.API keys, database connection string and passwords need to be stored in a secure store and not within the application code or configuration. This simplifies operational tasks like key rotation as well as improving overall security.
- Access model for keys and secrets is defined for this workload.Permissions to keys and secrets have to be controlled with a access model.
- A clear responsibility / role concept for managing keys and secrets is defined for this workload.Central SecOps team should provide guidance on how keys and secrets are managed (governance), application DevOps team is responsible to manage the application related keys and secrets.
- Secret/key rotation procedures are in place.In the situation where a key or secret becomes compromised, it is important to be able to quickly act and generate new versions. Key rotation reduces the attack vectors and should be automated and executed without any human interactions.
- Expiry dates of SSL/TLS certificates are monitored and there are renewal processes in place.
