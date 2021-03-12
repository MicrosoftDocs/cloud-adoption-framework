---
title: "Complex enterprise governance: Improve the Security Baseline discipline"
description: Use the Cloud Adoption Framework for Azure to learn about adding security controls that support moving protected data to the cloud.
author: BrianBlanchard
ms.author: brblanch
ms.date: 01/25/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
ms.custom: internal
---

# Governance guide for complex enterprises: Improve the Security Baseline discipline

This article advances the narrative by adding security controls that support moving protected data to the cloud.

## Advancing the narrative

The CIO has spent months collaborating with colleagues and the company's legal staff. A management consultant with expertise in cybersecurity was engaged to help the existing IT security and IT governance teams draft a new policy regarding protected data. The group was able to foster board support to replace the existing policy, allowing sensitive personal and financial data to be hosted by approved cloud providers. This required adopting a set of security requirements and a governance process to verify and document adherence to those policies.

For the past 12 months, the cloud adoption teams have cleared most of the 5,000 assets from the two datacenters to be retired. The 350 incompatible assets were moved to an alternate datacenter. Only the 1,250 virtual machines that contain protected data remain.

### Changes in the cloud governance team

The cloud governance team continues to change along with the narrative. The two founding members of the team are now among the most respected cloud architects in the company. The collection of configuration scripts has grown as new teams tackle innovative new deployments. The cloud governance team has also grown. Most recently, members of the IT operations team have joined cloud governance team activities to prepare for cloud operations. The cloud architects who helped foster this community are seen both as cloud guardians and cloud accelerators.

While the difference is subtle, it's an important distinction when building a governance-focused IT culture. A cloud custodian cleans up the messes made by innovative cloud architects, and the two roles have natural friction and opposing objectives. A cloud guardian helps keep the cloud safe, so other cloud architects can move more quickly with fewer messes. A cloud accelerator performs both functions but is also involved in the creation of templates to accelerate deployment and adoption, becoming an innovation accelerator as well as a defender of the Five Disciplines of Cloud Governance.

### Changes in the current state

In the previous phase of this narrative, the company had begun the process of retiring two datacenters. This ongoing effort includes migrating some applications with legacy authentication requirements, which required incremental improvements to the Identity Baseline discipline, described in the [previous article](./identity-baseline-improvement.md).

Since then, some things have changed that will affect governance:

- Thousands of IT and business assets have been deployed to the cloud.
- The application development team has implemented a continuous integration and continuous deployment (CI/CD) pipeline to deploy a cloud-native application with an improved user experience. That application doesn't interact with protected data yet, so it isn't production ready.
- The business intelligence team within IT actively curates data in the cloud from logistics, inventory, and third-party data. This data is being used to drive new predictions, which could shape business processes. Those predictions and insights are not actionable until customer and financial data can be integrated into the data platform.
- The IT team is making progress on the CIO and CFO plans to retire two datacenters. Almost 3,500 of the assets in the two datacenters have been retired or migrated.
- The policies regarding sensitive personal and financial data have been modernized. The new corporate policies are contingent on the implementation of related security and governance policies. Teams are still stalled.

### Incrementally improve the future state

- Early experiments from the application development and BI teams have shown potential improvements in customer experiences and data-driven decisions. Both teams would like to expand adoption of the cloud over the next 18 months by deploying those solutions to production.
- IT has developed a business justification to migrate five more datacenters to Azure, which will further decrease IT costs and provide greater business agility. While smaller in scale, the retirement of those datacenters is expected to double the total cost savings.
- Capital expense and operating expense budgets have approved to implement the required security and governance policies, tools, and processes. The expected cost savings from the datacenter retirement are more than enough to pay for this new initiative. IT and business leadership are confident this investment will accelerate the realization of returns in other areas. The grassroots cloud governance team became a recognized team with dedicated leadership and staffing.
- Collectively, the cloud adoption teams, the cloud governance team, the IT security team, and the IT governance team will implement security and governance requirements to allow cloud adoption teams to migrate protected data into the cloud.

## Changes in tangible risks

**Data breach:** There is an inherent increase in liabilities related to data breaches when adopting any new data platform. Technicians adopting cloud technologies have increased responsibilities to implement solutions that can decrease this risk. A robust security and governance strategy must be implemented to ensure those technicians fulfill those responsibilities.

This business risk can be expanded into several technical risks:

1. Mission-critical applications or protected data might be deployed unintentionally.
1. Protected data might be exposed during storage due to poor encryption decisions.
1. Unauthorized users might access protected data.
1. External intrusion could result in access to protected data.
1. External intrusion or denial of service attacks could cause a business interruption.
1. Organization or employment changes could allow for unauthorized access to protected data.
1. New exploits might create opportunities for intrusion or unauthorized access.
1. Inconsistent deployment processes might result in security gaps that could lead to data leaks or interruptions.
1. Configuration drift or missed patches might result in unintended security gaps that could lead to data leaks or interruptions.
1. Disparate edge devices might increase network operations costs.
1. Disparate device configurations might lead to oversights in configuration and compromises in security.
1. The cybersecurity team insists there is a risk of vendor lock-in from generating encryption keys on a single cloud provider's platform. While this claim is unsubstantiated, it was accepted by the team for the time being.

