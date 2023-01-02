---
title: Security considerations for Azure App Service
description: Learn about design considerations and recommendations for security in the Azure App Service landing zone accelerator
author: martinekuan
ms.author: martinek
ms.date: 03/23/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: internal
---

# Security considerations for the Azure App Service landing zone accelerator

This article provides design considerations and recommendations for security when using the Azure App Service landing zone accelerator. Security covers multiple aspects including securing application secrets, network isolation, and vulnerability scanning.

Learn more about the [security](../../../ready/landing-zone/design-area/security.md) design area.

## Design considerations

The following is a bulleted list of things you must think about when preparing for **any** deployment of App Service:

- Review your security requirements to determine if they allow your web applications to be run on shared network infrastructure or if they require the complete network/virtual machine isolation available with [App Service Environments](/azure/app-service/environment/overview).
- Authentication and Authorization: It is important to properly configure authentication and authorization for your Azure App Service, to ensure that only authorized users have access to the app and its resources. This can be done using Azure Active Directory, which provides a secure and scalable solution for managing user identities and access to the app.
- Network Security: Azure App Service includes several built-in features to help protect the app and its resources from network-based attacks. This includes support for SSL/TLS, IP firewall rules, and DDoS protection. It is important to properly configure these features to ensure that the app is protected from external threats.
- Application Security: It is also important to ensure that the app itself is secure, and that it follows best practices for protecting sensitive data and preventing common vulnerabilities such as SQL injection and cross-site scripting (XSS). This can be achieved through a combination of secure coding practices, regular security testing, and the use of tools such as Azure Security Center to monitor for potential threats.

- Data Security: Finally, it is important to properly protect the data that is stored and processed by the app. This can be done using Azure's built-in features such as Azure Key Vault, which provides secure storage for sensitive data such as cryptographic keys and passwords. It is also important to encrypt data in transit and at rest, and to regularly back up and test your data recovery processes.

In summary, security is a critical concern when working with Azure App Service. By following best practices for authentication and authorization, network security, application security, and data security, you can help ensure that your app and its resources are protected from potential threats.

## Design recommendations

The following is a bulleted list of things you must think about when preparing for **any** deployment of App Service:

- Store application secrets (database credentials, API tokens, private keys) in Azure Key Vault and configure your App Service app to access them securely with a Managed Identity.  Determine [when to use Azure Key Vault vs Azure App Configuration](/azure/architecture/solution-ideas/articles/appconfig-key-vault) with the guidance in mind.
- [Enable Cross-Origin Resource Sharing (CORS)](/azure/app-service/app-service-web-tutorial-rest-api#enable-cors) within App Services or using your own CORS utilities to indicate which origins the user’s browser should permit resources to be loaded from.
- When deploying containerized web applications to App Services, [enable Azure Defender for container registries](/azure/security-center/defender-for-container-registries-introduction) to automatically scan images for vulnerabilities.
- Enable [Azure Defender for App Service](/azure/security-center/defender-for-app-service-introduction) to assess the security of your web applications, detect threats, and alert when potential threats are detected so action can be taken to protect your Azure resources.
- Use [Private Endpoint](/azure/private-link/private-endpoint-overview) to privately access [Azure services](/azure/private-link/availability) through your VNet.
- Secure data transfer: When working with sensitive data, it's important to ensure that the data is transferred securely between the app and its clients. Azure App Service supports secure HTTPS connections, which encrypt the data in transit and prevent third parties from intercepting it.
- Managed SSL certificates: Azure App Service also offers managed SSL certificates, which provide a convenient way to secure the app with a trusted SSL certificate. This allows the app to use HTTPS to encrypt the data in transit and ensures that users can trust that data is transferred securely.
- Use a Web Application Firewall (WAF) such as Azure Front Door and Azure Application Gateway to provide protection for your web apps from common web vulnerabilities such as SQL injection and cross-site scripting (XSS) attacks. By implementing a WAF, you can help protect your apps from these types of threats and improve the security of your Azure App Service resources.


Overall, security is a key consideration when working with Azure App Service. By carefully managing access, implementing network security controls, protecting your data, and securing your apps, you can help ensure that your Azure App Service resources are secure and protected from potential threats.
