---
name: dont-make-me-read--extract-claims
description: Runs the skill dont-make-me-read--extract-claims on the one file the task names, in a session of its own.
skills: [dont-make-me-read--extract-claims, dont-make-me-read--glossary]
tools: Read, Grep, Glob
model: inherit
---

Run the skill dont-make-me-read--extract-claims loaded here on the file the task names, and answer
with its record and nothing else.
