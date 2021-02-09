---
title: "Govern modern container solutions"
description: Extend governance practices to modern containers instances
author: BrianBlanchard
ms.author: brblanch
ms.date: 03/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
---

# Govern modern container solutions

The [cloud adoption framework provides a governance methodology](../../govern/index.md) to systematically and incrementally improve governance of your cloud portfolio. This article demonstrates how you can extend that standard governance approach to govern Kubernetes clusters that are deployed to Azure or other public/private clouds.

## Initial governance foundation

Governance starts with an [initial governance foundation often referred to as a governance MVP](../../govern/initial-foundation.md). That foundation deploys the basic Azure products required to deliver governance across your cloud environment.

The initial governance foundation focuses on the following aspects of governance:

- Basic hybrid network and connectivity
- Azure Role-based access control (RBAC) for identity and access control
- Naming and tagging standard for consistent identification of resources
- Organization of resources using resource groups, subscriptions, and management groups
- Azure Policy and Azure Blueprint to enforce governance policies

Each of these features of the initial governance foundation should be used to govern modern container solutions instances. But first, you will need to add a few key components to that initial foundation to apply [Azure Policy to your containers](https://docs.microsoft.com/azure/governance/policy/concepts/policy-for-kubernetes?bc=%252fazure%252fcloud-adoption-framework%252f_bread%252ftoc.json&toc=%252fazure%252fcloud-adoption-framework%252ftoc.json). Once enabled, you can use Azure Policy & your initial governance foundation to govern the following types of containers:

- [Azure Kubernetes Service (AKS)](/azure/aks/intro-kubernetes?bc=%252fazure%252fcloud-adoption-framework%252f_bread%252ftoc.json&toc=%252fazure%252fcloud-adoption-framework%252ftoc.json)
- [Azure Arc enabled Kubernetes](/azure/azure-arc/kubernetes/overview?bc=%252fazure%252fcloud-adoption-framework%252f_bread%252ftoc.json&toc=%252fazure%252fcloud-adoption-framework%252ftoc.json)
- [AKS Engine](https://github.com/Azure/aks-engine/blob/master/docs/README.md)

## Expand on governance disciplines

The initial governance foundation can then be used to expand on various disciplines of governance to ensure consistent, stable deployment approaches across all of your Kubernetes instances.

Governance of Kubernetes clusters can be looked at with _five_ distinct perspectives.

### Azure resource governance

The first is the Azure resource perspective. Ensuring that all clusters adhere to your organization's requirements. This includes concepts like network topology, private cluster, Azure RBAC roles for SRE teams, diagnostics settings, region availability, node pool considerations, container registry governance, load balancer options, AKS add-ons, diagnostics settings, etc. This governance ensures consistency in "look and feel" and "topology" of clusters in your organizations. This should also extend to post cluster deployment bootstrapping; e.g. what security agents must be installed and how they should be configured.

Snowflake clusters are hard to govern in any central capacity. Minimize discrepancies between clusters so that policies can apply uniformly and anomalous clusters are discouraged and detectable. This might also include technologies used to deploy the clusters, such as ARM, Bicep, or Terraform.

Azure Policy applied at management group/subscription level can help deliver a lot of these considerations, but not all.

### Kubernetes workload governance

Since Kubernetes is itself a platform, the second is the governance of what happens within a cluster. This would include things like namespacing guidance, network policies, Kubernetes RBAC, Limits, and Quotas. This would be governance applied to the workloads, less to the cluster. Every workload is going to be unique (as they are all solving for different business problems and will be implemented in various ways with various technologies). There might not be many "one size fits all" governance here, but should consider governance around OCI artifact creation/consumption, supply chain requirements, public container registry usage, image quarantining process, deployment pipeline governance.

Consider standardizing around common tooling and patterns as well, if practicable to do. Put forth recommendations on things like helm, service mesh, ingress controllers, GitOps operators, Persistent Volumes, and the like. Included in here would also be governance around the usage of pod managed identity and sourcing secrets from Key Vault.

Drive strong expectations around access to telemetry, to ensure workload owners have appropriate access to the metrics and data they need to improve their product, while also ensuring cluster operators have access access to system telemetric to improve their service offering. Data often needs to be cross correlated between the two, ensure governance policies are in place to ensure appropriate access when necessary.

Azure Policy for AKS applied at the cluster level can help deliver some of these, but not all.

### Cluster operator roles (DevOps, SRE)

The third is governance around cluster operator roles. How to SRE teams interact with clusters? What's the relationship between that team and the workload team. Are they the same? Cluster operators should have a clearly defined playbook for cluster triage activities -- how they access the cluster(s), from where they access the cluster(s), and what permissions they have on the cluster(s), and when are those permissions assigned. Ensure any distinctions are made in governance documentation, policy, and training material around workload operator vs cluster operator in this context. Depending on your organization they may be the same.

### Cluster per workload or many workloads per cluster

The fourth is governance on multi-tenancy. That is to say should clusters contain a "like grouping" of applications owned, by definition, all by the same workload team and represent a _single set_ of related workload components. Or should clusters be, by design, multi-tenant in nature with multiple disperate workloads and workload owners; running and governed like a managed service offering within the organization. The governance strategy is notably different for each, and as such you should govern that your chosen strategy is enforced. If you have to support both models, ensure your governance plan is clearly defined for which policies apply to which types of clusters.

This choice should have been made in [strategy](./strategy.md) as it has significant impact to staffing, budgeting, and innovation.

### Stay current efforts

The fifth is around operations, such as node image freshness (patching) and Kubernetes versioning. Who is responsible for node image upgrades, tracking applied patches, tracking and putting together Kubernetes and AKS CVEs remediation plans? Workload teams _need_ to be involved in validating their solution works on cluster upgrades, and if your clusters are not current, they will fall out of Azure support. Having a strong governance in place around "stay current" efforts is _critical_ in AKS, more so most other platforms in Azure. This will necessitate a very close working relationship with application teams and dedicated time by them, at least monthly, for workload validation to ensure clusters stay current. Ensure all teams taking a dependency on Kubernetes understands the requirements and cost of this ongoing effort, which will last as long as they are on the platform.

### Security baseline

The following best practices can help add to your initial security baseline, to account for security of your AKS clusters:

- [Secure pods](/azure/aks/use-pod-security-on-azure-policy?bc=%252fazure%252fcloud-adoption-framework%252f_bread%252ftoc.json&toc=%252fazure%252fcloud-adoption-framework%252ftoc.json)
- [Secure traffic between pods](/azure/aks/use-network-policies?bc=%252fazure%252fcloud-adoption-framework%252f_bread%252ftoc.json&toc=%252fazure%252fcloud-adoption-framework%252ftoc.json)
- [Authorized IP access for AKS API](/azure/aks/api-server-authorized-ip-ranges?bc=%252fazure%252fcloud-adoption-framework%252f_bread%252ftoc.json&toc=%252fazure%252fcloud-adoption-framework%252ftoc.json) if not using Private Clusters.

### Identity

There are also a number of best practices you can apply to your identity baseline to ensure consistent identity and access management across your kubernetes clusters:

- [Azure AD integration](/azure/aks/managed-aad?bc=%252fazure%252fcloud-adoption-framework%252f_bread%252ftoc.json&toc=%252fazure%252fcloud-adoption-framework%252ftoc.json)
- [RBAC and Azure AD integration](/azure/aks/azure-ad-rbac?bc=%252fazure%252fcloud-adoption-framework%252f_bread%252ftoc.json&toc=%252fazure%252fcloud-adoption-framework%252ftoc.json)
- [Managed identities in Kubernetes](/azure/aks/use-managed-identity?bc=%252fazure%252fcloud-adoption-framework%252f_bread%252ftoc.json&toc=%252fazure%252fcloud-adoption-framework%252ftoc.json)
- [Access other Azure resources with Azure AD pod identity](/azure/aks/use-azure-ad-pod-identity?bc=%252fazure%252fcloud-adoption-framework%252f_bread%252ftoc.json&toc=%252fazure%252fcloud-adoption-framework%252ftoc.json)

## Next step: Manage modern container solutions

The following list of articles will take you to guidance found at specific points throughout the cloud adoption journey to help you be successful in the cloud adoption scenario.

- [Manage modern container solutions](./manage.md)
