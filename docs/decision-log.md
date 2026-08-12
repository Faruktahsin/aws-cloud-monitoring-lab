# Operational Decision Log

The lab is intentionally small, but its design choices are documented so a reviewer can see the operational reasoning behind the configuration.

## D-001: Monitor guest capacity, not only native EC2 metrics

**Decision:** Use the CloudWatch Agent for memory, root-disk, and swap utilization in addition to native EC2 metrics.

**Reason:** EC2 native metrics do not provide guest memory or filesystem pressure. These are the host-level signals needed to investigate capacity risk.

## D-002: Keep root-disk monitoring focused and aggregate by instance

**Decision:** Collect `disk_used_percent` only for `/`, aggregate by `InstanceId`, and drop the detailed original disk series.

**Reason:** The lab protects the filesystem most likely to affect host availability while avoiding a growing collection of device, filesystem-type, and path dimension combinations. The aggregation also aligns the Agent output with the dashboard and alarm templates.

**Trade-off:** Per-device, inode, and disk-I/O diagnosis is not available in the focused baseline. Reintroduce it only after documenting a specific operational need.

## D-003: Use three capacity alarms with five-minute evaluation periods

**Decision:** Alert on CPU at 80%, memory at 85%, and root disk at 90%, each from one five-minute datapoint. Keep status checks on the dashboard only.

**Reason:** This creates a simple, observable notification path for the learning workload without treating every dashboard signal as an incident trigger.

**Trade-off:** A single datapoint is responsive but can produce false positives on bursty workloads. Review alarm history before adopting these thresholds for another workload or production environment.

## D-004: Separate instance and operator permissions

**Decision:** The EC2 instance role supports CloudWatch Agent publishing; a separate operator identity manages dashboards, CloudFormation, and SNS.

**Reason:** The runtime workload should not receive administrative permissions it does not need.

## D-005: Publish redacted evidence, preserve raw material privately

**Decision:** Public evidence contains genuine console views with account, instance, subscription, email, and network identifiers removed. Original screenshots remain outside Git tracking.

**Reason:** Evidence should demonstrate implementation without permanently exposing account-specific data in a public repository.
