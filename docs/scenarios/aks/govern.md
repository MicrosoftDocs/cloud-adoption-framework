---
title: Govern modern application platform solutions
description: Extend governance practices to modern application platform instances
author: BrianBlanchard
ms.author: brblanch
ms.date: 03/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-aks
---

<!-- docutune:ignore "public container registry" -->

# Govern modern application platform solutions

The [Cloud Adoption Framework provides a methodology](../../govern/index.md) to systematically and incrementally improve governance of your cloud portfolio. This article demonstrates how you can extend your governance approach to Kubernetes clusters deployed to Azure or other public or private clouds.

## Initial governance foundation

Governance starts with an [initial governance foundation often referred to as a governance MVP](../../govern/initial-foundation.md). This foundation deploys the basic Azure products required to deliver governance across your cloud environment.

The initial governance foundation focuses on the following aspects of governance:

- Basic hybrid network and connectivity.
- Azure role-based access control (RBAC) for identity and access control.
- Naming and tagging standards for consistent identification of resources.
- Organization of resources using resource groups, subscriptions, and management groups.
- Azure Policy and Azure Blueprints to enforce governance policies.

Each of these features of the initial governance foundation can be used to govern modern application platform solution instances. But first, you'll need to add a few components to the initial foundation to apply [Azure Policy to your containers](/azure/governance/policy/concepts/policy-for-kubernetes?bc=/azure/cloud-adoption-framework/_bread/toc.json&toc=/azure/cloud-adoption-framework/toc.json). Once configured, you can use Azure Policy and your initial governance foundation to govern the following types of containers:

