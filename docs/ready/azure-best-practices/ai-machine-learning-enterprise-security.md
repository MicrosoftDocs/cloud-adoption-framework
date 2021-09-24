---
title: Machine learning enterprise security
description: This article provides best practices when planning or managing a secure Azure Machine Learning deployment.
author: jhirono
ms.author: jhirono
ms.date: 09/28/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Azure Machine Learning best practices for enterprise security

This article explains security best practices for planning or managing a secure Azure Machine Learning deployment. The best practices come from Microsoft and customer experience with Azure Machine Learning. Each guideline explains the practice and its rationale. The article also provides links to how-to and reference documentation.

## Recommended network security architecture

The recommended Machine Learning network security architecture is a virtual network with the following subnets:

- **Training** contains compute resources used for training, such as Machine Learning compute instances or compute clusters.
- **Scoring** contains compute resources used for scoring, such as Azure Kubernetes Service (AKS).
- **Firewall** contains the firewall that allows traffic to and from the public internet, such as Azure Firewall.

:::image type="content" source="./media/azure-ml-recommended-secure-network-architecture.png" alt-text="A diagram of the recommended secure architecture." border="false":::

The virtual network also contains a *private endpoint* for your Machine Learning workspace, and the following dependent services:

- Azure Storage account
- Azure Key Vault
- Azure Container Registry

*Outbound* communication from the virtual network must be able to reach the following Microsoft services:

- Machine Learning
- Azure Active Directory (Azure AD)
- Container Registry, and specific registries that Microsoft maintains
- Azure Front Door
- Azure Resource Manager
- Azure Storage

Remote clients connect to the virtual network by using either Azure ExpressRoute or a virtual private network (VPN) connection.

## Virtual network and private endpoint design

When designing virtual networks, subnets, and private endpoints, consider the following requirements:

- In general, create separate subnets for Training and Scoring, and use the Training subnet for all private endpoints.

