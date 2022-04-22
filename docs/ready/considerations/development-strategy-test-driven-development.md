---
title: Test-driven development for Azure Landing Zones
description: Test-driven development for Azure Landing Zones.
author: ElisaAnzelmo, ElenaBataneroGarcia
ms.author: elanzel, elbatane, vitoc, yeeshian
ms.date: 03/25/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Test-driven development for Azure Landing Zones

Test-driven development (TDD) is a common software development and DevOps process that improves the quality of new features and improvements in any code-based solution by creating unit test cases before developing the actual code and testing the code against them. This is as opposed to software being developed first and test cases created later.

Cloud-based infrastructure and the underlying source code can use this process to ensure landing zones meet core requirements and are of high quality. This process is especially useful when landing zones are being developed and refactored in a parallel development effort.

![Test-driven development process for Azure Landing Zones](../../_images/ready/test-driven-development-process.png)

In the cloud, infrastructure is the output of code execution. Well-structured, tested, and verified code produces a viable landing zone. A [landing zone](../landing-zone/index.md) is an environment for hosting your workloads, preprovisioned through code. It includes foundational capabilities using a defined set of cloud services and best practices that set you up for success. This guidance describes an approach that uses test-driven development to fulfill the last part of that definition, while meeting quality, security, operations, and governance requirements.

This approach can be used to meet simple feature requests during early development. Later in the cloud adoption lifecycle, this process can be used to meet security, operations, governance, or compliance requirements.

## Definition of done

"Set up for success" is a subjective statement. This statement provides the cloud platform team with little actionable information during landing zone development or refactoring efforts. This lack of clarity can lead to missed expectations and vulnerabilities in a cloud environment. Before refactoring or expanding any landing zone, the cloud platform team should seek clarity regarding the "definition of done" for each landing zone.

Definition of done is a simple agreement between the cloud platform team and other affected teams. This agreement outlines the expected value added features, which should be included in any landing zone development effort. The definition of done is often a checklist that's aligned with the short-term cloud adoption plan. In mature processes, those expected features in the checklist will each have their own acceptance criteria to create even more clarity. When the value-added features each meet the acceptance criteria, the landing zone is sufficiently configured to enable the success of the current wave or release of adoption effort.

As teams adopt additional workloads and cloud features, the definition of done and acceptance criteria will become increasingly more complex.

## Test-driven development cycle

The cycle that makes test-driven development effective is often referred to as a red/green test. In this approach, the cloud platform team starts with a failed test (red test) based on the definition of done and defined acceptance criteria. For each feature or acceptance criteria, the cloud platform team would complete development tasks until the test passes (green test). A test-driven development cycle (or red/green test) would repeat the basic steps in the following image and the list below until the full Definition of Done can be met. The TDD practice was created to address better design, not to create a suite of tests. The tests just happen to be an extremely valuable artifact for the process.

- **Create a test:** Define a test to validate that acceptance criteria for a specific value-add feature has been met. Automate the test as you develop, to reduce to the amount of manual tests effort for Landing Zone deployments, especially for Enterprise Scale.
- **Test the landing zone:** Run the new test and any existing tests. If the required feature hasn't already been met by prior development efforts and isn't inclusive to the cloud provider's offering, the test should fail. Running existing tests will help validate that your new test doesn't reduce reliability of landing zone features delivered by existing code.
- **Expand and refactor the landing zone:** Add or modify the source code to fulfill the requested value-add feature and improve the general quality of the code base. To meet the fullest spirit of test-driven development, the cloud platform team would only add code to meet the requested feature and nothing more. At the same time, code quality and maintenance is a shared effort. When fulfilling new feature requests, the cloud platform team should seek to improve the code by removing duplication and clarifying the code. Running tests between new code creation and refactoring of source code is highly suggested.
- **Deploy the landing zone:** Once the source code is capable of fulfilling the feature request, deploy the modified landing zone to the cloud provider in a controlled testing or sandbox environment.
- **Test the landing zone:** Retesting the landing zone should validate that the new code meets the acceptance criteria for the requested feature. Once all tests pass, the feature is considered complete and the acceptance criteria are considered to be met.

When all value-added features and acceptance criteria pass their associated tests, the landing zone is ready to support the next wave of the cloud adoption plan.

## Simple example of a definition of done

For an initial migration effort, definition of done may be overly simple. The following is an example of one of these overly simple examples.

- The initial landing zone will be used to host 10 workloads for initial learning purposes. These workloads are not critical to the business and have no access to sensitive data. In the future, it's likely these workloads will be released to production but criticality and sensitive is not expected to change. To support these workloads, the cloud adoption team will need the following criteria met:

- Network segmentation to align with proposed network design.
- Access to compute, storage, and networking resources to host the workloads aligned to the digital estate discovery.
- Naming and tagging schema for ease of use.
- This environment should be treated as a perimeter network with access to the public internet.
- During adoption efforts, the cloud adoption team would like temporary access to the environment to change service configurations.
- For awareness only: prior to production release, these workloads will require integration with the corporate identity provider to govern ongoing identity and access for operations management purposes. At which time the cloud adoption team's access should be revoked.

The last point above is not a feature or acceptance criteria. But it is an indicator that additional expansions will be required and should be explored with other teams early.

## Additional examples of a definition of done

