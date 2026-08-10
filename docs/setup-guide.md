# Setup Guide

## Prerequisites

Use a non-root AWS identity with AWS CLI v2, an existing EC2 instance with an attached IAM role, and `jq` locally. Never store AWS access keys in this repository.

## 1. Configure the agent

Attach `CloudWatchAgentServerPolicy` to the EC2 instance role for this lab. Install the CloudWatch Agent on the instance, then apply the tracked configuration:

```bash
sudo yum install -y amazon-cloudwatch-agent
sudo cp config/amazon-cloudwatch-agent.json /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json -s
```

For Ubuntu, install the appropriate CloudWatch Agent package first and use the same control command.

## 2. Create an SNS topic and confirm email delivery

```bash
aws sns create-topic --name ec2-monitoring-alerts --region <region>
aws sns subscribe --topic-arn <sns-topic-arn> --protocol email --notification-endpoint <your-email-address> --region <region>
```

Confirm the subscription from the email before relying on notifications.

## 3. Deploy and verify

```bash
bash scripts/validate-config.sh
aws cloudformation deploy --template-file infrastructure/cloudwatch-alarms.yaml --stack-name ec2-monitoring-alarms --parameter-overrides InstanceId=<instance-id> SnsTopicArn=<sns-topic-arn> --region <region>
./scripts/deploy-dashboard.sh ec2-monitoring-dashboard <instance-id> <region>
```

Verify EC2 and `CWAgent` metrics, wait until alarms become `OK`, then capture redacted evidence. Delete the stack, dashboard, topic, and unused instance when the lab ends.

