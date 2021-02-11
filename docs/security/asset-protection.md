---
title: Asset Protection
description: Learn about asset protection best practices in the Cloud Adoption Framework for Azure.
author: DominicAllen
ms.author: doalle
ms.date: 04/04/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: secure
ms.custom: internal
---

# Asset Protection

This article summarises the areas of consideration when planning to implement protection measures for corporate assets and data.

## Context

Running infrastructure and services in a public cloud introduces a number of security benefits that are difficult to replicate at equal scale in private data centres, but that doesn't mean that the task of securing an environment is complete.
Protecting company assets - from virtual machines and networks to applications and identity - is still mission critical in order to provide the best possible security to the functions of the business and company data.

## Securing Data

Organisations should treat the unauthorised access or theft of data amongst the highest impact risks to guard against.
The reputational - and often financial - impact of losing control of sensitive data can significant affect a company's ability to operate. Protecting data is a fundamental requirement of any IT organisation.
A key part of this is to put security measures in place to protect data at rest, and in transit.

### At rest

#### Transparent Data Encryption (TDE)

TDE is a feature of Azure SQL and Azure Synapse Analytics that helps protect data at rest by performing real-time encryption and decryption of the database, backups and logs.  

#### Disk and storage encryption

Encrypting disks attached to virtual machines and storage used for applications or services helps protect data stored locally.

#### RBAC

Access should be restricted to data to only those with a verified reason and only for the data sets explicitly required for the approved use.
Access should be deliberately split between those who can access and those who can modify.

#### Rights management

For data held outside of a database - for example on a file server - tools such as Rights Management can help to control the data leakage or misuse. Rights Management applies encryption, identity and authorisation policies to files to apply controls to data as it moved around within - or even outside - the organisation.

### In transit

#### VPN for ingress/egress

Sending or receiving data external to the business should be - wherever possible - via an encrypted network connection.
One option for this is to establish a Virtual Private Network (VPN) connection which encrypts the network route between two fixed points.
This enables smaller sites, such as branch offices to connect into the cloud environment in order to send and receive data securely.

#### ExpressRoute

For large scale connections such as into an on-premises data centre, the Azure ExpressRoute solution can provide a secure and performant network connection between two trusted locations. This enables organisations to establish the secure network route for high-volume, high-frequency network traffic required as part of a hybrid landing zone implementation.

#### HTTPS

For web services, all pages and connections should be encrypted using HTTPS wherever possible.

### Securing virtual machines

#### Policy

Policies should be used wherever possible in order to mandate the adherence to security requirements.
This technique allows central teams to specify certain configurations that should be used in order to ensure that the virtual machine is considered secure.
For example, policies can used to:

- Prohibit (or audit) Public IP addresses
- Enforce disk encryption
- Manage security policies for Azure Security Center
- Manage policies for log collection for virtual machines in Azure Monitor

#### Endpoint detection and response (EDR)

Technologies such as Windows Defender should be running on all virtual machines to provide anti-malware scanning and File Integrity Monitoring (FIM).

#### Disk encryption

### Securing networks

### Securing applications

#### Microsoft Cloud Application Security (MCAS)

MCAS enables organisations to control which Software-as-a-Service applications can be accessed. This can be an effective tool in stopping the use of unauthorised file-sharing applications that move data outside of the corporate environment. Using these controls can be a strong protection against data leakage.

#### Rights management inside applications

Using the rights managements techniques outlined earlier, data accessed within applications can be controlled in similar ways - even if a user has permissions within the application to extract data it is possible to apply rights to the data so that when it is extracted it is still governed and protected by the business rules applied.
This can be particularly effective for internet facing services such as files shares.

### Securing identity

#### Multifactor authentication (MFA)

MFA is becoming a commonly used component of safeguarding access into corporate systems. A number of large scale cloud services offer MFA as an additional authentication step in order ask the person attempting to authenticate that they are who they say they are.
The principles of MFA are 'something you know'  - typically your username and password, and 'something you have' - for example a phone or a cryptokey
Text messages, phone calls and authentication smartphone apps are commonly used authentication factors.

By using MFA to secure accounts reduces the impact of a user's account details being stolen as the attacker would still need to obtain the 'something you have' item in order to gain access. As a result, using multi-factor authentication is a highly recommended security mechanism to protect access into organisations.

#### Azure Active Directory Premium

### Security Administration

#### Privileged Identity Management (PIM)

#### Just In Time (JIT) Access

Reducing the amount of time that a specific account has elevated privileges can often correlate with the reduction in threat risk for unauthorised access to sensitive infrastructure or data. 
Using techniques and tools that enable JIT means granting an account only the specific permissions required to complete a task for the amount of time required to complete the task. Those permissions are then removed when the task is complete - or the time expires - whichever occurs first.
JIT tools also often include request and approval workflows in order to audit the reason for the elevated privileges and who requested it. This provides further governance controls and also information that could be used in a post-breach investigation to ascertain how the breach was possible.

#### Separate administration accounts
