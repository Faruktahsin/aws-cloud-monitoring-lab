# Evidence and Screenshots

Add genuine, redacted evidence to [`screenshots/`](../screenshots/). Recommended files:

| File | Evidence |
| --- | --- |
| `01-cloudwatch-dashboard-overview.png` | Unified dashboard with EC2 and Agent metrics |
| `02-cloudwatch-agent-memory-disk.png` | `CWAgent` metrics arriving |
| `03-cloudwatch-alarm-state.png` | Alarm configuration and `OK`/test state |
| `04-sns-subscription-confirmed.png` | Confirmed SNS delivery path |

Crop or blur account IDs, instance IDs, topic ARNs, public IPs, email addresses, billing information, browser tabs, and unrelated resources. Do not publish support cases or credit details.

After validating the live dashboard, follow [`dashboards/exported/README.md`](../dashboards/exported/README.md) to save a local export. Keep raw export data untracked; only commit a sanitized version with placeholders.

## Minimum credible public evidence

The dashboard alone does not prove alert delivery. Publish the full four-image set only when it genuinely reflects the account: dashboard, Agent metrics, alarm state, and confirmed SNS subscription. Add a short caption below each image in the README only after it has been verified.
