---
title: "Azure innovation guide: Democratize data" 
titleSuffix: Microsoft Cloud Adoption Framework for Azure
description: Learn how to democratize data by using Azure
author: absheik
ms.author: absheik
ms.date: 10/17/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: innovate
ms.custom: fasttrack-new, AQC
ms.localizationpriority: high
---

::: zone target="docs"

# Azure innovation guide: Democratize data

::: zone-end

::: zone target="chromeless"

# Democratize data

::: zone-end

One of the first steps in democratizing data is to enhance data discoverability. Cataloging and managing data sharing can help enterprises get the most value from their existing information assets. A data catalog makes data sources easy to discover and understand by the users who manage the data. Azure Data Catalog enables management inside an enterprise, whereas Azure Data Share enables management and sharing outside the enterprise.

Azure services that provide data processing, like Azure Time Series Insights and Stream Analytics, are other capabilities that customers and partners are successfully using for their innovation needs.

# [Catalog](#tab/Catalog)

## Azure Data Catalog

Azure Data Catalog addresses the discovery challenges of data consumers and enables data producers who maintain information assets. It bridges the gap between IT and the business, allowing everyone to contribute their insights. You can store your data where you want it and connect with the tools you want to use. With Azure Data Catalog, you can control who can discover registered data assets. You can integrate into existing tools and processes by using open REST APIs.

> [!div class="checklist"]
>
> - Register
> - Search and annotate
> - Connect and manage

::: zone target="docs"

**Go to the [Azure Data Catalog documentation](https://docs.microsoft.com/azure/data-catalog)**

::: zone-end

::: zone target="chromeless"

### Action

You can use only one Azure data catalog per organization. If a data catalog has already been created for your organization, you can't add more catalogs.

To create an Azure data catalog for your organization:

1. Go to **Azure Data Catalog**.
2. Select **Create**.

<!-- markdownlint-disable DOCSMD001 -->

::: form action="OpenBlade[#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.DataCatalog%2Fcatalogs]" submitText="Go to Azure Data Catalog" :::

<!-- markdownlint-enable DOCSMD001 -->

::: zone-end

# [Share](#tab/Share)

## Azure Data Share

Achieving a balance between openly sharing data and exercising control over what data is shared and with whom is a key driver of innovation. When trying to democratize data, organizations can easily be overwhelmed by the enormity of the volume, pace, and lifecycle of the data. Azure Data Share ensures providers can control how their data is handled by specifying terms of use for their data share. The data consumer must accept these terms before being able to receive the data. Data providers can specify the frequency at which their data consumers receive updates. Access to new updates can be revoked at any time by the data provider.

> [!div class="checklist"]
>
> - Create a Data Share.
> - Add datasets to your Data Share.
> - Enable a synchronization schedule for your Data Share.
> - Add recipients to your Data Share.

::: zone target="docs"
**Go to the [Azure Data Share documentation](https://docs.microsoft.com/azure/data-share)**

::: zone-end

::: zone target="chromeless"

<!-- markdownlint-disable MD024 -->

### Action

To create a data share:

1. Go to **Azure Data Shares**.
2. Select **Create data share**.

<!-- markdownlint-disable DOCSMD001 -->

::: form action="OpenBlade[#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.DataShare%2Faccounts]" submitText="Go to Azure Data Shares" :::

<!-- markdownlint-enable DOCSMD001 -->

::: zone-end

Use [Azure Open Datasets](https://docs.microsoft.com/azure/open-datasets/overview-what-are-open-datasets) to enhance your analysis by incorporating [holiday](https://azure.microsoft.com/services/open-datasets/catalog/public-holidays), [weather](https://azure.microsoft.com/services/open-datasets/catalog/noaa-global-forecast-system), and
[spatial imagery](https://azure.microsoft.com/services/open-datasets/catalog/hls) data into your models.

Next steps include [democratizing business processes](https://docs.microsoft.com/business-applications-release-notes/october18/microsoft-flow/democratize-business-processes) and [empowering citizen developers](https://docs.microsoft.com/business-applications-release-notes/october18/microsoft-flow/empower-citizen-developers).

# [Insights](#tab/Insights)

## Azure Time Series Insights

The data innovation capabilities of Azure Time Series Insights are endless. It provides near-real-time data exploration of data streams and multilayered storage for IoT-scale time series data. It also provides models to contextualize raw telemetry and derive asset-based insights. You can deliver smooth and continuous integration with other data solutions and provide root-cause analysis and anomaly detection, including custom-built application options, on the Time Series Insights platform.

> [!div class="checklist"]
>
> - Plan your Time Series Insights environment.
> - Visualize data in the explorer.
> - Understand data retention.
> - Develop and share custom views.

::: zone target="docs"

**Go to the [Azure Time Series Insights overview](https://docs.microsoft.com/azure/time-series-insights/time-series-insights-update-overview)**

::: zone-end

::: zone target="chromeless"

### Action

To create an Azure Time Series Insights environment:

1. Go to **Azure Time Series Insights environments**.
2. Select **Create time series insights environment**.
3. Point this environment to an event source, either Azure IoT Hub or Event Hubs.

<!-- markdownlint-disable DOCSMD001 -->

::: form action="OpenBlade[#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.TimeSeriesInsights%2Fenvironments]" submitText="Go to Azure Time Series Insights" :::

<!-- markdownlint-enable DOCSMD001 -->

::: zone-end