## Incremental improvement of the policy statements

The following changes to policy will help remediate the new risks and guide implementation. The list looks long, but the adoption of these policies may be easier than it would appear.

1. All deployed assets must be categorized by criticality and data classification. Classifications are to be reviewed by the cloud governance team and the application before deployment to the cloud.
1. Applications that store or access protected data are to be managed differently than those that don't. At a minimum, they should be segmented to avoid unintended access of protected data.
1. All protected data must be encrypted when at rest.
1. Elevated permissions in any segment containing protected data should be an exception. Any such exceptions will be recorded with the cloud governance team and audited regularly.
1. Network subnets containing protected data must be isolated from any other subnets. Network traffic between protected data subnets will be audited regularly.
1. No subnet containing protected data can be directly accessed over the public internet or across datacenters. Access to these subnets must be routed through intermediate subnets. All access into these subnets must come through a firewall solution that can perform packet scanning and blocking functions.
1. Governance tooling must audit and enforce network configuration requirements defined by the security management team.
1. Governance tooling must limit VM deployment to approved images only.
1. Whenever possible, node configuration management should apply policy requirements to the configuration of any guest operating system. Node configuration management should respect the existing investment in group policy objects (GPO) for resource configuration.
1. Governance tooling will audit that automatic updates are enabled on all deployed assets. When possible, automatic updates will be enforced. When not enforced by tooling, node-level violations must be reviewed with operational management teams and remediated in accordance with operations policies. Assets that are not automatically updated must be included in processes owned by IT operations.
1. Creation of new subscriptions or management groups for any mission-critical applications or protected data requires a review from the cloud governance team to ensure proper blueprint assignment.
1. A least-privilege access model will be applied to any subscription that contains mission-critical applications or protected data.
1. The cloud vendor must be capable of integrating encryption keys managed by the existing on-premises solution.
1. The cloud vendor must be capable of supporting the existing edge device solution and any required configurations to protect any publicly exposed network boundary.
1. The cloud vendor must be capable of supporting a shared connection to the global WAN, with data transmission routed through the existing edge device solution.
1. Trends and exploits that could affect cloud deployments should be reviewed regularly by the security team to provide updates to Security Baseline tools used in the cloud.
1. Deployment tooling must be approved by the cloud governance team to ensure ongoing governance of deployed assets. 18. Deployment scripts must be maintained in a central repository accessible by the cloud governance team for periodic review and auditing.
1. Governance processes must include audits at the point of deployment and at regular cycles to ensure consistency across all assets.
1. Deployment of any applications that require customer authentication must use an approved identity provider that is compatible with the primary identity provider for internal users. 1. Cloud governance processes must include quarterly reviews with identity baseline teams to identify malicious actors or usage patterns that should be prevented by cloud asset configuration.

## Incremental improvement of best practices

This section modifies the governance MVP design to include new Azure policies and an implementation of Azure Cost Management + Billing. Together, these two design changes will fulfill the new corporate policy statements.

The new best practices fall into two categories: corporate IT (hub) and cloud adoption (spoke).

