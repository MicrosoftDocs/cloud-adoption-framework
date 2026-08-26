---
title: "Operational standards for Azure VMware Solution"
description: Define operational standards for Azure VMware Solution to manage governance, monitoring, resilience, and cost. Learn key decisions for scaling your VMware estate.
#customer intent: As a decision maker, I want to understand the key operational decisions required to manage Azure VMware Solution at scale, including compliance, monitoring, resilience, tooling, and cost governance.
author: stephen-sumner
ms.author: dsoderholm
ms.reviewer: ssumner
ms.date: 08/20/2026
ms.topic: concept-article
ai-usage: ai-assisted
---

# Operational standards for Azure VMware Solution

*This article provides guidance to help decision makers define operational standards for Azure VMware Solution. You'll learn the key decisions for managing governance, monitoring, resilience, and cost as your VMware estate grows.*

:::image type="complex" border="false" source="./images/azure-vmware-solution-adoption-process.svg" alt-text="Diagram showing the Microsoft Cloud Adoption Framework process for Azure VMware Solution adoption." lightbox="./images/azure-vmware-solution-adoption-process.svg":::
    The image shows a progresses through five phases connected by arrows: Planning and readiness, Azure landing zone architecture, Governance and security baselines, Operational standards, and Migration. Each phase builds on the previous phase to prepare, govern, operate, and migrate workloads to Azure VMware Solution.
:::image-end:::

Azure VMware Solution runs your VMware estate on dedicated hardware inside Azure, and Microsoft operates the platform beneath it. That division shapes how your teams work day to day. This article sets the operational standards that decision-makers define once and apply to every workload team, so the platform stays healthy and compliant as adoption grows. It focuses on the decisions that carry the most weight, and it explains the trade-offs you should weigh before you commit to each one.

**Recommendation:** Treat Azure VMware Solution as a managed platform with organization-wide operational standards rather than a collection of independently managed workloads. Define clear accountability, approved toolsets, monitoring requirements, resilience objectives, and financial controls before workloads are deployed to ensure consistent operations, predictable costs, and adherence to governance requirements across the estate.

## 1. Operational tasks

You don't get the deepest administrative access on this platform, and that access is by design. Microsoft doesn't grant root access to the ESXi hosts or to the built-in vSphere administrator account. Instead, your teams work through a purpose-built vCenter role called CloudAdmin, and through role-based access control (RBAC) assignments. For the few tasks that normally need elevated rights, such as setting a vSAN storage policy or configuring an external identity source, teams run pre-approved PowerShell packages through the Run Command feature in the Azure portal. Set the expectation that teams operate within this model rather than request access the platform doesn't provide. For the operations Run Command supports, see [Use Run Commands in Azure VMware Solution](/azure/azure-vmware/using-run-command).

Management of the platform spans a few distinct areas, and each one has its own tools and owners. The following table groups those areas so you can assign them cleanly, and it feeds the accountability decisions in the next section.

| **Management area**     | **Description**                                                                           | **Examples**                                                                                                                    | **Recommended tools**                                                                                           |
|-------------------------|-------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------|
| The private cloud       | Monitor and manage the hosts, clusters, and management services, including vCenter Server | Add or remove hosts, monitor cluster health, assign roles, adjust network configuration, configure identity providers           | Azure portal, Azure CLI and PowerShell, vCenter Server, NSX Manager, Bicep or Terraform, VMware Aria Operations |
| VMware virtual machines | Manage the guest VMs that run your workloads                                              | Create and delete VMs, change VM configuration and resources, monitor VM resources                                              | vCenter Server, VMware Aria Operations, Azure Arc                                                               |
| Guest operating systems | Manage the operating system and software inside each VM                                   | Patch Windows or Linux, install software, monitor applications and endpoint security                                            | Azure Arc, Azure Monitor, Azure Machine Configuration, Microsoft Defender for Cloud                             |
| Platform dependencies   | Manage the Azure resources that support the private cloud                                 | Configure external storage, configure networking and DNS, assign Azure Policy and track compliance, configure identity services | Azure portal, Azure CLI and PowerShell, Bicep or Terraform, REST API, Azure Monitor                             |
| Connected resources     | Manage the Azure resources your workloads consume                                         | Create SQL databases, configure Azure AI Foundry resources, create Azure Files shares, configure private endpoints              | Azure portal, Azure CLI and PowerShell, Bicep or Terraform, REST API, Azure Monitor                             |

## 2. Compliance

