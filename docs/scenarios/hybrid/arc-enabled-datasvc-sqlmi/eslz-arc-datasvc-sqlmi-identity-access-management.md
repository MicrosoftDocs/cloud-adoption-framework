---
title: Identity and access management for Azure Arc-enabled Data Services
description: Describes how to improve identity and access management for the Azure Arc-enabled Data Services.
author: chintalavr
ms.author: vchintala
ms.date: 07/04/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-hybrid, think-tank
---

# Identity and access management for Azure Arc-enabled Data Services

This article describes Azure [Arc-enabled SQL Managed Instance](/azure/azure-arc/data/managed-instance-overview) identity and access management (IAM) architecture, design considerations, recommendations, and role-based access controls for various scenarios.

Azure [Arc-enabled SQL Managed Instance](/azure/azure-arc/data/managed-instance-overview) relies on the Azure [Arc-enabled data services](/azure/azure-arc/data/overview) extension running on Azure Arc-enabled Kubernetes services. Following are the various components of Azure Arc-enabled data services that are of importance to cover Identity and Access Management as part of this critical design area (CDA).

- Azure Arc-enabled data controller
- Kibana dashboard
- Grafana dashboard

## Architecture

Following is the high level architecture of Azure Arc-enabled SQL Managed Instance identity and access management.

