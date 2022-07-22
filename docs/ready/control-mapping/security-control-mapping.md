---
title: Security Control Mapping with Azure Landing Zone
description: This document is an End-to-End guidance for Security Control Mapping when deploying Azure Landing Zone for those organizations that are required to comply with regional and other regulatory compliances.
author: Tshah2808
ms.author: tanshah
ms.date: 07/06/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Security Control Mapping with Azure Landing Zone

Many organizations are required to comply with certain industry regulations before adopting and onboarding the Azure cloud services. These compliance regulations are identified by compliance domain and controls respectively. For example, Access Control is a compliance domain and CMMC L3 AC 1.001 is a control ID.
The best practice recommendation is to map the required compliance controls to Azure Security Benchmark (ASB) and create custom set of the controls that are not covered by ASB. Mapping the required controls to ASB can greatly expedite secure Azure onboarding experience.
ASB provides a canonical set of cloud-centric technical security controls based on widely used compliance control framework such as NIST, CIS, PCI.
There are many ASB Regulatory compliance built-in initiatives already available. If you are interested in a specific Compliance Domain, please reference  Regulatory Compliance Built-in initiatives

> [!NOTE]
> The control mappings between ASB and industry benchmarks (such as CIS, NIST, and PCI) only indicate that a specific Azure feature(s) can be used to fully or partially address a control requirement defined in these industry benchmarks. You should be aware that such implementation does not necessarily translate to the full compliance of the corresponding control(s) in these industry benchmarks.

The process flow of control mapping:

:::image type="content" source="./media/control-mapping-process-flow.svg" alt-text="Control Mapping Process Flow - with ALZ" lightbox="./media/control-mapping-process-flow.svg":::

## Control Mapping process steps

1. Identify the controls required
2. Map required controls to ASB
3. Identify the controls not mapped with ASB and respective policies
4. Perform Platform and Service level Assessment
5. Implement guardrails with policy initiatives using ALZ or native tools

> [!TIP]
> You should review the guidance in [Tailor the Azure landing zone architecture](/azure/cloud-adoption-framework/ready/landing-zone/tailoring-alz) for details on how to tailor the Azure Landing Zone architecture to support your control mapping requirements.

### 1.Identify the controls required

