---
title: Responsible and trusted AI
description: Understand the six guiding Microsoft principles for responsible AI, which include accountability, inclusiveness, reliability and safety, fairness, transparency, and privacy and security.
author: msteller-Ai
ms.author: martinek
ms.date: 01/20/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: innovate
ms.custom: think-tank
---

# Responsible and trusted AI

Microsoft outlines six key principles for responsible AI: accountability, inclusiveness, reliability and safety, fairness, transparency, and privacy and security. These principles are essential to creating responsible and trustworthy AI as it moves into mainstream products and services. They're guided by two perspectives: ethical and explainable.

![A diagram of responsible AI principles.](./media/responsible-ai-principles.png)

## Ethical

From an ethical perspective, AI should:

- Be fair and inclusive in its assertions.
- Be accountable for its decisions.
- Not discriminate or hinder different races, disabilities, or backgrounds.

In 2017, Microsoft established an advisory committee for AI, ethics, and effects in engineering and research ([Aether](https://www.microsoft.com/ai/our-approach?activetab=pivot1%3aprimaryr5)). The core responsibility of the committee is to advise on issues, technologies, processes, and best practices for responsible AI. To learn more, see [Understanding the Microsoft governance model - Aether + Office of Responsible AI](/training/modules/microsoft-responsible-ai-practices/3-microsoft-governance-model).

### Accountability

Accountability is an essential pillar of responsible AI. The people who design and deploy an AI system need to be accountable for its actions and decisions, especially as we progress toward more autonomous systems.

Organizations should consider establishing an internal review body that provides oversight, insights, and guidance about developing and deploying AI systems. This guidance might vary depending on the company and region, and it should reflect an organization's AI journey.

### Inclusiveness

Inclusiveness mandates that AI should consider all human races and experiences. Inclusive design practices can help developers understand and address potential barriers that could unintentionally exclude people. Where possible, organizations should use speech-to-text, text-to-speech, and visual recognition technology to empower people who have hearing, visual, and other impairments.

### Reliability and safety

For AI systems to be trusted, they need to be reliable and safe. It's important for a system to perform as it was originally designed and for it to respond safely to new situations. Its inherent resilience should resist intended or unintended manipulation.

An organization should establish rigorous testing and validation for operating conditions to ensure that the system responds safely to edge cases. It should integrate A/B testing and champion/challenger methods into the evaluation process.

An AI system's performance can degrade over time. An organization needs to establish a robust monitoring and model-tracking process to reactively and proactively measure the model's performance (and retrain it for modernization, as necessary).

## Explainability

Explainability helps data scientists, auditors, and business decision makers ensure that AI systems can justify their decisions and how they reach their conclusions. Explainability also helps ensure compliance with company policies, industry standards, and government regulations.

A data scientist should be able to explain to a stakeholder how they achieved certain levels of accuracy and what influenced the outcome. Likewise, to comply with the company's policies, an auditor needs a tool that validates the model. A business decision maker needs to gain trust by providing a transparent model.

### Explainability tools

Microsoft has developed [InterpretML](https://interpret.ml/), an open-source toolkit that helps an organization achieve model explainability. It supports glass-box and black-box models:

- Glass-box models are interpretable because of their structure. For these models, Explainable Boosting Machine (EBM) provides the state of the algorithm based on a decision tree or linear models. EBM provides lossless explanations and is editable by domain experts.

- Black-box models are more challenging to interpret because of a complex internal structure, the neural network. Explainers like local interpretable model-agnostic explanations (LIME) or SHapley Additive exPlanations (SHAP) interpret these models by analyzing the relationship between the input and output.

[Fairlearn](https://fairlearn.org/) is an Azure Machine Learning integration and an open-source toolkit for the SDK and the AutoML graphical user interface. It uses explainers to understand what mainly influences the model, and it uses and domain experts to validate these influences.

To learn more about explainability, explore [model interpretability in Azure Machine Learning](/azure/machine-learning/how-to-machine-learning-interpretability).

### Fairness

Fairness is a core ethical principle that all humans aim to understand and apply. This principle is even more important when AI systems are being developed. Key checks and balances need to make sure that the system's decisions don't discriminate or express a bias against a group or individual based on gender, race, sexual orientation, or religion.

Microsoft provides an [AI fairness checklist](https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RE4t6dA) that offers guidance and solutions for AI systems. These solutions are loosely categorized into five stages: envision, prototype, build, launch, and evolve. Each stage lists recommended due-diligence activities that help minimize the impact of unfairness in the system.

Fairlearn integrates with Azure Machine Learning and supports data scientists and developers to assess and improve the fairness of their AI systems. It provides unfairness-mitigation algorithms and an interactive dashboard that visualizes the fairness of the model. An organization should use the toolkit and closely assess the fairness of the model while it's being built. This should be an integral part of the data science process.

Learn how to [mitigate unfairness in machine learning models](/azure/machine-learning/concept-fairness-ml).

### Transparency

Achieving transparency helps the team understand:

- The data and algorithms that were used to train the model.
- The transformation logic that was applied to the data.
- The final model that was generated.
- The model's associated assets.

This information offers insights about how the model was created, so the team can reproduce it in a transparent way. Snapshots within [Azure Machine Learning workspaces](/azure/machine-learning/concept-workspace) support transparency by recording or retraining all training-related assets and metrics involved in the experiment.

### Privacy and security

A data holder is obligated to protect the data in an AI system. Privacy and security are an integral part of this system.

Personal data needs to be secured, and access to it shouldn't compromise an individual's privacy. [Azure differential privacy](/azure/machine-learning/concept-differential-privacy) helps protect and preserve privacy by randomizing data and adding noise to conceal personal information from data scientists.

## Human AI guidelines

Human AI design guidelines consist of 18 principles that occur over four periods: initially, during interaction, when wrong, and over time. These principles help an organization produce a more inclusive and human-centric AI system.

### Initially

- **Clarify what the system can do**. If the AI system uses or generates metrics, it's important to show them all and how they're tracked.

- **Clarify how well the system can do what it does**. Help users understand that AI won't be completely accurate. Set expectations for when the AI system might make mistakes.

### During interaction

- **Show contextually relevant information**. Provide visual information related to the user's current context and environment, such as nearby hotels. Return details close to the target destination and date.

- **Mitigate social biases**. Make sure that the language and behavior don't introduce unintended stereotypes or biases. For example, an autocomplete feature needs to be inclusive of gender identity.

### When wrong

- **Support efficient dismissal**. Provide an easy mechanism to ignore or dismiss undesirable features or services.
- **Support efficient correction**. Provide an intuitive way of making it easier to edit, refine, or recover.
- **Make clear why the system did what it did**. Optimize explainable AI to offer insights about the AI system's assertions.

### Over time

- **Remember recent interactions**. Retain a history of interactions for future reference.
- **Learn from user behavior**. Personalize the interaction based on the user's behavior.
- **Update and adapt cautiously**. Limit disruptive changes, and update based on the user's profile.
- **Encourage granular feedback**. Gather user feedback from their interactions with the AI system.

## Trusted AI framework

![A diagram of a persona-centric, trusted AI framework.](./media/ai-framework.png)

### AI designer

The AI designer builds the model and is responsible for:

- Data drift and quality checks. The designer detects outliers and performs data quality checks to identify missing values, standardizes distribution, scrutinizes data, and produces use case and project reports.

- Assessing data in the system's source to identify potential bias.

- Designing AI algorithms to minimize data biases. These efforts include discovering how binning, grouping, and normalization (especially in traditional machine learning models like tree-based ones) can eliminate minority groups from data. Categorical AI design reiterates data biases by grouping social, racial, and gender classes in industry verticals that rely on protected health information (PHI) and personal data.

- Optimizing monitoring and alerts to identify target leakage and strengthen the model's development.

- Establishing best practices for reporting and insights that offer a granular understanding of the model. The designer avoids black-box approaches that use feature or vector importance, Uniform Manifold Approximation and Projection (UMAP) clustering, Friedman's H-statistic, feature effects, and related techniques. Identification metrics help to define predictive influence, relationships, and dependencies between correlations in complex and modern datasets.

### AI administrator and officers

The AI administrator and officers oversee AI, governance, and audit framework operations and performance metrics. They also oversee how AI security is implemented and the business's return on investment. Their tasks include:

- Monitoring a tracking dashboard that assists model monitoring and combines model metrics for production models. The dashboard focuses on accuracy, model degradation, data drift, deviation, and changes in speed/error of inference.

- Implementing flexible deployment and redeployment (preferably, REST API) that allows models to be implemented into open, agnostic architecture. The architecture integrates the model with business processes and generates value for feedback loops.

- Working toward building model governance and access to set boundaries and mitigate negative business and operational impact. Role-based access control (RBAC) standards determine security controls, which preserve restricted production environments and the IP.

- Using AI audit and compliance frameworks to track how models develop and change to uphold industry-specific standards. Interpretable and responsible AI is founded on explainability measures, concise features, model visualizations, and industry-vertical language.

### AI business consumers

AI business consumers (business experts) close the feedback loop and provide input for the AI designer. Predictive decision-making and potential bias implications like fairness and ethical measures, privacy and compliance, and business efficiency help to evaluate AI systems. Here are some considerations for business consumers:

- Feedback loops belong to a business's ecosystem. Data that shows a model's bias, errors, prediction speed, and fairness establishes trust and balance between the AI designer, administrator, and officers. Human-centric assessment should gradually improve AI over time.

  Minimizing AI learning from multidimensional, complex data can help prevent biased learning. This technique is called less-than-one-shot (LO-shot) learning.

- Using interpretability design and tools holds AI systems accountable for potential biases. Model bias and fairness issues should be flagged and fed to an alerting and anomaly detection system that learns from this behavior and automatically addresses biases.

- Each predictive value should be broken down into individual features or vectors by importance or impact. It should deliver thorough prediction explanations that can be exported into a business report for audit and compliance reviews, customer transparency, and business readiness.

- Due to increasing global security and privacy risks, best practices for resolving data violations during inference require complying with regulations in individual industry verticals. Examples include alerts about noncompliance with PHI and personal data, or alerts about violation of national/regional security laws.

## Next steps

Explore [human AI guidelines](/ai/guidelines-human-ai-interaction/) to learn more about responsible AI.
