FROM python:3.10-slim as base
WORKDIR /code
RUN pip install --upgrade pip

FROM base as builder
WORKDIR /code
COPY requirements-build.txt .
RUN pip install -r requirements-build.txt
ENTRYPOINT ["/bin/bash"]
