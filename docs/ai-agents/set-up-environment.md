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

## Microsoft facilitation

This section provides actionable resources to help technical decision makers set up development and runtime environments for AI agents using Microsoft Copilot Studio and Azure AI Foundry. The links below correspond to the guidance in the article and enable direct implementation of the recommendations.

### Azure AI Foundry

Azure AI Foundry provides a comprehensive platform for building custom AI agents with enterprise-grade security and scalability. The following resources guide you through project creation, environment configuration, and landing zone integration.

#### Set up AI agent environments (Azure AI Foundry setup)

- [Create a hub-based project in Azure AI Foundry portal](/azure/ai-foundry/how-to/hub-create-projects) to establish your development environment with the necessary hub and project resources.
- [Deploy the baseline Azure AI Foundry chat architecture within an application landing zone](/azure/architecture/ai-ml/architecture/baseline-azure-ai-foundry-landing-zone) to integrate your AI workload with centralized shared resources while adhering to governance and cost efficiency.

#### Establish an AI foundation (Azure landing zone setup)

- [Establish an AI foundation using Azure landing zones](/azure/cloud-adoption-framework/scenarios/ai/ready#establish-an-ai-foundation) to prepare your Azure environment with a predefined setup for platform and application resources.

### Microsoft Copilot Studio

Microsoft Copilot Studio enables low-code AI agent development with built-in compliance and enterprise data integration. The resources below help you configure environments, permissions, and authentication for production deployments.

#### Set up AI agent environments (Microsoft Copilot Studio setup)

- [Work with Power Platform environments in Copilot Studio](/microsoft-copilot-studio/environments-first-run-experience) to create dedicated development and testing environments with isolated access controls.
- [Get access to Copilot Studio through licensing and subscriptions](/microsoft-copilot-studio/requirements-licensing-subscriptions) to understand the licensing requirements and obtain the necessary subscriptions for your team.

#### Set up AI agent environments (Authentication and permissions)

- [Configure user authentication with Microsoft Entra ID in Copilot Studio](/microsoft-copilot-studio/configuration-authentication-azure-ad) to integrate your identity system and enforce access control for enterprise users.
