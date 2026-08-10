#!/usr/bin/env bash
set -euo pipefail

# Usage: scripts/validate-config.sh
# Validates JSON configuration files and checks for CloudWatch alarm definitions without creating AWS resources.

# Determine repository root
root_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Files to validate
config_file="$root_dir/config/amazon-cloudwatch-agent.json"
dashboard_file="$root_dir/dashboards/cloudwatch-dashboard-template.json"
alarms_file="$root_dir/infrastructure/cloudwatch-alarms.yaml"

# Verify required commands are available
for cmd in jq grep; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "Error: required command '$cmd' not found in PATH." >&2
    exit 1
  fi
done

# Validate JSON files
for file in "$config_file" "$dashboard_file"; do
  if [[ ! -f "$file" ]]; then
    echo "Error: file $file does not exist." >&2
    exit 1
  fi
  jq empty "$file"
done

jq -e '
  .metrics.namespace == "CWAgent" and
  (.metrics.metrics_collected.mem.measurement | index("mem_used_percent") != null) and
  (.metrics.metrics_collected.disk.measurement | index("used_percent") != null)
' "$config_file" >/dev/null

jq -e '
  (.widgets | type == "array" and length >= 4) and
  ([.widgets[].properties.title] | index("EC2 CPU Utilization") != null) and
  ([.widgets[].properties.title] | index("EC2 Status Checks") != null) and
  ([.widgets[].properties.title] | index("Memory Used") != null) and
  ([.widgets[].properties.title] | index("Instance Disk Used") != null)
' "$dashboard_file" >/dev/null

if [[ -f "$root_dir/config/amazon-cloudwatch-agent-with-logs.example.json" ]]; then
  jq empty "$root_dir/config/amazon-cloudwatch-agent-with-logs.example.json"
fi

# Validate CloudFormation template contains at least one CloudWatch alarm resource
if [[ ! -f "$alarms_file" ]]; then
  echo "Error: alarms file $alarms_file not found." >&2
  exit 1
fi
if ! grep -q 'AWS::CloudWatch::Alarm' "$alarms_file"; then
  echo "Error: no CloudWatch Alarm definitions found in $alarms_file." >&2
  exit 1
else
  echo "Alarm definitions detected."
fi

echo "Configuration checks passed. No AWS resources were created or changed."
