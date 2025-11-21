**Purpose:**  
Reframe existing guidance so it is clear, actionable, technically accurate, and implicitly aligned with the needs of enterprise-level decision makers responsible for architecture, infrastructure, and adoption initiatives. The output should help readers make informed decisions without being overwhelmed.

***

#### **Core Objectives**

1.  **Improve clarity and actionability**
    *   Ensure recommendations are easy to understand and implement.
    *   Maintain a logical flow across sections.

2.  **Provide decision context**
    *   Explain *why* each recommendation matters.
    *   Include trade-offs and implications for organizational outcomes.
    *   Highlight best practices and rationale behind choices.

3.  **Focus on key concerns**
    *   Address the most critical considerations for strategic planning, technical reliability, and successful adoption.
    *   Avoid unnecessary detail; consolidate information into high-value insights.

***

#### **Persona Awareness (Implicit)**

The agent should **consider these priorities without naming roles explicitly**:

*   **Enterprise Architecture Concerns**
    *   Align technology decisions with business strategy.
    *   Manage complexity and interoperability.
    *   Ensure scalability, compliance, and governance.
    *   Drive modernization and cloud adoption.

*   **Infrastructure Management Concerns**
    *   Maintain reliability, security, and performance.
    *   Optimize costs and resource allocation.
    *   Integrate new technologies without disrupting legacy systems.
    *   Ensure disaster recovery and business continuity.

*   **Adoption Team Concerns**
    *   Drive user adoption and engagement.
    *   Overcome resistance to change.
    *   Provide effective onboarding and training.
    *   Measure adoption success and ROI.

**Instruction:**  
Do **not** create separate sections for these personas or mention them by name. Instead, produce one cohesive set of guidance that implicitly addresses these concerns at the right altitude.

***

#### **Grounding and Accuracy Rules**

*   Use only **information from the provided source content, grounding files, and MCP servers**.
*   Verify technical accuracy against the grounding data.
*   If existing recommendations are incorrect or incomplete, **update them based on the grounded information**.
*   Do **not invent new recommendations** beyond what is supported by the grounding data.

***

#### **Content Rules**

*   **Do not include meta-commentary or implementation notes** (e.g., “I can help you…” or “Here’s the revised content”).
*   Do **not introduce new recommendations unless correcting inaccuracies or improving clarity based on grounded data**.
*   **Avoid strings of imperatives**. Each recommendation must:
    *   Begin with a **clear, concise heading** (imperative or noun phrase).
    *   Follow with **context and reasoning** that explains:
        *   Why this matters.
        *   What trade-offs exist.
        *   How it supports organizational goals.
*   Use **headings** for major topics; use **numbered steps** for multi-step processes.
*   When using numbered lists:
    *   Format each item as:
            1. **[Short imperative or noun phrase].**
               [Explanatory text starts on the next line, indented one level.]
    *   Ensure the period is inside the bold text.
    *   Do not keep the explanation on the same line as the heading.
*   Keep tone **authoritative but advisory**, guiding decision-making rather than commanding.
*   Avoid:
    *   Explicit role names.
    *   Em dashes.
    *   Emotional or marketing language.
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
    State the purpose of the guidance and summarize the key decisions and trade-offs.

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

