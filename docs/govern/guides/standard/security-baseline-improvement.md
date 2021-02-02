---
title: "Standard enterprise governance: Improve the Security Baseline discipline"
description: Use the Azure Cloud Adoption Framework to learn about adding security controls that support moving protected data to the cloud.
author: BrianBlanchard
ms.author: brblanch
ms.date: 09/17/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
ms.custom: internal
---

# Standard enterprise governance guide: Improve the Security Baseline discipline

This article advances the [governance strategy narrative](./narrative.md) by adding security controls that support moving protected data to the cloud.

## Advancing the narrative

IT and business leadership are happy with results from early experimentation by the IT, application development, and BI teams. To realize tangible business values from these experiments, those teams must be allowed to integrate protected data into solutions. This integration triggers changes to corporate policy. It also requires incremental improvement of the cloud governance implementations before protected data can land in the cloud.

### Changes to the cloud governance team

Given the effect of the changing narrative and support provided so far, the cloud governance team is now viewed differently. The two system administrators who started the team are now viewed as experienced cloud architects. As this narrative develops, the perception of them will shift from that of cloud custodians to more of a cloud guardian role.

The difference is subtle, but it's an important distinction when you're creating a governance-focused IT culture. A cloud custodian cleans up the messes made by innovative cloud architects. The two roles have natural friction and opposing goals. On the other hand, a cloud guardian helps keep the cloud safe so other cloud architects can move more quickly, with fewer messes. And a cloud guardian is involved in creating templates that accelerate deployment and adoption. So they're innovation accelerators in addition to being defenders of the Five Disciplines of Cloud Governance.

### Changes in the current state

At the start of this narrative, the application development teams were still working in a dev/test capacity, and the BI team was still in the experimental phase. IT operated two hosted infrastructure environments, referred to as `Prod` and `DR`.

Since then, some things have changed that will affect governance:

- The application development team has implemented a CI/CD pipeline to deploy a cloud-native application with an improved user experience. That application doesn't yet interact with protected data, so it isn't production ready.
- The business intelligence team within IT actively curates data in the cloud from logistics, inventory, and third-party sources. This data is used to drive new predictions, which could shape business processes. Those predictions and insights aren't actionable until customer and financial data can be integrated into the data platform.
- The IT team is progressing on the CIO and CFO plans to retire the DR datacenter. More than 1,000 of the 2,000 assets in the DR datacenter have been retired or migrated.
- The loosely defined policies for personal data and financial data have been modernized. The new corporate policies are contingent on the implementation of related security and governance policies. Teams are still stalled.

### Incrementally improve the future state

Early experiments by the application development and BI teams show potential improvements in customer experiences and data-driven decisions. Both teams want to expand adoption of the cloud over the next 18 months by deploying those solutions to production.

During the remaining six months, the cloud governance team will implement security and governance requirements to allow the cloud adoption teams to migrate the protected data in those datacenters.

The changes to current and future state expose new risks that require new policy statements.

## Changes in tangible risks

**Data breach:** When you adopt any new data platform, there's an inherent increase in liabilities related to potential data breaches. Technicians adopting cloud technologies have increased responsibility to implement solutions that can reduce this risk. A robust security and governance strategy must be implemented to ensure those technicians fulfill those responsibilities.

This business risk can be expanded into a few technical risks:

- Mission-critical applications or protected data might be deployed unintentionally.
- Protected data might be exposed during storage because of poor encryption decisions.
- Unauthorized users might access protected data.
- External intrusion might result in access to protected data.
- External intrusion or denial-of-service attacks might cause a business interruption.
- Organization or employment changes might allow unauthorized access to protected data.
- New exploits could create new intrusion or access opportunities.
- Inconsistent deployment processes might result in security gaps, which could lead to data leaks or interruptions.
- Configuration drift or missed patches might result in unintended security gaps, which could lead to data leaks or interruptions.

**Data loss:** There's also an inherent risk of data loss in the new platform. The security and governance strategy should consider the following scenarios in which data loss can happen:

- A mission-critical resource is lost or deleted.
- A mission-critical resource is present, but the data is lost because of accidental deletion.
- A mission-critical resource is present, but the data is lost because of malicious administration.

## Incremental improvement of policy statements

The following changes to policy will help remediate the new risks and guide implementation. The list looks long, but adopting these policies might be easier than you think.

