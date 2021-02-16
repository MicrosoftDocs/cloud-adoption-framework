---
title: Access Control
description: Learn about access control best practices in the Cloud Adoption Framework for Azure.
author: DominicAllen
ms.author: doalle
ms.date: 04/04/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: secure
ms.custom: internal
---

## Access Control

This article summarises the areas for consideration when planning and implementing good access control practices inside your organisation.

## Context

As organisations plan for cloud-based environments, the concept of network boundaries as the outer edge of the security perimeter is challenged.
With users and applications expanding beyond internal network boundaries, securing access becomes an even more important element of corporate security.

Establishing patterns of people and services securely connecting to infrastructure and applications enables organisations to build secure services as scale without compromising security or increasing risk.

## First principles

Irrespective of the scale of the environment, the technologies in use or workloads in scope, implementing access controls should deliver a consistent outcome - demonstrating to business stakeholders that access to infrastructure and services owned by the organisation is appropriate, monitored and controlled.

By establishing these fundamentals, the business is able to monitor against a 'known' standard, review anomalies and agree exceptions.
Scaling this requires three things -

- **Visibility** - use tools and techniques to establish standard patterns - user access, locations, devices - and find and review exceptions
- **Orchestration** - streamline processes as much as possible in order to aggregate access requests and permissions management centrally. This enables teams to approve access and govern usage of permissions in context and help spot patterns that require investigation
- **Automation** - as much as possible use the technologies available to automate monitoring, detecting and responding to exceptions in access control patterns

## Zero Trust concept

A [Zero Trust](https://www.microsoft.com/security/business/zero-trust) approach assumes breach within an organisation's infrastructure and establishes processes where each request is explicitly validated as though it originates from an open network.

Zero Trust teaches us to "never trust, always verify".

Every access request is fully authenticated, authorized, and encrypted before granting access.  

## Identity

Identity as an authentication parameter should be the basis of all connections and validations to grant access within an organisation.
Users and service accounts should be validated to determine integrity - including as many data points as possible, such as location and comparisons of location compared to typical patterns.

The use of least privileged access techniques should be applied to minimize lateral movement.
Separation of duties techniques between accounts and roles enables identity teams to limit the amount of access or privilege an attacker can gain by compromising one account.

The Cloud Adoption Framework provides [guidance on structuring roles and role-based access controls (RBAC) as part of multi-team organisations](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/considerations/roles). This guidance should be the starting point for considering how to manage permissions and access to infrastructure and applications
Manage access to your Azure environment with Azure role-based access control - Cloud Adoption Framework | Microsoft Docs

For identities with elevated levels of access or permissions, time-based approvals should be considered to reduce the risk profile.
User accounts authenticating against services should use strong passwords and multi-factor authentication.

### Multifactor authentication (MFA)

MFA is becoming a commonly used component of safeguarding access into corporate systems. A number of large scale cloud services offer MFA as an additional authentication step in order ask the person attempting to authenticate that they are who they say they are.
The principles of MFA are 'something you know'  - typically your username and password, and 'something you have' - for example a phone or a cryptokey
Text messages, phone calls and authentication smartphone apps are commonly used authentication factors.

By using MFA to secure accounts reduces the impact of a user's account details being stolen as the attacker would still need to obtain the 'something you have' item in order to gain access. As a result, using multi-factor authentication is a highly recommended security mechanism to protect access into organisations.

### Azure Active Directory Premium

When using Azure Active Directory as the identity platform, organisations are able to enable enhancement features aimed at improving security.
For example:

- Password protection (custom banned passwords)
- Self-service password reset
- Privileged Identity Management (PIM)

### Just In Time (JIT) Access

Reducing the amount of time that a specific account has elevated privileges can often correlate with the reduction in threat risk for unauthorised access to sensitive infrastructure or data.
Using techniques and tools that enable JIT means granting an account only the specific permissions required to complete a task for the amount of time required to complete the task. Those permissions are then removed when the task is complete - or the time expires - whichever occurs first.
JIT tools also often include request and approval workflows in order to audit the reason for the elevated privileges and who requested it. This provides further governance controls and also information that could be used in a post-breach investigation to ascertain how the breach was possible.

### Separate administrator accounts

Separating user accounts from administrator accounts reduces the impact of account credentials being compromised and being used for lateral movement by an attacker.
User accounts (and passwords) used for day-to-day system access are often used in web services outside of an organisation's control and are therefore at risk of data breaches or phishing attacks.
By keeping adminstrator accounts separate and only used inside an organisation, reduces the probability of them being found and exploited by those looking to gain unauthorised access.

A common pattern for naming these accounts is adm-*username* which makes them visually distinguishable from 'standard' user accounts.

## Endpoints

In an increasingly mobile workforce, the connection points for users into a set of corporate services is likely to be significantly larger than devices connecting from within the corporate network.

Access control using Zero Trust techniques should consider all device connections as untrusted and validate what the device is, the health of the device, the identity of the user and the location of the device before granting approval to connect. Using these data points to check the integrity of an endpoint can reduce the risk probability of an authorised device gaining access to internal assets.

## Data

Data is the crown jewels of an organisation, and should be protected as such.

From internal personnel or financial data, to proprietary product-related or sensitive customer information; the ramifications of leaving exploitable weakness in the protections for accessing data are significant.

As a guiding principle, data held within the organisation should be secure and isolated from those who do not have a justifiable reason for having access.

Policy-based controls should be used to govern the movement, modification or extraction of data to only those who justified, managed business reasons.

## Apps

Controlling the access and permissions for applications will be an on-going activity, as users requirements change and those who require access changes.

Ensuring that privileges for applications are appropriate to the role of the requestor, and still appropriate over time, will be a key factor in reducing the risk profile of allowing access to sensitive applications and the data they contain.

In line with the Zero Trust concept, each access request to an application should be validated to check that it is appropriate.

Access to the application should be controlled by role-based permissions, with limitations placed on the ability to change or extract data to further reduce the risk of a rogue actor being able to obtain sensitive information.

## Infrastructure

The ability to access infrastructure within an organisation should be, by default, access controlled. Only those who authenticate as a known,  approved user should be granted access rights.

The ability to access configuration, change or deploy new infrastructure should be tightly restricted to only those identities who have a verified, managed justification. Permissions governing privileged access should be controlled within a role-based access control (RBAC) structure, tied to the organisations identity platform.

Those who do have elevated access rights to infrastructure should have the access protected using tools such as multi-factor authentication (MFA) and Just in time (JIT) access controls.

Access to infrastructure should be monitored, audited and reviewed for anomalies to ensure that only those who explicit authorisation are accessing.

Remote access is a known pattern used by both business users and IT Professionals to gain access to central infrastructure - these access routes should be protected with tools and techniques such as VPNs, Bastion servers and multi-factor authentication to reduce the risk profile.

## Network

Zero Trust is founded in the concept of assumed breach. Treat every connection as suspicious and requiring validation.

Taking this concept a step further, treat the network as if every network node is internet facing and protect them accordingly. Access should be segmented to contain movement to as small an area as possible within the network, and sensitive apps and infrastructure should be segmented to create separation through the use of Virtual networks (Vnets), Firewalls and Network Security Groups (NSG).

The Cloud Adoption Framework provides [reference architectures for hub and spoke network topologies as part of the Landing Zone guidance](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/landing-zone/implementation-options) which help establish a pattern of network segregation as part of architecture fundamentals when adopting cloud technologies.

## Developing further

Not every implementation of these concepts will be the same, but every one should be grounded in the same fundamentals.
The guidance provided in these articles, and the Cloud Adoption Framework more broadly, can help organisations find the right structure for their implementation.
