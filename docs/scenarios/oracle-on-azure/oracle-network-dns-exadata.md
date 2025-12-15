---
title: Oracle Database@Azure DNS 
description: Learn about key design considerations and recommendations for Oracle Database@Azure network topology and connectivity for your landing zone.
author: terrymandin
ms.author: author: terrymandin
ms.reviewer: sihbher
ms.date: 12/08/25
ms.topic: concept-article
ms.custom: e2e-oracle
---
# Domain Name Service (DNS) for Oracle Database@Azure Exadata

This article outlines key considerations and best practices for configuring Domain Name Service (DNS) when deploying Oracle Database@Azure Exadata. Its primary objective is to deliver technical guidance that supports a reliable and optimized cloud environment, ensuring a seamless customer experience. The content assumes familiarity with Oracle Database technologies and as Azure compute and networking fundamentals. As part of your planning and architecture design process, refer to this resource for detailed recommendations. For additional context, see [Private Link and DNS integration at scale](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/private-link-and-dns-integration-at-scale) and [DNS for on-premises and Azure resources](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/dns-for-on-premises-and-azure-resources). 

This guidance addresses critical considerations for Domain Name Service (DNS) configuration when deploying Oracle Database@Azure. At an enterprise level, DNS design impacts service reliability, security posture, and interoperability across hybrid environments. Misalignment can lead to name resolution failures, operational delays, and increased support costs. Establishing clear standards ensures consistent deployments and reduces risk.

Here’s a structured Cloud Adoption Framework (CAF) guidance document for **Oracle Database\@Azure DNS** that aligns with enterprise governance principles:


## **Private DNS Zones (Default)**

Link **Azure-provided default private DNS zones** to hub virtual networks unless the organization explicitly requires:

*   Custom namespaces for internal governance or branding.
*   Integration with a third-party DNS solution.
*   Advanced governance controls beyond what Azure DNS offers.

**Why this matters:**  
Default DNS reduces complexity, accelerates deployment, and ensures alignment with Azure-native services. It minimizes operational overhead and supports consistent governance across environments.


## **Custom DNS**

Custom DNS is supported but requires **manual setup and lifecycle management**. This option should be reserved for:

*   Organizations with strict namespace requirements.
*   Scenarios where DNS policies are tied to compliance frameworks.
*   Environments that mandate integration with external DNS providers.

**Trade-offs:**  
While custom DNS offers flexibility, it introduces more operational burden and risk of misconfiguration. Governance teams must define approval workflows and document configuration standards.

## **Hybrid Integration**

For on-premises integration, use **Azure Private DNS Resolver** to bridge DNS resolution between on-premises and Azure-hosted Oracle databases.

**Why this matters:**  
This approach ensures seamless name resolution across hybrid environments without exposing private endpoints publicly. It supports compliance and security objectives by maintaining private connectivity.

## **Scaling DNS Across a Large Number of instances**

When your team deploys a large number of Oracle Database@Azure Exadata instances, the process of managing and linking multiple private DNS zones can become an operational burden.

*   Consider **network anchors** (hub-and-spoke or virtual network peering models) to centralize DNS resolution.
*   Define governance policies for anchor networks to prevent sprawl and maintain security boundaries.

**Why this matters:**  
Centralized DNS resolution reduces administrative overhead, improves scalability, and enforces consistent governance across multiple workloads.


## Next step

Now that you understand Domain Name Service (DNS) for Oracle Database@Azure Exadata, see the [Business Continuity and Disaster Recovery (BCDR) design](./business-continuity-disaster-recovery-connectivity-design.md) guidance. This guidance helps you establish the required network foundations and best practices needed to support business continuity and disaster recovery strategies.
