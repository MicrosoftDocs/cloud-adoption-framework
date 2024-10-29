---
title: SAP and Power Platform Fundamentals
description: Learn how to extend SAP with Microsoft Power Platform to create better end-to-end business solutions.
author: mimergel
ms.author: mimergel
ms.date: 10/30/2024
ms.topic: conceptual
ms.custom: e2e-sap
---

# Extend SAP by using Microsoft Power Platform

This article is part of the **SAP and Power Platform** article series:

- Extend SAP by using the Microsoft Power Platform
- [SAP and Power Platform architecture workflow](./sap-power-platform-architecture-workflow.md)
- [Extend your SAP landing zone to support Power Platform](./sap-power-platform-extend-landing-zone.md)

## Microsoft Power Platform components

Core changes to SAP necessitate investments in care and maintenance to ensure that you maintain forward compatibility for future platform updates. The Microsoft Power Platform can help you extend SAP with extra functionality without changing the core SAP system.

This article provides an introduction to enhancing your SAP systems by using these Microsoft Power Platform components:

- Power Apps
- Power Automate
- Microsoft Copilot Studio
- Power Pages
- Power BI

You can build end-to-end-business solutions by using these components individually or together and integrate them with SAP, Microsoft 365, Dynamics 365, Azure, or other apps. The following image illustrates the main components of the integrated, low-code development suite. It enables businesses to enhance their SAP landscapes by building custom applications, automating processes, integrating AI, and getting actionable insights, all with a minimal need for extensive coding expertise.

![Diagram that describes the components of Microsoft Power Platform.](./media/power-platform-overview.svg)

The following underlying features provide essential capabilities for enabling seamless SAP integration.

- **Data connectors**: Out-of-the-box SAP connectors for accessing and interacting with SAP data without complex middleware. These connectors enable the smooth integration of SAP data into custom applications, automated workflows, or analytics dashboards.

- **AI Builder**: Intelligent automation for extracting information from documents, images, or text, or for adding predictive analytics into your SAP workflows. You can also add generative AI capabilities into SAP processes, like demand forecasting or intelligent inventory management, without needing in-depth AI expertise.

- **Microsoft Dataverse**: An optional additional data repository where you can store and manage SAP and other business data. It allows SAP data to be buffered for offline work or combined with non-SAP data to create a unified data source for deeper insights and broader functionality.

- **Power Fx**: The low-code language that enables app development across the platform. You can use it to easily create custom logic in workflows that interact with SAP data.

- **Managed Environments**: A suite of capabilities that facilitates governance, compliance, and scalability for Microsoft Power Platform solutions that are integrated with SAP systems. We recommend that you adopt a structured approach by implementing development, test, and production environments, as suggested by best practices for the SAP landscape.

## Extend SAP application development with Power Apps or Power Pages

Power Apps is a suite of apps, services, and connectors that allows you to create custom business apps without coding. You can rapidly develop web and mobile applications that extend SAP functionality. With prebuilt connectors for SAP, Power Apps allows you to build custom front ends or lightweight applications that interact directly with SAP data. This can streamline workflows, enable mobile access, and improve user experiences without modifying the core SAP system. 

You can create three types of apps by using Power Apps:

- **Canvas apps.** These apps start with a blank screen. You manually lay out each screen. This gives you complete control over the placement of each element on the canvas. Canvas apps are good for scenarios in which the user expects a customized experience.

- **Model-driven apps.** For complex business logic, model-driven apps might be a good fit. These apps require a [Dataverse database](/power-apps/maker/data-platform/data-platform-intro), the database of Microsoft Power Platform. Model-driven apps are built on top of the data modeled in that database environment. Views and detail screens for model-driven apps are based on the data structure. The SAP data resides only in the SAP system database. In certain use cases, Dataverse can be used as a temporary caching area for mobile workers when they have no connectivity to the back-end SAP system.

- **Power Pages.** You can use Power Pages to create professional internal or external websites with a no-code approach. You can integrate them with other Microsoft Power Platform components to make use of SAP data and functionality. Doing so allows you to engage customers, partners, or employees by offering a user-friendly web interface for interacting with SAP systems. For example, you could create an interface for submitting requests or viewing real-time data insights.

