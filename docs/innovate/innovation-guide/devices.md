---
title: "Azure innovation guide: Interact through devices" 
description: Azure innovation guide - Interact through devices
author: umarmohamedusman
ms.author: umarm
ms.date: 10/10/2019
ms.topic: guide
ms.service: cloud-adoption-framework
ms.subservice: innovate
ms.custom: fasttrack-new, AQC
ms.localizationpriority: high
---

::: zone target="docs"

# Azure innovation guide: Interact through devices

::: zone-end

::: zone target="chromeless"

# Interact through devices

::: zone-end

Innovate through intermittently connected and perceptive edge devices. Orchestrate millions of such devices, acquire and process limitless data, and take advantage of a growing number of multisensory, multidevice experiences. For devices at the edge of your network, Azure provides a framework for building immersive and effective business solutions. With ubiquitous computing, enabled by Azure combined with artificial intelligence (AI) technology, you can build every type of intelligent application and system you can envision.

Azure customers employ a continually expanding set of connected systems and devices that gather and analyze data&mdash;close to their users, the data, or both. Users get real-time insights and experiences, delivered by highly responsive and contextually aware apps. By moving parts of the workload to the edge, these devices can spend less time sending messages to the cloud and react more quickly to spatial events.

> [!div class="checklist"]
>
> - Industrial assets
> - HoloLens 2
> - Azure Sphere
> - Kinect DK
> - Drones
> - Azure SQL Database Edge
> - IoT Plug and Play

<!-- markdownlint-disable MD025 -->

## [Global scale IoT service](#tab/IoTHub)

<!-- markdownlint-enable MD025 -->

Architect solutions that exercise bidirectional communication with IoT devices at billions scale. Use out-of-box, device-to-cloud telemetry data to understand the state of your devices and define message routes to other Azure services just through configuration. By taking advantage of cloud-to-device messages, you can reliably send commands and notifications to your connected devices and track message delivery with acknowledgment receipts. And you'll automatically resend device messages as needed to accommodate intermittent connectivity.

Here are a few features you'll find:

- **Security-enhanced communication** channel for sending and receiving data from IoT devices.
- **Built-in device management** and provisioning to connect and manage IoT devices at scale.
- **Full integration with Event Grid** and serverless compute, simplifying IoT application development.
- **Compatibility with Azure IoT Edge** for building hybrid IoT applications.

::: zone target="docs"

