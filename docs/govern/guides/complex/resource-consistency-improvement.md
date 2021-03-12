---
title: "Complex enterprise governance: Improve the Resource Consistency discipline"
description: Use the Cloud Adoption Framework for Azure to learn about recovery, sizing, and monitoring controls to improve governance baseline and remediate risks.
author: BrianBlanchard
ms.author: brblanch
ms.date: 10/17/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
ms.custom: internal
---

# Governance guide for complex enterprises: Improve the Resource Consistency discipline

This article advances the narrative by adding resource consistency controls to the governance MVP to support mission-critical applications.

## Advancing the narrative

The cloud adoption teams have met all requirements to move protected data. With those applications come SLA commitments to the business and need for support from IT operations. Right behind the team migrating the two datacenters, multiple application development and BI teams are ready to begin launching new solutions into production. IT operations is new to cloud operations and needs to quickly integrate existing operational processes.

### Changes in the current state

- IT is actively moving production workloads with protected data into Azure. Some low-priority workloads are serving production traffic. More can be cut over as soon as IT operations signs off on readiness to support the workloads.
- The application development teams are ready for production traffic.
- The BI team is ready to integrate predictions and insights into the systems that run operations for the three business units.

### Incrementally improve the future state

- IT operations is new to cloud operations and needs to quickly integrate existing operational processes.
- The changes to current and future state expose new risks that will require new policy statements.

## Changes in tangible risks

**Business interruption:** There is an inherent risk of any new platform causing interruptions to mission-critical business processes. The IT operations team and the teams executing on various cloud adoptions are relatively inexperienced with cloud operations. This increases the risk of interruption and must be remediated and governed.

This business risk can be expanded into several technical risks:

1. Misaligned operational processes might lead to outages that can't be detected or mitigated quickly.
1. External intrusion or denial of service attacks might cause a business interruption.
1. Mission-critical assets might not be properly discovered and therefore not properly operated.
1. Undiscovered or mislabeled assets might not be supported by existing operational management processes.
1. Configuration of deployed assets might not meet performance expectations.
1. Logging might not be properly recorded and centralized to allow for remediation of performance issues.
1. Recovery policies may fail or take longer than expected.
1. Inconsistent deployment processes might result in security gaps that could lead to data leaks or interruptions.
1. Configuration drift or missed patches might result in unintended security gaps that could lead to data leaks or interruptions.
1. Configuration might not enforce the requirements of defined SLAs or committed recovery requirements.
1. Deployed operating systems or applications might not meet OS and application hardening requirements.
1. There is a risk of inconsistency due to multiple teams working in the cloud.

## Incremental improvement of the policy statements

The following changes to policy will help remediate the new risks and guide implementation. The list looks long, but the adoption of these policies may be easier than it would appear.

1. All deployed assets must be categorized by criticality and data classification. Classifications are to be reviewed by the cloud governance team and the application owner before deployment to the cloud.
1. Subnets containing mission-critical applications must be protected by a firewall solution capable of detecting intrusions and responding to attacks.
1. Governance tooling must audit and enforce network configuration requirements defined by the security baseline team.
1. Governance tooling must validate that all assets related to mission-critical applications or protected data are included in monitoring for resource depletion and optimization.
1. Governance tooling must validate that the appropriate level of logging data is being collected for all mission-critical applications or protected data.
1. Governance process must validate that backup, recovery, and SLA adherence are properly implemented for mission-critical applications and protected data.
1. Governance tooling must limit virtual machine deployment to approved images only.
1. Governance tooling must enforce that automatic updates are **prevented** on all deployed assets that support mission-critical applications. Violations must be reviewed with operational management teams and remediated in accordance with operations policies. Assets that are not automatically updated must be included in processes owned by IT operations to quickly and effectively update those servers.
1. Governance tooling must validate tagging related to cost, criticality, SLA, application, and data classification. All values must align to predefined values managed by the cloud governance team.
1. Governance processes must include audits at the point of deployment and at regular cycles to ensure consistency across all assets.
1. Trends and exploits that could affect cloud deployments should be reviewed regularly by the security team to provide updates to Security Baseline tools used in the cloud.
1. Before release into production, all mission-critical applications and protected data must be added to the designated operational monitoring solution. Assets that cannot be discovered by the chosen IT operations tooling cannot be released for production use. Any changes required to make the assets discoverable must be made to the relevant deployment processes to ensure assets will be discoverable in future deployments.
1. When discovered, asset sizing is to be validated by operational management teams to validate that the asset meets performance requirements.
1. Deployment tooling must be approved by the cloud governance team to ensure ongoing governance of deployed assets.
1. Deployment scripts must be maintained in central repository accessible by the cloud governance team for periodic review and auditing.
1. Governance review processes must validate that deployed assets are properly configured in alignment with SLA and recovery requirements.

## Incremental improvement of best practices

This section of the article will improve the governance MVP design to include new Azure policies and an implementation of Azure Cost Management + Billing. Together, these two design changes will fulfill the new corporate policy statements.

Following the experience of this fictional example, it's assumed that the protected data changes have already occurred. Building on that best practice, the following will add operational monitoring requirements, readying a subscription for mission-critical applications.

**Corporate IT subscription:** Add the following to the corporate IT subscription, which acts as a hub.

1. As an external dependency, the cloud operations team will need to define operational monitoring tooling, business continuity and disaster recovery (BCDR) tooling, and automated remediation tooling. The cloud governance team can then support necessary discovery processes.
    1. In this use case, the cloud operations team chose Azure Monitor as the primary tool for monitoring mission-critical applications.
    1. The team also chose Azure Site Recovery as the primary BCDR tooling.
1. Azure Site Recovery implementation.
    1. Define and deploy Azure Site Recovery vault for backup and recovery processes.
    1. Create an Azure resource management template for creation of a vault in each subscription.
1. Azure Monitor implementation.
    1. Once a mission-critical subscription is identified, a Log Analytics workspace can be created.

**Individual cloud adoption subscription:** The following will ensure that each subscription is discoverable by the monitoring solution and ready to be included in BCDR practices.

1. Azure Policy for mission-critical nodes:
    1. Audit and enforce use of standard roles only.
    1. Audit and enforce application of encryption for all storage accounts.
    1. Audit and enforce use of approved network subnet and virtual network per network interface.
    1. Audit and enforce the limitation of user-defined routing tables.
    1. Audit and enforce the deployment of Log Analytics agents for Windows and Linux virtual machines.
1. Azure Blueprints:
    1. Create a blueprint named `mission-critical-workloads-and-protected-data`. This blueprint will apply assets in addition to the protected data blueprint.
    1. Add the new Azure policies to the blueprint.
    1. Apply the blueprint to any subscription that is expected to host a mission-critical application.

## Conclusion

Adding these processes and changes to the governance MVP helps remediate many of the risks associated with resource governance. Together, they add the recovery, sizing, and monitoring controls necessary to empower cloud-aware operations.

## Next steps

As cloud adoption grows and delivers additional business value, the risks and cloud governance needs will also change. For the fictional company in this guide, the next trigger is when the scale of deployment exceeds 1,000 assets to the cloud or monthly spending exceeds $10,000 USD per month. At this point, the cloud governance team adds cost management controls.

> [!div class="nextstepaction"]
> [Improve the Cost Management discipline](./cost-management-improvement.md)
