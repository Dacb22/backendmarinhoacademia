FROM python:3.10-slim

RUN apt-get update && apt-get install -y \
    build-essential \
    libmysqlclient-dev \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

COPY . /app
WORKDIR /app

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]