---
title: Security guidelines for Oracle Database @Azure landing zone accelerator
description: Learn about security guidelines for Oracle Database @Azure landing zone accelerator.
author: bamajeed and mihdavid
ms.author: bamajeed
ms.reviewer: janfaurs
ms.date: 
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: 
---

# Security guidelines for Oracle Database @Azure landing zone accelerator

This article explores specific design elements and provides targeted recommendations for Oracle Database@Azure workload security.

## Overview

Most databases store sensitive data. To have a secure architecture in which to land these workloads, implementing security only at the database level isn't sufficient. Defense in depth is a comprehensive approach to security that involves implementing multiple layers of defense mechanisms to protect data. Instead of relying on a single security measure at a specific level, such as, for example, focusing on network security mechanisms, the defense in depth strategy employs a combination of different layer security measures to create a robust security posture. Defense-in-depth approach can be architected for Oracle workloads through strong authentication and authorization framework, hardened network security and encryption of data at rest and in-transit.

To learn more about Oracle Exadata security refer to [Overview of Oracle Exadata Security](https://docs.oracle.com/en/engineered-systems/exadata-database-machine/dbmsq/exadata-security-overview.html#GUID-4D178313-47E7-451B-8AF8-1FEAC2CD38B2) and [Security Features of Oracle Exadata Database Machine](https://docs.oracle.com/en/engineered-systems/exadata-database-machine/dbmsq/exadata-security-features.html#GUID-31C2978A-238C-4F30-82C7-17B355727810).

## Design Considerations

- Exadata Resource layered security

    Exadata Database Service on Dedicated Infrastructure (ExaDB-D) are resources deployed in Azure vNet and as such a multi-layer approach for security is pertinent. When deploying ExaDB-D there are two types of controls, the APIs to manage the infrastructure, these are local to Azure and executed based on the user/principal’s permissions. The other type are DB management APIs that are executed in Oracle Cloud Infrastructure (OCI) and will have their own set of credentials and permissions that will be set up as part of the initial onboarding process. Refer to **Link to IAM document** document to understand the customer experience for interacting with IAM resources when deploying Oracle Database@Azure.

- Exadata network security 

    Exadata Database on dedicated infrastructure (ExaDB-D for short) is deployed in the customer vNet using virtual interfaces in the proper subnets. The ExaDB-D system consists of multiple database servers and storage servers, running Oracle Linux.

    The Exadata Cloud Infrastructure utilizes different default ports for various operation, please review the below table for key ports that are used, for the full list and explanation please review the [Oracle document here](https://docs.oracle.com/en/engineered-systems/exadata-database-machine/dbmin/exadata-network-requirements.html#GUID-A454DAB3-7606-4288-9139-0C02A7669BE3). **Need link to the Network Document**

    | Protocol | Port Number | Service Name | Comments | Application |
    | -- | -- | -- | -- | -- |
    | TCP | 22 | SSH | Management port for Linux Virtual Machines | SSH |
    | TCP | 443 | HTTPS | Management Server (MS) on Exadata Storage Servers | Requests from ExaCLI and/or RESTful API calls. PDU Web interface |
    | UDP or TCP | 53 | DNS | Database servers, Exadata Storage Servers | DNS (Domain Name System) |
    | TCP | 1521 | Oracle Database listener | Client access to database servers | Client applications |

    
    From a network point of view it is important to consider control-plane security, vNet (data-plane) access security and the ExaDB-D server access security. 
    
    To secure the control-plane it is important to use the principle of least privilege and to utilize Entra ID to manage the proper permissions and group access to the infrastructure and APIs controlling ExaDB-D.
    
    For data-plane and vNet access, it is important to allow only specific networks to access the data by limiting the sources IP range, allow only ports needed for secure communication, prevent any access from and to the internet and use NAT in case it is required. Always encrypt data in transit (SSL).
    
    To secure ExaDB-D server access, utilize [_SELinux_](https://docs.oracle.com/en/learn/ol-selinux/#introduction) which includes a set of kernel mods and user-space tools that provide another layer of system security, precise access control, system-wide admin-defined policies, and improved mitigation for privilege escalation attacks. To secure the ExaDB-D storage servers utilise the [_cellwall_](https://docs.oracle.com/en/engineered-systems/exadata-database-machine/dbmsq/exadata-security-features.html#GUID-9858E126-0D9F-4F99-BE68-391E77916EC6) service which enables firewall service on the servers.
    
- Best practices of the shared responsibility security model
  
    Microsoft and Oracle provide enterprise-grade security features in order to keep the Oracle@Azure cloud service secure. For example, they provide best-in-class technology and operational processes for the security of the underlying cloud infrastructure (such as data center facilities, and hardware and software systems). However, to run your workloads on the service you must be aware of your responsibilities for securing your workloads.  It is important to understand the roles of the customer and the service provider in securing the traffic to the ExaDB-D service, and that achieving a secure deployment is a shared responsibility between the two.
  
  - The service provider ensures the security of the control-plane and the APIs to manage the ExaDB-D infrastructure in Azure or the Oracle databases in OCI. This type of traffic is encrypted in transit over SSL.

  - The data-plane security, connectivity to the database itself and data operations, is the responsibility of the customer and should follow the least privileges permission model, encryption at rest and in transit and periodic rotation of encryption keys.

- Exadata encryption and keys security

    Exadata uses [Oracle Cloud Infrastructure Vault (OCI Vault)](https://docs.oracle.com/en-us/iaas/Content/KeyManagement/Concepts/keyoverview.htm) to store and manage keys, you can choose to use managed keys or to [bring your own encryption key](https://docs.oracle.com/en-us/iaas/Content/KeyManagement/Concepts/keyoverview.htm) the vault.

    To note, in case you bring your own encryption key, the rotation of the key is managed by the user and is not automated by OCI Vault.

- Vulnerability Scanning

    [Oracle Cloud Infrastructure Vulnerability Scanning Service](https://docs.oracle.com/en-us/iaas/scanning/using/overview.htm) helps improve your security posture by routinely checking hosts and container images for potential vulnerabilities. The service gives developers, operations, and security administrators comprehensive visibility into misconfigured or vulnerable resources, and generates reports with metrics and details about these vulnerabilities including remediation information.

    The Vulnerability Scanning service identifies vulnerabilities in the following resources:
  
  - Compute instances  (also known as hosts)
  
  - Container Registry images

## Design Recommendations

- Secure the Control Plane using the principle of least privilege and use Microsoft Entra ID to manage the proper permissions and group access to the infrastructure and APIs controlling ExaDB-D.

- Secure the data-plane and vNet access by limiting the sources IP range, allowing only ports needed for secure communication, preventing access from/to the internet (use NAT in case it is required), and always encrypt data in transit (SSL).

- Follow a shared responsibility matrix to secure the network traffic related to ExaDB-D.

- Use OCI Vault to store and manage encryption keys. If yoy decide to bring your own keys then set up a strict process for key rotation.

- Use the Vulnerability Scanning capabilities provided by Oracle to detect security issues such as ports that are unintentionally left open, OS packages that require updates and patches to address vulnerabilities and OS configurations that hackers might exploit and other vulnerabilities.
