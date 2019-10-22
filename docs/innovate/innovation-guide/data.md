---
title: "Azure innovation guide: Democratize data" 
titleSuffix: Microsoft Cloud Adoption Framework for Azure
description: Learn to democratize data using Azure.
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

One of the first steps to democratize data is to enhance data discoverability. Cataloging and managing data sharing can help enterprises get the most value from their existing information assets. A data catalog makes data sources easily discoverable and understandable by the users who manage the data. Azure Data Catalog enables management inside an enterprise whereas Azure Data Share enables management and sharing outside the enterprise.

Azure services that provide data processing like Azure Time Series Insights and Stream Analytics are other capabilities that customers and partners are successfully leveraging for their innovation needs.

# [Catalog](#tab/Catalog)

## Azure Data Catalog

Azure data catalog addresses the discovery challenges of data consumers in addition to enabling data producers maintaining information assets. Bridge the gap between IT and the business, allowing everyone to contribute their insights. Let your data live where you want it, connect with the tools you choose. Control who can discover registered data assets. Integrate into existing tools and processes with open REST APIs.

> [!div class="checklist"]
>
> - Register
> - Search and Annotate
> - Connect and Manage

::: zone target="docs"

**Go to [Azure Data Catalog](https://docs.microsoft.com/azure/data-catalog).**

::: zone-end

::: zone target="chromeless"

### Action

Only one Azure Data Catalog is supported per organization. If a Catalog has already been created for your organization, you cannot add additional catalogs.

To create Azure Data Catalog for your organization:

1. Go to **Azure Data Catalog**.
2. Click Create button

<!-- markdownlint-disable DOCSMD001 -->

::: form action="OpenBlade[#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.DataCatalog%2Fcatalogs]" submitText="Go to Azure Data Catalog" :::

<!-- markdownlint-enable DOCSMD001 -->

::: zone-end

# [Share](#tab/Share)

## Azure Data Share

Achieving balance between openly sharing data and having control over what data is shared and with whom is a key driver of innovation. While endeavoring to democratize data, organizations can easily be overwhelmed by the enormity of the volume, pace, and lifecycle of such data. Using Azure Data Share ensures the provider can stay in control of how their data is handled by specifying terms of use for their data share. The data consumer must accept these terms before being able to receive the data. Data providers can specify the frequency at which their data consumers receive updates. Access to new updates can be revoked at any time by the data provider.

> [!div class="checklist"]
>
> - Create a Data Share.
> - Add datasets to your Data Share.
> - Enable a synchronization schedule for your Data Share.
> - Add recipients to your Data Share.

::: zone target="docs"
**Go to [Azure Data Share](https://docs.microsoft.com/azure/data-share).**

::: zone-end

::: zone target="chromeless"

<!-- markdownlint-disable DOCSMD001 -->

### Action

To create Azure Data Share

1. Go to **Azure Data Share**.
2. Click Create Data Share

::: form action="OpenBlade[#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.DataShare%2Faccounts]" submitText="Go to Azure Data Share" :::

<!-- markdownlint-enable DOCSMD001 -->

::: zone-end

Use [Azure Open Datasets](https://docs.microsoft.com/azure/open-datasets/overview-what-are-open-datasets) to enhance your analysis by incorporating [holiday](https://azure.microsoft.com/services/open-datasets/catalog/public-holidays), [weather](https://azure.microsoft.com/services/open-datasets/catalog/noaa-global-forecast-system), and
[spatial imagery](https://azure.microsoft.com/services/open-datasets/catalog/hls) data in to your models.

Information on [democratizing business processes](https://docs.microsoft.com/business-applications-release-notes/october18/microsoft-flow/democratize-business-processes) and [empowering citizen developers](https://docs.microsoft.com/business-applications-release-notes/october18/microsoft-flow/empower-citizen-developers) found here are next steps.

# [Insights](#tab/Insights)

## Azure Time Series Insights

Making near real-time data exploration of data streams and multilayered storage for IoT-scale time series data and models to contextualize raw telemetry and derive asset-based insights, the Data innovation capabilities are endless. You can deliver smooth and continuous integration with other data solutions, provide root-cause analysis and anomaly detection, including custom-built application options on Time Series Insights platform.

> [!div class="checklist"]
>
> - Plan your Time Series Insights environment.
> - Visualize data in the explorer.
> - Understand data retention.
> - Develop and share custom views.

::: zone target="docs"

**Go to [Azure Time Series Insights](https://docs.microsoft.com/azure/time-series-insights/time-series-insights-update-overview).**.

::: zone-end

::: zone target="chromeless"

<!-- markdownlint-disable DOCSMD001 -->

### Action

To create Azure Time Series Insights

1. Go to **Azure Time Series Insights**.
2. Click Create Time Series Insights environment
3. Point this environment to an event source, either IoT Hub or Event Hub

::: form action="OpenBlade[#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.TimeSeriesInsights%2Fenvironments]" submitText="Go to Azure Time Series Insights" :::

<!-- markdownlint-enable DOCSMD001 -->

::: zone-end
