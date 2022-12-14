FROM prefecthq/prefect:2.6.9-python3.10

COPY ./requirements-prefect.txt .

RUN apt update && pip install -r requirements-prefect.txt 