# DiaSync Makefile - Simple automation without chmod
#
# ⚠️  MEDICAL DISCLAIMER: This software is NOT a medical device
# NOT FDA approved - Always consult healthcare professionals
# See MEDICAL_COMPLIANCE.md for complete regulatory information

.PHONY: setup start stop logs clean help check-docker template disclaimer

# Default target
help:
	@echo "🩸 DiaSync - Available commands:"
	@echo ""
	@echo "  make disclaimer - Show medical disclaimer"
	@echo "  make setup      - Interactive setup (prompts for credentials)"
	@echo "  make template   - Create .env template (manual editing required)"
	@echo "  make start      - Start DiaSync (runs setup if needed)"
	@echo "  make stop       - Stop DiaSync"
	@echo "  make logs       - Show logs"
	@echo "  make clean      - Remove containers and volumes"
	@echo "  make check      - Check .env configuration"
	@echo "  make help       - Show this help"
	@echo ""
	@echo "⚠️  REMINDER: This is NOT a medical device. Always consult healthcare professionals."

# Show medical disclaimer
disclaimer:
	@echo "🚨 CRITICAL MEDICAL DISCLAIMER 🚨"
	@echo "=================================="
	@echo "THIS SOFTWARE IS NOT A MEDICAL DEVICE"
	@echo "- NOT FDA APPROVED for medical use"
	@echo "- NOT intended for medical decision-making"
	@echo "- ALWAYS consult healthcare professionals"
	@echo "- Use approved medical devices for diabetes management"
	@echo "- In emergencies, contact emergency services immediately"
	@echo ""
	@echo "📄 Read MEDICAL_COMPLIANCE.md for complete regulatory information"
# Check for docker compose command
DOCKER_COMPOSE := $(shell command -v docker-compose 2> /dev/null)
ifndef DOCKER_COMPOSE
	DOCKER_COMPOSE := docker compose
endif

# Check if docker is available
check-docker:
	@command -v docker >/dev/null 2>&1 || { echo "❌ Docker is not installed or not in PATH"; exit 1; }
	@docker --version >/dev/null 2>&1 || { echo "❌ Docker is not running"; exit 1; }

# Create .env from template
setup:
	@if [ ! -f .env ]; then \
		echo "🔧 Running interactive setup..."; \
		bash setup.sh; \
	else \
		echo "✅ .env already exists"; \
	fi

# Create .env template (manual editing required)
template:
	@if [ ! -f .env ]; then \
		echo "🔧 Creating .env from template..."; \
		cp .env.example .env; \
		echo "✅ .env template created!"; \
		echo "📝 Please edit .env with your credentials, then run: make start"; \
	else \
		echo "✅ .env already exists"; \
	fi

# Start DiaSync (auto-creates .env if needed)
start: check-docker disclaimer setup
	@echo "🚀 Starting DiaSync..."
	$(DOCKER_COMPOSE) up -d

# Stop DiaSync
stop: check-docker
	@echo "🛑 Stopping DiaSync..."
	$(DOCKER_COMPOSE) down

# Show logs
logs: check-docker
	@echo "📋 DiaSync logs (Ctrl+C to exit):"
	$(DOCKER_COMPOSE) logs -f

# Clean up everything
clean: check-docker
	@echo "🧹 Cleaning up containers and volumes..."
	$(DOCKER_COMPOSE) down -v
	docker system prune -f

# Check if .env exists and is configured
check:
	@if [ ! -f .env ]; then \
		echo "❌ .env file not found. Run 'make setup' first."; \
		exit 1; \
	fi
	@if grep -q "your_.*_username" .env; then \
		echo "⚠️  .env contains placeholder values. Please edit with real credentials."; \
	else \
		echo "✅ .env appears to be configured"; \
	fi
