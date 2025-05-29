---
title: Build with customer empathy
description: Learn to create solutions that drive cloud innovation based on customer empathy and a deep understanding of the customer's experience.
author: Zimmergren
ms.author: pnp
ms.date: 12/05/2022
ms.topic: conceptual
ms.custom: internal
keywords: how to build empathy, customer empathy, cloud innovation
---

# Build with customer empathy

"Necessity is the mother of invention." This saying captures the indelibility of the human spirit and our natural drive to invent. As explained in the Oxford English Dictionary, "When the need for something becomes imperative, you're forced to find ways of getting or achieving it." Few would deny these universal truths about invention. However, as the article [Innovation in the digital economy](./index.md) explains, cloud innovation requires a balance between invention and adoption.

If we continue with the analogy, innovation comes from a more extended family. *Customer empathy is the proud parent of innovation.* To create a customer empathy solution, which drives innovation, requires a legitimate customer need that keeps them coming back to solve critical challenges. These solutions are based on what customers need rather than wants or whims. To find customers' true needs, start with empathy and a deep understanding of the customer experience. Empathy is an underdeveloped skill for many engineers, product managers, and even business leaders. Fortunately, the diverse interactions and rapid pace of the cloud architect role foster this skill.

How do you build empathy and why is customer empathy so important? Customer empathy helps you understand and share in the experience of the customer. From the first release of a minimum viable product (MVP), to the general availability of a market-grade solution, customer empathy helps you build better solutions. More importantly, empathy better positions a team to invent solutions that encourage adoption. In a digital economy, product teams who can most readily empathize with customer needs can build a brighter future with better tools that redefine and lead the market.

## Define assumptions to build with customer empathy

Defining assumptions is a fundamental part of planning. The more you plan, the more clearly you can see your assumptions creeping into the foundation of a great idea. Assumptions are typically the product of self-empathy. In other words, *what would I want if I was in this position?* When you start with the build phase, it minimizes the period in which assumptions can invade a solution. This approach also accelerates the feedback loop with real customers, triggering earlier opportunities to learn and sharpen empathy.

> [!CAUTION]
> Properly defining what to build can be tricky and requires some practice. If you build something too quickly, it might not reflect customer needs. If you spend too much time trying to understand initial customer needs and solution requirements, the market might meet them before you have a chance to build anything at all. In either scenario, the opportunity to learn can be significantly delayed or reduced. Sometimes the data can even be corrupted.

The most innovative solutions in history began with an intuitive belief. That gut feeling comes from both existing expertise and firsthand observation. Start with the build phase because it allows for a rapid test of your intuition. From there, you can cultivate deeper understanding and clearer degrees of empathy. At every iteration or release of a solution, balance comes from building MVPs that demonstrate customer empathy.

To steady this balancing act, the following two sections describe the concepts of how to build with empathy and define an MVP.

### Define a customer-focused hypothesis

When you build with empathy, it means you create a solution based on defined hypotheses that illustrate a specific customer need. The following steps formulate a hypothesis that encourages building with empathy.

1. When you build with empathy, the customer is always the focus. This intention can take many shapes. You could reference a customer archetype, a specific persona, or even a picture of a customer in the midst of the problem you want to solve. And keep in mind that customers can be internal (employees or partners) or external (consumers or business customers). This definition is the first hypothesis for you to test: can we help this specific customer?
2. Understand the customer experience. Building with empathy means you can relate to the customer's experience and understand their challenges. This mindset indicates the next hypothesis to be tested: can we help this specific customer with this manageable challenge?
3. Define a clear solution to a single challenge. If you rely on expertise across people, processes, and subject matter experts, it can lead to a potential solution. The full hypothesis to be tested is then: can we help this specific customer with this manageable challenge through the proposed solution?
4. Arrive at a value statement. What long-term value do you hope to provide to these customers? The answer to this question creates your full hypothesis: how will these customers' lives be improved by using the proposed solution to address this manageable challenge?

This last step is the culmination of a customer empathy-driven hypothesis. It defines the audience, the problem, the solution, and the metric by which improvement is to be made, all of which center on the customer. During the measure and learn phases, you should test each hypothesis. Anticipate changes in the customer, the problem statement, or the solution as the team develops greater empathy for the addressable customer base.

> [!CAUTION]
> The goal is to *build* with customer empathy, not to *plan* with it. It's all too easy to get stuck in endless cycles of planning and tweaking to hit upon the perfect customer empathy statement. Before you try to develop such a statement, review the following sections on defining and building an MVP.

After you prove the core assumptions, later iterations focus on growth tests in addition to empathy tests. After you build, test, and validate empathy, you begin to understand the addressable market at scale. You can more deeply understand your addressable market by expanding the standard hypothesis formula described previously. Then, based on available data, estimate the size of the total market (the number of potential customers).

From there, estimate the percentage of the total market that experiences a similar challenge and might therefore be interested in the solution. You then have your addressable market. The next hypothesis to test is: how will *x%* of customers' lives be improved by using the proposed solution to address this manageable challenge? A small sampling of customers reveals leading indicators that suggest a percentage effect on the pool of customers engaged.

### Define a solution to test the hypothesis

During each iteration of a build-measure-learn feedback loop, your attempt to build with empathy is defined by an MVP.

An MVP is the smallest unit of effort (invention, engineering, application development, or data architecture) required to create enough of a solution to learn *with the customer*. The goal of every MVP is to test some or all of the prior hypotheses and to receive feedback directly from the customer. The output isn't a beautiful application with all the features required to change your industry. The desired output of each iteration is a learning opportunity, a chance to more deeply test a hypothesis.