All of these apps can call Power Automate flows from the location where the connection to SAP is made.

## Automate SAP workflows by using Power Automate

A Power Automate flow is a type of workflow that can automatically perform tasks like sending notifications, copying files, and collecting data. These flows are designed to help you streamline routine tasks, automate processes, and improve collaboration and communication across your organization.

Power Automate provides these two types of flows:

- **Cloud flows.** Use cloud flows when you want your automation to be triggered automatically, instantly, or via a schedule. These flows are API-based integrations that use SAP ERP, SAP OData, HTML, and other connectors. For example, you can use these flows to read or update objects in SAP, like orders, products, or stock information.

- **Desktop flows.** You can use desktop flows to automate tasks on the web or the desktop. It enables you to automate mundane, rule-based tasks when you use it with SAP application interfaces like SAP GUI or SAP Fiori. For example, you can automate repetitive tasks like entering customer or finance data from email or Excel into SAP.

  Desktop flows broaden the existing robotic process automation (RPA) capabilities in Power Automate and enable you to automate all repetitive desktop processes. You create automated processes by using the Power Automate desktop flow designer. You can use prebuilt drag-and-drop actions or record desktop flows.

## Create intelligent SAP solutions with Copilot Studio

You can use Copilot Studio to enhance your SAP users' experience. You can integrate AI-driven copilots with SAP systems to provide a more interactive and user-friendly interface.

- **Automated customer support**: Copilot Studio can handle routine inquiries and support tickets, freeing up human resources for more complex tasks. This approach leads to faster resolution times and improved customer satisfaction.

- **Self-service capabilities**: Users can interact with copilots to perform simple tasks like data retrieval, status updates, and transaction initiations directly within the SAP system. These capabilities foster a sense of autonomy and efficiency.

- **Streamlined processes**: The integration of copilots with SAP automates various workflows, like approvals, data entry, and report generation. This automation can reduce manual errors and accelerate business processes.

- **Personalized user interactions**: You can program Copilot Studio to provide personalized experiences based on user roles and preferences. Doing so makes the SAP system more intuitive and user-friendly.

- **Continuous availability**: Unlike human agents, copilots are available all day, every day to provide consistent support and ensure business continuity outside regular working hours.

By using Copilot Studio, you can significantly enhance the SAP user experience, making it more efficient, user-friendly, and responsive to business needs.

## Enhance business intelligence with Power BI and SAP connectivity

Power BI provides versatile integration options for SAP Business Warehouse and SAP HANA.

- **Direct connection**: Power BI can connect directly to [SAP HANA](/power-query/connectors/sap-hana/overview) and [SAP Business Warehouse (BW)](/power-query/connectors/sap-bw/application-setup-and-connect) to provide real-time analytics, dynamic data visualization, and timely decision-making. This direct integration enables immediate access and analysis of operational data and supports high-speed analytics and in-depth reporting. It also supports single sign-on (SSO) to help ensure that SAP access roles and permissions are respected.
  - [Use Kerberos for SSO to SAP HANA](/power-bi/connect-data/service-gateway-sso-kerberos-sap-hana)
  - [Use Kerberos for SSO to SAP BW by using CommonCryptoLib (sapcrypto.dll)](/power-bi/connect-data/service-gateway-sso-kerberos-sap-bw-commoncryptolib)
  - [Use Kerberos for SSO to SAP BW by using gx64krb5](/power-bi/connect-data/service-gateway-sso-kerberos-sap-bw-gx64krb)

- **Data extraction for sensitive environments**: For organizations that are cautious about direct connections to production environments, Power BI supports an alternative approach. You can extract data from SAP systems and then use Power BI to connect to the extracted dataset. This method provides protection for production environments and enables analytics on a static copy of the data. You should schedule the extraction to keep the Power BI dataset up to date without affecting the SAP systems' performance.

This flexibility in connecting Power BI with SAP systems, either through direct access for real-time insights or via data extraction for a more controlled approach, provides a tailored solution for effective SAP data analytics.

## Next step

- [SAP and Power Platform architecture workflow](./sap-power-platform-architecture-workflow.md)