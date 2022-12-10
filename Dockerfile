FROM prefecthq/prefect:2.6.9-python3.10

COPY ./requirements.txt .

RUN apt update && pip install -r requirements.txt 