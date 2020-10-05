---
title: "Enterprise-Scale management and monitoring for <Insert narrative Name>"
description: Describe how this enterprise-scale scenario can improve management and monitoring of <Insert Scenario Name>
author: BrianBlanchard
ms.author: brblanch
ms.date: 09/11/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Management and monitoring for <Insert narrative Name> Enterprise-Scale scenario

## Design considerations
* AKS limits
* Cluster scope limits
* Resource consumption limits
* Node sizing

* Monitoring solution
* Alerts
* Update and upgrades of node operating system, kubernetes version
* Cost allocation

* Monitor security
* Apply best practices

* Multi-cluster

## Design recommendations
* Be aware of AKS limits:
  * [Qutas and regional limits](https://docs.microsoft.com/en-us/azure/aks/quotas-skus-regions)
  * [AKS service limits](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/azure-subscription-service-limits#azure-kubernetes-service-limits)
* Use logical and physical isolation to separate applications, teams, environments, business units. [Multi-tenancy and cluster isolation](https://docs.microsoft.com/en-us/azure/aks/operator-best-practices-cluster-isolation)
* Plan and apply resource quotas at the namespace level. If pods don't define resource requests and limits, reject the deployment. Monitor resource usage and adjust quotas as needed. [Basic scheduler features](https://docs.microsoft.com/en-us/azure/aks/operator-best-practices-scheduler)
* Add Health Probes to your services. Make sure pods contain  Liveness, Readiness, and Startup probes. [AKS Health Probes](https://docs.microsoft.com/en-us/azure/application-gateway/ingress-controller-add-health-probes)
* Use VM sizes that are big enough, to contain multiple container instances so you get the benefits of increased density, and not too big, so that your cluster can handle the workload of a failing node.
* Use a monitoring solution. Azure monitor works by default and provides easy access to many insights. [Azure Container Insights](https://docs.microsoft.com/en-us/azure/azure-monitor/insights/container-insights-overview) If you want to drill deeper or are experienced with Prometheus use that. [Prometheus Integration](https://docs.microsoft.com/en-us/azure/azure-monitor/insights/container-insights-prometheus-integration)
Note that if you want to host a monitoring solution on AKS, you also want to look at Azure monitor.
* Use an alerting system to provide notifications when things need direct action. [Metric alerts](https://docs.microsoft.com/en-us/azure/azure-monitor/insights/container-insights-metric-alerts)
* Use [Kured](https://docs.microsoft.com/en-us/azure/aks/node-updates-kured) for node updates.  [Node upgrades](https://docs.microsoft.com/en-us/azure/aks/node-image-upgrade)
* Use node pools for isolation, different node specifications, and maintenance like Kubernetes upgrades [Multiple Node Pools](https://docs.microsoft.com/en-us/azure/aks/use-multiple-node-pools)
* Use [Security Center](https://docs.microsoft.com/en-us/azure/security-center/azure-kubernetes-service-integration) to prevent and detect threats like image vulnerabilities.
* Use Azure Advisor to get best practice recommendations on cost, security, reliability, operational excellence and performance.
* Use [Azure Arc](https://docs.microsoft.com/en-us/azure/azure-arc/kubernetes/overview) enabled Kubernetes to manage non-AKS Kubernetes clusters.
