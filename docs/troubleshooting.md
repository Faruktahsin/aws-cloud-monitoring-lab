# Troubleshooting Guide

## Dashboard disk panel has no current data

### Symptom

The `EC2 Disk Usage (%)` dashboard widget shows no recent datapoints while other EC2 and CloudWatch Agent widgets continue to update.

### Diagnosis used in this lab

The CloudWatch metric browser showed the current root-disk metric with the dimensions `InstanceId`, `device`, `fstype`, and `path`. The dashboard and alarm templates queried a focused `InstanceId` dimension series, so they could not resolve the newly published detailed disk series.

### Resolution

The Agent configuration was changed to:

1. collect `disk_used_percent` for `/` only;
2. aggregate metrics by `InstanceId`;
3. use `drop_original_metrics` for `used_percent`.

After the Agent configuration passed validation and the Agent reported `running` and `configured`, the dashboard's disk panel began receiving the focused `InstanceId` series again. The post-change dashboard screenshots document this result.

### Prevention

- Treat metric name **and dimension set** as part of a CloudWatch metric's identity.
- Keep Agent configuration, dashboard widgets, and alarm dimensions aligned.
- Validate the template locally with `bash scripts/validate-config.sh` before applying it.
- When a dashboard lacks data, check the Region, namespace, time window, and dimension combination before creating additional metrics or permissions.

## Alarm stays in `INSUFFICIENT_DATA`

Check, in order:

1. The selected AWS Region and `CWAgent` namespace.
2. The metric name and exact dimensions used by the alarm.
3. CloudWatch Agent status and its instance role.
4. Whether the selected time window contains new datapoints.
5. Whether the dashboard/Agent configuration was redeployed after a change.

Do not broaden IAM permissions or force workload stress merely to make an alarm change state.

## SNS subscription is not confirmed

SNS cannot deliver to an email endpoint until the confirmation link is accepted. Confirm the subscription first, then perform a controlled notification test. A confirmed subscription alone does not prove an `ALARM` notification was delivered; this lab separately records a successful controlled delivery in the [live verification record](live-verification.md).
