---
title: Xx
description: XX
author: rkuehfus
ms.author: brblanch
ms.date: 06/01/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Provision platform

This article describes how to deploy the platform infrastructure for the enterprise-scale reference implementation into your own environment. If you haven't completed the first step please start [here](./configure-run-initialization.md).

![Deploy your own environment process - step 2](../media/deploy-environment-step-2.png)

## Deployment artifact overview

It is important, that you are familiar with the azops folder structure that has been created during the environment discovery and repository initialization. To describe the desired state of platform subcriptions and landing zone we apply changes only in the _managementgroupscope_.parameters.json in the .azstate folder. This is how the folder structure should look like for your environment:

<!-- TODO: Replace with diagram -->

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

Each _managementgroupscope_.parameters.json file has the following section, and it is the most important part of the parameter files and the section you have to primarily apply changes to using this guide. You can learn more about the *.parameters.json schema [here](./parameters-schema.md).

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

There are two groups of properties in this section _\*definitions\*_ and _\*assignments\*_.

**Definitions:** All the definitions (`policy`, `role` and `policyset`) have to be deployed on the 'yourcompanyname' management group scope and with this in the 'yourcompanyname'.parameters.json file.
>Note: in the Azure portal `policysetdefinitions` is also known as an initiative. It represents a set of Azure Policy definition.

**Assignments:** The assignments (`role`, `policy`) can be deployed at any management group scope as long as the definition exists on the same scope or above. To simplify the management, it is highly recommended to reduce the number of scopes where you assign Azure Policy and RBAC roles. In the enterprise-scale
Reference implementation we recommend to do assignment at the following three scopes only:

- 'Yourcompanyname' `management group` scope for all companywide policies
- Platform subscription scope for Azure Policy deploying platform resourses
- Landing zones `management group` scope for all landing zone specific Azure Policy

## Deployment flow

In this reference implementation we are using GitHub and GitHub Actions to push and pull changes to and from your Azure environment. All the changes need to be committed to a feature branch and merged to the master using pull request (PR). The PR triggers a GitHub action doing the validation of the changes followed by a deployment to Azure.

The following diagram illustrates the flow to deploy the definitions:

![Landing Zone definitions deployment process](../media/lz-definition-deployment.png)

In a second step the assignment need to be deployed following a similar process:

![Landing Zone assignment deployment process](../media/lz-assignments-deployment.png)

## Deployment of definitions

