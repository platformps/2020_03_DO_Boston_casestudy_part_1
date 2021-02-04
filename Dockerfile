# use base image
FROM python:3.7-alpine

# set app directory
WORKDIR /usr/src/app

# copy app files into container
COPY . .

# set environment variables
ENV FLASK_APP app.py
ENV FLASK_RUN_HOST 0.0.0.0

# install prerequisites 
RUN apk add --no-cache gcc musl-dev linux-headers
RUN apk update && \
	apk upgrade && \
	apk add git
RUN apk update && \
	apk upgrade && \
	apk add docker
RUN pip install -r requirements.txt

# expose a port for the app
EXPOSE 5000

# run the app
CMD ["app", "run"]
