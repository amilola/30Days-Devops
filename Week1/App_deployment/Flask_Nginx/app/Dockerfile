# Use lightweight Python image
FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Install curl needed for healthcheck
RUN apt-get update && apt-get install -y curl && apt-get clean

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Expose port
EXPOSE 5000

# Run the Flask app
CMD ["python", "app.py"]