1. Select the 'yourcompanyname' management group scope for the definitions first and modify the _'yourcompanyname'.parameters.json_ in the _.azstate_ folder. Definitions need to be added in the respective section of _*.parameters.json_ file:

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

    As a reference for Azure Policy definition you can select the sample definition in the [azopsreference](https://github.com/Azure/CET-NorthStar/tree/master/AzOpsReference/3fc1081d-6105-4e19-b60c-1ec1252cf560/contoso/.AzState) folder. Filter files with _policydefinitions_ in the name.

2. Update the `policydefinitions`, `roledefinitions` or `policysetdefinitions` in one of two ways:
   1. In the 'yourcompanyname'.parameters.json file. Make sure that you always add it as an array object `[]`.

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

   2. Copying the files from [azopsreference folder](https://github.com/Azure/CET-NorthStar/tree/master/AzOpsReference/3fc1081d-6105-4e19-b60c-1ec1252cf560/contoso/.AzState) to the ```.azstate``` directory for your management group.

    > It is important that you add _all_ custom Azure policies in the [azopsreference folder](https://github.com/Azure/CET-NorthStar/tree/master/AzOpsReference/3fc1081d-6105-4e19-b60c-1ec1252cf560/contoso/.AzState) to your _'yourcompanyname.parameters.json_ file or ```.azstate``` directory.

3. Git stage and commit locally, and then push changes to your remote feature branch. Do not push changes directly into the `master` branch in this step.

    ``` bash
    git push <remote-name>
    ```

4. Create a pull request to the master branch. GitHub Actions runs a PR check and pushes the changes to the target Azure environment. You can monitor the status in the actions log. Once all the checks are successful you can squash and merge your changes to the master branch.

(Optional step) re-initialize/update repository on your master branch. This will complement all the definition with the resource ID's that are required for the assignments in the next section.

``` powershell
    Initialize-AzOpsRepository -Verbose
```

> Note: this step will be automated once pull GitHub action is fully operational.

## Create platform subscription

The platform infrastructure is deployed across three Azure subscriptions on platform management group scope:

![Platform subscriptions](../media/platform-subscriptions.png)

- The `management` subscription, where all cross-platform management resources are deployed (such as centralized Log Analytics workspace)
- The `connectivity` subscription, where all the networking resources are deployed (such as Azure Virtual WAN or Azure Firewall)
- The `identity` subscription, for virtual WAN-based enterprise-scale implementations, this is where domain controllers are deployed.

In a enterprise-scale implementation, all platform resources in the `connectivity` and `management` subscriptions are deployed via Azure Policy. Enterprise-scale includes both, policy definitions and assignments required to deploy the neccesary resources. While it is possible to deploy both, Azure Policy definition and assignments using enterprise-scale deployment process via GitHub Actions as described in this article, enterprise-scale provides flexiblity for how the assignments can be done in the platform subscriptions.

But not all resources in the `identity` subscriptions are deployed via Azure Policy, as each organization have different methods to deploy Active Directory domain controllers.

The following sections describe how to deploy the platform infrastructure resources across the three platform subscriptions. Before continue with the steps below ensure that the `management`, `connectivity` and `identity` subscriptions have been created and assigned at the `platform` management group scope.

### Management subscription

In the enterprise-scale reference implementation, Azure resources in the `management` subscription are deployed via Azure Policy. Enterprise-scale includes both, policy definitions and assignments required to deploy the neccesary resources in the `management` subscription. We will walk you though the process how to assign the Azure Policy later in the article. We need two Azure Policy assigments which create a Log Analytics workspace and Azure Automation account that are required in the **Management** subscription:

Required custom Azure Policy definition:

| Policy name                | Scope                   | Description                                                                     |
|----------------------------|-------------------------|---------------------------------------------------------------------------------|
| Deploy-loganalytics        | Management subscription | Deploys a Log Analytics workspace into your subscription                        |
| Deploy-loganalytics-config | Management subscription | Configures the Log Analytics workspace with the required counters and solutions |

Azure Policy assignments required on _management_ subscription:

| Policy name          | Type | Scope | Parameter description |
|----------------------|------|-------|-----------------------|
| Deploy-loganalytics-_\<region\>_  | Custom policy | Management subscription | _workspaceName:_ LA workspace name<br>_workspaceRegion:_ Azure DC region for LA<br>_automationAccountName:_ Linked Azure Automation Account, will be created with this Policy<br>_automationRegion:_ Azure DC region for the Azure Automation Account<br>_rgName_: Resource Group in which the resource reside |
| Deploy-loganalytics-config-_\<region\>_ | Custom policy | Management subscription | _workspaceName:_ LA workspace name this configration will be applied<br>_workspaceRegion:_ Azure DC region of the LA workspace |

> Note: how-to [assign Azure Policy](#deployment-of-assignments) at the _management_ subscription scope describs the process in detail.

### Connectivity subscription

The resource in the `connectivity` subscription will be deployed via Azure Policy following the enterprise-scale reference implementation. We need four Azure Policy assignments to create the virtual WAN, virtual hub, firewall policy and ddos protection resources required in the `connectivity` subscription:
The resources in the regional `connectivity` subscription will be deployed using DeployIfNotExists policy.

Required custom Azure Policy definition:

<!-- markdownlint:disable MD033 -->

| Policy name          | Scope | Description |
| ---------------------|-------|-------------|
| Deploy-vwan          |'Yourcompanyname' mg|Deploys the virtual WAN service into the connectivity subscription
| Deploy-firewallpolicy|'Yourcompanyname' mg|Configures the fw policies and rules for Azure Firewall
| Deploy-vhub          |'Yourcompanyname' mg|Deploys a regional virtual hub resource along with required gateways (er/VPN) and Azure Firewall
| Deploy-ddosprotection|'Yourcompanyname' mg|Deploys a DDoS standard plan service

Azure Policy assignments required on _connectifity_ subscription:

| Policy name          | Type | Scope | Parameter description |
|----------------------|------|-------|-----------------------|
| Deploy-vwan          | Custom policy | Connectivity subscription|_vwanname:_ VWAN resource name<br>_vwanRegion:_ Azure Region the service will be deployed to<br>_rgName:_ RG name where the resource will be deploy to. Policy will create rg if not exists|_vwanname:_ yourcompanyname-vwan<br>_vwanRegion:_ North Europe<br>_rgName:_ yourcompanyname-global-vwan
| Deploy-firewall policy| Custom policy |Connectivity subscription|_fwpolicy:_ Firewall policy configruation JSON object<br>_fwPolicyRegion:_ Azure Region the service will be deployed to (identical with VHUB) <br>_rgName:_ RG name where the resource will be deploy to. Policy will create rg if not exists
| Deploy-vhub-_\<region\>_     | Custom policy |Connectivity subscription|_vwanname:_ VWAN resource name<br>_vhubname:_ VHUB resource name<br>_vhub:_ VHUB configuration JSON object (location, addressPrefix, ...) <br>_vpngw:_ VPN Gateway configuration JSON object (name, BGP, scale unit) <br>_ergw:_ Express Route Gateway configuration JSON object<br>_azfw:_ Azure Firewall configuration JSON object (name, policy Id) <br>_rgName:_ RG name where the resource will be deploy to. Policy will create rg if not exists|
| Deploy-ddosprotection| Custom policy |Connectivity subscription|_ddosName:_ Resource name for the DDoS service<br>_ddosRegion:_ Azure Region the service will be deployed to (identical with VHUB) <br>_rgName:_ RG name where the resource will be deploy to. Policy will create rg if not exists|_ddosName:_ yourcompanyname-ddos-std-plan<br>_ddosRegion:_ North Europe<br>_rgName:_ yourcompanyname-global-ddos
| Enable data protection suite | Initiative | Connectivity subscription| N/A
| Enable monitoring in Azure Security Center | Initiative | Connectivity subscription| Using default parameter

> Note: how-to [assign Azure Policy](#deployment-of-assignments) at the _connectivity_ subscription scope describs the process in detail.

### Identity subscription

In the enterprise-scale reference implementation, the **Identity** subscription is only required when deploying a virtual WAN-based enterprise-scale implementation (as domain controllers cannot be deployed in a managed virtual hub). For non-virtual-WAN enterprise-scale reference implementations (traditional hub and spoke network architecture), the **Identity** subscription is not required as domain controllers should be deployed in the central hub virtual network.

The following instructions provide guidance for deploying the required resources for the **Identity** subscription for both, virtual-WAN-based and non-virtual-WAN-based enterprise-scale implementations:

**Virtual WAN-based enterprise-scale implementation:**

/ TODO Required custom Azure Policy definition:

| Policy name          | Scope              | Description                                                        |
| ---------------------|--------------------|--------------------------------------------------------------------|
| Deploy-VNet          |'Yourcompanyname' mg| Deploys a virtual network and and conect it to the local virtual WAN virtual hub.|

Azure Policy assignments required on _identity_ subscription (per region a policy is required):

| Policy name          | Type | Scope                |
|----------------------|------|----------------------|
| Deploy-VNet | Custom policy | 'Yourcompanyname' mg |

Once the virtual network is created the two Active Directory domain controllers can be created in the virtual network following your company's procedures.

**Non-virtual-WAN-based enterprise-scale implementation:**

1. In a regional hub virtual network, deploy two Active Directory domain controllers following your company's procedures
2. Repeat process for each regional hub virtual network

## Deployment of assignments

1. In one of the [previous section](#deployment-of-definitions) all the defintions have been updated with an resource ID. ID's are updated in the _'yourcompanyname'.parameters.json_ files in the _.azstate_ folder on 'yourcompanyname' scope. In addition to the updated _.parameters.json_ each definition is represented in an separate file in the same _.azstate_ folder. The pull or a respository discovery operation keeps all files and the related properties in the _.azstate_ folder in sync.

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

To do the assignments for `policyassignments` and `roleassignments` the _managementgroupname_.parameters.json need to be updated a second time as done it for the defintions.
Three scopes for the assignment need to be considered to follow the enterprise-scale reference implementation:

- 'Yourcompanyname' management group scope
- Landing zones management group scope
- _Connectivity_ / _management_ / _identity subscription scope

As a reference for Azure Policy assignment you can select a reference Azure Policy assignment in the [azopsreference](https://github.com/Azure/CET-NorthStar/tree/master/AzOpsReference/3fc1081d-6105-4e19-b60c-1ec1252cf560/contoso/.AzState) folder. Filter files with _policyassignments_ in the name. After you copied the object replace all the values with the value  \<replace-me\>, These needs to be done mainly for the attributes `policydefinitionid` and `scope`.

- `Policydefinitionid`: full resource ID (including scope path) of the definition
- `Scope`: assignment scope for the definition

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

2. Git stage and commit locally, and then push changes to your remote feature branch.

    > [!NOTE]
    > Do not push changes directly in the *master* branch in this step.

    ``` bash
    git push <remote-name>
    ```

3. Create a pull request to the master branch. GitHub Actions runs a PR check and pushes the changes to the target Azure enviroment. You can monitor the status in the actions log. Once all the checks are successful you have to squash and merge your changes to the master branch.

>Note: if the Azure Policy assignmetn fails please re-run the checks a second time. There is currently a known problem with the Azure Policy assigment on Azure which the product team is currently fixing.

---

## Finalize platform deployment

You can now follow the progress and see how the resources are getting deployed into the platform subscriptions. When the resources are deployed the platform can start updating configurations if needed. One thing that you or your netops team may start doing is adjusting the firewall policies/rules in the Azure portal or through the azops pipeline.
