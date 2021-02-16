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

This article summarizes the areas of consideration when planning to implement protection measures for corporate assets and data.

## Context

Running infrastructure and services in a public cloud introduces many security benefits that are difficult to replicate at equal scale in private data centres, but that doesn't mean that the task of securing an environment is complete.
Protecting company assets - from virtual machines and networks to applications and identity - is still mission critical in order to provide the best possible security to the functions of the business and company data.

## Securing Data

Organizations should treat the unauthorized access or theft of data among the highest impact risks to guard against.
The reputational - and often financial - impact of losing control of sensitive data can significantly affect a company's ability to operate. Protecting data is a fundamental requirement of any IT organization.
Organisations need to put security measures in place to protect data at rest, and in transit.

### At rest

#### Transparent Data Encryption (TDE)

TDE is a feature of Azure SQL and Azure Synapse Analytics that helps protect data at rest by performing real-time encryption and decryption of the database, backups, and logs.  

#### Disk and storage encryption

Encrypting disks attached to virtual machines and storage used for applications or services helps protect data stored locally.

#### RBAC

Access should be restricted to data to only accounts with a verified reason and only for the data sets explicitly required for the approved use.
Access should be deliberately split between accounts that can access and accounts that can modify.

#### Rights management

For data held outside of a database - for example on a file server - tools such as Rights Management can help to control the data leakage or misuse. Rights Management applies encryption, identity and authorization policies to files to apply controls to data as it moved around within - or even outside - the organization.

### In transit

#### VPN for ingress/egress

Sending or receiving data external to the business should be - wherever possible - via an encrypted network connection.
One option for this is to establish a Virtual Private Network (VPN) connection, which encrypts the network route between two fixed points.
VPNs enable smaller sites, such as branch offices to connect into the cloud environment in order to send and receive data securely.

#### ExpressRoute

For large-scale connections such as into an on-premises data centre, the Azure ExpressRoute solution can provide a secure and performant network connection between two trusted locations. ExpressRoute enables organizations to establish the secure network route for high-volume, high-frequency network traffic required as part of a hybrid landing zone implementation.

#### HTTPS

For web services, all pages and connections should be encrypted using HTTPS wherever possible.

### Securing virtual machines

#### Policy

Policies should be used wherever possible in order to mandate the adherence to security requirements.
This technique allows central teams to specify certain configurations that should be used in order to ensure that the virtual machine is considered secure.
For example, policies can be used to:

- Prohibit (or audit) Public IP addresses
- Enforce disk encryption
- Manage security policies for Azure Security Center
- Manage policies for log collection for virtual machines in Azure Monitor

#### Endpoint detection and response (EDR)

Technologies such as Windows Defender should be running on all virtual machines to provide anti-malware scanning and File Integrity Monitoring (FIM).

#### Disk encryption

As mentioned in earlier sections, encrypting disks provides extra layers of security and protects data at rest.

### Securing networks

Network infrastructure connects users and devices to applications and data. As a result, it becomes a valuable target for those looking to gain unauthorized access, given its ability to enable them to access a broad range of sensitive areas of an organization's environment.

There are techniques and technologies that can reduce the risk (or subsequent impact) of a network breach:

- Firewalls
- Network Access Control
- Network Security Groups
- Secure connectivity for inbound and outbound traffic
- Distributed Denial of Service (DDoS) Protection

### Securing applications

#### Microsoft Cloud Application Security

Microsoft Cloud Application Security (MCAS) enables organizations to control which Software-as-a-Service applications can be accessed. MCAS can be an effective tool in stopping the use of unauthorized file-sharing applications that move data outside of the corporate environment. Using these controls can be a strong protection against data leakage.

#### Rights management inside applications

Using the rights managements techniques outlined earlier, data accessed within applications can be controlled in similar ways - even if a user has permissions within the application to extract data it is possible to apply rights to the data so that when it is extracted it is still governed and protected by the business rules applied.
This can be particularly effective for internet facing services such as files shares.

### Securing identity

Protecting identity is a key consideration when planning an organization's approach to securing assets. Identity is one the most common routes for attackers to gain unauthorized access to applications and infrastructure.

[Guidance is provided here for areas of consideration related to protecting and controlling access.](./security/access-control.md)
