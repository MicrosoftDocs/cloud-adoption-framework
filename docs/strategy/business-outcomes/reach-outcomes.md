---
title: Examples of global reach outcomes
description: Use the Cloud Adoption Framework for Azure to understand global reach outcomes in the context of a cloud transformation.
author: mpvenables
ms.author: brblanch
ms.date: 03/02/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: strategy
ms.custom: internal
---

<!-- cSpell:ignore Personalizer -->
<!-- docutune:ignore "global reach" -->

# Examples of global reach outcomes

As discussed in [Business outcomes](./index.md), several potential business outcomes can serve as the foundation for any transformation journey conversation with the business. This article focuses on a common business measure: reach. *Reach* is a concise term that, in this case, refers to a company's globalization strategy. Understanding the company's globalization strategy helps you better articulate the business outcomes that are the target of a business's transformation journey.

Fortune 500 and smaller enterprises have focused on the globalization of services and customers for over three decades, and most business are likely to engage in global commerce as this globalization continues to pull focus. Hosting datacenters around the world can consume more than 80 percent of an annual IT budget, and wide-area networks using private lines to connect those datacenters can cost millions of dollars per year. Therefore, supporting global operations is both challenging and costly.

Cloud solutions move the cost of globalization to the cloud provider. In Azure, customers can quickly deploy resources in the same region as customers or operations, without buying and provisioning a datacenter. Microsoft owns one of the largest wide-area networks in the world, connecting datacenters around the globe. Connectivity and global operating capacity are available to global customers on demand.

[Walgreens Boots Alliance (WBA)](https://customers.microsoft.com/story/792289-walgreens-boots-alliance-retailers-azure-sap-migration) moved on-premises applications and IT resources in a heterogeneous Linux and Windows environment to the cloud, benefiting from improved performance and data centralization - and helping the company provide better customer service.

## Global access

Expanding into a new market can be one of the most valuable business outcomes during a transformation. The ability to quickly deploy resources in market without a longer-term commitment allows sales and operations leaders to explore options that wouldn't have been considered in the past.

### Manufacturing example

A cosmetics manufacturer has identified a trend. Some products are being shipped to the Asia Pacific region even though no sales teams are operating in that region. The minimum systems required by a remote sales force are small, but latency prevents a remote access solution. To capitalize on this trend, the vice president of sales wants to experiment with sales teams in Japan and South Korea. Because the company has undergone a cloud migration, it was able to deploy the necessary systems in both Japan and South Korea within days. This allowed the vice president of sales to grow revenue in the region within three months. Those two markets continue to outperform other parts of the world, leading to sales operations throughout the region.

### Retail example

An online retailer that ships products globally can engage with their customers across time zones and multiple languages. The retailer uses Azure Bot Service and various features in Azure Cognitive Services, such as Translator, Language Understanding (LUIS), QnA Maker, and Text Analytics. This ensures their customers are able to get the information they need when they need it, and that it's provided to them in their language. The retailer uses the [Personalizer service](https://azure.microsoft.com/services/cognitive-services/personalizer/) to further customize the experience and catalog offerings for their customers, ensuring geographical tastes, preferences, and availability are reflected.

## Data sovereignty

Operating in new markets introduces additional governance constraints. Azure provides compliance offerings that help customers meet compliance obligations across regulated industries and global markets. For more information, see the [overview of Microsoft Azure compliance](https://azure.microsoft.com/overview/trusted-cloud/compliance).

### Example

A US-based utilities provider was awarded a contract to provide utilities in Canada. Canadian data sovereignty law requires that Canadian data stays in Canada. This company had been working their way through a cloud-enabled application innovation effort for years. As a result, their software was deployed through fully scripted DevOps processes. With a few minor changes to the code base, they were able to deploy a working copy of the code to an Azure datacenter in Canada, meeting data sovereignty compliance and retaining the customer.

## Next steps

Learn more about customer engagement outcomes.

> [!div class="nextstepaction"]
> [Customer engagement outcomes](./engagement-outcomes.md)
