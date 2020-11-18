---
title: "Enterprise-Scale security, governance, and compliance for SAP"
description: Describe how this enterprise-scale scenario can improve security, governance, and compliance of SAP
author: deepakonics
ms.author: brblanch
ms.date: 11/11/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

# Security, governance, and compliance for Enterprise-Scale scenario

## Introduction

This document is for Enterprise Scale SAP on Azure Security, compliance and governance design guidance.

## Vision

SAP is the common technology used in many of the most crucial workloads in organizations today and therefore special attention needs to be placed in planning the architecture ensuring that the architecture is both robust and secure.

The vision for SAP Enterprise Zone Security, compliance and governance is to give the organizations tools and processes to prevent risk and make effective decisions. It defines the roles and responsibilities to ensure that everyone knows what is expected from them.

It’s important to understand the shared responsibility model between you as a customer and Microsoft. The division of responsibility is dependent on the cloud model used - SaaS, PaaS, or IaaS. As a customer, you are always responsible for your data, endpoints, account/access management, irrespective of the chosen cloud deployment.

This is shown in the picture below.

![Responsibility Zones](media\SGC_ResponsIbilityZones.jpg)

Picture 1: Cloud Responsibility Model

## Goals

The goal of this document is to document some of the design criterion for SAP on Azure Deployment. This will be done by listing these criteria as design Recommendations (Best Practices) and design considerations (Guidance as per the input received from the field) across the security, compliance and governance area.
Cloud solutions were initially designed to host single, relatively isolated applications in the public spectrum. This approach worked well for a few years. As the benefits of cloud solutions became clear, multiple large-scale workloads (e.g. SAP on Azure) were hosted on the cloud. Addressing security, reliability, performance, and cost concerns of deployments in one or more regions became vital throughout the lifecycle of cloud service.

Please follow SAP specific guidelines for SAP application security, compliance, and governance.

## Scope

