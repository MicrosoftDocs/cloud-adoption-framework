# Copilot instructions for the Cloud Adoption Framework for Azure
This template enables Copilot agents to **create, review, and refine guidance** aligned with Microsoft’s **Cloud Adoption Framework (CAF)**.

CAF offers a **self-service roadmap** to help organizations of all sizes **start, succeed, and mature in Azure**.

CAF guidance should:
- Help customers **navigate the cloud adoption lifecycle** and understand **what to do next**.
- Provide **actionable recommendations** for organizing teams, building skills, and managing processes across the **entire cloud estate**.
- Act as a **resource hub**, linking to deeper technical content:
  - https://learn.microsoft.com/azure/well-architected/ – for workload design principles: reliability, security, performance efficiency, operational excellence, and cost optimization.
  - https://learn.microsoft.com/azure/architecture/ – for architecture implementation guidance and use-case scenarios with Azure.
  - https://learn.microsoft.com/ – for product-specific features, tools, and step-by-step instructions.

- Headers and inline topic sentence recommendations in the numbered lists should only state the action and not the means (or how) to keep them short.

---

## **Scope of Changes**
- **Do not add** new recommendations.
- **Do not remove** existing recommendations.
- Focus on improving:
  - **Clarity**
  - **Consistency**
  - **Actionable value** for **technical leadership** and **cloud solution architects**.

-- 
## **Tone and Style**
- Use **clear, professional, and customer-focused language**.
- Assume the audience includes **business and technical decision-makers**.
- Keep guidance **practical, scenario-driven, and roadmap-oriented**.

## Customer needs

- ✅ **What to preserve**: Elements users consistently value and trust.
- ⚠️ **What to improve**: Areas where users request more clarity, support, or prescriptive guidance.

### **Usability**
✅ **What to preserve:**
- Step-by-step structure makes adoption manageable.
- Covers both technical and organizational aspects.

⚠️ **What to improve:**
- Initial learning curve is steep.
- Requires cross-team coordination, which can feel daunting.

### **Clarity**
✅ **What to preserve:**
- Clear phases (Strategy, Plan, Ready, Adopt, Govern, Manage) provide intuitive structure.
- Expert-authored guidance feels trustworthy.

⚠️ **What to improve:**
- Not prescriptive enough in some areas.
- Leaves many decisions to the user, causing uncertainty.

### **Completeness**
✅ **What to preserve:**
- Broad coverage of cloud adoption themes.
- Regular updates include new topics (AI, DevOps, etc.).

⚠️ **What to improve:**
- Earlier gaps (e.g., hybrid/data governance).
- Needs WAF for workload-level optimization.

### **Relevance**
✅ **What to preserve:**
- Built on real-world lessons from Microsoft and customers.
- Frequently updated to stay current.

⚠️ **What to improve:**
- Needs more tailored guidance for SMBs and niche industries.
- Multi-cloud clarity requested.

### **Implementation Support**
✅ **What to preserve:**
- Includes tools, templates, and reference implementations.
- Microsoft and partner support is valued.

⚠️ **What to improve:**
- Organizational change is challenging.
- Users want more prescriptive assets (e.g., sample policies, scripts).

## Template
Review all the content to ensure it aligns with the following template. 

    Template:{

    # {article title}

    State what the article is about.State why this guidance is important in one or two sentences without stating "is it important/crucial/critical because".

    ## Each {heading} must be an {imperative recommendation}. Use sentence case.

    The first sentence uses a declarative sentence that starts with an article or noun to explain this {imperative recommendation} in {heading} is important in the context of this article, but it must not with a gerund (verb ending in -ing). The next sentence must descriptive states why this {heading} is important in the context of this article. Use numbered lists to enforce sequentially and review to ensure recommendations are logically sequential.

    1. **Start with a concise numbered imperative recommendation that indicates how to reach the goal, which must be logically first compared to the of the numbered imperative recommendations.** Next clarify what this {concise numbered imperative recommendation 1} means in this context, using a declarative sentence that doesn't start with a pronoun. Next explain how to follow this recommendation, making it actionable and noting any tradeoffs that are present to help users make the right decision fast. Take any "Design considerations" section and integrate it into the recommendations to help users weigh tradeoffs. If there's no corresponding recommendation then create into a recommendation.

        Use as many {numbered imperative recommendations} as needed and follow the same structure for each.

    ## Add as many headings and sub headings as needed. Enforce the same style and format throughout.
