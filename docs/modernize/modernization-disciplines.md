---
title: 'Modernization disciplines'
description: TODO
author: BrianBlanchard
ms.author: brblanch
ms.date: 03/28/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: general
ms.custom: internal
---
<!--Slide 45-->
# Modernization disciplines

Some of these are going to map easily, like faster time to market if that's our goal. To keep building, keep launching new code bases. We probably want to increase the capabilities for application platform to minimize how much developers have to do to bring a production thing to market so faster time to market often maps to app platforms. Not always, and we want to talk to our customer that the things I'm about to say or generalized and they may have their own rules. But, if you want faster time to market, you want that increased agility. That ability to go faster with new app plans.

## Application platforms

App innovation...maybe the application platform isn't enough and we need to talk about aligning your developers.

## Developer alignment

If your desired cost savings is bigger than the cost of modernization, let's align developers and see what our developers can do to optimize. This is another example where they may have different rules if they're already doing a lot of application platform motions. Maybe you stick these in that bucket and you get your cost savings through application platform improvements, but it be one of these two categories. Generally we see customers lean more towards developer alignment as a way to get there.

## Data platforms

Centralizing data

They group up loosely with the different disciplines = linking. It says in general, this is a discipline that would apply for your workloads in this bucket.



Others are going to be more complex, so the first one will allow analyze. Here are many of the workloads left in that cost, optimizing applications motivation. 

1. Does the cost of modernizing exceed the desired cost savings? 
2. And do you understand your break even point? 
3. And if when we're working through this with the customer, they say that, well, no,  

On the other hand, if they do well, it's going to take a lot of change to modernize and the cost savings aren't all that great. Then let's go ahead and just migrate this over and get it out of the out of the pool of things we want to move around or modernize.
If they don't know, this is another case where we want to run the well architected review and find out on a workload by workload basis. Should they modernize? Should they just migrate it up and just know that they'll have that ongoing high cost of operations?

Is this one example of what may end up going into one of the more complex evaluation states? Similarly with hybrid work. When we talk about hybrid work, that means that different things to different people. For the customer in this article we want to help them find out really quickly. Is it your workload that's hybrid and you need some degree of portability so that you can move it to Azure but later move it to on Prem later? Move it to GCP or a WS and you want that fluidity of where your workload lives? It's very commonplace for customers that are trying to modernize right now, or conversely, is it really your workers or hybrid and you just need new network routing paths to get those workers to that workload. So when we asked that question, if it's a hybrid or portable workload, this is very clearly a case of application platform.

They may also have consumed considerations for data portability, so they may need to modernize their data platform, but usually starts with that flat. 
If it is more the workers that are hybrid and not the workload, then this is a migration only type of context.

## Testing & architecture

If they get into it and they really don't know, they just know that this application needs some hybrid portability capabilities. This is another
example of we may want to run a well architected review 'cause now we're having to understand that individual workload by workload basis a little better.

The other way as we go through these questions while we're trying to get to is a slightly modified view of. Now that we've got our workloads in. Pockets we want our buckets aligned with the disciplines and the reason for this is we're trying to create a pattern where we're going to then prioritize the buckets and set up repeatable processes to get faster time to market by modernizing all of these workloads using a chaos or deploying all of these application innovation workloads through some developer alignment techniques that are repeatable, or centralizing your data by simply moving using the Azure migrate capabilities of moving from SQL Server to individual. SQL instances, but this is the
end state we want to get. At first we took a whole lot of individual parts and group them as workloads. 

We then align those workloads to business values. Now that we've got that bucket, we want to start to align each bucket to a discipline that's going to drive the outcome that you want.

