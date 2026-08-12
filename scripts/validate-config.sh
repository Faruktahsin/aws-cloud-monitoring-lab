#!/usr/bin/env bash
set -euo pipefail

# Usage: scripts/validate-config.sh
# Validates local JSON templates and expected alarm definitions without creating AWS resources.

root_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
config_file="$root_dir/config/amazon-cloudwatch-agent.json"
dashboard_file="$root_dir/dashboards/cloudwatch-dashboard-template.json"
alarms_file="$root_dir/infrastructure/cloudwatch-alarms.yaml"
logs_config="$root_dir/config/amazon-cloudwatch-agent-with-logs.example.json"

for cmd in jq grep; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "Error: required command '$cmd' not found in PATH." >&2
    exit 1
  fi
done

for file in "$config_file" "$dashboard_file"; do
  if [[ ! -f "$file" ]]; then
    echo "Error: file $file does not exist." >&2
    exit 1
  fi
  jq empty "$file"
done

jq -e '
  .metrics.namespace == "CWAgent" and
  .agent.run_as_user == "cwagent" and
  (.metrics.metrics_collected.mem.measurement | index("mem_used_percent") != null) and
  (.metrics.metrics_collected.disk.measurement | index("used_percent") != null) and
  (.metrics.metrics_collected.swap.measurement | index("swap_used_percent") != null) and
  (.metrics.metrics_collected.disk.resources == ["/"]) and
  (.metrics.aggregation_dimensions == [["InstanceId"]]) and
  (.metrics.metrics_collected.disk.drop_original_metrics | index("used_percent") != null)
' "$config_file" >/dev/null

jq -e '
  (.widgets | type == "array" and length == 7) and
  ([.widgets[].properties.title] | index("EC2 CPU Utilization") != null) and
  ([.widgets[].properties.title] | index("EC2 Network Traffic") != null) and
  ([.widgets[].properties.title] | index("EC2 EBS Read/Write Throughput") != null) and
  ([.widgets[].properties.title] | index("EC2 Instance Health Check") != null) and
  ([.widgets[].properties.title] | index("EC2 Memory Usage (%)") != null) and
  ([.widgets[].properties.title] | index("EC2 Disk Usage (%)") != null) and
  ([.widgets[].properties.title] | index("EC2 Swap Usage (%)") != null)
' "$dashboard_file" >/dev/null

if [[ -f "$logs_config" ]]; then
  jq empty "$logs_config"
  jq -e '
    .agent.run_as_user == "root" and
    (.metrics.aggregation_dimensions == [["InstanceId"]]) and
    (.metrics.metrics_collected.swap.measurement | index("swap_used_percent") != null) and
    (.metrics.metrics_collected.disk.drop_original_metrics | index("used_percent") != null) and
    (.logs.logs_collected.files.collect_list | length == 1)
  ' "$logs_config" >/dev/null
fi

if [[ ! -f "$alarms_file" ]]; then
  echo "Error: alarms file $alarms_file not found." >&2
  exit 1
fi

alarm_count="$(grep -c 'Type: AWS::CloudWatch::Alarm' "$alarms_file" || true)"
if [[ "$alarm_count" -ne 3 ]]; then
  echo "Error: expected exactly three CloudWatch Alarm definitions; found $alarm_count." >&2
  exit 1
fi

for required in "MetricName: CPUUtilization" "MetricName: mem_used_percent" "MetricName: disk_used_percent" "Default: 90"; do
  if ! grep -Fq "$required" "$alarms_file"; then
    echo "Error: required alarm definition detail missing: $required" >&2
    exit 1
  fi
done

echo "Three expected alarm definitions detected."
echo "Configuration checks passed. No AWS resources were created or changed."
