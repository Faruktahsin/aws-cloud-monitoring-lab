# Optional CloudWatch Logs Integration

The base lab intentionally collects metrics only. Log collection can increase visibility, but it also increases data volume, cost, and the chance of capturing sensitive information. Enable it only after choosing a specific operational question that logs will answer.

## Included example

[`config/amazon-cloudwatch-agent-with-logs.example.json`](../config/amazon-cloudwatch-agent-with-logs.example.json) is a complete Agent configuration. It keeps the base memory and disk metrics and adds a single example system-log collection rule.

| Setting | Example value | Review before use |
| --- | --- | --- |
| Source file | `/var/log/messages` | Use `/var/log/syslog` or another approved path when appropriate |
| Log group | `EC2_MONITORING_LOG_GROUP` | Replace with a project-specific name; do not include personal data |
| Retention | 14 days | Choose the shortest retention period that meets the lab goal |
| Stream name | `{instance_id}/messages` | Redact instance IDs from public screenshots |

## Safe enablement checklist

1. Confirm the file path exists on the selected instance and that the file does not contain secrets or sensitive application data.
2. Replace the example log-group name and review the 14-day retention setting.
3. Confirm the instance role permits the Agent to deliver log events; do not add static credentials to the Agent configuration.
4. Apply this file as the Agent's complete configuration, then confirm only the intended log group and stream appear in CloudWatch.
5. Add a cleanup step for the log group when the lab finishes, unless retention is deliberately required.

## Portfolio boundary

Do not commit log content or raw log exports. A redacted CloudWatch Logs console screenshot may be used as evidence only when it contains no credentials, tokens, personal data, internal hostnames, or customer information.
