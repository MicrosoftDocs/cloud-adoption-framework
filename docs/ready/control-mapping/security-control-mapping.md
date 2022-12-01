---
title: Security control mapping with Azure landing zones
description: Learn about security control mapping with Azure landing zones for regional and other regulatory compliance.
author: Tshah2808
ms.author: tanshah
ms.date: 09/06/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Security control mapping with Azure landing zones


Many organizations are required to comply with certain industry/regional regulations before adopting and onboarding the Azure cloud services. These compliance regulations are identified by compliance domain and controls respectively. For example, **CMMC L3 AC 1.001** where AC is Access Control domain and 1.001 is a control ID in Cybersecurity Maturity Model Certification (CMMC) framework. The best practice recommendation is to map the required compliance controls to Microsoft cloud security benchmark (MCSB) and identify the custom set of the controls that are not covered by MCSB.

In Addition, MCSB also provides the list of built-in policies and Policy initiatives GUIDs to addresses the required controls. For the controls that are not covered in MCSB, the control mapping guidance includes a step by step process on how to build policies and initiatives.

Mapping the required controls to Microsoft cloud security benchmark can greatly expedite secure Azure onboarding experience. Microsoft cloud security benchmark provides a canonical set of cloud-centric technical security controls based on widely used compliance control frameworks such as NIST, CIS, PCI. There are built-in regulatory compliance initiatives already available. If you're interested in a specific compliance domain, refer to [Regulatory compliance built-in initiatives](/azure/governance/policy/samples/azure-security-benchmark).

> [!NOTE]
> The control mappings between Microsoft cloud security benchmark and industry benchmarks, such as CIS, NIST, and PCI, only indicate that a specific Azure feature can be used to fully or partially address a control requirement defined in these industry benchmarks. You should be aware that such implementation does not necessarily translate to the full compliance of the corresponding controls in these industry benchmarks.

The following diagram shows the process flow of control mapping:

:::image type="content" source="media/control-mapping-process-flow.png" alt-text="Diagram of control mapping process flow with Azure landing zones." lightbox="media/control-mapping-process-flow.png":::

## Control mapping steps

1. Identify the controls required.
2. Map required controls to Microsoft cloud security benchmark.
3. Identify the controls not mapped with Microsoft cloud security benchmark and respective policies.
4. Perform platform and service level assessment.
5. Implement guardrails with policy initiatives using Azure landing zone tooling, native tooling, or third-party tooling.

> [!TIP]
> You should review the guidance for how to [tailor the Azure landing zone architecture](../landing-zone/tailoring-alz.md) to support your control mapping requirements.

### 1. Identify the controls required

