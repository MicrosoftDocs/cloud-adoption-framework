---
title: Cost governance with Kubecost
description: Learn about AKS cost management.
author: BrianBlanchard
ms.author: brblanch
ms.date: 04/30/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-aks
---

<!-- cspell:ignoreRegExp "kubecostToken=.[A-Za-z\d=]{20,50}" -->

# Cost governance with Kubecost

Cost governance is the continuous process of implementing policies to control costs. In the Kubernetes context, there are several ways organizations can control and optimize costs. These include native Kubernetes tooling to manage and govern resource usage and consumption and proactively monitor and optimize the underlying infrastructure.

This section shows how to use [Kubecost](https://www.kubecost.com/) to govern AKS cluster costs. You can scope cost allocation to a deployment, service, label, pod, or namespace, which provides flexibility in charging back or showing cluster users.

## Install Kubecost

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

Select **Savings** on the left to dig into cost savings for underutilized resources. **Savings** gives you information about underutilized nodes and pods and abandoned resources, and identifies overprovisioned resource requests within the cluster. The following screenshot shows an example **Savings** overview:

:::image type="content" source="./media/kubecost-savings.png" alt-text="Screenshot showing the Kubecost Savings screen.":::

Take some time to navigate around the different views and features that Kubecost provides.
