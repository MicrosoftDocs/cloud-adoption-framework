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

# Contents

This article describes how to deploy Landing Zones under the respective Management Group scope. This is the last of the three steps to setup your environment. Please complete first [Step 1](./Configure-run-initialization.md) and [Step 2](./Deploy-lz.md) before you continue.

![Deploy your own environment process - step 3](./media/deploy-environment-step-3.png)

# Create Landing Zones

In a North Star implementation, all platform resources in the __Connectivity__ and __Management__ Subscriptions are deployed via Azure Policy. North Star includes both, policy definitions and assignments required to deploy the neccesary resources. While it is possible to deploy both, Azure Policy definition and assignments using North Star deployment process via GitHub Actions as described in this article, North Star provides flexiblity for how the assignments can be done in the platform subscriptions.

All platform Azure resources in a Landing Zones following the North Star guidance are fully controlled and provisioned through Azure Policy on the Landing Zone Management Group scope. More information on the [Policy Driven Approach](./../Design-Principles.md) can be found in the North Star design principals section of this document.

Before continuing, please ensure that you have completed all prerequisites in the previous sections. Specially the below steps:

1. Ensure the default management structure exist as described in the the [configure GitHub and run initialization](./Configure-run-initialization.md) section.
2. Ensure you have [initialized AzOps repository](Configure-run-initialization.md) and pushed changes are in your **master** branch.
3. All the platform infrastructure has been deployed following [these instructions](./Deploy-platform-infra.md).

---

## Create a Landing Zone

It is now time to turn the lights ON, there is only one step required!

1. Create or move a Subscription under the Landing Zone Management Group.  
   Once all the required definitions (roles, policies and policySet) and the assignment (roles and policies) are deployed, subscriptions can be created or moved to the Landing Zones managment group or any other scope below.

> Important: Existing Subscription and Azure resource in it, will be moved into a compliant state when moved under the Landing Zone scope.