Clear ownership keeps the platform compliant as you add more workloads. Compliance failures in Azure VMware Solution environments most often happen when ownership is unclear between the Azure platform team and the VMware administration team. Make the ownership decisions in the following sections and revisit them on a set cadence.

- **Ownership mapping.** Map every governance activity to an accountable team. Name one owner for each recurring governance activity. These activities include approving virtual machine deployments against your governance requirements and reviewing configuration drift. They also include responding to security findings from Microsoft Defender for Cloud and managing VMware administrative roles. Add ownership for maintaining the Azure Arc integration components and for validating ongoing compliance with your standards. **Trade-off:** A documented model adds review overhead, but the alternative is silent gaps where each team assumes the other owns a control.

- **Review cadence:** Review ownership on your existing governance cadence. Fold this review into the same governance and operational review cycle you use for other shared cloud platforms, so you cover both the Azure and the VMware management surfaces. **Trade-off:** A fixed cadence can lag a fast reorganization. To avoid this problem, treat a major change such as a new security requirement or a compliance obligation as its own trigger rather than waiting for the next cycle.

## 3. Tooling standard

You can manage Azure VMware Solution by using both Azure-native tools and VMware-native tools, and many of their capabilities overlap. You need to decide which toolset is authoritative for each operational area so governance and reporting draw from one source rather than two sources that can disagree. Two starting positions are common:

- **Option 1. Azure-native tooling:** Organizations with mature Azure governance practices typically choose Azure-native tooling because it consolidates identity governance and policy enforcement under a single control plane.

- **Option 2. VMware-native primary:** Organizations with deep VMware operational maturity often retain vCenter and Aria as the primary interface to preserve existing skills and runbooks.

A hybrid model works when you give each platform a distinct, non-overlapping role, such as Azure for identity governance and VMware for hypervisor-level operations. Avoid running the same workflow on both platforms. Duplication creates conflicting state and doubles your operational cost. It also makes audit evidence harder to defend.

The following table shows where each platform tends to lead. Use it to assign one authoritative tool per area.

| **Operational domain**      | **Azure-native approach**           | **VMware-native approach** | **Common consideration**                                             |
|-----------------------------|-------------------------------------|----------------------------|----------------------------------------------------------------------|
| Access governance           | Azure RBAC, Conditional Access, PIM | vCenter roles              | Central identity governance often favors Azure                       |
| Monitoring and alerting     | Azure Monitor, Log Analytics        | VMware Aria Operations     | Existing operational skillsets might influence the decision            |
| VM governance and inventory | Azure Arc                           | vCenter inventory          | Azure Arc provides centralized governance across hybrid environments |
| Automation                  | Azure Policy, Azure Resource Manager, Bicep, Terraform | vRealize/Aria Automation   | Existing automation standards might drive consistency                  |
| Security operations         | Microsoft Defender for Cloud        | VMware security tooling    | Central SOC integration is often a deciding factor                   |

## 4. Cost management and FinOps 

Azure VMware Solution grows one host at a time, not one virtual machine at a time, so a single sizing choice can add a large amount of capacity and cost at once. These standards keep that growth predictable. They start with how you size a cluster and move through how you keep it efficient and how you scale it. Set them centrally so capacity decisions rest on the same data across every team.

### 4.1 Cluster sizing standard

A cluster starts at three hosts and scales to a maximum of 16. You can add up to 12 clusters, or 96 hosts, to a single private cloud, managed by a single vCenter Server. Each host type comes with a fixed amount of compute and vSAN storage, so the host type you standardize on sets the granularity at which you add capacity. A private cloud can't mix host types, which makes your standard host type a firm platform constraint rather than a preference. Settle the following decisions before any team requests its first cluster.

- **Host SKU**: Standardize on one host type per private cloud. Pick the host type that fits the dominant workload profile. For a Gen2 private cloud, that host type is AV64. Document an exception path for a workload that needs a different host type in its own private cloud. For current host specifications, see [Azure VMware Solution private cloud and cluster concepts](/azure/azure-vmware/architecture-private-clouds).

- **Cluster sizing assessment:** Require a sizing assessment before any cluster request. **Use** Azure Migrate as the assessment tool of record so the inputs stay consistent across teams.

- **Production minimums:** Plan production clusters with at least four hosts. Three hosts is the supported minimum, but a fourth host keeps your data protected during routine maintenance on one host. **Trade-off**: The extra host raises baseline cost, but a three-host cluster leaves data unprotected whenever one host is under maintenance.

### 4.2 Right-sizing standards

