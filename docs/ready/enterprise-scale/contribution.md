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

# Contribution

## Contribution guide

### Enterprise-scale committee

The enterprise-scale committee and its members (aka committee members) are the primary caretakers of the enterprise-scale repo including language, design, and Contoso implementation.

### Current committee members

<!-- docsTest:disable -->

- Uday Pandya
- Callum Coffin
- Kristian Nese
- Victor Arzate
- Johan Dahlbom
- Lyon Till
- Niels Buit

<!-- docsTest:enable --->

### Committee member responsibilities

Committee members are responsible for reviewing and approving RFCs proposing new features or design changes.

The initial enterprise-scale committee consists of Microsoft employees. It is expected that over time, community will grow and new community members will join committee members. Membership is heavily dependent on the level of contribution and expertise: individuals who contribute in meaningful ways to the project will be recognized accordingly.

At any point in time, a committee member can nominate a strong community member to join the committee. Nominations should be submitted in the form of RFCs detailing why that individual is qualified and how they will contribute. After the RFC has been discussed, a unanimous vote will be required for the new committee member to be confirmed.

### Contribution scope for "enterprise-scale architecture guidelines"

The following is the scope of contributions to this repository:

As platform evolves and we have new service and feature is validated in production with customers, the design guidelines are subject to updates, in the overall architecture context.

Submit a pull request for documentation updates using the following template 'placeholder'.

### Contribution scope for "Contoso reference implementation"

With new services, resources, resource properties and API versions, the implementation guide and reference implementation must be updated as appropriate.
Primarily, the code contribution would be centered on Azure Policy definitions and Azure Policy assignments for for Contoso implementation.

#### How to submit pull request to upstream repo

1. Create a new branch based on upstream/master by executing following command

    ```shell
    git checkout -b feature upstream/master
    ```

2. Checkout the file(s) from your working branch that you may want to include in PR

    ```shell
    #substitute file name as appropriate. below example
    git checkout feature: .\.github\workflows\azops-push.yml
    ```

3. Push your Git branch to your origin

    ```shell
    git push origin -u
    ```

4. Create a pull request from upstream to your remote master

#### Writing ARM templates for Contoso implementation

First, let's assert that there is no right or wrong way writing ARM templates and parameters files.

ARM is a language and everyone has different "style of writing". Very seldom composition of the template and parameters file are the same among group of developers. There is no clear style definition to govern and separate code from the config. In other words, what goes in template versus what is in the parameter files. Available guidance on when to use parameters and object as parameters (without any schema) are subject to interpretation and there is no one authoring "style" fits all.

To simplify development and unit testing at-scale with multiple developers contributing, we have adopted to specific style of writing templates by decoupling template from its parameter file completely.

We have opted for minimalist "one template to rule them all" approach. This will externalize all resource properties as a complex object in parameter file and we can enforce strict schema validation on parameter file based on resource schema that platform already publishes. This drives clear separation between template and parameters. Parameter file is essentially RESTful representation of the resource when calling `get-azresource` or `az resource show`.

- Template.json

```json
"resources": [{
        "condition": "[bool(equals(variables('resourceType'),'Microsoft.Authorization/policyDefinitions'))]",
        "type": "Microsoft.Authorization/policyDefinitions",
        "name": "[variables('policyDefinitions').name]",
        "apiVersion": "[variables('apiversion')[variables('resourceType')]]",
        "location": "northeurope",
        "properties": "[variables('policyDefinitions').Properties]"
    }],
```

