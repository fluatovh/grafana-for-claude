#!/bin/bash

# Claude Code OpenTelemetry Environment Setup
# Source this file before running Claude Code:
#   source setup-env.sh

# Enable telemetry (required)
export CLAUDE_CODE_ENABLE_TELEMETRY=1

# Configure OTLP exporter
export OTEL_METRICS_EXPORTER=otlp
export OTEL_LOGS_EXPORTER=otlp
export OTEL_EXPORTER_OTLP_PROTOCOL=grpc
export OTEL_EXPORTER_OTLP_ENDPOINT=http://localhost:4317

# Faster export intervals for development (optional - comment out for production)
export OTEL_METRIC_EXPORT_INTERVAL=10000  # 10 seconds (default: 60000)
export OTEL_LOGS_EXPORT_INTERVAL=5000      # 5 seconds (default: 5000)

# Privacy settings (uncomment to enable user prompt logging)
# export OTEL_LOG_USER_PROMPTS=1

# Cardinality control (uncomment to customize)
# export OTEL_METRICS_INCLUDE_SESSION_ID=true
# export OTEL_METRICS_INCLUDE_VERSION=false
# export OTEL_METRICS_INCLUDE_ACCOUNT_UUID=true

# Custom resource attributes (uncomment and customize for team tracking)
# export OTEL_RESOURCE_ATTRIBUTES="department=engineering,team.id=platform"

echo "Claude Code telemetry environment configured!"
echo ""
echo "  OTLP Endpoint: $OTEL_EXPORTER_OTLP_ENDPOINT"
echo "  Metrics Export Interval: ${OTEL_METRIC_EXPORT_INTERVAL}ms"
echo "  Logs Export Interval: ${OTEL_LOGS_EXPORT_INTERVAL}ms"
echo ""
echo "You can now run 'claude' to start a session with telemetry enabled."
