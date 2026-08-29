# SPOILERS — Sentinel Mentor Validation Key

> **DO NOT READ DURING THE SIMULATION IF YOU WANT TO PRESERVE INVESTIGATION SPOILERS.**
>
> This file exists so future ChatGPT sessions can mentor Sentinel tickets from a validated map instead of improvising. It records what the current Release 1 synthetic dataset can actually support, known dead ends, and where the roadmap needs revision.
>
> The analyst-facing roadmap remains `docs/sentinel_analyst_roadmap.md`. This file is mentor-only guidance.

## Validation standard

A ticket is considered **Green** when the current dataset contains enough signal, volume, and context to support a meaningful investigation and defensible business/operational conclusion.

**Yellow** means the ticket is technically possible but weak, repetitive, overly dependent on another ticket's signal, or likely to encourage over-interpretation.

**Red** means the current objective cannot be taught responsibly with the current data and should be revised before the analyst reaches it.

---

## Release 1 audit

### DET-002 — Release 1 Data Acceptance & Onboarding
**Status: GREEN / COMPLETE**

The current files support row-count, date-range, NULL, grain, and relationship checks. The dataset guide is sufficient for onboarding. No further infrastructure work is required for this ticket.

---

### DET-003 — Customer Authentication Health Baseline
**Status: GREEN, WITH SCOPE GUARDRAIL**

**What the data supports**
- Overall organization failure rates are tightly grouped, roughly 7.7%–9.7% across the full period.
- Raw failure counts mostly track organization volume, so rates/denominators are necessary.
- One organization contains a high-volume temporal deterioration that becomes visible when the analyst adds a stability/time component rather than relying only on the 60-day aggregate.
- A weekly view is much more reliable than ranking tiny daily percentages.

**Validated signal**
- Harborline Financial (organization 2) has a week around 17.2% failures on 471 attempts, materially above its normal level.
- 2026-08-14 UTC contains 133 attempts and 59 failures (~44.4%), so this is not a tiny-denominator artifact.

**Mentor guardrail**
DET-003 should establish customer baseline + identify who deserves follow-up. Do not force the analyst to fully root-cause the event here; preserve root-cause work for subsequent tickets.

**Known dead end**
Ranking the highest daily percentages without considering volume produces misleading small-sample spikes, especially for smaller organizations.

---

### DET-004 — Application Access Friction
**Status: YELLOW / USABLE AS A DECOMPOSITION TICKET**

**What the data supports**
- Overall application failure rates range from about 7.2% to 11.7%.
- VPN Portal has the highest overall rate, but much of that elevation is driven by the Harborline Financial anomaly.
- Within organization 2, VPN Portal is about 21.2% failures over 443 attempts in the full dataset.
- After removing the known attack cluster, application rates become much more homogeneous (~7.2%–9.6%).

**Teaching value**
This can teach that an apparently poor application-wide metric may be driven by one customer/event rather than widespread product friction.

**Risk**
It reuses the same signal as DET-003/DET-007 and can feel repetitive if treated as a fully independent investigation.

**Recommendation**
Keep only if framed as: “Is the apparent application problem widespread or concentrated?” Otherwise add a distinct sustained application-specific pattern before use.

---

### DET-005 — Authentication Method Performance
**Status: RED/YELLOW — SHOULD BE REVISED BEFORE USE**

**What the data currently shows**
- Overall failure rates are close: Password ~9.5%, SSO ~8.9%, OAuth ~8.7%, Passkey ~8.6%, MFA Push ~8.3%.
- After removing the known planted anomalies, the range compresses further to roughly 8.1%–8.9%.
- Failure-category mixes are also broadly similar across methods.
- A few organization/method combinations appear elevated, but they look like ordinary synthetic variance rather than a deliberately supported business pattern.

**Problem**
The current ticket promises a substantive method-performance investigation, but the data does not contain a robust independent method-level signal. It risks either producing a boring duplicate “nothing much differs” conclusion or encouraging the analyst to over-interpret random variance.

**Recommendation**
Either:
1. Reframe as an explicit null-result decision ticket: “Does authentication method materially affect failures enough to justify remediation?” or
2. Add a deliberately sustained method-specific friction pattern before the ticket is assigned.

