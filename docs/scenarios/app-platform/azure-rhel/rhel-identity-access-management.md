---
title: Identity and access management for Red Hat Enterprise Linux on Azure
description: 
author: terrymandin
ms.author: temandin 
ms.date: 7/20/2024
ms.topic: conceptual
---

# Identity and access considerations for Red Hat Enterprise Linux on Azure

When you deploy the Azure Red Hat Enterprise Linux (RHEL) landing zone accelerator, identity and access management (IAM) is a key part of your organization's security settings. The RHEL operating system and the applications that run on it need to consume external identities to scale operations. Carefully design your hybrid cloud IAM implementation to ensure smooth integration and management of your instance landscape in the Azure cloud. Red Hat and Microsoft work together to ensure native integration between RHEL, Windows Server Active Directory, and Microsoft Entra ID Privileged Identity Management (PIM).

## Design considerations

Use these design considerations and recommendations to create an IAM plan that meets your organization's requirements in your Azure RHEL deployment.

In general, a RHEL deployment in a hybrid-cloud environment should:

- Use a centralized Linux identity authority that integrates with the operating system security subsystem where possible to increase operational efficiency and access control visibility. Use a centralized Linux identity authority so you can:
  - Manage host-specific authorization for the Linux operating system.

  - Achieve consistency across hybrid deployments.
  - Delegate authentication to external sources.
  - Streamline the access control review process.
  - Ensure uniformity.
  - Accelerate the implementation process.
  - Enhance the security framework of a hybrid cloud Linux infrastructure.

- Apply policies uniformly to multiple instances simultaneously. Use this approach so that you don't have to use automation to modify each instance in the infrastructure when a change occurs.  

- Support centralized, secure, differentiated instance-level access control by using host-based access control, delegation, and other rules.

- Centrally manage system-level privilege escalation rules across the identity authority. And apply this policy consistently across individual instances and groups of instances within the environment.

- Support or provide modern automation tooling capabilities to test and consistently implement security configurations across fleets of systems. Design security automation into a hybrid-cloud deployment from the beginning.  

- Support the integration of existing legacy enterprise single sign-on (SSO) capabilities to ease migration burdens, maintain consistency of security operations, and support modern integrations for cloud-based deployments.

Linux deployments tend to implement local user authentication environments at the operating system level. System-level authentication and authorization, object ownership, object permissions, and application integrations are based on this model. Operating system applications use these identities in many ways. For example:

- Application processes run under some user identities.

- Application processes create or access files that are attributed to specific users and groups.

- A set of groups that a user belongs to is fixed at sign-in time, and membership changes are only applied to new sessions.

- The authentication and authorization flow of a user is directly tied to the login session that's active as a result of authentication.

Previously, user-initiated shell sessions that were based on these identities were the primary means of interaction with applications on Linux. With the move to web, mobile, and cloud-oriented user interfaces, this pattern of identity consumption by applications is less common.  

Today, these identities are typically a support mechanism when you run isolated applications or services on the operating system. Now application-level identities don't necessarily have to be the same as the system-level users. But system-level identity is still critical to efficiently run and secure a Linux infrastructure that runs at scale in a cloud environment.

For small cloud deployments or pilot deployments, these traditional IAM methodologies provide a straightforward way to get started. As an environment scales, these mechanisms are more difficult to manage, even when you use automation. As the number of touch points increases, the volume of configuration data, logging data, drift data, and required analysis also increases. To manage this complexity, you must centralize IAM.

You can use various tools that provide centralized security within a Linux environment. Ensure that the tool meets your business and technical requirements. RHEL has a broad software compatibility list for security. You can integrate application-level security by using Azure-native Microsoft Entra ID, commercial open-source software solutions like Okta, Sailpoint, or JumpCloud, or open-source project solutions such as Keycloak. There are also various security solutions at the operating system level. You can deploy many commercial solutions and open-source software projects in the cloud.

## Design recommendations for Red Hat Identity Management

