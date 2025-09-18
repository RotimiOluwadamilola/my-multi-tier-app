# Use official Python image as base
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install system dependencies (needed for psycopg2 and others)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements folder and install dependencies
COPY requirements ./requirements
RUN pip install --upgrade pip && pip install --no-cache-dir -r requirements/prod.txt

# Copy application code
COPY . .

# Expose port
EXPOSE 8080

# Run the app (realworld flask entrypoint is conduit/app.py -> app variable)
CMD ["gunicorn", "-b", "0.0.0.0:8080", "conduit.app:app"]


