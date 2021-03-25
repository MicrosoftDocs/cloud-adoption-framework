---
title: Security Title
description: Security Description
author: GitHubAlias
ms.author: msftalias
ms.date: 04/04/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: secure
ms.custom: internal
---

# Generic space holder - remember to edit the metadata before publication

## This article should cover all of the items under the "consideration for governance and compliance" question at the CAF level

**Note that for this article, these items should be tackled from an overall enterprise viewpoint. Items which are specific to a singular workload should be referred to articles in https://aka.ms/waf and Well-Architected in general.**

- Services used by this workload, which should not be accessible from public IP addresses, are protected with network restrictions / IP firewall rules.Azure provides networking solutions to restrict access to individual application services. Multiple levels (such as IP filtering or firewall rules) should be explored to prevent application services from being accessed by unauthorized actors.
- Service Endpoints or Private Links are used for accessing Azure PaaS services.Service Endpoints and Private Link can be leveraged to restrict access to PaaS endpoints only from authorized virtual networks, effectively mitigating data intrusion risks and associated impact to application availability. Service Endpoints provide service level access to a PaaS service, while Private Link provides direct access to a specific PaaS resource to mitigate data exfiltration risks (e.g. malicious admin scenarios). Don't forget that Private Link is a paid service and has meters for inbound and outbound data processed. Private Endpoints are charged as well.
- Azure Firewall or any 3rd party next generation firewall is used for this workload to control outgoing traffic of Azure PaaS services (data exfiltration protection) where Private Link is not available.NVA solutions and Azure Firewall (for supported protocols) can be leveraged as a reverse proxy to restrict access to only authorized PaaS services for services where Private Link is not yet supported (Azure Firewall).
- Network security groups (NSG) are used to isolate and protect traffic within the workloads VNet.If NSGs are being used to isolate and protect the application, the rule set should be reviewed to confirm that required services are not unintentionally blocked.
- NSG flow logs are configured to get insights about incoming and outgoing traffic of this workload.NSG flow logs should be captured and analyzed to monitor performance and security. The NSG flow logs enables Traffic Analytics to gain insights into internal and external traffic flows of the application.
- Access to the workload backend infrastructure (APIs, databases, etc.) is restricted to only a minimal set of public IP addresses - only those who really need it.Web applications typically have one public entrypoint and don't expose subsequent APIs and database servers over the internet. When using gateway services like Azure Front Door it's possible to restrict access only to a set of Front Door IP addresses and lock down the infrastructure completely.
- Identified groups of resources are isolated from other parts of the organization to aid in detecting and containing adversary movement within the enterprise.A unified enterprise segmentation strategy will guide all technical teams to consistently segment access using networking, applications, identity, and any other access controls.
- All public endpoints of this workload are protected/secured with appropriate solution (i.e. Azure Front Door, Azure Firewall...).External application endpoints should be protected against common attack vectors, such as Denial of Service (DoS) attacks like Slowloris, to prevent potential application downtime due to malicious intent. Azure-native technologies such as Azure Firewall, Application Gateway/Azure Front Door WAF, and DDoS Protection Standard Plan can be used to achieve requisite protection (Azure DDoS Protection).
- Publishing methods for this workload (e.g FTP, Web Deploy) are protected.Application resources allowing multiple methods to publish app content (e.g FTP, Web Deploy) should have the unused endpoints disabled. For Azure Web Apps SCM is the recommended endpoint and it can be protected separately with network restrictions for sensitive scenarios.
- Code is published to this workload using CI/CD process instead of manually.Developers shouldn't publish their code directly to app servers - automated and gated CI/CD process should manage this.
- Workload virtual machines running on premises or in the cloud don't have direct internet connectivity for users that may perform interactive logins, or by applications running on virtual machines.Attackers constantly scan public cloud IP ranges for open management ports and attempt "easy" attacks like common passwords and known unpatched vulnerabilities. Limiting internet access from within an application server can prevent data exfiltration or stop the attacker from downloading additional tools.
- There's a capability and plans in place to mitigate DDoS attacks for this workload.