Once clusters exist, keep them efficient by right-sizing virtual machines as a standing practice. Right-sizing gives each virtual machine only the compute and storage it actually uses. This practice improves cluster utilization because oversized virtual machines consume capacity that could support additional workloads. Reducing overprovisioning helps delay unnecessary host purchases and lowers overall platform costs.

- **Right-sizing review:** Make right-sizing a standing practice. Require workload teams to review virtual machine utilization on a set cadence, such as quarterly, and to resize any machine whose sustained utilization sits well below its allocation. **Trade-off:** The review effort recurs, but it raises workloads per cluster and defers host purchases.

- **Capacity gates:** Gate capacity additions on right-sizing. Make right-sizing a precondition for any request to add hosts, so a team can't hide oversized machines by adding capacity. **Trade-off:** A team in a hurry waits for the review, but you avoid buying hosts to cover waste.

### 4.3 Overcommitting standard

With right-sizing in place, you can safely assign more virtual processors than there are physical cores. This practice, called CPU overcommitment, raises the number of virtual machines a cluster can run. It works because virtual processors are rarely all busy at the same moment, and the VMware scheduler shares the physical cores among them.

- **CPU overcommitment maximum:** Set the maximum CPU overcommitment ratio centrally, by workload tier. A common pattern keeps a conservative ratio such as 2:1 or 3:1 for business-critical production and allows a higher ratio such as 6:1 or 8:1 for development and test. As a worked example, a cluster with 200 physical cores at a 3:1 ratio supports 600 virtual processors across its machines. **Trade-off:** A higher ratio packs in more machines, but it raises the risk of contention on busy hosts, so pair the ratio with a rule that sustained CPU use above an agreed ceiling, such as 90 percent, triggers a capacity review.

- **Do not overcommit memory.** Memory overcommitment degrades virtual machine performance and isn't recommended for these workloads. **Trade-off:** You give up some memory density, but you avoid the performance loss that memory overcommitment causes.

### 4.4 Workload balancing standard

Allocation policy needs an automated way to keep hosts balanced as demand shifts. VMware Distributed Resource Scheduler (DRS) comes with the platform and moves running virtual machines between hosts to even out utilization. Require DRS on every production cluster, so placement stays automatic rather than dependent on individual administrators. Set its automation level centrally as well, such as fully automated for production, so behavior doesn't vary across teams.

### 4.5 Storage capacity standard

Storage is where capacity decisions and resilience decisions meet, so set the standard centrally rather than leaving it to workload owners. Architect your storage approach to meet your resilience needs while providing enough capacity for your workloads. You can extend the capacity of Azure VMware Solution with external storage, but you can't increase the resilience beyond the supported vSAN settings. Set a common storage baseline for the majority of your workloads, and then manage exceptions. For example, you might have a high resilience requirement for production workloads on your vSAN storage, but you can attach extra external storage for non-production workloads with different reliability and performance demands.

Azure VMware Solution stores data on vSAN, which pools the local disks of every host in a cluster into one shared datastore. Two settings govern how vSAN protects that data.

The failures-to-tolerate (resiliency) setting decides how many hosts can fail simultaneously while still keeping the data safe. A higher FTT value increases resilience but reduces the available capacity of your vSAN datastore. Larger clusters should have higher FTT values, as the risk of concurrent failures increases.

The RAID (capacity) setting decides how that protection is stored. Higher protection uses more raw capacity, and lower protection frees capacity but accepts more risk. The default policy mirrors the data and survives a single host failure.

- **Storage policies:** Map storage policies to workload tiers. A business-critical system justifies higher protection, such as mirroring or erasure coding. A non-production system can accept lower protection to reclaim capacity. Base every policy on validated sizing rather than a rough estimate. **Trade-off:** Higher protection levels need more hosts, so a policy that tolerates two host failures calls for a larger cluster, and a rough estimate tends to over-provision or under-protect. For the storage policy settings and their host requirements, see [Configure a storage policy](/azure/azure-vmware/configure-storage-policy).

- **External storage:** Default to external storage for storage-heavy workloads. When a cluster runs low on storage, adding a host raises compute and storage together, which fits a workload that grows evenly across both. Many estates instead grow storage faster than compute, and there adding hosts wastes the extra compute you are forced to buy. External storage services such as Azure NetApp Files and Azure Elastic SAN attach to a cluster as extra datastores and let you grow storage on its own. **Trade-off:** External storage adds a service to manage, but it usually lowers the host count a portfolio needs and makes platform cost easier to predict. For the supported external storage services, see [External storage solutions overview](/azure/azure-vmware/ecosystem-external-storage-solutions)

