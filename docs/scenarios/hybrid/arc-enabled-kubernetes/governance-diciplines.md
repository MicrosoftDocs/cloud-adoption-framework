---
title: Security, governance and compliance baseline for hybrid, multicloud, and edge Kubernetes deployments
description: Expand Azure governance, security and compliance capabilities to hybrid, multicloud, and edge deployments.
author: lanicolas
ms.author: matgri
ms.date: 06/10/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-hybrid
---

# Security, governance and compliance baseline for hybrid, multicloud, and edge Kubernetes deployments

This article walks through the key design considerations and best practices for the topics of security, governance, and compliance of Azure Arc-enabled Kubernetes deployments that should be in place as part of a CAF enterprise-scale landing zone implementation.

[Azure Policy](/azure/governance/policy/overview) and [Microsoft Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction) are cloud-native tools that allow the implementation of guardrails, controls, reports, alerts and remediation tasks in an automated fashion. By combining them with Azure Arc-enabled Kubernetes, your governance policies and security checks are extended to any Kubernetes cluster in public or private clouds.

Before going through this document its important to understand governance principles because of the effect of the decisions made, also make sure to review [Enterprise-scale for AKS](/azure/cloud-adoption-framework/scenarios/aks/enterprise-scale-landing-zone) to understand the relevant concepts of Enterprise Scale in a container environment.

By the end of this article, you will understand the critical design areas for security, governance, and compliance with clear Microsoft guidance.

## Architecture

The following image shows a conceptual reference architecture that demonstrates the security, compliance and governance design areas for Azure Arc-enabled Kubernetes:

![A diagram depicting the Enterprise-scale security, governance and compliance for Azure Arc-enabled Kubernetes on Azure conceptual reference architecture.](./media/arc-enabled-kubernetes-security-compliance-governance.png)

## Design considerations

As your hybrid and multicloud resources become part of Azure Resource Manager, they can be managed and governed with Azure tools just as [Azure Kubernetes Service(AKS)](/azure/aks):

