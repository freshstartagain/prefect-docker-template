from dotenv import dotenv_values

config = dotenv_values("./.env")

PREFECT_ORION_UI_API_URL = config["PREFECT_ORION_UI_API_URL"]