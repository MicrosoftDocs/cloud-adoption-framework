---
title: Cost governance for Azure Arc-enabled Kubernetes
description: Learn design considerations and recommendations for cost governance for Azure Arc-enabled Kubernetes.
author: sebassem
ms.author: sebassem
ms.date: 04/29/2022
ms.topic: conceptual
ms.custom: e2e-hybrid, think-tank, e2e-arc-enabled-kubernetes
---

# Cost governance for Azure Arc-enabled Kubernetes

Cost governance is the continuous process of implementing policies to control the costs of services you use in Azure. This document provides cost governance considerations and recommendations for you to keep in mind while using Azure Arc-enabled Kubernetes.

## Cost of Azure Arc-enabled Kubernetes

Azure Arc-enabled Kubernetes provides two types of services:

- Azure Arc control plane functionality, which is provided at no extra cost and includes:
  - Resource organization through Azure [management groups](/azure/governance/management-groups/overview) and [tags](/azure/azure-resource-manager/management/tag-resources?tabs=json).
  - Searching and indexing through [Azure Resource Graph](/azure/governance/resource-graph/overview).
  - Access control through [Azure role-based access control](/azure/role-based-access-control/overview) (RBAC) at the subscription or resource group level.
  - Automation through [templates](/azure/azure-resource-manager/templates/overview) and [extensions](/azure/azure-arc/kubernetes/extensions).

- Azure services used together with Azure Arc-enabled Kubernetes incur costs according to their usage. These services include:
  - [Kubernetes GitOps configuration](/azure/azure-arc/kubernetes/conceptual-configurations)
  - [Azure Policy for Kubernetes](/azure/governance/policy/concepts/policy-for-kubernetes)
  - [Azure Monitor Container Insights](/azure/azure-monitor/containers/container-insights-overview)
  - [Microsoft Defender for Containers](/azure/defender-for-cloud/defender-for-containers-introduction?tabs=defender-for-container-arch-aks)
  - [Microsoft Sentinel](/azure/sentinel/overview)
  - [Azure Key Vault](/azure/key-vault/general/basic-concepts)

>[!NOTE]
> Billing for Azure services used in conjunction with Azure Arc-enabled Kubernetes is the same as billing for the Azure Kubernetes Service.

> [!NOTE]
> If your Azure Arc-enabled Kubernetes cluster is on Azure Kubernetes Service (AKS) on Azure Local, Kubernetes GitOps configuration is included at no extra charge.

## Design considerations

- **Governance:** Define a governance plan for your hybrid clusters that translates into Azure Policies, tags, naming standards and least-privilege controls.

- **Azure Monitor Container Insights:** [Azure Monitor Container Insights](/azure/azure-monitor/containers/container-insights-overview) provides telemetry visibility by collecting performance metrics from controllers, nodes, and containers available in Kubernetes through the Metrics API. Container logs are also collected. This is billed by data ingestion, retention, and exports.

