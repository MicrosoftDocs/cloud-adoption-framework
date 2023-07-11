---
title: DevSecOps controls
description: Learn about DevSecOps controls and how to integrate security processes and tools into the DevOps development cycle.
author: texnokot
ms.author: martinek
ms.date: 08/01/2022
ms.topic: conceptual
ms.custom: internal
---

# DevSecOps controls

DevSecOps applies [innovation security](./innovation-security.md) by integrating security processes and tools into the DevOps development process.

Because DevOps itself is an emerging discipline with a high degree of process variations, successful DevSecOps hinges on understanding and thoughtfully integrating security into the development process. Adding security should start with low-friction changes to the code, the development processes, and the infrastructure that hosts the workload. Focus first on changes with the highest positive effect on security while placing a low burden on DevOps processes and skills.

This documentation reviews each stage of a continuous integration and continuous delivery (CI/CD) DevOps process and what security controls we recommend integrating first.

![DevSecOps controls](./media/devsecops-controls.png)

## Plan and develop

Typically, modern development follows an agile development methodology. Scrum is one implementation of agile methodology that has every sprint start with a planning activity. Introducing security into this part of the development process should focus on:

- *Threat modeling* to view the application through the lens of a potential attacker
- *IDE security plug-ins and pre-commit hooks* for lightweight static analysis checking within an integrated development environment (IDE).
- *Peer reviews and secure coding standards* to identify effective security coding standards, peer review processes, and pre-commit hooks.

It's not mandatory to add all these steps. But each step helps reveal security issues early, when they're much cheaper and easier to fix.

### Threat modeling

Threat modeling is arguably the most important security practice. It delivers immediate results and helps establish a security mindset in developers to improve security in all their future projects.

Threat modeling is a simple concept, though it can be detailed and technical if need be. Threat modeling reveals and documents a realistic security view of your application that includes:

- How attackers can abuse the application's design
- How to fix vulnerabilities
- How important it is to fix issues

Threat modeling effectively puts you in the mindset of an attacker. It lets you see the application through an attacker's eyes. You learn how to block attempts before attackers can do anything about it. If your team has user personas in the design, you can treat the attacker as a hostile user persona.

