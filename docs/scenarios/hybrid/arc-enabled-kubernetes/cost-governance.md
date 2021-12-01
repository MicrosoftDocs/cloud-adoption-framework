---
title: Cost governance for Azure Arc-enabled Kubernetes
description: Understand the design considerations and recommendations for cost management and governance of Azure Arc-enabled Kubernetes.
author: sebassem
ms.author: sebassem
ms.date: 11/15/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: e2e-hybrid, think-tank
---


# Cost governance with Azure Arc-enabled servers
Cost governance is the continuous process of implementing policies to control costs of services you are using on Azure. This document will walk you through the various cost governance considerations and recommendations when using Azure Arc-enabled Kubernetes.


## How much does Azure Arc-enabled Kubernetes cost?
Azure Arc-enabled Kubernetes provides two types of services:
1. Azure Arc control plane functionality, which is provided at no extra cost including:
   - Resource organization through Azure management groups and tags.
   - Searching and indexing through Azure Resource Graph.
   - Access control through Azure RBAC at subscription or resource group level.
   - Automation through templates and extensions.

2. Azure services used in conjunction to Azure Arc-enabled Kubernetes (but not limited to), which incur costs according to their usage including:
   - Kubernetes Configuration
   - Azure Policy for Kubernetes
   - Azure Monitor for Containers
   - Microsoft Defender for Containers

> [!Note]
> If the Azure Arc-enabled Kubernetes cluster is on Azure Stack Edge, AKS on Azure Stack HCI, or AKS on Windows Server 2019 Datacenter, then Kubernetes configuration is included at no charge