- IP addressing: Compute instances need one private IP each. Compute clusters need one private IP per node. AKS clusters need many private IP addresses, which are described in [Plan IP addressing for your AKS cluster](/azure/aks/configure-azure-cni#plan-ip-addressing-for-your-cluster). A separate subnet for at least AKS helps prevent IP address exhaustion.

- The compute resources in the Training and Scoring subnets need to access the Storage account, Key Vault, and Container Registry. Create private endpoints for the Storage account, Key Vault, and Container Registry.

- Machine Learning workspace default storage needs two private endpoints, one for Azure Blob storage and another for Azure File storage.

- If you use Azure Machine Learning studio, the workspace and storage private endpoints should be in the same subnet.

- If you have multiple workspaces, use a virtual network for each workspace to create an explicit network boundary between workspaces.

### Use private IP addresses

Private IP addresses minimize your Azure resources' exposure to the internet. Machine Learning uses many Azure resources, and the Machine Learning workspace private endpoint isn't enough for end-to-end private IP. The following table shows the major resources Machine Learning uses, and how to enable private IP for the resources. Compute instances and compute clusters are the only resources that don't have the private IP feature.

| Resources | Private IP solution | Documentation |
| ----- | ----- | ----- |
| Workspace | Private endpoint | [Configure a private endpoint for an Azure Machine Learning workspace](/azure/machine-learning/how-to-configure-private-link?tabs=python)
| **Associated resources** |
| Storage | Private endpoint | [Secure Azure Storage accounts with service endpoints](/azure/machine-learning/how-to-secure-workspace-vnet#secure-azure-storage-accounts-with-service-endpoints) |
| KeyVault | Private endpoint | [Secure Azure Key Vault](/azure/machine-learning/how-to-secure-workspace-vnet#secure-azure-key-vault) |
| Container Registry | Private endpoint | [Enable Azure Container Registry](/azure/machine-learning/how-to-secure-workspace-vnet#enable-azure-container-registry-acr) |
| **Training resources** |
| Compute instance | Behind virtual network with public IP | [Secure training environments](/azure/machine-learning/how-to-secure-training-vnet?tabs=azure-studio#compute-instance) |
| Compute cluster | Behind virtual network with public IP | [Secure training environments](/azure/machine-learning/how-to-secure-training-vnet?tabs=azure-studio%2Cipaddress#compute-cluster) |
| **More hosting resources** |
| Kubernetes cluster | Private endpoint | [Secure inferencing environments](/azure/machine-learning/how-to-secure-inferencing-vnet?tabs=python#secure-vnet-traffic) |
| Machine Learning Load Balancer on AKS | Private load balancer | [Secure inferencing environments](/azure/machine-learning/how-to-secure-inferencing-vnet?tabs=python#secure-vnet-traffic) |
| Azure Container Instance | Private endpoint | **Note:** You can't use a private endpoint with Container Instance if the Container Registry also uses a private endpoint.|

### Control virtual network inbound and outbound traffic

Use a firewall or Azure network security group (NSG) to control virtual network inbound and outbound traffic. For more information on inbound and outbound requirements, see [Configure inbound and outbound network traffic](/azure/machine-learning/how-to-access-azureml-behind-firewall?tabs=ipaddress). For more information on how traffic flows between components, see [Network traffic flow in a secured workspace](/azure/machine-learning/concept-secure-network-traffic-flow).

### Ensure access to your workspace

To ensure that your private endpoint can access your Machine Learning workspace, take the following steps:

1. Make sure you have access to your virtual network using a VPN connection, ExpressRoute, or Jumpbox virtual machine (VM) with Azure Bastion access. The public user can't access the Machine Learning workspace with the private endpoint, because it can be accessed only from your virtual network. For more information, see [Secure your workspace with virtual networks](/azure/machine-learning/how-to-secure-workspace-vnet#securely-connect-to-your-workspace).

1. Make sure you can resolve the workspace fully qualified domain names (FQDNs) with your private IP address. If you use your own domain name system (DNS) server or a [centralized DNS infrastructure](/azure/cloud-adoption-framework/ready/azure-best-practices/private-link-and-dns-integration-at-scale#private-link-and-dns-integration-in-hub-and-spoke-network-architectures), you need to configure a DNS forwarder. For more information, see [How to use your workspace with a custom DNS server](/azure/machine-learning/how-to-custom-dns).

## Workspace access management

When defining Machine Learning identity and access management controls, you can separate controls that define access to Azure resources from controls that manage access to data assets. Depending on your use case, consider whether to use *self-service*, *data-centric*, or *project-centric* identity and access management.

### Self-service pattern

In a self-service pattern, data scientists can create and manage workspaces. This pattern is best suited for proof-of-concept situations that require flexibility to try out different configurations. The disadvantage is that data scientists need the expertise to provision Azure resources. This approach is less suitable when strict control and auditability of resource use and data access are required.

1. Define Azure Policies to set safeguards for resource provisioning and usage, such as allowed cluster sizes and VM types.

1. Create a resource group for holding the workspaces, and grant data scientists a Contributor role in the resource group.

1. Data scientists can now create workspaces and associate resources in the resource group in a self-service manner.

1. To access data storage, create user-assigned managed identities, and grant the identities read-access roles on the storage.

1. When data scientists create compute resources, they can assign the managed identities to the compute instances to gain data access.

For best practices, see [Authentication for data management and analytics](/azure/cloud-adoption-framework/scenarios/data-management/secure-authentication).

### Data-centric pattern

In a data-centric pattern, the workspace belongs to a single data scientist, who might be working on multiple projects. The advantage of this approach is that the data scientist can reuse code or training pipelines across projects. As long as the workspace is limited to a single user, data access can be traced back to that user when auditing storage logs.

The disadvantage is that data access isn't compartmentalized or restricted on per-project basis, and any user added to the workspace can access the same assets.

1. Create the workspace.

1. Create compute resources with system-assigned managed identities enabled.
1. When a data scientist needs access to the data for a given project, grant the compute managed identity read access to the data.

1. Grant the compute managed identity access to any other required resources, such as a Container Registry with custom Docker images for training.

1. Also grant the workspace's managed identity read-access role on the data, to enable data preview.

1. Grant the data scientist access to the workspace.

1. The data scientist can now create data stores to access data required for projects, and submit training runs that use the data.

Optionally, create an Azure AD security group and grant it read access to data, then add managed identities to the security group. This approach reduces the number of direct role assignments on resources, to avoid reaching the subscription limit on role assignments.

### Project-centric pattern

A project-centric pattern creates a Machine Learning workspace for a specific project, and many data scientists collaborate within the same workspace. Data access is restricted to the specific project, making the approach well suited for working with sensitive data. Also, it's straightforward to add or remove data scientists from the project.

The disadvantage of this approach is that sharing assets across projects can be difficult. It's also hard to trace data access to specific users during audits.

1. Create the workspace

1. Identify data storage instances required for the project, create a user-assigned managed identity, and grant the identity read access to the storage.
   
   Optionally, grant the workspace's managed identity access to data storage to allow data preview. You can omit this access for sensitive data not suitable for preview.

1. Create credential-less data stores for the storage resources.

1. Create compute resources within the workspace, and assign the managed identity to the compute resources. 

1. Grant the compute managed identity access to any other required resources, such as a Container Registry with custom Docker images for training.

1. Grant data scientists working on the project a role on the workspace.

   By using Azure role-based access control (RBAC), you can restrict data scientists from creating new datastores or new compute resources with different managed identities. This practice prevents access to data not specific to the project.
   
   Optionally, to simplify project membership management, you can create an Azure AD security group for project members and grant the group access to the workspace.

### Azure Data Lake Storage with credential passthrough

You can use Azure AD user identity for interactive storage access from Machine Learning studio. Data Lake Storage with hierarchical namespace enabled allows for enhanced organization of data assets for storage and collaboration. With Data Lake Storage hierarchical namespace, you can compartmentalize data access by giving different users access control list (ACL)-based access to different folders and files. For example, you can grant only a subset of users access to confidential data.

The following features are planned for future Machine Learning releases:

- Credential passthrough support for Data Lake Storage and Blob storage for remote training on Machine Learning computes.
- Data Lake Storage with hierarchical namespace enabled as default storage for Machine Learning workspaces.

### RBAC and custom roles

Azure RBAC helps you manage who has access to Machine Learning resources, and configure who can perform operations. For example, you might want to grant only specific users the Workspace Administrator role to manage compute resources.

Access scope can differ between environments. In a production environment, you might want to limit the ability of users to update inference endpoints. Instead, you might grant that permission to an authorized service principal.

Machine Learning has several default roles: Owner, Contributor, Reader, and Data Scientist. You can also create your own custom roles, for example to create permissions that reflect your organizational structure. For more information, see [Manage access to Azure Machine Learning workspace](/azure/machine-learning/how-to-assign-roles#example-custom-roles).

Over time, the composition of your team might change. If you create an Azure AD group for each team role and workspace, you can assign an Azure RBAC role to the Azure AD group, and manage resource access and user groups separately.

User principals and service principals can be part of the same Azure AD group. For example, when you create a user-assigned managed identity that Azure Data Factory uses to trigger a Machine Learning pipeline, you might include the managed identity in a **ML pipelines executor** Azure AD group.

## Central Docker image management

Azure Machine Learning provides curated Docker images that you can use for training and deployment. However, your enterprise compliance requirements might mandate the use of images from a private repository that your company manages. Machine Learning has two ways to use a central repository:

- Use the images from a central repository as base images. The Machine Learning environment management installs packages and creates a Python environment where the training or inferencing code runs. With this approach, you can update package dependencies easily without having to modify the base image.

- Use the images as-is, without using Machine Learning environment management. This approach gives you a higher degree of control, but also requires you to carefully construct the Python environment as part of the image. You need to meet all the dependencies needed to run the code, and any new dependencies require rebuilding the image.

For more information, see [Train a model using a custom Docker image](/azure/machine-learning/how-to-train-with-custom-image).

## Data encryption

Machine Learning data at rest has two data sources:

- Your storage has all your data, such as training data and trained model data, except for the metadata. You're responsible for your storage encryption.

- Azure Cosmos DB contains your metadata, including run history information like experiment name and experiment submission date and time. In most workspaces, Azure Cosmos DB is in the Microsoft subscription and encrypted by a Microsoft-managed key.
  
  If you want to encrypt your metadata by using your own key, you can use a customer-managed key workspace. The downside is that you need to have Azure Cosmos DB in your subscription and pay its cost. For more information, see [Data encryption with Azure Machine Learning](/azure/machine-learning/concept-data-encryption#azure-cosmos-db).

For information on how Azure Machine Learning encrypts data in transit, see [Encryption in transit](/azure/machine-learning/concept-data-encryption#encryption-in-transit).

## Monitoring

When you deploy Machine Learning resources, set up logging and auditing controls for observability. Motivations for observing data might vary based on who looks at the data. Scenarios include:

- Machine learning practitioners or operations teams want to **monitor machine learning pipeline health**. These observers need to understand issues in scheduled execution, or problems with data quality or expected training performance. You can build Azure dashboards that [monitor Azure Machine Learning data](/azure/machine-learning/monitor-azure-machine-learning), or [create event-driven workflows](/azure/machine-learning/how-to-use-event-grid).

- Capacity managers, machine learning practitioners, or operations teams might want to [create a dashboard](/azure/machine-learning/monitor-azure-machine-learning) to **observe compute and quota utilization**. To manage a deployment with multiple Azure ML workspaces, consider creating a central dashboard to understand quota utilization. Quotas are managed on a subscription level, so the environment-wide view is important to drive optimization.

- IT and operations teams can set up [diagnostic logging](/azure/machine-learning/monitor-azure-machine-learning#collection-and-routing) to **audit resource access and altering events** in the workspace.

- Consider creating dashboards that **monitor overall infrastructure health** for Machine Learning and dependent resources such as storage. For example, combining Azure storage metrics with pipeline execution data can help you optimize infrastructure for better performance, or discover problem root causes.

Azure collects and stores platform metrics and activity logs automatically. You can route the data to other locations by using a diagnostic setting. For observability across several workspace instances, set up diagnostic logging into a centralized Log Analytics workspace. Use Azure Policy to automatically set up logging for new Machine Learning workspaces into this central Log Analytics workspace.

## Azure Policy

You can enforce and audit the usage of security features on workspaces through Azure Policy. Recommendations include:

- Enforce custom-managed key encryption.
- Enforce Azure Private Link and Private Endpoint.
- Enforce private DNS zones.
- Disable non-Azure AD authentication, such as secure shell (SSH).

For more information, see [Built-in policy definitions for Azure Machine Learning](/azure/machine-learning/policy-reference).

You can also use custom policy definitions to govern workspace security in a flexible manner.

## Compute clusters and instances

The following considerations and recommendations apply to Machine Learning compute clusters and instances.

### Disk encryption

The operating system (OS) disk for a compute instance or compute cluster node is stored in Azure Storage, and encrypted with Microsoft-managed keys. Each node also has a local temporary disk. If the workspace was created with the `hbi_workspace = True` parameter, the temporary disk is also encrypted with Microsoft-managed keys. For more information, see [Data encryption with Azure Machine Learning](/azure/machine-learning/concept-data-encryption#encryption-at-rest).

### Managed identity

Compute clusters support using managed identities to authenticate to Azure resources. Using a managed identity for the cluster allows authentication to resources without exposing credentials in your code. For more information, see [Create an Azure Machine Learning compute cluster](/azure/machine-learning/how-to-create-attach-compute-cluster#managed-identity).

### Setup script

You can use a setup script to automate customization and configuration of compute instances at creation. As an administrator, you can write a customization script to use when creating all compute instances in a workspace. You can use Azure Policy to enforce use of the setup script to create every compute instance. For more information, see [Create and manage an Azure Machine Learning compute instance](/azure/machine-learning/how-to-create-manage-compute-instance#setup-script).

### Create on behalf of

If you don't want data scientists to provision compute resources, you can create compute instances on their behalf, and then assign the instances to the data scientists. For more information, see [Create and manage an Azure Machine Learning compute instance](/azure/machine-learning/how-to-create-manage-compute-instance#on-behalf).

### Private endpoint-enabled workspace

Use compute instances with a private endpoint-enabled workspace. The compute instance rejects all public access from outside the virtual network. This configuration also prevents packet filtering.

### Azure Policy support

You can use Azure Policy to ensure that every compute cluster or instance is created in a virtual network, and specify the default virtual network and subnet. You can also use a policy to disable non-Azure AD authentication, such as SSH.

## Next steps

Read more about Machine Learning security configurations:

- [Enterprise security and governance](/azure/machine-learning/concept-enterprise-security)
- [Secure workspace resources using virtual networks](/azure/machine-learning/how-to-network-security-overview)

Read more about architectural considerations for deploying Machine Learning:

- How team structure, environment, or regional constraints affect workspace setup: [Organize and set up Azure ML workspaces](/azure/cloud-adoption-framework/ready/azure-best-practices/ai-machine-learning-resource-organization)
- Optimizations to manage compute costs and budget across teams and users: [Budget, cost, and quota management for Azure ML at organizational scale](/azure/cloud-adoption-framework/ready/azure-best-practices/optimize-ai-machine-learning-cost) 

Read the [Machine learning DevOps guide](/azure/cloud-adoption-framework/ready/azure-best-practices/ai-machine-learning-mlops) to learn about machine learning DevOps (MLOps). MLOps is an organizational change that relies on a combination of people, process, and technology. The goal of MLOps is to deliver machine learning solutions in a more robust, reliable, and automated way. The guide summarizes learning from organizations that adopted MLOps for enterprise-scale Machine Learning deployments.

Get started with a Machine Learning template-based deployment:

- [Azure Quickstart Templates (microsoft.com)](https://azure.microsoft.com/resources/templates/?resourceType=Microsoft.Machinelearningservices)
- [Enterprise-Scale Analytics and AI - Data Landing Zone](https://github.com/Azure/data-landing-zone)