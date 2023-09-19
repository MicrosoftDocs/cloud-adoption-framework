---
title: Examples of fiscal outcomes
description: Use the Cloud Adoption Framework to understand fiscal outcomes in the context of a cloud transformation.
author: mpvenables
ms.author: martinek
ms.date: 06/08/2022
ms.topic: conceptual
ms.custom: internal, UpdateFrequency2
---

# Examples of fiscal outcomes

The three basic concepts of fiscal conversation are:

- **Revenue:** Will more money come into the business as a result of the sales of goods or services?
- **Cost:** Will less money be spent in the creation, marketing, sales, or delivery of goods or services?
- **Profit:** Although they're rare, some transformations can both increase revenue and decrease costs. This is a profit outcome.

This article explains these fiscal outcomes within the context of a cloud transformation.

[Sentara Healthcare](https://customers.microsoft.com/story/769786-sentara-healthcare-health-provider-azure) moved its data to Azure to provide:

- better mobile app experiences for members
- faster access to critical diagnostic data for clinicians
- reduced IT team costs
- improved patient care
- a more agile, change-ready organization overall

> [!NOTE]
> The following examples are hypothetical and should not be considered a guarantee of returns when adopting any cloud strategy.

## Revenue outcomes

### New revenue streams

The cloud can create opportunities that allow you to deliver new products to customers or deliver existing products in a new way. New revenue streams are innovative, entrepreneurial, and exciting for people in the business world.

In some companies, new revenue streams are prone to failure and considered high risk. When a revenue-related outcome is proposed by IT in one of these companies, resistance is likely. Partnering with a business leader who's a proven innovator lends credibility to proposed outcomes, and demonstrating revenue stream validation early in the process can help prevent roadblocks.

- **Example:** A company has been selling books for over a hundred years. An employee of the company realizes that the content can be delivered electronically. The employee creates a device that's sold in the bookstore, that allows the same books to be downloaded directly, driving *$x* in new book sales.

### Revenue increases

Through its global scale and digital reach the cloud can help businesses increase revenues from existing revenue streams. This type of outcome often results from an alignment with sales or marketing leadership.

- **Example:** A company sells widgets. It could sell more widgets, if its salespeople could securely access the company's digital catalog and stock levels. Unfortunately, that data is only in the company's ERP system, which can only be accessed through network-connected devices. If the company creates a service facade to interface with the ERP and expose the catalog list and non-sensitive stock levels to an application in the cloud, salespeople can access the data they need while onsite with a customer. Extending on-premises Active Directory using Azure Active Directory (Azure AD) and integrating role-based access into the application allows the company to ensure their data stays safe. This simple change can affect revenue from an existing product line by *x%*.

### Profit increases

Seldom does a single effort simultaneously increase revenue and decrease costs. However, when it does, align the outcome statements from one or more of the revenue outcomes with one or more of the cost outcomes to communicate the desired outcome.

## Cost outcomes

### Cost reduction

Cloud computing can reduce capital expenses for hardware and software, datacenter setup, on-site datacenter operation, and more. The cost of servers, round-the-clock electricity for power and cooling, and IT experts to manage infrastructure adds up fast. Shutting down a datacenter can reduce your capital expense commitments. This is commonly referred to as "getting out of the datacenter business." The resulting cost reduction is typically measured in dollars in the current budget, which can span one to five years depending on how your CFO manages finances.

- **Example #1:** A company's datacenter consumes a large percentage of their annual IT budget. IT chooses to conduct a cloud migration and transitions that datacenter's assets to infrastructure as a service (IaaS) solutions, creating a three-year cost reduction.
- **Example #2:** A holding company recently acquired a new company. The terms of the acquisition dictate that the new entity should be removed from its current datacenters within six months. Failure to do so will result in a fine of $1 million USD per month to the holding company. Moving the new entity's digital assets to the cloud in a cloud migration can allow a quick decommission of the old assets.
- **Example #3:** An income tax company catering to consumers experiences 70 percent of its annual revenue during the first three months of the year. For the remainder of the year, its large IT investment is relatively dormant. A cloud migration can allow IT to deploy the compute/hosting capacity required for those three months. During the remaining nine months, they can reduce the compute footprint and IaaS costs.

### Example: Coverdell

Coverdell modernizes their infrastructure to drive record cost savings with Azure. Coverdell's decision to invest in Azure, and to unite their network of websites, applications, data, and infrastructure within this environment, led to more cost savings than the company expected. Their migration to an Azure-only environment eliminated $54,000 USD in monthly costs for co-location services. With their new united infrastructure, Coverdell expects to save an estimated $1M USD over the next two to three years.

> "Having access to the Azure technology stack opens the door for some scalable, easy-to-implement, and highly available solutions that are cost effective. This allows our architects to be much more creative with the solutions they provide."
>
> Ryan Sorensen
>
> Director of Application Development and Enterprise Architecture
>
> Coverdell

### Cost avoidance

Terminating a datacenter can also provide cost avoidance by preventing future refresh cycles. A refresh cycle is the process of buying new hardware and software to replace aging on-premises systems. In Azure, hardware and OS are routinely maintained, patched, and refreshed at no additional cost to customers. This allows CFOs to remove planned future spend from long-term financial forecasts. Cost avoidance is measured in dollars and differs from cost reduction, generally focusing on a future budget that has not been fully approved yet.

- **Example:** A company's datacenter is up for a lease renewal in six months. The datacenter has been in service for eight years. Four years ago, the company spent millions of dollars ensuring all servers were refreshed and virtualized. The company plans to refresh the hardware and software again next year. Migrating that datacenter's assets as part of a cloud migration allows cost avoidance by removing the planned refresh from next year's forecasted budget. It can also produce cost reduction by decreasing or eliminating real estate lease costs.

### Capital expenses and operating expenses

The two primary cost options are capital expenses and operating expenses.

The following terms can help you define the differences between capital expenses and operating expenses during business discussions about your transformation journey.

- **Capital** is the money and assets owned by a business to contribute to a particular purpose, such as increasing server capacity or building an application.
- **Capital expenditures** generate benefits over a long period. These expenditures are generally non-recurring and result in the acquisition of permanent assets. Building an application can qualify as a capital expenditure.
- **Operating expenditures** are a business' ongoing costs. Consuming cloud services in a pay-as-you-go model can qualify as an operating expenditure.
- **Assets** are economic resources that can be owned or controlled to produce value. Servers, data lakes, and applications can be considered assets.
- **Depreciation** is a decrease in the value of an asset over time. More relevant to the capital expense versus operating expense conversation, depreciation is how the costs of an asset are allocated across the periods in which they are used. For example, if you build an application this year but it's expected to have an average shelf life of five years (like most commercial applications), the cost of the development team and the tools required to create and deploy the code base would be depreciated evenly over five years.
- **Valuation** is the process of estimating a company's worth. In most industries, valuation is based on a company's ability to generate revenue and profit while respecting the operating costs required to create the goods that provide their revenue. In some industries, like retail, or in some transaction types, like private equity, assets and depreciation can play a large part in a company's valuation.

Various executives, including the chief investment officer (CIO), often debate the best use of capital to grow the company in the desired direction. Giving the CIO a means of converting contentious capital expense conversations into clear accountability for operating expenses can be an attractive outcome by itself. In many industries, chief financial officers (CFOs) actively look for ways to better associate fiscal accountability with the cost of goods being sold.

However, before you associate any transformation journey with this type of capital versus operating expense conversion, it's wise to meet with members of the CFO or CIO teams to see which cost structure your business prefers. In some organizations, reduction of capital expenses in favor of operating expenses is a highly undesirable outcome. As mentioned previously, this approach is sometimes seen in retail, holding, and private equity companies that place higher value on traditional asset accounting models, which place little value on IP. It's also seen in organizations that had negative experiences when outsourcing IT staff or other functions in the past.

The following example describes a situation where an operating expense model is a viable business outcome.

- **Example:** A company's datacenter is currently depreciating at *$x USD* per year for the next three years. It is expected to require an additional *$y USD* to refresh its hardware next year. We can convert the capital expenses to an operating expense model at an even rate of *$z USD* per month, enabling better management and accountability for the operating costs of technology.

## Next steps

Learn about [agility outcomes](./agility-outcomes.md).

> [!div class="nextstepaction"]
> [Agility outcomes](./agility-outcomes.md)
