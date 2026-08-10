# Architecture

EC2 publishes CPU and status-check metrics to `AWS/EC2`. The CloudWatch Agent publishes memory and disk utilization to `CWAgent` every 60 seconds using its EC2 instance role. CloudWatch displays both metric sources, evaluates threshold alarms, and routes `ALARM` and recovery events to a confirmed SNS email subscription.

| Component | Responsibility |
| --- | --- |
| EC2 | Workload host and native metrics |
| CloudWatch Agent | Guest memory and disk metrics |
| CloudWatch | Metric storage, dashboard, alarm evaluation |
| SNS | Opt-in email notification delivery |

The supplied thresholds are starting points. Tune them after observing the workload baseline.

