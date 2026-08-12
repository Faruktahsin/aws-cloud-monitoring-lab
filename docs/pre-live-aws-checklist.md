# Pre-Live AWS Checklist

Use this checklist before opening the AWS Console for live verification. It keeps repository work separate from account-specific actions and prevents accidental disclosure.

## Confirm before making changes

- Use an existing suitable learning instance where possible; do not create another instance just for screenshots.
- Know which AWS region contains the existing lab resources.
- Confirm that the EC2 instance role is intended for CloudWatch Agent metric delivery, while the operator identity performs dashboard, alarm, and SNS actions.
- Set a cost budget or review existing cost controls before launching any new resource.

## Live verification order

1. Check for incoming `CWAgent` memory, root-disk, and swap metrics.
2. Check the dashboard shows both `AWS/EC2` and `CWAgent` data.
3. Check alarms are configured and have enough data to move to `OK`.
4. Check the SNS subscription is confirmed.
5. Capture only the redacted evidence required by [the evidence guide](evidence-and-screenshots.md).

## Stop and ask for help when

- A prompt requests root credentials, access keys, or a broad administrator policy.
- A resource would create a cost you did not intend.
- A metric is missing, an alarm remains `INSUFFICIENT_DATA`, or a dashboard has no data.
- A screenshot contains personal, account, or billing information that cannot be safely redacted.
