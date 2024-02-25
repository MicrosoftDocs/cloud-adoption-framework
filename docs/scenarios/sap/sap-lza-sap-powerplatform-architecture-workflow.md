---
title: SAP and Power Platform Architecture Workflow
description: Learn about the architecture workflow of SAP and Power Platform.
author: shekhag, mimergel
ms.author: shegupt, mimergel
ms.date: 02/09/2024
ms.topic: conceptual
ms.custom: think-tank, e2e-sap
---

# SAP and Power Platform Fundamentals

This article is part of the "SAP and Power Platform" article series.
	
- [SAP and Power Platform fundamentals](./sap-lza-sap-powerplatform-fundamental.md)

- [SAP and Power Platform Architecture Workflow](./sap-lza-sap-powerplatform-architecture-workflow.md)


This article is Part 2 of the SAP and Power Platform Articles. 

## Architecture
The following image depicts the components of an architecture. The components utilized depend on the use case and security requirements.
The SAP ERP Connector requires an on-premises data gateway for a connection to SAP.
An OData connection or the use of "Other Connectors," such as the HTTP Connector, can be directly connected to SAP or through a firewall and API Management gateway.
A firewall and API management are recommended for implementations in production environments with sensitive customer data. Especially for further improvement of access control, traffic management, governance, scalability, and flexibility adding the Azure API management is recommended.

:::image type="content" source="./media/sap-powerplatform-integration.svg" border="false" alt-text="Diagram that shows architecture diagram of Power Platform Integration with SAP." lightbox="./media/sap-powerplatform-integration.svg":::

