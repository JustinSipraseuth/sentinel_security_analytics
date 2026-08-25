# Sentinel Security Analytics — Analyst Roadmap

> **Canonical ticket sequence for the Sentinel simulation.**
>
> Future Sentinel chats should consult this roadmap before creating or substituting tickets. Do not improvise a different DET-### assignment unless the roadmap is intentionally revised.

## Purpose

This roadmap is designed to maximize practical SQL growth while simulating realistic data-analyst work: understanding unfamiliar data, investigating ambiguity, extracting defensible insights, and translating findings into business and operational decisions.

The user should receive business problems, not prescribed SQL techniques. SQL methods should be chosen by the analyst unless help or hints are explicitly requested.

GitHub is the source of truth for canonical Sentinel work state. Chat is used for coaching, simulation, review, and interpretation.

---

## Release 1 — Authentication Analytics

### DET-002 — Release 1 Data Acceptance & Onboarding
**Goal:** Load the provided Release 1 dataset into PostgreSQL, understand the data dictionary and table grain, and perform basic acceptance checks before analysis begins.

**Analyst growth:**
- dataset onboarding
- row/grain awareness
- referential-integrity thinking
- null/missing-data awareness
- basic validation SQL

**Important:** The analyst does not generate the Release 1 dataset. Dataset design/generation is simulation infrastructure.

---

### DET-003 — Customer Authentication Health Baseline
**Goal:** Compare customer organizations fairly and determine which appear to have concerning authentication health, without relying on raw failure counts alone.

**Analyst growth:**
- aggregation
- rates and denominators
- fair comparisons
- business prioritization
- caveats and communication

---

### DET-004 — Application Access Friction
**Goal:** Determine which applications generate authentication problems, whether issues are widespread or customer-specific, and what deserves follow-up.

**Analyst growth:**
- joins
- grouped comparisons
- segmentation
- concentration vs broad impact
- stakeholder recommendations

---

### DET-005 — Authentication Method Performance
**Goal:** Evaluate how authentication methods behave and identify methods associated with disproportionate failure or friction.

**Analyst growth:**
- conditional aggregation
- comparative metrics
- normalization
- interpretation vs causation

---

### DET-006 — Device Trust & Authentication Outcomes
**Goal:** Investigate managed, unmanaged, and unknown-device contexts and determine whether device context materially changes authentication outcomes.

**Analyst growth:**
- multi-table joins
- NULL handling
- categorical analysis
- operational interpretation

---

### DET-007 — Authentication Failure Spike Investigation
**Goal:** Find and explain unusual time periods without being told where the anomaly is. Establish a baseline, isolate deviations, and drill into contributors.

**Analyst growth:**
- date/time SQL
- baselines
- trend analysis
- windows where useful
- iterative investigation

---

### DET-008 — Suspicious IP Investigation
**Goal:** Investigate IP behavior and determine whether activity is ordinary shared-IP noise or something deserving SOC escalation.

**Analyst growth:**
- distinct counts
- cross-user patterns
- time/frequency analysis
- security-oriented reasoning
- escalation judgment

---

### DET-009 — Account-Level Authentication Investigation
**Goal:** Investigate suspicious user behavior across sequences of authentication events instead of treating rows independently.

**Analyst growth:**
- event sequencing
- window functions
- LAG/LEAD when appropriate
- behavioral context
- hypothesis testing

---

### DET-010 — Inactive Account Activity Review
**Goal:** Determine whether authentication activity involving inactive accounts is explainable, concerning, or unsupported by the available evidence.

**Analyst growth:**
- exception analysis
- joins and filters
- careful interpretation
- distinguishing evidence from inference

---

### DET-011 — Telemetry Completeness Review
**Goal:** Measure missing device/application context and determine whether missingness materially weakens analytics or security conclusions.

**Analyst growth:**
- data-quality SQL
- missingness analysis
- impact assessment
- practical recommendations

---

### DET-012 — SOC Workload Prioritization
**Goal:** Determine which customers, users, applications, or failure patterns account for most operational burden and recommend where the SOC should focus.

