---
title: Deploy platform infrastructure
description: Deploy platform infrastructure
author: rkuehfus
ms.author: brblanch
ms.date: 06/01/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Provision platform

This article describes how to deploy the platform infrastructure for the enterprise-scale reference implementation into your own environment. If you haven't completed the first step, start [here](./configure-run-initialization.md).

![Step 2: the process to deploy your own environment](../media/deploy-environment-step-2.png)
_Figure 1: The process to deploy your own environment

## Deployment artifact overview

It is important for you to be familiar with the `AzOps` folder structure created during environment discovery and repository initialization. To describe the desired state of platform subscriptions and landing zones, we apply changes only in the `<management-group-scope>.parameters.json` `.AzState` folder. This is how the folder structure should look in your environment:

<!-- TODO: Replace with diagram -->

```shell
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

Each _managementgroupscope_.parameters.json file has the following section; it's the most important part of the parameter files and the section where you need to apply the changes in this guide. You can learn more about the *.parameters.json schema [here](./parameters-schema.md).

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

There are two groups of properties in this section _\*definitions\*_ and _\*assignments\*_:

- **Definitions:** All definitions (`policy`, `role`, and `policyset`) need to be deployed on the `<YourCompanyName>` management group scope and in the `<your-company-name>.parameters.json` file.

  > [!NOTE]
  > In the Azure portal, `policySetDefinitions` is also known as an _initiative_. It represents a set of Microsoft Azure Policy definitions.

- **Assignments:** The assignments (`role` and `policy`) can be deployed at any management group scope as long as the definition exists on the same scope or above. To simplify the management, it's recommended to reduce the number of scopes where you assign Azure Policy and role-based access control (RBAC) roles. In the enterprise-scale reference implementation section, we recommend assigning only at the following three scopes:

  - `<YourCompanyName>` management group scope for all company policies.
  - Platform subscription scope for platform resources related to Azure Policy.
  - `Landing Zone` management group scope for all landing-zone-specific Azure policies.

## Deployment flow

In this reference implementation, we're using GitHub Actions to push and pull changes to and from your Azure environment. All changes need to be committed to a feature branch and merged to the master using a pull request (PR). The PR triggers GitHub Actions to validate your changes and then deploy to Azure.

The following diagram illustrates the flow to deploy the definitions:

![Landing zone definitions deployment process](../media/lz-definition-deployment.png)
_Figure 2: The flow to deploy definitions_

The next step is to deploy the process while following a similar process:

![Landing zone assignment deployment process](../media/lz-assignments-deployment.png)
_Figure 3: The process to deploy definitions_

## Deploying definitions

1. Select the `<YourCompanyName>` management group scope for the definitions first and modify the `<your-company-name>.parameters.json` file in the `.AzState` folder. Definitions need to be added in the respective section of `*.parameters.json` file:

    ``` bash
    # The empty part of a parameters.json file after initialization
    "properties": {
        "policySetDefinitions": [],
        "roleAssignments": [],
        "policyAssignments": [],
        "policyDefinitions": [],
        "roleDefinitions": []
    }
    ```

    To refer to the Azure Policy definition, you can select the sample definition in the [`AzOpsReference` folder](https://github.com/Azure/CET-NorthStar/tree/master/AzOpsReference/3fc1081d-6105-4e19-b60c-1ec1252cf560/contoso/.AzState). Filter files with policy definitions in the name.

2. Update the `policyDefinitions`, `roleDefinitions`, or `policySetDefinitions` in one of two ways:
   2.1. See the `<your-company-name>.parameters.json` file. Make sure that to always add it as an array object `[]`.

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

   2.2 Copy the files from the [`AzOpsReference` folder](https://github.com/Azure/CET-NorthStar/tree/master/AzOpsReference/3fc1081d-6105-4e19-b60c-1ec1252cf560/contoso/.AzState) to the `.AzState` directory for your management group.

    > It is important that you add _all_ custom Azure policies in the [AzOpsReference folder](https://github.com/Azure/CET-NorthStar/tree/master/AzOpsReference/3fc1081d-6105-4e19-b60c-1ec1252cf560/contoso/.AzState) to the `<your-company-name>.parameters.json` file or the `.AzState` directory.

3. Stage your changes and commit locally via Git, and then push changes to your remote feature branch. Do not push changes directly into the `master` branch in this step.

    ``` bash
    git push <remote-name>
    ```

4. Create a PR to `master`. GitHub Actions run a PR check and push the changes to the target Azure environment. You can monitor the status in the actions log. Once all the checks are successful, you can squash and merge your changes to the master branch.

(Optional): Reinitialize or update the repository in your `master` branch. This will match all definitions with the resource IDs that are required for the assignments in the next section.

``` powershell
    Initialize-AzOpsRepository -Verbose
