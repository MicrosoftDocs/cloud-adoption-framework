---
title: Azure Machine Learning as a data product for enterprise-scale for analytics and AI 
description: Learn about Azure Machine Learning as a data product for enterprise-scale for analytics and AI.
author: abdale
ms.author: deeikele
ms.date: 06/21/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Azure Machine Learning implementation

Azure Machine Learning provides an integrated platform for the end-to-end machine learning lifecycle including creation, operation, and consumption of machine learning models and workflows. 

* Machine learning creators can achieve greater productivity via experiment management capabilities, unlocked data access, job tracking, hyperparameter tuning, and workflow automation capabilities.
* Operators are supported to meet governance and compliance requirements through model explainability, reproducibility, auditability, DevOps integration, and a rich security control model.
* Machine learning consumption is made accessible through managed inference capabilities, and rich integration with Azure compute and data services.

Positioning Azure Machine Learning together in the ecosystem of Azure data platform + Azure AI platform services, Azure Machine Learning is used to manage the overall machine learning lifecycle.

While a machine learning practitioner may start their data analysis via Azure Synapse, Azure SQL or Power BI, as soon they start prototyping and experimentation, Azure Machine Learning is added to the mix for machine learning experimentation management and operationalization. In Enterprise-Scale Landing Zones
Azure Machine Learning should be considered a [data product](../architectures/data-landing-zone-data-products.md).

## Azure Machine Learning in Enterprise-scale 

By layering on top of a Cloud Adoption Framework landing zones foundation, the enterprise-scale data landing zones, and Azure Machine Learning’s configuration within, machine learning professionals are set up with a pre-configured environment to repeatedly deploy new machine learning workloads on or migrate existing workloads onto. Greater agility and time-to-value to machine learning professionals, are a direct result.

Specific to Azure Machine Learning’s implementation in enterprise-scale landing zones, the following were guiding design principles:

* **Accelerated data access** by pre-configuring landing zone storage components as datastores in the Azure Machine Learning workspace.  
* **Enabled collaboration** between data engineering, data science and machine learning professionals through the organization of workspaces by project, and centralized access management over landing zone resources.
* **Secure implementation** as default for each deployment, offering network isolation, identity, and access management, following best practices to help safeguard data assets.
* **Self-service** options for machine learning professionals to deploy new project resources when needed enabling greater agility and work organization.
* **Separation of concerns between data management and data consumption** is kept with identity passthrough as the default authentication type between Azure ML and storage. 
* **Faster data integration** with Azure Data Factory, Synapse and Azure Databricks landing zone product pre-configured as linked services to Azure Machine Learning.
* **Observability** through central logging and reference configurations to monitor the environment.

## Implementation overview
>[!NOTE]
>This section aims to describe prescribed configurations which are specific to the Enterprise Scale Analytic and AI construction set. It is a complement to the Azure Machine Learning documentation and Cloud Adoption Framework set of best practices.

**Workspace organization and set up** - For every data landing zone that you deploy, you can choose to deploy zero up to as many machine learning workspaces to meet your workloads’ requirements.

* We recommend deploying at least one machine learning workspace per project. 
* Dependent on your machine learning project’s lifecycle, you may choose to deploy a single 'dev' workspace for early use case prototyping and data exploration, or also deploy a 'staging' and 'production' workspace for work that requires continuous experimentation, testing, and deployment.
* When requiring multiple environments for dev, staging and production workspaces in Enterprise-scale, we recommend each environment to land in the same production data landing zone to avoid the need for data duplication.
* To learn more about the recommended set up and organization of Azure Machine Learning resources, also refer to [Organize and set up Azure Machine Learning environments](/azure/cloud-adoption-framework/ready/azure-best-practices/ai-machine-learning-resource-organization).

Per default resource configuration of the enterprise-scale data landing zone, the Azure Machine Learning service gets deployed in a dedicated resource group with the following configuration and dependent resources:

* Azure Key Vault
* Application Insight
* Storage account, connected to by Azure ML through identity-based authentication enabling user AAD passthrough to storage.
* Container registry.
* Diagnostic logging is set up for each workspace and configured to a central log analytics resource in enterprise-scale. As a result, Azure Machine Learning job health and resources statuses can be analyzed centrally within and across landing zones. 
* To learn more on Azure Machine Learning’s resources and dependencies, also refer to [What is a workspace](/azure/machine-learning/concept-workspace).

