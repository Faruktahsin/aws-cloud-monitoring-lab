# Lessons Learned

1. Native EC2 metrics are useful but do not show guest memory and filesystem pressure.
2. CloudWatch Agent telemetry depends on correct IAM, configuration, namespace, and dimensions.
3. Alert evaluation windows are a workload decision: this lab uses one five-minute datapoint for responsive learning feedback, while production thresholds should be tuned from alarm history.
4. A confirmed SNS subscription proves the endpoint is ready; a controlled alert test provided separate evidence of delivered `ALARM` and `OK` notifications.
5. Metric dimensions affect both query correctness and cost; aggregation and `drop_original_metrics` can preserve the signal while reducing unnecessary detailed series.
6. Configuration in source control turns a console exercise into a repeatable portfolio project.

## Next improvements

- Add CloudWatch Logs collection with explicit retention.
- Provision IAM, SNS, alarms, and dashboard fully through infrastructure as code.
- Add AWS Budgets and cost-anomaly monitoring.
- Add controlled remediation only with explicit approval and rollback design.
