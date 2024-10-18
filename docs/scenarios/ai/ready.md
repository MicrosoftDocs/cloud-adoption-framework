---
title: AI Ready – Recommendations for organizations building AI workloads in Azure
description: Learn the process to build AI workloads in Azure with best practices and recommendations.
author: stephen-sumner
ms.author: ssumner
ms.date: 11/01/2024
ms.topic: conceptual
---

# AI Ready – Recommendations for organizations building AI workloads in Azure

This article provides recommendations for making key design and process decisions for adopting AI workloads at scale. It assumes as a prerequisite familiarity with the [Ready](/azure/cloud-adoption-framework/ready/) methodology in the Cloud Adoption Framework and [Azure landing zones](/azure/cloud-adoption-framework/ready/landing-zone/). It focuses on AI-specific guidance for region selection, resource organization, and networking.

:::image type="content" source="./images/aiready.svg" alt-text="Diagram showing the AI adoption framework process. It highlights AI Ready. The process with AI Strategy, AI Plan, AI Ready as sequential steps. Then Secure AI, Govern AI, and Manage AI are cyclical processes after AI Ready. Undergirding the entire process is Responsible AI." lightbox="./images/aiready.svg" border="false":::

## Establish AI reliability

Select the right region or regions to host your AI models. It affects the performance, compliance, cost, and availability of your AI services:

