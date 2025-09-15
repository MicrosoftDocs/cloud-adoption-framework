---
title: Strategy for adopting unified operations
description: Learn about strategic considerations of hybrid and multicloud operations.
author: stephen-sumner
ms.author: pnp
ms.date: 04/21/2021
ms.topic: conceptual
ms.custom: e2e-hybrid, think-tank
---

# Define a strategy for hybrid and multicloud operations

Hybrid cloud refers to a mix of on-premises/private infrastructure and public cloud services working together, while multicloud means using multiple cloud providers concurrently. Many enterprises today have siloed teams, distributed sites, and systems spread across on-prem datacenters and various clouds. The challenge is to unify these environments in a secure, well-managed way that enables modernization from cloud to edge. This guidance provides a prescriptive end-to-end framework for unifying and managing hybrid and multicloud environments with Azure as the central control plane.

We explain how Azure solutions, like Azure Arc, Azure Monitor, Azure Kubernetes Service, Microsoft Fabric, Azure IoT, and Azure Local, help consolidate control and modernize IT across all environments, while maintaining security and compliance. The goal is to establish a standard operational model that breaks down silos and delivers consistent practices everywhere. We’ll detail how to secure, manage, and modernize resources from cloud to edge, unifying previously isolated teams and systems under one Azure-driven strategy.

## Azure solutions for unified hybrid and multicloud operations

Azure provides the industry's most comprehensive platform for managing hybrid and multicloud environments. These solutions extend Azure's native capabilities to any infrastructure, enabling consistent operations regardless of where your workloads run.

