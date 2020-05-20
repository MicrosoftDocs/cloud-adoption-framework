# Navigation Menu

* [Overview](../../README.md)
* [North Star Architecture](../NorthStar-Architecture.md)
  * [Design Principles](../Design-Principles.md)
  * [Design Guidelines](../Design-Guidelines.md)
    * [A - Enterprise Enrollment and Azure AD Tenants](../A-Enterprise-Enrollment-and-Azure-AD-Tenants.md)
    * [B - Identity and Access Management](../B-Identity-and-Access-Management.md)
    * [C - Management Group and Subscription Organization](../C-Management-Group-and-Subscription-Organization.md)
    * [D - Network Topology and Connectivity](../D-Network-Topology-and-Connectivity.md)
    * [E - Management and Monitoring](../E-Management-and-Monitoring.md)
    * [F - Business Continuity and Disaster Recovery](../F-Business-Continuity-and-Disaster-Recovery.md)
    * [G - Security, Governance and Compliance](../G-Security-Governance-and-Compliance.md)
    * [H - Platform Automation and DevOps](../H-Platform-Automation-and-DevOps.md)
  * [Implementation Guide](../Implementation-Guide.md)
* [Contoso Reference](../Contoso/Readme.md)
  * [Scope and Design](../Contoso/Scope.md)
  * [Implementation](../Contoso/Design.md)    
* [Using reference implementation in your own environment](./Readme.md)
  * [Getting started](./Getting-Started.md)
    * [Prerequisites](./Prerequisites.md)
    * [Validate prerequisites](./Validate-prereqs.md)
  * [Configure your own environment](./Using-Reference-Implementation.md)
    * [Configure GitHub](./Configure-run-initialization.md)
    * [Provision Platform](./Deploy-platform-infra.md)
    * [Create Landing Zones](./Deploy-lz.md)
    * [Trigger deployments locally](./Trigger-local-deployment.md)
  * [North Star template schema](./NorthStar-schema.md)
    * [Generic North Star ARM template](./NorthStar-template-schema.md)
    * [North Star ARM parameters file](./NorthStar-parameters-schema.md)
  * [Known Issues](./Known-Issues.md)
* [How Do I Contribute?](../Northstar-Contribution.md)
* [FAQ](../Northstar-FAQ.md)
* [Roadmap](../Northstar-roadmap.md)

---

## Contoso Reference Implementation - Known Issues

The list below summarizes the known issues with Contoso reference implementation, when building and operationalizing their Azure platform using first-party platform and product capabilities.

### Subscription Creation

Area: Microsoft.Subscription Resource Provider

Issue: At present, it is not possible to provision new Subscription via ARM templates. Subscription creation requires an Enterprise Enrollment account to be migrated to a new billing account API in the backend.

Status: We are working closely with engineering teams to enable this functionality for the Contoso Tenant. As a workaround, subscriptions are created using GitHub Actions, having a Service Principal to call the POST API

### Unable to tag subscriptions using Azure Policy

Area: Azure Policy

Issue: Currently, a subscription cannot be tagged by Azure Policy, which makes it hard to navigate through subscriptions in policy evaluations to target the correct subscription(s).

Status: For Contoso to deterministically target the platform subscriptions with their specific policies, their workaround is to have a dedicated management group for each subscription, child to the platform management group

### Unable to use policy aliases on Microsoft.Resources/subscriptions

Area: Microsoft.Subscription Resource Provider

Issue: Currently, the display name of a subscription cannot be used in the policy rule, which makes it hard to navigate through subscriptions in policy evaluations to target the correct subscription(s).

Status: For Contoso to deterministically target the platform subscriptions with their specific policies, their workaround is to have a dedicated management group for each subscription, child to the platform management group

### Move subscription to management group

Area: Microsoft.Management Resource Provider

Issue: When doing put on Microsoft.Management/managementGroups/subscriptions, the PUT and GET response is 204 (no content), so the overall template deployment fails.	Fix was deployed to resolve PUT request. Waiting for the fix to resolve GET request.

Status: No fix as of yet.

### Reference() resources at management group scope when deploying ARM templates to subscription scope

Area: Azure Resource Manager template deployments

Issue: When deploying a subscription template and using template reference() function to reference a resource (policyDefinitions/policyAssignments) from management group, the function append the subscriptionId to the referenced resource, which will cause the deployment to fail.

Status: No fix as of yet, and for workaround the particular policyAssignments must sit directly on the subscription for the template deployment to succeed.

### Management group scoped deployments can deploy to tenant root scope

Area: Azure Resource Manager template deployments

Issue: When doing nested deployment from management group scope without having the “scope” property specified on "Microsoft.Resources/deployments", ARM defaults to tenant root and does a tenant scope deployment.

Status: No fix as of yet.

### Reference() function not respecting dependency graph [dependsOn]

Area: Azure Resource Manager template deployments

Issue: When doing nested deployments from tenant scope (e.g., policyAssignment and subsequent roleAssignment for the managed identity), the reference() function fails saying the policyAssignment cannot be found, even though it exists. A re-deployment works fine.

Status: No fix as of yet.

### Reference() function runs even though the resource condition is false

Area: Azure Resource Manager template deployments

Issue: When using “conditions” on resources, and it evaluates to false, the reference() function within the resource properties is still executed which causes the deployment to fail.

Status: No fix as of yet. Workaround is to do N number of additional if() functions to logically navigate (e.g., if reference resource doesn’t exist, throw json(‘null’).)

### Unsupported number of tenants in context: x TenantID(s)

Issue: We currently do not support Initialization across multiple tenants. <br>Clear your AzContext and run `Connect-AzAccount` with the service principal that was created earlier.

Status: No fix as of yet.

### Subscriptions or Management Group with duplicated names

Issue: The discovery process discussed on [this](./Configure-run-initialization.md) article will fail if there are subscriptions or Management Groups with duplicated names. 

Status: Workaround is to ensure subscription names and management groups are unique in your tenant regradless of the hierarchy prior to running the discovery process.
