# Revising an existing draft

Read this when the issue already exists — a draft of your own, or someone else's issue you are
tightening. Revising is a different pass from drafting: instead of deciding what to write, you are
hunting for what the draft already contains that should not be there, which is why it has its own
order. Work the steps in sequence.

1. Test each Background sentence: does the issue's necessity fail to hold without it? Delete what
   passes. For what remains, check the subject is a domain entity (flag `#\d+` or "this task" as
   subject — the scope statement is the one exception; a path naming the document or code itself
   is fine)
2. Check how many kinds of problem the remaining bullets sort into. More than one kind: split into
   one heading per problem, with a one-sentence opening reason. Can't write that sentence? Split
   into separate issues instead
3. Apply Gate 1: find implementation-method statements and drop the ones that depend on the
   codebase's current structure. Move only issue-external constraints to Acceptance criteria, with
   their grounds written into Background as a problem
4. Strip internal field names and schema vocabulary out of Acceptance criteria; replace with domain
   vocabulary
5. For each Acceptance criteria item, confirm Background states the problem it resolves. An item
   with no corresponding problem asks the implementer to do work with no stated reason
6. Check Affected areas' parentheticals for "what to do" language — including a future-placement
   note — and drop it or replace it with "what is there"
7. Apply Gate 2: drop a section wherever its content already has a destination; compress any
   paragraph whose later sentences only restate its first
8. Check whether Goal restates Acceptance criteria; if so, replace it with a pointer to what to
   conform to
9. Check that Goal covers every Acceptance criteria item. An item Goal doesn't reach is a second
   problem bundled into this issue — split it out
10. Check the draft is in one language — the one this repository's issues already use — with no
    second-language restatement of the same content (Gate 2)
