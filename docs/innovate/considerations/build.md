---
title: "Cloud innovation: Build with customer empathy"
titleSuffix: Microsoft Cloud Adoption Framework for Azure
description: Learn to build with customer empathy.
author: BrianBlanchard
ms.author: brblanch
ms.date: 09/27/2019
ms.topic: guide
ms.service: cloud-adoption-framework
ms.subservice: innovate
---

# Build with customer empathy

"Necessity is the mother of invention." This proverb captures the indelibility of the human spirit and our natural drive to invent. As explained in the Oxford English Dictionary, "When the need for something becomes imperative, you are forced to find ways of getting or achieving it." Few would deny these universal truths about invention. However, as described in the [innovate methodology](./index.md), innovation requires a balance of **invention** and **adoption**.

Continuing with the analogy, innovation comes from a more extended family. *Customer empathy is the proud parent of innovation.* Creating a solution that drives innovation requires a legitimate customer need&mdash;one that keeps the customer coming back to solve critical customer challenges. These solutions are based on what a customer needs rather than their wants or whims. To find customers' true needs, we start with empathy&mdash;a deep understanding of the customer's experience. This is an underdeveloped skill for many engineers, product managers, and even business leaders. Fortunately, the diverse interactions and rapid pace of the cloud architect role has likely already started developing these skills.

Why is empathy so important? From the first release of a minimum viable product (MVP) to the general availability of a market-grade solution, customer empathy allows us to understand and share in the experience of the customer. That empathy helps us learn to build a better solution. More importantly, it better positions us to **invent** solutions that will encourage **adoption**. In a digital economy, those who can most quickly empathize with customer needs can build a brighter future which redefines and leads the market.

## How to build with empathy

Planning is intrinsically an exercise in defining assumptions. The more we plan, the more assumptions will creep into the foundation of a great idea. Generally speaking, assumptions tend to be the product of self-empathy&mdash;in other words, "what would I want, if I were in this position?" Starting with the build phase minimizes the time that assumptions can invade a solution. It also accelerates the feedback loop with real customers, triggering earlier opportunities to learn and sharpen empathy.

> [!CAUTION]
> Properly defining what to build can be tricky and requires some practice. If you build something too quickly, if might not reflect customer needs. If you spend too much time understanding initial customer need and customer solution requirements, the market may meet the need before you have a chance to build anything at all. In either scenario, the opportunity to learn can be significantly delayed or reduced. Sometimes the data can even be corrupted.

The most innovative solutions in history began with an intuitive belief. That gut feel comes from both existing expertise and firsthand observation. We start with build because it allows for a rapid test of that intuition. From there, we can cultivate deeper understanding and clearer degrees of empathy. At every iteration or release of a solution, balance comes from building MVPs that demonstrate customer empathy.

To guide this balancing act, the following two sections discuss the concepts of building with empathy and defining an MVP.

### Define a customer focused-hypothesis

Building with empathy means creating a solution based on defined hypotheses that illustrate a specific customer need. The following steps will help formulate a hypothesis that will lead to building with empathy.

1. When building with empathy, the customer is always the focus. This can take many shapes. You could reference a customer archetype, a specific persona, or even a picture of a customer in the midst of the problem you wish to solve. Additionally, customers can be internal (employees or partners) or external (consumers or business customers). This definition of customer is the first hypothesis to be tested&mdash;can you help this specific customer?
2. Second is an understanding of the customer experience. Building with empathy means that the customer's experience is relatable and their challenge is understood. This is the next hypothesis to be tested&mdash;can we help this specific customer with this manageable challenge?
3. Third is to define a simple solution to a single challenge. Relying on expertise across people, process, and technology subject matter experts will lead to a potential solution. This is the full hypothesis to be tested&mdash;can we help this specific customer with this manageable challenge using the proposed solution?
4. The final step of building with empathy is the value statement. What long-term value do you hope to provide to these customers? This answer creates your full hypothesis&mdash;how will customers' lives be improved by using the proposed solution to address this manageable challenge?

This last step is the culmination of a empathy-driven hypothesis. It defines the audience, the problem, the solution, and the metric by which improvement is to be made, all of which center on the customer. During the measure and learn phases, each hypothesis should be tested. Changes in the customer, problem statement, or solution are anticipated as the team develops greater empathy for the addressable customer base.

> [!CAUTION]
> The goal is to _build_ with customer empathy, not to _plan_ with customer empathy. It is easy to get stuck in endless cycles of planning and tweaking to find the perfect customer empathy statement. Before beginning any attempts to develop such a statement, review the following two sections on defining and building an MVP.

Once core assumptions can be proven, later iterations will focus on growth tests in additional to empathy tests. Once empathy is built, tested, and validated, we can begin to understand the addressable market at scale. This can be done through an expansion of a standard hypothesis formula above. Based on available data, estimate the size of the total market (in other words, the number of potential customers). From there, estimate the percentage of that total market which experiences a similar challenge and might be interested in this solution if it could address the challenge. This is your addressable market. The next hypothesis to be tested is: how will _x%_ of customers' lives be improved by using the proposed solution to address this manageable challenge? A small sampling of customers will reveal leading indicators that suggest a percentage impact on customers engaged.

### Define a solution to test the hypothesis

During each iteration of a build-measure-learn feedback loop, the attempt to build with empathy is defined by an minimum viable product.

A minimum viable product (MVP) is the smallest unit of effort (invention, engineering, application development, or data architecture) to create enough of a solution to learn _with the customer_. The goal of every MVP is to test some or all of the prior hypothesis and to receive feedback directly from the customer. The output is not a beautiful application with all the features required to change your industry. The desired output of each iteration is a learning opportunity&mdash;a chance to more deeply test a hypothesis.

