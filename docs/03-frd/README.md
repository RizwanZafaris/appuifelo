# Stage 4 — FRD

> 🟡 **Pending Review Gate 3 approval.** Will be filled at Stage 4.

Target file: `frd-onboarding.md` decomposing PRD phases into ~60-80
functional requirements.

Each FR has the schema:

```
ID:            FR-{phase}.{step}.{n}
Title:         <short imperative>
Description:   <one paragraph>
Trigger:       <user action or system event>
Preconditions: <required state>
Behavior:      <ordered steps>
Postconditions:<resulting state>
Error states:  <validation + system errors>
Acceptance:    <Gherkin or list>
PRD link:      <section ID>
Analytics:     <event names that trace to this FR>
```

The traceability rule is absolute: every analytics event in Stage 6 carries
its FR ID. If an event doesn't trace to an FR, either the FR is missing or
the event is noise.
