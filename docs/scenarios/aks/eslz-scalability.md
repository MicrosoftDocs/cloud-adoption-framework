---
title: "AKS Enterprise-scale scalability"
description: AKS Guidelines for Enterprise-scale scalability
author: xstabel
ms.author: ctalaver
ms.date: 03/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
---

# AKS Enterprise-scale Scalability

AKS can be scaled-in and out depending upon infrastructure needs (requiring more or less capacity), adding additional node pools with special capabilities like GPU, or application needs, in this case you have a number of factors like  number and rate of concurrent connections, number of requests, back-end latencies on AKS Applications.

The most common scalability options for AKS are the Cluster Autoscaler (automatically adding/removing nodes based on cpu and memory utilization) and the HPA (Horizontal Pod Autoscaler) for your applications to scale-in and out within the space available in the cluster based on cpu and memory utilization as well as more advanced metrics.

## Workload scaling

Outside of highly specialized situations or certain migration scenarios, containerized workloads are rarely designed to run as a single instance in a cluster. They are typically built to scale out horizontally (that is adding or removing instances of the workload) in the cluster as demands for the workload changes. This is managed via the [Horizontal Pod Autoscaler (HPA)](/azure/aks/concepts-scale#horizontal-pod-autoscaler).

**TODO: Is there an enterprise-scale tie in here? Otherwise, this isn't new material in any way. What makes THIS guidance special for enterprise-scale deployments?**

### Design considerations for workload scaling

- HPA scales pod, and pods can only be scheduled in the cluster if there is room to do so. Ensure your cluster is sized to support the largest expected scale of all your workloads, ideally via the use of the cluster autoscaler to prevent the need for over initial provisioning.
- Maintain `Limit` and `ResourceQuota` resources to ensure workloads are being deployed with capacity requirements aligned with cluster capacity expectations.
- Selecting VM SKU size and capabilities are part of a cluster's planning process, which usually involves having performance characteristics and hardware dependencies in mind for the workloads on the cluster. Ensure your node pools are providing just the performance capabilities needed for your workload, so they can run optimally dense.
- In Kubernetes, applications typical scale based on CPU and Memory consumption. If you need advanced scaling options that go beyond HPA, consider (re-)architecting your solution around an alternative in-cluster solution like [KEDA with Azure Functions](/azure/azure-functions/functions-kubernetes-keda) for those specific workloads.

### Design recommendations for workload scaling

- All pods must have memory & cpu requests and limits defined, even if the pod is not going to be subject to the HPA.
  - Use Azure Policy and namespace `Limits` to enforce their existence and what the range those values can be.
- All workloads must have a related `HorizontalPodAutoscaler` resource defined that details the expected scale targets for the workload if the workload is expected to change based on usage.
- Configure Azure Monitor to alert on failed scaling or scheduling operations, which might indicate a cluster sizing issue or an unexpected workload change (excessive CPU or memory usage).
- Use node pool selectors to ensure your workload is operating in node pools that are the most appropriate for it.
- Never deploy your workloads to the system node pool, unless it is a security agent that you are running for compliance reasons.
- Enable [Azure Monitor for containers](https://docs.microsoft.com/azure/azure-monitor/insights/container-insights-overview) and Live Monitoring to monitor the workload utilization.

## Cluster scaling

Your cluster should be sized to handle your expected workload's needs, including enough of a buffer that some agreed upon percentage of unexpected traffic will not cause a poor use experience or system instability. To handle growth, or decline in traffic one can size the cluster by hand (manual scaling) or employ system resource metrics to define auto scaling rules.

**TODO: Is there an enterprise-scale tie in here? Otherwise, this isn't new material in any way. What makes THIS guidance special for enterprise-scale deployments?**

### Design considerations for cluster scaling

- Take time to understand all the scaling patterns of the workloads on your cluster and decide what, if any, scaling should occur at the cluster level; and if it should be manual or automatic.
  - Some workloads are static or grow/shrink over time predictably, and do not gain any benefit from the added complexity of the cluster autoscaler.
  - Some workloads are expected to be very "burstable" and as such require even more flexibility than just the cluster autoscaler, consider scaling out to [Virtual Nodes](/azure/aks/virtual-nodes-portal).
  - Most clusters hosting workloads that don't align with the prior two edge cases, fit well using the [cluster autoscaler](/azure/aks/cluster-autoscaler).
  - In the rare case you have a cluster that routinely sits with all workloads completely idle, use [scale-to-zero](/azure/aks/scale-cluster#scale-user-node-pools-to-0) to help control costs.
- Ensure workloads are landing on appropriate node pools. It might be more cost effective to introduce a new node pool with better aligned resources (memory vs cpu) into the cluster and move specific workloads to it than to scale out an unsuitable node pool.
- Consider multiple clusters or regions when appropriate to partition or distribute network traffic

### Design recommendations for cluster scaling

- When performing capacity planning for your cluster, ensure available subnet space for cluster scaling operations is available.
- Document an agreed amount of over provisioning and monitor that head space to ensure the buffer is retained and used for transient (but expected) load increases.
- If you have a cluster that can scale out, ensure that is accounted for in ResourceQuotas, as  `DaemonSet` resources will scale out with the cluster.
- Consider [Spot VM based node pools](/azure/aks/spot-node-pool) for non-timesensitive workloads that can handle interruptions and evictions.
- Use multiple node pools when your applications have different resource requirements.
  - Remember you can [specify a VM size for a node pool](/azure/aks/use-multiple-node-pools#specify-a-vm-size-for-a-node-pool).
- Enable [Azure Monitor for containers](https://docs.microsoft.com/azure/azure-monitor/insights/container-insights-overview) and Live Monitoring to monitor the cluster utilization.
  - Capture `cluster-autoscaler` Diagnostics logs to help troubleshoot any scaler-related issues.
- Tune the cluster autoscaler settings to fit the needs of your specific cluster's workload. If you want to leave them default, then set those explicitly in your infrastructure as code (IaC) solution, do not leave those settings unset.
