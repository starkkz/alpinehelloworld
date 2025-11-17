# Grab the latest alpine image
FROM alpine:latest

# Install python, pip and required tools
RUN apk add --no-cache python3 py3-pip bash build-base

# Create and activate a virtual environment
RUN python3 -m venv /venv
ENV PATH="/venv/bin:$PATH"

# Install dependencies
COPY ./webapp/requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt

# Add our code
COPY ./webapp /opt/webapp/
WORKDIR /opt/webapp

# Run the image as a non-root user
RUN adduser -D myuser
USER myuser

# Run the app
CMD gunicorn --bind 0.0.0.0:$PORT wsgi
