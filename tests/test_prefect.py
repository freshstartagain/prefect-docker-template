import requests
import docker
import pytest
from config import PREFECT_ORION_UI_API_URL


DOCKER_CLIENT = docker.DockerClient(base_url="unix://var/run/docker.sock")
RETRIES = 10
DELAY = 1


@pytest.mark.flaky(retries=RETRIES, delay=DELAY)
def test_server():
    response = requests.get(f"{PREFECT_ORION_UI_API_URL}/health")

    assert response.status_code == 200


@pytest.mark.flaky(retries=RETRIES, delay=DELAY)
def test_agent():
    container = DOCKER_CLIENT.containers.get("prefect-docker-template-prefect-agent-1")
    container_status = container.attrs["State"]["Status"]

    assert container_status == "running"


@pytest.mark.flaky(retries=RETRIES, delay=DELAY)
def test_postgres():
    container = DOCKER_CLIENT.containers.get("prefect-docker-template-postgres-1")
    container_status = container.attrs["State"]["Status"]

    assert container_status == "running"
