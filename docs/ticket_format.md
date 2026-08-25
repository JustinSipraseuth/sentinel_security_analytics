# Sentinel Security Analytics — Ticket Format

This document defines the standard GitHub Issue body format for Sentinel DET-### analyst tickets.

Use this structure for new tickets unless a ticket genuinely requires additional sections. Keep the issue concise enough to feel like a realistic workplace assignment rather than a tutorial.

## Standard Issue Body

```markdown
**Manager:** [Name — Role]
**Objective:** [One-sentence description of the business or operational goal.]
**Status:** [Open / Ongoing / Blocked / Complete]

**Tasks:**
- [Task or expectation 1]
- [Task or expectation 2]
- [Task or expectation 3]

**Deliverable:** [What the stakeholder expects back from the analyst.]

**Context:** [Only the background information the analyst would reasonably receive or need to begin.]
```

## Ticket-writing rules

1. **State the business problem, not the SQL solution.** Do not prescribe functions, clauses, joins, window functions, CTEs, or other implementation techniques unless the stakeholder realistically requires a specific method.
2. **Do not reveal the intended insight.** The analyst should investigate the data and determine what matters.
3. **Keep ambiguity realistic.** Stakeholders may leave terms such as “unusual,” “high,” or “concerning” undefined when interpretation is part of the analyst's job.
4. **Include enough context to begin.** Ambiguity should create analytical judgment, not make the ticket impossible to understand.
5. **Make the deliverable explicit.** The analyst should know whether the expected output is SQL, a written recommendation, a validation result, a customer-facing brief, or another artifact.
6. **Use the canonical roadmap.** Before creating a DET-### issue, consult `docs/sentinel_analyst_roadmap.md` and do not substitute a different assignment unless the roadmap is intentionally revised.
7. **GitHub is the source of truth.** The GitHub Issue body is the canonical statement of the active assignment; chat may clarify or roleplay discussion but should not silently redefine the ticket.

## Example — DET-002

```markdown
**Manager:** Maya Chen — Detection Analytics Manager
**Objective:** Load and validate the Release 1 authentication dataset before analyst investigations begin.
**Status:** Ongoing

**Tasks:**
- Load organizations, users, devices, and authentication_events into PostgreSQL.
- Review the Release 1 dataset guide/data dictionary.
- Validate basic dataset shape, including row counts, date coverage, distinct entities, and important NULLs.
- Perform basic relationship/integrity checks and flag anything that appears inconsistent.

**Deliverable:** Brief confirmation that the dataset is loaded and understood, with any data-quality concerns identified.

**Context:** Dataset generation is simulation infrastructure and is already complete. DET-002 is the analyst onboarding/acceptance step before DET-003 analysis begins.
```
