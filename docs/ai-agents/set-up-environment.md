---
title: Set up AI agent environments
description: Learn the Set up AI agent environments
author: stephen-sumner
ms.author: pnp
ms.date: 11/01/2025
ms.update-cycle: 180-days
ms.topic: conceptual
ms.collection: ce-skilling-ai-copilot
---

# Set up AI agent environments

This section provides a high level of overview of how to build agents for technical decision makers so they can see the roadmap and weigh the investment and ROI. It will also help you understand when to use single vs multi agent systems and resources on how to use each building tool Microsoft Copilot Studio and Azure AI Foundry. Set up the development and runtime environment before heavy development starts, to avoid disruptions later. Depending on your chosen approach (SaaS vs custom), this could mean simply enabling a service or a complex cloud setup:

- **Microsoft Copilots setup.** Environment setup is minimal. Focus on licensing, deployment, and data readiness. Ensure users are licensed for Copilot and that your data is well-organized with proper access controls. Copilots draw on this data. Good data governance will directly affect the quality and compliance of the agent’s answers. Use [Microsoft Purview](/azure/purview/ai-microsoft-purview) to classify and protect sensitive info. See the different setup requirements for your Copilot of choice. Use the links in the [Copilot overview](/azure/cloud-adoption-framework/scenarios/ai/strategy#adopt-microsoft-software-ai-services-saas-for-initial-outcomes) to find the setup guidance you need.

- **Microsoft Copilot Studio setup.** Set up a dedicated environment in the platform for development and testing. Coordinate with IT admins to get an isolated space where only the project team has edit rights. Configure **permissions**: decide who can create or modify the agent in Copilot Studio. Connect permitted data sources through provided connectors or APIs. You may need to create service accounts or app registrations to allow Copilot Studio to fetch enterprise data. Also set up authentication: if your agent will be used by employees, integrate it with your identity system (Microsoft Entra ID) so it knows who the user is and can enforce access control. Getting the environment right at the start will prevent frustrating blockers when you try to test the agent. For more information, see [Work with Power Platform environments.](/azure/microsoft-copilot-studio/environments-first-run-experience) and [Get access to Copilot Studio.](/azure/microsoft-copilot-studio/requirements-licensing-subscriptions).

- **Azure AI Foundry setup:** Start with an Azure landing zone as your foundation. Then use the Application landing zone accelerator for Azure AI Foundry. See also [AI-ready guidance](AI%20Adoption%20–%20Ready%20your%20Azure%20environment) of CAF to establish an application landing zone for AI.