*Timeboxing* is a standard way to make sure a product remains lean. For example, confirm that your development team thinks the solution can be created in a single iteration to allow for rapid testing. To better understand how to use velocity, iterations, and releases to define what minimal means, see [Planning velocity, iterations, release, and iteration paths](../../plan/iteration-paths.md).

### Reduce complexity and delay technical spikes

The [disciplines of invention](./invention.md) described in [Innovate methodology](./index.md) explore the functionality that's often required to deliver a mature innovation or scale-ready MVP solution. Use these disciplines as a long-term guide for feature inclusion. Likewise, use them as a cautionary guide during early testing of customer value and empathy in your solution.

Feature breadth and the different disciplines of invention can't all be created in a single iteration. It might take several releases for an MVP solution to include the complexity of multiple disciplines. Depending on the investment in development, there might be multiple parallel teams working within different disciplines to test multiple hypotheses. Although it's smart to maintain architectural alignment between those teams, it's unwise to try to build complex, integrated solutions until you can validate the value hypotheses.

You detect complexity the best in the frequency or volume of *technical spikes*. Technical spikes are efforts to create technical solutions that can't be easily tested with customers. When customer value and customer empathy are untested, technical spikes represent a risk to innovation, and should be minimized. For the types of mature tested solutions found in a migration effort, technical spikes can be common throughout adoption. But they delay the testing of hypotheses in innovation efforts and you should postpone them whenever possible.

A relentless simplification approach helps any MVP definition. This approach means you remove anything that doesn't aid your ability to validate the hypothesis. To minimize complexity, reduce the number of integrations and features that aren't required to test the hypothesis.

### Build an MVP

At each iteration, an MVP solution can take many different shapes. The common requirement is only that the output allows for measurement and testing of the hypothesis. This simple requirement initiates the scientific process and lets the team build with empathy. To deliver this customer-first focus, an initial MVP might rely on only one of the [disciplines of invention](./invention.md).

In some cases, the fastest path to innovation means temporarily avoiding these disciplines entirely, until the cloud adoption team is confident that the hypothesis is accurately validated. From a technology company like Microsoft, this guidance might sound counterintuitive. But it emphasizes that customer needs, not a specific technology decision, are the highest priority in an MVP solution.

Typically, an MVP solution consists of an application or data solution with minimal features and limited polish. For organizations that have professional development expertise, this path is often the fastest one to learning and iteration. The following list includes several other approaches a team might take to build an MVP:

- A predictive algorithm that's wrong 99 percent of the time but that demonstrates specific desired outcomes.
- An IoT device that doesn't communicate securely at production scale but demonstrates the value of nearly real-time data within a process.
- An application built by a citizen developer to test a hypothesis or meet smaller-scale needs.
- A manual process that re-creates the benefits of the application to follow.
- A wireframe or video that's detailed enough to let the customer interact.

Developing an MVP shouldn't require massive amounts of development investment. Preferably, you constrain investment as much as possible to minimize the number of hypotheses being tested at one time. Then, in each iteration and with each release, you intentionally improve the solution toward your scale-ready solution that represents multiple disciplines of invention.

### Accelerate MVP development

Time to market is crucial to the success of any innovation. Faster releases lead to faster learning. Faster learning leads to products that can scale more quickly. At times, traditional application development cycles can slow this process. More frequently, innovation is constrained by limits on available expertise. Budgets, headcount, and staff availability can all create limits to the number of new innovations a team can handle.

Staffing constraints and the desire to build with empathy spawned a rapidly growing trend toward citizen developers. These developers reduce risk and provide scale within an organization's professional development community. Citizen developers are subject matter experts in the customer experience, but they're not trained as engineers. These individuals use prototyping tools or lighter-weight development tools that might be frowned upon by professional developers. These business-aligned developers create MVP solutions and test theories. When aligned well, this process creates production solutions that provide value but don't pass a sufficiently effective scale hypothesis. Teams can also use the solutions to validate a prototype before scale efforts begin.

Within any innovate plan, cloud adoption teams should diversify their portfolios to include citizen developer efforts. By scaling development efforts, you can form and test more hypotheses at a reduced investment. When you validate a hypothesis and identify an addressable market, professional developers can then harden and scale the solution by using modern development tools.

### Final build gate: Customer pain

When customer empathy is strong, a clearly existing problem should be easy to identify. The customer's pain should be obvious. During build, the cloud adoption team is working on a solution to test a hypothesis based on a customer pain point. If the hypothesis is well-defined but the pain point isn't, the solution isn't truly based on customer empathy. In this scenario, build isn't the right starting point. Instead, invest first in building empathy and learning from real customers. The best approach for building empathy and validating pain is straightforward: listen to your customers. Invest time in meeting with and observing them until you can identify a pain point that occurs frequently. After you well understand the customer pain point, you're ready to test a hypothesized solution for addressing that pain.

## When not to apply this approach

There are many legal, compliance, and industry requirements that might necessitate an alternate approach. This approach might not be suitable if public releases of a developing solution:

- Create risk to patent timing, intellectual property protection, or customer data leaks
- Violate established compliance requirements

When these perceived risks exist, consult legal counsel before adopting any guided approach to release management.

## References

Some of the concepts in this article build on ideas discussed in [`The Lean Startup`](http://theleanstartup.com/book) by Eric Ries.

## Next steps

After you've built an MVP solution, you can measure the empathy value and scale value. Learn how to [measure for customer impact](./measure.md).

> [!div class="nextstepaction"]
> [Measure for customer impact](./measure.md)
