# Editorial Standard

This file governs future chapters and revisions. It is not part of the reader's path.

## The promise

The book explains systems mechanically. It does not ask the reader to trust a slogan, a product category, or the author's confidence.

Every chapter must make clear:

1. what the mechanism does;
2. which problem forced it to exist;
3. where its guarantee ends;
4. what it costs;
5. how a developer can observe or test the claim.

## Voice

Write like an engineer explaining a system to another engineer at a whiteboard.

- Start with the concrete problem or mechanism, not a ceremonial introduction.
- Prefer a precise noun and verb over abstract importance: “nodes execute the payload” beats “this plays a crucial role.”
- Use analogies to open a door, then return to the actual protocol.
- State the durable model first. Put historical exceptions and version-specific details after it.
- Do not manufacture excitement. Interesting machinery does not need adjectives such as *revolutionary*, *powerful*, or *game-changing*.
- Do not use filler such as “let us dive in,” “in today's rapidly evolving landscape,” “it is worth noting,” or a conclusion that merely repeats the introduction.
- Keep contractions and occasional blunt sentences when they improve rhythm. Uniformly polished prose sounds less human than clear prose with a point of view.

## Layer information by importance

A beginner should not have to hold the core rule and six caveats at the same visual level.

Use this order when a topic is dense:

1. **Core model:** the smallest correct idea worth remembering.
2. **Mechanism:** the parts and data flow.
3. **Failure boundary:** what the mechanism cannot guarantee.
4. **Production reality:** upgrades, operational dependencies, and current deployments.
5. **Deep dive:** history, edge cases, or cross-protocol differences.

Not every short note needs all five headings. They are a priority order, not a template.

## Code and evidence

Pseudocode is useful for a mental model. It is not a substitute for executable evidence.

- Use `text` fences for state transitions, invariants, and compact data flows.
- Use language-tagged fences only for code that is syntactically meaningful.
- A command must state its prerequisites and the network or environment it affects.
- Never place a real private key, API key, production address with authority, or secret-bearing command in the book.
- Labs must produce an artifact and include at least one failure or adversarial path.
- Pin dependency and protocol versions when reproducibility depends on them.

## Diagrams

Add a diagram when the reader must track actors, time, ownership, execution context, or several dependent branches.

Do not diagram a sentence merely to create visual variety. Use:

- sequence diagrams for messages and callbacks;
- flowcharts for state transitions and trust paths;
- timelines for fork choice and finality;
- tables for exact comparisons;
- plain formulas for arithmetic relationships.

Every diagram must still make sense in the surrounding prose if the renderer is unavailable.

## Sources

Protocol behavior and time-sensitive claims need primary sources.

Prefer, in order:

1. normative or executable specifications;
2. adopted EIPs, BIPs, standards, and official documentation;
3. client code or release notes;
4. original incident reports and postmortems;
5. high-quality secondary analysis when no primary source answers the question.

Do not attach a source to decorate a paragraph. The linked document must support the nearby claim.

Use a short final section:

```markdown
## Primary sources

- [Descriptive title](https://example.com) — what this source establishes.
```

Add `Last verified: YYYY-MM-DD` near the sources when a chapter describes a current deployment, roadmap, law, product, fee market, or governance state. Timeless cryptographic definitions do not need a freshness label.

## Check yourself

Questions should test the boundary of the model, not vocabulary alone.

A strong set usually contains:

- one reconstruction question;
- one comparison or counterexample;
- one failure scenario;
- one question asking what the mechanism does **not** prove.

Core Path chapters need answers, either inline under `<details>` or in an answer key. An answer should explain the reasoning, not repeat a sentence from the chapter.

## Review before release

- Can the opening claim survive without marketing language?
- Is the core model visible before its exceptions?
- Are protocol layers and trust boundaries named precisely?
- Does every current claim have a date and primary source?
- Do links resolve from the file that contains them?
- Does every Mermaid block render?
- Can every executable example run from a clean environment?
- Do the questions expose misunderstanding rather than reward memorization?
- Did the chapter add a new idea, or merely restate another note?
