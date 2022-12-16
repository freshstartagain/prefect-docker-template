import requests
import docker
import pytest
import os
from config import PREFECT_ORION_UI_API_URL

PROJECT_FOLDER_NAME = os.path.dirname(os.path.abspath(__file__)).split("/")[-2]
DOCKER_CLIENT = docker.DockerClient(base_url="unix://var/run/docker.sock")
RETRIES = 10
DELAY = 1


@pytest.mark.flaky(retries=RETRIES, delay=DELAY)
def test_server():
    response = requests.get(f"{PREFECT_ORION_UI_API_URL}/health")

    assert response.status_code == 200


@pytest.mark.flaky(retries=RETRIES, delay=DELAY)
def test_agent():
    container = DOCKER_CLIENT.containers.get(f"{PROJECT_FOLDER_NAME}-prefect-agent-1")
    container_status = container.attrs["State"]["Status"]

    assert container_status == "running"


@pytest.mark.flaky(retries=RETRIES, delay=DELAY)
def test_postgres():
    container = DOCKER_CLIENT.containers.get(f"{PROJECT_FOLDER_NAME}-postgres-1")
    container_status = container.attrs["State"]["Status"]

    assert container_status == "running"
