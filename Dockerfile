FROM python:3.7-alpine
ENV PYTHONUNBUFFERED=1
ADD requirements.txt /tmp/requirements.txt
RUN apk add --no-cache --virtual .build-deps \
    ca-certificates gcc postgresql-dev linux-headers musl-dev \
    libffi-dev jpeg-dev zlib-dev \
    && pip3 install --no-cache-dir -q -r /tmp/requirements.txt

ADD . /opt/hDjango
WORKDIR /opt/hDjango

# Run the image as a non-root user
RUN adduser -D myuser
USER myuser

# Run the app.  CMD is required to run on Heroku
# $PORT is set by Heroku
CMD gunicorn --bind 0.0.0.0:$PORT hDjango.wsgi