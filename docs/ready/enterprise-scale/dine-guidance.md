---
title: Adopt policy-driven guardrails
description: Understand how to adopt policy-driven guardrails in the Azure landing zone.
author: jtracey93
ms.author: jatracey
ms.date: 12/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---
# Adopt policy-driven guardrails

Before you adopt the use of policies, you need to understand where they're used within the Azure landing zone reference implementations and why. This background will help you understand whether you want to prevent `DeployIfNotExists` (DINE) or `Modify` policies from making changes within your Azure environment.

### Why use DINE and Modify policies?

DINE and Modify policies are part of the Azure landing zone reference implementations. They help you and your organization ensure your landing zones (also known as subscriptions) and the resources within them are compliant. These policies also remove the operational burden for platform and landing zone teams as your Azure environment scales.

For example, a new landing zone subscription is provisioned and placed in the "corp" management group.

DINE and Modify policies then take the following actions to the landing zone subscription:

>[!NOTE]
> You can disable the following options at any time or during deployment of the Azure landing zone reference implementations.
>  
> The following list shows a subset of all the policies that are assigned as part of the Azure Landing Zone accelerator. For a full list of policies that can be assigned by the Azure Landing Zone reference implementation, see [Policies included in Enterprise-Scale Landing Zones reference implementations](https://github.com/Azure/Enterprise-Scale/blob/main/docs/ESLZ-Policies.md).

- Enable Microsoft Defender for Cloud:
  - Including configuring Microsoft Defender for Cloud exports to the central Log Analytics workspace in the management subscription.
- Enable Azure Defender for the different supported offerings based on the policy parameters configured on the policy assignment.
- Configure the Azure Activity Logs to be sent to the central Log Analytics workspace in the management subscription.
- Configure the Diagnostic settings for all resources to be sent to the central Log Analytics workspace in the management subscription.
- Deploy the required Azure Monitor Agents for Virtual Machines and Azure Virtual Machine Scale Sets, including Arc connected servers, and connect them to the central Log Analytics workspace in the management subscription.

All assigned policies help you and the landing zone owners remain compliant. No actual workload resources are deployed via DINE or Modify policies (we don't recommend this either as per [Should we use Azure Policy to deploy workloads?](/azure/cloud-adoption-framework/ready/enterprise-scale/faq#should-we-use-azure-policy-to-deploy-workloads)). Only auxiliary or supporting resources or settings are deployed or configured by these DINE policies.

The Azure landing zones reference implementations use [DINE](/azure/governance/policy/concepts/effects#deployifnotexists) Azure policies to help you achieve policy-driven governance within your Azure environment. But you might not be able to use DINE or Modify policies, or you might not be ready to enable this type of [Azure policy](/azure/governance/policy/concepts/effects) because of:

- Regulatory compliance policies, standards, or law restrictions.
- Strict change control processes that require human approval for every action within your Azure environment.
- Lack of expertise, experience, and understanding of how to manage and use DINE policies.

If you fit into the preceding example scenarios or similar, this article helps you understand how to adopt the [Azure landing zone conceptual architecture](/azure/cloud-adoption-framework/ready/landing-zone/#azure-landing-zone-conceptual-architecture), alongside its [design principles](/azure/cloud-adoption-framework/ready/enterprise-scale/design-principles), while not using certain policies initially (can optionally choose to gradually enable in the future), that help you achieve [policy-driven governance](/azure/cloud-adoption-framework/ready/enterprise-scale/design-principles#policy-driven-governance).

>[!IMPORTANT]
> Throughout this article, you'll see references to the Enforcement Mode feature being set with two possible values in either of the terms listed for them:
>  
> - `Disabled` or `DoNotEnforce`
> - `Enabled` or `Default`
>  
> The Azure portal uses the `Disabled` and `Enabled` terms for the Enforcement Mode feature. Azure Resource Manager (ARM) templates and other API interfaces use `DoNotEnforce` and `Default` for the same options.
>  
> For more information, see [Enforcement Mode](/azure/governance/policy/concepts/assignment-structure#enforcement-mode).

If you're still certain that your organization can't use DINE or Modify policies, then below we'll explain how to prevent (also known as disable) the policies from making automatic changes to your Azure environment.

>[!NOTE]
> This operation isn't permanent. The policies can be reenabled at any time by a member of your platform team if you later decide to use DINE or Modify policies.
>  
> For more information, see Phase [2](#phase-2-enable-dinemodify-policies-on-a-specific-policy-or-reduced-scope-setting-enforcement-mode-to-default-on-policy-assignments) and Phase [3](#phase-3-enabling-dinemodify-policies-everywhere-setting-enforcementmode-to-default-on-policy-assignments).

### Approach overview

The following diagram summarizes the suggested phased approach:

![Graphic that shows a DINE phases overview.](./media/dine-phases.png)

1. Start by setting the [Enforcement Mode](/azure/governance/policy/concepts/assignment-structure#enforcement-mode) to `DoNotEnforce` on Policy Assignments:
   - By using this feature, you can modify the assignments behavior, to effectively become an audit only policy, without modifying the underlying policy definition.
   - This approach also still allows you to perform manual remediation tasks on non-compliant resources using [remediation tasks](/azure/governance/policy/how-to/remediate-resources), should you wish to.
1. Set the [Enforcement Mode](/azure/governance/policy/concepts/assignment-structure#enforcement-mode) to `Default` on Policy Assignments to reenable DINE policy assignments automatic remediation *on a reduced scope*.
   - You can choose to use an entire environment (for example the Sandbox management group) or a non-critical workload subscription.
1. Set the [Enforcement Mode](/azure/governance/policy/concepts/assignment-structure#enforcement-mode) to `Default` on Policy Assignments on remaining DINE policies across the entire Azure environment.

Because of regulatory compliance restrictions, some customers might not ever be able to move past phase 1. However, this is not an issue and is supported to remain in this state, if necessary. Other customers might be able to progress, over time, to phases 2 and 3 to fully adopt DINE and Modify policies to assist with policy-driven governance for their Azure environment.

>[!NOTE]
> This scenario and approach outlined in this article isn't intended for or recommended for the majority of customers. Review the preceding section [Why use DINE and Modify policies?](#why-use-dine-and-modify-policies) in full before you decide whether this is suitable and required for your environment.

### Phase 1: Disable DINE/Modify policies automated actions

When assigning a policy, by default the [effect](/azure/governance/policy/concepts/effects) defined in the policy definition will apply; and this is recommended to be left as is. For example, leave the policy assignment effect as `DeployIfNotExists`.

Instead of changing the policy definition and/or its effect, you can instead influence this behavior with minimal effort by using the feature on policy assignments.

#### Example of Azure portal experience setting Enforcement Mode to `DoNotEnforce` (also known as `Disabled`) on a policy assignment

![Set the Enforcement Mode to Disabled in the Azure portal.](./media/dine-phase1-portal.png)

#### Example of ARM template experience setting Enforcement Mode to `DoNotEnforce` (also known as `Disabled`) on a policy assignment

```json
{
  "type": "Microsoft.Authorization/policyAssignments",
  "apiVersion": "2019-09-01",
  "name": "PolicyAssignmentName",
  "location": "[deployment().location]",
  "properties": {
    "description": "PolicyAssignmentDescription",
    "policyDefinitionId": "[parameters('policyDefinitionId')]",
    "enforcementMode": "DoNotEnforce"
    … // other properties removed for display purposes
  }
}
```

The [Enforcement Mode](/azure/governance/policy/concepts/assignment-structure#enforcement-mode) feature provides you the ability to see the effect of a policy on existing resources without initiating it or triggering entries in the Azure Activity log. This scenario is commonly referred to as "What If" and aligns to safe deployment practices.

Even when [Enforcement Mode](/azure/governance/policy/concepts/assignment-structure#enforcement-mode) is set to `DoNotEnforce`, [remediation tasks](/azure/governance/policy/how-to/remediate-resources) can be triggered manually, allowing you to remediate specific non-compliant resources and also see what the DINE or Modify policy would have done if its enforcement mode was set to `Default`.

>[!IMPORTANT]
> When the Enforcement Mode feature is set to `DoNotEnforce`, entries in the Azure Activity log won't be generated. Consider this if you plan to be notified when a noncompliant resource is created.

#### Stay in the phase 1 state permanently

As mentioned at the end of the [Approach Overview](#approach-overview), some customers might need to remain in [phase 1](#phase-1-disable-dinemodify-policies-automated-actions) for a longer period or maybe even permanently due to their requirements; this is valid state to be in and remain in for any period of time.

However, if staying in this state permanently or a longer period (years etc.) then it might be better for you to adopt the [AuditIfNotExists](/azure/governance/policy/concepts/effects#auditifnotexists) (AINE) policy effect and associated definitions and setting the Enforcement Mode back to `Default`.

>[!NOTE]
> By changing to using an AINE policy and setting the Enforcement Mode to `Default`, you still achieve the same goal of "disabling DINE."

The reasons for changing from DINE to AINE and setting the Enforcement Mode back to `Default` as longer term or permanent approach for phase 1 are that; by doing this you will gain the Azure Activity Log entries back for policy compliance statuses which are useful for building automation workflows from these log entries in your overall platform management operations.

You'll lose the capability to perform manual remediation tasks because unlike DINE policies, AINE policies don't perform any deployments, either automated or manual.

Also, remember to update the policy definition to accept and allow the `AuditIfNotExists` policy assignment effect.

The following table summarizes the different options and the implications for the different types of policy effects and enforcement mode combination:

| Policy effect | Enforcement mode      | Activity log entry | Remediation action |
| --            | --                    | --                 | --          |
| DINE          | Enabled/Default       | Yes                | Platform triggered remediation at scan after creation/resource update. Manual creation of a remediation task required if dependent resource is modified or pre-existing prior to the policy assignment. |
| DINE          | Disabled/DoNotEnforce | No                 | Manual creation of a remediation task required. |
| Modify        | Enabled/Default       | Yes                | Automatic remediation during creation/update. |
| Modify        | Disabled/DoNotEnforce | No                 | Manual creation of a remediation task required. |
| Deny          | Enabled/Default       | Yes                | Creation/update denied. |
| Deny          | Disabled/DoNotEnforce | No                 | Creation/update allowed. Manual remediation required. |
| Audit/AINE    | Enabled/Default       | Yes                | Manual remediation required. |
| Audit/AINE    | Disabled/DoNotEnforce | No                 | Manual remediation required. |

>[!NOTE]
> You should also review the guidance in [Reacting to Azure Policy state change events](/azure/governance/policy/concepts/event-overview) to understand if using the Event Grid integration with Azure Policy provides a suitable approach if you plan to build your own automation based on policy state events.

### Phase 2: Enable DINE/Modify policies on a specific policy or reduced scope (set Enforcement Mode to `Default` on policy assignments)

After you've completed [phase 1](#phase-1-disable-dinemodify-policies-automated-actions), you might decide that you want to test and try out the full automation capabilities of DINE and Modify policies on a specific policy or upon a reduced scope, like the `Sandbox` management group or a nonproduction workload subscription.

To do this, you'll first need to identify the policy or reduced scope that will be used to test and try the DINE and Modify policies full automation capabilities.

>[!NOTE]
> You might want to review and implement a [Testing approach for enterprise-scale](/azure/cloud-adoption-framework/ready/enterprise-scale/testing-approach) platform to enable you to test policies and other platform changes in a separated management group hierarchy within the same tenant.
>  
> This is also known as a "Canary" deployment of Enterprise-scale.

Some suggested examples of scopes and policies are shown in the following table:

| When you want to... | ...choose from these scopes | Example policies to use |
| ------------------- | --------------------------- | ----------------------- |
| - Test the DINE/Modify automated remediation capabilities. <br> - Verify how your complete deployment processes and CI/CD pipelines (including tests) might be affected. <br> - Verify how your workload might be affected. | - Sandbox Subscription <br> - Sandbox Management Group <br> - Non-production workload landing zone Subscription <br> - [Enterprise-scale "Canary" environment](/azure/cloud-adoption-framework/ready/enterprise-scale/testing-approach) | - Configure Azure Activity logs to stream to specified Log Analytics workspace. <br> - Deploy Microsoft Defender for Cloud configuration. <br> - Enable Azure Monitor for VMs/Virtual Machine Scale Sets. <br> - Deploy diagnostic settings to Azure services. <br>  - Potentially only enable for specific services within the initiative. |

You might also decide to use a manual remediation task on a limited scope or set of resources to test how these policies will impact your environment. Detailed guidance on creating a remediation task can be found in the Azure Policy documentation here: [Create a remediation task](/azure/governance/policy/how-to/remediate-resources#create-a-remediation-task).

After you've identified a policy, or policies, and the reduced scope to assign them at, the next step is to assign the policy and set the Enforcement Mode to `Default`; whie leaving the policy effect (for example `DeployIfNotExists` or `Modify`) as is on chosen reduced scope.

#### Example of Azure portal experience setting Enforcement Mode to `Default` (also known as `Enabled`) on a policy assignment

![Set the Enforcement Mode to Default in the Azure portal.](./media/dine-phase2-portal.png)

#### Example of ARM template experience setting Enforcement Mode to `Default` (also known as `Enabled`) on a policy assignment

```json
{
  "type": "Microsoft.Authorization/policyAssignments",
  "apiVersion": "2019-09-01",
  "name": "PolicyAssignmentName",
  "location": "[deployment().location]",
  "properties": {
    "description": "PolicyAssignmentDescription",
    "policyDefinitionId": "[parameters('policyDefinitionId')]",
    "enforcementMode": "Default"
    … // other properties removed for display purposes
  }
}
```

#### Testing

The final step in this phase is to perform the required testing to verify if and how DINE or Modify policies might have affected and made changes to your workloads, code, tools, and processes.

We recommend that you perform multiple tests, capturing the entire lifecycle of your workload, to ensure you fully understand if and how DINE or Modify policies have made changes.

Some examples of test we would suggest are:

- Initial deployment of workload.
- Code/Application deployment onto workload.
- Day 2 operations and management of workload.
- Decommissioning of workload.

### Phase 3: Enable DINE/Modify policies everywhere (set `enforcementMode` to `Default` on policy assignments)

Assuming that during your [testing](#testing) at the end of [phase 2](#phase-2-enable-dinemodify-policies-on-a-specific-policy-or-reduced-scope-setting-enforcement-mode-to-default-on-policy-assignments) has passed successfully, or you're satisfied that you now understand how DINE or Modify policies interact with your workload. Now you can expand the use of DINE and Modify policies across the rest of your Azure environment.

To do this, you'll need to follow similar steps as you did in [phase 2](#phase-2-enable-dinemodify-policies-on-a-specific-policy-or-reduced-scope-setting-enforcement-mode-to-default-on-policy-assignments). Apart from this time, you'll be setting the Enforcement Mode to `Default` on all DINE and Modify policy assignments across your entire Azure environment.

Here's a high-level overview of the steps you need to perform in this phase:

- Remove assignments used specifically for [testing during phase 2](#testing).
- Go through each DINE and Modify policy assignment in your Azure environment and set the Enforcement Mode to `Default`, as shown in the examples in phase 2.
- Create remediation tasks for existing resources that are noncompliant following the guidance listed here in [Create a remediation task](/azure/governance/policy/how-to/remediate-resources#create-a-remediation-task).
  - New resources will automatically be remediated if they match the policy rules and existence conditions.

Even though in phase 3 we recommend that you set the Enforcement Mode to `Default` for all DINE and Modify policies in your Azure environment, this choice is still optional. You can make this choice on a per-policy basis to suit your needs and requirements.