**Integration with data landing zone core services** – The enterprise-scale data landing zone comes with a default set of services that are deployed in the [core services layer](/azure/cloud-adoption-framework/scenarios/data-management/architectures/data-landing-zone?branch=scenario-data-management#core-services-layer). When you deploy Azure Machine Learning in enterprise-scale, these core services can be configured at time of deployment.

* You can choose to connect an Azure Synapse Analytics workspace or Azure Databricks workspace as linked service for data integration and big data processing. 
* Data lake services are provisioned by default in the data landing zone. Azure Machine Learning product deployments will by default come with connections (Datastores) pre-configured to these storage accounts. 

![Azure Machine Learning Data Product Analytics](../images/machinelearning-dataproductanalytics-overview.png)

**Network connectivity** for Azure Machine Learning’s implementation in enterprise-scale landing zones is set up in accordance with [security best practices for Azure Machine Learning](/azure/machine-learning/concept-enterprise-security) and [networking best practices](/azure/security/fundamentals/network-best-practices?bc=/azure/cloud-adoption-framework/_bread/toc.json&toc=/azure/cloud-adoption-framework/toc.json) provided in CAF landing zones. In more detail this entails the following configuration: 

* Azure Machine Learning and its dependent resources are configured to use private link endpoints.
* Managed compute resources are deployed only with private IP addresses. 
* Network connectivity to Azure Machine Learning’s public base image repository, and partner-services like Azure Artifacts are configurable at a network level.

**Identity and access management** considerations for Azure Machine Learning are as follows:
•	Datastores in Azure Machine Learning can be configured to use credential-based authentication or identity-based authentication. When you use [Access Control Lists on Azure Data Lake Storage to manage data access](/azure/cloud-adoption-framework/scenarios/data-management/best-practices/data-lake-access?branch=scenario-data-management#configure-access-using-acls-only-recommended-for-enterprise-scale-analytics-and-ai), datastores should be configured to use identity-based authentication so user’s access permissions on storage are leveraged by Azure ML services.  
•	It is recommended using Azure AD groups to manage access permissions on storage and to the machine learning resources.
•	Azure Machine Learning can use [user-assigned managed identities for access control](/azure/machine-learning/how-to-use-managed-identities?tabs=python) to associated resources: Azure Container Registry, Azure Key Vault, Azure Storage, and Azure Application Insights. It is recommended to create a user-assigned managed identity to limit scope of access.
•	It is recommended to assign user-assigned managed identities to managed compute clusters created in Azure Machine Learning.

**Self-service provisioning of infrastructure** can be enabled and governed by using [Azure Policies for Azure Machine Learning](/azure/machine-learning/how-to-integrate-azure-policy). The below table represent a set of policies that are enabled by default in enterprise-scale when you deploy Azure Machine Learning. For more details on policies available for Azure Machine Learning, refer to [Built-in policy definitions for Azure Machine Learning](/azure/machine-learning/policy-reference).

Policy | Type | Reference
------ | ------ | -----
Azure Machine Learning workspaces should use private link | Built-in | [View on Azure Portal](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F40cec1dd-a100-4920-b15b-3024fe8901ab)
Azure Machine Learning workspaces should use user-assigned managed identity | Built-in | [View on Azure Portal](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F5f0c7d88-c7de-45b8-ac49-db49e72eaa78)
[Preview]: Configure allowed registries for specified Azure Machine Learning computes | Built-in | [View on Azure Portal](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F5853517a-63de-11ea-bc55-0242ac130003)
Configure Azure Machine Learning workspaces with private endpoints | Built-in | [View on Azure Portal](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F7838fd83-5cbb-4b5d-888c-bfa240972597)
Configure Machine Learning computes to disable local authentication methods | Built-in | [View on Azure Portal](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2Fa6f9a2d0-cff7-4855-83ad-4cd750666512)  
Append-MachineLearningCompute-SetupScriptsCreationScript | Custom (CAF landing zones) | [View on GitHub](https://github.com/Azure/data-management-zone/blob/main/infra/Policies/PolicyDefinitions/MachineLearning/params.policyDefinition.Audit-MachineLearning-PrivateEndpointId.json)  
Deny-MachineLearning-HbiWorkspace | Custom (CAF landing zones) | [View on GitHub](https://github.com/Azure/data-management-zone/blob/main/infra/Policies/PolicyDefinitions/MachineLearning/params.policyDefinition.Deny-MachineLearning-HbiWorkspace.json)  
Deny-MachineLearning-PublicAccessWhenBehindVnet | Custom (CAF landing zones) | [View on GitHub](https://github.com/Azure/data-management-zone/blob/main/infra/Policies/PolicyDefinitions/MachineLearning/params.policyDefinition.Deny-MachineLearning-PublicAccessWhenBehindVnet.json)  
Deny-MachineLearning-Aks | Custom (CAF landing zones) | [View on GitHub](https://github.com/Azure/data-management-zone/blob/main/infra/Policies/PolicyDefinitions/MachineLearning/params.policyDefinition.Deny-MachineLearningAks.json)  
Deny-MachineLearningCompute-SubnetId | Custom (CAF landing zones) | [View on GitHub](https://github.com/Azure/data-management-zone/blob/main/infra/Policies/PolicyDefinitions/MachineLearning/params.policyDefinition.Deny-MachineLearningCompute-SubnetId.json)  
Deny-MachineLearningCompute-VmSize | Custom (CAF landing zones) | [View on GitHub](https://github.com/Azure/data-management-zone/blob/main/infra/Policies/PolicyDefinitions/MachineLearning/params.policyDefinition.Deny-MachineLearningCompute-VmSize.json)  
Deny-MachineLearningComputeCluster-RemoteLoginPortPublicAccess | Custom (CAF landing zones) | [View on GitHub](https://github.com/Azure/data-management-zone/blob/main/infra/Policies/PolicyDefinitions/MachineLearning/params.policyDefinition.Deny-MachineLearningComputeCluster-RemoteLoginPortPublicAccess.json)  
Deny-MachineLearningComputeCluster-Scale | Custom (CAF landing zones) | [View on GitHub](https://github.com/Azure/data-management-zone/blob/main/infra/Policies/PolicyDefinitions/MachineLearning/params.policyDefinition.Deny-MachineLearningComputeCluster-Scale.json)  

## Environment management recommendations

While Enterprise-scale data landing zones lays out a reference implementation for repeatable deployments, you should set up your environment in a way that is manageable and governable. Considering Azure Machine Learning, the following are recommendations to keep in mind.

* Use Azure AD groups to manage access to machine learning resources.
* Publish a central monitoring dashboard to monitor machine learning pipeline health, compute utilization and quota management.
* When you use built-in Azure policies and cannot find these to capture additional organizational compliance requirements you may have to meet, consider building custom Azure policies to enhance governance and self-service.
* Consider deploying a single machine learning workspace in the landing zone as a shared resource for early use case exploration purposes. In this way, R&D cost may be better tracked.

## Next steps

* Deploy Azure Machine Learning using the [Enterprise-Scale Analytics – Data Product Analytics](https://github.com/Azure/data-product-analytics) template deployment.

## Further reading

Learn about enterprise deployment and management best practices for Azure Machine Learning on the Cloud Adoption Framework documentation pages.

* [Organize and set up Azure ML workspaces](/azure/cloud-adoption-framework/ready/azure-best-practices/ai-machine-learning-resource-organization)
  When planning an Azure Machine Learning deployment, how do team structure, environments or regionality of resources affect the workspace set up? 
* [Budget, cost, and quota management for Azure ML at organizational scale](/azure/cloud-adoption-framework/ready/azure-best-practices/optimize-ai-machine-learning-cost)
  When you manage compute costs incurred from Azure ML, at an organization scale with many workloads, many teams, and users, there are numerous management and optimization challenges to work through. 
* [Machine learning DevOps (MLOps)](/azure/cloud-adoption-framework/ready/azure-best-practices/ai-machine-learning-mlops)
  Machine learning DevOps is an organizational change that relies on a combination of people, process, and technology to deliver machine learning solutions in a robust, scalable, reliable, and automated way. This guide summarizes best practices and learnings from adopting machine learning DevOps in the enterprise with Azure ML.

Get started to build your solutions on Azure Machine Learning using the [Azure Machine Learning documentation](/azure/machine-learning/) and tutorials.
