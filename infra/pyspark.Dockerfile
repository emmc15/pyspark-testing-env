FROM python:3.8.16-slim-buster



# Install Java and AWS S3 Dependencies for Spark
RUN apt-get update && apt-get install -y openjdk-11-jdk

WORKDIR /workspace

# Install Poetry
RUN pip install poetry

COPY poetry.lock pyproject.toml ./

RUN poetry config virtualenvs.create false && poetry install

COPY . ./

ENTRYPOINT [ "jupyter-lab" ]