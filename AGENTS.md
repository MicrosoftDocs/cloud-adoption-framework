**Purpose:**  
Ensure the guidance is practical for enterprise architects. Rather than providing guidance that covers everything concisely, focus on the major decision points and provide enough context so that they are successful with those understand what they need to do. The output should help readers make informed decisions. Focus on the most important guidance so that the guidance there is well understood and explained but the overall length of the article is still actionable.

*   **Business and Strategy Guidance (Implicitly targets CTOs and C-suite)**
    *   Align technology decisions with business strategy and competitive advantage.
    *   Manage organizational change, financial impact (ROI), and high-level risk.
    *   Drive innovation velocity and market responsiveness.
*   **Planning, Governance, Security, and Operations Guidance (Implicitly targets Enterprise Architects)**
    *   Manage complexity, interoperability, and standardization across the cloud estate.
    *   Ensure scalability, compliance, and security governance.
    *   Drive modernization and consistent cloud adoption patterns.
    *   Architecture cohesion: How all workloads fit together.

#### **Core Objectives**

1.  **Improve clarity and actionability**
    *   Ensure recommendations are easy to understand and implement.
    *   Maintain a logical flow across sections.

2.  **Provide decision context**
    *   Explain *why* each recommendation matters.
    *   Include trade-offs and implications for organizational outcomes.
    *   Highlight best practices and rationale behind choices.

3.  **Focus on key concerns**
    *   Address the most critical considerations for the specific audience implied by the topic.
    *   Avoid unnecessary detail; consolidate information into high-value insights.

#### **Persona Awareness (Implicit)**

The agent should **address priorities without naming roles explicitly**. Adjust the altitude of the guidance based on the subject matter:

1.  **For Business and Strategy topics:** Speak to ROI, value, risk, and strategic busiess alignment (C-suite concerns).
2.  **For Governance, Security, and Estate Planning:** Speak to standards, cohesion, and policy (Enterprise Architect concerns).

**Instruction:**  
Do **not** create separate sections for persona or mention them by name. Instead, produce one cohesive set of guidance that implicitly addresses these concerns at the right altitude for the topic being discussed.

***

#### **Grounding and Accuracy Rules**

*   Verify technical accuracy against the grounding data.

#### **Content Rules**

*   **Do not include meta-commentary or implementation notes** (e.g., “I can help you…” or “Here’s the revised content”).
*   Do **not introduce new recommendations unless correcting inaccuracies or improving clarity based on grounded data**.
*   **Avoid strings of imperatives**. Each recommendation must:
    *   Begin with a **clear, concise heading** (imperative or noun phrase).
    *   Follow with **context and reasoning** that explains:
        *   Why this matters.
        *   What trade-offs exist.
        *   How it supports organizational goals.
*   Use **headings** for major topics. Use **numbered steps** for multi-step processes.
*   When using numbered lists:
    *   Format each item as:
            1. **[Short imperative or noun phrase].** [Explanatory text starts on the same line.]
    *   Ensure the period is inside the bold text.
    *   Do not keep the explanation on the same line as the heading.
*   Keep tone **authoritative but advisory**, guiding decision-making rather than commanding.
*   Avoid:
    *   Explicit role names.
    *   Em dashes.
    *   Emotional or marketing language.
    *   Using ;
*   Replace:
    *   Gerunds with active verbs.
    *   Future tense with present tense.
    *   Passive voice with active voice.
    *   “May” with direct, actionable phrasing.
    *   “Leverage” with “use.”
*   Add:
    *   Clear noun referents after demonstrative pronouns.
*   Ensure:
    *   Sentence case for all headers.
    *   Simple sentence structures.
    *   Images support and align with guidance.
    *   Narrative flow is smooth and connected.

***

#### **Template**

    # [Descriptive Noun Phrase Title]

    ## Introduction
    "This article ..." then summarize what the reader will learn. State why this is important to the key persona(s).

    ## [Section Heading]
    Explain the decision point, available options, trade-offs, and best practices. Provide concise, actionable recommendations with supporting rationale.

    ## [Additional Sections as Needed]
    Follow the same structure for each major topic.

***

### ✅ **Key Principles for Output**

*   Recommendations should **always include reasoning and trade-offs**, not just imperatives.
*   Keep explanations **focused on top concerns** for the topic.
*   Provide enough context for informed decisions without overwhelming detail.
*   Output should look like **final published guidance**, not instructions or commentary.