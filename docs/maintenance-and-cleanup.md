# Maintenance and Cleanup Runbook

Use this checklist after a learning session or before leaving the lab inactive. It is a guide: review the exact resource names, Region, and whether you need to retain evidence before deleting anything.

## During the lab

- Keep the CloudWatch Agent configuration and templates in Git rather than saving the only copy in the console.
- Review dashboard and alarm history before changing thresholds.
- Keep metric collection focused; add a metric, log group, or alarm only when it answers a documented question.
- Review the AWS Billing console after configuration changes rather than assuming cost effects immediately.

## When access is no longer needed

- Remove any temporary personal-IP Security Group rule used for administration.
- Prefer disabling or removing temporary access paths over leaving broad inbound access open.
- Keep the EC2 instance role limited to Agent delivery; remove unused operator permissions separately.

## When pausing or ending the lab

- Stop or terminate the learning instance when it is not needed, after confirming whether any data must be preserved.
- Delete unused EBS volumes, snapshots, Elastic IP addresses, dashboards, alarms, and SNS topics/subscriptions deliberately.
- If the alarm stack was created through CloudFormation, remove it through the same stack workflow rather than deleting individual resources first.
- If optional CloudWatch Logs was enabled, confirm the intended retention period or remove the log group.
- Review the Billing and Free Tier views after cleanup; billing data can lag resource changes.

## Preserve evidence safely

- Keep only redacted evidence in Git.
- Keep raw screenshots and dashboard exports outside Git tracking.
- Do not retain credentials, private keys, access keys, or copied console URLs in the repository.
