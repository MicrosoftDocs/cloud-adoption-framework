---
title: Industry priority scenarios in the retail industry
description: Learn the Microsoft approach to the retail industry's priority scenarios.
author: mpvenables
ms.author: jaalmond
ms.date: 09/10/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: internal, e2e-retail
---

# Industry priority scenarios

Industry priority scenarios aim to unlock the highest level of your digital retail maturity in the cloud, Intelligent Retail—implementing the master data management (MDM) approach to integrate consumer data within one dashboard. Understanding data throughout the consumer shopping journey requires gathering analytics—a deep view inside individual consumer product affinity, advertising effectiveness, and item forecast needs. This happens with a cohesive data model—an open data model for both internal and external solution providers that—

- ensures data is only visible to the entities that require it
- natively manages read/write privileges
- allows for rapid, secure deployment of solutions.

Implementing industry priority scenarios (IPS), you can harmonize your loosely coupled datasets, and implement a master data management (MDM) program to realize targeted, successful business outcomes.

Industry priority scenarios are holistic Microsoft Azure solutions that can address current challenges in the retail sector. Each scenario is backed by products and services that enable retail organizations to solve challenges, and drive their digital transformation to maturity.

There are four industry priority scenarios within the retail industry:

- Know your customers
- Empower your employees
- Deliver intelligent supply chain
- Reimagine retail

|Industry priority scenario (IPS)|Know your customers|Empower your employees|Deliver intelligent supply chain|Reimagine retail|
|--------------------------------|---------|----------------------|------------------------------|----------------|
||                    Create digital experiences,and use AI and predictive analytics to anticipate evolving customer needs and deliver individualized interactions across channels|Enable secure digital collaboration across your business and reduce costs|Gain visibility across your end-to-end supply chain using technology solutions|Create innovative customer experiences, optimize in-store operations, and use technology to evolve products, services, and business models|

Microsoft is addressing existing challenges in the retail sector to unlock Intelligent retail—the highest stage of digital retail maturity in the cloud by:

- [anticipating evolving customer needs](..\retail\retail-personalization.md) and [delivering individualized interactions across channels](..\retail\retail-omnichannel-optimization.md)
- enabling secure digital collaboration across your organization and reducing your costs
- [gaining end-to-end supply chain visibility](..\retail\retail-supply-chain-optimization.md) with technology solutions
- [deploying technologies to modernize products, services, and business models](..\retail\retail-building-management-optimization.md)

## Know your customers

Great customer service is—and has long been—the core art of retail. But the way consumers engage with retailers has changed, and the way retailers get to know you along with it. Data and predictive AI offers retailers the opportunity to create digital customer experiences that take customer service to the next level, while unlocking new business opportunities.

In your strategy and plan document—do you require that your:

- central IT, a cloud center of excellence (CCoE), or other forms of centralized operations be responsible for operating all workloads?
- on-premises datacenter locations be integrated into your cloud environment?
- certain deployments be included—that require adherence to regulatory compliance standards, such as the Payment Card Industry Data Security Standard (PCI DSS)?

The two use cases for Know your customer are personalization and omnichannel optimization. Personalization is the use of customer behavioral data across channels to tailor shopping experiences and offer the right product, in the right place, at the right time. Omnichannel optimization enables customers to switch platforms, devices, and channels—maintaining a coherent experience.

With individualized experiences offered in today's consumer marketplace, customers expect businesses to instantly react to their needs and wants on digital channels, anywhere, at any time. And, customers are concerned about privacy in the wake of recent data breaches. Retailers must seek new ways of understanding and engaging with customer behaviors—delivering personalization across multiple channels to increase the relevance of offerings, and improve the holistic customer experience.

### Business outcomes of personalization

Enabling a consistent, comprehensive pane of glass into customer behavioral data, your organization can gain tools to engage customers at the right time, in the right place, with the right content, context, messaging, and offers—positively affecting your business by:

- democratizing insights—to empower retailers to put products before people most likely to buy them.
- growing revenue and customer lifetime value—to help cross-sell products based on unified data.
- enhancing customer loyalty—responding to consumer behaviors and individualized customer interactions.
- improving marketing effectiveness—to boost engagement from understanding customer needs and unique preferences

### Challenges of personalization

Can your organization maximize customer engagement value? A holistic approach to data management is most effective to:

- Integrate data across applications, systems, and external data signals into a single, consistent consumer profile.
- Apply algorithms and heuristics to optimize consumer interactions.

Integrating this cross-channel data into existing retail processes is challenging because:

1. Lack of data governance and data silos obfuscate a unified 360-degree view of consumer data across channels.
2. Lack of insights from AI and machine learning model development limits how to respond to changes in customer behavior—and model interactions to individual consumer needs.
3. Ineffective targeting of advertisements and product information negatively affects conversion, cross-sell effectiveness, and customer satisfaction.

### Azure enables personalization for retailers

Take advantage of consistent retail data inputs to build deeper brand connections and extend customer lifetime value by:

