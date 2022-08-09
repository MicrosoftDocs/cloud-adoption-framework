---
title: Upgradeability disciplines
description: Learn how to implement upgradeability disciplines for Azure Arc-enabled SQL Managed Instance.
author: sebassem
ms.author: sebassem
ms.date: 07/28/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-hybrid, think-tank
---

# Upgradeability disciplines for Azure Arc-enabled SQL Managed Instance

Azure Arc-enabled SQL managed Instance allows you to keep your instances always current with servicing patches and new features with minimal downtime and manual intervention. Updates are pulled from the Microsoft Container Registry or a private registry  and deployment cadences are set by you in accordance with your policies, providing full control on the upgrade process.

This article provides key design considerations and recommendations for configuring and managing the upgrade process on your Azure Arc-enabled SQL Managed Instances.

## Architecture

[Placeholder for diagrams]

## Design considerations

### Data Controller upgrades

- Consider the different tools (Azure CLI, Azure portal or Kubernetes tools) that you can use to perform the Data Controller upgrades depending on the skillset of the team responsible for the upgrade process and the connectivity mode being used (directly or indirectly connected mode).
- Review your Azure Arc-enabled SQL Managed Instances to check if you have any preview data services deployed on the same Data Controller that will be upgraded with Generally Available instances. You cannot perform in-place upgrades if you have a mix of preview and Generally Available instances deployed on the same Data Controller.
- Review the versions of all the Azure Arc-enabled SQL Managed Instances deployed on the Data Controller to be confirm they are at the same version as the Data Controller before performing the upgrade.
- Consider the [supported upgrade path](/azure/azure-arc/data/upgrade-data-controller-direct-cli#upgrade-path) to determine the next right version for your Data Controller before the upgrade.
- Create an inventory of the current versions of the deployed Data Controllers. [Azure Resource Graph](/azure/governance/resource-graph/overview) can be used to query your current deployed Data Controllers.

   ```shell
    resources
    | where type == 'microsoft.azurearcdata/datacontrollers'
    | extend version = tostring(properties.k8sRaw.status.runningVersion)
    | project name,location,resourceGroup,version
   ```

> NOTE
> An upgrade of the data controller will not cause downtime for the data services.

#### Directly connected mode

- Determine if upgrading the Data Controller in directly connected mode will be implemented using the Azure Portal or the Azure CLI.
- Review the prerequisites for upgrades using the [Azure portal](/azure/azure-arc/data/upgrade-data-controller-direct-portal#prerequisites) and the [Azure CLI](/azure/azure-arc/data/upgrade-data-controller-direct-cli#prerequisites).

#### Indirectly connected mode

- Determine if upgrading the Azure Arc Data Controller in indirectly connected mode will be implemented using the [Azure CLI](/azure/azure-arc/data/upgrade-data-controller-indirect-cli) or [Kubernetes tools](/azure/azure-arc/data/upgrade-data-controller-indirect-kubernetes-tools).
- Review the prerequisites for upgrades using the [Kubernetes tools](/azure/azure-arc/data/upgrade-data-controller-indirect-kubernetes-tools#prerequisites) and the [Azure CLI](/azure/azure-arc/data/upgrade-data-controller-indirect-cli#prerequisites).
- Decide if you will use the [Microsoft Artifact Registry](https://mcr.microsoft.com/) in case your clusters have internet connectivity or a private registry in case your clusters are air gapped to pull the Azure Arc Data services images.
- Plan for the [required Kubernetes permissions](/azure/azure-arc/data/upgrade-data-controller-indirect-kubernetes-tools#create-the-service-account-for-running-upgrade) to for the service account used to upgrade the Azure Arc Data Controller using Kubernetes tools.

### Azure Arc-enabled SQL Managed Instance upgrades

#### General considerations

- Upgrades to the Data Controller must be performed prior to upgrading the Azure Arc-enabled SQL Managed Instances. The data and SQL MI extensions versions are related and must be the same version.
- Decide if you will use automatic or manual upgrades of your Azure Arc-enabled SQL Managed Instances depending on your requirements.
- In case of automatic upgrades, only a single maintenance window can be defined for a Data Controller. Consider the number of different maintenance windows needed for different workloads to identify the number of needed Data Controllers.

#### General Purpose service tier

- During an Azure Arc-enabled SQL Managed Instance in a General Purpose service tier upgrade, the pod will be terminated and reprovisioned at the new version. It is important to understand the application and client side impact of an upgrade where there will be a short amount of downtime as the new pod is created.
- Review your applications architecture to understand if they have the needed resiliency and re-try logic to support brief impact during an upgrade.

#### Business Critical service tier

- During an Azure Arc-enabled SQL Managed Instance in a Business Critical service tier upgrade with multiple replicas, the active database instance switches from one pod to another. It is important to understand the application and client side impact of an upgrade where there is a brief moment of downtime when the failover occurs.
- Review your applications architecture to understand if they have the needed resiliency and re-try logic to support brief impact during an upgrade.

### Extension upgrade

- Review the [extensions management critical design area](/azure/cloud-adoption-framework/scenarios/hybrid/arc-enabled-kubernetes/eslz-arc-kubernetes-extensions-management) in the [Azure Arc-enabled Kubernetes landing zone accelerator](/azure/cloud-adoption-framework/scenarios/hybrid/enterprise-scale-landing-zone).

## Design recommendations

### Data Controller upgrades

- If upgrading using the Azure CLI , verify that the arcdata extension version corresponds to the image version you want to upgrade to in the Version log.
- Perform a [dry run](/azure/azure-arc/data/upgrade-data-controller-direct-cli#upgrade-data-controller-1) prior to the upgrade to validate the version schema, the private repository authorization token (if used) and that the registry exists before attempting an actual upgrade.
- Create a process to monitor for new Azure Arc Data Controller upgrades availability.
- Properly size your cluster by planning for future capacity, upgrades and features.
- Avoid deploying Generally avaialble and preview Azure Arc-enabled SQL Managed Instances on the same Data Controller.
- Avoid using preview versions in your production environment and only use them for evaluation purposes.
- Review the [troubleshooting guide](/azure/azure-arc/data/maintenance-window#failed-upgrades) to understand how to get the needed logs and understand the reason for upgrade failure.

#### Directly connected mode

- Create a process to monitor the upgrade process using the [Azure Portal](/azure/azure-arc/data/upgrade-data-controller-direct-portal#monitor-the-upgrade-status) or [Azure CLI](/azure/azure-arc/data/upgrade-data-controller-direct-cli#monitor-the-upgrade-status).

#### Indirectly connected mode

- Create a process to monitor the upgrade process using the [Kubernetes tools](/azure/azure-arc/data/upgrade-data-controller-indirect-kubernetes-tools#monitor-the-upgrade-status) or [Azure CLI](/azure/azure-arc/data/upgrade-data-controller-indirect-cli#monitor-the-upgrade-status).
- [Automate the process](https://github.com/microsoft/azure_arc/tree/main/arc_data_services/deploy/scripts) to pull down images to your private registry.

### Azure Arc-enabled SQL Managed Instance upgrades

#### General recommendations

- Keep your Azure Arc-enabled Managed Instances up-to-date to the latest available version to make sure you receive the latest patches, bug fixes and features.
- Make sure to have your point in time restore backup policy configured as needed to be able to recover in case of problems during an upgrade. Review the [Business continuity and disaster recovery design area](../arc-enabled-datasvc-sqlmi/eslz-arc-datasvc-sqlmi-bcdr.md).
- Perform a [dry run](/azure/azure-arc/data/upgrade-sql-managed-instance-direct-cli#upgrade-the-managed-instance) prior to the upgrade to validate the version schema, the private repository authorization token (if used) and that the registry exists before attempting an actual upgrade.
- Use the Azure CLI to perform at scale upgrades of your Azure Arc-enabled SQL Managed Instances.
- Use [Automatic upgrades](/azure/azure-arc/data/maintenance-window) for workloads that can tolerate immediate upgrades and opt-out of automatic upgrades for workloads that need a scheduled off peak hour to perform the upgrade.
- If automatic upgrades will be used, make sure to define a suitable maintenance window to allow for upgrades to happen during off-peak hours.
- In case of manual upgrades, ensure that you establish a regular cadence to perform upgrades to stay within supported versions.
- Create a process to monitor the upgrade status using [Azure CLI](/azure-arc/data/upgrade-data-controller-direct-cli#monitor-the-upgrade-status) or the [Kubernetes tools](/azure/azure-arc/data/upgrade-data-controller-indirect-kubernetes-tools#monitor-the-upgrade-status).
- Review the [corresponding versions](/azure/azure-arc/data/version-log) of the different components before performing an upgrade to validate having the right components versions in place.

#### General Purpose service tier

- Perform upgrades during non-business critical times to minimize the impact to users and data.
- Review the of the [reliability pillar](/azure/architecture/framework/resiliency/overview) of the [Microsoft Azure Well-Architected Framework](/azure/architecture/framework/) for more information on architecting [resiliency and retry guidance](/azure/architecture/best-practices/retry-service-specific#sql-database-using-adonet) for your applications.

#### Business Critical service tier

- Deploy the Business Critical instance with 3 replicas instead of 2 to achieve higher availability and less downtime with upgrade and failover activities.
- Perform upgrades during non-business critical times to minimize the impact to users and data.
- Review the of the [reliability pillar](/azure/architecture/framework/resiliency/overview) of the [Microsoft Azure Well-Architected Framework](/azure/architecture/framework/) for more information on architecting [resiliency and retry guidance](/azure/architecture/best-practices/retry-service-specific#sql-database-using-adonet) for your applications.

### Extension upgrade

- Upgrade the [Arc Data Controller extension](/azure/azure-arc/data/upgrade-data-controller-direct-cli#upgrade-arc-data-controller-extension) before upgrading the Data Controller.

## Next steps

For more information on your hybrid and multicloud cloud journey, see the following articles:

- Review the [capabilities](/azure/azure-arc/data/overview) of Azure Arc-enabled Data Services.
- Review the [validated Kubernetes distributions](/azure/azure-arc/data/validation-program) for Azure Arc-enabled Data Services.
- Review [Manage hybrid and multicloud environments](/azure/cloud-adoption-framework/scenarios/hybrid/manage)..
- Experience Azure Arc-enabled SQL Managed Instance automated scenarios with [Azure Arc Jumpstart](https://azurearcjumpstart.io/azure_arc_jumpstart/azure_arc_data/).
- To learn more about Azure Arc, review the [Azure Arc learning path on Microsoft Learn](/learn/paths/manage-hybrid-infrastructure-with-azure-arc/).