The Govern methodology within the Cloud Adoption Framework provides a narrative journey through the natural maturity of a governance team. Embedded in that journey are several examples of "definition of done" and "acceptance criteria", in the form of policy statements.

- [Initial policy statements](../../govern/guides/complex/initial-corporate-policy.md#policy-statements): Example of corporate policies governing and initial definition of done based on early stage adoption requirements.
- [Identity expansion](../../govern/guides/complex/identity-baseline-improvement.md#incremental-improvement-of-the-policy-statements): Example of corporate policies governing *definition of done* to meet requirements to expand identity management for a landing zone.
- [Security expansion](../../govern/guides/complex/security-baseline-improvement.md#incremental-improvement-of-the-policy-statements): Example of corporate policies governing *definition of done* to meet security requirements aligned to the reference cloud adoption plan.
- [Operations expansion](../../govern/guides/complex/resource-consistency-improvement.md#incremental-improvement-of-the-policy-statements): Example of corporate policies governing *definition of done* to meet basic operations management requirements.
- [Cost expansion](../../govern/guides/complex/cost-management-improvement.md#changes-to-the-policy-statements): Example of corporate policies governing *definition of done* to meet cost management requirements.

The above examples are basic samples to help develop a *definition of done* for your landing zones. Additional sample policies are available for each of the [Five Disciplines of Cloud Governance](../../govern/governance-disciplines.md).


# Azure tools and features to support landing zone TDD cycles

![Test-driven development tools in Azure](../../_images/ready/azure-tdd-tools.png)

*Figure 1: Test-driven development tools in Azure.*

Here's a list of Azure tools and features that can be easily integrated into test-driven development for the creation of landing zones. These tools serve a specific purpose, making it easier to develop, test, and deploy your landing zone in alignment with TDD cycles.

- [Azure Resource Manager templates](https://docs.microsoft.com/azure/azure-resource-manager/templates/overview): These templates provide the primary source code for any environment deployed in Azure. Some third-party tools like Terraform generate their own ARM templates, which are then submitted to Azure Resource Manager.
- [Azure Quickstart templates](https://azure.microsoft.com/resources/templates/) provides source code templates to aid in accelerating landing zone and workload deployment.
- [Azure Resource Manager](https://docs.microsoft.com/azure/azure-resource-manager/management/overview): Resource Manager provides a consistent platform for build and deploy functions. This platform can deploy landing zones based on source code definitions.
- [Azure Policy](https://docs.microsoft.com/azure/governance/policy/): When deployments or attempted deployments deviate from governance policies, Azure Policy can provide automated detection, protection, and resolution. But Azure Policy also provides the primary mechanism for testing acceptance criteria in your definition of done. In a TDD cycle, a policy definition can be created to test a single acceptance criteria. Likewise, all acceptance criteria can be added to a policy initiative assigned to the entire subscription. This approach provides a mechanism for red tests before modifying the landing zone. Once the landing zone meets the definition of done, it can be used to enforce the test criteria to avoid code changes that would cause the test to fail in future releases. Azure Policy also includes [built-in policy initiatives](https://docs.microsoft.com//azure/governance/policy/samples/built-in-initiatives), which could be used to test and enforce the full definition of done for a landing zone. Azure Policy includes [built-in policy definitions](https://docs.microsoft.com/azure/governance/policy/samples/built-in-policies) that can meet individual acceptance criteria within the definition of done. Design and review [Azure Policy as Code workflows](https://docs.microsoft.com/en-us/azure/governance/policy/concepts/policy-as-code) as part of your TDD approach.
- [Azure Blueprints](https://docs.microsoft.com/azure/governance/blueprints/): Azure Blueprint groups policies and other deployment tools into a repeatable package that can be assigned to multiple landing zones. Blueprints prove useful when multiple adoption efforts share common definitions of done, which you may want to update over time. It can also help with deployment during subsequent efforts to expand and refactor landing zones. Azure Blueprints provides various [blueprint samples](https://docs.microsoft.com/azure/governance/blueprints/samples/), including policies for testing and templates for deployment. These blueprint samples can accelerate development, deployment, and testing efforts in TDD cycles. There are also 
- [Azure Resource Graph](https://docs.microsoft.com/azure/governance/resource-graph/overview): Resource Graph provides a query language for creating data-driven tests based on information about the assets deployed within a landing zone. Later in the adoption plan, this tool can also define complex tests based on the interactions between workload assets and the underlying cloud environment. Azure Graph includes advanced [query samples](https://docs.microsoft.com/azure/governance/resource-graph/samples/advanced), which can be used to understand how the workloads are deployed within a landing zone for advanced testing scenarios.

Other tools that are helpful, depending on your preferred approach:

- [Cloud Adoption Framework for Azure Terraform landing zones](https://github.com/Azure/caf-terraform-landingzones)
- [Azure Landing Zones using Bicep](https://github.com/Azure/ALZ-Bicep)
- [AzOps: PowerShell module which deploys (Push) Resource Templates & Bicep files at all Azure scope levels and exports (Pull) ARM resource hierarchy](https://github.com/Azure/AzOps)

# Next steps

Review the [security considerations](./security-considerations-overview.md) that will be important in your implementation.

Consider also the [options available](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/implementation-options) to start implementing your landing zone with TDD.
