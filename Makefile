.PHONY: up
up:
	docker compose up -d

.PHONY: down
down:
	docker compose down --remove-orphans

.PHONY: status
status:
	docker compose ps

.PHONY: stats
stats:
	docker stats ollama-backend ollama-webui

.PHONY: logs
logs:
	docker compose logs -f --tail=100
