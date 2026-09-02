# Use Python 3.10 slim image as base
FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Install system dependencies needed for bot
RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg \
    libssl-dev \
    libffi-dev \
    libpq-dev \
    git \
    curl \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first (for better caching)
COPY requirements.txt .

# Install Python dependencies with optimizations
RUN pip install --no-cache-dir --upgrade pip setuptools wheel && \
    pip install --no-cache-dir -r requirements.txt

# Copy entire project
COPY . .

# Expose port for web server
EXPOSE 8004

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8004/ || exit 1

# Run the bot
CMD ["python3", "bot.py"]
