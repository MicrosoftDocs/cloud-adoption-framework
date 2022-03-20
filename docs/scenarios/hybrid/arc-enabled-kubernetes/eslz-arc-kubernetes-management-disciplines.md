---
title: Management and monitoring for Azure Arc-enabled Kubernetes
description: Understand the design considerations and recommendations for management and monitoring of Arc-enabled Kubernetes.
author: chintalavr
ms.author: vchintala
ms.date: 11/15/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: e2e-hybrid, think-tank
---

# Management and monitoring for Azure Arc-enabled Kubernetes

This document provides key design considerations and recommendations to manage and monitor Azure Arc-enabled Kubernetes clusters to help you understand and design solutions for well architected operational excellence.

Use guidance provided in this document along with other critical design areas referenced throughout the document, to better understand related design considerations and recommendations to focus on management and monitoring aspects of Azure Arc-enabled Kubernetes.

## Architecture

It is important to understand Azure Arc-enabled Kubernetes architecture and [network connectivity modes](/azure/azure-arc/kubernetes/conceptual-connectivity-modes#understand-connectivity-modes) to make the right architectural decision to onboard on-premises or multicloud Kubernetes clusters to Azure Arc, manage, monitor, and meet organization architecture standards and operational desired state.

### Cluster management

The following architecture diagram shows different Azure Arc-enabled Kubernetes components and how they interact when onboarding and managing the on-premises or multicloud Kubernetes cluster in a fully connected network connectivity mode.

[ ![A diagram showing Azure Arc-enabled Kubernetes cluster management](./media/arc-enabled-kubernetes-cluster-management.png)](./media/arc-enabled-kubernetes-cluster-management.png#lightbox)


The following diagram shows [Azure Arc-enabled Kubernetes cluster access from anywhere](/azure/azure-arc/kubernetes/conceptual-cluster-connect) and how the components interact with each other to manage cluster using Azure RBAC.

[ ![A diagram showing Accessing Azure Arc-enabled Kubernetes anywhere](./media/arc-enabled-kubernetes-cluster-connect-network.png)](./media/arc-enabled-kubernetes-cluster-connect-network.png#lightbox)
### Cluster monitoring

The following architecture diagram shows Azure Arc-enabled Kubernetes cluster monitoring in a fully connected network connectivity mode.

[ ![A diagram showing Azure Arc-enabled Kubernetes cluster monitoring](./media/arc-enabled-kubernetes-cluster-monitoring.png)](./media/arc-enabled-kubernetes-cluster-monitoring.png#lightbox)

## Design considerations

- Review the [management design area](/azure/cloud-adoption-framework/ready/landing-zone/design-area/management) of the Azure landing zones to assess the impact of Azure Arc-enabled Kubernetes on your overall management model.

**Cluster onboarding:**

- Consider the recommendations provided in [resource organization critical design area](./eslz-arc-kubernetes-resource-organization.md) and [governance and security disciplines](./eslz-arc-kubernetes-governance-disciplines.md) when designing [enterprise scale landing zone subscriptions](/azure/cloud-adoption-framework/ready/landing-zone/#azure-landing-zone-conceptual-architecture) to onboard and manage Azure Arc-enabled Kubernetes cluster and the [extensions](/azure/azure-arc/kubernetes/extensions).
- Decide between [auto-upgrade versus manual upgrade Azure Arc-enabled Kubernetes agents](/azure/azure-arc/kubernetes/agent-upgrade#toggle-auto-upgrade-on-or-off-when-connecting-cluster-to-azure-arc) depending on the organization change management process and onboard on-premises or multicloud Kubernetes clusters to Azure Arc. If the decision is re-considered later, Azure Arc-enabled Kubernetes agents auto-upgrade management behavior can be changed any time after cluster is onboarded.
- Consider simplicity and minimizing of firewall or proxy management and design source and destination groups to manage [Azure Arc-enabled Kubernetes network firewall rules](/azure/azure-arc/kubernetes/quickstart-connect-cluster?tabs=azure-cli#meet-network-requirements). Refer to your on-premises or multicloud firewall or proxy management guidelines for more details.

**Cluster management:**

- Azure [Arc-enabled Kubernetes extensions](/azure/azure-arc/kubernetes/extensions) require  additional URLs allow access rules on firewalls or proxy. Depending on the extensions being installed, consider planning to accommodate additional URLs allow access rules to minimize change management timelines.
- If onboarding of on-premises or multicloud Kubernetes cluster is done with [auto-upgrade toggle off](/azure/azure-arc/kubernetes/agent-upgrade#toggle-auto-upgrade-on-or-off-when-connecting-cluster-to-azure-arc), to control agent upgrades, consider upgrading Azure Arc-enabled Kubernetes agents on a regular basis to stay up to date with latest product releases and avoid expensive upgrade process in the future.
- Consider using [GitOps](/azure/azure-arc/kubernetes/tutorial-use-gitops-flux2) to manage Arc-enabled Kubernetes agent and cluster extension updates to maintain consistent deployments across all clusters and environments. Review [CI/CD workflow using GitOps](./eslz-arc-kubernetes-cicd-gitops-disciplines.md) and [platform disciplines](./eslz-arc-kubernetes-automation-disciplines.md) critical design areas for detailed guidance.
- Consider using the [Azure Arc-enabled Kubernetes cluster connect](/azure/azure-arc/kubernetes/conceptual-cluster-connect) feature to connect to the _apiserver_ without requiring any inbound port to be enabled on the firewall. Review the [network connectivity critical design area](./eslz-arc-kubernetes-network-connectivity.md) to understand how this feature works.

**Cluster monitoring:**

- Review and consider the [supported configuration for Azure Monitor Container insights](/azure/azure-monitor/containers/container-insights-enable-arc-enabled-clusters?toc=/azure/azure-arc/kubernetes/toc.json#supported-configurations) with Azure Arc-enabled Kubernetes, and decide if Azure Monitor Container insights meet your business needs for monitoring Azure Arc-enabled Kubernetes clusters.
- Consider using dedicated Log Analytics workspace per region to collect logs and metrics from Azure Arc-enabled Kubernetes cluster to monitoring and reporting across multiple cluster in a specific environment. Review [Designing your Azure Monitor Logs deployment](/azure/azure-monitor/logs/design-logs-deployment) for additional details.
- Consider Azure Monitor [ITSM connector integration](/azure/azure-monitor/alerts/itsmc-overview) with your organization [IT service management] tools to raise incidents for Azure Monitor alerts and track issue resolution.
- When using [the semi-connected network connectivity mode](/azure/azure-arc/kubernetes/conceptual-connectivity-modes#understand-connectivity-modes), consider using private endpoints to connect to [Azure Log Analytics](/azure/azure-monitor/logs/private-link-design) workspaces through Azure ExpressRoute or VPN connectivity to collect logs and metrics from Azure Arc-enabled Kubernetes cluster and monitor.

## Design recommendations

**Cluster onboarding:**

- Use shared administration terminal server(s) to [install required tools](/azure/azure-arc/kubernetes/quickstart-connect-cluster?tabs=azure-cli#prerequisites) to maintain consistent tools and versions across all users to prevent issues deploying and managing Azure Arc-enabled Kubernetes cluster.
- Make sure administration terminal servers and on-premises or multicloud Kubernetes clusters are in the Allow list to access [Azure Arc-enabled Kubernetes required URLs](/azure/azure-arc/kubernetes/quickstart-connect-cluster?tabs=azure-cli#meet-network-requirements) to onboard and manage using Azure Arc control plane.
- Create a script to verify connectivity to the [Azure Arc-enabled Kubernetes required URLs](/azure/azure-arc/kubernetes/quickstart-connect-cluster?tabs=azure-cli#meet-network-requirements) from on the on-premises or multicloud Kubernetes cluster nodes to minimize effort troubleshooting and resolving connectivity issues.
- Create onboarding deployment script using [PowerShell](/azure/azure-resource-manager/templates/deploy-powershell) or [Bash](/azure/azure-resource-manager/templates/deploy-cloud-shell?tabs=azure-cli) to onboard Arc-enabled Kubernetes cluster and install cluster extensions to prevent issues and consistent deployment across all environments and clusters.

**Cluster management:**

- Certain [Azure Arc-enabled Kubernetes extensions](/azure/azure-arc/kubernetes/conceptual-extensions) requires [custom location](/azure/azure-arc/kubernetes/conceptual-custom-locations) to deploy extension pods and configuration. Only one custom location is supported per Kubernetes namespace. It is recommended to create each custom location in its own Kubernetes namespace and deploy Azure Arc-enabled Kubernetes extension that relies on the custom location, and in the same namespace.
- Use the fully-connected network connectivity model for your onboarded clusters and in case there is a need for [the semi-connected network connectivity mode](/azure/azure-arc/kubernetes/conceptual-connectivity-modes#understand-connectivity-modes), it is recommended to connect the cluster to Azure Arc at least once in 30 days to export billing data and once in 90 days to renew managed identity certificates, update Azure Arc-enabled Kubernetes resource and agents.
- Deploy [Open Service Mesh (OSM)](/azure/azure-arc/kubernetes/tutorial-arc-enabled-open-service-mesh) to get capabilities like mTLS security, fine grained access control, traffic shifting, monitoring with Azure Monitor or with open source add-ons of Prometheus and Grafana, tracing with Jaeger, integration with external certification management solution.

**Cluster monitoring:**

- Enable [Azure Monitor Container insights for Azure Arc-enabled Kubernetes clusters](/azure/azure-monitor/containers/container-insights-enable-arc-enabled-clusters) to collect logs and metrics to create dashboards and generate alerts for cluster related issues.
- Enable [recommended metric alert rules from Container insights](/azure/azure-monitor/containers/container-insights-metric-alerts) to receive notifications from Azure Monitor.
- Use [Azure Resource Graph](/azure/azure-arc/kubernetes/resource-graph-samples?tabs=azure-cli) or [Log Analytics queries](/azure/azure-monitor/logs/queries) to monitor cluster health and raise alerts.

  [ ![A screenshot showing Azure Arc-enabled Kubernetes cluster management](./media/arc-enabled-kubernetes-resource-graph-connected-cluster-status.png)](./media/arc-enabled-kubernetes-resource-graph-connected-cluster-status.png#lightbox)

## Next steps

For more information about your hybrid and multicloud cloud journey, see the following articles:

- Review the [prerequisites](/azure/azure-arc/kubernetes/quickstart-connect-cluster?tabs=azure-cli#prerequisites) for Azure Arc-enabled Kubernetes.
- Review [validated Kubernetes distributions](/azure/azure-arc/kubernetes/validation-program#validated-distributions) for Azure Arc-enabled Kubernetes.
- Review [Manage hybrid and multicloud environments](/azure/cloud-adoption-framework/scenarios/hybrid/manage).
- Review [Azure Arc-enabled Kubernetes network connectivity requirements](/azure/azure-arc/kubernetes/quickstart-connect-cluster?tabs=azure-cli#meet-network-requirements).
- Review [Connect an existing Kubernetes cluster to Azure Arc](/azure/azure-arc/kubernetes/quickstart-connect-cluster).
- Review [Upgrading Azure Arc-enabled Kubernetes agents](/azure/azure-arc/kubernetes/agent-upgrade).
- Review [Use Cluster Connect to connect to Azure Arc-enabled Kubernetes clusters](/azure/azure-arc/kubernetes/cluster-connect) to manage clusters.
- Experience Azure Arc-enabled Kubernetes automated scenarios with the [Azure Arc Jumpstart](https://azurearcjumpstart.io/azure_arc_jumpstart/azure_arc_k8s/).
- To learn more about Azure Arc, review the [Azure Arc learning path on Microsoft Learn](/learn/paths/manage-hybrid-infrastructure-with-azure-arc/).
- Review [Frequently Asked Questions - Azure Arc-enabled](/azure/azure-arc/kubernetes/faq) to get answers to most common questions.
