---
title: DNS for on-premises and Azure
description: Examine key design considerations and recommendations surrounding DNS for on-premises and Microsoft Azure.
author: sitarant 
ms.author: sitarant
ms.date: 06/17/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

<!-- cspell:ignore privatelink -->

# DNS for on-premises and Azure resources

Domain Name System (DNS) is a critical design topic in the overall enterprise-scale architecture. Some organizations might want to use their existing investments in DNS. Others might see cloud adoption as an opportunity to modernize their internal DNS infrastructure and use native Azure capabilities.

**Design considerations:**

- You can use a DNS resolver in conjunction with Azure Private DNS for cross-premises name resolution.

- You might require the use of existing DNS solutions across on-premises and Azure.

- The maximum number of private DNS zones to which a virtual network can link with auto-registration is one.

- Familiarize yourself with [Azure Private DNS zone limits](/azure/azure-resource-manager/management/azure-subscription-service-limits#azure-dns-limits).

**Design recommendations:**

- For environments where name resolution in Azure is all that's required, use Azure Private DNS zones for resolution. Create a delegated zone for name resolution (such as `azure.contoso.com`). Enable auto-registration for Azure Private DNS to automatically manage the lifecycle of the DNS records for the virtual machines deployed within a virtual network.

- For environments where name resolution across Azure and on-premises is required, use existing DNS infrastructure (for example, Active Directory integrated DNS) deployed onto at least two virtual machines (VMs). Configure DNS settings in virtual networks to use those DNS servers.

- For environments with Azure Firewall, evaluate using it as [DNS proxy](/azure/firewall/dns-settings).

- Use a virtual machine as a resolver for cross-premises DNS resolution with Azure Private DNS.

- You can still link an Azure Private DNS zones to the virtual networks and use DNS servers as hybrid resolvers with conditional forwarding to on-premises DNS names, such as `corporate.contoso.com`, by using on-premises DNS servers. You can configure on-premises servers with conditional forwarders to resolver VMs in Azure for the Azure Private DNS zone (for example, `azure.contoso.com`).

- Special workloads that require and deploy their own DNS (such as Red Hat OpenShift) should use their preferred DNS solution.

- Create the Azure Private DNS zones within a global connectivity subscription. The Azure Private DNS zones that should be created include the zones required for accessing Azure PaaS services via a [private endpoint](/azure/private-link/private-endpoint-dns#azure-services-dns-zone-configuration) (for example, `privatelink.database.windows.net` or `privatelink.blob.core.windows.net`).
