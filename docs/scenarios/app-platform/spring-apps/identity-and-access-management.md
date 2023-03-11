---
title: Identity considerations for the Azure Spring Apps landing zone accelerator
description: Identity considerations and recommendations for a Spring Boot workload.
author: pagewriter-msft
ms.author: prwilk
ms.date: 03/01/2023
ms.topic: conceptual
ms.service: caf
ms.subservice: caf-scenario-spring-apps
---

# Identity considerations for the Azure Spring Apps landing zone accelerator

This article provides design considerations and recommendations for authenticating users and granting level of access to workload resources for those who need them. 

The centralized platform team and the application teams must have a good understanding of:

- Which teams require access to the Azure Spring App workload deployed in the application landing zone?
- What are the roles and responsibility of users who need access?
- What is the minimum level of privilege needed to carry out those responsibilities?

> For information about the platform design, see [Platform design: Identity and access management](/azure/cloud-adoption-framework/ready/landing-zone/design-area/identity-access).

As the workload owner, follow these best practices to make sure that the application resources don't violate organizational security or governance boundaries. The goal is make sure that the deployed app and related resources of the workload are secure and can be accessed only by authorized users. Doing so can help you protect sensitive data and prevent misuse of the app and its resources.

## Design considerations

- **Access from the application to other services**. The application should authenticate itself when connecting to backend services that are part of the workload. This will protect the services from unauthorized access. Consider features of Azure Active Directory (Azure AD) to prevent the overhead of storing and managing credentials. 

- **Access to the application**. Users might send requests to the application over the public internet. Or requests might come from private or on-premises networks. In either case, access must be authenticated based on client certificates or through Active Directory (Azure AD). 

	Consider the technology options for the service discovery mechanism that will involke calls between apps. The options vary by Azure Spring Apps tiers. 

    - Basic/Standard: [Kubernetes Service Discovery or  Managed Spring Cloud Service Registry (using Eureka)](/azure/spring-apps/how-to-service-registration?pivots=programming-language-java)
    - (Enterprise) [Tanzu Service Registry](/azure/spring-apps/how-to-enterprise-service-registry) . 

	
- **Operator access to resources**. Your workload maybe accessed by various team members with different responsibilities. For example, you might need to grant access to: 

	- The platform team members who need operational access.
	- The application team memmbers who will develop applications.
	- DevOps engineer who will need access to the build and release pipelines to deploy the workload and configure using Infrastructure-as-Code (IaC).
	- Site reliability engineer for troubleshooting issues.

	Based on the purpose of access, decide the level of control you want to provide to the user. Always start with the principle of least privilege. RBAC Role assignments can make sure that users have right set of privileges for their responsibilities and maintain boundaries. Consider built-in RBAC roles before creating custom roles. 

	TBD: On Enterprise Tier, decide whether to setup Sigle sign on using AD for Spring cloud Gateway and API portal

- **Configuration data access**. Based on your choice of tier for Azure Spring Apps (**Basic** or **Enterprise**), you'll need to decide configuration server options. For **Basic**, consider support for server and client side for an externalized configuration in a distributed system like Azure DevOps, GitHub, GitLab, and Bitbucket for storing your Config Server files. 

	You'll need to make a choice between using public or private repositories and their authentication mechanism. Azure Spring Apps supports basic password/token-based authentication and SSH.
		
	For **Enterprise**, Application Configuration Service for VMware Tanzu enables the management of Kubernetes-native ConfigMap resources that are populated from properties defined in one or more Git repositories with explicit configuration to config-file-pattern. -- What's the guidance here.


## Design recommendations

##### Managed identities

Use managed identities for the application so that it's authenticated through Azure AD. Not all services supported this feature of Azure AD. For information, see [Azure services that support Azure AD authentication](/azure/active-directory/managed-identities-azure-resources/services-azure-active-directory-support).


Of the [types of managed identifies](/azure/active-directory/managed-identities-azure-resources/overview#managed-identity-types), decide which type is appropriate per use case. Consider the tradeoffs with ease of management. For example, if the application needs to access multiple resources, user-assigned managed identities are recommended. However, if you want permissions to be tied to the application lifecycle, system-managed identities might be better suited. 

For more information, see [Choose system or user-assigned managed identities](/azure/active-directory/managed-identities-azure-resources/managed-identity-best-practice-recommendations#choosing-system-or-user-assigned-managed-identities).

Use built-in Azure RBAC roles to simplify the management of required permissions for managed identity.

- Azure Spring Apps Identities
	- Use your own managed identity for Azure Spring Apps
	- Use system-assigned and user-assigned managed identities separately. For more information, see [Best practices when using managed identities](/azure/spring-apps/how-to-use-managed-identities?pivots=sc-standard-tier#best-practices-when-using-managed-identities). 
	- Use Privileged Identity Management in Azure AD.

##### Secure internet communication

- Use certificates issued by a certificate authority, extended validation certificates or wildcard certificates
- Use self-signed certificated only for non-prod environments
- Securely load certificates from Azure Key Vault

##### Role-based access control (RBAC)

- Consider creating custom roles, following the principle of least privilege when out-of-box roles require modifications to existing permissions. 
- Choose enhanced-security storage for keys, secrets, certificates, and application configuration.
- For automated deployment, set up a service principal that has the minimum required permissions to deploy from the CI/CD pipeline.
- Enable diagnostic logging for Application Console, System Logs, Ingress Logs, Build Logs and Container Event Logs. You can use these detailed logs to diagnose problems with your app and monitor access requests. Enabling these logs also provides an Azure Monitor activity log that gives you insight into subscription-level events.

## Next step

Review the critical design areas to make complete considerations and recommendations for your architecture. 

> [!div class="nextstepaction"] 
> [Network topology and connectivity](./network-topology-and-connectivity.md)