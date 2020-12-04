---
title: Trusted AI
description: Microsoft provides six guiding principles for responsible AI-fairness, reliability and safety, inclusivity, fairness, transparency, and privacy and security.
author: BrianBlanchard
ms.author: brblanch
ms.date: 12/07/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: innovate
---

# Trusted AI

Microsoft provides six guiding principles for responsible AI-fairness, reliability and safety, inclusivity, fairness, transparency, and privacy and security. These principles are essential to creating responsible and trustworthy AI as it moves into more mainstream products and services.

These principles can be viewed from two perspectives: ethical and explainable.

![A diagram of trusted AI.](media/trusted-ai.png)

## Ethical

From an ethical perspective, AI should be fair and inclusive in its assertions, be accountable for its decisions, and not discriminate or hinder different races, disabilities, or backgrounds.

Microsoft established an ethical AI committee, AI, Ethics, and Effects in Engineering and Research [AEHTER](https://www.microsoft.com/ai/our-approach?activetab=pivot1%3aprimaryr5), in 2017. The core responsibility of the committee is to advise on responsible issues, technologies, processes, and best practices. Learn more about AEHTER [at this Microsoft Learn module](/learn/modules/microsoft-responsible-ai-practices/3-microsoft-governance-model).  

### Accountability

Accountability is an essential pillar of responsible AI. The people who design and deploy the AI system need to be accountable for its actions and decisions, especially as we progress toward more autonomous systems. Organizations should consider establishing an internal review body that provides oversight, insights, and guidance about developing and deploying AI systems. While this guidance might vary depending on the company and region, it should reflect an organization's AI journey.  

### Inclusivity

Inclusivity mandates that AI should consider all human races and experiences, and inclusive design practices can help developers to understand and address potential barriers that might unintentionally exclude people. Where possible, speech-to-text, text-to-speech, and visual recognition technology should be used to empower people with hearing, visual, and other impairments.

### Reliability and safety

AI systems need to be reliable and safe in order to be trusted.  It is important for a system to perform as it was originally designed and for it to respond safely to new situations. Its inherent resilience should resists intended or unintended manipulation. Rigorous testing and validation should be established for operating conditions to ensure that the system responds safely to edge cases, and A/B testing and champion/challenger methods should be integrated into the evaluation process.

An AI system’s performance can degrade over time, so a robust monitoring and model tracking process needs to be established to reactively and proactively measure the model's performance and retrain it, as necessary, to modernize it.

## What is explainable

Explainability helps data scientists, auditors, and business decision makers to ensure that AI systems can reasonably justify their decisions and how they reach their conclusions. This also ensures compliance with company policies, industry standards, and government regulations. A data scientist should be able to explain to the stakeholder how they achieved a certain level of accuracy and what has influenced or attributed to this outcome. Likewise, an auditor needs a tool to validate the model in order to comply with the company’s policies, and a business decision maker needs to be able to provide a transparent model in order to gain trust.

### Explainability tools

To achieve the model explainability, Microsoft has developed [InpretML](http://interpret.ml/), an open-source toolkit that supports glass-box and black-box models.

- Glass-box models are interpretable because of their structure. For these types of models, it's recommended to use Explainable Boosting Machine, which is the state of the algorithm based on a decision tree or linear models, provides lossless explanations, and are editable by domain experts.

- Black-box models are more challenging to interpret because of a complex internal structure, the neural network. For these types models, the explainer analyzes the relationship between the input and output to interpret the model. Typical explainers like LIME or SHapley Additive exPlanation are used for these types of models.

- [FairLearn](https://fairlearn.github.io/) is an Azure Machine Learning integration and an open-source toolkit for the SDK and the AutoML GUI.  It is recommended that explainers are used to understand the key influencer of the model, and domain experts are used to validate these influencers.

More information is available at [model interpretability in Azure Machine Learning](/azure/machine-learning/how-to-machine-learning-interpretability)

### Fairness​

Fairness is a core ethical principle that all humans aim to understand and apply. This principle is even more important when AI systems are being developed, as key checks and balances need to make sure that the system's decisions don't discriminate or run a bias toward a group or individual that's based on gender, race, sexual orientation, or religion.

- Microsoft provides an [AI fairness checklist](https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RE4t6dA) that offers guidance and solutions for AI systems. These solutions are loosely categorized into five stages: Envision, Prototype, Build, Launch, and Evolve. Each category lists recommended activities for due diligence to minimize the impact of unfairness in the system.

- FairLean integrates with Azure Machine Learning and supports data scientists and developers to assess and improve the fairness of their AI systems. The toolbox provides various unfairness mitigation algorithms and an interactive dashboard for visualizing the fairness of the model. It is recommended to use the toolkit and closely assess the fairness of the model while it's being built; this should be an integral part of the DS process.

Explore [Mitigate fairness in machine learning models](/azure/machine-learning/concept-fairness-ml) to learn more about fairness for AI.

### Transparency

Achieving transparency helps the team to understand which data and algorithms were used to train the model, what transformation logic has been applied to the data, the final model generated, and its associated assets. This information offers insights about how the model was created, which allows it to be reproduced in a transparent way. **Shapshots** within [Azure Machine Learning workspaces](/azure/machine-learning/concept-workspace) support transparency by recording or retraining all training related assets and metrics involved in the experiment.  

### Privacy and security

A data holder is obligated to protected the data in an AI system, and privacy and security are an integral part of this system. Personal data doesn't just need to be secured, but it should also be accessed in a way that doesn't compromise an individual's privacy. [Azure differential privacy](/azure/machine-learning/concept-differential-privacy) protects protects and preserves privacy by adding randomness/noise to the data so that the data scientist can't identify individual information.

## Human AI guidelines​

Human AI design guidelines consist of 18 principles that occur over four periods: initially, during interaction, when wrong, and over time. These principles are designed to produce a more inclusive and human-centric AI system. The following diagram lists these principles. **Need updated image; only shows the periods.**

![A diagram of human AI design guidelines​. ](media/human-ai-guidelines.png)

### Initially

- **Clarify what the system can do.** If the AI system uses or generates metrics, it's important to show them all and how they're tracked.

- **Clarify how well the system can do what it can do.** Help users to understand that AI will not be 100-percent accurate, and set expectations for when the AI system might make mistakes.

### During interaction

- **Show contextually relevant information.** Provide visual information related to the user’s current context and environment, such as nearby hotels and return details close to the target destination and date.

- **Mitigate social biases.** Make sure that the language and behavior don't introduce unintended stereotypes or biases. For example, an auto-complete feature needs to acknowledge both genders.

### When wrong

- **Support efficient dismissal.** Provide an easy mechanism to ignore or dismiss undesirable features/services.
- **Support efficient correction.** Provide an intuitive way of making it easier way to edit, refine, or recover.
- **Make clear why the system did what it did.** Enable explainable AI to offer insights about the AI system's assertions.

### Over time

- **Remember recent interactions.** Retain a history of interactions for future reference.
- **Learn from user behavior.** Personalize the interaction based on the user’s behavior.
- **Update and adapt cautiously.** Limit disruptive changes, and update based on the user’s profile.
- **Encourage granular feedback.** Facilitate user feedback based on their usual interactions with the AI system.

Explore hHuman AI Guidelines](/ai/guidelines-human-ai-interaction.md) to learn more.

## A persona–centric, trusted AI framework

![A diagram of a persona–centric, trusted AI framework](media/AI-framework.png)

### AI designer

The AI designer builds the model and is responsible for:

- Data drift and quality checks. They enable outlier detection and perform data quality checks to identify missing values, standardize distribution, scrutinize data, and produce use case and project reports.

- Assessing data in the system's source to identify potential bias.

- Designing AI algorithms to minimize data biases, such as finding the elimination of minority groups within data due to binning, grouping, and normalization (especially in traditional machine learning models like tree-based ones). Categorical AI design reiterates bias implications by exposing social, racial, and gender classes in industry verticals that rely on protected health information and personally identifiable information.

- Monitoring and alerts about target leakage to strengthen the model's development.

- Establishing best practices for model reporting and insights that offer a granular understanding of the model, and avoiding black-box approaches that use feature or vector importance, UMAP clustering, Friedman's H-statistic, feature effects, and others. Correlations to the target within complex and modern datasets require identification metrics that define predictive influence, relationship and dependencies for their features.

## AI administrators and officers

The AI administrator and officer oversees AI, governance, and audit framework operations and performance metrics, plus how AI security is implemented and the business' return on investment.

- A tracking dashboard assists model monitoring, combines model metrics for production models, and focuses on accuracy, model degradation, data drift, deviation, and changes in speed/error of inference.

- Flexible deployment and redeployment (preferably, REST API) allows models to be implemented into open, agnostic architecture, which integrates the model with business processes and generates value for feedback loops.

- Model governance and access sets boundaries and mitigates negative business and operational impact. Security implications based on role-based access control standards preserve restricted production environments and IP.

- AI audit frameworks and compliance track how models develop, change, and changes to uphold industry-specific standards. The foundation of interpretable and trusted AI is based on explainability measures, concise features, model visualizations, and vertical-specific industry language.

## AI business consumer

AI business consumers (business experts) close the feedback loop and provide input for the AI designer. AI systems are evaluated by predictive decision-making and potential bias implications, including fairness and ethical measures, privacy and compliance, and business efficiency:

- Feedback loops belong to a business' ecosystem. Data showing a model's bias, errors, prediction speed, and fairness establish trust and balance between the AI designer and AI administrators and officers. Human-centric assessment should gradually improve AI over time, and minimizing AI learning from multi-dimensional and complex data (L0-shot learning) can help to prevent biased learning.

- Using interpretability design and tools hold AI systems accountable for potential biases. Model bias and fairness issues should be flagged feeding into an alerting and anomaly detection system learning from unsatisfying model behavior ensuring addressing such issues downstream automatically.

- Each predictive value should be able to be broken down into individual feature or vector importance/impact delivering full explanations of predictions ready to be exported into a business report for audit and compliance reviews, customer transparency, and business readiness.

- Due to increasing global security and privacy risks, best practices for resolving data violations when running inference require complying with regulations in individual industry verticals; for example, alerting about non-compliance PHI/PII usage, violation of national security laws, and more.