# Container image that runs your code
FROM python:3.12-slim

RUN mkdir -p /github/workspace
RUN mkdir -p /sesam

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    unzip \
    && rm -rf /var/lib/apt/lists/*

RUN curl -sSL https://github.com/sesam-community/sesam-py/archive/refs/tags/2.10.0.zip -o /tmp/sesam-py.zip && \
    unzip /tmp/sesam-py.zip -d /tmp  && \
    mv /tmp/sesam-py-*/* /sesam/ && \
    rm -rf /tmp/sesam-py.zip /tmp/sesam-py-*

RUN pip install --root-user-action=ignore --upgrade pip && pip install --root-user-action=ignore -r /sesam/requirements.txt

COPY src/entrypoint.sh /sesam/entrypoint.sh

ENTRYPOINT [ "/sesam/entrypoint.sh" ]
