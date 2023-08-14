---
title: SQL Server database security for SAP on Azure
description: Learn how to enable SAP with SQL Server database security on Azure by using transparent data encryption, backup encryption, and proper configurations.
author: msclash
ms.author: pameshra
ms.reviewer: tozimmergren
ms.date: 07/18/2023
ms.topic: conceptual
ms.subservice: scenario
ms.custom: think-tank, e2e-sap, UpdateFrequency2
---

# SQL Server database security for SAP on Azure

This article is part of the "SAP extend and innovate security: Best practices" article series.

- [SQL Server database security for SAP on Azure](./sap-lza-database-security.md)
- [Microsoft Sentinel for SAP on Azure](./sap-lza-sentinel-for-sap.md)
- [Security operations for SAP on Azure](./sap-lza-security-operations.md)

This article provides security considerations and recommendations for SAP on Azure that runs on a SQL Server database.

## Secure data at rest

The [SQL Server transparent data encryption (TDE)](/sql/relational-databases/security/encryption/transparent-data-encryption) encrypts the data and log files for user databases and SQL Server system databases. After it's encrypted, copies of the data and log files or backup files can't be restored and used without the associated certificates. This process is called securing data at rest. It's a transparent technology to the SAP system, so it's supported by [SAP note 1380493 - SQL Server TDE](https://me.sap.com/notes/1380493). For information about the TDE procedure, see [SQL Server encryption](/sql/relational-databases/security/encryption/sql-server-encryption).

All data pages that are read or written to disk must be encrypted or decrypted, so TDE has a CPU penalty. When TDE is applied to a user database, the CPU usage increases between 3% and 8%. Applications that heavily use TempDB of SQL Server or perform large scans on large tables are more affected. When at least one user database on the SQL Server instance is encrypted with TDE, the system databases, like TempDB, are also encrypted. SAP Business Warehouse (SAP BW) is an example of this type of application.

> [!NOTE]
>If the encryption keys or certificates are lost, the data in the encrypted database is lost. It's important to establish extensive processes and steps to secure the certificate backups.

A successful TDE implementation needs good and thorough testing and well-designed processes to handle certificates and certificate backups.

## Unsupported SQL Server features

SQL Server also offers other features for data protection. These methods allow partial encryption or masking on database column granularity:

- [SQL Server column encryption](/sql/relational-databases/security/encryption/encrypt-a-column-of-data)
- [SQL Server dynamic data masking](/sql/relational-databases/security/dynamic-data-masking)
- [SQL Server always encrypted](/sql/relational-databases/security/encryption/always-encrypted-database-engine)

Based on the restrictions of these three methods and the changes they require on many areas of the SAP NetWeaver components, these functionalities aren't supported by SAP.

Real-time replication between a TDE-enabled database on SQL Server and SAP HANA isn't supported. For more information, see [SAP OSS note 2812637 - Real-time replication isn't supported for TDE-enabled MSSQL Server database](https://me.sap.com/notes/2812637/E).

## Backup encryption

Backup encryption is when you encrypt the backup file while the backup is taken. It encrypts all the data pages in the backup file and creates a certificate or asymmetric key requirement to restore the backup file, which prevents an unauthorized restore.

If the database isn’t encrypted with TDE before the encrypted backup is taken, it still isn’t encrypted after the restore. Only the backup files get encrypted. The database file and its content aren’t altered.

You can use backup encryption with TDE, but it’s not beneficial because the data is already encrypted in the database files and in the backup files. When you use backup encryption and TDE together, the encrypted database with the TDE certificate or key-encrypted data pages are encrypted again with the backup certificate or key. This method prolongs the backup process and adds extra CPU load to the system while the backup process runs.

## Secure SQL Server and SAP system

Server and operating system-level hardening are essential to a secure running system.

Adhere to the following recommendations to secure [SQL Server](/sql/relational-databases/security/securing-sql-server) and your SAP system. For more information, see [SAP OSS note 2417205](https://me.sap.com/notes/2417205).

SQL Server is based on the Windows implementation of the Transport Layer Security (TLS) protocol and the Secure Sockets Layer (SSL) protocol through the SCHANNEL Security Support Provider (SSP).

You can disable the SSL protocol because TLS is widely used and supported. Most of the SQL Server and SAP product support use the [TLS 1.2](https://support.microsoft.com/topic/kb3135244-tls-1-2-support-for-microsoft-sql-server-e4472ef8-90a9-13c1-e4d8-44aad198cdbe) protocol.

You can control most of the security settings for the SCHANNEL SSP through registry changes in the corresponding SCHANNEL branch. With these settings, you can control:

- Which protocols, like SSL and TLS, are enabled for the client and server part of the dialog.
- The ciphers, for example RC2, RC4, Triple DES, and AES, that are enabled and the order that they're enabled.
- The hash algorithms, for example MD5 and SHA.
- The key exchange algorithms, for example Diffie-Hellman and ECDH.

The various combinations of these parts, such as the protocol, cipher, and hash and key exchange algorithm, are represented in cipher suites. By disabling one of these parts, for example protocol SSL 2.0, all cipher suites that contain this part are unusable for the system.

> [!NOTE]
>When you combine multiple changes, the client, for example the SAP system, and the server, for example SQL Server, might not be able to use a cipher suite to communicate, and the SAP system might not start.

You can also control the priority and availability of cipher suites on the system in the local group policy editor.

1. Go to Local Computer Policy > Computer Configuration > Administrative Templates > Network > SSL Configuration Settings.
1. Define a [custom SSL cipher suite order](/windows/client-management/mdm/policy-csp-admx-ciphersuiteorder).

:::image type="content" source="./media/sap-lza-ssl-configuration.png" alt-text="Screenshot that shows the SSL configuration." lightbox="./media/sap-lza-ssl-configuration.png":::
  
This list order defines the priority that the system uses cipher suites. If you remove a cipher suite from the list, it's no longer usable in the system. The group policy setting has priority over the SCHANNEL registry setting. The security department usually controls this setting based on group policies. But the SAP Basis or SQL Server database administration group handles the resulting connection issues.

Consider using the SAP tool, SCoTT, to analyze problems with disabled protocols or cipher suites. The tool can analyze connection problems between the SAP system, like ABAP and Java, and SQL Server that runs on Linux or Windows. For more information, see [SAP note 2846170](https://me.sap.com/notes/2846170/E).

## Authentication

Here are some considerations for authentication with SAP on Azure.

- **SAP NetWeaver on SQL Server** has specific requirements for the SAP and SQL Server startup accounts, authentication to the SQL Server instance, SAP database, and DBA access. For more information, see [SAP note 1645041 - SQL Server logins and their usage in SAP environments](https://me.sap.com/notes/1645041/E).

- The **SAP ABAP NetWeaver system** doesn't require SQL Server logins because all connections use Windows authentication. For example, for the user `SAPService<SID>` or `<SID>administrator`, you can disable the SQL Server authentication feature.

- The **SAP JAVA NetWeaver system** requires the SQL Server authentication feature because it uses a SQL Server login, such as `SAP<SID>DB`, for the connection.

- For **SAP on SQL Server**, you can disable the SQL Server system administrator account because the SAP systems on SQL Server don't use the account. Ensure that another user with system administrator rights can access the server before disabling the original system administrator account.

- **A high-availability system that uses SQL Server AlwaysOn** has specific requirements for logins, users, and jobs. All servers that are connected to the system must have the exact same logins and users, so the SAP system can connect even if a failover to another node occurs. All SAP-related SQL Server jobs must have the same owner on all AlwaysOn nodes. For more information, see [Synchronize SAP logins, jobs, and objects](https://techcommunity.microsoft.com/t5/running-sap-applications-on-the/always-on-synchronize-sap-login-jobs-and-objects/ba-p/367942).

- **SQL injection** is when [malicious code merges into SQL statements](/sql/relational-databases/security/sql-injection) that run on SQL Server. When a report runs in the SAP system, it generates generic SQL statements from the ABAP code of the report. The statements are sent to and transformed by the SAP database layer for SQL Server.

  This database layer is integrated into the SAP work process and isn't accessible from the outside. After the transformation into SQL Server-specific statements, they're sent to the database and run. The result is returned to the calling report. These statements can only be manipulated between the database layer of the SAP system and the SQL Server instance, which is called a man-in-the-middle attack.
  
  In the SAP system, use encrypted connections between the work process and the SQL Server database to prevent these attacks. The `DBACockpit` transaction has a rudimentary SQL command window to run basic SQL statements. For more information, see [SAP note 1027512 - MSSQL: DBA cockpit for basis release 7.00 and later](https://launchpad.support.sap.com/#/notes/1027512).

## Audit

- **Disable `xp_cmdshell`.** The SQL Server feature `xp_cmdshell` enables a SQL Server internal operating system command shell. It's a potential risk in security audits.  

  This feature is on when you install SAP. It gathers and displays operating system data in transaction `DBACockpit`. If you disable the setting, some monitoring data isn't available in transaction `DBACockpit` and a warning message displays in the `DBACockpit` message window. For more information, see [SAP KBA 2283909 - Side effect in monitoring](https://userapps.support.sap.com/sap/support/knowledge/en/2283909) and [SAP note 3019299 - Security audit questions or security customization in NetWeaver and SQL Server systems](https://me.sap.com/notes/3019299/E).

- **Properly configure virus scanners.** SAP supports virus scanners to protect against viruses and other malware, but a poorly configured virus scanner can cause performance issues or even database corruption. To set up and configure a virus scanner on the operating system for an SAP NetWeaver system, see [SAP note 106267 - Virus scanner software on Windows](https://service.sap.com/sap/support/notes/106267). For a SQL Server database, set the proper configurations to avoid performance and corruption problems. For detailed configurations, see [How to choose antivirus software to run on computers that run SQL Server](https://support.microsoft.com/topic/how-to-choose-antivirus-software-to-run-on-computers-that-are-running-sql-server-feda079b-3e24-186b-945a-3051f6f3a95b).

## Next steps

- [Sentinel for SAP](./sap-lza-sentinel-for-sap.md)
