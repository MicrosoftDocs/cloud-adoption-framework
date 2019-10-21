---
title: "Cloud innovation: Interact with devices"
titleSuffix: Microsoft Cloud Adoption Framework for Azure
description: Introduction to Cloud innovation - Interact with devices
author: BrianBlanchard
ms.author: brblanch
ms.date: 10/17/2019
ms.topic: guide
ms.service: cloud-adoption-framework
ms.subservice: innovate
---

# Ambient experiences: Interact with devices

In [building with empathy](./build.md), we discussed the three tests of true innovation: Solve a customer need, Keep the customer coming back, Scale across a base of customer cohorts. Each test of your hypothesis will require effort and iterations on the approach to adoption. This article will provide insights on some advanced approaches to reduce that effort through **ambient experiences**. By interacting with devices, instead of an application, the customer may be more likely to turn to your solution first to have their need met.

## Ambient experiences

An ambient experience is a digital experience which relates to the immediate surroundings. A solution which features ambient experiences strives to meet the customer in their moment of need. When possible, the solution meets the customer need without leaving the natural flow of what they were doing.

Life in the digital economy is full of distractions. We are all bombarded with social, email, web, visual, and verbal messaging, each of which is a risk of distraction. The risk of distraction increases with every second between the customer's point of need and an interaction with the solution. Countless customers are lost in that brief gap of time. To foster increases in repeat adoption, reduce the number of distractions by reducing time to solution (TTS).

## Interacting with devices

A standard web experience is the most common application development technique used to meet a customer's needs. The assumption baked into this approach is that the customer will be in front of their computer. If your customer consistently meets their point of need while in front of their laptop, build a web app. That web app will provide an "ambient experience" for that customer, in that scenario. But, we know this scenario is increasingly less likely in modern society.

![Ambient experiences](../../_images/innovate/ambient-experiences.png)

Ambient experiences, as illustrated above, usually require more than a web app. Through [measurement](./measure.md) and [learning with the customer](./learn.md) the behavior that leads to the customer's need trigger can be observed, tracked, and used to build a more ambient experience. The following summarizes a few approaches to integration of ambient solutions into your hypotheses, more details on each in the following paragraphs.

