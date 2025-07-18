# DiaSync Makefile - Simple automation without chmod

.PHONY: setup start stop logs clean help

# Default target
help:
	@echo "🩸 DiaSync - Available commands:"
	@echo ""
	@echo "  make setup    - Create .env file if it doesn't exist"
	@echo "  make start    - Start DiaSync (creates .env if needed)"
	@echo "  make stop     - Stop DiaSync"
	@echo "  make logs     - Show logs"
	@echo "  make clean    - Remove containers and volumes"
	@echo "  make help     - Show this help"

# Create .env from template
setup:
	@if [ ! -f .env ]; then \
		echo "🔧 Creating .env from template..."; \
		cp .env.example .env; \
		echo "✅ .env created! Please edit it with your credentials."; \
		echo "📝 Then run: make start"; \
	else \
		echo "✅ .env already exists"; \
	fi

# Start DiaSync (auto-creates .env if needed)
start: setup
	@echo "🚀 Starting DiaSync..."
	docker-compose up -d

# Stop DiaSync
stop:
	@echo "🛑 Stopping DiaSync..."
	docker-compose down

# Show logs
logs:
	@echo "📋 DiaSync logs (Ctrl+C to exit):"
	docker-compose logs -f

# Clean up everything
clean:
	@echo "🧹 Cleaning up containers and volumes..."
	docker-compose down -v
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
