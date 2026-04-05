FROM python:3.9-slim

# Step 2: Establish working directory
WORKDIR /app

# Step 3: Install all of the Python requirements
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Step 7: Copy the service package specifically
COPY service/ ./service/

# Step 8: Switch to a non-root user with UID 1000
RUN useradd --uid 1000 theia && chown -R theia /app
USER theia

# Step 9: Run the service with log-level info
EXPOSE 8080
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]