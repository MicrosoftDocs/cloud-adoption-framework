---
title: SAP and Power Platform Architecture Workflow
description: View an architecture workflow for integrations of SAP and Microsoft Power Platform and learn about security considerations.
author: mimergel
ms.author: mimergel
ms.date: 10/30/2024
ms.topic: conceptual
ms.custom: e2e-sap
---

# SAP and Microsoft Power Platform architecture workflow

This article is part of the **SAP and Power Platform** article series:

- [Extend SAP by using Microsoft Power Platform](./sap-power-platform-fundamental.md)
- SAP and Power Platform architecture workflow
- [Extend your SAP landing zone to support Power Platform](./sap-power-platform-extend-landing-zone.md)

## Architecture

The following architecture illustrates a comprehensive integration scenario that encompasses all integration options. It's designed to accommodate SAP systems operating on-premises, on Azure (both native and RISE with SAP), or on other cloud platforms.

:::image type="complex" source="./media/sap-power-platform-architecture.png" border="false" alt-text="Diagram that shows an architecture of a Microsoft Power Platform integration with a typical SAP landing zone." lightbox="./media/sap-power-platform-architecture.png":::
   Diagram that shows an architecture of a Microsoft Power Platform integration with a typical SAP landing zone. The architecture contains a Power Platform environment, an SAP environment, and box for client applications. The Power Platform environment contains Power BI, Power Apps, Power Pages, and Copilot Studio, all of which connect to Power Automate. Power Automate connects to SAP ERP connector, OData connector, and a custom connector. The Power Platform environment connects to a Microsoft Entra tenant. Data from Power BI and the SAP ERP connector go through a firewall and then to an SAP environment. Data from the OData connector and the custom connector goes through an API gateway into the SAP environment. The SAP environment contains an on-premises data gateway. Data enters this gateway from the firewall. From this gateway, data flows to SAP .NET Connector. The SAP environment also contains icons that represent OData API, REST / SOAP API, and HANA SQL port. Data flows from the API gateway through these APIs and into SAP. Data from HANA SQL port also flows into SAP. The client application box contains a laptop, a mobile device, Power Automate desktop, SAP GUI, and Power BI Desktop. In this box, data from Power BI Desktop flows to SAP .NET Connector and an SAP HANA ODBC driver. Data from SAP .NET Connector crosses through a DIAG and RFC port in the SAP environment and then flows to SAP. Data from the SAP HANA ODBC driver flows into a HANA SQL port in the SAP environment and then into SAP.  
:::image-end:::

