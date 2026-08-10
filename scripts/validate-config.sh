#!/usr/bin/env bash
set -euo pipefail
root_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
for file in "$root_dir/config/amazon-cloudwatch-agent.json" "$root_dir/dashboards/cloudwatch-dashboard-template.json"; do
  jq empty "$file"
done
grep -q 'AWS::CloudWatch::Alarm' "$root_dir/infrastructure/cloudwatch-alarms.yaml"
echo "Configuration checks passed. No AWS resources were created or changed."