```

> [!NOTE]
> This step will be automated once the pull GitHub action is fully operational.

## Create a platform subscription

The platform infrastructure is deployed across three Azure subscriptions on the platform management group scope:

![Platform subscriptions](../media/platform-subscriptions.png)
_Figure 4: Platform subscriptions_

- The `management` subscription: where all cross-platform management resources are deployed (such as a centralized Azure Monitor Logs workspace)
- The `connectivity` subscription: where all the networking resources are deployed (such as Azure Virtual WAN or Firewall)
- The `identity` subscription: for Virtual-WAN-based enterprise-scale implementations; this is where domain controllers are deployed

In an enterprise-scale implementation, all platform resources in the `connectivity` and `management` subscriptions are deployed via Azure Policy. Enterprise-scale includes both, policy definitions and assignments required to deploy the necessary resources. While it is possible to deploy both, Azure Policy definition and assignments using enterprise-scale deployment process via GitHub Actions as described in this article, enterprise-scale provides flexibility for how the assignments can be done in the platform subscriptions.

But not all resources in the `identity` subscriptions are deployed via Azure Policy, as each organization has different methods to deploy Azure Active Directory domain controllers.

The following sections describe how to deploy the platform infrastructure resources across the three platform subscriptions. Before continue with the steps below ensure that the `management`, `connectivity` and `identity` subscriptions have been created and assigned at the `platform` management group scope.

### Management subscription

In the enterprise-scale reference implementation, Azure resources in the `management` subscription are deployed via Azure Policy. Enterprise-scale includes both, policy definitions and assignments required to deploy the necessary resources in the `management` subscription. We will walk you though the process how to assign the Azure Policy later in the article. We need two Azure Policy assignments to create an Azure Monitor Logs workspace and the Azure Automation account required in the management subscription:

A required, customized Azure Policy definition:

| Policy name                | Scope                   | Description                                                                     |
|----------------------------|-------------------------|---------------------------------------------------------------------------------|
| Deploy-loganalytics        | Management subscription | Deploys Azure Monitor Logs workspace into your subscription                        |
| Deploy-loganalytics-config | Management subscription | Configures the Azure Monitor Logs workspace with the required counters and solutions |

Azure Policy assignments required on a _management_ subscription:

| Policy name          | Type | Scope | Parameter description |
|----------------------|------|-------|-----------------------|
| Deploy-loganalytics-_\<region\>_  | Custom policy | Management subscription | _workspaceName:_ LA workspace name<br>_workspaceRegion:_ Azure DC region for LA<br>_automationAccountName:_ Linked Azure Automation Account, will be created with this Policy<br>_automationRegion:_ Azure DC region for the Azure Automation Account<br>_rgName_: Resource Group in which the resource resides |
| Deploy-loganalytics-config-_\<region\>_ | Custom policy | Management subscription | _workspaceName:_ LA workspace name this configuration will be applied<br>_workspaceRegion:_ Azure DC region of the LA workspace |

> Note: how to [assign Azure Policy](#deployment-of-assignments) at the _management_ subscription scope describes the process in detail.

### Connectivity subscription

The resource in the `connectivity` subscription will be deployed via Azure Policy following the enterprise-scale reference implementation. We need four Azure Policy assignments to create the Virtual WAN, virtual hub (VHub), Azure Firewall, and denial-of-service attack (DDoS) protection resources required in the `connectivity` subscription. The resources in the regional `connectivity` subscription will be deployed using a DeployIfNotExists policy.

Required custom Azure Policy definition:

<!-- markdownlint:disable MD033 -->

| Policy name          | Scope | Description |
| ---------------------|-------|-------------|
| `Deploy-vwan`          | `<YourCompanyName>` management group |Deploys the Virtual WAN service into the connectivity subscription |
| `Deploy-firewallpolicy` | `<YourCompanyName>` management group | Configures the firewall policies and rules for Azure Firewall |
| `Deploy-vhub`          | `<YourCompanyName>` management group |Deploys a regional VHub resource along with required gateways (er/virtual private network [VPN]) and Azure Firewall |
| `Deploy-ddosprotection` | `<YourCompanyName>` management group |Deploys a DDoS standard plan service |

<!-- TODO: Format names in tables using `inline-code-blocks` -->

Azure Policy assignments required on `connectivity` subscription:

| Policy name          | Type | Scope | Parameter description |
|----------------------|------|-------|-----------------------|
| `Deploy-vwan`          | Custom policy | `connectivity` subscription |_vwanname:_ VWAN resource name<br>_vwanRegion:_ Azure Region the service will deploy<br>_rgName:_RG name where the resource will deploy. Azure Policy will create the RG if it doesn't exist|_vwanname:_ yourcompanyname-vwan<br>_vwanRegion:_ North Europe<br>_rgName:_ yourcompanyname-global-vwan
| Deploy-firewall policy| Custom policy |Connectivity subscription|_fwpolicy:_ Firewall policy configuration JSON object<br>_fwPolicyRegion:_ Azure Region where the service will be deployed (identical to the VHub) <br>_rgName:_ RG name where the resource will deploy. Azure Policy will create the RG if it doesn't exist
| Deploy-vhub-_\<region\>_     | Custom policy |Connectivity subscription|_vwanname:_ VWAN resource name<br>_vhubname:_ VHUB resource name<br>_vhub:_ VHUB configuration JSON object (location, addressPrefix, ...) <br>_vpngw:_ VPN Gateway configuration JSON object (name, BGP, and scale unit) <br>_ergw:_ Express route gateway configuration JSON object<br>_azfw:_ Azure Firewall configuration JSON object (name and policy ID) <br>_rgName:_ RG name where the resource will deploy. Azure Policy will create the RG if it doesn't exist|
| Deploy-ddosprotection| Custom policy |Connectivity subscription|_ddosName:_ Resource name for the DDoS service<br>_ddosRegion:_ Azure Region where the service will deploy (identical to VHub) <br>_rgName:_ RG name where the resource will deploy. Azure Policy will create the RG if it doesn't exist|_ddosName:_ yourcompanyname-ddos-std-plan<br>_ddosRegion:_ North Europe<br>_rgName:_ yourcompanyname-global-ddos
| Enable data protection suite | Initiative | Connectivity subscription| N/A
| Enable monitoring in Azure Security Center | Initiative | Connectivity subscription| Using the default parameter

> Note: how to [assign Azure Policy](#deployment-of-assignments) at the _connectivity_ subscription scope describes the process in detail.

### Identity subscription

In the enterprise-scale reference implementation, the identity subscription is only required when deploying a Virtual-WAN-based enterprise-scale implementation, as domain controllers cannot be deployed in a managed VHub). For non-Virtual-WAN enterprise-scale reference implementations (traditional hub and network architecture), the identity  subscription is not required, as domain controllers should be deployed in the central VHub network.

The following instructions provide guidance for deploying the required resources for the identity subscription for Virtual- and non-Virtual-WAN-based enterprise-scale implementations:

**Virtual-WAN-based enterprise-scale implementation:**

/ Required, customized Azure Policy definition:

| Policy name          | Scope              | Description                                                        |
| ---------------------|--------------------|--------------------------------------------------------------------|
| `Deploy-VNet`          | `<YourCompanyName>` management group | Deploys a virtual network and connects it to the local Virtual WAN VHub.|

Azure Policy assignments required on `identity` subscription (per region a policy is required):

| Policy name          | Type | Scope                |
|----------------------|------|----------------------|
| `Deploy-VNet` | Custom policy | `<YourCompanyName>` management group |

Once the virtual network is created the two Azure AD domain controllers can be created in the virtual network following your company's procedures.

**Non-Virtual-WAN-based enterprise-scale implementation:**

In a regional VHub network, deploy two Azure AD domain controllers following your company's procedures. Repeat the process for each regional VHub network.

## Deploying assignments

1. In the [previous section](#deployment-of-definitions), all the definitions have been updated with a resource ID. IDs are updated in the `<your-company-name>.parameters.json` files in the `.AzState` folder on 'yourcompanyname' scope. In addition to the updated _.parameters.json_ each definition is represented in a separate file in the same `.AzState` folder. The pull or a repository discovery operation keeps all files and the related properties in the `.AzState` folder in sync.

```shell
    # Simplified folder structure after initialization

    AzOps
    └─── Tenant root group
        └─── <YourCompanyName> # Management group
            ├─── .AzState
            │   ├─── <YourCompanyName>.parameters.json # File containing the ID's
            │   ├─── *_policyDefinitions-<policy-name-1>.parameters.json # Policy definition
            │   .
            │   └─── *_policyDefinitions-<policy-name-n>.parameters.json # Policy definition
            ├─── Landing Zones # Management group under Contoso
            │   ├─── .AzState
            │   │   ├─── LandingZones.parameters.json # File containing the ID's
            │   │   ├─── *_policyDefinitions-<policy-name-1>.parameters.json # Policy definition
            │   │   .
            │   │   └─── *_policyDefinitions-<policy-name-2>.parameters.json # Policy definition