Gather all existing and required lists of compliance controls from the Security team. If the list doesn’t exist, capture the control requirements in an Excel spreadsheet. Please use the format below as guidance to build the list. A list would consist of controls from one or many compliance frameworks. Use the [Security control mapping template](https://github.com/microsoft/CloudAdoptionFramework/blob/master/ready/Azure%20Security%20Control%20Mapping-%20Template%20with%20Example.xlsx) to capture required controls and related frameworks. 

:::image type="content" source="./media/formalized-controls-list-template.jpg" alt-text="Screenshot of a formalized controls list template." lightbox="./media/formalized-controls-list-template.jpg":::

_A sample of formalized controls list._

### 2. Map the controls to Microsoft cloud security benchmark and create set of custom controls

For each control you've captured, use appropriate control titles, domain categories, and guidance/description to identify related controls. Align the intent of each control as close as possible and note the deviance or gaps in the spreadsheet.

You can also use common frameworks that are mapped to both your organization’s and Microsoft cloud security benchmark where they exist. For example, if both yours and Microsoft cloud security benchmark controls are already mapped to NIST 800-53 r4 or CIS 7.1, you could join the data sets together on that pivot. Intermediate common frameworks can be found in the [resources section](/security/benchmark/azure/v2-cis-benchmark)

:::image type="content" source="./media/single-control-mapping-sample.jpg" alt-text="Screenshot of single control sample." lightbox="./media/single-control-mapping-sample.jpg":::

_Single control mapping example: Your organization's control objectives_

_The table above shows one of the unique control objectives with key words highlighted._

In this example, we can look at the existing categorization of a given control ‘Application Security' to identify it as an application-related control. The content in the requirement field is to implement **application firewalls** and to **harden and patch their applications.** Looking at the Microsoft cloud security benchmark controls and guidance for a proper match, we can see that there are many controls that might apply and map appropriately.
 
To quickly search a given version of the Microsoft cloud security benchmark, we provide [Excel download files](/security/benchmark/azure/overview#download) for each release that can be quickly searched by control ID or part of the description verbiage. In this step, the process identifies and maps controls that are covered under Microsoft cloud security benchmark.

### 3. Identify the controls not mapped with Microsoft cloud security benchmark and respective policies

Any identified controls that might not map directly should be marked as needing mitigating automation, and a custom policy or automation script should be developed in the guardrail implementation process.

> [!TIP]
> [AzAdvertizer](https://www.azadvertizer.net/azpolicyadvertizer_all.html#%7B%7D) is a community driven tool endorsed by the Cloud Adoption Framework. It can help you discover policies that are built-in, from Azure landing zones or from the [community Azure Policy repo](https://github.com/Azure/Community-Policy) in a single place.

### 4. Perform platform and service level assessment

Once you have your controls and objectives clearly mapped to Microsoft cloud security benchmark and have gathered the supporting information on responsibility, guidance, and monitoring, the IT security office or supporting organization must review all provided information in an official platform assessment.

This platform assessment will determine if the Microsoft cloud security benchmark meets the minimum threshold for usage and if it can meet all security and compliance requirements imposed by the regulations.

If there are gaps identified, you can still use Microsoft cloud security benchmark but might need to develop mitigating controls until these gaps are closed and the benchmark can release updates to address them. In addition, you can map the custom controls by creating a [policy definition](/azure/governance/policy/overview#policy-definition) and optionally adding to an [initiative definition](/azure/governance/policy/overview#initiative-definition).

#### Checklists for approval

1. Security team has approved the Azure platform for usage.
2. You'll need to join an individual Microsoft cloud security benchmark service baseline Excel to the previously completed, platform-level control mappings.
    - Add in columns to accommodate the assessment like: coverage, enforcement, effects allowed.
3. Perform a line-by-line analysis of the resulting service baseline assessment template:
    - For each control objective, indicate:
        - If it can be met by the service or a risk.
        - Risk value, if any.
        - Status of review for that line item.
        - Needed mitigating controls, if any.
        - What Azure Policy can enforce/monitor the control.

    - Where there are gaps in monitoring or enforcement for the service and control:
        - Report to the Microsoft cloud security benchmark team to close gaps in content, monitoring, or enforcement.

    - For any areas that don't meet your requirements, note the risk involved if you choose to exempt that requirement, the impact, and if it's acceptable to approve or if you're blocked due to the gap.

4. Service status is determined:
    - Either the service meets all requirements, or that the risk is acceptable and is placed on an allowlist to be used after guardrails are in place.
    - OR, the service gaps are too large / risk is too large and service is placed on a blocklist. It can't be used until gaps are closed by Microsoft.

##### Inputs - platform level

- Service assessment template (Excel)
- Control objectives to Microsoft cloud security benchmark mapping
- Target service

##### Outputs - platform level

- Completed service assessment (Excel)
- Mitigating controls
- Gaps
- Approval/non-approval for service usage

After the approval from your internal security/audit team that the platform and core services meet their needs, you need to implement the agreed upon appropriate monitoring and guardrails. During the mapping and assessment process, if there were mitigating controls that extend beyond Microsoft cloud security benchmark, then built-in controls or Azure Policy will need to be implemented using [policy definitions](/azure/governance/policy/overview#policy-definition) and optionally adding to an [initiative definition](/azure/governance/policy/overview#initiative-definition).

#### Checklist - service level

1. Summarize the policies that were identified as required as an output of the platform assessment and service assessments.
2. Develop any needed custom policy definitions to support mitigating controls/gaps.
3. Create custom policy initiative.
4. Assign the policy initiative with Azure landing zone tooling, native tooling, or third-party tooling.

##### Inputs - service level

- Completed service assessment (Excel)

##### Outputs - service level

- Custom policy initiative

### 5. Implement guardrails using Azure landing zone or native tools

The following sections describe the process of identifying, mapping, and implementing regulatory compliance-related controls as part of Azure landing zone deployment. Deployment covers policies that are aligned with Microsoft cloud security benchmark for platform-level security controls.

> [!TIP]
> As part of the Azure landing zone accelerators ([Portal](../landing-zone/index.md), [Bicep](https://aka.ms/alz/bicep) & [Terraform](https://aka.ms/alz/tf)), we assign the Microsoft cloud security benchmark policy initiative to Intermediate Root Management Group by default.

You can learn about [policies assigned as part of an Azure landing zone Accelerator deployment](https://github.com/Azure/Enterprise-Scale/blob/main/docs/ESLZ-Policies.md).

### Implementation policy guidance

Depending on your control objectives, you might need to create custom [policy definitions](/azure/governance/policy/concepts/definition-structure), [policy initiative definitions](/azure/governance/policy/concepts/initiative-definition-structure) and [policy assignments](/azure/governance/policy/concepts/assignment-structure).

Refer to the following guidance for each accelerator implementation option.

#### Azure landing zone accelerator portal

When using the [Azure landing zone portal-based experience](https://aka.ms/caf/ready/accelerator):

- [Create custom security policies in Microsoft Defender for Cloud](/azure/defender-for-cloud/custom-security-policies?pivots=azure-portal)
- [Tutorial: Create a custom policy definition](/azure/governance/policy/tutorials/create-custom-policy-definition)
- [Assign Azure Policy or policy initiatives](/azure/governance/policy/assign-policy-portal)

#### Azure Resource Manager with AzOps

When using the [Resource Manager templates](https://aka.ms/alz/arm) with the [AzOps Accelerator](https://github.com/azure/azops-accelerator), refer to the deployment article to learn how to operate the Azure platform using infrastructure as code.

- [Adding Custom Azure Policy definitions and initiatives](https://aka.ms/alz/wiki/azops)
- [Assigning Azure Policy](https://aka.ms/alz/wiki/azops)

#### Terraform module

When using the [Azure landing zones Terraform module](https://aka.ms/alz/tf/wiki), refer to the repository wiki for guidance on how to manage additional policy definitions and assignments.

- [Adding Custom Azure Policy definitions and assignments](https://aka.ms/alz/terraform/custompolicy)
- [Assigning a built-in Azure Policy](https://aka.ms/alz/terraform/assignpolicy)
- [Expand built-in archetype definitions](https://github.com/Azure/terraform-azurerm-caf-enterprise-scale/wiki/%5BExamples%5D-Expand-Built-in-Archetype-Definitions)

#### Bicep

When using the Azure landing zones Bicep implementation, learn how to [create your own policy definitions and assignments](https://github.com/Azure/ALZ-Bicep/wiki/PolicyDeepDive).

- [Adding Custom Azure Policy definitions and initiatives](https://aka.ms/alz/bicep/custompolicy)
- [Assigning Azure Policies](https://aka.ms/alz/bicep/assignpolicy)

### Implement custom policies when not using an Azure landing zones implementation

#### Azure portal

When using the Azure portal, refer to the following articles.

- [Create custom security policies in Microsoft Defender for Cloud](/azure/defender-for-cloud/custom-security-policies?pivots=azure-portal)
- [Create a custom policy definition](/azure/governance/policy/tutorials/create-custom-policy-definition)
- [Create and manage policies to enforce compliance](/azure/governance/policy/tutorials/create-and-manage)
- [Assign policy initiatives](/azure/governance/policy/assign-policy-portal)

#### Azure Resource Manager templates

When using the Resource Manager templates, refer to the following articles.

- [Create a custom policy definition](/azure/governance/policy/tutorials/create-custom-policy-definition)
- [Assign policy initiatives](/azure/governance/policy/assign-policy-portal)
- [Create a policy assignment to identify non-compliant resources by using an ARM template](/azure/governance/policy/assign-policy-template)
- [Bicep and Resource Manager policy definition template reference](/azure/templates/microsoft.authorization/policydefinitions?tabs=json)
- [Bicep and Resource Manager set (initiative) template reference](/azure/templates/microsoft.authorization/policysetdefinitions?tabs=json)
- [Bicep and Resource Manager policy assignment template reference](/azure/templates/microsoft.authorization/policyassignments?tabs=json)

#### Terraform

When using Terraform, refer to the following articles.

- [Adding custom Azure policy definitions and initiatives](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_definition)
- [Adding Azure Policy set Definition](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_policy_assignment)
- [Assigning management group policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_policy_assignment)
- [Assigning Azure Policy or policy initiative](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_policy_assignment)

#### Bicep

When using the Bicep templates, refer to the following articles.

- [Quickstart: Create a policy assignment to identify non-compliant resources by using a Bicep file](/azure/governance/policy/assign-policy-bicep?tabs=azure-powershell)
- [Bicep and Resource Manager policy definition template reference](/azure/templates/microsoft.authorization/policydefinitions?tabs=bicep)
- [Bicep and Resource Manager policy set (initiative) template reference](/azure/templates/microsoft.authorization/policysetdefinitions?tabs=bicep)
- [Bicep and Resource Manager policy assignment template reference](/azure/templates/microsoft.authorization/policyassignments?tabs=bicep)

## Guidance for using Microsoft Defender for Cloud

[Microsoft Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction) continually compares the configuration of your resources with requirements in industry standards, regulations, and benchmarks. The regulatory compliance dashboard provides insight into your compliance posture. Learn more about [improving your regulatory compliance](/azure/defender-for-cloud/regulatory-compliance-dashboard).

## Frequently asked questions

### We're using a framework not mapped to Microsoft cloud security benchmark, how can I still onboard our control objectives?

We provide Microsoft cloud security benchmark mappings to many of the most in-demand industry frameworks. However, for the controls that are currently not covered, a manual mapping exercise is needed. In these instances, refer to our steps for performing a manual control mapping.

_[Example]_ We need to meet Canada Federal Protected B (PBMM) compliance, and Microsoft cloud security benchmark doesn't yet have a mapping to PBMM. To bridge this mapping, you can find a shared framework mapping such as NIST SP 800-53 R4 that's available and mapped to both PBMM and MCSB v2. Using this common framework, you can understand what recommendations and guidance you must follow in Azure to meet your desired framework.

### Our control objectives aren’t covered by the Microsoft cloud security benchmark controls, how can I unblock them from onboarding?

Microsoft cloud security benchmark is focused on Azure technical controls. Objective areas surrounding non-technical items such as training, or for items that aren't direct technical security, such as data center security, are omitted by design. These items can be marked as Microsoft responsibility, and evidence of compliance can be provided from Microsoft cloud security benchmark content or Microsoft audit reports. If you find that the objective truly is a technical control, then create a mitigating control in-addition to the base for tracking, and send a request to *MCSBteam@microsoft.com* to address the missing controls in future releases.

## Resources

[Service Trust Portal](https://servicetrust.microsoft.com/)

[Cloud Security Alliance](/compliance/regulatory/offering-csa-star-attestation)

[Datacenter Security Overview](/compliance/assurance/assurance-datacenter-security)

[Financial Services Overview](https://servicetrust.microsoft.com/viewpage/financialservicesoverview)

[Financial Institution Risk Assessment Overview](https://servicetrust.microsoft.com/ViewPage/RiskAssessmentOverview)

[Service Level Agreement](https://azure.microsoft.com/support/legal/sla/)
