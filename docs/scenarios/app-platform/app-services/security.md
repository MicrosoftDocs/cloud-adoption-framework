---
title: Security considerations for the App Service landing zone accelerator
description: Learn about design considerations and recommendations for security in the Azure App Service landing zone accelerator.
author: martinekuan
ms.author: martinek
ms.date: 01/06/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: internal
---

# Security considerations for the App Service landing zone accelerator

This article provides design considerations and recommendations for security that you can apply when you use the Azure App Service landing zone accelerator. Securing application secrets, network isolation, and vulnerability scanning are some of the considerations covered in this article.

Learn more about the [security](../../../ready/landing-zone/design-area/security.md) design area.

## Design considerations

When you prepare for a deployment of App Service, take these considerations into account:

- **Requirements:** Review your security requirements to determine if they allow your web applications to be run on shared network infrastructure or if they require the complete network / virtual machine isolation that's available in an [App Service Environment](/azure/app-service/environment/overview).
- **Authentication and authorization:** You need to properly configure authentication and authorization for your App Service solution to ensure that only authorized users have access to the app and its resources. You can do this by using Azure Active Directory (Azure AD), which provides an enhanced-security, scalable solution for managing user identities and access to your app.
- **Network security:** App Service includes several built-in features to help protect your app and its resources from network-based attacks. These features include support for SSL/TLS, IP firewall rules, and distributed denial of service (DDoS) protection. You need to properly configure these features to ensure that your app is protected from external threats.
- **Application security:** You need to ensure that the app itself is secure, and that it incorporates best practices for protecting sensitive data and preventing common vulnerabilities like SQL injection and cross-site scripting (XSS). You can achieve this goal by using a combination of secure coding practices, regular security testing, and using tools like Azure Security Center to monitor for potential threats.

- **Data security:** You also need to properly protect the data that's stored and processed by your app. This can be done using Azure's built-in features such as Azure Key Vault, which provides secure storage for sensitive data such as cryptographic keys and passwords. It is also important to encrypt data in transit and at rest, and to regularly back up and test your data recovery processes.

Security is a critical concern when working with Azure App Service. By following best practices for authentication and authorization, network security, application security, and data security, you can help ensure that your app and its resources are protected from potential threats.

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
