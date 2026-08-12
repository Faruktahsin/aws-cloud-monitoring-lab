# AWS Cloud Monitoring Lab

Portfolio‑ready AWS observability case study using Amazon CloudWatch Agent, CloudWatch dashboards and alarms, and Amazon SNS email notifications.

> Educational, non‑commercial project. No account IDs, ARNs, email addresses, IP addresses, credentials, or unredacted console exports are tracked.

## Why this repository exists

Not every cloud engineering project needs an application. This repository documents a practical operations task: making an EC2 workload observable, defining the alerting path, and making the work reproducible instead of leaving it as undocumented console clicks.

It is intended for recruiters, hiring managers, and engineers who want to see how I approach cloud monitoring, operational boundaries, and infrastructure documentation.

## Demonstrated capabilities

- EC2 infrastructure and guest operating‑system monitoring
- CloudWatch Agent configuration for memory, root-disk, and swap utilization
- CloudWatch dashboards combining `AWS/EC2` and `CWAgent` metrics
- CPU, memory, and root-disk alarms
- Amazon SNS email notification workflow
- Cost‑aware operations, least‑privilege, and evidence redaction

## What this is—and is not

| This is | This is not |
| --- | --- |
| A reproducible single‑instance monitoring lab and portfolio case study | A claim of a production‑scale monitoring platform |
| A documented CloudWatch Agent, dashboard, alarm, and SNS workflow | A substitute for an on‑call process or incident‑management system |
| A transparent record of configuration and validation steps | A repository containing private AWS account data or credentials |

## Architecture

```mermaid
flowchart LR
  EC2["Amazon EC2"] -->|"Native metrics"| CW["Amazon CloudWatch"]
  Agent["CloudWatch Agent"] -->|"Memory, root-disk, and swap metrics"| CW
  CW --> Dashboard["Dashboard"]
  CW --> Alarms["Alarms"]
  Alarms --> SNS["Amazon SNS"] --> Email["Email notification"]
```

## Live evidence model

Git cannot host live AWS resources. This repository shows the work through:
1. version‑controlled configuration and infrastructure templates;
2. sanitized dashboard definitions;
3. redacted screenshots that prove the running resources.

See the [setup guide](docs/setup-guide.md), [evidence gallery](docs/evidence-and-screenshots.md), [live verification record](docs/live-verification.md), [metric catalog](docs/metric-catalog.md), [decision log](docs/decision-log.md), [troubleshooting guide](docs/troubleshooting.md), [maintenance and cleanup runbook](docs/maintenance-and-cleanup.md), and [publishing checklist](docs/github-publishing-checklist.md).

## Evidence maturity

| Level | Meaning | Publicly tracked now |
| --- | --- | --- |
| Configuration | Agent JSON, dashboard template, and CloudFormation alarm definition | Yes |
| Local validation | JSON and repository configuration checks | Yes |
| Live verification | Redacted dashboard, focused metrics, alarm state, confirmed SNS subscription, and controlled alert delivery evidence | Yes |

This distinction is intentional: templates prove design and repeatability; redacted live evidence proves the lab was actually exercised.

## Repository layout

```text
config/          CloudWatch Agent configuration
dashboards/      Dashboard template and export workflow
infrastructure/  CloudFormation alarms
scripts/         Validation and deployment helpers
docs/            Architecture, decisions, verification, security, cost, and runbook notes
screenshots/     Redacted live evidence
```

## Quick start

```bash
# Validate local JSON configuration and check the alarm template
bash scripts/validate-config.sh

# Render and validate a dashboard without contacting AWS
./scripts/deploy-dashboard.sh --dry-run ec2-monitoring-dashboard <instance-id> <region>

# Deploy a dashboard (replace placeholders with your values)
./scripts/deploy-dashboard.sh ec2-monitoring-dashboard <instance-id> <region>
```

Create and confirm an SNS subscription, install the CloudWatch Agent, then deploy [`infrastructure/cloudwatch-alarms.yaml`](infrastructure/cloudwatch-alarms.yaml) as described in the setup guide. Do not put resource identifiers in Git‑tracked files.

For the implementation rationale, see the [cost optimization case study](docs/cost-optimization-case-study.md), [metric catalog](docs/metric-catalog.md), and [decision log](docs/decision-log.md).

For an opt-in CloudWatch Logs extension, see [optional logs integration](docs/optional-cloudwatch-logs.md). Enable it only after log paths, retention, and privacy needs have been reviewed.

## Verification path

1. Confirm EC2 metrics appear under `AWS/EC2`.
2. Confirm `mem_used_percent`, `disk_used_percent`, and `swap_used_percent` appear under `CWAgent`.
3. Confirm CloudWatch alarms leave `INSUFFICIENT_DATA` and become `OK`.
4. Confirm the SNS email subscription, then run a documented controlled test before treating notifications as delivered.
5. Add the redacted evidence images specified in the [evidence guide](docs/evidence-and-screenshots.md).

## Redacted live dashboard evidence

The live CloudWatch dashboard is captured across three time windows. Account identifiers are excluded; the images show unmodified console views.

![Three-day dashboard view](screenshots/02-dashboard-3-day.png)

![Post-change dashboard confirmation (three hours)](screenshots/04-dashboard-post-change-3-hours.png)

![Controlled CloudWatch-to-SNS delivery test](screenshots/09-controlled-alarm-email.png)

See the [full evidence gallery](docs/evidence-and-screenshots.md) for one-day, one-week, and post-change views.

## How this project can grow

- Add CloudWatch Logs with explicit retention and a documented log‑selection rationale.
- Manage the instance role, SNS topic, dashboard, and alarms fully through infrastructure as code.
- Add AWS Budgets and Cost Anomaly Detection as a separate cost‑observability layer.
- Extend controlled testing with an approved remediation and rollback workflow.
- Expand the troubleshooting guide with an incident timeline after a controlled test.
- Add automated template checks through GitHub Actions; this repository already includes a lightweight validation workflow.

## CV‑ready description

> Built an AWS EC2 monitoring lab using Amazon CloudWatch Agent, CloudWatch dashboards and alarms, and Amazon SNS email notification workflow. Implemented host-level memory, root-disk, and swap telemetry with CPU and capacity alerts, reproducible configuration, and documented cost and security controls.

## Prerequisites

| Tool | Minimum version |
|------|-----------------|
| AWS CLI | 2.0 |
| jq | 1.6 |
| Bash (macOS / Linux) | any recent version |
| CloudWatch Agent | latest |

## Current status

The repository has been published on GitHub. Configuration, documentation, and local validation are publicly available. Redacted live dashboard, focused metric, alarm-state, and SNS-subscription evidence is now included.

---

[![Validate workflow](https://github.com/Faruktahsin/aws-cloud-monitoring-lab/actions/workflows/validate.yml/badge.svg)](https://github.com/Faruktahsin/aws-cloud-monitoring-lab/actions/workflows/validate.yml)
