---
on:
  workflow_dispatch:
    inputs:
      folder:
        description: "Folder under docs/ to review (e.g. govern, migrate). Leave empty for auto-rotation."
        required: false
        default: ""
  schedule: weekly on friday

engine: copilot

imports:
  - .github/agents/docs-reviewer.agent.md

safe-outputs:
  create-pull-request:

tools:
  edit:
  github:

mcp-servers:
  microsoftdocs:
    url: "https://learn.microsoft.com/api/mcp"
    allowed: ["*"]

network:
  allowed:
    - defaults
    - "learn.microsoft.com"

steps:
  - name: Determine folder
    id: folder
    run: |
      FOLDERS=(ai-agents antipatterns cloud-native context data get-started govern manage migrate modernize organize plan ready resources scenarios secure strategy)
      INPUT="${{ inputs.folder }}"
      if [ -n "$INPUT" ]; then
        FOLDER="$INPUT"
      else
        WEEK=$(date +%W)
        INDEX=$(( WEEK % ${#FOLDERS[@]} ))
        FOLDER="${FOLDERS[$INDEX]}"
      fi
      if [ ! -d "docs/$FOLDER" ]; then
        echo "::error::Folder docs/$FOLDER does not exist"
        exit 1
      fi
      echo "name=$FOLDER" >> "$GITHUB_OUTPUT"

  - name: Preprocess
    env:
      FOLDER: ${{ steps.folder.outputs.name }}
    run: |
      echo "Running deterministic fixes on docs/$FOLDER/**/*.md ..."

      # Smart/curly quotes → straight quotes
      # Invisible chars (ZWS, BOM, LTR/RTL marks) → removed
      # Non-breaking spaces → regular spaces
      find "docs/$FOLDER" -name '*.md' -print0 | xargs -0 --no-run-if-empty \
        perl -i -CSD -pe '
          s/[\x{201c}\x{201d}]/"/g;
          s/[\x{2018}\x{2019}]/'"'"'/g;
          s/[\x{200b}\x{200e}\x{200f}\x{feff}]//g;
          s/\x{a0}/ /g;
        '

      # Alert syntax: > **Note:** text → > [!NOTE]\n> text
      find "docs/$FOLDER" -name '*.md' -print0 | xargs -0 --no-run-if-empty \
        perl -i -CSD -pe \
          's/^(>\s*)\*\*(Note|Tip|Important|Caution|Warning)\s*[:.]\s*\*\*/sprintf("%s[!%s]",$1,uc($2))/ei'

      # Strip /en-us/ (or other locale) prefix from relative Markdown links
      find "docs/$FOLDER" -name '*.md' -print0 | xargs -0 --no-run-if-empty \
        perl -i -CSD -pe \
          's{\(/[a-z]{2}(?:-[a-z]{2,4})?(/(?:azure|entra|security|defender|intune|training|cli|powershell|mem|windows-server|purview|microsoft-365|dotnet|graph|rest)/)}{($1}gi'

      # Absolute learn.microsoft.com URLs → relative (also strips locale)
      find "docs/$FOLDER" -name '*.md' -print0 | xargs -0 --no-run-if-empty \
        perl -i -CSD -pe \
          's{\(https?://learn\.microsoft\.com(?:/[a-z]{2}(?:-[a-z]{2,4})?)?(/[^)]+)\)}{($1)}g'

      echo "Preprocessing complete."

---

# Weekly Docs Review

Review and fix Markdown documentation files in the Cloud Adoption Framework repository.

## Context

This is the MicrosoftDocs/cloud-adoption-framework-pr repository. It contains Markdown (.md) files under `docs/` organized in subfolders by topic area.

**Important:** A preprocessing step has already run on the target folder before you start. It already fixed: smart/curly quotes → straight quotes, invisible Unicode characters, non-breaking spaces, alert syntax (`> **Note:**` → `> [!NOTE]`), locale prefixes in links, and absolute learn.microsoft.com URLs → relative paths. Do NOT re-fix these issues — they are already handled. Focus your review on everything else.

## Folder Selection

The target folder has been determined by the preprocessing step. If a `folder` input was provided via workflow dispatch, that folder is used. Otherwise, the weekly rotation below was applied:

If no input was provided (scheduled run), pick ONE folder from this rotation based on the current week number (week mod 17):

| Week mod 17 | Folder |
|---|---|
| 0 | ai-agents |
| 1 | antipatterns |
| 2 | cloud-native |
| 3 | context |
| 4 | data |
| 5 | get-started |
| 6 | govern |
| 7 | manage |
| 8 | migrate |
| 9 | modernize |
| 10 | organize |
| 11 | plan |
| 12 | ready |
| 13 | resources |
| 14 | scenarios |
| 15 | secure |
| 16 | strategy |

## Workflow (follow this exact order)

### Pass 1 — Typos and grammar

Read every `.md` file in the selected `docs/<folder>/` directory and its subdirectories. For each file:

1. **Fix typos** — spelling errors, contextual typos, homophones, subject-verb agreement mistakes
2. **Fix grammar** — compound-adjective hyphens, missing articles, preposition errors

Scan EVERY sentence. Do not stop after finding a few issues.

### Pass 2 — Punctuation, formatting, word choice, headings

Re-read each file. For each file:

1. **Fix punctuation** — Oxford commas, em dashes, sentence-ending punctuation, remove filler words
2. **Fix formatting** — add language tags to bare code fences, fix table formatting
3. **Fix word choice** — use "select" instead of "click on", use contractions where natural, prefer "by using" over "using" at the start of a phrase
4. **Fix headings** — sentence case for all headings (capitalize only the first word and proper nouns)

### Pass 3 — Self-review (quality gate)

Re-read every file you changed. For each change, verify:

- Did you change the **meaning** of the text? → Revert it.
- Did you touch a **URL**, **code block**, or **YAML front matter**? → Revert it.
- Did you break **Markdown formatting**? → Fix it.
- Did you **rewrite a sentence** instead of making a minimal fix? → Revert to minimal.

## Rules (CRITICAL — violations will require rework)

- Edit ONLY `.md` files inside the selected `docs/<folder>/` directory
- Do NOT edit YAML front matter (the `---` block at the top of each file)
- Do NOT change meaning, add content, or restructure sections
- Do NOT modify URLs, code blocks, or backtick-wrapped text
- Make MINIMAL changes — fix the specific word or phrase, not the whole sentence
- Skip any file or fix you are unsure about

## PR Description

In the pull request you create, include:

- Summary of changes grouped by category (typos, grammar, punctuation, formatting, word choice, heading case)
- Count of files changed and approximate number of fixes per category
- Any files you skipped and why
- The folder that was reviewed
