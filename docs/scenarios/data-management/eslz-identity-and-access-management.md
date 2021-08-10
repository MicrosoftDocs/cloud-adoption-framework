---
title: Identity and access management for data management and analytics in Azure
description: Learn how this enterprise-scale scenario can improve identity and access management of data management and analytics in Azure.
author: mboswell
ms.author: mboswell
ms.date: 07/19/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Identity and access management for data management and analytics

This article examines design considerations and recommendations for identity and access management. It focuses on the deployment of a data management and analytic platform on Microsoft Azure. Since data management and analytics is a mission-critical element, the guidance on the enterprise-scale design areas should also be included in your design.

This article builds on considerations and recommendations about Azure landing zones. For more information, see [Identity and access management](../../ready/enterprise-scale/identity-and-access-management.md).

## Data landing zone design

Enterprise-scale for analytics and AI supports an access control model using Azure Active Directory (Azure AD) identities. The model uses both Azure role-based access control (Azure RBAC) and access control lists (ACLs).

Review the Azure administration and management activities your teams perform. Consider your data management and analytics on Azure. Determine the best possible distribution of responsibilities within your organization.

### Role assignments

For automation purposes of deploying data landing zones, you need these roles:

:::row:::
    :::column span="1":::
        Role name
    :::column-end:::
    :::column span="3":::
        Description
    :::column-end:::
    :::column span="2":::
        Scope
    :::column-end:::
:::row-end:::
:::row:::
    :::column span="1":::
        [Private DNS Zone Contributor](/azure/role-based-access-control/built-in-roles#private-dns-zone-contributor)
    :::column-end:::
    :::column span="3":::
        Deploy all private DNS zones for all data services into a single subscription and resource group. The service principal needs to be `Private DNS Zone Contributor` on the global DNS resource group that was created during the data management zone deployment. This role is required to deploy A-records for the private endpoints.
    :::column-end:::
    :::column span="2":::
        (Resource group scope) `/subscriptions/{{datamanagement}subscriptionId}/resourceGroups/{resourceGroupName}`
    :::column-end:::
:::row-end:::
:::row:::
    :::column span="1":::
        [Network Contributor](/azure/role-based-access-control/built-in-roles#network-contributor)
    :::column-end:::
    :::column span="3":::
        In order to set up virtual network peering between the data landing zone network and the data management landing zone network, the service principal needs `Network Contributor` access rights on the resource group of the remote virtual network.
    :::column-end:::
    :::column span="2":::
        (Resource group scope) `/subscriptions/{{datamanagement}subscriptionId}/resourceGroups/{resourceGroupName}`
    :::column-end:::
:::row-end:::
:::row:::
    :::column span="1":::
        [User Access Administrator](/azure/role-based-access-control/built-in-roles#user-access-administrator)
    :::column-end:::
    :::column span="3":::
        This permission is required to share the self-hosted integration runtime that gets deployed into the `integration-rg` resource group with other data factories. It's also required to assign the Azure Data Factory and Azure Synapse Analytics managed identities access on the respective storage account file systems.
    :::column-end:::
    :::column span="2":::
        (Resource scope) `/subscriptions/{{datalandingzone}subscriptionId}`
    :::column-end:::
:::row-end:::

> [!NOTE]
> The number of role assignments can be reduced in a production scenario. The `Network Contributor` role assignment is only required to set up the virtual network peering between the data management landing zone and the data landing zone. Without this consideration, DNS resolution doesn't work. Inbound and outbound traffic is dropped because there is no line of sight to the Azure Firewall.
>
> The `Private DNS Zone Contributor` is also not required if the deployment of DNS A-records of the private endpoints is automated through Azure policies with `deployIfNotExists` effect. The same is true for the `User Access Administrator` because the deployment can be automated using `deployIfNotExists` policies.

### Role assignments for data integration and data products

The following role assignments are required for a deployment of a data integration and data product within a data landing zone:

:::row:::
    :::column span="1":::
        Role name
    :::column-end:::
    :::column span="3":::
        Description
    :::column-end:::
    :::column span="2":::
        Scope
    :::column-end:::
:::row-end:::
:::row:::
    :::column span="1":::
        [Private DNS Zone Contributor](/azure/role-based-access-control/built-in-roles#private-dns-zone-contributor)
    :::column-end:::
    :::column span="3":::
        Deploy all private DNS zones for all data services into a single subscription and resource group. The service principal needs to be `Private DNS Zone Contributor` on the global DNS resource group that was created during the data management zone deployment. This role is required to deploy A-records for the respective private endpoints.
    :::column-end:::
    :::column span="2":::
        (Resource group scope) `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}`
    :::column-end:::
:::row-end:::
:::row:::
    :::column span="1":::
        [Contributor](/azure/role-based-access-control/built-in-roles#contributor)
    :::column-end:::
    :::column span="3":::
        Deploy all data-integration-streaming services into a single resource group within the data landing zone subscription. The service principal requires a `Contributor` role-assignment on that resource group.
    :::column-end:::
    :::column span="2":::
        (Resource group scope)  `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}`
    :::column-end:::
:::row-end:::
:::row:::
    :::column span="1":::
        [Network Contributor](/azure/role-based-access-control/built-in-roles#network-contributor)
    :::column-end:::
    :::column span="3":::
        In order to deploy private endpoints to the specified Private Link subnet, which was created during the data landing zone deployment, the service principal requires `Network Contributor` access on that subnet.
    :::column-end:::
    :::column span="2":::
        (Child-resource scope) `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName} /providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}"`
    :::column-end:::
:::row-end:::

## Managing access to data

Managing access to data should be done using Azure AD groups. Add user principle names or service principal names to the Azure AD groups. Add the groups to the services and grant permissions to the group. This approach allows for fine-grained access control.

For datasets in Azure data lakes, consider using access control lists (ACLs). For more information, see [Access control model in Azure Data Lake Storage Gen2](/azure/storage/blobs/data-lake-storage-access-control-model). Using Azure AD passthrough with access control lists is supported by most native Azure services, including Azure Machine Learning, Azure Synapse Analytics, and Azure Databricks.

Other polyglot storage is likely to be used in enterprise-scale for analytics and AI. Examples include Azure Database for PostgreSQL, Azure Database for MySQL, Azure SQL Database, SQL Managed Instance, and Azure Synapse Analytics. They could be used by data integrations to store read data stores or by data product teams.

- [Use Azure Active Directory for authentication with Azure Database for PostgreSQL](/azure/postgresql/howto-configure-sign-in-aad-authentication)
- [Use Azure Active Directory authentication](/azure/azure-sql/database/authentication-aad-overview) with Azure SQL Database, SQL Managed Instance, and Azure Synapse Analytics
- [Use Azure Active Directory for authenticating with Azure Database for MySQL](/azure/mysql/concepts-azure-ad-authentication)

We recommend that you use Azure AD groups to secure database objects instead of individual Azure AD user accounts. These Azure AD groups are used to authenticate users and help protect database objects. Similar to the data lake pattern, you could use your domain or data products onboarding to create these groups within your Azure AD service.

This approach also gives a single management location and allows reviewing access rights inside the Azure Graph.

For more details on how to drive a security for data management landing zones and data landing zones is managing your data estate, see [Security provisioning](./security-provisioning.md).

## Next steps

[Network topology and connectivity for an data management and analytics](./eslz-network-topology-and-connectivity.md)
