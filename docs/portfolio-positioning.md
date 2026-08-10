# Portfolio Positioning

## Is an AWS monitoring repository a real project?

Yes—when it documents a real engineering outcome rather than a list of AWS services. Cloud work is often delivered as configuration, operational controls, runbooks, and infrastructure as code rather than application source code. A monitoring case study is especially relevant for cloud engineering, DevOps, SRE, platform engineering, and infrastructure-focused roles.

The differentiator is evidence and judgment:

- **Problem:** native EC2 metrics do not expose guest memory and filesystem pressure.
- **Design:** add CloudWatch Agent telemetry, consolidate signals in a dashboard, and route actionable alerts through SNS.
- **Controls:** define thresholds, least-privilege direction, cleanup, and cost guardrails.
- **Evidence:** include redacted proof of metrics, alarms, and notification confirmation.
- **Honesty:** label templates separately from live verification; do not present a learning lab as production infrastructure.

## How people discover and assess it

| Surface | What a reviewer sees | What to optimize |
| --- | --- | --- |
| GitHub profile | Pinned repository, title, description, topics, README preview | Clear project name and first-screen README |
| Direct CV link | A specific proof point for a cloud skill | CV description matching README claims |
| Recruiter search | Topics and visible AWS/IaC terminology | `aws`, `amazon-cloudwatch`, `cloudformation`, `devops` topics |
| Technical interview | Design choices, trade-offs, and troubleshooting story | Architecture, runbook, evidence, lessons learned |

## Recommended GitHub presentation

Repository name: `aws-cloud-monitoring-lab`

Description: `EC2 monitoring with Amazon CloudWatch Agent, CloudWatch alarms, dashboards, and SNS email notifications.`

Pin the repository on the GitHub profile only after adding at least the dashboard, metrics, alarm, and SNS redacted evidence set. A clean repository with transparent limitations is more credible than a repository with unverified claims.

## Interview narrative

> I started with EC2’s built-in health signals, then identified the visibility gap for guest memory and disk utilization. I configured the CloudWatch Agent, designed sustained thresholds to reduce alert noise, routed alerts through SNS, and documented the setup as reusable configuration. I also separated live evidence from templates and included cost and security guardrails because operational quality matters as much as the monitoring charts.

