---
title: "Migrate Workloads to Azure VMware Solution"
description: "Discover the recommended process for migrating VMware workloads to Azure VMware Solution. Learn planning, preparation, execution, and decommissioning steps for successful migration."
#customer intent: As a decision maker, I want to understand the recommended process for migrating my organization's workloads to Azure VMware Solution, including the key phases, decisions, and activities required for a successful migration.
author: stephen-sumner
ms.author: dsoderholm
ms.reviewer: ssumner
ms.date: 08/20/2026
ms.topic: concept-article
ai-usage: ai-assisted
---

# Migrate workloads to Azure VMware Solution

*This article provides guidance to help decision makers define their migration strategy for Azure VMware Solution, including planning, execution, and decommissioning phases.*

:::image type="complex" border="false" source="./images/azure-vmware-solution-adoption-process.svg" alt-text="Diagram showing the Microsoft Cloud Adoption Framework process for Azure VMware Solution adoption." lightbox="./images/azure-vmware-solution-adoption-process.svg":::
    Diagram showing the five phases of the Azure VMware Solution adoption process: Planning and readiness, Azure landing zone architecture, Governance and security baselines, Operational standards, and Migration. Each phase builds on the previous to prepare, govern, operate, and migrate workloads to Azure VMware Solution.
:::image-end:::

Azure VMware Solution provides a structured path for migrating VMware-based workloads to Azure with minimal application change. Success depends on more than moving virtual machines. Organizations need clear migration policies, workload assessment criteria, validation standards, and execution controls that reduce risk, maintain operational continuity, and support long-term platform objectives.

**Recommendation:** Define your migration strategy, workload assessment approach, migration sequence, and validation requirements before migrating workloads to Azure VMware Solution.

## 1. Migration planning

Before you design anything, build a clear picture of what you migrate, in what order, and why. Use the Cloud Adoption Framework Plan methodology to assess your estate. Azure VMware Solution fits a rehost approach best, where you need minimal disruption and no near-term modernization. It's not the right home for every application, and the planning phase is where you decide.

### 1.1 Discovery and inventory

[Azure Migrate](/azure/migrate/) scans your on-premises vSphere environment and builds an inventory of virtual machines, their resource use, and their dependencies. This data informs both sizing (how many hosts and which host type), and wave planning (which workloads move together). Azure Migrate doesn't perform the move into Azure VMware Solution. It gives you the evidence to size and sequence the project.

### 1.2 Migration strategy

