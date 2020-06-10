---
title: Contoso reference implementation overview
description: Contoso reference implementation overview
author: BrianBlanchard
ms.author: brblanch
ms.date: 06/15/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready 
---

<!-- docsTest:disable -->

# Contoso reference implementation overview

Contoso's enterprise-scale reference implementation is rooted in the principle that everything in Microsoft Azure is a resource. Contoso uses Azure Resource Manager to describe and manage their resources as part of their target-state architecture at scale.

Contoso will enforce policies to support security, logging, networking, and any other plumbing needed for landing zones and subscriptions. Contoso will bootstrap the Azure environment with Resource Manager templates to create the necessary structure for management and networking, and to declare a desired goal state. Contoso will apply the principle of policy-driven governance and use policies to deploy all necessary platform resources for a landing zone. While deploying Azure Key Vault to store platform-level secrets in a management subscription versus scripting the template deployment to deploy Azure Key Vault, the Cloud Adoption Framework (CAF) enterprise-scale-based reference implementation will have a policy definition that deploys Key Vault prescriptively, using a policy assignment at the management subscription scope. The core benefits of a policy-driven approach are many, but the most significant benefits include the following:

- The platform is capable of bringing target resources such as subscriptions to a desired goal state.
- The platform monitors continuous conformance to ensure that all platform-level resources are compliant. It can monitor and remediate resources throughout their lifecycle because it's aware of the goal state.
- The platform supports autonomy regardless of the customer's scale point.

## File -> New -> Region

Contoso wants to use all Azure regions, deploy the workload closer to the user, and add new Azure regions as business demand increases. As a part of the enterprise-scale design principle of policy-driven governance, Contoso will assign policies in their environment to the number of regions they'd like to use. Policies will ensure that their Azure environment is set up correctly.

## Management

Contoso has decided to use only one Azure Monitor Log Analytics workspace. When the first region is enabled, Contoso will deploy a Log Analytics workspace in their management subscription. No action will be required when enabling subsequent Azure regions, because Azure Policy will ensure that all platform logging is routed to the workspace.

## Networking

Azure Policy will continuously check if an Azure Virtual WAN virtual hub already exists in a connectivity subscription for all enabled regions, and it will create one if it doesn't exist. A virtual hub will secure internet traffic from secured connections (virtual networks inside landing zones) to the internet via Azure Firewall.

For all virtual hubs, policy ensures that Azure Firewall is deployed and linked to existing global Azure Firewall policy, as well as the creation of a regional firewall policy if needed.

Azure Policy will deploy default network security groups (NSGs) and user-defined routes (UDRs) in landing zones. While NSGs will be linked to all subnets, UDRs will only be linked to virtual-network-injected platform as a service (PaaS) subnets. For virtual-network-injected services and control plane traffic to continue to work, Azure Policy will ensure that the right NSG and UDR rules are configured, but only for Azure PaaS services approved by the whitelisting framework described in this article. UDR and NSG rules are required to protect and manage control plane traffic for virtual-network-injected PaaS services such as Azure SQL Managed Instance. When landing zone virtual networks connect to a virtual hub, the default route configured (`0.0.0.0/0`) will point to their regional Azure firewall instance .

<!-- docsTest:ignore SD-WAN -->

For cross-premises connectivity, the regional virtual hub requires the policy to enforce deploying ExpressRoute or virtual private network (VPN) gateways. It will use ExpressRoute to connect the virtual hub to on-premises by using the ExpressRoute resource ID and authorization key as parameters. With a VPN, Contoso can decide whether to use their existing software-defined networking in a wide area network to automate connectivity from branch offices into Azure via site-to-site VPN, or Contoso can manually configure their on-premises equipment in the branch offices and then let Azure Policy configure the VPN sites via Virtual WAN. Contoso is rolling out a solution certified with Virtual WAN, SD-WAN, to manage the connectivity of all global branches and connect them to Azure.

## File -> New -> Landing zone (subscription)

Contoso wants to minimize the time required to create landing zones while avoiding bottlenecks for Central IT. A subscription will serve as the unit of management for landing zones, and each business owner will have access to an Azure billing profile that will allow them to create new subscriptions (landing zones) and delegate this task to their own IT teams. Once a new subscription is provisioned, it'll be automatically stored in a specified management group and subject to the configured policy.

**Networking:**

1. Create a virtual network inside a landing zone and establish virtual network peering with a virtual hub in the same Azure region.
2. Create a default NSG inside a landing zone with default rules, such as disallowing remote desktop protocol (RDP) or secure shell (SSH) traffic from the internet.
3. Ensure that new subnets created inside a landing zone have NSGs.
4. Default NSG rules can't be modified (for example, RDP/SSH traffic from the internet).
5. Enable NSG flow logs and connect them to an Azure Monitor Log Analytics workspace in a management subscription.
6. Protect virtual network traffic across virtual hubs with NSGs.

**Integrated access management:**

Create an Azure AD group for subscription access and an Azure AD Privileged Identity Management (PIM) entitlement for the scope.

## File -> New -> Sandbox

