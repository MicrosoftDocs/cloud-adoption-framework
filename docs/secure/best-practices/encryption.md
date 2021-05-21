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
https://docs.microsoft.com/en-us/azure/security/fundamentals/encryption-overview
https://docs.microsoft.com/en-us/security/compass/storage-data-encryption

# Generic space holder - remember to edit the metadata before publication

## This article should cover all of the items under the "managing encryption" question at the CAF level

- The workload uses industry standard encryption algorithms instead of creating own.Organizations should rarely develop and maintain their own encryption algorithms. Secure standards already exist on the market and should be preferred. AES should be used as symmetric block cipher, AES-128, AES-192 and AES-256 are acceptable. Crypto APIs built into operating systems should be used where possible, instead of non-platform crypto libraries. For .NET make sure you follow the .NET Cryptography Model.
- The workload communicates over encrypted (TLS / HTTPS) network channels only.Any network communication between client and server where man-in-the-middle attack can occur, needs to be encrypted. All website communication should use HTTPS, no matter the perceived sensitivity of transferred data (man-in-the-middle attacks can occur anywhere on the site, not just on login forms).
- TLS 1.2 or 1.3 is used by default across this workload.All Microsoft Azure services fully support TLS 1.2. It is recommended to migrate solutions to support TLS 1.2 and use this version by default. TLS 1.3 is not available on Azure yet, but should be the preferred option once implemented on the platform.
- Secure modern hashing algorithms (SHA-2 family) are used.Applications should use the SHA-2 family of hash algorithms (SHA-256, SHA-384, SHA-512).
- Data at rest is protected with encryption.This includes all information storage objects, containers, and types that exist statically on physical media, whether magnetic or optical disk. All data should be classified and encrypted with an encryption standard. How is the data classified and tagged as such so that it can be audited.
- Data in transit is encrypted.When data is being transferred between components, locations, or programs, it's in transit. Data in transit should be encrypted using a common encryption standard at all points to ensure data integrity. For example: web applications and APIs should use HTTPS/SSL for all communication with clients and also between each other (in micro-services architecture). Determine if all components in the solution are using a consistent standard. There are times when encryption is not possible due to technical limitations, but the reason needs to be clear and valid.
- Virtual disk files for virtual machines which are associated with this workload are encrypted.
