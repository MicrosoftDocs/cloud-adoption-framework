---
title: Identity and access management for 
description: 
author: 
ms.author: 
ms.date: 
ms.topic: 
ms.custom: 
---

# Identity and access considerations for Citrix on Azure

Identity and access management (IAM) is a key part of an organization's security settings when it deploys the Azure Red Hat Enterprise Linux landing zone accelerator. The Red Hat Enterprise Linux operating system and the applications that run on it need to consume external identities to scale operations. Careful design of your hybrid cloud IAM implementation is required to ensure smooth integration and management of your instance landscape in Azure cloud. Red Hat and Microsoft have worked together to ensure that there is native integration between Red Hat Enterprise Linux, Microsoft Active Directory, and Microsoft Entra ID identity management.  Additional cloud layer services are also supported.

## Design considerations

Use these design considerations and recommendations to create an identity and access management plan that meets your organization's requirements in your Azure Red Hat Enterprise Linux deployment.

Linux deployments have tended to implement local user authentication environments at the operating system level. System-level authentication and authorization, object ownership, object permissions, and application integrations have been based on this model. Operating system applications use these identities in many ways:

- Application processes run under some user identity.

- Application processes create or access files attributed to specific users and groups.

- A set of groups that a user belongs to is fixed at login time, and membership changes are only applied to new sessions.

- Authentication and authorization flow of a user is directly tied to the login session that is instantiated as a result of authentication.

User-initiated shell sessions based on these identities have been the primary means of interaction with applications on Linux. With the move to web, mobile, and cloud-oriented user interfaces, this pattern of identity consumption by applications is less common.  

Today, these identities are typically a support mechanism for running isolated applications or services on the operating system. Application-level identities do not necessarily have to be the same as the system-level users anymore. However, system-level identity is still critical in efficiently running and securing a Linux infrastructure running at scale in a cloud environment.  

In general, a Red Hat Enterprise Linux deployment in a hybrid-cloud environment should:

- Use a centralized Linux identity authority that integrates with the operating system security subsystem where possible to increase operational efficiency and access control visibility. Utilizing a centralized Linux identity authority enables:
  - Managing host-specific authorization for the Linux operating system
  - Achieving consistency across hybrid deployments
  - Delegating authentication to external sources
  - Streamlining the access control review process
  - Ensuring uniformity
  - Accelerating the implementation process
  - Enhancing the security framework of a hybrid cloud Linux infrastructure.

- Be capable of applying policies uniformly to multiple instances simultaneously without modifying each instance in the infrastructure through automation whenever there is a change.  

- Support centralized, secure, differentiated instance-level access control using host-based access control, delegation, and other rules.

- Centrally manage system-level privilege escalation rules across the identity authority and be able to apply this policy consistently across individual instances and groups of instances within the environment.

- Support or provide modern automation tooling capability to test and consistently implement security configurations across fleets of systems. Design security automation into a hybrid-cloud deployment from the beginning.  

- Support the integration of existing legacy enterprise SSO capabilities to ease migration burdens, maintain consistency of security operations, and support modern integrations for cloud-based deployments.

Red Hat has developed a centralized and unified way to manage identity stores, authentication, policies, and authorization policies in a Linux-based domain called Red Hat Identity Management (IdM), which is included in Red Hat Enterprise Linux. Red Hat IdM natively integrates with Microsoft Active Directory and Microsoft Entra ID. Organizations that maintain an on-premises Active Directory environment and extend that to the Azure cloud may benefit from the native AD trust capability in Red Hat IdM. Organizations that are adopting Microsoft Entra ID or have standardized on an alternate IdP provider may take advantage of the native capability of Red Hat IdM and Red Hat Single Sign-On (SSO) to integrate with these providers. Red Hat SSO is a supported enterprise implementation of the Keycloak open-source project. It is provided at no extra cost with various Red Hat subscriptions, including Red Hat Ansible Automation Platform. Red Hat recommends implementing Red Hat Identity Management within your Red Hat Enterprise Linux deployment in Azure.  

## Design recommendations

Design recommendations for identity and access management regarding Azure Landing Zones for Red Hat Enterprise Linux using Red Hat Identity Management (IdM) and Red Hat Single Sign-On (SSO) follow the Microsoft Azure Cloud Adoption Framework and Red Hat Infrastructure Standard Adoption Model. The recommendations extend the principles you would use to implement a hybrid-cloud deployment.