- [Azure Kubernetes Service (AKS)](/azure/aks/intro-kubernetes?bc=/azure/cloud-adoption-framework/_bread/toc.json&toc=/azure/cloud-adoption-framework/toc.json)
- [Azure Arc enabled Kubernetes](/azure/azure-arc/kubernetes/overview?bc=/azure/cloud-adoption-framework/_bread/toc.json&toc=/azure/cloud-adoption-framework/toc.json)
- [AKS engine](https://github.com/Azure/aks-engine/blob/master/docs/README.md)

## Expand on governance disciplines

The initial governance foundation can be used to expand on various disciplines of governance to ensure consistent, stable deployment approaches across all of your Kubernetes instances.

Governance of Kubernetes clusters can be looked at with five distinct perspectives.

### Azure resource governance

The first is the Azure resource perspective. Ensuring that all clusters adhere to your organization's requirements. This includes concepts like network topology, private cluster, Azure RBAC roles for SRE teams, diagnostics settings, region availability, node pool considerations, Azure Container Registry governance, Azure Load Balancer options, AKS add-ons, diagnostics settings, and so on. This governance ensures consistency in "look and feel" and "topology" of clusters in your organizations. This should also extend to post cluster deployment bootstrapping, such as what security agents must be installed and how they should be configured.

Snowflake clusters are hard to govern in any central capacity. Minimize discrepancies between clusters so that policies can apply uniformly and anomalous clusters are discouraged and detectable. This might also include technologies used to deploy the clusters, such as ARM, Bicep, or Terraform.

Azure Policy applied at management group/subscription level can help deliver a lot of these considerations, but not all.

### Kubernetes workload governance

Since Kubernetes is itself a platform, the second is the governance of what happens within a cluster. This would include things like namespace guidance, network policies, Kubernetes RBAC, limits, and quotas. This would be governance applied to the workloads, less to the cluster. Every workload is going to be unique, since they all solve different business problems and will be implemented in various ways with various technologies. There might not be many "one size fits all" governance practices, but you should consider governance around OCI artifact creation/consumption, supply chain requirements, public container registry usage, image quarantining process, deployment pipeline governance.

Consider standardizing around common tooling and patterns as well, if practicable to do. Put forth recommendations on technologies like Helm, service mesh, ingress controllers, GitOps operators, persistent volumes, and so on. Included in here would also be governance around the usage of pod managed identity and sourcing secrets from Key Vault.

Drive strong expectations around access to telemetry, to ensure workload owners have appropriate access to the metrics and data they need to improve their product, while also ensuring cluster operators have access to system telemetric to improve their service offering. Data often needs to be cross correlated between the two, ensure governance policies are in place to ensure appropriate access when necessary.

Azure Policy for AKS applied at the cluster level can help deliver some of these, but not all.

### Cluster operator roles (DevOps, SRE)

The third is governance around cluster operator roles. How to SRE teams interact with clusters? What's the relationship between that team and the workload team. Are they the same? Cluster operators should have a clearly defined playbook for cluster triage activities, such as how they access the clusters, from where they access the clusters, and what permissions they have on the clusters, and when are those permissions assigned. Ensure any distinctions are made in governance documentation, policy, and training materials around workload operator vs. cluster operator in this context. Depending on your organization they may be the same.

### Cluster per workload or many workloads per cluster

The fourth is governance on multitenancy. That is to say should clusters contain a "like grouping" of applications owned, by definition, all by the same workload team and represent a *single set* of related workload components. Or should clusters be, by design, multitenant in nature with multiple disparate workloads and workload owners; running and governed like a managed service offering within the organization. The governance strategy is notably different for each, and as such you should govern that your chosen strategy is enforced. If you have to support both models, ensure your governance plan is clearly defined for which policies apply to which types of clusters.

This choice should have been made during the [Strategy phase](./strategy.md) because it has significant impact to staffing, budgeting, and innovation.

### Stay current efforts

The fifth is around operations, such as node image freshness (patching) and Kubernetes versioning. Who is responsible for node image upgrades, tracking applied patches, tracking and putting together remediation plans for Kubernetes and AKS common vulnerabilities and exposures? Workload teams *need* to be involved in validating their solution works on cluster upgrades, and if your clusters are not current, they will fall out of Azure Support. Having a strong governance in place around "stay current" efforts is *critical* in AKS, more so most other platforms in Azure. This will necessitate a very close working relationship with application teams and dedicated time by them, at least monthly, for workload validation to ensure clusters stay current. Ensure all teams taking a dependency on Kubernetes understands the requirements and cost of this ongoing effort, which will last as long as they are on the platform.

### Security baseline

The following best practices can be added to your security baseline, to account for security of your AKS clusters:

- [Secure pods](/azure/aks/use-azure-policy?bc=/azure/cloud-adoption-framework/_bread/toc.json&toc=/azure/cloud-adoption-framework/toc.json)
- [Secure traffic between pods](/azure/aks/use-network-policies?bc=/azure/cloud-adoption-framework/_bread/toc.json&toc=/azure/cloud-adoption-framework/toc.json)
- [Authorized IP access for AKS API](/azure/aks/api-server-authorized-ip-ranges?bc=/azure/cloud-adoption-framework/_bread/toc.json&toc=/azure/cloud-adoption-framework/toc.json) if not using private clusters.

### Identity

There are many best practices you can apply to your identity baseline to ensure consistent identity and access management across your Kubernetes clusters:

- [Azure AD integration](/azure/aks/managed-aad?bc=/azure/cloud-adoption-framework/_bread/toc.json&toc=/azure/cloud-adoption-framework/toc.json)
- [RBAC and Azure AD integration](/azure/aks/azure-ad-rbac?bc=/azure/cloud-adoption-framework/_bread/toc.json&toc=/azure/cloud-adoption-framework/toc.json)
- [Managed identities in Kubernetes](/azure/aks/use-managed-identity?bc=/azure/cloud-adoption-framework/_bread/toc.json&toc=/azure/cloud-adoption-framework/toc.json)
- [Access other Azure resources with Azure AD pod identity](/azure/aks/use-azure-ad-pod-identity?bc=/azure/cloud-adoption-framework/_bread/toc.json&toc=/azure/cloud-adoption-framework/toc.json)

## Next step: Manage modern application platform solutions

The following articles will take you to guidance at specific points in the cloud adoption journey to help you be successful in the cloud adoption scenario.

- [Manage modern application platform solutions](./manage.md)
