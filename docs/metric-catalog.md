# Metric Catalog

This catalog describes the signals intentionally retained in the single-instance lab. It is a design reference, not a substitute for checking current CloudWatch data in the selected AWS Region.

| Signal | Namespace and metric | Source | Dashboard | Alarm | Design note |
| --- | --- | --- | --- | --- | --- |
| CPU utilization | `AWS/EC2` / `CPUUtilization` | EC2 native metric | Yes | `>= 80%` for one five-minute datapoint | Capacity indicator for compute saturation. |
| Network traffic | `AWS/EC2` / `NetworkIn`, `NetworkOut` | EC2 native metrics | Yes | No | Useful context during workload or connectivity investigation. |
| EBS throughput | `AWS/EC2` / `EBSReadBytes`, `EBSWriteBytes` | EC2 native metrics | Yes | No | I/O context; not treated as an incident trigger in this learning lab. |
| Instance health | `AWS/EC2` / `StatusCheckFailed` | EC2 native metric | Yes | No | Availability context retained on the dashboard. |
| Memory used | `CWAgent` / `mem_used_percent` | CloudWatch Agent | Yes | `>= 85%` for one five-minute datapoint | Guest operating-system capacity signal. |
| Root disk used | `CWAgent` / `disk_used_percent` | CloudWatch Agent | Yes | `>= 90%` for one five-minute datapoint | Collected for `/` only. Published as an `InstanceId` aggregate. |
| Swap used | `CWAgent` / `swap_used_percent` | CloudWatch Agent | Yes | No | Capacity context; retained without an alert while the learning workload has no demonstrated threshold need. |

## Dimension and cost boundary

The CloudWatch Agent publishes the retained host signals every 60 seconds. Root-disk collection is limited to `/`; the Agent aggregates by `InstanceId` and uses `drop_original_metrics` for `used_percent`. This keeps the dashboard and disk alarm on a stable `InstanceId` series without continuing to publish the detailed disk `device`, `fstype`, and `path` series.

Metric-browser series counts, alarm counts, and Billing/Free Tier counters are different views. Use AWS Billing as the cost source of truth; use the metric browser to validate what signals and dimensions are currently published.
