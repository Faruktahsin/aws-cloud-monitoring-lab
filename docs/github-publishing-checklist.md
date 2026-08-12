# GitHub Publishing Checklist

- [x] Run `bash scripts/validate-config.sh` locally before the evidence commit.
- [ ] Verify the GitHub Actions run after push.
- [x] Ensure `git status` contains no credentials, account IDs, personal email addresses, `.pem` files, `.aws/` content, or raw exports.
- [x] Add only redacted, genuine screenshots.
- [x] Confirm the README accurately distinguishes templates from live verification.
- [ ] Use this repository description: `EC2 monitoring with Amazon CloudWatch Agent, CloudWatch alarms, dashboards, and SNS email notifications.`
- [ ] Suggested topics: `aws`, `amazon-cloudwatch`, `amazon-ec2`, `amazon-sns`, `cloudformation`, `devops`, `cloud-monitoring`.
- [ ] Suggested initial commit: `feat: add AWS CloudWatch monitoring portfolio lab`.
- [ ] Add the repository description and topics from [portfolio positioning](portfolio-positioning.md).
- [ ] Pin the repository to the GitHub profile after this evidence commit is pushed and the GitHub Actions run is green.
