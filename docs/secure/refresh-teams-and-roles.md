---
title: Security teams, roles, and functions
description: Learn how to build a security team and thier roles.
author: claytonsiemens77
ms.author: csiemens
ms.date: 06/24/2024
ms.topic: conceptual
ms.custom: internal, UpdateFrequency2
---
# Security teams, roles, and functions

## Introduction

This article describes teams and roles involved in cloud security, and the functions they perform. Many security functions are performed by specialized teams and roles that operate alongside other technology functions, ensuring that security is part of every aspect of the cloud estate. Depending on the size of your organization, some roles and functions discussed in this article may be covered by consolidated teams rather than having a one-to-one relationship between roles and teams. Enterprise and large organizations tend to have more granularity with teams and roles, whereas smaller organizations tend to consolidate multiple roles and functions between a smaller set of teams, or even individuals. Regardless of the size or your organization, it is imperative that stakeholders agree on business requirements that will help determine the roles and functions that need to be covered and the amount of resources needed to fill those roles. Use the following guidance to help understand specific functions that teams and roles perform and how different teams interact to cover the entirety of a cloud security organization.

## Overview of roles and teams

The following section provides examples of typical teams and individual roles and the functions that they typically perform. Your particular team may be organized differently, with different nomenclature, but in order to oeprate securely in the cloud, ensure that you map out your existing teams to the functions listed below and look for gaps in your operational coverage.

**Chief Information Security Officer (CISO):**

The CISO is typically the overall technology leader of a business or business unit. While this role is typically removed from day-to-day operations, they need to stay connected to the rest of the security organziation to ensure that everyone is aligned on strategies and teams are adhering to the business standards. The CISO functions include:

- Oversees the overall security strategy and ensures alignment with business goals.
- Establishes security policies, standards, and frameworks.
- Manages the security budget and communicates security initiatives to senior leadership.

**Cloud security architecture and engineering team:**

This team is responsible for turning the strategies and standards approved by senior leadership into actionable solutions and design patterns. They may also act as mentors to the teams below them to teach best practices. Their functions include:

- Designs and implements cloud security architecture and solutions.
- Defines security policies, standards, and guidelines for cloud environments.
- Conducts security assessments and reviews of cloud deployments.
- Collaborates with development and infrastructure teams to ensure secure cloud configurations.

**Security operations:**

This team is commonly referred to as a Security Operations Center (SOC), and is normally organized in multiple tiers. The SOC team serves as the frontline defense against cyber threats, ensuring the organization's systems, data, and operations remain secure and resilient against evolving cybersecurity challenges.

- *Tier I*
    -  Triage specialists who collect raw data and review alarms & alerts.
    - They determine criticality of alerts and enrich it with relevant data to properly classify incidents and identify false positives, escalating issues to Tier II teams when appropriate.
    - Responsible for management and configuration of monitoring tools.
    - Continuously monitor the organization's network, endpoints, servers, and other digital assets for security threats.

- *Tier II* 
    - Primary incident response team.
    - They conduct in-depth analysis with threat intelligence for incidents escalated from Tier I.
    - They design and enforce strategies to contain and recover from incidents.
    - Escalate issues to Tier III when appropriate.
- *Tier III*
    - Experienced personnel in SOC who handle escalations from Tier II.
    - Automate repetitive security tasks and orchestrate incident response processes.
    - Provides timely and accurate reports on security incidents, trends, and performance metrics to senior management and stakeholders.

The following functions may be performed by Tier II or Tier III, or they are sometimes filled by standalone teams:

- *Threat intelligence* - Gather and analyze threat intelligence to identify emerging threats and vulnerabilities.
- *Threat hunting* - Proactively search for hidden threats within the network that have evaded standard detection mechanisms, using advanced analytics and hypotheses-driven investigations.

**Risk management:**

Risk management is a specialized role requiring training on security risks and mitigation strategies for technology in general, but also with a focus on the business's industry.

- Identifies, assesses, and mitigates security risks, implements risk management processes.
- Managing security risk registers.
- Sometimes they are combined with Compliance and Governance teams.

**Vulnerability management:**

