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
# Oracle Database@Azure DNS 

This article outlines key considerations and best practices for configuring Domain Name Service (DNS) when deploying Oracle Database@Azure Exadata.  Its primary objective is to deliver technical guidance that supports a reliable and optimized cloud environment, ensuring a seamless customer experience. The content assumes familiarity with Oracle Database technologies as well as Azure compute and networking fundamentals. As part of your planning and architecture design process, refer to this resource for detailed recommendations. For additional context, see [Private Link and DNS integration at scale](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/private-link-and-dns-integration-at-scale) and [DNS for on-premises and Azure resources](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/dns-for-on-premises-and-azure-resources). 

This guidance addresses critical considerations for Domain Name Service (DNS) configuration when deploying Oracle Database@Azure. At an enterprise level, DNS design impacts service reliability, security posture, and interoperability across hybrid environments. Misalignment can lead to name resolution failures, operational delays, and increased support costs. Establishing clear standards ensures consistent deployments and reduces risk.

This documentation examines three primary DNS configuration models that influence name resolution and connectivity across hybrid environments. Selecting the right topology is critical for ensuring operational stability, compliance with organizational standards, and seamless integration between Azure and Oracle Cloud Infrastructure.

The following DNS topologies will be discussed in more detail:

1.  **Default DNS Configuration**  
    Uses the automatically provisioned Oracle domain (`oraclevcn.com`) within Azure. This approach simplifies deployment but offers limited flexibility for organizations that require custom namespaces or advanced governance.

2.  **Custom DNS Configuration**  
    Enables alignment with enterprise naming standards (e.g., `contoso.com`). This option supports greater control and consistency across multi-cloud environments but requires additional planning for private zones, resolvers, and forwarding rules.

3.  **On-Premises DNS Integration**  
    Extends existing corporate DNS infrastructure into the cloud environment. This model is essential for organizations with strict compliance requirements or complex hybrid architectures, ensuring unified name resolution across on-premises and cloud resources.
a

## Default DNS

By default, Oracle Exadata uses the **oraclevcn.com** domain. This zone is automatically provisioned in Azure as a private DNS zone linked to the Oracle Database\@Azure virtual network. After deployment, records from Oracle Cloud Infrastructure (OCI) populate this zone automatically.

**Why this matters:**  
Relying on defaults simplifies initial setup but limits flexibility for organizations that require custom namespaces for compliance or multi-cloud integration. Enterprises should decide early whether to adopt the default domain or enforce custom DNS zones to maintain naming consistency across environments.

### Default DNS Setup

Use the default DNS domain and private DNS zones that were automatically created when the Oracle Database@Azure Exadata cluster was provisioned. The default OCI DNS domain is oraclevcn.com, while Azure’s default DNS relies on the IP address 168.63.129.16.

If a custom DNS domain is not selected during deployment, Oracle Exadata uses the default domain oraclevcn.com. This zone is automatically provisioned in Azure as a private DNS zone linked to the Oracle Database@Azure virtual network. After deployment, DNS records from Oracle Cloud Infrastructure (OCI) are automatically populated into the oraclevcn.com private DNS zone in Azure.

1. **DNS Namespace**
    * oraclevcn.com will be the default DNS namespace since there are no custom DNS domains.
    * No need to create this DNS zone, it will be auto-generated and associated with your VCN container and Azure subscription as a private zone.
1. **Create Virtual Network**
    * In your Azure subscription, create the virtual network for Oracle Database @ Azure.
    * Configure it to use custom DNS if other resources will be deployed; otherwise, Azure DNS will be used.
1. **Provision Oracle Database**
    * Provision Oracle Database @ Azure Infrastructure and Oracle Exadata VM Cluster resources from the OracleDB @ Azure blade in Azure.
    * Leave the DNS custom checkbox unchecked.
    * Create a hostname prefix (e.g., oradb) and logical database name.
    * Accept system-generated default names for other settings.
1. **Private Zone Linking**
    * The oraclevcn.com private zone will be linked to the Oracle Database @ Azure virtual network during cluster provisioning.
1. **DNS Records**
    * After deployment, oraclevcn.com records will appear in the private DNS zone in Azure.
    * The SCAN FQDN DNS record will also be created.
1. **Virtual Network Link**
    * Create a virtual network link from the oraclevcn.com private DNS domain in Azure to the virtual network with other custom DNS IaaS servers or Azure Private DNS Resolver service.
1. **Query DNS Zone**
    * Query the private DNS zone of oraclevcn.com in your Azure subscription or create a CNAME in your DNS servers pointing to the SCAN FQDN to use the domain name after deploying Oracle Database @ Azure.
1. **Communication Needs**
    * If Oracle Database @ Azure needs to communicate with Azure resources (e.g., storage), create private DNS zones with DNS private views.
1. **Update OCI Compartment**
    * In the OCI compartment, update DNS private views to add any additional Azure DNS views needed for Oracle Database @ Azure to resolve and communicate.
1. **Test DNS Resolution**
    * Test name resolution from Oracle Database @ Azure to Azure resources (e.g., NFS shares).
    * Test from Azure subscription and on-premises hosts.
    * Ensure connectivity to the SCAN FQDN of the Oracle Database @ Azure cluster.


## Custom DNS 

If your organization mandates a custom DNS domain (e.g., **contoso.com**), the following must be in place **before deploying the Exadata Cluster**:

