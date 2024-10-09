---
title: SAP and Power Platform architecture workflow
description: Learn about the architecture workflow of SAP and Power Platform, along with security considerations and recommendations.
author: mimergel
ms.author: mimergel
ms.date: 10/08/2024
ms.topic: conceptual
ms.custom: e2e-sap
---

# SAP and Power Platform architecture workflow

This article is part of the "SAP and Power Platform" article series.

- [Extend SAP with the Microsoft Power Platform](./sap-and-powerplatform-fundamental.md)
- [SAP and Power Platform Architecture Workflow](./sap-and-powerplatform-architecture-workflow.md)
- [Extend your SAP Landing Zone to support Power Platform](./sap-and-powerplatform-extend-landing-zone.md)

## Architecture

The following architecture illustrates a comprehensive integration scenario that encompasses all possible integration options. It's designed to accommodate SAP systems operating on-premises, on Azure (both native and RISE), or on other cloud platforms.

:::image type="complex" source="./media/sap-powerplatform-architecture.svg" border="false" alt-text="Diagram that shows architecture diagram of Power Platform Integration with a typical SAP landing zone." lightbox="./media/sap-powerplatform-architecture.svg":::
   On the left side of the image is box label "Power Platform Environment - Cloud." It contains Power Pages, Power App, Power Automate, and Copilot Studio, and Power BI Service. Power Automate has arrows coming out of it to SAP ERP Connector, OData Connector, and Custom Connector all in the same box. To the right of that box is Microsoft Entra, Firewall, and API Gateway. Going through the firewall is an arrow from SAP ERP Connector and Power BI Service. Going through the API Gateway is an arrow from OData Connector and Custom Connector. To the right of the Firewall and A.P.I. Gateway is a box labeled "S.A.P. Environment on on-premises data gateway - On-premises/IaaS." In that box is an On-premises data gateway icon with arrows pointing at it from Firewall and an arrow pointing to SAP .NET Connector. That Box also contains OData API and REST/SOAP API icons, with arrows coming from API Gateway and going into the SAP logo. Also going into the SAP logo is a HANA SQL Port icon. A final box sits above those icons, and that box is labeled "Client Applications." A laptop, mobile device, Power Automate Desktop, SAP GUI, Power BI Desktop all are shown. Power BI Desktop shows an arrow to two additional icons in that box called SAP .NET Connector and SAP HANA ODBC Driver. Those two icons both connect into the SAP Icon through a DIAG & RFC PORT icon and the HANA SQL Port icon respectively.
:::image-end:::