| Azure solution | Strategic value for hybrid and multicloud operations |
| --- | --- |
| [Azure Arc](https://learn.microsoft.com/azure/azure-arc/) | Extends Azure's management and security to any infrastructure, on-premises or other clouds. Azure Arc projects existing servers, Kubernetes clusters, and databases into Azure Resource Manager as Azure resources, which enables consistent policy, RBAC, inventory, and monitoring. With Arc, you can secure, develop, and operate workloads with Azure services anywhere, which enables central policy, monitoring, and automation across diverse platforms. |
| [Azure Arc-enabled servers](https://learn.microsoft.com/azure/azure-arc/servers/overview) | Azure Arc-enabled servers lets you manage Windows and Linux physical servers and virtual machines hosted outside of Azure, on your corporate network, or other cloud provider. For the purposes of Azure Arc, these machines hosted outside of Azure are considered hybrid machines. The management of hybrid machines in Azure Arc is designed to be consistent with how you manage native Azure virtual machines, using standard Azure constructs such as Azure Policy and applying tags.|
| [Azure Arc-enabled Kubernetes](https://learn.microsoft.com/azure/azure-arc/kubernetes/overview) | Azure Arc-enabled Kubernetes allows you to attach Kubernetes clusters running anywhere so that you can manage and configure them in Azure. By managing all of your Kubernetes resources in a single control plane, you can enable a more consistent development and operation experience, helping you run cloud-native apps anywhere and on any Kubernetes platform. When the Azure Arc agents are deployed to the cluster, an outbound connection to Azure is initiated, using industry-standard SSL to secure data in transit. Clusters that you connect to Azure are represented as their own resources in Azure Resource Manager, and they can be organized using resource groups and tagging.|
| [Azure Monitor](https://learn.microsoft.com/azure/azure-monitor/) | Provides end-to-end observability across applications, infrastructure, and networks in every environment. Azure Monitor unifies metrics, logs, and traces (via Application Insights) from Azure and Arc-connected resources into one view, so teams get complete insight into distributed systems. This solution helps break down operational silos by allowing a single monitoring toolset for all workloads, whether running in Azure, on-premises, or other clouds, which improves cross-team visibility and faster troubleshooting. |
| [Azure Kubernetes Service (AKS)](https://learn.microsoft.com/azure/aks/) | Azure's managed Kubernetes platform for the deployment and scaling of containerized applications. AKS in Azure provides managed cluster operations and integrates with Microsoft Entra ID and Azure Monitor for consistency. Use AKS hybrid options (AKS on Azure Local/Azure Stack HCI, AKS on Windows Server, or AKS Edge Essentials for edge) and manage all Kubernetes clusters with Azure Arc for consistent governance. This solution enables teams to use a common Kubernetes-based approach for microservices in any location, which unifies the application platform and development processes. |
| [Microsoft Fabric](https://learn.microsoft.com/fabric/) | Unified SaaS analytics platform that combines data engineering, data warehousing, real-time analytics, data science, and business intelligence. Microsoft Fabric breaks down data silos by integration of data engineering, warehousing, Power BI, and analytics into one environment. In a hybrid context, Fabric integrates on-premises and multicloud data sources via connectors to deliver consistent analytics and governance. This unified data foundation means insights and BI dashboards can span across distributed sites, which is crucial for a modern data-driven organization. |
| [Azure IoT Operations](https://learn.microsoft.com/azure/iot-operations/) | A comprehensive IoT platform for the creation of interoperable solutions that bridge physical operations with the cloud. Azure IoT Operations (part of Azure's IoT suite, some capabilities may be in preview) lets you connect and manage IoT devices and edge gateways at scale, while it normalizes data and runs analytics at the edge. It integrates with Azure Arc for unified management of IoT infrastructure, so your operational technology (factories, retail stores, remote sites) can be secured and governed like the rest of IT. This solution unifies OT and IT teams, which brings previously siloed operational systems into the cloud-managed fold. |
| [Azure Local](https://learn.microsoft.com/azure/azure-local/) | Azure hybrid service (Azure Stack HCI is now part of Azure Local) that runs virtual machines, containers, and selected Azure services on customer-owned infrastructure. Azure Local integrates with Azure Arc for unified governance and is managed via Azure portal and familiar tools. This solution allows you to extend Azure capabilities to edge or local datacenters while you maintain control at your sites. Azure Local brings Azure's hybrid capabilities to wherever you need them, from factory floors to branch offices, and ensures those resources are part of your unified Azure management and security framework. |

With these Azure solutions, you can unify all IT elements: developers and operators share common tools, central IT gains visibility over all assets, and modernization initiatives (containers, data analytics, IoT, etc.) proceed in a coordinated manner. In the framework below, each step shows how to use these Azure capabilities to achieve a secure, well-managed, and modern hybrid/multicloud environment. This step-by-step approach will help break down silos and establish Azure as the backbone of your unified operations.

## Establish Azure as your unified control plane

The first step is to establish a clear strategy for hybrid and multicloud that aligns with your business goals and emphasizes unification. This ensures your cloud adoption is driven by business value (agility, resilience, cost optimization, innovation) rather than ad-hoc decisions. Key activities in this phase include defining drivers and vision, setting guiding principles, determining your cloud mix, and mapping Azure services to objectives.

## Define business drivers for hybrid and multicloud adoption

Start by identifying why your organization is adopting hybrid and multicloud. Business drivers provide focus and ensure the approach delivers measurable value. These drivers must link to concrete business outcomes or KPIs to guide decisions and prevent fragmented technology choices. Common drivers include:

- **Vendor flexibility**: Reduce dependence on any single provider to mitigate lock-in and allow cost optimization and best-of-breed service use. For example, avoid relying solely on one cloud’s features if an alternative could save cost or offer unique capabilities.
- **Business unit diversity**: Accommodate different teams, acquisitions, or subsidiaries that use various platforms. A unified strategy prevents operational silos and establishes central governance across all environments while respecting existing investments.
- **Compliance and data residency**: Meet regulatory mandates for data sovereignty or specific security controls. For instance, use Azure Local for sensitive workloads that must remain on-premises, while connecting to Azure cloud services for other data and applications.
- **Resilience and disaster recovery**: Improve availability by distributing workloads and establishing multi-environment failover. Design seamless recovery between Azure and secondary environments (other clouds or on-prem) with unified processes to ensure minimal downtime.
- **Performance optimization**: Place workloads closer to users or data sources to reduce latency. For example, deploy Azure Local instances in factory locations for real-time processing, while maintaining centralized coordination through Azure cloud services.
- **Modernization and innovation**: Use specialized cloud services to drive transformation. For example, use Azure’s AI services and Microsoft Fabric analytics while integrating data and apps across other clouds as needed.
- **Unifying silos**: Eliminate internal silos between infrastructure, cloud, and application teams. Establish common tools and processes, like Azure Arc for resource management, Azure Monitor for observability, to create shared visibility and collaboration across formerly isolated groups.

For each business driver, link it to a specific business outcome or KPI. For example, if a driver is “avoid downtime,” an outcome could be achieving 99.99% availability. If “support global expansion” is a driver, an outcome might be launching in a certain number of new countries within a year. If unifying silos is a goal, an outcome could be 20% reduction in operational overhead by unifying IT processes. Grounding drivers in outcomes ensures the strategy focuses on delivering measurable value. Document these drivers and desired outcomes clearly, as they will steer all subsequent decisions.

## Create a clear vision statement and establish success metrics

Craft a concise vision statement that describes the target state of your hybrid/multicloud environment and what success looks like. This provides direction and helps all stakeholders understand the end goal. The vision should articulate how the unified approach benefits the organization. For example:

- “Build an adaptive cloud platform that unifies all infrastructure and teams, enabling any app to run where it best meets business needs.” (Emphasizes flexibility and unity.)
- “Deliver consistent customer experiences with 100% uptime through multi-cloud resilience.” (Focuses on reliability and continuity.)
- “Increase deployment frequency by 50% by standardizing DevOps across cloud and on-premises.” (Focuses on agility and process improvement.)
- “Reduce on-premises footprint by 50% in two years to cut costs, while extending cloud management to all remaining on-prem assets.” (Emphasizes efficiency and cloud-first operations.)

Alongside the vision, define 2–5 key success metrics (KPIs) to measure progress. Each major driver from the previous step should map to at least one KPI. Make them specific and time-bound where possible. For example: if agility is a driver, a KPI might be “Provisioning time for infrastructure reduced from weeks to hours across all environments within 12 months.” If cost optimization is a driver, a KPI might be “Improve infrastructure utilization by 30% through cloud bursting and consolidation.” Include a security or compliance metric as well, such as “100% of resources across clouds compliant with baseline security policies measured via Azure Policy and Defender for Cloud.”

By setting a clear vision and metrics, you create a shared definition of success. This will align teams and provide a way to track the impact of your hybrid/multicloud initiative over time.

## Set principles for cloud choice

Establish guiding principles for deciding which cloud or environment to use for different workloads. Clear principles prevent random or preference-driven choices that could increase complexity. They also balance the desire for portability against the benefits of cloud-specific services. Develop guidelines such as:

1. **Determine cloud-neutral versus cloud-specific usage.** Determine where you will build cloud-agnostic solutions versus using cloud-native services. For each workload, decide if portability is critical. For example, for core systems of record you might prioritize neutrality, using technologies like containers, Kubernetes, or databases that run anywhere. In contrast, for customer-facing or innovation projects, you might use cloud-specific PaaS services, like Azure Cosmos DB or Azure AI services, to accelerate development.

2. **Use Azure as a unifying layer where possible.** Since we are focusing on Microsoft’s solutions, make Azure the central management and integration layer for all environments. Rather than maintaining parallel toolsets for each cloud, plan to manage other clouds through Azure, using Azure Arc. This way, even if workloads run in AWS or GCP, your operations and security remain centralized on Azure. For example, you might run some VMs on AWS, but onboard them to Azure via Arc and enforce policies through Azure, so your team manages them just like Azure resources. This principle ensures that you’re not “locked in” to each cloud’s management tools. Azure becomes the consistent overlay.

3. **Justify multicloud complexity.** A multicloud approach can introduce complexity, such as multiple skill sets, varying architectures, and potentially higher costs like data egress charges between clouds. Set a principle that using an additional cloud must have a clear justification. For instance: “Default to Azure for new deployments unless a unique capability or business requirement mandates otherwise. If a secondary cloud is used, integrate it through Azure and revisit its necessity periodically.” This intentional stance avoids a sprawl of unmanaged, siloed deployments on different platforms. In practice, it means if a developer proposes using a different data analytics technology, they must have a strong reason and plan to integrate it, such as via Azure data services for governance. Otherwise, they should use Azure’s analytics offerings like Microsoft
Fabric.

These principles provide architects and engineers with a decision framework. For example, when choosing a database service, the guidelines might steer them to an open-source database on an Azure VM for portability or to Azure’s PaaS database for functionality, rather than automatically picking a non-Azure service that doesn’t align with strategy. The overall aim is to encourage use of Azure as the backbone, minimize fragmentation, and only embrace multicloud elements when required.

## Select your cloud mix and designate Azure as your primary hub

Decide which cloud platforms including on-premises will be part of your strategy, and establish Azure as the central management hub from the start:

1. **Choose your cloud portfolio based on requirements.** Evaluate business and technical needs to decide the mix of cloud platforms. Many enterprises use multiple public clouds to satisfy different needs or legacy investments. Document which platforms you will use and why. Also determine what role on-premises infrastructure will play going forward. For example, you might use Azure for the majority of workloads and maintain on-prem systems for certain factory control systems using Azure Local. Be specific. Identify any critical workloads that must remain on-prem and plan to modernize them with Azure Local or Arc, and any exceptional cases for other clouds. Ensure this planned mix ties back to your drivers, such as using a secondary cloud for resilience or specialized capabilities.

2. **Make Azure your primary control plane for all environments.** Clearly state that Azure will serve as the main hub for managing resources across all clouds and on-prem. This is a key strategic decision because Azure offers strong hybrid management via Azure Arc and related services. By projecting AWS, Google Cloud, and on-prem resources into Azure for management, you centralize expertise and tooling. For example, use Azure as the single pane of glass for management and monitoring for your entire infrastructure. This means you will prefer managing AWS resources from Azure (Arc) rather than managing Azure resources from AWS tools. Azure’s cross-cloud capabilities (Arc, Microsoft Defender for Cloud, Azure Monitor) make it well-suited for this hub role, providing a degree of integration and consistency you won’t get if you try the reverse.

3. **Design your unified operating model.** Envision how IT operations will function in this hybrid/multicloud setup. Define processes that work across all environments. For instance: “All servers (Azure VMs, on-prem servers, AWS EC2) will be inventoried and configured via Azure Arc and Azure Policy. CI/CD pipelines in GitHub Actions/Azure DevOps will deploy applications to any target environment using approved templates. Our network operations will treat Azure as the hub linking other sites/clouds, and our security team will use Microsoft Sentinel to watch everything.” By describing this target operating model, you set expectations that silos, like separate ops teams for each cloud, will be replaced with unified operations. It prepares the organization for changes in day-to-day work and clarifies how consistency will be achieved.

4. **Establish unified teams to support cross-platform operations.** Document your strategic intent to cross-train teams and consolidate functions under common governance. For example: "We establish a Cloud Center of Excellence to govern all cloud usage (Azure and others) and train our traditional IT staff on Azure services so they can manage cloud resources with their existing on-premises knowledge." This signals that siloed teams (such as separate teams for IoT or each cloud platform) must work together under unified governance as you adopt this framework. The Azure Adaptive Cloud approach specifically supports team unification and process standardization across technology platforms.

## Map Azure services to your strategic objectives

As you conclude the strategy phase, identify the Azure services that will be instrumental in achieving your goals (many of which we outlined above). This ensures your strategy is actionable and aligned with Microsoft’s offerings:

| Technology stack area | Azure solution |
|----------------------|----------------|
| Hybrid and multicloud resource management | Azure Arc to project all infrastructure into a unified control plane |
| Identity and access management | Microsoft Entra ID as the unified identity system across all clouds through federation or synchronization |
| Observability and monitoring | Azure Monitor for consolidated visibility across all environments and Azure Automation or Azure Automanage for routine operations |
| Container orchestration and modernization | Azure Kubernetes Service (AKS) and Azure Container Apps for containerization, with Arc to manage Kubernetes clusters anywhere |
| Data analytics and intelligence | Microsoft Fabric to create a unified analytics layer across on-premises SQL, Azure Data Lake, and third-party cloud data sources |
| IoT and edge computing | Azure IoT Hub, Azure IoT Edge, and Azure IoT Operations to manage IoT devices and data, integrated with Arc for unified management |
| On-premises modern infrastructure | Azure Local for new hardware investments to ensure integration with Azure services |
| Security and compliance | Microsoft Defender for Cloud for multi-cloud security posture management (CSPM) and cloud workload protection (CWP) across Azure, AWS, and Google Cloud Platform, with Azure Policy (via Arc) to apply governance to Arc-enabled servers, Kubernetes clusters, and data services |

Document these service selections with specific use cases and required skills. For example, Microsoft Fabric implementation requires data engineers familiar with Power BI, while Arc-enabled Kubernetes deployment needs Kubernetes expertise. This technical blueprint guides skill development planning and implementation priorities while it ensures your strategy translates into concrete technology choices.

## Next step

By the end of Step 1, you should have a Hybrid/Multicloud Strategy Brief that captures:

- **Business drivers and scope**: "Global expansion and 24/7 uptime require multi-cloud; manufacturing sites require hybrid edge; need to unify IT."
- **Success metrics**: Quantifiable targets (cost savings, reliability, deployment speed, etc.).
- **Guiding principles**: On lock-in, cloud selection, use of Azure as hub, etc.
- **Cloud mix**: Which clouds and environments are in play, and which is primary (Azure).
- **Key Azure (and any other) technologies**: To be adopted for execution.

**Example strategy conclusion:**

"The organization pursues an adaptive hybrid/multicloud approach to unify IT operations while using the best capabilities of cloud.

**Business drivers**: Avoid downtime (target <1 hour/year), meet data residency in EU, and break down operational silos between datacenter and cloud teams to improve efficiency (target 20% OPEX reduction).

**Vision**: Azure is our primary cloud platform and control plane that integrates AWS resources and on-premises systems. We improve global coverage by use of Azure + one secondary cloud and local edge infrastructure for plants.

**Stance on vendor dependence**: Design core business systems to be cloud-agnostic (containers, multi-cloud DB) but allow cloud-native services for differentiating features (such as Azure AI for analytics).

**Cloud mix**: Remain ~50% on-premises (but on Azure Local) for legacy in short term, 40% Azure, 10% AWS for specialized use. Long term aim for 70% Azure, with on-premises modernized via Azure Local and minimal AWS usage.

**Key Azure technologies**: Azure Arc to unify resource management; Azure Monitor and Microsoft Defender for Cloud for end-to-end visibility; Azure Local to run Azure services on-premises; AKS for containerization; Microsoft Fabric to unify data analytics; Azure IoT for factory devices; Microsoft Entra ID for single identity; and DevOps pipelines (GitHub/Azure DevOps) for all deployments. Success is measured by meeting uptime and deployment frequency targets while maintaining security compliance across all platforms."

With this strategic foundation agreed upon by stakeholders, you have a north star to guide the detailed planning.
