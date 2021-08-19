---
title: Enterprise-scale management and monitoring for Azure VMware Solution
description: <<Describe how this enterprise-scale scenario can improve management and monitoring of Azure VMware Solution.>>
author: pgandham
ms.author: janet
ms.date: 06/28/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Management and monitoring for Azure VMware Solution enterprise-scale scenario

Designing Azure VMware Solution with management and monitoring in mind will allow you to achieve operational excellence. VMware is a critical platform. As a result, guidance in the enterprise-scale design areas should also be included in your planning phase. Guidance is available in the Azure Enterprise Scale Landing Zone for Management and Monitoring [documentation](/azure/cloud-adoption-framework/ready/enterprise-scale/management-and-monitoring).

## Design considerations for platform management and monitoring

Review the following considerations for platform management and monitoring of Azure VMware Solution:

1. Create alerts and dashboards on metrics that are most important to your operations teams. The metrics available for monitoring and alerting can be found [here](/azure/azure-vmware/configure-alerts-for-azure-vmware-solution#supported-metrics-and-activities).

1. Consider licensing VMware eco-system solutions like vRealize Operations Manager and vRealize Network Insights. These solutions provide a detailed understanding of the Azure VMware Solution platform. Customers can see monitoring data like vCenter events and flow logs for the NSX-T Distributed Firewall. vRealize Log Insights for Azure VMware Solution currently only supports "pull" logging. Only events, tasks, and alarms can be captured. Syslog pushing unstructured data from hosts to vRealize is not currently supported.

1. vRealize Operations doesn't support in-guest memory collection using VMware tools. Active and consumed memory utilizations will continue to work. This feature is currently under review and may be available in the future for Azure VMware Solution.

1. vSAN storage is a finite resource, so customers need to manage vSAN capacity. Customers should use vSAN storage for guest virtual machine workloads only. The following design considerations should be examined closely to help alleviate unnecessary storage on vSAN. 
    1. [Configure content libraries on Azure Blob storage](https://avs.ms/centralized-avs-content-library-on-azure-blob/) to move virtual machine template storage off of vSAN.
    1. Store backups on an Azure virtual machine, either with [first party tooling](/azure/azure-vmware/set-up-backup-server-for-azure-vmware-solution) or choose a [third party vendor](/azure/azure-vmware/ecosystem-back-up-vms).

1. Azure VMware Solution uses a local identity provider. After deployment, customers will use a single administrative user account for initial Azure VMware Solution configurations. Integrating Azure VMware Solution with [Active Directory](https://docs.vmware.com/en/VMware-vSphere/6.7/com.vmware.psc.doc/GUID-B23B1360-8838-4FF2-B074-71643C4CB040.html) enables traceability of actions to users. Review guidance from the [identity portion](link to CDA for identity after finalized) of the Enterprise Scale Landing Zone documentation.

## Design recommendations

Review the following recommendations for platform management and monitoring of Azure VMware Solution:

1. Conduct baseline performance monitoring of Azure VMware Solution infrastructure through the [Azure portal](/azure/azure-vmware/configure-alerts-for-azure-vmware-solution#supported-metrics-and-activities).

1. Set the following alerts when the cluster is nearing capacity for disk, CPU, or RAM.

    | Metric  | Alert  |
    |---------|---------|
    | Monitor and alert on vSAN % datastore disk used   | >70% warning  |
    | Monitor and alert on vSAN % datastore disk used   | >75% critical |
    | Monitor and alert on % CPU | >80% warning |
    | Monitor and alert on average memory usage | >80% warning |

1. For SLA purposes, Azure VMware Solution requires that the cluster retains slack space of 25% available on vSAN.

1. Integrate the Azure VMware Solution vCenter with an [existing identity provider](link to identity CDA after completed).

1. In a hybrid environment, [monitor the ExpressRoute circuit from on-premises into Azure](/azure/network-watcher/connection-monitor-create-using-portal).

1. Configure two connection monitors in Azure Network Watcher to monitor connectivity:
    1. [Configure the first connection monitor](/azure/network-watcher/connection-monitor-create-using-portal) between an Azure-based resource and an Azure VMware Solution based virtual machine. This connection monitor enables availability and performance monitoring of the network connection between Azure and Azure VMware Solution over ExpressRoute.
    1. [Configure the second connection monitor](/azure/network-watcher/connection-monitor-create-using-portal) between an on-premises based virtual machine and an Azure VMware Solution based virtual machine. This connection monitor enables availability and performance monitoring of network connections between on-premises and Azure VMware Solution over ExpressRoute Global Reach.

## Guest workload management and monitoring

Review the following considerations and recommendations for guest management and monitoring of workloads running in Azure VMware Solution:

1. During workload migration, it may make sense to manage and monitor Azure VMware Solution workloads similarly to on-premises workloads. After migration, consider using [Azure Arc](/azure/azure-arc/servers/overview) for server to enable management and monitoring of Azure VMware Solution hosted workloads with Azure native solutions.

1. Azure VMware Solution implements a default storage policy with thick provisioning enabled. For efficient use of vSAN capacity, evaluate using thin provisioning for virtual machines. The risk factor is low if customers adopt the monitoring methodology above for vSAN datastore capacity alerting.

1. Another consideration is deciding upon thick or thin provisioned disks. Each virtual machine's disk configuration may vary. Additionally, individual disks on the virtual machine may vary. A virtual machine could have thick or thin disks, dependent upon requirements for the workload. Similarly, the virtual machine could have both thick and thin disks configured. These two extra components make evaluating the storage configuration a firm requirement to ensure the vSAN storage is never over capacity.

1. Configure guest monitoring for virtual machines running in Azure VMware Solution by following the hybrid documentation available for [Windows](/azure/azure-monitor/vm/quick-collect-windows-computer) and [Linux](/azure/azure-monitor/vm/quick-collect-linux-computer). Configuring both Windows and Linux in this way allows for the following Azure integrations:

    |Integration | Description  |
    |---------|---------|
    | Log Analytics | Primary tool for aggregating, querying, and interactively analyzing logs generated by Azure resources. |
    | Azure Security Center | Unified infrastructure security management system that strengthens security posture by providing advanced threat protection across hybrid and Azure resources. Assessments continually run and vulnerabilities of the Azure VMware Solution virtual machines report to the Azure service. |
    | Azure Sentinel | Cloud-native security information and event management solution. This Azure resource provides security analytics, alert detection, and automated threat response across on-premises and cloud environments. |
    | Azure Update Management |  Manages operating system updates for Windows and Linux machines on-premises and cloud environments. |
    | Azure Monitor | Comprehensive monitoring solution for collecting, analyzing, and acting upon telemetry from cloud and on-premises environments. |

## Additional considerations

1. If using a network virtual appliance, consider monitoring trace logs between both on-premises and Azure. Ensure monitoring is in place between Azure and Azure VMware Solution as well.

1. To help with storage concerns on the vSAN, consider using [Azure Disk Pools](/azure/virtual-machines/disks-pools-deploy) or [NetApp Files](/azure/azure-netapp-files/) to extend your storage footprint into Azure native storage services.