- Determining data inputs—with structured and unstructured data, including customer data; sales/POS data; online transaction data; campaign/offer data; product data; and external data (e.g. social media).
- Ingesting data—then take advantage of Azure Data Factory to ingest data, and Azure Databricks to prepare it. Ingested data is stored using Azure Data Lake Storage.
- Accelerating insights—the Azure Synapse Analytics engine then acts as a data warehouse to model data and serve it up as insights. Retailers can accelerate insights needed to support personalized experiences, while managing costs, while Azure Databricks machine learning capabilities continuously trains the data model.
- Visualizing personalized recommendations—using PowerBI enables retailers to visually surface insights as personalized recommendations that empower all employees to improve customer service.
- Discovering patterns and monetizing strategies—to take advantage of Azure’s AI and machine learning (ML) capabilities provides intelligence across massive data sets, so retailers can discover patterns and monetize strategies. Retailers understand the imperative to grow revenue, deepen customer loyalty, and manage effective marketing campaigns.

### Business outcomes of omnichannel optimization

Data is key to driving optimization cross-channel—integrated channels selling goods and services to provide a coherent, captivating consumer experience that is cross-platform and device-agnostic.

With a consistent cross-channel data view, retailers can gather, prepare, analyze, and execute on data insights to:

- Increase customer loyalty—to bring customers back to the brand repeatedly.
- Grow top-line revenue—competitive differentiation by providing seamless shopping experiences to purchase in brick-and-mortar stores and digital channels.
- Improve customer satisfaction—cross-channel visibility delivers customized consumer experiences—understanding preferences and better serve customers and gaining insights into crafting offers based on needs.
- Enhance marketing effectiveness—and take advantage of AI analytics capabilities to build smarter, more effective campaigns, and maximize marketing ROI.

### Challenges of omnichannel optimization

How can retailers take advantage of a simple, scalable approach to integrating the analytics and machine learning capabilities required to predict customer purchasing activity for omnichannel optimization?

Harnessing and integrating external, heterogeneous data sources in a shared, cross-channel data processing engine is a major challenge, as:

- Impossible to deliver coherent, captivating experiences that consumers expect.
- Inconsistent pricing, promotion, product availability, and fulfillment strategies.
- Fragmented, irrelevant and inconsistent shopping experiences.

### Azure enables omnichannel optimization for retailers

Benefit from Azure's capabilities to analyze customer data using analytics to deliver better customer experiences online and onsite by:

- Identifying data inputs—deploy datasets from physical and virtual retail channels as input for analytics, including on-premises customer, product, or transactional data; sales/POS data; cost-efficiency data; and workforce optimization data. 
- Enabling actionable, real-time analysis—then take advantage of Azure Data Factory to ingest data, and Azure Databricks to prepare it. Ingested data is stored using Azure Data Lake Storage.
- Accelerating insights—the Azure Synapse Analytics engine then acts as a data warehouse to model data and serve it up as insights. Retailers can accelerate insights needed to support personalized experiences, while managing costs.
- Empowering the entire business—using PowerBI enables retailers to visually surface insights as personalized recommendations that empower all employees to improve customer service.
- Build smarter, more effective advertisements—taking advantage of Azure’s AI and machine learning (ML) capabilities helps retailers build smarter, more effective advertisements that resonate with audiences across channels. 

## Empower your employees

The retail industry is seeing unprecedented change. As global business increases pace, the imperative of enabling your employees to access more secure, compliant tools increases. Retailers that embrace analytics, AI, and virtual desktop technology to address this need can maintain secure digital collaboration across channels, while reducing costs.

Equipping employees with helpful tools and insights unlocks their potential—regardless of role or geographic location. Whether a line-of-business contributor working from home, or frontline worker helping a customer onsite, the right equipment and information are critical to delivering impeccable customer service, building customer trust and loyalty, and ultimately growing sales.

## Deliver intelligent supply chain

The retail sales cycle is increasing its turnaround time. The average consumer expects near-instant gratification from online and in-store shopping experiences. For retailers, working toward a more resilient supply chain becomes critical. The retail sector must be able to respond to customer demand for fast, flexible delivery—and get the right product, to the right place, at the right time. They must be able to react to any disruptions, and quickly determine end-customer exposure and the supply chain fault point to build and maintain customer loyalty.

For retailers to gain agility and resilience in the end-to-end supply chain and fulfill customer demand at scale—it's imperative to enable the ability to rapidly deploy vast, multi-variate, real-time, and trusted datasets and algorithms to establish correlations and make predictions.

### Business outcomes of supply chain optimization

Retailers meeting and exceeding their customers’ expectations requires their optimizing the supply chain—gaining visibility into the operational bottlenecks across procurement, logistics, and delivery.

One unified dashboard with a modernized data environment can collect information from siloed sources, create a single source of truth, and bridge the gap between systems—unlocking the visibility to:

- Improve demand forecasting—optimizing labor and logistics and effectively forecast demand.
- Drive operational changes and efficiencies—optimizing processes and turning operational data into actionable insights with data, analytics, and AI.
- Reduce costs and improve customer experience—helping retailers to timely match products to customer, while reducing unnecessary inventory.
- Increase safety and security of goods and shipments—optimizing efficiencies in the logistics journey and reducing loss by providing a unified view of the supply chain for asset tracking and logistics.

