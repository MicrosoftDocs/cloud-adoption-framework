## Cloud Adoption Framework governance policies 
---
title: "[Descriptive title that clearly states the customer outcome]"
description: "[Brief description explaining what the customer will achieve after following this guidance]"
author: stephen-sumner # Requried add your Github username
ms.author: ssumner # Required: Add your Microsoft alias
ms.date: 06/01/2025 # Required: Use the date you submit the article
ms.topic: conceptual
---

# [Article title - same as title in metadata]

This article explains how to [*specific customer outcome*]. [Why this guidance is important (1-2 sentences)].

<!-- optional image that helps visualize the rest of the guidance
:::image type="content" source="./media/[image-filename].svg" alt-text="Diagram showing [description of diagram]." lightbox="./media/[image-filename].svg" border="false":::
-->

## [Prescriptive recommendation (logically first) (starts with a verb)]

[*INSTRUCTIONS: *Define what this section is about (1 sentence). Explain why this section is important to the topic of this article, if it's not obvious (1 sentence). Define the end state or what the customer needs to do*]. For guidance, follow these steps:

1. **[Prescriptive recommendation 1 (starts with action verb)].** [*INSTRUCTIONS: Every recommendation must: Define why this recommendation is important in the context of this section (1 sentence). Explain how to implement/carry out this recommendation. If available indicate how Azure or other tools, services, features facilitate the implementation. Rely heavily on links to product docs to describe these tools, services, and features (1-3 sentences).*].

1. **[Prescriptive recommendation 2 (starts with action verb)].** [*INSTRUCTIONS: Every recommendation must: Define why this recommendation is important in the context of this section (1 sentence). Explain how to implement/carry out this recommendation. If available indicate how Azure or other tools, services, features facilitate the implementation. Rely heavily on links to product docs to describe these tools, services, and features (1-3 sentences).*].

1. ... <!-- add as many sequential recommendations as needed -->

## [Prescriptive recommendation (logically second) (starts with a verb)]

[*INSTRUCTIONS: *Define what this section is about (1 sentence). Explain why this section is important to the topic of this article, if it's not obvious (1 sentence). Define the end state or what the customer needs to do*]. For guidance, follow these steps:

1. **[Prescriptive recommendation 1 (starts with action verb)].** [*INSTRUCTIONS: Every recommendation must: Define why this recommendation is important in the context of this section (1 sentence). Explain how to implement/carry out this recommendation. If available indicate how Azure or other tools, services, features facilitate the implementation. Rely heavily on links to product docs to describe these tools, services, and features (1-3 sentences).*].

1. **[Prescriptive recommendation 2 (starts with action verb)].** [*INSTRUCTIONS: Every recommendation must: Define why this recommendation is important in the context of this section (1 sentence). Explain how to implement/carry out this recommendation. If available indicate how Azure or other tools, services, features facilitate the implementation. Rely heavily on links to product docs to describe these tools, services, and features (1-3 sentences).*].

1. <!-- add as many sequential recommendations as needed -->

... 

## <!-- add as many headers as needed

### Add as many subheaders (###, ####) as needed -->

... 


## [Tools and resources section]
<!-- optional section -->

| Category | Tool | Description |
|----------|------|-------------|
| [Tool category 1] | [Tool name with link] | [Brief description of how it supports the recommendations] |
| [Tool category 2] | [Tool name with link] | [Brief description of implementation support] |

## Next steps

<!-- next step button 
> [!div class="nextstepaction"]
> [Next article](./next-article.md)
--->

## Template guidance for authors

### Content structure requirements

**Article flow must be sequential and logical:**
- Start with foundational concepts customers need first
- Progress through intermediate steps that build on each other  
- End with advanced guidance for mature implementations
- Each section should clearly connect to the next step in the customer journey

**Recommendation format (MUST follow this pattern):**
- **[Clear, actionable recommendation].** [*Every recommendation must: Define why this recommendation is important in the context of this section (1 sentence). Explain how to implement/carry out this recommendation. If available indicate how Azure or other tools, services, features facilitate the implementation. Rely heavily on links to product docs to describe these tools, services, and features (1-3 sentences).*].

### Content quality checklist

Before submitting your content, verify:

- [ ] **Proven guidance**: All recommendations based on successful customer engagements
- [ ] **Recommendation-driven**: Every point follows the [Recommendation] + [Why] + [How] format
- [ ] **Sequential**: Content follows logical customer journey progression  
- [ ] **Prescriptive**: Provides clear "do this" guidance, not "consider this"
- [ ] **Actionable**: Each recommendation includes specific implementation steps
- [ ] **Required**: All content directly supports customer success outcomes
- [ ] **Unique**: Content doesn't duplicate existing product documentation
- [ ] **Clear**: Language is unambiguous and easy to understand
- [ ] **Concise**: Content is brief and focused on essential guidance

### Writing standards

**Use action-oriented language:**
- Start sections with action verbs (Implement, Configure, Deploy, Monitor)
- Prefer the imperative mood ("Configure the policy" not "You should configure")
- Include specific tools and methods in recommendations, relying on links for product truth.

**Structure for clarity:**
- Use numbered steps for sequential processes
- Use bullet points for related but nonsequential items
- As needed, include tables for decision matrices and comparison guidance
- Add diagrams to illustrate complex processes or architectures

**Link strategy:**
- Link to authoritative Azure documentation for technical details
- Link to other CAF articles for related guidance in the customer journey
- Avoid excessive external links that require frequent validation

### Examples: Common pitfalls to avoid

**Don't write considerations or descriptive content:**
- ❌ "Consider implementing monitoring for your resources"
- ✅ "**Implement Azure Monitor alerts for all critical resources.** Alerts ensure rapid response to issues that impact business operations. Configure alerts for CPU utilization, memory usage, and application-specific metrics using Azure Monitor alert rules."

**Don't provide unordered lists of options:**
- ❌ "You can use Azure Policy, ARM templates, or Bicep for governance"
- ✅ "**Use Azure Policy to enforce governance standards.** Azure Policy prevents configuration drift and ensures compliance. Start with built-in policy definitions for common requirements like allowed locations and required tags."

**Don't create content without clear business value:**
- ❌ "Azure offers many different storage options"
- ✅ "**Select storage tiers based on access patterns.** Storage tiers optimize costs while meeting performance requirements. Use hot tier for frequently accessed data and cool tier for infrequently accessed data with lower cost requirements."
