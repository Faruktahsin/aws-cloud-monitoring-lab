#!/usr/bin/env bash
set -euo pipefail
if [[ $# -ne 3 ]]; then echo "Usage: $0 <dashboard-name> <instance-id> <region>" >&2; exit 64; fi
dashboard_name="$1"; instance_id="$2"; region="$3"
root_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
rendered_dashboard="$(mktemp)"; trap 'rm -f "$rendered_dashboard"' EXIT
sed -e "s/INSTANCE_ID/$instance_id/g" -e "s/REGION/$region/g" "$root_dir/dashboards/cloudwatch-dashboard-template.json" > "$rendered_dashboard"
jq empty "$rendered_dashboard"
aws cloudwatch put-dashboard --dashboard-name "$dashboard_name" --dashboard-body "file://$rendered_dashboard" --region "$region"
echo "Dashboard '$dashboard_name' deployed in $region."

