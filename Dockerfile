# Use python:3.9-slim as the base image
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Copy requirements.txt and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the service package
COPY service/ ./service/

# Create a non-root user
RUN useradd -m theia && chown -R theia:theia /app
USER theia

# Expose port 8080
EXPOSE 8080

# Run the service with gunicorn
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]

