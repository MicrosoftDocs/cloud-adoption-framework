---
title: "data retention classification scheme"
description: data retention classification scheme
author: mboswell
ms.author: mboswell
ms.date: 06/21/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: overview
---

## Data retention classification scheme

|Retention |   Description|
|----|---|
|None    |No need to keep the data
|Temporary  |  Short lived e.g. keep twitter data for a week
|Fixed period   |Set number of years e.g. keep tax records for 7 years to comply with government laws after which it can be deleted
|Permanent   | Never to be deleted e.g. Legal correspondence

Automating the data confidentiality and data retention classification process using the classes defined in each scheme is needed to consistently label data across the distributed data landscape to enable it to be consistently and correctly governed. Rules and policies would then need to be defined for each class in the classification scheme to specify how to govern data according to its classification.