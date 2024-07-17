---
title: Governance and compliance for Red Hat Enterprise Linux on Azure
description: Learn about key design considerations and recommendations for governance and compliance in Red Hat Enterprise Linux on Azure infrastructure.
author: terrymandin
ms.author: temandin 
ms.date: 7/20/2024
ms.topic: conceptual
---

# Governance and compliance for Red Hat Enterprise Linux on Azure

This article describes considerations and recommendations for Red Hat Enterprise Linux (RHEL) operating system images and instances. Efficient and effective governance and compliance in a cloud environment requires diligent effort. 

Compliance for RHEL deployments in Azure refers to the methods that you use to define, measure, and report on how systems conform to a rule, such as a specification, policy, or standard. Your organization likely has usage requirements for your system. Governance refers to the structures and processes that you use to define the specifications that you need to meet. Governance also includes how you enforce those specifications and how you remediate misalignment.

## Overview

Organizations, especially in regulated industries, often need an authority to operate (ATO) to install and use software in their environments. This process includes evaluating the software against a security requirements guide (SRG), which is a set of technical controls. An example of such controls is the National Institute of Standards and Technology (NIST) [security and privacy controls for information systems and organizations](https://csrc.nist.gov/pubs/sp/800/53/r5/upd1/final).

This evaluation determines whether the software meets each control or whether you can configure the software to meet each control. The evaluation also determines whether the control applies to a particular software. Your organization's governance framework determines which regulations apply within the Azure deployment and to which systems the regulations apply. Adherence to the security requirements determines the level of compliance.

Red Hat works with many standards bodies to ensure that the configuration points, measurements, and remediations are known, verified, and referenceable for Azure software. The standards bodies can create benchmarks or checklists of the evaluations that describe the SRG for their industry. Examples of these benchmarks include:

- Payment Card Industry Data Security Standard (PCI DSS) for the payment card industry.

- Health Insurance Portability and Accountability Act (HIPPA) for the healthcare industry.
- Defense Information Systems Agency (DISA) and Security Technical Implementation Guide (STIG) for government and related industries.

The Security Content and Automation Protocol (SCAP) provides these checklists. SCAP is a suite of specifications, such as definitions of checks and automation methods, for exchanging security automation content. You can use this content to assess configuration compliance and to detect the presence of vulnerable versions of software. Red Hat works with NIST and the MITRE corporation to write and publish content. Scanning tools use the content to evaluate and report on a wide variety of compliance standards for the RHEL operating system and other Red Hat software.

Red Hat also contributes to the open-source projects that develop the standard languages and tools to implement the checklists. The OpenSCAP open project provides an integration point for these efforts with Red Hat software. The OpenSCAP project combines standardized components to create tools that you can use to create, maintain, scan, report, and analyze the results of compliance definitions.

The compliance definitions are written in Open Vulnerability and Assessment Language (OVAL) and Extensible Configuration Checklist Description Format (XCCDF). Both formats are represented in XML. Think of OVAL as a means to define and measure a logical assertion about the state of an endpoint system. Think of XCCDF as a means to express, organize, and manage those assertions into security policies. The OpenSCAP scanner can consume both of these document types.  

The [Compliance as Code open-source project](https://www.redhat.com/blog/compliance-code-extending-compliance-automation-process-improvement) delivers content in SCAP, Ansible, and other formats. You typically use SCAP for measuring and reporting and use Ansible for remediation.

Microsoft Azure has several compliance offerings to help ensure that your workloads comply with regulatory guidelines. First, you must implement specific [compliance](/azure/compliance/) standards.

## Design considerations

When you manage governance for RHEL instances in an Azure landing zone, consider the compliance standards that your organization must adhere to. Configure your governance based on internally mandated and regulatory framework-defined controls as they apply to your RHEL systems. Choose your tooling and services based on how you enforce standards and remediate deviations. Consider how you measure compliance, and consider your reporting and remediation capabilities. From an implementation perspective, these choices impact many of the compliance areas that are described in the preceding section.

Compliance standards contain factorable lists of security requirements that you can use to integrate content and image management with automation tooling so that you can:

- Define operating system, application, and security configuration content together in a composable pipeline.

- Continually measure, maintain, and deliver images that meet requirements from the deployment time.
- Continually measure, maintain, and remediate persistent instances.

Content lifecycle and image build pipelines are ideal points of enforcement. Consider the following pipelines:

- **Analysis and reporting**: Cloud platforms provide comprehensive services that you can use to aggregate metadata and log data from deployed systems. You can also deliver and store the captured data for regulatory reporting requirements and audits.

- **Automation first**: Modern automation systems can simplify regulatory compliance and reporting and increase accuracy and visibility. Implement compliance management via infrastructure as code automation as part of your deployment process. Consider combining scanning and maintenance activity workflows to ensure timely reporting and a *fail-fast* methodology, which keeps your compliance backlog to a minimum. To ensure consistency, unify implementation automation code and remediation code .
- **Compliance maintenance**: Compliance standards are updated regularly and have well-known delivery mechanisms and content types. Ensure that you use open standards when you implement compliance management. Design your compliance content streaming and review into your lifecycle for application and image development.

## Design recommendations

Governance in Azure includes regulatory compliance and also cost, resource management, and resource scaling. Consider these Red Hat and Microsoft recommendations to comprehensively implement governance.

### Compliance

Red Hat provides validated content to meet governance needs. When you determine baseline and mandatory compliance requirements, thoroughly review existing sources of compliance content and automation code. To maintain comprehensive codebases, Red Hat, Microsoft, and Microsoft security partners work closely with compliance standards bodies. Comprehensive codebases simplify compliance evaluation. You can use utilities, such as the SCAP workbench that's included with every RHEL subscription, to take advantage of existing content and tailor it to meet your specific needs. For each major release of RHEL, Red Hat provides a SCAP Security guide (SSG) that contains the published XCCDF baselines for well-known compliance standards.

For example, the SSG for RHEL 9 contains:

- ANSSI-BP-028 - Enhanced, High, Intermediate, Minimal

- CCN RHEL 9 - Advanced, Intermediate, Basic
- Center for Internet Security (CIS) RHEL 9 Benchmark for Level 2 - Server
- CIS RHEL 9 Benchmark for Level 1 - Server
- CIS RHEL 9 Benchmark for Level 1 - Workstation
- CIS RHEL 9 Benchmark for Level 2 - Workstation
- [DRAFT] Controlled Unclassified Information in non-federal information systems and organizations (NIST 800-171)
- Australian Cyber Security Centre (ACSC) Essential Eight
- ACSC Information Security Manual (ISM) Official
- HIPAA
- Protection Profile for General Purpose Operating Systems
- PCI DSS v3.2.1 Control Baseline for RHEL 9
- PCI DSS v4.0 Control Baseline for RHEL 7, RHEL 8 (RHEL-1808), and RHEL 9
- [DRAFT] DISA STIG for RHEL 9
- [DRAFT] DISA STIG with graphical user interface (GUI) for RHEL 9

The Red Hat Product Security Incident Response Team provides a published stream of known Common Vulnerabilities and Exposures (CVE) information for Red Hat products in OVAL format. Red Hat recommends that you use these resources as part of your compliance implementation in Azure.

Red Hat Satellite and RHEL image builder includes integrated SCAP features that you can use to:
- Define an image that's hardened to a selected standard.

- Define a SCAP policy profile and tailor it to each workload.
- Scan scheduling for managed systems.
- Test content pipelines, and deliver versioned content to meet standards.

Azure provides tooling that you can use to implement several regulatory standards. To enforce a wide variety of initiatives automatically, use [Azure Policy initiatives](/azure/governance/policy/samples/built-in-initiatives). To implement secure settings for Linux operating system guests, consider [Linux security baseline](/azure/governance/policy/samples/guest-configuration-baseline-linux).

### Cost

In the context of cloud computing, particularly Microsoft Azure, cost governance refers to the practice of managing and optimizing the costs that are associated with Azure services. Azure provides a suite of tools to help you monitor, control, and optimize your expenditure. Use these tools to ensure that you can scale and adapt your resources efficiently without unnecessary financial overhead.

Use Microsoft Cost Management to manage and [track costs](/azure/cloud-adoption-framework/ready/azure-best-practices/track-costs) in Azure. Get visibility into your Azure spend to optimize costs. To help control costs for compute resources, use [Azure reservations](/azure/cost-management-billing/reservations/save-compute-costs-reservations) and [Azure savings plans](/azure/cost-management-billing/savings-plan/savings-plan-compute-overview). Use these tools to implement effective cost governance strategies and help your business maximize your cloud investment while keeping expenses under control.

### Resource governance

Govern your Azure resource organization to help manage and secure cloud resources efficiently, especially as the complexity of your enterprise environment grows. Azure has several tools and services that support effective governance and ensure that resources are consistently managed, compliant with policies, and optimized for both performance and cost.

Use [Azure Policy](/azure/governance/policy/overview) as a guardrail to keep your environment compliant. Use [template specs](/azure-resource-manager/templates/template-specs) to ensure that deployments meet your identity, security, cost, and other requirements by default. Ensure that you have a [naming standard](/azure/cloud-adoption-framework/ready/azure-best-practices/naming-and-tagging) for your Azure resources. A naming standard makes it easier for you to manage and configure your environment over time. Use management groups and policies to organize your resources within landing zones before you deploy workloads into your Azure tenant. 

For comprehensive recommendations about subscription design, see [Cloud Adoption Framework subscription guidance](/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org-subscriptions#organization-and-governance-design-considerations).

### Enforcement

Use [Azure Policy](/azure/governance/policy/overview) to enforce governance standards and implement regulatory initiatives. Azure policies are guardrails that help enforce compliance across security, cost, regulatory compliance, resources, and management. You can use the compliance dashboard to view compliance for each resource or policy. You can also use Azure Policy to perform remediation.

You can use Red Hat Satellite with Ansible Automation Platform to develop pipelines for content and image delivery that integrate your workload compliance requirements.

To get a comprehensive compliance analysis, use Red Hat Satellite-certified Ansible collections to automate data collection for integration into Azure monitoring.

## Next steps