A common way to ensure a product is minimal is timeboxing the solution creation. Ensure the development team thinks that the solution can be created in a single iteration to allow for rapid testing. To better understand using velocity, iterations, and releases to define what minimal means, see [Planning velocity, iterations, release, and iteration paths](../../plan/iteration-paths.md).

### Reduce complexity and delay technical spikes

The [disciplines of innovation](./invention.md) found within the [innovate methodology](./index.md) describe the functionality often required to deliver a mature innovation or scale-ready MVP solution. Use these disciplines as a long-term guide for feature inclusion. Likewise, use them as a cautionary guide during early testing of customer value and empathy in your solution.

Feature breadth and the different disciplines of innovation can't be created all in a single iteration. Often, it takes several releases for an MVP solution to include the complexity of multiple disciplines. Depending on the investment in development, there may be multiple parallel teams working within different disciplines to test multiple hypotheses. While it is wise to maintain architectural alignment between those teams, it is unwise to attempt complex integrated solutions until value hypotheses can be validated.

Complexity is best detected in the frequency or volume of **technical spikes**. Technical spikes are efforts to create technical solutions that can't be easily tested with customers. When customer value and customer empathy are untested, technical spikes represent a risk to innovation and should be minimized when possible. For the types of mature tested solutions found in a migration effort, technical spikes may be common throughout adoption. However, they delay the testing of hypotheses in innovation efforts and should be postponed when possible.

A relentless simplification approach is suggested for any MVP definition. Relentless simplification is the removal of anything that doesn't add to your ability to validate the hypothesis. To minimize complexity, reduce integrations and features that aren't required to test the hypothesis.

### Build a minimum viable product (MVP)

At each iteration, an MVP solution can take many different shapes. The common requirement is only that the output allows for measurement and testing of the hypothesis. This simple requirement initiates the scientific process and allows the team to build with empathy. To deliver this customer-first focus, an initial MVP may rely on only one of the [disciplines of innovation](./invention.md).

In some cases, the fastest path to innovation is temporarily avoiding these disciplines entirely, until the cloud adoption team is confident that the hypothesis is accurately validated. Coming from a technology company like Microsoft, this guidance may sound counterintuitive. The goal of this statement is to emphasize that the customer need, and not a specific technology decision, should be the highest priority in an MVP solution.

Commonly, an MVP solution consists of a simple web app or data solution with minimal features and limited polish. For organizations that have professional development expertise, this is often the fastest path to learning and iteration. The following are a few other approaches that a team could take build an MVP:

- A predictive algorithm that is wrong 99% of the time, but demonstrates specific desired outcomes.
- An IoT device that doesn't communicate securely at production scale, but can demonstrate the value of nearly real-time data within a process.
- An application built by a citizen developer to test a hypothesis or meet smaller-scale needs.
- A manual process that recreates the benefits of the application to follow.
- A wireframe or video that is detailed enough to allow the customer to interact.

Developing an MVP shouldn't require massive amounts of development investment. Preferably, investment should be constrained as much as possible to minimize the number of hypotheses being tested at one time. Then in each iteration and with each release, the solution is intentionally improved toward a scale-ready solution representing multiple disciplines of innovation.

### Accelerate MVP development

Time to market is crucial to the success of any innovation. Faster releases lead to faster learning. Faster learning leads to products that can scale more quickly. At times, traditional application development cycles can slow this process. More frequently, innovation is constrained by available expertise. Budgets, headcount, and availability of staff can all create limits to the number of new innovations a team can handle.

Staffing constraints and the desire to build with empathy have spawned a rapidly growing trend toward citizen developers. These developers reduce risk and provide scale within the professional development community of an organization. Citizen developers are subject matter experts regarding the customer experience, but they are not trained as engineers. These individuals use prototyping tools or lighter weight development tools that might be frowned upon by professional developers. This new breed of business-aligned developers create MVP solutions and test theories. When aligned well, this process can create production solutions that may provide value but don't pass an effective-enough scale hypothesis. They can also be used as validation of a prototype before scale efforts begin.

Within any innovate plan, it is advised that cloud adoption teams diversify their portfolio to include citizen developer efforts. By scaling development efforts, more hypotheses can be formed and tested at a reduced investment. When a hypothesis is validated and an addressable market is identified, professional developers can harden and scale the solution using modern development tools.

### Final build gate: Customer pain

When customer empathy is strong, a clear problem should be easy to identify. The customer pain should be obvious. During build, the cloud adoption team is building a solution to test a hypothesis based on a customer pain point. If the hypothesis is well defined, but the pain point is not, then the solution is not truly based on customer empathy. In this scenario, build is not the right starting point. Instead, invest first in building empathy and learning from real customers. The best approach for building empathy and validating pain is simple: listen to customers. Invest time in meeting with and observing your customers until you can identify a pain point that occurs frequently. Once the pain point is understood, this approach can test a hypothesized solution for addressing that pain.

## When not to apply this approach

There are many legal, compliance, and industry requirements which might require an alternative approach. If public releases of a developing solution create risk to patent timing, intellectual property protection, leak of customer data, or violation of established compliance requirements, then this approach may not be suitable. When perceived risks like these exist, consult legal counsel before adopting any guided approach to release management.

## References

Some of the concepts in this article build on topics discussed in _[The Lean Startup](http://theleanstartup.com/book)(Eric Ries, Crown Business, 2011)_.

## Next steps

Once an MVP solution has been built, the empathy value and scale value can be measured. Learn how to [measure for customer impact](./measure.md).

> [!div class="nextstepaction"]
> [Measure for customer impact](./measure.md)