- **[Mobile experience](#mobile-experience)**: Much like a laptop, mobile apps are commonly a part of the customers' surroundings. In some scenarios, this may provide a sufficient level of interactivity to make a solution ambient.
- **[Mixed reality](#mixed-reality):** Sometimes a customer's natural surroundings must be altered to make an interaction ambient. This creates a bit of a false reality in which the customer can interact with the solution and have a need met. In this case, the solution is ambient within the false reality.
- **[Integrated reality](#integrated-reality):** Moving closer to true ambience, integrated reality solutions focus on the use of a device that exists within the customer's reality to integrate the solution into natural behaviors. A virtual assistant is a great example of integrating reality into the surrounding environment. A lesser known option is to use Internet of Things (IoT) technologies to integrate devices that already exist in the customer's surroundings.
- **[Adjusted reality](#adjusted-reality):** When any of the ambient solutions above use predictive analysis in the cloud to define and provide an interaction with the customer through the natural surroundings, the solution has adjusted reality.

Understanding the customer need and measuring customer impact will aid in determining if a device interaction or ambient experience will be required to validate your hypothesis. With each of those data points, the following sections will help find the best solution.

## Mobile experience

The first stage of ambient experience is to get away from the computer. Today's consumers and business professionals move fluidly between mobile and PC devices. Each of the platforms or devices used by your customer creates a new potential experience for the customer. Adding a mobile experience that extends the primary solution is the fastest way to improve integration into the customer's immediate surroundings. While a mobile device is far from ambient, it could get closer to the customer's point of need.

When customers are mobile and changing locations frequently, this may be the most relevant form of ambient experience for a given solution. One common source of innovation over the last decade has been the expansion of existing solutions to integrate a mobile experience.

Examples of this approach can be seen in Azure App Services. During early iterations, the [web app feature of Azure App Service](/azure/app-service/overview) can be used to test the hypothesis. As the hypotheses become more complex, the [mobile app feature of Azure App Services](/azure/app-service-mobile/) can extend the web app to run in a variety of mobile platforms.

## Mixed reality

The next level of maturity for ambient experiences is the augmentation or replication of the customer's surroundings through mixed reality solutions. In this approach, the solution becomes more ambient by created an extension of reality for the customer to operate within.

> [!IMPORTANT]
> If a virtual reality (VR) device is required and *is not already part of their immediate surrounding or natural behaviors*, then augmented/virtual reality is more of an alternative experience and less of an ambient experience.

This form of experience is increasingly common for remote workforces. Use of these experiences is growing even faster in industries that require collaboration or specialty skills which are not readily available in the local market. One common scenario requiring augmented reality as part of a natural behavior is centralized implementation support of a complex product for a remote labor force. In those scenarios, the central support team and remote employee may leverage augmented reality to work troubleshoot or install the product.

For the scenario above or other similar scenarios, an example of an ambient experience would be the use of spatial anchors. Spatial anchors allow you to create mixed reality experiences with objects that persist their location across devices over time. Through spatial anchors, a specific behavior can be captured, recorded, and persisted providing an ambient experience, the next time the user is operating within that augmented environment. [Azure Spatial Anchors](https://docs.microsoft.com/azure/spatial-anchors/overview) is a service which moves this logic to the cloud, allowing experiences to be shared across devices and even across solutions.

## Integrated reality

Beyond mobile reality or even mixed reality is the use of integrated reality. In this approach, the objective is to remove the digital experience entirely. All around us are devices with compute and connectivity capabilities. These devices can be used to collect data from the immediate surroundings without the customer having to ever touch a phone, laptop, or VR device.

This form of experience is ideal when some form of device is consistently within the same surroundings in which the customer need occurs. Common scenarios include factory floors, elevators, or even your car. These types of large devices already contain compute power. You can also use data from the device itself to detect customer behaviors and send those behaviors into the cloud. This automatic capture of customer behavior data dramatically reduces the need for a customer to input data. Furthermore, the web, mobile, or VR experience can be used as a feedback loop to share what has been learned from the integrated reality solution.

Examples of integrated reality in Azure could include:

- [Azure Internet of Things (IoT) solutions](https://docs.microsoft.com/azure/iot-fundamentals), a collection of services in Azure which each aid in managing devices and the flow of data from those devices into the cloud and back out to end users.
- [Azure Sphere](/azure-sphere), a combination of hardware and software, Azure Sphere is an innately secure way to enable an existing device to securely transmit data between the device and Azure IoT solutions.
- [Azure Kinect Developers Kit](https://docs.microsoft.com/azure/Kinect-dk), AI sensors with advance computer vision and speech models, which can collect visual and audio data from the immediate surroundings and feed those inputs into your solution.

All three can be used to collect data within the natural surroundings, at the point of customer need. From there, your solution can respond to those data inputs to solve the need, sometimes before the customer is even aware that a trigger for that need has occurred.

## Adjusted reality

The highest form of ambient experience is adjusted reality, often referred to as ambient intelligence. Adjusted reality is an approach to using information from your solution to change the customer's reality, without the need to interact directly with an application. In this approach, the application you initially built to prove your hypothesis may not longer be relevant at all. Instead, the devices in the environment would facilitate the inputs and outputs to meet the customers need.

Virtual assistants / smart speakers can provide a great example of adjusted reality. Alone, a smart speaker is an example of simple integrated reality. Add a smart light and motion sense to a smart speaker solution and it's easy to create a basic solution with turns on the lights when you enter a room.

Factory floors around the world provide additional scenarios of adjusted reality. During early stages of integrated reality, sensors on devices detected conditions, such as overheating, and reported a need for a change to a human being via an application. In adjusted reality, the customer may still be involved. But, the feedback loop is tighter. In an adjusted reality factory floor, one device would detect overheating in a vital machine somewhere within the assembly line. Somewhere else on the floor, a second device would slow production slightly to allow the machine to cool and resume pace when the condition was resolved. In this scenario, the customer is a second-hand participate. The customer uses your application to set the rules and understand how those rules have affected production, but would not be a required part of the feedback loop.

The Azure services in the prior section, [Azure Internet of Things (IoT) solutions](https://docs.microsoft.com/azure/iot-fundamentals), [Azure Sphere](/azure-sphere), and [Azure Kinect Developers Kit](https://docs.microsoft.com/azure/Kinect-dk) could each be components of an adjusted reality solution. Your original application and business logic would serve as a the intermediary between the environmental input and the change that should be made to the physical environment.

Another example of adjusted reality is the creation of a digital twin, which is a digital representation of a physical device, presented through through computer, mobile, or mixed-reality formats. Unlike less sophisticated 3D models, a digital twin reflects data collected from an actual device in the physical environment. This allows the user to interact with the digital representation in ways that could never be done in the real world. In this approach the physical devices are adjusting a mixed reality environment. But, the solution is still gathering data from an integrated reality solution and using that to shape the reality of the customer's current surroundings.

In Azure, digital twins are created and accessed through a service called [Azure Digital Twins](https://docs.microsoft.com/azure/digital-twins/about-digital-twins).

## Next steps

With a deeper understanding of device interactions and the ambient experience that is right for your solution, you're now ready to explore the final discipline of innovation, [Predict and influence](./predict.md).

> [!div class="nextstepaction"]
> [Predict and influence](./predict.md)