---

### DET-006 — Device Trust & Authentication Outcomes
**Status: YELLOW — OBJECTIVE IS PARTLY SUPPORTED, BUT SIGNAL IS CONFOUNDED**

**What the data currently shows**
- Managed devices: ~8.7% failure.
- Unmanaged devices: ~8.5% failure.
- Unknown-device events: ~13.9% failure.
- The elevated unknown-device rate is driven heavily by the Harborline Financial anomaly; without known planted anomalies, unknown-device failure rate is only around 9.2%.

**Teaching value**
The analyst can correctly conclude that managed vs unmanaged status does not materially differ, and that the apparent unknown-device problem is confounded by one incident.

**Risk**
This again reuses the same Harborline incident and does not independently support a strong “device trust” business conclusion.

**Recommendation**
Before use, either reframe as a deliberate “does device management status actually matter?” null-result ticket, or add a distinct device-context pattern.

---

### DET-007 — Authentication Failure Spike Investigation
**Status: GREEN / STRONG**

**Validated signal**
- Harborline Financial, 2026-08-14 UTC: 133 attempts, 59 failures (~44.4%).
- The abnormal failures are heavily concentrated within a short time window.
- The spike is sufficiently large that denominator checks do not explain it away.

**Expected investigation direction**
Time baseline -> identify organization/date -> compare normal vs anomalous period -> decompose by result/method/application.

**Mentor guardrail**
The ticket can stop once the spike and its main dimensions are characterized. If possible, preserve detailed IP/source investigation for DET-008.

---

### DET-008 — Suspicious IP Investigation
**Status: GREEN / STRONG**

**Validated signal**
- IP `203.0.113.250` is the standout source.
- During the Harborline incident it generates 54 Invalid Password failures against many different users in roughly 20 minutes, primarily Password authentication to VPN Portal, with device context absent.
- A simple historical candidate threshold such as many Invalid Password attempts across multiple users from one IP in a short window isolates the cluster cleanly in this dataset.

**Expected conclusion**
Activity is consistent with password-spray-like behavior and warrants SOC escalation; the data supports behavioral characterization but not attribution of attacker identity.

---

### DET-009 — Account-Level Authentication Investigation
**Status: GREEN / STRONG**

**Validated independent signal**
- User 1017 (`tthomas`, organization 1) has seven MFA Denied events from the same IP/application between 03:40 and 03:52 UTC on 2026-08-09, followed by a Success at 03:56.
- This is the largest same-user short-window MFA-denial cluster in the dataset.

**Teaching value**
Excellent for event sequencing, time differences, LAG/LEAD or equivalent logic, repeated-event detection, and cautious security interpretation.

**Expected conclusion**
Pattern is consistent with an MFA-fatigue/push-bombing scenario and deserves follow-up, but telemetry alone does not prove user compromise.

---

### DET-010 — Inactive Account Activity Review
**Status: GREEN / NUANCED**

**What the data supports**
- Eight currently inactive users have 88 historical authentication events.
- The data dictionary explicitly states `is_active` is current account status, not historical status at event time.
- Therefore, analysts cannot claim that every event for an inactive user occurred after deactivation.
- One inactive user (1168, `nscott`) has a distinct sequence on 2026-08-18: three rapid Invalid Password attempts followed by a Success from the same IP to Internal Admin Portal with unknown device context.

**Expected conclusion**
The dataset does not support a blanket “inactive accounts are authenticating after deactivation” claim. However, the concentrated sequence for user 1168 merits investigation. This is a strong ticket for separating evidence from inference.

---

### DET-011 — Telemetry Completeness Review
**Status: GREEN/YELLOW — VIABLE DATA-QUALITY TICKET**

**Validated metrics**
- Missing `device_id`: 1,100 / 23,269 (~4.7%).
- Missing `application_name`: 398 / 23,269 (~1.7%).
- Missing application data behaves roughly like the overall population.
- Missing device context has a higher observed failure rate (~13.9% vs ~8.6% for known devices), but this is substantially influenced by the Harborline incident.

**Teaching value**
Good for measuring missingness, checking whether NULLs are random across groups/outcomes, and explaining how missing context can affect downstream conclusions.