When combining vSAN and external storage, understand the different features and performance each service supports. vSAN uses internal NVMe storage in the host servers and has very high performance, and supports storage deduplication. But, the only way to add more vSAN storage is with more hosts. External storage is easier to extend, but might have different feature support that you should map to your workload's requirements.

### 4.6 Capacity headroom standard

Reserve capacity for the platform itself. Each private cloud runs its own management components as virtual machines on the same clusters that host your workloads, such as vCenter Server and NSX Manager. Set a headroom policy that keeps enough free capacity for those components plus a buffer for maintenance and host failure, and keep workloads out of that reserve under normal conditions. This reserve matters most on small clusters, where the platform overhead is a larger share of the total, which is another reason to avoid undersizing.

Ensure that you have enough capacity for short-term growth and workloads that require temporary expansion. For example, you might need extra test and dev environments for an application before a major update. Plan ahead to make sure that your capacity increases are predictable, and have enough overhead to support the periods between cluster expansions.

### 4.7 Temporary capacity and licensing standard

The preceding standards assume a steady-state cluster, so you also need a position on short-term scaling. The platform lets you add hosts up to the cluster maximum on a pay-as-you-go basis, which suits a seasonal peak or a migration event.

- **Approval:** Define who authorizes a temporary expansion and how long it lasts. Decide in advance who can approve short-term hosts, and set the review that returns the cluster to its baseline size. **Trade-off:** Pay-as-you-go hosts absorb a peak without permanent cost, but without a return-to-baseline review they quietly become permanent spend.

- **Licensing:** Confirm VMware license coverage before each host is provisioned. Every host consumes license capacity even when you add it temporarily, so build the license check into the expansion approval. Coordinate capacity planning with your financial governance team, and review cost on a regular cadence.

