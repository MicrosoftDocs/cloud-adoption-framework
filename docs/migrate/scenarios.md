---
title: Product migration guidance
description: Get an overview of product migration scenarios that demonstrate how you can migrate to Microsoft Azure for various applications and services.
author: Zimmergren
ms.author: tozimmergren
ms.date: 01/16/2024
ms.topic: conceptual
---

# Product migration guidance

This article contains examples of several common migration scenarios and demonstrates how you can migrate to [Microsoft Azure](https://azure.microsoft.com/overview/what-is-azure/).

See each section below for relevant migration guidance for specific applications or products.

## AWS

| Link | Description |
|---|---|
| [Discover AWS instances](/azure/migrate/tutorial-discover-aws) | This tutorial shows you how to discover Amazon Web Services (AWS) instances with the Azure Migrate: Discovery and assessment tool. |
| [Assess AWS instances for migration to Azure](/azure/migrate/tutorial-assess-aws) | This article shows you how to assess Amazon Web Services (AWS) instances for migration to Azure, using the Azure Migrate: Discovery and assessment tool. |
| [Migrate AWS instances](/azure/migrate/tutorial-migrate-aws-virtual-machines) | This tutorial shows you how to discover, assess, and migrate Amazon Web Services (AWS) virtual machines (VMs) to Azure VMs by using Azure Migrate: Server Assessment and the Migration and modernization tool. |

## Containers

| Link | Description |
|---|---|
| [Migrate to Azure Kubernetes Service (AKS)](/azure/aks/aks-migration) | This guide provides details for the current recommended AKS configuration to help you plan and execute a successful migration to AKS. |

## Windows and Linux

### VMWare servers

| Link | Description |
|---|---|
| [Discover servers running in a VMware environment](/azure/migrate/tutorial-discover-vmware) | This tutorial shows you how to discover the servers that are running in your VMware environment by using the Azure Migrate: Discovery and assessment tool. |
| [Assess VMware VMs for migration to Azure VMs](/azure/migrate/tutorial-assess-vmware-azure-vm) | This article shows you how to assess discovered servers from your VMware environment in preparation for migration to Azure VMs, using the Azure Migrate: Discovery and assessment tool. |
| [Select a VMware migration option](/azure/migrate/server-migrate-overview) | Use this guide to learn how you can migrate VMware VMs to Azure using the Migration and modernization tool. |
| [Move on-premises VMware infrastructure to AVS](./azure-best-practices/contoso-migration-vmware-to-azure.md) | **Scenario:** In this article, Contoso uses Azure VMware Solution to create a private cloud in Azure. The cloud has native access to VMware vCenter Server and other VMware tools that are designed for workload migration. Contoso can confidently use Azure VMware Solution because it's a first-party Microsoft offering that's backed by VMware. |

### Hyper-V servers

| Link | Description |
|---|---|
| [Discover servers running in a Hyper-V environment](/azure/migrate/tutorial-discover-hyper-v) | This tutorial shows you how to discover the servers that are running in your Hyper-V environment by using the Azure Migrate: Discovery and assessment tool. |
| [Assess Hyper-V VMs for migration to Azure](/azure/migrate/tutorial-assess-hyper-v) | This article shows you how to assess discovered servers from your Hyper-V environment for migration to Azure, using the Azure Migrate: Discovery and assessment tool. |
| [Migrate Hyper-V VMs to Azure](/azure/migrate/tutorial-migrate-hyper-v) | This article demonstrates how to assess and migrate Hyper-V machines to Azure. |

### Remote Desktop Services & Azure Virtual Desktop

|Link|Description|
|---|---|
| [Move on-premises Remote Desktop Services to Azure Virtual Desktop scenario](./azure-best-practices/contoso-migration-rds-to-azure-virtual-desktop.md) | **Scenario:** In this article, Contoso migrates and modernizes their on-premises VDI environment based on Remote Desktop Services (RDS) in Windows Server to Azure Virtual Desktop.|

## Databases and data platforms

### SQL Server workloads

| Link | Description |
|---|---|
| [SQL Migration guides](/azure/azure-sql/migration-guides/)| Find documentation on how to migrate to the Azure SQL family of SQL Server database engine products in the cloud: Azure SQL Database, Azure SQL Managed Instance, and SQL Server on Azure. |
| [Migrate from SQL Server to Azure SQL](/azure/azure-sql/migration-guides/database/sql-server-to-sql-database-guide) | In this guide, you learn how to migrate your SQL Server instance to Azure SQL Database. |
| [Migrate from SQL Server to Azure SQL Managed Instance](/azure/azure-sql/migration-guides/managed-instance/sql-server-to-managed-instance-guide) | This guide helps you migrate your SQL Server instance to Azure SQL Managed Instance. |
| [Migrate from SQL Server to SQL Server on Azure VM](/azure/azure-sql/migration-guides/virtual-machines/sql-server-to-sql-on-azure-vm-individual-databases-guide) | In this guide, you learn how to discover, assess, and migrate your user databases from SQL Server to an instance of SQL Server on Azure Virtual Machines by tools and techniques based on your requirements. |

### DB2

| Link | Description |
|---|---|
| [Migrate from DB2 to Azure SQL](/azure/azure-sql/migration-guides/database/db2-to-sql-database-guide) | In this guide, you learn how to migrate your IBM Db2 databases to Azure SQL Database, by using SQL Server Migration Assistant for Db2. |
| [Migrate from DB2 to Azure SQL Managed Instance](/azure/azure-sql/migration-guides/managed-instance/db2-to-managed-instance-guide) | This guide teaches you to migrate your Oracle schemas to Azure SQL Managed Instance by using SQL Server Migration Assistant for Oracle. |
| [Migrate from DB2 to Azure SQL on Azure VM](/azure/azure-sql/migration-guides/virtual-machines/db2-to-sql-on-azure-vm-guide) | This guide teaches you to migrate your Oracle schemas to SQL Server on Azure Virtual Machines by using SQL Server Migration Assistant for Oracle. |

### Oracle

| Link | Description |
|---|---|
| [Migrate from Oracle to Azure SQL](/azure/azure-sql/migration-guides/database/oracle-to-sql-database-guide) | This guide teaches you to migrate your Oracle schemas to Azure SQL Database by using SQL Server Migration Assistant for Oracle (SSMA for Oracle). |
| [Migrate from Oracle to Azure SQL Managed Instance](/azure/azure-sql/migration-guides/managed-instance/oracle-to-managed-instance-guide) | This guide teaches you to migrate your Oracle schemas to Azure SQL Managed Instance by using SQL Server Migration Assistant for Oracle. |
| [Migrate from Oracle to Azure SQL on Azure VM](/azure/azure-sql/migration-guides/virtual-machines/oracle-to-sql-on-azure-vm-guide) | This guide teaches you to migrate your Oracle schemas to SQL Server on Azure Virtual Machines by using SQL Server Migration Assistant for Oracle. |

### Access

| Link | Description |
|---|---|
| [Migrate from Access to Azure SQL](/azure/azure-sql/migration-guides/database/access-to-sql-database-guide) | In this guide, you learn how to migrate your Microsoft Access database to an Azure SQL database by using SQL Server Migration Assistant for Access (SSMA for Access). |

### Linux and open-source databases

| Link | Description |
|---|---|
|[Migrate open-source databases to Azure](/training/paths/migrate-open-source-workloads/)|Learn how to migrate open-source workloads from PostgreSQL and MySQL databases to the equivalent services in Azure.|
| [Migrate from MySQL to Azure SQL](/azure/azure-sql/migration-guides/database/mysql-to-sql-database-guide) |Learn how to migrate your MySQL database to an Azure SQL database by using SQL Server Migration Assistant for MySQL (SSMA for MySQL).|
|[Migrate PostgreSQL to Azure](/azure/dms/tutorial-postgresql-azure-postgresql-online-portal)|You can use Azure Database Migration Service to migrate the databases from an on-premises PostgreSQL instance to Azure Database for PostgreSQL with minimal downtime to the application.|
|[Migrate MariaDB to Azure](https://azure.microsoft.com/updates/azure-database-for-mariadb-will-be-retired-on-19-september-2025-migrate-to-azure-database-for-mysql-flexible-server/)|MariaDB on Azure will be retired - please follow these directions to migrate to Azure Database for MySQL.|

### Storage migration

| Link | Description |
|---|---|
| [Storage migration overview](/azure/storage/common/storage-migration-overview) | This article focuses on storage migrations to Azure, including migration of unstructured data and block-based devices such as disks and storage area networks (SANs). |
| [Tools for unstructured storage migration](/azure/storage/solution-integration/validated-partners/data-management/migration-tools-comparison) | This guide offers a comparison matrix showing basic functionality of different tools that can be used for migration of unstructured data. |

## Java applications

| Link | Description |
|---|---|
| [Migration overview](/azure/developer/java/migration/migration-overview) | This migration guidance is designed to cover mainstream Java on Azure scenarios, and to provide high-level planning suggestions and considerations. |
| [Migrate Spring Boot applications to Azure Spring Apps](/azure/developer/java/migration/migrate-spring-boot-to-azure-spring-apps) | This guide describes what you should be aware of when you want to migrate an existing Spring Boot application to run on Azure Spring Apps. |
| [Migrate Spring Cloud applications to Azure Spring Apps](/azure/developer/java/migration/migrate-spring-cloud-to-azure-spring-apps) | This guide describes what you should be aware of when you want to migrate an existing Spring Cloud application to run on Azure Spring Apps. |
| [Migrate WildFly applications to WildFly on Azure Kubernetes Service](/azure/developer/java/migration/migrate-wildfly-to-wildfly-on-azure-kubernetes-service) | This guide describes what you should be aware of when you want to migrate an existing WildFly application to run on WildFly in an Azure Kubernetes Service container. |

### Tomcat to Azure

| Link | Description |
|---|---|
| [Migrate Tomcat applications to Tomcat on Azure App Service](/azure/developer/java/migration/migrate-tomcat-to-tomcat-app-service) | This guide describes what you should be aware of when you want to migrate an existing Tomcat application to run on Azure App Service using Tomcat 9.0. |
|[Migrate Tomcat applications to Azure Container Apps](/azure/developer/java/migration/migrate-tomcat-to-azure-container-apps)|This guide describes what you should be aware of when you want to migrate an existing Tomcat application to run on Azure Container Apps (ACA).|
|[Migrate Tomcat applications to containers on Azure Kubernetes Service](/azure/developer/java/migration/migrate-tomcat-to-containers-on-azure-kubernetes-service)|This guide describes what you should be aware of when you want to migrate an existing Tomcat application to run on Azure Kubernetes Service (AKS).|
|[Java web app containerization and migration to Azure Kubernetes Service](/azure/migrate/tutorial-app-containerization-java-kubernetes)|In this article, you'll learn how to containerize Java web applications (running on Apache Tomcat) and migrate them to Azure Kubernetes Service (AKS) using the Azure Migrate: App Containerization tool.|

### WebLogic Server to Azure

| Link | Description |
|---|---|
|[Migrate WebLogic Server applications to Azure Kubernetes Service](/azure/developer/java/migration/migrate-weblogic-to-azure-kubernetes-service)|This guide describes what you should be aware of when you want to migrate an existing WebLogic Server (WLS) application to run on Azure Kubernetes Service (AKS).|
|[Migrate WebLogic Server applications to Azure Virtual Machines](/azure/developer/java/migration/migrate-weblogic-to-virtual-machines)|This guide describes what you should be aware of when you want to migrate an existing WebLogic application to run on Azure Virtual Machines.|
|[Migrate WebLogic Server applications to WildFly on Azure Kubernetes Service](/azure/developer/java/migration/migrate-weblogic-to-wildfly-on-azure-kubernetes-service)|This guide describes what you should be aware of when you want to migrate an existing WebLogic Server application to run on WildFly in an Azure Kubernetes Service container.|
|[Tutorial: Manually install Oracle WebLogic Server on Azure Virtual Machines](/azure/developer/java/migration/migrate-weblogic-to-azure-vm-manually)|This tutorial shows the steps to install Oracle WebLogic Server (WLS) and configure a WebLogic cluster on Azure Virtual Machines (VMs), on Windows or GNU/Linux.|
|[Tutorial: Migrate Oracle WebLogic Server to Azure Kubernetes Service within a custom virtual network](/azure/developer/java/migration/migrate-weblogic-to-aks-within-an-existing-vnet)|This tutorial shows you how to deploy the Oracle WebLogic Server (WLS) on Azure Kubernetes Service (AKS) offer that integrates with a custom virtual network in the consumer's subscription.|
[Tutorial: Migrate a WebLogic Server cluster to Azure with Azure Application Gateway as a load balancer](/azure/developer/java/migration/migrate-weblogic-with-app-gateway)|This tutorial walks you through the process of deploying WebLogic Server (WLS) with Azure Application Gateway.|
|[Tutorial: Migrate Oracle WebLogic Server to Azure Virtual Machines with high availability and disaster recovery](/azure/developer/java/migration/migrate-weblogic-to-vms-with-ha-dr)|This tutorial shows you a simple and effective way to implement high availability and disaster recovery (HA/DR) for Java using Oracle WebLogic Server (WLS) on Azure Virtual Machines (VMs).|
|[Migrate WebLogic Server applications to JBoss EAP on Azure App Service](/azure/developer/java/migration/migrate-weblogic-to-jboss-eap-on-azure-app-service)|This guide describes what you should be aware of when you want to migrate an existing WebLogic Server application to run on Azure App Service using JBoss EAP.|

### WebSphere to Azure

| Link | Description |
|---|---|
|[Migrate WebSphere applications to Azure Kubernetes Service](/azure/developer/java/migration/migrate-websphere-to-azure-kubernetes-service)|This guide describes what you should be aware of when you want to migrate an existing WebSphere Application Server (WAS) workload to IBM WebSphere Liberty or Open Liberty on Azure Kubernetes Service (AKS).|
|[Migrate WebSphere applications to Azure Red Hat OpenShift](/azure/developer/java/migration/migrate-websphere-to-azure-redhat-openshift)|This guide describes what you should be aware of when you want to migrate an existing WebSphere Application Server (WAS) workload to IBM WebSphere Liberty or Open Liberty that runs on Azure Red Hat OpenShift.|
|[Migrate WebSphere applications to Azure Virtual Machines](/azure/developer/java/migration/migrate-websphere-to-virtual-machines)|This guide describes what you should be aware of when you want to migrate an existing WebSphere Application Server (WAS) traditional application to run on Azure Virtual Machines.|
|[Tutorial: Manually install IBM WebSphere Application Server Network Deployment traditional on Azure virtual machines](/azure/developer/java/migration/migrate-websphere-to-azure-vm-manually)|This tutorial shows you how to install IBM WebSphere Application Server (WAS) Network Deployment traditional and configure a WAS cluster on Azure virtual machines (VMs) on GNU/Linux.|
|[Migrate WebSphere applications to JBoss EAP on Azure App Service](/azure/developer/java/migration/migrate-websphere-to-jboss-eap-on-azure-app-service)|This guide describes what you should be aware of when you want to migrate an existing WebSphere application to run on Azure App Service using JBoss EAP.|
|[Migrate WebSphere applications to WildFly on Azure Kubernetes Service](/azure/developer/java/migration/migrate-websphere-to-wildfly-on-azure-kubernetes-service)|This guide describes what you should be aware of when you want to migrate an existing WebSphere application to run on WildFly in an Azure Kubernetes Service container.|

### JBoss EAP to Azure

| Link | Description |
|---|---|
|[Migrate JBoss EAP applications to JBoss EAP on Azure App Service](/azure/developer/java/migration/migrate-jboss-eap-to-jboss-eap-on-azure-app-service)|This guide describes what you should be aware of when you want to migrate an existing JBoss EAP application to run on JBoss EAP in an Azure App Service instance.|
|[Migrate JBoss EAP applications to JBoss EAP on Azure VMs](/azure/developer/java/migration/migrate-jboss-eap-to-jboss-eap-on-azure-vms)|This guide describes what you should be aware of when you want to migrate an existing JBoss EAP application to run on JBoss EAP in Azure VMs.|
|[Migrate JBoss EAP applications to Azure Red Hat OpenShift](/azure/developer/java/migration/migrate-jboss-eap-to-azure-redhat-openshift)|This guide describes what you should be aware of when you want to migrate an existing JBoss EAP application to run on Azure Red Hat OpenShift.|
|[Migrate JBoss EAP applications to WildFly on Azure Kubernetes Service](/azure/developer/java/migration/migrate-jboss-eap-to-wildfly-on-azure-kubernetes-service)|This guide describes what you should be aware of when you want to migrate an existing JBoss EAP application to run on WildFly in an Azure Kubernetes Service container.|

## SAP

| Link | Description |
|---|---|
| [Migrate an SAP platform to Azure](/azure/cloud-adoption-framework/scenarios/sap/migrate) | SAP workloads require different tools and processes to replicate and deploy their assets than what Azure Migrate traditionally offers. Learn more in this adoption scenario. |
| [Learning path for Migrate SAP workloads to Azure](/training/paths/migrate-sap-workloads-to-azure/) | **Training:** These modules explore migration of SAP workloads to Azure, including very large databases over 20 TB. |
| [SAP on Azure migration](https://azure.microsoft.com/solutions/sap/migration/) | Learn how to migrate your SAP estate to Azure, with resources to support your journey at every step. |
| [Migrate from SAP ASE to Azure SQL](/azure/azure-sql/migration-guides/database/sap-ase-to-sql-database) | In this guide, you learn how to migrate your SAP Adapter Server Enterprise (ASE) databases to an Azure SQL database by using SQL Server Migration Assistant for SAP Adapter Server Enterprise. |

## Azure Stack

| Link | Description |
|---|---|
| [Overview of Azure Migrate based migration for Azure Stack HCI](/azure-stack/hci/migrate/migration-azure-migrate-hci-overview) | Provides an overview of how to migrate Hyper-V virtual machines (VMs) to your Azure Stack HCI cluster using Azure Migrate. |

### Azure Synapse Analytics

| Link | Description |
|---|---|
|[Design and performance for Teradata migrations](/azure/synapse-analytics/migration-guides/teradata/1-design-performance-migration)|Guidance on how to migrate from Teradata to Azure Synapse Analytics.|
|[Design and performance for Netezza migrations](/azure/synapse-analytics/migration-guides/netezza/1-design-performance-migration)| Guidance on how to migrate from Netezza to Azure Synapse Analytics.|
|[Design and performance for Oracle migrations](/azure/synapse-analytics/migration-guides/oracle/1-design-performance-migration)|Guidance on how to migrate from Oracle to Azure Synapse Analytics.|

## Multitenant migration

| Link | Description |
|---|---|
| [Manage Azure Migrate projects at scale with Azure Lighthouse](/azure/lighthouse/how-to/migration-at-scale) | This article provides an overview of how Azure Lighthouse can help you use Azure Migrate in a scalable way across multiple Microsoft Entra tenants.|