```

As with definitions, to assign `policyAssignments` and `roleAssignments`, the `<management-group-name>.parameters.json` files needs to be updated a second time. When assigning, three scopes for need to be considered and followed for enterprise-scale reference implementation:

- The `YourCompanyName` management group scope
- The `Landing Zones` management group scope
- The `connectivity` / `management` / `identity` subscription scope

To assign a policy with Azure Policy, you can select a reference Azure Policy assignment in the [AzOpsReference](https://github.com/Azure/CET-NorthStar/tree/master/AzOpsReference/3fc1081d-6105-4e19-b60c-1ec1252cf560/contoso/.AzState) folder. Filter files with policy assignments in the name. After copying the object, replace all the values with the value  `<replace-me>`. This needs to be done mainly for the `policyDefinitionId` and `scope` attributes.

- `policyDefinitionId`: full resource ID (including scope path) of the definition
- `scope`: assignment scope for the definition

``` bash
    ....
    # Here an empty example for the policyAssignments.
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
    > Do not push changes directly to the master branch in this step.

    ``` bash
    git push <remote-name>
    ```

3. Create a PR to the master branch. GitHub Actions run a PR check and push the changes to the target Azure environment. You can monitor the status in the actions log. Once all the checks are successful, squash and merge your changes to the master branch.

Rerun the checks if the Azure Policy assignment fails. The product team is currently fixing a known issue with Azure Policy assignment.

## Finalize platform deployment

You can now follow the progress and see how the resources are getting deployed into the platform subscriptions. When resources are deployed, the platform can start updating configurations, if needed. You or your NetOps team may start adjusting the firewall policies/rules in the Azure portal or through the AzOps pipeline.
