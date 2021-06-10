#Grab the latest alpine image
#FROM alpine:latest
#
## Install python and pip
#RUN apk add --no-cache --update python3 py3-pip bash
#ADD ./requirements.txt /tmp/requirements.txt
#
## Install dependencies
#RUN \
## apk add --no-cache postgresql-libs && \
## apk add --no-cache python-dev-tools && \
## apk add --no-cache --virtual .build-deps gcc musl-dev postgresql-dev && \
# pip install --no-cache-dir -q -r /tmp/requirements.txt # && \
## apk --purge del .build-deps
#
## Add our code
#ADD . /opt/hDjango/
#WORKDIR /opt/hDjango
#
## Expose is NOT supported by Heroku
## EXPOSE 5000
#
## Run the image as a non-root user
#RUN adduser -D myuser
#USER myuser
#
## Run the app.  CMD is required to run on Heroku
## $PORT is set by Heroku
#CMD gunicorn --bind 0.0.0.0:$PORT wsgi
#
#
#
#
#
#

FROM python:3.7-alpine
ENV PYTHONUNBUFFERED=1
WORKDIR /code
COPY requirements.txt /code/
RUN apk add --no-cache --virtual .build-deps \
    ca-certificates gcc postgresql-dev linux-headers musl-dev \
    libffi-dev jpeg-dev zlib-dev \
    && pip install -r requirements.txt
COPY . /code/

# Run the image as a non-root user
RUN adduser -D myuser
USER myuser


# Run the app.  CMD is required to run on Heroku
# $PORT is set by Heroku
CMD gunicorn --bind 0.0.0.0:$PORT wsgi