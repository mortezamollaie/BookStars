FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# Add APT mirror manually
RUN echo "deb http://mirror.arvancloud.ir/debian bookworm main contrib non-free" > /etc/apt/sources.list && \
    echo "deb http://mirror.arvancloud.ir/debian bookworm-updates main contrib non-free" >> /etc/apt/sources.list && \
    echo "deb http://mirror.arvancloud.ir/debian-security bookworm-security main contrib non-free" >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        postgresql-client \
        gcc \
        python3-dev \
        libpq-dev \
        build-essential \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt /app/
RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

COPY . /app/

RUN mkdir -p /app/staticfiles

EXPOSE 8000

CMD ["gunicorn", "--bind", "0.0.0.0:8000", "bookstars.wsgi:application"]