[![Diagram that shows AD authentication with SQL Managed Instance.](./media/arc-enabled-sqlmi-adauth-system-keytab.png)](./media/arc-enabled-sqlmi-adauth-system-keytab.png#lighbox)

### Basic Authentication

Basic authentication is supported in Azure Arc-enabled SQL Managed Instance using a local SQL authentication credentials. It is recommended to use this authentication method during the initial setup of the SQL managed instance to support Active Directory authentication and grant required permissions to the database. Once AD authentication is supported avoid using basic authentication for day to day operations and use only for emergency access to the database.

Azure Arc-enabled Data Controller, Grafana, and Kibana dashboards support only basic authentication at this time.

### Active Directory authentication

For many enterprise customers Windows Active Directory(AD) authentication is the standard for enforcing role based access controls (RBAC) with SQL Servers running on-premises and other cloud environments. Azure Arc-enabled SQL managed instance supports Active Directory authentication to seamlessly migrate existing SQL Server databases to Arc-enabled SQL Managed Instance and stay current with latest SQL Server version and security patching.

Azure Arc-enabled SQL Managed Instance uses Kerberos key-tab to support [AD authentication](/azure/azure-arc/data/active-directory-introduction) when running on Arc-enabled Kubernetes environments. [Active Directory connector](/azure/azure-arc/data/active-directory-introduction#what-is-an-active-directory-ad-connector) is a key component in Arc-enabled data services to support AD authentication in Arc-enabled SQL Managed Instance. Following are two ways to generate and manage Kerberos keytab and use in Arc-enabled SQL Managed Instance. Sections below explains the scenarios and when to use these keytab modes.

#### System-managed keytab

[Active Directory connector in system-managed keytab mode](/azure/azure-arc/data/deploy-system-managed-keytab-active-directory-connector#active-directory-connector-in-system-managed-keytab-mode) simplifies service account and keytab management. AD connector takes responsibility of creating service accounts, assigning [service principals](/windows/win32/ad/service-principal-names), and [generating keytab](/windows-server/administration/windows-commands/ktpass) to support AD authentication in Arc-enabled SQL Managed Instance. This is recommended for customers who would prefer simplifying operations over granular control to auto-manage keytab for AD authentication.

Following is the architecture diagram for AD connector with system-managed keytab mode.

[![Diagram that shows AD authentication with SQL Managed Instance.](./media/arc-enabled-sqlmi-adauth-system-keytab.png)](./media/arc-enabled-sqlmi-adauth-system-keytab.png#lighbox)

#### Customer-managed keytab

Active Directory connector with customer-managed keytab mode provides the full control of managing service accounts, service principals, and generating keytab to the customers who strictly follow ITIL process and separation of duties and delegate activities to different teams to comply with organization security policies and governance.

Following is the architecture diagram for AD connector with customer-managed keytab mode.

[![Diagram that shows AD authentication with SQL Managed Instance.](./media/arc-enabled-sqlmi-adauth-customer-keytab.png)](./media/arc-enabled-sqlmi-adauth-customer-keytab.png#lighbox)

### Data controller managed identity integration

When Arc-enabled data services extension is created a [managed identity](/azure/azure-arc/data/create-data-controller-direct-cli?tabs=windows#retrieve-the-managed-identity-and-grant-roles) is created for Arc-enabled data services to interact with Azure resource manager APIs control plane and data plane to perform various actions. Azure Arc data controller uses this managed identity to perform these actions when managing Arc-enabled SQL Managed Instance.

### Azure RBAC on Azure Arc-enabled Data Services

Following are the required RBAC permissions to publish monitoring metrics to Azure Log Analytics workspace.

|Role|Description|
|-----------|------------|
|Contributor|Grants full access to manage all resources in a resource group.|
|Monitoring Metrics Publisher|Enables publishing metrics against Azure resources.|

### Securely access Azure Arc SQL Managed Instance

## Design considerations

Review the [identity and access management design area](/azure/cloud-adoption-framework/ready/enterprise-scale/identity-and-access-management) of Azure landing zones to assess the effect of Azure Arc-enabled data services on your overall identity and access model.

**Arc-enabled data services deployment:**

- Consider the identity being used to deploy Azure Arc-enabled data services depending on the type of deployment such as manual vs GitOps. This identity could be an Azure Active Directory account or Lightweight Directory Access Protocol (LDAP) account from Windows Active Directory domain services or a 3rd party LDAP provider based on how underlying Azure Arc-enabled Kubernetes access controls are managed in on-premises or other cloud environments.

- Consider whether a group based access control or individual identity based access controls are more appropriate for your Information Technology(IT) organization to manage Azure Arc-enabled data services based on the operations overhead created both options. Please refer to design recommendations below for Microsoft recommendations for decision making.

- Decide between Azure Arc-enabled Kubernetes administrators vs database management group(DMG) vs application administration group to deploy and manage Azure Arc-enabled data services depending on your organization security governance and separation of duties requirements.

**Arc-enabled data services access:**

Azure Arc-enabled SQL Managed Instance access controls are fully independent of underlying [Azure Arc-enabled Kubernetes access controls](/azure/azure-arc/kubernetes/azure-rbac). It is important to make few design decisions to administer Arc-enabled SQL Managed Instance and provide access to consumer applications and end users.

- Consider between AD authentication vs SQL authentication depending on the upstream consumer service capabilities to use one of these authentication types. As not all consumers applications support AD authentication, review your organization security policy for allowed authentication types additional security controls necessary when using SQL authentication.

## Design recommendations

**Arc-enabled data services deployment:**

- For enterprise organizations that follow strict ITIL process, isolate teams responsible for managing Arc-enabled data services from Arc-enabled Kubernetes by created different security groups and assign permissions to managed Arc-enabled data services.

**Arc-enabled data services access:**

- Where appropriate use AD authentication with SQL Managed Instance to offload user lifecycle management to the directory services and use security groups in AD to manage user permissions to access SQL database.

- Use SQL authentication with SQL Managed Instance as a least preferred authentication type and when it is not possible to use AD authentication due to the its support in the consumer applications or services.

## Role based access controls (RBAC)

When using system-managed keytab mode explicit permissions to [Domain Service Account(DSA)](/azure/azure-arc/data/active-directory-prerequisites#create-the-domain-service-account-dsa) is required at [Active Directory Organization Unit(OU)](/azure/azure-arc/data/active-directory-prerequisites#create-an-ou) for SQL Managed Instance. Following are [required RBAC permissions](/azure/azure-arc/data/active-directory-prerequisites#set-permissions-for-the-dsa). For customer-managed keytab mode, no explicit permissions required for the domain service account at Active Directory OU level.

|Permission|Description|
|-----------|------------|
|Read all properties|Allow to read all properties of a directory object. |
|Write all properties|Allow updates to all properties of the directory object .|
|Create User objects|Allow creation of directory objects in the OU.|
|Delete User objects|Allow deletion of directory objects in the OU. |
|Reset password| Allow password reset of user objects in the OU.|

## Next steps

For more information about Azure Arc-enabled SQL Managed Instance identity and access management, see the following articles:

- [Azure Arc-enabled SQL Managed Instance with Active Directory authentication](/azure/azure-arc/data/active-directory-introduction)
- [Azure Arc-enabled SQL Managed Instance in Active Directory authentication pre-requisites](/azure/azure-arc/data/active-directory-prerequisites)
- [Tutorial – Deploy Active Directory connector using Azure CLI](/azure/azure-arc/data/deploy-active-directory-connector-cli)
- [Deploy Active Directory integrated Azure Arc-enabled SQL Managed Instance](/azure/azure-arc/data/deploy-active-directory-sql-managed-instance)
