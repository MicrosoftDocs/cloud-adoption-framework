---
title: Machine learning enterprise security
description: This article provides best practices when planning or managing a secure Azure Machine Learning deployment.
author: jhirono
ms.author: jhirono
ms.date: 09/15/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Azure Machine Learning best practices for enterprise security

This article explains a collection of security best practices when planning or managing a secure Azure Machine Learning deployment. These best practices are derived from our experience with Azure Machine Learning and the experiences of customers like yourself.

Each best practice explains:

- What the best practice is

- Why you want to enable that best practice

- Reference documentation to learn how to enable the best practice

## Recommended network security architecture

The recommended network security architecture for Azure Machine Learning is to create a virtual network (VNet) with the following subnets:

* __Training__ - Contains compute resources used for training, such as Azure Machine Learning compute instance or compute cluster.
* __Scoring__ - Contains compute resources used for scoring, such as Azure Kubernetes Service (AKS).
* __Firewall__ - Contains the firewall (such as Azure Firewall) that allows traffic to/from the public internet.

The VNet also contains a __private endpoint__ for your Azure Machine Learning workspace and the following dependency services:

* Azure Storage Account
* Azure Key Vault
* Azure Container Registry

__Outbound__ communication from the VNet must be able to reach the following Microsoft services:

* Azure Active Directory
* Azure Resource Manager
* Azure Machine Learning
* Azure Front Door
* Azure Storage
* Azure Container Registry (including specific registries maintained by Microsoft)

Remote clients connect to the VNet using either Azure ExpressRoute or a VPN connection.

:::image type="content" source="./media/azure-ml-recommended-secure-network-architecture.png" alt-text="A diagram of the recommended secure architecture":::

## Virtual network and private endpoint design

Consider the following items:

- In general, we recommend creating separate subnets for training and
    Scoring, and using the training subnet for all private endpoints.

