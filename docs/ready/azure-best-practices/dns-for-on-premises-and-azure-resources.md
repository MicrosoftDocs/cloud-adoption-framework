---
title: DNS for On-Premises and Azure
description: Learn about key design considerations and recommendations surrounding DNS for on-premises and Microsoft Azure environments.
author: sitarant
ms.author: sitarant
ms.date: 01/10/2025
ms.topic: concept-article
ms.custom: think-tank
---

# DNS for on-premises and Azure resources

Domain Name System (DNS) is a critical design topic in the overall landing zone architecture. Some organizations might want to use their existing investments in DNS. Others might see cloud adoption as an opportunity to modernize their internal DNS infrastructure and use native Azure capabilities.

## Design considerations

- You can use Azure DNS Private Resolver with Azure Private DNS zones for cross-premises name resolution.

- You might need to use existing DNS solutions across on-premises and Azure.

- A virtual network can only be linked to one private DNS zone with auto-registration enabled.

- Familiarize yourself with [Azure Private DNS zone limits](/azure/azure-resource-manager/management/azure-subscription-service-limits#azure-dns-limits).

## Design recommendations

- For environments where only name resolution in Azure is required, use Azure Private DNS zones for resolution. Create a delegated zone for name resolution, such as `azure.contoso.com`. Enable auto-registration for the Azure Private DNS zone to automatically manage the lifecycle of the DNS records for the virtual machines that are deployed within a virtual network.

- For environments where name resolution across Azure and on-premises is required, use DNS Private Resolver along with Azure Private DNS zones. DNS Private Resolver provides many benefits over virtual machine-based DNS solutions, including cost reduction, built-in high availability, scalability, and flexibility.

  If you need to use existing DNS infrastructure, such as Windows Server Active Directory integrated DNS, ensure that the DNS server role is deployed onto at least two virtual machines, and configure DNS settings in virtual networks to use these custom DNS servers.
  
-  For environments that have Azure Firewall, consider using it as a [DNS proxy](/azure/firewall/dns-settings).

- You can link an Azure Private DNS zone to the virtual networks. Use DNS Private Resolver with a DNS forwarding ruleset that's also associated with the virtual networks:
  - For DNS queries generated in the Azure virtual network to resolve on-premises DNS names such as `corporate.contoso.com`, the DNS query is forwarded to the IP address of on-premises DNS servers specified in the ruleset. 
  
  - For DNS queries generated in the on-premises network to resolve DNS records in Azure Private DNS zones, you can configure on-premises DNS servers with conditional forwarders that point to the DNS Private Resolver inbound endpoint IP address in Azure. This configuration forwards the request to the Azure Private DNS zone, for example `azure.contoso.com`.

- Create two dedicated subnets for DNS Private Resolver in the hub virtual network, in the connectivity subscription. Create one subnet for inbound endpoints and one subnet for outbound endpoints. Both subnets should have a minimum size of `/28`.
    - If you deploy the DNS resolver alongside your ExpressRoute gateway, you must ensure that resolution of public FQDNs is permitted and replies with a valid response via a DNS forwarding ruleset rule to the targeted DNS server. Some Azure services rely on the ability to resolve public DNS names to function. For more information, see [DNS forwarding ruleset rules](/azure/dns/private-resolver-endpoints-rulesets#rules).
    
  - Inbound endpoints receive inbound resolution requests from clients within your internal private network, either Azure or on-premises. You can have a maximum of five inbound endpoints.
  - Outbound endpoints forward resolution requests to destinations within your internal private network, either Azure or on-premises, that can't be resolved by Azure Private DNS zones. You can have a maximum of five outbound endpoints.
  - Create an appropriate ruleset to permit DNS forwarding to on-premises DNS domains and namespaces.

- Workloads that require and deploy their own DNS, such as Red Hat OpenShift, should use their preferred DNS solution.

- Create the Azure Private DNS zones within a global connectivity subscription. The Azure Private DNS zones that should be created include the zones required for accessing Azure platform as a service solutions via a [private endpoint](/azure/private-link/private-endpoint-dns#azure-services-dns-zone-configuration). Examples include `privatelink.database.windows.net` or `privatelink.blob.core.windows.net`.