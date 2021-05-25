---
title: Data democratization tools
description: Learn about data democratization with Azure Data Catalog, Azure Data Share, and other tools that enhance data discoverability and understanding.
author: BrianBlanchard
ms.author: brblanch
ms.date: 01/27/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: innovate
ms.localizationpriority: high
ms.custom: internal, fasttrack-new, AQC, seo-caf-innovate
keywords: Democratize, democratize data, democratizing data, data democratization, democratized
---

# Data democratization tools

Data democratization is the ability to make digital information accessible to the average non-technical user of information systems, without having a gatekeeper or outside help to access the data. Democratizing data helps users gain unfettered access to important data without creating a bottleneck that impedes productivity.

One of the first steps in democratizing data is to enhance data discoverability. Cataloging and managing data sharing can help enterprises get the most value from their existing information assets. By democratizing a data catalog it makes data sources easy to discover and understand by the users who manage the data. Azure Data Catalog enables management inside an enterprise, whereas Azure Data Share enables management and sharing outside the enterprise.

Azure services that provide data processing, like Azure Time Series Insights and Stream Analytics, are other capabilities that customers and partners are successfully using for their innovation needs.

## [Catalog](#tab/Catalog)

### Azure Data Catalog

Azure Data Catalog addresses the discovery challenges of data consumers and enables data producers who maintain information assets. It bridges the gap between IT and the business, allowing everyone to contribute their insights. You can store your data where you want it and connect with the tools you want to use. With Azure Data Catalog, you can control who can discover registered data assets. You can integrate into existing tools and processes by using open REST APIs.

> [!div class="checklist"]
>
> - Register
> - Search and annotate
> - Connect and manage

::: zone target="docs"

**Go to the [Azure Data Catalog documentation](/azure/data-catalog/)**

::: zone-end

::: zone target="chromeless"

#### Action

You can use only one Azure Data Catalog per organization. If a catalog has already been created for your organization, you can't add more catalogs.

To create a catalog for your organization:

1. Go to **Azure Data Catalog**.
2. Select **Create**.

<!-- markdownlint-disable DOCSMD001 -->

::: form action="OpenBlade[#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.DataCatalog%2FCatalogs]" submitText="Go to Azure Data Catalog" :::

<!-- markdownlint-enable DOCSMD001 -->

::: zone-end

## [Share](#tab/Share)

### Azure Data Share

Achieving a balance between openly sharing data and exercising control over what data is shared and with whom is a key driver of innovation. When trying to democratize data, organizations can easily be overwhelmed by the enormity of the volume, pace, and lifecycle of the data. Azure Data Share ensures providers can control how their data is handled by specifying terms of use for their data share. The data consumer must accept these terms before receiving the data. Data providers can specify the frequency at which their data consumers receive updates. Access to new updates can be revoked at any time by the data provider.

> [!div class="checklist"]
>
> - Create a data share.
> - Add datasets to your data share.
> - Enable a synchronization schedule for your data share.
> - Add recipients to your data share.

::: zone target="docs"

**Go to the [Azure Data Share documentation](/azure/data-share/)**

::: zone-end

::: zone target="chromeless"

<!-- markdownlint-disable MD024 -->

#### Action

To create a data share:

1. Go to **Azure Data Shares**.
2. Select **Create data share**.

<!-- markdownlint-disable DOCSMD001 -->

::: form action="OpenBlade[#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.DataShare%2FAccounts]" submitText="Go to Azure Data Shares" :::

<!-- markdownlint-enable DOCSMD001 -->

::: zone-end

## [Insights](#tab/Insights)

### Azure Time Series Insights

The data innovation capabilities of Azure Time Series Insights are endless. It provides near-real-time data exploration of data streams and multilayered storage for IoT-scale time series data. It also provides models to contextualize raw telemetry and derive asset-based insights. You can deliver smooth and continuous integration with other data solutions and provide root-cause analysis and anomaly detection, including custom-built application options, on the Time Series Insights platform.

> [!div class="checklist"]
>
> - Plan your Time Series Insights environment.
> - Visualize data in the explorer.
> - Understand data retention.
> - Develop and share custom views.

::: zone target="docs"

**Go to the [Azure Time Series Insights overview](/azure/time-series-insights/overview-what-is-tsi)**

::: zone-end

::: zone target="chromeless"

#### Action

To create an Azure Time Series Insights environment:

1. Go to **Azure Time Series Insights environments**.
2. Select **Create Time Series Insights environment**.
3. Point this environment to an event source, either Azure IoT Hub or Event Hubs.

<!-- markdownlint-disable DOCSMD001 -->

::: form action="OpenBlade[#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.TimeSeriesInsights%2FEnvironments]" submitText="Go to Azure Time Series Insights" :::

<!-- markdownlint-enable DOCSMD001 -->

::: zone-end