- The number of required IPs. Compute Instance needs one private IP per each. Compute Cluster needs one private IP per node. Azure Kubernetes Service (AKS) clusters need many private IP addresses, which are described in [Plan IP addressing for your AKS cluster](/azure/aks/configure-azure-cni#plan-ip-addressing-for-your-cluster). We recommend having at least the separated subnet for AKS to prevent IP addresses exhaustion.

- The compute resources need to have access to your Azure Storage Account, Azure Key Vault, and Azure Container Registry (ACR). In the above diagram, the Training subnet and Scoring subnet need to have access to storage, key vault, and ACR. Create private endpoints for storage, key vault, and ACR.

- For the default storage attached to your Azure Machine Learning workspace, you need to have two private endpoints, one for Azure Blob storage and another for Azure File storage.

- The workspace private endpoint and storage private endpoints should be in the same subnet if you use the Azure Machine Learning studio.

If you plan to have multiple workspaces, we recommend creating a virtual network for each workspace to have the explicit network boundary between workspaces.

## Adopt private IP everywhere

Private IP is recommended to minimize your Azure resources' exposure to the Internet. Azure Machine Learning uses multiple Azure resources, and the private endpoint for Azure Machine Learning is not enough for end-to-end private IP. Below is the list of major resources and enable private IP with all resources. Compute instance and compute cluster are the only resources that do not have the private IP feature.

| Resources | Solutions to enable Private IP | Documentation |
| ----- | ----- | ----- |
| Workspace | Private Endpoint | [Configure a private endpoint for an Azure Machine Learning workspace](/azure/machine-learning/how-to-configure-private-link?tabs=python)
| **Associated Resources** |
| Storage | Private Endpoint | [Secure an Azure Machine Learning workspace](/azure/machine-learning/how-to-secure-workspace-vnet#secure-azure-storage-accounts-with-service-endpoints) |
| KeyVault | Private Endpoint | [Secure an Azure Machine Learning workspace](/azure/machine-learning/how-to-secure-workspace-vnet#secure-azure-key-vault) |
| Container Registry | Private Endpoint | [Secure an Azure Machine Learning workspace](/azure/machine-learning/how-to-secure-workspace-vnet#enable-azure-container-registry-acr) |
| Application Insight | Not Supported | NA |
| **Training Resources** |
| Compute Instance | Behind VNet with public IP | [Secure training environments](/azure/machine-learning/how-to-secure-training-vnet?tabs=azure-studio#compute-instance) |
| Compute Cluster | Behind VNet with public IP | [Secure training environments](/azure/machine-learning/how-to-secure-training-vnet?tabs=azure-studio%2Cipaddress#compute-cluster) |
| **More Hosting Resources** |
| Kubernetes Cluster | Private Endpoint | [Secure inferencing environments](/azure/machine-learning/how-to-secure-inferencing-vnet?tabs=python#secure-vnet-traffic) |
| AML Load Balancer on AKS | Private Load Balancer | [Secure inferencing environments](/azure/machine-learning/how-to-secure-inferencing-vnet?tabs=python#secure-vnet-traffic) |
| Container Instance | Private Endpoint | Cannot use a private endpoint with container instance if the Container Registry also uses a private endpoint. |

## Control VNet inbound and outbound traffic

Use a firewall or Azure Network Security Group to minimize the inbound and outbound traffic of your virtual network. For more information on inbound and outbound requirements, see [Configure inbound and outbound network traffic](/azure/machine-learning/how-to-access-azureml-behind-firewall?tabs=ipaddress). For more information on how traffic flows between components, see [Network traffic flow in a secured workspace](/azure/machine-learning/concept-secure-network-traffic-flow).

## Ensure access to your virtual network

To access your Azure Machine Learning workspace with a private endpoint, use the following steps:

1. Make sure to have access to your virtual network using the VPN connection, ExpressRoute, and a Jumpbox VM with Bastion access. The public user cannot use the Azure Machine Learning workspace with the private endpoint because it can be accessed only from your virtual network. For more information, see [Secure your workspace with virtual networks](/azure/machine-learning/how-to-secure-workspace-vnet#securely-connect-to-your-workspace).

1. Make sure you can resolve the workspace FQDNs with your private IP. If you use your own DNS server or a [centralized DNS infrastructure](/azure/cloud-adoption-framework/ready/azure-best-practices/private-link-and-dns-integration-at-scale#private-link-and-dns-integration-in-hub-and-spoke-network-architectures), you need to configure DNS forwarder. For more information, see [How to use your workspace with a custom DNS server](/azure/machine-learning/how-to-custom-dns).

## Identity and access management

When defining identity and access management controls for Azure Machine Learning, you can distinguish between controls that define access to Azure resources, and controls that manage access to data assets. In this section, we discuss common access management architectures and patterns when using Azure Machine Learning.

### Workspace access management architectures and patterns

Depending on your use case, consider one of the following identity and
access management patterns:

1. Self-service

1. Data-centric

1. Project-centric

In **self-service pattern**, data scientists can create and manage workspaces. This pattern is best suited for proof-of-concept situations that require flexibility to try out different configurations. The disadvantage is that data scientists need the expertise to provision Azure resources, and the approach is less suitable when strict control and auditability of resource use and data access are required.

- Define Azure Policies to set safety guards for resource provisioning and usage, such as allowed cluster sizes and VM types.

- Create a resource group for holding the workspaces, and grant data scientists a contributor role on it.

- Data scientists can then create workspaces and associate resources under the resource group in self-service manner.

- To access data storages, create user-assigned managed identities, and grant them read-access roles on the storage.

    - When data scientists create compute resources, they can assign the managed identities to the computes to gain data access.
    - For best practices, see [Authentication for data management and analytics](/azure/cloud-adoption-framework/scenarios/data-management/secure-authentication).

In **data-centric pattern**, the workspace belongs to single data scientists who may be working on multiple projects. The advantage of this approach is that the data scientist can reuse code or training pipelines across projects. As long as workspace is limited to single user, data access can be traced back to that user when auditing storage logs.

The disadvantage is that data access is not compartmentalized or restricted on per-project basis, as any added user to the workspace will have access to the same assets.

- Create workspace

- Create compute resources with system-assigned managed identities
    enabled.

- When data scientist needs access to the data for given project, grant the compute managed identity read-access role on the data

    - Also grant the workspace's managed identity the read-access role on the data to enable data preview

    - Optionally, create AAD security group and grant it reader access to data, then add managed identities to the security group. This approach reduces the number of direct role assignments on resources, to avoid reaching subscription limit on role assignments

- Grant compute managed identity access to any other resources that may be required, such as ACR with custom Docker images for training.

- Grant data scientist access to the workspace.

- Data scientist can now create data stores to access data required for projects and submit training runs that use the data

In a **project-centric pattern**, an Azure ML workspace is created for specific project, and many data scientists collaborate within the same workspace. The data access is restricted to specific project, making the approach well suited for working with sensitive data. Also, it is straightforward to add or remove data scientists from the project.

The disadvantage of this approach is that sharing assets across projects can be difficult. Also, tracing data access to specific user during audits is difficult.

- Create workspace

- Identify data storage instances required for the project, create a user-assigned managed identity, and grant it read-access role to them

- Create compute resources within the workspace and assign the managed identity to the computes

- Create credential-less data stores for the storages

    - Optionally, grant workspace's managed identity access to data storage to allow data preview. You may omit this step for sensitive data not suitable for preview.

- Grant compute managed identity access to any other resources that may be required, such as ACR with custom Docker images for training.

- Grant data scientist working on the project a role on the workspace

    - By using Azure RBAC roles, you can restrict data scientists from creating new datastores or new computes with different managed identity, thus preventing access to data not specific to project

    - Optionally, to simplify project membership management, you can create an AAD security group for project members and grant the group access to workspace.

### Use Azure Data Lake Store Gen2 with credential pass-through access

Currently, you can use user AAD identity to for interactive storage access from Azure ML Studio. With Azure Data Lake Store (ADLS) Gen 2 with hierarchical namespace enabled, you can compartmentalize data access by giving different users ACL-based access to different folders and files. For example, you can grant access to confidential data to only a subset of users.

Credential pass-through support for ADLS Gen2 storage and blob storage for remote training on Azure Machine Learning computes is planned for late September public preview.

ADLS Gen2 with hierarchical namespace enabled will be supported as default storage for the workspace later this fall, allowing for enhanced organization of data assets on storage and collaboration.

### Use role-based access control and custom roles

- Why create multiple roles?

- Assign role to Azure AD group?

- Azure RBAC for service principals

    - Triggering machine learning pipelines from another solution component like Azure Data Factory.

    - Advised set and scope of Azure RBAC permissions for workspace and compute resources.

- Tailor-make built-in roles to custom roles that work for you

Azure Machine Learning has several default roles: owner, contributor, reader, and data scientist. However, we recommend creating more granular customer roles. For more information, see [Manage access to a workspace](/azure/machine-learning/how-to-assign-roles#example-custom-roles).

### Managing Docker images centrally

Azure Machine Learning provides curated Docker images that you can use for training and deployment purposes. However, your enterprise compliance requirements may mandate the use of images from a private repository that your company manages. With Azure Machine Learning, there are two ways that you can use a central repository:

- Use the images from a central repository as base images. The Azure Machine Learning environment management will install packages and create a Python environment where the training or inferencing code runs. With this approach, you can update package dependencies easily without having to modify the base image.
- Use the images as-is, without using Azure Machine Learning environment management. This approach gives you a higher degree of control, but also requires you to carefully construct the Python environment as part of the image. All the dependencies needed to run the code must be met, and any new dependencies require re-building the image.

For more information, see [Train a model using a custom Docker image](/azure/machine-learning/how-to-train-with-custom-image).

## Encryption at rest

We have two data sources to store your data.

1. Your Storage. It has all your data such as training data, trained model data, except for the metadata. You are responsible for its encryption.

1. Azure Cosmos DB. It has your metadata such as run history information. For example, experiment name, experiment submission date/time, etc. We have two ways to encrypt this information:

    - In a normal workspace, Azure Cosmos DB is in a Microsoft subscription and encrypted by Microsoft Managed Key.

    - If you want to encrypt your metadata by your key, use customer-managed-key workspace. Downside is you need to have an Azure Cosmos DB in your subscription and pay its cost. For more information, see [Data encryption with Azure Machine Learning](/azure/machine-learning/concept-data-encryption#azure-cosmos-db).

## Encryption in transit

For information on how Azure Machine Learning encrypts data in transit, see [Data encryption with Azure Machine Learning](/azure/machine-learning/concept-data-encryption#encryption-in-transit).

## Monitoring

Once Azure Machine Learning resources are deployed, it is important to set up logging and auditing controls for observability. Motivations for observability may be different based on who is looking at the data, and scenarios may include:

- Machine learning practitioners or ops teams looking to **monitor machine learning pipeline health** to understand whether there are issues in scheduled execution, problems with data quality or expected training performance. You can build Azure dashboards using data that is [captured by Azure Machine Learning using Azure Monitor](/azure/machine-learning/monitor-azure-machine-learning) or [create event-driven workflows](/azure/machine-learning/how-to-use-event-grid).

- Capacity managers, machine learning practitioners, or ops teams may be interested in [creating a dashboard](/azure/machine-learning/monitor-azure-machine-learning) to observe compute and quota utilization. When managing a deployment with multiple Azure ML workspaces, consider creating a central dashboard to understand quota utilization. Since quotas are managed on a subscription-level, it is important to have the environment-wide view to drive optimization.

- IT and Ops teams can set up [diagnostic logging](/azure/machine-learning/monitor-azure-machine-learning#collection-and-routing) to audit resource access and altering events within the workspace.

- Consider creating dashboards that monitor overall infrastructure health for Azure Machine Learning, and also for dependent resources such as storage. For example, by combining Azure storage metrics with machine learning pipeline execution failure, you may be able to optimize infrastructure configurations for better performance or increase your ability to root case problems.

Platform metrics and the Activity log are collected and stored automatically but can be routed to other locations by using a diagnostic setting.

- To enable observability across N number of workspace instances, set up diagnostic logging into a centralized log analytics workspace.

- Make use of Azure Policy to automatically set up diagnostic logging to this central log analytics workspace when a new machine learning workspace gets deployed.

## Policy

You can enforce and audit the usage of different security features on workspaces through Azure Policy, including

- Enforce custom-managed key encryption

- Enforce private link and private endpoint

- Enforce private DNS zones

- Disable non-AAD authentication, such as SSH

For more information, see [Built-in policy definitions for Azure Machine Learning](/azure/machine-learning/policy-reference)

Furthermore, you can use custom policy definitions to govern the security of your workspace in a flexible manner

## Compute cluster and instance

### Compute cluster/instance disk encryption

The OS disk for a compute instance or each node in a compute cluster is stored in Azure Storage, and are encrypted with Microsoft-managed keys. Each node also has a local temporary disk. If the workspace was created with the `hbi_workspace = True` parameter, the temporary disk is also encrypted with Microsoft-managed keys. For more information, see [Data encryption with Azure Machine Learning](/azure/machine-learning/concept-data-encryption#encryption-at-rest).

### Compute cluster managed identity

Compute clusters support using managed identities to authenticate to Azure resources. This allows authentication to resources without including credentials in your code. For more information, see [Create an Azure Machine Learning compute cluster](/azure/machine-learning/how-to-create-attach-compute-cluster#managed-identity).

### Compute instance setup script

You can use a setup script to automate customization and configuration of a compute instance when it is created. As an administrator, you can write a customization script that is used when creating all compute instances in a workspace. You can use an Azure Policy to enforce that the setup script is ran for every compute instance during creation. For more information, see [Create and manage an Azure Machine Learning compute instance](/azure/machine-learning/how-to-create-manage-compute-instance#setup-script).

### Compute instance create on behalf of

If you don't want your Data Scientists to create compute resources, you can create a compute instance on their behalf and then assign it to them. For more information, see [Create and manage An Azure Machine Learning compute instance](/azure/machine-learning/how-to-create-manage-compute-instance#on-behalf).

### Compute instance with a private endpoint enabled workspace

When using a compute instance with a private endpoint enabled workspace, the compute instance rejects all public access from outside the VNet. This configuration also prevents packet filtering.

### Azure Policy support

You can use Azure Policy to ensure that every compute cluster/instance is created in a VNet, including specifying the default VNet and subnet. You can also use a policy to disable non-AAD authentication, such as SSH.

## Next steps

Read further about security configurations of Azure Machine Learning:

- [Enterprise security and governance](/azure/machine-learning/concept-enterprise-security)

- [Secure workspace resources using virtual networks](/azure/machine-learning/how-to-network-security-overview)

Read further about architectural considerations to make when deploying Azure Machine Learning:

- [Organize and set up Azure ML workspaces](/azure/cloud-adoption-framework/ready/azure-best-practices/ai-machine-learning-resource-organization) - When you plan a deployment, how does team structure affect the workspace set-up? How do environment or regional constraints affect the workspace set-up?

- [Budget, cost, and quota management for Azure ML at organizational scale](/azure/cloud-adoption-framework/ready/azure-best-practices/optimize-ai-machine-learning-cost) -When you need to manage budget and compute costs across teams and users, what optimizations can be made?

- [Machine learning DevOps (MLOps)](/azure/cloud-adoption-framework/ready/azure-best-practices/ai-machine-learning-mlops) - Machine learning DevOps is an organizational change, which relies on a combination of people, process, and technology. The goal is to deliver machine learning solutions in a more robust, reliable, and automated way. This guide summarizes learnings from adopting machine learning DevOps in the enterprise using Azure Machine Learning.

Get started with an Azure Machine Learning template-based deployment:

- [Azure Quickstart Templates (microsoft.com)](https://azure.microsoft.com/resources/templates/?resourceType=Microsoft.Machinelearningservices)

- [Azure/data-landing-zone](https://github.com/Azure/data-landing-zone)