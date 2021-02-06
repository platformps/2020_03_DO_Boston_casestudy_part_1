# use base image
FROM python:3.7-alpine

# set app directory
WORKDIR /usr/src/app

# copy app files into container
COPY . .

# install requirements
RUN apk update && \
	apk upgrade && \
	apk add curl
RUN pip install -r requirements.txt

# expose a port for the app
EXPOSE 5000

# run the app
CMD ["app", "run"]
