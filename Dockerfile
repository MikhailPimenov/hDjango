FROM python:3.7-slim-buster
ENV PYTHONUNBUFFERED=1
ADD requirements.txt /tmp/requirements.txt
RUN pip3 install --no-cache-dir -q -r /tmp/requirements.txt

ADD . /opt/hDjango
WORKDIR /opt/hDjango

# Run the image as a non-root user
RUN adduser --disabled-password myuser
USER myuser

# Run the app.  CMD is required to run on Heroku
# $PORT is set by Heroku
CMD gunicorn --bind 0.0.0.0:$PORT hDjango.wsgi