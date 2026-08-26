---
title: Planning and organizational readiness for Azure VMware Solution
description: "Prepare your organization for Azure VMware Solution by defining ownership, governance, skills, and operating models before deployment."
#customer intent: As a decision maker, I want to understand the organizational, operational, and financial preparations required to successfully adopt Azure VMware Solution and operate it at scale.
author: stephen-sumner
ms.author: dsoderholm
ms.reviewer: ssumner
ms.date: 08/20/2026
ms.topic: concept-article
ai-usage: ai-assisted
---

# Planning and organizational readiness for Azure VMware Solution

*This article helps decision makers prepare their organization to run workloads on Azure VMware Solution by defining ownership, governance, skills, and operating models before deployment.*  

:::image type="complex" border="false" source="./images/azure-vmware-solution-adoption-process.svg" alt-text="Diagram showing the Microsoft Cloud Adoption Framework process for Azure VMware Solution adoption." lightbox="./images/azure-vmware-solution-adoption-process.svg":::
    The image shows a progresses through five phases connected by arrows: Planning and readiness, Azure landing zone architecture, Governance and security baselines, Operational standards, and Migration. Each phase builds on the previous phase to prepare, govern, operate, and migrate workloads to Azure VMware Solution.
:::image-end:::
  
Azure VMware Solution Generation 2 provides a VMware Cloud Foundation-based platform that allows organizations to run VMware workloads natively in Azure and integrate them with Azure services. Azure VMware Solution is most successful when organizations establish operating ownership, governance, skills, and financial accountability before deployment begins. Early decisions reduce migration risk and help teams operate the platform consistently as adoption scales. For organizations already running Azure VMware Solution Generation 1, these recommendations help guide modernization and operational alignment as Gen 2 becomes the preferred deployment model.

**Recommendation:** Define operating ownership, governance controls, skilling plans, licensing commitments, and cost management practices before deployment so teams can migrate workloads with confidence and operate the platform efficiently as adoption grows.

## 1. Deployment model

Azure VMware Solution is deployed as one or more private clouds. Each private cloud represents an operational, governance, and lifecycle boundary. A private cloud can host multiple workloads or be dedicated to a single workload depending on isolation, compliance, performance, and ownership requirements.

