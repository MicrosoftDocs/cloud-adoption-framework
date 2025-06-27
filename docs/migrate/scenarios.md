---
title: Review product migration scenarios
description: Get an overview of product migration scenarios that demonstrate how you can migrate to Azure for various applications and services.
author: Zimmergren
ms.author: pnp
ms.date: 04/10/2024
ms.topic: conceptual
ms.custom: devx-track-extended-java, linux-related-content
ms.collection: 
 - migration
---

# Review product migration scenarios

Specific migration scenarios require different approaches and tools. This article is a collection of links to migration guidance for specific products and services.

## Amazon Web Services (AWS)

| Link | Description |
|---|---|
| [Discover AWS instances](/azure/migrate/tutorial-discover-aws) | Complete a tutorial to learn how to discover Amazon Web Services (AWS) instances using the [Azure Migrate: Discovery and assessment tool](/azure/migrate/migrate-services-overview#azure-migrate-discovery-and-assessment-tool>). |
| [Assess AWS instances for migration to Azure](/azure/migrate/tutorial-assess-aws) | Learn how to assess AWS instances for migration to Azure using the Azure Migrate: Discovery and assessment tool. |
| [Migrate AWS instances](/azure/migrate/tutorial-migrate-aws-virtual-machines) | Complete a tutorial to learn how to discover and assess AWS virtual machines (VMs), and then migrate them to Azure VMs using the Azure Migrate: Discovery and assessment tool and the Migration and modernization tool. |

## Google Cloud Platform (GCP)

| Link | Description |
|---|---|
| [Discover GCP instances](/azure/migrate/tutorial-discover-gcp) | Complete a tutorial to learn how to discover GCP instances by using the [Azure Migrate Discovery and assessment tool](/azure/migrate/migrate-services-overview). |
| [Assess GCP instances for migration to Azure](/azure/migrate/tutorial-assess-gcp) | Learn how to assess GCP instances for migration to Azure by using the Azure Migrate Discovery and assessment tool. |
| [Migrate GCP instances](/azure/migrate/tutorial-migrate-gcp-virtual-machines) | Complete a tutorial to learn how to discover and assess GCP VMs, and then migrate them to Azure VMs by using the Azure Migrate Discovery and assessment tool and the Azure Migrate Migration and modernization tool. |

## Containers

| Link | Description |
|---|---|
| [Migrate to Azure Kubernetes Service](/azure/aks/aks-migration) | Get the current recommended Azure Kubernetes Service configuration to help you plan and carry out a successful migration to Azure Kubernetes Service. |

## Windows and Linux

### VMware servers

| Link | Description |
|---|---|
| [Discover servers running in a VMware environment](/azure/migrate/tutorial-discover-vmware) | Learn how to discover the servers that run in your VMware environment by using the Azure Migrate discovery and assessment tool. |
| [Assess VMware VMs for migration to Azure VMs](/azure/migrate/tutorial-assess-vmware-azure-vm) | Use the Azure Migrate discovery and assessment tool to assess discovered servers in your VMware environment in preparation for migration to Azure VMs. |
| [Select a VMware migration option](/azure/migrate/server-migrate-overview) | Learn how you can migrate VMware VMs to Azure by using the migration and modernization tool. |
| [Move on-premises VMware infrastructure to Azure VMware Solution](./azure-best-practices/contoso-migration-vmware-to-azure.md) | Learn how to use Azure VMware Solution, a first-party Microsoft offering that's backed by VMware, to create a private cloud in Azure. The cloud has native access to VMware vCenter Server and other VMware tools that support workload migrations. |

### Hyper-V servers

| Link | Description |
|---|---|
| [Discover servers running in a Hyper-V environment](/azure/migrate/tutorial-discover-hyper-v) | This tutorial shows you how to use the Azure Migrate discovery and assessment tool to discover servers that run in your Hyper-V environment. |
| [Assess Hyper-V VMs for migration to Azure](/azure/migrate/tutorial-assess-hyper-v) | Learn how to use the Azure Migrate discovery and assessment tool to assess discovered servers in your Hyper-V environment for migration to Azure. |
| [Migrate Hyper-V VMs to Azure](/azure/migrate/tutorial-migrate-hyper-v) | This article demonstrates how to assess Hyper-V machines for migration to Azure and how to migrate them. |

### Remote Desktop Services and Azure Virtual Desktop

| Link | Description |
|---|---|
| [Move an on-premises Remote Desktop Services instance to Azure Virtual Desktop](./azure-best-practices/contoso-migration-rds-to-azure-virtual-desktop.md) | Learn how to migrate and modernize an on-premises virtual desktop infrastructure (VDI) environment by moving an instance of Remote Desktop Services in Windows Server to Azure Virtual Desktop. |

## Databases and data platforms

### SQL Server

| Link | Description |
|---|---|
| [SQL Server migration guides](/azure/azure-sql/migration-guides/)| Get the guidance you need to migrate to the Azure SQL family of SQL Server database engine products in the cloud: Azure SQL Database, Azure SQL Managed Instance, and SQL Server on Azure Virtual Machines. |
| [Migrate from SQL Server to Azure SQL](/azure/azure-sql/migration-guides/database/sql-server-to-sql-database-guide) | Learn how to migrate your SQL Server instance to Azure SQL Database. |
| [Migrate from SQL Server to Azure SQL Managed Instance](/azure/azure-sql/migration-guides/managed-instance/sql-server-to-managed-instance-guide) | Learn how to migrate your SQL Server instance to Azure SQL Managed Instance. |
| [Migrate from SQL Server to SQL Server on Azure Virtual Machines](/azure/azure-sql/migration-guides/virtual-machines/sql-server-to-sql-on-azure-vm-individual-databases-guide) | Learn how to discover and assess your user databases for migration from SQL Server to SQL Server on Azure Virtual Machines, and then migrate the databases by using tools and techniques based on your requirements. |

### IBM Db2

| Link | Description |
|---|---|
| [Migrate from IBM Db2 to Azure SQL Database](/azure/azure-sql/migration-guides/database/db2-to-sql-database-guide) | Learn how to migrate your IBM Db2 databases to Azure SQL Database by using SQL Server Migration Assistant (SSMA) for IBM Db2. |
| [Migrate from IBM Db2 to Azure SQL Managed Instance](/azure/azure-sql/migration-guides/managed-instance/db2-to-managed-instance-guide) | Learn how to migrate your Oracle schemas to Azure SQL Managed Instance by using SSMA for Oracle. |
| [Migrate from IBM Db2 to Azure SQL on Azure Virtual Machines](/azure/azure-sql/migration-guides/virtual-machines/db2-to-sql-on-azure-vm-guide) | Learn how to migrate your Oracle schemas to SQL Server on Azure Virtual Machines by using SSMA for Oracle. |

### Oracle

| Link | Description |
|---|---|
| [Migrate from Oracle to Azure SQL Database](/azure/azure-sql/migration-guides/database/oracle-to-sql-database-guide) | This article teaches you how to migrate your Oracle schemas to Azure SQL Database by using SSMA for Oracle. |
| [Migrate from Oracle to Azure SQL Managed Instance](/azure/azure-sql/migration-guides/managed-instance/oracle-to-managed-instance-guide) | This article teaches you how to migrate your Oracle schemas to Azure SQL Managed Instance by using SSMA for Oracle. |
| [Migrate from Oracle to Azure SQL on Azure Virtual Machines](/azure/azure-sql/migration-guides/virtual-machines/oracle-to-sql-on-azure-vm-guide) | Learn how to migrate your Oracle schemas to SQL Server on Azure Virtual Machines by using SSMA for Oracle. |

### Microsoft Access

| Link | Description |
|---|---|
| [Migrate from Microsoft Access to Azure SQL Database](/azure/azure-sql/migration-guides/database/access-to-sql-database-guide) | Learn how to migrate your Access database to Azure SQL Database by using SSMA for Access. |

### Linux and open-source databases

| Link | Description |
|---|---|
| [Migrate open-source databases to Azure](/training/paths/migrate-open-source-workloads/)| Learn how to migrate open-source workloads from PostgreSQL and MySQL databases to the equivalent services in Azure. |
| [Migrate MySQL databases to Azure SQL](/azure/azure-sql/migration-guides/database/mysql-to-sql-database-guide) | Learn how to migrate your MySQL database to Azure SQL Database by using SSMA for MySQL. |
| [Migrate PostgreSQL databases to Azure](/azure/dms/tutorial-postgresql-azure-postgresql-online-portal)|You can use Azure Database Migration Service to migrate databases from an on-premises PostgreSQL instance to Azure Database for PostgreSQL with minimal downtime to the application. |
| [Migrate Azure Database for MariaDB to Azure Database for MySQL](https://azure.microsoft.com/updates/azure-database-for-mariadb-will-be-retired-on-19-september-2025-migrate-to-azure-database-for-mysql-flexible-server/)|Azure Database for MariaDB is being retired. Learn how to migrate to Azure Database for MySQL. |

### Storage migration

| Link | Description |
|---|---|
| [Storage migration overview](/azure/storage/common/storage-migration-overview) | This article focuses on storage migrations to Azure, including the migration of unstructured data and block-based devices such as disks and storage area networks (SANs). |
| [Tools for unstructured storage migration](/azure/storage/solution-integration/validated-partners/data-management/migration-tools-comparison) | This article offers a comparison matrix of basic functionality in different tools that you can use for the migration of unstructured data. |

## Java applications

| Link | Description |
|---|---|
| [Migration overview](/azure/developer/java/migration/migration-overview) | This migration guidance covers mainstream Java on Azure scenarios and provides high-level planning suggestions and considerations. |
| [Migrate Spring Boot applications to Azure Spring Apps](/azure/developer/java/migration/migrate-spring-boot-to-azure-spring-apps) | This article describes what you should be aware of when you migrate an existing Spring Boot application to run on Azure Spring Apps. |
| [Migrate Spring Cloud applications to Azure Spring Apps](/azure/developer/java/migration/migrate-spring-cloud-to-azure-spring-apps) | This article describes what you should be aware of when you migrate an existing Spring Cloud application to run on Azure Spring Apps. |
| [Migrate WildFly applications to WildFly on Azure Kubernetes Service](/azure/developer/java/migration/migrate-wildfly-to-wildfly-on-azure-kubernetes-service) | This article describes what you should be aware of when you migrate an existing WildFly application to run on WildFly in an Azure Kubernetes Service container. |

### Apache Tomcat to Azure

| Link | Description |
|---|---|
| [Migrate Apache Tomcat applications to Tomcat on Azure App Service](/azure/developer/java/migration/migrate-tomcat-to-tomcat-app-service) | This article describes what you should be aware of when you migrate an existing Tomcat application to run on Azure App Service by using Tomcat 9.0. |
| [Migrate Tomcat applications to Azure Container Apps](/azure/developer/java/migration/migrate-tomcat-to-azure-container-apps) | This article describes what you should be aware of when you migrate an existing Tomcat application to run on Azure Container Apps. |
| [Migrate Tomcat applications to containers on Azure Kubernetes Service](/azure/developer/java/migration/migrate-tomcat-to-containers-on-azure-kubernetes-service) | This article describes what you should be aware of when you migrate an existing Tomcat application to run on Azure Kubernetes Service. |
| [Java web app containerization and migration to Azure Kubernetes Service](/azure/migrate/tutorial-app-containerization-java-kubernetes)|In this article, learn how to containerize Java web applications (running on Apache Tomcat) and migrate them to Azure Kubernetes Service by using the Azure Migrate: App Containerization tool. |

### Oracle WebLogic Server to Azure

| Link | Description |
|---|---|
| [Migrate WebLogic Server applications to Azure Kubernetes Service](/azure/developer/java/migration/migrate-weblogic-to-azure-kubernetes-service) | This article describes what you should be aware of when you migrate an existing Oracle WebLogic Server application to run on Azure Kubernetes Service. |
| [Migrate WebLogic Server applications to Azure Virtual Machines](/azure/developer/java/migration/migrate-weblogic-to-virtual-machines) | This article describes what you should be aware of when you migrate an existing WebLogic Server application to run on Azure Virtual Machines. |
| [Migrate WebLogic Server applications to WildFly on Azure Kubernetes Service](/azure/developer/java/migration/migrate-weblogic-to-wildfly-on-azure-kubernetes-service) | This article describes what you should be aware of when you migrate an existing WebLogic Server application to run on WildFly in an Azure Kubernetes Service container. |
| [Tutorial: Manually install WebLogic Server on Azure Virtual Machines](/azure/developer/java/migration/migrate-weblogic-to-azure-vm-manually) | This tutorial shows the steps to install WebLogic Server and configure a WebLogic Server cluster on Azure Virtual Machines on Windows or GNU/Linux. |
| [Tutorial: Migrate WebLogic Server to Azure Kubernetes Service within a custom virtual network](/azure/developer/java/migration/migrate-weblogic-to-aks-within-an-existing-vnet) | This tutorial shows you how to deploy the offer to integrate WebLogic Server with Azure Kubernetes Service by using a custom virtual network in the consumer's subscription. |
| [Tutorial: Migrate a WebLogic Server cluster to Azure by using Azure Application Gateway as a load balancer](/azure/developer/java/migration/migrate-weblogic-with-app-gateway) | This tutorial walks you through the process of deploying WebLogic Server by using Azure Application Gateway. |
| [Tutorial: Migrate WebLogic Server to Azure Virtual Machines with high availability and disaster recovery](/azure/developer/java/migration/migrate-weblogic-to-vms-with-ha-dr) | This tutorial shows you a simple and effective way to implement high availability (HA) and disaster recovery (DR) for Java by using WebLogic Server on Azure Virtual Machines |
| [Migrate WebLogic Server applications to JBoss EAP on Azure App Service](/azure/developer/java/migration/migrate-weblogic-to-jboss-eap-on-azure-app-service) | This article describes what you should be aware of when you migrate an existing WebLogic Server application to run on Azure App Service by using Red Hat JBoss Enterprise Application Platform (JBoss EAP). |

### IBM WebSphere to Azure

| Link | Description |
|---|---|
| [Migrate WebSphere applications to Azure Kubernetes Service](/azure/developer/java/migration/migrate-websphere-to-azure-kubernetes-service) | This article describes what you should be aware of when you migrate an existing IBM WebSphere Application Server workload to IBM WebSphere Liberty or Open Liberty on Azure Kubernetes Service. |
| [Migrate WebSphere applications to Azure Red Hat OpenShift](/azure/developer/java/migration/migrate-websphere-to-azure-redhat-openshift) | This article describes what you should be aware of when you migrate an existing WebSphere Application Server workload to IBM WebSphere Liberty or Open Liberty that runs on Azure Red Hat OpenShift. |
| [Migrate WebSphere applications to Azure Virtual Machines](/azure/developer/java/migration/migrate-websphere-to-virtual-machines) | This article describes what you should be aware of when you migrate an existing WebSphere Application Server traditional application to run on Azure Virtual Machines. |
| [Tutorial: Manually install IBM WebSphere Application Server Network Deployment traditional on Azure Virtual Machines](/azure/developer/java/migration/migrate-websphere-to-azure-vm-manually) | This tutorial shows you how to install traditional IBM WebSphere Application Server Network Deployment traditional and configure a WebSphere Application Server cluster on Azure Virtual Machines on GNU/Linux. |
| [Migrate WebSphere applications to JBoss EAP on Azure App Service](/azure/developer/java/migration/migrate-websphere-to-jboss-eap-on-azure-app-service) | Learn what you should be aware of when you migrate an existing WebSphere application to run on Azure App Service by using JBoss EAP. |
| [Migrate WebSphere applications to WildFly on Azure Kubernetes Service](/azure/developer/java/migration/migrate-websphere-to-wildfly-on-azure-kubernetes-service) | This article describes what you should be aware of when you migrate an existing WebSphere application to run on WildFly in an Azure Kubernetes Service container. |

### JBoss EAP to Azure

| Link | Description |
|---|---|
| [Migrate JBoss EAP applications to JBoss EAP on Azure App Service](/azure/developer/java/migration/migrate-jboss-eap-to-jboss-eap-on-azure-app-service) | This article describes what you should be aware of when you migrate an existing JBoss EAP application to run on JBoss EAP in an Azure App Service instance. |
| [Migrate JBoss EAP applications to JBoss EAP on Azure Virtual Machines](/azure/developer/java/migration/migrate-jboss-eap-to-jboss-eap-on-azure-vms) | This article describes what you should be aware of when you migrate an existing JBoss EAP application to run on JBoss EAP on Azure Virtual Machines. |
| [Migrate JBoss EAP applications to Azure Red Hat OpenShift](/azure/developer/java/migration/migrate-jboss-eap-to-azure-redhat-openshift) | This article describes what you should be aware of when you migrate an existing JBoss EAP application to run on Azure Red Hat OpenShift. |
| [Migrate JBoss EAP applications to WildFly on Azure Kubernetes Service](/azure/developer/java/migration/migrate-jboss-eap-to-wildfly-on-azure-kubernetes-service) | This article describes what you should be aware of when you migrate an existing JBoss EAP application to run on WildFly in an Azure Kubernetes Service container. |

## SAP

| Link | Description |
|---|---|
| [Migrate an SAP platform to Azure](/azure/cloud-adoption-framework/scenarios/sap/migrate) | SAP workloads require different tools and processes to replicate and deploy their assets than what Azure Migrate traditionally offers. Learn more in this adoption scenario. |
| [Learning path for migrating SAP workloads to Azure](/training/paths/migrate-sap-workloads-to-azure/) | These Microsoft Learn training modules explore migrating SAP workloads to Azure, including databases that are larger than 20 terabytes (TB). |
| [SAP on Azure migration](https://azure.microsoft.com/solutions/sap/migration/) | Learn how to migrate your SAP estate to Azure, with resources to support your journey at every step. |
| [Migrate from SAP ASE to Azure SQL](/azure/azure-sql/migration-guides/database/sap-ase-to-sql-database) | Learn how to migrate your SAP Adaptive Server Enterprise (ASE) databases to Azure SQL Database by using SSMA for SAP ASE. |

## Azure Local

| Link | Description |
|---|---|
| [Overview of an Azure Migrate-based migration for Azure Local](/azure-stack/hci/migrate/migration-azure-migrate-hci-overview) | Get an overview of how to migrate Hyper-V VMs to your Azure Local instance by using Azure Migrate. |

## Multitenant migration

| Link | Description |
|---|---|
| [Manage Azure Migrate projects at scale by using Azure Lighthouse](/azure/lighthouse/how-to/migration-at-scale) | Get an overview of how Azure Lighthouse can help you use Azure Migrate in a scalable way across multiple Microsoft Entra tenants. |
