---
title: Extend an SAP Landing Zone to Support Power Platform
description: Learn how to implement the integration of SAP with Microsoft Power Platform by extending your SAP landing zone.
author: shekhag
ms.author: shegupt
ms.date: 10/30/2024
ms.topic: conceptual
ms.custom: e2e-sap
---

# Extend an SAP landing zone to support Microsoft Power Platform

This article is part of the **SAP and Power Platform** article series:

- [Extend SAP by using the Microsoft Power Platform](./sap-power-platform-fundamental.md)
- [SAP and Power Platform architecture workflow](./sap-power-platform-architecture-workflow.md)
- Extend your SAP landing zone to support Power Platform 

When you integrate SAP systems with Microsoft Power Platform, the actions you take depend on your use cases and the connector that you use. Each connector has unique technical requirements that you need to address.

This article outlines integration options and provides links to implementation guides that can help you establish the connections and technical setup required for each scenario. Based on your organization's needs and use cases, you can select and implement the appropriate components to extend your SAP environment by using Microsoft Power Platform.

## Architecture

Depending on your scenario for Power Platform usage with SAP, there will be a need of middleware component deployment.

:::image type="complex" source="./media/sap-power-platform-architecture.png" border="false" alt-text="Diagram that shows architecture diagram of Power Platform Integration with a typical SAP landing zone." lightbox="./media/sap-power-platform-architecture.png":::
   Diagram that shows an architecture of a Microsoft Power Platform integration with a typical SAP landing zone. The architecture contains a Power Platform environment, an SAP environment, and box for client applications. The Power Platform environment contains Power BI, Power Apps, Power Pages, and Copilot Studio, all of which connect to Power Automate. Power Automate connects to SAP ERP connector, OData connector, and a custom connector. The Power Platform environment connects to a Microsoft Entra tenant. Data from Power BI and the SAP ERP connector go through a firewall and then to an SAP environment. Data from the OData connector and the custom connector goes through an API gateway into the SAP environment. The SAP environment contains an on-premises data gateway. Data enters this gateway from the firewall. From this gateway, data flows to SAP .NET Connector. The SAP environment also contains icons that represent OData API, REST / SOAP API, and HANA SQL port. Data flows from the API gateway through these APIs and into SAP. Data from HANA SQL port also flows into SAP. The client application box contains a laptop, a mobile device, Power Automate desktop, SAP GUI, and Power BI Desktop. In this box, data from Power BI Desktop flows to SAP .NET Connector and an SAP HANA ODBC driver. Data from SAP .NET Connector crosses through a DIAG and RFC port in the SAP environment and then flows to SAP. Data from the SAP HANA ODBC driver flows into a HANA SQL port in the SAP environment and then into SAP.
:::image-end:::

