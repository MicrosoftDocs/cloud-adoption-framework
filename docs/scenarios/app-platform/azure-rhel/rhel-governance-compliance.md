---
title: Governance and compliance for RHEL on Azure
description: Learn about key design considerations and recommendations for governance and compliance in RHEL on Azure infrastructure.
author: 
ms.author: 
ms.date: 
ms.topic: 
ms.custom: 
---

# Overview

Efficient and effective governance and compliance in a cloud environment is an enormous task. In this section the focus will be on considerations and recommendations with respect to Red Hat Enterprise Linux operating system images and instances. When discussing compliance with respect to Red Hat Enterprise Linux deployments in Azure, we are referring to the methods for defining, measuring and reporting on how systems conform to a rule, such as a specification, policy, or standard required by a system’s use within the organization. When discussing governance, we are referring to those structures and processes used to define which specifications are to be met, how they are enforced and remediated.

Organizations, especially those in regulated industries, must often attain an Authority to Operate (ATO) to install and use software in their environments. Part of this process is to evaluate the software against a Security Requirements Guide (SRG), which is a set of technical controls such as those found in the National Institute of Standards and Technology (NIST) Special Publication [800-53 v5.1.1 (2023)](https://csrc.nist.gov/pubs/sp/800/53/r5/upd1/final) as an example. The evaluation is done to determine whether or not the software meets, does not meet, or can be configured to meet each control, or whether or not the control applies to the particular software. An organization’s governance framework will determine which regulations are applicable, and to which systems, within the Azure deployment. Compliance is measured by adherence to the security requirements. Red Hat works with many standards bodies to ensure that the configuration points, the measurements, and remediations are known, verified, and referenceable, for our software. This enables those standards bodies to create benchmarks (checklists) of those evaluations that describe the SRG for their industry. Examples of these benchmarks include:

- PCI-DSS for the payment card industry
- HIPPA for healthcare industry
- DISA-STIG for government and related industries

NIST defines the Security Content and Automation Protocol (SCAP) standard as a means for encapsulating these checklists. SCAP is a suite of specifications for exchanging security automation content (i.e. definitions of checks and automation methods) used to assess configuration compliance and to detect the presence of vulnerable versions of software. Red Hat works with NIST and MITRE to write and publish content used by scanning tools to evaluate and report on a wide variety of compliance standards for the Red Hat Enterprise Linux operating system and other Red Hat software.

Red Hat also contributes to the open-source projects that develop the standard languages and tools to implement the checklists. The Open Security Content and Automation Protocol (OpenSCAP) open-project is the integration point for these efforts with Red Hat software. The OpenSCAP project pulls together standardized components to implement the tools to create, maintain, scan, report and analyze results of compliance definitions written in eXensible Configuration Checklist Description Format (XCCDF) and Open Vulnerability and Assessment Language (OVAL). Both are represented in XML. Think of OVAL as a means to define and measure a logical assertion about the state of an endpoint system, and XCCDF to express, organize, and manage those assertions into security policies. The scanner developed by OpenSCAP is capable of consuming both of these document types.  

Red Hat founded and contributes to the [Compliance as Code open-source project](https://www.redhat.com/en/blog/compliance-code-extending-compliance-automation-process-improvement) to deliver content in SCAP, Ansible and other formats. SCAP is typically used for measurement and reporting while Ansible is used for remediation.

Microsoft Azure has a wide array of compliance offerings to help ensure that your workloads comply with regulatory guidelines. Here is the starting point for learning how to implement specific [compliance](/azure/compliance/) standards.

## Design Considerations

Managing governance for Red Hat Enterprise Linux instances in an Azure landing zone centers around the compliance standards that your organization must adhere to, based on internally mandated and regulatory framework defined controls, as they apply to your RHEL systems.  Considerations with respect to enforcement of standards and the remediation of deviations can affect the tooling and services that you decide to deploy. Compliance measurement, reporting and remediation capabilities are tied closely to these choices. From an implementation perspective, these choices impact most of the areas that we have discussed in this model.

Image and Instance Management - Compliance standards contain factorable lists of security requirements that should allow organizations to integrate content and image management with automation tooling to:

- define OS, application and security configuration content together in a composable pipeline
- continually measure, maintain and deliver images that meet requirements from deployment time
- continually measure, maintain and remediate persistent instances.
Content lifecycle and image build pipelines are ideal points of enforcement.
- **Analysis and reporting** - Cloud platforms provide comprehensive services to enable aggregation of metadata and relevant log data from deployed systems, and to deliver and store the captured data as required for regulatory reporting requirements and relevant auditability
- **Automation first** - Modern automation systems provide the necessary capabilities to ease regulatory compliance and reporting burden while increasing accuracy and visibility. Implement compliance management via Infrastructure-as-Code automation as part of your deployment process. Consider linking scanning with maintenance activity workflows to ensure timely reporting and a “fail fast” methodology to keep your compliance backlog to a minimum. Unify implementation automation and remediation code to ensure consistency.
- **Compliance maintenance** - Compliance standards are updated regularly and have well known delivery mechanisms and content types. Ensure the use of open standards within your compliance management implementation. Design your compliance content streaming and review into your lifecycle for application and image development.

Governance in Azure spans beyond regulatory compliance and extends to cost, resource management, and resource scaling. Consider the below recommendations from RedHat and Microsoft to implement governance comprehensively.

## Design Recommendations

### Compliance

Red Hat provides validated content to meet governance needs. When determining baseline and mandatory compliance requirements, thoroughly review existing sources of compliance content and automation code. Red Hat, Microsoft and our security partners work closely with compliance standards bodies to maintain comprehensive codebases to simplify compliance evaluation. Utilities such as the SCAP workbench included with every Red Hat Enterprise Linux subscription allow organizations to take advantage of existing content and tailor it to meet their specific needs. For each major release of Red Hat Enterprise Linux, Red Hat provides a SCAP Security guide (SSG) that contains the published XCCDF format baselines for well known compliance standards. As an example the SSG for RHEL 9 contains:

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
- [DRAFT] DISA STIG for Red Hat Enterprise Linux 9
- [DRAFT] DISA STIG with GUI for Red Hat Enterprise Linux 9
Red Hat Security Response Team provides a published stream of known CVE information for Red Hat products in OVAL format. Red Hat recommends using these resources as part of your compliance implementation in Azure.
Red Hat Satellite and Image Builder includes integrated SCAP features that allow for:
- defining an image hardened to a selected standard
- defining SCAP policy profile and tailoring on a per workload basis
- scan scheduling for managed systems
- testing content pipelines and delivering versioned content to meet standards

Azure provides tooling for implementing a breadth of regulatory standards. Use [Azure Policy Initiatives](/azure/governance/policy/samples/built-in-initiatives) to enforce a wide variety of initiatives automatically. Consider [Linux security baseline](/azure/governance/policy/samples/guest-configuration-baseline-linux) to implement secure settings for Linux OS guests.

### Cost

Cost governance in the context of cloud computing, particularly with Microsoft Azure, refers to the practice of managing and optimizing the costs associated with using Azure services. Azure provides a suite of tools designed to help users monitor, control, and optimize their expenditure, ensuring that they can scale and adapt their resources efficiently without unnecessary financial overhead. Manage and [track costs](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/azure-best-practices/track-costs) in Azure using Cost Management. Optimize costs by having visibility into your Azure spend. Use [Azure Reservations](https://learn.microsoft.coms/azure/cost-management-billing/reservations/save-compute-costs-reservations) for the most cost savings on compute and [Azure Savings Plans](https://learn.microsoft.com/azure/cost-management-billing/savings-plan/savings-plan-compute-overview). These tools are integral to implementing effective cost governance strategies, helping businesses to maximize their cloud investment while keeping expenses under control.

### Resource Governance

Governance of Azure resource organization is crucial for managing and securing cloud resources efficiently, especially as enterprise environments grow in complexity. Azure introduces several tools and services that support effective governance, ensuring that resources are consistently managed, compliant with policies, and optimized for both performance and cost. Use Azure Policy as the guardrail to keep your environment compliant. Use [Template Specs](https://learn.microsoft.com/azure/azure-resource-manager/templates/template-specs?tabs=azure-powershell) to ensure that deployments meet you identity, security, cost, and other requirements upon deployments. Ensure that you have a [naming standard](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/azure-best-practices/naming-and-tagging) for your Azure resources. This will simplify management and configuration of your environment over time. Organize your resources within landing zones using management groups and policies before deploying workloads into your Azure tenant. Use subscriptions for your workload deployments as a unit of scale (prod, non-prod, etc).

### Enforcement

Ensure that you use [Azure Policy](https://learn.microsoft.com/azure/governance/policy/overview) to enforce governance standards and implement regulatory initiatives. With its compliance dashboard, you are able to view compliance down to a per resource, per policy granularity. You can also perform remediation. Azure Policies are the guardrails for enforcing compliance across security, cost, regulatory compliance, resource consistency and management.

Leverage Red Hat Satellite along with Ansible Automation Platform to develop pipelines for content and image delivery that integrate your workload compliance requirements.

Leverage Red Hat Satellite certified Ansible collections to automate data collection for integration into Azure monitoring for comprehensive compliance analysis.
