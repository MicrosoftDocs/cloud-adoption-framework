---
title: 'Standard enterprise governance: Improve the resource consistency discipline'
description: Use the Cloud Adoption Framework for Azure to learn about improving governance baseline and adding recovery, sizing, and monitoring controls to remediate risks.
author: martinekuan
ms.author: martinek
ms.date: 09/05/2019
ms.topic: conceptual
ms.custom: internal, UpdateFrequency2
---

# Standard enterprise governance guide: Improve the resource consistency discipline

This article advances the [governance strategy narrative](./narrative.md) by adding resource consistency controls to support mission-critical applications.

## Advancing the narrative

New customer experiences, new prediction tools, and migrated infrastructure continue to progress. The business is now ready to begin using those assets in a production capacity.

### Changes in the current state

In the previous phase of this narrative, the application development and BI teams were nearly ready to integrate customer and financial data into production workloads. The IT team was in the process of retiring the DR datacenter.

Since then, some things have changed that affects governance:

- IT has retired 100% of the DR datacenter, ahead of schedule. In the process, a set of assets in the production datacenter were identified as cloud migration candidates.
- The application development teams are now ready for production traffic.
- The BI team is ready to feed predictions and insights back into operation systems in the production datacenter.

### Incrementally improve the future state

Before you use Azure deployments in production business processes, cloud operations must mature. In conjunction, more governance changes are required to ensure assets can be operated properly.

The changes to current and future state expose new risks that require new policy statements.

## Changes in tangible risks

**Business interruption:** There's an inherent risk of any new platform causing interruptions to mission-critical business processes. The IT operations team and the teams executing on various cloud adoptions are relatively inexperienced with cloud operations. These issues increase the risk of interruption and must be remediated and governed.

This business risk can be expanded into several technical risks:

1. External intrusion or denial of service attacks might cause a business interruption.
1. Mission-critical assets might not be properly discovered, and therefore might not be properly operated.
1. Undiscovered or mislabeled assets might not be supported by existing operational management processes.
1. The configuration of deployed assets might not meet performance expectations.
1. Logging might not be properly recorded and centralized to allow for remediation of performance issues.
1. Recovery policies might fail or take longer than expected.
1. Inconsistent deployment processes might result in security gaps that could lead to data leaks or interruptions.
1. Configuration drift or missed patches might result in unintended security gaps that could lead to data leaks or interruptions.
1. Configuration might not enforce the requirements of defined SLAs or committed recovery requirements.
1. Deployed operating systems or applications might fail to meet hardening requirements.
1. With so many teams working in the cloud, there's a risk of inconsistency.

## Incremental improvement of the policy statements

The following changes to policy help remediate the new risks and guide implementation. The list looks long, but adopting these policies might be easier than it appears.

1. You must categorize all deployed assets by criticality and data classification. The cloud governance team and the application owner review classifications before deployment to the cloud.
1. Subnets containing mission-critical applications must use a firewall solution capable of detecting intrusions and responding to attacks for protection.
1. Governance tooling must audit and enforce network configuration requirements defined by the security management team.
1. Governance tooling must validate that all assets related to mission-critical applications or protected data are included in monitoring for resource depletion and optimization.
1. Governance tooling must validate that the appropriate level of logging data is being collected for all mission-critical applications or protected data.
1. Governance process must validate that backup, recovery, and SLA adherence are properly implemented for mission-critical applications and protected data.
1. Governance tooling must limit virtual machine deployments to approved images only.
1. Governance tooling must enforce that automatic updates are prevented on all deployed assets that support mission-critical applications. Violations must be reviewed with operational management teams and remediated in accordance with operations policies. Assets that aren't automatically updated must be included in processes owned by IT operations.
1. Governance tooling must validate tagging related to cost, criticality, SLA, application, and data classification. All values must align to predefined values managed by the governance team.
1. Governance processes must include audits at the point of deployment and at regular cycles to ensure consistency across all assets.
1. The security team should review trends and exploits that could affect cloud deployments and provide updates to security management tooling used in the cloud.
1. Before release into production, all mission-critical applications and protected data must be added to the designated operational monitoring solution. If the chosen IT operations tooling can't discover assets, the assets can't be released for production use. Any changes required to make the assets discoverable must be made to the relevant deployment processes to ensure assets are discoverable in future deployments.
1. When discovered, operational management teams size assets to ensure that the assets meet performance requirements.
1. The cloud governance team must approve deployment tooling to ensure ongoing governance of deployed assets.
1. Deployment scripts must be maintained in a central repository accessible by the cloud governance team for periodic review and auditing.
1. Governance review processes must validate that deployed assets are properly configured in alignment with SLA and recovery requirements.

## Incremental improvement of governance practices

The following changes to the governance MVP design include new Azure policies and an implementation of Azure Cost Management and Billing. Together, these two design changes fulfill the new corporate policy statements.

1. The cloud operations team defines operational monitoring tooling and automated remediation tooling. The cloud governance team supports those discovery processes. In this use case, the cloud operations team chose Azure Monitor as the primary tool for monitoring mission-critical applications.
2. Create a repository in Azure DevOps to store and version all relevant Resource Manager templates and scripted configurations.
3. Implement Azure Recovery Services vault:
    1. Define and deploy an Azure Recovery Services vault for backup and recovery processes.
    2. Create a Resource Manager template for creation of a vault in each subscription.
4. Update Azure Policy for all subscriptions:
    1. Audit and enforce criticality and data classification across all subscriptions to identify any subscriptions with mission-critical assets.
    2. Audit and enforce the use of approved images only.
5. Implement Azure Monitor:
    1. After a mission-critical workload is identified, create an Azure Monitor Log Analytics workspace.
    2. During deployment testing, the cloud operations team deploys the necessary agents and tests discovery.
6. Update Azure Policy for all subscriptions that contain mission-critical applications.
    1. Audit and enforce the application of an NSG to all NICs and subnets. Networking and IT security define the NSG.
    2. Audit and enforce the use of approved network subnets and virtual networks for each network interface.
    3. Audit and enforce the limitation of user-defined routing tables.
    4. Audit and enforce deployment of Azure Monitor agents for all virtual machines.
    5. Audit and enforce that Azure Recovery Services vaults exist in the subscription.
7. Configure Azure Firewall:
    1. Identify a configuration of Azure Firewall that meets security requirements. Alternatively, identify a third-party appliance that is compatible with Azure.
    1. Create a Resource Manager template to deploy the firewall with required configurations.
8. Configure Azure blueprint:
    1. Create a new Azure blueprint named `protected-data`.
    2. Add the firewall and Azure Recovery Services vault templates to the blueprint.
    3. Add the new policies for protected data subscriptions.
    4. Publish the blueprint to any management group that hosts mission-critical applications.
    5. Apply the new blueprint to each affected subscription and existing blueprints.

## Conclusion

These extra processes and changes to the governance MVP help remediate many of the risks associated with resource governance. Together they add recovery, sizing, and monitoring controls that empower cloud-aware operations.

## Next steps

As cloud adoption continues and delivers more business value, risks and cloud governance needs also change. For the fictional company in this guide, the next trigger is when the scale of deployment exceeds 100 assets to the cloud or monthly spending exceeds $1,000 per month. At this point, the cloud governance team adds cost management controls.

> [!div class="nextstepaction"]
> [Improve the Cost Management discipline](./cost-management-improvement.md)
