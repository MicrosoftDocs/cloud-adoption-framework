---
title: Identity and Access Management for Cloud-Scale Analytics
description: Learn how this scenario can improve identity and access management for cloud-scale analytics in Azure.
author: mboswell
ms.author: mboswell
ms.date: 01/29/2025
ms.topic: conceptual
ms.custom: e2e-data-management, think-tank
---

# Identity and access management

This article outlines design considerations and recommendations for identity and access management. It focuses on the deployment of a cloud-scale analytics platform on Microsoft Azure. Because cloud-scale analytics is a mission-critical component, you should follow the guidance about Azure landing zone design areas when you design your solution.

This article builds on considerations and recommendations about Azure landing zones. For more information, see [Identity and access management design area](../../ready/landing-zone/design-area/identity-access.md).

## Data landing zone design

Cloud-scale analytics supports an access control model by using Microsoft Entra identities. The model uses Azure role-based access control (Azure RBAC) and access control lists.

Review the Azure administration and management activities that your teams perform. Evaluate your cloud-scale analytics on Azure. Determine the best possible distribution of responsibilities within your organization.

## Role assignments

To develop, deliver, and serve data products autonomously within the data platform, data application teams require several access rights within the Azure environment. It's important to note that you should use different access models for development and higher environments. Use security groups when possible to reduce the number of role assignments and to simplify the management and review process of RBAC rights. This step is crucial because of the [limited number of role assignments that you can create for each subscription](/azure/azure-resource-manager/management/azure-subscription-service-limits#azure-rbac-limits).

The development environment should be accessible to the development team and their respective user identities. This access enables them to iterate more quickly, learn about certain capabilities within Azure services, and troubleshoot problems effectively. Access to a development environment can help you develop or enhance infrastructure as code and other code artifacts.

After you confirm that an implementation works as expected in the development environment, it can be rolled out continuously to higher environments. Higher environments, such as testing and production, should be locked off for the data application team. Only a service principal should have access to these environments. As such, all deployments must be run through the service principal identity by using continuous integration and continuous delivery (CI/CD) pipelines. In the development environment, provide access rights to both a service principal and user identities. In higher environments, restrict access rights to the service principal identity only.

To create resources and role assignments between resources within the data application resource groups, you must provide `Contributor` and `User Access Administrator` rights. These rights allow the teams to create and control services in their environment within the [boundaries of Azure Policy](eslz-policies.md). 

To reduce the risk of data exfiltration, it's cloud-analytics best practices to use private endpoints. The Azure platform team blocks other connectivity options via policies, so data application teams need access rights to the shared virtual network of a data landing zone. This access is essential for setting up the necessary network connectivity for the services that they plan to use. 

To follow the principle of least privilege, avoid conflicts between different data application teams and have a clear separation of teams. It's cloud-scale analytics best practices to create a dedicated subnet for each data application team and create a `Network Contributor` role assignment for that subnet, or child resource scope. This role assignment allows the teams to join the subnet by using private endpoints.

These first two role assignments enable the self-service deployment of data services within these environments. To address cost management concerns, organizations should add a cost center tag to the resource groups to enable cross-charging and distributed cost ownership. This approach raises awareness within the teams and helps ensure that they make informed decisions about required SKUs and service tiers.

To enable self-service use of other shared resources within the data landing zone, a few extra role assignments are required. If access to an Azure Databricks environment is required, organizations should use [SCIM sync from Microsoft Entra ID](/azure/databricks/administration-guide/users-groups/scim/aad) to provide access. This synchronization mechanism is important because it automatically synchronizes users and groups from Microsoft Entra ID to the Azure Databricks data plane. It also automatically removes access rights when an individual leaves the organization or business. In Azure Databricks, give the data application teams `Can Restart` access rights to a predefined cluster so that they can run workloads within the workspace.

Individual teams require access to the Microsoft Purview account to discover data assets within their respective data landing zones. Teams often need to edit cataloged data assets that they own to provide extra details like the contact information of data owners and experts. Teams also require the ability to provide more granular information about what each column in a dataset describes and includes.