_Download a [Visio file](https://github.com/microsoft/CloudAdoptionFramework/raw/main/ready/sap-powerplatform-architecture.vsdx) of this architecture._

## Connectivity options and when to use them

To integrate SAP with the Microsoft Power Platform effectively, select the appropriate connectivity option based on your specific use cases, integration requirements, and technical constraints. The following table provides a comprehensive overview of the available connectors, their use cases, requirements, communication protocols, and typical scenarios.

### Connectivity overview table

| **Connectivity** | **Scenarios** | **Middleware, software, driver requirements** | **Communication Protocol** | **SAP Requirements** |
|---|---|---|---|---|
| **SAP ERP Connector** | Invoke SAP RFC or BAPI functions.<br>Example: reading, creating, updating, approving sales orders. | On-premises data gateway,<br> SAP .NET Connector | RFC | - SAP system exposing RFC/BAPI interfaces<br>- Appropriate authentication is configured |
| **SAP OData Connector** | Interact with SAP data via OData services.<br>Example: reading or changing product information. | API Management for SSO | HTTP(S) / OData | - SAP system with OData services enabled<br>- Appropriate authentication is configured |
| **Custom Connector** | Connect to SAP SOAP services via API Management for integrating with custom SAP REST web services or specialized/unique integration needs. | API Management for SSO and SOAP "restified" services | HTTP(S) / REST | - Knowledge of SAP REST API specifications<br>- For SOAP services, expose as REST via API Management<br>- Appropriate authentication is configured |
| **Power Automate Desktop**| Automate tasks within SAP GUI (RPA) for automating repetitive GUI tasks, screen scraping, or legacy application automation. | Installed Power Automate Desktop software on client machines | None, UI Automation | - SAP GUI scripting enabled on SAP server and client |
| **Power BI** | Create reports and dashboards with SAP data, visualizing data in reports and performing business intelligence tasks (for example, data analysis, real-time insights). | SAP HANA ODBC driver,<br> SAP .NET Connector | HANA: ODBC,<br>BW: OLAP BAPI (RFC) | - Appropriate authentication is configured |

### Selecting the right connectivity

When deciding which connectivity to use, consider the following factors:

- **SAP System capabilities**:
  - **Connectivity preference**: Does your SAP system expose RFC/BAPI, OData services, SOAP services, or support direct connections for reporting?
  - **Interfaces availability**: Are additional actions required to enabled and expose these services in your SAP environment?

- **Integration Requirements**:
  - **Type of operations**: Do you need to perform real-time data operations, data analysis, or task automation?
  - **Focus area**: Is the integration focused on data retrieval, data updates, reporting, or automating user interface tasks?

- **Technical constraints**:
  - **Network restrictions**: Are there network restrictions (for example, firewalls, proxies) that prevent connectivity? Who is required to make necessary changes and where have changes to be implemented to allow connectivity?
  - **Middleware infrastructure**: Do you have or can provision the infrastructure to support middleware components like the on-premises data gateway?
  - **Client requirements**: For Power BI and Power Automate Desktop, can you install necessary drivers and software on client machines?

- **Development Resources**:
  - **Development effort**: Do you have the time and expertise to create the scenarios or is a partner needed to help with the implementation and integration?
  - **Connectivity preference**: Most SAP services can be exposed in multiple ways as RFC, OData, or SOAP services, allowing you to choose the method that best fits your expertise and what's easier for you to handle in SAP and the Power Platform.

- **Security and Compliance**:
  - **Authentication methods**: Can you implement the required authentication methods (for example, SSO with Microsoft Entra ID)?
  - **Data protection**: Does the connector support your organization's data protection policies and compliance requirements?

### Design considerations

- **Custom connectors and SOAP Services**:
  - Custom connectors in Power Platform support REST APIs but don't support SOAP directly.
  - To integrate with SAP SOAP services, you can expose them as RESTful APIs using Azure API Management or SAP API Management.
  - Alternatively, generate SOAP services from RFCs in SAP and then use API Management to "restify" them.

- **Power Automate Desktop for SAP GUI Automation**:
  - Utilize the new SAP GUI actions available in Power Automate Desktop to automate tasks without writing code.
  - Ensure that SAP GUI scripting is enabled on both the SAP server and client-side.

- **Middleware Requirements for specific connectors**:
  - The **SAP ERP Connector** requires both the on-premises data gateway and the SAP .NET Connector.
  - For **Power BI** connections to SAP BW, the SAP .NET Connector is also required.

- **High Availability and load balancing**:
  - For enterprise scenarios, consider setting up the on-premises data gateway in high-availability clusters to ensure continuous connectivity and load balancing.
  - Refer to [Manage on-premises data gateway high-availability clusters and load balancing](/data-integration/gateway/service-gateway-high-availability-clusters) for guidance.

- **SAP API Management and SAP Cloud Connector**:
  - For a more SAP-centric approach, you can use SAP API Management on SAP Business Technology Platform (BTP) and the SAP Cloud Connector.
  - This setup is especially useful if you prefer to manage APIs and connectivity within the SAP ecosystem.

- **APIM Self-Hosted Gateway for Non-Azure Scenarios**:
  - If you're operating in a non-Azure or hybrid environment, consider using the [Azure API Management self-hosted gateway](/azure/api-management/self-hosted-gateway-overview).
  - Deploying the self-hosted gateway closer to your SAP systems can reduce latency and improve performance.

## Integration considerations for SAP with Microsoft Power Platform

When building integrations between SAP and the Microsoft Power Platform, it's crucial to carefully consider several key aspects to ensure a successful and secure implementation. You don't need to have all these considerations fully resolved before beginning. Many customers start with pilot projects, which allow them to better understand these topics in practice and address them more effectively as they progress.

- **Define business objectives**
  - _Identify business challenges_: Clearly outline the business processes or challenges you aim to enhance or automate through integration.
  - _Set measurable goals_: Establish what success looks like in terms of efficiency gains, cost savings, or user experience improvements.

- **Assess current environment**
  - _Licensing requirements_: Ensure you have the necessary Power Platform licenses for the components you plan to use (for example, Power Apps, Power Automate, Power BI, Copilot Studio). You can consider [trial licenses](https://www.microsoft.com/power-platform/try-free) for piloting.
  - _SAP system location_: Identify the location of the SAP systems, for example, Azure native or SAP RISE, other clouds or on-premises.
  - _Network infrastructure_: Evaluate your network setup, including firewalls, proxies, and VPNs, to ensure connectivity between the Power Platform and your SAP systems.

- **Understand integration options**
  - _Connectors_: Choose the appropriate connectors based on your integration needs:
    - _Power BI connections_ directly via ODBC or via Power Query SAP HANA database connector
    - _SAP ERP connector_ for RFC and BAPI functions.
    - _SAP OData connector_ for OData APIs.
    - _Custom connectors_ for REST or SOAP APIs.
  - _Middleware requirements_: Determine required middleware components like the on-premises data gateway and Azure API Management for single sign-on (SSO).

- **Security and compliance**
  - _Authentication mechanisms_: Plan for secure authentication methods such as single sign-on (SSO) using Microsoft Entra ID (formerly Azure Active Directory).
  - _Data protection_: Ensure compliance with data protection regulations (for example, GDPR, HIPAA) by implementing encryption and data governance policies.
  - _Data residency_: Consider data residency requirements that might affect where data can be stored or processed.
  - _Network security_: Design your network connectivity between the SAP systems and the Power Platform.
  - _Access control_: Apply role-based access control (RBAC) and the principle of least privilege to restrict access to critical systems and data.

- **Technical readiness**
  - System readiness: Ensure your SAP system is prepared for integration by verifying that Remote Function Call (RFC) enabled function modules are available, OData or SOAP services are exposed, and network access is configured to allow access by the Power Platform connectors.
  - Infrastructure capacity: Assess whether your current infrastructure can handle additional load from the integration.
  - Software requirements: Install necessary software like the SAP .NET Connector and ensure that the on-premises data gateway meets system requirements.

- **Design and architecture planning**
  - _Integration architecture_: Plan your integration architecture to minimize latency and maximize performance.
  - _Scalability and availability_: Design for scalability to accommodate future growth and ensure high availability.
  - _Resource organization_: Align with your organization's standards for naming conventions, tagging, and resource grouping.

- **Governance**
  - _Policy enforcement_: Establish governance policies for using the Power Platform to prevent unauthorized access and changes.
  - _Monitoring and auditing_: Implement monitoring solutions to track system performance and user activities.
  - _Change management_: Develop a change management process to handle updates and modifications to the integration.

- **Skill set and team readiness**
  - _Training needs_: Identify any training requirements for your team to effectively use and manage the Power Platform and SAP integration.
  - _Stakeholder engagement_: Involve key stakeholders from both IT and business units early in the planning process.

- **Testing strategy**
  - _Development and testing environments_: Set up separate environments for development, testing, and production to ensure stability.
  - _Quality assurance (QA)_: Plan for thorough testing, including unit tests, integration tests, and user acceptance tests.

- **Cost considerations**
  - _Budget planning_: Account for all costs associated with licensing, development, infrastructure, and maintenance.
  - _Cost optimization_: Explore opportunities to optimize costs, such as using existing resources or choosing cost-effective service tiers.

- **Future-proofing**
  - _Flexibility_: Design the integration to be adaptable to future changes in business requirements or technology updates.
  - _Vendor roadmaps_: Stay informed about updates and roadmap changes from SAP and Microsoft that could affect your integration.

By thoroughly evaluating these factors when starting your integration project, you can mitigate risks, ensure compliance, and set a strong foundation for a successful integration between SAP and the Microsoft Power Platform.

Integrating SAP systems with the Microsoft Power Platform enables you to enhance business processes, automate tasks, and gain valuable insights. By considering factors like business objectives, current environment, integration options, security, and technical readiness, you can establish a strong foundation for successful integration.

By clearly defining business objectives and setting measurable goals, you can effectively focus your integration efforts between SAP and the Microsoft Power Platform. For instance, automating manual data entry to reduce errors and free up staff time, or integrating real-time inventory dashboards to improve decision-making, can lead to significant efficiency gains. Setting specific targets—like decreasing data entry errors by 90% or cutting report generation time from five days to one—not only measures the success of your projects but also aligns your integration initiatives with tangible business outcomes.

Starting with easy pilot projects can help you achieve quick wins, allowing you to further extend and refine your approach to effectively harness the potential of SAP and Power Platform integration.

## Next steps

- [Extend your SAP Landing Zone to support Power Platform](./sap-and-powerplatform-extend-landing-zone.md)