- *Use multiple regions to host AI model endpoints.* For production workloads, host AI endpoints in at least two regions to provide redundancy and ensure high availability. Although generative AI models are stateless, hosting them in multiple regions ensures faster failover and recovery during regional failures. For Azure OpenAI Service models, you can use [global deployments](/azure/ai-services/openai/how-to/deployment-types#deployment-types). These multiregion deployments can automatically and transparently route requests to a region that has enough capacity. If you choose a nonglobal deployment, also known as a regional deployment, use [Azure API Management](/azure/api-management/genai-gateway-capabilities#backend-load-balancer-and-circuit-breaker) for load balancing API requests to AI endpoints.

- *Confirm service availability.* Before deployment, ensure that there's [availability in the region](https://azure.microsoft.com/explore/global-infrastructure/products-by-region/#products-by-region_tab5) for the AI resources that you need. Certain regions might not provide specific AI services or might have limited features, which can affect the functionality of your solution. This limitation can also affect the scalability of your deployment. For example, Azure OpenAI service availability can vary based on your deployment model. These deployment models include global standard, global provisioned, regional standard, and regional provisioned. Check the AI service to confirm that you have access to the necessary resources.

- *Evaluate region quota and capacity.* Consider the quota or subscription limits in your chosen region as your AI workloads grow. Azure services have regional subscription limits. These limits can affect large-scale AI model deployments, such as large inference workloads. To prevent disruptions, contact Azure support in advance if you foresee a need for extra capacity.

- *Evaluate performance.* When you build applications that need to retrieve data, such as retrieval-augmented-generation (RAG) applications, it's important to consider data storage locations to optimize performance. You don't have to colocate data with models in RAG apps, but doing so can improve performance by reducing latency and ensuring efficient data retrieval.

- *Prepare for continuity of operations.* To ensure business continuity and disaster recovery, replicate critical assets such as fine-tuned models, RAG data, trained models, and training datasets in a secondary region. This redundancy enables faster recovery if there's an outage and ensures continued service availability.

## Establish AI governance

In Azure, resource organization is how you structure management groups and subscriptions to organize your Azure resources. Resource organization is critical for AI governance across AI workloads and cost management.

- *Separate internet facing and internal AI workloads*. At a minimum, use management groups to separate AI workloads into internet-facing ("online") and internal only ("corporate"). The distinction provides an important data governance boundary. It helps you keep internal separate from public data. You don't want external users to access sensitive business information required for internal work. This distinction between internet-facing and internal workloads aligns with [Azure landing zone management groups](/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org-management-groups).

- *Apply AI policies to each management group.* Start with baseline policies for each workload type, such as those policies used in [Azure landing zones](https://github.com/Azure/Enterprise-Scale/wiki/ALZ-Policies). Add more Azure Policy definitions to your baseline to drive uniform governance for [Azure AI services](/azure/ai-services/policy-reference), [Azure AI Search](/azure/governance/policy/samples/built-in-policies#search), [Azure Machine Learning](/azure/governance/policy/samples/built-in-policies#machine-learning), and [Azure Virtual Machines](/azure/virtual-machines/policy-reference).

- *Deploy AI resources in workload subscriptions.* AI resources need to inherit workload governance policies from the workload management group (internal or internet-facing). Keep them separate from platform resources. AI resources controlled by platform teams tend to create development bottlenecks. In the context of Azure landing zone, deploy AI platforms to application landing zone subscriptions.

## Establish AI networking

This guidance provides recommendations for setting up your network topology for AI workloads. Organizations that have multiple intelligent applications should use a hub-and-spoke network topology. When you have a single intelligent application, consider adopting a hub-and-spoke topology as the number of your workloads increases.

- *Activate Azure DDoS Protection for internet-facing AI workloads.* Azure DDoS Protection safeguards your AI services from potential disruptions and downtime caused by Distributed Denial of Service attacks. Enable DDoS protection at the virtual network level to defend against traffic floods targeting internet-facing applications.

- *Connect to on-premises data.* For organizations transferring large amounts of data from on-premises sources to cloud environments, use a high-bandwidth connection.

    - *Consider Azure ExpressRoute.* Azure [ExpressRoute](/azure/expressroute/expressroute-introduction) is ideal for high data volumes, real-time processing, or workloads that require consistent performance. It has [FastPath](/azure/expressroute/about-fastpath) feature that improves data path performance.

    - *Consider Azure VPN Gateway.* Use [Azure VPN Gateway](/azure/vpn-gateway/vpn-gateway-about-vpngateways) for moderate data volumes, infrequent data transfer, or when public internet access is required. It’s simpler to set up and cost-effective for smaller datasets than ExpressRoute. Use the correct [topology and design](/azure/vpn-gateway/design) for your AI workloads. Use site-to-site VPN for cross-premises and hybrid connectivity. Use a point-to-site VPN for secure device connectivity. For more information, see [Connect an on-premises network to Azure](/azure/architecture/reference-architectures/hybrid-networking/).

- *Prepare domain name resolution services.* Use private endpoints to protect AI workloads by assigning them private IP addresses for communication. [Integrate private endpoints with DNS](/azure/private-link/private-endpoint-dns-integration) for proper DNS resolution and successful private endpoint functionality. Deploy Azure DNS infrastructure as part of your [Azure landing zone](/azure/cloud-adoption-framework/ready/azure-best-practices/dns-for-on-premises-and-azure-resources) and [configure conditional forwarders](/azure/private-link/private-endpoint-dns) from existing DNS services for the appropriate zones. For more information, see [Private Link and DNS integration at scale for Azure landing zones](/azure/cloud-adoption-framework/ready/azure-best-practices/private-link-and-dns-integration-at-scale).

- *Segment virtual networks.* Apply network segmentation to control traffic flow and reduce the risk of lateral movement if there was a breach. Microsegmentation can provide even finer control at the workload or application level within Azure Virtual Networks (VNets).

- *Configure network access controls.* Utilize Network Security Groups (NSGs) and Azure Firewall to define and apply access policies that govern inbound and outbound traffic to and from AI workloads. These controls can be used to implement the principle of least privilege, ensuring that only essential communication is permitted.

- *Use network monitoring services.* Use services such as Azure Monitor Network Insights and Azure Network Watcher to gain visibility into network performance and health. Additionally, use Microsoft Sentinel for advanced threat detection and response across your Azure network.

- *Deploy Azure Firewall to inspect and secure outbound Azure workload traffic.* Azure Firewall inspects outbound traffic before it reaches the internet, enforcing security measures and policies for data leaving Azure. Use Azure Firewall as an extra security layer to control and monitor outgoing traffic from your AI workloads. Enable Azure Firewall SNAT for Azure to internet connectivity. Azure Firewall SNAT conceals internal IP addresses, adding a security layer by translating private IPs of Azure services to the public IP address of the firewall. Configure SNAT on Azure Firewall to ensure outbound traffic from Azure to the internet uses a secure, identifiable public IP for monitoring and security.

- *Use Azure Web Application Firewall v2 (WAFv2) for internet-facing workloads.* Azure WAFv2 helps protect your AI applications from common web vulnerabilities, including SQL injections and cross-site scripting attacks. Configure Azure WAFv2 on Application Gateway for applications that require enhanced security against malicious web traffic.

## Establish an AI foundation

To build a solid foundation for AI workloads in Azure, you must set up your resource hierarchy and core infrastructure. This foundation ensures that your AI environment is scalable, secure, and aligned with governance and operational requirements.

### Use Azure landing zone

An Azure landing zone is the recommended starting point that prepares your Azure environment. It provides a predefined setup for platform and application resources. Once the platform is in place, you can deploy AI workloads to dedicated application landing zones. Figure 2 below illustrates how AI workloads integrate within an Azure landing zone.

:::image type="content" source="./images/alz-ai.svg" alt-text="Diagram showing AI workloads within an Azure landing zone." lightbox="./images/alz-ai.svg" border="false":::
*Figure 2. AI applications in the context of an Azure landing zone.*

### Build an AI environment

Follow the recommendations outlined in this article to create a foundational environment for your AI workloads. The following diagram shows a baseline resource hierarchy. It distinguishes between internal AI workloads and internet-facing AI workloads, as described in [establish AI governance](#establish-ai-governance). This separation safeguards internal data by preventing exposure to external users.

:::image type="content" source="./images/baseline-resource-hierarchy.svg" alt-text="Diagram showing the resource organization for internal and internet-facing AI workloads." lightbox="./images/baseline-resource-hierarchy.svg" border="false":::
*Figure 3. Baseline resource hierarchy for AI workloads.*

## Next steps

The next step is to build and deploy AI workloads to your AI environment. Use the following links to find the architecture guidance that meets your needs. Start with platform-as-a-service (PaaS) architectures. PaaS is Microsoft's recommended approach to adopting AI.

> [!div class="nextstepaction"]
> [PaaS AI architecture guidance](./platform/architectures.md)

> [!div class="nextstepaction"]
> [IaaS AI architecture guidance](./infrastructure/cycle-cloud.md)
