IMAGE := prefecthq/prefect:2.6.9-python3.10

.PHONY: docker
docker:
	@chmod +x scripts/prefect.sh
	@./scripts/prefect.sh docker_build
	@docker build --no-cache -f Dockerfile -t ${IMAGE} .

prefect-start:
	@chmod +x scripts/prefect.sh
	@./scripts/prefect.sh start ENV=$(ENV)

prefect-restart:
	@chmod +x scripts/prefect.sh
	@./scripts/prefect.sh restart ENV=$(ENV)

prefect-reset:
	@chmod +x scripts/prefect.sh
	@./scripts/prefect.sh reset ENV=$(ENV)

prefect-test:
	pytest tests/ -rP