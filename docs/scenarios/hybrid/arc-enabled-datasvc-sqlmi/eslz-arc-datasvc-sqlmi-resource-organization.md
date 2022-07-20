# Resource organization for Azure Arc-enabled Data Services SQL Managed Instance

Resource organization decisions are a foundation for all compliance-related design areas and involves preparing your environment and setting up your resources so you can efficiently secure, manage, and track costs related to your workloads

The Cloud Adoption Framework [Ready methodology](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/) provides resource organization guidance you can review before deploying and implementing your workloads. This strategy should include your hybrid and multicloud resources and add business and operational details as components of inventory management and metadata tags.

It is important to know how to use consistent resource grouping, defined naming standards, relevant tagging, and fine-grained access control to optimize your resource organization when using Azure Arc-enabled Data Services SQL Managed Instance.

## Resource consistency and organization

It's important to define a structure on how resources will be projected to Azure management scopes  (management groups, subscriptions, and resource groups) and this should be done before onboarding any Azure Arc-enabled SQL Managed Instance onto Azure Arc. Review the Cloud Adoption Framework recommendations on how to [organize resources](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-setup-guide/organize-resources?tabs=AzureManagementGroupsAndHierarchy). 

Also you can review the [resource organization design](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org) area of the Azure landing zones to assess the impact of Azure Arc-enabled SQL Managed Instance on your overall resource organization model.

This mapping is the key to determine how you can interact with these resources whe applying [role-based access control (RBAC)](https://docs.microsoft.com/en-us/azure/active-directory/roles/best-practices) and assigning [Azure Policy](https://docs.microsoft.com/en-us/azure/governance/policy/overview) as part of your governance model.

When designing this structure, keep in mind the [Azure Resource Manager service limits](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/azure-subscription-service-limits) as they apply to Azure Arc-enabled SQL Managed Instance. While designing your structure, it's important to plan and determine how many clusters should connect to a specific [resource group](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/azure-subscription-service-limits#resource-group-limits) or [subscription](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/azure-subscription-service-limits#subscription-limits).