Sandbox subscriptions are for experimentation and validation only. Sandbox subscriptions aren't connected to production and policy will prevent connectivity to on-premises resources.

## File -> Delete -> Sandbox/landing zone

Subscriptions will be moved to a management group for decommissioned resources. Policy will prevent creation of resources in these subscriptions, and a subscription cancellation request will be sent.

## Implementation components

<!-- cSpell:ignore AzOps GitOps managementgroup -->

Contoso will use the term _AzOps_ (inspired by GitOps, Kubernetes operations, and more) to designate Azure operations within enterprise-scale design principles. Contoso has decided to use platform-native capabilities and Resource Manager to orchestrate, configure, and deploy landing zones and to declare a goal state. Contoso abides by the policy-driven governance design principle and wants landing zones (subscriptions) to be provisioned and configured autonomously.

After deliberating about the pros and cons of using a single template or modular templates, Contoso has chosen to use a single template to orchestrate the platform. The template mainly consists of policy definitions and policy assignments. Since policy assignments have a direct dependency on policy definitions, it's operationally easier to manage and control lifecycle changes and versioning if artifacts are represented in same template.

Contoso will use platform-provided schema as input to the parameter file. An end-to-end template will use nested deployment to trigger deployment of nested children at the appropriate scope (for example, the management group or subscription scope).

    ```powershell
    Get-AzManagementGroup -GroupName Tailspin -Expand -Recurse | ConvertTo-Json -Depth 100
    ```

The rationale is that it can be machine-generated on-demand, and it can be consistently exported to help with configuration drift.

    ```json
    {
      "Id": "/providers/Microsoft.Management/managementGroups/Tailspin",
      "Type": "/providers/Microsoft.Management/managementGroups",
      "Name": "Tailspin",
      "TenantId": "3fc1081d-6105-4e19-b60c-1ec1252cf560",
      "DisplayName": "Tailspin",
      "UpdatedTime": "0001-01-01T00:00:00Z",
      "UpdatedBy": null,
      "ParentId": "/providers/Microsoft.Management/managementGroups/3fc1081d-6105-4e19-b60c-1ec1252cf560",
      "ParentName": "3fc1081d-6105-4e19-b60c-1ec1252cf560",
      "ParentDisplayName": "3fc1081d-6105-4e19-b60c-1ec1252cf560",
      "Children": [
        {
          "Type": "/providers/Microsoft.Management/managementGroups",
          "Id": "/providers/Microsoft.Management/managementGroups/Tailspin-bu1",
          "Name": "Tailspin-bu1",
          "DisplayName": "Tailspin-bu1",
          "Children": [
            {
              "Type": "/providers/Microsoft.Management/managementGroups",
              "Id": "/providers/Microsoft.Management/managementGroups/Tailspin-bu1-corp",
              "Name": "Tailspin-bu1-corp",
              "DisplayName": "Tailspin-bu1-corp",
              "Children": null
            }
          ]
        }
      ]
    }
    
    ```

Contoso personnel should copy and paste the output into the input template parameter file. Not all properties are required, but extra metadata won't disrupt the processes, because the platform and template will ignore these properties. To view the requirements, see the [20-create-child-managementgroup.parameters.json](https://github.com/azure/CET-NorthStar/blob/master/examples/20-create-child-managementgroup.parameters.json) example file.

    ```json
    {
      "$schema": "http://schema.management.azure.com/schemas/2015-01-01/deploymentParameters.json#",
      "contentVersion": "1.0.0.0",
      "parameters": {
        "input": {
          "value": {
            "Name": "Tailspin",
            "DisplayName": "Tailspin",
            "ParentId": "/providers/Microsoft.Management/managementGroups/3fc1081d-6105-4e19-b60c-1ec1252cf560",
            "Children": [
              {
                "Id": "/providers/Microsoft.Management/managementGroups/Tailspin-bu1",
                "Name": "Tailspin-bu1",
                "DisplayName": "Tailspin-bu1",
                "Children": [
                  {
                    "Id": "/providers/Microsoft.Management/managementGroups/Tailspin-bu1-corp",
                    "Name": "Tailspin-bu1-corp",
                    "DisplayName": "Tailspin-bu1-corp"
                  }
                ]
              }
            ]
          }
        }
      }
    }
    ```

The tenant-level Resource Manager deployment above should create the following deployment at the root scope and nested deployment at the scope of children.

- `Tailspin`
- `Tailspin-bu1`
- `Tailspin-bu1-corp`

