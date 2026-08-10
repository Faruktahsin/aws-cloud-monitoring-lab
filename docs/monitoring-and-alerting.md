# Monitoring and Alerting Runbook

| Signal | Default condition | Operational meaning |
| --- | --- | --- |
| CPU utilization | >= 80% for 15 minutes | Sustained compute saturation |
| EC2 status check | Failed for 2 minutes | Instance or system availability concern |
| Memory used | >= 85% for 15 minutes | Risk of OOM or degraded performance |
| Disk used | >= 85% for 15 minutes | Risk of failed writes and log growth |

On notification: confirm the dashboard trend, check EC2 status checks and instance events, inspect the process or filesystem through an approved access method, then record cause and action. `INSUFFICIENT_DATA` usually means the Agent, IAM role, namespace, region, or metric dimensions need verification.

SNS subscription confirmation is the first safe notification test. Do not induce sustained load on shared or production resources merely to trigger an alarm.

