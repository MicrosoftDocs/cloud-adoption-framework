---
title: Mainframe application migration strategies
description: Learn how to use rehost, retire, rebuild, or replace applications strategies to migrate from mainframe environments to Azure.
author: njray
ms.author: pnp
ms.date: 08/09/2022
ms.topic: conceptual
ms.custom: think-tank
---

# Mainframe application migration strategies

When most teams migrate applications from mainframe environments to Azure, they generally follow a pragmatic approach: reuse wherever and whenever possible. Then, they start a phased deployment where applications are rewritten or replaced.

Application migration typically involves one or more of the following strategies:

- *Rehost:* Move existing code, programs, and applications from the mainframe. Recompile the code to run in a mainframe emulator hosted in a cloud instance. This approach typically starts with moving applications to a cloud-based emulator, and then migrating the database to a cloud-based database. Some engineering and refactoring are required with this strategy, along with data and file conversions.

    Alternatively, you can rehost using a traditional hosting provider. One of the principal benefits of the cloud is outsourcing infrastructure management. Find a datacenter provider that hosts your mainframe workloads for you. This model can buy some time, reduce vendor lock in, and produce interim cost savings.

- *Retire:* Retire applications that are no longer needed before migration.

- *Rebuild:* Some organizations choose to completely rewrite programs using modern techniques. Given the added cost and complexity of this approach, it's not as common as a lift-and-shift approach. Often after this type of migration, it makes sense to begin replacing modules and code using code transformation engines.

- *Replace:* This approach replaces mainframe functionality with equivalent features in the cloud. Software as a service (SaaS) is one option. With Saas, you're using a solution created specifically for an enterprise concern, such as finance, human resources, manufacturing, or enterprise resource planning. Also, many industry-specific applications are now available to solve problems that custom mainframe solutions used to previously solve.

Start by planning the workloads that you want to initially migrate, and then determine the requirements for moving associated applications, legacy code bases, and databases.

## Mainframe emulation in Azure

Azure services can emulate traditional mainframe environments. You can then reuse existing mainframe code and applications. You can emulate common server components such as online transaction processing (OLTP), batch, and data ingestion systems.

### OLTP systems

Many mainframes have OLTP systems that process thousands or millions of updates for large numbers of users. These applications often use transaction processing and screen-form handling software, such as Customer Information Control System (CICS), Information Management System (IMS), and Terminal Interface Processor (TIP).

When you move OLTP applications to Azure, emulators for mainframe transaction processing (TP) monitors can run as infrastructure as a service (IaaS) using virtual machines (VMs) on Azure. The web servers can also implement screen handling and form functionality. Combine this approach with database APIs, such as ActiveX Data Objects (ADO), Open Database Connectivity (ODBC), and Java Database Connectivity (JDBC) for data access and transactions.

### Time-constrained batch updates

Many mainframe systems perform monthly or annual updates of millions of account records, such as those used in banking, insurance, and government. Mainframes handle these types of workloads by offering high-throughput data handling systems. Mainframes batch jobs are typically serial in nature and depend on the input and output operations per second (IOPS) provided by the mainframe backbone for performance.

Cloud-based batch environments use parallel compute and high-speed networks for performance. If you need to optimize batch performance, Azure provides various compute, storage, and networking options.

### Data ingestion systems

Mainframes ingest large batches of data from retail, financial services, manufacturing, and other solutions for processing. With Azure, you can use simple command-line utilities such as [AzCopy](/azure/storage/common/storage-use-azcopy-v10) for copying data to and from a storage location. You can also use the [Azure Data Factory](/azure/data-factory/introduction) service, to ingest data from disparate data stores and to create and schedule data-driven workflows.

In addition to emulation environments, Azure provides platform as a service (PaaS) and analytics services that can enhance existing mainframe environments.

## Migrate OLTP workloads to Azure

The lift-and-shift approach is the no-code option for quickly migrating existing applications to Azure. Each application migrates as is, which provides the benefits of the cloud without the risks or costs of making code changes. Using an emulator for mainframe transaction processing (TP) monitors on Azure supports this approach.

TP monitors are available from various vendors and run on virtual machines, an infrastructure as a service (IaaS) option on Azure. The following diagrams show the before and after of an online application backed by IBM DB2, a relational database management system (DBMS), on an IBM z/OS mainframe. DB2 for z/OS uses Virtual Storage Access Method (VSAM) files to store the data and Indexed Sequential Access Method (ISAM) for flat files. This architecture also uses CICS for transaction monitoring.

