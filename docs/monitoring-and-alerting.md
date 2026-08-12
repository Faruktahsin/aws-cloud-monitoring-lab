# Monitoring and Alerting Runbook

| Signal | Default condition | Operational meaning |
| --- | --- | --- |
| CPU utilization | >= 80% for one five-minute period | Compute saturation requiring review |
| Memory used | >= 85% for one five-minute period | Risk of OOM or degraded performance |
| Root disk used | >= 90% for one five-minute period | Risk of failed writes and log growth |
| EC2 status check | Dashboard-only signal | Instance or system availability context |

On notification: confirm the dashboard trend, check EC2 status checks and instance events, inspect the process or filesystem through an approved access method, then record cause and action. `INSUFFICIENT_DATA` usually means the Agent, IAM role, namespace, region, or metric dimensions need verification.

For this lab, SNS delivery was verified with a controlled `SetAlarmState` test on the existing CPU alarm. The test produced an `ALARM` email and CloudWatch recorded the subsequent `ALARM -> OK` transition. Do not induce sustained load on shared or production resources merely to trigger an alarm; use a documented, approved state test where appropriate.
