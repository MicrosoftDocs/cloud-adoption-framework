---
title: Extend your SAP Landing Zone to support Power Platform
description: Learn about extending your SAP Landing Zone to support the Power Platform
author: shekhag
ms.author: shegupt
ms.date: 02/09/2024
ms.topic: conceptual
ms.custom: think-tank, e2e-sap
---

# SAP and Power Platform Architecture Workflow

This article is part of the "SAP and Power Platform" article series.
	
- [SAP and Power Platform fundamentals](./sap-lza-powerplatform-fundamental.md)
- [SAP and Power Platform Architecture Workflow](./sap-lza-powerplatform-architecture-workflow.md)
- [Extend your SAP Landing Zone to support Power Platform](./sap-lza-powerplatform-extend-sap-lza.md)


This article is Part 3 of the SAP and Power Platform Articles. 

## Guidance - SAP Landing Zone extension for Power Platform  
Depending on customer scenario of Power Platform usage with SAP, there will be a need of middleware component deployment. 

:::image type="content" source="./media/sap-powerplatform-architecture.svg" border="false" alt-text="Diagram that shows architecture diagram of Power Platform Integration with SAP." lightbox="./media/sap-powerplatform-architecture.svg":::

*Download a [Visio file](https://github.com/microsoft/CloudAdoptionFramework/raw/main/ready/sap-powerplatform-architecture.vsdx) of this architecture.*

The table below list the possible usage scenarios in relation to Power Platform and SAP, required connectors and middleware.

| **Scenario**                 | **Connector Type**                   | **Middleware Requirement** | **Communication Protocol** | Usage Example| 
| ---------------------------  | ------------------------------------ | -------------------------- | -------------------------- | ------------ |
| Call RFC API of SAP system   | SAP ERP                              | On-Premises Data Gateway   |  RFC                       | Call SAP Table or CDS views or BAPI or RFC Function Modules of SAP NetWeaver based systems|
| Call OData API or Web service of SAP system   | Custom, HTTP, OData |         N/A                |  HTTP(S) / OData           | Call SAP OData/Web service of SAP system |
| Call REST or SOAP API of SAP system   | Custom                      |          N/A               |  REST / SOAP               | Call SAP Table or CDS views or BAPI or RFC Function Modules of SAP NetWeaver based systems|
| Call SAP SaaS system API of SAP system  | Custom, HTTP, OData       |          N/A               |  HTTP(S) / OData           | Call SAP Table or CDS views or BAPI or RFC Function Modules of SAP NetWeaver based systems|                                

Before trying to integrate SAP systems with Power Platform, the customer must have the Power Platform and SAP systems deployed and configured. Therefore, the section only focuses on the design and deployment of middleware component needed for Power Platform and SAP integration, which is on-premises data gateway.
 The usage of API management solution in relation to non-RFC calls are optional but recommended, and thus the section focuses on API management solutions also.

> [!TIP]
> For the design and deployment of on-premises data gateway, one can take inspiration from the pattern used for the deployment of SAP Cloud Connector, which acts as a bridge between on-premises/IaaS based SAP systems and cloud-based SAP solutions (like SAP Cloud Platform or S/4HANA Cloud). It facilitates secure communication and data flow between these two environments.


## Design Considerations 

- Consider organization naming, tagging and resource organization standards for on-premises data gateway.
- Consider combining on-premises data gateway for all non-production environments.
- Consider using any existing on-premises data gateway and API management solution for proof-of-concept or pilot use cases.

## Design Recommendations
- Refer the guidance from [On-premises and virtual network (VNet) data gateways documentation](/data-integration/gateway/) for the installation, configuration and management of on-premises data gateway.
•	Deploy a dedicated on-premises gateway cluster for SAP to achieve better observability and control for business-critical use cases.
•	Segregate on-premises data gateways for non-production and production SAP environments.
•	Use an API management solution (Azure API Management, SAP API Management etc.) to expose the backend SAP services to Power Platform components. This approach will ensure better security and management of SAP APIs and enhanced citizen developer experience.
•	Use [Azure API Management landing zone accelerator](/azure/architecture/example-scenario/integration/app-gateway-internal-api-management-function) - Azure Architecture Center | Microsoft Learn to speed-up deployment, while using Azure API Management as API management solution.


## Next steps

- [SAP and Power Platform fundamentals](./sap-lza-powerplatform-fundamental.md)
- [SAP and Power Platform Architecture Workflow](./sap-lza-powerplatform-architecture-workflow.md)
- [Extend your SAP Landing Zone to support Power Platform](./sap-lza-powerplatform-extend-sap-lza.md)