![Diagram of a "lift and shift" migration of a mainframe environment to Azure using emulation software.](../../_images/mainframe-migration/mainframe-vs-azure.png)

On Azure, emulation environments run the TP manager and the batch jobs that use JCL. In the data tier, DB2 is replaced by [Azure SQL Database](/azure/azure-sql/database/sql-database-paas-overview), although you can also use Microsoft SQL Server, DB2 LUW, or Oracle Database. An emulator supports IMS, VSAM, and SEQ. The mainframe's system management tools are replaced by Azure services, and software from other vendors, that run in VMs.

Web servers commonly implement the screen handling and form entry functionality, which you can combine with database APIs, such as ADO, ODBC, and JDBC for data access and transactions. The exact line-up of Azure IaaS components to use depends on the operating system you prefer. For example:

- *Windows-based VMs:* Internet Information Server (IIS) along with ASP.NET for the screen handling and business logic. Use ADO.NET for data access and transactions.

- *Linux-based VMs:* Java-based application servers, such as Apache Tomcat process screen handling and Java-based business functionality. Use JDBC for data access and transactions.

## Migrate batch workloads to Azure

Batch operations in Azure differ from the typical batch environment on mainframes. Mainframe batch jobs are typically serial in nature and depend on the IOPS provided by the mainframe backbone for performance. Cloud-based batch environments use parallel computing and high-speed networks for performance.

