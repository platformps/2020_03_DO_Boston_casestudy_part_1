# pull a base image
FROM python:3.7-alpine

# set current working directory
WORKDIR /usr/src/app

# copy app files into container
COPY . .

# install curl and requirements
RUN apk update && \
	apk upgrade && \
	apk add curl docker.io
RUN usermod -g docker jenkins
VOLUME /var/run/docker.sock
ENTRYPOINT groupmod -g $(stat -c “%g” /var/run/docker.sock) docker && usermod -u $(stat -c “%u” /var/jenkins_home) jenkins && gosu jenkins /bin/tini – /usr/local/bin/jenkins.sh
RUN pip install -r requirements.txt

# expose a port for the app
EXPOSE 5000

# run the app
CMD ["app", "run"]
