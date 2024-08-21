---
title: Extend your SAP Landing Zone to support Power Platform
description: Learn about extending your SAP Landing Zone to support the Power Platform
author: shekhag
ms.author: shegupt
ms.date: 02/09/2024
ms.topic: conceptual
ms.custom: think-tank, e2e-sap
---

# Extend your SAP Landing Zone to support Power Platform

This article is part of the "SAP and Power Platform" article series.
	
- [SAP and Power Platform fundamentals](./sap-and-powerplatform-fundamental.md)
- [SAP and Power Platform Architecture Workflow](./sap-and-powerplatform-architecture-workflow.md)
- [Extend your SAP Landing Zone to support Power Platform](./sap-and-powerplatform-extend-landing-zone.md)

This article is part 3 of the SAP and Power Platform articles.

## Guidance - SAP landing zone extension for Power Platform

### Architecture Diagram of the extended SAP Landing Zone for Power Platform
Depending on your scenario for Power Platform usage with SAP, there will be a need of middleware component deployment.

:::image type="complex" source="./media/sap-powerplatform-architecture.svg" border="false" alt-text="Diagram that shows architecture diagram of Power Platform Integration with a typical SAP landing zone." lightbox="./media/sap-powerplatform-architecture.svg":::
   On the left side of the image is box label "Power Platform Environment - Cloud." It contains Power Pages, Power App, Power Automate, and Copilot Studio, and Power BI Service.  Power Automate has arrows coming out of it to SAP ERP Connector, OData Connector, and Custom Connector all in the same box. To the right of that box is Microsoft Entra, Firewall, and API Gateway. Going through the firewall is and arrow from SAP ERP Connector and Power BI Service. Going through the API Gateway is an arrow from OData Connector and Custom Connector. To the right of the Firewall and A.P.I. Gateway is a box labeled "S.A.P. Environment on on-premises data gateway - On-Premises/IaaS." In that box is an On-premises data gateway icon with arrows pointing at it from Firewall and an arrow pointing to SAP .NET Connector. That Box also contains OData API and REST/SOAP API icons, with arrows coming from API Gateway and going into the SAP logo. Also going into the SAP logo is a HANA SQL Port icon. A final box sits above those icons, and that box is labeled "Client Applications." A laptop, mobile device, Power Automate Desktop, SAP GUI, Power BI Desktop all are shown. The Power BI Desktop shows an arrow to two additional icons in that box called SAP .NET Connector and SAP HANA ODBC Driver. Those two icons both connect into the SAP Icon through a DIAG & RFC PORT icon and the HANA SQL Port icon respectively.
:::image-end:::

### Choose the appropriate SAP Power Platform connector

*Download a [Visio file](https://github.com/microsoft/CloudAdoptionFramework/raw/main/ready/sap-powerplatform-architecture.vsdx) of this architecture.*

The table below list the possible usage scenarios in relation to Power Platform and SAP, required connectors and middleware.

| **Scenario**                 | **Connector type**                   | **Middleware requirement** | **Communication protocol** | Usage example |
| ---------------------------  | ------------------------------------ | -------------------------- | -------------------------- | ------------ |
| Call RFC API of SAP system   | SAP ERP                              | On-Premises Data Gateway   |  RFC                       | Call SAP Table or CDS views or BAPI or RFC Function Modules of SAP NetWeaver based systems|
| Call OData API or Web service of SAP system   | Custom, HTTP, OData |         N/A                |  HTTP(S) / OData           | Call SAP OData/Web service of SAP system |
| Call REST or SOAP API of SAP system   | Custom                      |          N/A               |  REST / SOAP               | Call SAP Table or CDS views or BAPI or RFC Function Modules of SAP NetWeaver based systems|
| Call SAP SaaS system API of SAP system  | Custom, HTTP, OData       |          N/A               |  HTTP(S) / OData           | Call SAP Table or CDS views or BAPI or RFC Function Modules of SAP NetWeaver based systems |

### Extend SAP Landing zone to support Power Platform Integration
Before trying to integrate SAP systems with Power Platform, you must have the Power Platform and SAP systems deployed and configured. Therefore, the section only focuses on the design and deployment of middleware component needed for Power Platform and SAP integration, which is the on-premises data gateway. The usage of an API gateway solution for non-RFC calls is optional but recommended, Azure API Management is used in this solution for that component.

> [!TIP]
> For the design and deployment of on-premises data gateway, one can take inspiration from the pattern used for the deployment of SAP Cloud Connector, which acts as a bridge between on-premises/IaaS based SAP systems and cloud-based SAP solutions (like SAP Cloud Platform or S/4HANA Cloud). It facilitates secure communication and data flow between these two environments.


## Design considerations

- Consider organization naming, tagging and resource organization standards for on-premises data gateway.
- Consider combining on-premises data gateway for all non-production environments.
- Consider using any existing on-premises data gateway and API management solution for proof-of-concept or pilot use cases.
- Consider the performance needs of the application during design and choose the location of various design components to minimize the network latency between Power Platform and SAP system. For example: it's recommended to deploy API gateway in cloud for scenario where SAP system is running in Cloud (RISE or Native)

## Design recommendations


- Refer the guidance from [On-premises and virtual network (VNet) data gateways documentation](/data-integration/gateway/) for the installation, configuration and management of on-premises data gateway.
- Deploy a dedicated on-premises gateway cluster for SAP to achieve better observability and control for business-critical use cases.
- Segment on-premises data gateways for non-production and production SAP environments.
- Use an API gateway solution (Azure API Management, SAP API Management, etc.) to expose the backend SAP services to Power Platform components. This approach will ensure better security and management of SAP APIs and enhanced citizen developer experience.
- Use [Azure API Management landing zone accelerator](/azure/architecture/example-scenario/integration/app-gateway-internal-api-management-function) to design your API gateway architecture.


## Next steps

- [Innovate with SAP and Azure](./innovate.md)