Azure VMware Solution primarily supports the *rehost* approach. Applications that need a *refactor* or *rearchitect* treatment might be better served by Azure-native compute. Record these decisions so the plan reflects deliberate choices rather than defaults. See [Select a cloud migration strategy](/azure/cloud-adoption-framework/plan/select-cloud-migration-strategy#migration-strategy-overview).

### 1.3 Workload assessment

Not every workload is an equally suitable candidate for Azure VMware Solution. Before you assign workloads to migration waves, evaluate their technical requirements, operational dependencies, and platform fit. A structured assessment helps you identify risks early, validate suitability, and ensure that migration plans reflect business priorities rather than assumptions.

#### 1.3.1 Requirements

Before assigning a workload to a migration wave, assess the technical, operational, and business requirements that influence its success on Azure VMware Solution. This assessment helps you determine platform suitability, identify potential migration challenges, and provide the information needed for sizing, sequencing, and readiness decisions. When assessing each workload, focus on:

- **Performance requirements:** Understand CPU, memory, storage IOPS, and network throughput demands. Map these requirements to Azure VMware Solution host SKUs and vSAN storage policies, including RAID configuration and failures-to-tolerate (FTT) settings.

- **Application dependencies:** Identify which systems each workload communicates with. Dependencies determine your migration wave planning and whether dependent systems need to move together.

- **Compatibility requirements:** Confirm that guest operating systems and third-party software are supported on Azure VMware Solution. Most workloads that run on on-premises vSphere run on Azure VMware Solution without modification, but validate rather than assume, and ensure you test your rollback approach for problematic migrations.

- **Network requirements:** Document the network segments, IP addresses, DNS configurations, and firewall rules each workload requires. Identify latency-sensitive workloads and ensure that network architecture is optimized to support their demands.

#### 1.3.2 Workload treatment

Workload assessment identifies what a workload needs. Workload treatment determines what action to take. Decision makers should evaluate whether each application belongs on Azure VMware Solution, whether it should remain on-premises, or whether parts of the application are better served by Azure-native services. For each workload, determine:

- **Whether the workload belongs there.** Workloads that already run well on vSphere are natural candidates, especially those with no near-term modernization plan. For a workload heading for retirement or a SaaS replacement, weigh whether moving it adds value or whether it should stay in place until end of life.

- **Whether every tier belongs there.** A workload often has more than one tier, such as a web front end and a database. You can run the application virtual machines on Azure VMware Solution and connect them to Azure-native data services such as Azure SQL Database. That configuration gives you managed database benefits alongside your VMware workloads, and reduces your VMware host and license costs.

### 1.4 Migration readiness

Define the minimum operational, performance, security, and governance requirements that every workload must meet before you approve it for production use.

Apply a consistent validation framework across every migration wave. The framework should define required checks, approval criteria, and the evidence teams must provide before cutover approval. At a minimum, validate:

- HCX replication health

- NSX segment routability

- ESXi host health

- Identity and authentication reachability from the target segment
- Health of supporting services such as backup and monitoring

Decide whether teams must capture baseline performance metrics from the source environment before migration. These measurements provide a reference point for validating post-migration performance and identifying regressions.

Before cutover, require teams to determine whether external DNS records, load balancer configurations, application endpoints, or other connectivity dependencies require updates. Include all required changes in the wave cutover plan to reduce the risk of service disruption.

### 1.5 Azure VMware Solution migration sequence

Migration sequencing determines which workloads move to Azure VMware Solution first, second, and so on. Good wave planning reduces risk and avoids unnecessary disruption.

- **Group by dependency:** Use the dependency data from discovery to find sets of virtual machines that work closely together, such as an application server and its database. Move them in the same wave so traffic doesn't cross the network for every request when one part still waits on-premises.

- **Map existing rules:** Document any affinity or anti-affinity rules from your on-premises environment and plan how to reproduce them. Azure VMware Solution [placement policies](/azure/azure-vmware/create-placement-policy) enforce virtual-machine-to-host affinity, which matters for licensing constraints such as SQL Server and for strict performance needs.

- **Sequence by risk:** Start with lower-risk workloads such as non-production systems or applications with few dependencies. Your team builds confidence with the process before it takes on business-critical applications. Move to higher-complexity workloads as experience grows.

- **Align with network extension plans:** Base your sequence on your on-premises network layout. When several applications share a network segment, migrate them in the same wave or in consecutive waves. You can then cut the segment over to an Azure VMware Solution-native network promptly and remove the temporary extension.

### 1.6 Migration tooling

Use [VMware HCX](/azure/azure-vmware/install-vmware-hcx) to move workloads into Azure VMware Solution with minimal disruption. HCX Enterprise is included at no extra cost and installs by default, which unlocks options such as Replication Assisted vMotion and Mobility Optimized Networking. You don't need to use HCX, and you can also bring in physical workloads by using a [partner migration solution](/azure/azure-vmware/ecosystem-migration-vms).

#### 1.6.1 Migration approach

vMotion moves a running workload with no downtime, and on Generation 2 it generally performs faster than bulk methods. Replication-assisted and bulk migration can run slower on Generation 2 today, so plan longer windows and schedule waves accordingly. See [Azure VMware Solution Generation 2 private cloud design considerations](/azure/azure-vmware/native-network-design-consideration).

#### 1.6.2 Network extension governance

Some teams treat network extension as a permanent design. It's not. Keep extensions open only for the migration window. HCX network extension stretches an on-premises network into Azure VMware Solution at Layer 2, which lets workloads keep their existing addresses during the move. This design avoids reconfiguring applications up front, and it carries trade-offs that a decision-maker must govern.

- **On-premises dependency.** An extended network usually keeps its gateway on-premises, so the workload still depends on the source site after it moves.

- **Inefficient routing.** Traffic can travel back to on-premises and return, a pattern called tromboning that adds latency and failure points.

Set a firm policy. Extend a network only when a workload can't change its address, and remove every extension once its workloads move. Assess your on-premises network first so you know which segments need extension and for how long. That assessment feeds both your wave plan and your extension timeline. Mobility Optimized Networking can reduce tromboning in specific cases, so confirm the supported configurations before you enable it. See [Configure HCX network extension](/azure/azure-vmware/configure-hcx-network-extension).

## 2. Migration preparation

The following deployment sequence reflects the dependencies between stages. Each step assumes the previous step is complete and validated.

1.  **Platform landing zone:** Ensure all required centralized networking, identity, security, and monitoring services are ready to integrate with Azure VMware workloads. Apply the governance and security baselines via Azure Policy to your management group hierarchy that help you achieve your compliance requirements. Generation 2 deploys into your virtual network, so a policy baseline that enforces strict rules on network security groups or route tables can block the deployment. Remove those specific policies from the private cloud's virtual network before you deploy, then reapply them afterward. Plan this exception into your baseline so governance doesn't stall the rollout.

2.  **Workload landing zones:** Place your workload landing zones (subscriptions) under the correct management group, online or internal ("Corp").

3.  **IP address ranges:** Reserve a minimum /22 address block for the private cloud. On Generation 2, also reserve two additional /24 blocks for HCX management and uplink. Confirm that none of these ranges overlap your on-premises, Azure, or other cloud address space. You can't easily correct this condition after deployment. See [Generation 2 design considerations](/azure/azure-vmware/native-network-design-consideration).

4.  **Quota request:** Request quota early, because allocation can take up to five business days. Request enough for growth and disaster recovery, such as N+1 redundancy, which is one host beyond what the workload needs. Confirm the Portable VMware Cloud Foundation license that new deployments require. See [Request host quota](/azure/azure-vmware/request-host-quota-azure-vmware-solution).

5.  **Azure VMware Solution private cloud deployment:** Provision the Generation 2 private cloud into its Azure virtual network. See [Create a Generation 2 private cloud](/azure/azure-vmware/native-create-azure-vmware-virtual-network-private-cloud).

6.  **Networking and identity configuration:** Peer the private cloud network to your hub and establish on-premises connectivity. Connect vCenter Server to your external identity source so administrators sign in with managed accounts instead of shared built-in credentials.

7.  **Monitoring and management:** Forward logs to your log management solution and configure Service Health alerts. Onboard guest virtual machines through [Azure Arc](/azure/azure-vmware/deploy-arc-for-azure-vmware-solution) so you can govern them with the same Azure tools you use elsewhere.

8.  **HCX install:** Install HCX and test site-to-site connectivity before you start the first wave.

## 3. Migration execution

Define what "done" means before each wave. A wave is complete when the workload is validated, the network extension is removed, and the application is healthy in its permanent state.

Define rollback criteria before each wave and test the rollback path before you migrate production systems. HCX supports reverse migration, and the exact approach depends on the migration type you used. Wave success criteria include:

1.  Every virtual machine in the wave runs on Azure VMware Solution and no longer depends on network extension for production traffic.

2.  Every application is reachable by its users and its dependent systems.

3.  Every virtual machine appears in your monitoring tools with no warnings or errors.

4.  Rollback is no longer needed and you can formally close it out.

5.  Application performance matches or beats the baseline.

6.  The workloads meet your security and compliance requirements.

7.  The workload has been successfully onboarded to backup and disaster recovery solutions. 

## 4. Migration evaluation and decommission

Migration doesn't end when workloads power on in Azure VMware Solution. Validate that workloads operate correctly in their new environment, confirm that temporary migration accommodations are removed, and formally retire source infrastructure. Leaving your on-premises infrastructure in place can result in undiscovered and undocumented dependencies. A disciplined evaluation and decommission process ensures the organization realizes the expected benefits of migration without carrying unnecessary operational costs or risk.

### 4.1 Post-cutover production readiness

Mandate post-cutover criteria that confirm the workload behaves as expected. Check network reachability and name resolution. Check application function and communication with dependent systems. After each virtual machine moves, confirm it starts, that its resources match plan, and that the correct storage policy applies. Compare performance to the pre-migration baseline.

Decide your parity policy. The key decision is whether a migrated workload must reach full parity with the on-premises state before you call it production-ready, or whether you allow temporary deviations. Many organizations demand immediate performance parity for customer-facing systems but grant internal applications a short stabilization period with a fixed remediation deadline.

### 4.2 Connectivity validation

Validate connectivity end to end across Azure VMware Solution, Azure, on-premises, the internet, and name resolution. Run application smoke tests to confirm the workload serves its purpose. Confirm whether external name records or load balancer settings need updates as part of cutover.

If you built a secondary instance of Azure VMware Solution for disaster recovery, ensure that it's reachable from both the primary instance and from any clients or supporting services that need to connect to it if it's activated.

### 4.3 Network extension dissolution

When every workload on an extended segment moves, remove the HCX Layer 2 extension and confirm that the Azure VMware Solution-native gateway routes correctly. Don't leave an extension in place longer than the migration needs.

### 4.4 Decommission source environment

Decommissioning formally releases source capacity, licenses, and operational coverage. Treat it as a governed handoff rather than a cleanup task. If you skip decommissioning, you pay for idle infrastructure and carry security exposure. Use [Decommission source workloads after migration to cloud](/azure/cloud-adoption-framework/migrate/decommission-source-workload) to set the order of operations, the retention period for source backups, the approvals needed to power off source systems, and the criteria for reclaiming licenses and hardware.

## Next steps

Workload design:
- [Azure VMware Solution application landing zone accelerator](https://github.com/Azure/Enterprise-Scale-for-AVS)
- [Azure VMware Solution design considerations](/azure/azure-vmware/native-network-design-consideration)

