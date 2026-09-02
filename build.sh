#!/bin/bash
# Railway Build Script for Akshiva Bot
# This script runs before the main bot starts to set up environment

set -e

echo "🚀 Starting Akshiva Bot Railway Build..."

# Update pip
echo "📦 Updating pip, setuptools, and wheel..."
pip install --upgrade pip setuptools wheel

# Install dependencies
echo "📥 Installing Python dependencies..."
pip install -r requirements.txt

# Verify FFmpeg installation
echo "🎬 Verifying FFmpeg installation..."
if ! command -v ffmpeg &> /dev/null; then
    echo "⚠️  FFmpeg not found in system PATH"
    echo "   Note: FFmpeg will be installed by Railway via apt-get in Dockerfile"
else
    echo "✅ FFmpeg found: $(ffmpeg -version | head -n 1)"
fi

# Create necessary directories
echo "📁 Creating necessary directories..."
mkdir -p logs temp_files downloads sessions

# Set environment variable for logging
export LOG_LEVEL=INFO

echo "✅ Build completed successfully!"
echo "🤖 Bot is ready to start..."

# The actual bot starts via Procfile/Dockerfile CMD
