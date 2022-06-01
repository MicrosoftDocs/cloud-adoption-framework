```
author: MarkSimos
ms.author: mas
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: secure
ms.custom: internal
```

# DevSecOps as continuous improvement strategy

Adopt a DevSecOps strategy that blends elements of DevOps and classic security and operations approaches. The diagram above illustrates how this contrasts with classic Waterfall development release cycles where security and other governance mechanisms were built into large longer-term releases. The DevOps model leads with rapid iterative releases (of smaller changes) which enables organizations to meet continuously evolving marketplace expectations.

Operationalize DevSecOps strategies as the ideal state your organization should be working towards, not simply a quick transformation away from your current development practices.

## Governance and production releases

![](./media/devsecops-continuous-innovation-security.png)

As your organization adopts DevOps continuous improvement strategies (illustrated in the diagram above), ensure first that security and other governance processes are adapted to your approach, so it mitigates security risk but does not decrease the value of rapid release cycles.

Before an application is put into full production, identify your MVP for production release across Dev, Sec, and Ops domains meet minimum requirements across these disciplines. The MVP will vary with your organization’s goals, culture, and industry— but should balance among the needs for rapid release, security/safety, and production performance and reliability. Prioritizing requirements and meeting all these needs is a team effort. Your organization won't be well served if the product is released too late, doesn’t meet market needs—if an application doesn’t scale or perform well—or if sensitive information and customer trust is compromised.

As illustrated in the diagram above, security should focus on ensuring the application/workload doesn’t provide an easy (low cost, low friction) means for an attacker to abuse its functionality:
  - **Secure design**: follow a sound security design approach—typically using a threat modelling technique.
  - **Secure code**: validate security of the actual implementation (including dependent components), typically by correcting bugs found with tooling like static and dynamic analysis.
  - **Secure environment**: validate underlying infrastructure configurations follow best practices (patching, configuration, etc.)

## Securing production DevOps

After the first production release of the workload, it enters production DevOps phase pictured in the diagram above, where changes and bug fixes are applied rapidly. Integrate security natively in this process to ensure that security lessons are integrated within the developer operations cycle—review security aspects of design during design reviews—and report security bugs using the same tools and prioritization terminology as other bugs, etc. 

Rapidly fix security bugs, and use a bottom-up approach to reduce security bug volume and its impact. Reduce the count and potential severity of security bugs in your applications by implementing security practices and tools during the development lifecycle.

## Continuous improvement increments

The diagram above illustrates how working together and learning as a team will continually refine your understanding of the process of adding continuous improvements in increments. These lessons will shape how you determine the MVP across the Dev, Sec, and Ops domains, how to make incremental progress with less friction, and how your team can better work together as you move forward to balance any trade-offs.

## Security as team sport
DevOps security is a team effort—integrating security throughout the application development lifecycle that offers high security threat visibility, shorter development cycles, and automated cloud security implementations.

## Delivering end-user value faster
DevOps tightly integrates development and operations to enable fast and continuous delivery of value to end users. As you mature this process, ensure it continues to build security as mindset and practice using security development lifecycle (SDL) and Operational Security Assurance (OSA) processes such as:

- Providing training—focus on ramping up your team's collective knowledge of security best practices—and the mindset of attackers—how they exploit configuration mistakes and architectural weaknesses.
- Defining requirements—establish a minimum-security baseline for your security and compliance controls. Bake these into the DevOps process and pipeline. Baselines should consider current, real-world threats, known industry challenges, and regulatory requirements stretching across the technology stack. 
- Defining metrics and reporting—drive desired behaviors across your engineering team—defining specific metrics which drive action and support compliance objectives.
- Using Software Composition Analysis (SCA) and governance—analyze and keep an inventory of third-party components, and create a plan to evaluate reported vulnerabilities. Weigh possible vulnerabilities of third-party components on system security.
- Performing threat modeling—use a structured approach to quickly identify security vulnerabilities—and use threat modeling to determine and mitigate risk. While optimizing cost, your team can effectively choose security features, and establish appropriate mitigation strategies.
- Using automation and tools—carefully select intelligent automation and tools to help engineers and ensure process consistency—toolsets that are already integrated into engineering processes. Focus on fixing issues and avoid overloading engineers with processes alien to the engineering ecosystem. Secure DevOps workflow tools are integrated into CI/CD pipelines—avoid security expertise requirements—and avoid high false-positive issue-reporting rates.
- Keeping credentials safe—scan for credentials and sensitive content in source files during pre-commit as they reduce the risk of propagating the sensitive information into your team’s CI/CD process. Don't store sensitive keys in code—and consider using a bring-your-own-key (BYOK) solution that generates keys using a hardware security module (HSM).
- Using continuous learning and monitoring—monitor applications, infrastructure, and network with advanced analytics to uncover security and performance issues. Gain better visibility into your application health and identify and mitigate risks to reduce exposure to attacks when utilizing CI/CD practices coupled with monitoring tools. Monitoring supporting a defense-in-depth strategy and can reduce your organization’s mean time to identify (MTTI) and mean time to contain (MTTC) metrics.

A comprehensive DevOps ecosystem of development lifecycle+ native security encompasses strategy, security, architecture, and implementation/operations, along with toolsets to support this ecosystem, e.g., Azure DevOps. Below is an example of DevOps workflows / processes, from the initial Idea Incubation phase (invention of new products or services) through to DevOperations (continuous Agile innovation).

The diagram highlights how security teams implement continuous improvements across the lifecycle—to both refine an MVP across the various Dev (Business Requirements), Sec (compliance/security/safety), and Ops (quality/performance/support) domains, as well as continuously improve the security process and program itself (developer productivity, operational efficiency, security posture, identity standardization protocols, etc.

![](./media/development-security-operations-continuous-lifecycle-improvement.png)

## Next steps:

- [Development security architecture](development-security-architecture.md)