**Risk**
Part of the device-missing signal repeats the known Harborline anomaly.

**Recommendation**
Keep; frame as data-quality impact assessment rather than another security-incident hunt.

---

### DET-012 — SOC Workload Prioritization
**Status: RED/YELLOW — CURRENT BUSINESS FRAMING IS TOO STRONG**

**What the data can support**
Using authentication failures as a volume proxy:
- Invalid Password accounts for ~50.7% of all failures.
- Top 3 organizations account for ~54.4% of failures.
- User-level failures are diffuse: roughly 64 users are needed to reach 50% of failures.
- Application failures are also fairly distributed; the top five applications account for just over half.

**Problem**
Authentication events are not alerts, cases, analyst touches, or SOC queue records. The dataset cannot directly measure analyst workload.

**Recommendation**
Rename/reframe as **Authentication Failure Burden Prioritization**, where failure-event volume is explicitly the quantity being prioritized. Save true SOC workload/SLA analysis for Release 2 when alert/incident/operational data exists.

---

### DET-013 — Customer Authentication Risk Scorecard
**Status: RED — SHOULD BE REFRAMED**

**Problem**
The current dataset has no validated ground-truth risk label, incident severity label, confirmed compromises, losses, or outcome variable that can validate a “risk score.” Any weighting scheme would be largely subjective and may teach false precision.

**What the data CAN support**
A **Customer Authentication Health / Monitoring Priority Scorecard** based on transparent metrics such as overall failure rate, temporal instability, missing-device share, unusual failure concentration, and similar observable measures.

**Recommendation**
Replace “risk” with “health,” “concern,” or “monitoring priority.” Require the analyst to document assumptions and avoid claiming the score predicts compromise.

---

### DET-014 — Detection Candidate Evaluation
**Status: GREEN / VERY STRONG**

**Validated candidate patterns**
At least two strong candidates exist:
1. Password spray: multiple Invalid Password events from one IP across many users within a short window.
2. MFA fatigue: repeated MFA Denied events for one user in a short period, optionally followed by Success.

**Historical validation examples**
- A fixed 30-minute grouping requiring >=10 Password/Invalid Password attempts across >=5 users isolates the Harborline spray cluster in this dataset.
- A short-window repeated-MFA-denial rule isolates the user 1017 pattern.

**Teaching value**
Strong for threshold design, false-positive reasoning, historical backtesting, trade-offs, and translating analysis into detection logic.

---

### DET-015 — Customer Authentication Health Brief
**Status: GREEN**

The Release 1 data can support a customer-facing brief, especially for Harborline Financial: overall authentication behavior is mostly normal across the 60-day window, but there is a concentrated abnormal event requiring careful wording and follow-up. The ticket is useful for separating technical evidence from customer-safe claims and avoiding attack attribution beyond the data.

---

## Release 2 audit

### DET-016 through DET-021
**Status: NOT YET AUDITABLE / DATA DOES NOT EXIST**

The current repository/dataset contains only Release 1 organizations, users, devices, and authentication events. There are no Release 2 alert, incident, triage, response, or SLA tables/data yet.

**Hard rule:** Do not assign DET-016 through DET-021 until Release 2 schema/data is generated and each ticket is validated against the actual dataset using the same standard as this file.

---

## Overall audit conclusion

The Release 1 dataset is **not broken**, but the original roadmap overestimated how many independent investigations it could support.

Strong independent signals currently exist for:
- high-volume temporal authentication anomaly / password-spray-like behavior,
- suspicious source-IP behavior,
- repeated MFA-denial sequence followed by success,
- nuanced inactive-account review,
- telemetry-completeness analysis,
- detection-rule backtesting.

The main weaknesses are:
- DET-004 through DET-006 can repeatedly rediscover the same Harborline incident,
- DET-005 lacks a robust independent method-performance signal,
- DET-012 cannot honestly measure SOC analyst workload from authentication events alone,
- DET-013 uses the word “risk” more strongly than the data supports,
- Release 2 tickets were planned before Release 2 data existed.

Before continuing far into the roadmap, revise weak ticket framing rather than forcing the analyst to search for insights the dataset does not support. Prefer fewer, richer investigations over many shallow tickets.
