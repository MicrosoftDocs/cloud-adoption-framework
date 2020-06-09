---
title: Contribution guide
description: Contribution guide
author: BrianBlanchard
ms.author: brblanch
ms.date: 06/01/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Contribution guide

## Enterprise-scale committee

The enterprise-scale committee and its members are the primary caretakers of the enterprise-scale repository and its language, design, and Contoso implementation.

Current committee members:

<!-- docsTest:disable -->
<!-- cSpell:disable -->

- Uday Pandya
- Callum Coffin
- Kristian Nese
- Victor Arzate
- Johan Dahlbom
- Lyon Till
- Niels Buit

<!-- docsTest:enable --->
<!-- cSpell:enable -->

## Committee member responsibilities

Committee members are responsible for reviewing and approving requests for comments (RFCs) proposing new features or design changes.

The initial enterprise-scale committee consists of Microsoft employees. It is expected that the community will grow, and new community members will join committee members over time. Membership depends on the level of contribution and expertise. Individuals who contribute in meaningful ways to the project will be recognized accordingly.

A committee member can nominate a strong community member to join the committee at any time. Nominations should be submitted in the form of RFCs detailing why that individual is qualified and how they'll contribute. After the RFC has been discussed, a unanimous vote will be required for the new committee member to be confirmed.

## Contribution scope for enterprise-scale architecture guidelines

The scope of contributions to this repo is that as a platform evolves and new services and feature are validated in production with customers, the design guidelines are subject to updates in the overall context of the architecture. Use the `placeholder` template to submit pull requests (PRs) for documentation updates.

## Contribution scope for Contoso reference implementation

The implementation guide and reference implementation must be updated accordingly as new services, resources, resource properties, and API versions emerge. Code contributions would primarily focus on Microsoft Azure Policy definitions and assignments for Contoso implementation.

## How to submit a PR to the upstream repo

1. Create a new branch based on upstream/master by executing the following command:

    ```shell
    git checkout -b feature upstream/master
    ```

2. Check out the files from your working branch that you want to include in a PR:

    ```shell
    #substitute file name as appropriate. below example
    git checkout feature: .\.github\workflows\azops-push.yml
    ```

3. Push your Git branch to your origin:

    ```shell
    git push origin -u
    ```

4. Create a PR from upstream to your remote `master` branch.

## Writing Azure Resource Manager templates for Contoso implementation

There isn't a right or wrong way to write Resource Manager templates and parameters files. Resource Manager is a language, and everyone has a different style of writing. Few template and parameters files are written similarly among a group of developers. There aren't clear style definitions to govern and separate code from configurations, subjecting what goes into templates versus parameter files to interpretation. Guidance on when to use parameters and object as parameters (without any schema) is also subject to interpretation, and there isn't one authoring style that fits all.

To simplify development and unit testing at scale with multiple developers contributing, we've adopted a specific style of writing templates by completely decoupling a template from its parameter file. This minimalist one-template-to-rule-them-all approach externalizes all resource properties as a complex object in a parameter file, and we can enforce strict schema validation in the file based on resource schema that the platform already publishes. This approach clearly separates template and parameters. The parameter file is essentially a RESTful representation of the resource when calling `Get-AzResource` or `az resource show`.

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

