---
title: SAP and Power Platform Architecture Workflow
description: Learn about the architecture workflow of SAP and Power Platform.
author: shekhag
ms.author: shegupt
ms.date: 02/09/2024
ms.topic: conceptual
ms.custom: e2e-sap
---

# SAP and Power Platform architecture workflow

This article is part of the "SAP and Power Platform" article series.
	
- [SAP and Power Platform fundamentals](./sap-and-powerplatform-fundamental.md)
- [SAP and Power Platform Architecture Workflow](./sap-and-powerplatform-architecture-workflow.md)
- [Extend your SAP Landing Zone to support Power Platform](./sap-and-powerplatform-extend-landing-zone.md)


This article is part 2 of the SAP and Power Platform articles.

## Architecture

The following image depicts the components of an architecture. The components utilized are depending on the use cases and security requirements. This diagram illustrates how Power Platform components (Power BI, Power Apps, Power Automate, Power Pages, and Copilot Studio) connect to SAP systems.
 
For SAP systems using RFC or BAPI protocols, Power Platform components rely on the SAP ERP connector, which communicates with the SAP system via an on-premises data gateway and SAP .NET connector running in a virtual machine.
 
For SAP systems offering OData endpoints, the SAP OData connector is used. REST or SOAP-based SAP systems are accessed through custom connectors.
 
Security best practices dictate that connections to the on-premises data gateway pass through a firewall, while OData and REST/SOAP calls are routed via an API gateway.
 
Both Power Platform components and the on-premises data gateway are linked to the same Microsoft Entra tenant.
 
The diagram also depicts how mobile and laptop devices can access Power Platform components, and how Power Automate Desktop can connect to SAP systems through SAP GUI. Power BI Desktop can connect to SAP applications using the SAP .NET connector and the SAP HANA database using SAP HANA ODBC driver.
 
Importantly, the Power Platform is a cloud-based service (PaaS), while other components can be deployed either on-premises or in the cloud (IaaS).

- The SAP ERP Connector requires an on-premises data gateway for a connection to SAP.
- An OData connection or the use of "other connectors," such as the HTTP Connector, can be directly connected to SAP or through a firewall and API gateway.
- A firewall and an API gateway are recommended for implementations in production environments with sensitive customer data. Especially for further improvement of access control, traffic management, governance, scalability, and flexibility adding the API gateway is recommended.

:::image type="complex" source="./media/sap-powerplatform-architecture.svg" border="false" alt-text="This diagram illustrates how Power Platform components (Power BI, Power Apps, Power Automate, Power Pages, and Copilot Studio) connect to SAP systems. For SAP systems using RFC or BAPI protocols, Power Platform components rely on the SAP ERP connector, which communicates with the SAP system via an on-premises data gateway and SAP .NET connector running in a virtual machine. For SAP systems offering OData endpoints, the SAP OData connector is used. REST or SOAP-based SAP systems are accessed through custom connectors. Security best practices dictate that connections to the on-premises data gateway pass through a firewall, while OData and REST/SOAP calls are routed via an API gateway. Both Power Platform components and the on-premises data gateway are linked to the same Microsoft Entra tenant. The diagram also depicts how mobile and laptop devices can access Power Platform components, and how Power Automate Desktop can connect to SAP systems through SAP GUI. Power BI Desktop can connect to SAP applications using the SAP .NET connector and the SAP HANA database using SAP HANA ODBC driver. Importantly, the Power Platform is a cloud-based service (PaaS), while other components can be deployed either on-premises or in the cloud (IaaS)" lightbox="./media/sap-powerplatform-architecture.svg":::