_Download a [Visio file](https://arch-center.azureedge.net/sap-power-platform-architecture.vsdx) of this architecture._

## Connectivity options and when to use them

To effectively integrate SAP with Microsoft Power Platform, select the appropriate connectivity option, based on your use cases, integration requirements, and technical constraints. The following table provides an overview of the available connectors and their use cases, requirements, and communication protocols.

| **Connectivity option** | **Scenarios** | **Middleware, software, and driver requirements** | **Communication protocol** | **SAP requirements** |
|---|---|---|---|---|
| **SAP ERP connector** | Invoke SAP RFC or BAPI functions.<br>Example: reading, creating, updating, or approving sales orders. | On-premises data gateway,<br> SAP .NET Connector | RFC | - SAP system exposing RFC/BAPI interfaces<br>- Appropriate authentication configured |
| **SAP OData connector** | Interact with SAP data via OData services.<br>Example: reading or changing product information. | API Management for SSO | HTTP(S) / OData | - SAP system with OData services enabled<br>- Appropriate authentication configured |
| **Custom connector** | Connect to SAP SOAP services via API Management to integrate with custom SAP REST web services or specialized integration needs. | API Management for SSO and SOAP REST-compatible services | HTTP(S) / REST | - Knowledge of SAP REST API specifications<br>- For SOAP services, expose as REST via API Management<br>- Appropriate authentication configured |
| **Power Automate desktop**| Automate tasks within SAP GUI (RPA) to automate repetitive GUI tasks, screen scraping, or legacy application tasks. |  Power Automate desktop software on client machines | None, UI Automation | - SAP GUI scripting enabled on the SAP server and client |
| **Power BI** | Create reports and dashboards from SAP data and perform business intelligence tasks (for example, data analysis and real-time insights). | SAP HANA ODBC driver,<br> SAP .NET Connector | HANA: ODBC,<br>BW: OLAP BAPI (RFC) | - Appropriate authentication configured |

You need to consider several factors when you select a connector for working with transactional data via the SAP ERP or SAP OData connectors. The decision might depend on the interfaces already available in your SAP system. First, check whether your SAP system exposes RFC/BAPI or OData services. For simplicity, choose the method you're most familiar with. SAP often provides both options for external connectivity.

If your system lacks RFC or OData services for the specific use case, your choice depends on connectivity requirements and what's easier to implement: API Management for OData services or an on-premises gateway for the SAP ERP connector. In general, we recommend that you expose an existing SAP OData service, or develop one if there isn't one, because of its modern architecture and flexibility. See the [SAP Business Accelerator Hub](https://api.sap.com) to check for existing OData services.

To help you implement the best solution for your scenario, the next article in this series provides detailed instructions and links to resources for setting up these connectivity options.

### Design considerations

**Custom connectors and SOAP services**:

Custom connectors in Microsoft Power Platform support REST APIs but don't support SOAP directly. To integrate with SAP SOAP services, you can expose them as RESTful APIs by using Azure API Management or SAP API Management. Alternatively, generate SOAP services from RFCs in SAP and then use API Management to convert them into REST services.

**Power Automate desktop for SAP GUI automation**:

Use the SAP GUI actions available in Power Automate desktop to automate tasks without writing code. Ensure that SAP GUI scripting is enabled on both the SAP server and client.

**Middleware requirements for specific connectors**:

The SAP ERP connector requires both an on-premises data gateway and SAP .NET Connector. For Power BI connections to SAP Business Warehouse, SAP .NET Connector is also required.

**High availability and load balancing**:

For enterprise scenarios, consider setting up the on-premises data gateway in [high-availability clusters to ensure continuous connectivity and load balancing](/data-integration/gateway/service-gateway-high-availability-clusters).

**SAP API Management and SAP Cloud Connector**:

For a more SAP-centric approach, you can use SAP API Management on SAP Business Technology Platform and SAP Cloud Connector. This setup is especially useful if you prefer to manage APIs and connectivity within the SAP ecosystem.

**Azure API Management self-hosted gateway for non-Azure scenarios**:

If you operate in a non-Azure or hybrid environment, consider using the [Azure API Management self-hosted gateway](/azure/api-management/self-hosted-gateway-overview). Deploying the self-hosted gateway closer to your SAP systems can reduce latency and improve performance.

## Considerations for integrating SAP with Microsoft Power Platform

There are several considerations to take into account when you integrate SAP with Microsoft Power Platform. You don't need to fully resolve all of these considerations before you start. Many customers start with pilot projects, which allow them to better understand these considerations in practice and address them more effectively as they progress.

**Business objectives**
  
- _Identify business challenges_: Clearly outline the business processes or challenges that you want to improve or automate through integration.
- _Set measurable goals_: Establish what success looks like in terms of efficiency gains, cost savings, or user experience improvements.

**Current environment**
  
- _Licensing requirements_: Ensure that you have the necessary Microsoft Power Platform licenses for the components that you plan to use (for example, Power Apps, Power Automate, Power BI, Copilot, and Copilot Studio). Consider [trial licenses](https://www.microsoft.com/power-platform/try-free) for pilot projects. All licensing options are outlined in [Licensing overview for Microsoft Power Platform](/power-platform/admin/pricing-billing-skus).
- _Network connectivity_: Identify the location of SAP systems, for example, Azure native or RISE with SAP, other clouds or on-premises, or a combination of multiple locations. Then evaluate your network situation, based on the SAP systems locations, and involve required parties to enable connectivity.

**Security and compliance**
  
- _Authentication mechanisms_: Plan for high-security authentication methods like single sign-on (SSO) via Microsoft Entra ID (formerly Azure Active Directory). See this blog post to get information about the setup: [SAP OData Connector: Single sign-on through Microsoft Azure API Management](https://www.microsoft.com/power-platform/blog/power-apps/announcing-public-preview-of-expanded-single-sign-on-authentication-options-for-sap-connectors/). This post also contains a reference that you can use if you prefer to use the API Management capability of SAP Integration Suite.
- _Data protection_: Ensure compliance with data protection regulations (for example, GDPR and HIPAA) by implementing relevant best practices. See [Compliance and data privacy](/power-platform/admin/wp-compliance-data-privacy) in the Microsoft Power Platform documentation.
- _Data residency_: Consider data residency requirements that might affect where data can be stored or processed. Choose the [location of your Microsoft Power Platform environment](/power-platform/admin/new-datacenter-regions) accordingly.

**Technical readiness**
  
- _Infrastructure capacity_: Assess whether your current infrastructure can support the additional load introduced by the integration. Estimate the anticipated load by considering user activity and reviewing current performance metrics, including SAP EarlyWatch reports. Keep in mind that users might not generate more load. They might perform their tasks in a different way after the integration, so the overall system impact might not change much.

**Governance**
  
- _Policy enforcement_: Establish governance policies for using Microsoft Power Platform to help prevent unauthorized access and changes.
- _Monitoring and auditing_: Implement monitoring solutions to track system performance and user activities.
- _Change management_: Set up separate environments for development, testing, and production to ensure proper change management and stability.

**Skill set and team readiness**
  
- _Training needs_: Identify any training requirements that your team needs to effectively use and manage the Microsoft Power Platform and SAP integration.
- _Stakeholder engagement_: Involve key stakeholders from both IT and business units early in the planning process.

**Testing strategy**
  
- _Quality assurance_: Plan for thorough testing, including unit tests, integration tests, and user acceptance tests.

**Cost considerations**
  
- _Budget planning_: Account for all costs that are associated with licensing, development, infrastructure, and maintenance.
- _Cost optimization_: Explore opportunities to optimize costs, like using existing licenses and resources or choosing cost-effective service tiers.

**Future-proofing**

-  _Flexibility_: Design the integration to be adaptable to changes in business requirements and technology updates.
- _Vendor roadmaps_: Stay informed about updates and roadmap changes from SAP and Microsoft that could affect your integration.

By thoroughly evaluating these factors when you start your integration project, you can mitigate risks, help ensure compliance, and set a strong foundation for a successful integration between SAP and Microsoft Power Platform.

Integrating SAP systems with the Microsoft Power Platform enables you to enhance business processes, automate tasks, and gain valuable insights. By considering factors like business objectives, the current environment, integration options, security, and technical readiness, you can establish a strong foundation for successful integration.

By clearly defining business objectives and setting measurable goals, you can effectively focus your integration efforts. For instance, automating manual data entry to reduce errors and free up staff time, or integrating real-time inventory dashboards to improve decision-making, can lead to significant efficiency gains. Setting specific targets, like decreasing data entry errors by 90% or cutting report generation time from five days to one, doesn't just measure the success of your projects. It also aligns your integration initiatives with tangible business outcomes.

Starting with easy pilot projects can help you achieve success quickly, which allows you to further extend and refine your approach to effectively take advantage of your SAP and Microsoft Power Platform integration.

## Next step

> [!div class="nextstepaction"]
> [Extend your SAP landing zone to support Power Platform](./sap-power-platform-extend-landing-zone.md)