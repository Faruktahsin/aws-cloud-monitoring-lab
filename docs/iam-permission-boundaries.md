# IAM Permission Boundaries

This lab deliberately separates the EC2 instance role from the identity that deploys or administers resources.

## EC2 instance role

The instance role is used by the CloudWatch Agent at runtime. For a learning lab, `CloudWatchAgentServerPolicy` is an appropriate baseline. It lets the Agent publish the configured metrics without storing static credentials on the instance.

The instance role should not be used to deploy dashboards, create CloudFormation stacks, manage SNS subscriptions, or administer unrelated AWS resources.

## Operator identity

The local user or assumed role that runs deployment commands is a separate identity. It needs only the permissions required for the selected workflow, such as deploying the alarm stack, writing the dashboard, and managing the chosen SNS topic and subscription.

Scope this access to the lab resources and region whenever possible. Avoid using the root user or broad administrative permissions for routine work.

## Verification boundary

The repository documents the intended separation; whether a specific AWS account actually follows it requires live AWS Console verification. Do not record the role name, account ID, or policy exports in this public repository.
