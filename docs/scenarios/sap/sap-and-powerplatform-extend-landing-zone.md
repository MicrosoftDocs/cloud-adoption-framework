---
title: Extend an SAP landing zone to support Power Platform
description: Learn how to technically implement the integration of SAP with the Microsoft Power Platform by extending your SAP landing zone.
author: shekhag
ms.author: shegupt
ms.date: 09/14/2024
ms.topic: conceptual
ms.custom: e2e-sap
---

# Extend an SAP landing zone to support Power Platform

This article is part of the "SAP and Power Platform" article series.

- [Extend SAP with the Microsoft Power Platform](./sap-and-powerplatform-fundamental.md)
- [SAP and Power Platform architecture workflow](./sap-and-powerplatform-architecture-workflow.md)
- [Extend your SAP landing zone to support Power Platform](./sap-and-powerplatform-extend-landing-zone.md)

When integrating SAP systems with Microsoft Power Platform, specific actions are required to enable the service, depending on the chosen use cases and connectors. Each connector has unique technical requirements that need to be addressed.
In this guide, we outline the integration options and provide links to the relevant implementation guides to establish the connection and technical setup required for each scenario. Based on your organization's specific needs and use cases, you can select and implement the appropriate components to extend your SAP environment with the Power Platform.

## Architecture Diagram

Depending on your scenario for Power Platform usage with SAP, there will be a need of middleware component deployment.



:::image type="complex" source="./media/sap-powerplatform-architecture.svg" border="false" alt-text="Diagram that shows architecture diagram of Power Platform Integration with a typical SAP landing zone." lightbox="./media/sap-powerplatform-architecture.svg":::
   On the left side of the image is box label "Power Platform Environment - Cloud." It contains Power Pages, Power App, Power Automate, and Copilot Studio, and Power BI Service.  Power Automate has arrows coming out of it to SAP ERP Connector, OData Connector, and Custom Connector all in the same box. To the right of that box is Microsoft Entra, Firewall, and API Gateway. Going through the firewall is and arrow from SAP ERP Connector and Power BI Service. Going through the API Gateway is an arrow from OData Connector and Custom Connector. To the right of the Firewall and A.P.I. Gateway is a box labeled "S.A.P. Environment on on-premises data gateway - On-Premises/IaaS." In that box is an On-premises data gateway icon with arrows pointing at it from Firewall and an arrow pointing to SAP .NET Connector. That Box also contains OData API and REST/SOAP API icons, with arrows coming from API Gateway and going into the SAP logo. Also going into the SAP logo is a HANA SQL Port icon. A final box sits above those icons, and that box is labeled "Client Applications." A laptop, mobile device, Power Automate Desktop, SAP GUI, Power BI Desktop all are shown. The Power BI Desktop shows an arrow to two additional icons in that box called SAP .NET Connector and SAP HANA ODBC Driver. Those two icons both connect into the SAP Icon through a DIAG & RFC PORT icon and the HANA SQL Port icon respectively.
:::image-end:::