There is generic multiresource template available [here](https://raw.githubusercontent.com/uday31in/AzOps/master/src/template.json) to ensure bug fixes are incorporated with latest API version.

- Template.parameters.json

```json
{
    "$schema": "http://schema.management.azure.com/schemas/2015-01-01/deploymentParameters.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "input": {
            "value": {
                <copy-paste-value-of-powershell/cli-output-here>
            }
        }
    }
}
```

Retrieve resource definition by calling `get-azresource` function and giving `resourceid` to existing resource.

```powershell
#Replace resourceId in below command before executing it
Get-AzResource -ResourceId '/providers/Microsoft.Management/managementGroups/contoso/providers/Microsoft.Authorization/policyDefinitions/DINE-Diagnostics-ActivityLog' | ConvertTo-Json -depth 100
```

Following pros and cons are considered when making design decision.

- Pros

  - No more writing of ARM templates! Last ARM template is written 😊.
  - Consistent resource export throughout the lifecycle of the resource regardless of how resource is created and updated - portal, CLI, PowerShell or third-party tools
  - Easier to detect drift between configuration stored in Git versus what is current configuration&mdash;we are essentially comparing two JSON documents.
  - Managing implicit dependencies between simple resources at client side or server side. Azure doesn't have many circular dependency between resources and it is possible to workout implicit dependencies based on resource schema already published. For example, VM might have dependency on kv but kvs do not depend on VMs. e.g. Policy definition -> Policy assignment -> Role assignment -> Remediation or virtual network -> ExpressRoute or kv -> Azure SQL

- Cons

  - Losing intellisense when authoring parameter file complex object. This is one-off activity and can be mitigated by retrieving base definition of existing resource or creating resource via portal first.
  - Unable to track template deployments using Azure-partner-customer-usage-attribution. This is not in the scope of enterprise-scale.

Again to re-iterate, there is nothing wrong with existing ARM templates used for resource deployments and there is no expectation to re-write those. Pipeline will continue to honour deployment of those ARM templates and detect configuration drift. But we will not be able to reconcile those templates as platform do not allow exporting deployment template in a way that can facilitate reconciliation. For that reason, any templates submit for PR must conform to ***"what-you-export"*** is ***"what-you-deploy"***.

- Do's
  - Read the next section before submitting PR
- Don'ts
- Submit PR with template and parameters file to deploy resources e.g. Key Vault, Log Analytics, network without wrapping them inside policy.

#### Contributing policy definitions, policy assignment, role definition and role assignment for for Contoso implementation

Once you have parameter file ready for your resource that conforms to the standards mentioned in above section, please consider the scope at which this resource should be deployed - management group or subscription (either connectivity or management subscription). Although pipeline has an ability to deploy template at any of the given 4 scopes - we will not use resource group level deployment as a part of landing zone template. Minimum bar is subscription level deployment template wrapped inside policy definition.

- Dos

  - If you have resource to deploy inside landing zone, wrap them inside deploy-if-not-exist (dine) policies and assignment for this should be at management group scope.

  - Policy should ideally have existence scope targeted at subscription scope if deployment count of resources inside landing zone is exactly one e.g. Virtual network inside landing zone or virtual hub for new Azure region
  - All policy definition should ideally be created at the root defined in e2e template.

- Don'ts
  - Submit PR with template and parameters file to deploy resources e.g. Key Vault.
  - Create your own management group hierarchy outside of what is described in e2e landing zone

Example:

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
            "properties": {
              "policyAssignments" :[
              ],
              "roleAssignments": [
              ]
            }
          }
        ],
        "properties": {
          "policyDefinitions": [
                <<copy-paste of Json representation of the resource>>
          ],
          "policyAssignments" :[
          ],
          "roleDefinitions": [
          ],
          "roleAssignments": [
          ]
        }
      }
    }
  }
}
```

#### Contributing new Azure Policy definitions for for Contoso implementation

To contribute with policy definitions that adheres to the enterprise-scale architecture, use the following tools and recommendations:

[Azure Policy extension for Visual Studio](https://docs.microsoft.com/azure/governance/policy/how-to/extension-for-vscode)

Use this extension to look up policy aliases ad review resources and policies

#### Explore available resource properties with associated policy aliases

##### Azure PowerShell

```powershell
# List all available providers
Get-AzPolicyAlias -ListAvailable

# Get aliases for a specific resource provider
(Get-AzPolicyAlias -NamespaceMatch 'Microsoft.Network').aliases.name
```

##### Azure CLI

```cli
# List all available providers
az provider list --query [*].namespace

# Get aliases for a specific resource provider
az provider show --namespace Microsoft.Network --expand "resourceTypes/aliases" --query "resourceTypes[].aliases[].name"
```

#### Contributing new Azure Policy assignment

For all policy assignment, the following must be considered:

- Be specific with the intent of the assignment; does it belong to the 2 subscriptions (connectivity and management), or to the management groups?
- What is the resource distribution within the subscriptions?
- What are the regions being used, and are multiple regions allowed/used per subscription?
- What resource types are allowed that might/might not affect where the policy is being assigned?
- For multiple policies serving same/similar purpose, can they be bundled into a policy initiative?
- What is the rationale of the policy effect? Should an audit policy be translated to an enforcement instead?
- For DeployIfNotExists policies, are you following the principle of least privileges of access for the RBAC definition being used?

### Code of conduct

We are working hard to build strong and productive collaboration with our passionate community. We heard you loud and clear. We are working on set of principles and guidelines with do's and don'ts.
