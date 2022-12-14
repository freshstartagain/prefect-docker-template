import requests
import pytest
from config import PREFECT_ORION_UI_API_URL

@pytest.mark.flaky(retries=10, delay=1)
def test_server():

    response = requests.get(f'{PREFECT_ORION_UI_API_URL}/health')

    assert response.status_code == 200

