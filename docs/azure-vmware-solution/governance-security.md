---
title: "Governance and Security Baselines for Azure VMware Solution"
description: "Establish governance and security baselines for Azure VMware Solution to reduce risk before onboarding workloads. Learn key controls and enforcement steps."
#customer intent: As a decision maker, I want to define the governance and security baseline that every Azure VMware Solution workload inherits by default, so that I can minimize risk before onboarding applications or operational teams.
author: stephen-sumner
ms.author: dsoderholm
ms.reviewer: ssumner
ms.date: 08/20/2026
ms.topic: concept-article
ai-usage: ai-assisted
--- 

# Governance and security baselines for Azure VMware Solution

*This article helps you establish governance and security baselines so every Azure VMware Solution workload inherits consistent controls and reduces risk before onboarding.*

:::image type="complex" border="false" source="./images/azure-vmware-solution-adoption-process.svg" alt-text="Diagram showing the Microsoft Cloud Adoption Framework process for Azure VMware Solution adoption." lightbox="./images/azure-vmware-solution-adoption-process.svg":::
    The image shows a progresses through five phases connected by arrows: Planning and readiness, Azure landing zone architecture, Governance and security baselines, Operational standards, and Migration. Each phase builds on the previous phase to prepare, govern, operate, and migrate workloads to Azure VMware Solution.
:::image-end:::

This article helps decision makers establish the governance and security baseline that every Azure VMware Solution workload inherits by default. A baseline is the *minimum* set of controls every Azure VMware Solution workload inherits *before* any workload team onboards. You create and maintain these baselines. Build additional controls to meet organizational needs such as regulatory compliance or to manage workload-specific risks.

The baseline guidance here assumes Azure VMware Solution Generation 2 (Gen 2), where the private cloud is deployed inside an Azure virtual network by default, giving native connectivity to Azure services and Azure-native controls. Generation 1 (Gen 1) is the legacy exception and is called out only where its capabilities differ.

Apply the same governance and security baselines to non-production environments as you do to production environments. Having consistent baselines means less risk of weaknesses in your overall estate, and simplifies transitioning workloads from one environment to another.

***Recommendation:*** Determine the governance and security baseline that every Azure VMware Solution workload must inherit across both the Azure environment and the VMware private cloud before onboarding applications or operational teams.

## 1. Governance baseline scope

Azure VMware Solution needs governance across two surfaces, and a baseline that covers only one of them leaves gaps in control and risk.

- **Azure governance:** The **Azure surface** is the set of Azure resources that support the private cloud, such as the subscription, the virtual network, monitoring, and Azure role assignments. You govern it with Azure-native tools.

- **Private cloud governance:** The **VMware surface** is the private cloud itself, such as network segments, firewall policy, vCenter and NSX roles, and storage policies. You govern most of it with VMware-native tools inside the private cloud.

A governance baseline that addresses only the Azure environment or only the VMware environment creates gaps in operational control and risk management.

## 2. Governance enforcement

Enforce baseline requirements through the platform landing zone whenever possible. Use manual operational processes to support enforcement when technical controls aren't available.

Apply Azure Policy at the management group, subscription, or resource group level to establish mandatory requirements for every Azure VMware Solution deployment. By using Azure Policy, you can ensure consistency across Azure VMware Solution private clouds, especially when you delegate VMware administration to workload owners. Align these requirements with the standards already used across the broader Azure estate. Some standard enforcement policies and mechanisms include:

- **Deployment boundaries:** [Allowed locations](/azure/governance/policy/samples/built-in-policies?context=/azure/governance/policy/context/policy-context#general)

- **Azure VMware Solution SKUs:** [Allowed resource types](/azure/governance/policy/samples/built-in-policies#general) (customized for Azure VMware Solution)

- **Protect private cloud**: [Resource locks](/azure/azure-resource-manager/management/lock-resources?tabs=json) (not an Azure Policy definition)

## 3. Security baseline

Every Azure VMware Solution deployment should inherit an approved security baseline before workload onboarding. Start with the Azure security baseline for Azure VMware Solution, which maps Azure VMware Solution capabilities to the Microsoft Cloud Security Benchmark and provides Microsoft-recommended security guidance. Microsoft Defender for Cloud can continuously assess the environment against applicable recommendations and regulatory controls. Azure Policy definitions associated with benchmark controls appear within the Regulatory Compliance experience in Microsoft Defender for Cloud. See [Azure VMware Solution security recommendations](/azure/azure-vmware/security-recommendations).

## 4. Azure VMware Solution identity baseline

Azure VMware Solution consumes your existing identity services, so the baseline refers to how you connect and your resources such as virtual machines, rather than deploying new identity services. This baseline relates to the identity services used by Azure VMware Solution itself, and doesn't affect the identity services used by individual application workloads running on VMware.

### 4.1 Identity provider

Use an external identity source for vCenter access rather than the built-in CloudAdmin account. Azure VMware Solution supports both Microsoft Entra ID and Active Directory (LDAPS) as external identity sources for vCenter Server.

- **Option 1. Microsoft Entra ID (recommended).** Organizations that already standardize on Microsoft Entra ID should prefer Entra ID federation because it centralizes identity governance, Conditional Access, and multifactor authentication across Azure and VMware administration.

- **Option 2. Active Directory Domain Services over LDAPS.** Organizations with operational dependencies on Active Directory-integrated VMware administration can continue to use LDAPS. It provides continuity with existing AD-integrated VMware admin workflows. You run AD domain controllers in Azure centrally in the platform identity subscription.

### 4.2 User permissions 

User access decisions establish the foundation for secure administration of Azure VMware Solution. Before onboarding operational teams, define how administrators receive access, which roles they can use, and how access is reviewed over time.

- **Group-based assignment:** Define administrator groups before onboarding operational teams. Assign users to groups and assign groups to roles. Avoid direct user assignments except for temporary exceptions.

- **Least-privilege vCenter roles:** Use custom vCenter roles when the CloudAdmin role grants more access than a team needs. Azure VMware Solution supports custom roles in vCenter with privileges equal to or lower than the CloudAdmin role. It doesn't offer custom roles in the Azure VMware Solution portal.

- **NSX Manager parity:** Apply the same access governance process to NSX Manager. Define approved administrative roles, apply least privilege, and conduct periodic access reviews. Not every predefined NSX role is supported, so define a small set of approved NSX roles and review them regularly.

### 4.3 CloudAdmin role

The CloudAdmin role in Azure VMware Solution behaves differently from on-premises VMware administrator access, and treating it like a daily-driver admin account is a common mistake. Treat CloudAdmin as a break-glass credential, rotated, monitored, and restricted to emergencies. Grant day-to-day access through external-identity groups mapped to least-privilege roles.

- **Break-glass only:** Don't use the built-in CloudAdmin account for daily administration or service integration. Reserve it as a break-glass account for emergency access. Store the credential through your privileged access process, rotate it on a defined schedule, and alert on retrieval or use.

- **No host-level access:** Azure VMware Solution administrators don't receive the vCenter Server *administrator@vsphere.local* account or the ESXi root account. Administrators can, however, assign Active Directory users and groups to the CloudAdmin role in vCenter Server.

- **Managed SSO domain:** The vsphere.local SSO domain is a **managed resource** that supports platform operations. You can't use it to create or manage local users and groups beyond the default accounts provided with the private cloud.

- **Adding an identity source:** The CloudAdmin role can't add an identity source (such as LDAP/LDAPS) directly. Use **Run commands** to add an external identity source and assign the CloudAdmin role to users and groups.

## 5. Azure VMware Solution networking baseline

Every private cloud uses VMware NSX as its software-defined network layer, replacing the VLAN-based model from on-premises VMware. Your teams create NSX segments for workloads, route traffic through NSX Tier-0 and Tier-1 gateways, and write distributed firewall rules. Plan the network security approach early and set a clear boundary:

- Use NSX for traffic inside the Azure VMware Solution environment (east-west).

- Use Azure-native or on-premises controls for traffic that crosses the Azure VMware Solution boundary (north-south).

### 5.1 East-west traffic baseline

East-west controls govern traffic *between workloads* inside the private cloud. Enforce microsegmentation with the NSX distributed firewall for every workload. Add vDefend only when a specific control objective requires it.

- **Option 1. NSX firewall.** Always use the NSX distributed firewall to enforce microsegmentation between workloads. Microsegmentation limits lateral movement if an attacker reaches one workload, such as stopping a compromised web server from reaching a database. Teams often underuse this capability right after migration, so make it part of the baseline.

- **Option 2. NSX firewall and VMware vDefend Firewall.** When the distributed firewall doesn't meet a specific requirement, evaluate the optional VMware vDefend Firewall add-on for capabilities that NSX alone doesn't provide, such as intrusion detection and URL filtering. Adopt it only when those capabilities map to a control objective you must meet.

Apply the same least-privilege approach to NSX by limiting who can change firewall rules, segments, and routing. Put change control and auditing in place because NSX updates can affect shared connectivity and disrupt multiple workloads.

### 5.2 North-south traffic baseline

North-south controls govern traffic *entering and leaving* the Azure VMware Solution environment. The right tool depends on your broader Azure network design.

- **Option 1.** **Azure Firewall or a third-party NVA.** Many organizations inspect this traffic with Azure Firewall or a third-party network virtual appliance placed in your centralized "Connectivity" platform subscription.

- **Option 2.** **NSX Gateway Firewall at the edge.** Use NSX Gateway Firewall at the Azure VMware Solution edge when you prefer to inspect at the private cloud boundary.

- **Option 3.** **On-premises firewall.** Some route internet egress through an existing on-premises firewall.

On Gen 2, add Azure network security groups (NSGs) at the Azure virtual network level for an extra Azure-native layer that complements NSX. Gen 1 doesn't offer NSGs.

If you apply controls at more than one layer, plan how you will keep them consistent. Controls split across layers add complexity, make troubleshooting harder, and can create unintended traffic paths. If you use automated network tools, decide up front how you will keep policies synchronized across VMware and Azure. Document the workload's network connectivity requirements, and ensure the same documentation and change notification process is used by VMware administrators and upstream network admin teams.

## 6. Azure VMware Solution cost baseline

Cost governance sets the financial guardrails that every Azure VMware Solution deployment inherits. At a minimum, you need a budget with alerts, a required tagging standard, and a named approver for capacity changes on every Azure VMware Solution subscription.

- **Budgets and alerts:** Use Microsoft Cost Management to set budget thresholds and spending alerts so overspend surfaces early. Require workload teams to configure alerts for CPU, memory, and vSAN utilization thresholds, and route those alerts to a named operations owner so that response is not ambiguous. Set the threshold values centrally, such as alerting at 75 percent sustained CPU utilization for production clusters, so that capacity decisions are based on the same data across every team. See [Configure Alerts for Azure VMware Solution](/azure/azure-vmware/configure-alerts-for-azure-vmware-solution).

- **Tagging:** Require tags on Azure VMware Solution resources so costs map back to owners and workloads and you can report on them. See [Policy definitions for tagging resources](/azure/azure-resource-manager/management/tag-policies).

- **Capacity:** Treat adding hosts as a deliberate, approved action. Decide who can approve new capacity. Set standards for minimum and maximum cluster size and for approved deployment regions, and require a capacity headroom buffer so a datastore never runs too full. Request host quota ahead of need. Quota requests add no cost, but a capacity addition can take several days to fulfill. Ensure that your process includes acquiring the necessary VCF licenses for newly added Azure VMware Solution hosts.

## 7. Azure VMware Solution guest VM baseline

Microsoft manages the Azure VMware Solution infrastructure, including ESXi hosts, vCenter Server, and NSX. You remain responsible for the guest operating systems, applications, and the security controls that run inside each virtual machine.

Extend governance into guest operating systems by onboarding virtual machines to Azure Arc-enabled VMware vSphere. See [Azure Arc-enabled VMware vSphere](/azure/azure-arc/vmware-vsphere/overview).

Once a virtual machine is Arc-enabled, organizations can apply Azure Policy Machine Configuration, Microsoft Defender services, Update Manager, and other Azure management capabilities using the same governance processes used for Azure virtual machines. See [Built-in policy definitions for Azure Arc-enabled servers](/azure/azure-arc/servers/policy-reference) and [How to create custom machine configuration policy definitions](/azure/governance/machine-configuration/how-to/create-policy-definition).

### 7.1 Guest configuration baseline

Require Azure Arc onboarding as part of the virtual machine provisioning process. Early onboarding ensures governance controls apply from day one rather than being added later through manual effort. Azure Arc enables capabilities such as Inventory, Change Tracking, and Machine Configuration.

These services work in Azure VMware Solution the same way they work for Azure virtual machines once the guest is Arc-enabled. Organizations can then apply the same configuration standards across Azure, on-premises VMware, and Azure VMware Solution environments.

### 7.2 Endpoint protection

Endpoint protection standards should remain consistent regardless of where the virtual machine runs. For Azure VMware Solution virtual machines, Azure Arc-enabled VMware vSphere provides the integration path required to deploy Microsoft Defender for Endpoint and other Azure security services. This approach allows security teams to maintain a unified view of endpoint security posture across the hybrid environment. See [Integrate Microsoft Defender for Cloud with Azure VMware Solution](/azure/azure-vmware/azure-security-integration).

### 7.3 Patching baseline

Microsoft is responsible for patching the Azure VMware Solution infrastructure. In your organization, typically the IT Operations team or workload admin teams are responsible for patching guest operating systems and applications. If your organization depends on established enterprise patching solutions, continue using those tools where advanced scheduling or orchestration requirements exist. These requirements can include Azure Update Manager on Arc-enabled Azure VMware Solution virtual machines.

### 7.4 VM extension baseline

VM extensions provide capabilities such as security monitoring, telemetry collection, and operational management. Without governance, extension deployment can become fragmented and difficult to control.

Define an approved extension catalog and require workload teams to use only authorized extensions. Pair extension governance with Azure Policy to enforce compliance and detect unauthorized configurations.

## Next step

> [!div class="nextstepaction"]
> [Operational standards](./operations-health-management.md)