- Identify and prioritize vulnerabilities within the organization’s systems and networks, by conducting regular vulnerability scans, assessing risk levels, and recommending remediation actions.
- Some organisations have this integrated into the SOC team functions.

**Cloud security:**

- Securing cloud infrastructure and services.
- Implementing cloud-specific security controls.
- Ensuring compliance with cloud security standards.

**Data security:**

- Protecting data at rest and in transit.
- Implementing encryption and data loss prevention (DLP) solutions.
- Managing data access policies.

**Network security:**

- Securing network infrastructure.
- Implementing firewalls, VPNs, and IDS/IPS.
- Managing network segmentation and traffic monitoring.

**Application security:**

- Securing application development and deployment.
- Performing code reviews and security testing.
- Integrating security into the software development lifecycle (SDLC).

**Identity and access management (IAM):**

- Manages user identities and access permissions across cloud services.
- Implements multi-factor authentication (MFA) and single sign-on (SSO) solutions.
- Ensures adherence to least privilege access principles.
- Reviews and audits access logs and permissions.
- May sometimes be part of the larger cloud security team if resources are limited

**Compliance and governance:**

- Ensures compliance with regulatory requirements and internal policies
- Conducts audits
- May work closely with Risk Management team or be integrated into a broader IT governance team.

**Training and awareness:**

- Provides security training and awareness programs for employees.
- Document secure standards for employees to follow to protect corporate (and personal) digital assets.
- They may work with Compliance and Risk Management teams to promote a security-conscious culture and mitigate risks.
- Sometimes, this is managed by HR or IT Dept with inputs from the security professionals.

**DevSecOps:**

- Integrates security practices into the DevOps pipeline, ensures secure software development.
- Sometimes, this is part of the development or IT operations team with Security oversight.

**Vendor and third-party risk management:**

- Manages risks associated with third-party vendors and partners.
- Ensures third-party compliance with security policies.

## Example scenario: Typical interoperability between teams

When an organization deploys and operationalizes a Web Application Firewall (WAF), several security teams must collaborate to ensure its effective deployment, management, and integration into the existing security infrastructure. Here’s how the interoperability among the teams might look in an enterprise security organization:

1. **Planning and design**
    1. The *CISO* identifies the need for enhanced web application security and allocates budget for a WAF.
    1. The *Cloud Security Architect* designs the WAF deployment strategy, ensuring it integrates seamlessly with existing security controls and aligns with the organization's security architecture.
1. **Implementation**
    1. The *Cloud Security Engineer* deploys the WAF according to the architect’s design, configuring it to protect the specific web applications.
    1. The *IAM Specialist* sets up access controls, ensuring only authorized personnel can manage the WAF.
1. **Monitoring and management**
    1. The *SOC Analyst* configures monitoring tools to receive alerts from the WAF and sets up dashboards to track WAF activity.
    1. The *Incident Response Team* develops response plans for incidents involving the WAF and conducts simulations to test these plans.
1. **Compliance and risk management**
    1. The *Compliance and Risk Management Officer* reviews the WAF deployment to ensure it meets regulatory requirements and conducts periodic audits.
    1. The *DPO* ensures that the WAF's logging and data protection measures comply with data privacy regulations.
1. **Continuous improvement and training**
    1. The *DevSecOps Engineer* integrates WAF management into the CI/CD pipeline, ensuring that updates and configurations are automated and consistent.
    1. The *Security Awareness and Training Specialist* develops and delivers training programs to ensure that all relevant personnel understand how to use and manage the WAF effectively.
    1. The *Cloud Governance team member* reviews the WAF deployment and management processes to ensure they align with organizational policies and standards
    
By collaborating effectively, these roles ensure that the WAF is not only deployed correctly but also continuously monitored, managed, and improved to protect the organization's web applications from evolving threats.

## Resources

Video outlining ‘Roles and Responsibilities’: https://learn.microsoft.com/en-us/security/adoption/the-ciso-workshop-videos#roles--responsibilities

Security Adoption Framework: https://learn.microsoft.com/en-us/security/adoption/the-ciso-workshop
