FROM python:3.9

# Create a working directory
WORKDIR /app

# Copy dependencies first for better caching
COPY requirements.txt /app/

# Install Python dependencies
RUN pip3 install --no-cache-dir -r requirements.txt

# Copy rest of the application code
COPY . /app

# 🔐 Add a non-root user to satisfy Choreo Scan (CKV_DOCKER_3)
RUN useradd -u 10014 -m appuser
USER appuser

# Expose the port
EXPOSE 3000

# Start your app
CMD flask run -h 0.0.0.0 -p 3000 & python3 main.py
