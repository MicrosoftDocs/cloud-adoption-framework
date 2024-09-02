---
title: SAP and Power Platform architecture workflow
description: Learn about the architecture workflow of SAP and Power Platform, along with security considerations and recommendations.
author: shekhag
ms.author: shegupt
ms.date: 09/02/2024
ms.topic: conceptual
ms.custom: e2e-sap
---

# SAP and Power Platform architecture workflow

This article is part of the "SAP and Power Platform" article series.

- [Extend SAP with the Microsoft Power Platform](./sap-and-powerplatform-fundamental.md)
- [SAP and Power Platform Architecture Workflow](./sap-and-powerplatform-architecture-workflow.md)
- [Extend your SAP Landing Zone to support Power Platform](./sap-and-powerplatform-extend-landing-zone.md)

The following architecture shows a scenario where SAP on Azure (Native/RISE) is integrated with Power Platform for developing low-code and no-code applications.

## Architecture

:::image type="complex" source="./media/sap-powerplatform-architecture.svg" border="false" alt-text="Diagram that shows architecture diagram of Power Platform Integration with a typical SAP landing zone." lightbox="./media/sap-powerplatform-architecture.svg":::
   On the left side of the image is box label "Power Platform Environment - Cloud." It contains Power Pages, Power App, Power Automate, and Copilot Studio, and Power BI Service. Power Automate has arrows coming out of it to SAP ERP Connector, OData Connector, and Custom Connector all in the same box. To the right of that box is Microsoft Entra, Firewall, and API Gateway. Going through the firewall is and arrow from SAP ERP Connector and Power BI Service. Going through the API Gateway is an arrow from OData Connector and Custom Connector. To the right of the Firewall and A.P.I. Gateway is a box labeled "S.A.P. Environment on on-premises data gateway - On-premises/IaaS." In that box is an On-premises data gateway icon with arrows pointing at it from Firewall and an arrow pointing to SAP .NET Connector. That Box also contains OData API and REST/SOAP API icons, with arrows coming from API Gateway and going into the SAP logo. Also going into the SAP logo is a HANA SQL Port icon. A final box sits above those icons, and that box is labeled "Client Applications." A laptop, mobile device, Power Automate Desktop, SAP GUI, Power BI Desktop all are shown. The Power BI Desktop shows an arrow to two additional icons in that box called SAP .NET Connector and SAP HANA ODBC Driver. Those two icons both connect into the SAP Icon through a DIAG & RFC PORT icon and the HANA SQL Port icon respectively.
:::image-end:::