### Summary of RBAC requirements

To automate the deployment of data landing zones, the following roles are required:

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
        Deploy all private DNS zones for all data services into a single subscription and resource group. The service principal needs to be `Private DNS Zone Contributor` on the global DNS resource group that was created during the data management landing zone deployment. This role is required to deploy A-records for the private endpoints.
    :::column-end:::
    :::column span="2":::
        (Resource group scope) `/subscriptions/{{dataManagement}subscriptionId}/resourceGroups/{resourceGroupName}`
    :::column-end:::
:::row-end:::
:::row:::
    :::column span="1":::
        [Network Contributor](/azure/role-based-access-control/built-in-roles#network-contributor)
    :::column-end:::
    :::column span="3":::
        To set up virtual network peering between the data landing zone network and the data management landing zone network, the service principal needs `Network Contributor` access rights on the resource group of the remote virtual network.
    :::column-end:::
    :::column span="2":::
        (Resource group scope) `/subscriptions/{{dataManagement}subscriptionId}/resourceGroups/{resourceGroupName}`
    :::column-end:::
:::row-end:::
:::row:::
    :::column span="1":::
        [User Access Administrator](/azure/role-based-access-control/built-in-roles#user-access-administrator)
    :::column-end:::
    :::column span="3":::
        This permission is required to share the self-hosted integration runtime that gets deployed into the `integration-rg` resource group with other data factories. It's also required to assign the Azure Data Factory managed identities access on the respective storage account file systems.
    :::column-end:::
    :::column span="2":::
        (Resource scope) `/subscriptions/{{dataLandingZone}subscriptionId}`
    :::column-end:::
:::row-end:::

> [!NOTE]
> In a production scenario, you can reduce the number of role assignments. The `Network Contributor` role is only required to set up the virtual network peering between the data management landing zone and the data landing zone. Without this role, DNS resolution fails. Also, inbound and outbound traffic is dropped because there's no line of sight to Azure Firewall.
>
> The `Private DNS Zone Contributor` role isn't required if the deployment of DNS A-records for the private endpoints is automated through Azure policies with the `deployIfNotExists` effect. The same is true for the `User Access Administrator` role because you can automate the deployment by using `deployIfNotExists` policies.

### Role assignments for data products

The following role assignments are required to deploy a data product within a data landing zone:

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
        Deploy all private DNS zones for all data services into a single subscription and resource group. The service principal needs to be `Private DNS Zone Contributor` on the global DNS resource group that was created during the data management landing zone deployment. This role is required to deploy A-records for the respective private endpoints.
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
        Deploy all data integration streaming services into a single resource group within the data landing zone subscription. The service principal requires a `Contributor` role assignment on that resource group.
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
        To deploy private endpoints to the specified Azure Private Link subnet that was created during the data landing zone deployment, the service principal requires `Network Contributor` access on that subnet.
    :::column-end:::
    :::column span="2":::
        (Child resource scope) `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName} /providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}"`
    :::column-end:::
:::row-end:::

## Access to other resources

Outside of Azure, data application teams require access to a repository to store code artifacts, collaborate effectively, and roll out updates and changes consistently to higher environments via CI/CD. You should provide a project board to allow for agile development, sprint planning, task tracking, and managing user feedback and feature requests.

To automate CI/CD, establish a connection to Azure. This process is done in most services via service principals. Because of this requirement, teams must have access to a service principal to achieve automation in their project.

## Manage access to data

Manage access to data by using Microsoft Entra groups. Add user principal names or service principal names to the Microsoft Entra groups. Then add those groups to the services and grant permissions to the group. This approach allows for fine-grained access control.

For more information about how to drive security for data management landing zones and data landing zones that manage your data estate, see [Authentication for cloud-scale analytics in Azure](./secure-authentication.md).

## Next step

> [!div class="nextstepaction"]
> [Networking overview](./eslz-network-topology-and-connectivity.md)