![IAM Diagram](images/IAM-Diagram.png)

The identity and access management components for your Red Hat deployment in Azure use the subscription scaling model described in the Azure Cloud Adoption Framework documentation to provide additional control and isolation to the management tooling. The Identity Management primary and replica systems and Red Hat Single Sign-On instances will reside in a Red Hat Management Subscription with other tools. The subscription will provide resource groups throughout the implementation to provide localized services and high availability.

Critical design recommendations for your Red Hat Identity Management deployment are:

- Implement automation for deployment, configuration, and day-2 operation of Red Hat Identity Management. Red Hat and Microsoft strongly recommend building using an Infrastructure as Code methodology. Red Hat provides the [redhat.rhel_idm](https://console.redhat.com/ansible/automation-hub/repo/published/redhat/rhel_idm/) certified Ansible collection, from [Ansible Automation Hub](https://console.redhat.com/ansible/automation-hub/), for automating Red Hat Identity Management and the [redhat.sso](https://console.redhat.com/ansible/automation-hub/repo/published/redhat/sso/) certified Ansible collection for automating Red Hat Single Sign-On.

- Implement enterprise and application identity support. Understand clearly which services will be exposed by instances and will require authentication at the operating system level and which at the application level. Red Hat IdM is recommended to implement OS layer security, host-based access control rules, privilege escalation management rules (e.g. sudo), SELinux policy mapping, and identity mapping for legacy systems. Red Hat Single Sign-On is recommended to integrate enterprise authentication sources with web-based applications.

- Centralized identity management is critical in threat response. It can instantly invalidate and/or rotate compromised credentials across cloud-scale deployments. This strongly motivates the use of centralized identity and authorization frameworks.

- Determine the initial integration path for current identity providers with the Azure Cloud deployment, such as Active Directory, Microsoft Entra ID, etc. Red Hat Identity Management supports several integration options. Adding and removing integrations can be performed within IdM, however, it is best to evaluate existing requirements, migration impacts, and cost of change over time.  

- Geographical deployment of Red Hat Enterprise Linux instances affect your IdM infrastructure. IdM primary and replica deployments should be configured to reduce latencies and ensure no single point of failure in replication. Red Hat Identity Management provides for performance, load balancing, failover, and high availability by deploying multiple IdM replicas. Deployments can consist of up to 60 replicas. Replica deployments should ensure that systems span fault domains. IdM replica updates should be managed via automation to ensure replication consistency. Use Red Hat recommended replication topologies.  

- Active Directory trust configuration and DNS configuration are key to a successful IdM implementation. Note that when configuring Identity Management and Active Directory, the directory servers need to reside in their own DNS domains or subdomains due to the nature of Kerberos service records. This is not a limitation of Active Directory or Identity Management. Private IP DNS resolution for Azure-based instances is recommended in the Azure Cloud Adoption Framework.  

- Red Hat Identity Management provides an integrated DNS service. Configuration of Red Hat Satellite for IdM integration provides automated management of forward and reverse DNS zones, host registration, and host ssh key generation and registration in IdM. This integration when coupled with AD trust provides seamless SSO login for AD users to Red Hat Enterprise Linux systems and services.

- Back up your IdM resources. Although Identity Management is typically deployed in a self-managed multi-master replica configuration, ensuring proper backups of systems and data is critical. Identity Management supports using hidden replicas to implement full offline backups without interrupting service availability. Use Azure platform encrypted backup or other encrypted backup facility.  

- When deploying with the integrated certificate authority (CA), having the IdM root certificate signed by an external CA, corporate or 3rd-party, is recommended.

- Integrating Red Hat Identity services with other Red Hat products. Red Hat Identity Management and Red Hat SSO integrate with Ansible Automation Platform, OpenShift Container Platform, OpenStack Platform, Satellite, and development tools.

The Planning Identity Management guide provides detailed considerations for planning the infrastructure and service integration of a Red Hat Identity Management deployment. Refer to the specific guide for the operating system release of Red Hat Enterprise Linux on which your IdM deployment is based.

## Next steps

Learn about Network topology and connectivity considerations for Red Hat Enterprise Linux.

- [Resource organization](citrix-resource-organization.md)