There are published approaches for threat modeling that range from simple question and answer methods to detailed tool-based analysis. You can base your approach on methodologies like the [STRIDE model](/azure/security/develop/threat-modeling-tool-threats), the [DREAD model](https://en.wikipedia.org/wiki/DREAD_(risk_assessment_model)), or [OWASP threat modeling](https://owasp.org/www-community/Threat_Modeling).

#### Threat modeling: Start simple

Because some approaches to threat modeling can be time-consuming and skill-intensive, we recommend starting with a simpler approach using basic questions. Simpler methods aren't as thorough, but they start the critical thinking process and help you quickly identify major security issues.

The following simple questions methods will get you started:

- [Simple questions method from Microsoft](/security/compass/applications-services#simple-questions-method): This method asks specific technical questions designed to surface common security design mistakes.
- [OWASP threat modeling](https://owasp.org/www-community/Threat_Modeling): This method focuses on asking simple, non-technical questions to get the threat modeling process started.

You can use one or both of these approaches, depending on what works better for your team.

When your team gets more comfortable with the process, they can apply more advanced techniques from Microsoft [security development lifecycle](https://www.microsoft.com/securityengineering/sdl/threatmodeling). And they can integrate threat modeling tools like [Microsoft threat modeling tool](/azure/security/develop/threat-modeling-tool) to get deeper insights and help automate the process.

Another helpful resource is the [guide to threat modeling for developers](https://martinfowler.com/articles/agile-threat-modelling.html).

### IDE security plug-ins and pre-commit hooks

Developers focus on the speed of delivery, and security controls might slow down the process. Typically, the slow-down occurs if the security checks start at the pipeline. A developer finds out about the potential vulnerability after pushing the code to the repository. To speed up the process and give immediate feedback, it's worth adding steps such as IDE security plug-ins and pre-commit hooks.

Integrated development environment (IDE) security plug-ins identify different security issues during the development process in the developer's familiar IDE environment. Plug-ins can provide immediate feedback if there's a potential security risk in the developer's written code. Plug-ins can also reveal risks in the third-party library or package. Depending on the IDE you choose, many open-source or commercial plug-ins are available and provided by security companies.

Another option to consider is to use a pre-commit framework if the version control system allows it. A pre-commit framework provides Git hook scripts that help identify issues before a developer submits code for code review. One example is [pre-commit](https://pre-commit.com) that you can set up in GitHub.

### Peer review and secure coding standards

Pull requests are standard in the development process. Part of the pull request process is peer reviews that often reveal undiscovered defects, bugs, or issues related to human mistakes. It's good practice to have a security champion or knowledgeable security teammate who can guide the developer during the peer review process before creating a pull request.

Secure coding practice guidelines help developers learn essential secure coding principles and how they should be applied. There are secure coding practices available, such as [OWASP secure coding practices](https://owasp.org/www-project-secure-coding-practices-quick-reference-guide/) to incorporate with general coding practices.

## Commit the code

Typically, developers create, manage, and share their code in repositories such as GitHub or Azure Repos. This approach provides a central, version-controlled library of code for developers to collaborate on easily. However, enabling many collaborators on a single codebase also runs the risk of changes being introduced. That risk can lead to vulnerabilities or unintentionally including credentials or tokens in commits.

To address this risk, development teams should evaluate and implement a repository scanning capability. Repository scanning tools perform static code analysis on source code within repositories. The tools look for vulnerabilities or credentials changes and flag any items found for remediation. This capability acts to protect against human error and is a useful safeguard for distributed teams where many people are collaborating in the same repository.

### Dependency management

Up to 90 percent of the code in current applications contains elements of, or is based on, external packages and libraries. With the adoption of dependencies in the source code, it's essential to address potential risks. Many third-party libraries have serious security problems. Also, developers don't consistently follow the best lifecycle and keep dependencies up to date.

Ensure that your development team knows what components to include in their applications. They'll want to download secure and up-to-date versions from known sources. And they'll want to have a process for keeping versions up to date. Your team can use tools like the OWASP Dependency-Check project, WhiteSource, and others.

To focus only on dependency vulnerabilities or their lifecycle isn't enough. It's also important to address package feeds security. There are known attack vectors that target package management systems: typosquatting, compromising existing packages, substitution attacks, and others. So, responsible package management administration must address these risks. For more information, see [Three ways to mitigate risk when using private package feeds](https://aka.ms/pkg-sec-wp).

### Static application security testing

After your team addresses third-party libraries and package management, it's essential to shift focus and improve code security. There are different ways to improve code security. You can use IDE security plug-ins. Or you can wire incremental static analysis pre-commit and commit checks as discussed before. It's also possible to do a complete source code scan to catch mistakes missed by previous steps. It's necessary but might take hours or even days to scan a large block of code. So, this approach can slow down development and introduce burden.

But a team must start somewhere when implementing static code scanning practices. One way is to introduce static code analysis inside of continuous integration. This method verifies security as soon as code changes happen. One example is SonarCloud. It wraps multiple static application security testing (SAST) tools for different languages. SonarCloud assesses and tracks technical debt with a focus on maintainability. It looks at code quality and style and has security-specific checkers. But there are many other commercial and open-source tools available in the market.

To ensure that the feedback loop is effective, it's crucial to tune the tool. You want to minimize false positives and provide clear, actionable feedback on problems to fix. Also, it's good to implement a workflow, which prevents code commits to the default branch if there are findings. You would want to cover both quality and security findings. So, security becomes a part of the unit testing experience.

### Secure pipelines

DevOps takes automation to another level because everything in the development lifecycle goes through a pipeline. Continuous integration and continuous delivery (CI/CD) are a key part of modern development cycles. In CI/CD, your team merges developer code into a central codebase on a regular schedule and automatically runs standard builds and test processes.

Infrastructure pipelines are a central part of development. But using pipelines to run scripts or deploy code to production environments can introduce unique security challenges. You want to make sure your CI/CD pipelines don't become avenues to run malicious code, allow credentials to be stolen, or give attackers any surface area for access. You also want to ensure that only the code your team intends to release then deploys.

DevOps teams must ensure they implement the proper security controls for the pipeline. Depending on the chosen platform, there are different guidelines on how to address the risks. For more information, see [Securing Azure Pipelines](/azure/devops/pipelines/security/overview).

## Build and test

Many organizations use build and release pipelines to automate and standardize the processes for building and deploying code. Release pipelines let development teams make iterative changes to sections of code quickly and at scale. The teams won't need to spend large amounts of time redeploying or upgrading existing environments. 

Using release pipelines also lets teams promote code from development environments, through testing environments, and ultimately into production. As part of automation, development teams should include security tools that run scripted, automated tests when deploying code into testing environments. The tests should include unit testing on application features to check for vulnerabilities or public endpoints. Testing ensures intentional access.

### Dynamic application security testing

In a classical waterfall development model, security was typically introduced at the last step, right before going to production. One of the most popular security approaches is penetration testing or pen testing. Penetration testing lets a team look at the application from a black-box security perspective, as in, closest to an attacker mindset. 

A penetration test consists of several action points, one of which is dynamic application security testing (DAST). DAST is a web application security test that finds security issues in the running application by seeing how the application responds to specially crafted requests. DAST tools are also known as web application vulnerability scanners. One example is an open-source tool, [OWASP Zed Attack Proxy (ZAP)](https://owasp.org/www-project-zap/). It finds vulnerabilities in the running web application. There are different ways OWASP ZAP scans: a passive baseline scan or a full scan, depending on the configuration.

The disadvantage of pen testing is that it takes time. A thorough pen test might take up to several weeks, and with the speed of DevOps development, that time frame might be unsustainable. But it's still worth adding a *lighter* version of pen testing during the development process to uncover issues missed by SAST and other steps. DAST tools like OWASP ZAP can help.

Developers integrate OWASP ZAP in the pipeline as a task. During the run, the OWASP ZAP scanner spins up in the container and does its scanning, then publishes the results. This approach might not be perfect, because it's not complete penetration testing, but it's still valuable. It's one more quality measure in the development cycle for improving the security posture.

### Cloud configuration validation and infrastructure scanning

Alongside scanning and securing the code for applications, be sure that the environments you deploy applications into are also secure. Secure environments are key for organizations who want to move at pace, innovate, and use new technologies. Secure environments also help teams create new environments quickly for experimentation.

Azure capabilities let organizations create security standards from environments, such as Azure Policy. Teams can use Azure Policy to create policy sets. The policy sets prevent the creation of certain workload types or configuration items such as public IP addresses. These *guardrails* enable teams to experiment within a safe and controlled environment, balancing innovation and governance.

One of the ways DevOps can bring developers and operations in step with each other is to support converting the existing infrastructure into an infrastructure-as-code approach.

Infrastructure as code (IaC) is the management of infrastructure (networks, virtual machines, load balancers, and connection topology) in a descriptive model. IaC uses the same versioning model as the DevOps team uses for source code. Like the principle of the same source code generates the same binary, an IaC model generates the same environment every time it's applied. IaC is a key DevOps practice that's used with [continuous delivery](/devops/deliver/what-is-continuous-delivery).

DevSecOps shifts security left and shows that security isn't just about application security but infrastructure security as well. One of the ways DevSecOps supports infrastructure security is to include security scanning before the infrastructure deploys in the cloud. As infrastructure became code, you'd then apply the same security actions to the infrastructure as the application security. There are security tools available to run infrastructure security scanning based on your chosen IaC strategy.

With the adoption of the cloud, containerization is a popular approach that teams take in application architecture decisions. Some of the container repositories scan images to catch packages with known vulnerabilities. There's still a risk that a container might have out-of-date software. Because of this risk, it's vital to scan the container for security risks. There are plenty of open-source and commercial security tools that target this area and support tight integration in the CD process. The security tools help teams adopt DevSecOps for infrastructure as code and more specifically learn how to use containers.

## Go to production and operate

When the solution goes to production, it's vital to continue overseeing and managing the security state. At this stage in the process, it's time to focus on the cloud infrastructure and overall application.

### Configuration and infrastructure scanning

For visibility into cloud subscriptions and resource configuration across multiple subscriptions, use the [Azure tenant security solution](https://github.com/azsk/AzTS-docs) from the AzSK team.

Azure includes monitoring and security capabilities. These capabilities detect and alert any anomalous events or configurations that require investigation and potential remediation. Technologies such as [Microsoft Defender for Cloud](/azure/security-center/azure-defender) and [Microsoft Sentinel](https://techcommunity.microsoft.com/t5/azure-sentinel/become-an-azure-sentinel-ninja-the-complete-level-400-training/ba-p/1246310) are first-party tools that natively integrate into the Azure environments. These technologies complement the environment and code security tools. And the technologies provide thorough security monitoring so organizations can experiment and innovate quickly and securely.

### Penetration testing

Penetration testing is a recommended practice to check for any vulnerabilities in the infrastructure or application configuration, which might create weaknesses that attackers can exploit.

Many products and partners offer penetration testing services. Microsoft provides guidance for [penetration testing in Azure](/azure/security/fundamentals/pen-testing).

Testing typically covers the following test types:

- Tests on your endpoints to uncover vulnerabilities
- Fuzz testing (finding program errors by supplying malformed input data) of your endpoints
- Port scanning of your endpoints

### Actionable intelligence

The tools and techniques in this guidance offer a holistic security model for organizations who want to move at pace and experiment with new technologies that aim to drive innovation. A key element of DevSecOps is data-driven, event-driven processes. These processes help teams identify, evaluate, and respond to potential risks. Many organizations choose to integrate alerts and usage data into their IT service management (ITSM) platform. The team can then bring the same structured workflow to security events that they use for other incidents and requests.

### Feedback loops

:::image type="content" source="./media/continuous-security.png" alt-text="Screenshot showing the Continuous security model." lightbox="./media/continuous-security.png":::

All these techniques and tools empower teams to find and flag risks and vulnerabilities that require investigation and potential resolution. Operations teams who receive an alert, or discover a potential issue when they investigate a support ticket, need a route back to the development team to flag items for review. A smooth, collaborative, feedback loop is vital to address issues quickly and minimize the risk of a vulnerability as much as possible. 

A common pattern for feedback is to integrate it into a developer work management system, such as Azure DevOps or GitHub. An organization can link alerts or incidents to work items for developers to plan and action. This process provides an effective way for developers to resolve issues within their standard workflow, including development, testing, and release.