*Download a [Visio file](https://github.com/microsoft/CloudAdoptionFramework/raw/main/ready/sap-powerplatform-architecture.vsdx) of this architecture.*

## Choose the optimal connector

- **SAP ERP** - The SAP ERP connector for Power Automate and Power Apps allows you to invoke SAP RFC and BAPI functions using on-premises data gateway. For details, please see [SAP ERP - Connectors](/connectors/saperp/) 

- **SAP ODATA** - The OData connector provides the ability to fetch, create, and update records exposed by an SAP system through OData APIs. Currently this connector is in private preview.

- **Custom Connector** - A custom connector for Power Platform is a way to connect your Power Apps or Power Automate to any web service that has a REST or SOAP API. A custom connector acts as a wrapper around the web service, allowing you to use its data and actions in your app or flow. A custom connector can be created from scratch from an OpenAPI definition or a WSDL file.

  - **SAP SOAP** - SAP offers a comprehensive suite of services and functionalities accessible via SOAP (Simple Object Access Protocol), facilitating seamless integration with the Power Platform. Utilizing the Power Platform's HTTP connector, a connection to SAP's SOAP services can be established. This integration enables the execution of various operations and interactions, leveraging the robust capabilities of SAP within the Power Platform.
  - **HTTP** - HTTP connectors use Representational State Transfer (REST) architecture, which allows users to interact directly with data by using web requests. Additionally, it allows flow makers to use the full potential of the web service offerings in a secure manner while still using Power Automate flows.

- **SAP GUI Connection through the RPA** - Use Power Automate Desktop to develop low-code SAP GUI automation. End users can automate their repetitive tasks within SAP's UIs. Please see more information [here](/power-automate/guidance/rpa-sap-playbook/action-based-sap-gui-automation-manually-overview).

Here is a summary of the connectors 

| Criteria | SAP ERP Connector | SAP OData Connector | Custom Connector | 
|----------|-------------------|---------------------|------------------|
| Integration Method | On-premises data gateway (RFC and BAPI) | OData APIs | REST or SOAP API |
| Use Cases          | SAP RFC and BAPI functions | SAP data manipulation via OData APIs | Any web service with REST or SOAP API |

## Security and compliance considerations

When integrating SAP with the Power Platform, prioritizing security and compliance is imperative, especially given the sensitive nature of data typically managed within SAP systems and its significance to enterprise operations. This section outlines essential security and compliance considerations, focusing on key components integral to securing and streamlining the integration process. These components collectively establish a fortified security framework, ensuring the protection of sensitive data and compliance with regulatory standards, thereby enhancing the overall integrity and reliability of the integrated system.

- **On-Premises Data Gateway** - The on-premises data gateway serves as a critical conduit, facilitating secure and efficient data transfer between Power BI, Power Apps, Power Automate, Azure Analysis Services, Azure Logic Apps, and your SAP system, irrespective of whether they are cloud-based or on-premises. To connect with SAP ERP, certain pre-requisites need to be met and installed on a Windows machine with network access to the SAP system. Please see the pre-requisites details [here](/connectors/saperp/#pre-requisites).

Please see the On-premise data Gateway [Installation and Configuration](/azure/analysis-services/analysis-services-gateway-install?tabs=azure-portal) guidance. 

- **Use Single Sign-On (SSO)** - SSO is a user authentication process that allows a user to access multiple applications with one set of login credentials. Implementing SSO with the Microsoft Power Platform and SAP offers several significant benefits:

  - Unified authentication: Simplifies user authentication across SAP and Power Platform, enhancing user experience without compromising security.
  - Reduced credential exposure: Minimizes the risk of password-related breaches by eliminating the need for multiple credentials.
  - Compliance with identity management policies: Aligns with organizational identity management policies and standards.

  See the following tutorials for SSO setup:

  - [Setup SAP SSO with Microsoft Entra ID](/entra/identity/saas-apps/sap-netweaver-tutorial)
  - [SSO authentication setup in the SAP ERP Connector](/connectors/saperp/#authentication)


- **Use API Management** - API Management is instrumental in ensuring secure, efficient, and reliable communication with the SAP backend.

  - SAP Principal Propagation requires [APIM](https://github.com/Azure/api-management-policy-snippets/blob/master/examples/Request%20OAuth2%20access%20token%20from%20SAP%20using%20AAD%20JWT%20token.xml).
  - **Implement IP address filtering**: Bolsters security by selectively permitting or denying requests based on predefined IP address criteria.
  - **Perform request validation**: Ensures incoming requests are in line with expected patterns by pre-validating headers, queries, or path parameters against the API schema.
  - **Backend decoupling**: Protect backend system from directly exposing it to API consumers.
  - **Configure monitoring and alerts**: Perform vigilant monitoring of backend API use and establish alert mechanisms for prompt identification and resolution of potential security issues.

For more details, please see [The One with protecting SAP services with Azure APIM and SSO](https://www.youtube.com/watch?v=KFd2x06c4nM)

- **Deploy behind a firewall** - Implementing a firewall is crucial for enhancing network security in the integration of SAP and Power Platform.

  - **Network Protection**: Shields the SAP and Power Platform infrastructure from unauthorized external access.
  - **Intrusion Prevention**: Monitors and blocks potentially harmful traffic, safeguarding against network-based attacks.
  - **Data Leakage Prevention**: Helps in preventing unauthorized data access and ensures data does not leave the network without proper authorization.

  Power Platform specific service tags are available to restrict incoming connections from the Power Platform IP addresses, with even region-specific tags being an option.

By addressing these security and compliance considerations, organizations can ensure a secure, efficient, and compliant integration of SAP with the Power Platform, fostering a secure and responsive environment conducive to modern enterprise needs.

## Next steps

- [Extend your SAP Landing Zone to support Power Platform](./sap-and-powerplatform-extend-landing-zone.md)


