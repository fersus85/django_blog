FROM python:3.10-slim
LABEL maintainer="Deriabin_85@mail.ru"

ARG BUILD_DEPS="curl"
RUN apt-get update && apt-get install -y $BUILD_DEPS

RUN curl -sSL https://install.python-poetry.org | POETRY_VERSION=1.5.1 POETRY_HOME=/root/poetry python3 -
ENV PATH="${PATH}:/root/poetry/bin"

WORKDIR /code/

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

COPY poetry.lock pyproject.toml /code/

COPY . /code/

RUN poetry config virtualenvs.create false
RUN poetry install --no-interaction --no-ansi
