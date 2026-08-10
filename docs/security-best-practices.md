# Security Best Practices

- Do not use the root user for normal work; enable MFA for privileged identities.
- Prefer an EC2 instance role over access keys in files, user data, or CloudWatch Agent configuration.
- Use `CloudWatchAgentServerPolicy` only as a lab starting point; scope a custom policy for production.
- Apply least-privilege Security Group rules and prefer Systems Manager Session Manager over exposed SSH where possible.
- Redact account IDs, ARNs, IP addresses, email addresses, resource names, billing values, and browser profiles in evidence.
- Keep raw dashboard exports out of version control and never commit `.aws/`, private keys, or `.env` files.

SNS email is a notification path, not an authorization to make unsafe changes. Define investigation and approval procedures before adding automatic remediation.

