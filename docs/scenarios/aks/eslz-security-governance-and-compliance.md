---
title: Enterprise-scale Azure Kubernetes Service (AKS) security governance and compliance
description: Learn about the cloud security control lifecycle, and how to set up AKS security controls, Azure Policy, and AKS cost management.
author: BrianBlanchard
ms.author: brblanch
ms.date: 03/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank, e2e-aks
---

<!-- docutune:casing "Contoso Financials" -->

# AKS enterprise-scale platform security governance and compliance

This article walks through aspects of Azure Kubernetes Service (AKS) security governance to think about before implementing any solution.

Most of this content is technology-agnostic, because implementation varies among customers. The article focuses on how to implement solutions using Azure and some open-source software (OSS).

## Cloud security control lifecycle

In cloud-native security and governance, the cloud can be dynamic, whereas most enterprises are used to relatively stable environments. Traditional environments include detection and prevention controls in a structured organizational model that aligns with traditional IT functions like identity, networking, and machine and virtual machine (VM) OS management. Traditional security and compliance teams face relatively infrequent changes to overall structure and infrastructure, or to required controls and monitoring to achieve security and risk objectives.

With the adoption of cloud and DevOps models, security must adapt to changes, so it doesn't become an impediment to business and progress. Security adaptations include people processes like creating the right roles and responsibilities, and automation and technical tools like scanning, testing, and infrastructure as code. These tools are part of a DevOps pipeline that enables innovation and fast delivery times, while still meeting security requirements.

The temptation is to begin by doing what you do today, but the key takeaway is that if you try to do in the cloud exactly what you do today on-premises, you will fail. Cloud adoption is an opportunity to learn, update skills, and increase the organization's security posture. You can position security to be an enabler rather than a blocker by streamlining security as part of the development to production process. If you use 10-20 year-old tools and processes, you inherit or introduce 10-20 year-old security challenges, problems, and frustrations. Cloud adoption is your chance to start fresh.

Starting fresh begins with an understanding of the cloud.

- What are the available cloud services, controls, and visibility?
- How do you operate the cloud services and controls?
- What are the available security tools and governance tools?
- How can you use security and governance tools in processes and systems, so lines of business can be more agile with a modern DevOps model?
- How can you make sure to meet security and compliance requirements?

It's often easiest to start a lifecycle framework from a process perspective, both in establishing security controls, and managing and operationalizing the controls themselves. For establishing security controls, many customers use common frameworks and standards like NIST 800-53, ISO, CIS benchmarks, and HIPAA/HITRUST. These standards can help establish a comprehensive framework, and offer guidance to help establish, document, and audit security controls and processes.

For managing and operationalizing security controls, you can look at various models, including security development lifecycle processes that include cloud and DevOps. These approaches and models treat security controls like any other assets in an organization, and include lifecycle management. The following diagram shows an example of an organization's security control lifecycle management:

:::image type="content" source="./media/security-control-lifecycle.png" alt-text="Diagram showing Azure security control lifecycle management setup." border="false":::

### Azure security control architecture

All Azure security controls start with, and build on top of, the Azure Resource Manager API. The following diagram shows how the Azure Policy engine helps enforce policies regardless of their origin. This ability is important because it means organizations don't have to define policies in multiple places.

:::image type="content" source="./media/enterprise-control-plane-architecture.png" alt-text="Diagram showing Azure security control architecture." border="false":::

### Security control governance

One of the key benefits of a security control framework is its incorporation of governance and controls auditing. In addition to Azure Policy, Azure security control governance includes [Azure Security Center](/azure/security-center/security-center-introduction), with its [secure score](/azure/security-center/secure-score-security-controls) and compliance dashboard features. Compliance, at its core, is all about governance observability. The following image shows a sample compliance dashboard:

:::image type="content" source="./media/enterprise-control-plane-governance.png" alt-text="Diagram showing Azure security control governance." border="false":::

## Azure security controls setup

This section walks through setting up an overarching Azure-specific security control framework. This section assumes organizational security controls are already established. Defining these security controls is out of scope for this article.

The following sections describe implementing the following controls to meet security requirements for a fictitious Contoso Financials scenario:

- Log all cloud API requests for audit reporting purposes.
- Enable authorized IP ranges to secure access to the API server.
- Use allowed locations to create AKS clusters only in certain regions.