*Download a [Visio file](https://github.com/microsoft/CloudAdoptionFramework/raw/main/ready/sap-powerplatform-architecture.vsdx) of this architecture.*

## Prerequisites

Before you begin, ensure you have:

- Administrative access to your SAP systems and Azure subscription.
- Necessary licenses for Power Platform components (consider using [trial licenses](https://www.microsoft.com/power-platform/try-free) for piloting).
- Understanding of your network infrastructure, including firewalls and virtual networks.
- An existing [SAP landing zone](/azure/cloud-adoption-framework/scenarios/sap/ready) to extend.

## Integration options

### SAP GUI–based RPA in Power Automate Desktop 
When you’re looking for ways to automate frequent, mundane, and rules-based tasks, please follow the SAP GUI automation patterns and best practices using Microsoft Power Automate, Power Automate Desktop, and desktop flows as described here and subsequent documents:

- [Introduction to SAP GUI–based RPA in Power Automate Desktop](/power-automate/guidance/rpa-sap-playbook/introduction)


### Reporting and analytics with Power BI on SAP HANA Business Warehouse
For real-time analytics, dynamic data visualization, and timely decision-making on SAP Business Warehouse, follow this guide to establish the connectivity:

- [Power Query SAP Business Warehouse Application Server connector - Power Query | Microsoft Learn](https://learn.microsoft.com/power-query/connectors/sap-bw/application-setup-and-connect)  

To use the SAP BW Message Server connector in Power BI, you must install the SAP .NET Connector as described here: 

- [Power Query SAP Business Warehouse Message Server connector - Power Query | Microsoft Learn](https://learn.microsoft.com/power-query/connectors/sap-bw/message-setup-and-connect)


### 3. Reporting and Data Analytics with Power BI on SAP HANA
For real-time analytics, dynamic data visualization, and timely decision-making on SAP HANA systems, follow this guide to learn about all options, capabilities, and how to establish connectivity:

- [Power Query SAP HANA database connector - Power Query | Microsoft Learn](https://learn.microsoft.com/power-query/connectors/sap-hana/overview)

> [!Note] Access to the SAP HANA database ports from your desktop may not always be permitted. Firewall rules may need to be configured to enable this access.

### 4. Applications, Copilots and more by leveraging the connectors
When building apps, copilots, web pages, or automations using the SAP ERP or SAP OData connectors, several activities are required to establish the appropriate network connectivity. The specific configuration will vary depending on the connector being used and the location of your SAP systems.

> [!Note]
> In an SAP Rise context, where SAP systems are hosted on Azure and managed by SAP AG, required middleware components like the firewall, the on-premises data gateway, or Azure API Management are installed in your Azure Subscription, and the SAP Rise network is peered with the customer’s own Azure virtual network.
> Follow this documentation to establish NW connectivity of your Azure subscription with the networks in scope of SAP Rise:  
[Integrating Azure with SAP RISE | Microsoft Learn](https://learn.microsoft.com/azure/sap/workloads/rise-integration)

#### 4.1. SAP ERP connector
This connector requires the on-premises data gateway, a locally installed Windows client application that acts as a bridge between your local on-premises data sources and services in the Microsoft cloud. It provides quick and secure data transfer and requires no inbound ports to your network. Only outbound ports are needed to reach the Azure web service to which the gateway connects.

- The on-premises gateway should be installed on a Windows VM in close proximity to the SAP system and positioned behind a firewall, as illustrated in the architecture diagram.
- Segment on-premises data gateways for non-production and production SAP environments.
- Consider combining on-premises data gateway for non-production environments.
- For business critical use-cases on productions consider implementing 2 on-premises data gateways for redundancy.

- Follow this documentation for the setup: [On-premises and virtual network (VNet) data gateways documentation | Microsoft Learn](https://learn.microsoft.com/data-integration/gateway/)

Also check the connector documentation for more details: [SAP ERP - Connectors | Microsoft Learn](https://learn.microsoft.com/connectors/saperp/)  

> [!Note] In an SAP Rise context, the on-premises data gateway will be installed within your Azure subscription and will connect to the SAP Rise environment via network peering. If your SAP systems are still running on-premises, the gateway must be installed in your on-premises environment.

#### 4.2. SAP OData connector
Unlike the SAP ERP connector, the SAP OData connector opens communication through an HTTP/S-based protocol. A connection is triggered from the connector in the Power Platform.  

See the connector documentation for more details: [SAP OData - Connectors | Microsoft Learn](https://learn.microsoft.com/connectors/sapodata)  

At a minimum, you need to configure your firewall(s) to allow communication between the public IPs of Power Platform and your SAP system. This ensures the necessary functionality for integration.  
- The outbound IP addresses for Power Platform are documented here: [Connectors outbound IP addresses | Microsoft Learn](https://learn.microsoft.com/connectors/common/outbound-ip-addresses)  
- If you are using Azure Firewall, you can simplify this process by using Service Tags, eliminating the need to manage individual IP address ranges manually.  
[Azure service tags overview | Microsoft Learn](https://learn.microsoft.com/azure/virtual-network/service-tags-overview)  

As an optimal implementation, recommended for production workloads, we propose including API management, which allows for Single Sign-On and other helpful features. See the next chapter for more details.


> [!Note] In an SAP Rise context, you can leverage the SAP API management service on the SAP Business Technology Platform.


#### Setup Single Sign-On (SSO)
In addition to Basic, Anonymous, and API Key Authentication, the SAP OData Connector, currently in public preview, now supports Single Sign-On available through Microsoft Azure API Management. It enables SAP Principal propagation with SAP services such as SAP Gateway, S/4HANA Cloud, RISE, and many more using Microsoft Entra ID (formerly Azure AD) as the Identity Provider. This way, users of your low-code solutions spanning the Microsoft and SAP ecosystem are mapped from their Microsoft Entra ID identities to their named SAP backend users. SAP authorizations are fully retained.

[Announcing public preview of expanded Single Sign-On authentication options for SAP Connectors - Microsoft Power Platform Blog](https://www.microsoft.com/power-platform/blog/power-apps/announcing-public-preview-of-expanded-single-sign-on-authentication-options-for-sap-connectors/)



![Alt text for the image](./media/Power-Platform-SSO.png)



This blog guides you through the setup of SSO using Azure API Management:  
[Hurray 🎉 SAP OData connector now supports OAuth2 and SAP Principal Propagation (powerplatform.com)](https://community.powerplatform.com/blogs/post/?postid=c6a609ab-3556-ef11-a317-6045bda95bf0)  

Alternatively, use this blog when SAP API Management is the preferred choice:  
[Integrating low-code solutions with Microsoft using SAP API Management - SAP Community](https://community.sap.com/t5/enterprise-resource-planning-blogs-by-members/integrating-low-code-solutions-with-microsoft-using-sap-integration-suite/ba-p/13789298)


### Next steps

- [Innovate with SAP and Azure](./innovate.md)

