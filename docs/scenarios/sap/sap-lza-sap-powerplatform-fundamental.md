---
title: SAP and Power Platform Fundamentals
description: Learn about the fundamentals of SAP and Power Platform.
author: mimergel
ms.author: mimergel
ms.date: 02/09/2024
ms.topic: conceptual
ms.custom: think-tank, e2e-sap
---

# SAP and Power Platform Fundamentals

This article is part of the "SAP and Power Platform" article series.
	
- [SAP and Power Platform fundamentals](./sap-lza-sap-powerplatform-fundamental.md)
- [SAP and Power Platform Architecture Workflow](./sap-lza-sap-powerplatform-architecture-workflow.md)


This article is Part 1 of the SAP and Power Platform Articles. 

## Introduction to Microsoft Power Platform

The Microsoft Power Platform is a suite of business intelligence, app development, and app connectivity software applications. It’s designed to empower everyone in an organization with an intuitive, collaborative, and extensible platform of low-code tools that makes it easy to create efficient and flexible solutions. Businesses can keep the SAP core clean of code changes by handling additional functionality externally. As a result, businesses can respond quickly and efficiently to evolving requirements, all while maintaining the integrity and stability of the SAP core.
The following Power Platform components are especially helpful in combination with SAP:

- Power BI: helps you make informed, confident business decisions based on your SAP data by putting data-driven insights into everyone’s hands.
- Power Apps: a low-code solution for building business applications that can interact with SAP.
- Power Automate: helps create automated workflows between, SAP, other apps and services to synchronize files, get notifications, collect data, and more.
- Microsoft Copilot Studio a low-code comprehensive conversational AI solution that unlocks new chatbot capabilities: connect copilot to your SAP data using pre-built or custom plugins and GPTs. This is also an evolution of Power Virtual Agent. Power Virtual Agents capabilities and features are now part of Microsoft Copilot Studio

These components can be used individually or together, and they integrate with SAP, Microsoft 365, Dynamics 365, Azure and hundreds of other apps to build end-to-end business solutions.

## SAP analytics with Power BI
Power BI offers versatile integration options for SAP Business Warehouse and SAP HANA, catering to different organizational needs and security considerations.

-**Direct Connection**: For real-time analytics, Power BI can directly connect to SAP HANA and SAP Business Warehouse. This direct integration allows for immediate access and analysis of operational data, supporting high-speed analytics and in-depth reporting. It's particularly useful for dynamic data visualization and timely decision-making. It also supports SSO which means all the permissions, roles that are in place on the SAP side are still considered. Please see details.

  - **SAP HANA** - [Use Kerberos for single sign-on (SSO) to SAP HANA - Power BI](/power-bi/connect-data/service-gateway-sso-kerberos-sap-hana)
  - **SAP BW** - [Use Kerberos single sign-on for SSO to SAP BW using CommonCryptoLib (sapcrypto.dll) - Power BI](/power-bi/connect-data/service-gateway-sso-kerberos-sap-bw-commoncryptolib)
  - **SAP BW** - [Use Kerberos for single sign-on (SSO) to SAP BW using gx64krb5 - Power BI](/power-bi/connect-data/service-gateway-sso-kerberos-sap-bw-gx64krb)

- Connect to a SAP HANA database - [Power Query SAP HANA database connector](/power-query/connectors/sap-hana/overview)

- Connect to a SAP BW Application Server - [Power Query SAP Business Warehouse Application Server connector](/power-query/connectors/sap-bw/application-setup-and-connect)

- **Data Extraction for Sensitive Environments** : For organizations cautious about direct connections to production environments, Power BI supports an alternative approach. Data can be extracted from SAP systems and then Power BI connects to this extracted dataset. This method ensures the protection of production environments and allows for analytics on a static copy of the data. The extraction can be scheduled to keep the Power BI dataset up to date without impacting the SAP systems' performance. 

This flexibility in connecting Power BI with SAP systems—either through direct access for real-time insights or via data extraction for a more controlled approach—provides a tailored solution for effective SAP data analytics.

## Custom App Development with Power Apps
Power Apps is a suite of apps, services, and connectors that allows you to create custom business apps without coding. There are three types of apps you can create with Power Apps:

- **Canvas Apps**: These apps start with a blank screen, like an artist’s canvas, and the creator manually lays out each screen. This gives the creator complete control over the placement of each element on the canvas. Canvas apps are good for scenarios where the user is expecting a customized user experience.

- **Model-Driven Apps**: These apps require a Microsoft Dataverse database. They’re built on top of the data modelled in that database environment. Views and detail screens for model-driven apps are based on the data structure. Model-driven apps are good for scenarios where the business logic is complex.

- **Power Pages**: Enable teams to create professional websites with no-code faster and integrate with other Power Platform components to make use of SAP data and functionality.

Each type of app has its own strengths and is suited to different scenarios, so the type of app you choose to create will depend on your specific needs.

All types of Power Apps can call Power Automate Flows from where the connection to SAP is made.

## Workflow Automation with Power Automate
A Power Automate flow is a type of workflow that can automatically perform tasks such as sending notifications, copying files, collecting data, and more. These flows are designed to help users streamline routine tasks, automate processes, and improve collaboration and communication across their organization.
There are three types of flows in Power Automate:

- **Cloud Flows**: These are created when you want your automation to be triggered either automatically, instantly, or via a schedule. These are API based integrations. 

- **Desktop Flows**: These are used to automate tasks on the Web or the desktop and enables SAP users to automate mundane, rules-based tasks on their desktop in combination with their SAP Application Interfaces like SAP Gui or SAP Fiori.

Desktop flows broaden the existing robotic process automation (RPA) capabilities in Power Automate and enable you to automate all repetitive desktop processes. Automating is quicker and easier than ever with the new intuitive Power Automate desktop flow designer using the prebuilt drag-and-drop actions or recording your own desktop flows to run later.

- **Business Process Flows**: These provide a guide for people to get work done. They provide a streamlined user experience that leads people through the processes their organization has defined for interactions that need to be advanced to a conclusion of some kind.
Each type of flow serves a different purpose and can be used depending on the specific needs of the task.


## Enhancing User Engagement with Microsoft Copilot Studio
Copilot Studio offers a significant opportunity for customers to enhance the SAP user experience. These AI-driven copilots can be seamlessly integrated with SAP systems, providing a more interactive and user-friendly interface.

- **Automated Customer Support**: Copilot Studio can handle routine inquiries and support tickets, freeing up human resources for more complex tasks. This leads to faster resolution times and improved customer satisfaction.

-	**Self-Service Capabilities**: Users can interact with the copilots to perform simple tasks like data retrieval, status updates, and transaction initiations directly within the SAP system, fostering a sense of autonomy and efficiency.

-	**Streamlined Processes**: The integration of copilots with SAP automates various workflows, such as approvals, data entry, and report generation. This automation reduces manual errors and accelerates business processes.

- **Personalized User Interactions**: Copilot Studio can be programmed to provide personalized experiences based on user roles and preferences, making the SAP system more intuitive and user-friendly.

- **24/7 Availability**: Unlike human agents, copilots are available around the clock, offering consistent support and ensuring business continuity outside regular working hours. 


By leveraging Copilot Studio, customers can significantly enhance the SAP user experience, making it more efficient, user-friendly, and responsive to their business needs.

## Next steps

- [SAP and Power Platform Architecture Workflow](./sap-lza-sap-powerplatform-architecture-workflow.md)