These controls are just a subset of the security controls and Azure policies that a full Azure deployment includes. Once you understand the process, you can repeat it to implement any other security controls your organization requires.

### Log all cloud API requests for audit reporting purposes

[Azure activity logs](/azure/azure-monitor/essentials/platform-logs-overview) capture all Azure Resource Manager interactions, including audit logs. The challenge is that activity logs only have a certain retention lifecycle. To retain logs for audit reporting, you must export the data out of the activity logs into a more persistent storage location, such as Azure Monitor Logs.

For a tutorial on how to set up activity log collection for an Azure subscription, see [Send to a Log Analytics workspace](/azure/azure-monitor/essentials/activity-log#send-to-log-analytics-workspace).

The following screenshot shows an Azure activity log capture in an Azure Log Analytics workspace:

:::image type="content" source="./media/activity-log-capture.png" alt-text="Screenshot showing an Activity Log capture." border="false":::

### Enable Azure security monitoring to check for authorized IP ranges

Before you create anything, look to your cloud provider for security monitoring best practices and recommendations. The cloud provider doesn't implement all the security controls an organization needs, but the key is to use the provided controls to avoid reinventing the wheel, and to create custom controls only when necessary.

In Azure, you can enable Azure Security Center to see security monitoring recommendations. You can also use Azure Security Center to determine whether an AKS cluster has authorized IP ranges enabled.

To enable Azure Security Center Standard for an Azure subscription, see [Quickstart: set up Azure Security Center](/azure/security-center/security-center-get-started).

The following screenshot shows Azure Security Center Standard monitoring:

:::image type="content" source="./media/security-center-standard.png" alt-text="Screenshot showing Azure Security Center Standard monitoring.":::

### Enforce an Azure Policy to create AKS clusters only in certain regions

Also look to the cloud provider for policy enforcement. In Azure, evaluate Azure Policy, which is a key part of the enterprise control plane. You can't do everything with Azure Policy, but the key is to use what's provided to avoid reinventing the wheel, and to create custom controls only when necessary.

You can use Azure Policy to implement allowed locations for creating Azure resources like AKS clusters. For more information and instructions, see [Tutorial: create and manage policies to enforce compliance](/azure/governance/policy/tutorials/create-and-manage).

The following screenshots show the steps of using Azure Policy to implement allowed region locations.

1. Select the built-in **Allowed locations** policy in Azure Policy.

   :::image type="content" source="./media/policy-definitions.png" alt-text="Screenshot showing the built-in Azure policies.":::

1. View the policy definition and assign the policy.

   :::image type="content" source="./media/assign-policy.png" alt-text="Screenshot showing the Allowed locations policy definition.":::

1. Configure the policy.

   :::image type="content" source="./media/configure-policy.png" alt-text="Screenshot showing the Allowed locations configuration screen.":::

1. Configure the policy parameters.

   :::image type="content" source="./media/configure-parameters.png" alt-text="Screenshot showing the Allowed locations parameters screen.":::

1. View policy assignments.

   :::image type="content" source="./media/policy-assignments.png" alt-text="Screenshot showing Azure Policy assignments.":::

The ability to restrict resource creation to a specific region is just one of many available Azure policies.

- For samples of what you can do with Azure Policy, see [Azure Policy samples](/azure/governance/policy/samples/).
- For more information about Azure Policy for Azure Security Center, see [Azure Policy built-in definitions for Azure Security Center](/azure/security-center/policy-reference).

## Cost governance

Cost governance is the continuous process of implementing policies to control costs. In the Kubernetes context, there are several ways organizations can control and optimize costs. These include native Kubernetes tooling to manage and govern resource usage and consumption and proactively monitor and optimize the underlying infrastructure.

This section shows how to use [Kubecost](https://kubecost.com/) to govern AKS cluster cost. You can scope cost allocation to a deployment, service, label, pod, or namespace, which provides flexibility in charging back or showing cluster users.

### Install Kubecost

There are several Kubecost installation options. For more information, see [Installing Kubecost](https://docs.kubecost.com/install).

To install Kubecost directly, use the following commands:

```bash

# Create the Kubecost namespace

kubectl create namespace kubecost

# Install Kubecost into the AKS cluster

kubectl apply -f https://raw.githubusercontent.com/kubecost/cost-analyzer-helm-chart/master/kubecost.yaml --namespace kubecost
```

To install Kubecost by using Helm 2, use the following commands:

```bash
helm repo add kubecost https://kubecost.github.io/cost-analyzer/
helm install kubecost/cost-analyzer --namespace kubecost --name kubecost --set kubecostToken="YWxnaWJib25AbWljcm9zb2Z0LmNvbQ==xm343yadf98"
```

To install Kubecost by using Helm 3, use the following commands:

```bash
kubectl create namespace kubecost
helm repo add kubecost https://kubecost.github.io/cost-analyzer/
helm install kubecost kubecost/cost-analyzer --namespace kubecost --set kubecostToken="YWxnaWJib25AbWljcm9zb2Z0LmNvbQ==xm343yadf98"
```

After a few minutes, check to make sure that Kubecost is up and running:

```bash
kubectl get pods -n kubecost

# Connect to the Kubecost dashboard UI

kubectl port-forward -n kubecost svc/kubecost-cost-analyzer 9090:9090
```

You can now open your browser and point to `http://127.0.0.1:9090` to open the Kubecost UI. In the Kubecost UI, select your cluster to view cost allocation information.

### Navigate Kubecost

Kubecost breaks down resources into the following categories:

- Monthly cluster cost
- Namespace cost
- Deployment resource cost
- Cost efficiency

Select your cluster to see an overview like the following dashboard:

:::image type="content" source="./media/kubecost-dashboard.png" alt-text="Screenshot showing the Kubecost dashboard.":::

Select **Allocation** on the left to dig down into the namespace cost of your resources. **Allocation** shows the cost for CPU, memory, persistent volumes, and network. Kubecost gets the data from Azure pricing, but you can also set custom costs for the resources.

:::image type="content" source="./media/kubecost-allocation.png" alt-text="Screenshot showing the Kubecost Allocation screen.":::

Select **Savings** on the left to dig into cost savings for underutilized resources. **Savings** gives you information about underutilized nodes and pods and abandoned resources, and identifies resource requests that are overprovisioned within the cluster. The following screenshot shows an example **Savings** overview:

:::image type="content" source="./media/kubecost-savings.png" alt-text="Screenshot showing the Kubecost Savings screen.":::

Take some time to navigate around the different views and features that Kubecost provides.

## Design considerations

AKS has several interfaces to other Azure services like Azure Active Directory, Azure Storage, and Azure Virtual Network, which require special attention during the planning phase. AKS also adds extra complexity that requires you to consider applying the same security, governance, and compliance mechanisms and controls as in the rest of your infrastructure landscape.

Here are some other design considerations for AKS security governance and compliance:

- Decide whether the cluster's control plane is accessible via the internet, which is the default, or only within a specific virtual network as a private cluster.

- Evaluate using the built-in [AppArmor](/azure/aks/operator-best-practices-cluster-security#app-armor) Linux security module to limit actions that containers can perform, like read, write, execute, or system functions like mounting file systems.

- Evaluate using [secure computing (seccomp)](/azure/aks/operator-best-practices-cluster-security#secure-computing) at the process level to limit the process calls that containers can perform.

- Consider using [Azure Defender for Kubernetes](/azure/security-center/defender-for-kubernetes-introduction) for threat detection.

## Design recommendations

- Limit access to the [Kubernetes cluster configuration](/azure/aks/control-kubeconfig-access) file by using Azure role-based access control.

- [Secure pod access to resources](/azure/aks/developer-best-practices-pod-security#secure-pod-access-to-resources). Provide the least number of permissions, and avoid using root or privileged escalation.

- Use [Pod-managed identities](/azure/aks/operator-best-practices-identity#use-pod-managed-identities) and [Azure Key Vault provider for Secrets Store CSI Driver](https://github.com/Azure/secrets-store-csi-driver-provider-azure) to protect secrets, certificates, and connection strings.

- Make sure to [rotate certificates](/azure/aks/certificate-rotation) regularly, like every 90 days.

- Use [AKS node image upgrade](/azure/aks/node-image-upgrade) to update AKS cluster node images if possible, or [kured](/azure/aks/node-updates-kured) to automate node reboots after applying updates.

- View AKS recommendations in [Azure Security Center](/azure/security-center/security-center-introduction).

- Monitor and enforce configuration by using the [Azure Policy add-on for Kubernetes](/azure/aks/use-pod-security-on-azure-policy).
