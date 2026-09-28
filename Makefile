.PHONY: up down restart status logs logs-collector logs-prometheus logs-loki logs-grafana clean validate setup help

# Default target
help:
	@echo "Claude Code Grafana Observability Stack"
	@echo ""
	@echo "Usage:"
	@echo "  make up              Start all services"
	@echo "  make down            Stop all services"
	@echo "  make restart         Restart all services"
	@echo "  make status          Show service status"
	@echo "  make logs            View all service logs"
	@echo "  make logs-collector  View OTel Collector logs"
	@echo "  make logs-prometheus View Prometheus logs"
	@echo "  make logs-loki       View Loki logs"
	@echo "  make logs-grafana    View Grafana logs"
	@echo "  make clean           Remove all containers and volumes"
	@echo "  make validate        Validate configuration files"
	@echo "  make setup           Show Claude Code setup instructions"
	@echo ""
	@echo "Access:"
	@echo "  Grafana:    http://localhost:3000 (admin/admin)"
	@echo "  Prometheus: http://localhost:9090"
	@echo "  Loki:       http://localhost:3100"

# Start all services
up:
	@echo "Starting observability stack..."
	docker compose up -d
	@echo ""
	@echo "Stack is starting up. Services will be available at:"
	@echo "  Grafana:    http://localhost:3000 (admin/admin)"
	@echo "  Prometheus: http://localhost:9090"
	@echo ""
	@echo "Run 'make setup' for Claude Code configuration instructions."

# Stop all services
down:
	@echo "Stopping observability stack..."
	docker compose down

# Restart all services
restart:
	@echo "Restarting observability stack..."
	docker compose restart

# Show service status
status:
	@docker compose ps

# View all logs
logs:
	docker compose logs -f

# View specific service logs
logs-collector:
	docker compose logs -f otel-collector

logs-prometheus:
	docker compose logs -f prometheus

logs-loki:
	docker compose logs -f loki

logs-grafana:
	docker compose logs -f grafana

# Remove all containers and volumes
clean:
	@echo "Removing all containers and volumes..."
	docker compose down -v
	@echo "Clean complete."

# Validate configuration files
validate:
	@echo "Validating configuration files..."
	@docker run --rm -v $(PWD)/config/otel-collector-config.yaml:/etc/otel-collector-config.yaml:ro \
		otel/opentelemetry-collector-contrib:0.96.0 validate --config=/etc/otel-collector-config.yaml && \
		echo "OTel Collector config: OK" || echo "OTel Collector config: FAILED"
	@echo "Validation complete."

# Show setup instructions
setup:
	@echo ""
	@echo "=== Claude Code Telemetry Setup ==="
	@echo ""
	@echo "Option 1: Source the environment file"
	@echo "  source setup-env.sh"
	@echo "  claude"
	@echo ""
	@echo "Option 2: Set environment variables manually"
	@echo "  export CLAUDE_CODE_ENABLE_TELEMETRY=1"
	@echo "  export OTEL_METRICS_EXPORTER=otlp"
	@echo "  export OTEL_LOGS_EXPORTER=otlp"
	@echo "  export OTEL_EXPORTER_OTLP_PROTOCOL=grpc"
	@echo "  export OTEL_EXPORTER_OTLP_ENDPOINT=http://localhost:4317"
	@echo "  claude"
	@echo ""
	@echo "View your metrics at: http://localhost:3000"
	@echo ""