**Establishing a corporate IT hub and spoke subscription to centralize the security baseline:** In this best practice, the existing governance capacity is wrapped by a [hub and spoke topology with shared services](/azure/architecture/reference-architectures/hybrid-networking/#hub-spoke-network-topology), with a few key additions from the cloud governance team.

1. Azure DevOps repository. Create a repository in Azure DevOps to store and version all relevant Azure Resource Manager templates and scripted configurations.
1. Hub and spoke template:
    1. The guidance in the [hub and spoke topology with shared services](/azure/architecture/reference-architectures/hybrid-networking/#hub-spoke-network-topology) reference architecture can be used to generate Resource Manager templates for the assets required in a corporate IT hub.
    1. Using those templates, this structure can be made repeatable, as part of a central governance strategy.
    1. In addition to the current reference architecture, a network security group template should be created to capture any port blocking or allow-listing requirements for the virtual network to host the firewall. This network security group differs from prior groups, because it will be the first network security group to allow public traffic into a virtual network.
1. Create Azure policies. Create a policy named `hub NSG enforcement` to enforce the configuration of the network security group assigned to any virtual network created in this subscription. Apply the built-in policies for guest configuration as follows:
    1. Audit that Windows web servers are using secure communication protocols.
    1. Audit that password security settings are set correctly inside Linux and Windows machines.
1. Create the corporate IT blueprint.
    1. Create an Azure blueprint named `corporate-it-subscription`.
    1. Add the hub and spoke templates and `hub NSG enforcement` policy.
1. Expanding on initial management group hierarchy.
    1. For each management group that has requested support for protected data, the `corporate-it-subscription-blueprint` blueprint provides an accelerated hub solution.
    1. Because management groups in this fictional example include a regional hierarchy in addition to a business unit hierarchy, this blueprint will be deployed in each region.
    1. For each region in the management group hierarchy, create a subscription named `corporate IT subscription`.
    1. Apply the `corporate-it-subscription-blueprint` blueprint to each regional instance.
    1. This will establish a hub for each business unit in each region. Note: further cost savings could be achieved by sharing hubs across business units in each region.
1. Integrate group policy objects (GPO) through Desired State Configuration (DSC):
    1. Convert GPO to DSC. The [Microsoft baseline management project](https://github.com/microsoft/baselinemanagement) in GitHub can accelerate this effort. Be sure to store DSC in the repository in parallel with Resource Manager templates.
    1. Deploy Azure Automation State Configuration to any instances of the corporate IT subscription. Azure Automation can be used to apply DSC to VMs deployed in supported subscriptions within the management group.
    1. The current roadmap aims to enable custom guest configuration policies. When that feature is released, the use of Azure Automation in this best practice will no longer be required.

**Applying additional governance to a cloud adoption subscription (spoke):** Building on the `corporate IT subscription`, minor changes to the governance MVP applied to each subscription dedicated to the support of application archetypes can produce rapid improvement.

In prior iterative changes to the best practice, we defined network security groups to block public traffic and allow internal traffic. Additionally, the Azure blueprint temporarily created DMZ and Active Directory capabilities. In this iteration, we will tweak those assets a bit, creating a new version of the Azure blueprint.

1. Network peering template. This template will peer the virtual network in each subscription with the hub virtual network in the corporate IT subscription.
    1. The reference architecture from the prior section, [hub and spoke topology with shared services](/azure/architecture/reference-architectures/hybrid-networking/#hub-spoke-network-topology), generated a Resource Manager template for enabling virtual network peering.
    2. That template can be used as a guide to modify the DMZ template from the prior governance iteration.
    3. We are now adding virtual network peering to the DMZ virtual network that was previously connected to the local edge device over VPN.
    4. The VPN should also be removed from this template as well to ensure no traffic is routed directly to the on-premises datacenter, without passing through the corporate IT subscription and firewall solution. You could also set this VPN as a failover circuit in the event of an ExpressRoute circuit outage.
    5. Additional [network configuration](/azure/automation/automation-dsc-overview#network-planning) is required by Azure Automation to apply DSC to hosted VMs.
2. Modify the network security group. Block all public **and** direct on-premises traffic in the network security group. The only inbound traffic should be coming through the virtual network peer in the corporate IT subscription.
    1. In the prior iteration, a network security group was created blocking all public traffic and allowing all internal traffic. Now we want to shift this network security group a bit.
    2. The new network security group configuration should block all public traffic, along with all traffic from the local datacenter.
    3. Traffic entering this virtual network should only come from the virtual network on the other side of the virtual network peer.
3. Azure Security Center implementation:
    1. Configure Azure Security Center for any management group that contains protected data classifications.
    2. Set automatic provisioning to on by default to ensure patching compliance.
    3. Establish OS security configurations. IT security to define the configuration.
    4. Support IT security in the initial use of Azure Security Center. Transition use of Security Center to IT security, but maintain access for governance continuous improvement purposes.
    5. Create a Resource Manager template reflecting the changes required for Azure Security Center configuration within a subscription.
4. Update Azure Policy for all subscriptions.
    1. Audit and enforce criticality and data classification across all management groups and subscriptions to identify any subscriptions with protected data classifications.
    2. Audit and enforce use of approved OS images only.
    3. Audit and enforce guest configurations based on security requirements for each node.
5. Update Azure Policy for all subscriptions that contains protected data classifications.
    1. Audit and enforce use of standard roles only.
    2. Audit and enforce application of encryption for all storage accounts and files at rest on individual nodes.
    3. Audit and enforce the application of the new version of the DMZ network security group.
    4. Audit and enforce use of approved network subnet and virtual network per network interface.
    5. Audit and enforce the limitation of user-defined routing tables.
6. Azure blueprint:
    1. Create an Azure blueprint named `protected-data`.
    2. Add the virtual network peer, network security group, and Azure Security Center templates to the blueprint.
    3. Ensure the template for Active Directory from the previous iteration is **not** included in the blueprint. Any dependencies on Active Directory will be provided by the corporate IT subscription.
    4. Terminate any existing Active Directory VMs deployed in the previous iteration.
    5. Add the new policies for protected data subscriptions.
    6. Publish the blueprint to any management group that will host protected data.
    7. Apply the new blueprint to each affected subscription along with existing blueprints.

## Conclusion

Adding these processes and changes to the governance MVP helps remediate many of the risks associated with security governance. Together, they add the network, identity, and security monitoring tools needed to protect data.

## Next steps

As cloud adoption continues and delivers additional business value, risks and cloud governance needs also change. For the fictional company in this guide, the next step is to support mission-critical workloads. This is the point when resource consistency controls are needed. A critical part of the security governance narrative will be to review best practices that Microsoft has built for security. The Azure Security Benchmark (ASB) provides prescriptive best practices and recommendations to help improve the security of workloads, data, and services on Azure. [Read here.](/azure/security/benchmarks/overview)

> [!div class="nextstepaction"]
> [Improve the Resource Consistency discipline](./resource-consistency-improvement.md)
