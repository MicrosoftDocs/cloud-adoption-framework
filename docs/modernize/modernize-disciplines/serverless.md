### Serverless application platform components

At the center of the Serverless platform, are our compute offerings: Azure Functions and Azure Logic Apps. Azure Functions is an event-based Serverless compute experience that helps you accelerate your development. Logic Apps is a powerful orchestration tool, which enables building a Serverless app in minutes by orchestrating multiple functions using a visual workflow tool.

:::image type="content" source="../../_images/modernize/serverless-application-platform-components.png" alt-text="Graphic showing serverless app plat components.":::

Once you have your apps up and running using Serverless, then you can collect intelligence from different apps across platforms to action on. The following essential components are core to building Serverless applications:

- **Data/Storage:** Azure Functions has triggers and bindings with Azure document DB and Azure Blob storage.
- **Triggers:** Event responses used to trigger your custom code. They allow you to respond to events across the Azure platform or on premise.
- **Bindings:** Represent the necessary metadata used to connect your code to the desired trigger or associated input or output data.
- **Messaging:** Queues and topics using Azure Service Bus and Azure Event Hubs.
- **Integration:** Includes core LOB apps and SaaS apps integration via Azure Logic Apps.
- **Intelligence on data and sentiment:** Predictive analysis using Cognitive services and Machine learning.
- **Conversation as a service:** Equips developers to build apps that offer an end-to-end experience for their users. Azure Bot Service offers a Serverless interactive bot experience.

Developers are spending more time writing code, which allows them to add huge business results with Serverless. Microsoft offers numerous development tools, such as IDE Support for Visual Studio in Azure Functions and Logic Apps, which enable local development and visual debugging capability, all with your tools of choice.

#### Use cases for Serverless

We've highlighted the following top scenarios and use cases for Serverless:

- **Real-time Stream analytics:** Uses Azure Functions to feed real-time streams of data from application tracking into structured data and store it in SQL online.
- **SaaS event processing:** Uses Azure Functions and Logic Apps to analyze data from an excel file in OneDrive. Then performs validation, filtration, sorting, and conversion of data into consumable business charts.
- **Web app architecture:** Uses a function to create an ad that matches your customer profile and displays a completed webpage. After you select on a webpage, a webhook gets triggered. Used often in creating targeted marketing collateral.
- **Real-time bot messaging:** Uses Azure Functions and calls Cortana analytics to generate appropriate answers and sends a response back, when you send a message to a chatbot.