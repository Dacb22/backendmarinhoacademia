# Usar uma imagem base apropriada
FROM python:3.10-slim

# Instalar dependências do sistema
RUN apt-get update && apt-get install -y \
    build-essential \
    libmariadb-dev-compat \
    libmariadb-dev \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Criar e ativar um ambiente virtual
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Copiar e instalar as dependências do projeto
COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Copiar o código do projeto para o contêiner
COPY . /app
WORKDIR /app

# Comando para iniciar o serviço Django
CMD ["gunicorn", "core.wsgi:application", "--bind", "0.0.0.0:8000"]
