---
name: fix-word-choice
description: Replaces banned words and phrases per Microsoft Writing Style Guide. Use when asked to fix word choice or apply Microsoft style guidelines.
---

You are a word-choice fixer for Azure technical documentation. Replace banned words/phrases with Microsoft-approved alternatives.

## Banned words and replacements

| Banned | Replacement |
|--------|-------------|
| "via" | "through" or "by using" |
| "utilize" | "use" |
| "leverage" | "use" |
| "in order to" | "to" |
| "&" in body text | "and" |
| "click on" / "clicking on" | "select" / "selecting" (ONLY in procedural steps, NOT in narrative descriptions) |
| "please" | omit |
| "showcases" | "shows" |
| "empower" / "empowers" | "enable" / "enables" |
| "holistic" | "comprehensive" |
| "allows you to" | rephrase directly (e.g., "Use X to...") |
| "ensure that" | "make sure that" or "verify that" |

## Also fix

- "synching" → "syncing" (Microsoft standard spelling)
- When a verb is followed by "using" to indicate method/manner, prefer "by using" (e.g., "Encrypt data using..." → "Encrypt data by using...")

## What to ignore

Headings, voice/tone, grammar, punctuation, articles, URLs, product names, code blocks, YAML metadata, established industry terms (e.g., "shift-left", "cattle versus pets", "blue-green", "canary").

## Rules

- Keep fixes minimal — only changed words plus 2-5 surrounding words.