This section describes design recommendations for IAM in Azure landing zones for RHEL. To incorporate these recommendations, you can use Red Hat Identity Management (IdM) and Red Hat SSO, which align with the Cloud Adoption Framework for Azure and Red Hat Infrastructure Standard Adoption Model. The recommendations extend the principles that you use to implement a hybrid-cloud deployment.  

Red Hat IdM provides a centralized way to manage identity stores, authentication, policies, and authorization in a Linux-based domain. Red Hat IdM natively integrates with Windows Server Active Directory and Microsoft Entra ID and is included with RHEL. If you extend your on-premises Active Directory to Azure, you could benefit from the Red Hat IdM-native Windows Server Active Directory trust capability. Similarly, if you adopt Microsoft Entra ID or use an alternate IdP provider, you can use Red Hat IdM and Red Hat single SSO for seamless integration. Red Hat SSO is a supported enterprise implementation of the Keycloak open-source project. It's provided at no extra cost with various Red Hat subscriptions, including Red Hat Ansible Automation Platform. Red Hat recommends that you implement Red Hat IdM within your RHEL deployment in Azure.

:::image type="content" source="images/IAM-Diagram.png" alt-text="Diagram that shows a high-level depiction of a RHEL management subscription deployment." border="false":::

The IAM components for your Red Hat deployment in Azure use the [subscription scaling model](/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org-subscriptions) described in the Azure Cloud Adoption Framework documentation to provide extra control and isolation to the management tooling. The Identity Management primary and replica systems and Red Hat single sign-on instances reside in a Red Hat Management Subscription with other tools. The subscription provides resource groups throughout the implementation to provide localized services and high availability.

:::image type="content" source="images/rhel-lz-idm-zoneHA.png" alt-text="Diagram that shows the Red Hat IdM zonal deployment architecture." border="false":::

:::image type="content" source="images/rhel-lz-idm-deploy-detail.png" alt-text="Diagram that shows the Red Hat IdM multi-region deployment architecture." border="false":::

*Figure N: A recommended high availability deployment of Red Hat Identity Management across regions and availability zones. IdM servers within each region replicate to one another and a hidden replica. There are at least two replication links across regions. The hidden replicas serve as the backup points as they might be taken offline for full backups without affecting availability.*
*IdM clients can load balance and failover between IdM servers based on service record discovery or via a list of servers in sssd.conf. Don't use external load balancing or HA configurations with IdM.*

Consider the following critical design recommendations for your Red Hat IdM deployment.