For pricing and licensing, see [Azure VMware Solution pricing](https://azure.microsoft.com/pricing/details/azure-vmware/).

## 5. Monitoring and alerting

You can't keep the platform healthy or prove it's compliant without the right signals. This set of standards defines what your teams watch and how a signal turns into action. Choose the signals first, because tooling choices only make sense once you know what you intend to watch. The following sections move from the signals your teams collect to the alerts that reach an accountable owner.

### 5.1 Monitoring signals

Azure VMware Solution produces telemetry at several levels. Focus on the signals that warn of real risk, and set for each one who watches it and what threshold triggers action. Anything you leave undefined becomes a blind spot that surfaces only during an incident. The following table groups the signals worth standardizing.

| **Signal source**      | **What to watch**                                                            | **Notes**                                         |
|------------------------|------------------------------------------------------------------------------|---------------------------------------------------|
| vSphere and vSAN       | Host health, cluster capacity, vSAN latency and congestion, host utilization | Keep at least 25 percent free vSAN capacity       |
| Virtual machines       | CPU, memory, and disk use, plus application performance                      | Guest signals mirror standard Azure VM monitoring |
| NSX networking         | Firewall drops, gateway and routing health, segment utilization              | Flags a connectivity or security change           |
| HCX (during migration) | Replication health, tunnel status, network extension health                  | Relevant only during migrations                   |
| Azure platform         | Resource Health events, ExpressRoute circuit use, Activity Log               | Warns of platform-level issues                    |

For the metrics the platform exposes and how to alert on them, see [Configure alerts in Azure VMware Solution](/azure/azure-vmware/configure-alerts-for-azure-vmware-solution).

### 5.2 Log collection and retention

Metrics tell you that something happened, but logs tell you why. Your standard must govern logs too. Azure VMware Solution exposes a VMware syslog feed that carries the diagnostic records your teams need, such as vCenter Server logs and NSX firewall logs.

- **Log collection:** Forward the VMware syslog to Log Analytics Workspace. Align your Log Analytics workspaces to your organization’s administrative scopes. Treat Azure VMware Solution logs as separate from individual application workload logs. **Trade-off:** Keeping Azure VMware Solution logs in a dedicated Log Analytics workspace simplifies log querying and administrative scope, but reduces total visibility. If your organization has a centralized Log Analytics workspace with Sentinel enabled, prioritize security and use that workspace rather than risk missing threat signals.

- **Diagnostic setting:** Require teams to configure a diagnostic setting on the private cloud that forwards this syslog to a shared workspace, which puts platform logs alongside the rest of your Azure telemetry. **Trade-off:** A shared workspace centralizes investigation, but it needs access controls so each team sees the logs it should and no more. To configure it, see [Configure VMware syslogs](/azure/azure-vmware/configure-vmware-syslogs).

- **Log retention:** Set a tiered retention standard. Log Analytics keeps data ready for query and alerting at a higher price. An Azure Storage account holds the same data far more cheaply for long-term archive, but without the query features. Keep recent logs in Log Analytics for active investigation, and move older logs to storage to control spend. Retain your Activity Log entries in line with your audit policy. **Trade-off:** Longer query-ready retention speeds investigation but costs more, so the tier boundary is where you balance investigation speed against spend.

- **Logging enforcement.** Enforce logging with Azure Policy. A built-in policy sends diagnostic logs from Azure VMware Solution private clouds, the `Microsoft.AVS/privateClouds` resource type, to a Log Analytics workspace across every subscription in scope. **Trade-off:** Policy enforcement removes per-team discretion, but it closes the gap that manual configuration leaves open. See [Create diagnostic settings at scale with built-in policies](/azure/azure-monitor/platform/diagnostic-settings-policy-built-in)

### 5.3 Security monitoring

The shared workspace you set up for logs becomes the foundation for security monitoring, so this decision builds on the last one.

- **Security monitoring automation:** Enable Microsoft Defender for Cloud on every subscription that hosts a private cloud. Confirm that its plan for servers is turned on so the guest virtual machines are protected. Ensure additional workload protection is enabled where available, such as Defender for SQL on database servers. **Trade-off:** The Defender for Servers plan adds a per-machine cost, but it brings the guest machines under the same protection as the rest of your estate.

- **SIEM connection:** Connect Microsoft Sentinel to the workspace if you run a security operations center. Sentinel correlates private cloud events, such as a failed vCenter sign-in, with signals from the rest of your estate, so analysts see one picture rather than an isolated VMware silo. Decide whether security monitoring is a central responsibility or a workload-team responsibility, and write that ownership into the standard. **Trade-off:** Sentinel adds ingestion and analyst cost, but without it private cloud events sit in a silo that no one correlates.

### 5.4 Consolidated operational view

By now your teams gather signals through several tools at once, and that breadth creates a real risk that operators jump between consoles and lose the single picture you set out to build. Name one consolidation layer that every team builds toward.

Azure Monitor workbooks and Azure Managed Grafana can each pull platform metrics and Log Analytics queries into one dashboard an operations team reads at a glance. Where VMware Aria Operations stays the system of record for deep VMware metrics, let it keep that detail and design the Azure dashboard to carry the cross-cutting health view that ties the estate together. Standardizing the consolidation layer matters more than the specific product, because a common dashboard gives leadership and operations the same source of truth.

### 5.5 Alerting

The last decision turns monitoring into action. Telemetry only protects a workload when an alert reaches an accountable owner in time, so define who responds to what and at which threshold. You should map the required alerts, the recipients and their responsibilities, and how they are provisioned:

- **Azure platform alerts** from the underlying Azure platform components that Azure VMware Solution depends on. For example, ExpressRoute and Active Directory.

- **Azure VMware Solution alerts** for the VMware components, including vCenter Server, ESXi, host hardware status, and NSX.

- **Virtual machine alerts** such as failed heartbeats or CPU and memory alerts, indicating a problem with the virtual machine itself.

- **Application workload alerts**, such as SQL databases and web application telemetry.

Clearly document which logs are automatically enabled, and which require manual creation. For example, Azure Monitor Baseline Alerts can automatically configure performance and availability alerts, but application owners must enable custom alerts on specific telemetry that is important to their application’s health.

After creation, logging typically requires tuning so that you receive only relevant and actionable alerts:

- **Alert thresholds:** Set thresholds from an agreed baseline, not from guesswork. Base capacity alerts on the free space your service-level agreement requires, such as keeping vSAN slack at or above 25 percent. Subscribe to Azure Service Health for platform-level notices, and turn on Resource Health alerts so the platform warns your teams of private cloud issues in real time. **Trade-off:** Baselines take effort to establish, but thresholds set by guesswork either cry wolf or miss real problems.

- **Noise reduction:** Guard against alert fatigue. Group notifications by cluster or by host rather than firing one alert per machine, and suppress short-lived blips with a time threshold. Name the team that owns each alert category and the channel that reaches it, such as email or Microsoft Teams, so every signal ends with a clear path to resolution. **Trade-off:** Grouping and suppression can delay notice of a fast-moving issue, so tune the time threshold to the tier rather than applying one setting everywhere.

## 6. Reliability and resilience standards

Reliability on this platform is a shared responsibility. Microsoft protects the infrastructure to a defined floor, and you decide how much protection to add above it for each workload. These standards set that bar consistently, so workload teams don't negotiate resilience case by case. They start from what the platform already guarantees and build up to the protection you add on top. For the full platform reliability detail, see [Reliability in Azure VMware Solution](/azure/reliability/reliability-vmware-solution).

### 6.1 Shared responsibility

Every private cloud includes vSphere High Availability, which restarts virtual machines on healthy hosts after a host fails and reserves enough capacity for a single host failure by default. vSAN keeps multiple copies of your data across hosts, and Microsoft replaces failed hosts and patches the platform without taking workloads down. These protections cover a host failure and routine maintenance. They don't cover the loss of an availability zone or a full region, and they don't undo data corruption inside an application. Set the expectation in writing that teams treat the platform floor as a starting point and layer their own protection on top for anything it doesn't address.

### 6.2 Workload tiering standard

Give teams one common way to state how much protection a workload deserves, because that classification drives every later decision.

- **Recovery targets:** Require a recovery point objective and a recovery time objective for every workload. The recovery point objective states how much data loss the business will accept, and the recovery time objective states how long the business will accept being down. **Trade-off:** Setting objectives forces a business conversation up front, but without them every later resilience decision rests on assumption.

- **Workload tiers:** Define a small number of tiers, such as Gold, Silver, and Bronze. A top tier might demand near-zero data loss and fast automatic recovery for a system such as a core transaction database. A lower tier might accept several hours of data loss for a system such as an internal reporting server. The tier a workload lands in decides how far its protection must reach, from backup alone up to full region recovery. **Trade-off:** Fewer tiers keep classification simple but can over-protect a middle workload, so size the tiers to your real portfolio. Assigning an application to a higher tier than it needs will incur additional costs and reduce the capacity available for other applications.

### 6.3 Availability zone protection standard

Decide how far you protect against the loss of an availability zone, which is one physically separate group of datacenters inside a region. The answer differs by generation, so make the generation explicit in your standard.

- **Gen 2:** A Gen2 private cloud runs in a single availability zone. You can pick the zone so the private cloud sits close to related Azure resources, or you can let Microsoft place it. Either way, a single-zone private cloud doesn't survive the loss of that zone. To protect a Gen2 workload against zone loss, deploy a second private cloud in another zone and establish a replication and failover method, which you design and operate yourself. Gen2 has no single-cluster option that spans two zones.

- **Gen 1:** Gen1 offers a stretched cluster, which spans two availability zones on one management surface and keeps synchronous copies of data in both. A stretched cluster carries a higher availability commitment, often expressed as 99.99 percent, but it needs at least six hosts across the two zones and scales in pairs, so it roughly doubles the host count and the cost. Virtual machines are replicated across vSAN datastores in both halves of the cluster. The AV64 host type that Gen2 uses doesn't support stretched clusters. Approve a Gen1 stretched cluster only when a documented business or regulatory requirement demands zone resilience inside a single region, and remember that it's a high-availability feature, not a substitute for the cross-region recovery covered next. Document this position centrally so teams don't negotiate stretched clusters case by case. For the Gen1 stretched-cluster requirements, see [Deploy vSAN stretched clusters](/azure/azure-vmware/deploy-vsan-stretched-clusters).

### 6.4 Multi-region recovery standard

Because neither a single-zone Gen2 cloud nor a Gen1 stretched cluster survives the loss of a full region, decide next which workloads need a second region. This question is the most common concern teams raise, so make the standard explicit.

- **Option 1. Single-region posture.** A single-region posture keeps cost and complexity lower and suits a workload the business can rebuild or briefly lose during a regional event. If you define your workloads with tiers for resiliency and availability, such as Gold, Silver, and Bronze, map lower tier (bronze) to a single region. **Trade-off:** You carry no second-region cost, but the workload can't survive a regional disaster.

- **Option 2. Dual-region posture.** A dual-region posture places a second private cloud in another region and replicates protected workloads to it. This setup is the only way to meet a recovery objective that survives a regional disaster. Require your top tiers (Gold and Silver) to adopt dual region. Choose a secondary region that meets your latency and regulatory needs. Some regions operate in pairs, where updates are staggered and regions aren't updated simultaneously. This setup can provide extra protection where available. **Trade-off:** Dual region protects against a regional outage, but it adds a second site to fund and operate.

See [Azure paired regions](/azure/reliability/cross-region-replication-azure) and [Business continuity and disaster recovery for Azure VMware Solution](/azure/cloud-adoption-framework/scenarios/azure-vmware/eslz-business-continuity-and-disaster-recovery).

### 6.5 Secondary site capacity

Decide the standing capacity you keep at the secondary site, because that choice controls most of your recovery spend. Full duplicate capacity in a second region is rarely justified outside the highest tier. Allow the secondary site to run as a pilot light, meaning it holds only the core components at minimal capacity and scales out when a failover actually happens.

To make pilot light work, secure host capacity at the secondary site in advance, so scale-out isn't blocked by capacity limits during the incident itself. Set this standing-capacity policy by tier, and have finance and operations revisit it each year as workload counts change.

**Trade-off:** A pilot light cuts standing recovery spend, but it adds scale-out time to your recovery. Reserve full standby capacity only for the highest tier. To reserve host quota in advance, see [Request host quota for Azure VMware Solution](/azure/azure-vmware/request-host-quota-azure-vmware-solution).

### 6.6 Recovery topology standard

Choose the recovery target for each tier, because it drives the tooling, networking, and cost. Two targets are common. Publish an approved matrix that maps each tier to its allowed target and keeps teams from relitigating the choice.

- **Option 1. Recovery to a second Azure VMware Solution site.** Recovery from one Azure VMware Solution site to another in a second region preserves the full VMware operating model. This target fits a workload that depends on vSphere or NSX features. **Trade-off:** You keep the same operating model, but you hold VMware-capable capacity at the secondary site, which costs more in steady state.

- **Option 2. Recovery to native Azure virtual machines.** Recovery converts the machines to native Azure virtual machines at recovery time. This target usually costs less to hold in steady state. It fits a workload that can tolerate a platform change during a disaster. **Trade-off**: You pay less to stand by, but the machine changes platform at recovery. Validate that the workload runs correctly and securely as a native Azure virtual machine. It's critical to ensure a recovery event is fully covered by all network security controls and doesn't compromise the security baseline. Ensure that policies automatically apply security and governance controls to newly recovered virtual machines.

### 6.7 Secondary site network and identity standard

A recovery plan only works when the secondary site can address and authenticate the recovered workloads. Set these standards as part of platform readiness rather than at incident time.

- **IP addresses:** Set an IP addressing standard for the secondary site. The simpler default gives each region its own distinct address space and relies on the recovery tool to remap addresses at failover. This default reduces engineering effort but needs applications that tolerate an address change. Retaining the source addresses at the secondary site simplifies application configuration after failover. However, it needs isolated network segments, routing changes at failover time, and far more automation. Reserve address retention for the few legacy applications that can't accept an address change. **Trade-off:** Distinct address spaces cut engineering effort but need address-tolerant applications. Retained addresses ease application configuration but demand far more automation. For dual-region network design, see [Dual-region network topology](/azure/cloud-adoption-framework/scenarios/azure-vmware/eslz-dual-region-network-topology).

- **Foundational services:** Mandate foundational services at the secondary site. For example, if you need Active Directory domain controllers, they must exist at the secondary site so recovered workloads can authenticate. If you use Microsoft Entra Connect or Cloud Sync, design the sync service to keep working when the primary domain controllers are offline. Your DNS and certificate services need the same treatment, and so does your time source. Publish the list of foundational services every recovery design must include. Require platform teams to confirm their presence before a workload is called recovery-ready. **Trade-off:** Standing services at the secondary site add cost, but recovered workloads can't authenticate or resolve names without them.

- **Connectivity:** Establish inter-site connectivity as a Day 0 requirement. For a Gen2 private cloud, connect the two virtual networks across regions, such as through virtual network peering, because Gen2 lives natively in your virtual network. For a Gen1 private cloud, ExpressRoute Global Reach between the backend circuits provides the same primary-to-secondary path. For two private clouds in the same region, Azure VMware Solution Interconnect links their networks. The platform team must confirm that the routed address space in each doesn't overlap. Audit connectivity regularly, because discovering a gap during a real disaster is common and avoidable. **Trade-off:** Setting up and auditing connectivity ahead of time takes effort, but finding the gap during a real disaster is far more costly. See [Connect multiple private clouds in the same region](/azure/azure-vmware/connect-multiple-private-clouds-same-region).

### 6.8 Disaster recovery tooling standard

Approve a short list of recovery tools and prohibit ad hoc choices. Tool sprawl drives up your licensing and training costs and slows incident response. Pick one primary tool per recovery target, and document an exception path.

- **Option 1. VMware Live Recovery for site-to-site recovery.** VMware Live Recovery orchestrates failover between Azure VMware Solution sites and handles both partial and full recovery. **Trade-off:** A single orchestration tool keeps drills consistent, but it adds licensing that you standardize and fund centrally.

- **Option 2. Zerto or JetStream for the highest tier.** Both use continuous data protection, which suits the top-tier systems that can't tolerate measurable data loss. **Trade-off:** Continuous data protection reaches near-zero data loss, but it costs more and adds a component to run, so reserve it for the top tier.

- **Option 3. Azure Site Recovery for recovery to native Azure virtual machines.** Azure Site Recovery is the right tool when the recovery target is native Azure virtual machines. To set it up, see [Set up Azure Site Recovery for Azure VMware Solution](/azure/site-recovery/avs-tutorial-prepare-azure). **Trade-off:** It fits the native-Azure target at lower standby cost, but it doesn't preserve the VMware operating model.

- **Option 4. VMware HCX for smaller estates only.** HCX offers a low-cost option for smaller estates but needs significant manual orchestration, so it doesn't suit large production environments. **Trade-off:** HCX lowers tooling cost, but its manual orchestration slows recovery and doesn't scale to large production estates.

See [Disaster recovery solutions for Azure VMware Solution](/azure/azure-vmware/ecosystem-disaster-recovery-vms) and [Set up Azure Site Recovery for Azure VMware Solution](/azure/site-recovery/avs-tutorial-prepare-azure)

### 6.9 Backup standard

Zone and region protection guard against infrastructure loss, but they don't undo a bad change or recover a corrupted database. Backup is mandatory for every tier. Govern backup as a platform capability, not a per-workload afterthought.

- **Backup solution:** Designate one backup product as the organizational standard and fund it centrally. Require every workload to use it. Options include Microsoft Azure Backup Server and certified partner solutions. **Trade-off:** One standard product limits team choice, but it makes backup coverage uniform and auditable.

- **Data backup cadence:** Require a regular schedule and separate backup storage. Back up every workload on a regular schedule, and land backups in storage separate from the private cloud, so a failure of the cloud doesn't take the backups with it. Ensure that your backup storage has zonal or regional replication enabled, if necessary. For a database or other stateful system, require application-consistent snapshots so a restored copy comes back usable rather than mid-transaction. Set this as a non-negotiable baseline that applies even to single-region lower-tier workloads. **Trade-off:** Separate storage and application-consistent snapshots add cost and setup, but backups stored with the cloud can be lost with it, and a crash-consistent copy can restore unusable.

- **Backup scope:** Don't back up the platform's own management components. Microsoft backs up the management components such as vCenter Server and NSX Manager and restores them through an Azure support request, so teams focus their backup investment on the guest workloads they own. Open an [Azure support request](/azure/azure-portal/supportability/how-to-create-azure-support-request) if needed.

- **Backup configuration:** Configure protection automatically rather than machine-by-machine. If you use Azure Backup Server, its vCenter integration discovers the virtual machines that vCenter Server manages, so you can protect workloads automatically. If you use a third-party product, check whether it offers equivalent vCenter Server integration and configure automatic assignment of backup policies. **Trade-off:** Virtual machines are auto-assigned to backup policies based on rules such as folder placement. If you have different workloads with different backup requirements, policy assignment might require manual intervention. Newly created virtual machines remain unprotected until the next discovery cycle.

### 6.10 Recovery testing standard

A recovery plan you didn't exercise is an assumption, not a capability. Mandate testing and tie funding to evidence of successful drills.

- **Recovery drill cadence:** Require at least one full recovery drill a year for every top-tier workload. Run lighter smoke tests more often, and use the automated recovery plans in VMware Live Recovery or your chosen partner tool to keep manual effort low during a drill. **Trade-off:** Drills take time and coordination, but an untested plan drifts from a commitment to an aspiration you discover only during a real incident.

- **Recovery drill report:** Report each drill outcome to executive leadership. Include the measured recovery time and recovery point along with any gaps the drill found, and fund the fixes as a first-class platform investment.

- **Recovery destination network:** You can choose to bring up your test recovery in an isolated network, or on a connected network. 
  - An isolated network lets you confirm that the virtual machine starts and that data is intact. But, you may not be able to test application components that rely on external services. 
  - A connected network will allow you to perform full application testing, but requires careful configuration to ensure it does not interfere with production workloads.

## Next step

> [!div class="nextstepaction"]
> [Migration to Azure VMware Solution](./migration.md)