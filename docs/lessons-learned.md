# Lessons Learned

1. Native EC2 metrics are useful but do not show guest memory and filesystem pressure.
2. CloudWatch Agent telemetry depends on correct IAM, configuration, namespace, and dimensions.
3. Sustained thresholds make alerts more actionable than single-point spikes.
4. SNS delivery is not complete until the subscriber confirms the email.
5. Configuration in source control turns a console exercise into a repeatable portfolio project.

## Next improvements

- Add CloudWatch Logs collection with explicit retention.
- Provision IAM, SNS, alarms, and dashboard fully through infrastructure as code.
- Add AWS Budgets and cost-anomaly monitoring.
- Add controlled remediation only with explicit approval and rollback design.

