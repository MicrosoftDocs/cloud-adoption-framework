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
| [Migration overview](/azure/developer/java/migration/migration-overview) | TBD |
| [Spring Boot to Azure App Service](/azure/developer/java/migration/migrate-spring-boot-to-app-service) | TBD |
| [Spring Boot to AKS](/azure/developer/java/migration/migrate-spring-boot-to-azure-kubernetes-service) | TBD |
| [Spring Boot to Azure Spring Cloud](/azure/developer/java/migration/migrate-spring-boot-to-azure-spring-cloud) | TBD |
| [Spring Cloud to Azure Spring Cloud](/azure/developer/java/migration/migrate-spring-cloud-to-azure-spring-cloud) | TBD |
| [Tomcat to Azure App Service](/azure/developer/java/migration/migrate-tomcat-to-tomcat-app-service) | TBD |
| [Tomcat to containers on AKS](/azure/developer/java/migration/migrate-tomcat-to-containers-on-azure-kubernetes-service) | TBD |
| [Tomcat to Azure Spring Cloud](/azure/developer/java/migration/migrate-tomcat-to-azure-spring-cloud) | TBD |
| [WildFly to WildFly on AKS](/azure/developer/java/migration/migrate-wildfly-to-wildfly-on-azure-kubernetes-service) | TBD |
| [WebLogic to WildFly on AKS](/azure/developer/java/migration/migrate-weblogic-to-wildfly-on-azure-kubernetes-service) | TBD |
| [WebSphere to WildFly on AKS](/azure/developer/java/migration/migrate-websphere-to-wildfly-on-azure-kubernetes-service) | TBD |
| [JBoss EAP to WildFly on AKS](/azure/developer/java/migration/migrate-jboss-eap-to-wildfly-on-azure-kubernetes-service) | TBD |

### WebLogic to Azure

| Link | Description |
|---|---|
| [WebLogic to Azure Virtual Machines](/azure/developer/java/migration/migrate-weblogic-to-virtual-machines) | TBD |
| [WebLogic with Microsoft Entra ID via LDAP](/azure/developer/java/migration/migrate-weblogic-with-aad-ldap) | TBD |
| [WebLogic with Application Gateway](/azure/developer/java/migration/migrate-weblogic-with-app-gateway) | TBD |

## SAP

| Link | Description |
|---|---|
| [Migrate an SAP platform to Azure](/azure/cloud-adoption-framework/scenarios/sap/migrate) | TBD |
| [Learning path for Migrate SAP workloads to Azure](/training/paths/migrate-sap-workloads-to-azure/) | TBD |
| [SAP on Azure migration](https://azure.microsoft.com/solutions/sap/migration/) | TBD |
| [Migrate from SAP ASE to Azure SQL](/azure/azure-sql/migration-guides/database/sap-ase-to-sql-database) | TBD |

## Specialized workloads

| Link | Description |
|---|---|
| [Azure NetApp Files](https://azure.microsoft.com/services/netapp/) | TBD |
| [Cray in Azure](https://azure.microsoft.com/solutions/high-performance-computing/cray/) | TBD |

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
| [Azure Lighthouse for scale migration](/azure/lighthouse/how-to/migration-at-scale) | TBD |

## Mainframes

| Link | Description |
|---|---|
| [Overview](../infrastructure/mainframe-migration/index.md) | TBD |
| [Switch from mainframes to Azure](../infrastructure/mainframe-migration/migration-strategies.md) | TBD |
| [Mainframe application migration](../infrastructure/mainframe-migration/application-strategies.md) | TBD |

## Migrate secure workloads

| Link | Description |
|---|---|
| [Azure database security best practices](/azure/azure-sql/database/security-best-practice) | TBD |
| [Azure data security and encryption best practices](/azure/security/fundamentals/data-encryption-best-practices) | TBD |
| [Azure PaaS best practices](/azure/security/fundamentals/paas-deployments) | TBD |
| [Azure Service Fabric security best practices](/azure/security/fundamentals/service-fabric-best-practices) | TBD |
| [Best practices for Azure VM security](/azure/security/fundamentals/iaas) | TBD |
| [IoT security best practices](/azure/iot-fundamentals/iot-security-best-practices) | TBD|
| [Securing PaaS databases in Azure](/azure/security/fundamentals/paas-applications-using-sql) | TBD |
| [Securing PaaS web and mobile applications using Azure App Service](/azure/security/fundamentals/paas-applications-using-app-services) | TBD |
| [Securing PaaS web and mobile applications using Azure Storage](/azure/security/fundamentals/paas-applications-using-storage) | TBD |
| [Security best practices for IaaS workloads in Azure](/azure/security/fundamentals/iaas) | TBD |
