---
title: Governance and compliance for Red Hat Enterprise Linux on Azure
description: Learn about key design considerations and recommendations for governance and compliance in RHEL on Azure infrastructure.
author: 
ms.author: 
ms.date: 7/20/2024
ms.topic: conceptual
ms.custom: 
---

# Governance and compliance for Red Hat Enterprise Linux on Azure

Efficient and effective governance and compliance in a cloud environment is an enormous task. This article describes considerations and recommendations for Red Hat Enterprise Linux (RHEL) operating system images and instances. Compliance for RHEL deployments in Azure refers to the methods that you can use to define, measure, and report on how systems conform to a rule, such as a specification, policy, or standard. Your organization likely has requirements for a system's use. Governance refers to the structures and processes that you use to define the specifications that you need to meet, how you enforce those specifications, and how you remediate misalignment.

Organizations, especially those in regulated industries, must often attain an Authority to Operate (ATO) to install and use software in their environments. Part of this process is to evaluate the software against a Security Requirements Guide (SRG), which is a set of technical controls such as those found in the National Institute of Standards and Technology (NIST) Special Publication [800-53 v5.1.1 (2023)](https://csrc.nist.gov/pubs/sp/800/53/r5/upd1/final) as an example. The evaluation is done to determine whether or not the software meets, does not meet, or can be configured to meet each control, or whether or not the control applies to the particular software. An organization’s governance framework will determine which regulations are applicable, and to which systems, within the Azure deployment. Compliance is measured by adherence to the security requirements. Red Hat works with many standards bodies to ensure that the configuration points, the measurements, and remediations are known, verified, and referenceable, for our software. This enables those standards bodies to create benchmarks (checklists) of those evaluations that describe the SRG for their industry. Examples of these benchmarks include:

- PCI-DSS for the payment card industry
- HIPPA for healthcare industry
- DISA-STIG for government and related industries

NIST defines the Security Content and Automation Protocol (SCAP) standard as a means for encapsulating these checklists. SCAP is a suite of specifications for exchanging security automation content (i.e. definitions of checks and automation methods) used to assess configuration compliance and to detect the presence of vulnerable versions of software. Red Hat works with NIST and MITRE to write and publish content used by scanning tools to evaluate and report on a wide variety of compliance standards for the RHEL operating system and other Red Hat software.

Red Hat also contributes to the open-source projects that develop the standard languages and tools to implement the checklists. The Open Security Content and Automation Protocol (OpenSCAP) open-project is the integration point for these efforts with Red Hat software. The OpenSCAP project pulls together standardized components to implement the tools to create, maintain, scan, report and analyze results of compliance definitions written in eXensible Configuration Checklist Description Format (XCCDF) and Open Vulnerability and Assessment Language (OVAL). Both are represented in XML. Think of OVAL as a means to define and measure a logical assertion about the state of an endpoint system, and XCCDF to express, organize, and manage those assertions into security policies. The scanner developed by OpenSCAP is capable of consuming both of these document types.  

Red Hat founded and contributes to the [Compliance as Code open-source project](https://www.redhat.com/en/blog/compliance-code-extending-compliance-automation-process-improvement) to deliver content in SCAP, Ansible, and other formats. SCAP is typically used for measurement and reporting while Ansible is used for remediation.

Microsoft Azure has several compliance offerings to help ensure that your workloads comply with regulatory guidelines. First, learn how to implement specific [compliance](/azure/compliance/) standards.

## Design considerations

When you manage governance for RHEL instances in an Azure landing zone, consider the compliance standards that your organization must adhere to. Configure your governance based on internally mandated and regulatory framework defined controls, as they apply to your RHEL systems. Determine your tooling and services based on how you enforce standards and remediate deviations. Consider how you measure compliance and consider your reporting and remediation capabilities. From an implementation perspective, these choices impact most of the areas that we have discussed in this model.

Compliance standards contain factorable lists of security requirements so that your organization can integrate content and image management with automation tooling to:

- Define OS, application, and security configuration content together in a composable pipeline.

- Continually measure, maintain, and deliver images that meet requirements from deployment time.
- Continually measure, maintain, and remediate persistent instances.

Content lifecycle and image build pipelines are ideal points of enforcement.

- **Analysis and reporting**: Cloud platforms provide comprehensive services that you can use to aggregate metadata and log data from deployed systems. You can also deliver and store the captured data for regulatory reporting requirements and audits.

- **Automation first**: Modern automation systems can simplify regulatory compliance and reporting and increase accuracy and visibility. Implement compliance management via infrastructure as code automation as part of your deployment process. Consider combining scanning and maintenance activity workflows to ensure timely reporting and a *fail fast* methodology, which keeps your compliance backlog to a minimum. To ensure consistency, unify implementation automation and remediation code .
- **Compliance maintenance**: Compliance standards are updated regularly and have well-known delivery mechanisms and content types. Ensure that you use open standards when you implement compliance management. Design your compliance content streaming and review into your lifecycle for application and image development.

## Design recommendations

Governance in Azure includes regulatory compliance and also cost, resource management, and resource scaling. Consider these Red Hat and Microsoft recommendations to implement governance comprehensively.

### Compliance

Red Hat provides validated content to meet governance needs. When determining baseline and mandatory compliance requirements, thoroughly review existing sources of compliance content and automation code. Red Hat, Microsoft and our security partners work closely with compliance standards bodies to maintain comprehensive codebases to simplify compliance evaluation. Utilities such as the SCAP workbench included with every RHEL subscription allow organizations to take advantage of existing content and tailor it to meet their specific needs. For each major release of RHEL, Red Hat provides a SCAP Security guide (SSG) that contains the published XCCDF format baselines for well known compliance standards. As an example the SSG for RHEL 9 contains:

- ANSSI-BP-028 (enhanced, high, intermediate, minimal)

- CCN Red Hat Enterprise Linux 9 - Advanced, Intermediate, Basic
- CIS Red Hat Enterprise Linux 9 Benchmark for Level 2 - Server
- CIS Red Hat Enterprise Linux 9 Benchmark for Level 1 - Server
- CIS Red Hat Enterprise Linux 9 Benchmark for Level 1 - Workstation
- CIS Red Hat Enterprise Linux 9 Benchmark for Level 2 - Workstation
- [DRAFT] Unclassified Information in Non-federal Information Systems and Organizations (NIST 800-171)
- Australian Cyber Security Centre (ACSC) Essential Eight
- Australian Cyber Security Centre (ACSC) ISM Official
- Health Insurance Portability and Accountability Act (HIPAA)
- Protection Profile for General Purpose Operating Systems
- PCI-DSS v3.2.1 Control Baseline for Red Hat Enterprise Linux 9
- PCI-DSS v4.0 Control Baseline for Red Hat Enterprise Linux 7, Red Hat Enterprise Linux 8 (RHEL-1808), Red Hat Enterprise Linux 9
- [DRAFT] DISA STIG for Red Hat Enterprise Linux 9
- [DRAFT] DISA STIG with GUI for Red Hat Enterprise Linux 9

The Red Hat Security Response Team provides a published stream of known Common Vulnerabilities and Exposures information for Red Hat products in OVAL format. Red Hat recommends that you use these resources as part of your compliance implementation in Azure.
Red Hat Satellite and Image Builder includes integrated SCAP features that you can use to:
- Define an image that's hardened to a selected standard.

- Define a SCAP policy profile and tailor it to each workload.
- Scan scheduling for managed systems.
- Test content pipelines and deliver versioned content to meet standards.

Azure provides tooling that you can use to implement several regulatory standards. To enforce a wide variety of initiatives automatically, use [Azure Policy initiatives](/azure/governance/policy/samples/built-in-initiatives). To implement secure settings for Linux OS guests, consider [Linux security baseline](/azure/governance/policy/samples/guest-configuration-baseline-linux).

### Cost

 In the context of cloud computing, particularly Microsoft Azure, cost governance refers to the practice of managing and optimizing the costs that are associated with Azure services. Azure provides a suite of tools to help users monitor, control, and optimize their expenditure. Use these tools to ensure that you can scale and adapt your resources efficiently without unnecessary financial overhead.

Use Microsoft Cost Management to manage and [track costs](/azure/cloud-adoption-framework/ready/azure-best-practices/track-costs) in Azure. Optimize costs by having visibility into your Azure spend. To help control costs for compute resources, use [Azure Reservations](/azure/cost-management-billing/reservations/save-compute-costs-reservations) and [Azure Savings Plans](/azure/cost-management-billing/savings-plan/savings-plan-compute-overview). Use these tools to implement effective cost governance strategies and help your business maximize your cloud investment while keeping expenses under control.

### Resource governance

Govern your Azure resource organization to help manage and secure cloud resources efficiently, especially as the complexity of your enterprise environment increases. Azure has several tools and services that support effective governance and ensure that resource are consistently managed, compliant with policies, and optimized for both performance and cost.

Use [Azure Policy] (/azure/governance/policy/overview) as the guardrail to keep your environment compliant. Use [template specs](/azure-resource-manager/templates/template-specs) to ensure that deployments meet your identity, security, cost, and other requirements by default. Ensure that you have a [naming standard](/azure/cloud-adoption-framework/ready/azure-best-practices/naming-and-tagging) for your Azure resources. A naming standard makes it easier for you to manage and configure your environment over time. Use management groups and policies to organize your resources within landing zones before you deploy workloads into your Azure tenant. 

For comprehensive recommendations about subscription design, see [Cloud Adoption Framework subscription guidance](/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org-subscriptions#organization-and-governance-design-considerations).

### Enforcement

Use [Azure Policy](/azure/governance/policy/overview) to enforce governance standards and implement regulatory initiatives. You can use the compliance dashboard to view compliance for each resource or policy. You can also perform remediation. Azure policies are guardrails that help enforce compliance across security, cost, regulatory compliance, resources, and management.

Leverage Red Hat Satellite along with Ansible Automation Platform to develop pipelines for content and image delivery that integrate your workload compliance requirements.

Leverage Red Hat Satellite certified Ansible collections to automate data collection for integration into Azure monitoring for comprehensive compliance analysis.
