# Cost Optimization Notes

- Use a single small EC2 instance for the lab and stop or terminate it outside practice sessions.
- Start with only the metrics and alarms that answer real health or capacity questions.
- The current baseline uses one five-minute datapoint for CPU, memory, and root-disk alerts; review alarm history and adjust if the workload produces false positives.
- Create a monthly AWS Budget and an alert before launching resources.
- Tag resources consistently, for example `Project=aws-cloud-monitoring-lab` and `Environment=learning`.
- Remove unused EC2 instances, EBS volumes, dashboards, alarms, and SNS topics during cleanup.

See [the cost-optimization case study](cost-optimization-case-study.md) for the measured trigger, reduction rationale, and the boundary between metric-browser observations and billing.

AWS pricing and Free Tier eligibility are account- and region-specific and may change. Verify them in the AWS Billing console before assuming a resource is free.