To optimize batch performance using Azure, consider the [compute](/azure/virtual-machines/windows/overview), [storage](/azure/storage/blobs/storage-blobs-introduction), [networking](https://azure.microsoft.com/blog/maximize-your-vm-s-performance-with-accelerated-networking-now-generally-available-for-both-windows-and-linux/), and [monitoring](/azure/azure-monitor/overview) options as follows.

### Compute

Use:

- VMs with the highest clock speed. Mainframe applications are often single-threaded and mainframe CPUs have a high clock speed.

- VMs with large memory capacity to allow caching of data and application work areas.

- VMs with higher density vCPUs to take advantage of multithreaded processing if the application supports multiple threads.

- Parallel processing, as Azure easily scales out for parallel processing, delivering more compute power for a batch run.

### Storage

Use:

- [Azure Premium SSDs](/azure/virtual-machines/disks-types#premium-ssd) or [Azure Ultra Disk Storage](/azure/virtual-machines/disks-types#ultra-ssd-preview) for maximum available IOPS.

- Striping with multiple disks for more IOPS per storage size.

- Partitioning for storage to spread I/O over multiple Azure Storage devices.

### Networking

- Use [Azure accelerated networking](/azure/virtual-network/create-vm-accelerated-networking-powershell) to minimize latency.

### Monitoring

- Use monitoring tools, [Azure Monitor](/azure/azure-monitor/overview), [Application Insights](/azure/azure-monitor/app/app-insights-overview), and Azure logs. These tools help you monitor over-performing batch runs and reduce bottlenecks.

## Migrate development environments

The cloud's distributed architectures rely on a different set of development tools that provide the advantage of modern practices and programming languages. To ease this transition, use a development environment with other tools that are designed to emulate IBM z/OS environments. The following list shows options from Microsoft and other vendors:

| Component        | Azure options                                                                                                                                  |
|------------------|---------------------------------------------------------------------------------------------------------------------------------------------------|
| z/OS             | Windows, Linux, or Unix                                                                                                                      |
| CICS             | Azure services offered by Micro Focus, Oracle, GT Software (Fujitsu), TmaxSoft, Raincode, and NTT DATA, or rewrite using Kubernetes |
| IMS              | Azure services offered by Micro Focus and Oracle                                                                                  |
| Assembler        | Azure services from Raincode and TmaxSoft; or COBOL, C, or Java, or map to operating system functions               |
| JCL              | JCL, PowerShell, or other scripting tools                                                                                                   |
| COBOL            | COBOL, C, or Java                                                                                                                            |
| Natural          | Natural, COBOL, C, or Java                                                                                                                  |
| Fortran and PL/I | Fortran, PL/I, COBOL, C, or Java                                                                                                           |
| REXX and PL/I    | REXX, PowerShell, or other scripting tools                                                                                                  |

## Migrate databases and data

Application migration usually involves rehosting the data tier. You can migrate SQL Server, open-source, and other relational databases to fully managed solutions on Azure. You can use [Azure SQL Managed Instance](/azure/azure-sql/managed-instance/sql-managed-instance-paas-overview), [Azure Database for PostgreSQL](/azure/postgresql/overview), and [Azure Database for MySQL](/azure/mysql/overview) with [Azure Database Migration Service](/azure/dms/dms-overview).

For example, you can migrate if the mainframe data tier uses:

- IBM DB2 or an IMS database, use Azure SQL Database, SQL Server, DB2 LUW, or Oracle Database on Azure.

- VSAM and other flat files, use Indexed Sequential Access Method (ISAM) flat files for Azure SQL Database, SQL Server, DB2 LUW, or Oracle.

- Generation date groups (GDGs), migrate to files on Azure that use a naming convention and filename extensions that provide similar functionality to GDGs.

The IBM data tier includes several key components that you must also migrate. For example, when you migrate a database, you also migrate a collection of data contained in pools, each containing dbextents, which are z/OS VSAM data sets. Your migration must include the directory that identifies data locations in the storage pools. Also, your migration plan must consider the database log, which contains a record of operations performed on the database. A database can have one, two (dual or alternate), or four (dual and alternate) logs.

Database migration also includes these components:

- *Database manager:* Provides access to data in the database. The database manager runs in its own partition in a z/OS environment.
- *Application requester:* Accepts requests from applications before passing them to an application server.
- *Online resource adapter:* Includes application requester components for use in CICS transactions.
- *Batch resource adapter:* Implements application requester components for z/OS batch applications.
- *Interactive SQL (ISQL):* Runs as a CICS application and interface and lets users enter SQL statements or operator commands.
- *CICS application:* Runs under the control of CICS, using available resources and data sources in CICS.
- *Batch application:* Runs process logic without interactive communication with users to, for example, produce bulk data updates or generate reports from a database.

## Optimize scale and throughput for Azure

Generally speaking, mainframes scale up, while the cloud scales out. To optimize scale and throughput of mainframe-style applications running on Azure, it's important to understand how mainframes separate and isolate applications. A z/OS mainframe uses a feature called logical partitions (LPARs) to isolate and manage the resources for a specific application on a single instance.

For example, a mainframe might use one LPAR for a CICS region with associated COBOL programs, and a separate LPAR for DB2. Other LPARs are often used for the development, testing, and staging environments.

On Azure, it's more common to use separate VMs to serve this purpose. Azure architectures typically deploy VMs for the application tier, a separate set of VMs for the data tier, another set for development, and so on. You can optimize each tier of processing using the most suitable type of VMs and features for that environment.

In addition, each tier can also provide appropriate disaster recovery services. For example, production and database VMs might require a hot or warm recovery, while the development and testing VMs support a cold recovery.

The following figure shows a possible Azure deployment using a primary and a secondary site. In the primary site, the production, staging, and testing VMs deploy with high availability. The secondary site is for backup and disaster recovery.

![Diagram of a possible Azure deployment using a primary and a secondary site.](../../_images/mainframe-migration/migration-backup-dr.png)

## Perform a staged migration to Azure

Moving solutions from a mainframe to Azure might involve a *staged* migration. You move some applications first, while others remain on the mainframe temporarily or permanently. This approach typically requires systems that let applications and databases interoperate between the mainframe and Azure.

A common scenario is to move an application to Azure while keeping the data used by the application on the mainframe. Specific software enables the applications on Azure to access data from the mainframe. Fortunately, a wide range of solutions provide integration between Azure and existing mainframe environments, support for hybrid scenarios, and migration over time. Microsoft partners, independent software vendors, and system integrators can help you on your journey.

One option is [Microsoft Host Integration Server](/host-integration-server/). This solution provides the distributed relational database architecture (DRDA) required for applications in Azure. It lets the applications access data in DB2 that remains on the mainframe. Other options for mainframe-to-Azure integration include solutions from IBM, Attunity, Codit, other vendors, and open-source options.

## Partner solutions

If you're considering a mainframe migration, the partner ecosystem can help.

Azure provides a proven, highly available, and scalable infrastructure for systems that currently run on mainframes. Some workloads can migrate with relative ease. You can rehost other workloads that depend on legacy system software, such as CICS and IMS. Use partner solutions and migrate them to Azure over time. Regardless of the choice you make, Microsoft and our partners can help you optimize for Azure while maintaining mainframe system software functionality.

## Learn more

For more information, see the following resources:

- [Get started with Azure](/azure/)

- [Deploy IBM DB2 pureScale on Azure](/azure/virtual-machines/workloads/mainframe-rehosting/ibm/deploy-ibm-db2-purescale-azure/)

- [Host Integration Server documentation](/host-integration-server/)
