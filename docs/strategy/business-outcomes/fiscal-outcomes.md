---
title: Examples of fiscal outcomes
description: Use the Azure Cloud Adoption Framework to understand fiscal outcomes in the context of a cloud transformation.
author: mpvenables
ms.author: brblanch
ms.date: 06/08/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: strategy
ms.custom: internal
---

# Examples of fiscal outcomes

The three concepts of fiscal conversations consist:

- **Revenue:** Will more money come into the business as a result of the sales of goods or services?
- **Cost:** Will less money be spent in the creation, marketing, sales, or delivery of goods or services?
- **Profit:** Although they're rare, some transformations can both increase revenue and decrease costs. This is a profit outcome.

The rest of this article explains the fiscal outcomes in the cloud transformation context.

[Sentara Healthcare](https://customers.microsoft.com/story/769786-sentara-healthcare-health-provider-azure) moved its data to Azure to provide better experience to:

- members with mobile apps
- for clinicians to access access critical data faster for diagnoses
- reduced costs for the IT team
- improved patient care with a more agile
- change-ready organization.

> [!NOTE]
> The following examples are hypothetical and should not be considered a guarantee of returns when adopting any cloud strategy.

## Revenue outcomes

### New revenue streams

The cloud can create opportunities to deliver new products to customers or deliver existing products in a new way. New revenue streams are innovative, entrepreneurial, and exciting for people in the business world. For some companies, new revenue streams are prone to failure and are considered to be at a high risk. When revenue-related outcomes are proposed by IT, there will likely be resistance. To add credibility to these outcomes, you can partner with a business leader who's a proven innovator. Validation of the revenue stream early in the process helps avoid roadblocks from the business. It is a good idea to validate the revenue system early in the process to avoid road blocks in the business.

- **Example:** A company has been selling books for over a hundred years. An employee of the company realizes that the content can be delivered electronically. The employee creates a device that's sold in the bookstore, that allows the same books to be downloaded directly, driving *$x* in new book sales.

### Revenue increases

With global scale and digital reach, the cloud helps businesses to increase revenues from existing revenue streams. Often, this type of outcome comes from an alignment with sales or marketing leadership.

- **Example:** A company that sells widgets could sell more widgets, if the salespeople could securely access the company's digital catalog and stock levels. Unfortunately, that data is only in the company's ERP system, that can be accessed only using a network-connected device. Creating a service façade to interface with the ERP and exposing the catalog list and non-sensitive stock levels to an application in the cloud allows the salespeople to access the data they need while onsite with a customer. Extending on-premises Active Directory using Azure Active Directory (Azure AD) and integrating role-based access into the application would allow the company to help ensure that the data stays safe. This simple project affects revenue from an existing product line by *x%*.

### Profit increases

Often a single effort simultaneously increase revenue and decrease costs. However, when it does, align the outcome statements from one or more of the revenue outcomes with one or more of the cost outcomes to communicate the desired outcome.

## Cost outcomes

### Cost reduction

Cloud computing can reduce capital expenses for hardware and software, setting up datacenters, running on-site datacenters, and many more. The costs of racks of servers, round-the-clock electricity for power and cooling, and IT experts to manage the infrastructure add up fast. Shutting down a datacenter can reduce capital expense commitments. This is commonly referred to as "getting out of the datacenter business." Cost reduction is typically measured in dollars in the current budget, that can span one to five years depending on how the CFO manages finances.

- **Example #1:** A company's datacenter consumes a large percentage of the annual IT budget. IT chooses to conduct a cloud migration and transitions the assets in that datacenter to infrastructure as a service (IaaS) solutions, to create a three-year cost reduction.
- **Example #2:** A holding company recently acquired a new company. In the acquisition, the terms dictate that the new entity should be removed from the current datacenters within six months. Failure to do so will result in a fine of $1 million USD per month to the holding company. Moving the digital assets to the cloud in a cloud migration could allow for a quick decommission of the old assets.
- **Example #3:** An income tax company that caters to consumers experiences 70 percent of its annual revenue during the first three months of the year. The remainder of the year, its large IT investment is relatively dormant. A cloud migration could allow IT to deploy the compute/hosting capacity required for those three months. During the remaining nine months, the IaaS costs can be reduced by reducing the compute footprint.

### Example: Coverdell

Coverdell modernizes their infrastructure to drive record cost savings with Azure. Coverdell's decision to invest in Azure, and to unite their network of websites, applications, data, and infrastructure within this environment, led to more cost savings than the company can expect. The migration to an Azure-only environment eliminated $54,000 USD in monthly costs for co-location services. With the company's new united infrastructure, coverdell expects to save an estimated $1M USD over the next two to three years.

> "Access to the Azure technology stack help to use cost effective solutions like scalable, easy-to-implement, and highly available solutions. This allows architects to be more creative with the solutions they provide."
>
> Ryan Sorensen
>
> Director of Application Development and Enterprise Architecture
>
> Coverdell

### Cost avoidance

Terminating a datacenter can also provide cost avoidance, by preventing future refresh cycles. A refresh cycle is the process of buying new hardware and software to replace aging on-premises systems. In Azure, hardware and OS are routinely maintained, patched, and refreshed at no additional cost to customers. This allows a CFO to remove planned future spend from long-term financial forecasts. Cost avoidance is measured in dollars. It differs from cost reduction, generally focusing on a future budget that has not been fully approved yet.

- **Example:** A company's datacenter is up for a lease renewal in six months. The datacenter has been in service for eight years. Four years ago, all servers were refreshed and virtualized, costing the company millions of dollars. Next year, the company plans to refresh the hardware and software again. Migrating the assets in that datacenter as part of a cloud migration allows cost avoidance by removing the planned refresh from next year's forecasted budget. It can also produce cost reduction by decreasing or eliminating the real estate lease costs.

### Capital expenses and operating expenses

The two primary cost options are capital expenses and operating expenses.

The following terms helps in understanding the differences between capital expenses and operating expenses during business discussions about a transformation journey.

- **Capital** is the money and assets owned by a business to contribute to a particular purpose, such as increasing server capacity or building an application.
- **Capital expenditures** generate benefits over a long period. These expenditures are generally non-recurring and result in the acquisition of permanent assets. Building an application can be qualified as a capital expenditure.
- **Operating expenditures** are ongoing costs for a business. Consuming cloud services in a pay-as-you-go model can be qualified as an operating expenditure.
- **Assets** are economic resources that can be owned or controlled to produce value. Servers, data lakes, and applications can be considered assets.
- **Depreciation** is a decrease in the value of an asset over time. More relevant to the capital expense versus operating expense conversation, depreciation is how the costs of an asset are allocated across the periods in which they are used. For example, if you build an application this year but it's expected to have an average shelf life of five years (like most commercial applications), the cost of the development team and the tools required to create and deploy the code base would be depreciated evenly over five years.
- **Valuation** is the process to estimate how much a company is worth. In most industries, valuation is based on the company's ability to generate revenue and profit, while respecting the operating costs required to create the goods that provide that revenue. In some industries, such as retail, or in some transaction types, such as private equity, assets and depreciation can play a large part in the company's valuation.

It is often that various executives, including the chief investment officer (CIO), debate the best use of capital to grow the company in the desired direction. Giving the CIO a means of converting contentious capital expense conversations into clear accountability for operating expenses can be an attractive outcome by itself. In many industries, chief financial officers (CFOs) actively look for ways to better associate fiscal accountability to the cost of goods being sold.

However, before you associate any transformation journey with this type of capital versus operating expense conversion, it's wise to meet with members of the CFO or CIO teams to see which cost structure the business prefers. In some organizations, reducing capital expenses in favor of operating expenses is a highly undesirable outcome. As mentioned earlier, sometimes this approach is seen in retail, holding, and private equity companies that place higher value on traditional asset accounting models, which place little value on IP. It's also seen in organizations that had negative experiences when they outsource IT staff or other functions in the past.

If a user wants a operating expense model, use the following example for a usable business outcome.

- **Example:** The company's datacenter is currently depreciating at *$x USD* per year for the next three years. It is expected to require an additional *$y USD* to refresh the hardware next year. We can convert the capital expenses to an operating expense model at an even rate of *$z USD* per month, to allow better management and accountability for the operating costs of technology.

## Next steps

Learn about [agility outcomes](./agility-outcomes.md).

> [!div class="nextstepaction"]
> [Agility outcomes](./agility-outcomes.md)
