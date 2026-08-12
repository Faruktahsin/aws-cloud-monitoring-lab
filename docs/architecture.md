# Architecture

EC2 publishes CPU and status-check metrics to `AWS/EC2`. The CloudWatch Agent publishes memory, root-disk, and swap utilization to `CWAgent` every 60 seconds using its EC2 instance role. Root-disk telemetry is aggregated by `InstanceId`, and the detailed disk series is dropped after aggregation so the dashboard and alarm resolve one focused host-level signal. CloudWatch displays both metric sources, evaluates threshold alarms, and routes `ALARM` and recovery events to a confirmed SNS email subscription.

| Component | Responsibility |
| --- | --- |
| EC2 | Workload host and native metrics |
| CloudWatch Agent | Guest memory, root-disk, and swap metrics |
| CloudWatch | Metric storage, dashboard, alarm evaluation |
| SNS | Opt-in email notification delivery |

The supplied thresholds are starting points. Tune them after observing the workload baseline.

