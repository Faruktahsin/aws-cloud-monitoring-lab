# Dashboard export workflow

Export a live dashboard locally after verifying it:

```bash
aws cloudwatch get-dashboard --dashboard-name <dashboard-name> --region <region> --query DashboardBody --output text > dashboards/exported/dashboard-export.json
```

Raw exports are ignored by Git. Review and replace account-specific identifiers, resource names, annotations, and embedded URLs before publishing a sanitized copy.

