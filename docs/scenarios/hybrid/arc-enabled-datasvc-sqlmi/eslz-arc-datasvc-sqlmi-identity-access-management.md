---
title: Identity and access management for Azure Arc-enabled SQL Managed Instance
description: Describes how to improve identity and access management for the Azure Arc-enabled SQL Managed Instance.
author: chintalavr
ms.author: vchintala
ms.date: 07/04/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-hybrid, think-tank
---

# Identity and access management for Azure Arc-enabled SQL Managed Instance

This article describes [Azure Arc-enabled SQL Managed Instance](/azure/azure-arc/data/managed-instance-overview) identity and access management (IAM) architecture, design considerations, recommendations, and role-based access controls for various scenarios.

[Arc-enabled SQL MI](/azure/azure-arc/data/managed-instance-overview) relies on the [Azure Arc-enabled data services](/azure/azure-arc/data/overview) extension running on Azure Arc-enabled Kubernetes cluster. Following are the various components of Azure Arc-enabled data services that are of importance to cover Identity and Access Management as part of this critical design area (CDA).

- Azure Arc Data Controller
- Azure Arc Active Directory connector
- Azure Arc-enabled SQL Managed Instance

## Architecture

### SQL Authentication

SQL authentication is supported for Arc-enabled SQL MI using a local [SQL identities](/sql/relational-databases/security/choose-an-authentication-mode#connecting-through-sql-server-authentication). SQL authentication method is used during first-time login to Arc-enabled SQL MI to create logins from Windows for administrators and grant permissions to the database to access Arc-enabled SQL MI using Active Directory authentication. Grafana and Kibana dashboards support only basic authentication at this time.

### Active Directory authentication

For many enterprise organizations Active Directory (AD) authentication is the standard for enforcing role-based access controls (RBAC) with SQL Servers running on-premises and other cloud environments. Azure Arc-enabled SQL MI supports AD authentication to seamlessly migrate existing SQL Server databases to Arc-enabled SQL MI and stay current with the latest SQL Server version and security patches.

Arc-enabled SQL MI uses Kerberos keytab to support [AD authentication](/azure/azure-arc/data/active-directory-introduction) when running on Arc-enabled Kubernetes clusters. [Active Directory connector](/azure/azure-arc/data/active-directory-introduction#what-is-an-active-directory-ad-connector) is a key component in Arc-enabled data services to support AD authentication in Arc-enabled SQL MI. 

Following are two ways to generate and manage Kerberos keytab and use it in Arc-enabled SQL MI. The sections below explain the scenarios and when to use the appropriate keytab mode.

#### System-managed keytab

[Active Directory connector in system-managed keytab mode](/azure/azure-arc/data/deploy-system-managed-keytab-active-directory-connector#active-directory-connector-in-system-managed-keytab-mode) simplifies AD account generation and keytab management for Arc-enabled SQL MI. The AD connector is responsible for creating the service accounts, assigning [service principals](/windows/win32/ad/service-principal-names), and [generating keytab](/windows-server/administration/windows-commands/ktpass) to support AD authentication in Arc-enabled SQL MI. This is recommended for customers who would prefer simplifying operations over granular control to auto-manage the keytab for AD authentication.

Following is the architecture diagram for the AD connector with system-managed keytab mode.

[![Diagram that shows AD authentication using system-managed keytab mode.](./media/arc-enabled-sqlmi-adauth-system-keytab.png)](./media/arc-enabled-sqlmi-adauth-system-keytab.png#lighbox)

#### Customer-managed keytab

Active Directory connector with [customer-managed keytab mode](/azure/azure-arc/data/deploy-customer-managed-keytab-active-directory-connector) provides the full control of managing service accounts, service principals, and generating keytab to the customers who strictly follow [Information Technology Infrastructure Library (ITIL)](https://www.axelos.com/certifications/itil-service-management) process and separation of duties to delegate activities to different teams to comply with organizational security policies and governance.

Following is the architecture diagram for AD connector with customer-managed keytab mode.

[![Diagram that shows AD authentication using customer-managed keytab mode.](./media/arc-enabled-sqlmi-adauth-customer-keytab.png)](./media/arc-enabled-sqlmi-adauth-customer-keytab.png#lighbox)

### Data Controller managed identity integration

When the Arc-enabled data services extension is installed in Directly connected mode, a [managed identity](/azure/azure-arc/data/create-data-controller-direct-cli?tabs=windows#retrieve-the-managed-identity-and-grant-roles) is created for Arc-enabled data services to interact with Azure Resource Manager (ARM) APIs control plane and data plane to perform various actions. Azure Arc Data Controller uses this managed identity to perform these actions when managing Arc-enabled SQL MI.

In an Indirect connectivity mode a [service principal](/azure/azure-arc/data/upload-metrics-and-logs-to-azure-monitor#create-service-principal) with [required permissions](/azure/azure-arc/data/upload-metrics-and-logs-to-azure-monitor?tabs=windows#assign-roles-to-the-service-principal) is needed by Arc Data Controller to periodically [export usage information](/en-us/azure/azure-arc/data/upload-usage-data#upload-usage-data) such as inventory and resource usage to Azure.

### Azure RBAC on Azure Arc-enabled Data Services

Following are the required RBAC permissions to publish monitoring metrics to Azure Monitor.

|Role|Description|
|-----------|------------|
|Monitoring Metrics Publisher|Enables publishing metrics against Azure resources.|

### Securely access Azure Arc-enabled SQL Managed Instance

Following is the architecture diagram to securely access Arc-enabled SQL MI using AD authentication.

[![Diagram that shows secure access to Arc-enabled SQL MI using AD authentication.](./media/arc-enabled-sqlmi-secure-access.png)](./media/arc-enabled-sqlmi-secure-access.png#lighbox)

Following is the architecture diagram to securely access Arc-enabled SQL MI using SQL authentication.

[![Diagram that shows secure access to Arc-enabled SQL MI using SQL authentication.](./media/arc-enabled-sqlmi-secure-access-sql-auth.png)](./media/arc-enabled-sqlmi-secure-access-sql-auth.png#lighbox)

## Design considerations

Review the [identity and access management critical design area](/azure/cloud-adoption-framework/ready/enterprise-scale/identity-and-access-management) of Azure landing zones to assess the effect of Azure Arc-enabled data services on your overall identity and access model.

### Arc-enabled data services deployment

- Consider the identity being used to deploy Azure Arc-enabled data services depending on the type of deployment such as manual vs automated selected for Arc-enabled data services deployment. This identity could be an Azure Active Directory account or Lightweight Directory Access Protocol (LDAP) account from Active Directory Domain Services (ADDS) or a 3rd party LDAP provider based on how underlying Azure Arc-enabled Kubernetes access controls are managed in on-premises or other cloud environments.

- Consider whether a group-based access control or individual identity-based access controls are more appropriate for your Information Technology (IT) organization to manage Arc-enabled data services based on the operations overhead created by both options.

- Consider between Azure Arc-enabled Kubernetes administrators vs database management group (DMG) vs application administration group to deploy and manage Azure Arc-enabled data services depending on your organization's security governance and separation of duties requirements.

- Consider the usage pattern between system-managed keytab vs customer-managed keytab to deploy Azure Arc AD connector to support AD authentication in Arc-enabled SQL MI. Both methods have the benefits of simplified operations vs full customer control of managing service accounts and keytab for AD authentication support.

### Arc-enabled data services access

Arc-enabled SQL MI access controls are fully independent of underlying [Azure Arc-enabled Kubernetes access controls](/azure/azure-arc/kubernetes/azure-rbac). It is important to make a few design decisions to administer Arc-enabled SQL MI and provide access to consumer applications and end users.

- Consider AD vs SQL authentication depending on your organization's applications or service capabilities to use one of these authentication types. As not all applications support AD authentication, review your organization's security policies for allowed authentication types and enforce additional security controls necessary when using SQL authentication.

- When cloud-native services need to authenticate and connect to Arc-enabled SQL MI databases for Data Analytics for extracting and ingesting data into data analytics services, consider using self-hosted runtime virtual or physical machines on-premises that are AD joined over SQL to authenticate and connect to Arc-enabled SQL MI.

## Design recommendations

In addition to design recommendations provided in this section, review the [identity and access management design recommendations](/azure/cloud-adoption-framework/scenarios/hybrid/arc-enabled-kubernetes/eslz-arc-kubernetes-identity-access-management#design-recommendations) of Azure Arc-enabled Kubernetes as Arc-enabled SQL MI is deployed on the Arc-enabled Kubernetes cluster.

### Arc-enabled data services deployment

- For enterprise organizations that follow strict ITIL processes, isolate teams responsible for managing Arc-enabled data services from Arc-enabled Kubernetes by creating different security groups and assigning permissions to manage Arc-enabled data services.

- Use system-managed keytab mode for AD authentication support to offload domain account and keytab management overhead to simplify operations.

- Use customer-managed keytab mode for AD authentication to have full control of service account creation and keytab generation.

- Create dedicated [AD Organization Unit (OU)](/azure/azure-arc/data/active-directory-prerequisites#create-an-ou) to keep all Arc-enabled SQL MI service accounts to delegate access control and simplify operations.

- Use AES256 encryption for Kerberos keytab files and avoid use of RC4 ciphers.

### Arc-enabled data services access

- Where appropriate use AD authentication with SQL MI to offload user lifecycle management to the directory services and use security groups in AD to manage user permissions to access the SQL database.

- Use SQL authentication with Arc-enabled SQL MI as a [least preferred authentication](/sql/relational-databases/security/choose-an-authentication-mode?view=sql-server-ver16#disadvantages-of-sql-server-authentication) type and when it is not possible to use AD authentication due to the its [support in the consumer applications or services](/sql/relational-databases/security/choose-an-authentication-mode#advantages-of-sql-server-authentication).

- Once AD authentication is made possible for your organizational needs, avoid using SQL authentication for day-to-day operations. Use SQL authentication only for emergency access to the database server for database administration.

- In deployment scenarios that do not support AD authentication, use SQL authentication supported in Arc-enabled SQL MI. Make sure to use strong password policies and enable auditing to monitor SQL user identities and permissions granted to access database servers and databases.

## Role based access controls (RBAC)

When using system-managed keytab mode explicit permissions to [Domain Service Account (DSA)](/azure/azure-arc/data/active-directory-prerequisites#create-the-domain-service-account-dsa) is required at [Active Directory OU](/azure/azure-arc/data/active-directory-prerequisites#create-an-ou) level for Arc-enabled SQL MI. 

Following are [the required RBAC permissions](/azure/azure-arc/data/active-directory-prerequisites#set-permissions-for-the-dsa). For customer-managed keytab mode, no explicit permissions are required for the domain service account at the Active Directory OU level.

### Azure Arc AD Connector permissions

|Permission|Description|
|-----------|------------|
|Read all properties|Allow to read all properties of a directory object. |
|Write all properties|Allow updates to all properties of the directory object .|
|Create User objects|Allow creation of directory objects in the OU.|
|Delete User objects|Allow deletion of directory objects in the OU. |
|Reset password| Allow password reset of user objects in the OU.|

### SQL Server roles

|Role|Details|
|-----------|------------|
|Server-level roles | Refer [details](/sql/relational-databases/security/authentication-access/server-level-roles)|
|Database-level roles| Refer [details](/sql/relational-databases/security/authentication-access/database-level-roles)|
|Application roles|Refer [details](/sql/relational-databases/security/authentication-access/application-roles)|

## Next steps

For more information about Azure Arc-enabled SQL Managed Instance identity and access management, see the following articles:

- [Azure Arc-enabled SQL Managed Instance with Active Directory authentication](/azure/azure-arc/data/active-directory-introduction)
- [Azure Arc-enabled SQL Managed Instance in Active Directory authentication pre-requisites](/azure/azure-arc/data/active-directory-prerequisites)
- [Tutorial – Deploy Active Directory connector using Azure CLI](/azure/azure-arc/data/deploy-active-directory-connector-cli)
- [Deploy Active Directory integrated Azure Arc-enabled SQL Managed Instance](/azure/azure-arc/data/deploy-active-directory-sql-managed-instance)
- Experience Azure Arc-enabled SQL MI automated scenarios with [Azure Arc Jumpstart](https://azurearcjumpstart.io/azure_arc_jumpstart/azure_arc_data/).
- To learn more about Azure Arc, review the [Azure Arc learning path on Microsoft Learn](/learn/paths/manage-hybrid-infrastructure-with-azure-arc/).