**Go to [IoT Hub](https://docs.microsoft.com/azure/iot-dps)**

**Go to [Device Provisioning Services](https://docs.microsoft.com/azure/iot-dps)**

::: zone-end

::: zone target="chromeless"

### Action

To create an IoT hub:

1. Go to **IoT Hub**.
2. Select **Create IoT hub**.

<!-- markdownlint-disable DOCSMD001 -->

::: form action="OpenBlade[#blade/HubsExtension/BrowseResource/resourceType/Microsoft.Devices%2FIotHubs]" submitText="Go to IoT Hub" :::

<!-- markdownlint-enable DOCSMD001 -->

The IoT Hub Device Provisioning Service is a helper service for IoT Hub that enables zero-touch, just-in-time provisioning.

<!-- markdownlint-disable MD024 -->

### Action

To create IoT Hub Device Provisioning Services:

1. Go to **IoT Hub Device Provisioning Services**.
2. Select **Create Device Provisioning Services**.

<!-- markdownlint-disable DOCSMD001 -->

::: form action="OpenBlade[#blade/HubsExtension/BrowseResource/resourceType/Microsoft.Devices%2FProvisioningServices]" submitText="Go to Device Provisioning Services" :::

<!-- markdownlint-enable DOCSMD001 -->

::: zone-end

<!-- markdownlint-disable MD025 -->

## [Azure Digital Twins](#tab/DigitalTwins)

Build reusable, highly scalable, spatially aware experiences that link streaming data across the physical and digital world. Enhance your customer engagement using comprehensive models of physical environments. Generate spatial intelligence graphs to model the relationships and interactions between people, places, and devices. Query data from a physical space rather than disparate sensors.

**Azure Digital Twins object models:** An ontology that describes the regions, venues, floors, offices, zones, conference rooms, and focus rooms of a smart building, or various power stations, substations, energy resources, and customers of an energy grid, can be modeled by using digital twins object models and ontologies.

**Spatial intelligence graph:** The hierarchical graph of spaces, devices, and people defined in the Digital Twins object model that supports inheritance, filtering, traversing, scalability, and extensibility. You can manage and interact with your spatial graph through the collection of REST APIs that are hosted in Azure.

::: zone target="docs"

**Go to [Azure Digital Twins](https://docs.microsoft.com/azure/digital-twins/about-digital-twins)**

::: zone-end

::: zone target="chromeless"

### Action

To create Azure Digital Twins:

1. In the left pane, select **Create a resource**.
2. Search for **digital twins**, and then select **Digital Twins**.
3. Select **Create** to start the deployment process.
4. To review existing Digital Twins, select this button:

<!-- markdownlint-disable DOCSMD001 -->

::: form action="OpenBlade[#blade/HubsExtension/BrowseResource/resourceType/Microsoft.IoTSpaces%2FGraph]" submitText="Go to Digital Twins" :::

<!-- markdownlint-enable DOCSMD001 -->

::: zone-end

<!-- markdownlint-disable MD025 -->

## [Location intelligence](#tab/AzureMaps)

In addition to traditional location capabilities such as nearby, traffic, and routing, the Azure Maps service enables enterprises to create solutions by using real-time location intelligence that's powered by world-class mobility technology partners **TomTom** and **Moovit**. Easily integrate advanced location and mobility capabilities into your applications with geospatial services.

**Data Service Preview:** Upload and store geospatial data for use with spatial operations or image composition to reduce latency, increase productivity, and enable new scenarios within your applications.

**Spatial operations:** Enhance your location intelligence with a library of common geospatial mathematical calculations, including geofencing, closest point, great circle distance, and buffers.

**Geolocation:** Look up the country of an IP address. Customize content and services based on user location, and gain insight on customer geographic distribution.

::: zone target="docs"

**Go to [Azure Maps](https://docs.microsoft.com/azure/azure-maps)**

::: zone-end

::: zone target="chromeless"

### Action

To use Location Intelligence:

1. Go to **Azure Maps Accounts**.
2. Select **Create Azure Maps accounts**.

<!-- markdownlint-disable DOCSMD001 -->

::: form action="OpenBlade[#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.Maps%2Faccounts]" submitText="Go to Azure Maps Account" :::

<!-- markdownlint-enable DOCSMD001 -->

::: zone-end

## [Spatial experiences](#tab/spatial)

Azure Spatial Anchors enables developers to work with mixed-reality platforms to perceive spaces, designate precise points of interest, and recall those points of interest from supported devices.

**Add context to the real world:** Give your users a better understanding of their data, where they need it, and when they need it by placing and connecting your digital content to physical points of interest.

**Share holograms across devices:** Accelerate decisions and results by bringing 3D to your team and customers on the device of their choice. Spatial Anchors makes it easy for people in the same space to participate in multiuser, mixed-reality applications.

**Engaging experiences:** Connect spatial anchors by creating relationships between them, and deliver a user experience that might include two or more points of interest that a user must interact with to complete a task. Your app can let a user place a virtual artifact in the real world. In an industrial setting, a user could receive contextual information about a machine by pointing a supported device camera at it.

Azure Spatial Anchors is composed of a managed service and client SDKs for supported device platforms.

::: zone target="docs"

**Go to [Azure Spatial Anchors](https://azure.microsoft.com/services/spatial-anchors)**

::: zone-end

::: zone target="chromeless"

### Action

To use Spatial experiences:

1. Go to **Spatial Anchors Accounts**.
2. Select **Create spatial anchors accounts**.

<!-- markdownlint-disable DOCSMD001 -->

::: form action="OpenBlade[#blade/HubsExtension/BrowseResource/resourceType/Microsoft.MixedReality%2FspatialAnchorsAccounts]" submitText="Go to Spatial Anchors Accounts" :::

<!-- markdownlint-enable DOCSMD001 -->

::: zone-end

## [Azure Remote Rendering](#tab/RemoteRender)

Render high-quality interactive 3D content in the cloud and stream it to your devices in real time. Rendering workloads are heavily used for special effects (VFX) in the media and entertainment industry. Rendering is also used in many other industries, such as advertising, retail, oil and gas, and manufacturing.

The process of rendering is computationally intensive. There can be many frames or images to produce, and each image can take many hours to render. Rendering is therefore a perfect workload for batch processing that can use Azure and Azure Batch to run many renders in parallel.

::: zone target="docs"

**Go to [Azure Remote Rendering](https://azure.microsoft.com/services/remote-rendering)**

**Go to [Rendering using Azure](https://docs.microsoft.com/azure/batch/batch-rendering-service)**

::: zone-end

::: zone target="chromeless"

### Action

To use Remote Rendering:

1. Go to **Batch Accounts**.
2. Select **Create batch accounts**.

<!-- markdownlint-disable DOCSMD001 -->

::: form action="OpenBlade[#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.Batch%2FbatchAccounts]" submitText="Go to Azure Batch" :::

<!-- markdownlint-enable DOCSMD001 -->

::: zone-end