- **Agent Provisioning:** Define a strategy for provisioning the Azure Arc-enabled Kubernetes agent and use the least privilege principle to create the onboarding service principal. Consider a method of automation for bulk enrollment.
- **Agent Management:** The Arc agent plays a critical role in the hybrid operations of your Azure Arc-enabled Kubernetes clusters as it enables you to manage them from Azure, create GitOps configurations and enforce governance policies, it is important to implement solutions that keep track of the [agent's connectivity status](/azure/azure-arc/kubernetes/conceptual-agent-architecture#connectivity-status). Also it is critical to define a process for upgrading the Azure Arc-enabled Kubernetes agents.
- **Role based access controls:** Define administrative, operations, and developer roles within the organization that will take care of day-to-day operations in the hybrid clusters. Mapping each team to actions and responsibilities will determine Azure role-based access control (RBAC) roles and Kubernetes ClusterRoleBinding and RoleBinding. Consider using a [RACI](/azure/cloud-adoption-framework/organize/raci-alignment) matrix to support this effort and build controls into the management scope hierarchy that you define following the resource consistency and inventory management guidance. For more information, review the [Identity and access management for Azure Arc-enabled kubernetes section of this guide](PLACEHOLDER IDENTITY CDA).
- **Secret and certificate management:** secure secrets and certificates using Azure Key Vault and deploying its extension on your Azure Arc-enabled kubernetes clusters via Container Storage Interface (CSI).
- **Enable and secure GitOps configurations:** GitOps configurations enforce the desired state of the system so it is an important tool for compliance as there is tracking of all the changes made overtime. When working with GitOps configurations you need to thing about how to secure access to your source control tool.
- **Policy management and reporting:** Define a governance plan for your hybrid Kubernetes that translates into Azure Policies and remediation tasks.
- **Log management strategy:** Plan for metrics and log collection of your hybrid resources into a Log Analytics workspace for further analysis and auditing. Review the recommendations for [monitoring in this guide](./management-disciplines.md).
- **Threat protection and cloud security posture management:** enforce thread protection and introduce controls to detect security misconfigurations and track compliance. Also, use [Azure's intelligence](/azure/sentinel/overview) to protect your hybrid workloads against threats. [Enable Microsoft Defender for Kubernetes](/defender-for-cloud/defender-for-kubernetes-introduction) for all subscriptions containing Azure Arc-enabled Kubernetes for security baseline monitoring, security posture management and threat protection.
- **Secure cluster access:** plan how to secure access to the Kubernetes API. Azure Arc-enabled Kubernetes provides the cluster connect feature that provides connectivity to the apiserver without having to enable any inbound port.
- **Improve microservices observability and security:** the implementation of a service mesh can help with authentication, authorization, security and visibility of microservice-based applications. Azure Arc-enabled Kubernetes simplifies the deployment of Open Service Mesh as an extension.
- **Registry Security:** the container registry is another element that should be considered in the context of governance and security of an Azure Arc-enabled Kubernetes cluster as it holds the application images that can be a confidentiality risk and is another attack vector.

## Design recommendations

### Agent Provisioning

Define a strategy for onboarding your clusters in Azure Arc, including a method of automation for bulk enrollment and establish a formal plan that takes into account the scope and plan for a deployment including objectives, selection criteria, success criteria, training plans, rollback and risks.

It is possible to integrate the agent provisioning as part of your continuous integration and continuous deployment (CI/CD) pipelines by [using a service principal](/azure/azure-arc/kubernetes/create-onboarding-service-principal). It is recommended to limit the privileges of this service principal and only asign the roles required to onboard Kubernetes to Azure, the "Kubernetes Cluster - Azure Arc Onboarding" role, as this can only be used to onboard Kubernetes and cannot re-onboard or delete the resource.

### Agent Management

The Azure Arc agent is the key piece for Azure Arc-enabled Kubernetes, it contains several logical components that play a role in security, governance and management operations. If the agent stops sending heartbeats to Azure, goes offline or looses connectivity to Azure you will not be able to perform operational tasks on it. Hence, it is necessary to develop a plan to get notified and how you will respond.

Azure Activity Log can be used to set up [resource health notifications](/azure/service-health/resource-health-alert-monitor-guide) and remain informed on current and historical health status of the [agent's pods](/azure/azure-arc/kubernetes/quickstart-connect-cluster?tabs=azure-cli#6-view-azure-arc-agents-for-kubernetes), review [management best practices](management-disciplines.md). An [Azure Arc-enabled Kubernetes cluster will be shown offline](/azure/azure-arc/kubernetes/conceptual-agent-architecture) if the service has not received an agent heartbeat for 15 minutes, review the [Azure Arc-enabled Kubernetes connectivity best practices](PLACEHOLDER NETWORKING CDA) to make sure the agent can connect to Azure's endpoints securely.

### Role based access controls

Once a Kubernetes cluster is onboarded you will be able to assign [Azure Role Based Access Controls](/azure/role-based-access-control/overview) to the Azure Arc-enabled resource, follow the [least privilege principle](/security/benchmark/azure/baselines/arc-enabled-security-baseline#pa-7-follow-just-enough-administration-least-privilege-principle) users, groups or applications assigned with roles like "Contributor" or "Owner" are able to execute operations like deploying extensions which basically has the power to do anything on Arc-enabled Kubernetes. These roles should be used with caution to limit possible blast radius or eventually replaced by custom roles.

Also consider the sensitive data that is sent to the Azure Monitor Log Analytics workspace, the same RBAC principle should be applied to the data itself. Azure Arc-enabled Kubernetes provides RBAC access to log data collected by the Log Analytics agent, stored in the Log Analytics workspace the machine is registered to. Review how to implement granular Log Analytics Workspace access in the [designing your Azure Monitor Logs deployment documentation](/azure/azure-monitor/logs/design-logs-deployment#access-control-overview).

Consider [integrating your Azure Arc-enabled Kubernetes cluster with Azure Active Directory](/azure/azure-arc/kubernetes/azure-rbac) this will allow you to use Azure role assignments to granulary control who has access an permissions on Kubernetes objects. This integration works natively with Kubernetes ClusterRoleBinding and RoleBinding object types and effectively consolidates authorization to your Kubernetes cluster with Azure AD as the central identity and access management service. By using Azure AD you get full auditing and tracing of changes done in the cluster as well as any authorization event.

The following image shows a conceptual reference architecture that demonstrates the Azure AD integration for Azure Arc-enabled Kubernetes:

![Azure Arc-enabled Kubernetes and Azure AD integration](./media/arc-enabled-k8s-aad-integration.png)

### Secret and certificate management

Consider using the Azure Key Vault extension to manage secrets and certificates on your Azure Arc-enabled Kubernetes clusters. The Key Vault extension allows you to manage the certificate lifecycle on your Kubernetes deployments. [PLACEHOLDER](Jumpstart scenario)

### Enable and secure GitOps configurations

GitOps is an essential component of any IT strategy that follows a fully automated approach to operations, it provides scale, consistency, tracking and auditing capabilities to any deployment.
This GitOps approach simplifies the deployment of multiple aplications, accross clusters and environments while tracking and enforcing the desired state of the system declaratively with Git. By using Git as your single source of truth and as the central tool for all deployments it becomes the best way to track cluster state, account for changes and approvals overtime, facilitate fault investigation while enabling automation across distributed environments.

The following image shows how the GitOps flow looks like in the context of Arc-enabled KubernetesAzure Arc-enabled Kubernetes:

![Azure Arc-enabled Kubernetes GitOps Flow](./media/arc-enabled-k8s-gitops.png)

Make sure to review best practices on [implementing CI/CD workflows with GitOps](PLACEHOLDER_CDA)

### Policy management and reporting

Having a policy-driven governance is a foundational principle of cloud-native operations and Cloud Adoption Framework. [Azure Policy](/azure/governance/policy/) provides the mechanism to enforce corporate standards and to assess compliance at scale. Through it, you can implement governance for consistency of deployments, compliance, control costs, and improve your security posture; with its compliance dashboard, you will get an aggregated view of the overall state as well as remediation capabilities. Azure Arc-enabled Kubernetes supports [Azure Policy](/azure/governance/policy/overview) at the Azure Resource Management layer, and also in-cluster policy enforcements by extending [Gatekeeper for Open Policy Agent](/azure/governance/policy/concepts/policy-for-kubernetes?toc=/azure/azure-arc/kubernetes/toc.json). The following image ilustrates how Azure Policy applies at-scale enforcements and safeguards on Azure Arc-enabled Kubernetes clusters:

![Azure Arc-enabled Kubernetes GitOps Flow](./media/arc-enabled-k8s-policy.png)

Understand the [scope of Azure policy](/azure/governance/policy/concepts/scope) and where it can be applied (Management Group, subscription, resource group or individual resource level). Create a Management Group design in accordance with the recommended practices outlined in the [Cloud Adoption Framework Enterprise Scale](/azure/cloud-adoption-framework/ready/enterprise-scale/management-group-and-subscription-organization)

- Determine what Azure policies are required by defining business, regulatory and security requirements for Azure Arc-enabled Kubernetes.
- Enforce tagging and implement [remediation tasks](/azure/governance/policy/how-to/remediate-resources).
- Use an Azure Policy to [enforce GitOps](/azure/azure-arc/kubernetes/use-azure-policy) and apply configurations at scale.
- Understand and evaluate the [Azure Policy built-in definitions for Azure Arc-enabled Kubernetes](/azure/azure-arc/kubernetes/policy-reference).
- Use an Azure Policy and Remediation tasks to onboard management services agents via the extension management feature, including Microsoft Defender.
- Enable [Azure Monitor Container Insights](/azure/azure-monitor/containers/container-insights-enable-arc-enabled-clusters?toc=/azure/azure-arc/kubernetes/toc.json) for compliance and operational monitoring of Azure Arc-enabled Kubernetes.

### Log management strategy

Design and plan your Log Analytics Workspace deployment, as it will be the container where data is collected, aggregated, and later analyzed. As the Log Analytics Workspace represents a geographical location of your data, a level of isolation and scope for configurations like data retention you will have to identify the number of workspaces needed and how it maps to your organizational structure. It is recommended to use a single Azure Monitor Log Analytics workspace to manage centrally RBAC, visibility and reporting as it is described in the [Management and monitoring best practices of Cloud Adoption Framework](/azure/cloud-adoption-framework/ready/enterprise-scale/management-and-monitoring).

Review the best practices in [designing your Azure Monitor Logs deployment](/azure/azure-monitor/logs/design-logs-deployment).

### Threat protection and cloud security posture management

[Microsoft Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction) provides a unified security-management platform segmented as a cloud security posture management (CSPM) and cloud workload protection platform (CWPP). To increase security on your hybrid landing zone it is important to protect the data and assets hosted in Azure and elsewhere, Microsoft Defender for Kubernetes extends these capabilities to Azure Arc-enabled Kubernetes.  To heighten security on your hybrid landing zone consider the following:

- Use Azure Arc-enabled Kubernetes extension to onboard hybrid resources in Microsoft Defender for Cloud.
- Implement an Azure Policy to make sure all resources are compliant and its security data is collected into the Log Analytics workspaces.
- Enable Microsoft Defender for all subscriptions and use Azure Policy to ensure compliance.
- Use security information and event management integration with Microsoft Defender for Cloud and Azure Sentinel.

The following image shows a conceptual reference architecture for Microsoft Defender for Cloud on an Azure Arc-enabled Kubernetes:

![A diagram depicting the Azure Policy for Azure Arc-enabled Kubernetes](./media/arc-enabled-k8s-defender.png)

If Azure Container Registry is used as the central private Docker registry to store and manage your container images, [enable Microsoft Defender for container registries](/azure/defender-for-cloud/defender-for-container-registries-introduction) to also scan the images for vulnerabilities with the integrated scanner powered by Qualys.

Make sure to review [the best practices for a secure network connectivity](PLACEHOLDER_Network).

### Secure cluster access

Plan how to secure access to the Kubernetes API. Azure Arc-enabled Kubernetes provides the cluster connect feature that provides connectivity to the apiserver without having to enable any inbound port.

### Improve microservices observability and security

the implementation of a service mesh can help with authentication, authorization, security and visibility of microservice-based applications. Azure Arc-enabled Kubernetes simplifies the deployment of Open Service Mesh as an extension.

### Registry Security

the container registry is another element that should be considered in the context of governance and security of an Azure Arc-enabled Kubernetes cluster as it holds the application images that can be a confidentiality risk and is another attack vector.

## Next steps

For more guidance for your cloud adoption journey, see the following article:

- [Manage hybrid and multicloud environments](./manage.md)
- [Connect an existing Kubernetes cluster to Azure Arc](/azure/azure-arc/kubernetes/quickstart-connect-cluster?tabs=azure-cli)
- [Secret and certificate management](PLACEHOLDER Jumpstart)
- [Threat protection and cloud security posture management](/azure/defender-for-cloud/)
- [Apply GitOps configurations on GKE as an Azure Arc Connected Cluster using Azure Policy for Kubernetes](https://azurearcjumpstart.io/azure_arc_jumpstart/azure_arc_k8s/day2/gke/gke_policy/)
- [Integrate Azure Defender with Cluster API as an Azure Arc Connected Cluster using Kubernetes extensions](https://azurearcjumpstart.io/azure_arc_jumpstart/azure_arc_k8s/day2/cluster_api/cluster_api_defender_extension/)
- [Integrate Open Service Mesh (OSM) with Cluster API as an Azure Arc Connected Cluster using Kubernetes extensions](https://azurearcjumpstart.io/azure_arc_jumpstart/azure_arc_k8s/day2/cluster_api/cluster_api_osm_extension/)
