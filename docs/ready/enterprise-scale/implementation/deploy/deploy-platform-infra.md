---
title: Deploy platform infrastructure
description: Deploy platform infrastructure
author: tbd
ms.author: tbd
ms.date: 06/01/2020
ms.topic: deploy
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Navigation menu

* [Overview](../../README.md)
* [CAF enterprise-scale architecture](../CAF enterprise-scale-Architecture.md)
  * [Design principles](../Design-Principles.md)
  * [Design guidelines](../Design-Guidelines.md)
    * [A - Enterprise enrollment and Microsoft Azure Active Directory tenants](../A-Enterprise-Enrollment-and-Azure-AD-Tenants.md)
    * [B - Identity and access management](../B-Identity-and-Access-Management.md)
    * [C - Management group and subscription organization](../C-Management-Group-and-Subscription-Organization.md)
    * [D - Network topology and connectivity](../D-Network-Topology-and-Connectivity.md)
    * [E - Management and monitoring](../E-Management-and-Monitoring.md)
    * [F - Business continuity and disaster recovery](../F-Business-Continuity-and-Disaster-Recovery.md)
    * [G - Security, governance, and compliance](../G-Security-Governance-and-Compliance.md)
    * [H - Platform automation and DevOps](../H-Platform-Automation-and-DevOps.md)
  * [Implementation guide](../Implementation-Guide.md)
* [Contoso reference](../Contoso/Readme.md)
  * [Scope and design](../Contoso/Scope.md)
  * [Implementation](../Contoso/Design.md)
* [Using reference implementation in your own environment](./Readme.md)
  * [Getting started](./Getting-Started.md)
    * [Prerequisites](./Prerequisites.md)
    * [Validate prerequisites](./Validate-prereqs.md)
  * [Configure your own environment](./Using-Reference-Implementation.md)
    * [Configure GitHub](./Configure-run-initialization.md)
    * [Provision platform](./Deploy-platform-infra.md)
    * [Create landing zones](./Deploy-lz.md)
    * [Trigger deployments locally](./Trigger-local-deployment.md)
  * [CAF enterprise-scale template schema](./northstar-schema.md)
    * [Generic CAF enterprise-scale Microsoft Azure Resource Manager template](./northstar-template-schema.md)
    * [CAF enterprise-scale Azure Resource Manager parameters file](./northstar-parameters-schema.md)
  * [Known issues](./Known-Issues.md)
* [How do I contribute?](../CAF enterprise-scale-Contribution.md)
* [FAQ](../northstar-FAQ.md)
* [Road map](../northstar-roadmap.md)

---

# Provision platform

This article describes how to deploy the platform infrastructure for the CAF enterprise-scale reference implementation into your own environment. If you haven't completed the first step please start [here](./Configure-run-initialization.md).

![Deploy your own environment process - step 2](./media/deploy-environment-step-2.png)

## Deployment artifact overview

It is important that you're familiar with the AzOps folder structure created during environment discovery and repository initialization. To describe the desired state of platform subscriptions/landing zones, we apply changes only in the _managementgroupscope_.parameters.json in the .AzState folder. This is how the folder structure should look within your environment:

```bash
    AzOps
    └───Tenant Root Group
        ├───<YourCompanyName>                              # NEW company root management group
        │   ├───.AzState
        │   │   └───<YourCompanyName>.parameters.json
        │   ├───Landing Zones
        │   │   └───.AzState
        │   │       └───LandingZones.parameters.json
        │   ├───Platform
        │   │   └───.AzState
        │   │       └───Platform.parameters.json
        │   ├───Sandbox
        │   │   └───.AzState
        │   │       └───Sandbox.parameters.json
        │   └───Decommissioned
        │       └───.AzState
        │           └───Decommissioned.parameters.json
        ├───.....
```

Each _managementgroupscope_.parameters.json file has the following section, and it's the most important part of the parameter files. This is the primary section where you need to apply the changes in this guide. You can learn more about the *.parameters.json schema [here](./NorthStar-parameters-schema.md).

``` bash
    # empty part of a parameter json file after initialization
    "properties": {
        "policySetDefinitions": [],
        "roleAssignments": [],
        "policyAssignments": [],
        "policyDefinitions": [],
        "roleDefinitions": []
    }
```

There are two groups of properties in this section _\*Definitions\*_ and _\*Assignments\*_.  

__Definitions:__ All definitions (`policy`, `role` and `policySet`) have to be deployed on the 'YourCompanyName' management group scope and with this in the 'YourCompanyName'.parameters.json file.
>Note: in the Azure portal `policySetDefinitions`, it's also known as an initiative. It represents a set of Azure Policy definitions.