## Design considerations
- **Governance:** Define a governance plan for your hybrid clusters that translates into Azure Policies, tags, naming standards and least-privilege controls.
- **Azure Monitor for Containers:** [Azure Monitor for Containers](/azure/azure-monitor/containers/container-insights-overview) gives you performance visibility by collecting memory and processor metrics from controllers, nodes, and containers that are available in Kubernetes through the Metrics API. Container logs are also collected. **[Missing]Pricing information**
- **Microsoft Defender for Cloud (formerly known as Azure Security Center):**  Microsoft Defender for Cloud is offered in [two modes](/azure/defender-for-cloud/enhanced-security-features-overview#what-are-the-benefits-of-enabling-enhanced-security-features):

   **Without enhanced security features (Free)** - [Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction) is enabled for free on all your Azure subscriptions when you visit the workload protection dashboard in the Azure portal for the first time, or if enabled programmatically via API. Using this free mode provides the secure score and its related features: security policy, continuous security assessment, and actionable security recommendations to help you protect your Azure resources..

   **Defender for Cloud with all enhanced security features (Paid)** - Enabling [Microsoft Defender for Cloud](/azure/defender-for-cloud/enhanced-security-features-overview) enhanced security extends the capabilities of the free mode to workloads running in private and other public clouds, providing unified security management and threat protection across your hybrid cloud workloads.

- **Kubernetes configuration:** [Kubernetes Configuration](/azure/azure-arc/kubernetes/conceptual-configurations) delivers configuration management and application deployment using GitOps. With this capability, cluster admins can declare their cluster configuration and applications in Git. The development teams can then use pull requests and the tools they are familiar with (existing DevOps pipelines, Git, Kubernetes manifests, Helm charts) to easily deploy applications onto Azure Arc enabled Kubernetes clusters and make updates in production. Billing is based on the number of vCPUs/hour in the cluster and is charged monthly. Clusters incur a single charge for configuration management no matter how many repositories are connected.
>[!Note]
>Clusters can function without a constant connection to Azure. When disconnected, each cluster’s charge will be determined based on the last known number of vCPUs that were registered with Azure Arc. If your cluster will be disconnected from Azure and you don’t want to be charged for Kubernetes Configuration, you can delete the configurations. The vCPU count is updated every 5 minutes when connected. The first 6 vCPUs are included at no cost.

- **Azure Policy for Kubernetes:** [Azure Policy for Kubernetes](/azure/governance/policy/concepts/policy-for-kubernetes) extends Gatekeeper v3, an admission controller webhook for Open Policy Agent (OPA), to apply at-scale enforcements and safeguards on your clusters in a centralized, consistent manner. Azure Policy makes it possible to manage and report on the compliance state of your Kubernetes clusters from one place. **[Missing]Pricing information**
- **Microsoft Sentinel:** Microsoft Sentinel provides intelligent security analytics across your enterprise. The data for this analysis is stored in an Azure Monitor Log Analytics workspace. Microsoft Sentinel is billed based on the volume of data ingested for analysis in Azure Sentinel, and stored in the Azure Monitor Log Analytics workspace for your Azure Arc-enabled servers.
## Design recommendations
Here are some general design recommendations for Azure Arc-enabled servers cost governance:
### Governance
- Ensure that all Azure Arc-enabled Kubernetes clusters follow proper [naming and tagging conventions](/azure/cloud-adoption-framework/ready/azure-best-practices/naming-and-tagging).
- Use least privilege RBAC by assigning **[Kubernetes Cluster - Azure Arc Onboarding](/azure/role-based-access-control/built-in-roles#kubernetes-cluster---azure-arc-onboarding)** to only administrators who will on-board Azure Arc-enabled Kubernetes clusters to avoid unnecessary costs.
- Use least privilege RBAC by assigning builtin roles to administrators managing the Azure Arc-enabled Kubernetes clusters to avoid unnecessary costs.

| Role  | Description  |
|---|---|
| [Azure Arc Enabled Kubernetes Cluster User Role](/azure/role-based-access-control/built-in-roles#azure-arc-enabled-kubernetes-cluster-user-role)  | List cluster user credentials action.  |
| [Azure Arc Kubernetes Admin](/azure/role-based-access-control/built-in-roles#azure-arc-kubernetes-admin)  |  Lets you manage all resources under cluster/namespace, except update or delete resource quotas and namespaces.	 |
| [Azure Arc Kubernetes Cluster Admin](/azure/role-based-access-control/built-in-roles#azure-arc-kubernetes-cluster-admin)  | Lets you manage all resources in the cluster.	  |
| [Azure Arc Kubernetes Viewer](/azure/role-based-access-control/built-in-roles#azure-arc-kubernetes-viewer)  | Lets you view all resources in cluster/namespace, except secrets.	  |
| [Azure Arc Kubernetes Writer](/azure/role-based-access-control/built-in-roles#azure-arc-kubernetes-writer) | Lets you update everything in cluster/namespace, except (cluster)roles and (cluster)role bindings.  |

### Azure Monitor for Containers
- Review [recommendations for monitoring](./eslz-k8s-management-and-monitoring-arc-server.md) to decide on your monitoring requirements and review [Azure Monitor pricing](https://azure.microsoft.com/pricing/details/monitor/).

-  Decide on the [required logs and events](/azure/azure-monitor/containers/container-insights-agent-config) for the Azure Arc-enabled Kubernetes clusters to be collected in the Log Analytics workspace.
-  Use the [Azure Pricing Calculator](https://azure.microsoft.com/en-us/pricing/calculator/) to calculate an estimate of the Azure Arc-enabled Kubernetes monitoring costs for Azure Log Analytics ingestion, alerts and notifications.
  
![Azure Pricing Calculator](./media/pricing-calculator.png)

![Azure Pricing Calculator AZMon](./media/pricing-calculator-az-monitor.png)

- Use [Azure Cost Management and Billing](/azure/azure-monitor/usage-estimated-costs#azure-cost-management--billing) to have visibility on Azure Monitor costs.

![Azure cost management and billing](./media/Azure-cost-management-billing.png)

- Use [Log Analytics workspaces insights](/azure/azure-monitor/logs/log-analytics-workspace-insights-overview) solution to understand and monitor the collected logs and their ingestion rate on the Log Analytics workspace.

![Log Analytics insights](./media/Log-analytics-insights.png)

- Evaluate possible data ingestion volume reducing, Refer to this [Tips for reducing data volume](/azure/azure-monitor/logs/manage-cost-storage#tips-for-reducing-data-volume) documentation to help configure data ingestion properly.
- Consider how long to retain data on Log Analytics. Data ingested into Log Analytics workspace can be retained at no additional charge up to first 31 days. Consider general aspects to configure the [Log Analytics workspace level default retention](/azure/azure-monitor/logs/manage-cost-storage#workspace-level-default-retention) and specific needs to configure data [retention by data type](/azure/azure-monitor/logs/manage-cost-storage#retention-by-data-type), that can be as low as 4 days. Example: Usually, performance data doens't need to be retained longer, instead, security logs may need to be retained longer.
- To retain data longer than 730 days, consider using [Log Analytics workspace data export](/azure/azure-monitor/logs/logs-data-export).
- Consider using [Commitment Tier](/azure/azure-monitor/logs/manage-cost-storage#pricing-model) pricing based on your data ingestion volume.

### Microsoft Defender for Cloud (formerly known as Azure Security Center):
- Review the [recommendations for security and compliance](./eslz-k8s-security-governance-and-compliance.md)
- Review [Microsoft Defender for Containers pricing information](https://azure.microsoft.com/pricing/details/azure-defender/).
- Use Azure Resource Graph to review the number of cores you have for the Azure Arc-enabled Kubernetes clusters.

```python
Resources
| extend AgentVersion=properties.agentVersion, KubernetesVersion=properties.kubernetesVersion, Distribution= properties.distribution,Infrastructure=properties.infrastructure, NodeCount=properties.totalNodeCount,TotalCoreCount=toint(properties.totalCoreCount)
| project id, subscriptionId, location, type,AgentVersion ,KubernetesVersion ,Distribution,Infrastructure ,NodeCount , TotalCoreCount
| where type =~ 'Microsoft.Kubernetes/connectedClusters'
| order by TotalCoreCount
```
### Kubernetes configuration

### Azure Policy for Kubernetes

### Microsoft Sentinel
- Review [Azure Sentinel pricing](https://azure.microsoft.com/pricing/details/azure-sentinel/).
- Use the Azure Pricing Calculator to estimate [Azure Sentinel costs](/azure/sentinel/azure-sentinel-billing).

![Azure Sentinel costs](./media/azure-sentinel-costs.png)

- Use [Azure Cost Management and Billing](/azure/sentinel/azure-sentinel-billing#manage-and-monitor-azure-sentinel-costs) to have visibility on Azure Sentinel analysis costs.

![Azure Sentinel cost analysis](./media/Azure-cost-management-Sentinel.png)

- Review [data retention costs](/azure/sentinel/azure-sentinel-billing#data-retention-costs) for data ingested into the Log Analytics workspace used by Azure Sentinel.
- Filter the [right level of logs and events](/azure/azure-monitor/containers/container-insights-agent-config) for the Azure Arc-enabled Kubernetes clusters to be collected in the Log Analytics workspace.
- Use [Log Analytics queries](/azure/sentinel/azure-sentinel-billing#run-queries-to-understand-your-data-ingestion) and the [Workspace Usage Report workbook](/azure/sentinel/azure-sentinel-billing#deploy-a-workbook-to-visualize-data-ingestion) to understand your data ingestion trends.
- Create a [cost management playbook](/azure/sentinel/azure-sentinel-billing#use-a-playbook-for-cost-management-alerts) to send notification if your Azure Sentinel workspace exceeds your budget.
- Azure Sentinel integrates with other Azure services to provide enhanced capabilities. Review the [pricing details](/azure/sentinel/azure-sentinel-billing#costs-for-other-services) for these services.
- Consider using [Commitment Tier](/azure/sentinel/azure-sentinel-billing#set-or-change-pricing-tier) pricing based on your data ingestion volume.
- Consider [separating non-security](/azure/sentinel/azure-sentinel-billing#separate-non-security-data-in-a-different-workspace) operational data into a different Azure Log Analytics workspace.

### Azure Policy Guest Configuration
- Review the [recommendations for governance and compliance](./eslz-security-governance-and-compliance.md) and [Azure Policy Guest Configuration pricing](https://azure.microsoft.com/pricing/details/azure-arc/).
- Use Azure Cost Management to understand the Azure Policy Guest Configuration costs by filtering by the **Microsoft.HybridCompute/machines** resource type.
- All built-in Guest Configuration policies include a parameter that controls whether the policy will be assigned to Azure Arc-enabled servers machines. Review your policy assignments and set this parameter to "false" for policies that do not need to be evaluated on your hybrid servers.

![Azure policy costs](./media/Azure-cost-management-policy.png)
### Azure Key Vault
- Review [Azure Key Vault pricing](https://azure.microsoft.com/pricing/details/key-vault/).
- Use [Azure Key Vault insights](/azure/azure-monitor/insights/key-vault-insights-overview) to monitor certificate renewal and secrets operations on your Azure Arc-enabled servers.

![Azure Key Vault insights](./media/key-vault-insights.png)

## Next steps
Review the Cloud Adoption Framework [best practices and recommendations](/azure/cloud-adoption-framework/get-started/manage-costs) to efficiently manage your cloud costs.