- All deployed assets must be categorized by criticality and data classification. The cloud governance team and the application owner must review these classifications before deployment to the cloud.
- Applications that store or access protected data must be managed differently than applications that don't. At a minimum, they should be segmented to avoid unintended access of protected data.
- All protected data must be encrypted when at rest. This encryption is the default for all Azure Storage accounts. But you might need additional encryption strategies, including encryption of the data within the storage account, encryption of VMs, and database-level encryption when you use SQL in a VM (TDE and column encryption).
- Mission-critical data can be deleted accidentally. You need to develop a data backup strategy to handle this risk and restore the data from before the deletion point. A malicious admin can delete the mission-critical data and its backups as well. To handle this scenario, deletions of backup data should be soft deletions that can be reversed. Azure Backup can help with both of these scenarios.
- Elevated permissions in any segment that contains protected data should be an exception. Any such exceptions will be recorded with the cloud governance team and audited regularly.
- Network subnets that contain protected data must be isolated from other subnets. Network traffic between protected data subnets will be audited regularly.
- No subnet that contains protected data should be directly accessible over the public internet or across datacenters. Access to those subnets must be routed through intermediate subnets. All access into those subnets must come through a firewall solution that can perform packet scanning and blocking functions.
- Governance tooling must audit and enforce network configuration requirements defined by the security management team.
- Governance tooling must limit VM deployment to only approved images.
- Governance process must validate that backup, recovery, and SLA adherence are properly implemented for mission-critical applications and protected data.
- Whenever possible, node configuration management should apply policy requirements to the configuration of any guest operating system.
- Governance tooling must enforce that automatic updates are enabled on all deployed assets. Violations must be reviewed with operational management teams and remediated in accordance with operations policies. Assets that aren't automatically updated must be included in processes owned by IT operations.
- Creation of new subscriptions or management groups for any mission-critical applications or protected data will require a review from the cloud governance team to ensure that the proper blueprint is assigned.
- A least-privilege access model will be applied to any management group or subscription that contains mission-critical applications or protected data.
- Trends and exploits that could affect cloud deployments should be reviewed regularly by the security team to provide updates to security management tooling used in the cloud.
- Deployment tooling must be approved by the cloud governance team to ensure ongoing governance of deployed assets.
- Deployment scripts must be maintained in a central repository accessible by the cloud governance team for periodic review and auditing.
- Governance processes must include audits at the point of deployment and at regular cycles to ensure consistency across all assets.
- Deployment of any applications that require customer authentication must use an approved identity provider that's compatible with the primary identity provider for internal users.
- Cloud governance processes must include quarterly reviews with identity management teams. These reviews can help identify malicious actors or usage patterns that should be prevented by cloud asset configuration.

## Incremental improvement of governance practices

The governance MVP design will change to include new Azure policies and an implementation of Azure Cost Management + Billing. Together, these two design changes will fulfill the new corporate policy statements.

- The networking and IT security teams will define network requirements. The cloud governance team will support the conversation.
- The identity and IT security teams will define identity requirements and make any necessary changes to local Active Directory implementation. The cloud governance team will review changes.
- Create a repository in Azure DevOps to store and version all relevant Azure Resource Manager templates and scripted configurations.
- Azure Recovery Services vault implementation:
  - Define and deploy an Azure Recovery Services vault for backup and recovery processes.
  - Create a Resource Manager template for creation of a vault in each subscription.
- Azure Security Center implementation:
  - Configure Azure Security Center for any management group that contains protected data classifications.
  - Set automatic provisioning to on by default to ensure patching compliance.
  - Establish OS security configurations. The IT security team will define the configuration.
  - Support the IT security team in the initial use of Security Center. Transition the use of Security Center to the IT security team, but maintain access for the purpose of continually improving governance.
  - Create a Resource Manager template that reflects the changes required for Security Center configuration within a subscription.
- Update Azure policies for all subscriptions:
  - Audit and enforce the criticality of data and data classification across all management groups and subscriptions to identify any subscriptions with protected data classifications.
  - Audit and enforce the use of approved images only.
- Update Azure policies for all subscriptions that contain protected data classifications:
  - Audit and enforce the use of standard Azure roles only.
  - Audit and enforce encryption for all storage accounts and files at rest on individual nodes.
  - Audit and enforce the application of an NSG to all NICs and subnets. The networking and IT security teams will define the NSG.
  - Audit and enforce the use of approved network subnet and virtual network per network interface.
  - Audit and enforce the limitation of user-defined routing tables.
  - Apply the built-in policies for guest configuration as follows:
    - Audit that Windows web servers are using secure communication protocols.
    - Audit that password security settings are set correctly inside Linux and Windows machines.
  - Audit and enforce that Azure Recovery Services vaults exist in the subscription.
- Firewall configuration:
  - Identify a configuration of Azure Firewall that meets necessary security requirements. Alternatively, identify a compatible third-party appliance that's compatible with Azure. The Azure Security Benchmark provides additional information on [network security strategy](/azure/security/benchmarks/security-controls-v2-governance-strategy#gs-5-define-network-security-strategy) and [firewall configurations to support your security strategy](/azure/security/benchmarks/security-controls-v2-network-security#ns-4-protect-applications-and-services-from-external-network-attacks).
  - Create a Resource Manager template to deploy the firewall with required configurations.
- Azure Blueprints:
  - Create a new blueprint named `protected-data`.
  - Add the Azure Firewall templates, Azure Security Center templates, and Azure Recovery Services vault templates to the blueprint.
  - Add the new policies for protected data subscriptions.
  - Publish the blueprint to any management group that currently plans on hosting protected data.
  - Apply the new blueprint to each affected subscription and to existing blueprints.

## Conclusion

Adding the above processes and changes to the governance MVP will help to remediate many of the risks associated with security governance. Together, they add the network, identity, and security monitoring tools needed to protect data.

## Next steps

As cloud adoption continues and delivers additional business value, risks and cloud governance needs also change. For the fictional company in this guide, the next step is to support mission-critical workloads. At this point, resource consistency controls are needed.

> [!div class="nextstepaction"]
> [Improve the Resource Consistency discipline](./resource-consistency-improvement.md)