This Resource Manager template can be expanded to include [subscriptions](https://github.com/azure/CET-NorthStar/blob/master/examples/60-move-subscription-under-managementgroup.parameters.json) (moving subscription), [policy definition](https://github.com/azure/CET-NorthStar/blob/master/examples/30-create-policydefinition-at-managementgroup.parameters.json), [policy assignment](https://github.com/azure/CET-NorthStar/blob/master/examples/40-create-policyassignment-at-managementgroup.parameters.json), role definition, and role assignment.

Contoso has chosen the following for their reference implementation:

## Git repo for Azure platform configuration

Contoso is already using Azure and is concerned about their current management group and subscription deployed in production. To address these concerns, Contoso will create a Git repo to store their existing management group and subscription organization.

Azure resources are organized hierarchically:

    ```shell
    Tenant Root
    └───Management Group
        ├───Subscription
            ├───Resource Group
                ├───Resources
    ```

Contoso has found it advantageous to organize these resources in same hierarchical layout inside their Git repo. Since management groups and subscriptions can be moved and renamed, organizing resources in a hierarchical manner allows Contoso to track their lineage over time. This approach reduces misconfiguration and allows them to predictably base mapping resource paths on resource IDs.

The `AzOpsScope` class will abstract the mapping between the resource identifier in Azure and the path to resources stored in the Git repo. This will facilitate quick conversion between Git and Azure and vice-versa. Reviewing the examples below, the important properties to note are the scope, type (tenant, management group, subscription, and resource group), and state path representing the file location inside Git.

Another advantage of the class is clear when deployment templates are updated via GitHub pull requests (PRs). The pipeline can determine at what scope to trigger deployments and the appropriate parameters to pass such as name, scope, and more. By using the same Azure AD tenant, the pipeline can be triggered predictably and deployment artifacts can be organized without deployment scripts in each PR throughout the scope of the Azure platform. For more information, see [Deploy templates](./index.md#deploy-templates).

    ```powershell
        New-AzTenantDeployment
        New-AzManagementGroupDeployment
        New-AzSubscriptionDeployment
        New-AzResourceGroupDeployment
    ```

    ```powershell
    #Example-1
    New-AzOpsScope -scope /providers/Microsoft.Management/managementGroups/contoso
    
    scope            : /providers/Microsoft.Management/managementGroups/contoso
    type             : managementGroups
    name             : contoso
    state path        : C:\Git\CET-NorthStar\AzOps\3fc1081d-6105-4e19-b60c-1ec1252cf560\contoso\managementgroup.json
    managementgroup  : contoso
    subscription     :
    resourcegroup    :
    resourceprovider :
    resource         :
    
    #Example-2
    New-AzOpsScope -path C:\Git\CET-NorthStar\AzOps\3fc1081d-6105-4e19-b60c-1ec1252cf560\contoso\connectivity
    
    scope            : /subscriptions/99c2838f-a548-4884-a6e2-38c1f8fb4c0b
    type             : subscriptions
    name             : 99c2838f-a548-4884-a6e2-38c1f8fb4c0b
    state path        : C:\Git\CET-NorthStar\AzOps\3fc1081d-6105-4e19-b60c-1ec1252cf560\contoso\connectivity\subscription.json
    managementgroup  : contoso
    subscription     : connectivity
    resourcegroup    :
    resourceprovider :
    resource         :
    ```

## Initialization

**`Initialize-AzOpsRepository`:**

This is a discovery function to traverse the whole management group and subscription hierarchy:

    ```powershell
    Get-AzManagementGroup -Recurse -expand -GroupName <root-management-group-name-or-ID> | ConvertTo-Json -depth 100
    ```

This will create the association between management group and subscription. Additionally, when the `Initialize-AzOpsRepository` function is called with the `-Recurse` parameter, it should enlist all resources available at the scope and children. When calling out a subscription, it also displays a list of resource groups.

## Deployment

**`Invoke-AzOpsGitPush`:**

Contoso wants to ensure that all platform changes are peer-reviewed and approved before deploying to a production environment. Contoso has decided to implement workflows (also known as deployment pipelines) and to use GitHub Actions for this process. Contoso has named this workflow `azops-push`, referring to the direction of the change (for example, from GitHub to Azure). All platform changes will be peer reviewed and in the form of PRs. Once PRs are reviewed thoroughly, a platform team will attempt the merge them to the `master` branch and trigger the deployment action by calling the `Invoke-AzOpsGitPush` function.

When a PR is approved, but before it's merged with the `master` branch, this function is the starting point for GitHub Actions. The `master` branch represents the truth from an infrastructure-as-code (IaC) perspective. This quality gate ensures that the `master` branch remains healthy and only contain artifacts successfully deployed in Azure. It specifies the files changed in PRs by comparing each feature branch with the current `master` branch. The following actions should be executed inside `Invoke-AzOpsGitPush`:

- Validate that the current Azure configuration is the same as what's stored in Git by running `Initialize-AzOpsRepository`.
- Git will determine if the working directory is dirty and exit the deployment task to alert the user and run `Initialize-AzOpsRepository` interactively. All deployments should be halted at this stage, because the platform is in a nondeterministic state from an perspective.
- Invoke built-in `new-az-*deployment` cmdlets at the appropriate scope.

## Operationalizing configuration drift and reconciliation

**`Invoke-AzOpsGitPull`:**

Operationalize the Azure environment at scale for day-to-day activities.

Contoso has decided to use PowerShell 7 and has mandated that all continuous integration (CI) tasks must complete successfully and simultaneously on Windows and Linux hosts to ensure complete coverage. No local execution should be necessary after initialization and discovery are completed, and these CI tasks will be published as GitHub Actions.
