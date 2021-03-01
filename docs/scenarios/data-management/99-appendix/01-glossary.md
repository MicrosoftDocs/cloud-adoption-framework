---
title: Enterprise Scale Analytics and AI Business Glossary
description: Enterprise Scale Analytics and AI Architecture Business Glossary.
author: mboswell
ms.author: mboswell # Microsoft employees only
ms.date: 03/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---
\
**General disclaimer: DO NOT COPY - UNDER DEVELOPMENT - MS INTERNAL ONLY** \
&nbsp;

# Glossary of Terms and Acronyms

| Term | Definition |
|--|--|
| Above the line controls | Controls within direct view and governed by the operating model. |
| API | Application Programming Interface. A set of clearly defined methods of communication between various components. |
| Enterprise Scale Analytics and AI | The collection of environments, workspace, risk and policy controls, release pipelines and supporting foundational infrastructure that together deliver a cloud computing capability.. |
| Azure Service | A feature or offering in Azure that delivers a specific compute, storage, network or other service. Examples of Azure services include Virtual Machines, Virtual Networks, Storage, Web Apps and Azure SQL. |
| BAU | Business as Usual. The normal execution of standard functional operations within an organization. |
| Below the line controls | Controls implemented by the platform vendor to meet control definitions. |
| BGP | Border Gateway Protocol. Standardized exterior gateway protocol designed to exchange routing and reachability information among autonomous systems. |
| BYOIP | Bring Your Own IP. Ability to choose your own IPs within a network. |
| BYOK | Bring Your Own Key. Ability to use your own keys in a key store. |
| Canary Releases | A way of going into production for a limited number of users, usually by only having a small number of load-balanced servers hosting the new release. |
| Defence in Depth | The use of multiple security techniques to mitigate the risk of one component of the defence being compromised or circumvented. |
| Deliverable | A document, software product, configuration, or customization to a product or to an online service. |
| Detective Controls | Controls applied to objects to detect errors and irregularities. |
| DR | Disaster Recovery. Policies, tools, and procedures to enable the recovery or continuation of vital technology infrastructure and systems following a disaster. |
| DTU | Database Throughput Unit. Provides a way to describe the relative capacity of a performance level of Basic, Standard, and Premium databases. |
| Environment Group | See Environments |
| Environments | Collections of Azure subscriptions that share similar risk and security controls, identity requirements, and hybrid network connections. |
| ERT | Estimates Recovery Time. |
| Evergreen | Always up to date technology. |
| FQDN | Fully Qualified Domain Name |
| GA | General Availability |
| HA | High Availability |
| HSM | Hardware Security Module. Physical device that safeguards and manages digital keys for strong authentication and provides crypto processing. |
| Hybrid Identity | A Hybrid Identity solution implements synchronization between on-premises directory objects (which reside on Active Directory Domain Services) with cloud directory objects |
| (Azure Active Directory). | This enables users to access resources on-premises and on the cloud using the same identity, and the management of directory objects in a single location (usually on-premises). |
| IaaS | Infrastructure-as-a-Service. In Azure IaaS refers primarily to networking and virtual machines. |
| IaC | Infrastructure-as-Code. The process of describing IT infrastructure using machine readable definition files. These files are used directly by the tools that create the infrastructure and are developed and versioned in the same way that application source code is managed. |
| IO | Input/Output |
| IOPS | IO per second |
| JSON | JavaScript Object Notation. Open-standard file format that uses human-readable text to transmit data objects. |
| Workspace | A construct in Azure (implemented using Azure Resource Groups) where the applications based on PaaS Services are deployed. Workspace include the essential services for the management and development of applications, as well as policy and configuration to ensure that applicable risk and security controls are met. Also referred to as "Workspaces". |
| Break Glass Account | Emergency access accounts with high privileges, and they are not assigned to specific individuals. Emergency access accounts are limited to emergency or "break glass"' scenarios where normal administrative accounts can't be used. |
| NAT | Network Address Translation. Mapping of one IP address space into another. |
| NVA | Network Virtual Appliance. |
| Opex | Operating Expense. Ongoing cost for running a product, business, or system. |
| PaaS | Platform-as-a-Service. In Azure, primarily services that can be used to host workloads without exposing the underlying infrastructure and machines. |
| PITR | Point-in-Time Recovery. The ability to restore or recover a set of data or a particular setting from a time in the past. |
| Preventative Controls | Controls applied to objects that specify acceptable and unacceptable usage of that object. Unacceptable use of the object is blocked. |
| Primary Site | The Azure data centre to which isolated, Test and production environments will be deployed for normal hosting of workloads. |
| RBAC | Role-Base Access Control. |
| REST | Representational State Transfer. Web Services that conform to the REST architectural style, or RESTful web services, provide interoperability between computer systems on the Internet over HTTP. |
| Release Pipeline | The automated process that reads the definition of an Azure Service or workspace from a source repository and creates an instance of this Service or workspace in a target environment. |
| RTO | Recovery Time Objective. The duration of time within which a business process must be restored after a disaster. |
| S2S | Site-to-Site |
| Development | An Azure environment that will be utilized for Platform development and does not have any connection to the Enterprise network. |
| Service Definitions | A description of an Azure Service that includes the policy and configuration required to meet any relevant risk and security controls. Completed and approved Service Definition are deployed using Release Pipelines. |
| SLA | Service-Level Agreement. Commitment between a service provider and a client. |
| SSH | Secure Shell. Cryptographic network protocol for operating network services securely over an unsecured network. |
| SSIS | SQL Server Integration Services |
| ADF | Azure Data Factory |
| SSAS | SQL Server Analysis Services |
| DW | Datawarehouse |
| Db | Database |
| IR | Integration Runtime |
| SSO | Single Sign-On |
| TDE | Transparent Data Encryption. Encryption of data at rest. |
| TLS | Transport Layer Encryption. Encryption of data in transit (predecessor is SSL). |
| UDR | User Defined Routing. Allows you to configure and assign routes that override the default implicit system routes in Azure. |
| VPN | Virtual Private Network. |
| Workload | An application or collection of related applications that are deployed to Azure |
| Workspace | A construct in Azure (implemented using Azure Resource Groups) where the applications based on PaaS Services are deployed. Workspaces include the essential services for the management and development of applications, as well as policy and configuration to ensure that applicable risk and security controls are met. Also referred to as "Data Landing Zones" |

## Log Feedback to Enterprise Scale Analytics v-team

[Log Feedback for this page](https://github.com/Azure/enterprise-scale-analytics/issues/new?title=&body=%0A%0A%5BEnter%20feedback%20here%5D%0A%0A%0A---%0A%23%23%23%23%20Document%20Details%0A%0A%E2%9A%A0%20*Do%20not%20edit%20this%20section.%20It%20is%20required%20for%20Solution%20Engineering%20%E2%9E%9F%20GitHub%20issue%20linking.*%0A%0A*%20Content%3A%2099-appendix%20%E2%9E%9F%2001-glossary.md)