Generic guidance related to Azure Platform Security, Compliance and Governance is available at [https://docs.microsoft.com/azure/security/fundamentals/overview](/azure/security/fundamentals/overview)

The following are recommendations for Enterprise Scale Landing Zone (ESLZ) SAP on Azure in this section.

### References

- [https://azure.microsoft.com/blog/best-practices-in-migrating-sap-applications-to-azure-part-1/](https://azure.microsoft.com/blog/best-practices-in-migrating-sap-applications-to-azure-part-1/)
- [https://docs.microsoft.com/azure/virtual-machines/workloads/sap/planning-guide](/azure/virtual-machines/workloads/sap/planning-guide)

As you consider and evaluate public cloud services, it’s critical to understand the shared responsibility model and which security tasks are handled by the cloud provider and which tasks are handled by you. The workload responsibilities vary depending on whether the workload is hosted on Software as a Service (SaaS), Platform as a Service (PaaS), Infrastructure as a Service (IaaS), or in an on-premises datacenter. Please find more details about shared responsibility model at https://docs.microsoft.com/azure/security/fundamentals/shared-responsibility

### Design Recommendations

- Enable [Azure Security Center](/azure/security-center/security-center-introduction) (ASC) Standard for SAP on Azure subscriptions. Customers deploy their Cloud architecture patterns across multiple subscriptions following Hub- Spoke topology and hence it’s important to get have a holistic view of entire security posture with Azure Security Center. In the example of cloud deployment diagram below, the red box highlights a security gap. The yellow box shows an opportunity to optimize network virtual appliances across workloads.

   Azure Security Center helps customers to strengthens the security posture of their data centres, and provides advanced threat protection across the hybrid workloads in the cloud - whether they're in Azure or not - as well as on premises.
- ASC helps to pull all -up Security Posture for various SAP on Azure Subscriptions, Resource Security Hygiene across SAP VM's, Disk and applications as well. This further gets enhanced by Threat protection and delegating SAP admin /custom role with [Just in Time access](/azure/security-center/just-in-time-explained). However please make sure Make sure that the SAP database servers are excluded from any policy that may install endpoint protection.

   ![Azure Security Center](media\SGC_ASC.jpg)

   Please find Azure Security Center Dashboard view below for reference:-

   ![Azure Security Center Dashboard](media\SGC_ASC_View.jpg)

- Operating System Hardening – [Azure Update Manager](/azure/automation/update-management/update-mgmt-overview). Security is a shared responsibility between Microsoft and you as a customer where your customer specific security controls need to be applied to the operating system, database, and the SAP application layer. For example, you need to ensure the operating system is hardened to eradicate vulnerabilities which could lead to attacks on the SAP database. To build end to end orchestration, you can configure to send notifications to your Devops/ Git Repo as work items or issues.

   A few additional checks ensure safe base installation.

  1. Check the integrity of the system files on a regular basis.
  2. Restrict access to the operating system.
  3. Restrict physical access to the server.
  4. Protect access to the server at the network level.
- Security for data in rest: - Data at rest includes information that resides in persistent storage on physical media, in any digital format. The media can include files on magnetic or optical media, archived data, and data backups. Microsoft Azure offers a variety of data storage solutions to meet different needs, including file, disk, blob, and table storage and there are few encryptions which is available by default and on top of it customer have more options to configure the same. Server Side Encryption is recommended for SAP on Azure VM estate. Please find more details at [Microsoft Azure Data Encryption-at-Rest](/azure/security/fundamentals/encryption-atrest) and  https://docs.microsoft.com/azure/security/fundamentals/encryption-overview
- For data in transit/in-flight Azure offers many mechanisms for keeping data private as it moves from one location to another. All data in transit, either exchanged with remote components or internal, can be protected by methods such as encryption.From Security for Data in Transit/In-flight perspective Microsoft provides a number of options that can be utilized by customers for securing data in transit internally within the Azure network and externally across the Internet to the end user. These include communication through Virtual Private Networks (utilizing IPsec/IKE encryption), Transport Layer Security (TLS) 1.2 or later (via Azure components such as Application Gateway or Azure Front Door), protocols directly on the Azure virtual machines (such as Windows IPsec or SMB), and more.
- Additionally, "encryption by default" using MACsec (an IEEE standard at the data-link layer) is enabled for all Azure traffic travelling between Azure datacentres to ensure confidentiality and integrity of customer data. Please find more details at [Protection of customer data in Azure](/azure/security/fundamentals/protection-customer-data) 
- Isolation/Restriction of Network services and Protocols: - The recommended network architecture of Hub and Spoke can further be secured by using various Azure security mechanisms for tighter control.The SAP application and database servers are all isolated from either internet or even to the on-premises network and Instead all traffic to-and-from on-premises must traverse through to the hub which VNet peered to a spoke. This guarantees network isolation for the SAP solution on Azure from the public internet. We can monitor and filter traffic using Azure Monitor, NSG and ASG. This guarantees network isolation for the SAP solution on Azure from the public internet. For more advanced network security measures, a [network DMZ](/azure/architecture/reference-architectures/dmz/secure-vnet-hybrid) – “[Implement a DMZ between Azure and your on-premises datacentre](/azure/architecture/reference-architectures/dmz/secure-vnet-hybrid)”, you can also use any of the marketplace available NVA or [Azure Firewall](/azure/firewall/overview).

   To understand it further, please look at the architecture below that depicts how to administer an Azure virtual network topology, isolation, restriction of network services and protocols through the concept of [Azure Network Security Groups](/azure/virtual-network/security-overview). This network security would need to comply with security policy requirements that your organization dictates.

   ![Network Security](media\SGC_Network_Security.jpg)

   Source Microsoft and [https://blogs.sap.com/2019/07/21/sap-security-operations-on-azure/](https://blogs.sap.com/2019/07/21/sap-security-operations-on-azure/)

- Azure Storage/ Operating System / Database Security: - Customers will have the option to upload their own VM and Database Images to Azure or use images from the Azure Marketplace. However, all these images are generic in nature and hence need tightened security controls as per application and organization requirements. Customers usually looks at CIS standards at [https://www.cisecurity.org/cybersecurity-best-practices/](https://www.cisecurity.org/cybersecurity-best-practices/) . The recommendations are -
  - Server-side encryption (SSE): protects your data and helps you meet your organizational security and compliance commitments. SSE automatically encrypts your data stored on Azure managed disks (OS and data disks) at rest by default when persisting it to the cloud. Data in Azure managed disks is encrypted transparently using 256-bit [AES encryption](https://en.wikipedia.org/wiki/Advanced_Encryption_Standard), one of the strongest block ciphers available, and is FIPS 140-2 complaint. For more information about the cryptographic modules underlying Azure managed disks, see [Cryptography API: Next Generation](/windows/desktop/seccng/cng-portal) . Server-side encryption does not impact on the performance of managed disks and there is no additional cost.
  - Azure Storage encryption for data at rest: Azure Storage automatically encrypts your data when it is persisted to the cloud. Azure Storage encryption protects your data and to help you to meet your organizational security and compliance commitments. AZURE Storage encryption is enabled for all storage accounts, including both Resource Manager and classic storage accounts. Azure Storage encryption cannot be disabled. Because your data is secured by default, you don't need to modify your code or applications to take advantage of Azure Storage encryption.
  - Database Encryption: For Databases, Microsoft recommends using the SAP HANA native encryption technology. Likewise, if you are using SQL Database, [TDE (Transparent Data Encryption)](/sql/relational-databases/security/encryption/transparent-data-encryption) should be enabled.
  - Azure Key Vault: We recommend using Azure Key vault for Non-Hana Windows and Non-Windows OSes to control and manage the disk encryption keys and secrets. It has capabilities in provisioning and managing SSL/TLS (Secure Sockets Layer/Transport Layer Security) certificates. The secrets can also be protected by HSM (Hardware Security Modules. SAP HANA is not supported with Azure Key Vault and hence alternate methods to be used e.g. SAP ABAP, SSH Keys etc.
  - Secure Authentication: - Single-sign-on (SSO) provides the foundation for integrating SAP and Microsoft products, and for years Kerberos tokens from Microsoft Active Directory have been enabling this capability for both SAP GUI and web-browser based applications when combined with third party security products. When a user logs onto their workstation and successfully authenticates against Microsoft Active Directory they are issued a Kerberos token. The Kerberos token can then be used by a 3rd party security product to handle the authentication to the SAP application without the user having to re-authenticate. Additionally, data in transit from the users front-end towards the SAP application can also be encrypted by integrating the security product with secure network communications (SNC) for DIAG (SAP GUI), RFC and SPNEGO for HTTPS. Azure Active Directory (Azure AD) with SAML 2.0 can also be used to provide SSO to a range of SAP applications and platforms such as SAP NetWeaver, SAP HANA and the SAP Cloud Platform.
- Security Monitoring and Management: Azure Monitor for SAP Solutions is an Azure-native monitoring product for customers, running their SAP landscapes on Azure. The product works with both SAP on Azure Virtual Machines and SAP on Azure Large Instances. With Azure Monitor for SAP Solutions, customers can collect telemetry data from Azure infrastructure and databases in one central location and visually correlate telemetry data for faster troubleshooting. The Recommendations are-
  - Azure Monitor for SAP Solutions is an Azure-native monitoring product for customers, running their SAP landscapes on Azure. The product works with both [SAP on Azure Virtual Machines](/azure/virtual-machines/workloads/sap/hana-get-started) and [SAP on Azure Large Instances](/azure/virtual-machines/workloads/sap/hana-overview-architecture) more details at [https://docs.microsoft.com/azure/virtual-machines/workloads/sap/azure-monitor-overview](/azure/virtual-machines/workloads/sap/azure-monitor-overview)
  - [Microsoft Enterprise Mobility and Security](https://www.microsoft.com/microsoft-365/enterprise-mobility-security) can be used to integrate the SAP internet facing applications as it helps to protect and secure your organization and empowers your employees to work in new and flexible ways.

   For detailed guidelines, please refer: - [Azure Monitor for SAP Solutions overview and architecture - Azure Virtual Machines](/azure/virtual-machines/workloads/sap/azure-monitor-overview)
- Internet Facing application Security e.g. Fiori: For internet facing applications, we need to make sure that load gets distributed as per application requirements while maintaining the security levels e.g. WAF. The term load balancing refers to the distribution of workloads across multiple computing resources. Load balancing aims to optimize resource use, maximize throughput, minimize response time, and avoid overloading any single resource. It can also improve availability by sharing a workload across redundant computing resources.

Load balancers direct traffic to virtual machines in the application subnet. For high availability, this example uses SAP Web Dispatcher and Azure Standard Load Balancer. These two services also support capacity extension by scaling out, or you can use Azure Application Gateway or other partner products, depending on the traffic type and required functionality you need, such as Secure Sockets Layer (SSL) termination and forwarding. 

   Azure load balancing services can be categorized along two dimensions: global versus regional, and HTTP(S) versus non-HTTP(S).

   Global load-balancing services distribute traffic across regional backends, clouds, or hybrid on-premises services. These services route end-user traffic to the closest available backend. They also react to changes in service reliability or performance, to maximize availability and performance. You can think of them as systems that load balance between application stamps, endpoints, or scale-units hosted across different regions/geographies. Regional load-balancing services distribute traffic within virtual networks across virtual machines (VMs) or zonal and zone-redundant service endpoints within a region. You can think of them as systems that load balance between VMs, containers, or clusters within a region in a virtual network.

   HTTP(S) load-balancing services are Layer 7 load balancers that only accept HTTP(S) traffic. They are intended for web applications or other HTTP(S) endpoints. They include features such as SSL offload, web application firewall, path-based load balancing, and session affinity.

   Non-HTTP/S load-balancing services can handle non-HTTP(S) traffic and are recommended for non-web workloads.

   The following table summarizes the Azure load balancing services by these categories:

   | **Service** | **Global/regional** | **Recommended traffic** |
   |---|---|---|
   | Azure Front Door | Global | HTTP(S) |
   | Traffic Manager | Global | non-HTTP(S) |
   | Application Gateway | Regional | HTTP(S) |
   | Azure Load Balancer | Global | non-HTTP(S) |

[Front Door](/azure/frontdoor/front-door-overview) is an application delivery network that provides global load balancing and site acceleration service for web applications. It offers Layer 7 capabilities for your application like SSL offload, path-based routing, fast failover, caching, etc. to improve performance and high-availability of your applications.

[Traffic Manager](/azure/traffic-manager/traffic-manager-overview) is a DNS-based traffic load balancer that enables you to distribute traffic optimally to services across global Azure regions, while providing high availability and responsiveness. Because Traffic Manager is a DNS-based load-balancing service, it loads balances only at the domain level. For that reason, it can't fail over as quickly as Front Door, because of common challenges around DNS caching and systems not honouring DNS TTLs.

[Application Gateway](/azure/application-gateway/overview) provides application delivery controller (ADC) as a service, offering various Layer 7 load-balancing capabilities. Use it to optimize web farm productivity by offloading CPU-intensive SSL termination to the gateway.

[Azure Load Balancer](/azure/load-balancer/load-balancer-overview) is a high-performance, ultra-low-latency Layer 4 load-balancing service (inbound and outbound) for all UDP and TCP protocols. It is built to handle millions of requests per second while ensuring your solution is highly available. Azure Load Balancer is zone-redundant, ensuring high availability across Availability Zones.

Decision tree for load balancing in Azure:

![Decision tree for load balancing in Azure](media\SGC_Application_Decesion_Tree.jpg)

Treat the above flow chart as a starting point. Every SAP application has unique requirements, so use the recommendation (good to have) as a starting point. Then perform a more detailed evaluation.

If your SAP application consists of multiple workloads, evaluate each workload separately. A complete solution may incorporate two or more load-balancing solutions.

### Design Considerations

- Use third party Web Application Firewall (WAF) as available in the Azure Marketplace for Layer 7 Security.
- Configure [Azure Sentinel](/azure/sentinel/overview) i.e. a scalable, cloud-native, security information event management (SIEM) and security orchestration automated response (SOAR) solution. Azure Sentinel delivers intelligent security analytics and threat intelligence across the enterprise, providing a single solution for alert detection, threat visibility, proactive hunting, and threat response.
- Follow SAP on Azure Architecture guide at [https://docs.microsoft.com/azure/architecture/reference-architectures/sap/sap-overview](/azure/architecture/reference-architectures/sap/sap-overview)
- Review SAP on Azure deployment checklist at [https://docs.microsoft.com/azure/virtual-machines/workloads/sap/sap-deployment-checklist](/azure/virtual-machines/workloads/sap/sap-deployment-checklist)

### Scoping Decisions

| **Scope (Customer Scenario)** | **In-scope (Requirements)** | **Recommendations** | **Notes** |
|---|---|---|---|
| The Company wants a consolidated view of their all up Azure and/or on-Prem Security Posture | Cost Effective and scaleble |  Azure Security Center (ASC) Standard |   Azure Security Center Standard Helps to onboard Windows and Linux Machines from on-prem and / or Cloud and gives consolidated Security Posture. |
| The company wants to make sure to encrypt all their SAP on Azure Database to meet regulatory requirements. | Cost Effective and scalable | SAP HANA Native Encryption and SQL TDE | For Databases, Microsoft recommends using the SAP HANA native encryption technology. Likewise, if you are using SQL Database, TDE (Transparent Data Encryption) should be enabled. |
| The company wants to secure a Fiori application for their global users with HTTPS traffic. | Cost Effective and scalable | Azure Front Door | Azure Front Door (AFD) is an application delivery network that provides global load balancing and site acceleration service for web applications. |


### Compliance and Governance

### References

- [https://azure.microsoft.com/blog/sap-on-azure-designing-for-efficiency-operations/](https://azure.microsoft.com/blog/sap-on-azure-designing-for-efficiency-operations/)

### Design Recommendations

- Azure Resource Naming Convention with Azure Tag: In alignment with [Cloud Adoption Framework](/azure/cloud-adoption-framework/) Ready section the Naming and tagging strategy includes business and operational details as components of resource names and metadata tags:

   The business side of this strategy ensures that resource names and tags include the organizational information needed to identify the teams. Use a resource along with the business owners who are responsible for resource costs. The operational side ensures that names and tags include information that IT teams use to identify the workload, application, environment, criticality, and other information useful for managing resources.

   e.g. VM, Load Balancer, DNS Label, Availability Set, vNet, subnet, Express Route, Network Security Group, Application Security Group, Tag, Route Table, Managed Disk, Public IP. Sample use case could be tag all Azure Dev VMs with Tag “Dev” and this will ease the operations for reporting and billing purpose to pull a report for all things “dev”. More details at [https://docs.microsoft.com/azure/cloud-adoption-framework/ready/azure-best-practices/naming-and-tagging](/azure/cloud-adoption-framework/ready/azure-best-practices/naming-and-tagging)

- Azure Policy – Azure Policy helps to enforce organizational standards and to assess compliance at-scale. Through its compliance dashboard, it provides an aggregated view to evaluate the overall state of the environment, with the ability to drill-down to the per-resource, per-policy granularity. It also helps to bring your resources to compliance through bulk remediation for existing resources and automatic remediation for new resources. Sample Azure Policies are Allowed Locations (Apply at Management Group), Enforce Tag and its value, Naming Policies, create VM using Managed Disk.
- SAP on [Azure Cost Management](/azure/cost-management-billing/manage/spending-limit)- It is very important aspect and Microsoft offers various levers to optimize the same e.g. Reservations, Right Sizing, Snoozing etc. However, it’s important to understand the [Azure cost spending limits](/azure/cost-management-billing/manage/spending-limit) and set alerts for same. This can be further extended to integrate with the ITSM solution.
- Save Time and Reduce Errors by Automating SAP Deployments: Deploying complex SAP landscapes into a public cloud is not an easy task. While SAP basis teams tend to be very familiar with the traditional tasks of installing and configuring SAP systems on-premise, additional domain knowledge is often required to design, build, and test cloud deployments. Need to link SAP on Azure Enterprise Scale Automation reference
- [Azure Advisors Recommendation](/azure/advisor/advisor-overview) : Leverage Azure advisor recommendation across Reliability, Security, Performance, Cost and Operation Excellence.
- [Azure Resource Lock for Production Workloads](/azure/azure-resource-manager/management/lock-resources): It is recommended to create the required Azure resources at the start of your SAP project. When all additions, moves, and changes are finished, and the SAP on Azure deployment is operational all resources can be locked. Following, only a super administrator can unlock a resource and permit the resource (such as a VM) to be modified. SAP Database servers - leverage Transparent Data Encryption offered by the DBMS provider to secure your data and log files and to ensure the backups are also encrypted.

### Design Considerations

- Custom RBAC roles for SAP on Azure Spoke Subscriptions to avoid accidental network related changes: - The SAP on Azure infra team members can be permissioned to deploy virtual machines (VMs) into Azure virtual networks (vNets) and restricted to change anything on the Azure Virtual Network i.e. peered to the Hub Subscription. On the flip side, members of the networking team can create and configure vNets, however, they are prohibited from deploying or configuring VMs in vNets where SAP applications are running.
- Configure DMZ and NVA as isolated from rest of the SAP estate, configure the Azure Private Link and Securely manage and control the SAP on Azure resources.
- Optimizing Dev, Test and Sandbox deployments with Azure Connector for SAP LaMa: Within a typical SAP estate, several application landscapes are often deployed i.e. ERP, SCM, BW etc. and there is an ongoing need to perform SAP system copies and SAP system refreshes, i.e. creating new SAP projects systems for technical/application releases or periodically refreshing QA systems from Production copies. The end-to-end process for SAP system copies and refreshes can be both time-consuming and labor intensive.

   SAP LaMa Enterprise Edition can support operational efficiencies in this area where several steps involved in the SAP system copy or refresh can be automated. Our [Azure Connector for LaMa](/azure/virtual-machines/workloads/sap/lama-installation) enables copying, deletion and relocation of Azure Managed Disks to help your SAP operations team perform SAP system copies and system refreshes rapidly reducing manual efforts.
- In terms of virtual machines (VMs) operations, the Azure Connector for LaMa can be used to reduce the run costs for your SAP estate on Azure. You can stop (deallocate) and start your SAP virtual machines which enables you to run certain workloads with a reduced utilization profile i.e. though the LaMa interface scheduling your SAP S/4HANA sandbox virtual machine to be online from 08:00-18:00, 10 hours per day instead of running 24 hours. Furthermore, the Azure Connector for LaMa also allows you to resize your virtual machine when performance demands arise directly from within LaMa.

### Scoping Decisions

| **Scope (Customer Scenario)** | **In-scope (Requirements)** | **Recommendation** | **Notes** |
|---|---|---|---|
| The company wants to configure a governance model for standing Naming convention and ability to pull reports base on their cost center. | Cost Effective and scalable | Azure Policy and Azure Tags | Azure Policy and Azure Tagging can be used together to meet the requirements. |
| The company wants to avoid accidental deletion of Azure Resources. | Cost Effective and scalable | Azure Resource Lock | Azure Resource Locks prevents accidental resource deletion. |
| The company wants a consolidated view of opportunity areas of Cost Optimization, Resiliency, Security, Operational Excellence and Performance for SAP on Azure resources | Cost Effective and scalable | Azure Advisor | Azure Advisor is Free and helps to get a consolidated view across SAP on Azure subscription Cost Optimization, Resiliency, Security, Operational Excellence and Performance |