Organizations should determine whether workloads share private clouds or require dedicated environments before establishing an operating model. This decision influences ownership boundaries, operational responsibilities, cost allocation, and governance requirements. You should also review the [scalability limits](/azure/azure-resource-manager/management/azure-subscription-service-limits#azure-vmware-solution-limits) to ensure that your private cloud approach provides the required capacity for your workloads. The decision is how many private clouds your organization should operate.

- **One private cloud, many workloads.** Place workloads together when they share security requirements, operational ownership, and lifecycle goals. This approach keeps hosts well used and holds down cost. **Trade-off:** Shared workloads inherit the same maintenance windows, cluster resources, and failure impact, so a change or incident can affect all of them.

- **One private cloud, one workload.** Create a separate private cloud when isolation, a regulatory obligation, a performance guarantee, or an independent lifecycle justifies the added cost and management. **Trade-off**: Each extra private cloud carries its own minimum host count and management overhead, so add one only when a real requirement calls for it.

Consider how to provision non-production workloads, such as dev/test instances of your applications. You might choose to co-locate them on the same private cloud as the production workload, which makes them easier for a single application team to administer, but requires careful allocation of cluster resources so that production workloads maintain performance. Alternatively, you can create a dedicated private cloud for non-production workloads, where you can more aggressively overcommit resources to reduce costs, but different environments for the applications are spread across administrative boundaries.

## 2. Operating model

Before you deploy Azure VMware Solution, decide which team will own and operate it day to day. The right model depends on your organization’s size and scale, how your teams are structured, and whether different business units run different technology stacks. Choose the model that best matches how you already run shared platforms. Three common approaches are:

- **Platform-team owned:** A central platform team provisions and operates each Azure VMware Solution private cloud as a shared service. The platform team is responsible for the entire Azure platform landing zone, and takes on additional responsibility for VMware operations in Azure. Workload teams consume capacity without managing the underlying environment. Choose it when you already have an Azure platform team and want consistent configuration, networking, and monitoring across many application teams.

  - **When to choose:** This option is common among smaller organizations where the same teams manage multiple technologies. A single team having responsibility for the Azure platform and Azure VMware Service can reduce hand-offs between teams, but doesn't scale to very large and complex organizations or VMware estates.

  - **Trade-off:** Workload teams have less autonomy and depend on the platform team's responsiveness, and that team needs skills in both VMware and Azure.

- **Dedicated VMware hosting team:** A dedicated team owns Azure VMware Solution alongside your other VMware estates in your on-premises data centers or other public clouds. It consumes shared services from the Azure platform team, such as landing zones and identity, then offers the platform to application teams. Choose it when you already run VMware as a central service and want clear separation between Azure platform work and VMware operations. 

  - **When to choose:** If your organization has many VMware environments across different clouds or data centers, having a single VMware management team creates consistency for workload owners and developers. This option is also common where you have a very mature VMware environment with complex automation and management workflows, requiring deep VMware skills.

  - **Trade-off:** It depends on strong collaboration and well-defined boundaries between the Azure and VMware teams.

- **Decentralized ownership:** Each workload team or business-unit team owns and operates its own private cloud, consuming shared Azure services such as connectivity and identity but running VMware operations itself. Choose it for isolated environments or a business unit that needs autonomy for distinct requirements.

  - **When to choose:** If you have a loosely coupled organization where each business unit or subsidiary has significant autonomy, allowing workload administrators to manage their own platforms supports their ability to operate independently and doesn't slow down their productivity.

  - **Trade-off:** You add operational overhead and duplicate effort if several teams each run their own environment, and it's more difficult to maintain a single view of cost and security compliance.

Favor a central model when consistency and economies of scale matter most. Favor the workload-team model when autonomy and isolation matter more than standardization. Many large organizations combine models, where a platform or hosting team runs shared private clouds for most workloads and a few business units run their own for special cases.

## 3. Roles and responsibilities

Ownership responsibilities vary by operating model. The guidance that follows reflects common responsibilities that tend to apply across most Azure VMware Solution deployments. The following section uses the term "service owner" (platform team, dedicated VMware team, or decentralized team) to indicate the team accountable for operating the Azure VMware Solution platform chosen earlier.

### 3.1 Responsibilities by adoption phase

Different teams contribute to Azure VMware Solution adoption at different stages of the lifecycle. Defining responsibilities by phase helps organizations establish accountability early, coordinate decisions across teams, and avoid gaps that can delay deployment or increase operational risk.

- **Strategy phase:** Senior leadership defines business objectives and approves investment priorities. Finance and commercial teams develop the business case, forecast costs, and evaluate licensing and reservation commitments. The Azure platform team and VMware IT operations team validate feasibility, estimate sizing requirements, and determine whether workloads should use shared or dedicated private clouds.

<!-- -->

- **Organizational** **readiness phase:** The Azure platform team and VMware IT operations team assess readiness, identify skills gaps, and define the ownership model. The security administrator and identity administrator help establish identity, access control, compliance, monitoring, and lifecycle management requirements before deployment. As part of your organizational readiness, consider whether you have sufficient skills in both Azure and VMware, or whether an experienced partner is needed to help build your operational capabilities. A partner with Azure VMware Solution expertise can help reduce project risk and delays.

- **Architecture phase:** The network administrator leads connectivity and network design decisions. The identity administrator configures the vCenter Server identity model and administrative access. The Azure platform team establishes landing zones, governance controls, and platform connectivity. The security administrator defines security and monitoring requirements. The storage administrator participates when external storage services are required.

- **Operations phase:** The Azure platform team manages governance, landing zones, and shared Azure services. The VMware IT operations team manages private cloud operations, capacity, and platform lifecycle activities. Workload owners remain responsible for application performance and business outcomes. The security administrator maintains compliance oversight. Finance and commercial teams review utilization, cost allocation, reservations, and optimization opportunities.

- **Migration phase:** The VMware administration team and workload owners lead migration activities. The network administrator validates connectivity and application dependencies. The IT operations team and security administrator verify monitoring, backup, recovery, and security controls before production cutover. Application owners test and verify application performance and stability before and after migration.

### 3.2 Responsibilities by roles

Role-based responsibilities provide a more detailed view of the skills and functions required to plan, deploy, operate, and govern Azure VMware Solution. Organizations can assign these responsibilities to the same or different teams based on their operating model, but every responsibility should have a clearly identified owner.

*Table: Team and role mapped to responsibilities*

| Team or role | Responsibilities |
|---|---|
| VMware admin | Manage VMware private cloud resources and performance. Configure Azure VMware Solution services, including vCenter Server and Live Recovery. Maintain virtual machine images, templates, and snapshots. Manage VMware lifecycle operations. Plan for service changes, such as VMware software updates and Azure service notifications. Migrate application workloads from other VMware environments into Azure VMware Solution. |
| Network admin | Ensure that Azure VMware Solution is integrated to Azure, on-premises, and WAN networks. Design for performance, security, and reliability. Configure NSX-T, HCX, and vDefend Firewall. Plan network topology and layer 2 extension. |
| Storage admin | Design vSAN storage policies. Configure external storage services. Configure backup and data protection services. |
| Security admin | Recommend security baselines for Azure VMware Solution. Deploy and configure security services such as Defender for Servers and Sentinel. Assess ongoing risk assessments, security compliance, and alerts. |
| Identity admin | Configure Azure VMware Solution integration with Microsoft Entra ID and Active Directory Domain Services. Create custom roles for Azure VMware Solution administrators. Apply role-based access control (RBAC) permissions for Azure VMware Solution resources. |
| Cloud operations team | Design and configure monitoring and alerting policies. Deploy Azure Arc to VMware virtual machines. Configure Azure services such as Azure Update Manager and Guest Configuration. |
| Workload owners | Validate workload compatibility and configuration. Execute day-to-day administrative actions. Manage workload resource lifecycles. |
| Azure platform team | Design application landing zones to support Azure VMware Solution. Configure Azure Policy to support governance and security requirements. Manage centralized infrastructure-as-code deployment pipelines. |
| Senior leadership | Oversight of long-term cloud adoption goals. Provide funding and commercial authority. Resolve cross-team ownership and align priorities. Sponsor governance and operating model change. Own risk acceptance and architectural trade-offs.  |
| Business analysts | Capture and document business objectives. Map business outcomes to requirements. Track benefits and adoption success. Identify dependencies and constraints. Develop application treatments and align to cloud strategy. |
| Finance and commercial team | Create cost models, budgets, and financial controls. Track spend against business case assumptions. Advise on reservations, licensing, and commitment decisions. |

## 4. Azure VMware Solution skilling

Your ownership model and role assignments determine where you need skills and how deep they go. Aim for overlap in knowledge so your Azure and VMware people work as one team. Decide how you build the skills and where you focus them.

- **Align skilling with your operating model.** Use the three models in the previous section (Azure platform team-owned, VMware admin team-owned, or workload team-owned) to decide who will manage the Azure VMware Solution private cloud, who will consume it, and what permissions each group needs. Use your responsibilities mapping to create your team's skills and training plan.

- **Build shared understanding across teams.** Regardless of the ownership model, aim for overlap in knowledge between Azure and VMware teams. VMware administrators typically need enough Azure capability to operate Azure VMware Solution day to day (for example, using the Azure portal, CLI/PowerShell, Azure Monitor, and Azure Arc). Azure platform teams need to understand the VMware concepts that most affect integration. This understanding includes networking constructs, security boundaries, and monitoring. That understanding enables clean integration with application landing zones and effective use of Azure services such as Microsoft Foundry, SQL Database, and Storage Accounts.

Azure VMware Solution uses VMware vSAN for storage, VMware NSX for networking, and VMware HCX for migration. If your teams don't use these technologies today, they need targeted training before migration. Give administrators hands-on labs and current reference material. This guidance lowers execution risk. Focus training on these areas:

- **Networking.** Understand how NSX replaces VLAN-based networking and how HCX extends networks during migration. Before migrating, assess your on-premises VLANs, application dependencies, and traffic flows. Build knowledge of Azure networking concepts such as virtual networks, peering, routing, and Network Security Groups.

- **Identity.** Integrate Azure VMware Solution with Active Directory Domain Services and Entra ID. Ensure that you secure administrator privileges, and support application developers to use modern authentication services.

- **Security and compliance.** Understand how Azure VMware Solution integrates with Microsoft Defender for Cloud, Sentinel, and Azure Policy, and how compliance operates across VMware and Azure boundaries. Maintain vulnerability scanning and threat protection across platforms and endpoints.

- **Azure platform skills.** Build capability with Azure services used to operate and govern Azure VMware Solution, such as Azure Monitor, cost management, and the Azure portal and CLI.

- **Storage and backup.** Understand how vSAN provides primary storage, when external Azure storage services are appropriate, and how backup and data protection operate in Azure VMware Solution. Ensure that your disaster recovery needs are met with VM replication.

## 5. Broadcom licenses

You must purchase portable VMware Cloud Foundation (VCF) subscription licenses from Broadcom, in a *bring your own license* (BYOL) model. You need the correct number of VCF licenses to cover all the physical cores in the Azure VMware Solution private cloud. When you create an Azure VMware Solution private cloud, enter the license information as part of the deployment process. If you have an active reserved instance for license-included hosts, you might need to convert your licensing to VCF BYOL. Optional add-ons such as the VMware vDefend Firewall need their own Broadcom license. See [Use Portable VMware Cloud Foundation (VCF) on Azure VMware Solution](/azure/azure-vmware/vmware-cloud-foundations-license-portability).

## 6. Azure VMware Solution quota

Request host quota early. Azure VMware Solution needs approved host quota in your target region before you can provision a private cloud. Approval can take up to five business days and depends on region and host availability. Requesting late is a frequent source of schedule slip, so submit the request as soon as you know your region and host count. Also, the subscription must use an eligible plan such as an Enterprise Agreement or a Microsoft Customer Agreement. See [Request host quota for Azure VMware Solution](/azure/azure-vmware/request-host-quota-azure-vmware-solution).

## 7. Cost management and FinOps

Cost management for Azure VMware Solution differs from some other Azure resources because you pay for hosts regardless of how many virtual machines run on them. You must purchase VMware Cloud Foundation software licenses separately and apply them to the private cloud. You must also ensure you have the required licenses for other software, such as Windows Server and SQL Server.

When you deploy a cluster of at least three hosts, you can run as many virtual machines on it as its capacity allows, so cost efficiency comes from how densely you pack workloads onto hosts. You must decide the optimal utilization of resources to ensure that you maximize value from the platform without compromising workload performance. VMware tools such as Aria Operations can help with cluster resource optimization.

### 7.1 Cost allocation

Review how Azure VMware Solution affects your FinOps approach. You might charge all cluster costs to a single business unit, or allocate costs across business units based on how they use the platform. You can also allocate costs based on assigned resources (for example, the vCPU cores and memory allocated to each workload), which can encourage application owners to right-size their virtual machines. Azure Arc-enabled VMware vSphere can help with cost attribution by applying Azure resource tags to VMware virtual machines, such as application name, cost center, and owner.

Whether or not you cross-charge application teams for their consumption, you should have clear visibility of the costs of your Azure VMware Solution private clouds. Azure VMware Solution is most cost-efficient when clusters are well utilized. If CPU and memory utilization are low, your cluster might be oversized, which increases costs. Review utilization regularly and adjust cluster size as workloads change, while keeping enough headroom for expected growth. Defining a target range for CPU and memory utilization can help you optimize costs over time.

### 7.2 Cost forecasting 

To predict the costs of the Azure VMware Solution private cloud, calculate the number of hosts required. The host count is determined by the CPU, memory, and storage requirements for your virtual machines. Azure Migrate can help you calculate the number of hosts based on your virtual machine inventory. See [Migrate VMware VMs agentless with the Migration and modernization tool](/azure/migrate/tutorial-migrate-vmware).

When calculating your requirements, look at the demands of the virtual machines, not what is currently assigned. Azure Migrate helps you right-size the virtual machines by recommending the optimal CPU and memory assignment based on observed performance demands. Assigning more CPU and memory than a VM requires reduces the cost efficiency of the platform.

### 7.3 Compute commitments

Commit where demand is steady, stay flexible where it isn't. You can apply reserved-instance discounts to Azure VMware Solution with a one-year or three-year commitment for significant savings over pay-as-you-go. Combine the two, so you reserve hosts for core workloads and add pay-as-you-go hosts for temporary needs such as migration or seasonal demand. **Trade-off:** Reservations lock in spend, so check whether you can exchange them for other Azure services if your strategy changes. Remember that reserved and pay-as-you-go hosts both still need the correct VMware Cloud Foundation licenses. See [Reserved instances of Azure VMware Solution](/azure/azure-vmware/reserved-instance).

## Next step

> [!div class="nextstepaction"]
> [Architecture - Azure VMware Solution in an Azure landing zone](./architecture-landing-zone.md)