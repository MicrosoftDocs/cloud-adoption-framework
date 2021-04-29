---
title: Build customer empathy
description: Learn to create solutions that drive cloud innovation based on customer empathy, a deep understanding of the customer's experience.
author: BrianBlanchard
ms.author: brblanch
ms.date: 09/27/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: innovate
ms.custom: internal, seo-caf-innovate
keywords: how to build empathy, customer empathy, cloud innovation
---

<!-- docutune:casing "Oxford English Dictionary" -->

# Build with customer empathy

"Necessity is the mother of invention." This proverb captures the indelibility of the human spirit and our natural drive to invent. As explained in the Oxford English Dictionary, "When the need for something becomes imperative, you're forced to find ways of getting or achieving it." Few would deny these universal truths about invention. However, as described in [Innovation in the digital economy](./index.md), cloud innovation requires a balance between invention and adoption.

Continuing with the analogy, innovation comes from a more extended family. *Customer empathy is the proud parent of innovation.* Creating a customer empathy solution that drives innovation requires a legitimate customer need that keeps the customer coming back to solve critical challenges. These solutions are based on what a customer needs rather than on their wants or whims. To find their true needs, we start with empathy, a deep understanding of the customer's experience. Empathy is an underdeveloped skill for many engineers, product managers, and even business leaders. Fortunately, the diverse interactions and rapid pace of the cloud architect role have already started fostering this skill.

How do we build empathy, and why is customer empathy so important? Customer empathy helps us understand and share in the experience of the customer. From the first release of a minimum viable product (MVP) to the general availability of a market-grade solution, customer empathy helps us build a better solution. More importantly, it better positions us to invent solutions that will encourage adoption. In a digital economy, those who can most readily empathize with customer needs can build a brighter future that redefines and leads the market.

## How to build with customer empathy

Defining assumptions is a fundamental part of planning. The more we plan, the more we see assumptions creep into the foundation of a great idea. Assumptions are typically the product of self-empathy. In other words, *what would I want if I were in this position?* Starting with the build phase minimizes the period in which assumptions can invade a solution. This approach also accelerates the feedback loop with real customers, triggering earlier opportunities to learn and sharpen empathy.

> [!CAUTION]
> Properly defining what to build can be tricky and requires some practice. If you build something too quickly, if might not reflect customer needs. If you spend too much time trying to understand initial customer needs and solution requirements, the market might meet them before you have a chance to build anything at all. In either scenario, the opportunity to learn can be significantly delayed or reduced. Sometimes the data can even be corrupted.

The most innovative solutions in history began with an intuitive belief. That gut feeling comes from both existing expertise and firsthand observation. We start with the build phase because it allows for a rapid test of that intuition. From there, we can cultivate deeper understanding and clearer degrees of empathy. At every iteration or release of a solution, balance comes from building MVPs that demonstrate customer empathy.

To steady this balancing act, the following two sections discuss the concepts of how to build with empathy and defining an MVP.

### Define a customer focused-hypothesis

Building with empathy means creating a solution based on defined hypotheses that illustrate a specific customer need. The following steps aim to formulate a hypothesis that will encourage building with empathy.

1. When you build with empathy, the customer is always the focus. This intention can take many shapes. You could reference a customer archetype, a specific persona, or even a picture of a customer in the midst of the problem you want to solve. And keep in mind that customers can be internal (employees or partners) or external (consumers or business customers). This definition is the first hypothesis to be tested: can we help this specific customer?
2. Understand the customer experience. Building with empathy means you can relate to the customer's experience and understand their challenges. This mindset indicates the next hypothesis to be tested: can we help this specific customer with this manageable challenge?
3. Define a simple solution to a single challenge. Relying on expertise across people, processes, and subject matter experts will lead to a potential solution. This is the full hypothesis to be tested: can we help this specific customer with this manageable challenge through the proposed solution?
4. Arrive at a value statement. What long-term value do you hope to provide to these customers? The answer to this question creates your full hypothesis: how will these customers' lives be improved by using the proposed solution to address this manageable challenge?

This last step is the culmination of a customer empathy-driven hypothesis. It defines the audience, the problem, the solution, and the metric by which improvement is to be made, all of which center on the customer. During the measure and learn phases, each hypothesis should be tested. Changes in the customer, problem statement, or solution are anticipated as the team develops greater empathy for the addressable customer base.

> [!CAUTION]
> The goal is to *build* with customer empathy, not to *plan* with it. It's all too easy to get stuck in endless cycles of planning and tweaking to hit upon the perfect customer empathy statement. Before you try to develop such a statement, review the following sections on defining and building an MVP.

After core assumptions are proven, later iterations will focus on growth tests in addition to empathy tests. After empathy is built, tested, and validated, you can begin to understand the addressable market at scale. This can be done through an expansion of the standard hypothesis formula described earlier. Based on available data, estimate the size of the total market (the number of potential customers).

From there, estimate the percentage of that total market that experiences a similar challenge and that might therefore be interested in this solution. This is your addressable market. The next hypothesis to be tested is: how will *x%* of customers' lives be improved by using the proposed solution to address this manageable challenge? A small sampling of customers will reveal leading indicators that suggest a percentage impact on the pool of customers engaged.

### Define a solution to test the hypothesis

During each iteration of a build-measure-learn feedback loop, your attempt to build with empathy is defined by an MVP.

An MVP is the smallest unit of effort (invention, engineering, application development, or data architecture) required to create enough of a solution to learn *with the customer*. The goal of every MVP is to test some or all of the prior hypotheses and to receive feedback directly from the customer. The output is not a beautiful application with all the features required to change your industry. The desired output of each iteration is a learning opportunity, a chance to more deeply test a hypothesis.

