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

As the workload owner, follow these best practices to make sure that the application resources don't violate organizational security or governance boundaries. The goal  is to help ensure that the deployed app and its associated resources are secure and can be accessed only by authorized users. Doing so can help you protect sensitive data and prevent misuse of the app and its resources.

## Design considerations

- **Access from the application to other services**. The application should authenticate itself when connecting to backend services that are part of the workload. This will protect the services from unauthorized access. Consider features of Azure Active Directory (Azure AD) to prevent the overhead of storing and managing credentials. 

- **Access to the application**. Access must be authenticated based on client certificates or via Azure Active Directory (Azure AD). 

- **Role-based access control (RBAC)** 

- Configuration data access



- Authorization

- Data plane

- Control plane


- Decide how to authenticate access: based on client certificates or via Azure Active Directory (Azure AD).
- Decide on the configuration server options
	- If on Basic Tier, decide server and client-side support for an externalized configuration in a distributed system like Azure DevOps, GitHub, GitLab, and Bitbucket for storing your Config Server files. 
	- Decide whether to use public repository or private repositories and their authentication mechanism. Azure Spring Apps supports basic password/token-based authentication and SSH.
	- If on enterprise tier, Application Configuration Service for VMware Tanzu enables the management of Kubernetes-native ConfigMap resources that are populated from properties defined in one or more Git repositories with explicit configuration to config-file-pattern
- Decide the service discovery mechanism, Kubernetes Service Discovery approach to invoke calls among apps or using Managed Spring Cloud Service Registry (OSS). 
- Define how to access the Spring Cloud Service Registry using Azure Active Directory (Azure AD) role-based access control (RBAC)
- Determine the roles and permissions using built-in Azure RBAC roles for ASA or using custom roles.
	- Decide what permissions are needed for the landing zone owner
	- Decide what permissions the application teams will need to develop applications or use custom developer role
	- Decide  permissions to deploy applications to ASA or use custom DevOps Engineer role or by using "
	- Azure Pipelines / Jenkins / GitHub Actions role" to configure everything in ASA using IaC
	- Decide  permissions for SRE activities or use custom Ops - Site Reliability Engineering role
- Decide the secure communication model from client to application with TLS/SSL
- On Enterprise Tier, decide whether to setup Sigle sign on using AD for Spring cloud Gateway and API portal



## Design recommendations

##### Managed identities

Use managed identities for the application so that it's authenticated through Azure AD. Of the [types of managed identifies](/azure/active-directory/managed-identities-azure-resources/overview#managed-identity-types), decide which type is appropriate per use case. Consider the tradeoffs with ease of management. For example, if the application needs to access multiple resources, user-assigned managed identities are recommended. However, if you want permissions to be tied to the application lifecycle, system-managed identities might be better suited. For more information, see [Choose system or user-assigned managed identities](/azure/active-directory/managed-identities-azure-resources/managed-identity-best-practice-recommendations#choosing-system-or-user-assigned-managed-identities).


- Azure Spring Apps Identities
	- Use your own managed identity for Azure Spring Apps
	- Use system-assigned and user-assigned managed identities separately 
	- Use Built in Azure RBAC roles to simplify the management of required permissions for managed identity.
	- Use Privileged Identity Management in Azure AD and identity and access management in Azure landing zones.
- Secure internet communication
	- Use certificates issued by a certificate authority, extended validation certificates or wildcard certificates
	- Use self-signed certificated only for non-prod environments
	- Securely load certificates from Azure Key Vault
- Consider creating custom roles, following the principle of least privilege when out-of-box roles require modifications to existing permissions. 
- Choose enhanced-security storage for keys, secrets, certificates, and application configuration.
- For automated deployment, set up a service principal that has the minimum required permissions to deploy from the CI/CD pipeline.
- Enable diagnostic logging for Application Console, System Logs, Ingress Logs, Build Logs and Container Event Logs. You can use these detailed logs to diagnose problems with your app and monitor access requests. Enabling these logs also provides an Azure Monitor activity log that gives you insight into subscription-level events.