### Challenges of supply chain optimization

Disconnected business processes and data silos prevent retailers from agile, accurate analysis of consumer behaviors: 

- No infrastructure to improve inventory management and cost savings.
- Limited visibility into key data and no digital feedback loop—creating a lack of agility and responsiveness.
- No ability to discover patterns that negatively affect the end-to-end supply chain experience.

### Azure optimizes the supply chain

Azure enables real-time IoT insights layered on top of a unified view of retail data, so retailers can: 

- Collect and ingest data—from POS transactions, online and mobile purchases, social media, devices and IoT sensors, and supply chain or warehouse operations using Azure IoT Hub and Azure Event Hubs.
- Eliminate data silos—remove data silos by storing ingested data deploying Azure Data Lake Storage and Azure Cosmos DB, ensuring data is always secure and available, and enabling instant scalability.
- Conduct complex data analysis—unify cross-system views of analytics and perform complex queries on operational and transactional factory data at rapid petabyte scale using Azure Synapse Analytics.
- Visualize analytics outputs(contract cycle optimization, available-to-promise, price elasticity analysis, route planning and scheduling, and demand forecasting)—integrating with PowerBI to increase operational efficiencies, reduce costs, and optimize performance.

## Reimagine retail

In the retail sector, predicting future customer preference behaviors is always challenging. However, you can take action towards modernizing your products, services and business models.

Retailers achieving successful business outcomes are embracing digital transformation—reimagining what retail means—planning digital innovation that's necessary to evolve in the current market. Evolving the retail model means not only adopting the latest technologies (e.g., AI, IoT, and open APIs), but also implementing truly transformative business models—and building in-house digital capabilities on top of these technologies for continued viability into the consumer purchase cycle.

### Building management optimization 

Building management optimization refers to retailers using in-store sensors and beacon technology to create a smart and connected store, deliver personalized customer experiences, and increase profitability. Retailers must understand their retail space to provide innovative customer experiences and optimize in-store operations—including customer movement, product status, and store devices.

### Business outcomes of building management

Real-time data from in-store sensors and IoT beacon technology empowers retailers to create a smart, connected store environment and optimize building management—to track store occupancy, checkout line patterns, energy usage. and maintenance needs with real-time observational data that empowers retailers to:
 
- Make more informed decisions—harnessing energy usage and warehouse operations real-time analytics and alerts to empower data-driven decisions.
- Improve marketing ROI—optimizing available store space enhances abilities targets and increases efficiencies across advertising and marketing.
- Provide optimal shopping experiences—with alerts triggering on real-time data from video cameras, beacon technology, and IoT sensors.
- Reduce energy costs—increases the efficiency of store and warehouse operations, applying analytics and AI to unlock insights and visualize data for quicker decision making.

### Challenges of building management optimization

Retailers must embrace advances in analytics, AI, IoT, and other technologies to meet these challenges—and join forces with the right technology partner.

Retail establishments often lack visibility into physical assets (e.g., security cameras, shelves, lighting, equipment)—affecting store performance and profitability with challenges such as:

- Inability to identify a store’s busiest cash register stands in the way of optimizing customer flow across all registers.
- No visibility into occupancy levels inhibits maintaining compliance with social distancing requirements.
- Inability to effectively monitor energy consumption negatively affects cost management and sustainability efforts.

### Azure helps retailers optimize building management

Azure support the efforts of retailers to optimize building management by:

- Connecting physical retail environments— with IoT sensors and mixed reality to create a stream of data inputs.
- Collecting and ingesting data—from input sources using Azure App Service, Azure Functions, and Azure Event Hubs.
- Storing data—on Azure Data Lake.
- Creating virtual models of physical retail spaces—to gain insights driving optimized operations, reduced costs, and breakthrough customer experiences using Azure Spatial Anchors and Azure Digital Twins.
- Visualizing customer and store data—integrate with Power BI to visualize in real-time customer preference, store performance, equipment maintenance, and advertising data.

### See intelligent retail hands-on with a retail industry demo

See how Azure’s data and AI capabilities are enabling intelligent retail with the Microsoft [Data and AI Demo Megamap](https://azure-data-ai-demomap.azurewebsites.net/map), showing how technologies such as Azure Synapse, Power BI, Azure IoT, and Azure Machine Learning enable retailers to reimagine every facet of their business.

### Take the Cloud Journey Tracker assessment

Take [Microsoft’s Cloud Journey Tracker](https://docs.microsoft.com/assessments/?id=cloud-journey-tracker&mode=pre-assessment) to develop and implement your cloud strategy. The tracker enables users to identify a cloud adoption path based on their organization’s needs and enables them to navigate to relevant content in the Cloud Adoption Framework for Azure. 

## Next steps

The following articles can guide your cloud adoption journey and help you succeed in the cloud adoption scenario.

- [Cloud adoption plan for the retail industry](./plan.md)
- [Review your environment or Azure landing zones](./ready.md)
- [Migrate common retail industry technologies](./migrate.md)
- [Innovation in the retail industry](./innovate.md)
- [Governance in the retail industry](./govern.md)
- [Management in the retail industry](./manage.md)