#!/usr/bin/env bash
set -euo pipefail

usage() {
  echo "Usage: $0 [--dry-run] <dashboard-name> <instance-id> <region>" >&2
}

dry_run=false
if [[ "${1:-}" == "--dry-run" ]]; then
  dry_run=true
  shift
fi

if [[ $# -ne 3 ]]; then
  usage
  exit 64
fi

dashboard_name="$1"
instance_id="$2"
region="$3"

# Validate inputs before they reach sed or the AWS CLI. Unvalidated values containing
# characters such as '/', '&', or quotes would break or alter the rendered dashboard.
if [[ ! "$dashboard_name" =~ ^[A-Za-z0-9_-]{1,255}$ ]]; then
  echo "Error: dashboard name may contain only letters, digits, '-' and '_' (max 255)." >&2
  exit 64
fi
if [[ ! "$instance_id" =~ ^i-([0-9a-f]{8}|[0-9a-f]{17})$ ]]; then
  echo "Error: instance ID must look like i-0123456789abcdef0." >&2
  exit 64
fi
if [[ ! "$region" =~ ^[a-z]{2}(-[a-z]+)+-[0-9]+$ ]]; then
  echo "Error: region must look like eu-central-1." >&2
  exit 64
fi

root_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
rendered_dashboard="$(mktemp)"
trap 'rm -f "$rendered_dashboard"' EXIT

if ! command -v jq >/dev/null 2>&1; then
  echo "Error: jq is required to validate the rendered dashboard." >&2
  exit 1
fi

sed -e "s/INSTANCE_ID/$instance_id/g" -e "s/REGION/$region/g" \
  "$root_dir/dashboards/cloudwatch-dashboard-template.json" > "$rendered_dashboard"
jq empty "$rendered_dashboard"

if [[ "$dry_run" == true ]]; then
  echo "Dry run passed. Rendered dashboard is valid JSON; no AWS resources were changed."
  exit 0
fi

if ! command -v aws >/dev/null 2>&1; then
  echo "Error: AWS CLI is required to deploy the dashboard." >&2
  exit 1
fi

aws cloudwatch put-dashboard --dashboard-name "$dashboard_name" --dashboard-body "file://$rendered_dashboard" --region "$region"
echo "Dashboard '$dashboard_name' deployed in $region."

