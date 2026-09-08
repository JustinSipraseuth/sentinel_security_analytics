# Sentinel Security Analytics — Analyst Roadmap

> **Canonical ticket sequence for the Sentinel simulation.**
>
> Future Sentinel chats should consult this roadmap before creating or substituting tickets. Do not improvise a different DET-### assignment unless the roadmap is intentionally revised.

## Purpose

This roadmap is designed to maximize practical SQL growth while simulating realistic data-analyst work: understanding unfamiliar data, investigating ambiguity, extracting defensible insights, and translating findings into business and operational decisions.

The user should receive business problems, not prescribed SQL techniques. SQL methods should be chosen by the analyst unless help or hints are explicitly requested.

GitHub is the source of truth for canonical Sentinel work state. Chat is used for coaching, simulation, review, and interpretation.

## Research basis for the skill progression

The roadmap emphasizes skills that are directly relevant to analytics and, where possible, security analytics:

- The NIST NICE Framework describes **Data Analysis** as analyzing data from multiple disparate sources to provide cybersecurity and privacy insight.
- Microsoft Sentinel guidance treats filtering, summarizing, joining, baselining, anomaly identification, incident investigation, and suspicious-activity monitoring as routine security-analytics tasks.
- Microsoft Sentinel sample queries explicitly use aggregations, distinct counts, time windows, baselines, historical comparisons, and anomaly detection across sign-in, audit, network, and process telemetry.

These sources support keeping the roadmap centered on data validation, joins, aggregation, segmentation, baselines, anomaly investigation, event sequencing, data quality, prioritization, detection evaluation, and defensible communication.

References:
- NIST NICE Framework Work Role Videos: https://www.nist.gov/itl/applied-cybersecurity/nice/nice-framework-work-role-videos
- Microsoft Learn — Common Tasks With KQL for Microsoft Sentinel: https://learn.microsoft.com/en-us/kusto/query/tutorials/common-tasks-microsoft-sentinel?view=microsoft-sentinel
- Microsoft Learn — Sample KQL Queries for Microsoft Sentinel Data Lake: https://learn.microsoft.com/en-us/azure/sentinel/datalake/kql-sample-queries

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

**Scope guardrail:** Do not force a new anomaly if the application-level signal mainly reflects behavior already discovered in DET-003. A valid conclusion may be that application segmentation adds limited new information.

---

### DET-005 — Authentication Method & Outcome Coverage Review
**Goal:** Evaluate whether authentication method is a useful analytical segment in Release 1. Compare known outcomes across methods, examine missing/unknown outcomes, and determine whether the data actually supports claims that one method performs materially differently from another.

**Analyst growth:**
- conditional aggregation
- comparative metrics
- normalization
- missing-data interpretation
- testing whether a segmentation variable is genuinely informative
- distinguishing evidence from causation
- writing a defensible negative or inconclusive finding

**Scope guardrail:** The Release 1 method distribution is relatively homogeneous. Do not manufacture a method-performance story if the observed differences are weak.

---

### DET-006 — Device Context & Authentication Outcomes
**Goal:** Investigate managed, unmanaged, and unknown-device contexts and test whether device context materially changes authentication outcomes. The ticket should ask whether a relationship exists rather than assume one exists.

**Analyst growth:**
- multi-table joins
- NULL handling
- categorical analysis
- segmentation and confounding awareness
- operational interpretation
- rejecting unsupported hypotheses

**Scope guardrail:** Treat device-management status as an observed association, not a causal explanation. If differences are weak or confounded, that is an acceptable conclusion.

---

### DET-007 — Authentication Failure Spike Investigation
**Goal:** Find and explain unusual time periods without being told where the anomaly is. Establish a baseline, isolate deviations, and drill into contributors.

**Analyst growth:**
- date/time SQL
- baselines
- trend analysis
- windows where useful
- iterative investigation
- anomaly identification

---

### DET-008 — Suspicious IP Investigation
**Goal:** Investigate IP behavior and determine whether activity is ordinary shared-IP noise or something deserving SOC escalation.

**Analyst growth:**
- distinct counts
- cross-user patterns
- time/frequency analysis
- security-oriented reasoning
- escalation judgment
- separating suspicious behavior from unsupported attribution

---

### DET-009 — Account-Level Authentication Investigation
**Goal:** Investigate suspicious user behavior across sequences of authentication events instead of treating rows independently.

**Analyst growth:**
- event sequencing
- window functions
- LAG/LEAD when appropriate
- behavioral context
- hypothesis testing
- incident-style investigation

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
- coverage assessment
- impact assessment
- practical recommendations

---

### DET-012 — Authentication Failure Burden Prioritization
**Goal:** Determine which customers, users, applications, or recurring failure patterns account for the largest share of authentication-failure burden and recommend where deeper investigation or monitoring effort should be concentrated.

**Analyst growth:**
- ranking
- cumulative contribution
- Pareto-style analysis
- concentration analysis
- prioritization
- operational decision support

**Scope guardrail:** Release 1 does not contain analyst queues, case assignments, handling time, staffing, or other evidence needed to measure true SOC workload. Do not label authentication-event volume as SOC workload.

---

### DET-013 — Customer Authentication Monitoring Priority Scorecard
**Goal:** Combine multiple observable, defensible authentication-health indicators into a customer monitoring-priority model and document the assumptions behind the scoring approach.

**Analyst growth:**
- metric design
- CTE-style decomposition
- weighting/normalization decisions
- sensitivity to assumptions
- transparent prioritization
- business communication

**Scope guardrail:** This is a monitoring-priority or authentication-health scorecard, not a validated cyber-risk model. Do not claim that the score measures breach likelihood, business impact, or overall customer risk.

---

### DET-014 — Detection Candidate Evaluation
**Goal:** Work with Priya to turn a discovered authentication pattern into a possible detection rule and estimate usefulness/noise.

**Analyst growth:**
- translating analysis into detection logic
- false-positive/false-negative thinking
- threshold evaluation
- operational trade-offs
- detection-engineering collaboration

---

### DET-015 — Customer Authentication Health Brief
**Goal:** Produce a customer-facing interpretation of authentication health that is accurate, contextualized, and safe to communicate.

**Analyst growth:**
- executive/customer communication
- explainability
- trust and caveats
- translating technical findings
- separating observed evidence from security claims

---

## Release 2 — Alerts, Incidents, and SOC Operations

> **Blocked until Release 2 exists and is validated.** DET-016 through DET-021 must not begin until the Release 2 schema and dataset have been generated, loaded, and accepted. Their final framing should be validated against the actual data before tickets are issued.

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
8. Before issuing a ticket whose conclusion depends on a specific signal, validate that the current release actually contains enough evidence to investigate the question without forcing the answer.
