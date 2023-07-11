---
title: Security considerations for the App Service landing zone accelerator
description: Learn about design considerations and recommendations for security in the Azure App Service landing zone accelerator.
author: motasem13
ms.author: martinek
ms.date: 01/09/2023
ms.topic: conceptual
ms.subservice: scenario
ms.custom: internal
---

# Security considerations for the App Service landing zone accelerator

This article provides design considerations and recommendations for security that you can apply when you use the Azure App Service landing zone accelerator. Security for application secrets, network isolation, and vulnerability scanning are some of the considerations covered in this article.

Learn more about the [security](../../../ready/landing-zone/design-area/security.md) design area.

## Design considerations

When you prepare for a deployment of App Service, take these considerations into account:

- **Requirements:** Review your security requirements to determine if they allow your web applications to be run on shared network infrastructure or if they require the complete network / virtual machine isolation that's available in an [App Service Environment](/azure/app-service/environment/overview).
- **Authentication and authorization:** You need to properly configure authentication and authorization for your App Service solution to ensure that only authorized users have access to the app and its resources. You can do this by using Azure Active Directory (Azure AD), which provides an enhanced-security, scalable solution for managing user identities and access to your app.
- **Network security:** App Service includes several built-in features to help protect your app and its resources from network-based attacks. These features include support for SSL/TLS, IP firewall rules, and distributed denial of service (DDoS) protection. You need to properly configure these features to ensure that your app is protected from external threats.
- **Application security:** You need to ensure that the app itself is secure, and that it incorporates best practices for protecting sensitive data and preventing common vulnerabilities like SQL injection and cross-site scripting (XSS). You can achieve this goal via a combination of secure coding practices, regular security testing, and the use of tools like Azure Security Center to monitor for potential threats.

- **Data security:** You also need to properly protect the data that's stored and processed by your app. You can get a level of protection for your data by using Azure services like Azure Key Vault, which provides enhanced-security storage for sensitive data such as cryptographic keys and passwords. You also need to encrypt data in transit and at rest, and to regularly back up and test your data recovery processes.

Following best practices for authentication and authorization, network security, application security, and data security can help you ensure that your app and its resources are protected from potential threats.

## Design recommendations

As you prepare for your App Service deployment, take these recommendations into account:

- Store application secrets (database credentials, API tokens, and private keys) in Key Vault, and configure your App Service app to access them via a managed identity. To determine when to use Key Vault and when to use Azure App Configuration, see [Centralized app configuration and security](/azure/architecture/solution-ideas/articles/appconfig-key-vault).
- [Enable cross-origin resource sharing (CORS)](/azure/app-service/app-service-web-tutorial-rest-api#enable-cors) in App Services or by using your own CORS utilities. CORS specifies origins from which user browsers should permit the loading of resources.
- When you deploy containerized web applications to App Services, [enable Azure Defender for container registries](/azure/security-center/defender-for-container-registries-introduction) to automatically scan images for vulnerabilities.
- Enable [Azure Defender for App Service](/azure/security-center/defender-for-app-service-introduction) to assess the security of your web applications, detect threats, and get alerts when potential threats are detected so that you can take action to protect your resources.
- Use [private endpoints](/azure/private-link/private-endpoint-overview) to privately access [Azure services](/azure/private-link/availability) through your virtual network.
- If you work with sensitive data, ensure that the data is transferred securely between the app and its clients. App Service supports secure HTTPS connections, which encrypt data in transit and help prevent third parties from intercepting it.
- App Service offers managed SSL certificates, a convenient way to use trusted SSL certificates. SSL certificates allow an app to use HTTPS to encrypt data in transit and helps ensure that data is transferred securely.
- Use a web application firewall (WAF) like Azure Front Door or Azure Application Gateway to help protect for your web apps from common web vulnerabilities such as SQL injection and XSS attacks. 

When you use App Service, security is an important consideration. By carefully managing access, implementing network security controls, protecting your data, and securing your apps, you can help ensure that your App Service resources are secure and protected from potential threats.