Gather all existing and required lists of compliance controls from the Security team. If the list doesn’t exist, capture the control requirements in an Excel spreadsheet. Please use the format below as guidance to build the list. A list would consist of controls from one or many compliance frameworks. The template to use for capturing required controls and related frameworks can be found [Here](https://github.com/tshah2808/cloud-adoption-framework-pr/tree/collab-control-mapping/docs/ready/control-mapping/templates)

A sample of formalized controls list:

:::image type="content" source="./media/formalized-controls-list-template.jpg" alt-text="Formalized Controls list - Template" lightbox="./media/formalized-controls-list-template.jpg":::

### 2.Map the controls to ASB and create set of custom controls

For each control you have captured use appropriate control titles, domain categories, and guidance/description to identify related ASB controls which are a match appropriately. Align the intent of each control as close as possible and note the deviance or gaps in the spreadsheet.
You can also use common frameworks that are mapped to both your organization’s and ASB where they exist. For example, if both yours and ASB controls are already mapped to NIST 800-53 r4 or CIS 7.1 you could join the data sets together on that pivot. Intermediate common frameworks can be found in the [ASB resources section](/security/benchmark/azure/2-cis-benchmark)

Single Control Mapping Example:
Your Org's Control Objectives

:::image type="content" source="./media/single-control-mapping-sample.jpg" alt-text="Single Control  - Sample" lightbox="./media/single-control-mapping-sample.jpg":::

Above table: shows one of the unique control objectives with key words highlighted

We can look at the existing categorization of a given control ‘Application Security' to identify this is an application related control. The content in the requirement field is to implement application firewalls and to harden and patch their applications. Looking at the ASB controls and guidance for a proper match we can see that there are many controls which might apply and map appropriately. To quickly search a given version of the Azure Security Benchmark we provide [Excel download files](/security/benchmark/azure/overview#download) of each release that can be quickly searched by control ID or part of the description verbiage.
In this step the process identifies and maps controls that are covered under ASB.

### 3.Identify the controls not mapped with ASB and respective policies

Any controls that might not map directly to ASB should be marked as needing mitigating automation, and a custom policy or automation script should be developed in the guardrail implementation process.

### 4.Perform platform and Service level Assessment

Once you have your controls & objectives clearly mapped to ASB and have gathered the supporting information on responsibility, guidance, and monitoring, the IT security office or supporting organization must review all provided information in an official platform assessment. This platform assessment will determine if the Azure Security Benchmark meets the minimum threshold for usage and if it can meet all security and compliance requirements imposed by the regulations. If there are gaps identified, you can still use Azure and ASB but might need to develop mitigating controls until these gaps are closed and the benchmark can release updates to address them. In addition, you can map the custom controls by creating a policy definition and optionally adding to an initiative.

#### Checklist Platform

1. Security team has approved the Azure Platform for usage
2. You will need to join an individual ASB Service Baseline excel to the previously completed (platform level) ASB control mappings.
    - Add in columns to accommodate the assessment like: Coverage, Enforcement, Effects allowed
3. Perform a line-by-line analysis of the resulting service baseline assessment template
    - For each control objective indicate:
        1. If it can be met by the service or a risk
        2. Risk value (if any)
        3. Status of review for that line item
        4. Needed mitigating controls (if any)
        5. What Azure Policy can enforce/monitor the control

    - Where there are gaps in monitoring or enforcement for the service and control
        1. report to the ASB team to drive gaps closed (content, monitoring, or enforcement)

    - For any areas that do not meet the your requirements, please notate the risk involved if you choose to exempt that requirement, the impact, and if it is acceptable to approve or if you are blocked due to the gap.

4. Service status is determined:
    - Either the service meets all requirements, or that the risk is acceptable and is placed on an allow list to be used after guardrails are in place
    - OR the service gaps are too large / risk is too big and service is placed on a deny list - it cannot be used until gaps are closed by Microsoft

##### Inputs - platform level

- Service Assessment Template (Excel)
- Control Objectives to ASB Mapping
- Target service

##### Outputs - platform level

- Completed Service Assessment (Excel)
- Mitigating controls
- Gaps
- Approval/Non-Approval for service usage.

After the approval from your internal Security/Audit team that the platform and core services meet their needs, you need to implement the agreed upon appropriate monitoring and guardrails. During the mapping and assessment process, if there were mitigating controls that extend beyond ASB, built-in controls or Azure Policy will need to be implemented using policy definitions and optionally added to initiatives.

#### Checklist - service level

1. Summarize the Policies that were identified as required as an output of the platform assessment and service assessments
2. Develop any needed custom policy definitions to support mitigating controls/gaps
3. Create custom policy initiative
4. Assign the policy initiative with ALZ tooling

##### Inputs - service level

- Completed Service Assessment (Excel)

##### Outputs - service level

- Custom Policy Initiative

### 5.Implement Guardrails (policy initiative) using Azure Landing Zone or native tools

> [!TIP]
> As part of the Azure Landing Zone Accelerators (Portal, Bicep & Terraform), by default, we assign the ASB policy initiative to Intermediate Root Management Group (‘Contoso’ for example). This article describes the process of identifying, mapping, and implementing regulatory compliance related controls as part of Azure Landing Zone (ALZ) deployment.ALZ deployment covers policies that are aligned with ASB for platform level security controls.

#### ALZ Implementation Policy Guidance

Depending on the customer’s control objectives, you might need to create custom policies, policy initiatives and policies assignments.

Please reference the guidance below for each ALZ implementation option.
[ALZ Accelerator using the Azure Portal](https://aka.ms/caf/ready/accelerator)
When using the ALZ Accelerator Azure Portal based experience, please refer to the following articles.
Adding Azure Policy Definitions and initiatives:

[Create custom security policies in Microsoft Defender for Cloud](/azure/defender-for-cloud/custom-security-policies?pivots=azure-portal)

Tutorial: [Create a custom policy definition](/azure/governance/policy/tutorials/create-custom-policy-definition)

[Assigning Azure Policy or Policy initiatives](/azure/governance/policy/assign-policy-portal)

#### ALZ ARM with AzOps Accelerator

[ARM](/aka.ms/alz/arm) and [AzOps](/azure/azops-accelerator>)

When using the ALZ ARM templates implementation with AzOps, please refer to the deployment article to learn how to operate the Azure platform using infrastructure as code.
[Adding Custom Azure Policy Definitions and Initiatives](/aka.ms/alz/wiki/azops)
[Assigning Azure Policy](/aka.ms/alz/wiki/azops)

#### ALZ Terraform module

[caf-enterprise-scale](/aka.ms/alz/tf/wiki)

When using the ALZ Terraform module caf-enterprise-scale, refer to the repository wiki for guidance on how to manage additional policy definitions and assignments.
[Adding Custom Azure Policy Definitions,Initiatives and assigning](https://aka.ms/alz/terraform/custompolicy)

[Assigning a built-in Azure Policy](https://aka.ms/alz/terraform/assignpolicy)

Adding Custom Policy Definitions/Initiatives and assigning:

[Examples](https://github.com/Azure/terraform-azurerm-caf-enterprise-scale/wiki/%5BExamples%5D-Expand-Built-in-Archetype-Definitions)

## ALZ-Bicep

When using the ALZ-Bicep implementation please refer to the article “How does ALZ-Bicep implement Azure Policy” to learn how to create your own policy definitions and assignments.
[Adding Custom Azure Policy Definitions and Initiatives](https://aka.ms/alz/bicep/custompolicy)

[Assigning Azure Policies](https://aka.ms/alz/bicep/assignpolicy)

Implementing custom policy definitions, initiatives and assignments when not using one of the ALZ implementations

**If you are following the ALZ guidance but not using any of the ALZ implementations, you might need to create custom policies, policy initiatives and policies assignments.**

## Azure Portal

When using the Azure Portal, please refer to the following articles.
Adding Customer Azure Policy Definitions and initiatives:
(/azure/defender-for-cloud/custom-security-policies?pivots=azure-portal)
Tutorial: (/azure/governance/policy/tutorials/create-custom-policy-definition)
Tutorial: (/azure/governance/policy/tutorials/create-and-manage)

Assigning Azure Policy or Policy initiatives:
(/azure/governance/policy/assign-policy-portal)

## ARM

When using the ARM templates, please refer to the following articles.
Adding Custom Azure Policy Definitions and initiatives:
[Tutorial](/azure/governance/policy/tutorials/create-custom-policy-definition)
[Tutorial](/azure/governance/policy/tutorials/create-and-manage)

(/azure/templates/microsoft.authorization/policydefinitions?tabs=json)

(/azure/templates/microsoft.authorization/policysetdefinitions?tabs=json)

Assigning Azure Policy or Policy initiatives:

[Quickstart](/azure/governance/policy/assign-policy-template)
(/azure/templates/microsoft.authorization/policyassignments?tabs=json)

## Terraform

When using Terraform, please refer to the following articles.

[Adding Custom Azure Policy Definitions and Initiatives](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_definition)

[Assigning Azure Policy or Policy initiatives](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_policy_assignment)

## Bicep

When using the Bicep templates, please refer to the following articles.

[Adding Custom Azure Policy Definitions and initiatives](/azure/templates/microsoft.authorization/policydefinitions?tabs=bicep)

(/azure/templates/microsoft.authorization/policysetdefinitions?tabs=bicep)

Assigning Azure Policy or Policy initiatives
(/azure/templates/microsoft.authorization/policyassignments?tabs=bicep)

(/azure/governance/policy/assign-policy-bicep?tabs=azure-powershell)

## Additional Guidance using MDC (Microsoft Defender for Cloud)

MDC continually compares the configuration of your resources with requirements in industry standards, regulations and benchmarks. The regulatory compliance dashboard provides insight into your compliance posture.
To enable built-in regulatory compliance dashboard in Microsoft Defender for cloud
The regulatory compliance dashboard in Microsoft Defender for Cloud | Microsoft Docs
To enable custom policy compliance dashboard in Microsoft Defender for cloud
Create custom security policies in Microsoft Defender for Cloud | Microsoft Docs

## Frequently Asked Questions

We are using a framework that ASB is not mapped to yet, how can I still onboard our control objectives to ASB controls?

- We provide ASB mappings to many of the most in-demand industry frameworks, however for the controls that are currently not covered, a manual mapping exercise is needed. In these instances, please refer to our steps for performing a manual control mapping.

[Example] We need to meet Canada Federal Protected B (PBMM) compliance, and ASB does not yet have a mapping to PBMM. To bridge this mapping, you can find a shared framework mapping such as NIST SP 800-53 R4 which is available and mapped to both PBMM and ASB v2. Using this common framework, you can understand what recommendations and guidance you must follow in Azure to meet your desired framework.

Our control objectives aren’t covered by the ASB controls, how can I unblock them from onboarding to ASB?

- ASB is focused on Azure technical controls, objective areas surrounding non-technical items such as training, or for those that are not direct technical security, such as data center security are omitted by design. These items can be marked as Microsoft responsibility, and evidence of compliance can be provided from ASB content or Microsoft audit reports. If you find that the objective truly is a technical control, then create a mitigating control in-addition to the ASB base for tracking, and open a request to the asbteam@microsoft.com to address the missing controls in future releases.

## Resources

[Service Trust Portal](https://servicetrust.microsoft.com/)

[Cloud Security Alliance](/compliance/regulatory/offering-csa-star-attestation)

[Datacenter Security Overview](/compliance/assurance/assurance-datacenter-security)

[Financial Services Overview](https://servicetrust.microsoft.com/viewpage/financialservicesoverview)

[Financial Institution Risk Assessment Overview](https://servicetrust.microsoft.com/ViewPage/RiskAssessmentOverview)

[Service Level Agreement](/support/legal/sla/)
