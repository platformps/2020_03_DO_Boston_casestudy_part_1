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
RUN apk update && \
	apk upgrade && \
	apk add docker
RUN pip install -r requirements.txt

# expose a port for the app
EXPOSE 5000

# run the app
CMD ["app", "run"]