**Analyst growth:**
- ranking
- cumulative contribution
- Pareto-style analysis
- prioritization
- operational decision support

---

### DET-013 — Customer Authentication Risk Scorecard
**Goal:** Combine multiple defensible metrics into a customer-prioritization model and document assumptions behind the scoring approach.

**Analyst growth:**
- metric design
- CTE-style decomposition
- weighting/normalization decisions
- sensitivity to assumptions
- business communication

---

### DET-014 — Detection Candidate Evaluation
**Goal:** Work with Priya to turn a discovered authentication pattern into a possible detection rule and estimate usefulness/noise.

**Analyst growth:**
- translating analysis into detection logic
- false-positive/false-negative thinking
- threshold evaluation
- operational trade-offs

---

### DET-015 — Customer Authentication Health Brief
**Goal:** Produce a customer-facing interpretation of authentication health that is accurate, contextualized, and safe to communicate.

**Analyst growth:**
- executive/customer communication
- explainability
- trust and caveats
- translating technical findings

---

## Release 2 — Alerts, Incidents, and SOC Operations

### DET-016 — Release 2 Warehouse Onboarding
**Goal:** Learn new alert/incident tables and establish their grains and relationships before analysis.

**Analyst growth:**
- complex schema onboarding
- many-to-many relationships
- grain validation
- join-risk awareness

---

### DET-017 — Alert Category Quality Review
**Goal:** Compare alert categories by volume, incident significance, and operational usefulness rather than assuming high volume means high value.

**Analyst growth:**
- multi-metric comparisons
- rates vs counts
- business significance
- prioritization

---

### DET-018 — Incident Composition Investigation
**Goal:** Determine how alerts contribute to incidents and investigate the implications of many-to-many relationships.

**Analyst growth:**
- bridge/junction tables
- duplicate-count prevention
- distinct-entity analysis
- incident-level reasoning

---

### DET-019 — Detection Noise & Escalation Analysis
**Goal:** Identify detection behaviors that create analyst workload without corresponding operational value.

**Analyst growth:**
- effectiveness metrics
- false-positive/noise reasoning
- workload trade-offs
- recommendation quality

---

### DET-020 — SOC Response / SLA Analysis
**Goal:** Analyze operational timing, queues, and service performance and make process or staffing recommendations.

**Analyst growth:**
- time-to-event analysis
- percentiles/aggregates
- SLA thinking
- operational analytics

---

### DET-021 — Capstone Investigation
**Goal:** Receive a deliberately ambiguous stakeholder request, investigate freely across the warehouse, decide what matters, and present an executive recommendation.

**Analyst growth:**
- end-to-end investigation
- SQL technique selection
- ambiguity management
- hypothesis refinement
- business decision support
- executive communication

---

## Reviewer Lenses

Use reviewers only when relevant to the work.

- **Ethan Brooks — Senior Data Analyst:** SQL correctness, data modeling, grain, constraints, readability, maintainability, performance, and production trade-offs.
- **Priya Patel — Detection Engineer:** detection logic, alert usefulness, false positives/negatives, and technical security assumptions.
- **Maya Chen — Detection Analytics Manager:** business question, ambiguity, assumptions, prioritization, communication, and decision support.
- **Carlos Ramirez — SOC Manager:** operational usefulness, urgency, actionability, analyst workload, and shift/incident usefulness.
- **Ava Kim — Customer Success:** customer impact, explainability, trust, account context, and safe customer communication.

---

## Simulation Rules

1. Do not prescribe SQL functions, clauses, or solution patterns unless the analyst asks for help or a technique-specific exercise.
2. Let the analyst investigate and choose methods.
3. Some tickets may legitimately conclude that the available data does not support the stakeholder's claim.
4. Use realistic ambiguity, messy data, and imperfect information without making the environment incoherent.
5. GitHub holds canonical ticket/work state; do not rely on chat memory alone for exact DET-### assignments.
6. Infrastructure work should support analyst practice, not replace it.
7. Before introducing a new ticket, verify the current ticket is complete and consult this roadmap.
