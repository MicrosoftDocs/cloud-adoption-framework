---
title: Enterprise-scale management and monitoring - Azure VMware Solution
description: Learn how this enterprise-scale scenario can improve management and monitoring of Azure VMware Solution.
author: pgandham
ms.author: janet
ms.date: 09/15/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-azure-vmware, think-tank
---

# Management and monitoring for an Azure VMware Solution enterprise-scale scenario

You can achieve operational excellence when you design Azure VMware Solution with management and monitoring in mind. VMware is a critical platform. As a result, you should also include guidance in the enterprise-scale design areas in your planning phase. Guidance is available in the Azure enterprise-scale landing zone for management and monitoring [documentation](../../ready/enterprise-scale/management-and-monitoring.md).

## Platform management and monitoring

Review the following considerations for platform management and monitoring of Azure VMware Solution.

- Create alerts and dashboards on the metrics that are most important to your operations teams. See [Configure alerts for Azure VMware Solution](/azure/azure-vmware/configure-alerts-for-azure-vmware-solution#supported-metrics-and-activities) for available monitoring and alerting metrics.

- License VMware eco-system solutions like vRealize Operations Manager and vRealize Network Insight. These solutions provide a detailed understanding of the Azure VMware Solution platform. Customers can see monitoring data like vCenter events and flow logs for the NSX-T distributed firewall. *Pull* logging is currently supported by vRealize Log Insight for Azure VMware Solution . Only events, tasks, and alarms can be captured. Syslog pushing of unstructured data from hosts to vRealize isn't currently supported.

- In-guest memory collection isn't supported by vRealize Operations using VMware tools. Active and consumed memory use will continue to work.

- vSAN storage is a finite resource, so you need to manage vSAN capacity. Use vSAN storage for guest virtual machine (VM) workloads only. Examine the following design considerations to help reduce unnecessary storage on vSAN.

  - [Configure content libraries on Azure Blob Storage](https://avs.ms/centralized-avs-content-library-on-azure-blob/) to move VM template storage off of vSAN.
  - Store backups on an Azure virtual machine, either with [Microsoft tooling](/azure/azure-vmware/set-up-backup-server-for-azure-vmware-solution) or choose a [partner vendor](/azure/azure-vmware/ecosystem-back-up-vms).

- Azure VMware Solution uses a local identity provider. After deployment, use a single administrative user account for the initial Azure VMware Solution configurations. Integrating Azure VMware Solution with [Active Directory](https://docs.vmware.com/en/VMware-vSphere/6.7/com.vmware.psc.doc/GUID-B23B1360-8838-4FF2-B074-71643C4CB040.html) enables traceability of actions to users. Review guidance from the identity portion <!-- link to CDA for identity after finalized --> of the enterprise-scale landing zone documentation.

## Design recommendations

Review the following recommendations for platform management and monitoring of Azure VMware Solution.

- Conduct baseline performance monitoring of Azure VMware Solution infrastructure through the [Azure portal](/azure/azure-vmware/configure-alerts-for-azure-vmware-solution#supported-metrics-and-activities).

- Set the following alerts when the cluster is nearing capacity for disk, CPU, or RAM:

    | Metric  | Alert  |
    |---------|---------|
    | Monitor and alert on vSAN % datastore disk used   | >70% warning  |
    | Monitor and alert on vSAN % datastore disk used   | >75% critical |
    | Monitor and alert on % CPU | >80% warning |
    | Monitor and alert on average memory usage | >80% warning |

- For service-level agreement (SLA) purposes, Azure VMware Solution requires that the cluster keep slack space of 25 percent available on vSAN.

- Integrate the Azure VMware Solution vCenter with an existing identity provider<!-- link to identity CDA after completed -->.

- In a hybrid environment, [monitor the ExpressRoute circuit from on-premises into Azure](/azure/network-watcher/connection-monitor-create-using-portal).

- Configure two connection monitors in [Azure Network Watcher](/azure/network-watcher/network-watcher-monitoring-overview) to monitor connectivity.

  - [Configure the first Connection Monitor](/azure/network-watcher/connection-monitor-create-using-portal) between an Azure-based resource and an Azure VMware Solution-based VM. This monitor lets you see the availability and performance of the network connection between Azure and Azure VMware Solution over ExpressRoute.
  - [Configure the second Connection Monitor](/azure/network-watcher/connection-monitor-create-using-portal) between an on-premises-based VM and an Azure VMware Solution-based VM. This monitor lets you see the availability and performance of network connections between on-premises and Azure VMware Solution over ExpressRoute Global Reach.

## Guest workload management and monitoring

Review the following recommendations for guest management and monitoring of workloads running in Azure VMware Solution.

- During workload migration, it might make sense to manage and monitor Azure VMware Solution workloads like on-premises workloads. After migration, consider using an [Azure Arc](/azure/azure-arc/servers/overview) server to enable management and monitoring of Azure VMware Solution hosted workloads with Azure native solutions.

- Azure VMware Solution implements a default storage policy with thick provisioning enabled. For efficient use of vSAN capacity, evaluate using thin provisioning for VMs. The risk factor is low if you adopt the monitoring methodology above for vSAN datastore capacity alerting.

- Decide between thick or thin provisioned disks. Each VM's disk configuration and individual disks can vary. A VM can have thick or thin disks, or both, dependent on the requirements for the workload. These two extra components make evaluating the storage configuration a firm requirement to ensure the vSAN storage is never over capacity.

- Configure guest monitoring for VMs running in Azure VMware Solution by following the [hybrid guidance](/azure/azure-monitor/vm/monitor-virtual-machine) for Windows and Linux. Configure both Windows and Linux this way for the following Azure integrations:

    |Integration | Description  |
    |---------|---------|
    | [Log Analytics](/azure/azure-monitor/logs/log-analytics-overview) | Primary tool for aggregating, querying, and interactively analyzing logs generated by Azure resources. |
    | [Azure Security Center](/azure/security-center/security-center-introduction) | Unified infrastructure security management system that strengthens security posture by providing advanced threat protection across hybrid and Azure resources. Assessments continually run and vulnerabilities of the Azure VMware Solution VMs report to the Azure service. |
    | [Azure Sentinel](/azure/sentinel/overview) | Cloud-native security information and event management solution. This Azure resource provides security analytics, alert detection, and automated threat response across on-premises and cloud environments. |
    | [Azure Update Management](/azure/automation/update-management/overview) |  Manages operating system updates for Windows and Linux machines on-premises and in cloud environments. |
    | [Azure Monitor](/azure/azure-monitor/overview) | Comprehensive monitoring solution for collecting, analyzing, and acting upon telemetry from cloud and on-premises environments. |

## Other considerations

- If you're using a network virtual appliance, consider monitoring trace logs between both on-premises and Azure. Ensure monitoring is in place between Azure and Azure VMware Solution.

- To help with storage concerns on the vSAN, consider using [Azure disk pools (preview)](/azure/virtual-machines/disks-pools-deploy) or [Azure NetApp Files](/azure/azure-netapp-files/) to extend your storage footprint into Azure native storage services.

## Next steps

Learn about design considerations for Azure VMware Solution business continuity and disaster recovery in an enterprise-scale scenario.

> [!div class="nextstepaction"]
> [Business continuity and disaster recovery for Azure VMware Solution](./eslz-business-continuity-and-disaster-recovery.md)
