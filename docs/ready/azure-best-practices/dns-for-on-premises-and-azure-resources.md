---
title: DNS for on-premises and Azure
description: Examine key design considerations and recommendations surrounding DNS for on-premises and Microsoft Azure.
author: sitarant
ms.author: sitarant
ms.date: 12/06/2022
ms.topic: conceptual
ms.subservice: ready
ms.custom: think-tank
---

# DNS for on-premises and Azure resources

Domain Name System (DNS) is a critical design topic in the overall landing zone architecture. Some organizations might want to use their existing investments in DNS. Others might see cloud adoption as an opportunity to modernize their internal DNS infrastructure and use native Azure capabilities.

**Design considerations:**

- You can use Azure DNS Private Resolver service in conjunction with Azure Private DNS Zones for cross-premises name resolution.

- You might require the use of existing DNS solutions across on-premises and Azure.

- The maximum number of private DNS zones a virtual network can be linked to with auto-registration enabled is one.

- Familiarize yourself with [Azure Private DNS zone limits](/azure/azure-resource-manager/management/azure-subscription-service-limits#azure-dns-limits).

**Design recommendations:**

- For environments where name resolution in Azure is all that's required, use Azure Private DNS zones for resolution. Create a delegated zone for name resolution (such as `azure.contoso.com`). Enable auto-registration for Azure Private DNS zone to automatically manage the lifecycle of the DNS records for the virtual machines deployed within a virtual network.

- For environments where name resolution across Azure and on-premises is required, it is recommended to use DNS Private Resolver service along with Azure Private DNS Zones. It offers many benefits over virtual machines based DNS solution, including cost reduction, built-in high availability, scalability, and flexibility.

  If you need to use existing DNS infrastructure (for example, Active Directory integrated DNS), ensure that the DNS server role is deployed onto at least two VMs and configure DNS settings in virtual networks to use those custom DNS servers.
  
-  For environments with Azure Firewall, consider using it as [DNS proxy](/azure/firewall/dns-settings).

- You can link an Azure Private DNS zone to the virtual networks and use DNS Private Resolver service with DNS forwarding rule set also associated with the virtual networks:
  - For DNS queries generated in the Azure virtual network to resolve on-premises DNS names such as `corporate.contoso.com`, the DNS query is forwarded to the IP address of on-premises DNS servers specified in the rule set. 
  - For DNS queries generated in the on-premises network to resolve DNS records in Azure Private DNS Zones, you can configure on-premises DNS servers with conditional forwarders pointing to DNS Private Resolver service's inbound endpoint IP address in Azure, to forward the request to the Azure Private DNS zone (for example, `azure.contoso.com`).

- Special workloads that require and deploy their own DNS (such as Red Hat OpenShift) should use their preferred DNS solution.

- Create the Azure Private DNS zones within a global connectivity subscription. The Azure Private DNS zones that should be created include the zones required for accessing Azure PaaS services via a [private endpoint](/azure/private-link/private-endpoint-dns#azure-services-dns-zone-configuration) (for example, `privatelink.database.windows.net` or `privatelink.blob.core.windows.net`).