Before deploying the Exadata Cluster with a custom DNS domain (e.g., contoso.com), you must create a private view and private zone in OCI. Refer to Private DNS Resolvers for details. Note that the private resolver created in the OCI Private View is not authoritative; it only supports name resolution external to the OCI VCN compartment.

1.  **Create Private View and Private Zone.**  
    These components enable name resolution within Oracle Database\@Azure while aligning with enterprise DNS standards. Failure to configure them upfront can disrupt provisioning workflows.

2.  **Understand Resolver Authority.**  
    The private resolver in OCI’s Private View is **not authoritative**; it only supports name resolution external to the OCI VCN compartment. Enterprises should plan authoritative DNS paths to avoid ambiguity in hybrid name resolution.

3.  **Plan Forwarding Rules Early.**  
    If your architecture requires forwarding to another DNS server, configure this in the OCI DNS console before deployment. This ensures seamless resolution across on-premises and cloud networks.  
    *Reference:* [DNS in a Virtual Cloud Network](https://docs.oracle.com/en-us/iaas/Content/Network/Concepts/dns.htm)

### Custom DNS Setup

In this scenario, a custom DNS domain will be configured for Oracle Database@Azure, such as contoso.com. Oracle Cloud Infrastructure (OCI) supports up to two subdomains under this domain, for example: oradb.prod.contoso.com.

1.  **Create Private DNS Resolver in OCI**
    *   Before deploying Oracle Database\@Azure:
        *   Go to the OCI portal.
        *   Select **DNS in the VCN compartment**.
        *   Create a **private DNS resolver** (e.g., `contoso.com`) under **Private Views**.
        *   Add multiple private DNS resolvers and views.
    *   These zones are used only for Oracle Database\@Azure external DNS name resolution from OCI for Azure resources.

1.  **Create Virtual Network in Azure**
    *   In your Azure subscription:
        *   Create the virtual network for Oracle Database\@Azure.
        *   Configure it to use **custom DNS** if Azure resources will be deployed such as virtual machines.
        *   Use **default Azure DNS** if no other resources will be deployed.

1.  **Private Zone Behavior**
    *   The `oraclevcn.com` private zone in Azure will **not** be created when custom DNS is selected.

1.  **Provision Oracle Database\@Azure**
    *   Deploy Oracle Database\@Azure Infrastructure and Oracle Exadata VM Cluster resources from the **Oracle Database\@Azure blade** in Azure.
    *   **Select the Custom DNS checkbox**.
        *   Choose the private view of your custom DNS zone (`contoso.com`) from the dropdown.
    *   Create a **hostname prefix** (e.g., `oradb`) for the virtual cluster name.
    *   Records will be added to the custom domain in OCI.
    *   **Manually duplicate the DNS records of Oracle Database\@Azure into your production DNS zone (`contoso.com`)**.

1.  **Add Additional Azure Private DNS Zones**
    *   In the OCI compartment:
        *   Update DNS Private Views to add additional Azure DNS views as needed for Oracle Database\@Azure communication with Azure resources.
    *   If you want to resolve on-premises hosts:
        *   Update those records in the OCI Private View of `contoso.com`.

1.  **Test DNS Name Resolution**
    *   From an Azure client:
        *   Connect to the SCAN FQDN of the Oracle Database\@Azure cluster.
        *   Ensure Oracle Database\@Azure can communicate with other Azure resources like NFS mounts.
        *   Test name resolution for on-premises hosts.

Here’s the clean, numbered checklist extracted and formatted for documentation from the screenshot:

***

## Oracle Database\@Azure External DNS Setup

Oracle Database\@Azure has been deployed in Azure using the defaults or custom DNS. The goal is to facilitate name resolution for Oracle Database\@Azure externally. Primary focus will be resources in Azure.

1.  **Understand DNS Dependency**  
    *   Oracle Database\@Azure relies on DNS infrastructure within the OCI compartment for name resolution, not Azure virtual network DNS settings.
    *   Custom DNS and Azure private zones must be created in OCI DNS Private Views.
    *   These zones mirror DNS records of your custom DNS zone (e.g., `contoso.com`) or Azure private DNS zones.
    *   These are **not authoritative**.
1.  **Configure OCI Private DNS Resolver**
    *   An OCI private DNS resolver in a private view supports DNS queries only from the OCI compartment and is not authoritative.
    *   Operates based on private views, private zones, and resolver rules.
    *   Responds only to clients accessible through an Oracle Cloud Virtual Network (VCN) within the OCI compartment where Oracle Database\@Azure is deployed.
1.  **Associate Required DNS Components**  
    Ensure the following are associated with your OCI VCN compartment to support DNS resolution for Azure and internet resources:
    *   **Private Views:**
        *   Includes `oraclevcn.com` domain with specific settings assigned at OCI compartment if custom DNS was not selected.
    *   **Private DNS Resolvers:**
        *   Can include your custom DNS zone and Azure private DNS zones to mirror what has been deployed in Azure.  
            Oracle Database\@Azure relies on this DNS infrastructure for external communication with Azure resources.
1.  **Update OCI DNS Records**
    *   Add new records in OCI whenever new IPs or hostnames are added in Azure.
    *   Ensure DNS records mirror Azure resources accurately.
1.  **Test DNS Resolution**
    *   From Oracle Database\@Azure instances, verify communication with Azure resources.
    *   Test name resolution for on-premises hosts from Oracle Database\@Azure.
    *   Confirm IPs and hostnames are correct.