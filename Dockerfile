FROM python:3.10-slim

RUN apt-get update && apt-get install -y \
  curl \
  && rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install -y libpq-dev gcc && rm -rf /var/lib/apt/lists/*


WORKDIR /usr/src/app

ENV POETRY_HOME=/usr/local/share/pypoetry
ENV POETRY_VIRTUALENVS_CREATE=false

RUN ["/bin/bash", "-c", "set -o pipefail && curl -sSL https://install.python-poetry.org | python3 -"]

COPY . .
RUN /usr/local/share/pypoetry/bin/poetry install --no-dev
RUN export PATH="/usr/local/share/pypoetry/bin:$PATH" && python3 /usr/src/app/updater.py

CMD [ "/usr/local/share/pypoetry/bin/poetry", "run", "python", "./start_us.py" ]
