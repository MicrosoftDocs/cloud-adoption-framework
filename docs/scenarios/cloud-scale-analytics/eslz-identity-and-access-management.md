---
title: Identity and access management for cloud-scale analytics
description: Learn how this scenario can improve identity and access management for cloud-scale analytics in Azure.
author: mboswell
ms.author: mboswell
ms.date: 11/27/2024
ms.topic: conceptual
ms.custom: e2e-data-management, think-tank
---

# Identity and access management

This article examines design considerations and recommendations for identity and access management. It focuses on the deployment of a cloud-scale analytics platform on Microsoft Azure. Since cloud-scale analytics is a mission-critical element, the guidance on the Azure landing zone design areas should also be included in your design.

This article builds on considerations and recommendations about Azure landing zones. For more information, see [Identity and access management](../../ready/landing-zone/design-area/identity-access.md).

## Data landing zone design

Cloud-scale analytics supports an access control model using Microsoft Entra identities. The model uses both Azure role-based access control (Azure RBAC) and access control lists (ACLs).

Review the Azure administration and management activities your teams perform. Consider your cloud-scale analytics on Azure. Determine the best possible distribution of responsibilities within your organization.

## Role assignments

In order to develop, deliver, and serve data products autonomously within the data platform, data application teams require few access rights within the Azure environment. Before discussing the respective RBAC requirements, it's important to highlight that different access models should be used for development and higher environments. Also, security groups should be used wherever possible to reduce the number of role assignments and to simplify the management and review process of RBAC rights. This step is critical, due to the [limited number of role assignments that can be created per subscription](/azure/azure-resource-manager/management/azure-subscription-service-limits#azure-rbac-limits).

The development environment should be accessible to the development team and their respective user identities. This access enables them to iterate more quickly, learn about certain capabilities within Azure services, and troubleshoot issues effectively. Access to a development environment helps when developing or enhancing the infrastructure as code (IaC) and other code artifacts. After an implementation within the development environment works as expected, it can be rolled out continuously to the higher environments. Higher environments, such as test and prod, should be locked off for the data application team. Only a service principal should have access to these environments and therefore all deployments must be executed through the service principal identity by using CI/CD pipelines. To summarize, in the development environment access rights should be provided to a service principal AND user identities and in higher environments access rights should only be provided to a service principal identity.

To be able to create resources and role assignments between resources within the data application resource groups, `Contributor` and `User Access Administrator` rights must be provided. These rights allow the teams to create and control services within their environment within the [boundaries of Azure Policy](eslz-policies.md). Cloud-scale analytics recommends the usage of private endpoints to overcome the data exfiltration risk and as other connectivity options are blocked by the Azure platform team via policies, data application teams require access rights to the shared virtual network of a data landing zone to be able to successfully set up the required network connectivity for the services they're planning to use. To follow the least privilege principle, overcome conflicts between different data application teams and have a clear separation of teams, cloud-scale analytics proposes to create a dedicated subnet per data application team and create a `Network Contributor` role assignment to that subnet (child resource scope). This role assignment allows the teams to join the subnet using private endpoints.

These two first role assignments enable self-service deployment of data services within these environments. To address the cost management concern, organizations should add a cost center tag to the resource groups to enable cross-charging and distributed cost ownership. This raises awareness within the teams and enforces them to make the right decisions with respect to required SKUs and service tiers.

To also enable self-service use of other shared resources within the data landing zone, few extra role assignments are required. If access to a Databricks environment is required, organizations should use the [SCIM Synch from Microsoft Entra ID](/azure/databricks/administration-guide/users-groups/scim/aad) to provide access. This is important because this mechanism automatically syncs users and groups from Microsoft Entra ID to the Databricks data plane and also automatically removes access rights when an individual leaves the organization or business. Within Azure Databricks, the data application teams should be given `Can Restart` access rights to a predefined cluster to be able to run workloads within the workspace.

Individual teams require access to the Microsoft Purview account to discover data assets within the respective data landing zones. In addition, the teams will in most cases require the option to edit cataloged data assets that they're owning in order to provide extra details such as contact details of data owners and experts as well as more granular details about what columns within a dataset describe and what information they're including.

### Summary of role based access control requirements

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
        In order to set up virtual network peering between the data landing zone network and the data management landing zone network, the service principal needs `Network Contributor` access rights on the resource group of the remote virtual network.
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
        This permission is required to share the self-hosted integration runtime that gets deployed into the `integration-rg` resource group with other data factories. It's also required to assign the Azure Data Factory and Azure Synapse Analytics managed identities access on the respective storage account file systems.
    :::column-end:::
    :::column span="2":::
        (Resource scope) `/subscriptions/{{dataLandingZone}subscriptionId}`
    :::column-end:::
:::row-end:::

> [!NOTE]
> The number of role assignments can be reduced in a production scenario. The `Network Contributor` role assignment is only required to set up the virtual network peering between the data management landing zone and the data landing zone. Without this consideration, DNS resolution doesn't work. Inbound and outbound traffic is dropped because there is no line of sight to the Azure Firewall.
>
> The `Private DNS Zone Contributor` is also not required if the deployment of DNS A-records of the private endpoints is automated through Azure policies with `deployIfNotExists` effect. The same is true for the `User Access Administrator` because the deployment can be automated using `deployIfNotExists` policies.

### Role assignments for data products

The following role assignments are required for deploying a data product within a data landing zone:

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

## Access to other resources

Outside of Azure, data application teams also require access to a repository to store code artifacts, collaborate effectively, and roll out updates and changes consistently via CI/CD to higher environments. In addition, a project board should be provided to allow for agile development, sprint planning, tracking of tasks and as well as user feedback and feature requests.

Lastly, the CI/CD automation requires setting up a connection to Azure, which is done in most services via service principles. Hence, teams require access to a service principle to achieve automation within their project.

## Managing access to data

Managing access to data should be done using Microsoft Entra groups. Add user principle names or service principal names to the Microsoft Entra groups. Add the groups to the services and grant permissions to the group. This approach allows for fine-grained access control.

For more information on how to drive security for data management landing zones and data landing zones managing your data estate, see [Authentication for cloud-scale analytics in Azure](./secure-authentication.md).

## Next steps

- [Network topology and connectivity](./eslz-network-topology-and-connectivity.md)