*Download a [Visio file](https://github.com/microsoft/CloudAdoptionFramework/raw/main/ready/sap-powerplatform-integraion.vsdx) of this architecture.*

## Choose the optimal connector

- **SAP ERP** - The SAP ERP connector for Power Automate and Power Apps allows you to invoke SAP RFC and BAPI functions using on-premises data gateway. For details, please see [SAP ERP - Connectors](https://learn.microsoft.com/connectors/saperp/) 

- **SAP ODATA** - The OData connector provides the ability to fetch, create, and update records exposed by an SAP system through OData APIs.
Currently this connector is in private preview 

- **Custom Connector** - A custom connector for Power Platform is a way to connect your Power Apps or Power Automate to any web service that has a REST or SOAP API. A custom connector acts as a wrapper around the web service, allowing you to use its data and actions in your app or flow. A custom connector can be created from scratch from an OpenAPI definition, from a Postman collection or from a WSDL file for SOAP services.

  - **SAP SOAP** - SAP offers a comprehensive suite of services and functionalities accessible via SOAP (Simple Object Access Protocol), facilitating seamless integration with the Power Platform. Utilizing the Power Platform's HTTP connector, users can establish a robust connection to SAP's SOAP services. This integration enables the execution of various operations and interactions, leveraging the robust capabilities of SAP within the versatile framework of the Power Platform.
  - **HTTP** - HTTP connectors use Representational State Transfer (REST) architecture, which allows users to interact directly with data by using web requests. Additionally, it allows flow makers to use the full potential of the web service offerings in a secure manner while still using Power Automate flows

- **SAP GUI Connection through the RPA** - With the addition of Power Automate Desktop, it's quicker and easier to develop low-code SAP GUI automation. You can use Power Automate Desktop to build from simple to highly sophisticated end-to-end automation. End users can automate their repetitive tasks. Please see more information [here](https://learn.microsoft.com/power-automate/guidance/rpa-sap-playbook/action-based-sap-gui-automation-manually-overview)

Here is a summary of the connectors 

| Criteria | SAP ERP Connector | SAP OData Connector | Custom Connector | 
|----------|-------------------|---------------------|------------------|
| Integration Method | On-premises data gateway (RFC and BAPI) | OData APIs | REST or SOAP API |
| Availability        | GA   | Private Preview (*subject to change)    | GA |
| Use Cases          | SAP RFC and BAPI functions | SAP data manipulation via OData APIs | Any web service with REST or SOAP API |

## Security and compliance considerations
When integrating SAP with the Power Platform, prioritizing security and compliance is imperative, especially given the sensitive nature of data typically managed within SAP systems and its significance to enterprise operations. This section outlines essential security and compliance considerations, focusing on key components integral to securing and streamlining the integration process. These components collectively establish a fortified security framework, ensuring the protection of sensitive data and compliance with regulatory standards, thereby enhancing the overall integrity and reliability of the integrated system.


- **On-Premises Data Gateway** - The on-premises data gateway serves as a critical conduit, facilitating secure and efficient data transfer between Power BI, Power Apps, Power Automate, Azure Analysis Services, Azure Logic Apps, and your SAP system, irrespective of whether they are cloud-based or on-premises. To connect with SAP ERP, certain pre-requisites need to be met and installed on a Windows machine with network access to the SAP system. Please see the pre-requisties details [here](https://learn.microsoft.com/connectors/saperp/#pre-requisites)

Please see the On-premise data Gateway [Installation and Configuration](https://learn.microsoft.com/azure/analysis-services/analysis-services-gateway-install?tabs=azure-portal) guidance. 

- **Single Sign-On(SSO)** - SSO is a user authentication process that allows a user to access multiple applications with one set of login credentials. Implementing SSO with the Microsoft Power Platform and SAP offers several significant benefits:

  -	Unified Authentication: Simplifies user authentication across SAP and Power Platform, enhancing user experience without compromising security.
  - Reduced Credential Exposure: Minimizes the risk of password-related breaches by eliminating the need for multiple credentials.
  - Compliance with Identity Management Policies: Aligns with organizational identity management policies and standards.

Please see the following tutorials for SSO Setup
  - [Setup SAP SSO with Microsoft Entra ID](https://learn.microsoft.com/entra/identity/saas-apps/sap-netweaver-tutorial)
  - [SSO authentication setup in the SAP ERP Connector](https://learn.microsoft.com/connectors/saperp/#authentication)


- **API Management** - API Management is instrumental in ensuring secure, efficient, and reliable communication with the SAP backend.
  - SAP Principal Propagation using [APIM policy](https://github.com/Azure/api-management-policy-snippets/blob/master/examples/Request%20OAuth2%20access%20token%20from%20SAP%20using%20AAD%20JWT%20token.xml).
  - **Rate Limiting for Load Management**: Controls the volume of incoming requests to the backend, preventing overload and ensuring continuous service availability.
  - **IP Address Filtering**: Bolsters security by selectively permitting or denying requests based on predefined IP address criteria.
  - **Performance Optimization through Caching**: Enhances response times by caching backend responses, facilitating quicker access to commonly requested data.
  - **Request Validation**: Ensures incoming requests are in line with expected patterns by pre-validating headers, 
    queries, or path parameters against the API schema.
  - **Backend Decoupling**: Maintains API consistency and reduces consumer application disruptions by shielding API consumers from backend changes.
  - **Proactive Monitoring and Alerts**: Enables vigilant monitoring of backend API use and establishes alert mechanisms for prompt
    identification and resolution of potential issues.

For more details, please see [The One with protecting SAP services with Azure APIM and SSO](https://www.youtube.com/watch?v=KFd2x06c4nM)

- **Firewall** - Implementing a firewall is crucial for enhancing network security in the integration of SAP and Power Platform.

  - **Network Protection**: Shields the SAP and Power Platform infrastructure from unauthorized external access.
  - **Intrusion Prevention**: Monitors and blocks potentially harmful traffic, safeguarding against network-based attacks.
  - **Data Leakage Prevention**: Helps in preventing unauthorized data access and ensures data does not leave the network without proper authorization.
Power Platform specific service tags are available to restrict incoming connections from the Power Platform IP addresses, with even region-specific tags being an option.
By addressing these security and compliance considerations, organizations can ensure a secure, efficient, and compliant integration of SAP with the Power Platform, fostering a secure and responsive environment conducive to modern enterprise needs.





