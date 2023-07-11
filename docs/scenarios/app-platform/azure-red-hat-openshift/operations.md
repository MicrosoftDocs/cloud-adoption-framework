---
title: Operations baseline guidance for Azure Red Hat OpenShift
description: Learn about design considerations and recommendations for Azure Red Hat OpenShift baseline operations.
author: SriniPadala
ms.author: srpadala
ms.date: 08/19/2022
ms.topic: conceptual
ms.subservice: scenario
ms.custom: think-tank, e2e-aro
---

# Operations baseline guidance for Azure Red Hat OpenShift

Azure Red Hat OpenShift provides highly scalable, fully managed OpenShift clusters on demand. By properly designing your solution with management and monitoring in mind, you can work toward operational excellence and customer success.

## Design considerations

Consider the following factors:

- Review the [Azure Red Hat OpenShift responsibility matrix](/azure/openshift/responsibility-matrix) to understand how responsibilities for clusters are shared between Microsoft, Red Hat, and customers.
- Be aware of [Azure virtual machine limits](/azure/azure-resource-manager/management/azure-subscription-service-limits#virtual-machines-limits---azure-resource-manager) and [supported regions](/azure/openshift/openshift-faq#which-azure-regions-are-supported). Ensure there's capacity available to deploy resources.
- Be aware of ways to isolate workloads logically within a cluster and physically in separate clusters.
- Be aware of ways to help Kubernetes understand the health of your workloads.
- Be aware of various [virtual machines sizes](/azure/openshift/openshift-faq#what-virtual-machine-sizes-can-i-use) and the effect of using one or the other.
- Be aware of ways to monitor and log Azure Red Hat OpenShift to gain insights into the health of your resources and to foresee potential issues. Both the cluster and the applications running on top can generate many events. Use alerts to help differentiate between log entries for historical purposes and entries that require immediate action.
- Be aware of important system updates and upgrades. Critical patch updates are applied to clusters automatically by Azure Red Hat OpenShift site reliability engineers (SRE). Customers who wish to install patch updates in advance are free to do so.
- Be aware of resource limitations of the cluster and individual workloads.
- Be aware of the differences between [horizontal pod autoscaler](https://docs.openshift.com/container-platform/4.10/nodes/pods/nodes-pods-autoscaling.html) and [cluster autoscaling](https://docs.openshift.com/container-platform/4.10/machine_management/applying-autoscaling.html).
- Review the [support lifecycle](/azure/openshift/support-lifecycle) and understand the version support policy. Azure Red Hat OpenShift only supports the [current and previous generally available minor releases](/azure/openshift/support-lifecycle#red-hat-openshift-container-platform-version-support-policy) of Red Hat OpenShift Container Platform. Support requests require the cluster to be within a supported version.
- Review [cluster configuration requirements](/azure/openshift/support-policies-v4#cluster-configuration-requirements) to maintain cluster supportability.
- Review cross-namespace networking to secure traffic within the cluster using [network policy](https://docs.openshift.com/container-platform/4.10/networking/network_policy/about-network-policy.html).

## Design recommendations

- Azure Red Hat OpenShift has a rich operator ecosystem and should be used to perform and automate operational activities with efficiency and accuracy.
- Add health probes to your pods to monitor application health. Make sure pods contain livenessProbe and readinessProbe. Use Startup probes to determine the point at which the application has started up.
- Use virtual machine sizes that are large enough to contain multiple container instances so you get the benefits of increased density, but not so large that your cluster can't handle the workload of a failing node.
- Regulate cluster functions using [admission plug-ins](https://docs.openshift.com/container-platform/4.10/architecture/admission-plug-ins.html), which are commonly used to enforce security policy, resource limitations, or configuration requirements.
- Use pod requests and limits to manage the compute resources within a cluster. Pod requests and limits inform the Kubernetes scheduler, which assigns compute resources to a pod. Restrict resource consumption in a project using [limit ranges](https://docs.openshift.com/container-platform/4.10/nodes/clusters/nodes-cluster-limit-ranges.html).
- Optimize the CPU and memory request values, and maximize the efficiency of the cluster resources using [vertical pod autoscaler](https://docs.openshift.com/container-platform/4.10/nodes/pods/nodes-pods-vertical-autoscaler.html).
- The OpenShift web console contains all metrics at the node level. Establish a monitoring process using the inbuilt Prometheus or Container Insights integration.
  - Prometheus comes pre-installed and configured for Azure Red Hat OpenShift 4.x clusters.
  - Container Insights can be enabled by onboarding the cluster to Azure Arc-enabled Kubernetes.
  - [OpenShift logging](https://docs.openshift.com/container-platform/4.10/logging/cluster-logging.html) deploys log aggregators, storage, and visualization components.
- Automate the application delivery process through DevOps practices and CI/CD solutions, such as Pipelines/GitOps provided by OpenShift Container Platform.
- Define ClusterAutoScaler and MachineAutoScaler to scale machines when your cluster runs out of resources to support more deployments.
- Deploy machine health checks to automatically repair damaged machines in a machine pool.
- Scale pods to meet demand using [horizontal pod autoscaler](https://docs.openshift.com/container-platform/4.10/nodes/pods/nodes-pods-autoscaling.html).
- Use an alerting system to provide notifications when things need direct action: Container Insights [metric alerts](/azure/azure-monitor/containers/container-insights-metric-alerts) or in-built [Alerting UI](https://docs.openshift.com/container-platform/4.10/monitoring/managing-alerts.html).

## Business continuity and disaster recovery (BCDR)

Your organization needs to design suitable Azure Red Hat OpenShift platform-level capabilities to meet its specific requirements. These application services have requirements related to recovery time objective (RTO) and recovery point objective (RPO). There are multiple considerations to address for disaster recovery. Your first step is to define a service-level agreement (SLA) for your infrastructure and application. Learn about the [SLA for Azure Red Hat OpenShift](https://azure.microsoft.com/support/legal/sla/openshift/v1_0/). See the **SLA details** section for information about monthly uptime calculations.

### Design considerations for BCDR

Consider the following factors:

- The Azure Red Hat OpenShift cluster should use multiple machine sets to provide the minimum level of availability for your application.
- Set pod requests and limits. Setting these limits lets Kubernetes:
  - Efficiently assign CPU and memory resources to the pods.
  - Have higher container density on a node.
  - Increase reliability with reduced costs because of better use of hardware.
- Spread nodes across all the available zones for higher availability.
  - Choose a region that supports Availability Zones.
  - For complete zonal benefit, all service dependencies must also support zones. If a dependent service doesn't support zones, it's possible that a zone failure could cause that service to fail. Review the disk types used when spreading the workload across zones.
  - For higher availability beyond what Availability Zones can achieve, run multiple clusters in different paired regions. If an Azure resource supports geo-redundancy, provide the location where the redundant service will have its secondary region.
- Consistently create backups for applications and data.
  - A non-stateful service can be replicated efficiently.
  - If you need to store *state* in the cluster, back up the data frequently in the paired region.
- Upgrade and maintain your clusters.
  - Always keep your cluster up to date. Check for [cluster upgrades](/azure/openshift/howto-upgrade#check-for-azure-red-hat-openshift-cluster-upgrades).
  - Be aware of the release and deprecation process.
  - Control upgrades through schedules.
  - Review the need for a [canary rollout update](https://access.redhat.com/documentation/en-us/openshift_container_platform/4.10/html-single/updating_clusters/index#update-using-custom-machine-config-pools-canary_updating-cluster-within-minor) for critical workloads.
- For network connectivity if a failover occurs:
  - If you need to distribute traffic across regions, consider using [Azure Front Door](/azure/frontdoor/front-door-overview).
- For planned and unplanned failovers:
  - When setting up each Azure service, choose features that support disaster recovery. For example, if [Azure Container Registry](/azure/container-registry/container-registry-intro) is chosen, enable it for geo-replication. If a region goes down, you can still pull images from the replicated region.
- Maintain engineering DevOps capabilities to reach service-level goals.

### Design recommendations for BCDR

The following are best practices for your design:

- Azure Red Hat OpenShift clusters are provisioned with three control plane nodes and three or more worker nodes. Ensure that the cluster is created in a region that supports Availability Zones so that the nodes are spread across the zones.
- For high availability, deploy these nodes to different Availability Zones. Since you need different machine sets for each Availability Zone, create at least three machine sets.
- Don't run extra workloads on the control plane nodes. While they can be scheduled on the control plane nodes, it will cause extra resource usage and stability issues that can affect the entire cluster.
- Create infrastructure machine sets to hold infrastructure components. Apply specific Kubernetes labels to these machines and then update the infrastructure components to run on only those machines.
- Whenever possible, remove the service state from inside containers. Instead, use an Azure platform as a service (PaaS) that supports multiregion replication.
- Deployments should specify pod resource requirements. The scheduler can then appropriately schedule the pod. Reliability depreciates significantly when pods aren't scheduled.
- Set up multiple replicas in the deployment to handle disruptions like hardware failures. For planned events like updates and upgrades, a disruption budget can ensure the required number of pod replicas exist to handle expected application load.
- Use [pod topology](https://docs.openshift.com/container-platform/4.9/nodes/scheduling/nodes-scheduler-pod-topology-spread-constraints.html) constraints to automatically schedule pods on nodes throughout the cluster.
- Your applications might use storage for their data and should ensure availability across regions if needed:
	- Using RWX storage with inbuilt [Azure Files storage class](/azure/openshift/howto-create-a-storageclass).
	- Using CSI Drivers for storage provisioning.
- Create application backup and plan for restore:
	- Include [persistent volumes](/azure/openshift/howto-create-a-backup#create-a-backup-with-velero-to-include-snapshots) in the backup.
- Estimate pod resource limits. Test and establish a baseline. Start with equal values for requests and limits. Then, gradually tune those values until you've established a threshold that can cause instability in the cluster. Pod limits can be specified in your deployment manifests. [Vertical pod autoscaler](https://docs.openshift.com/container-platform/4.10/nodes/pods/nodes-pods-vertical-autoscaler.html) optimizes the CPU and memory request values and can maximize the efficiency of cluster resources.
  - The built-in features can handle failures and disruptions in service architecture. These configurations help to simplify both design and deployment automation. When an organization defines a standard for the SLA, RTO, and RPO, it can use services built into Kubernetes and Azure to achieve business goals.
- Consider blue/green or canary strategies to deploy new releases of application.
- Set [pod priority](https://docs.openshift.com/container-platform/4.10/nodes/pods/nodes-pods-priority.html)/pod disruption budgets to limit the number of pod replicas that the cluster is allowed to take down for maintenance operations, thereby ensuring availability.
- Enforce resource quotas on service namespaces. The resource quota on a namespace will ensure pod requests and limits are properly set on a deployment.
  - Setting resources quotas at the cluster level can cause problems when deploying partner services that don't have proper requests and limits.
- Store your container images in [Azure Container Registry](/azure/openshift/howto-use-acr-with-aro) and [geo-replicate](/azure/container-registry/container-registry-geo-replication) the registry to each region.
- Use multiple regions and peering locations for [Azure ExpressRoute](/azure/expressroute/expressroute-introduction) connectivity. If an outage affecting an Azure region or peering provider location occurs, a redundant hybrid network architecture can help ensure uninterrupted cross-premises connectivity.
- Interconnect regions with global virtual network peering. If the clusters need to talk to each other, connecting both virtual networks to each other can be achieved through virtual network peering. This technology interconnects virtual networks to each other to provide high bandwidth across Microsoft's backbone network, even across different geographic regions.
- Use the split TCP-based anycast protocol, [Azure Front Door](/azure/frontdoor/front-door-overview), to promptly connect your end users to the nearest Front Door POP (point of presence). More features of Azure Front Door include:
  - TLS termination
  - Custom domain
  - Web Application Firewall
  - URL rewrite
  - Session affinity

## Next steps

Learn about [design considerations and recommendations for platform automation and DevOps](./platform-automation-devops.md) in your Azure landing zones.
