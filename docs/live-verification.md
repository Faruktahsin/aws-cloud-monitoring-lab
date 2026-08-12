# Live Verification Record

## Scope

This record separates observed live AWS evidence from version-controlled design and local checks. The evidence was captured from the single-instance learning lab in August 2026 and is redacted before publication.

| Capability | Evidence | Status |
| --- | --- | --- |
| Dashboard visibility | One-day, three-day, one-week, and post-change dashboard captures | Observed |
| Focused Agent telemetry | `mem_used_percent`, `disk_used_percent`, and `swap_used_percent` selected from `CWAgent` | Observed |
| Disk-metric correction | Post-change dashboard captures show `disk_used_percent` after `InstanceId` aggregation was applied | Observed |
| Alarm readiness | CPU, memory, and root-disk alarms are `OK` with actions enabled | Observed |
| Notification endpoint | One SNS email subscription is `Confirmed`; a controlled `ALARM` state produced a delivered SNS email | Observed |
| Controlled test trace | CloudWatch history recorded `OK -> ALARM -> OK` for the existing CPU alarm | Observed |
| Agent health | The Agent reported `running` and `configured` after configuration validation | Observed during the implementation session |

## What this does not prove

- The controlled test uses a temporary alarm-state override; it does not prove a real workload exceeded the CPU threshold.
- The repository does not claim a measured billing reduction; metric and billing usage must be reviewed over a relevant billing period.
- This is a single-instance learning lab, not a production-scale monitoring service.
- Optional CloudWatch Logs collection is documented but not represented as enabled live evidence.

See the [evidence gallery](evidence-and-screenshots.md), [metric catalog](metric-catalog.md), and [decision log](decision-log.md) for the corresponding artifacts and reasoning.