*Timeboxing* is a standard way to make sure a product remains lean. For example, make sure your development team thinks the solution can be created in a single iteration to allow for rapid testing. To better understand using velocity, iterations, and releases to define what minimal means, see [Planning velocity, iterations, release, and iteration paths](../../plan/iteration-paths.md).

### Reduce complexity and delay technical spikes

The [disciplines of invention](./invention.md) found in the [Innovate methodology](./index.md) describe the functionality that's often required to deliver a mature innovation or scale-ready MVP solution. Use these disciplines as a long-term guide for feature inclusion. Likewise, use them as a cautionary guide during early testing of customer value and empathy in your solution.

Feature breadth and the different disciplines of invention can't all be created in a single iteration. It might take several releases for an MVP solution to include the complexity of multiple disciplines. Depending on the investment in development, there might be multiple parallel teams working within different disciplines to test multiple hypotheses. Although it's smart to maintain architectural alignment between those teams, it's unwise to try to build complex, integrated solutions until value hypotheses can be validated.

Complexity is best detected in the frequency or volume of *technical spikes*. Technical spikes are efforts to create technical solutions that can't be easily tested with customers. When customer value and customer empathy are untested, technical spikes represent a risk to innovation and should be minimized. For the types of mature tested solutions found in a migration effort, technical spikes can be common throughout adoption. However, they delay the testing of hypotheses in innovation efforts and should be postponed whenever possible.

A relentless simplification approach is suggested for any MVP definition. This approach means removing anything that doesn't add to your ability to validate the hypothesis. To minimize complexity, reduce the number of integrations and features that aren't required to test the hypothesis.

### Build an MVP

At each iteration, an MVP solution can take many different shapes. The common requirement is only that the output allows for measurement and testing of the hypothesis. This simple requirement initiates the scientific process and allows the team to build with empathy. To deliver this customer-first focus, an initial MVP might rely on only one of the [disciplines of invention](./invention.md).

In some cases, the fastest path to innovation means temporarily avoiding these disciplines entirely, until the cloud adoption team is confident that the hypothesis has been accurately validated. Coming from a technology company like Microsoft, this guidance might sound counterintuitive. However, this simply emphasizes that customer needs, not a specific technology decision, are the highest priority in an MVP solution.

Typically, an MVP solution consists of a simple application or data solution with minimal features and limited polish. For organizations that have professional development expertise, this path is often the fastest one to learning and iteration. The following list includes several other approaches a team might take to build an MVP:

- A predictive algorithm that's wrong 99 percent of the time but that demonstrates specific desired outcomes.
- An IoT device that doesn't communicate securely at production scale but that demonstrates the value of nearly real-time data within a process.
- An application built by a citizen developer to test a hypothesis or meet smaller-scale needs.
- A manual process that re-creates the benefits of the application to follow.
- A wireframe or video that's detailed enough to allow the customer to interact.

Developing an MVP shouldn't require massive amounts of development investment. Preferably, investment should be as constrained as possible to minimize the number of hypotheses being tested at one time. Then, in each iteration and with each release, the solution is intentionally improved toward a scale-ready solution that represents multiple disciplines of invention.

### Accelerate MVP development

Time to market is crucial to the success of any innovation. Faster releases lead to faster learning. Faster learning leads to products that can scale more quickly. At times, traditional application development cycles can slow this process. More frequently, innovation is constrained by limits on available expertise. Budgets, headcount, and availability of staff can all create limits to the number of new innovations a team can handle.

Staffing constraints and the desire to build with empathy have spawned a rapidly growing trend toward citizen developers. These developers reduce risk and provide scale within an organization's professional development community. Citizen developers are subject matter experts where the customer experience is concerned, but they're not trained as engineers. These individuals use prototyping tools or lighter-weight development tools that might be frowned upon by professional developers. These business-aligned developers create MVP solutions and test theories. When aligned well, this process can create production solutions that provide value but don't pass a sufficiently effective scale hypothesis. They can also be used to validate a prototype before scale efforts begin.

Within any innovate plan, cloud adoption teams should diversify their portfolios to include citizen developer efforts. By scaling development efforts, more hypotheses can be formed and tested at a reduced investment. When a hypothesis is validated and an addressable market is identified, professional developers can harden and scale the solution by using modern development tools.

### Final build gate: Customer pain

When customer empathy is strong, a clearly existing problem should be easy to identify. The customer's pain should be obvious. During build, the cloud adoption team is building a solution to test a hypothesis based on a customer pain point. If the hypothesis is well-defined but the pain point is not, the solution is not truly based on customer empathy. In this scenario, build is not the right starting point. Instead, invest first in building empathy and learning from real customers. The best approach for building empathy and validating pain is simple: listen to your customers. Invest time in meeting with and observing them until you can identify a pain point that occurs frequently. After the pain point is well-understood, you're ready to test a hypothesized solution for addressing that pain.

## When not to apply this approach

There are many legal, compliance, and industry requirements that might necessitate an alternate approach. If public releases of a developing solution create risk to patent timing, intellectual property protection, customer data leaks, or violation of established compliance requirements, this approach might not be suitable. When perceived risks like these exist, consult legal counsel before adopting any guided approach to release management.

## References

Some of the concepts in this article build on topics discussed in [The Lean Startup](http://theleanstartup.com/book) by Eric Ries.

## Next steps

After you've built an MVP solution, you can measure the empathy value and scale value. Learn how to [measure for customer impact](./measure.md).

> [!div class="nextstepaction"]
> [Measure for customer impact](./measure.md)