- Implement infrastructure as code (IaC) automation for deployment, configuration, and day-2 operation of Red Hat IdM. To automate Red Hat IdM, you can use the certified Ansible collection [redhat.rhel_idm](https://console.redhat.com/ansible/automation-hub/repo/published/redhat/rhel_idm/) through the [Ansible Automation Hub](https://console.redhat.com/ansible/automation-hub/). To automate Red Hat SSO, you can use the [redhat.sso](https://console.redhat.com/ansible/automation-hub/repo/published/redhat/sso/) certified Ansible collection.

- Implement enterprise and application identity support. Understand which services instances expose and which services require authentication at the operating system level and the application level. Use Red Hat IdM to implement OS layer security, host-based access control rules, and privilege escalation management rules such as sudo. You can also use Red Hat IdM to map SELinux policies and map identities for legacy systems. Use Red Hat SSO to integrate enterprise authentication sources with web-based applications.

- Use centralized identity management for threat response. You can instantly invalidate or rotate compromised credentials across cloud-scale deployments. 

- Determine the initial integration path for Azure-native identity providers, such as Windows Server Active Directory and Microsoft Entra ID. Red Hat IdM supports several integration options. You can add and remove integrations within IdM, but you should evaluate existing requirements, migration effects, and the cost of change over time.  

- Configure IdM primary and replica deployments to reduce latencies and ensure that there's no single point of failure in replication. Geographical deployments of RHEL instances affect your IdM infrastructure. You can use Red Hat IdM to deploy multiple IdM replicas, which provides improved performance, load balancing, failover, and high availability. Deployments can consist of up to 60 replicas. Replica deployments should ensure that systems span fault domains. Manage IdM replica updates via automation to ensure replication consistency. Use Red Hat-recommended replication topologies.  

- Ensure that you properly set up the Windows Server Active Directory trust configuration and Domain Name System (DNS) configuration. When you configure IdM and Windows Server Active Directory, both on-premises Active Directory servers and IdM servers need to reside in their own DNS domains or subdomains. This requirement is because of Kerberos service records and Kerberos service discovery. The Cloud Adoption Framework recommends [private IP DNS resolution](/azure/cloud-adoption-framework/ready/azure-best-practices/dns-for-on-premises-and-azure-resources) for Azure-based instances.

- Red Hat IdM provides an integrated DNS service. Configure Red Hat Satellite for IdM integration to automate management tasks such as forward and reverse DNS zones, host registration, and Secure Shell (SSH) key generation and registration within IdM. Combine this integration with Windows Server Active Directory trust so that Windows Server Active Directory users can seamlessly sign in to RHEL systems and services via SSO.

- Back up your IdM resources. Typically, you deploy IdM in a self-managed multi-master replica configuration, but you must also ensure that you have proper system and data backups. Use IdM hidden replicas to implement full offline backups without interrupting service availability. Use Azure Backup for encrypted backup facility.   

- When you deploy RHEL with the integrated certificate authority (CA), we recommend that you have an external CA, corporate, or third-party, sign the IdM root certificate.

- Integrate Red Hat Identity services with other Red Hat products. Red Hat IdM and Red Hat SSO integrate with Ansible Automation Platform, OpenShift Container Platform, OpenStack Platform, Satellite, and development tools.

Use the [Planning Identity Management guide](https://docs.redhat.com/documentation/red_hat_enterprise_linux/8/html/planning_identity_management/index) to plan the infrastructure and integrate services for your Red Hat IdM deployment. Refer to the specific guide for the operating system release of RHEL on which your IdM deployment is based.

## Design recommendations for Azure native identity management

- Use Azure RHEL virtual machines with Microsoft Entra ID to limit user rights and minimize the number of users who have administrator rights. Limit user rights to protect the configuration and secrets access. For more information, see [Azure built-in roles for compute](/azure/role-based-access-control/built-in-roles/compute).

- Follow the principle of least privilege, and assign the minimum permissions that users need for authorized tasks. Give full access and just-in-time access only as needed. Use [Microsoft Entra ID PIM](/azure/defender-for-cloud/just-in-time-access-usage) and [IAM in Azure landing zones](/azure/cloud-adoption-framework/ready/landing-zone/design-area/identity-access).  

- Use [managed identities](/entra/identity/managed-identities-azure-resources/overview) to access Microsoft Entra ID protected RHEL resources without needing to manage secrets for workloads that run on Azure.

- Consider using Microsoft Entra ID as a core authentication platform and a certificate authority to [SSH into a Linux VM](/entra/identity/devices/howto-vm-sign-in-azure-ad-linux).

- Protect sensitive information such as keys, secrets, and certificates. For more information, see [Cloud Adoption Framework for encryption and key management in Azure](/azure/cloud-adoption-framework/ready/landing-zone/design-area/encryption-and-keys).

- Implement SSO by using Windows Server Active Directory, Microsoft Entra ID, or Active Directory Federation Services (AD FS). Choose your service based on the access type. Use SSO so that the users can connect to RHEL applications without a user ID and password after the central identity provider successfully authenticates them.

- Use a solution, like Local Administrator Password Solution (LAPS), to frequently rotate local administrator passwords. For more information, see [Security assessment: Microsoft LAPS usage](/defender-for-identity/cas-isp-laps).

## Next steps

Learn about Network topology and connectivity considerations for RHEL.
