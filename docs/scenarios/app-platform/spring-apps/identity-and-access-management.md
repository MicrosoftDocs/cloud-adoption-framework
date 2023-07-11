---
title: Identity and access management for the Azure Spring Apps landing zone accelerator
description: Learn how to ensure that the deployed Azure Spring app and the related resources of the workload are secure and only accessible by authorized users.
author: pagewriter-msft
ms.author: prwilk
ms.date: 03/01/2023
ms.topic: conceptual
--

# Identity and access management for the Azure Spring Apps landing zone accelerator

This article describes design considerations and recommendations to authenticate users in Azure Spring Apps, and grant users the necessary level of access to workload resources.

The centralized platform team and the application teams must have a good understanding of:

- Which teams require access to the Azure Spring app workload that's deployed in the application landing zone.
- The roles and responsibility of users and who needs access.
- The minimum level of privilege that's needed to carry out those responsibilities.

For information about the platform design, see [Azure identity and access management design area](/azure/cloud-adoption-framework/ready/landing-zone/design-area/identity-access).

As the workload owner, follow these best practices to ensure that the application resources don't violate organizational security or governance boundaries. The goal is to ensure that the deployed Azure Spring app and the related resources of the workload are secure and only accessible by authorized users. When you follow these practices, you protect sensitive data and prevent the misuse of the app and its resources.

## Design considerations

- **Access from the application to other services**. The application should authenticate itself when it connects to backend services that are part of the workload. This authentication protects the services from unauthorized access. Consider using features of Azure Active Directory (Azure AD) to prevent the overhead of storing and managing credentials.

- **Access to the application**. Users might send requests to the application over the public internet. Or requests might come from private or on-premises networks. In either case, access must be authenticated based on client certificates or through Active Directory (Azure AD).

  Consider the technology options for the service discovery mechanism that invokes calls between apps. The options vary based on the Azure Spring Apps tier.

  - Basic/Standard: [Kubernetes service discovery or Managed Spring Cloud Service Registry (using Eureka)](/azure/spring-apps/how-to-service-registration?pivots=programming-language-java)
  - Enterprise: [Tanzu Service Registry](/azure/spring-apps/how-to-enterprise-service-registry)

- **Operator access to resources**. Team members with different responsibilities might access your workload. For example, you might need to grant access to:

  - Platform team members who need operational access.
  - Application team members who develop applications.
  - DevOps engineers who build and release pipelines to deploy the workload and configure by using infrastructure as code (IaC).
  - Site reliability engineers for troubleshooting issues.

  Based on the purpose of access, decide the level of control you want to provide to the user. Start with the principle of least privilege. RBAC role assignments can ensure that users have the right set of privileges for their responsibilities and maintain boundaries. Consider built-in RBAC roles before you create custom roles.

- **Configuration data access**. Based on your choice of tier for Azure Spring Apps (**Basic/Standard** or **Enterprise**), you need to decide configuration server options.

  For **Basic**, consider support for the server and client side. To store your config server files, choose an externalized configuration in a distributed system, like Azure DevOps, GitHub, GitLab, or Bitbucket.

  You can use public or private repositories, and choose their authentication mechanism. Azure Spring Apps supports basic password or token-based authentication and SSH.

  For **Enterprise**, consider using Application Configuration Service for VMware Tanzu, which enables the management of Kubernetes-native ConfigMap resources that are populated from properties defined in one or more Git repositories.

## Design recommendations

### Managed identities

Use managed identities for the application so that it's authenticated through Azure AD. Not all services support this feature of Azure AD. For more information, see [Azure services that support Azure AD authentication](/azure/active-directory/managed-identities-azure-resources/services-azure-active-directory-support).

Decide which type of [managed identity](/azure/active-directory/managed-identities-azure-resources/overview#managed-identity-types) is appropriate for your use case. Consider the tradeoffs with ease of management. For example, if the application needs to access multiple resources, user-assigned managed identities are recommended. But if you want permissions tied to the application lifecycle, system-managed identities might be better suited.

For more information, see [Choose system or user-assigned managed identities](/azure/active-directory/managed-identities-azure-resources/managed-identity-best-practice-recommendations#choosing-system-or-user-assigned-managed-identities).

Use built-in Azure RBAC roles to simplify the management of required permissions for a managed identity.

- Use your own managed identity for Azure Spring Apps.
- Use system-assigned and user-assigned managed identities separately. For more information, see [Best practices when using managed identities](/azure/spring-apps/how-to-use-managed-identities?pivots=sc-standard-tier#best-practices-when-using-managed-identities).
- Use Privileged Identity Management in Azure AD.

### Secure internet communication

- Use certificates issued by a certificate authority, extended validation certificates, or wildcard certificates.
- Use self-signed certificated only for preproduction environments.
- Securely load certificates from Azure Key Vault.

### Role-based access control (RBAC)

- Consider creating custom roles. Follow the principle of least privilege when out-of-box roles require modifications to existing permissions.
- Choose enhanced-security storage for keys, secrets, certificates, and application configuration.
- For automated deployment, set up a service principal that has the minimum required permissions to deploy from the CI/CD pipeline.
- Enable diagnostic logging for application console, system logs, ingress logs, build logs, and container event logs. You can use these detailed logs to diagnose problems with your app and monitor access requests. When you enable these logs, an Azure Monitor activity log gives you insight into subscription-level events.

## Next steps

[Network topology and connectivity](./network-topology-and-connectivity.md)

