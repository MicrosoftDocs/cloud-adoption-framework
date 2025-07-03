---
title: Cost governance with Kubecost
description: Learn about cost governance for Azure Kubernetes Service.
author: Zimmergren
ms.author: pnp
ms.date: 01/20/2023
ms.topic: conceptual
ms.custom: think-tank, e2e-aks
---

# Cost governance with Kubecost

Cost governance is the continuous process of implementing policies to control costs. In the Kubernetes context, there are several ways organizations can control and optimize costs. These include native Kubernetes tooling to manage and govern resource usage and consumption and proactively monitor and optimize the underlying infrastructure.

This section shows how to use [Kubecost](https://www.kubecost.com/) to govern Azure Kubernetes Service (AKS) cluster costs. You can scope cost allocation to a deployment, service, label, pod, or namespace, which provides flexibility in charging back or showing cluster users.

## Install Kubecost

There are several Kubecost installation options. For more information, see [Installing Kubecost](https://docs.kubecost.com/install-and-configure/install).

The recommended installation method is the Helm 3 chart. To install a basic configuration of Kubecost by using Helm 3, use the following commands:

```bash
helm repo add kubecost https://kubecost.github.io/cost-analyzer/
helm repo update
helm upgrade --install kubecost kubecost/cost-analyzer --namespace kubecost --create-namespace
```

After a few minutes, check to make sure that Kubecost is up and running:

```bash
kubectl get pods -n kubecost

# Connect to the Kubecost dashboard UI

kubectl port-forward -n kubecost svc/kubecost-cost-analyzer 9090:9090
```

You can now open your browser and point to `http://127.0.0.1:9090` to open the Kubecost UI. In the Kubecost UI, select your cluster to view cost allocation information.

### Configuring Kubecost for Azure cloud integration

To complete your Kubecost installation, you should configure the [Azure Cloud Integration](https://docs.kubecost.com/install-and-configure/install/cloud-integration/azure-out-of-cluster) and the [Azure Rate Card Configuration](https://docs.kubecost.com/install-and-configure/install/cloud-integration/azure-out-of-cluster/azure-config).

With [Microsoft Cost Export](/azure/cost-management-billing/costs/tutorial-export-acm-data?tabs=azure-portal), you can create a recurring task that automatically exports your Cost Management data to an Azure storage account on a daily basis. Kubecost is configured to access the data in this storage account, allowing it to display the total cost for Azure resources in the dashboard, not just the data coming from the AKS cluster. To ensure that Kubecost produces accurate dashboards, you should tag your Azure resources as described in the Kubecost documentation for [tagging Azure resources](https://docs.kubecost.com/install-and-configure/install/cloud-integration/azure-out-of-cluster#step-3-tagging-azure-resources). Some Azure resources are created by the AKS cluster, this is the case when you create a Service of type `LoadBalancer` or a `PersistentVolume`. To track the cost for these resources correctly, you can use annotations in the Kubernetes resources to add the proper Azure tags, as examples in the article ["Use Azure tags in Azure Kubernetes Service"](https://techcommunity.microsoft.com/t5/fasttrack-for-azure/use-azure-tags-in-azure-kubernetes-service-aks/ba-p/3611583).

The Azure Rate Card Configuration is necessary for accurate pricing to be reported in your dashboard. You will need to [create a Service Principal with a custom role as explained in the documentation page](https://docs.kubecost.com/install-and-configure/install/cloud-integration/azure-out-of-cluster/azure-config) and configure Kubecost to use the Service Principal to query the Azure Billing Rate Card API.

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

Select **Savings** on the left to dig into cost savings for underutilized resources. **Savings** gives you information about underutilized nodes and pods and abandoned resources, and identifies overprovisioned resource requests within the cluster. The following screenshot shows an example **Savings** overview:

:::image type="content" source="./media/kubecost-savings.png" alt-text="Screenshot showing the Kubecost Savings screen.":::

Take some time to navigate around the different views and features that Kubecost provides.
