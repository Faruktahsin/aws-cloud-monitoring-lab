# Contribution and Evidence Guidelines

This repository is a public cloud-monitoring portfolio case study. Contributions should preserve its reproducibility, security boundaries, and evidence accuracy.

## Before changing configuration

1. Keep AWS account identifiers, ARNs, email addresses, IP addresses, credentials, private keys, and raw exports out of Git.
2. Do not make production-scale claims for this single-instance educational lab.
3. Keep live verification separate from templates and local checks.
4. Prefer small, documented changes that can be validated without AWS credentials.

## Before adding screenshots

Only add genuine screenshots captured from the configured lab. Redact or crop:

- AWS account IDs, instance IDs, topic ARNs, and public IP addresses
- Email addresses and notification contents containing personal data
- Browser profiles, unrelated tabs, bookmarks, and billing data
- Credentials, tokens, log content, and internal hostnames

Use the filenames and evidence requirements in [docs/evidence-and-screenshots.md](docs/evidence-and-screenshots.md). Never add a screenshot merely to make the repository look complete.

## Local checks

Run these before committing changes:

```bash
bash scripts/validate-config.sh
./scripts/deploy-dashboard.sh --dry-run ec2-monitoring-dashboard i-0123456789abcdef0 eu-central-1
bash -n scripts/validate-config.sh
bash -n scripts/deploy-dashboard.sh
```