*Download a [Visio file](https://arch-center.azureedge.net/sap-power-platform-architecture.vsdx) of this architecture.*

## Prerequisites

Before you begin, ensure that you have:

- Administrative access to your SAP systems and Azure subscription.
- The necessary licenses for Microsoft Power Platform components. Consider using [trial licenses](https://www.microsoft.com/power-platform/try-free) for pilot projects.
- An understanding of your network infrastructure, including firewalls and virtual networks.
- An existing [SAP landing zone](/azure/cloud-adoption-framework/scenarios/sap/ready) to extend.

## Integration options

### SAP GUI–based RPA in Power Automate for desktop

When you're looking for ways to automate frequent, mundane, and rules-based tasks, follow the SAP GUI automation patterns and best practices described here and in subsequent articles:

- [Introduction to SAP GUI–based RPA in Power Automate desktop](/power-automate/guidance/rpa-sap-playbook/introduction)

### Reporting and analytics with Power BI on SAP HANA Business Warehouse

For information about real-time analytics, dynamic data visualization, and timely decision making on SAP Business Warehouse (BW), see [PowerQuery SAP Business Warehouse Application Server connector](/power-query/connectors/sap-bw/application-setup-and-connect).

To use the SAP BW Message Server connector in Power BI, you need to install SAP .NET Connector. For more information, see [Power Query SAP Business Warehouse Message Server connector](/power-query/connectors/sap-bw/message-setup-and-connect).

### Reporting and analytics with Power BI on SAP HANA

For information about real-time analytics, dynamic data visualization, and timely decision making on SAP HANA systems, see [Power Query SAP HANA database connector](/power-query/connectors/sap-hana/overview).

> [!NOTE]
> Access to the SAP HANA database ports from your desktop might not always be permitted. You might need to configure firewall rules to enable this access.

### Custom applications and copilots that use connectors

When you create apps, copilots, web pages, or automation by using the SAP ERP or SAP OData connector, you need to establish the appropriate network connectivity. The specific configuration varies depending on the connector you use and the location of your SAP systems.

> [!NOTE]
> In an SAP Rise context, where SAP systems are hosted on Azure and managed by SAP AG, required middleware components like the firewall, the on-premises data gateway, and Azure API Management are installed in your Azure subscription, and the SAP Rise network is peered with your Azure virtual network.
>
> To learn how to establish network connectivity of your Azure subscription with the networks in the scope of SAP Rise, see [Integrating Azure with SAP RISE managed workloads](/azure/sap/workloads/rise-integration).

#### SAP ERP connector

This connector requires an on-premises data gateway: a locally installed Windows client application that serves as a bridge between your local on-premises data sources and services in the Microsoft cloud. It provides quick, high-security data transfer and requires no inbound ports to your network. Only outbound ports are needed to reach the Azure web service to which the gateway connects.

- The on-premises gateway should be installed on a Windows VM in close proximity to the SAP system and positioned behind a firewall, as illustrated in the architecture diagram.
- Segment on-premises data gateways for nonproduction and production SAP environments.
- Consider combining on-premises data gateways for nonproduction environments.
- For business-critical use cases on production environments, consider implementing two on-premises data gateways for redundancy.
- To learn how to set up this configuration, see [On-premises and virtual network data gateways documentation](/data-integration/gateway/).

For more information, see [SAP ERP connectors](/connectors/saperp/).

> [!NOTE] 
> In an SAP Rise context, the on-premises data gateway is installed within your Azure subscription and connects to the SAP Rise environment via network peering. If your SAP systems are still running on-premises, the gateway must be installed in your on-premises environment.

#### SAP OData connector

Unlike the SAP ERP connector, the SAP OData connector opens communication through an HTTP/S-based protocol. A connection is triggered from the connector in Microsoft Power Platform.  

For more information, see [SAP OData connectors](/connectors/sapodata).  

At a minimum, you need to configure your firewalls to allow communication between the public IPs of Microsoft Power Platform and your SAP system. Doing so ensures the necessary functionality for integration.  

- For a list of the outbound IP addresses for Microsoft Power Platform, see [Managed connectors outbound IP addresses](/connectors/common/outbound-ip-addresses).  
- If you're using Azure Firewall, you can simplify this process by using service tags, which eliminates the need to manage individual IP address ranges manually. For more information, see [Azure service tags overview](/azure/virtual-network/service-tags-overview).

For production workloads, we recommend that you include API management, which enables single sign-on (SSO) and other helpful features. For more details, see the next section.

> [!NOTE]
> In an SAP Rise context, you can use the SAP API management service on the SAP Business Technology Platform.

#### Set up SSO

In addition to basic, anonymous, and API key authentication, the SAP OData connector, currently in public preview, now supports SSO available through Microsoft Azure API Management. It enables SAP Principal propagation with SAP services such as SAP Gateway, S/4HANA Cloud, RISE, and many more using Microsoft Entra ID (formerly Azure AD) as the Identity Provider. This way, users of your low-code solutions spanning the Microsoft and SAP ecosystem are mapped from their Microsoft Entra ID identities to their named SAP backend users. SAP authorizations are fully retained.

![A diagram showing Power Platform integration with SSO](./media/Power-Platform-SSO.png)

To learn more about the options for using SSO, see these resources:

- [SAP OData Connector: SSO through Microsoft Azure API Management](https://www.microsoft.com/power-platform/blog/power-apps/announcing-public-preview-of-expanded-single-sign-on-authentication-options-for-sap-connectors/) 
- [SAP OData connector now supports OAuth2 and SAP Principal Propagation](https://community.powerplatform.com/blogs/post/?postid=c6a609ab-3556-ef11-a317-6045bda95bf0)
- [Integrating low-code solutions with Microsoft using SAP API Management](https://community.sap.com/t5/enterprise-resource-planning-blogs-by-members/integrating-low-code-solutions-with-microsoft-using-sap-integration-suite/ba-p/13789298)

### Next steps

- [Innovate with SAP and Azure](./innovate.md)
