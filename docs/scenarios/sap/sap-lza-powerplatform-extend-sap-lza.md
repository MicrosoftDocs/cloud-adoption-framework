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

:::image type="complex" source="./media/sap-powerplatform-architecture.svg" border="false" alt-text="This diagram illustrates how Power Platform components (Power BI, Power Apps, Power Automate, Power Pages, and Copilot Studio) connect to SAP systems (SAP Cloud Solutions i.e., SAP PaaS, SAP SaaS and SAP On-premises). The Power Automate executes the application logic for complex integration scenario, and integration with SAP mostly falls in that category. Therefore, in the diagram arrows from Power BI Service, Power App, Power Pages and Copilot studio are connected to Power Automate. For SAP systems using RFC or BAPI protocols, Power Platform components rely on the SAP ERP connector, which communicates with the SAP system via an on-premises data gateway and SAP .NET connector running in a virtual machine. As per security best practices, the connection to on-premises data gateway goes via Firewall. Therefore, in the diagram, the arrow from Power Automate is connected to on-premises data gateway through SAP ERP connector and a firewall. For SAP systems offering OData endpoints, the SAP OData connector is used. REST or SOAP-based SAP systems are accessed through custom connectors. As per security best practices, the OData and REST/SOAP calls are routed via API gateway. Therefore, in the diagram an arrow  from Power Automate is connected to OData and REST/SOAP API of SAP system through OData and Custom connector and an API Gateway. Both on-premises data gateway and the Power Platform components are connected to the same Microsoft Entra tenant. Therefore, the diagram is showing arrows starting from on-premises data gateway and Power Platform components connected to Microsoft Entra tenant. An arrow from Power BI Service is also connected to SAP system via firewall and on-premises data gateway. 
The diagram also depicts how mobile and laptop devices can access Power Platform components, and how Power Automate Desktop can connect to SAP systems through SAP GUI. Power BI Desktop can connect to SAP applications using the SAP .NET connector and the SAP HANA database using SAP HANA ODBC driver. Therefore, an arrow from Laptop/mobile group is connected to Power Platform components. Another arrow from Power Automate Desktop is connected to SAP system through SAP GUI. Further, an arrow from Power BI desktop is also connected to SAP system using SAP .NET connector and SAP HANA database using SAP HANA ODBC driver. Importantly, the Power Platform is a cloud-based service (PaaS), while other components can be deployed either on-premises or in the cloud" lightbox="./media/sap-powerplatform-architecture.svg"::::::image-end:::


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