- **Microsoft Defender for Cloud:**  Microsoft Defender for Cloud is offered in [two modes](/azure/defender-for-cloud/enhanced-security-features-overview#what-are-the-benefits-of-enabling-enhanced-security-features):

   **Without enhanced security features (Free)** - [Microsoft Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction) is enabled for free on all your Azure subscriptions when you visit the workload protection dashboard in the Azure portal for the first time, or if you enable it programmatically via API. This free mode provides the secure score and its related features: security policy, continuous security assessment, and actionable security recommendations for your Azure resources.

   **With all enhanced security features (Paid)** - Enabling [Microsoft Defender for Cloud](/azure/defender-for-cloud/enhanced-security-features-overview) enhanced security extends the capabilities of free mode to workloads running in private and other public clouds, providing unified security management and threat protection across your hybrid cloud workloads.

- **Kubernetes GitOps configuration:** [Kubernetes GitOps configuration](/azure/azure-arc/kubernetes/conceptual-configurations) delivers configuration management and application deployment using GitOps. Admins can declare their cluster configuration and applications in Git. Development teams can then use pull requests and other tools they're familiar with (existing Azure Pipelines, Git, Kubernetes manifests, Helm charts) to easily deploy applications into Azure Arc-enabled Kubernetes clusters and make updates in production. Billing is charged monthly and is based on the number of vCPUs/hour in your cluster. Clusters incur a single charge for configuration management, no matter how many repositories are connected.

  > [!Note]
  > Clusters can function without a constant connection to Azure. When disconnected, each cluster’s charge is determined based on the last known number of vCPUs that were registered with Azure Arc. The vCPU count is updated every 5 minutes while your cluster is connected to Azure. Each cluster's first 6 vCPUs are included at no cost.
  >
  > If your cluster will be disconnected from Azure and you don’t want to be charged for Kubernetes configurations, you can delete the configurations.

- **Azure Policy for Kubernetes:** [Azure Policy for Kubernetes](/azure/governance/policy/concepts/policy-for-kubernetes) extends Gatekeeper v3, an admission controller webhook for Open Policy Agent (OPA), to apply at-scale enforcements and safeguards on your clusters in a centralized, consistent manner. Azure Policy makes it possible to manage and report on the compliance state of your Kubernetes clusters from one place. There's currently no cost for Azure Policy for Kubernetes while in public preview.

- **Microsoft Sentinel:** [Microsoft Sentinel](/azure/sentinel/overview) provides intelligent security analytics across your enterprise. The data for its analysis is stored in an Azure Monitor Log Analytics workspace. Microsoft Sentinel is billed based on the volume of data ingested for analysis in Microsoft Sentinel and stored in the Azure Monitor Log Analytics workspace for your Azure Arc-enabled Kubernetes clusters.

- **Azure Key Vault:** The [Azure Key Vault](/azure/key-vault/general/basic-concepts) Provider for Secrets Store CSI Driver allows for the integration of an Azure Key Vault as a store of secrets with a Kubernetes cluster via a CSI volume. Azure Key Vault is billed by the operations performed on certificates, keys, and secrets.

## Design recommendations

The following sections contain design recommendations for Azure Arc-enabled Kubernetes cost governance.

> [!Note]
> Pricing information shown in the provided screenshots are examples and provided to allow a demonstrating Azure Calculator, and don't reflect the actual pricing information you might see in your own Azure Arc deployments.

### Governance

- Review the recommendations in the [resource organization](./eslz-arc-kubernetes-resource-organization.md) and [governance disciplines](./eslz-arc-kubernetes-governance-disciplines.md) critical design area to implement a governance strategy, organize your resources for better cost control and visibility, and avoid unnecessary costs by using the least privileged access model for onboarding and management.

### Azure Monitor for Containers

- Review the [Management and monitoring critical design area](./eslz-arc-kubernetes-management-disciplines.md) to plan your monitoring strategy and decide on your requirements for monitoring Azure Arc-enabled Kubernetes clusters to optimize costs.
- Review [Azure Monitor for Containers pricing](https://azure.microsoft.com/pricing/details/monitor/).
- Use the [Azure Pricing Calculator](https://azure.microsoft.com/pricing/calculator/) to get an estimate of Azure Arc-enabled Kubernetes monitoring costs for Azure Log Analytics ingestion, alerts, and notifications.

   :::image type="content" source="./media/arc-enabled-kubernetes-cost-pricing-calculator.png" alt-text="A screenshot showing Azure Pricing Calculator." lightbox="./media/arc-enabled-kubernetes-cost-pricing-calculator.png" border="true":::

   :::image type="content" source="./media/arc-enabled-kubernetes-cost-pricing-calculator-az-monitor.png" alt-text="A screenshot showing Azure Pricing Calculator Azure Monitor." lightbox="./media/arc-enabled-kubernetes-cost-pricing-calculator-az-monitor.png" border="true":::

- Use [Microsoft Cost Management](/azure/azure-monitor/usage-estimated-costs#azure-cost-management--billing) to view the costs of Azure Monitor for Containers.

   :::image type="content" source="./media/arc-enabled-kubernetes-cost-billing.png" alt-text="A screenshot showing Microsoft Cost Management." lightbox="./media/arc-enabled-kubernetes-cost-billing.png" border="true":::

- Use the [Log Analytics workspace insights](/azure/azure-monitor/logs/log-analytics-workspace-insights-overview) solution to gain insights on monitored Azure Kubernetes clusters, collected logs, and their integration rate so you can avoid unnecessary ingestion costs.

   :::image type="content" source="./media/arc-enabled-kubernetes-cost-log-analytics-insights.png" alt-text="A screenshot showing Log Analytics insights." lightbox="./media/arc-enabled-kubernetes-cost-log-analytics-insights.png" border="true":::

- Use built-in [Azure Monitor workbooks](/azure/azure-monitor/containers/container-insights-reports#billing-workbooks) to understand your clusters' billable monitoring data.

   :::image type="content" source="./media/arc-enabled-kubernetes-cost-monitor-workbooks.png" alt-text="A screenshot showing Azure Monitor workbook showing namespace billing." lightbox="./media/arc-enabled-kubernetes-cost-monitor-workbooks.png" border="true":::

- Review [tips for reducing Log Analytics ingestion data volume](/azure/azure-monitor/logs/manage-cost-storage#tips-for-reducing-data-volume) to help you properly configure data ingestion.
- Consider how long you should retain data in Log Analytics. Data ingested into the Log Analytics workspace can be retained for no extra charge up through the first 31 days. Consider general needs when configuring the [Log Analytics workspace level default retention](/azure/azure-monitor/logs/manage-cost-storage#workspace-level-default-retention) and specific needs when configuring data [retention by data type](/azure/azure-monitor/logs/manage-cost-storage#retention-by-data-type), which can be as low as four days. For example, while performance data might only need to be retained for a short time, security logs often need to be retained longer.
- Consider using [Log Analytics workspace data export](/azure/azure-monitor/logs/logs-data-export) to retain data for longer than 730 days.
- Consider using [Commitment Tier](/azure/azure-monitor/logs/manage-cost-storage#pricing-model) pricing based on your data ingestion volume.

### Microsoft Defender for Cloud (formerly known as Azure Security Center)

- Review the [Security, governance, and compliance critical design area](./eslz-arc-kubernetes-management-disciplines.md) to understand how to use Microsoft Defender for Cloud to protect and secure your Azure Arc-enabled Kubernetes clusters.
- Review [Microsoft Defender for Containers pricing information](https://azure.microsoft.com/pricing/details/azure-defender/).
- Consider deploying the Microsoft Defender for Containers [cost estimation workbook](https://github.com/Azure/Microsoft-Defender-for-Cloud/tree/main/Workbooks/Defender%20for%20Containers%20Cost%20Estimation?WT.mc_id=m365-0000-rotrent) to understand the cost estimates for using Microsoft Defender for Containers to protect your Azure Arc-enabled Kubernetes cluster(s).

### Kubernetes GitOps configuration

- Review [Kubernetes GitOps configuration pricing](https://azure.microsoft.com/pricing/details/azure-arc/).
- Review the [CI/CD workflow critical design area](./eslz-arc-kubernetes-cicd-gitops-disciplines.md) to find best practices and recommendations for managing and monitoring Kubernetes GitOps configuration on your Azure Arc-enabled Kubernetes clusters.
- Use [Azure Policy for Kubernetes](/azure/azure-arc/kubernetes/policy-reference) to enforce and ensure consistent configuration across all your Azure Arc-enabled Kubernetes clusters.
- Use [Azure Resource Graph](/azure/governance/resource-graph/overview) queries to review the number of cores you have for Azure Arc-enabled Kubernetes clusters and estimate the cost of enabling Kubernetes GitOps configuration.

   ```python
   Resources
   | extend AgentVersion=properties.agentVersion, KubernetesVersion=properties.kubernetesVersion, Distribution= properties.distribution,Infrastructure=properties.infrastructure, NodeCount=properties.totalNodeCount,TotalCoreCount=toint(properties.totalCoreCount)
   | project id, subscriptionId, location, type,AgentVersion ,KubernetesVersion ,Distribution,Infrastructure ,NodeCount , TotalCoreCount
   | where type =~ 'Microsoft.Kubernetes/connectedClusters'
   | order by TotalCoreCount
   ```

- Use [Microsoft Cost Management](/azure/cost-management-billing/cost-management-billing-overview) to understand Kubernetes GitOps configuration costs.

   :::image type="content" source="./media/arc-enabled-kubernetes-configuration-cost.png" alt-text="A screenshot showing Kubernetes GitOps configuration cost in Azure portal." lightbox="./media/arc-enabled-kubernetes-configuration-cost.png" border="true":::

### Azure Policy for Kubernetes

- Review [Azure Policy for Kubernetes pricing](https://azure.microsoft.com/pricing/details/azure-arc/).
- Review the [Security, governance, and compliance critical design area](./eslz-arc-kubernetes-management-disciplines.md) to learn best practices and recommendations for implementing Azure Policy for Kubernetes. These best practices include:
  - Enforcing tagging for better cost visibility across clusters
  - Enforcing Kubernetes GitOps configuration
  - Controlling the enablement of Azure services.

### Microsoft Sentinel

- Review [Microsoft Sentinel pricing](https://azure.microsoft.com/pricing/details/azure-sentinel/).
- Use the Azure Pricing Calculator to estimate [Microsoft Sentinel costs](/azure/sentinel/azure-sentinel-billing) for your organization.

<!--   :::image type="content" source="./media/arc-enabled-kubernetes-cost-sentinel-costs.png" alt-text="A screenshot showing Microsoft Sentinel costs." lightbox="./media/arc-enabled-kubernetes-cost-sentinel-costs.png" border="true"::: -->

- Use [Microsoft Sentinel Cost Management and Billing](/azure/sentinel/azure-sentinel-billing#manage-and-monitor-azure-sentinel-costs) to understand Microsoft Sentinel analysis costs.

   :::image type="content" source="./media/arc-enabled-kubernetes-cost-sentinel.png" alt-text="A screenshot showing Microsoft Sentinel cost analysis." lightbox="./media/arc-enabled-kubernetes-cost-sentinel.png" border="true":::

- Review [data retention costs](/azure/sentinel/azure-sentinel-billing#data-retention-costs) for data ingested into the Log Analytics workspace Microsoft Sentinel uses.
- Filter the [right level of logs and events](/azure/azure-monitor/containers/container-insights-agent-config) for your Azure Arc-enabled Kubernetes clusters to be collected in the Log Analytics workspace.
- Use [Log Analytics queries](/azure/sentinel/azure-sentinel-billing#run-queries-to-understand-your-data-ingestion) and the [Workspace Usage Report workbook](/azure/sentinel/azure-sentinel-billing#deploy-a-workbook-to-visualize-data-ingestion) to understand your data ingestion trends.
- Create a [cost management playbook](/azure/sentinel/billing-monitor-costs#use-a-playbook-for-cost-management-alerts) to send notifications if your Microsoft Sentinel workspace exceeds your budget.
- Microsoft Sentinel integrates with other Azure services to provide enhanced capabilities. Review the [pricing details](/azure/sentinel/azure-sentinel-billing#costs-for-other-services) for these services.
- Consider using [Commitment Tier](/azure/sentinel/azure-sentinel-billing#set-or-change-pricing-tier) pricing based on your data ingestion volume.
- Consider [separating non-security](/azure/sentinel/azure-sentinel-billing#separate-non-security-data-in-a-different-workspace) operational data into a different Azure Log Analytics workspace.

### Azure Key Vault

- Review [Azure Key Vault pricing](https://azure.microsoft.com/pricing/details/key-vault/).
- Review [recommendations for security and governance](./eslz-arc-kubernetes-management-disciplines.md) to understand how you can use Azure Key vault to manage secrets and certificates on your Azure Arc-enabled Kubernetes clusters.
- Use [Azure Key Vault insights](/azure/azure-monitor/insights/key-vault-insights-overview) to monitor secrets operations.

    :::image type="content" source="./media/arc-enabled-kubernetes-cost-key-vault-insights.png" alt-text="A screenshot showing Azure Key Vault insights" lightbox="./media/arc-enabled-kubernetes-cost-key-vault-insights.png" border="true":::

## Next steps

For more information about your hybrid and multicloud cloud journey, see the following articles:

- Review the [prerequisites](/azure/azure-arc/kubernetes/quickstart-connect-cluster?tabs=azure-cli#prerequisites) for Azure Arc-enabled Kubernetes.
- Review the [validated Kubernetes distributions](/azure/azure-arc/kubernetes/validation-program#validated-distributions) for Azure Arc-enabled Kubernetes.
- Learn how to [Manage hybrid and multicloud environments](../manage.md).
- Experience Azure Arc-enabled Kubernetes automated scenarios with [Azure Arc Jumpstart](https://azurearcjumpstart.io/azure_arc_jumpstart/azure_arc_k8s/).
- Learn more about Azure Arc via the [Azure Arc learning path](/training/paths/manage-hybrid-infrastructure-with-azure-arc/).
- See the [Frequently Asked Questions - Azure Arc-enabled](/azure/azure-arc/kubernetes/faq) to find answers to most common questions.
