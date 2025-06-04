---
title: Ambient experience for device interaction
description: Learn about Azure tools for device interaction and ambient experiences that augment customers' natural surroundings and behaviors.
author: Zimmergren
ms.author: pnp
ms.date: 10/17/2019
ms.topic: conceptual
ms.custom: internal
keywords: ambient user experience, ambient experience, device interaction
---

# Ambient experience tools to interact with devices in Azure

As described in [Interacting with devices](../considerations/devices.md), the devices used to interact with a customer depend on how much ambient user experience is required to deliver the customer's need and empower adoption. Speed from the trigger that prompts the customer's need and your solution's ability to meet that need are determining factors in repeat usage. Ambient experiences help accelerate that response time and create a better experience for your customers by embedding your solution in the customers' immediate surroundings.

![Diagram that shows the Cloud Adoption Framework approach to interact with devices.](../../_images/innovate/ambient-experiences.png)

## Alignment to the methodology

This type of digital invention can be delivered through any of the following levels of ambient experience. The table of contents on the left side of this page lists technical guidance to accelerate digital invention. Those device interaction articles are grouped by level of ambient user experience to align with the methodology.

- **Mobile experience:** Mobile apps are commonly part of a customer's surroundings. In some scenarios, a mobile device might provide enough interactivity to make a solution ambient.
- **Mixed reality:** Sometimes a customer's natural surroundings must be altered through mixed reality. Engaging a customer within that mixed reality can provide a form of ambient user experience.
- **Integrated reality:** Moving closer to true ambience, integrated reality solutions focus on the use of a customer's physical device to integrate the solution into natural behaviors.
- **Adjusted reality:** When any of the preceding solutions use predictive analysis to provide an interaction with a customer within that customer's natural surroundings, that solution creates the highest form of ambient experience.

## Toolchain

In Azure, you commonly use the following tools to accelerate digital invention across each level of ambient user experience solutions. These tools are grouped based on the amount of experience required to reduce complexity in aligning tools with those experiences.

| Category | Tools |
|---|---|
| Mobile experiences | <li> Azure App Service <li> Power Apps <li> Power Automate <li> Intune |
| Mixed reality | <li> Unity <li> HoloLens |
| Integrated reality | <li> Azure IoT Hub <li> Azure Sphere <li> Azure Kinect DK |
| Adjusted reality | <li> IoT cloud to device <li> Azure Digital Twins + HoloLens |

## Get started

Below you'll find articles to help you get started with each of the tools in this toolchain.

> [!NOTE]
> The following links will leave the Cloud Adoption Framework, as they reference supporting content that's beyond the scope of CAF.

### Mobile experience

- [Extend a legacy claims-processing application with a web and mobile experience](/azure/architecture/solution-ideas/articles/adding-a-modern-web-and-mobile-frontend-to-a-legacy-claims-processing-application)
- [Optimize reports to share data on a mobile app](/power-bi/create-reports/desktop-create-phone-report)
- [Extend Power Apps canvas application to a mobile experience](/powerapps/mobile/run-powerapps-on-mobile)
- [Extend Power Automate to add a mobile experience](/power-automate/create-mobile-task-flow)
- **Secure mobile experiences**
- [Protect mobile reports with face, touch, or passcodes](/power-bi/consumer/mobile/mobile-native-secure-access)
- [Secure mobile task flows with Intune](/power-automate/intune-support)
- [Secure data in common data services](/power-platform/admin/wp-security)

### Mixed reality

- [Develop mixed reality experiences with Unity](/windows/mixed-reality/develop/unity/unity-development-overview)

### Integrated reality and IoT

- [Visualize sensor data with Azure IoT in Power BI](/azure/iot-hub/iot-hub-live-data-visualization-in-power-bi)
- [Visualize sensor data with Azure IoT Hub in a web solution](/azure/iot-hub/iot-hub-live-data-visualization-in-web-apps)
- [Securing an IoT solution](/azure/iot-fundamentals/iot-security-architecture)
- [Get started with Azure Sphere](https://azure.microsoft.com/services/azure-sphere/get-started/)
- [Create a deployment with Azure Sphere](/azure-sphere/deployment/create-a-deployment)
- [Get started with Azure Kinect DK](/azure/Kinect-dk/about-azure-kinect-dk)
- [Build your first Azure Kinect DK application](/azure/Kinect-dk/build-first-app)

### Adjusted reality

- ["Azure Digital Twins + HoloLens: Adjusting virtual reality"](https://azure.microsoft.com/resources/videos/)
- [Get started with Azure Digital Twins](/azure/digital-twins/overview)
- [Monitor a building with Azure Digital Twins](/previous-versions/azure/digital-twins/tutorial-facilities-setup)
- [Azure IoT for cloud-to-device communications guide](/azure/iot-hub/iot-hub-devguide-c2d-guidance)
- [Azure IoT configuration for cloud-to-device communications](/azure/iot-hub/iot-hub-devguide-c2d-guidance)

## Next steps

Learn about tools for predictive analysis and integration of their output into applications.

> [!div class="nextstepaction"]
> [Predict and influence](./predict.md)