__Assignments :__ The assignments (`role`, `policy`) can be deployed at any management group scope as long as the definition exists on the same scope or above. To simplify management, it's recommended to reduce the number of scopes where you assign Azure Policy and role-based access control roles. In the CAF enterprise-scale reference implementation, we recommend to assign only at the following three scopes:

1. 'YourCompanyName' __Management Group__ scope for all company-wide policies
2. Platform Subscription scope for Azure Policy deploying Platform resources
3. Landing zones __Management Group__ scope for all landing zones specific to Azure Policy

## Deployment flow

In this reference implementation, we're using GitHub and GitHub Actions to push and pull changes to and from your Azure environment. All the changes need to be committed to a feature branch and merged to the master using a pull request. The pull request triggers a GitHub Action validating changes, followed by a deployment to Azure.  

The following diagram illustrates the flow to deploy definitions:

![Landing zone definitions deployment process](./media/lz-definition-deployment.png)

The second step is to deploy the assignment with a similar process:

![Landing zone assignment deployment process](./media/lz-assignments-deployment.png)

## Deploying definitions

1. Select the 'YourCompanyName' management group scope for the definitions and then modify the _'YourCompanyName'.parameters.json_ in the _.AzState_ folder.  Definitions need to be added in the respective section of _*.parameters.json_ file:

    ``` bash
    # empty part of a parameter json file after initialization
    "properties": {
        "policySetDefinitions": [],
        "roleAssignments": [],
        "policyAssignments": [],
        "policyDefinitions": [],
        "roleDefinitions": []
    }
    ```

    As a reference for Azure Policy definition, you can select the sample definition in the [AzOpsReference](https://github.com/Azure/CET-NorthStar/tree/master/AzOpsReference/3fc1081d-6105-4e19-b60c-1ec1252cf560/contoso/.AzState) folder. Filter files with _policyDefinitions_ in the name.

2. Update the `policyDefinitions`, `roleDefinitions` or `policySetDefinitions` in the 'YourCompanyName'.parameters.json file. Make sure that you always add it as an array object `[]`.

    ``` bash
    ....
    # here an empty example for the policyDefinitions
    "policyDefinitions": [
        {
            # Copy value object content of a Azure Policy from the AzOpsReference here.
        },
        {
            # Copy value object content of a Azure Policy from the AzOpsReference here.
        }
    ],
    ...
    ```

    > It is important that you add __all__ custom Azure Policies in the [AzOpsReference folder](https://github.com/Azure/CET-NorthStar/tree/master/AzOpsReference/3fc1081d-6105-4e19-b60c-1ec1252cf560/contoso/.AzState) to your _'YourCompanyName.parameters.json_ file.

3. Git stage and commit locally, and then push changes to your remote feature branch. __Do not push changes directly in the *master* branch in this step__

    ``` bash
    git push <remote-name>
    ```

4. Create a pull request to the master branch. GitHub runs a pull request check and pushes the changes to the target Azure environment. You can monitor the status in the Actions log. Once all the checks are successful, you can squash and merge your changes to the master branch.

(Optional step) reinitialize/update the repository on your master branch. This will match all definitions with the resource ids required for the assignments in the next section.

``` powershell
    Initialize-AzOpsRepository -Recurse -Verbose
```

> Note: this step will be automated once the GitHub pull request is fully operational.

## Create a platform subscription

The platform infrastructure is deployed across __three__ Azure Subscriptions on the platform management group scope:

![Platform subscriptions](./media/platform-subscriptions.png)

* __Management Subscription__ : where all cross-platform management resources are deployed (such as a centralized Azure Monitor Logs workspace)
* __Connectivity Subscription__ : where all the networking resources are deployed (such as Azure Virtual WAN or Azure Firewall)
* __Identity Subscription__ : where domain controllers are deployed for Virtual WAN-based CAF enterprise-scale implementations

In a CAF enterprise-scale implementation, all platform resources in the __Connectivity__ and __Management__ subscriptions are deployed via Microsoft Azure Policy. CAF enterprise includes policy definitions and assignments required to deploy the necessary resources. While it's possible to follow the GitHub steps described in this to deploy Azure Policy definitions and assignments within the CAF enterprise deployment process, CAF enterprise provides flexibility for how the assignments can be done within platform subscriptions.

Not all resources in __Identity__ subscriptions are deployed via Azure Policy, as each organization has a different method to deploy Azure AD domain controllers.

The following sections describe how to deploy platform infrastructure resources across three platform subscriptions. Before continuing with the steps below, ensure that the __Management__, __Connectivity__, and __Identity__ subscriptions have been created and assigned at the __Platform__ management group scope.

### Management subscription

During CAF enterprise-scale reference implementation, Azure resources in the __Management__ subscription are deployed via Azure Policy. CAF enterprise-scale includes the policy definitions and assignments required to deploy the necessary resources in the __Management__ subscription. We will walk you though how to assign the Azure Policy later in the article. We need two Azure Policy assignments to create the Azure Monitor Logs workspace and Azure Automation account required in the **Management** subscription:

A required and customized Azure Policy definition:

| Policy name                | Scope                   | Description                                                                     |
|----------------------------|-------------------------|---------------------------------------------------------------------------------|
| Deploy-LogAnalytics        | management subscription | Deploys an Azure Monitor Logs workspace into your subscription                        |
| Deploy-LogAnalytics-Config | management subscription | Configures the Azure Monitor Logs workspace with the required counters and solutions |

Azure Policy assignments required in a _management_ subscription:

| Policy name          | Type | Scope | Parameter description |
|----------------------|------|-------|-----------------------|
| Deploy-LogAnalytics-_\<region\>_  | custom policy | management Subscription | _workspaceName:_ LA workspace name<br>_workspaceRegion:_ Azure DC region for LA<br>_automationAccountName:_ Linked Azure Automation Account, will be created with this Policy<br>_automationRegion:_ Azure DC region for the Azure Automation Account<br>_rgName_: Resource Group in which the resource reside |
| Deploy-LogAnalytics-Config-_\<region\>_ | custom policy | management Subscription | _workspaceName:_ LA workspace name this configration will be applied<br>_workspaceRegion:_ Azure DC region of the LA workspace |

> Note: How-to [assign Azure Policy](#deployment-of-assignments) at the _Management_ Subscription scope describs the process in detail.

### Connectivity subscription

The resource in the __Connectivity__ subscription will be deployed via Azure Policy following the CAF enterprise-scale reference implementation. We need four Azure Policy assignments to create the VWAN, virtual hub (VHub), Azure Firewall policy, and distributed denial-of-service (DDoS) resources required in the __Connectivity__ subscription. The resources in the regional __Connectivity__ subscription will be deployed using DeployIfNotExist policy.

A required and customized Azure Policy definition:

| Policy name          | Scope | Description |
| ---------------------|-------|-------------|
| Deploy-VWAN          |'YourCompanyName' MG|Deploys the VWAN service into the connectivity subscription
| Deploy-FirewallPolicy|'YourCompanyName' MG|Configures the firewall policies and rules for Azure Firewall
| Deploy-VHUB          |'YourCompanyName' MG|Deploys a regional VHUB resource along with required gateways (ER/VPN) and Azure Firewall
| Deploy-DDoSProtection|'YourCompanyName' MG|Deploys a DDoS Standard plan service

Azure Policy assignments required in a _connectifity_ subscription:

| Policy name          | Type | Scope | Parameter description |
|----------------------|------|-------|-----------------------|
| Deploy-VWAN          | Custom Policy | connectivity Subscription|_vwanname:_ VWAN resource name<br>_vwanRegion:_ Azure Region the service will be deployed to<br>_rgName:_ RG name where the resource will be deploy to. Policy will create RG if not exists|_vwanname:_ yourcompanyname-vwan<br>_vwanRegion:_ North Europe<br>_rgName:_ yourcompanyname-global-vwan
| Deploy-Firewall Policy| Custom Policy |connectivity Subscription|_fwpolicy:_ Firewall policy configruation JSON object<br>_fwPolicyRegion:_ Azure Region the service will be deployed to (identical with VHUB)<br>_rgName:_ RG name where the resource will be deploy to. Policy will create RG if not exists
| Deploy-VHUB-_\<region\>_     | Custom Policy |connectivity Subscription|_vwanname:_ VWAN resource name<br>_vhubname:_ VHUB resource name<br>_vhub:_ VHUB configuration JSON object (location, addressPrefix, ...)<br>_vpngw:_ VPN Gateway configuration JSON object (name, BGP, scale unit)<br>_ergw:_ Express Route Gateway configuration JSON object<br>_azfw:_ Azure Firewall configuration JSON object (name, policy Id)<br>_rgName:_ RG name where the resource will be deploy to. Policy will create RG if not exists|
| Deploy-DDoSProtection| Custom Policy |connectivity Subscription|_ddosName:_ Resource name for the DDoS service<br>_ddosRegion:_ Azure Region the service will be deployed to (identical with VHUB)<br>_rgName:_ RG name where the resource will be deploy to. Policy will create RG if not exists|_ddosName:_ yourcompanyname-ddos-std-plan<br>_ddosRegion:_ North Europe<br>_rgName:_ yourcompanyname-global-ddos
| Enable Data Protection Suite | Initiative | connectivity Subscription| n/a
| Enable Monitoring in Azure Security Center | Initiative | connectivity Subscription| using default parameter

> Note: how to [assign Azure Policy](#deployment-of-assignments) at the _connectivity_ subscription scope describes the process in detail.

### Identity subscription

In the CAF enterprise-scale reference implementation, the **Identity** subscription is only required when deploying a VWAN-based CAF enterprise-scale implementation since domain controllers can't be deployed in a managed VHub. For non-VWAN CAF enterprise-scale reference implementations—traditional hub-and-spoke network architecture—the **Identity** subscription isn't required, as domain controllers should be deployed in the central Hub VNet.

The following instructions provide guidance for deploying the required resources for the **Identity** subscription for both VWAN- non-VWAN-based CAF enterprise-scale implementations:

__VWAN-based CAF enterprise-scale implementation__

// TODO Required custom Azure Policy definition:

| Policy name          | Scope              | Description                                                        |
| ---------------------|--------------------|--------------------------------------------------------------------|
| Deploy-vNET          |'YourCompanyName' MG| Deploys a VNet and and connects it to the local VWAN VHub.|

Azure Policy assignments required on _identity_ Subscription (per region a policy is required):

| Policy name          | Type | Scope                |
|----------------------|------|----------------------|
| Deploy-vNET | Custom policy | 'YourCompanyName' MG |

Once the vNET is created, two Azure AD domain controllers can be created in the VNet with your company's procedures.

__Non-VWAN-based CAF enterprise-scale implementation__
1. In a regional hub VNet, deploy two Azure AD domain controllers following your company's procedures.
2. Repeat the process for each regional hub VNet.

## Deployment of assignments

1. In one of the [previous section](#deployment-of-definitions) all the defintions have been updated with an resource ID. ID's are updated in the _'YourCompanyName'.parameters.json_ files in the _.AzState_ folder on 'YourCompanyName' scope. In addition to the updated _.parameters.json_ each definition is represented in an separate file in the same _.AzState_ folder. The pull or a respository discovery operation keeps all files and the related properties in the _.AzState_ folder in sync.

```bash
    # Simplified folder structure after initialization
    AzOps
    └─── Tenant Root Group
        └─── <YourCompanyName> # Management group
            ├─── .AzState
            │   ├─── <YourCompanyName>.parameters.json # File containing the ID's
            │   ├─── *_policyDefinitions-<policy-name-1>.parameters.json # Policy defintion
            │   .
            │   └─── *_policyDefinitions-<policy-name-n>.parameters.json # Policy defintion
            ├─── Landing Zones # Management group under Contoso
            │   ├─── .AzState
            │   │   ├─── LandingZones.parameters.json # File containing the ID's
            │   │   ├─── *_policyDefinitions-<policy-name-1>.parameters.json # Policy defintion
            │   │   .
            │   │   └─── *_policyDefinitions-<policy-name-2>.parameters.json # Policy defintion
```

To assign `policyAssignments` and `roleAssignments`, the _managementGroupName_.parameters.json file needs to be updated a second time, as done for the definitions.  
Three scopes for the assignment need to be considered to follow the CAF enterprise-scale reference implementation:

1. Your company name: management group scope
2. Landing zone: management group scope
3. _connectivity_ / _management_ / _identity: subscription scope

As a reference for Azure Policy assignment, you can select a reference Azure Policy assignment in the [AzOpsReference](https://github.com/Azure/CET-NorthStar/tree/master/AzOpsReference/3fc1081d-6105-4e19-b60c-1ec1252cf560/contoso/.AzState) folder. Filter files with _policyAssignments_ in the name. After copying the object, replace all the values with the value  \<replace-me\>. This needs to be done mainly for the attributes `policyDefinitionId` and `scope`.

* `policyDefinitionId`: Full resource ID (including scope path) of the definition
* `scope`: Assignment scope for the definition

``` bash
    ....
    # here an empty example for the policyAssigments
    "policyAssignments": [
        {
            # Copy value object content of a Azure Policy from the AzOpsReference here.
        },
        {
            # Copy value object content of a Azure Policy from the AzOpsReference here.
        }
    ],
    ...
```

Next, Git stage and commit locally, and then push changes to your remote feature branch. __Do not push changes directly in the *master* branch in this step__

    ``` bash
    git push <remote-name>
    ```

Lastly, create a pull request to the master branch. GitHub runs a pull request check and pushes the changes to the target Azure environment. You can monitor the status in the Actions log. Once all the checks are successful you have to squash and merge your changes to the master branch.

>Note: ikf the Azure Policy assignment fails, please run the checks a second time. There is currently a known problem with the Azure Policy assignment, which the product team is currently fixing.

---

## Finalize platform deployment

You can now follow the progress and see how the resources are getting deployed into the platform Subscriptions. When the resources are deployed, the platform can start updating configurations if needed. One thing that you or your NetOps team may start doing is adjusting the firewall policies/rules in the Azure Portal or through the AzOps pipeline.
