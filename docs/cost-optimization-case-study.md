# CloudWatch Cost Optimization Case Study

## Context

This single-instance lab was intentionally narrowed after an AWS Free Tier usage alert indicated that custom-metric capacity needed attention. The alert showed 9 custom metrics in use against a 10-metric Free Tier allowance and forecasted 23. These values are account-specific, can update with delay, and are not a price quote.

The CloudWatch metric browser also showed a changing set of more than 25 visible `CWAgent` time series. Metric-browser series and Billing Free Tier consumption are different views: old series can remain queryable after publication stops, while billing is the source of truth for charged metric usage.

## What changed

| Area | Earlier broad collection | Current focused baseline | Why |
| --- | --- | --- | --- |
| Disk scope | Multiple mounted filesystems | Root filesystem only (`/`) | The lab alarm protects the filesystem most likely to affect host availability. |
| Disk signals | Utilization, inode, and disk I/O signals | `disk_used_percent` only | Removes metrics with no current alerting or dashboard decision. |
| Dimensions | Extra image and instance-type dimensions | `InstanceId` only | Keeps the single-instance dashboard and alarms unambiguous. |
| Agent metrics | Broader disk collection | Memory, root-disk, and swap utilization | Retains the host-capacity signals used by the lab. |
| Agent identity | Root in the original template | `cwagent` in the current template | Aligns the public example with the current agent configuration. |

The tracked agent configuration uses a 60-second collection interval, publishes to `CWAgent`, and aggregates by `InstanceId` while dropping the detailed root-disk series.

## Validation boundary

The Agent configuration was applied successfully to the learning instance and the Agent reported a running/configured state. The live dashboard showed EC2, memory, root-disk, and swap telemetry. The live alarm list showed the three configured capacity alarms in `OK`, with actions enabled. A later controlled state test also verified one SNS `ALARM` email delivery; this test did not create extra workload or establish a measured billing outcome.

This is evidence that the monitoring path was configured and observed; it is **not** a claim that a lower bill has already been measured. Review AWS Billing after the relevant usage period before making a cost-savings claim.

## Trade-offs and next review

The focused configuration does not collect inode or disk-I/O metrics, and it monitors only `/`. Reintroduce a signal only when a concrete operational question requires it. Before enabling additional metrics, document the decision, expected dimensions, retention need, and cost impact.

## Secure access and cleanup

Administrative access was constrained to a personal source IP and the regional EC2 Instance Connect managed prefix list; no unrestricted SSH rule was used. Do not publish IP addresses, prefix-list IDs, account IDs, instance IDs, or email endpoints. Remove the temporary personal-IP rule when it is no longer needed.

## Supporting evidence

After redaction, add the dashboard, three-alarm state, confirmed SNS subscription, and focused `CWAgent` metric views described in the [evidence guide](evidence-and-screenshots.md). A redacted Billing/Free Tier alert may be retained as supplementary evidence; it should not expose account or billing details.
