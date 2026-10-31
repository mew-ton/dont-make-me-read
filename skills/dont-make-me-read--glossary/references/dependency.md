# Dependency

Instances of what is a dependency and what is not, and of the ways a dependency is named by
something other than an address.

- Dependencies: a doc comment that cites a decision, on the decision; a README sentence that gives
  the retry limit, on `config/retry.json`; a test body, on the set-up it uses; a name, on the body
  it summarises.
- Not dependencies: a sentence using "timeout" as everyone uses it, unless the project defines the
  word; two functions that happen to look alike, when a change to one does not mean checking the
  other.

## Named by something other than an address

In prose, a dependency named by:

- a position: "see above", "below", "the previous section".
- a past only its participants hold: "as discussed", "we originally went with", "not A but B".
- the conversation that produced the text, which its reader was not in: "as requested", "you
  said", an instruction with nothing in front of it.
- a role: "the config", "the usual way", "same as the other one".
- nothing: a count, a name or a definition copied from the file that owns it, without naming that
  file; a sentence that only means something with another file open.
- an address its readers cannot open: a chat session, a private channel, a file on the writer's
  disk.

In a program, a dependency named by:

- nothing a caller reads: state the body uses and the signature does not declare, a global, an
  environment variable, module state.
- nothing at all: an interface satisfied structurally, with nothing in the implementation saying
  so.