A [generic multiresource template](https://raw.githubusercontent.com/uday31in/AzOps/master/src/template.json) is available to ensure that bug fixes are incorporated with the latest API version.

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

Retrieve resource definitions by calling the `Get-AzResource` function and giving `resourceId` to the existing resource.

```powershell
# Replace the resourceId in the command below before executing it

Get-AzResource -ResourceId '/providers/Microsoft.Management/managementGroups/contoso/providers/Microsoft.Authorization/policyDefinitions/DINE-Diagnostics-ActivityLog' | ConvertTo-Json -depth 100
```

The following pros and cons should be considered when making design decisions:

- Pros:

  - No more writing Resource Manager templates! The last Resource Manager template has been written.
  - Resources export consistently throughout their lifecycle regardless of how they're created and updated⁠&mdash;the Azure portal, Azure CLI, PowerShell, or third-party tools.
  - It's easier to detect drift between a configuration stored in Git versus the current configuration; we're essentially comparing two JSON documents.
  - It's possible to manage implicit dependencies between simple resources on both the client side and the server side. Azure doesn't have many circular dependencies between resources, and it's possible to work out implicit dependencies based on resource schemas already published. For example, a virtual machine might depend on kernel-level virtual switches but not vice-versa (for example, policy definition -> Policy assignment -> Role assignment -> Remediation or virtual network -> ExpressRoute or Key Vault -> Azure SQL).

- Cons:

  It's possible to lose intelligence when authoring a parameter file's complex object. This one-off activity can be mitigated by retrieving the base definition of the current resource or creating the resource via the portal first. It's not possible to track template deployments using Azure-partner-customer-usage-attribution. This is not in the scope of enterprise scale.

There is nothing wrong with the current Resource Manager templates used for resource deployments, and there isn't an expectation to rewrite them. The pipeline will continue to deploy them and detect configuration drift. We won't be able to reconcile them, as the platform doesn't allow exporting deployment templates to complete this action. Because of these parameters, all templates submitted within PRs must conform to the principle that what you export is what you deploy.

Read the next section before submitting a PR, but don't submit a PR with templates and parameters files to deploy resources such as Azure Key Vault or Azure Monitor logs without wrapping them inside a policy.

## Contributing to policy definitions, policy assignments, and role definitions and assignments for Contoso implementation

Once your parameter conforms to the standards mentioned in section above and is ready for your resource, consider whether the resource should be deployed at a management group scope or a subscription scope (either the `connectivity` or `management` subscription). Although the pipeline can deploy templates at any of the four scopes, it won't be deployed at the resource group level as part of a landing zone template. The minimum bar is a subscription-level deployment template wrapped inside a policy definition.

- Do:
  - If you have resources to deploy inside a landing zone, wrap them inside `DeployIfNotExists` policies; the assignment for this should be at the management group scope.
  - The policy should ideally have an existence scope targeted at the subscription scope if the deployment count of resources inside landing zone is exactly one (for example, a virtual network inside a landing zone or virtual hub for a new Azure region).
  - Ideally, all policy definitions should be created at the root defined in the end-to-end template.

- Don't submit a PR with a template and parameter file to deploy resources (such as a key vault) or create your own management group hierarchy outside of what's described in an end-to-end landing zone.

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
                <copy-paste of Json representation of the resource>
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

## Contributing new Azure Policy definitions for Contoso implementation

To contribute to policy definitions that adhere to the enterprise-scale architecture, use the following tools and recommendations:

[Azure Policy extension for Visual Studio](https://docs.microsoft.com/azure/governance/policy/how-to/extension-for-vscode)

Use this extension to look up policy aliases and review resources and policies.

## Explore available resource properties with corresponding policy aliases

For Azure PowerShell:

```powershell
# List all available providers
Get-AzPolicyAlias -ListAvailable

# Get aliases for a specific resource provider
(Get-AzPolicyAlias -NamespaceMatch 'Microsoft.Network').Aliases.Name
```

For Azure CLI:

```cli
# List all available providers

az provider list --query [*].namespace

# Get aliases for a specific resource provider

az provider show --namespace Microsoft.Network --expand "resourceTypes/aliases" --query "resourceTypes[].aliases[].name"
```

## Contributing new Azure Policy assignments

The following must be considered when assigning all policies:

- Be specific about the intent of the assignment. Does it belong to the two subscriptions (connectivity and management) or to the management groups?
- What is the resource distribution within the subscriptions?
- What are the regions being used, and are multiple regions allowed/used per subscription?
- What resource types are allowed that may or may not affect where the policy is being assigned?
- For multiple policies serving the same or a similar purpose, can they be bundled into a policy initiative?
- What is the rationale of the policy in effect? Should an audit policy be translated to an enforcement instead?
- For `DeployIfNotExists` policies, are you following the principle of least privilege for the role-based access-control definition used?

<!-- cSpell:ignore don'ts -->

## Code of conduct

We are working hard to build strong and productive collaboration with our passionate community. We heard you loud and clear. We are working on set of principles and guidelines with dos and don'ts.
