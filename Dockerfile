# pull a base image
FROM python:3.7-alpine

# set current working directory
WORKDIR /usr/src/app

# copy app files into container
COPY . .

# install curl and requirements
RUN apk update && \
	apk upgrade && \
	apk add curl
RUN curl -fsSLO https://get.docker.com/builds/Linux/x86_64/docker-17.04.0-ce.tgz \
  && tar xzvf docker-17.04.0-ce.tgz \
  && mv docker/docker /usr/local/bin \
  && rm -r docker docker-17.04.0-ce.tgz
RUN apk remove docker-compose -y && apk autoremove
RUN pip install -r requirements.txt

# expose a port for the app
EXPOSE 5000

# run the app
CMD ["app", "run"]