*Download a [Visio file](https://github.com/microsoft/CloudAdoptionFramework/raw/main/ready/sap-powerplatform-architecture.vsdx) of this architecture.*

### Workflow

This architecture illustrates how various components, including Power BI, Power Apps, Power Pages, and Copilot Studio can connect to SAP systems. The Power Platform is a cloud-based service (PaaS), while other components can be deployed either on-premises or in the cloud (IaaS).

In this architecture, Power Platform and the on-premises data gateway are linked to the same Microsoft Entra tenant.

- For SAP systems using Remote Function Call (RFC) or Business Application Programming Interface (BAPI) protocols, Power Platform components rely on the SAP ERP connector, which communicates with the SAP system via an on-premises data gateway and SAP .NET connector running in a virtual machine.
  - The SAP ERP Connector requires an on-premises data gateway for a connection to SAP.

- For SAP systems offering OData endpoints, the SAP OData connector is used. REST or SOAP-based SAP systems are accessed through custom connectors.

- Security best practices dictate that connections to the on-premises data gateway pass through a firewall, while OData and REST/SOAP calls are routed via an API gateway.
  - A firewall and an API gateway are recommended for implementations in production environments with sensitive customer data. Especially for further improvement of access control, traffic management, governance, scalability, and flexibility adding the API gateway is recommended.

- Mobile and laptop devices can access Power Platform components.

- Power Automate Desktop can connect to SAP systems through SAP GUI.
  - Power BI Desktop can connect to SAP applications using the SAP .NET connector and the SAP HANA database using SAP HANA ODBC driver.

## Connector options

| Purpose | Integration method | Connector | Description |
|---|---|---|---|
| SAP RFC and BAPI functions | On-premises data gateway | [SAP ERP Connector](/connectors/saperp/) | The SAP ERP connector for Power Automate and Power Apps allows you to invoke SAP RFC and BAPI functions using on-premises data gateway. |
| SAP data manipulation via OData APIs | OData APIs | [SAP OData Connector](/connectors/sapodata/) | The OData connector provides the ability to fetch, create, and update records exposed by an SAP system through OData APIs. Currently this connector is in private preview. |
| Any web service with REST or SOAP API | REST or SOAP API | [Custom Connector](/power-platform/connectors/custom-connectors-overview) | A custom connector for Power Platform is a way to connect your Power Apps or Power Automate to any web service that has a REST or SOAP API. |
| End-user task automation | SAP GUI | Power Automate Desktop | Power Automate Desktop can automate repetitive tasks within SAP's UIs. For details, see [Use low-code RPA with SAP GUI in Power Automate Desktop](/power-automate/guidance/rpa-sap-playbook/action-based-sap-gui-automation-manually-overview). |

## Security and compliance considerations

When integrating SAP with the Power Platform, prioritizing security and compliance is imperative, especially given the sensitive nature of data typically managed within SAP systems and its significance to enterprise operations.

This section outlines essential security and compliance considerations, focusing on key components integral to securing and streamlining the integration process. These components collectively establish a fortified security framework, ensuring the protection of sensitive data and compliance with regulatory standards, thereby enhancing the overall integrity and reliability of the integrated system.

## On-premises data gateway

The on-premises data gateway serves as a critical conduit, facilitating secure and efficient data transfer between Power BI, Power Apps, Power Automate, Azure Analysis Services, Azure Logic Apps, and your SAP system, whether they're cloud-based or on-premises.

To connect with SAP ERP, certain prerequisites need to be met and installed on a Windows machine with network access to the SAP system.

For more information, see [SAP ERP connector pre-requisites](/connectors/saperp/#pre-requisites) and [Install and configure an on-premises data gateway](/azure/analysis-services/analysis-services-gateway-install).

### Use single sign-on (SSO)

SSO is a user authentication process that allows a user to access multiple applications with one set of sign-in credentials. Implementing SSO with the Microsoft Power Platform and SAP offers several significant benefits:

- Unified authentication: Simplified user authentication across SAP and Power Platform, enhancing user experience without compromising security.
- Reduced credential exposure: Minimizes the risk of password-related breaches by eliminating the need for multiple credentials.
- Compliance with identity management policies: Aligns with organizational identity management policies and standards.

For more information, see [Setup SAP SSO with Microsoft Entra ID](/entra/identity/saas-apps/sap-netweaver-tutorial) and [SSO authentication setup in the SAP ERP Connector](/connectors/saperp/#authentication).

### Use API Management

API Management is instrumental in ensuring secure, efficient, and reliable communication with the SAP backend, and offers several key benefits:

- IP address filtering: Bolsters security by selectively permitting or denying requests based on predefined IP address criteria.
- Request validation: Ensures incoming requests are in line with expected patterns by prevalidating headers, queries, or path parameters against the API schema.
- Backend decoupling: Protect backend system from directly exposing it to API consumers.
- Configure monitoring and alerts: Perform vigilant monitoring of backend API use and establish alert mechanisms for prompt identification and resolution of potential security issues.

SAP Principal Propagation requires [APIM](https://github.com/Azure/api-management-policy-snippets/blob/master/examples/Request%20OAuth2%20access%20token%20from%20SAP%20using%20AAD%20JWT%20token.xml).

For more information, see [The One with protecting SAP services with Azure APIM and SSO](https://www.youtube.com/watch?v=KFd2x06c4nM)

### Deploy behind a firewall

Implementing a firewall is crucial for enhancing network security in the integration of SAP and Power Platform. Key benefits include:

- **Network Protection**: Shields the SAP and Power Platform infrastructure from unauthorized external access.
- **Intrusion Prevention**: Monitors and blocks potentially harmful traffic, safeguarding against network-based attacks.
- **Data Leakage Prevention**: Helps in preventing unauthorized data access and ensures data doesn't leave the network without proper authorization.

Power Platform specific service tags are available to restrict incoming connections from the Power Platform IP addresses, with even region-specific tags being an option.

By addressing these security and compliance considerations, organizations can ensure a secure, efficient, and compliant integration of SAP with the Power Platform, fostering a secure and responsive environment conducive to modern enterprise needs.

## Next steps

- [Extend your SAP Landing Zone to support Power Platform](./sap-and-powerplatform-extend-landing-zone.md)
