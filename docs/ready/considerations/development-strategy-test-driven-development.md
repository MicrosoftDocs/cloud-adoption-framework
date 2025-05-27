---
title: Test-driven development for Azure Landing Zones
description: Test-driven development for Azure Landing Zones.
author: elbatane
ms.author: elbatane
ms.date: 06/28/2022
ms.topic: conceptual
ms.custom: internal
---

# Test-driven development for Azure landing zones

Test-driven development (TDD) is a software development and DevOps process that improves the quality of new features and improvements in code-based solutions. TDD creates unit test cases before developing the actual code, and tests the code against the test cases. This approach is opposed to developing code first and creating test cases later.

A [landing zone](../landing-zone/index.md) is an environment for hosting workloads that is preprovisioned through code. Landing zones include foundational capabilities that use a defined set of cloud services and best practices. This article describes an approach that uses TDD to deploy successful landing zones while meeting quality, security, operations, and governance requirements.

Cloud infrastructure is the output of code execution. Well-structured, tested, and verified code produces a viable landing zone. Cloud-based infrastructure and its underlying source code can use this approach to ensure that landing zones are high quality and meet core requirements.

Use this approach to meet simple feature requests during early development. Later in the cloud adoption lifecycle, you can use this process to meet security, operations, governance, or compliance requirements. The process is especially useful for developing and refactoring landing zones in a parallel development effort.

## Test-driven development cycle

The following diagram shows the test-driven development cycle for Azure landing zones:

![Diagram of the test-driven development process for Azure landing zones.](../../_images/ready/test-driven-development-process.png)

1. **Create a test.** Define a test to validate that acceptance criteria for a feature has been met. Automate the test as you develop, to reduce the amount of manual test effort, especially for enterprise-scale deployments.

1. **Test the landing zone.** Run the new test and any existing tests. If the required feature isn't included in the cloud provider's offerings and hasn't been provided by prior development efforts, the test should fail. Running existing tests helps validate that your new feature or test doesn't reduce the reliability of existing landing zone features.

1. **Expand and refactor the landing zone.** Add or modify source code to fulfill the requested value-add feature and improve the general quality of the code base.

   To meet the TDD criteria, the cloud platform team would add code only to meet the requested feature. However, code quality and maintenance are shared efforts. As they fulfill new feature requests, the cloud platform team should try to improve code by removing duplication and clarifying the code. Running tests between new code creation and refactoring of source code is highly recommended.

1. **Deploy the landing zone.** Once the source code fulfills the feature request, deploy the modified landing zone to the cloud provider in a controlled testing or sandbox environment.

1. **Test the landing zone.** Retest the landing zone to validate that the new code meets the acceptance criteria for the requested feature. Once all tests pass, the feature is considered complete and the acceptance criteria are considered met.

The TDD cycle repeats the preceding basic steps until they meet the full *definition of done*. When all value-added features and acceptance criteria pass their associated tests, the landing zone is ready to support the next wave of the cloud adoption plan.

The cycle that makes TDD effective is often referred to as a *red/green test*. In this approach, the cloud platform team starts with a failed test, or red test, based on the definition of done and the defined acceptance criteria. For each feature or acceptance criteria, the cloud platform team completes development tasks until the test passes, or has a green test.

The goal of TDD is to address better design, not to create a suite of tests. The tests are a valuable artifact for completing the process.

## Definition of done

Success can be a subjective measure that provides a cloud platform team little actionable information during landing zone development or refactoring. Lack of clarity can lead to missed expectations and vulnerabilities in a cloud environment. Before the cloud platform team refactors or expands any landing zones, they should seek clarity regarding the *definition of done* (DoD) for each landing zone.

DoD is a simple agreement between the cloud platform team and other affected teams that defines the expected value-added features to include in the landing zone development effort. The DoD is often a checklist that's aligned with the short-term cloud adoption plan.

As teams adopt more workloads and cloud features, the DoD and the acceptance criteria become more complex. In mature processes, the expected features each have their own acceptance criteria to provide more clarity. When the value-added features all meet the acceptance criteria, the landing zone is sufficiently configured to enable the success of the current adoption wave or release.

### Simple DoD example

For an initial migration effort, the DoD might be overly simple. The following example is a simple DoD:

The initial landing zone will host 10 workloads for initial learning purposes. These workloads aren't critical to the business and have no access to sensitive data. In the future, these workloads will probably release to production, but the criticality and sensitivity aren't expected to change.

To support these workloads, the cloud adoption team needs to meet the following criteria:

- Network segmentation to align with proposed network design. This environment should be a perimeter network with access to the public internet.
- Access to compute, storage, and networking resources to host the workloads aligned to the digital estate discovery.
- Naming and tagging schema for ease of use.
- During adoption, temporary access for the cloud adoption team to change service configurations.
- Prior to production release, integration with the corporate identity provider to govern ongoing identity and access for operations management. At that time, the cloud adoption team's access should be revoked.

The last point isn't a feature or acceptance criterion, but an indicator that more expansions will be required and should be explored with other teams early.

### More complex DoD examples

The Govern methodology within the Cloud Adoption Framework provides a narrative journey through the natural maturity of a governance team. Embedded in that journey are several examples of DoD and acceptance criteria, in the form of policy statements.

- [Initial policy statements](../../govern/guides/complex/initial-corporate-policy.md#policy-statements). Example of initial DoD based on corporate policies governing early stage adoption requirements.

- [Incremental improvements to expand identity management](../../govern/guides/complex/identity-baseline-improvement.md#incremental-improvement-of-the-policy-statements). Example of corporate policies governing DoD to meet requirements to expand identity management for a landing zone.

- [Incremental improvements to expand security requirements](../../govern/guides/complex/security-baseline-improvement.md#incremental-improvement-of-the-policy-statements). Example of corporate policies governing DoD to meet security requirements aligned to the reference cloud adoption plan.

- [Incremental improvements to expand operations management](../../govern/guides/complex/resource-consistency-improvement.md#incremental-improvement-of-the-policy-statements). Example of corporate policies governing DoD to meet basic operations management requirements.

- [Incremental improvements to expand cost management](../../govern/guides/complex/cost-management-improvement.md#changes-to-the-policy-statements). Example of corporate policies governing DoD to meet cost management requirements.

The preceding examples are basic samples to help you develop a DoD for your landing zones.

## Azure tools and features to support landing zone TDD

The following diagram shows available test-driven development tools in Azure:

![Diagram that shows available test-driven development tools in Azure.](../../_images/ready/azure-tdd-tools.png)

You can easily integrate these Azure tools and features into TDD for landing zone creation. The tools serve specific purposes, making it easier to develop, test, and deploy landing zones in alignment with TDD cycles.

- [Azure Resource Manager](/azure/azure-resource-manager/management/overview) provides a consistent platform for build and deployment processes. The Resource Manager platform can deploy landing zones based on source code definitions.

- [Azure Resource Manager (ARM) templates](/azure/azure-resource-manager/templates/overview) provide primary source code for environments deployed in Azure. Some third-party tools like Terraform provide their own ARM templates to submit to Azure Resource Manager.

- [Azure Quickstart Templates](https://azure.microsoft.com/resources/templates) provide source code templates that help accelerate landing zone and workload deployment.

- [Azure Policy](/azure/governance/policy) provides the primary mechanism for testing acceptance criteria in your DoD. Azure Policy can also provide automated detection, protection, and resolution when deployments deviate from governance policies.

  In a TDD cycle, you can create a policy definition to test a single acceptance criteria. Azure Policy includes [built-in policy definitions](/azure/governance/policy/samples/built-in-policies) that can meet individual acceptance criteria within a DoD. This approach provides a mechanism for red tests before you modify the landing zone.

  Azure Policy also includes [built-in policy initiatives](/azure/governance/policy/samples/built-in-initiatives) that you can use to test and enforce the full DoD for a landing zone. You can add all acceptance criteria to a policy initiative assigned to the entire subscription. Once the landing zone meets the DoD, Azure Policy can enforce the test criteria to avoid code changes that would cause the test to fail in future releases.

  Design and review [Azure Policy as Code workflows](/azure/governance/policy/concepts/policy-as-code) as part of your TDD approach.

- [Azure Resource Graph](/azure/governance/resource-graph/overview) provides a query language for creating data-driven tests based on information about the assets deployed in a landing zone. Later in the adoption plan, this tool can also define complex tests based on the interactions between workload assets and the underlying cloud environment.

  Resource Graph includes advanced [query samples](/azure/governance/resource-graph/samples/advanced), which you can use to understand how workloads are deployed within a landing zone for advanced testing scenarios.

Depending on your preferred approach, you can also use the following tools:

- [Deploy landing zones using Terraform](../landing-zone/deploy-landing-zones-with-terraform.md).
- [Deploy landing zones using Bicep](https://github.com/Azure/ALZ-Bicep).
- [Manage landing zones using AzOps](https://github.com/Azure/AzOps), a PowerShell module that pushes resource templates and Bicep files at all Azure scope levels, and pulls and exports Azure resource hierarchies.

## Next steps

- [Security considerations for DevOps platforms](./security-considerations-overview.md)
- [Landing zone implementation options](../landing-zone/implementation-options.md)
